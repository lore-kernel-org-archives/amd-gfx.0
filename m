Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057D2C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 00:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C24610E383;
	Tue, 20 Aug 2024 00:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zaEaPhOg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB6210E370
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 00:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/ypDemdTlXF9e47yQRzitgaZ4sFvtkMnMnj1iU9Kc+Q9nHQE4/Z2Cv0YQzu834t+tqMOSXGx80bhadXH6vjz5mQeE1g+PmENSM8iKJwvyRFCfnQENi7hOZHW8w1sMb8IqynLAvyTNCajHxHZEV6po7Jv04SzIMTHWMaESSv0IFHb+aksZzdiooisOD9ZZruPc8BFShNxCTk/qi7qkUVv4mqkNtSqVc9YBXLOcuZxgfICM1CsNfU6FIW05CTnU9AX50VSBhaV2TSqqd2qh6g9xTLT1Wra5KFQEoGRoNuulm4Eb3NuGxATrd6L+rgG7sLU/v10/LiUZVHHGbHZ6iFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVEMn8PB9Ds+0QfFHZQkVrxtCcY5ytienX1o8fufsZ4=;
 b=aWceZLk7ai3L70NSfoD02QdOwVMVXNfwYx2H3aes3YCdCOsKQKr8hEh4N/RoPl98U5x1N+dnXKfw3B8qaCh+ss1CPayfzkFQ/uK1Th8rjS/Oc9/OyuRjD9BZDLIaManM09cWqNdLR0eRmCaXEHlgMNUSfCdfJctUH0jT9cYKtq6PSbuiUII+3ADrGaCsC2pxCOwY3ZDuhdomrKB1QXdDdZq50/C4WquM1DHT2XX70wHhFDrMY9EItCoGyYspQmWpgeKqqTfTQgw/KzYM1c+teQFPFx+0hAV2I5XB3CjdHx07CscI6t/zwvzOMGbV9npeY0kcR2MaHEPpSP8VvWlh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVEMn8PB9Ds+0QfFHZQkVrxtCcY5ytienX1o8fufsZ4=;
 b=zaEaPhOgv/53p0dgmkLTlixFgcmB29VGBCePDJcIYcwHRWAUqUyVK3rQMiU8Ud7znyXz8kwGrFoYglFuDO0eQBNWeq0ZNGWCHrXrGHWTvOn+YeU0Fh01i0QKBJM/eBwnItPDeuaYZ3UbDy84yQFzxAgroWJgSq4gOK0SA/Egf18=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 00:59:14 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::af) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 00:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 00:59:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 19:58:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 19:58:46 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 19 Aug 2024 19:58:45 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update message interface for smu v14.0.2/3
