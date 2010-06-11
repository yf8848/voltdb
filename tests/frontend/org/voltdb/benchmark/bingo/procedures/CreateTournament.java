/* This file is part of VoltDB.
 * Copyright (C) 2008-2010 VoltDB L.L.C.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

package org.voltdb.benchmark.bingo.procedures;

import org.voltdb.*;

@ProcInfo(
    partitionInfo = "T.T_ID: 0",
    singlePartition = true
)
public class CreateTournament extends VoltProcedure {

    public final SQLStmt insertT =
            new SQLStmt("INSERT INTO T VALUES (?, ?)");

    public final SQLStmt insertB =
            new SQLStmt("INSERT INTO B VALUES (?, ?, ?)");

    private final java.util.Random r = new java.util.Random();
    /* Create a new T entry and create b_per_t board entries in B */
    public VoltTable[] run(int t_id, int b_per_t) throws VoltAbortException {
        StringBuilder sb = new StringBuilder(300);
        for (int ii = 0; ii < 300; ii++) {
            sb.append(r.nextInt(9));
        }

        voltQueueSQL(insertT, t_id, sb.toString());

        for (int i=0; i < b_per_t; i++) {
            voltQueueSQL(insertB, t_id, i, "INITIAL VALUE");
        }
        return voltExecuteSQL();
    }
}
