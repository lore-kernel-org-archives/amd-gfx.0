Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46F6CCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DD410E70D;
	Wed, 29 Oct 2025 07:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5HGQQSH2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B737610E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rshhBHaOKrLq3p1uUp/4JC7fzQKSQncLb+bYyEsTncIk6o1sl6GQGdjOf5YkwPnBm0ViatuRutoCKeJBfyFE0Ppa5TRuXx/5/8JwUjKj81bnB4ImwktCqrUCh6YuMOANqRMII2ykz2ey34d8uvbiriSQM3rqazDoz0IsIlX782Gvvc9ikXoaQwSUnFI/kGfnpTVv6NOjp98IaKORtV9kSneyvCc81dvQaM2m7GUxYAI+rMVqmoaD8wQVMCNf+uxUVLoKfUucTIDEGo82pdyOl9HsAc8zjFmRi3+jWzlcwCVJW8MBne07IHLf0Ikb0mzDK/YTN1mhkiIoiog+UgWtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD/m55G22LguoOMq6ceE69xktcNeYkIuPZi6sZEEu78=;
 b=YS6VWvXl24up0a58FV0jZRv1b8x1Ed+Ag0fSPWflXrr0nl30W5zl7bJfZ65rEPqyFVqY7L9lpvrO7jNwmJdEU/f9/y+poFJQ2Hje6Z/K57ikVjJZnTcjl5PtDzJ/aqf9izxTFoos0nzzZ6n+PVrZpKE4IWJM8Z6ahsE/zc7qURhWqan0bag+SzCAuosTQ82Q2UUFRVTV9kcIdEGCMnKyLX/zZ15epOyrXmx5fKyZ9HmfMc2EZUw6ffGlmE8ZGmddsl2IutJOH1lokK0a01XaA5PQYLjW05wR8qdIVZO4Fk2FyLclIFGAeds0Q0aF4rk7rvkpc54/XKnSweavOULpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD/m55G22LguoOMq6ceE69xktcNeYkIuPZi6sZEEu78=;
 b=5HGQQSH2HkY6/WkdUUX+Mo4MZbozdBzql/mhpFavPPbezcgD6YP3OFLC8JXB5lAgIcyV9bBKTRnLl+0RDDaLCmKDd7LDFZiiOAhDH4v0TxvO5EwfUnT4Do7YlmXOqgDgrW8lSne1aiC3KlDLtBnl71jNmh5wrdV3YUKoKuxF13U=
Received: from DS7P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::32) by
 BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:31:27 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:8:223:cafe::fc) by DS7P220CA0034.outlook.office365.com
 (2603:10b6:8:223::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 07:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:31:27 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:31:26 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 01/10] drm/amd/pm: add new message definitions for pmfw eeprom
 interface
Date: Wed, 29 Oct 2025 15:30:59 +0800
Message-ID: <20251029073108.1698129-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c0b8b9-d241-4e0f-a756-08de16bd2c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?37IYFlgQRHIoOCqGsYs8pxtD7ZpWphSg4sQW5bMDVdAyJkc2nwlCbI44Xo+g?=
 =?us-ascii?Q?4xh+D7jibBOH6Bz8AoMZFS8Z/aRT+OKBhe6qS97Sr2R1M1ZauiC4N5WeZ12q?=
 =?us-ascii?Q?wnlpAP3DT50ZQNFEqG0crSemW79NDIl61YUBJrhN4mfwpW9hPeEuDPExLW8p?=
 =?us-ascii?Q?Pnr7jMpqmhWFJTnhE87DR8As755Y230Vyh/KzN79tklcDQ5nfYfX0SO05uce?=
 =?us-ascii?Q?rkzoQPqDpgBCeHVFMVHJ5RA2EjKeSSS2qDSS2Yk/+y7do71IZ358OSHuNn+C?=
 =?us-ascii?Q?tPiPxPWwuuq5KGGXwNQ3qPWlgH1C0QjXP0UfvTSsqIYS4pfKJgKtiJCD81F7?=
 =?us-ascii?Q?veVbss9opA6/0fUikIb/e6vv1ElA5M6TaFm5WrmdNyQsK0RFOEFbhDssCPe5?=
 =?us-ascii?Q?MGmpS5diR6+s7OasCSpfjL1C/ZTWpM7yiNFiPQPb0M4fdQnx9lwvX9SoR6oM?=
 =?us-ascii?Q?u3ajyDsctvm84OnhQgQJuFczBkfeCZP4CA3NeXiTjaOVj7h6mX4SX7t5fnpy?=
 =?us-ascii?Q?C0tIRkzFqE0mv0FhlKUlN7b/BXW3m8nUrgDTHe/gsr4kApn4egxNMT7qhiCY?=
 =?us-ascii?Q?utLhSrYPtPI4nk/POK43Xjt1Kd9z7fPtjtfvTIuuC+mVDbjIZzU/kzoAepz6?=
 =?us-ascii?Q?os/AHDoi5rtCrKxGDmpo2PLkXca/YUTxjjq5JoOyGVmBXJcYbHFvQJ7yVb9c?=
 =?us-ascii?Q?yNUy+BtwFxFQxCLzs2Tz3XDlf/eFNTk7YfSipcK9FgkO0Agbo+ICbfaoOhM9?=
 =?us-ascii?Q?r7jFuhZ/+TYMW01Bb3HXR43hotqWufXp30rE3hNMSRoNoep71D91eo7Z1oVe?=
 =?us-ascii?Q?qJXtnBQAwFiwtMwsHYQy1yksfr7qutU1C14mLARKmCSlvkintN/ejN7zWL8d?=
 =?us-ascii?Q?rNQYXPv7HHh1kVC/OR7JsJnrDMxF9DolMGV5fZmCcIYXa2uuadR7/SBcyhg2?=
 =?us-ascii?Q?tvfRsO9Bo/cL5oqu2ZXNMXUwrRbJU4KxoRDasM9OxfXEhghUb3O9JFIgwbEp?=
 =?us-ascii?Q?faMwgmwve9W4WV0eN0MYJeSAcXKR9HCp45mquYLw37Ipbdc0oZoWORxI9dj5?=
 =?us-ascii?Q?z5Ex6suYmsFocpuE52sJ1ps+gb027tolki1p2nKCQVZd0gxUK1Kbu6Ev/ef7?=
 =?us-ascii?Q?+iLFcun9ACBUeG9421caJb5osBCRF571AoxfXR2gMhM+kV4dsCwLefTGqhAl?=
 =?us-ascii?Q?AWzQB4xuuOUSUwtDR7XUN29oBlN58/54wvax5nnkXy2y9uN/D1yoFa1GcDcn?=
 =?us-ascii?Q?FBrZ/whxJIsTJwpToMKA9tHG6S3jsJSxBCTDmiEeQvHb4ze2Ijaaqq4y8G8X?=
 =?us-ascii?Q?hsvR5UkBkVzJhrbC015PdAzubFi9kxCSvsbaroFMYGZtELPSesL5Silc6IQS?=
 =?us-ascii?Q?jGld609MMcdE2GMZn8ZDj2pQ7a3ABfMa7HpQB78JACSO0GpHG38apP4BRRYx?=
 =?us-ascii?Q?QRUa4SDDudbahVM1cjRfV3HSOh5Dnf36PrYzmGV6MVTnf2HUDoh6da2MD0yc?=
 =?us-ascii?Q?Fb1iCzO1IPbTEfKP1vX4SmIJMBWFTCQoV3DGYoV9J51UIjyyjxea/hKT3C5f?=
 =?us-ascii?Q?pMIaDWIUa09JeQYZ99k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:31:27.5653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c0b8b9-d241-4e0f-a756-08de16bd2c02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
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

