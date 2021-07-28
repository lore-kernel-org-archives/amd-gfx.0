Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA9DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 04:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05FF60EBB
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 04:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B05FF60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DC66EC91;
	Wed, 28 Jul 2021 04:07:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CC26EC8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 04:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnUU+INuhq0+7eyMAYbNtVNpVSEFaXZy1DdJ0wu2fvr9VMhiL1k8N3Hh28HYvm7rjUTmEPqSlyYVH1voWEgkxWgzZhgEVx4QdZVKs27T9zabiT64NAHsWAtZhuUQCsmy0GXwRetIfUBPPcJIJrJTOsRyBzmzUtdN5wYhsCT+qfeSy1vw7uLfwCVX8dFfvTobOSMsmpCkYSXCimng2or9T67i9CSBSgeU8mQBQGGwW/afxwkgCACHNurSHaoE2X4ouw8zijYRhzgwofaH4WD1CYrm0SB/wHRxGXxAoYKnyL1UbhlaIntjleTHvd5+QYLM0DAFXYIXWWYhQqo+KXIkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX6vy1f/03+lrwYg3ezozC4eKGMinjiQc0KPXTNIqoA=;
 b=HTqfb1UmEQLislQ/Eze4/MuYjSPdLre/FC3L2S5c3Ps7vaJFbueXqoKrwuwdMG6jxptiZ6l0ngkC/ZsQ7dlBOssGXlfRCBNbunVfk+TQ3Tct7Tx974DV3+uxk+CtGwdG9Zce443mYnY02fwCQY76Q/uJs9lL+hGthnNSYmrKI0L/fu7LHtsqKzsRSK3mpSb98P1qI7/zCNWKAEyQOsAKA2f1KSyl/coA9U7kLWhullxkZjXJIHdtspMTxJChHCT2eYdhYeZbdjSmsHVZS9R+xwAY5pafexDDEBab/sdcmbpRnxDxIyU5j4S0vCX/Rn1WMLNEzBAdp0TnAyWrQuSefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX6vy1f/03+lrwYg3ezozC4eKGMinjiQc0KPXTNIqoA=;
 b=VPAFx1Hy/dhxwWXIvuibnrwzaM9nhFx3Py54Z8zJM9k8WeiQX///QCeduPuCPP0dMi7TTr33r6mmPEaSNF/MCIQt4IVDHJj1pM1/4Wv9hXHb7x/CNVL5jloEovM7ailLnmIywNxfjNP/jDh1J+vTgVT+OaTzY9PbuAF5JmqG3D8=
Received: from DM5PR07CA0129.namprd07.prod.outlook.com (2603:10b6:3:13e::19)
 by CY4PR12MB1782.namprd12.prod.outlook.com (2603:10b6:903:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 04:07:55 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::7f) by DM5PR07CA0129.outlook.office365.com
 (2603:10b6:3:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 04:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 04:07:55 +0000
Received: from lnx-glk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 23:07:53 -0500
From: Likun Gao <likun.gao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: adjust fence driver enable sequence
Date: Wed, 28 Jul 2021 12:07:41 +0800
Message-ID: <20210728040741.2734771-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0033b16b-33cf-4ac6-89d3-08d9517d46f8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1782:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17823D150BD3530C913328ACEFEA9@CY4PR12MB1782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /trzOTi8y+sqJ7q2pK80sbDEFMVw/NRzvc6g1BMGatogEL5H8oT0uyfsPaJ9H6kAsnBTBiP8/HJ2SL5vH4/DLIsmWTwh/X5xzjtxI6kTr9SMZZPFCztntvDi200Ek+aOf2ukdcbT/2N/EbeFrPLOGE38hnx3px6eKUyMRhzLjrbjWKUQfjnnvZGrL/W3S/33cmdjhIPWdEr8K0rARx9nfGRurcSpfYTMRh4aip6mspwlG+SG/kumjSh0Y16UBDYmhmxD+4v4rB4P8pyJrip4dPQCv6AnpObf+LGt3+8D//ufVWAzlrItS1yQAdBoWZF40Mgbm71i4X9nPzhA02KCfeF1yemhYJ5FxxlbHUPZi/pPjnDySPyrFgPF6lNd4zxF5sehOTv89YhIULYMlUSR8JXHkm2AmudX5S2oueqn5O5MI2rFEGdqhpy1xA7bWcsMg8apuaaZo/uk9HexYRFrU28LMWm3vnebRZy7zlt0Xqs3/xqjPivWeCa5X8FqlexF5bspUUlXjWMxRkVfct/in2fTjCVOBJRfqUveZzqJ1bLcEHb7bVfs5PeyU//nn6vNgQcu5dDFcrTsDVFg8TeXuFcLCQXGjp8RSG/Vztr7TYC0xy9cmIniK/XEGVI/AjO2s4jGUHeu6iNuqkkaMr8ZTSPCYAGUudn5ZbEG4uRwyzFQE61a9UyhK7Je/CaGoydNs8lvQq4C1pNtMOTLI2NoyHO5XeaFj+F1ZuUR6q5NQrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(336012)(70206006)(2616005)(70586007)(8936002)(4326008)(6666004)(2906002)(6916009)(83380400001)(186003)(356005)(81166007)(54906003)(86362001)(16526019)(426003)(36860700001)(47076005)(26005)(44832011)(8676002)(82310400003)(36756003)(316002)(5660300002)(1076003)(478600001)(7696005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 04:07:55.2151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0033b16b-33cf-4ac6-89d3-08d9517d46f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1782
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Fence driver was enabled per ring when sw init on per IP block before.
Change to enable all the fence driver at the same time after
amdgpu_device_ip_init finished.
Rename some function related to fence to make it reasonable for read.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d3a4299b1f30..77195a4e5c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3675,6 +3675,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto release_ras_con;
 	}
 
+	amdgpu_fence_driver_hw_init(adev);
+
 	dev_info(adev->dev,
 		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
@@ -3939,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
 
-	amdgpu_fence_driver_suspend(adev);
+	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
 	/* evict remaining vram memory
@@ -3984,7 +3986,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		return r;
 	}
-	amdgpu_fence_driver_resume(adev);
+	amdgpu_fence_driver_hw_init(adev);
 
 
 	r = amdgpu_device_ip_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 72d9b92b1754..e2f606bca779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -417,9 +417,6 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 	}
 	amdgpu_fence_write(ring, atomic_read(&ring->fence_drv.last_seq));
 
-	if (irq_src)
-		amdgpu_irq_get(adev, irq_src, irq_type);
-
 	ring->fence_drv.irq_src = irq_src;
 	ring->fence_drv.irq_type = irq_type;
 	ring->fence_drv.initialized = true;
@@ -572,14 +569,14 @@ void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_fence_driver_suspend - suspend the fence driver
+ * amdgpu_fence_driver_hw_fini - disable the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
  *
- * Suspend the fence driver for all possible rings (all asics).
+ * Disable the fence driver for all possible rings (all asics).
  */
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
@@ -603,18 +600,18 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_fence_driver_resume - resume the fence driver
+ * amdgpu_fence_driver_hw_init - enable the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
  *
- * Resume the fence driver for all possible rings (all asics).
+ * Enable the fence driver for all possible rings (all asics).
  * Not all asics have all rings, so each asic will only
  * start the fence driver on the rings it has using
  * amdgpu_fence_driver_start_ring().
  * Returns 0 for success.
  */
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e7d3d0dbdd96..64471018f5e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -117,8 +117,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
 				   unsigned irq_type);
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev);
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
