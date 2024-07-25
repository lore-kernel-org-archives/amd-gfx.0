Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C92C52CD8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC12F10E865;
	Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2GI6pNN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032B610E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI3UWwRZM4IIyOJfg3nIgFmOefeK2pW9es6XSyD4EwfMNR9+GYcJ1tO2YxPceD4ws/NtOIMSiwaGfHxbtD+aUCsLguaJmUp8JnUdc22S4ZcdSn0gFMkEXXFO1MHiDyEE/bdE+svEfhwOoQrqGPaeBrXuObeIyF2qv5HPQKkydT5UISwDInzBmLWrw4YUg9OSZDQNh2Y43oudO8A+gZw5up6HKNFeyqWQugPLIzJFJX3JaD1OgYUVB0H8xGpAYCOV7e1/gErIumpTiDCOtxsQ3XV/py0CBahNEL4R7dFdkqr2BnZuXf83TaqoKXW1ueNPuwHQGMVyXDH5I2WduDtYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxXD5Ea260B0uXZa8UB8gKT4Kq+iuDiyH0xZg8qWdGs=;
 b=tgV4Nw4b+oIuGXsK7kCrfMHBeeZ9cO1S+IFOmQdGghgGkfsxKtcebak2UCBBQLfygDXKOE7PIVI9R0FAfG0yWegZdUQ2MuIfvg1X3Jq79LbeXyo6wOGmURCRvpR/w3r6ilqdJpgylyFerGU6UBr7+ghSC16ULzUqXCIrJZxFcvtwxJuKyDHHLbTNr5CSiFN7L4SzlGyCWSydeVK7lLGF6NFymDhFHI/2ZljVIuGXQXgu1TBf/LN+D1kCBLVihUm60esamZb16AXSVDE7i1q77T/YudQU61fRXOWx1c6mU7Yc2s0xcafXns9fBvAyRWaBohiwafdAQby6ueSKmYT7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxXD5Ea260B0uXZa8UB8gKT4Kq+iuDiyH0xZg8qWdGs=;
 b=O2GI6pNNyZjtWufJG1eyE2AYYiFGtlkrV15yun2RttW567ONcGRsJrlYyrEm/xwvPvaVAbyn735Nk24DQ0uyaGtFcZ+DqbwkzyDD4ywCAUw0olOmC/2/Fz6pTgU55LK1Fz/iWK6hzhoJytWrLjqKsPQiJpgaeiL82P6QlFsYAng=
Received: from CYZPR10CA0008.namprd10.prod.outlook.com (2603:10b6:930:8a::18)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:26 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::7b) by CYZPR10CA0008.outlook.office365.com
 (2603:10b6:930:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/53] drm/amdgpu/gfx12: fallback to driver reset compute
 queue directly
