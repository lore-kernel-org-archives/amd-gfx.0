Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFD8FEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E369110E5F8;
	Tue, 17 Mar 2026 20:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FjumBeWF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EA610E62E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxFMGf0t6AXQlbctnNFlWwgTDgfLuvVQnRDFjytRKYK83V7W/zBNdCoQRP4ptxgQGQMJFF6oF5gJGDpdn4Md/4ndRqgymzuRiDTbqNQoMcDQMWoscuWylmV5v5mUzM7BmBHA5TAokJhNC/U9NwmIErXT3Vwj6wG+myqriIax5t2VzQpCPnSpVRGte0hIIqrs/kn3AX+gDAu+wSSX1ADGrTmh4X+KPmkOA1Et0SeVoeobSLeD1KVWmBNsLO9wDvvetfqzws5EKlfruxc5rk7vZyK5OKInCw+9JCcIc8+BC09O//F5EOKuoKySfz/iPqqSzVj1mcr9QF0rhbGoAwxpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC7yXANuGbYtVUmG/xtjDD6SQmFWZaMPVDxhZQRMmEo=;
 b=vjQgoBpULsNy8fo2FHZDG2CRso/0TPuPvV2W5qqm7gernVMHGht8/1Ba9HF9DG09ha3REfwud3oQBfDuCkdG1C3A0mYdulqjNJwUZTypJG26dyiIWE/Cy2a5NbFGvPocsrMcO4bvQRuCK35Gyjbfg4Kt4old1gifMeiLWtRj7yrcQzwwGPt8kIyAEt67cLNrHrse3wYgkWQ3tVq5KY9cQD7rOmo8NeS0CGIU1CpvzAwl6EsUdMnHY4NfpOI+DHwsk/XhjqPjlek3nbKjVeuOQUHhU8U/fdYI1BA0ud/xStD/Wep+6HAv6YP2vzpy7s2SjtpSmLFe/TBYpBhZe+x2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC7yXANuGbYtVUmG/xtjDD6SQmFWZaMPVDxhZQRMmEo=;
 b=FjumBeWFgOcpKYUqPHk3R7Bw/mdO1lo31GhDK9vXnas/9spe8S1xZlfTV6b0dRp8IqZKQDjaT3UW/B9UUv4hHXn1zHNvM7hDpLCRE/VWyLjT4QSwFURWURwPZAzf8YfgWl59nXThzyxWfsdxZyXTgsoFbDMrsnBidA3700nKdQM=
Received: from PH2PEPF00003855.namprd17.prod.outlook.com (2603:10b6:518:1::75)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:00 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH2PEPF00003855.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:12:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:12:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:12:57 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:12:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Yang
 Wang <kevinyang.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/25] drm/amd/pm: Add initial support for smu v15_0_8
Date: Tue, 17 Mar 2026 16:12:20 -0400
Message-ID: <20260317201242.3808136-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 401caeb3-e71b-4a5d-98cb-08de84619623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: DHb+0xZ4WXZ+7XgNHFvId97Vd5fb8K3+kQPfZL774rouC8I2ob6ZEbpVTZe8JMtWQfyF9wF+UTd6WNtcgDuW0mCWnrGU/aI40c9Jlp8lAtuh2jFkcaPoUH6t95q9MyM8B+8xY6JXxN0hsy8CD/D2HujB6ZC36QfIPVRNIwk7t+bhet52StWwyCd2yv9Olrcixk0X0GAOCmiWdW0LJoGwmgPBHwLmXnbOIuihZrY55g8FGO2XoeCvJDZMGOCWT0KG1amPJt6w+d2FHZQJaMZ4likMAlGGZJ3BFAZxiwlgR7RuNHLgWBivnT2PKZv9FClrQ2rHIJ28Z6g/NT6vyNd6N5BSfvvgRoi3qKaqYBos+g51w1vGxt2mEcdIU143cBI92i6I0xm6PyvgrcOpiIQwAnH8SNvAclBX3y3O3dKfAoeUPG2tpl3tGPsdfhB0Bd00WYIcK4mdrFjBz0p6nLPfSB0tQl3RViY4Ki9tfecSjcCYkAGmjzV1WNdZ4RNqUVKv6DQVWTCE4Ivvdvt73zbBPtSH+4gQBtuNcapUsSkWC+LXEgqCiHb+LZdorz1sdiy3wN6YwF9TiZjLgdvks5KklE1p1CmWn1gvz+HoU8874rzXkM+WEpar8Ny3N6af3Juk+oJnBWPUWRZvXVxCD7uhyhHBQdInXqC4Q/9UCeCtyRGsAt67cRadpJwIpENomoMuMPQdtx+qIOr+z8e+cP0x/VY2XyZ9/zj+ZsYU7KgawEdt5cNuuqTgF31KnIRdmx6SNEv8WE7z+9okDwEFAoVQRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AOVda00n+Ze9uiUMlPNqRpCVvzBI1CBFBJ3QZ5pm++2lSNGMGvbMhWKdRdIynOpKorX/2KcDaWvmiSw8OK9nRAUCH3kWZgFnZIjxnbQFDihY0pv9cqjQJFK0noAoi9anNbQIvO9zFak5NRIZnE9zdrOTUiOsPzWrewVQ0rq3EEAb7+Oiby+Q0iXWxEwIFJHL3/nbq9wOE0TMyRKlmScUkUfAj7dEilzjFtPb+pJHms7HkoWhHDHJrcFcLOO/4s0rdpEzQ+Sr1pPRSjSpV+W/lA0fkaV/+JRjrhrT94S95OFKe4dsnj6EXqPXMX2T00MMQQ9P4EwQRLyK7kZhAKQEzWdExYq1ZcBek1gUnJ9kpsoPrb7Vk3PXh2rT1xUc3HR2YemtgNoiz/7JB1LPw2esi4vBYUAXtOVzGJGerG/CFdEQaumNGXM7ypvZb2hxw2fD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:12:59.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401caeb3-e71b-4a5d-98cb-08de84619623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

