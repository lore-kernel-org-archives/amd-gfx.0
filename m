Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2754FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 11:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0CD10EA11;
	Mon, 29 Apr 2024 11:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NOUGwvSG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A078310EA11
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 11:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2/YsfnysUs7HH/SKcymSatBopHTi2cQKtSqhcAoQUuQDFEc5XQapfuCxtplPw03NnJaw1ouSsvTA5wk6QWxUB+s5i8cKMH1B2cqHTloopYgJA8Z0BycYn3xX5VRzB7CKJBk6VajIlafbtctvYz7VjI6YLsypzRutHyoFSCSZ5o97ydu6t0L8yJtLe055pvLoWr5pAk05gP6TgZ542GPI4ZY7G3CuYPDFAW5gBbz9afJsS6YJPncJj/jDD2RvYxEtreLU+ogLpyiy+Dqgm5RkApPQbV8hXxtSTf9IsG3b2ED/v5EZWJYT/a1R8OHAoUUDACvl9xNcIhd8ymrpaE0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnJ++A6Pu2pUuQg8jIoRhHgy+grikiQso0oARR1vusY=;
 b=NgqVA2SzVBn5/ffsB8wDNe4snvg9Vr9gNRoTEUi2+N8LGczsnQEWMoj5ZiP4FoMSd+ISbPuUXvWS6DIBIE4i454hwPFhkoWL0Mg59lgfYTowWk1wGwidX2JvIp19M1/NKZU9mruyLfZz4NIJYQNMprx+XbbP2paZOFj3FWjUtMLg8AFdr9RlfM3FsQ9iKxsGsbIqD1s7GUG4HWduKc6rO33cirgSyHePNCsPfHu7Gc0aH5GCwScFLtFSIZGcdZx9HQsSi3+rXwNMS4uF/45x3pFv+TthPJKDPlAwEv5tD3P3FyXq+cMnVwJ8jIBu0V99XP1fgp6H3pmuk9WSRFfMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnJ++A6Pu2pUuQg8jIoRhHgy+grikiQso0oARR1vusY=;
 b=NOUGwvSGQimv3r03BIt0YnatX8nDDECFqxjFQ/cb+qGRH1VADLUPTPfWWTw0tRlfuA3tLqzVwApo0yiyUDZLCydkfOq23aztWlr6Vl9c29E5VTulNZ1efHRdX3Nh/ISng15J3vrg5ZzgdOA7AbnVW486zjyjgY/LzCICd/LYsnk=
