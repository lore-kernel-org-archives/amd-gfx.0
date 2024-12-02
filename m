Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9480E69E9A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FD910E877;
	Mon,  2 Dec 2024 21:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+WXWDsb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2624710E195
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS16g74mQdPUcl9iFnthjAmXeIArAhAqlflBudPNvmtEr+5FHce4tKCdc6erd4JrDKvbUtN64aL3fye10AifInVcS25v+kn5LJoheRKBMNehU4I+fqdKAH6aIi//474l6w0/CJxA3Whw0WZGRxnC0pMVpLoK/excyuo7zFAcoiAz61/c7jae3oN5ZEeD1hHm8o6Nqzmv+BxhDAGoCF2qXQxRU02fZZ/RWxiwIlFk/BgmY93Tw/Tz0eYGneitiDg6jAeasdj69zJctgEsjJ5jyjvVt0VTxys7L4IKAoYYivv6imgDZvgqtqy8ii8llvPByUuYhi51uBBuJyClX6MhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn5qmmAG/XzdKNjVSq/sA/PVJqdTO9ijzuOIkdeVh8M=;
 b=gEKFoghf1m1tmuqTUso2XQS8dm248E5NhgB3RIGoJb4efbnuZtyTxkrEhPR8y33ObekNegfJY3W15cXxqgTBEJ3FLNkNJ787m/Gx/31WIKx8zDVWBTO/HkjZ4SSY/XPI69fNKQ7FKx3jD0QRj6hPktncJVNF8wPHl5Hy9AuN77W0w8GE267DJhhuPTjtUmSg8k8ACBckJz0GHOaMJCvwkG7cvi3pm6vaOv8hIidigAFUE+Y4ZJVV2/JHF9EBGCiwyfSAkPsJVEsdfaWsBHFMcrYEbUibOe7fEQYZ4/OIBijwSyI8IUDcRBehZuX8+RbGB3aI1J/XFk4PNMQijKmOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn5qmmAG/XzdKNjVSq/sA/PVJqdTO9ijzuOIkdeVh8M=;
 b=S+WXWDsbVS3TrxiVdeFTgYEgtwZ/U5eAbvW6mzyj1mtjpdKJBCA1fWK6buPI/XBzmHfQ8ev+0cgo2Wgcs+L0uy8YT0L3cgokwLMEK2w1rkXRiAwaUnoGI79OK/5mWNvupruNWX70SwwPLoWZUDu7U+V6mWm2AU7yBgoRFvLdP/g=
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:50:21 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::49) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Jay Cornwall <jay.cornwall@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdkfd: update buffer_{store,
 load}_* modifiers for gfx940
Date: Mon, 2 Dec 2024 16:49:49 -0500
Message-ID: <20241202214952.1125211-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 95687883-449b-4d6a-17c4-08dd131b51a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a6wz2lATX4oygHPRrtIqT5v+cVePsEguMJgXrMxB70RzlD3IlIATOVKbTX6I?=
 =?us-ascii?Q?oG828BFi+aBokU5K4PS9Hu0uKYyfBBPTCSK/vcGMe7nvvB26f/kDfpp+Yjsl?=
 =?us-ascii?Q?S9vXAgu0mO6skC+Cu7Rd8cAD+TDeAUQ6b4gOofn7dlnGFBwQEugoy5BtVsN3?=
 =?us-ascii?Q?bCCabElQGvzflK+rF9VQOtBfjlzzbiiEK6GDp8wnxZnGueHi4c+gbPrLvvyz?=
 =?us-ascii?Q?aHBcxlR+BgrrcTTMgmSQUdELIyadwjfX+LwgCHXwhdlr5nAQKQVuSlWnGdlB?=
 =?us-ascii?Q?u/iCKKuLxofHVKWPp1DYTIjFFr1z2wUtHFFKrFrCc6Mvc4b2SF4apGlHk5ex?=
 =?us-ascii?Q?bmrepsJI5c/Z7Byj4qrgi92FmNqV/RKSv438X6TS+p89c5Pnqf1kAhrrcu8k?=
 =?us-ascii?Q?d0Mq4KqSrcH+oMEUEDiAWMame2DtMfW04cwE/n55nNxXn8rNynXHL+tV0eya?=
 =?us-ascii?Q?mta9QL1/MwcnUsNY9X6uSZoQaHX2uvVmzKOVyuyq7EFjnptlHCj19RpW6xIX?=
 =?us-ascii?Q?lRowkih5rC07Z1JNX24G1eTBZK4L/V8mMhFfZMt9KeAq4DSKNAkaiPw4/1Lv?=
 =?us-ascii?Q?Z6/nNzahOxQf1eeZJWjqmh5+57oNxvcdUOzZZ97L948c8iRLVdkVLVNw07Cp?=
 =?us-ascii?Q?U3ybvZiq56Or+fi1hPqrU48234tJCFxt1Syn9o0N6SaBhk3S60aEMB7/zQ95?=
 =?us-ascii?Q?5nGcRnNGprHLvZhrhKNyqqRWuK2cLvMYbg9WV8YDwV1tk24M1X8mSATK80rt?=
 =?us-ascii?Q?uwnUiojOkDnKepd92+Dn4OWJNcL5us8EGdHZ1fPXtm9+Rw3sEFoWt6fP+ziQ?=
 =?us-ascii?Q?E6RuhJ3MiLiCU8MbaQ141JW8HlSAWcj1q2lsaD1TNqY67lX06PZBQhRDLaDy?=
 =?us-ascii?Q?hnhZiG9fR2IYLHIk0YnKKrZvIEV8FUZbsmRMfQs8b9RkpOgvzeV4xkEg5V1E?=
 =?us-ascii?Q?maodz45EzNbWn9iRaeXA9jzxH3oYZzE8bdd7UFSEra/qDT3Unv0n4k4OzEcz?=
 =?us-ascii?Q?CgXmTGgJVhLyOhXgsTwoWmnTIuY7LEnRj15Y6e1IvSo4JVNsabIyrVgEdJ2a?=
 =?us-ascii?Q?LnwypbaOdWEu5yG4Ct3xzF7e3Gu2n7D5WN4n35tj4O42F3w/MDhQPNa+VBX5?=
 =?us-ascii?Q?hUDDMTTFGLPVwW05f2bN/clcKw3VmBhDps/zRFkTKWpc8ZFAEGI1IYDgNmfh?=
 =?us-ascii?Q?KQ7KPvur6IsAhclehIj/dw73Yp82iTLxZlc0av0TZJecYqoToVHoDJGlk4Oz?=
 =?us-ascii?Q?PJMll4lr+1LymjqjeyD5kq72UDfhllaTBh9uJIqPtfFcmVGNFzdcSGEKLBib?=
 =?us-ascii?Q?FRIL7lfZ4N8z7FJpDHP4QNkARZa5Cp1hMLyc3odYqgRN0XMEZytTstUWYBwX?=
 =?us-ascii?Q?edenYpIFls+tJUO9x9aNhM/Ze/7NTX5q+TaWtk89IPjEX3RW2KPh+XgySrLB?=
 =?us-ascii?Q?JlN1J0X3z5vTimIuN0TavBIoRZG74j9o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:21.0605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95687883-449b-4d6a-17c4-08dd131b51a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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

From: Lancelot SIX <lancelot.six@amd.com>

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
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index bb26338204f4b..a2d597d7fb574 100644
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
 
-- 
2.47.0

