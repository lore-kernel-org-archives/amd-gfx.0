Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4675910ED671
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CA210EDC8;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWJBE9iY";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4F910EBBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:06 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so611526fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551306; x=1775156106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtzYjTItScPv3ZPv5u0hQB8QpwmveJQikTbqnzcN8xo=;
 b=gWJBE9iYqkX5ifNy98GcVSPqaILTm3863mWMPbDrajjExuKMvKHWkqOmu8kgBG05KV
 sUnefqoABnDz0K8cuCMdyR9NBJT+Lp2sEM/GJGemLmBAnOFyk1bZSMEuuXUSSFweFj+8
 AnSf5ru/Szg+5l9I63KcTYfOhhKEZFUO9hxPdM0Fjx8L0//mBiX0rmUfDbGAHbfAFYqs
 8RkJNng9X4axFQFR5K4dw8zQZ53vyNpJZ1sP7fJ84Zx//xAZS8msz/oIzg7ubRvDnvE5
 4YXQA5sbzfvsn4Z+3IYApzQcxOSt/o1VGOKnEid0IZM22xAebx9s8IcJA6jGntM8EdEv
 oS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551306; x=1775156106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BtzYjTItScPv3ZPv5u0hQB8QpwmveJQikTbqnzcN8xo=;
 b=cLyNik4vGm57j+e9rl7eoiQPWaHAE0Icwb4loadejhcz0B3BYyFFp+zhJMdOvV5C6G
 S10j6yA4cmpMBVZSvlNpFSHQlA8y1UarNqj2lQ+p0FSLEros86L+i7OFG/BvKImq/ub5
 4ic+EuK3Ts4NgvfxjDrjcKsU9xy1YWim0KqZZCEHOZRtEh2OS/2vCTjp3ef9freSA+OA
 92R0AXMGB8b0wE8zPT6Dr33jSS2JLImnuX6FDiCZEXiweJ7jhN+Rz/EuAuP77bN6qjb1
 n+s+cNRBUX4nbcvNu54rj77Q6l0XuAn7ZI9YO58YgkSW9TqKWMcDvmF669dMbxAbvMlH
 MwKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVbIZaQGOB8osfqAmgx8JZxLpWhZ/+Pbx5GkusiLcrnM6p0N5/c2KLOFv5gGxZz7hprwU//bgU@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8H6+ho6TSGgUDshRv2uH2F9eomhXLGEsprtV5y/cW+iT+dYYp
 WO7DwFWdrH51LCaUf7G7m0s5Ndqh7tF2cdQg6xne/oaynw3SLih/9quw
X-Gm-Gg: ATEYQzz/M/6ZR9tNcqLhgYhaAC30Z9s5F1kx5iV2u6BBMx0qXi9Brokqow19BwO+Q0w
 UTQ5gH0flG3FvJxFhY8b+THZDU+iU477EUwKqQRCOXeJsG7uFlRzTJfF1EHNXGkTtkX1xUa7xhA
 YCCf4rqUfoBqE0QRKWady6E1rw7pfeL9Qe5gWYKFhem1gkVEk8aPa6fk7sgAygddxMm6Kx0soHX
 +dZ5t+x1ja55pM44pMjr2M80IalZJWzIQwktAZtjrbSjdPR7bzXw3VnWqFjBXNj2azfdwa1K5+F
 Z0NdphU0ZJpHjtbw7f1HCQzf/VfVwCu1TzYTGVyywR459AYkT4OxYcLq+eXM1pQCbuhdntBp5w6
 9SEicWjvg7kS4H+7cFTBMilUvVR8C6wrIzURqIFM0orSqXh9b8sZHQ5hxAbL6WdDBRz/bzxDK2U
 rYofYMB9BAX9N8LLvjsePmJdEnOxtChPuUEcfGNEZzNteGiVw5
X-Received: by 2002:a05:6870:d18d:b0:417:4679:d550 with SMTP id
 586e51a60fabf-41ca6e15946mr4548356fac.22.1774551305958; 
 Thu, 26 Mar 2026 11:55:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:05 -0700 (PDT)
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
Subject: [PATCH v12 24/69] dyndbg: change __dynamic_func_call_cls* macros into
 expressions
Date: Thu, 26 Mar 2026 12:53:28 -0600
Message-ID: <20260326185413.1205870-25-jim.cromie@gmail.com>
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

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 3939b294c647..33291abd8971 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -224,24 +224,24 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
 		func(&id, ##__VA_ARGS__);			\
 		__dynamic_dump_stack(id);			\
 	}							\
-} while (0)
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
 		func(__VA_ARGS__);					\
 		__dynamic_dump_stack(id);				\
 	}								\
-} while (0)
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
-- 
2.53.0

