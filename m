Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B49CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 17:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721EC10F004;
	Wed, 24 Jun 2026 17:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f1SnoRI3";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE8B10E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGHJ+RKcs8Jwt8HqaO5EHsINd/yP5N6qrS0UeDpEIZk8cRDeNf7RcJ+FqloCvavBHYo0CGloY71mChVx6LhdKAhBe6KXtddBoy1Qf58GZCqmwqCVZ5/emxBvZRp+V21nUFRJIzYjxxX2QV108ekiuFBTTq4Yyqbm+EeY/hWMA9o8aKlk4EPUtkQ4vSDJPistGY7kC9TUpL/KUzqCPP9Edvaea53BEPLklGkkv7/PqnljeJOrZKQXh8WTfMHkwJ5akhHzRWkjaGM8Z41SWAbS1Eac/xsyE1r0Nh+V75UcGqN5NbTLY38BA7LXfLeV9uQ+JpX45HIbtPv8HmR1K/OxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEM9gx89hiBTkHvPZE34T/2CKusjM0zY0aewy2iNFEg=;
 b=N2uf0rl95YuJmOXVzQncnKNtS4mTuxxoH5GUSj/XhMPnsPQcl5FVRxuBqIktJQGMqtSDw77mWFkd4JG5XGouKKCgqI95vvYXXQb0QbmwGRrPCd6ohQH4BM4gYqFlbpbftdtw2s9HuBeChKrxllHWODtGxNbOPdrQDSyLxpjgqZKraecoRHdcafpWNSAFzH2PQHjJ2BJ7FVbBdPNR58C9IrDfdaO3haZKPVr359apD2w2wmGpdwhAJy9CygdSmpVQWjZqTvFt5mhUt2tDOY7PHuvFOuLDAoDQYmA2ti2QOs/wMD68NWHJXhqMOTpVPUfdMZQGXVlPo9voEWc8rBN1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEM9gx89hiBTkHvPZE34T/2CKusjM0zY0aewy2iNFEg=;
 b=f1SnoRI3+0nN06zlf9AnNLdhVOWjctLi20ZuThHDtmlrHEOZMFM53014QAcPNRYDK8bA+UhCWo57NJC7QUKBCqejl0vknF3mr5G9C0ZEazSaZSe6S2aU70xhuRnZ1VBUJ6p00weFDP/+41SNUK42/OSvZdb0xK6OugRq0q4Ba0o=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 17:56:09 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::14) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 17:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 17:56:09 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 12:56:04 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v4 3/6] drm/amdgpu: move struct amdgpu_mqd and helpers into
 header file
Date: Wed, 24 Jun 2026 13:55:04 -0400
Message-ID: <20260624175554.489406-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624175554.489406-1-shahyan.soltani@amd.com>
References: <20260624175554.489406-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 01501e6b-a941-4cf8-7f09-08ded219df23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ODDu6VK2/VQAN1J+B3FMboivPXsMpJ+AK8OoJC+vpEP8IdFsnyaavP4rE8FUTEY2uzUlCiawaYzvmsfPoyC7eM0oN6+rOp9UxU9TxPWl+UuyZCjZx8rmImcJKr6w8gBMIiPO2c+KgD6/GFMp3RUKr28PjyiFNiimK8F3sv42OEhyNELJTporcek50/POzPIqnRIDnuakla/+mdj/s3AgKVB4jEWWuY7MVt1frok4qLaTCbCNaKAIhc5c1+qw07XWmcOAHDrEM8FL4Aa2B2Uwr9fFL3FtncFTiPDQAMuR8qv69EDhkdqifh1NFKojMBdK9DfURYfUPajB52G2JVlw0ghA8zGur4IMOaM1A2hkjA2E3AJvjEP2Ov8gjNyn5bsrQ6sgs/nIY7T6oA/9NWa/AD4DcBI19xXX/cjJql6rI4l1Z5H3e8OuabFbXwGG1U34N8HA+99a6dX4XPdqmdFx/lbxJcAGsmBc42L1K8J/K1wJGicn9klj3NuhLLo0MNUtuxkiR2S3RP3w0Y2avDQr36dWg2oxftddJLgR5LZ3RzFeS7lF0Rf0H52j6dpy84XIuqK7dlynT7tgFjRQehwJL1fs87aouMVIEZRBOSe1yvNKRFL/4VFXFNXauA81sxAMRdr271IijZwOUdEhN0/5ZgZckdPaV3aAjxmK4U0+iIlF2DL+2XWyXutag09GZv0kEc9mSxTT/A7LKukcoi6AhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ROMoUjTEEsXAfr1VcjARb+gWTZLx19f93KGbCis5rpd2/84eKMr4a/CueGsOvpBNWCMaNkhH5dfDpE+bw74P85gS5DWRE9z9r5H1UzX6wqeq1RmaKyOyDBoLBMxS0AB649yodos4G4XqZVzxrjE/WPxtoG91q41rFHH038y1ECaAZsVCKzvmpkRahCBAK3+kYii7ggbBtpWUVNPUk1l1shLbnE3HtIojdeo+TK328SSXq2tEtiiJGU14mLamOURXmr+9DBkIe2Druc7ipk53NYUaRmq40SEcp6hsa+OQvjHqxWaIEbyzugqyuTd27Rilg1HNg/v7w67b5vsBYJCi3Gm/gG5jotbCyFsfPNhlBFBSERRj95SHMW3CVD8bE9CCINug55a8pipNmB6MF0SV+YAM3ylt2/pIiWvziJ2qHZMnxvvVU3yR4+fKK1B8pGUU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:56:09.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01501e6b-a941-4cf8-7f09-08ded219df23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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

Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the monolithic amdgpu.h
into existing amdgpu_mes.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48 +------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0a1c6c9c3e18..2eaf7d570acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -96,7 +96,6 @@
 #include "amdgpu_doorbell.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_discovery.h"
