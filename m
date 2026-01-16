Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8004BC982FE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 20:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD0D10E932;
	Fri, 16 Jan 2026 20:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQ275rEJ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33B010E932
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 20:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNZGATAuHf1VzAwHDXFHtToCXN+f5ZZlkKV5/xyqFH8+xTZr8i/RQ3SjeciWDzRqd99KLVtlyjzOPRFyZenKz2Gr+hh5cfzOLETYJdtZybRbJvOeD9108Z7joXj6vlbczH3Ks08bQfQZLJKGxLKVhgqNw+gdocCs2VE6si2QEciLbSIwKDkYtyCMyxx3cLfv/EZhvJbs3IxzDVk25w3ATE2edPPdXHrhTAP0kh5VLySSJm/qg6UtRsnzrmp3CGCwzah6nn+6+Vo+tpNOKVI4zpnt0wpaz7v3DYsWRNTk1u58dBYk5U54Tps0AzM3OiDxj7JOojA6/doIVpbqLbfvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x0ggp4LWxWP/jPDdoIAqge8jLt7ipqVZnkbo4KH+9Q=;
 b=QGWD5UPHfmSogpzGI2oLhUyHkFikJ5ZzjPX38yxSbgjleoXPrZFunlh3CaQ+k5mHHN5fGp6FIEv/1SnJO5w9qrhhfa2++litBweoJ6SaN6dZkQ16a49AQTCo7PhFMefmERIjGv8ObDjxcrO45bAp1aHsj7pQ8MVWCWzTcQT4TWgl0ROQmaIMzpUJCRYMibstY9kUMUp0lVm0dQtzdFa1lFtV/VBYTZ5BcpAYQLtVhyLIRt9534tKWdFI3VQceb6ePcYk30Vyyh/Q0PHhccVzx9EHHaFBbTIUVCEbWV2Jomkb5HPjjiJ3C5WrEXfoLAbm3dt3U2A+c08KPbg91Kqb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x0ggp4LWxWP/jPDdoIAqge8jLt7ipqVZnkbo4KH+9Q=;
 b=DQ275rEJHuGdxRYkFFf6UFSR+ISPJWVFnkPoAmslZFdECIQ9yWdxcS3uce+mGvDIXQK6DkVE83FBSYlfsbFbPq//ZnVqow3S7pckc8UmnnXh5x8AuDLdLYBNzfZB56FEAxpWViUSSpIsDYxx/H5CS3h811iT21vRuaYDtLYtILw=
