Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C35C3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A994F10E639;
	Tue,  6 May 2025 09:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0UW91bYU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD3910E638
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKK71EW9ztn/d7FWp9MIKQQ2YSm9HbFejixECMLRRRhIQw9H6RBtIGl0ABj8X2LsrRiXg5PFzP9WOfdGYjGBwiVjKgNUn0kD7rMaH1FxirEd9SEGoP/oTKsqu+ptAH+SknKchekxc8qBL34n72VRq03yTfGtCbukWW8VVRaY0L7SE1j29VSkZGJhc0sSmpxcrr8ld4m3uM6SMYHhvaK7o2v7NVU4P+8v1p+B9Bq2US3nVZpPE2r35IhdZHb6/Q3JwDWQ0jVy3JG2G2B7V7GT+u+JzwLR40ig1oIb7Uj95b7DNZTvdDm+o2vfrX9ckzceltn0o/DiQEhF3c3GUx0zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUyCcAg/wohKBNxzIKLFlctS8l0Tu7XvXPwC5X2+1Uc=;
 b=XdXQwssSw1aiJ8A1URqnZ2RQS7jKwgcsjWeBpgMokrVYMTGw9KxXqDzllb2PkIILhTijt8skGK/E7ZtE2wyKhOtCT4Z6mEshjom6BnbURsJ8Ia5MqtlUUBqCMTU9H9RAOBDo1cJaFDkVBUMaNguMh3ur615CAPg0UeYSEuaIaLg/cB4IUIEKqoQ48IKe1Uwj9nyGXVpGOBccIsnTIgzSM1SUmrcCKXdg5oWyBOBrusn09ryQY1Rr4+hZ0HfxA0Y6ePIzqc+0VNQRw+P0vBr2rd8SXaFYVqhSvXvkDysfMjHPpem7+ymoozBRgxolG8LmTaxV+TZMwzIE41nUkLO1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUyCcAg/wohKBNxzIKLFlctS8l0Tu7XvXPwC5X2+1Uc=;
 b=0UW91bYUJRAfZLJxKS40u26gvKBtq3oevbeyrKeDPHij91UyF0rrndQ/VA3+rAJAAtyGrjRp3hkjBp6R+fIQxbMTPbqZ4fuyVwRgB6JZ28g1GdrFhXipGTokmnGQOzv/3fhJS0iEh+vQrSouSEPxPaWM2rf0lz/OgU7/NhV3+Yw=
Received: from DM6PR10CA0006.namprd10.prod.outlook.com (2603:10b6:5:60::19) by
 MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 09:38:17 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::57) by DM6PR10CA0006.outlook.office365.com
 (2603:10b6:5:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 09:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:16 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:14 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v3 4/7] drm/amdgpu: remove cached gpu addr:
 ta_mem_context.shared_mc_addr
