Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD04C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4311924695
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OncOEBWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4311924695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3F36E187;
	Mon,  2 Mar 2020 09:22:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71226E187
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkh/Qc3hgT8g02XSxaHw+/vZYO8fZdkwmOR3k66k7mo4YRnSLAQ96gfstNZ8KqYl+H4niUKEJ/p8gwz94Rxxs0LUGBRXgfIBNGyeideKgV24NnBLTwmpsCLEGjBIaO5UbaDDZyS2ce0XWed0utM0h/MwxLUvLIT2Yam6ddQmnRCKTeUIcLW42HbTPSgbaBrVRBaeVQCRalcO9cNGUfz/kmzoz0kbb/OOYG87tx/NmU5yiQF6wMitVAsM2ps+so+8FmwDmUgknacTke6MmoL46qseC6K3GnYjGohZkSCgs8iZ1rlTRHlY6HNLLzZEJX+Cyd5goXE+OWZGH0cfdoXz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf/G4MakJmND6fYtak+6tWKx4aQWZMd4r+Ocb+31tfs=;
 b=iu6svjTwGJ/2M1AiRqwNOIpHkQLAXddPWRuaf2CLPSNUm89jz9xFagmNmld5zn3H1XRDFsdvCabUMfe3XF4IdAc6zZlDJ+OxQh14oI0e1VXwChoeWKbym5Ms9GgYvYJ2DW4BEV0L6KZ3Drbv7Q5nT5wT0WbtUYasjPlAciBTBqMOQ/dnn2kDKTiYxx7a0aetxmYVsdDtN9rkNuzbVY+4vCihLuHKmsjEORXvKaS4so6TGfAsn8zYiI8BLQ4z60VXIqowyC1QVCo9myqcVprVwvu14nzPGt2ycdoaCqEAiWJu/COjXYKfxOfaCvO+Vsn04ShbrthLFar9TuHlNrRW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf/G4MakJmND6fYtak+6tWKx4aQWZMd4r+Ocb+31tfs=;
 b=OncOEBWsTcAydrUzCeXstK/ltDn7KUJhA8s8lMGvQVjxZIBMP57LnATQBleAygCEh8DfT6Nux4Vb+Cglg/6DcLJM7wRIifJIQOGYieEoLJ7JlXqbn23vslsNTmJrXV0jGeyb5koGU6WJ2o+3/JX9uA4AUiACjzQjJur8MjotFvM=
Received: from BN6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:404:65::29)
 by MWHPR1201MB0272.namprd12.prod.outlook.com (2603:10b6:301:52::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 09:22:11 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::fa) by BN6PR17CA0019.outlook.office365.com
 (2603:10b6:404:65::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 09:22:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 09:22:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 03:22:10 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 03:22:09 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: fix IB test MCBP bug
Date: Mon, 2 Mar 2020 17:22:05 +0800
Message-ID: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(428003)(189003)(199004)(426003)(70586007)(7696005)(186003)(6916009)(70206006)(8936002)(478600001)(5660300002)(2616005)(36756003)(336012)(86362001)(8676002)(26005)(81166006)(81156014)(2906002)(356004)(4326008)(6666004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0272; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a03001f1-58db-4efb-a13c-08d7be8b3018
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02720126D3E837CF62DDA51884E70@MWHPR1201MB0272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNgHBpjfNH04POdHk92+ZP0qLzkWtdXKUFVfJMHvPuFa0yQTUnb0WEWAvDQAvgUxI/jTTg7y9QIT//t/MfWuyrDSgpM4kvf3HUqGBC2KYp0kU8YS5Sj6AL7N7sAXEwyUbl19wHE1k+NJxe//8ku7T43mEwSKnCTtLAWNUJIrwK50ww+oes/1EoIYBgNXgk0TLOWHwY/z2EmeczI+0mRxaLh5CxM/JNJvnu5EV7R5/JceWE4SSgDl3TnX4YTCqkKeo0avrJF5jHJjgM9oXbcpVOMKlTW2g7jUivq7N4+tRifbcmBy0mLyWqGayI0L4b9TBOswxqowqkL3Hd/jkI6LxliuqNplxMQzDDiOQic4WDepKiiPRUJSWk93WjWgCOMezdMKYeIjCmdhmI3wLcKzXqXj21ASqegQdZaiYaAD+4YRYNE92L36uAySJKAborVe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:22:11.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03001f1-58db-4efb-a13c-08d7be8b3018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1)for gfx IB test we shouldn't insert DE meta data

2)we should make sure IB test finished before we
send event 3 to hypervisor otherwise the IDLE from
event 3 will preempt IB test, which is not designed
as a compatible structure for MCBP

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 351096a..572eb6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3195,6 +3195,12 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
+	/* make sure IB test finished before entering exclusive mode
+	 * to avoid preemption on IB test
+	 * */
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_request_full_gpu(adev, false);
+
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized){
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0f35639..0b1511a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -88,9 +88,6 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev->rmmio == NULL)
 		goto done_free;
 
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_request_full_gpu(adev, false);
-
 	if (adev->runpm) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 94ca9ff..0555989 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4432,7 +4432,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 		if (flags & AMDGPU_IB_PREEMPTED)
 			control |= INDIRECT_BUFFER_PRE_RESUME(1);
 
-		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
+		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
 			gfx_v10_0_ring_emit_de_meta(ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 393a132..b14f46a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6116,7 +6116,7 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
-		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
+		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
 			gfx_v8_0_ring_emit_de_meta(ring);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0156479..d8d256e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4985,7 +4985,7 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
-		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
+		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
 			gfx_v9_0_ring_emit_de_meta(ring);
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
