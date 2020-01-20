Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 12:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C9820678
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 12:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgpPf903"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C9820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1136E932;
	Mon, 20 Jan 2020 12:56:32 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221436E932
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 12:56:31 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y11so29449022wrt.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BYslVAlb5WtLl14xKK6aLgiQDKa9WycMq5rV5+HK7ag=;
 b=UgpPf903g/uMBK0S20F0x/ycgHXwck5qYxyCBvdXlBHBVNw+fVcgf1qIpEsIaU1UdP
 FPsnxHHPGliaw4vh6WfS7T16JIXUyOe+u7aubiMd/iXsgiFGPMxaq+cP4i7fCcfNVHRi
 hXPx8WTIAe5f9ysQ87PC5Wx9YrtvLT3/kLGS4uVXNZSF1O2etqeCBUgVlfFtmTcblun6
 qucNnBOpEIQXA/g6X3yS4wgtGI0sVEKAMZsJ9ZYMtvNmjjHuQ/8Jt0LreUANyWubg6q+
 7J35BpdYO9W0eL4mc48WsGWsi3MwZbhLDeGX7Exgb/WeN3zuHFQtDrryrHL/i3wVcVTI
 a42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BYslVAlb5WtLl14xKK6aLgiQDKa9WycMq5rV5+HK7ag=;
 b=oAqRLFEhKNfQTg1r5iogkeQWEmepom6tbQ8uN0BoBgTx5msqnrxbky7cKKMAUfMFRt
 Gq5ZgqJwFWxpwdxUIpMoaGWvKnzc0Pxzu29wvsvmRb2YBeLru4XoyLRcExGhdmYWoywZ
 R9ex+0R21CR66UqWFKsYXORGcHNQ0STXi9XGBb8d4c0MtrB8thPM5zk5R3fjw9vXoYqa
 Q22mK1JPIpp4sXsurujBr4hBM5Gcl/Wg9Q8DFSUCvsnXgsFKhVbDYyyuhmqwjM3Raspl
 H8dbC3yNaAC/BIKThiNP0Yu+/mzkISgpbZhSXxpGOdcbcSTbmAYPBJPkdCEMqBroMBAl
 sb1A==
X-Gm-Message-State: APjAAAXNFL1c0c4kD7Gsz5tHP8t6G0mVTrYIXP6twe4oXKSJNFtJvO0y
 +/i1RK3zr4LSW14aMEwm8+QVXc92B6o=
X-Google-Smtp-Source: APXvYqyI8t51eyWEQdmErhnpC8s0ylUwDVdxEoKcm7fH+sNJyEbpHRtiW4MYg2zzZwRFDTlUwBmhfg==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr18610167wrp.182.1579524989025; 
 Mon, 20 Jan 2020 04:56:29 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F25000097A4C6C4F4A6FD0B.dip0.t-ipconnect.de.
 [2003:c5:8f25:0:97a4:c6c4:f4a6:fd0b])
 by smtp.gmail.com with ESMTPSA id d12sm48368565wrp.62.2020.01.20.04.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 04:56:28 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu:  remove unnecessary conversion to bool
