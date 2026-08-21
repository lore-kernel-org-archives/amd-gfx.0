Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FE2C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4617C10F359;
	Fri, 21 Aug 2026 16:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfIbXorH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0483C10F351
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9Bt/2zKtIKS/V7g4FJxCYXPjRboSbPdYHklYCE6TCM0T50HqHfEPnAp8miJxtz5pC58ka2Xe5fXLY5ztkySZKDrLdhj5PWwV+sEL9DiOngzQdZ06ffsC08KMQLQqwkdQ4cMpi1/ddfXLmsy790dK+/+HSPjjlkXVKgXBge5JANIJSD/smzAzb1AxUNhwHdTLnb7OxxOE+o+XGrY7pW7GQWETEr0oyPm1qEHgHZ2oorSIsohldM27QfUe+dGp5hUCp5LterTFHFB5Pw+EEUmI0ePXYJqM1i5LE8YXteKYQroB825I7tx0OoEWEkKEjvXgl9BZSAAl07Yio8Twptzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhbEeNtiAp9+J5TmwdL5jXLvlxYTO5irp1226xbW808=;
 b=ULGiszDN9AXCNrTiBWzpoSWvHwVmX4PBx/jeX+vzEODcgYnuWRlN6J2hmb0uqDt/JTSZe4ZeQjyk5ozMLKw2oAVGcUGBTfruP/C14zRFeAee7J04//R6qMCFQZNZH6mxXTroQvuXbJHI5nUwNMBVmarZ4wqdpoY0+/e0gM1O7beAPB4il9JI7xDkFoFR+mAl9sT05uhQ13B0lZZ7FoOhkMoU8mKx22rFSMeboxC0uW0rI8V/Qtbl1o/esGUDo5+1F+c4HY+kHeFYLvoOaLAV60fvo+2Vv3v65D4Jyh8CRHuj7gVDxHPkT0qxtWWFJeN+DqEPopDzISP2DUvj2jrx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhbEeNtiAp9+J5TmwdL5jXLvlxYTO5irp1226xbW808=;
 b=tfIbXorHwKnPZ9OsU33a0pTuxWY21pV6EFQ3OB804WAK6LM+MevJ1xcTBvNQS5k7Y33YQt5V0nn+SJdt0YIzIFC0RqLCvaqGAEpN72ZjfNeTp0RVRPm6Eer6PJo94vYpiDTJA6QKFG7AydPl/qwz0MbncbbMNXMrgDPwOr0L0vc=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by CHXPR12MB999221.namprd12.prod.outlook.com (2603:10b6:610:2fa::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:07:27 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::92) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 06/15] drm/amdgpu: Add gc_info_v1_5 table for soc_v1_0
Date: Fri, 21 Aug 2026 12:07:01 -0400
Message-ID: <20260821160710.752459-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|CHXPR12MB999221:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc04a5b-decf-44a8-a693-08deff9e4bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gYsiQTobGBgj/nAgzaQtyxxD3tX1skwvOCh/8NI7WQPyuVXUUiCYW8Ntq823+9pk+3g1aAO9pjqGHzuyZCXaU4eeJLg3pJkLbbr5wfMPO+ueDsyc5lYb2tIgp7l6ztWPQ6061fT0VTGd9PEgXCoX/5a1U++QliHxgdx/r3JLpQJe5SyGwnF08Y87T4KwMS79358v/moSOXwrqMOrEuTTZ+/gQpqshtJK8tGbPr0vrzfkTff1NpP5ngmjxghAQrA9K3ZItKsohgF+bPsdviVjRSfPUPrYGGRzB01+rRbFCWiiQrdmmm8zD4yFMnb9xUHWUC+3B/aBw9DrAmGrXUoyW4CltEkEsfmhvXd6RSiBSOXpNbBJc+fdPemBSeZHeDBTCr40chP/w723Fuz0B8gEAE8HuYifgPYyYTi37X2s4ReEul/Ahvs5A3cqbyWIC52Df1fRLEYz7Hj7Ec5ksSEl/blY8h5c4K8ofugGykp5IYds8uJgILeQZO6e+zCsLJYdKOVlqpNJjwteYTHyUVIgm7zpXsmn/JHZ48FFYIL/DbIWjC1e3dAWTY2M8ymTFtTDs2lg9Ty7ZDKn8GWBHu/qNe0qHHFLcguMG2YYKPqxdxgJwQaUU+GiUanSV4Ti/Oh2jm8bVB6WDwMgDFP0oIFk2GrclSisCFrEmCXfPD5pnwI+mJm9WN7dxCGDQGyqb7VyRSM+NoF1mz5vOF6kko0T4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PKJp9mrjLaNHydNpRiMW3EJbhmO8rjRJbmMN9Wz+7or2eZ3tz2VPj8G21YPKW6MgW6znXULS71xQbl634Wd02PDLzhtIvU7W1qEDw9GlbhJsu/e9SLFi7/MrLY6/ikgWBkzTpSgJRtVlkr4RkHKaVl0ELmeBiPIpOKPcZvcRulQ7L+TiigHXIAJdxxkx+agiBBBh4pDQgafBU7DiJoBjko9Nb5FjYf1VKWWeskNYi0hq7MjYbzR1oa+8bquhxO2JBKoASv85AJI7MRax7sdCZqJxJgwXnLp47wU/LXGOb4g9ctK5y/q+abFHvD73UeUYZUWfNKSpVleehKzWAYWlYES8UyJWiUnmajVFda/rOVv80IDq0dtO29nwujKfpPq0+l/89alu81PnD580ALS2BXFVOlN32uRlWiMUVBk79cb0wxiuEKh1VM3Z1qh3isgw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:27.2546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc04a5b-decf-44a8-a693-08deff9e4bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999221
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

