Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ADDC001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBE410E7E0;
	Fri, 14 Jul 2023 07:16:18 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D0A10E101
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 03:54:53 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R2Hfy3kqBzBRSVn
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 11:54:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689306890; x=1691898891; bh=iTXZlIcRdyK6o3+wDm/UapfqCgm
 g6WekFBy6SQamdR0=; b=Nok34jzjPVafwrRrSRNa78LuU/gf5f63GOJ39mTJ7LC
 cobjTiBXs/8nOmpsUZTvDxOmIOo+7cx3cgGhuNz+U6Zc9NAB9rxq8S3dirFxlHCm
 7q87gKe04TpTQyfgHXfr/j7fP5RI4lbtjUqdfSNyru0rVZu7eN2riO0thnxCXBWy
 QHOI5tpTRy7twmcJUwFVCoCw/8CGybNDafhtqyzTVZ4BGt5xDsVH2zWKL7G25Ftn
 VLZCqOmCi1vEKOJtWyB3aosMjId51PyLTtyhTC/DzP7YuQvG1I+rsWxEA7rVm6bE
 +HcDd8XtTtwu5YbLWQ0iJAjsc1uQ072hQzlwOJHdzLg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id p7wo_brvv1KP for <amd-gfx@lists.freedesktop.org>;
 Fri, 14 Jul 2023 11:54:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R2Hfy0G1bzBR7b2;
 Fri, 14 Jul 2023 11:54:50 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 11:54:49 +0800
From: shijie001@208suo.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: ERROR: that open brace { should be on the
 previous line
In-Reply-To: <tencent_996261255FBE1BF185353D65C90BFB5FDF0A@qq.com>
References: <tencent_996261255FBE1BF185353D65C90BFB5FDF0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8d7c6d7599c0f56403c920985f646e34@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 14 Jul 2023 07:16:15 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix eight occurrences of the checkpatch.pl error:
ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that close parenthesis ')'
ERROR: spaces required around that '?' (ctx:VxW)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/sumo_dpm.c | 18 ++++++++----------
  1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c 
b/drivers/gpu/drm/radeon/sumo_dpm.c
index f74f381af05f..8af793c89fd1 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.c
+++ b/drivers/gpu/drm/radeon/sumo_dpm.c
@@ -33,8 +33,7 @@
  #define SUMO_MINIMUM_ENGINE_CLOCK 800
  #define BOOST_DPM_LEVEL 7

-static const u32 sumo_utc[SUMO_PM_NUMBER_OF_TC] =
-{
+static const u32 sumo_utc[SUMO_PM_NUMBER_OF_TC] = {
      SUMO_UTC_DFLT_00,
      SUMO_UTC_DFLT_01,
      SUMO_UTC_DFLT_02,
@@ -52,8 +51,7 @@ static const u32 sumo_utc[SUMO_PM_NUMBER_OF_TC] =
      SUMO_UTC_DFLT_14,
  };

-static const u32 sumo_dtc[SUMO_PM_NUMBER_OF_TC] =
-{
+static const u32 sumo_dtc[SUMO_PM_NUMBER_OF_TC] = {
      SUMO_DTC_DFLT_00,
      SUMO_DTC_DFLT_01,
      SUMO_DTC_DFLT_02,
@@ -109,11 +107,11 @@ static void sumo_mg_clockgating_enable(struct 
radeon_device *rdev, bool enable)
      local1 = RREG32(CG_CGTT_LOCAL_1);

      if (enable) {
-        WREG32(CG_CGTT_LOCAL_0, (0 & CGCG_CGTT_LOCAL0_MASK) | (local0 & 
~CGCG_CGTT_LOCAL0_MASK) );
-        WREG32(CG_CGTT_LOCAL_1, (0 & CGCG_CGTT_LOCAL1_MASK) | (local1 & 
~CGCG_CGTT_LOCAL1_MASK) );
+        WREG32(CG_CGTT_LOCAL_0, (0 & CGCG_CGTT_LOCAL0_MASK) | (local0 & 
~CGCG_CGTT_LOCAL0_MASK));
+        WREG32(CG_CGTT_LOCAL_1, (0 & CGCG_CGTT_LOCAL1_MASK) | (local1 & 
~CGCG_CGTT_LOCAL1_MASK));
      } else {
-        WREG32(CG_CGTT_LOCAL_0, (0xFFFFFFFF & CGCG_CGTT_LOCAL0_MASK) | 
(local0 & ~CGCG_CGTT_LOCAL0_MASK) );
-        WREG32(CG_CGTT_LOCAL_1, (0xFFFFCFFF & CGCG_CGTT_LOCAL1_MASK) | 
(local1 & ~CGCG_CGTT_LOCAL1_MASK) );
+        WREG32(CG_CGTT_LOCAL_0, (0xFFFFFFFF & CGCG_CGTT_LOCAL0_MASK) | 
(local0 & ~CGCG_CGTT_LOCAL0_MASK));
+        WREG32(CG_CGTT_LOCAL_1, (0xFFFFCFFF & CGCG_CGTT_LOCAL1_MASK) | 
(local1 & ~CGCG_CGTT_LOCAL1_MASK));
      }
  }

@@ -702,9 +700,9 @@ static void sumo_post_notify_alt_vddnb_change(struct 
radeon_device *rdev,
      u32 nbps1_new = 0;

      if (old_ps != NULL)
-        nbps1_old = (old_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE)? 1 : 0;
+        nbps1_old = (old_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE) ? 1 : 0;

-    nbps1_new = (new_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE)? 1 : 0;
+    nbps1_new = (new_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE) ? 1 : 0;

      if (nbps1_old == 0 && nbps1_new == 1)
          sumo_smu_notify_alt_vddnb_change(rdev, 1, 1);
