Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D6CC982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A327410EAC5;
	Mon, 21 Sep 2026 20:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XFXD2ads";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A5F10EAEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQGHiPrkiIc/B0gH/NqgTUdQPviH1boCvqbXdHZWCzCOIv5ej+TCPLTC9rryvkP83XdvLiFe7mmeyrAMhpq1dPd4QSjt8J4GaPNfbddiFBxP99SOrJjEFvlS5dcMkbJAr7WUFeVwcKnmNGPMMjo4Yi8Zh3nTYYokcWeK0JpLvSpIBHGPxqeJeYICpqmGYgutEs6VFf40v+mCLZJZpd0Cqc2RQy73zNWNfVg4XXEGPU6lCMxz9ltRhtGlSZYoBaSVLpWd/QhH7RGsbMyJPSAL7zEoz82lNHSQsPOGYjzjlMK9Od/8ybCjq2FqjQJz3cddDKCbOaA8oKHrE+62ex5p7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EL+DqKRtdguIGepMPHrVgBe1wS4FUKwUkrBkpRDeho=;
 b=RZeoaCZetSoGhcjiZ9aQr3H9OC/OagLT47Uhj4abFIHL0lTwUF8pLKSjHzsIz6lhRicvfN7G2KvOlmkybXx1x/TJKAqZlf689JkcQt7b0e5TgVFG+k9MYHlxtWOaVy42ucRSeR5s8wUfa5f2e0bS1oPnJfmKRyrZU9ydnKesJsP7MhIY95R/p+ZaZ5uI7ngKa6vG+TF8TEWGmmPChG4NqkKcaGWzE85Dh+KhZAgPmkB5HRqVp1+sDAjct0cpawtd8FIDx2HnHANOjM9NfMsnoaqqb7BVF6XV1nNEPGmx1zuGQuXKZ1UZzcvNhEqeVH1JjRMe4B5NmFJoywLOIVrEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EL+DqKRtdguIGepMPHrVgBe1wS4FUKwUkrBkpRDeho=;
 b=XFXD2adsgqr8F03jAUXiIWUtn84PbgfICeUmmM3kp85Xgvk2tEC7uLHGxC3er7qYy736Q06bsLdngtUP95451ukzuR94SbU6jQG9fM/43aYjOQvzx6F/E4gqjWsdkdHBiRsxDMmXU2JcfAsffuBdyDajrwNclDKnZKDSTZK3Y8I=
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:10:41 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::3e) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add gc_info_v1_4 table support
Date: Mon, 21 Sep 2026 16:10:23 -0400
Message-ID: <20260921201026.2019083-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201026.2019083-1-alexander.deucher@amd.com>
References: <20260921201026.2019083-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 406e0e0a-d261-4c4d-8342-08df181c6956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|11063799006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JD//m9fyDnuSyikdcDyxX+qsCCRxauwO7MdfUjtm08MHbM3F9jKRaJxYWk3j2NU5+nhsN5xNWbm9+A86pILHWxabHjFGWYmw2M+gV+QRq7LbXshtUyevRJJH9F7KKS+I9fLT6MKMvOU3xflvqsBytQ8jq1TeWgjiUzKuFatidhEHS3GH5e1OxwwvU4iBdMdGmZQvxYQi+SUfplVrujrNbuApO+iOMtVv8MxtXGcHzMrM7nXXv+CXHD9PkkCUcoOjr0ASvtM4B+FMrANui01WI9yNTCNTpaNErtvtYjlY8cQ5JmmV4EpPmIomkgSLAhP76c+bysP1RaOmVbhIdV4a/J/YrIrqWv46KsQbi1tMTnEt6voTnriAZK6HpllGcfQCas3029/cJbH4tpavFd7hy5CdZFfEUu+HSHZs5MHTiTKuY/6DKVOxjz6cn1JhVB4BWUhKYpiT1yl0FzCfF0mx3bnUseJSYc2bNKGHCOv2I6vh55b3JU5HXsfg0jcO4qf6HOzShDx6MMpqiBiRB/Ynq3RSCcxyUrMiHeYF53Wv54zf1XaWKnxqSwDSc0kr7o6gam3VKmhZ72dwrLNp0FR7VMkYQ6rXnfc9jDOMF9qn8Uqlp3MxHE+ZXt2/gUvOXYe1XJE3l8N4ogAO8O8gCMMmOL09ICJOA7U8W4z3dXKN+Irr4biAebkzL14uztKxb9Y5MbC3JiMAgjUOrFF9p6oYlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LkJpt6+Lwxtfj0knG72vxOv25HAA+YZLYPqPZGYMz0bTPS58jCGuRnBKHsCB/hJ0OOgoKetbyVeSlIvuNuF4JAwhD0erTvK0zPOnIVid4I0MN8ojO5GrKi9cnDq0cDMbWQ+xAEByWtCng8xb5uVfdfQPs5M7JSl8H9v0IurQh5ZtGKsL0oBDct+Z+A1QsKab8mispAZLHSmLZlaQ8CpBTPthSaW0XRqeoKXdQeLEgK8p/O7i16+oHqXowFXVRXRrHzsRqSd/P2RYN6KLMbD5OMKw/RH0nQM5TOKP1YU4p/eQkMbbyQtch4B9uuc6GVET4T59H8krlin68UEKqbMlsdXTM8htkRrx5aLs9CtbQvTU+hIflDis/kKDPmzy4W8NI5xc2up3Vy6+t1B55pFRhLA8zVc2BAnOYTikhkm8S4PI9OBiJNIBx//Ap3jBWyKA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:41.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406e0e0a-d261-4c4d-8342-08df181c6956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
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

