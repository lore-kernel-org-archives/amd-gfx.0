Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BBCE674A1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6762310E599;
	Mon, 22 Dec 2025 08:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Syu2tmjs";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AB410E55A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:22:01 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so4230648b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391721; x=1766996521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFfaj1jg7DkAQbZ2xQqGZ0nerYqYJ2u1eC/UX4LEwiY=;
 b=Syu2tmjspjbsxZBZzGro64cQcQxDsuaF1oafdwsRYTmhV8m9oLv/T5CGThXCSSQpre
 KwrMxpwtrWG5MJP9eiw0dK4sX9hEOF5Olgzz8RN+zkWTdm5bvz8yM1Iti+bTt/ma4xj4
 REgQJtNslUwRe6fs2prz34bzz/FH7AyHFkTIP3tyTqi3HrIOfPYmEEZXEY1qoPdxIhoS
 MG2flnVi8hF9xIDw2wcl44BbzQisCRQdSQKBB4Z9k5l1pHx2GClnvhHADK/gnD07xSVF
 M9MphcIiuAcEISZ/qBmS3WhnA70rBSHcMaUvKJFYaryXyqjUvSpYSkuvkQKDn0w7EpKD
 sV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391721; x=1766996521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dFfaj1jg7DkAQbZ2xQqGZ0nerYqYJ2u1eC/UX4LEwiY=;
 b=ityE0B6FoW9lsFkXTnEN5uDnqLfZJ7HXr0yhHRHoLsnhqQezGecuIQxCJm2A0QWtUH
 H3v4HlBGvWs6trx6ucSRq2HDGi6VK5LJ5/ksgD1jqPE639wbx7m6mKJckrEqPVXtCACl
 rpWY7l55C869YjlM3AdicQqM/f6EzNuVP1GFArFHrqXepbt4fXq0vGeztw8udqyq13nH
 ok7HnZG+XnFt9kHFgszxOBfWyKfgL9WQCREc0X8Brh8qqGElIdyZpe73tV/UwuZrPFV3
 IThv1pdXCfsILqJ7pDEbF+Iass+bXxEoBmnZQ3Mq8JfJBufKFqSXY7506k8iAF7eeqvp
 3bXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4TxWlsQRKBqeKHIOjKSdpiagBeD5yoR3O+zZnYj5YefAYdrRuY0qmnxB/8uQfdnJvzOBJfaq2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7wZcUzc28/Jk3EXmgnhAl+B1RHN17GQv0ois37wCfuPtqfXN+
 nJMkxxpv+bf21QnE90XS/a9tFy8CaIZ+nMAv8zutqzp3nDNTBq6lxodO
X-Gm-Gg: AY/fxX6BDK7kqv18voFsI3nfoT8oeF3fqQ34AJLMKZPovH83MCGyMQnZCzqP/XXWgK1
 0mlSBkwQ54m5GYZjYpm176dBmbPVpGwZCLpBc/ctLb2AFLvCQnmsfj76YR3nRgFlP0+83v4OX91
 6bkmEtP2qV3CulMsmgN7HpFpX/pI0YzvQjS/dLvK3ax9HZTumYEKHw21k8lXrMM3OOW7fT0Bwkc
 uxi3YamSTsifA5PdCLuMhjlJx9jyrG067mnZrJ6yH5YSeCp3YnyW7w/3LUaLSMq5XQarLyh5ifk
 ll567/QI54rrc1DHEZDEw8p7IeK42Pmo0TQwwhR3YR9ARY2YUmd5I+ZNWVX0+BDQjP0dCmvBXb/
 HflU7kSnKRtn11CyooULbdZAUySoPBkNzOXUDmRW8HS5svSnkDGv4Q9aHapnfLamg3MdxMkQCYe
 PfvbVuhpd7
X-Google-Smtp-Source: AGHT+IG3eUuB5Tb1s+Zs70IjrZagHo/mf8fIHvmKfCB1AS8Rh4HCdjBPUwGbrg6oNBn8UN6DCsv0tQ==
X-Received: by 2002:a05:6a00:3e2a:b0:7ff:9657:d6c8 with SMTP id
 d2e1a72fcca58-7ff9657d93bmr10043630b3a.27.1766391721087; 
 Mon, 22 Dec 2025 00:22:01 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:22:00 -0800 (PST)
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
 linux-arm-msm@vger.kernel.org, mingo@redhat.com, jim.cromie@gmail.com,
 linux-doc@vger.kernel.org
Subject: [PATCH v7 04/31] docs/dyndbg: explain flags parse 1st
Date: Mon, 22 Dec 2025 21:20:21 +1300
Message-ID: <20251222082049.1782440-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst         | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4ac18c0a1d95..e76ccd987704 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |
-- 
2.52.0

