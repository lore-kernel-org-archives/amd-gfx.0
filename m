Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0195FC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 23:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFB910E0FF;
	Wed,  5 Jun 2024 23:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I5jhljwn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E28A10E0FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 23:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTorWnrHvNkIpHIn49OhTj5oq4nf8Jzy98Xk8w3Hp57FjxaE2OEZ6apxbpGO19piD1xFPNUir7ogx8vlJX/Y9zxVapht1x1QJAzbxu1BhFOaiNH47Oy48ihiyvYuhZf9LlEOS08vozjS6Tw/UiB5kNrDqANSyjHX93W17X5ouIXVi5oqaUw4hoalxT9avGkWOEjClBipW6622HRMjJSv0Lo3tmPUo3MT1bCliUugj01Cl8W/V+ho1Vp9gwz7zpf47GeLjvzqxSbjpwHg2FO7dw39clRSzk3iBEF4yYJR53rqEGi24o/4R6wiPkviVhYCtlpQowHScu14WYAXaUrTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWGD0bmUMSBr+iZHDvo0Fz2Z3CoaDpJWAIJ/m+c4EmA=;
 b=CscFM9h5HKze/qPGsgQG7JatpIOe1x/tOgjjYC2qbT1qiAcUkQrKFqAtAeEjJuRUhTj8Ppibf72VlwTNsMmIZIXeh4zDOWrBurhS0Nl5xXxsC+zxBWAV9JthhXPZe0xyncjAN006ucuAr9TpJ2sVocrs66fcdRIpTejmctF+NtLmYBHatL2MQSgXqIGXxiR8+KJ+lSB3jTioFIBXFo0dsIeDYUQhKvHDSs/GWM9SYORqDC5gzkHOFWKikoD7jLEzCkGGWCKbrMR87UtMX+c01145cNswdCcS2PyCCd5K/4ZJlUzaY7oQp4EdXUcM6FeGDT3aeWlL/xUg3XjdNeYdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWGD0bmUMSBr+iZHDvo0Fz2Z3CoaDpJWAIJ/m+c4EmA=;
 b=I5jhljwnjZPCq5SMjo2naFolaYKiO/XI2hOEZWGqdOcCYqDDvr/Iv/zs1uKw8KrqbQc8lnNoFRFHO8hqpBSKQRpRjhBW+Egs4kYS41SiMr4FLhCIrDh8b7SqDUqm+TxG8IG6OdsO9yuJVRShi38LX37gOtY6pIRGdHE49kFzdF0=
