Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4594C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 02:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C81D89BD4;
	Wed, 24 Nov 2021 02:43:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889CA89BD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 02:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHQ6zvoewGQ8sXu8HA+k/LrXeBa34B4368pMNkhDuBnb/xPi8bMenRtbL0eMpRvRkQMVo+WdRSiGfLMkzkCd13n++A03DByT3TL5ZigcHJPLEocgghpvI8dNXO4vvjM92lzSaQwx2t12epFLAg83aWqSHFHpVQhIGdmOW+dyPNnddkuomGrATkZBP3OpoRKVmla9LvAXMj9m3aUHnEbE7m/HvUoF68jgQaT4FlAeEKHONPfSGSwldoApzBdpCdUU/R0JWfwX/KbPnNXTnabr+MOaQFGWb6zmzi6UVthVV6hpwKA4xBYwdaiFk9ow1fGO1M1g38m2MuCPo4f9ENZ/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaHy5S1/q+DliYZpUYL9TYQ5ik74/qqpr8Ugxjtuj3o=;
 b=mFufF8A9U+Nj9A/OKW9LRPxFdoSXsTapEFw3yijZtPrGV19Z6zPjPbIJxjOrrTrUcYBmdqjnF3VLyuv1v10wCPUduj6Y1VThoFLdFCW+tmcPGsOy5LdR3vyiHjEpD64/zEnvphfobSLw8u+5x0TCAUerjlRDNmBTv560KQAUz0tng+8LTr6F1BJ9wOiU+U7qhgekBdGgwm3wjPCyG4bC9qE8/GQ3d4BnYiPJ4szXhP1g5ugJobRJvqXzgbyxAL45q8UxJYKkaD5Gn7hNb7EWZgWM3ub8jrI6h3ahkfqVacRrmUhOZqrZ7iot9qu1TLnGJ9MAoC/+EY8cMdj0DfAJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaHy5S1/q+DliYZpUYL9TYQ5ik74/qqpr8Ugxjtuj3o=;
 b=ZlH3bd6vGf+wiGcwlK5feVgWTRcrZgzXFBobF9QwRlLWQ/t59PKwTzB+JCk3iJoSkfZZeUuPayksGkW4TgIiMK/ga/SKzU/9mdFkxWKZa09QituunJ1/aG2su/l5E7ZiSNwpQXaekulPWf+BwBZ/3seG0HQiyQsOf4tFxCu4vw8=
