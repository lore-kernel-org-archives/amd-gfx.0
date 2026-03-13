Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D24107BCCD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF7C10EC92;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gl67R/Mn";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAA210EBFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:31 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-467166cb638so881896b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408211; x=1774013011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaAiGHt7PLiNFokoH+wcRTOWenkuKwVpfHhxx7Kp6sw=;
 b=Gl67R/MnwuYOdXexmVDmFg7n8BKqxcoW2rhWwCgLzyDeCKC6fdW8VNKK579IxOSUAV
 QbTNUlIaps765yTrVGJbaJIE586LVTHGuci8hOzdXF6fWCoPxqxxoAkn7e+CcXeX4495
 erx0wCWX8UMsM6Mw7GxbPkfTcUKGAV3b4zbmklu8609L08TNi3Q/jqHDquqCzwG4uuoz
 SVROOIKqH3+UNENDIfHlii6bC9wnh1HvycC5CMhNdzkFUGWZ2yJdYXS47R3nN2aYbAYp
 t9wvcjqZFf+B9JwGm04sIRiHZrVDlbPd0tgX0dgg9Ws0ZISLA2Ykd6w6kLRJXqv6Th92
 pFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408211; x=1774013011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MaAiGHt7PLiNFokoH+wcRTOWenkuKwVpfHhxx7Kp6sw=;
 b=GrudJHnQvelRIKd9wjVK1IkO4yblC3MIgf59swJ9gH/9Q7kzOD4GaKWlCUWxxt84it
 TjK57fZnP43E3gtVuvc2dgf7n/4PIhHCAAlL7SNAyapwrnR9ODTtwzadD8M4g3OJryJE
 wWnbc0eUGwGYQHz0jXzoorCivQhN0ubdPN2fh4AcWoRldSkvU/l2DETXH6rb7QYQ2mtn
 JGzQOgHlYKccgiT84x270MR3WLd7mnZ5LOFvdqub1UDXDyeLnPqdcChAXedOGcUmfyZ3
 hxtrnwlX9GhkfN0uJF3+M2mz6n9m7tiuB5hiCxggWDOy1z7qxwTycLJ8B96IDCaxF0OM
 6yww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaj4TsW2CMzEnUvxYn9fMK8uxzs12VBZvjwWAQyz8sBtnDVzmKz81Gz+oj0IRtR7SjDVyTvk+p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTBxHN60VvpAum0eOYuDjX3vQWmklAdbeEntRXT4+VnMOygu57
 oJ7/33V/1iwU+X97kaMzwdyD7UBwG7EYGzp0WF0sGvbSf+VP4WhWRsWa
X-Gm-Gg: ATEYQzwPQL0yopPzJisi8knfObZc0WsbUO3zTQnqsFEM73Of6KXJUyF41rsQyY+hSqX
 PuaQpkwOAK9ySvnc7WfqFAwEWVzDOiB7Ma0UDpc3J/vEmKbLkWZD5b/eL2L3aPGNcg89n7uwk9B
 5y5T2TCzpEe3qh6QGlurquwVadioEea3t0oFRU4AjwLyDAfo4AjWZhnB5417zHCsXDTAY6sjpi1
 jar4KsxWtmWhbqruKn0ede+xVgUmTUc/oOxYHGoaNpd3HXA9EvoJbhtdopevS3hOV98kcbDW3Ir
 0XsDvI1DUvEqTlzPpUtYlInY+R+sRnTmPt6N3MDXH9vlUSa1QSqHwk1RjDM3VY/4UB4y8dvM22f
 9lQBp5EEXmNYpoaSlucCiAmu8DUPgBYVt1qKTs0bso3AzDN1qsMgK0PsmfI6pmlZLR+Rr/ssShK
 HCEJtVxYHozh3Vr4mKejJLHYjPHWmqVp9lY6tZBIETvFQAN63f
X-Received: by 2002:a05:6808:4f4e:b0:45c:925b:5848 with SMTP id
 5614622812f47-467574304eemr1623103b6e.45.1773408210779; 
 Fri, 13 Mar 2026 06:23:30 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 17/65] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Date: Fri, 13 Mar 2026 07:19:42 -0600
Message-ID: <20260313132103.2529746-18-jim.cromie@gmail.com>
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
reordered params to match kdoc
---
 lib/dynamic_debug.c | 57 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f47fdb769d7a..df7223532cf5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -170,8 +170,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct _ddebug_class_map *map;
 	int i, idx;
@@ -1247,30 +1247,35 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct _ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		}
-	}
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
-	}
+	vpr_info("module:%s attached %d classes\n", dt->mod_name, dt->info.maps.len);
 }
 
+/*
+ * Walk the @_box->@_vec member, over @_vec.start[0..len], and find
+ * the contiguous subrange of elements matching on ->mod_name.  Copy
+ * the subrange into @_dst.  This depends on vars defd by caller.
+ *
+ * @_i:   caller provided counter var, init'd by macro
+ * @_sp:  cursor into @_vec.
+ * @_box: contains member named @_vec
+ * @_vec: member-name of a type with: .start .len fields.
+ * @_dst: an array-ref: to remember the module's subrange
+ */
+#define dd_mark_vector_subrange(_i, _sp, _box, _vec, _dst) ({		\
+	typeof(_dst) __dst = (_dst);					\
+	int __nc = 0;							\
+	for_subvec(_i, _sp, _box, _vec) {				\
+		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
+			if (!__nc++)					\
+				(__dst)->info._vec.start = (_sp);	\
+		} else {						\
+			if (__nc)					\
+				break; /* end of consecutive matches */ \
+		}							\
+	}								\
+	(__dst)->info._vec.len = __nc;					\
+})
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1278,6 +1283,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1300,6 +1307,8 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 
 	INIT_LIST_HEAD(&dt->link);
 
+	dd_mark_vector_subrange(i, cm, di, maps, dt);
+
 	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
 
-- 
2.53.0

