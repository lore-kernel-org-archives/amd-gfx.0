Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED0C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 20:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C36361528
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 20:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C36361528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E146E23F;
	Wed, 29 Sep 2021 20:05:23 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92AB6E20A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 19:40:58 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id jo30so2167397qvb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uygLVQeQ0o4/XQscKBshgBLNwrWUdtQfvhLaK3mF1Xw=;
 b=RPMXil1/MY1q0e14CFpeUcnWodx2GVTWgPci6RPiPeq1HFAfRwOnbnmmGwEHYs+oo+
 BMa+bbOIUOlNWZgsVklNBrgtYQlE00vflN9GgbSKqykN5MRcu2BWvdvJV5BDz4F16PZl
 ewc4wE7VByQOuxLX/+XNrxTDgu/ZlQuU34HLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uygLVQeQ0o4/XQscKBshgBLNwrWUdtQfvhLaK3mF1Xw=;
 b=FGvj+9aGJYTMm9R5INlsOD0aunHrG9YllygvrmddwXllZQ7hLrtHIdbr3MpFOvGWfD
 Ei90SzgBYLmiO04YfKtVNGNHg0ruZy7pWMZRjtiwEgMmtu67yQeeGXuf3qQlsW9WR/ly
 x1G+Rh2vGP1tOQfK9nH6ximhoUaI70W23lG0SwngLNA98eMr5FbNXN6IWeD4PTyd3m/D
 cYtvHATfpknaOQNCjQGLFSmv1pVUizEx+3MXbVd5EfhIzM4KmVKUmxAgF7kawEz2hBWI
 SmVf8pSEqUsLSWRLGxt6pn2SyCtJHW7VNKPZ/N1z3TT2oiPUpBGOGFs2rqQ9uKDReVWZ
 m+QQ==
X-Gm-Message-State: AOAM532B4OZwEVBdpd3K6ZzNrHXw0+XxuMsFD0/wcYVTPZnn0UAcuLY5
 5pdqB5N22qJ28vHyBQKKL67Bm+li6T4Hzg==
X-Google-Smtp-Source: ABdhPJx9FxFUi8+5WLUsq9ELR8HA5URHUmYQjIw5BV8E/BxURQ/k4/q2kA7VoUODagoC+37YBIaTtA==
X-Received: by 2002:a05:6214:13e9:: with SMTP id
 ch9mr176270qvb.45.1632944457993; 
 Wed, 29 Sep 2021 12:40:57 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com
 ([2620:15c:6c:200:db75:cbbd:56c0:9891])
 by smtp.gmail.com with ESMTPSA id c4sm395064qkf.122.2021.09.29.12.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 12:40:57 -0700 (PDT)
From: Mark Yacoub <markyacoub@chromium.org>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Cc: seanpaul@chromium.org, Rodrigo.Siqueira@amd.com, anson.jacob@amd.com,
 Mark Yacoub <markyacoub@google.com>, Mark Yacoub <markyacoub@chromium.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/2] amd/amdgpu_dm: Verify Gamma and Degamma LUT sizes using
 DRM Core check
Date: Wed, 29 Sep 2021 15:39:26 -0400
Message-Id: <20210929194012.3433306-2-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929194012.3433306-1-markyacoub@chromium.org>
References: <20210929194012.3433306-1-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Sep 2021 20:05:22 +0000
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

From: Mark Yacoub <markyacoub@google.com>

[Why]
drm_atomic_helper_check_crtc now verifies both legacy and non-legacy LUT
sizes. There is no need to check it within amdgpu_dm_atomic_check.

[How]
Remove the local call to verify LUT sizes and use DRM Core function
instead.

Tested on ChromeOS Zork.

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 07adac1a8c42b..96a1d006b777e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10683,6 +10683,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 #endif
+	ret = drm_atomic_helper_check_crtc(state);
+	if (ret)
+		return ret;
+
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -10692,10 +10696,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			dm_old_crtc_state->dsc_force_changed == false)
 			continue;
 
-		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
-		if (ret)
-			goto fail;
-
 		if (!new_crtc_state->enable)
 			continue;
 
-- 
2.33.0.685.g46640cef36-goog

