Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA54C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Apr 2023 11:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B9510E0CB;
	Tue, 18 Apr 2023 11:29:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6316F10E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Apr 2023 11:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxiAAD3imvPYG7PLBXnJbiLdWK3P3OSb/fjnB9J1yIrXvZkLeO03Y4vzFvj8CgZ6K0H3I2gLnGa6LDpvpQ/+oHMKnvfv0TZZfgbuP7ozDsGgbT6vlfQJQlVjKjpRHbLk0ttB7kX0IZRF58F997dwV4Fo3WAMllHhkokmFVYXi9Nmk5QmuqTyR7e/MLRK9bsL54ncIslTP4dcKTTPtv/AU5jUhv7f/ZBEVvH0Ocf2Ra08gmVZi5eShRD4YXnCaCGL/wR0XFc4HbkkV1jBhDZdetLtKIVEW1EjF5IYcY2c3MbdR1ogNOiAJgrOe68dhK559Y9gEq8jSG89zD09NMXHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr2YGKtgXU7qgEjorHd/W6g1M2zQn71sWqMGVkMSlnc=;
 b=FrCz3ACk47oUWjS8Jbr5C7GoNAPrkD/jlKfSyGU2ens4aUuVlnc/tCdsHx2awc8iinJ13RBS+7ADhTBqUepsHHDitRHu2a/ttaXgzgG3P/1kc2vbtAZC2dKDtuZgjCyDzKkOZUr5a/5ocITKdLEHkAZtO+4sKpW5oWDOs8Y5FABhMnBT62lARMYs8XqIHWz0ne9mJxNcpwtrH/St1MPBDD0MSmi7hWDurtJoFBN9aasBDJ/vTnTkdVFvyj5SR6Bn3C0iwqz2sdxNxqCwZIPdj7jMv8k6tguMB2/WoE0dLQDPviy7kpB46TpCLB9pNSTJG5gdZY0PcZiPjvOux+T/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr2YGKtgXU7qgEjorHd/W6g1M2zQn71sWqMGVkMSlnc=;
 b=qyXQy92O6+MheEqGJrt7e/P7JpemFTy3aCFQW67CPRXh5Uy5HQ37eEwcNyzuSq/GjAyMg0jxqsE+xk6YE1xFqMtdnTGMXCEkfSb3kgD8LmkFlWhU1M0F2aFLaZMbbdRc8U8+FNndD0PcL7gaHhnGnlUJVbkLYmRhSDwqOeSM+Fo=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:29:26 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::32) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 11:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:29:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 06:29:20 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 18 Apr 2023 06:29:19 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Fix desktop freezed after gpu-reset
Date: Tue, 18 Apr 2023 19:29:13 +0800
Message-ID: <20230418112913.1544565-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbe024a-d694-4cd0-8358-08db40002a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UG2niScpEmQHi7M1xxVhreUBEXjMpcjnKA/PcqEex82gF1iEJW+IURjRXFFuf2d5x2eNwANLqYBqjw4TCBbQlrqrEQPVqbOoUuRgpdJuxtNWzuGyAmP+p1SvtFBH/fIq2+6S2O6m/ShrIrHrTOQBejgdigIBRRpqh4r6jYpoPovVaGw+YbcKN48NnnTcABSs3T1Sf4nNnPT5DYSd6UmLCf3hVxB+sYPpgok9decQvuKgXsZNAJ9XcRqklcdfooOvlIufjkoU+LYelc3SSyPrPHfwkmSbSf/lKZLosD+dn9eP8TncoBKxSq6X44pdUh7lG6u1T/cIkO3BsXLy7o3vRSHvKtgxptKCPIg61VgRgqMP2erlcA/pv0UL6VQNYqRN45DO92dL73nmPOYMp0lPPz6YyLCzlZK+sCKU7t5iHhwgFhKRpEKS1DH8al1hdkzWMJHX7NSlVINXJ2FX7FAVgWwyvq6Pfdb4RgLaMlbM9z/XouMkYw24YuAUG4nzJo1rpLHVXHQ7fmGcoP0bOVkSXrr7Yevnj73EihQSF9ZXED/9YX7k8lpKF8DI6KQ/A9TwvIvpyfe9GtPtbc15jwvXKoGnH8aFTeFHWpxdNAjmmQnV+ef0zLcThRMFP9d7ViW6PhqlEvScDWWxfAUTzC2keeLLkrIZUguME95QyiqLumHuOky2aZNA0LP4hRjvP+fM28+HZW5J6++KkCoLmQfnXdzdvI9QF3sEYg1PdP+KskY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(4326008)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(6916009)(70206006)(70586007)(40480700001)(81166007)(54906003)(356005)(40460700003)(186003)(36756003)(2906002)(1076003)(336012)(26005)(426003)(86362001)(83380400001)(47076005)(82310400005)(36860700001)(2616005)(5660300002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:29:26.0436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbe024a-d694-4cd0-8358-08db40002a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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
After gpu-reset, sometimes the driver fails to enable vblank irq,
causing flip_done timed out and the desktop freezed.

During gpu-reset, we disable and enable vblank irq in dm_suspend() and
dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we check
irqs' refcount and decide to enable or disable the irqs again.

However, we have 2 sets of API for controling vblank irq, one is
dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
its own refcount and flag to store the state of vblank irq, and they
are not synchronized.

In drm we use the first API to control vblank irq but in
amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.

The failure happens when vblank irq was enabled by dm_vblank_get()
before gpu-reset, we have vblank->enabled true. However, during
gpu-reset, in amdgpu_irq_gpu_reset_resume_helper() vblank irq's state
checked from amdgpu_irq_update() is DISABLED. So finally it disables
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

v3:
- Improve commit message and code comments.

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
index 1d924dc51a3e..e3762e806617 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -169,10 +169,21 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (rc)
 		return rc;
 
-	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+	if (amdgpu_in_reset(adev)) {
+		irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+		/* During gpu-reset we disable and then enable vblank irq, so
+		 * don't use amdgpu_irq_get/put() to avoid refcount change.
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

