Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DBFC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E9910E8F2;
	Thu, 18 Jul 2024 14:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E90jHT2e";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE0210E8C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2JopWgj+VkeZQ7A6oDPFdM/Ded846iTitF6CkP5Fj54q+nX27U/QkSBX0iEha/A5RA2oNVUbtH3X9jNsmEruTnlRD8rzE8vEKnXnLNb3GwdK4jZ5fsucRXfifO9NtHS7WmKg8C3S1S9xv6ocyLhwpjfm2bfNsoGlyBOEH0H5UZVhySTppwPev7aGA+cUAkf9oLkyBkN1ugpenF1V6iLkvoHVoaZOhoXAte7RMZJ7McueSe+sqZABjOJcla/aTAyjr71LPkNr9NjNApgY6IpaP0K03q/dZyjDir3QA/0RS8gT8LH/Y6dbKIqt5T5pe1P7/J13K/fvIsEtdG4IyPB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6LoxvZ7om+lHm1lV3hiRx+06XXSIka6OzYxkVeRGZE=;
 b=seV9HuzVhZtSrsAOtu2IdEUmg+mOVy8EED09uyWMqPl0H3b6+QRPPgSLK1dCWcRPPyL9lFf39GapuZqfhgSanlftrIuU0wgFLT82rIIoPPR0ENtF5VRBrwLXCJZ19/aDfxJGnOmOJbyAFCy1GYdPF19z9eWo9ET1PSsdCskuvDaX8CbVqKmER7Y6maUhDLd2v0rJl/jfldoSAhO2j0d6h8YDceFKyl2xhNsKge/yEa4NF3c6zzLBWSh/dFX2SxpdZz0XnLNtCzVvMb6aZQkdh4rT0/RMFiZoq8+BA6PzWs5kVdQlt0jwEA/TeNVs05BxInefIpWaNotuR75uEkPi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6LoxvZ7om+lHm1lV3hiRx+06XXSIka6OzYxkVeRGZE=;
 b=E90jHT2edjxAre82fFFwGNEMeVLXCoK4BelcUx0z4etesC2Wm3nR9IL9eoaAeHjLrhVyhvqpIbeZFTRhUZaNc1EYr6fI6oHdERSqSs5w8vPtWP534gclswwtdcFE+TL4uDDMzoYAOC5jHw5de7OGMsx681356L+9gv6/mki9ay0=
Received: from BL0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:207:3c::42)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 14:08:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::3a) by BL0PR02CA0029.outlook.office365.com
 (2603:10b6:207:3c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/34] drm/amdgpu/gfx11: fallback to driver reset compute
 queue directly (v2)
