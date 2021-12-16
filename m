Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255A5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 03:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA97810FD2A;
	Thu, 16 Dec 2021 03:18:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343F810FD2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 03:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoXWfeKy3QFM7iXqaM8y9KBW+eo1NZg973gUXEGwda47lr8vp0mN9fYSejXcdvh+KLhBcCayGiK/qFl+W9em/POjzseSRTQP5XKf5WGu0b12cGnU07BEKAvyWiyMpHW5uKN9Hv0z569x5xJABx3NHhOpgtmum4xJ16dBxoZOMemtAySP9cMqAg14Cy2Ri6urdQbx5btAFeofMVbhByjsvKdedkS+i21jfQIs0uRJe2AxjcgIoZqODaRBztBJoFLhnFkt50qujarNqTzPf5RmM/CZUvU1FE6EQT+Akqkfq7WOJQXCJ03WvWokNkB5nopJtQ893Yad/FaYb3/sA51Vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87/maubLcElkOVtE+n3Yv6Qb2j6hAfd1MpYUagwurCI=;
 b=fmPh+xEUboUElLvtZ1XS2ELbkl+HFxwL4FY6LKlGIM6XPiiTwthb70owDxhXHkuqFymBLrNSEz9SuhT5IGWxIAopJHJUpxse565TynbL1DwA2jtT+84mmuE06hgPDdRX6S4AEn3mcZBF1664iymSGbqiEB55hGdCvKd0Js2mG5AU+QSBGVEFtEJCVbis+WhB6SgyTxkr+adVHz/Hp7ByUJeMxCH9QLAzUbm6BqDh463Z6NmFzUcvKPco/woQ71GNrYZ9QxNRBP0Uqbdzr7hVKXW31airjcZLDppNu/rZ8O25xIYOeQS6dpn+e4YR4BR3LHOCfbo5tyapmkK4PMS8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87/maubLcElkOVtE+n3Yv6Qb2j6hAfd1MpYUagwurCI=;
 b=Fu5VbP+7eu65vPQGBMrCxLg2UQXv1umEbiLUs1wr0JQMOJ5f9ybpxrdv43Vgh7owuAg4fhX9/8kMA41/+uH87svklDoMvAu8fhvEwWNnFgrA0bMat7XliPUOLP6ENhGOIFFVx46NPgz/hSAaa4kq+3bLtDwgRLDUtVXh5mK7TC4=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 03:18:13 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::5f) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 03:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Thu, 16 Dec 2021 03:18:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 21:18:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for IP discovery gc_info table v2
Date: Wed, 15 Dec 2021 22:17:58 -0500
Message-ID: <20211216031758.177296-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9285d4c3-f14f-4a1d-8930-08d9c042b1b5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31891F7FF2DE5FCAD7AD970BF7779@BYAPR12MB3189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jd87x0Lsti4RO5zF9N5S2rZC18KpuYlK0x6Ie6t1uNZEVQiqETxnj2pRkDJooxRqF5Ot/gK9EoNfMGiIDV8ouGwF3uQfpoClmMFn5OxNXEEWMG3L41tt7gU574AJ0pG+NzrnKb7kGxT2cSXrBG3uEuLWZAP3BQGA24YFpPhfXZ2X3KXgQFTSs0MUzGXFa40siMdriz8LqCxJMA12nnTd+b1Dh+HnTsTS32s2keT850wn+k+gIWz1iv1bXpqJqLlHnRqU2wbtILnCmEMJ010VHieU0+3xhH/G5hVBRq1DKPiK4krG6RUdKZXKNrAR1i3rvFHKdHa4v570iWgmKP2iV03EkUgh2ImvSjLMxVf6+WfTQnTWDjwbGBPCazGUwyyxMojKtE5jkzLoUQaybFHkxwGfCfF7AxkBnTOGlDguPHmxid/0XB5liCrSfXHnwVR1BZoHYNEbczTZDKMGbL0h50UmbF+rOe3N0uXzDce3ijD02Om6CyW0bq4TMSWqnou9U6qdCCG+yY3qARDHwdeSmy1exIn4sntBghPKgXZX9mr6YNJX7wdGbewbS+iU0S/7inonlG01l/Dp7fyso2z6a6EjhzVYSz3XtWYf0gqepT8wIctDnmHh8spEXbKuCnxsB7hxKYA9Bk/DiWQWmamNEhuiNys5DT4cgXYH8AGDMgaTVEdh1Z3GiOoFsOQm0qgFgfMZQ8Y8fZaCT+SaA7eunJl2yf1hokrU606WLpR8Rm3OKBpPDszf7Rw679gO6bi/B8Zsay2KdmjcIs0KecdzgHG1C5OFI6Ya9r8s9N/PGa4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(83380400001)(81166007)(356005)(7696005)(316002)(40460700001)(8676002)(8936002)(426003)(36860700001)(2906002)(47076005)(6666004)(26005)(70206006)(36756003)(6916009)(86362001)(966005)(508600001)(2616005)(5660300002)(186003)(4326008)(82310400004)(16526019)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 03:18:13.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9285d4c3-f14f-4a1d-8930-08d9c042b1b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used on gfx9 based systems. Fixes incorrect CU counts reported
in the kernel log.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1833
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 76 +++++++++++++------
 drivers/gpu/drm/amd/include/discovery.h       | 49 ++++++++++++
 2 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ea00090b3fb3..bcc9343353b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -526,10 +526,15 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	}
 }
 
