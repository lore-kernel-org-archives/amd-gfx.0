Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F86EDB7D0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 01:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17ECE10E32F;
	Wed,  8 Apr 2026 01:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gEDpXhvN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B9910E32F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 01:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAJuyAPdJyBPsXrQNLSwPscdv2hn9SBgrdSEzZWjkgUeagebFdwRHoBlhzPPXc5F/QX8WARl33HZwMl8DYxGOleyX6BVCY1EWJYYq+XfZt8sJZXTAmqcporpo/xwY/0wwUKrzUmmXJ6VQ0UDX0mbMP6KbFrUXTow984THWbfoM1Qlp3pMG+SUHToy/S4fviBeE3E9IahcbfgQPZZ6XYwU6gdUd+fvP02IKPCcbjkzq+Mn/49sf3dhuJunAzYY5jO8V3C14a9IqqNzrnLuXGTx5wb7rzeAmDs7YTfaGkgBjBU61baYuf6ahLz9eesCbPoPSmUSUknYmCxqu5Se2TxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDt4KM8Wpf7TMIOWc0szmaeWzJKlvLG4tMercFp546E=;
 b=prpDN2BJSd8yxd3iAmQjTWFMJtBpX1AhqKPbBHzqdGa4LhN+Po3AUC1mnuRVYz/I0BD5LvkPy9O2OALaR63SH+Wt38vf1MeYkIImtPDj5Yg+xnRdROVd2BP2BJWGjqfrAANS07xtvOiUePS3L5W1SZOMgojGGlehCPOgRnOnPznRhKxdX8+OZYWQ70QVYaOTiP6xJhKg0fCUUixYU7twhgHInXBNcsA2pa3EgWCH+rFl/j+49Y2CIb9D9plK12sC/kpgWlj68BDZE5RA7JyXstsO8qpmEtfqzlvmsh7mN0imgC8KlrczsZ/vcCPgwqQTh/I9qeEQeWeZUf2ryJUR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDt4KM8Wpf7TMIOWc0szmaeWzJKlvLG4tMercFp546E=;
 b=gEDpXhvNnSnKfmuNoGEfNmLM5+FfpljgDI4mMTFCzyaHOjQksXoCpxQ/o6aUun6yhuAmc2H4GIKC1Xvq5f55wwZ0SRbYv+oiTbmnJxx35Xvqv0tSiHD81qIuHA0KfdphzpnTFywLpnU7IKoqV5Hwt6ZcL7vQLQ5lH2zEVnpsKHY=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Wed, 8 Apr 2026 01:16:26 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::c5) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Wed,
 8 Apr 2026 01:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 01:16:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 20:16:25 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 20:16:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu/gfx11: enable per-pipe reset support for
 compute queues
Date: Wed, 8 Apr 2026 09:15:09 +0800
Message-ID: <20260408011600.2512734-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
References: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c642b9e-bbc9-43bf-8824-08de950c7476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xygoHvIAjBh9BLcK81l+Hohao+n3JMCzb2JLkjdSRBEwBFBYvAI+CiW9pNp8wsMWqizTrECHsK8Xv+28gROkZVumfpxCNZO+mhmiv+t0S/l3prpQYr8aYEhbe3HVDCGu7TpAyK1t7zBrDjh1zMOYdrLRA2yeWduFt4fXRzfCRnaAdmb7PK3IgYrdx+CNwsocIhTNMmy9znE/KKSEAtg1G0nL4QdHyLs0i+U9GBkIm5RbC94iPhROSpW9QaDCkm6PVXMmkUGTblfDKO5/DvaIbqBoNIIRqTIf2ga6BOlTraxwVl41E3qokbEDRhS5G73XLb8yMlThgO52CxIHETqhDib4faBPqaWBv76KakIVmFlYi9eJ84NB01eBlFDrbXazo3WK9GqTN4rlI58bIR4pe+icYVTmOHo+cnEsRmEtzIp+QJK3Gs/3YRpXL/GUCPyvPa6tdqnNWHKpXINhj2pD2xvDKNSoDaOJ1v0WUXvkryrilZMKt2iWOUCjpkpRVzyUnP2pYdbvlnlIbXMm3XYRFyL6bhQ/43OfK3y1mU7WYpiuKyucHJGQYx0nsC5Kk8E4Pq46cuq8RZxJzyTA9x/IJ0UxLxMxz+TJciXG+aKtJUQqtsjNWghioD5aXp/z5s/t4xGosmsWIB/MtpGTaZelrRsWMPoL1Bf/DfdncEckU0VfVKfiTBIkQsVC7QKC27BuYUyBJuOCfZYrcm6W5Q8Ci99t5tGSLZRfAfn8Su4d/CqSolQISN6r1ebGhTCJgfLBvhl4vcZysSXGtgw5wvQ9JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T2Hd8tkvnHB22MdFERVLiJ6pb0/xubbuNXSvcXNk93WxmmaQXgzGgdciwqUuUgEvz4x86kjNTkPcINqc7gtICMI+y6Y+DC0+28qKOyjv2y5B/pGf1mmKSXKj8KqeRVScbtzON3DhreeNo0eFp+KvbtK4VmEf1tKZNGwVVKVyqZVNREpVOIwCrvgZqFOHahR6FSBPQzcbixtmmIeNm6Is5VpKvQwNJXS2wEY/VSKqNnIuJ/YShumlhbBrYNz+V/+3OsPUVC7K4ptZtljEvQgu44cJZSZ7kkj/3d3HVRJOVy+L5m6OInpAHKh9875XEnbSsBeMA3iKW6n5n44FIfubw1EA7wjflH8296YkrzxVUW0h3q4fRLaxEkuexkpJjYzTkYKIANItOMswUihpwWCkXVy91hno7ikY7Z5HaBs+MErE0Bb+kgjZKhwu58jELhBo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 01:16:25.8515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c642b9e-bbc9-43bf-8824-08de950c7476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

This allows the driver to fall back to pipe-level reset when per-queue
reset fails, improving recovery success for hung compute or graphics
rings.

V2: replace both gfx_v11_compute_pipe_reset_support() and gfx_v11_pipe_reset_support() with
amdgpu_ring_is_reset_type_supported (Alex)

Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a25fc25279b1..72a7d40a9c61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1851,6 +1851,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	default:
@@ -1858,6 +1859,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	}
@@ -6807,23 +6809,12 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
-
 static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reset_pipe = 0, clean_pipe = 0;
 	int r;
 
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -6884,6 +6875,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r) {
 
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+							 AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
 		r = gfx_v11_reset_gfx_pipe(ring);
 		if (r)
 			return r;
@@ -6942,9 +6936,6 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	uint32_t reset_val, clean_val;
 	int r;
 
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -7083,6 +7074,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+							 AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
 		amdgpu_gfx_mec_pipe_reset_prepare(adev, ring);
 		r = gfx_v11_0_reset_compute_pipe(ring);
 		if (r) {
-- 
2.49.0

