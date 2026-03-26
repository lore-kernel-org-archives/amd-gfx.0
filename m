Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB47110ED676
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47AD10EE2A;
	Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WpID93gh";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFD710EBB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:50 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso856509a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551288; x=1775156088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=WpID93ghVpitifRDUJcKgOvdzsq91/FZOXI6zs/WW14ShmaWjwlQ8stnpHC1XrkDpv
 Gb9ChAY3hOu+4kfF4Er6HsQ/1V6iowLKwXo9xLSRIXm4aumvsoKntGCKTwoA9REc2s6P
 I/tqJN7Qb2SNBmRlKK4cXFoYiWIEicnRl85iRqt2M8l1WrMudzRnbpk0d//P7vRr9E00
 j0i1oS35jKjbOuWfgb1z4ViS/zmmyJG9hcw2Nw2maDRyGWDJljcZWepH48Pz6eudF5xZ
 wioUqrK+9uLrMQRghCS4oOReQagv7LTAIUr2HWrOMsPb8IyZmhrs73yWj6qF8CluBUJV
 JlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551288; x=1775156088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=iae/CMDotVx0iDN6l4bC28VdA1EDYRgAVHkcF8vzGHlcCZWGlSHVbow1x9MIPE6OaN
 dGKT7KHFNBeVlahnCWeJ4RzKsrbxwnHBtmwaUVRpE1B7PqOIiDNdvaR5YF2mlf+MZ6Lp
 KRE0q0nlduX4ZLZdWiDJH/jF8QuI301WB8eJMUvthgxoe6/vNd8tjEQnB2FzugUvAgr8
 rlLbG9LA3BrAsKo/1vdAo/uXAfa3mv25KSjZw5pJ1BN0FHLWSduHOLhkdL/o0e/PVfwL
 q59p6y44rHYFwmYqyd8V5cdv9cKwm9+ET37XwcP1UpehbMXyoOkPfObWBazdSmO/RaCC
 4cmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0S6tsh/1PvNhTCkx4t3V9vgrKxXkNULVOEPVabgK4JXiE09Iz4O/PZCu0Ts4Vjv96G3JCfF5A@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyehv//d3mRGnPa8dF+7R8pmlQYg7PKu4vi+mlrBE7o8Srg/cbC
 XrIM9cvR9rG5LsG51pMvC9M+mdGMDCtM6s3BY5W2XqWvFb1qypPl3v92
X-Gm-Gg: ATEYQzzU+12BxFyliXY20lPWKhGjIWLcJh8Mi8lbqUQmGtuvYMCmz4XR+CS06IkGVoy
 +1fKpbhr78Ky/9j1bjM6Rl6DWFG1M09JJz1/wAmmqCeOYaeO86PY5BPmrjc96DJvi+Do4VWPROl
 MSf92YAx9xJEXKZhvZnWRWLB4O3aJecSFCmkZdYF8uDo/I01yESxr2nezCWbC468lyZiKXc4h3N
 qUVDGA5XjxcUAjS8OHgmoI6bk1FL94KsLljZM17twighR/HTIr1lXKMcs5o65zX9QJc91tABPiQ
 AsLP0oN+ln1FFQ7tDaHok0Fs8hjBLzT8iO4e56VikS+kHckzeqAYexN2Ins1oT/F7XKJmen/c0C
 WQGuZKm5g6oSEP9GbA0oxFznBO1xDl5inV84AaXn4xW9ng/ni+ed4X/Rn7yFp04brmqtr5cgf9k
 Ly7axDVg7Y5OJfFQDtyMDlrvlLDdoNNdYkRzOb0Zq432v92gsV
X-Received: by 2002:a05:6820:1893:b0:67d:b2f2:6e72 with SMTP id
 006d021491bc7-67dff3ce6efmr4416641eaf.13.1774551288030; 
 Thu, 26 Mar 2026 11:54:48 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:47 -0700 (PDT)
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
Subject: [PATCH v12 12/69] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu, 26 Mar 2026 12:53:16 -0600
Message-ID: <20260326185413.1205870-13-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 441305277914..92627a03b4d1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -132,11 +132,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
-- 
2.53.0