Received: from BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 20:40:18 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::72) by BN9PR03CA0295.outlook.office365.com
 (2603:10b6:408:f5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 20:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 20:40:18 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 14:40:17 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Gang Ba <Gang.Ba@amd.com>, "Harish
 Kasiviswanathan" <Harish.Kasiviswanathan@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Vladimir Indic <vladimir.indic@amd.com>
Subject: [PATCH 3/5] drm/amdkfd: gfx12.1 cluster barrier context save
 workaround
Date: Fri, 16 Jan 2026 14:39:30 -0600
Message-ID: <20260116203932.988704-4-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116203932.988704-1-jay.cornwall@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 21de9e6b-94ba-4333-0ae2-08de553f761b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jZ6bDGq82NKEbywQUpnaboNck6qtIgi0HeRtltuM4uOKL7Z0Nv9AwsNJSn5V?=
 =?us-ascii?Q?5lvwsbSmB8IaoU/Z0MozpRXsglcq2UkY9suE94nrSav8Acb+spRmuwrZZqsx?=
 =?us-ascii?Q?XnBUs+dbrzmxSsln0cDfh1VLRp2GLtcPQyeHiaXcSdE/hztlcZf1xj2DXRDl?=
 =?us-ascii?Q?6dniNE/kvA+/BPsaynmGGxhU3hPlzfO155TKypC8cM1tYlTXrDHxIxM3udVp?=
 =?us-ascii?Q?f09hAP2fzT1YQkqjPE9FDUVGnjRZe1IwNn9Ue83IhMh3W3Eb3tURdOnjWXEj?=
 =?us-ascii?Q?C593r+jiwE7iT5MHizL08nJDG9DPb+nOwIVnHJgze5Fqh4AVOt7W+bqFsGpq?=
 =?us-ascii?Q?Xp4qmfPl3eSgQK9ShkG8DtyDYs5XXwVr1KcGCN5pGnE+Ei5bbhNFyjnti3e/?=
 =?us-ascii?Q?63qKlxTPrpmmJbuGsuv5e+J1VtOKh7QvtTfaYHWQBX8l2ZmzSnaMyf6YarRt?=
 =?us-ascii?Q?qzemrFfVmtLOd4L9ZHsWX7KqVS8YSUZy3Nq/dio9FLnnsNGXQ+KngyUrs5WR?=
 =?us-ascii?Q?TWmRG/dWGOey+lgmCPiDXezse+0RG5KcbwpdJzXIihG2Y9b6n1LuiT60kvYs?=
 =?us-ascii?Q?ScO1e0d4WdDVMo2qOcv35sLSZXvDHibxvbEppl7YY3inEIxkZjLtrblrgV6N?=
 =?us-ascii?Q?Uu4O4JqsLzR1rqMwTX9z6mWpD/dm2TjNuezrNywWJYccJaMvZYD9OQs5fb5S?=
 =?us-ascii?Q?xSZy8Mt8pAwfj3a9JTtAMDOtI0xsBRWuKYQKsnmk0V8oEEryE0eKJgIEwg2L?=
 =?us-ascii?Q?quwZ7KAgjfawh9T3+92j63vtu4ikkZsE5Co64ZPFEBTrz7dfgWV+tbDtLfFj?=
 =?us-ascii?Q?rDUgeWJs/iDyMxt19pu4jVZOYiA+1x4CfWe26rh+FNPB2eiGLsNqsOXqGGvK?=
 =?us-ascii?Q?JOzdAETzL5AzHGmvVHTRgHmffWe6bKmOaHH621cgE6g9UkuoWg1JBGSF1ZpQ?=
 =?us-ascii?Q?9FUhgsTXpoeh4B5cOLq9SD9n1NJr2Cao7EDDOciRNQMi7ygpnwrQ6M/mMwea?=
 =?us-ascii?Q?kFsu2GVwllqoxK5WhhGkBQI8Y+d4huORGTtARPM0XXRa9MoOvFuU06seHYD9?=
 =?us-ascii?Q?6mOz2hj/O+MmjAi9gXFwZRBeHwhG4TpuKgRtpcuXQkRpBbHFLYrAcczOlwrz?=
 =?us-ascii?Q?CLRcTPIvKNUas7vgQvqapwjGI/EvZwPWP8RFCoMPCOvpxE2PMfqITHK54Bpd?=
 =?us-ascii?Q?4AdgOHIoSb0XXU7a2iItgvYtiDWtJhkm+94Stw9rGOMjzNwTDUid68k0uw4h?=
 =?us-ascii?Q?NtKmOu/XSqiQeTEDZIv6lpFolpNQUiXkm2dIrLL2Xpb+EYaMNwbqu7mzMeLS?=
 =?us-ascii?Q?JgNaEujNDpZnH67PcqtQguoxq82zlqoFcUVFZNPUU92YIhVe8xinp3/eov/P?=
 =?us-ascii?Q?ln8viTt8NuoiWyCq7w+KmoPTuawYPhP5EjX9kRya/r3dA6aCoHiLR0srV0uK?=
 =?us-ascii?Q?RpmJp5BqC5eo3N8F/oV2PoP0XQLZYGH8RTNFf1lDvM1VPfWVxrHFmsUXKXV/?=
 =?us-ascii?Q?GUfImtbcPm7jYGCqyeyZL1hSHi3GcqZ45Wufh/r3J58uBPiR3/WHdtCNAH9C?=
 =?us-ascii?Q?MnbObek3BlDclQmYhmiL2BNPHD6jayA56gc1IHwxiQZkEQ68tVlZDZqfCd6t?=
 =?us-ascii?Q?l3ly1NUb+m+utpcFzUNQZ+Or6iT5x2RdiSpRjec3/4HpuUpOjAAYDZagiMRf?=
 =?us-ascii?Q?wUIXkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:40:18.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21de9e6b-94ba-4333-0ae2-08de553f761b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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

Trap cluster barrier may not serialize with user cluster barrier
under some circumstances. Add a check for pending user cluster
barrier complete.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Tested-by: Gang Ba <Gang.Ba@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 31 +++++++++-------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 36 +++++++++++++++----
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 453c08845d74..d86bccc49e3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3754,11 +3754,11 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x84708a70, 0x8070ff70,
 	0x00000200, 0x7e000280,
 	0x7e020280, 0x7e040280,
-	0xbefd0080, 0xbe804ec2,
-	0xbf94fffe, 0xb8faf804,
-	0x8b7a847a, 0x91788478,
-	0x8c787a78, 0xd7610002,
+	0xbefd0080, 0xd7610002,
 	0x0000fa71, 0x807d817d,
+	0xbe804ec2, 0xbf94fffe,
+	0xb8faf804, 0x8b7a847a,
+	0x91788478, 0x8c787a78,
 	0xd7610002, 0x0000fa6c,
 	0x807d817d, 0x917aff6d,
 	0x80000000, 0xd7610002,
@@ -4587,7 +4587,7 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
-	0xbfa00001, 0xbfa003aa,
+	0xbfa00001, 0xbfa003b4,
 	0xb0804009, 0xb8eef81a,
 	0xbf880000, 0xb980081a,
 	0x00000000, 0xb8f8f804,
@@ -4838,15 +4838,20 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x84708a70, 0x8070ff70,
 	0x00000200, 0x7e000280,
 	0x7e020280, 0x7e040280,
-	0xbefd0080, 0xb8faf802,
-	0xbf0c8b7a, 0xbfa20003,
-	0xbe804fc2, 0xbf94fffe,
-	0xbfa10001, 0xbe804ec4,
-	0xbf94fffc, 0xb8faf804,
-	0x8b7aff7a, 0x0001000c,
-	0x9178ff78, 0x0001000c,
-	0x8c787a78, 0xd7610002,
+	0xbefd0080, 0xd7610002,
 	0x0000fa71, 0x807d817d,
+	0xb8faf802, 0xbf0c8b7a,
+	0xbfa20003, 0xbe804fc2,
+	0xbf94fffe, 0xbfa10001,
+	0xbe804ec4, 0xbf94fffc,
+	0xbefa4c88, 0xbfc70000,
+	0xbf0c807a, 0xbfa20006,
+	0x9371ff7a, 0x00070004,
+	0x937aff7a, 0x00070010,
+	0xbf06717a, 0xbfa2fff6,
+	0xb8faf804, 0x8b7aff7a,
+	0x0001000c, 0x9178ff78,
+	0x0001000c, 0x8c787a78,
 	0xd7610002, 0x0000fa6c,
 	0x807d817d, 0x917aff6d,
 	0x80000000, 0xd7610002,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 7ed4b502eb22..ace2a9f2ac73 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -35,6 +35,7 @@
 #define HAVE_BANKED_VGPRS (ASIC_FAMILY == CHIP_GC_12_0_3)
 #define NUM_NAMED_BARRIERS (ASIC_FAMILY == CHIP_GC_12_0_3 ? 0x10 : 0)
 #define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
@@ -104,6 +105,7 @@ var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
 var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
 
 var BARRIER_STATE_SIGNAL_OFFSET			= 16
+var BARRIER_STATE_SIGNAL_SIZE			= 7
 var BARRIER_STATE_MEMBER_OFFSET			= 4
 var BARRIER_STATE_MEMBER_SIZE			= 7
 var BARRIER_STATE_VALID_OFFSET			= 0
@@ -520,9 +522,11 @@ L_SAVE_HWREG:
 	v_mov_b32	v2, 0x0							//Set of SGPRs for TCP store
 	s_mov_b32	m0, 0x0							//Next lane of v2 to write to
 
+	write_hwreg_to_v2(s_save_m0)
+
 	// Ensure no further changes to barrier or LDS state.
 	// STATE_PRIV.*BARRIER_COMPLETE may change up to this point.
-	wait_trap_barriers(s_save_tmp)
+	wait_trap_barriers(s_save_tmp, s_save_m0, 1)
 
 	// Re-read final state of *BARRIER_COMPLETE fields for save.
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATE_PRIV)
@@ -530,7 +534,6 @@ L_SAVE_HWREG:
 	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
 	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
 