Add new message definitions for pmfw eeprom interface

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h    | 16 ++++++----------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h     |  9 ++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    |  7 +++++++
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index 4b066c42e0ec..fe1b3ac50a75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -105,19 +105,15 @@
 #define PPSMC_MSG_UpdatePccWaitDecMaxStr            0x4C
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_GetRasTableVersion                0x4E
-#define PPSMC_MSG_GetRmaStatus                      0x4F
-#define PPSMC_MSG_GetErrorCount                     0x50
-#define PPSMC_MSG_GetBadPageCount                   0x51
-#define PPSMC_MSG_GetBadPageInfo                    0x52
-#define PPSMC_MSG_GetBadPagePaAddrLoHi              0x53
-#define PPSMC_MSG_SetTimestampLoHi                  0x54
-#define PPSMC_MSG_GetTimestampLoHi                  0x55
-#define PPSMC_MSG_GetRasPolicy                      0x56
-#define PPSMC_MSG_DumpErrorRecord                   0x57
+#define PPSMC_MSG_GetBadPageCount                   0x50
+#define PPSMC_MSG_GetBadPageMcaAddress              0x51
+#define PPSMC_MSG_SetTimestamp                      0x53
+#define PPSMC_MSG_SetTimestampHi                    0x54
+#define PPSMC_MSG_GetTimestamp                      0x55
+#define PPSMC_MSG_GetBadPageIpIdLoHi                0x57
 #define PPSMC_MSG_EraseRasTable                     0x58
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
 #define PPSMC_MSG_ResetVfArbitersByIndex            0x5A
-#define PPSMC_MSG_GetBadPageSeverity                0x5B
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
 #define PPSMC_MSG_ResetVCN                          0x5E
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 2256c77da636..9315ce49b396 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -279,7 +279,14 @@
 	__SMU_DUMMY_MAP(ResetSDMA), \
 	__SMU_DUMMY_MAP(ResetVCN), \
 	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
-	__SMU_DUMMY_MAP(GetSystemMetricsTable),
+	__SMU_DUMMY_MAP(GetSystemMetricsTable), \
+	__SMU_DUMMY_MAP(GetRASTableVersion), \
+	__SMU_DUMMY_MAP(GetBadPageCount), \
+	__SMU_DUMMY_MAP(GetBadPageMcaAddr), \
+	__SMU_DUMMY_MAP(SetTimestamp), \
+	__SMU_DUMMY_MAP(GetTimestamp), \
+	__SMU_DUMMY_MAP(GetBadPageIpid), \
+	__SMU_DUMMY_MAP(EraseRasTable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index cb3fea9e8cf3..27b950c126ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -139,6 +139,13 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
+	MSG_MAP(GetRASTableVersion,                  PPSMC_MSG_GetRasTableVersion,              0),
+	MSG_MAP(GetBadPageCount,                     PPSMC_MSG_GetBadPageCount,                 0),
+	MSG_MAP(GetBadPageMcaAddr,                   PPSMC_MSG_GetBadPageMcaAddress,            0),
+	MSG_MAP(SetTimestamp,                        PPSMC_MSG_SetTimestamp,                    0),
+	MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp,                    0),
+	MSG_MAP(GetBadPageIpid,                      PPSMC_MSG_GetBadPageIpIdLoHi,              0),
+	MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTable,                   0),
 };
 
 int smu_v13_0_12_tables_init(struct smu_context *smu)
-- 
2.34.1