-#include "amdgpu_mes.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_mmhub.h"
 #include "amdgpu_gfxhub.h"
@@ -115,6 +114,7 @@
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -624,44 +624,6 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
-enum amdgpu_mqd_update_flag {
-       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
-       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
-       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
-};
-
-struct amdgpu_mqd_prop {
-	uint64_t mqd_gpu_addr;
-	uint64_t hqd_base_gpu_addr;
-	uint64_t rptr_gpu_addr;
-	uint64_t wptr_gpu_addr;
-	uint32_t queue_size;
-	bool use_doorbell;
-	uint32_t doorbell_index;
-	uint64_t eop_gpu_addr;
-	uint32_t hqd_pipe_priority;
-	uint32_t hqd_queue_priority;
-	uint32_t mqd_stride_size;
-	bool allow_tunneling;
-	bool hqd_active;
-	uint64_t shadow_addr;
-	uint64_t gds_bkup_addr;
-	uint64_t csa_addr;
-	uint64_t fence_address;
-	bool tmz_queue;
-	bool kernel_queue;
-	uint32_t *cu_mask;
-	uint32_t cu_mask_count;
-	uint32_t cu_flags;
-	bool is_user_cu_masked;
-};
-
-struct amdgpu_mqd {
-	unsigned mqd_size;
-	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
-			struct amdgpu_mqd_prop *p);
-};
-
 struct amdgpu_pcie_reset_ctx {
 	bool in_link_reset;
 	bool occurs_dpc;
@@ -1050,14 +1012,6 @@ struct amdgpu_device {
 	struct amdgpu_kfd_dev		kfd;
 };
 
-/*
- * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
- * as fence address and writes a 32 bit fence value to this address.
- * Driver needs to allocate at least 4 DWs extra memory in addition to
- * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
- */
-#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
-
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5255360353f4..7b4cfb5c8f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
 			      struct mes_inv_tlbs_pasid_input *input);
 };
 
+enum amdgpu_mqd_update_flag {
+	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
+struct amdgpu_mqd_prop {
+	uint64_t mqd_gpu_addr;
+	uint64_t hqd_base_gpu_addr;
+	uint64_t rptr_gpu_addr;
+	uint64_t wptr_gpu_addr;
+	uint32_t queue_size;
+	bool use_doorbell;
+	uint32_t doorbell_index;
+	uint64_t eop_gpu_addr;
+	uint32_t hqd_pipe_priority;
+	uint32_t hqd_queue_priority;
+	uint32_t mqd_stride_size;
+	bool allow_tunneling;
+	bool hqd_active;
+	uint64_t shadow_addr;
+	uint64_t gds_bkup_addr;
+	uint64_t csa_addr;
+	uint64_t fence_address;
+	bool tmz_queue;
+	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
+};
+
+struct amdgpu_mqd {
+	unsigned mqd_size;
+	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
+			struct amdgpu_mqd_prop *p);
+};
+
+/*
+ * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
+ * as fence address and writes a 32 bit fence value to this address.
+ * Driver needs to allocate at least 4 DWs extra memory in addition to
+ * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
+ */
+#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
+
 #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
 	(adev)->mes.kiq_hw_init((adev), (xcc_id))
 #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
-- 
2.54.0

