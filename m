Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA39C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8EC2078D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDpeGhsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8EC2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698066E0D7;
	Mon,  8 Jun 2020 23:17:37 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E542E6E0D7;
 Mon,  8 Jun 2020 23:17:36 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D64B20842;
 Mon,  8 Jun 2020 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658256;
 bh=jq73E0XRcEVooUoKZS79XlgjeVA7SExlr3KiK8w//p4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XDpeGhsA5bJq8pwAyUC0d6oM0c7snxdeBp+qPRGMI1bonOsaNFARLN5K3t6AZA2CV
 Xw3clwMH8AIIuLPI7jM4dXG1/cFp2RE3UFUQsjQeE3f6e8S5pN9SYrwcgvSgk2N46e
 czmvJKf3j+39ejHv57Rj8ZT0kUEp1FtL6gI2iuYQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 265/606] drm/amdgpu: drop unnecessary
 cancel_delayed_work_sync on PG ungate
Date: Mon,  8 Jun 2020 19:06:30 -0400
Message-Id: <20200608231211.3363633-265-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Evan Quan <evan.quan@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 1fe48ec08d9f2e26d893a6c05bd6c99a3490f9ef ]

As this is already properly handled in amdgpu_gfx_off_ctrl(). In fact,
this unnecessary cancel_delayed_work_sync may leave a small time window
for race condition and is dangerous.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  6 +-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 12 +++---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 02702597ddeb..012df3d574bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4241,11 +4241,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-		if (!enable) {
-			amdgpu_gfx_off_ctrl(adev, false);
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-		} else
-			amdgpu_gfx_off_ctrl(adev, true);
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 906648fca9ef..914dbd901b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4734,10 +4734,9 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
-		if (!enable) {
+		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-		}
+
 		if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
 			gfx_v9_0_enable_sck_slow_down_on_power_up(adev, true);
 			gfx_v9_0_enable_sck_slow_down_on_power_down(adev, true);
@@ -4761,12 +4760,7 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 			amdgpu_gfx_off_ctrl(adev, true);
 		break;
 	case CHIP_VEGA12:
-		if (!enable) {
-			amdgpu_gfx_off_ctrl(adev, false);
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-		} else {
-			amdgpu_gfx_off_ctrl(adev, true);
-		}
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
