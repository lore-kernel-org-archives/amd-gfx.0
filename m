Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CA8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6D310EC60;
	Tue, 26 Apr 2022 18:29:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A444D10E69D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOnnJ8Q3heoFDfIGBAMu/b6aF0ehBqc4UQ5shsa8GO0tVm2SiYnnqiMhkO3rQhOi753pLOmIJskQDNe8hyNTzWxMeu+pNzQwbTfUACC61ivp0Lf6L7xzMWQi2kuNOFesgxyxor7jKHVUEF/vlU7EI6xND58GATmKKys2rdB8yhaWWwx4a6ay7J7tMd8hPSuJYEaDFepuVCi9J75IwqSWXnlun7QHDfhsztPgCZschhcHRPMcRydCwBpn/XuqJKuvHFJeprUBx7KJB7N2prjRv0r5mBFI11BzquEXXm6WUasCZdO/kApXp2u7hUg8y0cdIPFuhejI0iHo4Z9yeYGZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWW6u9y7G8ksIBmooVxcxN1Z1NSpV5QqetXpESvtNKg=;
 b=mi5sgAsRTpPGOTddmYK7uGG+V/jtYDQnnlvx3QQ5jIL9Y/cZgmwFiQ9OKUOPxF0gLaWs/Ikx8EvyUoQd9zlN4qTpYB86o6idxm+/t5r+ORPT3wRe6ln6AjkZuYbPvqlFzIc56+HzlyZCizZ0ha+ps3lnn4/vmFiwed0tJ05tW441U8M5o0gdvoa5Ng8mRP5RGO1lRWnJvdkPmOe7yJn398CJGCC529qQju7rlTLvOhQxmXEDiqX56zW+Sn/EwQvOYk4jizuXhTiwtKHhc7uCc4XE5yawIGkX8pdAAO6gx6DHrlOMBaqgQ/eVSgRJnCaoe64k+Isa7Il7yZZOr48gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWW6u9y7G8ksIBmooVxcxN1Z1NSpV5QqetXpESvtNKg=;
 b=jpKB2kqNvvPsiiKYu3ahypH1/ath6ADJNKem2BXsDYCLJBMuoSvskOz4f6TecOr1CLaJxtKzsSn1mIA5X6sMGgyqMa+GOau03KgveK+IkNwvCBUB5VTeg5dqNowRI7knVg4NcDAdOSpWXlcTw8aJt947GQmKqr6hd1knF1xiRgs=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by BYAPR12MB3638.namprd12.prod.outlook.com (2603:10b6:a03:dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:29:38 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::aa) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 18:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:29:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:29:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: update gc info from bios table
