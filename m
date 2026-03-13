Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A7C107BCCF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CF610ECD4;
	Fri, 13 Mar 2026 16:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mOzDWYib";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B38D10EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:07 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-46704177543so1451154b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408247; x=1774013047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUFWI26wJ3+Z57HFFsxefXkK3D/1IEaVOdGJ9g+Mjso=;
 b=mOzDWYib02hXz1WqVhevQUL1cUUyaHw9mW8uuFIQNJ0pxV10YFg5xUlkI0rTlZC8ev
 WO8PCVox27kfG7WBjflCfF/6e8W0pAN1sSvPdgbBH9mrPDpnJm8K2bLTLBszrL0yKBow
 FEiGVv6k5IKFaFzX0MWdobEKnz3cbstJBDnIy8p/8hZPh0SBnXIKw2OxWSSjjpp4PhOd
 qcn8tPFoYpOxEdsBjEN6J+NgCeT9Rr/tNDjGyEZHldRKL+0LLLRKqwERv9rjPHLd5yN0
 nNOvJpZtHmz7zbJndEMQP8DC0kJc1nsmcCtJ9FXq5sOBXk4A6uvRUAmzt47lp0DZJneg
 ZA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408247; x=1774013047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUFWI26wJ3+Z57HFFsxefXkK3D/1IEaVOdGJ9g+Mjso=;
 b=cktORHKyi5A4avHY/7iBV+WPu0nmmJS+SI7GGRV3uwogpurJS3EmF8mGrLqjD2vC+0
 +p4GVLlVkHu+xsSpHIWlJdN2/jtP1cPJTkXpJ07IMXtW/Zcb+a2LJ/Tli//Vjc4z8mU4
 LeE4vOB6Buhe9uEWBOn9ddFksNEThQ7cyrNlPC4qfvdR+rXBLwASiKrJOR2jqirX++t7
 BwE1iH/VVxHYQm857kM+VJxfxfV5zHt7hyQJHkIhRmJ/RraUb6D0sI2OLRaMT7oy/PaW
 SX5olAvEMYLohVEn/Jy1wIz0a3XgnVk8cjOtkbcRGkGLRPx6Q7w9SufQ6RGRym5I1Uuk
 G30Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0egyQVzUvgSGZONAmzaUTJaY7g691j+JyxgjGSMJ3CQGZtVNH5b079fPbUoeQczPqtdE1T9lQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwunHdWcUfNjYM0soKeKl1xixkIm3f/LzHxhz06bBzixG0Z6nRZ
 2yRTzfFE/m6mzqLTR3uE9JJol0RRhO4sZI9AAmh7jYt1i+Ge/Dk0NIM2
X-Gm-Gg: ATEYQzwMglc/+GJYobehm09BhyhOQlGezeB0O0AZhE9RHGMGpoKsJ/UDfU1bbfuFl6V
 1DPKQRwPRpkvzMpus3Zh5qu1fREK8jXSqG/hKM7PxyWApovfJj9l6aVVFf0UbfE6wPulPJUlcUM
 JDCVf81Rb24ftXTd3RqfUtPrxqwQtQYYI+tSNVqL1Zww3qYWKNG0KJzkugz1pJ8/p7ifS2K4eIR
 jGT+vYkmacybNFQW1gL2iA4fi+SWdotsxilSjUuKdu9CDAp/XJOf66rFkr9sNm/kVzZRMrKu2rd
 xMM7nxN/OgSnS8sJ7i/Gx+A0Ya6vXNFm01QJq6rKpZNc2KmrBlcJ/L7mehIMM/2NUmKY1JRvvBX
 8gENDOIDjEh0vUSjc91xD8c72LqEFAXsntzBIZlX6vyG4QiJ5c2gvJsU5JU4PBcZrfXWpA+c0XY
 3VbGsy8dLNdzmKEqwNgSC+f9rX5/v1/TBlFcV9FjwoLHlZaNAp0Qo80DN5WR4=
X-Received: by 2002:a05:6808:2385:b0:450:bcc7:18d7 with SMTP id
 5614622812f47-4675704dfa8mr1712441b6e.2.1773408246581; 
 Fri, 13 Mar 2026 06:24:06 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:06 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 32/65] dyndbg: Harden classmap and callsite validation
Date: Fri, 13 Mar 2026 07:19:57 -0600
Message-ID: <20260313132103.2529746-33-jim.cromie@gmail.com>
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

Dynamic debug classmaps allow modules to _DEFINE or _USE classmaps,
which map classnames to a range of class-IDs (0..62) that they are
using.  This names => IDs mapping allows many modules to use 0..N
independently, and even allows (carefully) shared classnames.

Previously, class validation only caught some violations in _DEFINEd
classmaps; 0..62 range checks, overlaps among _DEFINEd classmaps, but
left blind spots in _USEs, for out of bounds manual offsets,
overlapping _USEd classmaps, unknown map types, and orphaned callsite
IDs. These oversights could lead to ambiguous routing or spammy
warnings during control query execution.