Initialize amdgpu_gfx_config using values from
gc_info_v1_5.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   3 +
 drivers/gpu/drm/amd/include/discovery.h       | 125 ++++++++++++------
 3 files changed, 109 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 836a412fcdc2d..b567860aa555a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1987,6 +1987,7 @@ union gc_info {
 	struct gc_info_v1_1 v1_1;
 	struct gc_info_v1_2 v1_2;
 	struct gc_info_v1_3 v1_3;
+	struct gc_info_v1_5 v1_5;
 	struct gc_info_v2_0 v2;
 	struct gc_info_v2_1 v2_1;
 };
@@ -2016,7 +2017,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	case 1:
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v1.gc_num_se);
 		adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
-						      le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa));
+					      le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa));
 		adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
 		adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v1.gc_num_rb_per_se);
 		adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v1.gc_num_gl2c);
@@ -2057,6 +2058,24 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 			adev->gfx.config.gc_tcc_size = le32_to_cpu(gc_info->v1_3.gc_tcc_size);
 			adev->gfx.config.gc_tcc_cache_line_size = le32_to_cpu(gc_info->v1_3.gc_tcc_cache_line_size);
 		}
+		if (le16_to_cpu(gc_info->v1.header.version_minor) == 4 ||
+		    le16_to_cpu(gc_info->v1.header.version_minor) > 5) {
+			dev_err(adev->dev,
+				"Unsupported GC info table %d.%d\n",
+				le16_to_cpu(gc_info->v1.header.version_major),
+				le16_to_cpu(gc_info->v1.header.version_minor));
+			return -EINVAL;
+		}
+		if (le16_to_cpu(gc_info->v1.header.version_minor) == 5) {
+			adev->gfx.config.gc_max_num_residency_ways = le32_to_cpu(gc_info->v1_5.gc_max_num_residency_ways);
+			adev->gfx.config.gc_cache_ways_size_in_bytes = le32_to_cpu(gc_info->v1_5.gc_cache_ways_size_in_bytes);
+			adev->gfx.config.gc_reserved = le32_to_cpu(gc_info->v1_5.gc_reserved);
+			/* GC info v1.5 derives max_cu_per_sh from the combined SA/SA1 WGP counts. */
+			adev->gfx.config.max_cu_per_sh = le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
+						le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa) +
+						le32_to_cpu(gc_info->v1_5.gc_num_wgp0_per_sa1) +
+						le32_to_cpu(gc_info->v1_5.gc_num_wgp1_per_sa1);
+		}
 		break;
 	case 2:
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v2.gc_num_se);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1023719c18bb6..6722213db8f01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -307,6 +307,9 @@ struct amdgpu_gfx_config {
 	uint32_t gc_scalar_data_cache_size_per_sqc;
 	uint32_t gc_scalar_data_cache_line_size;
 	uint32_t gc_tcc_cache_line_size;
+	uint32_t gc_max_num_residency_ways;
+	uint32_t gc_cache_ways_size_in_bytes;
+	uint32_t gc_reserved;
 };
 
 struct amdgpu_cu_info {
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 76c9f951bc1c8..575705653e957 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -272,45 +272,92 @@ struct gc_info_v1_2 {
 };
 
 struct gc_info_v1_3 {
-    struct gpu_info_header header;
-    uint32_t gc_num_se;
-    uint32_t gc_num_wgp0_per_sa;
-    uint32_t gc_num_wgp1_per_sa;
-    uint32_t gc_num_rb_per_se;
-    uint32_t gc_num_gl2c;
-    uint32_t gc_num_gprs;
-    uint32_t gc_num_max_gs_thds;
-    uint32_t gc_gs_table_depth;
-    uint32_t gc_gsprim_buff_depth;
-    uint32_t gc_parameter_cache_depth;
-    uint32_t gc_double_offchip_lds_buffer;
-    uint32_t gc_wave_size;
-    uint32_t gc_max_waves_per_simd;
-    uint32_t gc_max_scratch_slots_per_cu;
-    uint32_t gc_lds_size;
-    uint32_t gc_num_sc_per_se;
-    uint32_t gc_num_sa_per_se;
-    uint32_t gc_num_packer_per_sc;
-    uint32_t gc_num_gl2a;
-    uint32_t gc_num_tcp_per_sa;
-    uint32_t gc_num_sdp_interface;
-    uint32_t gc_num_tcps;
-    uint32_t gc_num_tcp_per_wpg;
-    uint32_t gc_tcp_l1_size;
-    uint32_t gc_num_sqc_per_wgp;
-    uint32_t gc_l1_instruction_cache_size_per_sqc;
-    uint32_t gc_l1_data_cache_size_per_sqc;
-    uint32_t gc_gl1c_per_sa;
-    uint32_t gc_gl1c_size_per_instance;
-    uint32_t gc_gl2c_per_gpu;
-    uint32_t gc_tcp_size_per_cu;
-    uint32_t gc_tcp_cache_line_size;
-    uint32_t gc_instruction_cache_size_per_sqc;
-    uint32_t gc_instruction_cache_line_size;
-    uint32_t gc_scalar_data_cache_size_per_sqc;
-    uint32_t gc_scalar_data_cache_line_size;
-    uint32_t gc_tcc_size;
-    uint32_t gc_tcc_cache_line_size;
+	struct gpu_info_header header;
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
+	uint32_t gc_num_tcp_per_wpg;
+	uint32_t gc_tcp_l1_size;
+	uint32_t gc_num_sqc_per_wgp;
+	uint32_t gc_l1_instruction_cache_size_per_sqc;
+	uint32_t gc_l1_data_cache_size_per_sqc;
+	uint32_t gc_gl1c_per_sa;
+	uint32_t gc_gl1c_size_per_instance;
+	uint32_t gc_gl2c_per_gpu;
+	uint32_t gc_tcp_size_per_cu;
+	uint32_t gc_tcp_cache_line_size;
+	uint32_t gc_instruction_cache_size_per_sqc;
+	uint32_t gc_instruction_cache_line_size;
+	uint32_t gc_scalar_data_cache_size_per_sqc;
+	uint32_t gc_scalar_data_cache_line_size;
+	uint32_t gc_tcc_size;
+	uint32_t gc_tcc_cache_line_size;
+};
+
+struct gc_info_v1_5 {
+	struct gpu_info_header header;
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
+	uint32_t gc_num_tcp_per_wpg;
+	uint32_t gc_tcp_l1_size;
+	uint32_t gc_num_sqc_per_wgp;
+	uint32_t gc_l1_instruction_cache_size_per_sqc;
+	uint32_t gc_l1_data_cache_size_per_sqc;
+	uint32_t gc_gl1c_per_sa;
+	uint32_t gc_gl1c_size_per_instance;
+	uint32_t gc_gl2c_per_gpu;
+	uint32_t gc_tcp_size_per_cu;
+	uint32_t gc_tcp_cache_line_size;
+	uint32_t gc_instruction_cache_size_per_sqc;
+	uint32_t gc_instruction_cache_line_size;
+	uint32_t gc_scalar_data_cache_size_per_sqc;
+	uint32_t gc_scalar_data_cache_line_size;
+	uint32_t gc_tcc_size;
+	uint32_t gc_tcc_cache_line_size;
+	uint32_t gc_num_wgp0_per_sa1;
+	uint32_t gc_num_wgp1_per_sa1;
+	uint32_t gc_max_num_residency_ways;
+	uint32_t gc_cache_ways_size_in_bytes;
+	uint32_t gc_reserved;
 };
 
 struct gc_info_v2_0 {
-- 
2.55.0