+union gc_info {
+	struct gc_info_v1_0 v1;
+	struct gc_info_v2_0 v2;
+};
+
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
-	struct gc_info_v1_0 *gc_info;
+	union gc_info *gc_info;
 
 	if (!adev->mman.discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
@@ -537,28 +542,55 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	gc_info = (struct gc_info_v1_0 *)(adev->mman.discovery_bin +
+	gc_info = (union gc_info *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[GC].offset));
-
-	adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->gc_num_se);
-	adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->gc_num_wgp0_per_sa) +
-					      le32_to_cpu(gc_info->gc_num_wgp1_per_sa));
-	adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->gc_num_sa_per_se);
-	adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->gc_num_rb_per_se);
-	adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->gc_num_gl2c);
-	adev->gfx.config.max_gprs = le32_to_cpu(gc_info->gc_num_gprs);
-	adev->gfx.config.max_gs_threads = le32_to_cpu(gc_info->gc_num_max_gs_thds);
-	adev->gfx.config.gs_vgt_table_depth = le32_to_cpu(gc_info->gc_gs_table_depth);
-	adev->gfx.config.gs_prim_buffer_depth = le32_to_cpu(gc_info->gc_gsprim_buff_depth);
-	adev->gfx.config.double_offchip_lds_buf = le32_to_cpu(gc_info->gc_double_offchip_lds_buffer);
-	adev->gfx.cu_info.wave_front_size = le32_to_cpu(gc_info->gc_wave_size);
-	adev->gfx.cu_info.max_waves_per_simd = le32_to_cpu(gc_info->gc_max_waves_per_simd);
-	adev->gfx.cu_info.max_scratch_slots_per_cu = le32_to_cpu(gc_info->gc_max_scratch_slots_per_cu);
-	adev->gfx.cu_info.lds_size = le32_to_cpu(gc_info->gc_lds_size);
-	adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->gc_num_sc_per_se) /
-					 le32_to_cpu(gc_info->gc_num_sa_per_se);
-	adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->gc_num_packer_per_sc);
-
+	switch (gc_info->v1.header.version_major) {
+	case 1:
+		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v1.gc_num_se);
+		adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
+						      le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa));
+		adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
+		adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v1.gc_num_rb_per_se);
+		adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v1.gc_num_gl2c);
+		adev->gfx.config.max_gprs = le32_to_cpu(gc_info->v1.gc_num_gprs);
+		adev->gfx.config.max_gs_threads = le32_to_cpu(gc_info->v1.gc_num_max_gs_thds);
+		adev->gfx.config.gs_vgt_table_depth = le32_to_cpu(gc_info->v1.gc_gs_table_depth);
+		adev->gfx.config.gs_prim_buffer_depth = le32_to_cpu(gc_info->v1.gc_gsprim_buff_depth);
+		adev->gfx.config.double_offchip_lds_buf = le32_to_cpu(gc_info->v1.gc_double_offchip_lds_buffer);
+		adev->gfx.cu_info.wave_front_size = le32_to_cpu(gc_info->v1.gc_wave_size);
+		adev->gfx.cu_info.max_waves_per_simd = le32_to_cpu(gc_info->v1.gc_max_waves_per_simd);
+		adev->gfx.cu_info.max_scratch_slots_per_cu = le32_to_cpu(gc_info->v1.gc_max_scratch_slots_per_cu);
+		adev->gfx.cu_info.lds_size = le32_to_cpu(gc_info->v1.gc_lds_size);
+		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v1.gc_num_sc_per_se) /
+			le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
+		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v1.gc_num_packer_per_sc);
+		break;
+	case 2:
+		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v2.gc_num_se);
+		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gc_info->v2.gc_num_cu_per_sh);
+		adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
+		adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v2.gc_num_rb_per_se);
+		adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v2.gc_num_tccs);
+		adev->gfx.config.max_gprs = le32_to_cpu(gc_info->v2.gc_num_gprs);
+		adev->gfx.config.max_gs_threads = le32_to_cpu(gc_info->v2.gc_num_max_gs_thds);
+		adev->gfx.config.gs_vgt_table_depth = le32_to_cpu(gc_info->v2.gc_gs_table_depth);
+		adev->gfx.config.gs_prim_buffer_depth = le32_to_cpu(gc_info->v2.gc_gsprim_buff_depth);
+		adev->gfx.config.double_offchip_lds_buf = le32_to_cpu(gc_info->v2.gc_double_offchip_lds_buffer);
+		adev->gfx.cu_info.wave_front_size = le32_to_cpu(gc_info->v2.gc_wave_size);
+		adev->gfx.cu_info.max_waves_per_simd = le32_to_cpu(gc_info->v2.gc_max_waves_per_simd);
+		adev->gfx.cu_info.max_scratch_slots_per_cu = le32_to_cpu(gc_info->v2.gc_max_scratch_slots_per_cu);
+		adev->gfx.cu_info.lds_size = le32_to_cpu(gc_info->v2.gc_lds_size);
+		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v2.gc_num_sc_per_se) /
+			le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
+		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v2.gc_num_packer_per_sc);
+		break;
+	default:
+		dev_err(adev->dev,
+			"Unhandled GC info table %d.%d\n",
+			gc_info->v1.header.version_major,
+			gc_info->v1.header.version_minor);
+		return -EINVAL;
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 7ec4331e67f2..a486769b66c6 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -143,6 +143,55 @@ struct gc_info_v1_0 {
 	uint32_t gc_num_gl2a;
 };
 
