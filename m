Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F47FCCD18F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5121B10EB4E;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MxdBUltC";
	dkim-atps=neutral
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
 [209.85.166.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B5210EAD2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:50 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id
 ca18e2360f4ac-92c781fd73aso115607639f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032730; x=1760637530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTjH4sGVjFOYrHuOXXQp8+DmE+GbVi2pPpgMotQBb8c=;
 b=MxdBUltCGjYtzDyl5bwKvwl0amAdd8y6+7zVYo3CyUCyUu2Kb38wRgYidUt3vQM0DI
 ZjQuQ858S+iAZ683+p5GL8hIUUbX2CPceLV6g7QGiwRVkGW17EqWYm7xwOJxyGDOflMl
 Zp7AI2N6J4SMvMF8AvVd271F0B5bLATpqKVF/swIi0GNdTgZYHtKKilIRKDnjooZwn8r
 xWGUF9cz1hUmveMIcYRQ2OxaG/bAmHDMbFEJNvIPKXRCrGfO9wna505NtL6ARagcIcXW
 Ttc7lrS3qwjuptzZcq9HAYiFvl3j1KyE8TObJKSe1qRh5UZTtOgcha/JnQ4JS8V3/tuf
 9g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032730; x=1760637530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTjH4sGVjFOYrHuOXXQp8+DmE+GbVi2pPpgMotQBb8c=;
 b=Njg04OxQ10hMxlcjY7BK2Tjhvlf285Oo+qWcR7zgdWbQENqDoP7oWfBvSc6I1hzoIO
 sjSqI09g1KZebC/9eqzCG67dNWMOR34Ans+qtCLWBTtxzgk6fx5u7WQp2nU5ZMRWA/Cd
 U0Nm2rcG0q2xmhRhST7hnXclswtgHlcZLi8gk5N9l/APXuO/8GldHTtZBC7cax5YEox7
 Ieq/XSQEWIse7WmkVKEAfNUd+467byt9ky2wfIPJvdL6KIDlP6ZOUBNICypZRS4KPENt
 kvF3ksG9gUORhBaxhzIA09mHT2FoDZKIwenNIkRDh6a5tnkiXu7CbcUlDWgpJQquGh6n
 3cPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUitQp2A5kzplp1hZGV2WAjNWh8e6Cy2AAroEHORn1uYrwIocyLN0sR8eG0Dqdo5qwJsVwNRgpU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCqS+v5p37rs0DYzIpHIGXpS9cmwHVrUfy4AT8s3H8y4eFb3Mw
 pRPZE3cKD10m03wdWT9Qwl/CfmvQkUsaKZjiSBzq7XO0ZNhmMKue295d
X-Gm-Gg: ASbGncs1Ku7YTjyjSPQtxEfdrKfm0UlWe0eUIrhYs1D0j5CLsDn0FVx6qCs1rlZi5Wt
 M6aVAzkrolAKdqYRLPLkZIBaocFZa+f9UNG71OdMBMfM3vj0f5Wq4T6TpsBSmxl/1Wl3UBGUb68
 gidJjLafnU/TXZCyS6M7d313BZrUKNKSUTTGBe1wZ8rMis5uZD/prxaVq1pAJNc31tqSHLGYTLi
 3Ufa/MvgS+vVauLV4Zon+EP5OIjAsrtCkrtS2Ev6v0oPDwvKIpv3MGtPNPPIUltaAoT0PicReni
 QF7PCtTsdwRPr/gqtS+UpcMSRj+7uXOl9pEOa31ETMKEba4VmXL57L3dycSBz2RntJjRzXfBuj4
 fe6nhFcjHDIbMZFjI/5xZeV5b8Asgz59S6tU7cKGNvV+DWKEeUT10XC604HS63FFNvScTn9GQXB
 LXeJWA548CiGGER00jxzQ4W6gnvnpEHXElcNX3og==
X-Google-Smtp-Source: AGHT+IGqp7iPYqC+hSmWS9kXElNlvxppUNSCrpXp6d0YnM0eWjcHcBKQts/HVhk5zAlEdOdTjEStJw==
X-Received: by 2002:a05:6e02:1a44:b0:42f:8b94:c128 with SMTP id
 e9e14a558f8ab-42f8b94e60dmr60429525ab.28.1760032729943; 
 Thu, 09 Oct 2025 10:58:49 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:49 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 03/30] test-dyndbg: fixup CLASSMAP usage error
Date: Thu,  9 Oct 2025 11:58:07 -0600
Message-ID: <20251009175834.1024308-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Oct 2025 08:03:12 +0000
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

commit 6ea3bf466ac6 ("dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs nodes")

A closer look at test_dynamic_debug.ko logging output reveals a macro
usage error:

lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, and 105,106 have a LOW/MID and MID/HI skew.

DECLARE_DYNDBG_CLASSMAP() _base arg must equal the enum's 1st value,
in this case it was _base + 1.  This leaves HI class un-selectable.

NB: the macro could better validate its arguments.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet<louis.chauvet@bootlin.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..396144cf351b 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.51.0

