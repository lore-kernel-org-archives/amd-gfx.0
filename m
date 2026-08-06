Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B883C5AC82
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 06:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429A910F394;
	Fri,  7 Aug 2026 06:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NLLzwZ7h";
	dkim-atps=neutral
X-Greylist: delayed 332 seconds by postgrey-1.36 at gabe;
 Thu, 06 Aug 2026 14:39:46 UTC
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B97910E323
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:39:46 +0000 (UTC)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0F013F9A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1786026853;
 bh=DfJA3Bjw1scHLEIZGaM9XvRkeKWja03nB5QNkQg2/dQ=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=NLLzwZ7hCGbL9Z3B5JqobvnxqcKPN5jRbrcVywVmMKsl0zGHYCDyc+TK9BQhVBfxK
 +WHVIKGgBsBouHsVXcfyd1UUsyCA9TxzGqc1BifQt1Vn3RSshnpRDHNzeqjFJ0sCag
 PXgE+/8F5okXOhrDgULylNio6DGpY+CreX3nY219HO09L1YETLAMYXYGA0+zK039Kk
 YSlTIk2MNCmGqC5lAj88vPh9OE1uMxI6aR5T5LIjbcU499VM5U3hZ3i0PCCbrbWvMH
 GWSgFE5qaLimKjyHRNkKqOqWpQPmBUrupDBgctbcPRHWvAo/Fx7O0+OyjU7UFMOvrn
 1vaL5k3tu9ZTKo6lJbKe8o4lnnjeFX7bgMMpBgs51q5Fr0MzBQaR21m9fhdRfESZeq
 RkNpS5actedqdS+vZ6JL7FJbjdB3BR96qtkD3lsQ1hT1msMs2rTXheaCI1Ak3BRPjX
 YrwLf5gGn4OoMfPrsSxFt6N68NQ7yVmVMJ4pzqrBNOiBKuM84nigNl6UwYX0WrRQXu
 BUdsiwur7ks5wEx6LV8Ok1qdZyC1M8lQmD/aGJbnXBoXdOKkm3mQGXozZv5p04z05X
 w1+2LrZ7b7rm8Z9rnVFrpDq66loFP6RSsIDu13caLUoeNFwyXkWY2cONUTm/K0cmhG
 +x1YIZs/d3AVR62hCkjGQUg0=
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-80ee3cb097eso70795877b3.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2026 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786026852; x=1786631652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DfJA3Bjw1scHLEIZGaM9XvRkeKWja03nB5QNkQg2/dQ=;
 b=E0qpjsIL/SudpushcL3DzO4mJsMmSy+dJcQkow/8BS+0mO16H30GgZ3nWCu0JTgqx4
 ZO9N6D7FCzLO0FI2xLOYKOtG3SiPj6fcfuKpWSqX686DBh6i9Jwj8yI9YxIh5dRLe8gS
 et6NOAcOa0Mashr3Ww7x+6B+cdg9jF36OR3gO0hY8PyMhqNuwmmwFen2VDhcWEM6Kca8
 LqNDF1jl8W1WrvL2jq+kBO8FYQ/+XhNxuTIuYOjQX0z2Q7bDR4KIWlt0LFBImAgDczsJ
 dIbscAZ4xHXKrwP2pVcH4duKa5j/g9/flTZsTQEwe9ugYt4iyxWxdK45eWARfOIMR/Cz
 SmKw==
X-Gm-Message-State: AOJu0Yz5S+mOTLScGIitNwC4ODF76ypwSX4OG88TFsVNm70qBcokPvgg
 38ciWEe2+wWQsWG5gljWgnur3oB3mhh0FOH/pXY3a/B8A5XsaRPj5VToo5T/Y2QqoxzmjkB7ogq
 ICmzGOymK3VgRfIe7x+oyBGU601yhDH9EPke28fptnScqAb8djrxl1UvvJjxEpGVTNQSFyeFeMp
 lOR2982oGoFqMyFuA=
X-Gm-Gg: AR+sD13N21yA8yZe6Lk6WH4GIBuapQllPNd/aKFHV8q253AYcKeYCtB2BqsBizQXeov
 B9nyCzx+Klepeax/MENpeA+QK/6371La6bn6+E4yAO3NKBAYlWcOyAccoTT0X6wFLiAAaFO+3iT
 se9FiuVFOKKVe53wyBOHkY75edJijgWI6OpRlfHgjOvb0IEcZLKYG7Pfu0rbrcDPAfWg9KBUiSP
 o2FsFAte4P9Wwe1GnI/pG7MxAUwd6vzZeOBY+N8ksX4Z5D9y41vMYgqOUdjsOZehYoh6VAziQYV
 CYdkmYorTvngQLinFwwhz8/2hHEVnm0pfP6215MgUUTMfhs5ATJ2OuzJYvFN1xK4op1EXdANr35
 9ocTSfOTF4sbeXc3MqA==
X-Received: by 2002:a05:690c:4481:b0:81e:f5ac:e40 with SMTP id
 00721157ae682-820224a7827mr99658447b3.20.1786026852511; 
 Thu, 06 Aug 2026 07:34:12 -0700 (PDT)
X-Received: by 2002:a05:690c:4481:b0:81e:f5ac:e40 with SMTP id
 00721157ae682-820224a7827mr99658027b3.20.1786026851978; 
 Thu, 06 Aug 2026 07:34:11 -0700 (PDT)
Received: from localhost ([2600:6c40:657f:4180:2a3f:d445:3d4e:f355])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-820131db335sm40071407b3.3.2026.08.06.07.34.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 07:34:11 -0700 (PDT)
From: mitchell.augustin@canonical.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
Date: Thu,  6 Aug 2026 09:34:08 -0500
Message-ID: <20260806143408.979209-2-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806143408.979209-1-mitchell.augustin@canonical.com>
References: <20260806143408.979209-1-mitchell.augustin@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:54:51 +0000
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

From: Mitchell Augustin <mitchell.augustin@canonical.com>

Issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/5394
Ubuntu BugLink: https://bugs.launchpad.net/bugs/2162904

This commit disables panel self-refresh when more than one display is
active to eliminate a common hang and system crash that happens
frequently on some laptops, evidently due to race conditions between
the DMCUB, amdgpu module, and possibly other components which are
exacerbated when more than one display is active.

To my knowledge, a fix for the underlying failure condition is not
available upstream, so given how disruptive this is for impacted users,
I propose disabling this feature under this condition until it is fixed.
The main downside of disabling PSR is that it
will increase power consumption, but this should be barely noticeable to
end users, since PSR will remain enabled on laptops unconnected to
external monitors, and since laptops connected to external monitors are
likely typically also connected to power (and thus less concerned with
the energy savings afforded by PSR).

Signed-off-by: Mitchell Augustin <mitchell.augustin@canonical.com>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 5d2715f78314..272f195b8c28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -152,7 +152,8 @@ void amdgpu_dm_crtc_set_panel_sr_feature(
 		struct amdgpu_dm_connector *aconn =
 			(struct amdgpu_dm_connector *) stream->dm_stream_context;
 
-		if (!aconn->disallow_edp_enter_psr) {
+		/* Do not enter PSR if multiple displays are active to prevent DMCUB hangs */
+		if (!aconn->disallow_edp_enter_psr && dm->dc->current_state->stream_count == 1) {
 			amdgpu_dm_psr_enable(stream);
 			if (dm->idle_workqueue &&
 			    (dm->dc->config.disable_ips == DMUB_IPS_ENABLE) &&
-- 
2.43.0