+struct gc_info_v1_1 {
+	struct gpu_info_header header;
+
+	uint32_t gc_num_se;
+	uint32_t gc_num_wgp0_per_sa;
+	uint32_t gc_num_wgp1_per_sa;
+	uint32_t gc_num_rb_per_se;
+	uint32_t gc_num_gl2c;
+	uint32_t gc_num_gprs;
+	uint32_t gc_num_max_gs_thds;
+	uint32_t gc_gs_table_depth;
+	uint32_t gc_gsprim_buff_depth;
+	uint32_t gc_parameter_cache_depth;
+	uint32_t gc_double_offchip_lds_buffer;
+	uint32_t gc_wave_size;
+	uint32_t gc_max_waves_per_simd;
+	uint32_t gc_max_scratch_slots_per_cu;
+	uint32_t gc_lds_size;
+	uint32_t gc_num_sc_per_se;
+	uint32_t gc_num_sa_per_se;
+	uint32_t gc_num_packer_per_sc;
+	uint32_t gc_num_gl2a;
+	uint32_t gc_num_tcp_per_sa;
+	uint32_t gc_num_sdp_interface;
+	uint32_t gc_num_tcps;
+};
+
+struct gc_info_v2_0 {
+	struct gpu_info_header header;
+
+	uint32_t gc_num_se;
+	uint32_t gc_num_cu_per_sh;
+	uint32_t gc_num_sh_per_se;
+	uint32_t gc_num_rb_per_se;
+	uint32_t gc_num_tccs;
+	uint32_t gc_num_gprs;
+	uint32_t gc_num_max_gs_thds;
+	uint32_t gc_gs_table_depth;
+	uint32_t gc_gsprim_buff_depth;
+	uint32_t gc_parameter_cache_depth;
+	uint32_t gc_double_offchip_lds_buffer;
+	uint32_t gc_wave_size;
+	uint32_t gc_max_waves_per_simd;
+	uint32_t gc_max_scratch_slots_per_cu;
+	uint32_t gc_lds_size;
+	uint32_t gc_num_sc_per_se;
+	uint32_t gc_num_packer_per_sc;
+};
+
 typedef struct harvest_info_header {
 	uint32_t signature; /* Table Signature */
 	uint32_t version;   /* Table Version */
-- 
2.33.1

