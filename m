Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF510C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 03:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8C410F798;
	Wed, 27 Mar 2024 03:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z89W3DO0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9719510F798
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 03:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2QGJU5d9OvReV7kWkC7NmZ6CBDJeWGZEl6qvtA1BluTd6ufFQfjnuNgpmJDTB3oBepcm+xFFDdx/a+1GEsRoaq4g5Al8nHzCvTpFwlp5hhwTBdzwXfOfF+QlObi1yXOYAJqZDKqan4TX/rhVm4LdriuLKfC7v420/64D3ghKD9UQXkxBh9a9sSrR9GR9rMhoucfTvwthHxmbg2nwri41iGywHe4UH94Rx0v2tYJW78TPfLT7W631RlzzZeWZrtcMQ06P/kUVS7qOzBTpwUkGedNbHsoZ7dRzjkc6iR2wLYcgx54i/apkgIryYqOfRH14UcOckTfste6fZknAPOIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piIaLsiNsyyuXIYx/ooqu67Rwn17KdU1zEzzBhoPY8I=;
 b=AkIRwJ+k/UFZZQzABYKs+OKH8Yku8tlkbQeNCYiirhZJuAnW7jIdnPYg2FQJC/cT8FgckqdlNhtdfxs29ppb5OKGxOvui6iVlRWcJGm4Gaatyxbj0Kaghx02cji/KDDLRE9/ou28kwrn0s7f1IDWLDXEPHp+Nui9k9mP136st9BCLpGgRV1K22/fxqxQ+GfE/GOUnrozxoLP4xzyFm04mXWlO3IhDPwV1XDmoFGdAUHRRTcNFkdl2ZbO/zihJIGxPfDdluFyRfh33p2ShLBAnsNxwXrYVukI2i2iAFlLUe/q5Q1aaoM27/xgkfRdcn4XTOfS+svl+rLo9Wicffg1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piIaLsiNsyyuXIYx/ooqu67Rwn17KdU1zEzzBhoPY8I=;
 b=z89W3DO01ArCHleWu/6MTvDfeLC4QPjT3kAAqf/2GLI7yX5nCFeZUU/14xS8rPWAWjsvn1xSVPMpj3M99hREmQlWi99aouy60HhH4Jp5rLa5l7LmeEXUhgtZvjGpuhay38/Ju63Hhyu7vPpoMQsvElcgdrl8yrKpgUTzvTkcxbY=
