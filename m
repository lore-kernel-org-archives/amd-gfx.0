Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75637CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB8410EB49;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IHKCmk0X";
	dkim-atps=neutral
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com
 [209.85.166.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B43510EAE3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:59:12 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id
 e9e14a558f8ab-42f5e9e4314so12594375ab.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032751; x=1760637551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0XzNWaGxbCntgrurWhYrm4iEPkiXeipxXgUvuzvBHw=;
 b=IHKCmk0XoZYmHYEtADyXvdDY7i5YTwMY1PjmOlnFZRQZUphGJXoL94APQF4CpP1TeK
 vhT5DPCpmtR3n2hgRHB+/NsWmARDqc856Poe1fivSdpslcXuKXS5qhicwN5y3WtYXYbj
 qd1gnosUf8ojjl6OP+Yk4orV3ADBTF+bF7a3u2mbOUSo99FDLHMO6/YKD62w6G9M/Mr8
 xf4DF1PFVO9zLKDvifYvgcHEE1PAU8cqddxTBssgi7Z7QEQV1kpBHTLRYdtVsHtTu5QC
 RCqTQEWckQ2Y8AtcCKaQG24y25F74m5DKQBA/eitebuvKO8IGINpTLBseV8V/Q2RHQEZ
 KY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032751; x=1760637551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0XzNWaGxbCntgrurWhYrm4iEPkiXeipxXgUvuzvBHw=;
 b=I2noFygj9hbNT+jpUv1ZjtzHp2SBjSvd4ZqgY2SPY/mYow1EfPAdVRND6PO1hdAvey
 R34lvWMlYBAHnB2EOHPH4FcSCnNS7sVzYohrX6pluLqOCw6oIAMWEbYCjME74ryaTa72
 Fqg1MpWAuCkja5kYGTcpcddPihJGDMAsys+koU0PIsFIJmO5XZilvWqSenPVnmodK5Vf
 dK+kXXFEgXbWFQnIqa+LG/K0kL4naTvKjelWJmmNxOOOGerRLhSwls8EZL71Y00A74f6
 6QNcGW9Eb1IRMlKiDz1urWKTSWx0dPo++DuN5V+mXIqh29qY38wJfxMtkFPOCmO4tPeg
 EZwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd1SQQZ4875lyETkYE+7RwRZJ0E9urMPtVLIRh104nM85VqDu6G7qeF0XpaGvDXNdq7voEwp3u@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzkg0Ze19GN8sQyvlu3G16KovZ1oaPun1DcVccclL+MBBRcuuBa
 KG1XeTiplPssd2gQCvRmswhYKRDXOWq1sJ1r2Dk8BzyudkPvnDHlg3fW
X-Gm-Gg: ASbGncuVZgkI70lCEt1jcEGrYfHJu4HqsiFZUebRtDoMnBiv1+Rl6Ct9LEWBeHb+8BR
 jtah3ODqPnzt2Gzlsb+v3vGoy/PfhNdgZZY5GeCAAdBPGB9xRm7qtblrlQ62jYa/9EruNwUWc9E
 bMMVkoEr/ojUorhjo38Bivyur3vPwz5WffhlK+5dJ0xsP2iV3gmCnV489RUpXt6teEHFb5QqEUI
 2L3l0o3jjWnUCaGrD7PinwUYneY1yi62Mctbl09amFsJt4T0642PlZFdTlweWeq8h2DB4iCpda8
 aDaQ83WZ4V4/jRJUkeJM3kvtHZ0NfHh8q74L8+CH3ZtyqWMb38pINoCcKlHxsE95IRi//XzOBVz
 7JvKjJ3rB/07ot7eqC8r1jUefaD3cHqTs+HCt0LE2SzKaQcfn6CBgaM6MV4tSnThxRj+7JbE3V7
 pDCeTO+5Jz9De+huyIdAwS1x92nMk=
X-Google-Smtp-Source: AGHT+IEYsyaeLyf8EZpNw3F9lCq0tpNVoC1uSjvB+6nwdk9sRQjO0dbdJ/WpD+G+dOz+8SbQ7siORg==
X-Received: by 2002:a05:6e02:378c:b0:42e:2c30:285d with SMTP id
 e9e14a558f8ab-42f8735201emr80190015ab.6.1760032751102; 
 Thu, 09 Oct 2025 10:59:11 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:59:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 22/30] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at
 compile-time
Date: Thu,  9 Oct 2025 11:58:26 -0600
Message-ID: <20251009175834.1024308-23-jim.cromie@gmail.com>
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
v4- deconflict after pulling macro-stubs forward
v3- $macro_name =~ s/DYNDBG/DYNAMIC_DEBUG/

prev-
- split static-asserts to __DYNDBG_CLASSMAP_CHECK
- move __DYNDBG_CLASSMAP_CHECK above kdoc for DYNDBG_CLASSMAP_DEFINE
  silences kernel-doc warnings
---
 include/linux/dynamic_debug.h |  9 +++++++++
 lib/test_dynamic_debug.c      | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2c64f2401e51..b96f069290bd 100644
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
2.51.0

