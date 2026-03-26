Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D38E10ED677
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C72010EE0A;
	Fri, 27 Mar 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kecb9Wbb";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AFE10EBE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:42 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so940058fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551341; x=1775156141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93dR2Z7/f38EiX2nhH8I335LY48jx/pTe8LM2CbujQc=;
 b=kecb9WbbHe0WJPkkW9xYW6t8hBEBq8OQ23n7G6ZP/lhh1HqeogNq1ZB6UvbGmz58hm
 C83d+dGlcAkdgECZaJ/pVD9jhxO6y7YndsV6f6BCjzGNoG+lE8fMM0PQ4nEejwja3FAL
 QFz1a2I92n7i3cikCYwCCc9p54GKPqh38mWdZEFnTpDIupMbLHXT7Vug1Y4tSkzZMNkR
 SUWeCxlKMXYV4Wba9wfSudsrQ0SZQ9W6G27WEsNhcFNigAE2sXKpFZBrvq37ujajJfKu
 55ImOKrPurq+HkBX1qqg1GRcgrc04p93W/rtanU/0o8wBmC+tFoZfcixbAwc08S2ej8b
 lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551341; x=1775156141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93dR2Z7/f38EiX2nhH8I335LY48jx/pTe8LM2CbujQc=;
 b=B7W1Mx2ebv0iUMteJhtAgr1rEWftSL3MsyPbHPaWTjbu26sdc/eKCUh04m88OTT/WA
 yBELSZF6NqyvZzR53Kxy7pjH3gnxGcPbPbEzfQ24QMS6TL/1EON8cpw2Oc32aO6402Uz
 fLGZ+qlNCU+MDac+WZSv0jaaQ7q4RX+LRLVcolFZChXh1DF0SpOkMvQfA2G7UvYaQTNY
 3P62a90QEZOwBqxOgT+YY/ZkB4PYpMMj+iA2eEAoY4fZZjf3Zuu0fQiOj16icKy/yoj0
 56w/oHEbawvVuYoEQVZqYNh6sy0lmYaAwu3kQv//0muBN6TbmXnXU/1QvH0cenr+5w2M
 R6jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOzyXybv3Yj2ft5VVW4tFsyj3yHwDNPoCFAQfSAUFPsl2A89aDoyA386i9etvTOFHcpUYg+Qht@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweQgJe0abJuPun8/+0+eVJmM3+8zRY9Vg41zIJjhv+lV+IO6iW
 2wiMB8dW9P+baGcivY82QebZ9esUJMZhjIlzJKEUA12nXXjmli3uHMf2
X-Gm-Gg: ATEYQzwe2ImzFfwS5fcaLGtr6qzS2CcU+JOCKVJIrkI6FeCw4yTIJPw/MosTIk82EkX
 JSj/Sa0gErmKv6WdpjDLU0TXeXT3L1y73Kuc2WduYwsQTvDGzWcglXazlpqlE1ZeIPmgtgaTXFX
 M2qkQGHROk2Oc66AQv4MzkVA06+D2VfJLVWO7qrrr5Ldz7JiwPEAHe7rCJPgOcKk0WNEzlfssH6
 WztEbJclgR5UcssJdwqbZOKiOd7t7NY+GWFiU1sOGHGXx4T3r5vGNJNam+96lopM9qhrID7f+Vc
 MVIo+5iIj9pCIigFag45HmJfyGcHpeujUEuqGLa75ubBz1CR+/uc+dt+ZHxZKZsaxBJACGpsvQp
 R/inseTvq7Bn/YufwkWPpKNXmbZs925lIaoqrkorvhTESyMuoq6zsQlXt7MLRWQffRVjhFsKfXs
 M/k76Ku2pmT4xXL6O7vI5A0JJwPPT3Farfj8tBx3GbQxAD8BXY
X-Received: by 2002:a05:6870:209:b0:417:2b13:f2cd with SMTP id
 586e51a60fabf-41ca6d734dcmr4697103fac.10.1774551341455; 
 Thu, 26 Mar 2026 11:55:41 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 45/69] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Thu, 26 Mar 2026 12:53:49 -0600
Message-ID: <20260326185413.1205870-46-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d54..e5dd051eeba9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -249,17 +249,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-- 
2.53.0

