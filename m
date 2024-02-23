Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331D1C5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 09:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D19210EB4F;
	Fri, 23 Feb 2024 09:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PPG2Qaun";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1E010EB4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 09:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCs4IZvaxiQQ0PEsB+RfdAXRCm8DEIFm8ED90fLFAXoKoUFj+gWSLUddi687LOa76F/bSLb0lvKUKa59N9CI7gtMcIhUCTYOQHQyvwKU5VP/ABlS9MGyH7pYHf5uxCAqtjLSFb6zxi+zKD+Db7dRiHHFuWWywJPyufCHHIsP1DNa1cxGaSEpqTTcNxDXW4vGhTIvtSq/pusSFrm0kok8OgGDzdxHLW+bzXNa3gc2NR6HHbTNI1KxYGTnmxcbOTSqOqIVoaYRb5Du8unn6pUbZXWJjqSCuOjfAyFtZTyrEiqeFYt9EjdUTrXFuB1tJyHAFs1D5qxZkRi8yo/vDYCKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj+tOtKJbvfHOex4T3r19wagWuCzGjZ8dHCkvjyOxH4=;
 b=U66C34TpnC8RjMh2wdgTLhRzowGNTWZGgYbznnUIpzZqGYWdHlfa50K9WOI7WUmFNiWXzsyRxZ8m8HeG6boJVWbmKv7XYq0/TgXQHgAH4QFdIwzI+4b17C2ekvHc0DhLD+WYmpnzbrtgaQt8Lk537DzUYrI8Bu8zoZrdP1mBBM74GreMaJ/kFVFAFaI4YOLHWNn6CjVOuryN/R99YQT0acrucl80VsDChJJto8mN7jHZT1RQvN4F5nHv9APDpSXvuGaiDlcFQ9pinKY2qidryuFzz4Yx4bv/ARQRA6caHXJKWf+BbuQpXneZDGSFwv7SydVnT5CYp2PU1Bb/kj9ZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj+tOtKJbvfHOex4T3r19wagWuCzGjZ8dHCkvjyOxH4=;
 b=PPG2Qauner3YRVspMEXpPRETHW/30LmYxiPoKe5vV9CrAQQsAobuJEQBIVyjhp+yTD2y5d6yO5XGm3Y98MqMhbWLWdZOZOaUVUTiE8Xmp7wIWLdROKncAH197nL6I/N+0tAAFZYj7rFfIv9H6eOxP08+dlIrf2gIGz9JEzvlNfg=
Received: from MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 09:42:07 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::fb) by MN2PR16CA0051.outlook.office365.com
 (2603:10b6:208:234::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 09:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 09:42:07 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 03:42:02 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: disable ring_muxer if mcbp is off
Date: Fri, 23 Feb 2024 10:40:46 +0100
Message-ID: <20240223094132.880396-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2d0dbf-b94f-42a9-2caf-08dc3453b331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2f78W5BeEknfRXO1AsRouGAamMPLNyD2yEtB+sF7NR+w2pr+Qbc6J4Fot1v681uz7KwoGpgqshZ0Ytf9ezdACZWol7fxAWLGOCNjsdw9cbQinPwXadaatKyXgxNBKCl2NP1e6IEuFmQ7TX/m3Szr08bSFg7aj1tIWJwkYDC5PrJvTj50a+Lb3qrdpU7bmfg2lZ2+v6TL3ccqiRZ+k3wIj9HNqlbC3mJLtfhvLyRAiPGRj8FO59U4f0dZK/EYma23QGY4Fr0z8VvBDHyQU8dTS0GNDezCMDvjnjYsKmSgvi6giBzyeGFcA3aYstlFdLCeC37mlGCxCwFmWEp+ayLRYrjWP3AtWGoBvHGJquIQDrNZ0H8qPbBwL2GMxnVprB2Cqw1VtvPnVkdaKFFM5wYG5zgNOvAJ7xuwbZgannnGitpRqEzM0r7IERMlrL6TV5IvVVMrAuRg2WekbXwq6KpIJ69NOKC0UFEZyfJZ5XLIadGZkVhFLrAnbO+qYV2zyNtGz4dPEyePtt/A/VRtrW+IbsRUkSQjL61YLbJ1sdpkSG9E4K5Bfpq5IOQ/+uYUtmDZVqSQl3FneSLlhIHt4j27nynhlNqtk1YHuj36GMO76F+avsmlTgq3pgNBpRj9qV8A7+gJuoW7P8dqFOwLCxTPsFXk966i17KyC5nyKuDlvM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:42:07.2573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2d0dbf-b94f-42a9-2caf-08dc3453b331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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

Using the ring_muxer without preemption adds overhead for no
reason since mcbp cannot be triggered.

Moving back to a single queue in this case also helps when
high priority app are used: in this case the gpu_scheduler
priority handling will work as expected - much better than
ring_muxer with its 2 independant schedulers competing for
the same hardware queue.

This change requires moving amdgpu_device_set_mcbp above
amdgpu_device_ip_early_init because we use adev->gfx.mcbp.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d534e192e260..40516d24026c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4054,13 +4054,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 	}
 
+	amdgpu_device_set_mcbp(adev);
+
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
 		return r;
 
-	amdgpu_device_set_mcbp(adev);
-
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 169d45268ef6..f682f830f7f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2080,7 +2080,7 @@ static int gfx_v9_0_sw_init(void *handle)
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 
 		/* disable scheduler on the real ring */
-		ring->no_scheduler = true;
+		ring->no_scheduler = adev->gfx.mcbp;
 		ring->vm_hub = AMDGPU_GFXHUB(0);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
@@ -2090,7 +2090,7 @@ static int gfx_v9_0_sw_init(void *handle)
 	}
 
 	/* set up the software rings */
-	if (adev->gfx.num_gfx_rings) {
+	if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
 		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
 			ring = &adev->gfx.sw_gfx_ring[i];
 			ring->ring_obj = NULL;
@@ -2181,7 +2181,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->gfx.num_gfx_rings) {
+	if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
 		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
 			amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
 		amdgpu_ring_mux_fini(&adev->gfx.muxer);
@@ -5910,11 +5910,14 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
 
 	switch (me_id) {
 	case 0:
-		if (adev->gfx.num_gfx_rings &&
-		    !amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
-			/* Fence signals are handled on the software rings*/
-			for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
-				amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
+		if (adev->gfx.num_gfx_rings) {
+			if (!adev->gfx.mcbp) {
+				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+			} else if (!amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
+				/* Fence signals are handled on the software rings*/
+				for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+					amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
+			}
 		}
 		break;
 	case 1:
@@ -7051,7 +7054,7 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
 
-	if (adev->gfx.num_gfx_rings) {
+	if (adev->gfx.mcbp && adev->gfx.num_gfx_rings) {
 		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
 			adev->gfx.sw_gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
 	}
-- 
2.40.1