Date: Tue, 20 Aug 2024 08:58:43 +0800
Message-ID: <20240820005844.277280-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 617d27e7-e6f2-483e-7804-08dcc0b34efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eNkdZ1TWH2haPeiLOKW4+JBIFrnBmb3VBpjD3kCTo5tbA/vANttHDotPp5b8?=
 =?us-ascii?Q?HeFYX+KCM6J7tooXpXiYekkHHxZIxl9AnKm0K/7sUkhjOwdFtHHR/yR5nI/L?=
 =?us-ascii?Q?A9xZctjb53TAjn4stcxVQj8FrXMwUcmhPjSO41L5SaBo5X12Ah60sLP7Y4zO?=
 =?us-ascii?Q?x/e/iF6lJYX31vXe1ddYsdGHXvscNpBbr15NHPHfU6XZFgIuOd4Ett8GJCqL?=
 =?us-ascii?Q?9AHiegFhp8fdoqmjk/nv7J0YoNazGbbiLuO0Y+7wTytP2bHKcc7O7oD3XX67?=
 =?us-ascii?Q?kNZLPl9GOo+dbPTM20OQSUjdbcetwj1vAAwVY8Qbu/BiPGpuUAdpU35ezv3P?=
 =?us-ascii?Q?a9wOGn3QP2nRS1MLNZioxHSBYfCIQpOPTOvCyQ0AO34w144SvTVoMWeTqiZC?=
 =?us-ascii?Q?OAxaVmBj3l0J+JMjsOQOIl/BbsZZ2y6mCZ080ETpZGf8RkxqrLPhSirsB+zO?=
 =?us-ascii?Q?yQt6gM9qTHvVH19W+fTZKn+sxt4/2AXazqK+nQ60Txg84J1VFHR3o42nVV3b?=
 =?us-ascii?Q?iO+jev4IxItijgzvehiSDkteuwUAqppa9gVBX0e08Ka09Pd2ndhkJba0YOp4?=
 =?us-ascii?Q?Qvn2f5OJwKZGybwY30ccZuGevg1tOjIXh0eIPnhffot87NDsSeZyjuYHNEbr?=
 =?us-ascii?Q?53Mm1mXysLgcc9Y6+pO8NuM/CKxnXPaXal4+zWScbosbfkNPxF7EQSIrttck?=
 =?us-ascii?Q?Z2AiheBcC0o/wkOTk5wPxdcOvQXvSpe8vPcUje+oPo2ViIQVVOfa8biHD4pD?=
 =?us-ascii?Q?DsVt6XhTWIfDIJGOGFedF2Uq28jO+O8bzirxd22ffZx7yWyNuZeRCNLpJDox?=
 =?us-ascii?Q?GcWdlEDvXBIBSxmtIpIIRG1gdBpTiHJrnExgXqnkV362O1oefXLstMWpKCPN?=
 =?us-ascii?Q?Onacc6tPpYijlFcLIbmNvxmpXVDFuWXqiJKSVpsUc0OVYvSkuKwUgfw3rh2G?=
 =?us-ascii?Q?t66HPXzh7quZC3AEBanV1jFhGAFDs8UNTguXovWEDsmrZF/T0tFcKd5l7fIT?=
 =?us-ascii?Q?h+q/8Wdkclal9DwD8GCidm681PkUVPqgXlfC7o4tzG2NwsxVHt5qUv8mcKwH?=
 =?us-ascii?Q?5kcLkTZs2bCJdn+IpYQXD/2v5uwENveC7AA1eW3w/oHZqh+lI1vdj6x+biJY?=
 =?us-ascii?Q?ZWFfaEi1YL6TT1N9b96hSxCvFW//4YwXVYqYM6tRntJ14LZd56m2+A6b9GuN?=
 =?us-ascii?Q?z6P8Z6G8rg9dLXRkIpENUN8ZCVSUjT7xRSFjgT6LuGEaBZ3C56GILQxJr1gC?=
 =?us-ascii?Q?QJMt/8wYh/qOC+5FzbzhzQcYgaoEMlwHc2avIPDo87r4N5REEZlUPda1E5aD?=
 =?us-ascii?Q?gS9yMki0KMcbAwJs++X2wgwJ87m68RTV9H2BmYdetARssQOqWRdxuRCFDtd3?=
 =?us-ascii?Q?NTkTWJw3UNQLd2Z3jnP7kCrRVPP0DzFt0QG7uSmru6h/Ys51VxkrLMzIWwrQ?=
 =?us-ascii?Q?3cj4fd9trPU+j6bnYk2J0wnJid/6d+46?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 00:59:13.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d27e7-e6f2-483e-7804-08dcc0b34efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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

update message interface for smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h   | 18 ++++++++++++++----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  1 -
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
index de2e442281ff..87ca5ceb1ece 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
@@ -92,7 +92,6 @@
 
 //Resets
 #define PPSMC_MSG_PrepareMp1ForUnload            0x2E
-#define PPSMC_MSG_Mode1Reset                     0x2F
 
 //Set SystemVirtual DramAddrHigh
 #define PPSMC_MSG_SetSystemVirtualDramAddrHigh   0x30
@@ -119,11 +118,12 @@
 
 //STB to dram log
 #define PPSMC_MSG_DumpSTBtoDram                  0x3D
-#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh    0x3E
-#define PPSMC_MSG_STBtoDramLogSetDramAddrLow     0x3F
+#define PPSMC_MSG_STBtoDramLogSetDramAddress     0x3E
+#define PPSMC_MSG_DummyUndefined                 0x3F
 #define PPSMC_MSG_STBtoDramLogSetDramSize        0x40
 #define PPSMC_MSG_SetOBMTraceBufferLogging       0x41
 
+#define PPSMC_MSG_UseProfilingMode               0x42
 #define PPSMC_MSG_AllowGfxDcs                    0x43
 #define PPSMC_MSG_DisallowGfxDcs                 0x44
 #define PPSMC_MSG_EnableAudioStutterWA           0x45
@@ -135,6 +135,16 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4B
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4C
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4D
+#define PPSMC_MSG_EnableShadowDpm                0x4E
 #define PPSMC_MSG_Mode3Reset                     0x4F
-#define PPSMC_Message_Count                      0x50
+#define PPSMC_MSG_SetDriverDramAddr              0x50
+#define PPSMC_MSG_SetToolsDramAddr               0x51
+#define PPSMC_MSG_TransferTableSmu2DramWithAddr  0x52
+#define PPSMC_MSG_TransferTableDram2SmuWithAddr  0x53
+#define PPSMC_MSG_GetAllRunningSmuFeatures       0x54
+#define PPSMC_MSG_GetSvi3Voltage                 0x55
+#define PPSMC_MSG_UpdatePolicy                   0x56
+#define PPSMC_MSG_ExtPwrConnSupport              0x57
+#define PPSMC_MSG_PreloadSwPstateForUclkOverDrive         0x58
+#define PPSMC_Message_Count                      0x59
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5913f9c60fe0..e000ac7b4c0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -127,7 +127,6 @@ static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
-	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
-- 
2.34.1