Date: Tue, 26 Apr 2022 14:29:19 -0400
Message-ID: <20220426182920.3007060-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182920.3007060-1-alexander.deucher@amd.com>
References: <20220426182920.3007060-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2910d9d6-c58d-440d-bd74-08da27b2b885
X-MS-TrafficTypeDiagnostic: BYAPR12MB3638:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3638B1AE47795A4FFD1BFAB4F7FB9@BYAPR12MB3638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ecaq55eMNmNSbaTEppydaIIEqWwLzAVtRGRlqHNpiH+8BjNanvtSJpS/+FxSOawxzyZRge/2pfgLH+8N8zxW0/SZA+4h+S0zWLXS/qRc7BDUW//5InPt/xErwoo9YBtkLIKOmfy+Sv3z5/UF1YiKvi+hxD1vBv2w4tBZTUC7/ZRm3ZdQoY4Oakp90RPvjPLHRwFpj5Snu+TLnjDU1P2eHJRcoS+INU2s6yR/39EZR5NcMwfy0lHk54x2nyomKsIevh+xK0j5MyIYdXC/Cf1PP39GS2sfdZpj4qsnGnCuu5zrgXAoWuItLQ3XF9DBfdQOjya4T/mxzdjYTNMnpYhR8CQUI+7MOyE760wbMzGtkh5SR7BFAtuhEKRSAe+NVzm7JduM5uVTcQbsKFfTR1diZ6RSngnA7jd1zhr0qY8tKmecNaKUuQUvMppAv8eh10NG45QkjaqLE8codU24ItcWXYCvgpBzJFDwKmEZb5/CC0+26UR+PZJZ+deouJ2hBfgt0Jx5iYCy1KZg0hWqhQYjCYaGRC34bWIYSJ7Xa503KUK1vuT8xZNVrOiqhJ8w0w5DLJKgVT/Y5W6RUumyWqRVj70hXaUAwoG56IoWXNB67uL61u/VV8v4Jo4NUKnkicuQRE73qawqE92IrfyY0M2L0dW3pbHFnCFqaHNsSRr0N/gdbutKLo8YEIlhHjCH6U5mtvDvLPuTCMWIr6QLvr3x/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(426003)(16526019)(47076005)(82310400005)(186003)(8676002)(54906003)(6916009)(83380400001)(36756003)(356005)(81166007)(4326008)(40460700003)(36860700001)(6666004)(2616005)(26005)(8936002)(70586007)(5660300002)(70206006)(508600001)(7696005)(1076003)(86362001)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:29:37.8062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910d9d6-c58d-440d-bd74-08da27b2b885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Handle newer gc info tables.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 89 +++++++++++--------
 1 file changed, 53 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6034578cf57f..0900912be72d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -653,6 +653,7 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 union gfx_info {
 	struct atom_gfx_info_v2_4 v24;
 	struct atom_gfx_info_v2_7 v27;
+	struct atom_gfx_info_v3_0 v30;
 };
 
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)
@@ -668,42 +669,58 @@ int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)
 				   &frev, &crev, &data_offset)) {
 		union gfx_info *gfx_info = (union gfx_info *)
 			(mode_info->atom_context->bios + data_offset);
-		switch (crev) {
-		case 4:
-			adev->gfx.config.max_shader_engines = gfx_info->v24.max_shader_engines;
-			adev->gfx.config.max_cu_per_sh = gfx_info->v24.max_cu_per_sh;
-			adev->gfx.config.max_sh_per_se = gfx_info->v24.max_sh_per_se;
-			adev->gfx.config.max_backends_per_se = gfx_info->v24.max_backends_per_se;
-			adev->gfx.config.max_texture_channel_caches = gfx_info->v24.max_texture_channel_caches;
-			adev->gfx.config.max_gprs = le16_to_cpu(gfx_info->v24.gc_num_gprs);
-			adev->gfx.config.max_gs_threads = gfx_info->v24.gc_num_max_gs_thds;
-			adev->gfx.config.gs_vgt_table_depth = gfx_info->v24.gc_gs_table_depth;
-			adev->gfx.config.gs_prim_buffer_depth =
-				le16_to_cpu(gfx_info->v24.gc_gsprim_buff_depth);
-			adev->gfx.config.double_offchip_lds_buf =
-				gfx_info->v24.gc_double_offchip_lds_buffer;
-			adev->gfx.cu_info.wave_front_size = le16_to_cpu(gfx_info->v24.gc_wave_size);
-			adev->gfx.cu_info.max_waves_per_simd = le16_to_cpu(gfx_info->v24.gc_max_waves_per_simd);
-			adev->gfx.cu_info.max_scratch_slots_per_cu = gfx_info->v24.gc_max_scratch_slots_per_cu;
-			adev->gfx.cu_info.lds_size = le16_to_cpu(gfx_info->v24.gc_lds_size);
-			return 0;
-		case 7:
-			adev->gfx.config.max_shader_engines = gfx_info->v27.max_shader_engines;
-			adev->gfx.config.max_cu_per_sh = gfx_info->v27.max_cu_per_sh;
-			adev->gfx.config.max_sh_per_se = gfx_info->v27.max_sh_per_se;
-			adev->gfx.config.max_backends_per_se = gfx_info->v27.max_backends_per_se;
-			adev->gfx.config.max_texture_channel_caches = gfx_info->v27.max_texture_channel_caches;
-			adev->gfx.config.max_gprs = le16_to_cpu(gfx_info->v27.gc_num_gprs);
-			adev->gfx.config.max_gs_threads = gfx_info->v27.gc_num_max_gs_thds;
-			adev->gfx.config.gs_vgt_table_depth = gfx_info->v27.gc_gs_table_depth;
-			adev->gfx.config.gs_prim_buffer_depth = le16_to_cpu(gfx_info->v27.gc_gsprim_buff_depth);
-			adev->gfx.config.double_offchip_lds_buf = gfx_info->v27.gc_double_offchip_lds_buffer;
-			adev->gfx.cu_info.wave_front_size = le16_to_cpu(gfx_info->v27.gc_wave_size);
-			adev->gfx.cu_info.max_waves_per_simd = le16_to_cpu(gfx_info->v27.gc_max_waves_per_simd);
-			adev->gfx.cu_info.max_scratch_slots_per_cu = gfx_info->v27.gc_max_scratch_slots_per_cu;
-			adev->gfx.cu_info.lds_size = le16_to_cpu(gfx_info->v27.gc_lds_size);
-			return 0;
-		default:
+		if (frev == 2) {
+			switch (crev) {
+			case 4:
+				adev->gfx.config.max_shader_engines = gfx_info->v24.max_shader_engines;
+				adev->gfx.config.max_cu_per_sh = gfx_info->v24.max_cu_per_sh;
+				adev->gfx.config.max_sh_per_se = gfx_info->v24.max_sh_per_se;
+				adev->gfx.config.max_backends_per_se = gfx_info->v24.max_backends_per_se;
+				adev->gfx.config.max_texture_channel_caches = gfx_info->v24.max_texture_channel_caches;
+				adev->gfx.config.max_gprs = le16_to_cpu(gfx_info->v24.gc_num_gprs);
+				adev->gfx.config.max_gs_threads = gfx_info->v24.gc_num_max_gs_thds;
+				adev->gfx.config.gs_vgt_table_depth = gfx_info->v24.gc_gs_table_depth;
+				adev->gfx.config.gs_prim_buffer_depth =
+					le16_to_cpu(gfx_info->v24.gc_gsprim_buff_depth);
+				adev->gfx.config.double_offchip_lds_buf =
+					gfx_info->v24.gc_double_offchip_lds_buffer;
+				adev->gfx.cu_info.wave_front_size = le16_to_cpu(gfx_info->v24.gc_wave_size);
+				adev->gfx.cu_info.max_waves_per_simd = le16_to_cpu(gfx_info->v24.gc_max_waves_per_simd);
+				adev->gfx.cu_info.max_scratch_slots_per_cu = gfx_info->v24.gc_max_scratch_slots_per_cu;
+				adev->gfx.cu_info.lds_size = le16_to_cpu(gfx_info->v24.gc_lds_size);
+				return 0;
+			case 7:
+				adev->gfx.config.max_shader_engines = gfx_info->v27.max_shader_engines;
+				adev->gfx.config.max_cu_per_sh = gfx_info->v27.max_cu_per_sh;
+				adev->gfx.config.max_sh_per_se = gfx_info->v27.max_sh_per_se;
+				adev->gfx.config.max_backends_per_se = gfx_info->v27.max_backends_per_se;
+				adev->gfx.config.max_texture_channel_caches = gfx_info->v27.max_texture_channel_caches;
+				adev->gfx.config.max_gprs = le16_to_cpu(gfx_info->v27.gc_num_gprs);
+				adev->gfx.config.max_gs_threads = gfx_info->v27.gc_num_max_gs_thds;
+				adev->gfx.config.gs_vgt_table_depth = gfx_info->v27.gc_gs_table_depth;
+				adev->gfx.config.gs_prim_buffer_depth = le16_to_cpu(gfx_info->v27.gc_gsprim_buff_depth);
+				adev->gfx.config.double_offchip_lds_buf = gfx_info->v27.gc_double_offchip_lds_buffer;
+				adev->gfx.cu_info.wave_front_size = le16_to_cpu(gfx_info->v27.gc_wave_size);
+				adev->gfx.cu_info.max_waves_per_simd = le16_to_cpu(gfx_info->v27.gc_max_waves_per_simd);
+				adev->gfx.cu_info.max_scratch_slots_per_cu = gfx_info->v27.gc_max_scratch_slots_per_cu;
+				adev->gfx.cu_info.lds_size = le16_to_cpu(gfx_info->v27.gc_lds_size);
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		} else if (frev == 3) {
+			switch (crev) {
+			case 0:
+				adev->gfx.config.max_shader_engines = gfx_info->v30.max_shader_engines;
+				adev->gfx.config.max_cu_per_sh = gfx_info->v30.max_cu_per_sh;
+				adev->gfx.config.max_sh_per_se = gfx_info->v30.max_sh_per_se;
+				adev->gfx.config.max_backends_per_se = gfx_info->v30.max_backends_per_se;
+				adev->gfx.config.max_texture_channel_caches = gfx_info->v30.max_texture_channel_caches;
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		} else {
 			return -EINVAL;
 		}
 
-- 
2.35.1

