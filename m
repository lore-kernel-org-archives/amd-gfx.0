Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97389E677E9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A399210E517;
	Mon, 22 Dec 2025 15:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jm1AUlHG";
	dkim-atps=neutral
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 908C610E5CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:25:29 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo4233799b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391929; x=1766996729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ6LQIhz3opDVp8qv4sJ5LmxJU4UfSK37U6o6GR2gQA=;
 b=jm1AUlHGDPOcW4GE1XtrmSAlx9M2JPf7oMcN8viNQMaKQXvpyhFdgxnuj2+KnXopS1
 eg1Z7011tWxq+DyEN1fayiHDb8e2KMtHeFoL27rkot5AWKkHN4V2stAfeKhKxW3xgOpL
 HtFrthgOOJ0oawKougrg43wrol7zAco5OH5JvaP6+X3zLIEdKuApPbeAMtK5KgI+4ivS
 e2j/ZqNXEIFhllmMqT8UcVsUhRrDXvHALddQ9yxlt0atp2/3i1EHYvyRRr+PFi8NFjgw
 xsRLAsU6+Y4yNsUKiOpHXKgw6XGzDE8ms1rYpJDn+gy9Upz5JB/n4v0T9pjqymDqVacD
 3ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391929; x=1766996729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJ6LQIhz3opDVp8qv4sJ5LmxJU4UfSK37U6o6GR2gQA=;
 b=AEwocEnqJX8uHu5icdyiMFWdEVpQ3DAscK1vQynzwGEsZYGDH47xTcIQL5PUM2Iq23
 DTuQONIOFqioq36pASDcQe49xKaZ7pXyj06y/PQ9fXa8Ao8O4Hy3HhA45tnb3HAl9HAn
 fHz5d9sFvuvV5isKanPIARF5MexA8P+RYMp2PCl76bA4HBslErDxEFgcSzLjoNQP0gxd
 quvORqBmV/ITGcttIcetQ0RrVLaJwIGwjf9/fSWyKhXE6HC3dGk3mLlgEmKojUUQ8y2e
 rDgRjayq6+S1zUTps1mcpceDXR781hszgy+OE4DiU9RynNnYRvDRULOCJlocR5R5nrsA
 VWgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHHpLsMNrHnmD692gATJ8FxKBiAscTOcDErdzSkRy87YSYPp7guE0WhZ4fGIpP+W8aTHZFswHW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFPdVcbvGh81+xSuODHMbWCgLOdveZNKCa7a0u5P0PRW2w8IT1
 L7fcTGHokqvHvH3QiA2irX1nM1jjTpkUcewoYZ2ymWPRnohEaqxv8Zgu
X-Gm-Gg: AY/fxX6+MEwDPMKwyXdwiE8+CbhETOXLdHv0sLqC7fAPqbn4/Pj9QWvm6rprffHJZb3
 itedex9UJtHPP2KpHjw1oz1ta82Dlw6UnnzHGPJw52NMDnRncLC6QBCCfPrhSJDmSZETT9mtgdo
 BYpFxqkK67P2NUv3JoEUus9FeuQYWAMO+56JkVv3zl5LoW+BB1DH9auF8hEXLQjYLALoQpKhw5u
 dUnlsKYvW5GMD5IGNgPgE+wnahe6GYmv200TA3LCGPBFAv+SYzO+UoPE6gFKa7Q/EPJzL+Mdqm2
 d7j61OyNK70Hhnp/0fcfFrh6s38lG05+3eET0dkVdonmlBEhkkZ6z0KZ7w1lqbuWmRrzWKT+Dad
 ajgoEBFyzciOvRAPbTwhqelNR8/mPQsu28c7oaLigB1Sd9ILnaQs4XreH5gVo9Z9CEkce5Sx9t0
 hSDxC0FtWP
X-Google-Smtp-Source: AGHT+IE+QxCurRN0AzDICu9k2MWk1SPp1amxCYIl0Rf045fB7y1IHjsIYvGaV+1OKSxAVQgufeDctw==
X-Received: by 2002:a05:6a00:4190:b0:7e8:4471:ae5d with SMTP id
 d2e1a72fcca58-7ff67456c6emr7951795b3a.41.1766391929081; 
 Mon, 22 Dec 2025 00:25:29 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:25:28 -0800 (PST)
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
Subject: [PATCH v7 23/31] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at
 compile-time
Date: Mon, 22 Dec 2025 21:20:40 +1300
Message-ID: <20251222082049.1782440-24-jim.cromie@gmail.com>
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

Add __DYNAMIC_DEBUG_CLASSMAP_CHECK to implement the following
arg-checks at compile-time:

	0 <= _base < 63
	class_names is not empty
	class_names[0] is a string
	(class_names.length + _base) < 63

These compile-time checks will prevent several simple misuses, and
will issue obvious errors if violated.

4 such examples are added to test_dynamic_debug_submod.ko, and will
fail compilation if -DDD_MACRO_ARGCHECK is added to cflags.  This
wouldn't be a useful CONFIG_ item, since it breaks the build.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  9 +++++++++
 lib/test_dynamic_debug.c      | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 905db0b49104..b19c9b1d53b6 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -180,6 +180,14 @@ struct _ddebug_class_param {
  * __pr_debug_cls(22, "no such class"); compiles but is not reachable
  */
 
+#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base)			\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length exceeds range")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -193,6 +201,7 @@ struct _ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base));	\
 	extern struct _ddebug_class_map _var;				\
 	struct _ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 1ba4be9a403a..b2bdfdfb6ba1 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -133,7 +133,7 @@ DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
  * Enable with -Dflag on compile to test overlapping class-id range
  * detection.  This should warn on modprobes.
  */
-DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 #endif
 
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
@@ -146,8 +146,19 @@ DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
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
 #endif
 
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
-- 
2.52.0

