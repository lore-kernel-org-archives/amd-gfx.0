Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396B606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HFU6P0Y0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF6610EC22;
	Mon, 26 Oct 2026 07:34:00 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C13110EAF4
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 07:33:54 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-3ab35e31f6dso31804941fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793000032; x=1793604832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8U0LKvHGA5PLMBRYsbuaSBNWEEM8e/eqX0yoWLbYmU=;
 b=HFU6P0Y0LkMgS6dezuYIbT0eytAXToc4Fqmb5+hkZEdhg+Ka0LRCQWdxNpfctEphfj
 Ti8P3/nRYIjIeblC+xXBRNG/ncDMO5Qw7AVlA9Z7DhQ0RjcbyqRHuXwmXVOl70hiu3Fp
 Qd2G0IdnjLLxJcya0cETQ95RF1LWQcKRSaelZTgbvUdAzkpl1q2RJE/MaOtTLwe4FPD8
 Lps8lrInSg5zUJ6Z8+VEQVlq5kxMRzw0i228vHksY5UaBDNVunIEQNDkDtXdEuVCbr6O
 RgnXd/QdC6MLHKyukxyljuFnGl5b3tQ6NbKMjpW4cvZ/kDXYgZEQXd0YOv6h5pvkDAjD
 VarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793000032; x=1793604832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8U0LKvHGA5PLMBRYsbuaSBNWEEM8e/eqX0yoWLbYmU=;
 b=EDWbNy7aVcV8CF+IcHHvEQ8w08zOAwomtQNeEPLGhDvjQVaig0Qr0mWA6ExzZmm2/T
 ATDtNvFm7LZNjhClHURjbzZbFq794W3d6KcFW8Zx4JSLEB1dY1VLfZ1mqbh8yGcHHBlr
 nm/Sw4o2Cfu2zSuHulMhzKLqviPhlcFoiK8w2mLmufDBKQCpZ84jKkc4+ZYjjD11H9qM
 ZA4suwkf8SSBmofC5SyoLycYUuKWkhNln8Bo3CUWCAeJ7gGdkb33OE5YX/oeKyhZX54n
 g62YbTIHx54cw9z6XidVOevTC7Bpj1RGrZrPKF2Wjclns6XtkippUq56Uho1Stwco++Z
 gRMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8hKQmM2DVEzP4lxXOOgnqcI0vsq0IhSFfLlLIiEtlZbG2LvOmdDQTaHpZzClNLiu1jbDmlw1y@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL2QCDo0FlGIS2wnNGgYDvJY/so51o+y8vpne3qAJW9HU2mQObK
 XIE3yrwv5km11fcar5QwUutnL/rHAKT1euzd4s4n7ES+LlmrQ5FGj6v5
X-Gm-Gg: AYBFou2H1jEznhAip423xE2AQJjHMUgS4hSSi0mMaxh+3XOJs/0D1UL4czuWxj/cYku
 pR5xgdxeBmshz/0EhLagYMBr5a9SOzM98OcA5aSCNPQvdOCvANEO19UvDYqB8f0lz7Y9yinQySw
 ncvSwdah42B+4K37EFTziq6v9ljKu1JX6F3pkEF3H9euPcx58jwpaOwKE2xLRlVCD5RbENoUyT/
 H6liLVCyFIxJI6f+tvDmcwBpMROzeZSyES0WR5a4nuQOy+qTee4+s7mSnz2t/HWZP6zbInm8Ylb
 JihyBei8IYPggzofuov32e7lJiC8EKJzwjOiz1QqZ46rK5J1BEs5Tx4xnlzIcH/4RtEmyWZhEvN
 ovWS0qz/PJgajq3nUGL29RMlzG7TyGP2IvUNSd67XGlqVx26j7/9LpQAP05Z/c+ooaKIRr2OY+p
 OTsRkJZWEHmK5yQXnAhlA83x5Re1qU3VZY9jZ2bf4dVAy4yJ0fNkxfjCPdbSaM63w8wu2k4mdcB
 CezeJy8tNv+k854C3AWZPICurlN5cqSSdHgYzwhfi+GZMtVEN4/9ZLcFg8rv/J+fLLOSPDEPWLc
 5YE12BF7+EOA2oOosUlesUulBTQY7GAbDTL9IIFtxRKnBtZf/V2xhQ==
X-Received: by 2002:a05:6512:3c9a:b0:5bc:f296:a12b with SMTP id
 2adb3069b0e04-5bfb7449714mr1568356e87.26.1793000032116; 
 Mon, 26 Oct 2026 00:33:52 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfc085a3d2sm236852e87.10.2026.10.26.00.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 00:33:50 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Josh Kasten <jkasten@gmail.com>
Subject: [PATCH v2] drm/amd/display: set allow_freesync before validating a
 new stream
Date: Mon, 26 Oct 2026 12:33:45 +0500
Message-ID: <20261026073345.297491-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After resume from S3, DC enables SubVP on a single FreeSync display at
a high refresh rate, although dcn32_allow_subvp_high_refresh_rate() is
meant to keep SubVP off that configuration ("For single display cases,
freesync must be disabled").  On an RX 7900 XTX driving a FreeSync TV
at 3840x2160@120, amdgpu_dm_capabilities reports sub-viewport disabled
after boot and enabled after "rtcwake -m mem", and the memory clock
starts switching.  It stays that way until a later commit re-validates
the state; a CRTC gamma change (toggling Night Light) turns SubVP off
again.

The policy reads dc_stream_state::allow_freesync while the new state
is validated, but amdgpu_dm sets that field only in
amdgpu_dm_update_freesync_state_on_stream(), on the first flip after
the commit.  A stream created by a modeset is therefore validated as
if FreeSync were off.  On resume, dm_destroy_cached_state() drops the
streams and forces a modeset, so the resumed state is validated
without FreeSync.

Set allow_freesync in amdgpu_dm_get_freesync_config_for_crtc(), which
atomic check calls for every active CRTC and which already writes
ignore_msa_timing_param to the stream.  It uses vrr_supported, the
condition the flip-time value is derived from.  With this change the
same TV keeps SubVP disabled across "rtcwake -m mem".

On this machine SubVP is also what exposes the single-frame scanout
corruption reported in the thread linked below, so the FreeSync
setting stopped working as a workaround after every suspend.

Fixes: 87f0c16e0eeb ("drm/amd/display: Enable SubVP for high refresh rate displays")
Link: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5714#note_3736349
Tested-by: Josh Kasten <jkasten@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
v2:
 - Rebased onto amd-staging-drm-next, where vrr_supported also depends
   on vrr_timing_valid, so v1 no longer applied there.  No functional
   change.
 - Added Tested-by from Josh Kasten, who ran v2 on next-20261023 (the
   file is the same there as in amd-staging-drm-next) and saw SubVP
   stay disabled across rtcwake with FreeSync enabled.
 
v1: https://lore.kernel.org/all/20261018221726.27259-1-mikhail.v.gavrilov@gmail.com/

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 386ba88c57c6..936a899aef00 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -170,6 +170,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 					vrefresh <= aconnector->max_vfreq &&
 					vrr_timing_valid;
 
+	/*
+	 * DC reads allow_freesync while validating the new state, for example
+	 * to keep SubVP off a single FreeSync display, but it is otherwise set
+	 * only on the first flip after the commit.  Set it here, so that a
+	 * stream created by this commit is not validated without it.
+	 */
+	new_crtc_state->stream->allow_freesync = new_crtc_state->vrr_supported;
+
 	if (new_crtc_state->vrr_supported) {
 		new_crtc_state->stream->ignore_msa_timing_param = true;
 		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
-- 
2.56.0

