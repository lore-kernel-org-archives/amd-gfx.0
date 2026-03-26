Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A782610ED673
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8838510EE05;
	Fri, 27 Mar 2026 12:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YgL126Zf";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2F310EBE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:40 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d9c98e437cso1084993a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551340; x=1775156140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26vMP3nfkpOdAIVisqGbQnZnw5iiyCO+aaCVYuAOEzg=;
 b=YgL126Zfb5gq5ReaihNiWNA+xK6A8mLKXUZjxzcZaz/s8UwL4YYuGAggdaRJ+JOmdN
 qOFJkldmt5eJ5+K4FA+71zUibjsgOp6ZjIt7CaG6ePBp120kZrjwi91RPb7E903rxtCj
 5D5AhLKhm8fJ1TPiJQgwpzgnjsN8rTcz3jFqHWNu1OP6IOceA1z2+JWlBU/p72QaiT1e
 QFlNjQ1PTUrT/miNS2rAJVyIHTzkpiWON3RX45+936d+YBJQlKFMCjNn4pL1yGuZ9dkL
 02Hr0RLeOBHmYXB9FpLLh4IBpe5qcOXYqvIbRx8bKvyRtL8xeDL/PEltS2VIsBT8KXRt
 T3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551340; x=1775156140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26vMP3nfkpOdAIVisqGbQnZnw5iiyCO+aaCVYuAOEzg=;
 b=ZWq3VifjmcXPc+cn0WLYsVL8RxKFXipCj2iTyjYVj1Twx3z1Zri05I2DzpJSDOUqPj
 Xf5uFQPoDsUFAWpwN6g3OdZfIp+M+bAf3FJ/+Z5CrnZ96raA+WLXuBnj6n2mS1BzPgAc
 Y8fO2jCOJZ/8TWziOkbcLcLSCCmcjVr6EB7lg63tntxnaKMMDKEwNsSd8+rBw787ik+Q
 SXHW2s9GDHp6W3c2CMT7rJdW0g96d22XP/7XHdaU7vKm7pSQWUjqX9/FbMfKZZ4e/gD6
 +imYU2dlc04mAnuQjgrIWSmLgTXcZxuhhv8ClGS0arQ24hvk5tMGtC98wtC65B5u7QLu
 Z09g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvZY2Er83ueqN3bdGCwXqtQt21rL8r6/UlVZbV+QbxXrzCa+d/WVu+bR3FwJdkHEW2S3si6N9n@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmdJ48b4ybzqvepYW7n0oAzkeBKfawUu0Pj0Lm5mFzh+H5cjHi
 3vFJ/aJ3xIiJp8JLDdMKBNKih303haI4aEWyl/ghrEgtSLTqZmP2fTOw
X-Gm-Gg: ATEYQzzoom7cd3Gr7+GZsF4x3p8MWd7o617hBP39x0pRe0yZ5PvRWvgCfY3F8hv4WDF
 GGuJ67AOXagmWvGeN7qX6qJyyG/FUXgAFGYecSM20JpKzygK7VyI7OOUXS4KOyKZfp2ZauDfyF9
 UkVEqgjHg81LwcrgQkyrSuJvwFdEQqOP6zzu+QNzNfSoVfJSz5eWqHxx4h2mJ5AjZjfPnnj/yhh
 ipPIGbfMtKHxcGAFcDVrGcbH1EmwBulGfZN8SEXJUCGSJOgGidQjnMlpRQkfH8n2vrbl3ZuSu6j
 MPWmfc28A5JsjecpPU/ShuXJuXjjzZkIJ2xHCpGPI9/hU9CQlUNoxGTFOgnOM2pxsNDDOnzkUA2
 XwYpm7s3D/sCNLgxN0ZqpeXkQa1G5NMsXh84B3e5btQXSxcWXZhFUzRqMR1oX8wgDOWpJQU2f7/
 1nVkJGFvYMo+lgbWkiNmWnSQsCR8X091sWcKWVlsd8QKo45KlA
X-Received: by 2002:a05:6820:2289:b0:67e:14bd:5ef3 with SMTP id
 006d021491bc7-67e14bd605dmr669706eaf.30.1774551339843; 
 Thu, 26 Mar 2026 11:55:39 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:39 -0700 (PDT)
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
Subject: [PATCH v12 44/69] drm_print: modernize an archaic comment
Date: Thu, 26 Mar 2026 12:53:48 -0600
Message-ID: <20260326185413.1205870-45-jim.cromie@gmail.com>
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

In the year 2025 it is no longer noteworthy that drm.debug logging is
adjustable at runtime, via sysfs node.  Simplify the statement.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 94064ec6c229..c3df2f3f47d8 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -89,10 +89,9 @@ extern unsigned long __drm_debug;
  *  - ...
  *  - drm.debug=0x1ff will enable all messages
  *
- * An interesting feature is that it's possible to enable verbose logging at
- * run-time by echoing the debug value in its sysfs node::
+ * You can also alter the logged categories at run-time:
  *
- *   # echo 0xf > /sys/module/drm/parameters/debug
+ *   #> echo 0xf > /sys/module/drm/parameters/debug
  *
  */
 enum drm_debug_category {
-- 
2.53.0

