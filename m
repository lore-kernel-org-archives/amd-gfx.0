Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA672C5519F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 17:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877C221D40
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 17:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C221D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11C36E30F;
	Thu, 12 Nov 2020 17:37:52 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6700F6E30F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 17:37:52 +0000 (UTC)
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com
 [91.134.188.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41103.protonmail.ch (Postfix) with ESMTPS id B2A14200A0D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 17:37:50 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="A3Q9GXIR"
Date: Thu, 12 Nov 2020 17:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1605202665;
 bh=ni4di209k8ngZMMPtw31Fv0228Hm786EKjEHDXjW1gM=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=A3Q9GXIRYH+bpVk+LM3Cw2a5If0+I5yNVGG4o0f/HsVa0NeuhabQkzw2y2KRBTrZi
 72S4fsE98bWvROJQNRI6Oj9u2t0wsNqHhc4SMU91Tqbv54OwQmYNg2J3hDJkBAEm1u
 0HmVU/pf1DUWANle59W3ZSaUj3jmo8enRyJcFvud1S8ba9VOT1sjXM572EajP/pLFV
 ljw7911ggEbSOFoi+5LkuPYPTkZE9jtkBfhh6LqJ98zYJKsQDvEtlZn6FQnso9OUk/
 zhSjV662w7dnugW/fpP7lwVLb09awGzidySwy/rL9JYnL/M8cTejoURV+tPTDZaCyt
 zn37zkBgohJ1g==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amd/display: add cursor pitch check
Message-ID: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch expands the cursor checks added in "drm/amd/display: add basic
atomic check for cursor plane" to also include a pitch check. Without
this patch, setting a FB smaller than max_cursor_size with an invalid
pitch would result in amdgpu error messages and a fallback to a 64-byte
pitch:

    [drm:hubp1_cursor_set_attributes [amdgpu]] *ERROR* Invalid cursor pitch of 100. Only 64/128/256 is supported on DCN.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---

Couple questions:

- This implements a single check for all GPU generations. Is my
  assumption correct here? It seems like this check is OK for at least
  DCN 1.0 and DCN 2.0.
- We should really implement better checks. What features are supported
  on the cursor plane? Is scaling supported? Is cropping supported? Is
  rotation always supported?

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2855bb918535..42b0ade7de39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8902,6 +8902,20 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (new_plane_state->fb) {
+			switch (new_plane_state->fb->pitches[0]) {
+			case 64:
+			case 128:
+			case 256:
+				/* Pitch is supported by cursor plane */
+				break;
+			default:
+				DRM_DEBUG_ATOMIC("Bad cursor pitch %d\n",
+						 new_plane_state->fb->pitches[0]);
+				return -EINVAL;
+			}
+		}
+
 		return 0;
 	}
 
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