Received: from BN8PR12CA0034.namprd12.prod.outlook.com (2603:10b6:408:60::47)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 02:43:22 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::a6) by BN8PR12CA0034.outlook.office365.com
 (2603:10b6:408:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Wed, 24 Nov 2021 02:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 02:43:21 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 20:43:16 -0600
From: Flora Cui <flora.cui@amd.com>
To: <guchun.chen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix vkms crtc settings
Date: Wed, 24 Nov 2021 10:43:01 +0800
Message-ID: <20211124024302.1493100-2-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211124024302.1493100-1-flora.cui@amd.com>
References: <20211124024302.1493100-1-flora.cui@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ba5132e-e61e-4748-3e33-08d9aef42e2f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5218:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5218E0724B9C566DB5DAB14DFA619@CH0PR12MB5218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaG1uhS6a0pDN1ldPiT8VDeNDnvmOK0Yx1IlS6cP1Z4+PUlI1FDw6YENAQOip+hP3o6bGO/yw3lUsV+k85/YrtqroG4X2qZnjCIAbrG9fk9rGhRNG1Tw1SJldKZgtThzVB5GiSsf1src5oDECl+xN8gpfGo5Bsnwsyzn67JxJciXeqJAuMqadzF84EftekTtxetXcDRxzJxGdNvfmNCDiDa3RO0m3+/zv2qrNxm1s7lckeqGuTuIWWnPw6Y/p3bUz9pBXYimpdTpBhEdXDzWpFWcegtWzKn2o1fP4rHkhqmYWBjJsfklOdXVUrdkBEiCccT4KXqBuD2nqAMyXtRgNYvKkXVhg/E8286MbmuAWp9sOeAKVMEe+3dUXmMHLzhLEa5M5+E5yfYUUb07kJAOPxqfIkv3OZrDfyW6OjiySjSp2SHOC2kemK4i4YR/vUf0sTlfYGIV2zClhXm9pkFccDnMVdOktDY6hMy7x5t+2TenHf48WCdcABSHN/nVFFs2JMOsWxrOOwLVzSWEz/GlgFekx9vOjta9qzund6li892h68kxaPcJotFJbrX99yY/u4lrO3u47Rfa7beinWpzB/3I1oafBBsgGOJ1LNGAE43nZyH0bX69d/RL7Lu/LKC533rHh3VX30AmD4ve7cn3VgXqTpdKXe02xWwzsIDJanMZlybpiTw1tId5NqXPrbd4uwZd7cfF+W8gVX2vt5XdoRawlB0QcfnzkBmIMjHhRjknGcuEqnppiFtN2D0LrjTN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(36756003)(2906002)(336012)(4326008)(6666004)(81166007)(36860700001)(356005)(5660300002)(1076003)(8676002)(44832011)(2616005)(70206006)(508600001)(47076005)(110136005)(83380400001)(8936002)(70586007)(316002)(86362001)(16526019)(186003)(82310400004)(6636002)(7696005)(26005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 02:43:21.4320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba5132e-e61e-4748-3e33-08d9aef42e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise adev->mode_info.crtcs[] is NULL

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 42 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |  5 ++-
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index ac9a8cd21c4b..6c62c45e3e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -16,6 +16,8 @@
 #include "ivsrcid/ivsrcid_vislands30.h"
 #include "amdgpu_vkms.h"
 #include "amdgpu_display.h"
+#include "atom.h"
+#include "amdgpu_irq.h"
 
 /**
  * DOC: amdgpu_vkms
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] = {
 
 static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 {
-	struct amdgpu_vkms_output *output = container_of(timer,
-							 struct amdgpu_vkms_output,
-							 vblank_hrtimer);
-	struct drm_crtc *crtc = &output->crtc;
+	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
+	struct drm_crtc *crtc = &amdgpu_crtc->base;
+	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	u64 ret_overrun;
 	bool ret;
 
-	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
+	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
 	WARN_ON(ret_overrun != 1);
 
@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *crtc)
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function = &amdgpu_vkms_vblank_simulate;
 	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
+	hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns, HRTIMER_MODE_REL);
 
 	return 0;
 }
 
 static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
-	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
@@ -92,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 	unsigned int pipe = crtc->index;
 	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	if (!READ_ONCE(vblank->enabled)) {
 		*vblank_time = ktime_get();
 		return true;
 	}
 
-	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
+	*vblank_time = READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);
 
 	if (WARN_ON(*vblank_time == vblank->time))
 		return true;
@@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
 static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 			  struct drm_plane *primary, struct drm_plane *cursor)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int ret;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
@@ -176,6 +179,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);
 
+	amdgpu_crtc->crtc_id = drm_crtc_index(crtc);
+	adev->mode_info.crtcs[drm_crtc_index(crtc)] = amdgpu_crtc;
+
+	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
+	amdgpu_crtc->encoder = NULL;
+	amdgpu_crtc->connector = NULL;
+	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
+
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	amdgpu_crtc->vblank_timer.function = &amdgpu_vkms_vblank_simulate;
+
 	return ret;
 }
 
@@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,
 {
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
-	struct drm_crtc *crtc = &output->crtc;
+	struct drm_crtc *crtc = &output->crtc.base;
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
 
@@ -504,8 +518,8 @@ static int amdgpu_vkms_sw_fini(void *handle)
 	int i = 0;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++)
-		if (adev->amdgpu_vkms_output[i].vblank_hrtimer.function)
-			hrtimer_cancel(&adev->amdgpu_vkms_output[i].vblank_hrtimer);
+		if (adev->mode_info.crtcs[i])
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	kfree(adev->mode_info.bios_hardcoded_edid);
 	kfree(adev->amdgpu_vkms_output);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
index 97f1b79c0724..4f8722ff37c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
@@ -10,15 +10,14 @@
 #define YRES_MAX  16384
 
 #define drm_crtc_to_amdgpu_vkms_output(target) \
-	container_of(target, struct amdgpu_vkms_output, crtc)
+	container_of(target, struct amdgpu_vkms_output, crtc.base)
 
 extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;
 
 struct amdgpu_vkms_output {
-	struct drm_crtc crtc;
+	struct amdgpu_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
 };
-- 
2.25.1

