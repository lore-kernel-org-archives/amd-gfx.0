Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F159A10ED672
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B09810EE11;
	Fri, 27 Mar 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+9bcOMh";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D6D10EBC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:21 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so1173689a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551321; x=1775156121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmGyHMtly7Qz0CqR2wXNKvZRnLsbvPnYKpSxXzkbtSQ=;
 b=S+9bcOMhhxMlz2iiGvz1w+Ys3jtUzT7xUxLsVr95NvYrfLAP7owgVEuCVEH6fpOOYz
 5mFlBopMkYNQMXktWv4QHRtnSgkCgjqLW/5+xmsSoaaq+Ie7sd2o1N8ydsdxlmuqRwE8
 6e7DuPsUzm/Xa3nh0lOAuxRIdrehXUY8pzEhRD+1LUqWSKxCpSuki0ofWpNk62plw+bM
 w1DnHI2EI38Gc+lI2v9e70uGMx8Gp/l5oZUkO9ZCcLuEKeJYgitag1Usiih+0bmeGmnl
 pqvS4oebR5FeAuChUtbu/SBp6a8vJq0c//hqGDflwXmCwYwYolv1IQnbTJgNkPQqYaVl
 ofag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551321; x=1775156121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kmGyHMtly7Qz0CqR2wXNKvZRnLsbvPnYKpSxXzkbtSQ=;
 b=WwgTt3e+7TzaphDpF+0CFNwkoIevrhlKfPxDwz/lkDKaltu6QhOK4SMoaHNHRoiGEe
 jjLfZGa4ZZtxRAeQc6V6PQd1Ojr29ZrxGTHrV8Bi5rbJkRNj+q1sGnk34nLHvuSR/U2C
 JTwkn0RncZXt6G1U7fC6XL8bMYtfXBrKNHYxMFYDGxsMIblmjee339A/TfoF/rIk2Tmr
 LRKVtZswtmvD/Jf4Gh7Hv8OcGXp8zxvauyaBvBIG3xNFLiGQypV3F8cL9ONxgUClHWMu
 MwLQ1tolTX4J1fKjWihaCcRcaOB5MKAJ9XwbRni1nLetUU1EftI4DO50e8kMy6Xm7agj
 m7Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzvAKwl++CyY7ZsY/aSMsWE0/rSE4AIxfZuxGDki34Fw//OJJH7azhaMVXQ175j6KysQ0IK1r9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9XkyOT5M0EfqAvA7QINKbYvHcQXolIZIP7flDKkW5FSPIaYfY
 VAXTX0t6BVxysIBh12/PitiGJrEtGIsRcZ1Y23TPROlAAIYeqXr+O73t
X-Gm-Gg: ATEYQzzIuCSMWRoi4WLxyg/fpdfbXFhvpUJ3B63Bl27HXB70QoJdAm/IDTR1oimgd22
 zwHHGyWyctHsQ+jzhYL2pLF4vfeXCSvYB9Vqw9o3HvguIaIFp+nioYSx0DBATazVozH4J2SaIwD
 4LG+WuRr4WMJSxAmbiDerlIYGDedw33UvWXtQhxK+sXO487OTcMZhJyi8yUDqYqC2mAHGy58Q1T
 LBcRYWIJQrYDEx4khTjwb+nZIc641t+rSZHgJnaJh0KWrPaCBTVWbYMfZT6+yPAL/LrAEZx8IwC
 nKKXh3pSnkPw4cPv3bVnJr7ujw0zGQa7Wb0iLiN9ihBtUhgCX7s3WuI4+Nq7JowUIHEb7yawb6k
 +qhoLMvk1VFhSflgU3nSND5+HOL1EVrNWYS+w1tYcgq2ICAuXMDkFxYW8IoKidHzHRIEnKCVViH
 8fAgGa0TwRqHW59maBB5k6NXPc3/TVf3XtE43BU/+PUts7ISqvWy3p2meZGUM=
X-Received: by 2002:a05:6820:4715:b0:67e:d8c:9f87 with SMTP id
 006d021491bc7-67e0d8caa1amr1460403eaf.5.1774551320853; 
 Thu, 26 Mar 2026 11:55:20 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:20 -0700 (PDT)
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
Subject: [PATCH v12 34/69] dyndbg: harden classmap and descriptor validation
Date: Thu, 26 Mar 2026 12:53:38 -0600
Message-ID: <20260326185413.1205870-35-jim.cromie@gmail.com>
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

Dynamic debug classmaps allow modules to _DEFINE and/or _USE multiple
classmaps, but this requires coordination amongst the classmaps.

Previously, class validation done by DYNAMIC_DEBUG_CLASSMAP_DEFINE at
compile-time, and ddebug_class_range_overlap() at modprobe-time, was
incomplete, and DYNAMIC_DEBUG_CLASSMAP_USE_ had no validation.  This
could allow broken classmaps, making them harder to use well.

This commit improves classmap and descriptor validation:

- Mirror the compile-time limits of _DEFINE by adding a static_assert
  to validate the _offset value passed to DYNAMIC_DEBUG_CLASSMAP_USE_.

- Add run-time overlap checks for _USEd classmaps in ddebug_add_module()
  to prevent collisions between private maps and imported APIs.

- Scan module descriptors at load time to print a single warning per
  missing class_id, rather than waiting for a user query to trip over it.