This commit hardens classmap and descriptor validation:

- Mirror the compile-time limits of _DEFINE by adding a static_assert
  to validate the _offset value passed to DYNAMIC_DEBUG_CLASSMAP_USE_.
- Add run-time overlap checks for _USEd classmaps in ddebug_add_module()
  to prevent collisions between private maps and imported APIs.
- Validate that module classmaps use known enum map types.
- Scan module descriptors at load time to print a single warning per
  missing class_id, rather than waiting for a user query to trip over it.
- Downgrade the global WARN_ONCE in ddebug_match_desc() to a
  pr_warn_ratelimited, since orphaned class IDs are now tracked and
  warned about early at module load.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  2 ++
 lib/dynamic_debug.c           | 52 +++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0d1245aefc69..28684cfc0937 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -262,6 +262,8 @@ struct _ddebug_class_param {
 
 #define __DYNAMIC_DEBUG_CLASSMAP_USE(_var, _offset, _uname)		\
 	extern struct _ddebug_class_map _var;				\
+	static_assert((_offset) >= 0 && (_offset) < _DPRINTK_CLASS_DFLT, \
+		      "classmap use offset must be in 0..62");		\
 	static struct _ddebug_class_user __aligned(8) __used		\
 	__section("__dyndbg_class_users") _uname = {			\
 		.mod_name = KBUILD_MODNAME,				\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2083a8546460..635df6edb4cf 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -320,7 +320,7 @@ static bool ddebug_match_desc(const struct ddebug_query *query,
 	/* site is class'd */
 	site_map = ddebug_find_map_by_class_id(di, dp->class_id);
 	if (!site_map) {
-		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions",
+		pr_warn_ratelimited("unknown class_id %d, check %s's CLASSMAP definitions\n",
 			  dp->class_id, di->mod_name);
 		return false;
 	}
@@ -1404,9 +1404,8 @@ static void ddebug_apply_class_users(const struct _ddebug_info *di)
 	(__dst)->info._vec.len = __nc;					\
 })
 
-static int __maybe_unused
-ddebug_class_range_overlap(struct _ddebug_class_map *cm,
-			   u64 *reserved_ids)
+static int ddebug_class_range_overlap(struct _ddebug_class_map *cm,
+				      u64 *reserved_ids)
 {
 	u64 range = (((1ULL << cm->length) - 1) << cm->base);
 
@@ -1420,6 +1419,23 @@ ddebug_class_range_overlap(struct _ddebug_class_map *cm,
 	return 0;
 }
 
+static int ddebug_class_user_overlap(struct _ddebug_class_user *cli,
+				     u64 *reserved_ids)
+{
+	struct _ddebug_class_map *cm = cli->map;
+	int base = cm->base + cli->offset;
+	u64 range = (((1ULL << cm->length) - 1) << base);
+
+	if (range & *reserved_ids) {
+		pr_err("[%d..%d] (from %s) conflicts with %llx\n", base,
+		       base + cm->length - 1, cm->class_names[0],
+		       *reserved_ids);
+		return -EINVAL;
+	}
+	*reserved_ids |= range;
+	return 0;
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1430,6 +1446,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
 	u64 reserved_ids = 0;
+	u64 bad_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1454,10 +1471,33 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_mark_vector_subrange(i, cli, &dt->info, users, dt);
 	/* now di is stale */
 
-	/* insure 2+ classmaps share the per-module 0..62 class_id space */
-	for_subvec(i, cm, &dt->info, maps)
+	/* validate class map types and the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps) {
+		if (cm->map_type > DD_CLASS_TYPE_LEVEL_NUM) {
+			pr_err("module %s has unknown classmap type %d\n", dt->info.mod_name, cm->map_type);
+			goto cleanup;
+		}
 		if (ddebug_class_range_overlap(cm, &reserved_ids))
 			goto cleanup;
+	}
+
+	for_subvec(i, cli, &dt->info, users)
+		if (ddebug_class_user_overlap(cli, &reserved_ids))
+			goto cleanup;
+
+	/* validate all class_ids against module's classmaps/users */
+	for (i = 0; i < dt->info.descs.len; i++) {
+		struct _ddebug *dp = &dt->info.descs.start[i];
+
+		if (dp->class_id == _DPRINTK_CLASS_DFLT)
+			continue;
+		if (bad_ids & (1ULL << dp->class_id))
+			continue;
+		if (!ddebug_find_map_by_class_id(&dt->info, dp->class_id)) {
+			pr_warn("module %s uses unknown class_id %d\n", dt->info.mod_name, dp->class_id);
+			bad_ids |= (1ULL << dp->class_id);
+		}
+	}
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
-- 
2.53.0