smu v15_0_8 is the new generation of smu ip block

v2: Squash in rebase changes (Alex)
v3: Squash in fw version check changes (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  15 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   6 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  81 ++-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 483 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  |  28 +
 7 files changed, 564 insertions(+), 52 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3dc9171941542..5a92ab9601a15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -47,6 +47,7 @@
 #include "smu_v14_0_0_ppt.h"
 #include "smu_v14_0_2_ppt.h"
 #include "smu_v15_0_0_ppt.h"
+#include "smu_v15_0_8_ppt.h"
 #include "amd_pcie.h"
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 584c4cfd0c16f..5f77749998e32 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -292,7 +292,12 @@
 	__SMU_DUMMY_MAP(AllowZstates), \
 	__SMU_DUMMY_MAP(GetSmartShiftStatus), \
 	__SMU_DUMMY_MAP(EnableLSdma), \
-	__SMU_DUMMY_MAP(DisableLSdma),
+	__SMU_DUMMY_MAP(DisableLSdma), \
+	__SMU_DUMMY_MAP(InitializeGfx), \
+	__SMU_DUMMY_MAP(SetSoftMaxFclk), \
+	__SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
+	__SMU_DUMMY_MAP(SetSoftMinGl2clk), \
+	__SMU_DUMMY_MAP(GetSystemMetricsVersion),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
@@ -472,6 +477,14 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
        __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
        __SMU_DUMMY_MAP(PIT),				\
+       __SMU_DUMMY_MAP(DS_DMABECLK),				\
+       __SMU_DUMMY_MAP(DS_MPIFOECLK),				\
+       __SMU_DUMMY_MAP(DS_MPRASCLK),				\
+       __SMU_DUMMY_MAP(DS_MPNHTCLK),				\
+       __SMU_DUMMY_MAP(DS_FIOCLK),				\
+       __SMU_DUMMY_MAP(DS_DXIOCLK),				\
+       __SMU_DUMMY_MAP(DS_GL2CLK),				\
+       __SMU_DUMMY_MAP(DPM_GL2CLK),				\
        __SMU_DUMMY_MAP(HROM_EN),
 
 #undef __SMU_DUMMY_MAP
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 09743ccd0d15c..95c77e926e1fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -41,6 +41,10 @@
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
 #define smnMP1_PUB_CTRL			0x3010d10
 
+#define SMU15_DRIVER_IF_VERSION_SMU_V15_0_8 0x007D0000
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+
 #define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 3
 
@@ -104,6 +108,7 @@ struct smu_15_0_dpm_context {
 	struct smu_15_0_dpm_tables  dpm_tables;
 	uint32_t                    workload_policy_mask;
 	uint32_t                    dcef_min_ds_clk;
+	uint64_t                    caps;
 };
 
 enum smu_15_0_power_state {
@@ -118,6 +123,7 @@ struct smu_15_0_power_context {
 	uint32_t	power_source;
 	uint8_t		in_power_limit_boost_mode;
 	enum smu_15_0_power_state power_state;
+	atomic_t 	throttle_status;
 };
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile
index 7f59a0aabdeb6..fa083ad46c0fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.
 
-SMU15_MGR = smu_v15_0.o smu_v15_0_0_ppt.o
+SMU15_MGR = smu_v15_0.o smu_v15_0_0_ppt.o smu_v15_0_8_ppt.o
 
 AMD_SWSMU_SMU15MGR = $(addprefix $(AMD_SWSMU_PATH)/smu15/,$(SMU15_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 478ee87af51f3..51d1f5d42ad31 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -590,71 +590,52 @@ int smu_v15_0_notify_memory_pool_location(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *memory_pool = &smu_table->memory_pool;
-	int ret = 0;
-	uint64_t address;
-	uint32_t address_low, address_high;
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_DramLogSetDramAddr,
+		.num_args = 3,
+		.num_out_args = 0,
+	};
 
 	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
-		return ret;
-
-	address = memory_pool->mc_address;
-	address_high = (uint32_t)upper_32_bits(address);
-	address_low  = (uint32_t)lower_32_bits(address);
+		return 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
-					      address_high, NULL);
-	if (ret)
-		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
-					      address_low, NULL);
-	if (ret)
-		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
-	if (ret)
-		return ret;
+	/* SMU_MSG_DramLogSetDramAddr: ARG0=low, ARG1=high, ARG2=size */
+	args.args[0] = lower_32_bits(memory_pool->mc_address);
+	args.args[1] = upper_32_bits(memory_pool->mc_address);
+	args.args[2] = (u32)memory_pool->size;
 
-	return ret;
+	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
 }
 
 int smu_v15_0_set_driver_table_location(struct smu_context *smu)
 {
 	struct smu_table *driver_table = &smu->smu_table.driver_table;
-	int ret = 0;
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_SetDriverDramAddrHigh,
+		.num_args = 2,
+		.num_out_args = 0,
+	};
 
-	if (driver_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetDriverDramAddrHigh,
-						      upper_32_bits(driver_table->mc_address),
-						      NULL);
-		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_SetDriverDramAddrLow,
-							      lower_32_bits(driver_table->mc_address),
-							      NULL);
-	}
+	args.args[0] = lower_32_bits(driver_table->mc_address);
+	args.args[1] = upper_32_bits(driver_table->mc_address);
 
