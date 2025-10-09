Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C39ACCD18D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB2110EB79;
	Fri, 10 Oct 2025 08:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N19mMDzr";
	dkim-atps=neutral
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23EE10EAD2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:51 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id
 e9e14a558f8ab-42f7b17f9f7so11200965ab.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032731; x=1760637531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCaJXGEEoKxacl2B/5AyBFFUSkEK+Qm7rR3SS8wI7Gk=;
 b=N19mMDzr9eKdR1/lfrzPkA1PvTBzmibNeRQ2Om8CMUNm3rLEqln14ORw/og1V72SQC
 4A+tPRp/xjsSMbPh2y3ckR1ZUjVGsyRoBs7SjxtdnrTCMKBFRkOT+6JqzNTiB9/N5saz
 WQkwElcXwZswFxbOmVzp1191IVa63r8EE8ZT625QErJ7ab+Akb7AnMx6RNsgq5Sszhe3
 uGrz3mpO2IV86DaAJuu43q0bXbtQ902zqGfu7YvWN8/eEW9ddYZETAzGLAC//EmBTFdA
 g6ViGc8Y6tyZ1XdCw6Rl0WZ761a5mnyIU0mWYucIi6NMgND8fJrFj5dZiSU+G66PO18M
 0VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032731; x=1760637531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCaJXGEEoKxacl2B/5AyBFFUSkEK+Qm7rR3SS8wI7Gk=;
 b=MP09HizMHDGQeFS0pGvBDGHJCjtDNV1Hdy6PUfuG6EBkfw+V/oOgEKiEXsJxX2CHuj
 BGDPeIJCr6Xxarr6Mxvic1UeLoQhO5KXjS0E2tlaHfZHdC+GFDhqnGOCrQAKQXFi/xZX
 mcSK9KJ8pLlvIii8I/lqvow6EJYlKHJyeIEHaQMyP0W5lGNMLavmhsONHo+niD3Wsdqy
 YN3yU18CYgZJtCdqyd7zdFUzrLNHIpIxNIFE5u+4QYYowlXaBJwy3oaFTg2DFoSqJYxO
 Df1/0tFhZ5Lpajdv3M8ZSgg2NCmSvaA9RXXKGt8BAUPtCn0jmjDMU+TkJyKBgSWJn6ru
 sa/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTg36yRWHHoxZqmrdT6JUbHRb9XAOubB/qvBt0ZSCPJWkVR1+BIMmebLok0Zlx7f0SI8CRtMEo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyN9U/fQ6HoSQ3zZTSVUofOG5HdkMsrSTwBOxUB6+zWCgcmf5H
 F5kJqt+WHToasj24LeZ0XxnaiIrWb0+IaXDDRhPElMBMRl8r2X/8Mk/f
X-Gm-Gg: ASbGncvPyDABhNKILf/tGGezjmD1mXoKg7JigC5BaSPmF2hPeqmfibs8etqvWndOOvq
 tSqBve9439gwGVzPeWRcmigetaU7lew8ae1nQwWddUdmdkX4cIflcPbK/xpsMB6YK0/0OvSdAju
 AVTyELm6nkEhk4zu/sNAVMzmfqp/Nmf1XOO9TO5UzK4QnyLLr7DCtwuisdcHot3Dq85g6mLGzfS
 tW1Mo99iGfMm8+mh1u5J3f8NPp7oQRE/X+CLaGDMudNXHFG+X4cgYAt8Ob6Twaf0eTJsmklgcA3
 0Kp6zmIaWv8vWvROymU6wwLYThf+foJ/yxNVzanmG+3BlfmbyGcf1AvvlIc5ylO7PfzPOnZBCBB
 6Tjt0c/oMJjCJIsSDYWr27xmxocbtmnjS2fT/un0pevtal/SAPDJD3cTJyUJwjt/FlD4/SLNwfq
 JuuqF8WqsSTzUYq7R3o5phZF3aTQfym+K2LxgnzQ==
X-Google-Smtp-Source: AGHT+IFGYwQAi6/+LnQSrv5XVqN8PJXx4dyNZG3PIv3e3G7kxepvzgPF7iyA+hTKfqnZ5PXXLeiArQ==
X-Received: by 2002:a05:6e02:4706:b0:42f:8eeb:499e with SMTP id
 e9e14a558f8ab-42f8eeb4a3amr54728835ab.13.1760032731025; 
 Thu, 09 Oct 2025 10:58:51 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 04/30] dyndbg: reword "class unknown, " to "class:_UNKNOWN_"
Date: Thu,  9 Oct 2025 11:58:08 -0600
Message-ID: <20251009175834.1024308-5-jim.cromie@gmail.com>
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

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..147540c57154 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.51.0

