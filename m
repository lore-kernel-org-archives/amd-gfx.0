Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05092C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5261810ECD9;
	Wed, 26 Aug 2026 12:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MUS9AQn2";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA2710E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 21:19:01 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-7377dde7bc6so998224137.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787692740; x=1788297540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KaEPfXUewgQRHDDWoDuU8VavJ7ak/kOFZR7Xytm9nQQ=;
 b=MUS9AQn2wi+tT9Ds3HVJmHUDyYsPMVMwQRpZvogqP4I974kDW+1qHQGUKJLSxMc9Jg
 LDu4zfVJ09Wd0Z+f7wibjKSQU9yO28lhjb2m4oV7ffA7MlL3iIcgjkhtb56wGT1ZTPXy
 wbJJpjTPvA69GJ6oQussVFBiJTnSpEYwUEMny5KcBVXSqNoJL68IhY1ts1+Rd+Cll2RZ
 NLFD0gAsAXfsEw851ocy62J0AVTbwsU3nQxY7Or8AheaO0LkmmTfk7OYxmziflL78k0+
 5M0qtDtUst3qmsZNva24n86qEB5A+Dk212JV3ZR+dutIaAa1yD/s0wWavhzPdmp6jov4
 6wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787692740; x=1788297540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KaEPfXUewgQRHDDWoDuU8VavJ7ak/kOFZR7Xytm9nQQ=;
 b=A05Fyqjbg7YZqG54at90bUX1g2FA+vEgFf+MK4tjuOIYllDyG6wtBHOiDeLZAEOcEe
 skfTnQQjJlYy7abboBA5PhGXqY0eIfQLj1euPSBIb3omATNR832k87RnHxjkBm5YQ6NO
 1hFOXkr9zFINFf50IF+h5qXhkbNpUewTjMnJp1Up+5ma9yTrzgeCS0AqflbQdzRP6hYN
 oi9GjoFhwdG1vwmczshAOHtsawfYdCNHeeVTX+QjhFg2m/pN5wQY/04zNPYCcVqK4OOO
 X9Mu5TxyDeMYfVNLXe5gH2fJYUsPGJ6c175pB5IAnuBkdUiWlur8MynyQ68dGj0/+Yzl
 d9Ng==
X-Gm-Message-State: AFuF++mjwh75Z9FSwOVkrahrKYOEpXOilG9CE/8/rs4XjUkRFxznOq/b
 3TjNIHCFq8X6aPDCXsSZqb0WMmsEfbUOdttt4I1D3Irs+9qNr/8jaeTmrNYwQdHemVs=
X-Gm-Gg: AR+sD11TtJps3JPpUrWRHvpu+kJsZ8ASUbD1JyNJKXdRs/U292FXQLPsncQ0KFV4IqV
 uj18uqUppQUAkhwfawVEGcudz8Ps6NU4iojC6ncEpsYLmubS40VHoeozjJ1iHPl4pMCtGFUFEzI
 A9UO1gAIZNljq6JFEXaES0EwMvgfCO3bZuufLusiiH9J5I5i3n7ZVJI/FxsaQ1tQfPgv41tovYS
 vcyILpA3Yba5Rd6+s/Ka20To9wK5OVx2USJ5kL6tOvtLQERXj1GoEolwQ4w75eqTsdBs8PLRFtd
 +GvraocBB1Oo7V0Ubl8/GPt7UWA+ifFCPB3T6KWRZhcATJELmFhzO8cqFEsyS8i3F1BhLFf0sz5
 P6grViZjNUylgl0rMRRbG81l9o7jN2l9sIrITHMlHkIRp7Tukwzwx611JoTEEweDOowm8CGZfnI
 gY2qsJ/bYLncYGetk1u+uuHoV66eEmXmjywLD8q/mhQzWFqytDZqODPZXI
X-Received: by 2002:a05:6102:2921:b0:778:3894:b2e2 with SMTP id
 ada2fe7eead31-782bea7ce5emr469515137.6.1787692739953; 
 Tue, 25 Aug 2026 14:18:59 -0700 (PDT)
Received: from t14 ([189.39.221.242]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78307cb51b9sm47611137.7.2026.08.25.14.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:18:59 -0700 (PDT)
From: Mauricio Bellon <mauriciobellon@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mauricio Bellon <mbellon@lenovo.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
Date: Tue, 25 Aug 2026 18:18:19 -0300
Message-ID: <20260825211819.100210-3-mauriciobellon@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825211819.100210-1-mauriciobellon@gmail.com>
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 12:46:21 +0000
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

From: Mauricio Bellon <mbellon@lenovo.com>

Direct DisplayPort high-refresh modes using DSC and two-way ODM can
commit without visible output during a 4K120-to-4K144 transition. A
working 4K144 stream can also return black after long-pulse hotplug
reconstruction.

The DPMS-on path currently enables source DSC before link enablement but
does not enable sink DSC until after the source stream is enabled. This
leaves the sink and source compression state ordered differently while
the stream is brought up.

Enable sink DSC immediately before source DSC in the pre-enable phase,
and remove the later redundant sink-enable operation near PPS packet
programming. This establishes the order as sink DSC, source DSC, stream
enablement, and PPS before the compressed stream becomes visible.

Cc: stable@vger.kernel.org
Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 48b086d15..412ce52b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2635,8 +2635,10 @@ static enum dc_status link_set_dpms_on_pre_enable_link(
 	 */
 	if (stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(stream->signal) ||
-			dc_is_virtual_signal(stream->signal))
+			dc_is_virtual_signal(stream->signal)) {
+			dp_set_dsc_on_rx(pipe_ctx, true);
 			link_set_dsc_enable(pipe_ctx, true);
+		}
 	}
 
 	if (link->replay_settings.config.replay_supported && !dc_is_embedded_signal(link->connector_signal))
@@ -2729,7 +2731,6 @@ static enum dc_status link_set_dpms_on_post_enable_link(
 	if (stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(stream->signal) ||
 				dc_is_virtual_signal(stream->signal)) {
-			dp_set_dsc_on_rx(pipe_ctx, true);
 			link_set_dsc_pps_packet(pipe_ctx, true, true);
 		}
 	}
-- 
2.53.0

