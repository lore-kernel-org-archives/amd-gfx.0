Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E441D3C527
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 04:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A4110E245;
	Wed, 10 Dec 2025 04:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NiITPwD5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2623E10E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 04:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vlu4yfx2IPg+2KcWqGda1iy/am3t2elvMSZ/ZfKh0hDdzZhap4xZwkILKHeeT+PGdfZ9QDyB8Ty2Msza41emDZboL1g4cZUFSG3NAdNtm4wyJ2aQgihypbGGGmJ6x91tK5+CxFnwkx2J5205rTw56zBPxDYSfuiRf/X/twND4HxBum0cGVoQLiFR+CjqA8fT6AgK2lAyXz+cDITOjciHCXe8tz/CXCz/trxkKvtfcI0ynf94PD1c5WqJqoDEnji9U2tZrQvBkYi0xOSmtm2qD61MPj9ZFMVJci/I0zRNHw/OxqHNw8Q6yzJsrZGBbwGz/EO5a11kP9+oqfIVnBJqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb7T2O7Kgz40F+jYIuQ6KS49v4U4LBdO/tRruvvJ6MM=;
 b=nHQyVkkWDX+bpebnQFc7m6t7aEeei1GPsEaYHE6aKPjxov2NSZl+Cbc3AxoAIAiOUMueOcYjmAi7zLGSatwqfXPMmKupWKcToDFE/JmJ7Zg/SmEcKlwuFthKR724+r3RJv3+/bR4rzmmPNzvmynj8boL2UI/05DUsJl6moue1gEIGfKHeEjfalT+dIpU1sQsBaLmn9pV+C2AzXtQAqgmN/0Lt1F8eR8zL7GWi1qwgjMnhM4ft+Dvi6QbV6ymlZ8z61+UG446BaPgePZZ3BMW3TDTYky1kRQfWJiH9cwljJlA0iLhiPYojl7Tk8O4kEBj5AqYJRsXaSOaGKCut5Ve4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb7T2O7Kgz40F+jYIuQ6KS49v4U4LBdO/tRruvvJ6MM=;
 b=NiITPwD5EEJqEq/hzj9sMYX5M1oNqpua9UmQWEyYMh9t+rwROpoH/suB2jiqEfL18XFFeol76+1fFfTLrYJCvpwyOOdK0PdCR+Lf1yZOsL6JIvwzleQj62b/d5hBsONypoT15spDEEVcSTDbFi3fqeeVlJMbtTBICrcEc4C44Xo=
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 04:05:43 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::fc) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 04:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 04:05:43 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 22:05:41 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, <lijo.lazar@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
Date: Wed, 10 Dec 2025 12:05:26 +0800
Message-ID: <20251210040526.1475073-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f1f031-77f5-4d06-6797-08de37a163c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PSk7317Q5DlmtlQ/rQ1fubo5KV8f1Kk5jbITQ4AVMcFEQOqFhFqhTaEtdyKi?=
 =?us-ascii?Q?cfyppouAcSi+mAX5bBKbQlpo4jLU+d1FaI8IyokpitQ4NSuDGzrjnwdVhsKF?=
 =?us-ascii?Q?GaewqjOTAl6+jBVQYBlh+sD4+7XgZhqNeiD5ld0P4g0Xe7c/SCwrTgG/9YWm?=
 =?us-ascii?Q?4Z3AdNAm+SiO7cs8dOJiSyY7qAzWv45xrTJTI6CoIe6fmAJv8aIzHYajyPpE?=
 =?us-ascii?Q?wz95mWNebyz805GJ/dCwy0zRCwswv1lS1Pio8ozsooUCbqkH0BRUh3NPuuM7?=
 =?us-ascii?Q?p6iE2sj29uVzQsvgBjPDn35w2ooAV1ryWu9j8ULWXOoHW2fkzUOdC63HfD+P?=
 =?us-ascii?Q?Yrl39Boj3PdwfzS99r3UAfyXJQKiAMZvldteEaU8ePWXF9KN2mVM/8iGmlw/?=
 =?us-ascii?Q?g7aTtEHQ1w88MEPHd5377LLFxDsRzH31AhW4yXRGQkaPvFE7d6Lb1a7RTtus?=
 =?us-ascii?Q?lsVEOUHWdkdP2mL4hME6XHECEZYJx3jHbDT9tj64/7fpxUOoGGnMN6xcpGbu?=
 =?us-ascii?Q?Qt6uJMaiV1B14Lk2cb075RCil2qcd3h7QW3RWVbFi67GMWn2bkS5WFTugr00?=
 =?us-ascii?Q?mncMKe/C81M2LgacEtBonnLvQmmVfOn2EJOH5NuJMKHnGRjgeXoWzYS9Ql89?=
 =?us-ascii?Q?+8IO9fKrJeYmDvSF6lc/0Jc4e1F0zvvQZvbKqoU4I2aUvfXH3seV9DMifric?=
 =?us-ascii?Q?sLfRNCCqPckQRBu7KoVDEa6tziHRd2ukpqZyEdMgE+Lp89Sdfg9ARfHuYQe/?=
 =?us-ascii?Q?lF5uf10zN1NXMn2LcUdHNJ1KtVA0Od+dtOdApF2NNYq3/QI+1NjJDITvWsQ0?=
 =?us-ascii?Q?ZoVklHBbglvj0hfB56EsBDwT0Ceexpl+tv+nFbFywBI4EV8qSzBCpXQV9bxN?=
 =?us-ascii?Q?VuAwRy0P6LpwsfsZauBrTCO1CVQ/Mpq8iRBabgz2fDCAeGcLxCvigfY5l9cP?=
 =?us-ascii?Q?1NJfu50SIrvN5dtHuOX3IDkOpCocicZJIcwomkIRPtCH0ifWL2tnBbQQ7fi9?=
 =?us-ascii?Q?rdRsNl/Vm+HZOQIidR56ZCltVmvZVaZCj54JYLU72cUbZ8xHRoEmrsUww2Fp?=
 =?us-ascii?Q?zbs5tGYIJUZDWgWChyAF+e0QXBAFFa+38jLe8SCQMAzNuHbwIVjV6o+0ARHg?=
 =?us-ascii?Q?T9uVk3FlvH3SOD2NJnmHU+4XgZkOSIQf1j5TWm902lhK6+LD8AM9vi5ckzxQ?=
 =?us-ascii?Q?41ELGew8NWI5WRgcC+J7bUa4Ampl+2i0alhAjYOTyAUCkcDHtv38Eegm7pEA?=
 =?us-ascii?Q?obCXdp/6eKDq76BKP+cFDv48wJtgGWNLiTkzDwna/ghNJD302MP/zmDdqwtZ?=
 =?us-ascii?Q?8Vd+9D73rNgcjQQCr62SdBoGapD85hJxPlDhXwq0DwWAlOIYEElT39WP4oJ4?=
 =?us-ascii?Q?+aK2kWhLdaF2w1wo4+erzo08JvNc2KXPMwRG9gVpTGFufpL8xSd4BIrWRRb2?=
 =?us-ascii?Q?RLTAuYdKXglX4NfIYgODrRIbUG9XavPFqaLte/CNnDby6H4fK4UhgohhwMIt?=
 =?us-ascii?Q?KdCqw+wxMnUqW6EJXCfSHb7Vh4EFKvSBEQoKlEnIooiY+bNUnLoDBta2C/0z?=
 =?us-ascii?Q?mHTFv4mZNYzUKlauAI0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 04:05:43.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f1f031-77f5-4d06-6797-08de37a163c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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