- Downgrade the global WARN_ONCE in ddebug_match_desc() to a
  pr_warn_ratelimited, since orphaned class IDs are now tracked and
  warned about early at module load.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
-v12 - squash several enhancments together

drop run-time USE check, now done at compile-time

s/WARN_ONCE/pr_err/, dont need stack trace for this, and do want
multiple error reports, so dont quit on 1st err.

Now that DYNAMIC_DEBUG_CLASSMAP_USE_() has an offset parameter, it is
possible for a user to specify an illegal value - one that shifts the
bit-range past the 64 bit max.  The macro detects an offset > 63, but
this isn't enough; the legal max is:

  map.length - 1 + map.base + user.offset < 64

Testing class-map vs class-user overlap is nonsense if the class-user
range extends past the implemented limit.  So check that 1st, before
looking for map/user overlap.

To validate this, add ifdef DD_RUNTIME_CLASS_CHECK code to
test_dynamic_debug_submod.ko.  When its enabled, it creates a bad
class-user record via:

  DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 55);

bash-5.3# modprobe test_dynamic_debug_submod
[   19.359818] dyndbg:  23 debug prints in module test_dynamic_debug
[   19.366239] dyndbg: module test_dynamic_debug_submod: base:16 + classes.len:8 + cli.offset:55 must be < 63
[   19.366612] dyndbg: dyndbg multi-classmap conflict in test_dynamic_debug_submod
[   19.366945] dyndbg: dyndbg: failed to add module test_dynamic_debug_submod: -22

Finally, replace the misleading "Failed to allocate memory" WARN in
the module notifier with a pr_err that reports the specific failure
code without the stack-trace.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c      | 67 ++++++++++++++++++++++++++++++++++++----
 lib/test_dynamic_debug.c |  9 +++++-
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66879a40b822..3cd9b67bd995 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -320,7 +320,8 @@ static bool ddebug_match_desc(const struct ddebug_query *query,
 	/* site is class'd */
 	site_map = ddebug_find_map_by_class_id(di, dp->class_id);
 	if (!site_map) {
-		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", dp->class_id, di->mod_name);
+		pr_warn_ratelimited("unknown class_id %d, check %s's CLASSMAP definitions\n",
+			  dp->class_id, di->mod_name);
 		return false;
 	}
 	/* module(-param) decides protection */
@@ -1420,6 +1421,23 @@ static int ddebug_class_range_overlap(struct _ddebug_class_map *cm, u64 *reserve
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
+		pr_err("module %s: [%d..%d] (from %s) conflicts with %llx\n",
+		       cli->mod_name, base, base + cm->length - 1,
+		       cm->class_names[0], *reserved_ids);
+		return -EINVAL;
+	}
+	*reserved_ids |= range;
+	return 0;
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1430,7 +1448,8 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
 	u64 reserved_ids = 0;
-	int i;
+	u64 bad_ids = 0;
+	int i, err = 0;
 
 	if (!di->descs.len)
 		return 0;
@@ -1454,10 +1473,46 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_set_module_subrange(i, cli, &dt->info, users);
 	/* now di is stale */
 
-	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	/* validate the per-module shared 0..62 class_id space */
 	for_subvec(i, cm, &dt->info, maps)
 		if (ddebug_class_range_overlap(cm, &reserved_ids))
-			goto cleanup;
+			err = -EINVAL;
+
+	for_subvec(i, cli, &dt->info, users) {
+		cm = cli->map;
+		if (!cm) {
+			pr_err("module %s: classmap not found for user\n", di->mod_name);
+			err = -EINVAL;
+			continue;
+		}
+
+		if (cm->base + cm->length + cli->offset >= _DPRINTK_CLASS_DFLT) {
+			pr_err("module %s: base:%d + classes.len:%d + cli.offset:%d must be < %d\n",
+			       di->mod_name, cm->base, cm->length, cli->offset, _DPRINTK_CLASS_DFLT);
+			err = -EINVAL;
+			continue;
+		}
+
+		if (ddebug_class_user_overlap(cli, &reserved_ids))
+			err = -EINVAL;
+	}
+	if (err)
+		goto cleanup;
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
+			pr_warn("module %s uses unknown class_id %d\n",
+				dt->info.mod_name, dp->class_id);
+			bad_ids |= (1ULL << dp->class_id);
+		}
+	}
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1472,7 +1527,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
 cleanup:
-	WARN_ONCE(1, "dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	pr_err("dyndbg multi-classmap conflict in %s\n", di->mod_name);
 	kfree(dt);
 	return -EINVAL;
 }
@@ -1559,7 +1614,7 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 		mod->dyndbg_info.mod_name = mod->name;
 		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
-			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
+			pr_err("dyndbg: failed to add module %s: %d\n", mod->name, ret);
 		break;
 	case MODULE_STATE_GOING:
 		ddebug_remove_module(mod->name);
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 08d4e3962026..db555f5f8ea4 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -137,7 +137,14 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE")
  * DEFINEd (and exported) above.
  */
 DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
-DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
+#if !defined(DD_RUNTIME_CLASS_CHECK)
+  DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
+#else
+/*
+ * force failure of runtime sanity test of classmap.length + offset < 63
+ */
+DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 55);
+#endif
 
 #if defined(DD_MACRO_ARGCHECK)
 /*
-- 
2.53.0