Date: Tue, 6 May 2025 17:36:26 +0800
Message-ID: <20250506093629.249792-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 401be5b2-6b3a-4353-db63-08dd8c81bac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?koTO2TcPEBynCZI2NJ42Gew2sFHTgId5d8rfBB04twnOHZlAQpXmtSj9bLjO?=
 =?us-ascii?Q?+EfWRQXroUK2PUsAUB/0yV9Dqu41q9sN80VPSwhUbLJ92OaaT/fmFpvtABZb?=
 =?us-ascii?Q?V9XOOCKGYovbN8umaMNzCdqQzfb/37KrG7g//sm0OMOCvA1tJ8nJltJlpd+Z?=
 =?us-ascii?Q?AZrl8Wy5HLlbfnQ7WSXzj0K2Tdba+9/LbjqRX9iTnnlWKDstI2kCkR5qm942?=
 =?us-ascii?Q?mA+P0Kc4qNnp2SGLDN6ZqTmVdr/B9gbN39Kl0p/M1apNaCm4agx5AV1L6+wr?=
 =?us-ascii?Q?eJJxdOE25Kt2OoKhDVZZtdv0NueuIfWAEdptQSrxLLEAhDpQbJP6oB0fL5Lg?=
 =?us-ascii?Q?/An0SbuLm2oG9BImWtHe+aNqRSdrHWhiOUy7fojt2N1Fno4oxkaQ20EwHFWp?=
 =?us-ascii?Q?a2V84yTsg9A5H8ua9FBP5N2/jeUyntEiIDTlI9AKsqdapoumYkZNFeu1UxI1?=
 =?us-ascii?Q?+LarHmsfWPTWf0P3iq8CfdI3AkojwprjttsXvahL8SKu+uy5u4k+S+sdhf2d?=
 =?us-ascii?Q?FD41pmvgeMXwxwbxYGTFmbEM1b894qxdJnnvK8vMcoMOfDH7PH8hF4l0/TGt?=
 =?us-ascii?Q?1inO55+vcp5BEz8PitQnvahNI3WQi/HXOgOu1KB+mu+azUw5yA7/IBDV5uze?=
 =?us-ascii?Q?y2jRARvdw5m8sVFO9K7vdTOdppO3BujmrVeqCS+ESzYBPUWepGN6Dx832vrj?=
 =?us-ascii?Q?l1CsqFmUOQ96xVNMwAkVplitKHHkhtO5meWrVauQPDTeOMowpoJacf23cpvT?=
 =?us-ascii?Q?GdDImUddKWbGh/J/os8/DCcDUgAOcMPi2lrK9B0jc63NTPRvXx8FiijXlz/L?=
 =?us-ascii?Q?dkAIgatYpCBwoj5wjGPscB3uS0yANNroRzyPuAfItrDy/CtVRDVgfrIlbI1G?=
 =?us-ascii?Q?K6euL10vEs/wierZ66jvqx0DuPXVebNGOfQvoHR6j1++ZtA6vyZBv2SHpfav?=
 =?us-ascii?Q?f1c8zvYToSj8DTq5EL5qJkuynxJyg2Xgvkc6fXmJQ4m7ql/sJmnFCk8apZYA?=
 =?us-ascii?Q?B7wo+vqDUVzq2sj83/7YqsAo0FenO9EE0NvdAA1PD+Aaf3XeY6bXoh+eKfT6?=
 =?us-ascii?Q?6SnKPsfSgUI9nFr/KSsa7PYETf0kA6yW+8p6I+SzsQ4uLjKHQ9x6RvxIJLcu?=
 =?us-ascii?Q?Obt9mfM5F7WwturdHDBP2z4RQO9npi0HWWlk0TaVgcwLyZX65km5NdbIY+Ou?=
 =?us-ascii?Q?SZp9V7aNbOOOj/BgpeLNG5QQgaIlrQhhyak40G3oe98R3DEWbwpVG2ChBJvl?=
 =?us-ascii?Q?9OOiFwDaAbFZVD4Dl/IH602n0ujbH7r2A+O+4IzlXjwoI8obRnwUc59mjhuD?=
 =?us-ascii?Q?pVZ0zHVzUcU8yYvJHwxVUetUfi0bkOqhG6AYd1Tlk6gvolbfdby92QpfvEsV?=
 =?us-ascii?Q?/A4OdX0v1rFocqGzTrsgciQRtsYPF6JIQP/8zrEBEKogjvmZUFJXDJrpy/+n?=
 =?us-ascii?Q?YLgnxttKUp0jBkxuCXx56CG/JU2ZIZMLl9ktPZyg4TJ9QVp/q4GPbwkuSaCq?=
 =?us-ascii?Q?C/2Zake2+bcYnorKeavU7ednW2txFhG1vcWX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:16.7705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401be5b2-6b3a-4353-db63-08dd8c81bac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 +++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bdab40b42983..153c0c868546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -276,8 +276,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 
 void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 {
-	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
-			      &mem_ctx->shared_buf);
+	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, NULL, &mem_ctx->shared_buf);
 	mem_ctx->shared_bo = NULL;
 }
 
@@ -1123,7 +1122,6 @@ static int psp_asd_initialize(struct psp_context *psp)
 	    amdgpu_ip_version(psp->adev, MP0_HWIP, 0) >= IP_VERSION(13, 0, 10))
 		return 0;
 
-	psp->asd_context.mem_context.shared_mc_addr  = 0;
 	psp->asd_context.mem_context.shared_mem_size = PSP_ASD_SHARED_MEM_SIZE;
 	psp->asd_context.ta_load_type                = GFX_CMD_ID_LOAD_ASD;
 
@@ -1207,18 +1205,16 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
 				     struct ta_context *context)
 {
+	uint64_t shared_mc_addr;
+
 	cmd->cmd_id				= context->ta_load_type;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
-	if (context->mem_context.shared_bo)
-		context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
-
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
-		lower_32_bits(context->mem_context.shared_mc_addr);
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
-		upper_32_bits(context->mem_context.shared_mc_addr);
+	shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo = lower_32_bits(shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi = upper_32_bits(shared_mc_addr);
 	cmd->cmd.cmd_load_ta.cmd_buf_len = context->mem_context.shared_mem_size;
 }
 
@@ -1233,7 +1229,7 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
 				      &mem_ctx->shared_bo,
-				      &mem_ctx->shared_mc_addr,
+				      NULL,
 				      &mem_ctx->shared_buf);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 6ea5c21edc4e..106d07aaf8e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -174,7 +174,6 @@ struct psp_bin_desc {
 
 struct ta_mem_context {
 	struct amdgpu_bo		*shared_bo;
-	uint64_t		shared_mc_addr;
 	void			*shared_buf;
 	enum psp_shared_mem_size	shared_mem_size;
 };
-- 
2.43.5

