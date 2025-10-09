Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B64CCD190
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2C810EB56;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSnAPg4y";
	dkim-atps=neutral
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
 [209.85.166.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A0110EADB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:54 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id
 e9e14a558f8ab-42d8b15548eso6140735ab.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032733; x=1760637533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFKSLN6BiOw7bUnN4PQUQFUZxRNUkszMTNMdPxBofl8=;
 b=BSnAPg4y3FbHu7LGYkZQnNA5KbAuOIMHsNwWGMgmJi/cTdzfaZicoo2h/Y0coDO2ey
 DmbdiyjEythU9uqxMtxyrWJgOEuySrgZMrYAXqrVOUw9EYl5xIZ04yeEjuDnfQObNXhJ
 szGWz5MuMjT/pYV5ama0lw6NGZ5UvteNFVCnSBaqUsTFPXSOXULIuw1cTZIy8fIrZq3R
 Mz+WLZt/GbBhMWzfxf8bnOwQeWSXFnMTYcJIUAAmY4On7+pj6eyrNz5Sxqxej+9D1vNL
 pKN7YU5BCS6Jw2ULXwkwFjPkN6ZVpr9Ej6PJe+Hm6dQyIdAPBLbiRbi4oWJVfM6tL+4O
 zIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032733; x=1760637533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFKSLN6BiOw7bUnN4PQUQFUZxRNUkszMTNMdPxBofl8=;
 b=s5BJNI+I4OTb+87kMgniBH34jN2dd6H6g8UKukgr8M1kcWQ/11pRKK5SsH/giwMkM2
 xkqPawqUbmadDwuTafI/TeZx4cmQ40WVBwwqDqYNXALENhqGpI9gX1JaP5M9WzO1hsSB
 DgotLr+Q5uxdKBGTN2vJBCGvlSiIuAyPflKddbAiNRKkXr69kB8J2ak+vixJiQQIO9MQ
 UhJIRbAIWOYbtnbOrfdUaC0LnaQ7W5sh3K8z0q2kqfjUNL1lDvrSxZX2cvBSN3GbsQ54
 IzwxJQydxgbtpBQNmMK2uE/H61fhCCE+rrRN57tz/NWgHdrXfa3TJNZTI5OKFTnhpBgv
 OfXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtdgpcrbqHal9/R/L8Hk/API5MHlpr2BrEW+qStPCNSXbz8hE8+1TrtpQOwk0oQPWWJMCOVy33@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPxFIzM3L5FvMIQxGvAMgcHGJET/Y1iuuU/SZkEbaPvHgtFW2f
 Vv+8T7men32TZVe+HxAGNI9KDx0Ffe/zuPO10rd+YQn5XGraiQZdzbbT
X-Gm-Gg: ASbGncujL9pVKmeIm9YG5QAhSHvSJCK/6ywpvlWx8G66aiC4kn0j+UmK27fIQQON1+H
 jzL5Acqun7nGdvlPvBsJvUEHWTEY0ln4RcCN4tsQbhO8IhyiGkbOv6ut2MBqHFF4QJXgUMq1NLB
 dyE9hNBo3K2EhI607UKxuQG9e/zGFfVPnhwSaXBUpXeqf7epLXOjQ20sJ2otgwql51nSd1+g7OZ
 Rlr85FklwGt8CrP91lJGNEeiMdlfJRbXjPNxqDgAxJ63K4ush5vDOD8sYhy2L8w89GXqqpJZ54y
 LvS4dhzxidmIrZ8ci26VqvP7cTBcorf4TqInelsG6CudoLYi+7eMdY1vLUanHXG9qrYa+Sbct6s
 ZciH5MnXRhU5EqiLZGm2yTQ4BElrxnSwO4OGMZASBFy8CxZYYw8arIv7kPmXa84EefFawTqxJxL
 uE3fsUoc8tH9rJTHSygxnQItXynEtAD8H6FdLnAw==
X-Google-Smtp-Source: AGHT+IEFgHidntDfvFhDlZruUCJmrkaroGW1qP4eIEz2kkTaQPPkZf7Zvr9cHn+uTBEE/+gwDo4uRw==
X-Received: by 2002:a05:6e02:1a89:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-42f8736aa0bmr82269925ab.12.1760032733126; 
 Thu, 09 Oct 2025 10:58:53 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:52 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 06/30] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu,  9 Oct 2025 11:58:10 -0600
Message-ID: <20251009175834.1024308-7-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9afc7731b7c..ac199293d203 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -107,11 +107,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.51.0

