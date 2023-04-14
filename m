Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3DAC77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 16:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC1910E1C4;
	Fri, 14 Apr 2023 16:22:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFB310E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 16:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qds4wsrmRXXP076udxBOOL1bDxH3AyRvvXZPmHQtiVOH0FVkspMyQI36b1o7EcNiREu4w+FRNPJehdHqL0PuBE/VW2Gxkfcg5IL3cptYEDoyPKY5/7TzZZkwgYhdt13I2AanQOVV2HuqCfFUHKMbUUGwlW6cFS3eT7byfkOo2Q3tJpkzu0R/4qPIFX3kb2Smmy8YlVMWDemJOW9S0ff/ad3BTMMOKLjD0RzeGjflzl14KkkXCuGgNiwDEzurEqSq2pO7ZVNzeep6Zjb2yuE5vfgq7KgRo2PopXQ4ggzO+Ee3IWHjso8FuFovFti2OjwUZyy5HzCTvkXXR6YXo6l/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbBIeG1D/Ah/zvR81eWPOgB1XCPvWfws96ju0nxMEmk=;
 b=LZMK0F0T3V86Z0IDm2+j1BJW9i0wOE/H9h++Uv4r+0qJIeTXi6Zfuq0IfWuh+cNSPfvjEQEw9JU8CTn7Ll80D0CL/Rn8O40OGPFmv4WDLvyIucpgphGjEWYmhz41uEthSG3zz1nmKBRYQZnVyZni6wHuAxiXnK6W85bDMEUmMAp5g/4W67SELM/zmMzv30WrMDnpFQmYABJq2pXClO/eY7yi5JNUoLPBvXFv4VsA9/w9HHPpAISxq8Y0MRcDanPaFUOh/0L7RZ59jf/PglLgIjU+6+OJzj2hnw8RMRbr1L4JHfX8YTnFqil7v6XO6mR+Fg5tV8yzOQIPkYtxDHg4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbBIeG1D/Ah/zvR81eWPOgB1XCPvWfws96ju0nxMEmk=;
 b=W/YDbifRYUUkyUYTTlTzCDauO80ejqO7B5yF3SG6hT+as/E095JXhQdHFlB0KtxY54MMliRw/g/Q+aQtLCUMCb1qUJzJ1mh+TwdB2bzEObKOyH3z7sqEh+RLB6SmCEr1wU33KMUDivd2E6oAP/hWdfoyNMZZLaWWAhwHeViSNWg=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 16:22:20 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::99) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 16:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 16:22:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 11:22:19 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 14 Apr 2023 11:22:18 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Date: Sat, 15 Apr 2023 00:22:15 +0800
Message-ID: <20230414162215.1201883-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|BN9PR12MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dded82-8ca3-4d47-4dd6-08db3d046bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xq+YUre4gdrUZTsESm5jb9NnutwqWt13koUXZjzC/p559aoAFFz7siFg20w3Z2fBaH7z+HAUF/0od1liwHjT0q78u3LTnei2YOB9zsLc7F3slYYkWJBGOrHABbakK9unG94riUSMzAauBCapwpemSgYdfhfoh58i/uIR543YzkezksCk8fBxetTPZluz5w1utANpp20e4ALFouJhQYiUNRlQTFFUi6DauDkW81L/lph07zbb87xehphlRO6k48VDyOxwD4C10gpCIJXKmcKWCrJeQRTj6ihUj1LH9VcSPvWdp+2XIlIjBbrv99mQi53rBesfQKruoQmqZh4JflNl80m2+ojJwUGmZ/RXx5lE9I78twd/oNMALhR4VMBNA5+/xNjKsDD1mneSj/XHOu4rK/NcZ7xtaOEAtunvmITBgVs9mqp+NUa7dhOnt48Y1sDWELbE55ug9lL78FhbkyzJU0NCUbw+Mg/GvVaDGun0cxPkYxug0YqL1fBauCa+pUgzB9WtR7g7jveIr8VIrX0mJIlrXSsRh/ozdg0/SggJOjyoMoIP5rfQpA1cSxqJFL6JR/P+TsU3rHnhNw0lV939dovz2opH25pKsoRWjWA5l9kxWsplPHOSSBX4RKlzXF+bDeViD9S4emmm6QuFUIu3pgsjxgzSJwPKyHyxDevG/p7DTZEX9uOKLJiIInd8EQejNPLtawdzriHMrgIn2qtIv/6To32oIo0e5YOTTzRubUA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(26005)(36860700001)(5660300002)(36756003)(2906002)(316002)(40480700001)(86362001)(8936002)(8676002)(81166007)(4326008)(6916009)(40460700003)(41300700001)(82310400005)(82740400003)(356005)(426003)(1076003)(70206006)(336012)(47076005)(70586007)(83380400001)(2616005)(54906003)(186003)(7696005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 16:22:19.9774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dded82-8ca3-4d47-4dd6-08db3d046bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
Cc: Alan Liu <HaoPing.Liu@amd.com>, bhawanpreet.lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
After gpu-reset, sometimes the driver would fail to enable vblank irq,
causing flip_done timed out and the desktop freezed.

During gpu-reset, we will disable and enable vblank irq in dm_suspend()
and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
will check irqs' refcount and decide to enable or disable the irqs
again.

However, we have 2 sets of API for controling vblank irq, one is
dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
its own refcount and flag to store the state of vblank irq, and they
are not synchronized.

In drm we use the first API to control vblank irq but in
amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.

The failure happens when vblank irq was enabled by dm_vblank_get()
before gpu-reset, we have vblank->enabled true. However, during
gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
checked from amdgpu_irq_update() is DISABLED. So finally it will disable
vblank irq again. After gpu-reset, if there is a cursor plane commit,
the driver will try to enable vblank irq by calling drm_vblank_enable(),
but the vblank->enabled is still true, so it fails to turn on vblank
irq and causes flip_done can't be completed in vblank irq handler and
desktop become freezed.

[How]
Combining the 2 vblank control APIs by letting drm's API finally calls
amdgpu_irq's API, so the irq's refcount and state of both APIs can be
synchronized. Also add a check to prevent refcount from being less then
0 in amdgpu_irq_put().

v2:
- Add warning in amdgpu_irq_enable() if the irq is already disabled.
- Call dc_interrupt_set() in dm_set_vblank() to avoid refcount change
  if it is in gpu-reset.

Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c         |  3 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 17 ++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index a6aef488a822..c8413470e057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 	if (!src->enabled_types || !src->funcs->set)
 		return -EINVAL;
 
+	if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
+		return -EINVAL;
+
 	if (atomic_dec_and_test(&src->enabled_types[type]))
 		return amdgpu_irq_update(adev, src, type);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 1d924dc51a3e..514fefef109d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -169,10 +169,21 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (rc)
 		return rc;
 
-	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+	if (amdgpu_in_reset(adev)) {
+		irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+		/* During gpu-reset we'll disable and then enable vblank irq,
+		 * so don't use amdgpu_irq_get/put() to avoid refcount change.
+		 */
+		if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+			rc = -EBUSY;
+	} else {
+		rc = (enable)
+			? amdgpu_irq_get(adev, &adev->crtc_irq, acrtc->crtc_id)
+			: amdgpu_irq_put(adev, &adev->crtc_irq, acrtc->crtc_id);
+	}
 
-	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
-		return -EBUSY;
+	if (rc)
+		return rc;
 
 skip:
 	if (amdgpu_in_reset(adev))
-- 
2.34.1

