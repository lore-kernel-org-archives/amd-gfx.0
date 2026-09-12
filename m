Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF27C88E6D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 07:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8083910EBB8;
	Mon, 14 Sep 2026 07:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDnVStjn";
	dkim-atps=neutral
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE76010F73D
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 02:30:40 +0000 (UTC)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a49a10ee5aso1217141fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 19:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789180238; cv=none;
 d=google.com; s=arc-20260327;
 b=bwapj93qSKpvw8jBT5IWrQDvRdQ4ZSvboR1KdY9rPmPANTWXSnFLU1blcWksMb6idw
 jkXfSflYJqDAzoo2LnjXjQ6O/R82eAzxkPJwzmE/imRjRO9PVxLfGZ9iP8Sz72++EoT9
 Yyo+ZubM8j5PNtV88fndbMUEd+eipAWW6fxxap9hGcbemnTXwzqZ9oOna0cLgfrXeBnn
 5RRscAWFp2pJVsxmoZw/VBvuI0Qygg5DIjtLA4sVRaMmjPEEOMnmex5uL1Yo7ROJVEs1
 RXhluYONGdAWGa4e0gGwppXEdu9OmJ/fGhRdwaFouCzzPsZDbWyBLCVGySAHgdPYQ/Bk
 ecQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=LhlEYDWQpemuIMnWvpMSCy+QwKP38TCR3oYFVMnKb9A=;
 fh=OjGPIe5FcUd88TiOtm/FAPQQ6rjxBRqpM62kItB6HJg=;
 b=Ehn57C+BEG2wvobgvzn+jwMba2vdCVGb+1a9VC/i2X/tuSaU5jzvlGeCh+/D9h9eQU
 dqkxSBy5xSE+0Kbe6dv5EEt1piVZlZXNYTAe3bDRqmxCknDKIDwtgXxQ8LPM8rWiWzJN
 xZbuPhMMcC7zTdKVKMCQsqpeEEwwUexYrgKCZ0Q6UNdUratf5L7h1Q/PkPHE2Ok+Nd2U
 tauDWtLU6ren5A3AMQMX4HhlsjAxEMoRl0KTQQMvnZEEqN9ndx76M4ajXxoHvEhlKw5V
 MN+9VM4g9ErWN8KEJ+lMPtmLKnaIaOQJ25NOHYyPsxfMWxJqjyZrK/hOYiO4uwGKDEzZ
 5s/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789180238; x=1789785038; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LhlEYDWQpemuIMnWvpMSCy+QwKP38TCR3oYFVMnKb9A=;
 b=nDnVStjng/rUn32PabZkEJhl5ZypfdBZXAeb2uTUvZWP6cxIXMQictZwtQTFST0uFn
 lDN9UnPHr/nT6xaHOZ0Nu7rxcUF8t+PAcD7IqKgT/c4RKIsH1GBH7Fib9q6P9/4P3CAY
 aHBbrTrbAZg0WxsN9UavFWDbwfhHb/+tA9Ga8Y5OxQijtMadohlRFknt6buvIHI+noqP
 OphznEND91DANZ9JAxrb+DWtdXEkwpDORPLuUprVXJnBL8wncn77eT9iHvH/XD9xASup
 XKvadfUOS4yIqZD832o45lDwcPYWkWJdMV3NXOGwlECWTJU31eqekQbC5+4ChihfUdH1
 ur/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789180238; x=1789785038;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LhlEYDWQpemuIMnWvpMSCy+QwKP38TCR3oYFVMnKb9A=;
 b=KJ9SSzlF5uJv6cmwfv8SW1R3bISDhc+uoDgre3FXVPMmfQ6YuiUT3/+3fCgF/H5HAr
 mNeSmPwq8S0MXRt4AZ86AdC0VSCO7CynRO8Gve65i/wcvpH0DNHU36CYS2K4j4+uDy16
 x5kANVP2rT4d2Ow+qDc9LK8RbPI7GsSAf0f7w3Eka1ls05y6crmmDj3HP9b0RkgF4doH
 SmWU4iVV+g1KxAf/m3Qa1/SDiCquZ1pauz5B9nc/XM4rTmEIjjJ5m9l4G+QPzrF6CpmL
 uBEOBbDOg4ekauESn4DzOYpRj1McLYGluKnkg6utIv80qX/pj+O8PyvHuxOV9Ao5/QlW
 Z+gw==
