Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAE110ED66F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324B710EC88;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PrvLVlSz";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F2D10EBF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:11 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-41c420d1460so582612fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551370; x=1775156170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyf4ilrW4GCVGVmagWACzMec5+WgfPealp/jm9A7WHo=;
 b=PrvLVlSz6yV6Wz7KbPU8wq3qlUwveAxdzvE0PxxRnjEfA3qep1cO1j+kJPhg/69WuS
 MZHo+n6jHPFTFHkQtMwATflLMvcAW7x4dKMJbMwCyNssK7tgUwvytp1+u4sOeo3irfCO
 9am9OilhJC5Eq8ZQuziU0B61BrNw85J1O29Bpw22ZM6UWXsIxlTE6RNUy5DOebCeg5aO
 YlQbfj14UfREwBP5lMx+Pefb+cdkpMciTidIu52Kjj2SNz00Zj6iKHhE3CYSpf2+BPtk
 InET7UlJyot48FJxEzYZp8d7aS1HZbyUm/ad5apkWuoYKiHD9QFPgNuHpccj/NElqXCh
 t8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551370; x=1775156170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hyf4ilrW4GCVGVmagWACzMec5+WgfPealp/jm9A7WHo=;
 b=ALhEPb+1zy9+VkXm/XAs1UkoI4DXseqQkEQLWMDTSfqst/dWOfAD3EH0T2zIGLH+KD
 WzGU5GebxsIunsveUFespqvBJAyWio49QkSRLT1n8qTEfebm6+Wq9E6mJgSErxc1A2Rn
 DbKaAibOqxoIqP8IPXZPtDa4G0W2lZmw+fTqpn+3fGhd784/xW95Tp8mQFoBJZaab83+
 m0g6oX1cWxwGSufDOIvmf2dewWWrZxWWE4wK9pX28DJB4Pbpsr2JLYO9zwCBTKGfdl1r
 ICLsbdBct4S4qda2epdKsyzPdovASU6JHo+hvZiePjPwERj11mJNnvLz6y7Le3SvsFUZ
 tjcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/KAPFlyoPl1IYuLYY8/VOc4Sdh+/0p5CMzJ+IpopShnhRvy4Pz4JbNY/Vqq5Whxg41brkKcxx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzX1UpErgqNrCzEjFpDoWLcjCmhcx7W37IEZolqqbEjgKSdjJTd
 mJGSaDm+aUeDGMa1ljLKRzAFQNrzPhbfncBxEW4XVflOLjbfOykWXGWZ
X-Gm-Gg: ATEYQzxE2tISTs+ge2HbQtne6hUdzraXnxmj0KR8kdGg/T12XPBqwA88KUDhsrsUzhi
 HUBytxlQzgImnbCJfua110vyu+LHcNOr0pcFVGce37VLXAAH8iIakE9ILBtJQVadwrTgeTFWvsb
 mPCg6JF7dadsZwMypY+KoN+H/57rutL4yvGLA833Hpg/yBGB5oiN1ioaZygQg5nkYcPj9PyNGLY
 UjhYz1rB3NgXRpHhPB06MomcrW7/CC/Sk/tTWo5+z7OkTmyVRM2ZFC6wlVMlPWRLZzCnasQzVsE
 cmcwlwCWwzbGvOROJJz0s/BnGcZrdQ6kUrKR8rYDJ6JSmB2nRnfAbvFQf+WOM/aT7pEHAOpPMsp
 kuPfRhMDzTIFq6/ozD3rGB3ID7aw3ijBRs6rQuqNnCQskBclDm9VN/Aaa2nCBL3qhkizAOojl2G
 44+Zl92J2E/33OOefHf+jWqLGns9IibEHbHDZYhUP5SIzOwwfM
X-Received: by 2002:a05:6870:8e0d:b0:417:1bb9:c00 with SMTP id
 586e51a60fabf-41ca6e3d581mr4428868fac.20.1774551370328; 
 Thu, 26 Mar 2026 11:56:10 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:10 -0700 (PDT)
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
Subject: [PATCH v12 65/69] drm-dyndbg: set CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Date: Thu, 26 Mar 2026 12:54:09 -0600
Message-ID: <20260326185413.1205870-66-jim.cromie@gmail.com>
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

Set CONFIG_DRM_USE_DYNAMIC_DEBUG=y by default, so its easier to test
with less config fiddling.

Note that it still depends upon CONFIG_DYNAMIC_DEBUG=y, so may not be
automatic for DRM-CI.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 6c83b1276870..6d17868b4c80 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,6 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.53.0

