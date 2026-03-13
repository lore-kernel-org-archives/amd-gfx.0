Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B3F107BCDB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030AD10ECAE;
	Fri, 13 Mar 2026 16:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmNTlo02";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B9110EC10
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:17 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-46701f2077cso2599817b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408256; x=1774013056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26vMP3nfkpOdAIVisqGbQnZnw5iiyCO+aaCVYuAOEzg=;
 b=WmNTlo02SCBpoSToy/6YiubusBXVTTjAKS2GiPGp4uAeFePbVPdIPs8Hv1pF7u8ocA
 5ZOI48Ea/8GL4U+x6fCBUbpJ9847PoYXtl25EjbSEwoKgGYbZkzd6o33XHjsq+uHMVYE
 uFsrjtQDxkOwuIpODyW4ONx5pMEvKeM74PAiVpnnhLj+ZIYtRoIEnqGL/8d69eNuXyYb
 cLfVPs6rAacPNDHzpVbVphebvLF5rYWtgRZFtEVMh9rwoeBcySu9mAAtQkDFlaYTvarB
 No8wqECDfv0LVqUwEU4Y+roUlORNxIBVnTY5L4okV/lHA7rDfyzcS2Cf/TFIf43w7B9N
 RdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408256; x=1774013056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26vMP3nfkpOdAIVisqGbQnZnw5iiyCO+aaCVYuAOEzg=;
 b=BH/TOZqNcEUzrAe355cBcNRwLUvXlIHS0NmUXTzY8nlQYRIXCcEfAegSyJ/MXGGyRP
 Q1uP+S7M92bvePRXwtzy4POJhzCW5Brkrtt+DFItXIeomu3fpqtYB3mwppoXo8LLmF31
 Un2s+eUefOEGdvcALc7YGUb4q2Wt/+2ARapbKdx70gP5MPdUKZM7IKLK7up3dt+qtEtM
 wSntf1XptrgPgPv0e9kWFwbaRAM+CAMy8A2XbTDGrGFZIIGJ8jmisrelN6b/YFbzXwac
 Z9AcViunqiZyUg5hl+2mj+YAV12ib7XZ4UIVl0zBVTKyXov2Fo8l2Fa9xg1EXXXLDlsf
 POZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX77z+gbzxICZFIUDfmn93FBSxUCWBCFR9YqPQk+uXdNfaSag0MWV5iYsIGeAh3LWKJywpM0y9t@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg+A7VVdXFJyFnVE6uKJkdN192jLRoKOcKEywwfGwqX01Lm0Ye
 Thdjjz7tg8atl4T995fmxLBTmykJrBIATp6TphTPev6lheGNWXwL394H
X-Gm-Gg: ATEYQzyPVERRI8nI4hBrMtlxL7ZXkyCwhuT0ekJESENncPrsFoDO9kwVLQhj2zNsWO6
 riBmGvXrPb/Py49gQjra+R3HKU3v80qLBeZahrbFaGoqNwRDRk+zV73+hG5pALzgoC49/wQtCkh
 cT+Umka75Hy+/m5hVJL6M1WQcUa8AS4UcHp9ki3up5ju1Bo0qK2GUz5wiKQFPc5vSUwyes+7HhY
 5IboXE8mCV7aiEN1Gx3kXATLaxFVALl8GYJxxMWsIivbS4ObesycjzNs4zXvheK0eO11PrzDwfb
 9sPXLxvFR+kPjRwQgf0Li/4G1aSQROi5RNTnkGjZ296LfdpdWeLlXU28nUzaNOn5aC+i4NxRaNF
 nRkNlFp6JnscLq6HyqlXQftpL/sRKWjaUWDOpDODVgFO05yXlTX0w/SRP2JYF/V/q/ognKrkDZ7
 Sj8HXz8xenq7SxUCKNjUHti9FQv97me0ZUvLT7G+/8a3MaIwcY
X-Received: by 2002:a05:6808:118e:b0:45f:103c:2478 with SMTP id
 5614622812f47-4674329caf4mr3963254b6e.30.1773408256475; 
 Fri, 13 Mar 2026 06:24:16 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:16 -0700 (PDT)
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
Subject: [PATCH v11 37/65] drm-print: modernize an archaic comment
Date: Fri, 13 Mar 2026 07:20:02 -0600
Message-ID: <20260313132103.2529746-38-jim.cromie@gmail.com>
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

