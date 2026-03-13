Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8BB107BCCC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6F910ECB9;
	Fri, 13 Mar 2026 16:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WlPnBfD2";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3CB10EBF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:14 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-46702742c99so1401118b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408194; x=1774012994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=WlPnBfD2ikkHx6z98gzW9KZsxQ79SjmFVGsIFvb4gIeRclv9o/NVPVmmklXGIPliZU
 EpnR6Ch/Shbs+/lo0h/8ggG1/aijyiogv93k3Aouta1SpEsg2gbY7a02rLUQ83OJzlsV
 dYwiC8t0ROXtgwhHWVNeGdo+7ro6C+OKyX9+1Mf5z38mNfOjX66SCmuudX9EdlnVNTR2
 0lKTjka44O4biP3/aPrqeRzCG5FPwKoPVS5EA/jSXmOvAepyinUADi70Qb+L0pJn/Jq8
 tOkrkXSZIMoyXQWA1A+xnTduz0g6ZMekSyjYxSKoQJXQoPk8bVR9EH3YONHt/iyhO3C0
 KgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408194; x=1774012994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=haKak1HqlJIkf6ABGIsDtnHFQGNIbzafdTwMbEl6gvQP3JpSLNb/PDfdbQIamzM3vz
 yb+iY3eiyI6m6KyzlBMKa7lW+IRbNoe4iTb0jqLu9n13ARYOmcvAE3fwFcOqxwewnL8A
 lAHxtvAQxA12e4TLbZx0sOPJLh3XNT0SNYplv37xySEMci4jstgs5vxM18fdVYr0BLCA
 lP2bJm0D5Nu7c5+JvbJR1usTgWEt/tpm04nrusD51RnDbidA0WolEEcYjQwnKIQi2/1W
 ghYJ0RAXFtpvkQwMWcfwwxQduhi2tE0DU89IcP7P8xyS3+PCtGYZA5t98y34nmqg+2yz
 g5bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ9kJPUGkbGa+8xfszXX5Y16tgdYObt3BHLQzDKBQKAQjtRwNTXMna7aOaaxJEUPbupRn39Cep@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYdWbJOOxE5PbHh3usDQSv/3CbLyyHPrBU/edIlyD5XsGF71vo
 7LQH5BQAoD0J8UpjrHm8MHqavzkcATYkbth0JrmT9YKVKz2VUglxtVX8
X-Gm-Gg: ATEYQzxtT+XtqofZ/Fe+NjPoxa4fplzA4x2DJByMfX6wrv60gfOamlznVrMYRF4HX22
 4e+OhqsoptWR4+dCov3UjUSGiAVCLMdWO7S1glpoe0oF4EUrTFIy5enUL3OwjmOiXpf8xV4/aKV
 XW7OkJcWZc4bWY2/Sejv/WKk3GRWMd9K6iOIA2ZXM0C286bTAXeAGeVBy0vJxeMEmwrPAZScPOc
 ARAz4ooFEz+wPiChA8BZaBzvxNZKR631V1akqzolQ6tBXMwzvPbDIPcWdC/rjP7K2nIDBHT/Y3U
 TnVU7BRF4VjijnExJPup+x2vgrS2bnjjyHyvYquyWYCFU5AFmHB3+NLRPl/jygi4RBCZ+G4OeG1
 Ghp0XOzwsQDrIm5JOaMZxVQyIL/5P+FO2dHaeJTZC+xiPL8eEC/BY3bUogTXwWkLPcQnNmu+vR5
 wB7S75ynMEpWSymjbTWGRXYAyBSr+9n/pX4nVBxxDZRpYWwyx8
X-Received: by 2002:a05:6808:1b24:b0:450:d471:dce5 with SMTP id
 5614622812f47-4675701babbmr1568851b6e.6.1773408193868; 
 Fri, 13 Mar 2026 06:23:13 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 09/65] dyndbg: drop NUM_TYPE_ARRAY
Date: Fri, 13 Mar 2026 07:19:34 -0600
Message-ID: <20260313132103.2529746-10-jim.cromie@gmail.com>
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

