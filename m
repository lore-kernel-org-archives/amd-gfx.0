Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7110B10ED66D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A19210EE2C;
	Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="npMhsj+v";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4499B10EBE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:35 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-417571c6083so746948fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551334; x=1775156134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bX4ilSonYi7XSfI6S+RBBXv+cAYgjTID5jxcrBPOaxA=;
 b=npMhsj+vJQSGEcd3eMQDjm1OaGuqQRfbpa3rUxpdGZudnHxtVFZrd509LVgS6vcR7N
 0VrswZVQR/zh121vnZX99qjzdsa/Og/QqLRZbAItJjOfU+8k1aW58yncAktADlDAHiAR
 riCF1ssN6Ij/q7AWwvSFoHnklg6AXDrz4qHpuYvr2lHbvu+wYMXPy7Py+YjkCUAGbqx0
 gZZL51G84iuPztt77NM0rgiVMVY1xSn00yxKX4dklXm7aoqox0iHPsHx4t43d2LeznhP
 PV7VS173350iDmsxe4caj9/4pcwXa3kDUdJqfYd82SvgGGf5Wo0LRYHqSRZ5I/6LY+Ws
 ZMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551334; x=1775156134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bX4ilSonYi7XSfI6S+RBBXv+cAYgjTID5jxcrBPOaxA=;
 b=tXCuTFYSm9IvaUlqpYZg65w2YmYmjCSShzrH5ujouNmcxjNq42xI1rXcVIFFSdqfIX
 pLAs3WTsVQcISFrMysv36EVR02it9SAosWmBJ+fyN1MlVoNAN1jYNS7ePO5L6A0VPQas
 z3YHKvZTpCXhrQ6vkOcObHUAwvdBSpqQwOmUAm++zxBhVJlzCTAsl6pZD/TbBHubzUSC
 tSaTrA5+ob+2S5wQcRMpA/IlvHT0Idcn6Bq5M2jlasvRa/BHTG59OBR2KMJmwnbzCWRE
 1kINVYYqSJKUT9cL/HvxXyWKjEcwISdnQWKDAka3azMqRoCDGME83jdQNQSzERwk8HMz
 IAuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3rgToK9Gy4mRiwRzOUp8CVKt6sYaCzKkESUamFuTi9EEYbg6Lg0G18HZLQGUOQ0o19vtoj4Wa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIGW2Q3q0C5ATAQ+h1g0NVWst2XCtbUeJnWRwnCwDXb/tIwZQM
 bWeCkxvhRZwyTk0DQW3BLwjhRCqX9GaCb2Dr++VLxAHPZrn67kvSvRlN
X-Gm-Gg: ATEYQzy3ZDKuD4JhcYUkt1VzQb0ZcPc5ChzRorlAnISy0XwGG9ab+1LoDA4FTvas9nU
 X6oZbkWP87fyTRunvfc7w2NGlOTyRJqO2nQ8nFzRCli3UAprLLk/AEQdEQWPVoO43XFbVl4vWCc
 AWKwySlaDgNTs8aaRjKFoSRcQKXHPzPkcfhD92YypbWkjiyL7SVxiG8Pe6/yRUHmsB0c5MUweYx
 i/cxYkgsiHPYycb0WdHMqz11Fqm1D1ZAvfAf22/HpIfxzVMXUjhK1yT5zrMWgNDEo4Vl5LivbAC
 DC0IC2hg7ns9DNoozVIh4nhC8SV4Bp4v5bnZsj9DulfU0r1TXv0jJBSLk2Yt0dx0TkdDaPpKMMo
 Cw/Rhut/L88hIA+1qI4ZuNWq2KwjMYfm5PLxyElPbv0ohlDBN/OzGHc1yVPK/b55aZgGAo5dlf4
 0EHdFLgBbHqvTIJgfp0PeFH/eUywb4kieKLlLQ3oTi/3BwLXFP
X-Received: by 2002:a05:6870:9502:b0:409:5ef5:be0c with SMTP id
 586e51a60fabf-41ca6de6bcbmr4583508fac.12.1774551334408; 
 Thu, 26 Mar 2026 11:55:34 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:34 -0700 (PDT)
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
Subject: [PATCH v12 40/69] drm_print: fix drm_printer dynamic debug bypass
Date: Thu, 26 Mar 2026 12:53:44 -0600
Message-ID: <20260326185413.1205870-41-jim.cromie@gmail.com>
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

drm_debug_enabled() is the canonical bit-test for drm.debug.

Commit 6ce6fae84536 ("drm_print: optimize drm_debug_enabled for
jump-label") renamed the original bit-test to drm_debug_enabled_raw()
and introduced an internal bypass for dyndbg. When [1]=y, it defined
__drm_debug_enabled() to evaluate to 'true', allowing dyndbg's
static-key to handle the filtering at the callsite. It also provided
drm_debug_enabled() for cases where an explicit bit-mask check is
still required.

Later, commit 9fd6f61a297e ("drm/print: add drm_dbg_printer() for drm
device specific printer") added __drm_printfn_dbg(), but mistakenly
used the internal bypass __drm_debug_enabled() instead of the
canonical drm_debug_enabled(). This went unnoticed because at the
time, [1]=y was marked BROKEN.

Because __drm_printfn_dbg() is a shared helper where the callsite is
not directly guarded by dyndbg's static-key, this caused it to hit
the 'true' bypass and always print, ignoring the drm.debug bit-mask.

This results in a flood of messages in environments with slow serial
consoles, as seen in DRM-CI on i915 CML devices. When IGT causes a
mismatch in intel_pipe_config_compare(), the resulting UART storm
causes a hard timeout after 20 minutes.

To fix this, change __drm_printfn_dbg() to use
drm_debug_enabled_instrumented() instead.  This ensures the bit-test
is performed at runtime even when dyndbg is enabled.  It also adds a
pr_debug(), allowing us to enable it and count the frequency of this
bit-test.

Note that using drm_debug_enabled() here would also instrument the
callsite but only when [1]=n.  Since _instrumented() is basically free
when its off, theres no reason to not have it available where it might
provide some insight into the performance benefits of [1]=y.

Additionally, update __drm_dev_dbg() to use the canonical
drm_debug_enabled() instead of the internal __drm_debug_enabled().

- when [1]=y the call to __drm_dev_dbg() is guarded by a static-key,
  so the bit-test is redundant.

- when [1]=n, we need the bit-test, since drm_dev_dbg() calls
  __drm_dev_dbg() directly.  Here the pr_debug() can tell us the
  possible value of further optimization.

[1] CONFIG_DRM_USE_DYNAMIC_DEBUG

Fixes: 9fd6f61a297e ("drm/print: add drm_dbg_printer() for drm device specific printer")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
-v12- improve commit-msg explanation of choices re (__)?drm_debug_enabled
---
 drivers/gpu/drm/drm_print.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..9b622345e2eb 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -218,7 +218,7 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 	const struct device *dev = drm ? drm->dev : NULL;
 	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!drm_debug_enabled_instrumented(category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
@@ -335,7 +335,7 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
 	struct va_format vaf;
 	va_list args;
 
-	if (!__drm_debug_enabled(category))
+	if (!drm_debug_enabled(category))
 		return;
 
 	/* we know we are printing for either syslog, tracefs, or both */
-- 
2.53.0

