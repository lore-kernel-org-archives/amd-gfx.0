Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65666C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28C210E2F3;
	Fri, 12 May 2023 21:44:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BBF10E2D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7fR7OTe6+MBb4FzCvURsMBDfnYN3uiLk3yfXMbJsRBa7tOAsPRl6ik1krLnB6KlE0Y+QEO11EHtNnL2GRASK4h0vuT+ATZ5eQRFqkMnH8HkCbRMMB/mERnHb/xAPgsnXs3IFGfzXe1dOM+vb+JI4lrsyCiHIDTKP1qVFaTwwL1WZ6MDf3M2MxG3CbmQUgbOlW3STYrqATaqqwhdaJziXsYz0f2vHoNMfRkF69osl+BjddOtls4ZNgWlKM1xJQymYrgPhsNGVQqGoz0n95YyfuAJpzFora5umJrU2/M/e1J8igbGrxQB9bzRtUbZb/72gxmUYudiCG7JKd6GX/HfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAupaM5qYv8dOc1skb3tnWq9NJZe89yOMmMUW3SEfOY=;
 b=C64bzaq2gXjM0ObHmiEoWcAJsTtF0FrHSqqsp/xnAr2eQTGtagde+whbhhGT3MJj5LbvlGkb75gqQfRqGY9j2kr5YM5ZvuNUByqRl6N5mGpu2cNcAE5jUrUKx/hhxTSH3BAfZT2zzSUqzTqVW4CSf+JOSnz0VaAgbeB52wvnA7Mtv8TyfvuIuEVaJqK73oIpwYHfl+Jd3otwkHVoICH1iZ4aTLFHlDh2AGXWad7EXom8Tha/RDH31W7L1hiiM4h78s98v3WG340/7117tNd8FVBU5M/+7ULL+bkmKycUZAZR8XJOPMxyd2V8L7Bwq6t5hgIIF+PqE8mHRz5/9J8cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAupaM5qYv8dOc1skb3tnWq9NJZe89yOMmMUW3SEfOY=;
 b=GiEGi6KOjODhXUXgc4+0aKTnBJdSTQMwzYrp7iPlJyophaiX7DjEAm/QwPyJyJ13aC+XvoMkp9Jh4AGSl3uLQDIjrHzj6iNJuM6XZ1w3WjmxjHj9F1kC0H2AR0deW2RlZCwygWKM1Ai1r0pVHVBStJATlNG8NqYv34d1zuv2IOU=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 21:44:22 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5f) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amdgpu: add sq timeout status functions for
 gfx_v9_4_3
Date: Fri, 12 May 2023 17:43:50 -0400
Message-ID: <20230512214351.1356254-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 646b2a9d-b0d7-4347-fe93-08db53320bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEA7wVdvEmhuIMAkBjmwwXF+DeywtAgMALT//+lqX1ZoGPdVdYzAOI+2ki8imiHRcDtaJlOvTr1GMhKb1a5/p78Se6eeoaEw2w5/s1HXT/0A1AAjujGUt/+NuJsyMVp+hES0/U2iLZLeRGFJZlL2iHuNKFRFyRf1FkFTD1KyAugf0/vAxL0GBFanPFl1eXy+TI/rVYvHsi+e6O7rzqxsaDegzA/Yu9cpZPKSrtVidq2xD/W8xmzg6RTrJwITDgF0KrdsS5zwMg5yZgi07Ad4519N4st6YQcrEUk9g5Xb0Bwpx5N3ppLNKdXZbLySiUv/iVzL2EgyJZ2sEBqp4PLbY0GFfZLsBqmNRHNadGc0AdPEt81Hstwvf7gKpCy+kuHwfzsMweyO7vkDn12S3qVnuhUn9JSsTldowvVYFd1pSUSqJVbSvkWR14taCdvDWr7by8ZuK03C98TREg0gLL19citY3jwUQ9lS4UB0kuEZw6G9a3HLRsdkrcJn1FISo8aLfe1W6sdTePX+rMJrM2kgctq51BdXY/snRtHCEGWuHEIYL68WCtoKhRkl/VQWRq/3D7t/92myw83v+xwXw5TTtgRpGPE4QSHKYJ88N5Q9dKie3OyUlRloeoLeior2GpIszmLHlV2z1XY81WwV5F2xoqjll52TB34et3anWz08WqkMEUMjMciJqzT3/lWg49+QaJg8I7wG8NwdikrVRX/w4tBv+e3XC6IVpxPUINfmpsXqouD9O0KQaavoQ1jMeDkqHCc3faHH8nHiGqgasK+XEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(54906003)(478600001)(8676002)(6666004)(8936002)(41300700001)(7696005)(316002)(26005)(1076003)(70206006)(4326008)(6916009)(70586007)(2906002)(83380400001)(47076005)(336012)(40460700003)(426003)(2616005)(16526019)(186003)(356005)(36860700001)(82740400003)(81166007)(40480700001)(36756003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:21.5308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646b2a9d-b0d7-4347-fe93-08db53320bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Query and reset sq timeout status.

