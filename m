Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438EC107BCD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AB210ECC4;
	Fri, 13 Mar 2026 16:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdycYuDm";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5C210EC13
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:19 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-463a0e14abfso1412722b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408259; x=1774013059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vB+cc01KMDy+1bX+9nVaruepBX97i9TSrBfN/R0HMBE=;
 b=MdycYuDmncXDn72uVtohze40ooYOKurGUI/qdNe/ZB4SqtcJ6UOZ1evgz6TjfxEn7M
 TzEcPj0dcDuAtgIhUp2CPCRdZyUkwzbsKJ+gz6WNobXgGxSYGb3ap3CBx5TiDxFIrh04
 ZwUruwihvmdFrf5pAjRYL7T7GD4/I7J7Zrz318HclYkOFWgLJYBED5dSqBgWMfGocq26
 yDg5XU++iXE+KqoIy50za8+xt53xn+CaJM9bjXY+/urLvx6KKq+x3YWAJZfLhsRhBzRU
 mcIbHZDu9vdVPAB0ZFbaRwrx6BPvAO4jZIw3lsKo4kfmunlG6BOHx+D8vz0GwDsu2wCJ
 uVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408259; x=1774013059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vB+cc01KMDy+1bX+9nVaruepBX97i9TSrBfN/R0HMBE=;
 b=i1wrztgERP7hQh0G0JmrNmZEsty0i1eMThBPP9UZrRqYPhvs2lyQkDpPxzrwf2z4wY
 XlDGXtXtmrfYwIDR0h+JcxXehfXTD6HxU+PPbiWTaU1KJlQbHbVU+6PlookwyUL8Qdn0
 /9N+NE82/Ut2XRzfc49m+6GynHGJAgHUwnJcGZNC4J+k36R2VRc7PaFLwnWHJ+tfTm2N
 UPxZRnmQo6eijfUVLqymZ89iXTk3Zfl9/ygPjrSSItfsXxXdED51cgdvstWsb7zamwhJ
 ZtyITa+sSG8HGBKCo11EbcxmJZnxVdGLL/bFg7Hex2Z4y3HB9AVQhNTmfdCOPidCvSrA
 QLWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPjs/PAZAUoXRYSXY0q5FlGJK3CCALmplWuoGYSv78O1XI+dJ+0To/0vNJazOXOB6Thwz+rTtc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS/cdqIcBtXluCjUq4NxgJ/gA/9HmotBvPOfCROO8qgOzPerMz
 GbMW2O8hMZcqLukLYtT6QM1SmDNWrZ9EhEZCA1BGnN12Ncx5n+SWohn2
X-Gm-Gg: ATEYQzyJStUSXyvlUuxp0q2kcJNhWYAZgGE3f9NcmWcRrs+4bbnZhqTk+fyh3mPZsnD
 kPyCNqv5McQqqs1b6J7KNgtLoWF7bsN2f0yMTA7+mSfS8kH6CgX85XfiyBC7IEErzJURK+bVmqa
 a1/xz4uVd6QaTf7iEskeisR7fAeO+nTeZcDMpgBIYsYKJALcX4bPLAGqFXgzzQ4OrivhXGHUXms
 PYYyqdpqpKiQzIa5VhvBgtRB0K/akz9akOFz6evqRjSBrxMEj0FpTe8z5iMkenV/qpiDXh/t/En
 8CH47q/jpENLnkEXvDpFlKpYV9e7cfSWEIw6qCXjmvbQ+ZwIyqocvL69PP6q31olSM3JoCrg7P0
 /cLJM2BF8rQ4yqGDH1C0KlJkpm8gfsEzDCWdjCZijGtZ9ylH86rVf1ruBWvxG0WipwNOQGoT3kS
 IwanhSkI4r7v/kGPIkHaBrTL681Jm9yrF3lYG8fy+CkS8oO524
X-Received: by 2002:a05:6808:158e:b0:45e:e07d:85af with SMTP id
 5614622812f47-467570a2be8mr1585147b6e.2.1773408258671; 
 Fri, 13 Mar 2026 06:24:18 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 38/65] drm-print: fix config-dependent unused variable
Date: Fri, 13 Mar 2026 07:20:03 -0600
Message-ID: <20260313132103.2529746-39-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, __drm_printfn_dbg() gets an
unused variable warning/error on 'category', even though the usage
follows immediately, in drm_debug_enabled(category).

For static-key optimized dyndbg, the macro doesn't actually check the
category var, since the static-key patches in the proper state.  The
compiler evidently sees this lack of reference and complains.

So this drops the local var and refs the field directly in the
macro-call, which avoids the warning/error.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 93dd714d4533..ceede094ff13 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -213,9 +213,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
-- 
2.53.0