X-Gm-Message-State: AFuF++mgcYKZ5OU0iNbjVzrCAOfFyWFE+FsaaRoYni16QgVgu44o7G+P
 MR+dBfEYzIVWMP04VLyGwOCQ/4v5mZzh9ettZuH6PpCHy++L2Fg8SK9/KVitrv1kZm2sKBefLJB
 oe+twij8gkuejxLDXhEBRzz0BRleIJo1dnjskabS59w==
X-Gm-Gg: AYBFou2sw4msU/KJ4UwHKpJznFYKRQ4N2Mz6U4nC2mCvqOf1VaXs1PqJpbaz11K4FVs
 B+ZVfcZAhqCQzBPg9JiCjLjC0mWUhnQaCt/XPU2b39J57wmZ4TH1sI4Mv/smjdikwQI87ZQn1Kk
 N7s3lDhIzfFKvPDN7XLIiEFvHTbB+OKuXN/CQzDvrlB7227LckECzzh/dq9eyr10njUqnKGmt+2
 R3CzWyfkPRjKSJCey+uB1E5lm8hvWSRJHhWHPLrVFOLrJGzVjbRbi5s7U6mpsZcqMuWQLEKJkXc
 da55KIUkVeE9Rm8g+QXLCriszY+7rI5ZbCUR18BTpuFJcqmuP3ZyrfE=
X-Received: by 2002:a05:651c:b25:b0:3a3:7681:6d67 with SMTP id
 38308e7fff4ca-3a5b37ef2f7mr1209821fa.16.1789180238192; Fri, 11 Sep 2026
 19:30:38 -0700 (PDT)
MIME-Version: 1.0
From: Dan Himebauch <danielhimebauch@gmail.com>
Date: Fri, 11 Sep 2026 22:30:26 -0400
X-Gm-Features: AcwNN1V963IeDUd-QUldO-pjWGCQZiXzrgoLRjiqt0-JerrHpoXg4IvNra2ffgs
Message-ID: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
Subject: [PATCH] drm/amd/display: invalidate DP CEC state on s3 suspend
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com, 
 wayne.lin@amd.com, george.zhang@amd.com, jerry.zuo@amd.com, 
 chen-yu.chen@amd.com, ivan.lipski@amd.com, evg28bur@yandex.ru, 
 Kun.Liu2@amd.com, mario.limonciello@amd.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 14 Sep 2026 07:29:45 +0000
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

HTPC setups on Linux with discrete GPUs can opt to use an active DP to
HDMI adaptor in order to carry CEC over DP AUX, as most GPUs do not
wire up CEC pin 13.

Currently under s3 suspend, amdgpu invalidates native HDMI CEC state
but leaves DP AUX CEC physical address valid, which can leave these
adapter's CEC states stale across suspend and make wake transmissions
to fail before adapter is reconfigured.

This patch allows invalidating the DP AUX CEC physical address during
suspend for AUX mode connectors. Normal connector detection reattaches
adaptor using the physical address from EDID.

Tested on a 9070xt HTPC on steamOS and UGREEN DP to HDMI adapter on
amd-staging-drm-next at d8ab7636160e20bf6a2ad69cd975f4d63319f1d4 where
unmodified tree reproduced resume NACK, with this patch, multiple
cycles succeeded with ImageViewOn and ActiveSource transmission, and
intended behavior on wake was observed with cecd.

Assisted-by: LLM
Signed-off-by: xXJSONDeruloXx <danielhimebauch@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0b446133edd8..919394778a25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -372,10 +372,13 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct
drm_device *ddev, bool suspend)
  continue;

  aconnector = to_amdgpu_dm_connector(connector);
- if (suspend)
+ if (suspend) {
  hdmi_cec_unset_edid(aconnector);
- else
+ if (aconnector->dc_link && aconnector->dc_link->aux_mode)
+ drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
+ } else {
  amdgpu_dm_hdmi_cec_set_edid(aconnector);
+ }
  }
  drm_connector_list_iter_end(&conn_iter);
 }
-- 
2.50.1 (Apple Git-155)