From: Likun Gao <Likun.Gao@amd.com>

Initialize amdgpu_gfx_config using values from
gc_info_v1_4.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 22 ++++++----
 drivers/gpu/drm/amd/include/discovery.h       | 42 +++++++++++++++++++
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1420bb60e015e..9a04e681a0cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2056,6 +2056,7 @@ union gc_info {
 	struct gc_info_v1_1 v1_1;
 	struct gc_info_v1_2 v1_2;
 	struct gc_info_v1_3 v1_3;
+	struct gc_info_v1_4 v1_4;
 	struct gc_info_v1_5 v1_5;
 	struct gc_info_v2_0 v2;
 	struct gc_info_v2_1 v2_1;
@@ -2118,7 +2119,18 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 			adev->gfx.config.gc_gl1c_size_per_instance = le32_to_cpu(gc_info->v1_2.gc_gl1c_size_per_instance);
 			adev->gfx.config.gc_gl2c_per_gpu = le32_to_cpu(gc_info->v1_2.gc_gl2c_per_gpu);
 		}
-		if (le16_to_cpu(gc_info->v1.header.version_minor) >= 3) {
+		if (le16_to_cpu(gc_info->v1.header.version_minor) == 4) {
+			num_wgps_per_sa = le32_to_cpu(gc_info->v1_4.gc_num_rwgp0_per_sa) +
+					  le32_to_cpu(gc_info->v1_4.gc_num_rwgp1_per_sa) +
+					  le32_to_cpu(gc_info->v1_4.gc_num_twgp0_per_sa) +
+					  le32_to_cpu(gc_info->v1_4.gc_num_twgp1_per_sa);
+			num_wgps_per_sa1 = le32_to_cpu(gc_info->v1_4.gc_num_rwgp0_per_sa1) +
+					   le32_to_cpu(gc_info->v1_4.gc_num_rwgp1_per_sa1) +
+					   le32_to_cpu(gc_info->v1_4.gc_num_twgp0_per_sa1) +
+					   le32_to_cpu(gc_info->v1_4.gc_num_twgp1_per_sa1);
+			adev->gfx.config.max_cu_per_sh = 2 * (num_wgps_per_sa >= num_wgps_per_sa1 ?
+							      num_wgps_per_sa : num_wgps_per_sa1);
+		} else if (le16_to_cpu(gc_info->v1.header.version_minor) >= 3) {
 			adev->gfx.config.gc_tcp_size_per_cu = le32_to_cpu(gc_info->v1_3.gc_tcp_size_per_cu);
 			adev->gfx.config.gc_tcp_cache_line_size = le32_to_cpu(gc_info->v1_3.gc_tcp_cache_line_size);
 			adev->gfx.config.gc_instruction_cache_size_per_sqc = le32_to_cpu(gc_info->v1_3.gc_instruction_cache_size_per_sqc);
@@ -2128,14 +2140,6 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 			adev->gfx.config.gc_tcc_size = le32_to_cpu(gc_info->v1_3.gc_tcc_size);
 			adev->gfx.config.gc_tcc_cache_line_size = le32_to_cpu(gc_info->v1_3.gc_tcc_cache_line_size);
 		}
-		if (le16_to_cpu(gc_info->v1.header.version_minor) == 4 ||
-		    le16_to_cpu(gc_info->v1.header.version_minor) > 5) {
-			dev_err(adev->dev,
-				"Unsupported GC info table %d.%d\n",
-				le16_to_cpu(gc_info->v1.header.version_major),
-				le16_to_cpu(gc_info->v1.header.version_minor));
-			return -EINVAL;
-		}
 		if (le16_to_cpu(gc_info->v1.header.version_minor) == 5) {
 			adev->gfx.config.gc_max_num_residency_ways = le32_to_cpu(gc_info->v1_5.gc_max_num_residency_ways);
 			adev->gfx.config.gc_cache_ways_size_in_bytes = le32_to_cpu(gc_info->v1_5.gc_cache_ways_size_in_bytes);
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 07199c6abc73a..f5629a4ad04a1 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -319,6 +319,48 @@ struct gc_info_v1_3 {
 	uint32_t gc_tcc_cache_line_size;
 };
 
+struct gc_info_v1_4 {
+    struct gpu_info_header header;
+    uint32_t gc_num_se;
+    uint32_t gc_num_wgp0_per_sa;
+    uint32_t gc_num_wgp1_per_sa;
+    uint32_t gc_num_rb_per_se;
+    uint32_t gc_num_gl2c;
+    uint32_t gc_num_gprs;
+    uint32_t gc_num_max_gs_thds;
+    uint32_t gc_gs_table_depth;
+    uint32_t gc_gsprim_buff_depth;
+    uint32_t gc_parameter_cache_depth;
+    uint32_t gc_double_offchip_lds_buffer;
+    uint32_t gc_wave_size;
+    uint32_t gc_max_waves_per_simd;
+    uint32_t gc_max_scratch_slots_per_cu;
+    uint32_t gc_lds_size;
+    uint32_t gc_num_sc_per_se;
+    uint32_t gc_num_sa_per_se;
+    uint32_t gc_num_packer_per_sc;
+    uint32_t gc_num_gl2a;
+    uint32_t gc_num_tcp_per_sa;
+    uint32_t gc_num_sdp_interface;
+    uint32_t gc_num_tcps;
+    uint32_t gc_num_tcp_per_wpg;
+    uint32_t gc_tcp_l1_size;
+    uint32_t gc_num_sqc_per_wgp;
+    uint32_t gc_l1_instruction_cache_size_per_sqc;
+    uint32_t gc_l1_data_cache_size_per_sqc;
+    uint32_t gc_gl1c_per_sa;
+    uint32_t gc_gl1c_size_per_instance;
+    uint32_t gc_gl2c_per_gpu;
+    uint32_t gc_num_rwgp0_per_sa;
+    uint32_t gc_num_rwgp0_per_sa1;
+    uint32_t gc_num_rwgp1_per_sa;
+    uint32_t gc_num_rwgp1_per_sa1;
+    uint32_t gc_num_twgp0_per_sa;
+    uint32_t gc_num_twgp0_per_sa1;
+    uint32_t gc_num_twgp1_per_sa;
+    uint32_t gc_num_twgp1_per_sa1;
+};
+
 struct gc_info_v1_5 {
 	struct gpu_info_header header;
 	uint32_t gc_num_se;
-- 
2.55.0