Date: Thu, 18 Jul 2024 10:07:10 -0400
Message-ID: <20240718140733.1731004-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 04839a04-8cff-434f-6092-08dca73308e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5D6gqSNFYamM/7TAkUFRseNd33NCCcFBsfv5K839xLBHmgfNyC5Ex4sORYTR?=
 =?us-ascii?Q?cXRFP2zlXJRk+CzRibmnUk4mWz2vAAV7M/Vy9pepcGJxVGIFy8scbilqZQIn?=
 =?us-ascii?Q?zLNk8EeiEcZi+6/ans5nS/RI8/vd7FhB7lz27gVql1RFbtYqUsBUNFhQMUd9?=
 =?us-ascii?Q?pYn2Vu5goFTCk7ONxugopUJ24SfGvprwZaP90kbtm+E0kMr2vFz2ytJoNcOK?=
 =?us-ascii?Q?5Pa4vzk1Uh6fO+D8dlATSyDXJwOYqH/5KdTbb5hQ0byJnyTdQulZtnFKrJS8?=
 =?us-ascii?Q?BxEZWlxpLXzhiv8oiA/sM++PyFLAKXIs2Gv0YtnbG9Cbre0o/FECdOnp6xRa?=
 =?us-ascii?Q?/PbAd/rNl8OSp5GFpHKCqrQW1ft02KtCdo6l91Pema/nkzhbBeUMOam6KKtZ?=
 =?us-ascii?Q?Ybr7irGaPfv1/3AipFqtfcYQeeL4BiTJt3CPQaYcBjmtPTJKYHuMfr93n5m3?=
 =?us-ascii?Q?ar7LAbmTcBxyGccipDzBaxTk5sgPAGEz3ccG4nYU/UpsONP8Wcb95G2zncDJ?=
 =?us-ascii?Q?BwuKWB/RUHNTygBtpcp1zSZNj1D7A9kdza2LRZ5atAMv20BdlVXUHPqVqzYr?=
 =?us-ascii?Q?qwLEMTqJyzVX93IiUobiz+c5cLmnxuMcpzWKQIU69/L8zOzI6PcihBlE1IUY?=
 =?us-ascii?Q?n97Njh3DPP9MvvFMtoQA7bMzvwRt7jQa61Z0DTY45Akkv2W2ies34GgrOVg0?=
 =?us-ascii?Q?+7tnbQelpNmDEfcOtoPLk/SSx91jUoYY57xX1Im/WmLjo/8z4UzCcMcnwFZt?=
 =?us-ascii?Q?dNKv9S9Oj/PNx7avog1f2/iXf7vf8Lh2x0Na+b0uMe7BwOnfCKNC1LzJBpoJ?=
 =?us-ascii?Q?XHirw6ooGX/0wGHQsHmT5CO7BNJ/T09bvxH4CposSnAJyiQlDNpTVPelCuVf?=
 =?us-ascii?Q?y8H7DJQOPMogs70EaAyvRLQgi1MCveWxMC09uDAoFqTpMWkC27dQpnFEdpKt?=
 =?us-ascii?Q?Gs63qkeMowK7t+DxmSlrC26JKqxhYr1RJ8L5S37btqnVUb1zttisOpKzI4Ir?=
 =?us-ascii?Q?TE9BBnrRekv7NH8VeNPhTrS8KSd601IftMIWes8lRLnJoPEyOwzmWS0Exr/V?=
 =?us-ascii?Q?9aykfa7xoIQeUzB0+NcIOEe5xLxdXexAklv/roi8wtp4WUCkwjPE8uXXoUkg?=
 =?us-ascii?Q?q8i9p3pagfRxOumqPi4Atoo5cLQCiVi7NZL7YEU5Z1sCtynIsVtbEnlv+2fW?=
 =?us-ascii?Q?Wy8R+/G6u4tg1CE8Lc4cmTfIzGo4hWouqObaMzN8l/77F4IkPKsjdlOmWJxF?=
 =?us-ascii?Q?yw8lvxXoB9Hoymp6xYtEOpSPDRsULxoh4fsLJ8ok8EOMTgnajtigzsHnF6b+?=
 =?us-ascii?Q?DEdP0GwfJweNWWe5K5JLMjtng4AKK+cevwrki5FKFW4xqwYX4CtvqM+psb8c?=
 =?us-ascii?Q?Yq5t/VEbBiSLTYxEsVMeLjZzAQUcJJYb7DmoJ/HZcHQd57WKBTIDZ/yZ2Ab6?=
 =?us-ascii?Q?YPQ1Wu2uXaL5L8ktORwIsWuswWwTfgNM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:01.3498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04839a04-8cff-434f-6092-08dca73308e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

From: Prike Liang <Prike.Liang@amd.com>

Since the MES FW resets kernel compute queue always failed, this
may caused by the KIQ failed to process unmap KCQ. So, before MES
FW work properly that will fallback to driver executes dequeue and
resets SPI directly. Besides, rework the ring reset function and make
the busy ring type reset in each function respectively.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 84 ++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 56606c6dbb15..22073a839922 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3966,13 +3966,13 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
+static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4008,7 +4008,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v11_0_gfx_init_queue(ring);
+			r = gfx_v11_0_gfx_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -4303,13 +4303,13 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4373,7 +4373,7 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v11_0_kcq_init_queue(ring);
+			r = gfx_v11_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -6520,18 +6520,76 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static int gfx_v11_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
+	struct amdgpu_device *adev = ring->adev;
 	int r;
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v11_0_gfx_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		return r;
+	}
+
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kgq\n");
+		return r;
+	}
+
+	return amdgpu_ring_test_ring(ring);
+}
+
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	gfx_v11_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v11_0_unset_safe_mode(adev, 0);
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v11_0_kcq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r) {
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kcq\n");
+		return r;
+	}
 
 	return amdgpu_ring_test_ring(ring);
 }
@@ -6737,7 +6795,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
-	.reset = gfx_v11_0_reset_ring,
+	.reset = gfx_v11_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6775,7 +6833,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
-	.reset = gfx_v11_0_reset_ring,
+	.reset = gfx_v11_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.45.2