v2: change instance from 0 to xcc_id for register access.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 98 +++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ac5270d5eff4..5bd2f40a817e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3865,11 +3865,87 @@ static void gfx_v9_4_3_inst_query_utc_err_status(struct amdgpu_device *adev,
 	}
 }
 
+static void gfx_v9_4_3_log_cu_timeout_status(struct amdgpu_device *adev,
+					uint32_t status, int xcc_id)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	uint32_t i, simd, wave;
+	uint32_t wave_status;
+	uint32_t wave_pc_lo, wave_pc_hi;
+	uint32_t wave_exec_lo, wave_exec_hi;
+	uint32_t wave_inst_dw0, wave_inst_dw1;
+	uint32_t wave_ib_sts;
+
+	for (i = 0; i < 32; i++) {
+		if (!((i << 1) & status))
+			continue;
+
+		simd = i / cu_info->max_waves_per_simd;
+		wave = i % cu_info->max_waves_per_simd;
+
+		wave_status = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_STATUS);
+		wave_pc_lo = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_LO);
+		wave_pc_hi = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_HI);
+		wave_exec_lo =
+			wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_LO);
+		wave_exec_hi =
+			wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_HI);
+		wave_inst_dw0 =
+			wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW0);
+		wave_inst_dw1 =
+			wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW1);
+		wave_ib_sts = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_STS);
+
+		dev_info(
+			adev->dev,
+			"\t SIMD %d, Wave %d: status 0x%x, pc 0x%llx, exec 0x%llx, inst 0x%llx, ib_sts 0x%x\n",
+			simd, wave, wave_status,
+			((uint64_t)wave_pc_hi << 32 | wave_pc_lo),
+			((uint64_t)wave_exec_hi << 32 | wave_exec_lo),
+			((uint64_t)wave_inst_dw1 << 32 | wave_inst_dw0),
+			wave_ib_sts);
+	}
+}
+
+static void gfx_v9_4_3_inst_query_sq_timeout_status(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t se_idx, sh_idx, cu_idx;
+	uint32_t status;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (se_idx = 0; se_idx < adev->gfx.config.max_shader_engines; se_idx++) {
+		for (sh_idx = 0; sh_idx < adev->gfx.config.max_sh_per_se; sh_idx++) {
+			for (cu_idx = 0; cu_idx < adev->gfx.config.max_cu_per_sh; cu_idx++) {
+				gfx_v9_4_3_xcc_select_se_sh(adev, se_idx, sh_idx,
+							cu_idx, xcc_id);
+				status = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+						      regSQ_TIMEOUT_STATUS);
+				if (status != 0) {
+					dev_info(
+						adev->dev,
+						"GFX Watchdog Timeout: SE %d, SH %d, CU %d\n",
+						se_idx, sh_idx, cu_idx);
+					gfx_v9_4_3_log_cu_timeout_status(
+						adev, status, xcc_id);
+				}
+				/* clear old status */
+				WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+						regSQ_TIMEOUT_STATUS, 0);
+			}
+		}
+	}
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
 static void gfx_v9_4_3_inst_query_ras_err_status(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
 	gfx_v9_4_3_inst_query_ea_err_status(adev, xcc_id);
 	gfx_v9_4_3_inst_query_utc_err_status(adev, xcc_id);
+	gfx_v9_4_3_inst_query_sq_timeout_status(adev, xcc_id);
 }
 
 static void gfx_v9_4_3_inst_reset_utc_err_status(struct amdgpu_device *adev,
@@ -3901,11 +3977,33 @@ static void gfx_v9_4_3_inst_reset_ea_err_status(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
+static void gfx_v9_4_3_inst_reset_sq_timeout_status(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t se_idx, sh_idx, cu_idx;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (se_idx = 0; se_idx < adev->gfx.config.max_shader_engines; se_idx++) {
+		for (sh_idx = 0; sh_idx < adev->gfx.config.max_sh_per_se; sh_idx++) {
+			for (cu_idx = 0; cu_idx < adev->gfx.config.max_cu_per_sh; cu_idx++) {
+				gfx_v9_4_3_xcc_select_se_sh(adev, se_idx, sh_idx,
+							cu_idx, xcc_id);
+				WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+						regSQ_TIMEOUT_STATUS, 0);
+			}
+		}
+	}
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
 static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
 	gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
 	gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
+	gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);
 }
 
 static void gfx_v9_4_3_query_ras_error_count(struct amdgpu_device *adev,
-- 
2.40.1