v3:
Unify the get_ref_and_mask function in amdgpu_gfx_funcs,
to support both GFX11 and earlier generations

v2:
place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
since this function only assigns the cp entry.

v1:
both gfx ring and mes ring use cp0 to flush hdp, cause conflict.

use function get_ref_and_mask to assign the cp entry.
reassign mes to use cp8 instead.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 60 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 64 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 64 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 59 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 59 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 60 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 60 ++++++++++++++++-------
 9 files changed, 327 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index efd61a1ccc66..090714127cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
 	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
+	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
+				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 895b841b9626..77d25317973e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 
 int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
 {
-	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
+	struct amdgpu_ring *mes_ring;
+	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
 
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "mes hdp flush is not supported.\n");
+		return -EINVAL;
+	}
+
+	mes_ring = &adev->mes.ring[0];
 	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
 	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
-	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
+
+	adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
 
 	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
 					     ref_and_mask, ref_and_mask, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index aaed24f7e716..8b85b836fd32 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4566,6 +4566,45 @@ static void gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
 }
 
+/**
+ * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v10_0_select_se_sh,
@@ -4575,6 +4614,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
 	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
 	.update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
+	.get_ref_and_mask = &gfx_v10_0_get_ref_and_mask,
 };
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
@@ -8614,25 +8654,13 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f4d4dd5dd07b..2600a698ea38 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1072,6 +1072,49 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		case 3:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -1081,6 +1124,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
+	.get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -5833,25 +5877,13 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f9cae6666697..4c86f99a2783 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -929,6 +929,49 @@ static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+/**
+ * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		case 3:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_0_select_se_sh,
@@ -938,6 +981,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
+	.get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -4389,25 +4433,13 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 66a4e4998106..29a6378cbf04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2068,23 +2068,15 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	u32 ref_and_mask;
-	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
+	int usepfp;
+	struct amdgpu_device *adev = ring->adev;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
-			break;
-		default:
-			return;
-		}
-	} else {
-		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
 				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
@@ -4075,12 +4067,49 @@ static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
 	cik_srbm_select(adev, me, pipe, q, vm);
 }
 
+/**
+ * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+		*reg_mem_engine = 1;
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v7_0_select_se_sh,
 	.read_wave_data = &gfx_v7_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
-	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
+	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
 };
 
 static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5d6e8e0601cb..0fd17fdf2cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5211,13 +5211,49 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
 		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
+/**
+ * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+		*reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
+	}
+}
 
 static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v8_0_select_se_sh,
 	.read_wave_data = &gfx_v8_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
-	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
+	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
 };
 
 static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
@@ -6000,25 +6036,14 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	u32 ref_and_mask, reg_mem_engine;
+	struct amdgpu_device *adev = ring->adev;
 
-	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
-	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
-		reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
 				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e6187be27385..8b912ea87450 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1997,6 +1997,45 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, me, pipe, q, vm, 0);
 }
 
+/**
+ * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
         .select_se_sh = &gfx_v9_0_select_se_sh,
@@ -2004,6 +2043,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
         .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v9_0_get_ref_and_mask,
 };
 
 const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = {
@@ -5380,25 +5420,13 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 89253df5ffc8..56a1f6d8c121 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -838,6 +838,45 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return xcc - 1;
 }
 
+/**
+ * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
@@ -848,6 +887,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
 	.get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
+	.get_ref_and_mask = &gfx_v9_4_3_get_ref_and_mask,
 };
 
 static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
@@ -2818,25 +2858,13 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
-- 
2.48.1

