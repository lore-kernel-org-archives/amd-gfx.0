Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C4E677EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DC910E6BD;
	Mon, 22 Dec 2025 15:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neBQnuVn";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067F710E575
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:22:50 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso5006575b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391769; x=1766996569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbNTI65sKfDeAaHShpwIIW/4QzYcWu3sc0P4jYcnBH4=;
 b=neBQnuVnzqt1H6VYOlP3M8KKFRI/cdKsOs3057KO5vNhsv1HbmMwGjaVH15rsyMKo/
 N4ZdO94JS47LXLlFvUizmZFqWUnevi51Zgx1usHTPggd09nMkqZTs2OIV3Uvvw2fBV+c
 0+eacWIonCw1Pxvbvx49TWdjkDpuo0AgR+d7B2mAdf2tWg65Icad4FES8F+s3A+5Qpog
 gBJEHIf8vEB6jIuFnXyLLg15qascLywGhdyt5Ni7672afCUd5aM6lmmiK/n+Lu0jEf2X
 bYMcs7+8Xixtmzz0NSjUX4jhTUnKompVNPl6Oh8iCSeJ+QzrUsInR1N8oZ1KyL5H5nYM
 vgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391769; x=1766996569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kbNTI65sKfDeAaHShpwIIW/4QzYcWu3sc0P4jYcnBH4=;
 b=WhJhakjgYBFUMFzWdzsNHArY2LqrOQiRtNxcQzYXLzI01G50dbLiQVnicHjNsuCY8d
 +dny/lmQFg2UPnIlxaezYoIrAmO9Vwli9x4wxpNaD0fWGE3o+I77f3aoURp+BVAdx/ft
 UpHk1+LUZGE5BTwnPzxlNeW2tXvkKbQ+Vj270MDdezHtUvLQRZTteHlDk90Xmo+zxA0a
 Tx6RVbZi0XojEOdaQMcf7p3ljOUbhK7oW8sGYtYEyCPX2Mi0rUIfEE2MNQD/0QUAh2MI
 Z01qXLe5YWrXahPrnl3HlPBNdaAtRkliF+TMKgk6K51QI2dmsFEGHRRnvYOB39g2Fx/N
 MbEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe8GndB0r7zGvNEg+vXw8XFlLWkT9UwJF53G5OY/phPqIkTwX1vc4ScBiHPOt5XQ4IBfof14Dj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9TwphWeXJUQUbZehe1qFa0BPL6b+fCuDvQe8PY0uoZzmo0lBY
 TIXgH4cvZt43YzzUse+9Rnewn4NlY3O56WpBRCol64hCskwVNEVZR/nPM5SE5ER1xZA=
X-Gm-Gg: AY/fxX78zMGj8EOA7U8xVSAg/45d7L1uPuf2KmDsOyCzoLBMgdt0pOnPhdnqfB0xqfc
 tQQ5kQt+L2bLHaoQLbRoJWoNV70XHo1/3LLaYdzQe0RhH+ULCsEa1JkQlDvg7p3sdavdRacrrlu
 ZMDY7GEcPM9fIX48SGfbjJGbyQ2Vabzm46MAfQz90/mbOHM9K3uaNdFEDxhscoCILDxtgsOUAO/
 osAOe5PAPDFsVqUEwKz/0Phjfmwl7dWu9JB8Lv+a6c32Jzt0vecVRi7J/6EBBHf3n+2xpjyV1di
 oto9p5awvfuzlltzW0+PufCCDOr0FzkfU24lgXAPP1go+jleSxyR1jPyStCQTdtOjLIJ9HIZKL1
 owa8G9sQHoaAoIhCMCh/2mR9JBPnNOOF2Eh3eQKCQe2SdaNCa+q46F/6CA5MUmVi7NEGbB1oYGo
 0igkhLCi2B
X-Google-Smtp-Source: AGHT+IGD08I50soJcdL+xzw0QhupyvnNGdXij4KQgDOgK8/wl2+Is9lHSt1ytu+E7hNdpFYZDBEOMA==
X-Received: by 2002:a05:6a00:1d12:b0:7b8:16af:3bbc with SMTP id
 d2e1a72fcca58-7ff650ce054mr9986499b3a.31.1766391769458; 
 Mon, 22 Dec 2025 00:22:49 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:22:49 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 seanpaul@chromium.org, robdclark@gmail.com, groeck@google.com,
 yanivt@google.com, bleung@google.com, quic_saipraka@quicinc.com,
 will@kernel.org, catalin.marinas@arm.com, quic_psodagud@quicinc.com,
 maz@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, mingo@redhat.com, jim.cromie@gmail.com
Subject: [PATCH v7 08/31] dyndbg: drop NUM_TYPE_ARRAY
Date: Mon, 22 Dec 2025 21:20:25 +1300
Message-ID: <20251222082049.1782440-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 15:34:03 +0000
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
index 4b7c3b997657..c4ae79f934d9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -131,11 +131,9 @@ struct ddebug_class_param {
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
2.52.0