-	return ret;
+	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
 }
 
 int smu_v15_0_set_tool_table_location(struct smu_context *smu)
 {
-	int ret = 0;
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_SetToolsDramAddrHigh,
+		.num_args = 2,
+		.num_out_args = 0,
+	};
 
-	if (tool_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetToolsDramAddrHigh,
-						      upper_32_bits(tool_table->mc_address),
-						      NULL);
-		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_SetToolsDramAddrLow,
-							      lower_32_bits(tool_table->mc_address),
-							      NULL);
-	}
+	/* SMU_MSG_SetToolsDramAddr: ARG0=low, ARG1=high */
+	args.args[0] = lower_32_bits(tool_table->mc_address);
+	args.args[1] = upper_32_bits(tool_table->mc_address);
 
-	return ret;
+	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
 }
 
 int smu_v15_0_set_allowed_mask(struct smu_context *smu)
@@ -701,8 +682,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-int smu_v15_0_system_features_control(struct smu_context *smu,
-				      bool en)
+int smu_v15_0_system_features_control(struct smu_context *smu, bool en)
 {
 	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
 					  SMU_MSG_DisableAllSmuFeatures), NULL);
@@ -906,7 +886,8 @@ static int smu_v15_0_wait_for_reset_complete(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v15_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
+int smu_v15_0_wait_for_event(struct smu_context *smu,
+			     enum smu_event_type event,
 			     uint64_t event_arg)
 {
 	int ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
new file mode 100644
index 0000000000000..c4da0cdc1222a
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -0,0 +1,483 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#define SWSMU_CODE_LAYER_L2
+
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v15_0_8_pmfw.h"
+#include "smu15_driver_if_v15_0_8.h"
+#include "smu_v15_0_8_ppsmc.h"
+#include "smu_v15_0_8_ppt.h"
+#include <linux/pci.h>
+#include "smu_cmn.h"
+#include "mp/mp_15_0_8_offset.h"
+#include "mp/mp_15_0_8_sh_mask.h"
+#include "smu_v15_0.h"
+
+#undef MP1_Public
+
+/* address block */
+#define MP1_Public 			0x03b00000
+#define smnMP1_FIRMWARE_FLAGS_15_0_8 	0x3010024
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
+
+#define SMU_15_0_8_FEA_MAP(smu_feature, smu_15_0_8_feature)                    \
+	[smu_feature] = { 1, (smu_15_0_8_feature) }
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+
+static const struct smu_feature_bits smu_v15_0_8_dpm_features = {
+	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_ID_DATA_CALCULATION),
+		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_GFXCLK),
+		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_UCLK),
+		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_FCLK),
+		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_GL2CLK) }
+};
+
+static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
+	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
+	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI | SMU_MSG_NO_PRECHECK),
+	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
+	MSG_MAP(GetMetricsVersion,		     PPSMC_MSG_GetMetricsVersion,		1),
+	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
+	MSG_MAP(GetEnabledSmuFeatures,	     	     PPSMC_MSG_GetEnabledSmuFeatures,		1),
+	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddr,		1),
+	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddr,		0),
+	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		1),
+	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
+	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
+	MSG_MAP(DramLogSetDramAddr,		     PPSMC_MSG_DramLogSetDramAddr,		0),
+	MSG_MAP(HeavySBR,		     	     PPSMC_MSG_HeavySBR,			0),
+	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl,			0),
+	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
+	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                1),
+	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                1),
+	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
+	MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMcaCount,              SMU_MSG_RAS_PRI),
+	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   SMU_MSG_RAS_PRI),
+	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
+	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            SMU_MSG_RAS_PRI),
+	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 SMU_MSG_RAS_PRI),
+	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
+	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
+	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(GetRASTableVersion,                  PPSMC_MSG_GetRasTableVersion,              0),
+	MSG_MAP(SetTimestamp,                        PPSMC_MSG_SetTimestamp,                    0),
+	MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp,                    0),
+	MSG_MAP(GetBadPageIpid,                      PPSMC_MSG_GetBadPageIpIdLoHi,              0),
+	MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTable,                   0),
+	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,		1),
+	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
+	MSG_MAP(GetSystemMetricsVersion,             PPSMC_MSG_GetSystemMetricsVersion,		0),
+	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
+	MSG_MAP(SetFastPptLimit,                     PPSMC_MSG_SetFastPptLimit,			0),
+	MSG_MAP(GetFastPptLimit,                     PPSMC_MSG_GetFastPptLimit,			0),
+	MSG_MAP(SetSoftMinGl2clk,                    PPSMC_MSG_SetSoftMinGl2clk,		0),
+	MSG_MAP(SetSoftMaxGl2clk,                    PPSMC_MSG_SetSoftMaxGl2clk,		0),
+	MSG_MAP(SetSoftMinFclk,                      PPSMC_MSG_SetSoftMinFclk,			0),
+	MSG_MAP(SetSoftMaxFclk,                      PPSMC_MSG_SetSoftMaxFclk,			0),
+};
+
+/* TODO: Update the clk map once enum PPCLK is updated in smu15_driver_if_v15_0_8.h */
+static struct cmn2asic_mapping smu_v15_0_8_clk_map[SMU_CLK_COUNT] = {
+	CLK_MAP(UCLK,		PPCLK_UCLK),
+};
+
+static const struct cmn2asic_mapping smu_v15_0_8_feature_mask_map[SMU_FEATURE_COUNT] = {
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_ID_DATA_CALCULATION),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT, 			FEATURE_ID_DPM_GFXCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DPM_UCLK_BIT,                    FEATURE_ID_DPM_UCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DPM_FCLK_BIT, 			FEATURE_ID_DPM_FCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DPM_GL2CLK_BIT, 			FEATURE_ID_DPM_GL2CLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_GFXCLK_BIT, 			FEATURE_ID_DS_GFXCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_SOCCLK_BIT, 			FEATURE_ID_DS_SOCCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_LCLK_BIT, 			FEATURE_ID_DS_LCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_FCLK_BIT, 			FEATURE_ID_DS_FCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_DMABECLK_BIT, 		FEATURE_ID_DS_DMABECLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_MPIFOECLK_BIT, 		FEATURE_ID_DS_MPIFOECLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_MPRASCLK_BIT, 		FEATURE_ID_DS_MPRASCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_MPNHTCLK_BIT, 		FEATURE_ID_DS_MPNHTCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_FIOCLK_BIT, 			FEATURE_ID_DS_FIOCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_DXIOCLK_BIT, 			FEATURE_ID_DS_DXIOCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_GL2CLK_BIT, 			FEATURE_ID_DS_GL2CLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_PPT_BIT, 			FEATURE_ID_PPT),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_TDC_BIT, 			FEATURE_ID_TDC),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_MP1_CG_BIT, 			FEATURE_ID_SMU_CG),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 			FEATURE_ID_FW_CTF),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_ID_THERMAL),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_SOC_PCC_BIT, 			FEATURE_ID_SOC_PCC),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_ID_XGMI_PER_LINK_PWR_DOWN),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_VCN_BIT,			FEATURE_ID_DS_VCN),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_MP1CLK_BIT,			FEATURE_ID_DS_MP1CLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_ID_DS_MPIOCLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_ID_DS_MP0CLK),
+	SMU_15_0_8_FEA_MAP(SMU_FEATURE_PIT_BIT,				FEATURE_ID_PIT),
+};
+
+#define TABLE_PMSTATUSLOG             0
+#define TABLE_SMU_METRICS             1
+#define TABLE_I2C_COMMANDS            2
+#define TABLE_COUNT                   3
+
+static const struct cmn2asic_mapping smu_v15_0_8_table_map[SMU_TABLE_COUNT] = {
+	TAB_MAP(PMSTATUSLOG),
+	TAB_MAP(SMU_METRICS),
+	TAB_MAP(I2C_COMMANDS),
+};
+
+static int smu_v15_0_8_tables_init(struct smu_context *smu)
+{
+	return 0;
+}
+
+static int smu_v15_0_8_allocate_dpm_context(struct smu_context *smu)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+	smu_dpm->dpm_context =
+		kzalloc(sizeof(struct smu_15_0_dpm_context), GFP_KERNEL);
+	if (!smu_dpm->dpm_context)
+		return -ENOMEM;
+	smu_dpm->dpm_context_size = sizeof(struct smu_15_0_dpm_context);
+
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+	if (!smu_dpm->dpm_policies) {
+		kfree(smu_dpm->dpm_context);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_8_init_smc_tables(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = smu_v15_0_8_tables_init(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_v15_0_8_allocate_dpm_context(smu);
+
+	return ret;
+}
+
+static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
+{
+	/* pptable will handle the features to enable */
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
+
+	return 0;
+}
+
+static int smu_v15_0_8_set_default_dpm_table(struct smu_context *smu)
+{
+	return 0;
+}
+
+static int smu_v15_0_8_setup_pptable(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+
+	/* TODO: PPTable is not available.
+	 * 1) Find an alternate way to get 'PPTable values' here.
+	 * 2) Check if there is SW CTF
+	 */
+	table_context->thermal_controller_type = 0;
+
+	return 0;
+}
+
+static int smu_v15_0_8_check_fw_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t mp1_fw_flags;
+
+	mp1_fw_flags = RREG32_PCIE(MP1_Public |
+				   (smnMP1_FIRMWARE_FLAGS_15_0_8 & 0xffffffff));
+
+	if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
+	    MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
+		return 0;
+
+	return -EIO;
+}
+
+static int smu_v15_0_8_irq_process(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   struct amdgpu_iv_entry *entry)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_15_0_power_context *power_context = smu_power->power_context;
+	uint32_t client_id = entry->client_id;
+	uint32_t ctxid = entry->src_data[0];
+	uint32_t src_id = entry->src_id;
+	uint32_t data;
+
+	if (client_id == SOC_V1_0_IH_CLIENTID_MP1) {
+		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
+			/* ACK SMUToHost interrupt */
+			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
+			/*
+			 * ctxid is used to distinguish different events for SMCToHost
+			 * interrupt.
+			 */
+			switch (ctxid) {
+			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
+				/*
+				 * Increment the throttle interrupt counter
+				 */
+				atomic64_inc(&smu->throttle_int_counter);
+
+				if (!atomic_read(&adev->throttling_logging_enabled))
+					return 0;
+
+				/* This uses the new method which fixes the
+				 * incorrect throttling status reporting
+				 * through metrics table. For older FWs,
+				 * it will be ignored.
+				 */
+				if (__ratelimit(&adev->throttling_logging_rs)) {
+					atomic_set(
+						&power_context->throttle_status,
+							entry->src_data[1]);
+					schedule_work(&smu->throttling_logging_work);
+				}
+				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled context id %d from client:%d!\n",
+									ctxid, client_id);
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_8_set_irq_state(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     unsigned type,
+				     enum amdgpu_interrupt_state state)
+{
+	uint32_t val = 0;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		/* For MP1 SW irqs */
+		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* For MP1 SW irqs */
+		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT, val);
+
+		val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+		WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, val);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs smu_v15_0_8_irq_funcs = {
+	.set = smu_v15_0_8_set_irq_state,
+	.process = smu_v15_0_8_irq_process,
+};
+
+static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_irq_src *irq_src = &smu->irq_source;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	irq_src->num_types = 1;
+	irq_src->funcs = &smu_v15_0_8_irq_funcs;
+
+	ret = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_MP1,
+				IH_INTERRUPT_ID_TO_DRIVER,
+				irq_src);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int smu_v15_0_8_notify_unload(struct smu_context *smu)
+{
+	if (amdgpu_in_reset(smu->adev))
+		return 0;
+
+	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
+	/* Ignore return, just intimate FW that driver is not going to be there */
+	smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+
+	return 0;
+}
+
+
+static int smu_v15_0_8_system_features_control(struct smu_context *smu,
+					       bool enable)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (enable)
+		ret = smu_v15_0_system_features_control(smu, enable);
+	else
+		smu_v15_0_8_notify_unload(smu);
+
+	return ret;
+}
+
+/**
+ * smu_v15_0_8_get_enabled_mask - Get enabled SMU features (128-bit)
+ * @smu: SMU context
+ * @feature_mask: feature mask structure
+ *
+ * SMU 15 returns all 128 feature bits in a single message via out_args[0..3].
+ * For backward compatibility, this function returns only the first 64 bits.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int smu_v15_0_8_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+	int ret;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	ret = smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+
+	if (ret)
+		return ret;
+
+	smu_feature_bits_from_arr32(feature_mask, args.out_args,
+				    SMU_FEATURE_NUM_DEFAULT);
+
+	return 0;
+}
+
+static bool smu_v15_0_8_is_dpm_running(struct smu_context *smu)
+{
+	int ret = 0;
+	struct smu_feature_bits feature_enabled;
+
+	ret = smu_v15_0_8_get_enabled_mask(smu, &feature_enabled);
+	if (ret)
+		return false;
+
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v15_0_8_dpm_features.bits);
+}
+
+static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
+	.init_allowed_features = smu_v15_0_8_init_allowed_features,
+	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
+	.is_dpm_running = smu_v15_0_8_is_dpm_running,
+	.init_smc_tables = smu_v15_0_8_init_smc_tables,
+	.fini_smc_tables = smu_v15_0_fini_smc_tables,
+	.init_power = smu_v15_0_init_power,
+	.fini_power = smu_v15_0_fini_power,
+	.check_fw_status = smu_v15_0_8_check_fw_status,
+	.check_fw_version = smu_cmn_check_fw_version,
+	.set_driver_table_location = smu_v15_0_set_driver_table_location,
+	.set_tool_table_location = smu_v15_0_set_tool_table_location,
+	.notify_memory_pool_location = smu_v15_0_notify_memory_pool_location,
+	.system_features_control = smu_v15_0_8_system_features_control,
+	.get_enabled_mask = smu_v15_0_8_get_enabled_mask,
+	.feature_is_enabled = smu_cmn_feature_is_enabled,
+	.register_irq_handler = smu_v15_0_8_register_irq_handler,
+	.setup_pptable = smu_v15_0_8_setup_pptable,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.wait_for_event = smu_v15_0_wait_for_event,
+};
+
+static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
+				     const struct cmn2asic_msg_mapping *message_map)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_40);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_41);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_42);
+	ctl->config.arg_regs[1] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_43);
+	ctl->config.arg_regs[2] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_44);
+	ctl->config.arg_regs[3] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_45);
+	ctl->config.num_arg_regs = 4;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = message_map;
+}
+
+void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu)
+{
+	smu->ppt_funcs = &smu_v15_0_8_ppt_funcs;
+	smu->clock_map = smu_v15_0_8_clk_map;
+	smu->feature_map = smu_v15_0_8_feature_mask_map;
+	smu->table_map = smu_v15_0_8_table_map;
+	smu_v15_0_8_init_msg_ctl(smu, smu_v15_0_8_message_map);
+	smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_SMU_V15_0_8;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
new file mode 100644
index 0000000000000..40c410928c966
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __SMU_15_0_8_PPT_H__
+#define __SMU_15_0_8_PPT_H__
+
+extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
+
+#endif
-- 
2.53.0