Received: from CH2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:610:5b::22)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 03:53:45 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::5) by CH2PR07CA0048.outlook.office365.com
 (2603:10b6:610:5b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 27 Mar 2024 03:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 03:53:44 +0000
Received: from alan-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 22:53:42 -0500
From: chongli2 <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jingwech@amd.com>, chongli2 <chongli2@amd.com>
Subject: [PATCH v1] drm/amd/amdgpu: support MES command SET_HW_RESOURCE1 in
 sriov
Date: Wed, 27 Mar 2024 11:52:10 +0800
Message-ID: <20240327035210.3985-2-chongli2@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327035210.3985-1-chongli2@amd.com>
References: <20240327035210.3985-1-chongli2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d4c1d4-4653-4c0d-d4e3-08dc4e117fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go1ZGK1GIJWK6cy4Y9rhTc2wbQN+638MLN/umteiLCC4HIy19tRbuaMw3zKEt/8HkAOwOrJWtaSMLH+L/EIfn9LSYKlM7fJe1hh4j3bDE+SmZiNw6Q6Whjx6YZ0mXhDvkqgn/vxQQecnbC5dRcbkCJ0D+7PCUiSJ3gVcxovmDleryFGnfzBgLpIepaSwhgWJprPsvLj+k9OTB/RpYSLEwR5Ek/5AQQxIu8JaV/Uz6eFE8FsVRE8EwpcSZoC71O2oHOX/lugnRO8ql/nku9CBMS9EYlGv9R1ZBnUc9E2T+uN4/R+wq1wLQUC6D/zzoiiOM+bnbzxkWooxK0w/8jZNf5GxDmjPA6k9PEwgn9s6hrOCXX5KQ7rtWBDsrwAasyo1Ajlxi6oHjW5pV2VDcusOSrnc0kQga4/6bw4ckQPywVaA3dbReYPaAtSjBqXUk2bjiLfyk2JgE2ylwCuPkiSnKdiEU2P6pH3CmV3sf2dyysvlgD32mcp+8jlEFpXp7BcvRjqRVhnW88Es5g9ThGrrIEBtFb1b0KI6fBKIUsKVcM17WiazLfI6F0hByx9x4Xdoz/Prtw9xTJdEu4nhH8x8HdtKmSRldi04RwnlxKxMXbOvC7oGRA/UDSejKJHNjAzvT1vV2ydPkrlbw87vhtiMmksyDNFR5i0h7Fuhb+BI7j7Et67Uv2JMZ5uVeVMetsNfYkex5djCR7l+12EK57VksxS9eoQ43/g+zcmF0C/ZnnKJsn+VSBtdRAJL71wtybEZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 03:53:44.3897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d4c1d4-4653-4c0d-d4e3-08dc4e117fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

	support MES command SET_HW_RESOURCE1 in sriov

Signed-off-by: chongli2 <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  9 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 21 +++++++++
 6 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7d4f93fea937..3774148f3e5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -140,6 +140,12 @@ struct amdgpu_mes {
 
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
+
+	/* mes resource_1 bo*/
+	struct amdgpu_bo    *resource_1;
+	uint64_t            resource_1_gpu_addr;
+	void                *resource_1_addr;
+
 };
 
 struct amdgpu_mes_process {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index aed60aaf1a55..52f01efde2fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -576,6 +576,11 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->decode_usage = 0;
 
 	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
+	vf2pf_info->mes_info_addr = (uint64_t)adev->mes.resource_1_gpu_addr;
+
+	if (adev->mes.resource_1) {
+		vf2pf_info->mes_info_size = adev->mes.resource_1->tbo.base.size;
+	}
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
 		vf2pf_info, vf2pf_info->header.size, 0, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a858bc98cad4..a9f2f0c4f799 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -132,6 +132,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_AV1_SUPPORT = (1 << 6),
 	/* VCN RB decouple */
 	AMDGIM_FEATURE_VCN_RB_DECOUPLE = (1 << 7),
+	/* MES info */
+	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -335,6 +337,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
 #define amdgpu_sriov_is_vcn_rb_decouple(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
+#define amdgpu_sriov_is_mes_info_enable(adev) \
+	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 51a14f6d93bd..0de78d6a83fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -94,7 +94,8 @@ union amd_sriov_msg_feature_flags {
 		uint32_t reg_indirect_acc  : 1;
 		uint32_t av1_support       : 1;
 		uint32_t vcn_rb_decouple   : 1;
-		uint32_t reserved          : 24;
+		uint32_t mes_info_enable   : 1;
+		uint32_t reserved          : 23;
 	} flags;
 	uint32_t all;
 };
@@ -221,7 +222,7 @@ struct amd_sriov_msg_vf2pf_info_header {
 	uint32_t reserved[2];
 };
 
-#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (70)
+#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (73)
 struct amd_sriov_msg_vf2pf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
@@ -265,7 +266,9 @@ struct amd_sriov_msg_vf2pf_info {
 		uint32_t version;
 	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
-
+	/* FB allocated for guest MES to record UQ info */
+	uint64_t mes_info_addr;
+	uint32_t mes_info_size;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 072c478665ad..78ec170cfeef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -419,6 +419,36 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
 
+static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
+{
+	int size = 128 * PAGE_SIZE;
+	int ret = 0;
+	struct amdgpu_device *adev = mes->adev;
+	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
+	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
+
+	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
+	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&mes->resource_1,
+				&mes->resource_1_gpu_addr,
+				&mes->resource_1_addr);
+	if (ret) {
+		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
+		return ret;
+	}
+
+	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
+	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1200,6 +1230,14 @@ static int mes_v11_0_hw_init(void *handle)
 	if (r)
 		goto failure;
 
+	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+		r = mes_v11_0_set_hw_resources_1(&adev->mes);
+		if (r) {
+			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
+			goto failure;
+		}
+	}
+
 	r = mes_v11_0_query_sched_status(&adev->mes);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
@@ -1223,6 +1261,11 @@ static int mes_v11_0_hw_init(void *handle)
 
 static int mes_v11_0_hw_fini(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
+					&adev->mes.resource_1_addr);
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index ec5b9ab67c5e..410c8d664336 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -61,6 +61,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_MISC			= 14,
 	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE      = 15,
 	MES_SCH_API_AMD_LOG                     = 16,
+	MES_SCH_API_SET_HW_RSRC_1               = 19,
 	MES_SCH_API_MAX				= 0xFF
 };
 
@@ -238,6 +239,26 @@ union MESAPI_SET_HW_RESOURCES {
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
+union MESAPI_SET_HW_RESOURCES_1 {
+	struct {
+		union MES_API_HEADER				header;
+		struct MES_API_STATUS			   api_status;
+		uint64_t							timestamp;
+		union {
+			struct {
+				uint32_t enable_mes_info_ctx : 1;
+				uint32_t reserved : 31;
+			};
+			uint32_t uint32_all;
+		};
+		uint64_t							mes_info_ctx_mc_addr;
+		uint32_t							mes_info_ctx_size;
+		uint32_t							mes_kiq_unmap_timeout; // unit is 100ms
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
 union MESAPI__ADD_QUEUE {
 	struct {
 		union MES_API_HEADER		header;
-- 
2.43.2