Received: from BN0PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:143::21)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 23:17:05 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::85) by BN0PR10CA0026.outlook.office365.com
 (2603:10b6:408:143::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 23:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 23:17:05 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 18:17:04 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>
Subject: [PATCH] drm/amdkfd: Extend gfx12 trap handler fix to gfx10/11
Date: Wed, 5 Jun 2024 18:16:54 -0500
Message-ID: <20240605231654.6374-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e9ddf5-35ec-4e12-d636-08dc85b59d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FKa0wxnukXFdz0COyTTVUpGHdUvoHZBZ7ORH+TxoeAgUZ9kmb3JPqDNWHko/?=
 =?us-ascii?Q?7wytAZ+gD6iBhrc84dskBid4l3UfsPaF8Za2LljhFD3MirptDcs7ePitNmC9?=
 =?us-ascii?Q?yNAc5Ters7U3Q3j3D7YlyIpgwKW0aQNdOMn3mqv1b/hL5Wxu62gKuB6MS2F/?=
 =?us-ascii?Q?487P0YbvTrrGRPqPjyLPEZ0GbfMWo/kSRb2Gr8JYXUjjbHkMs1Cy6wval7xT?=
 =?us-ascii?Q?Reu9sjLFgkzujDz2zl5ltvyekXQpk+FNibT2E3QoUph5vaOhhU33TCbZxFoC?=
 =?us-ascii?Q?msktqJuHKkLTuIpI0JzLSMSpElqPE0JcZR9Xdwreimu15nPX0Mencqav+eyb?=
 =?us-ascii?Q?Rt3rfcsLZyBPmr+Ubh1QwIIGbzkgiIlccyKEpgy1cT3T9IIcQ89HzqKXzAdN?=
 =?us-ascii?Q?hrNWNyidOebMuagevBJKqAVVVAeBdGvvG7WWE4mw1ufRXTPb/CAbjl+G5egs?=
 =?us-ascii?Q?6Qr2cPtJ8rZsIzGDBRDHq4vKt5APvzIohc75UBkkj9hSE/Iz9hFRT8b+xPzX?=
 =?us-ascii?Q?BWG+PR1PbnfzFRq3YKgBBWJT6MxfFYh0gwu50TcRh7ximGreuy5Z66alzDRA?=
 =?us-ascii?Q?0tLgHI0jz2btU+gm/Dd51NJWWGmwGAe/sbs8+sQm5KQC13vVCpd4pkfMdoOA?=
 =?us-ascii?Q?gpJDD45+obQf/Yh8MIpsr3fX/iEyITa94RkbT/ALMQckPkIw+YbGWXShfskc?=
 =?us-ascii?Q?xSJ1nwVpHZGBSzhmlL4L/SwWsnC24IOQ8Y7P0bhk/Y7+9075DRTqq6c51+KF?=
 =?us-ascii?Q?nIQnkFup2O4pqbCVx+eq1MPHUwMIGrHlDRxrpUdowlNfXNR4iJ0SkkGE2SGL?=
 =?us-ascii?Q?0889S1CUceXfDuUCaWRWzZSOqiBYZi/H2PsjgFdwIw/JZ+AdXSfD7fUnTKYB?=
 =?us-ascii?Q?8PHPgam4UUzCBio8m+3Cm/N6X/2Ry3S6PJvS08yz3t9+NLvO3plpc0yMTf9r?=
 =?us-ascii?Q?eRKvhjr6GktSvqmr9XrB4QRpoXwjdngnCoBZhCdQ80q/dnyUAnIjP1XwxGPu?=
 =?us-ascii?Q?OYF8jCNasYPg1bz2ZKJfF67aGhLcLgi1UOfCKI2m7J435dN+JFIyjWj/ZfoU?=
 =?us-ascii?Q?6zVrI2uUZwXXFSvTwbelUbVARxT4Nmlk9pZulvs1gSzQM2xhiT1ER90jQ3ez?=
 =?us-ascii?Q?fQ7qWr4D179AsBn+s0jtEAQVgb28LaeQA5Iw2Xq8mBtdzH53+ma/4vHWbzF6?=
 =?us-ascii?Q?WuOUDAQnfeY1bVs6DLDbEd/cxSD5QZ6DO4qQbAFMbfmuE8PWatDLkAyhXAes?=
 =?us-ascii?Q?Ujg0huaUZ7Mn2lF5pF9aYtXoaIBrKVgtfnOuGK7oHrXnURg5fJskpxX7ms3v?=
 =?us-ascii?Q?36nSyvJ1ubBmYqE8AX0eGuUPNJV11i60LltIbPTTJEs6uCBqpAwdb0HJdIYf?=
 =?us-ascii?Q?SmHgtqqTpJztNVS4rMN4zs/8TwXqvMMMidARGTLv+nN7NoRduQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 23:17:05.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e9ddf5-35ec-4e12-d636-08dc85b59d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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

In commit 6d1878882d2d
("drm/amdkfd: gfx12 context save/restore trap handler fixes") the
following fix was introduced but incorrectly restricted to gfx12.
The same issue and a corresponding fix apply to gfx10 and gfx11.

Do not overwrite TRAPSTS.{SAVECTX,HOST_TRAP} when restoring this
register. Both of these fields can assert while the wavefront is
running the trap handler.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 16 +++++---
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    | 38 ++++++++++++++-----
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 665122d1bbbd..02f7ba8c93cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -1136,7 +1136,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x705d0000, 0x807c817c,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7c, 0xbf85fff8,
-	0xbf82013d, 0xbef4037e,
+	0xbf82013f, 0xbef4037e,
 	0x8775ff7f, 0x0000ffff,
 	0x8875ff75, 0x00040000,
 	0xbef60380, 0xbef703ff,
@@ -1275,7 +1275,8 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x80788478, 0xbf8c0000,
 	0xb9eef815, 0xbefc036f,
 	0xbefe0370, 0xbeff0371,
-	0xb9f9f816, 0xb9fbf803,
+	0xb9f9f816, 0xb9fb4803,
+	0x907b8b7b, 0xb9fba2c3,
 	0xb9f3f801, 0xb96e3a05,
 	0x806e816e, 0xbf0d9972,
 	0xbf850002, 0x8f6e896e,
@@ -2544,7 +2545,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xe0704000, 0x705d0000,
 	0x807c817c, 0x8070ff70,
 	0x00000080, 0xbf0a7b7c,
-	0xbf85fff8, 0xbf820134,
+	0xbf85fff8, 0xbf820136,
 	0xbef4037e, 0x8775ff7f,
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
@@ -2683,7 +2684,8 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xf0000000, 0x80788478,
 	0xbf8c0000, 0xb9eef815,
 	0xbefc036f, 0xbefe0370,
-	0xbeff0371, 0xb9fbf803,
+	0xbeff0371, 0xb9fb4803,
+	0x907b8b7b, 0xb9fba2c3,
 	0xb9f3f801, 0xb96e3a05,
 	0x806e816e, 0xbf0d9972,
 	0xbf850002, 0x8f6e896e,
@@ -2981,7 +2983,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0x701d0000, 0x807d817d,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7d, 0xbfa2fff8,
-	0xbfa0013f, 0xbef4007e,
+	0xbfa00143, 0xbef4007e,
 	0x8b75ff7f, 0x0000ffff,
 	0x8c75ff75, 0x00040000,
 	0xbef60080, 0xbef700ff,
@@ -3123,7 +3125,9 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0x80788478, 0xbf890000,
 	0xb96ef815, 0xbefd006f,
 	0xbefe0070, 0xbeff0071,
-	0xb97bf803, 0xb973f801,
+	0xb97b4803, 0x857b8b7b,
+	0xb97b22c3, 0x857b867b,
+	0xb97b7443, 0xb973f801,
 	0xb8ee3b05, 0x806e816e,
 	0xbf0d9972, 0xbfa20002,
 	0x846e896e, 0xbfa00001,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index ac3702b8e3c4..44772eec9ef4 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -119,9 +119,12 @@ var SQ_WAVE_TRAPSTS_ADDR_WATCH_SHIFT		= 7
 var SQ_WAVE_TRAPSTS_MEM_VIOL_MASK		= 0x100
 var SQ_WAVE_TRAPSTS_MEM_VIOL_SHIFT		= 8
 var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK		= 0x800
+var SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT		= 11
 var SQ_WAVE_TRAPSTS_EXCP_HI_MASK		= 0x7000
 #if ASIC_FAMILY >= CHIP_PLUM_BONITO
+var SQ_WAVE_TRAPSTS_HOST_TRAP_SHIFT		= 16
 var SQ_WAVE_TRAPSTS_WAVE_START_MASK		= 0x20000
+var SQ_WAVE_TRAPSTS_WAVE_START_SHIFT		= 17
 var SQ_WAVE_TRAPSTS_WAVE_END_MASK		= 0x40000
 var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK	= 0x100000
 #endif
@@ -137,14 +140,23 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x003F8000
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK			= 0x800
 
+var S_TRAPSTS_RESTORE_PART_1_SIZE		= SQ_WAVE_TRAPSTS_SAVECTX_SHIFT
+var S_TRAPSTS_RESTORE_PART_2_SHIFT		= SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT
+
 #if ASIC_FAMILY < CHIP_PLUM_BONITO
 var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+var S_TRAPSTS_RESTORE_PART_2_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_2_SHIFT
+var S_TRAPSTS_RESTORE_PART_3_SHIFT		= 0
+var S_TRAPSTS_RESTORE_PART_3_SIZE		= 0
 #else
 var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK		|\
 						  SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK	|\
 						  SQ_WAVE_TRAPSTS_WAVE_START_MASK	|\
 						  SQ_WAVE_TRAPSTS_WAVE_END_MASK		|\
 						  SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK
+var S_TRAPSTS_RESTORE_PART_2_SIZE		= SQ_WAVE_TRAPSTS_HOST_TRAP_SHIFT - SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT
+var S_TRAPSTS_RESTORE_PART_3_SHIFT		= SQ_WAVE_TRAPSTS_WAVE_START_SHIFT
+var S_TRAPSTS_RESTORE_PART_3_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
 #endif
 var S_TRAPSTS_HWREG				= HW_REG_TRAPSTS
 var S_TRAPSTS_SAVE_CONTEXT_MASK			= SQ_WAVE_TRAPSTS_SAVECTX_MASK
@@ -157,6 +169,7 @@ var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
 var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
 var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
 var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
+var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT	= 7
 var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
 var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
 var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
@@ -173,6 +186,11 @@ var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
 						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
 						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
 						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
+var S_TRAPSTS_RESTORE_PART_1_SIZE		= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
+var S_TRAPSTS_RESTORE_PART_2_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
+var S_TRAPSTS_RESTORE_PART_2_SIZE		= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
+var S_TRAPSTS_RESTORE_PART_3_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
+var S_TRAPSTS_RESTORE_PART_3_SIZE		= 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
 var BARRIER_STATE_SIGNAL_OFFSET			= 16
 var BARRIER_STATE_VALID_OFFSET			= 0
 #endif
@@ -1386,17 +1404,17 @@ L_SKIP_BARRIER_RESTORE:
 	s_setreg_b32	hwreg(HW_REG_SHADER_XNACK_MASK), s_restore_xnack_mask
 #endif
 
-#if ASIC_FAMILY < CHIP_GFX12
-	s_setreg_b32	hwreg(S_TRAPSTS_HWREG), s_restore_trapsts
-#else
-	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
+	// {TRAPSTS/EXCP_FLAG_PRIV}.SAVE_CONTEXT and HOST_TRAP may have changed.
 	// Only restore the other fields to avoid clobbering them.
-	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, 0, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT), s_restore_trapsts
-	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
-	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT, 1), s_restore_trapsts
-	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
-	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT, 32 - SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT), s_restore_trapsts
-#endif
+	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, 0, S_TRAPSTS_RESTORE_PART_1_SIZE), s_restore_trapsts
+	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, S_TRAPSTS_RESTORE_PART_2_SHIFT
+	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_RESTORE_PART_2_SHIFT, S_TRAPSTS_RESTORE_PART_2_SIZE), s_restore_trapsts
+
+if S_TRAPSTS_RESTORE_PART_3_SIZE > 0
+	s_lshr_b32	s_restore_trapsts, s_restore_trapsts, S_TRAPSTS_RESTORE_PART_3_SHIFT - S_TRAPSTS_RESTORE_PART_2_SHIFT
+	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_RESTORE_PART_3_SHIFT, S_TRAPSTS_RESTORE_PART_3_SIZE), s_restore_trapsts
+end
+
 	s_setreg_b32	hwreg(HW_REG_MODE), s_restore_mode
 
 	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
-- 
2.34.1

