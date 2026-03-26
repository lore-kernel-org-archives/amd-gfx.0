Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91B110BA42A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8184D10EE25;
	Fri, 27 Mar 2026 12:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a9J9CkT+";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EB410EBF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:52 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d91f82d819so1164693a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551351; x=1775156151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ts/LFRGubV+qE5nUbczy5fsPH9e9tt1w1L0GvmpB2A=;
 b=a9J9CkT+kUB+PG+4uyuxrBUUPB4aDXS4onJlaKHlmZKYYcCbEnbeGaO0ggHa/u0qOR
 5+V64ZG/9HDLNyB4Cc9OUCz2aKcbsyLcd0vuzvwXeXjC8TAQ8X2XQJtm3g2htadXH6g5
 PGMH0Xe+F5Em/8T1MI5EA4b4o7IwOrkAoinn3QSodX5I33qW6q3IrBPTSP19uLfyOrNl
 WQ/7nSNodYoasB0EkErai70C9+3Ff+/PmWM8Oq5IvHTG+LIhBNa3LV8GUoth7NBy9rfn
 +uCE4GfZrD643hhRz8gKJyBHyCzczFzCStOYsmcRVmV2kUEZHH18h8YpK7bp1vCYOKnI
 FEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551351; x=1775156151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ts/LFRGubV+qE5nUbczy5fsPH9e9tt1w1L0GvmpB2A=;
 b=pkgq+dWClx4Mis6ij9z0cPvJjdiXfXnYydrC4oQCGHERv3j/UABwNPgaXxKs4A4DqP
 WFQt6WEdOasQZce3sJfvt7QJYjPDxPPkrPUyPKXrn9YWNc4hXso9WOw1qOdvYYQVlAgW
 yJK6UFWZFxbzSG6pnLXx4lnDAPCAz0nz1N7S4BiWoTF5J8py+krB1t+pTRAXQ+Uzc2IO
 Toaj5ozp2pP7j6yvi917xs1fb1v6v7OI1ZzFOIf6GCItXOMNuWUZ+BgSgc+LdZw0Jcg2
 WZ1M4W9E/sN7NLB1wf89HhU77wPXGc2xce6krZ9ifJIQ2gCgF3LRUfa8HjuAaej2iaQk
 R9iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGv+w6/Ta6mPnJMr/Lw5Q7d0M6S/x+B1iuP7BHjmz0uyZT6LML0LhXEPJXhNvEz+7tUtUP3tgh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwV95sNFAzcKSnPe5neiuS+C2l27rPJ/qOPNV96RlnyOz5lTnHT
 /JZaZLE4/qt5eFKRbxxPh6/gIDBF6fAJFS1WeWA6kBPX75bVFx1MHJbl
X-Gm-Gg: ATEYQzxgKzZ3VcWGZB60XXOcvvv/XVsF+6xNpahVMAt8InS/NOA4E1+UCDtyeiRdhx9
 cui0l6pziMKc7+/KN95Wmi7/34Kr2lsNTjIBZueYdnLMa5B4d0dyWsEyAUULG9kP5riBoEZ5/gS
 XOooYVCkxAQbCLdQ6pNkC3eLU3S3pwaoTpgNyazEdvHKECvgitzGNdg7ujSNKnC2eL/BmjdbLQv
 q9AlWS1/gk703JRyRvIYOLJg31tF3VqLSSjhMyip3Th/+r/ET6OB7PM3HfRjTikYm+XG4M+KlmT
 S0yzfI+0ukHtuVCe98WC1WicVarjCAapcBhJb3XMnscq5VXEr+zlNkAfjDSML7sdGQtoF0sR/33
 aUHaIC7pEeIjv3d8Du2Dvh0gFvk+H/J+GFRPpds6MGyts2u8lpz/yo3/vCcDQBix7V+kDd3Ybtj
 nZASNpdS8ih/0d4ey5+ers5v5zEsi7h21SSJbD8gwgrrmR0MOL
X-Received: by 2002:a05:6820:152a:b0:67b:af3e:b1de with SMTP id
 006d021491bc7-67dff5a94a4mr3770147eaf.69.1774551351454; 
 Thu, 26 Mar 2026 11:55:51 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:51 -0700 (PDT)
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
Subject: [PATCH v12 52/69] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Thu, 26 Mar 2026 12:53:56 -0600
Message-ID: <20260326185413.1205870-53-jim.cromie@gmail.com>
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

tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 7a95d2dacd9d..8958e115abc1 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -35,6 +35,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * Helpers for simplefb
  */
-- 
2.53.0