-	write_hwreg_to_v2(s_save_m0)
 	write_hwreg_to_v2(s_save_pc_lo)
 	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
 	write_hwreg_to_v2(s_save_tmp)
@@ -1198,7 +1201,7 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
 
 	// Make barrier and LDS state visible to all waves in the group/cluster.
 	// STATE_PRIV.*BARRIER_COMPLETE may change after this point.
-	wait_trap_barriers(s_restore_tmp)
+	wait_trap_barriers(s_restore_tmp, 0, 0)
 
 #if HAVE_CLUSTER_BARRIER
 	// SCC is changed by wait_trap_barriers, restore it separately.
@@ -1211,7 +1214,7 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
 L_END_PGM:
 	// Make sure that no wave of the group/cluster can exit the trap handler
 	// before the group/cluster barrier state is saved.
-	wait_trap_barriers(s_restore_tmp)
+	wait_trap_barriers(s_restore_tmp, 0, 0)
 
 	s_endpgm_saved
 end
@@ -1301,11 +1304,11 @@ function restore_xnack_state_priv(s_tmp)
 end
 #endif
 
-function wait_trap_barriers(s_tmp)
+function wait_trap_barriers(s_tmp1, s_tmp2, serialize_wa)
 #if HAVE_CLUSTER_BARRIER
 	// If not in a WG then wave cannot use s_barrier_signal_isfirst.
