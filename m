Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF996112E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FF996112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429C6E999;
	Wed, 15 Sep 2021 16:40:37 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3345B6E994;
 Wed, 15 Sep 2021 16:40:35 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id y18so4307914ioc.1;
 Wed, 15 Sep 2021 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Rxb+EQHGqGlKpLXwnxUW51+7Nk9iz0v7oEOEwdl08A=;
 b=B3heCAFAtcC6QryGQYGFjVVPguP6UT62uRvWMrikUSymwViLYD2YEulfooP94KdKym
 yTmfyeKCbtyBv0fu65gMzGbq67vSBFo15bYKVzH31w7PaPB52rtBZUrm/NDugcFv4mPD
 DF9dr3wsY1ErnpmAfgUj5cnWoBi14jl5cZYK+T+Mv7QjqO3dCTY5TS7X/fwMz+n9neoS
 mGQmqg+t6j91x1RIc9POov9tZ4oCae8zbrKltCMZzDZOyC30482Z4Fvyj8Tts4+ySOMH
 SoLUoCp+Ffuo2iRBVtgBPfS7pfs2I2r3ArWMvyHz1kSz7LxTXWckF3O/9sTKktkdtSc0
 KKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Rxb+EQHGqGlKpLXwnxUW51+7Nk9iz0v7oEOEwdl08A=;
 b=fUhN+iY3T0nm5TVwC1gvQBQCLhfyKL1vKAsMmXxT477JtkVlP4hpLQ+Re58s4C8uRK
 kPq+vLQohUnA6+FFyJoDRUghyLDqlioiBksMXLRiLex5s0TA4GonKRrQxY+J8zwK+x6F
 UUQImmxXjHkRLfk2kiPJiZksp5wXVARBxD6AykDWfYEWG9FoGeP2xFhSOlh5F9oPxL6J
 HXUZaSsVzZaFMf/CfHx740SNEH1Xikfm/qyTjlGUfAZRkqNnLZLW19KfP2OJj08r1aIp
 p/AppP6TRu+20D1lLbcb9DYZ2lofDgp1p4Tx9zc82BW4daQNMcqBAPgoNm0Hz5IFzyUc
 lozA==
X-Gm-Message-State: AOAM530LnaIFTyfpAGPUMY1VUUKNu0BGOldK70BCHWzFcLmJuRpln5Cv
 vgipP0+UoWq+OjQ5qVrv7x7wZwOYBKM=
X-Google-Smtp-Source: ABdhPJwUiCq3Y3P8gdIakSpZEu530hrN6NBPP0mUbBFhez/Kq/Mrs4i9Z7NqYhq6FS8kercLVnuDsg==
X-Received: by 2002:a05:6638:14cd:: with SMTP id
 l13mr789772jak.90.1631724034555; 
 Wed, 15 Sep 2021 09:40:34 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
 by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 09:40:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 05/16] dyndbg: vpr-info on remove-module complete,
 not starting
Date: Wed, 15 Sep 2021 10:39:46 -0600
Message-Id: <20210915163957.2949166-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On qemu --smp 3 runs, remove-module can get called 3 times.
Instead, print once at end, if entry was found and removed.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index eac6c6877277..abc04bf4f765 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1030,8 +1030,6 @@ int ddebug_remove_module(const char *mod_name)
 	struct ddebug_table *dt, *nextdt;
 	int ret = -ENOENT;
 
-	v2pr_info("removing module <%s>\n", mod_name);
-
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
@@ -1041,6 +1039,8 @@ int ddebug_remove_module(const char *mod_name)
 		}
 	}
 	mutex_unlock(&ddebug_lock);
+	if (!ret)
+		v2pr_info("removed module <%s>\n", mod_name);
 	return ret;
 }
 
-- 
2.31.1