Received: from SA9PR03CA0018.namprd03.prod.outlook.com (2603:10b6:806:20::23)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 11:07:24 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::6a) by SA9PR03CA0018.outlook.office365.com
 (2603:10b6:806:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 11:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 11:07:23 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 06:07:22 -0500
From: Lancelot SIX <lancelot.six@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, Lancelot SIX <lancelot.six@amd.com>
Subject: [PATCH] drm/amdkfd: update buffer_{store, load}_* modifiers for gfx940
Date: Mon, 29 Apr 2024 12:06:28 +0100
Message-ID: <20240429110628.149277-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 100ce905-1425-4001-08b9-08dc683c8c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WLV6WBKm1tcDygHOq8EGuDlWW3uJHTFTgGfasqMq2980jbfQCxIAkBgEXatd?=
 =?us-ascii?Q?oy+ID3Pi3qWyNcw+QoBGSG2jCYRTfFN37HWCxGH8tSaX8KnuFc+1L57tbOw6?=
 =?us-ascii?Q?9Q2F3NS67QwX+w5I6aJ9iHAkXhTkPwzSUImq8xzU80jbAHczQw13Cr0gkg3i?=
 =?us-ascii?Q?CJOuB/cSiNKNGgjKOnqAFv0JMo6/gbb5vAlBrMQLAd1x5Wx1lp9DJx9Q/aQV?=
 =?us-ascii?Q?Y4JOVHkvpotYi0Ebh+Z/oJn2zb69MFkWFTbFRXNsJT/0LO8mXwPbvkfYc1X3?=
 =?us-ascii?Q?EXsrjvIZE+8QpYAG0iqbwObAWZzSXtNG1awxWXI/LX2jsh2wY1ezWxLUiwDj?=
 =?us-ascii?Q?8/XmrzGjRz+seFS6oO5G2W3oZDKmp6RkRAztzYa77dRnuhRTk4GjOrqywjPy?=
 =?us-ascii?Q?NqvNcoL+4y+lWEjduFl/eMnTBvKuyHov4r5946vb7bcSVh6x4D+k5HZWH98d?=
 =?us-ascii?Q?HvC2Mj3lKXnwzJhkhdi5lr3Jna2zg6OR4fiXaW2eJOG6Bv/GYPkG2N0XpjuO?=
 =?us-ascii?Q?OOnU8cFGkX2QeadYhCRQ6WtXs9eMY48jUZppY3FKS9gBYG7fSn/BYlLVeYLV?=
 =?us-ascii?Q?+zaTuCwmHLAkyqhxrHftUYTUIi8zh2qrdJql1S4mcXYv5itsppGrqRhg4E24?=
 =?us-ascii?Q?mgBTzSWjL0qaay2tcvU4uuGE+WtGXRq0vVkg8SU+HR1fp8Lf4oyLh5WpGRtB?=
 =?us-ascii?Q?9GJn+oQdTWOVSrEfUBaGTyREBaKeWtyCcQdNlEDFt8ZWVwKCy16afACAo/sJ?=
 =?us-ascii?Q?DJhc7yKwg3wQciImCxfeXoQwNNBD0sLQcvEZne/fc4qgHbOzaMgXH9/sQrSC?=
 =?us-ascii?Q?CnoRapVYpSxU4OdfA0EPMlNeA2s/rGnQJ9Ap6LMwRCRDPArNazpZezlvpv/9?=
 =?us-ascii?Q?9RZsIKE9SnXaE74O2lDcnWY5WARubd4dCV4bh/F+F7aQgYrXMZC+8/rlYuHm?=
 =?us-ascii?Q?BR5EPVhizX6g5+stGFEYoK9gqkAnOAEzz55UBtHUxvS+FbZxA28uwlZ2IeqR?=
 =?us-ascii?Q?kXkkDQnFpYVCnfPNuUVo59cvnx5Y/zt8965gbdubLvOAhAIqJ4b0Wff5FgWy?=
 =?us-ascii?Q?7dvr9CtSwVcHVlT4QEwEefYKvBzCTrc5LLWxmr23a8GsBEjmOadHDQf+PtoS?=
 =?us-ascii?Q?1H6osDadf68GTh64Yw3oDsScDcW1+e50cQSgmZVtZAWNnWn4kxos/BBOmpf9?=
 =?us-ascii?Q?IbKJUTp7gpTJeQdwNloQOHh0YGJNS+5ewDNruB+i9dR2mohxgwgeIkbkqdPm?=
 =?us-ascii?Q?P982nFVzFJb7/KBF96db2n/kj1JClW2V7eQ6ccaBj5kcvnuk9Q0BNdJX+8TC?=
 =?us-ascii?Q?9tOigzjqSARrHcGSvTTaWDtXh2K6JCWG6MVYoy5llRBJHBOLihL8K36J1Xi/?=
 =?us-ascii?Q?xlk0y6k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:07:23.9148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100ce905-1425-4001-08b9-08dc683c8c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instruction modifiers of the untyped vector memory buffer instructions
(MUBUF encoded) changed in gfx940.  The slc, scc and glc modifiers have
been replaced with sc0, sc1 and nt.

The current CWSR trap handler is written using pre-gfx940 modifier
names, making the source incompatible with a strict gfx940 assembler.

This patch updates the cwsr_trap_handler_gfx9.s source file to be
compatible with all gfx9 variants of the ISA.  The binary assembled code
is unchanged (so the behaviour is unchanged as well), only the source
representation is updated.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index bb26338204f4..a2d597d7fb57 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -48,6 +48,12 @@ var ACK_SQC_STORE		    =	1		    //workaround for suspected SQC store bug causing
 var SAVE_AFTER_XNACK_ERROR	    =	1		    //workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
 var SINGLE_STEP_MISSED_WORKAROUND   =	(ASIC_FAMILY <= CHIP_ALDEBARAN)	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
+#if ASIC_FAMILY < CHIP_GC_9_4_3
+#define VMEM_MODIFIERS slc:1 glc:1
+#else
+#define VMEM_MODIFIERS sc0:1 nt:1
+#endif
+
 /**************************************************************************/
 /*			variables					  */
 /**************************************************************************/
@@ -581,7 +587,7 @@ end
 L_SAVE_LDS_LOOP_VECTOR:
       ds_read_b64 v[0:1], v2	//x =LDS[a], byte address
       s_waitcnt lgkmcnt(0)
-      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, s_save_mem_offset offen:1  glc:1  slc:1
+      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, s_save_mem_offset VMEM_MODIFIERS offen:1
 //	s_waitcnt vmcnt(0)
 //	v_add_u32 v2, vcc[0:1], v2, v3
       v_add_u32 v2, v2, v3
@@ -979,17 +985,17 @@ L_TCP_STORE_CHECK_DONE:
 end
 
 function write_4vgprs_to_mem(s_rsrc, s_mem_offset)
-	buffer_store_dword v0, v0, s_rsrc, s_mem_offset slc:1 glc:1
-	buffer_store_dword v1, v0, s_rsrc, s_mem_offset slc:1 glc:1  offset:256
-	buffer_store_dword v2, v0, s_rsrc, s_mem_offset slc:1 glc:1  offset:256*2
-	buffer_store_dword v3, v0, s_rsrc, s_mem_offset slc:1 glc:1  offset:256*3
+	buffer_store_dword v0, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS
+	buffer_store_dword v1, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256
+	buffer_store_dword v2, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*2
+	buffer_store_dword v3, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*3
 end
 
 function read_4vgprs_from_mem(s_rsrc, s_mem_offset)
-	buffer_load_dword v0, v0, s_rsrc, s_mem_offset slc:1 glc:1
-	buffer_load_dword v1, v0, s_rsrc, s_mem_offset slc:1 glc:1 offset:256
-	buffer_load_dword v2, v0, s_rsrc, s_mem_offset slc:1 glc:1 offset:256*2
-	buffer_load_dword v3, v0, s_rsrc, s_mem_offset slc:1 glc:1 offset:256*3
+	buffer_load_dword v0, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS
+	buffer_load_dword v1, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256
+	buffer_load_dword v2, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*2
+	buffer_load_dword v3, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*3
 	s_waitcnt vmcnt(0)
 end
 

base-commit: cf743996352e327f483dc7d66606c90276f57380
-- 
2.34.1