Date: Mon, 20 Jan 2020 13:58:06 +0100
Message-Id: <20200120125806.4895-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  8 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 28 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
 25 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 82155ac3288a..12247a32f9ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -527,7 +527,7 @@ static int acp_set_powergating_state(void *handle,
 				     enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = state == AMD_PG_STATE_GATE ? true : false;
+	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev->powerplay.pp_funcs &&
 		adev->powerplay.pp_funcs->set_powergating_by_smu)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f58ec9edb73f..1da03658891c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -986,7 +986,7 @@ static void amdgpu_device_check_vm_size(struct amdgpu_device *adev)
 static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
 {
 	struct sysinfo si;
-	bool is_os_64 = (sizeof(void *) == 8) ? true : false;
+	bool is_os_64 = (sizeof(void *) == 8);
 	uint64_t total_memory;
 	uint64_t dram_size_seven_GB = 0x1B8000000;
 	uint64_t dram_size_three_GB = 0xB8000000;
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
index d9cc746af5e6..847ca9b3ce4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
@@ -74,9 +74,9 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_VEGA20:
 	case CHIP_RAVEN:
 		athub_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		athub_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index ceb9aa4df0e7..921a69abda55 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -77,9 +77,9 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		athub_v2_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		athub_v2_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 18d79e83ef3f..e55a2c058cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4230,7 +4230,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_PG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_PG_STATE_GATE);
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
@@ -4256,7 +4256,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		gfx_v10_0_update_gfx_clock_gating(adev,
-						 state == AMD_CG_STATE_GATE ? true : false);
+						 state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3a841dc20474..33e851ad4943 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4652,7 +4652,7 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_PG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_PG_STATE_GATE);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -4714,7 +4714,7 @@ static int gfx_v9_0_set_clockgating_state(void *handle,
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
 		gfx_v9_0_update_gfx_clock_gating(adev,
-						 state == AMD_CG_STATE_GATE ? true : false);
+						 state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index a78292d84854..ff2e6e1ccde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -690,7 +690,7 @@ static int jpeg_v2_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		if (jpeg_v2_0_is_idle(handle))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 2c58939e6ad0..c6d046df4b70 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -469,7 +469,7 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index adfd8a6171eb..49a3a56ec017 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -523,9 +523,9 @@ int mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		mmhub_v1_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		mmhub_v1_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index a7cb185d639a..bde189680521 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -427,9 +427,9 @@ int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index a32c9757711f..a5281df8d84f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -625,9 +625,9 @@ int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
 		mmhub_v9_4_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		mmhub_v9_4_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f737ce459c28..cf557a428298 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -426,7 +426,7 @@ static int navi10_ih_set_clockgating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	navi10_ih_update_clockgating_state(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2e0f8933410e..2d1bebdf1603 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -950,13 +950,13 @@ static int nv_common_set_clockgating_state(void *handle,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		nv_update_hdp_mem_power_gating(adev,
-				   state == AMD_CG_STATE_GATE ? true : false);
+				   state == AMD_CG_STATE_GATE);
 		nv_update_hdp_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 2ce30a8faed8..7cea4513c303 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2176,9 +2176,9 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
 		sdma_v4_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		sdma_v4_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 3912937f878f..7ee603db8c57 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1525,9 +1525,9 @@ static int sdma_v5_0_set_clockgating_state(void *handle,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		sdma_v5_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		sdma_v5_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 9ad85eddf9c4..7f64d73043cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -648,7 +648,7 @@ static int si_dma_set_clockgating_state(void *handle,
 	bool enable;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 317803f6a561..af41ee4c9639 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1467,38 +1467,38 @@ static int soc15_common_set_clockgating_state(void *handle,
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_hdp_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_rom_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		adev->df.funcs->update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_hdp_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		soc15_update_rom_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
 		soc15_update_hdp_light_sleep(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 01e62fb8e6e0..0fa8aae2d78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -763,7 +763,7 @@ static int uvd_v5_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 217084d56ab8..e0aadcaf6c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1421,7 +1421,7 @@ static int uvd_v6_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 475ae68f38f5..217db187207c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -739,7 +739,7 @@ static int vce_v3_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
 	if (!(adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG))
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 683701cf7270..3fd102efb7af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -887,7 +887,7 @@ static int vce_v4_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
 	if ((adev->asic_type == CHIP_POLARIS10) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e654938f6cca..1a24fadd30e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1346,7 +1346,7 @@ static int vcn_v1_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f4db8af6536b..b8dc136d2a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1213,7 +1213,7 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index c8b63d57a541..6970d3a1ae6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1663,7 +1663,7 @@ static int vcn_v2_5_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index d9e331084ea0..407c6093c2ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -717,7 +717,7 @@ static int vega10_ih_set_clockgating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	vega10_ih_update_clockgating_state(adev,
-				state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 	return 0;
 
 }
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