Date: Thu, 25 Jul 2024 11:00:29 -0400
Message-ID: <20240725150055.1991893-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: eeae95f9-85fc-4dc3-247e-08dcacbaa801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CyZFuHgzgqQxZylutm8wucjmS97ceKi9ZSMG8e8e0NKElf2Z0pdqjF8A3Oib?=
 =?us-ascii?Q?X0sFTmw6gGP/1X2HJsQ461O0xUpFOHjKWdWYOMmHsOQJiBWijvGM+y8hBxIt?=
 =?us-ascii?Q?LD+DDIya57D8E5Q5hJpIVd0SajNOEMWPuIt9CZ2/6skimM5FhrWVUT07J9OT?=
 =?us-ascii?Q?kXAewIicy+MQpBdIYEZpRb/eoqPGGfz2bziF914XSzUg4SyfnLmSL1wFsrSh?=
 =?us-ascii?Q?6+9nAl+oAPZVncxWMdQemCMKgCVXrvk3OtjbXCZzjjNNaDyjvqseE6bhFwH0?=
 =?us-ascii?Q?eEnN+JL7V3Ga+HguJCH306nFoQJlp1YOD4k8wp6iYB1M5BEkTsmdIKGZgmD2?=
 =?us-ascii?Q?no8vtca5rmjJAUB9AdIk5G8QJTUCUV85QMzqRsaL3GDaG24HCxwY4ffaYdrm?=
 =?us-ascii?Q?UKtNyeoGrpWQ9j2RJGvUEw7eGeGuUYYajfq5aljdsSnk993YOYjfMvx9vXK+?=
 =?us-ascii?Q?byjBff3cYmn8o1I+JeUryMNQrGqbopO0znEHi2EN7qFQLRbhWH7UJBFIRgkD?=
 =?us-ascii?Q?aAE/eSyC2r38vtj2bnzXzVIuOgOAgnjHPDU0ddIXwHzxfSilzNfLG1M7ZZD2?=
 =?us-ascii?Q?DhX5kv430rite3rp395ynM9VGVuhh3QUSfzFK5oOs8t07OQy154oOZOedwGf?=
 =?us-ascii?Q?KlmI0/6EKSex8UpW6YppIpWK9s1Iy3GmfqcCjFrU9KLFrjiz2FzjyIZquQCj?=
 =?us-ascii?Q?s2rGqcBqbQnE8eRAe8Gz5XTcFGFqGN9vIxnAs2Dyla57VyqUsuXdAkeEcoqb?=
 =?us-ascii?Q?FjdqndfgoRrnozOHA9bWNCW4DGdlaySRhIqUyl02b6qyARejvnjz2bB3+5Nx?=
 =?us-ascii?Q?p8STpqJr4QITozqc9vk5/DgQ3r/InXfbWdDBlS/KufJJ7IPt+mjDYEdCJoQM?=
 =?us-ascii?Q?DDVmjaqnG6kNJONumd5Ixr30W1qcYNu9ygD8wvx7qChVUL49eWceg66Csv1U?=
 =?us-ascii?Q?z4m4rgtyANzvHk6yYe5Z9CWI8TzwVNvcTGXSYHMDi2zhC13XtR6diYyTqnnY?=
 =?us-ascii?Q?vMD5bLDXgsYRD1PV5ADN9s+gNySgOzijesVZfI3XDqqm9gtmkcwkcTlTQjX+?=
 =?us-ascii?Q?p/BRMqGO0gX0i8y1aI8fMcApbbbpBAJQOwSXMG0ZspoTUonMASVRWmg1SRQl?=
 =?us-ascii?Q?4vgJclfNlLE2G5oWJ1O9d63oY+NyW1Yjrzzr91DLIR+h+EUj1ec/1+k69JO2?=
 =?us-ascii?Q?/Y8hyJ/PNsdQNB2FfMq/TW1jc8K7aT0c62y1Y83EDUFl/HBlsaXX/Dt0UlTO?=
 =?us-ascii?Q?h4kbX2pOVdn3ltOHyROQpMnp1lcC1Gs6GCnw7/iYVpIROhY3cB1HsHY4jUuK?=
 =?us-ascii?Q?w/cDwFt7zi4Db/X0oBOGyE9oDIVkt/+Z3nktEIjeqi6lyyzy9iaITjeB3Wsg?=
 =?us-ascii?Q?5nwSlAkZef8ZC0sT7y92GTyxsUI8oRLvz4ZDInqaCCzllqftist0jD8EhwWV?=
 =?us-ascii?Q?VZMXyvOJvCL/JOT6L13Zxm6q8o2Yytpq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:25.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae95f9-85fc-4dc3-247e-08dcacbaa801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
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

Since the MES FW resets kernel compute queue always failed, this
may caused by the KIQ failed to process unmap KCQ. So, before MES
FW work properly that will fallback to driver executes dequeue and
resets SPI directly. Besides, rework the ring reset function and make
the busy ring type reset in each function respectively.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 93 ++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 790b8d471d4c..db5550449872 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2910,13 +2910,13 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v12_0_gfx_init_queue(struct amdgpu_ring *ring)
+static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v12_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -2952,7 +2952,7 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v12_0_gfx_init_queue(ring);
+			r = gfx_v12_0_kgq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -3256,13 +3256,13 @@ static int gfx_v12_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v12_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -3326,7 +3326,7 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v12_0_kcq_init_queue(ring);
+			r = gfx_v12_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -5135,18 +5135,83 @@ static void gfx_v12_ip_dump(void *handle)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-static int gfx_v12_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
+	struct amdgpu_device *adev = ring->adev;
 	int r;
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
-	if (r)
+	if (r) {
+		dev_err(adev->dev, "reset via MES failed %d\n", r);
 		return r;
+	}
 
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
+		r = gfx_v12_0_kgq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
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
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r, i;
+
+	gfx_v12_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v12_0_unset_safe_mode(adev, 0);
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		DRM_ERROR("fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v12_0_kcq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kcq\n");
+		return r;
+	}
 
 	return amdgpu_ring_test_ring(ring);
 }
@@ -5213,7 +5278,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
-	.reset = gfx_v12_0_reset_ring,
+	.reset = gfx_v12_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5248,7 +5313,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
-	.reset = gfx_v12_0_reset_ring,
+	.reset = gfx_v12_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.45.2

