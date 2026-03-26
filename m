Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E3B10ED66F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AB110EDF5;
	Fri, 27 Mar 2026 12:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtEyGh88";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497A110EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:02 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-467161c4ba7so760707b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551301; x=1775156101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLjFx8xvoYU6I9e8U5366NO9qUPUvtME5XDnhqfKA8c=;
 b=dtEyGh88X+r5zpzihl27D8Up+IHI1Aklog6su6Gl8SXCxGlAosTsvK5DBfAPHSg6rx
 5JmlZY+5WTkR8cmVh3DKUiU5IGh2tq9SEmxCbombX23utRl5y7W4tFeNVq/7xmdVHEBX
 PpXgGanBom7oZoC8fdOkX3pyN9FCyVcR2lZc9NQRupDvWnvfQiEwbviN89RJ+eRwxH8m
 JkywqxPsVSg+EDcSFZEgY67cGR1nHcabq1FGuigf7RdZEikNzlcepL9BN6q0yGU63SXY
 vP44iWe1xDrHzyEkch0FZ05c4x+qbTsQOLaw+13HJzQBxjb/CH711LmFWsreOgW4cCio
 LOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551301; x=1775156101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NLjFx8xvoYU6I9e8U5366NO9qUPUvtME5XDnhqfKA8c=;
 b=ifoDLdkj9QxXMV+xtC+HVXDLJD00Fk9WLNKmSabN3i8GNxtfFpMZdDjeuLVHdaVwP3
 ID9WUnnUJxwIxgePrb6ObdVGw22PuW2tyUpYC3PtSc9BtQXIced8k77ZbdQTv4N+06/M
 7PIJH4pIB7YN073VGq67eGVx9H1ZR8g2wtDhAjXhyppFRelX7lQiRsyuWMccJbh2bv87
 vNoUOTrQMDhlq+IIrrgOXnCg9YxRhJR78Mo5AS8adyrMsC5F0L1YLYpRDWB/ViWGf7mw
 K4DXAgrXzXUhSdREZxBTh+uAFQBHcPegY3iB14/zkbQic5HZRWMSUjhvuQWSyD+K/Wq0
 Pt9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMLJOdV5zMIpJ/uxEiz53eXxUrH/SorfGC9KKulCI8qeAwzEJ1D0jUh+Yu3u66yfU9cK/lZP/l@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPF14Ke0xAyjiORBmr+PMU+WNONW/pJvTTwhj3bcnApCd2ws7t
 82LF3QQIByXJDyDqgphdHt6iIgLD+Iw6w04nH5Q5UtGWfNPeI87s6OIc
X-Gm-Gg: ATEYQzy/UfeQwm7w45EmPUwRlgTcDlusA7i4LlZWEmSg89R62U9vgEe4/uLoCi74ARQ
 8sCu6D3S1+PHVotB7vsUSiA3BVWnfs3jW0Xq46IPC2p0i/7gWdXDFysXvsgWdmadULV4vnkp8m/
 dlNchAxTd6JRU0ujPDFSi+OG7aXjyBSmfXZS9iloyegLmmQ8RmzLWrCFVX/iRzRLXqHpEDt7Et/
 wrzU2H8pgm6VaGKd6cXaI6wJR+ro7CJ5h7Us39rZGFJllENF1TpXZkQOq1QE7TTKXEGwJS3s88t
 4EYMehSC3suhbDZiG1s1AxT/+gO8OVp+4wkEFu6l/FQDcH7YKQrG13R1Qtx5OqIR0JW5XIQ0FsC
 aB75velybEaIHk54wWAdXjlriEH5eN71HeUgq4TZnut2B1BQZzQpmOoUMXTrniEZteWd0u7bZVD
 BxINEV5xKbXA8McymHS+Hkqfci/UeqMtsuYf8yyKaB6zNmIDNU
X-Received: by 2002:a05:6808:3509:b0:466:f451:a0c0 with SMTP id
 5614622812f47-46a7a84537amr1185457b6e.1.1774551301362; 
 Thu, 26 Mar 2026 11:55:01 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:00 -0700 (PDT)
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
Subject: [PATCH v12 21/69] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Date: Thu, 26 Mar 2026 12:53:25 -0600
Message-ID: <20260326185413.1205870-22-jim.cromie@gmail.com>
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

The body of ddebug_attach_module_classes() is dominated by a
code-block that finds the contiguous subrange of classmaps matching on
modname, and saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).  We will
reuse this macro shortly.

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which already segments the builtin pr_debug
descriptors on their mod_name boundaries.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v10?- reordered params to match kdoc

v12- refactor/rename: s/dd_mark_vector_subrange/dd_set_module_subrange/

1. Renamed the macro from dd_mark_vector_subrange to
   dd_set_module_subrange to better reflect its purpose of narrowing a
   vector to a module-specific subrange.

2. Simplified the arguments by removing the redundant _dst, as the _di
   pointer already provides access to the target _ddebug_info struct.

3. Refactored for Clarity: Instead of overwriting the struct's start
   pointer while the for_subvec loop is using it to iterate, I
   introduced a temporary __start variable. This avoids the "subtle"
   side effect and makes the logic easier to follow.

4. Updated Documentation: Improved the comment block to explicitly
   state that the macro scans for the first match and counts
   contiguous elements.
---
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 21ba5cb3b406..443f0fd6e8c4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -169,8 +169,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct _ddebug_class_map *map;
 	int i, idx;
@@ -1271,6 +1271,35 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	}
 }
 
+/*
+ * Narrow a _ddebug_info's vector (@_vec) to the contiguous subrange
+ * of elements where ->mod_name matches @__di->mod_name.
+ *
+ * This scans the @_di->_vec for the first element matching the module
+ * name, and counts contiguous matches to define the subrange.
+ *
+ * @_i:   caller-provided index var
+ * @_sp:  cursor into @_vec
+ * @_di:  pointer to the struct _ddebug_info to be narrowed
+ * @_vec: name of the vector member (must have .start and .len)
+ */
+#define dd_set_module_subrange(_i, _sp, _di, _vec) ({			\
+	struct _ddebug_info *__di = (_di);				\
+	typeof(__di->_vec.start) __start = NULL;			\
+	int __nc = 0;							\
+	for_subvec(_i, _sp, __di, _vec) {				\
+		if (!strcmp((_sp)->mod_name, __di->mod_name)) {		\
+			if (!__nc++)					\
+				__start = (_sp);			\
+		} else if (__nc) {					\
+			break; /* end of consecutive matches */		\
+		}							\
+	}								\
+	if (__nc)							\
+		__di->_vec.start = __start;				\
+	__di->_vec.len = __nc;						\
+})
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1278,6 +1307,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1299,6 +1330,8 @@ static int ddebug_add_module(struct _ddebug_info *di)
 
 	INIT_LIST_HEAD(&dt->link);
 
+	dd_set_module_subrange(i, cm, &dt->info, maps);
+
 	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
 
-- 
2.53.0