-	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_STATUS)
-	s_bitcmp0_b32	s_tmp, SQ_WAVE_STATUS_IN_WG_SHIFT
+	s_getreg_b32	s_tmp1, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp0_b32	s_tmp1, SQ_WAVE_STATUS_IN_WG_SHIFT
 	s_cbranch_scc1	L_TRAP_CLUSTER_BARRIER_SIGNAL
 
 	s_barrier_signal_isfirst	-2
@@ -1319,6 +1322,25 @@ L_TRAP_CLUSTER_BARRIER_SIGNAL:
 
 L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
 	s_barrier_wait	-4
+
+#if CLUSTER_BARRIER_SERIALIZE_WORKAROUND
+if serialize_wa
+	// Trap cluster barrier may complete with a user cluster barrier in-flight.
+	// This is indicated if user cluster member count and signal count are equal.
+L_WAIT_USER_CLUSTER_BARRIER_COMPLETE:
+	s_sendmsg_rtn_b32	s_tmp1, sendmsg(MSG_RTN_GET_CLUSTER_BARRIER_STATE)
+	s_wait_kmcnt	0
+	s_bitcmp0_b32	s_tmp1, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc1	L_NOT_IN_CLUSTER
+
+	s_bfe_u32	s_tmp2, s_tmp1, (BARRIER_STATE_MEMBER_OFFSET | (BARRIER_STATE_MEMBER_SIZE << 0x10))
+	s_bfe_u32	s_tmp1, s_tmp1, (BARRIER_STATE_SIGNAL_OFFSET | (BARRIER_STATE_SIGNAL_SIZE << 0x10))
+	s_cmp_eq_u32	s_tmp1, s_tmp2
+	s_cbranch_scc1	L_WAIT_USER_CLUSTER_BARRIER_COMPLETE
+end
+L_NOT_IN_CLUSTER:
+#endif
+
 #else
 	s_barrier_signal	-2
 	s_barrier_wait	-2
-- 
2.34.1

