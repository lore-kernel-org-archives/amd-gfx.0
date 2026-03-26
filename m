Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F058E10ED66E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B4110EDFC;
	Fri, 27 Mar 2026 12:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTIbJaT7";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CE710EBB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:11 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-40429b1d8baso540355fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551311; x=1775156111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5920cM3w/QFHxSwN5yK5lUkglylj8O6aZoTa/l3EtaQ=;
 b=HTIbJaT7ORfDQQrrMfTBv8OUuaekrWxc+SIgOjpolf4BDCqqVq3WSWpSL7u8yFU7lI
 WJD9o9LGm9WImcS23bQTrQR+k9oWskTEXmaMT32/FSiSccyheO5axGNGrwmVNY26je+N
 scK8IP6LQgY6fIQQbHHagBYBoVDD7qtH9FEdNmhvkA3g40c4+cie2zb5Ij79kAVy6q9d
 MFHmV5IdzXYjNBFn0JBlcNEQFw2xfw3rVDNXLBGzAWc1THaGlQSF0v76I808DkA/Penw
 1/s5gQLrsIZcggujN0nMSV6xUclLZUURYOcfneToXozQ8Llxb281qfrHTcDABMAIFx/Q
 ij5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551311; x=1775156111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5920cM3w/QFHxSwN5yK5lUkglylj8O6aZoTa/l3EtaQ=;
 b=G/WUksLYMAbxVvhny2Yz516Sto+E6ut5Ey4rNLV4o9DLfYt3l2Xlphr8smT217sljN
 Z6B/ZZjF9dsgPhfXpcnEre77GNLvYvCjCiEtXC71dJZhUZiTzEtW5cxEonpaDNsdEx/2
 K1oj4l+Rkz0+W5wkya6XqVkTss4o970fSzgT8nO5Hh13QvVF1p0SQUFmeiCjavrG/3k6
 XrADtQIX8ZZ92tWxQA4V+ZrUcoPfI4mVrDdb1Tt60cNORBuo5Y5gj7iPkbLOB7QBUaip
 Dw21f76180RrhZV+Tz8ZwLO34WKhJS6d5YSRf2p3UZVmAavJaEnN+T5BqJ/FAObqHGVN
 Ru1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYtkq9cdZrQoDOlr4r2OHXCtsNMaCqB+5Ik7mz7EFohcGbWUVcS6xeSqNCKiYML0Yj98cvVIc8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBGt2Z5PVpTpXISiCtoE0PTAoUtl3cRQFZ+ClSn+BWQOvtjE4A
 1b7Bu9rRCvAntuPtUT8hLAnMe+spwIeRpdGZ4cvi4gktJZON4LParPCp
X-Gm-Gg: ATEYQzwFfMHinfEWb2kD0U12I9z63NHLbwrikLrVdf0zLZXZXoSTmlK59k04fytRRTd
 v5F6Y0fP1l5PaHAvoXp9jbDxa3xpmJcaQmZJpboLeiN1NOXoxlFKRQMwmKmNZtgRXLBg1FikZS6
 F9wDJvUixUPcLyLMczNoDeCXfE6MCqZdrz8WAqvTKus7XoLQ8o4wv+nSTLFBddRvFlzZp7teXW7
 /NxuVoD+BQmbhjZHNzqNHBHKO2QUBglwjjwVk9iDsAv2AxWY4KS/vjXVKaUhFCvpov46fzPIAWV
 r/9PJnqlufyjyVYxA7vOYr9IwrzXQb2ljQnyUssfdG5mapwRNU8JZ2KVPOpAPlf3+4Lz1CNPi6+
 ByJegUXbENE90v5/0XWy0oQ9kijWRKISJ6vWyU0QPXwuaWPhQHRR0fWa9PcVT9ft4ruR/du1Emp
 B5lld1pv7NGifPO8MI6jk2bFRbhe/EaWW9JyVsqejWhZQzocgGXgXfFvcl95k=
X-Received: by 2002:a05:6870:8a21:b0:41c:976:374e with SMTP id
 586e51a60fabf-41ca6fdc8e9mr4813996fac.30.1774551311110; 
 Thu, 26 Mar 2026 11:55:11 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:10 -0700 (PDT)
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
Subject: [PATCH v12 27/69] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at
 compile-time
Date: Thu, 26 Mar 2026 12:53:31 -0600
Message-ID: <20260326185413.1205870-28-jim.cromie@gmail.com>
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

Add __DYNAMIC_DEBUG_CLASSMAP_CHECK to implement the following
arg-checks at compile-time:

	0 <= _base < 63
	class_names is not empty
	class_names[0] is a string
	(class_names.length + _base) < 63
	dd-map-type is known value

These compile-time checks will prevent several simple misuses, and
will issue obvious errors if violated.

4 such examples are added to test_dynamic_debug_submod.ko, and will
fail compilation if -DDD_MACRO_ARGCHECK is added to cflags.  This
wouldn't be a useful CONFIG_ item, since it breaks the build.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
-v12

check map-type at compile-time

make base+len(classnames) check more explicit

dyndbg-test: add more tests of compile-time CHECKs

add 3 tests of static-asserts added to 2 macros:
DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_}

_DEFINE():
1- validates maptype,
2- validate classmap.length + base-offset < 63
_USE_():
3- validate user-offset < 63

As before, these tests fail when activated:

make KCPPFLAGS="-DDD_MACRO_ARGCHECK" lib/test_dynamic_debug_submod.o

NOTE: _USE_() cannot test classmap.length, since its a property of
the referent, not the macro itself.
---
 include/linux/dynamic_debug.h | 12 ++++++++++++
 lib/test_dynamic_debug.c      | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 71c91bc8d3a6..a1c75237abaa 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -181,6 +181,17 @@ struct _ddebug_class_param {
  * __pr_debug_cls(22, "no such class"); compiles but is not reachable
  */
 
+#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)		\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length must be <= 62");	\
+	static_assert(((_mapty) >= DD_CLASS_TYPE_DISJOINT_BITS) &&	\
+		      ((_mapty) <= DD_CLASS_TYPE_LEVEL_NUM),		\
+		      "unknown class_map_type")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -194,6 +205,7 @@ struct _ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base), (_mapty)); \
 	extern struct _ddebug_class_map _var;				\
 	struct _ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index fc599bbe605e..5036fd58d7c6 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -146,8 +146,22 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE")
 DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
 DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
 
+#if defined(DD_MACRO_ARGCHECK)
+/*
+ * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
+ * These will break compilation.
+ */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60, "one", "two", "three");
+DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 100);
 #endif
 
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
-- 
2.53.0

