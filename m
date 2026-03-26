Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F07F10ED671
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1129E10EDF7;
	Fri, 27 Mar 2026 12:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rsJ1vhD5";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF1E10EBBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:10 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-41576c5c01cso891018fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551309; x=1775156109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhkUA1UVesD8yNrP4RsQIbF+Lt6WpQrbgggJ/VjIv9U=;
 b=rsJ1vhD5+kYQ+qJIv7BPsWZblY/S4YGV6NPAn7+1+/syCzP1iEgsw2l5BGIKuIUh9o
 EzvIQIC775YuZcmfwUmcdo/BLYrNQ79cVWKhA3Z4yPjaKF3DAy0YCIhWD475vJveAMP/
 iWyDWAzoopBeyF4iVy09bCOdozhKUH6MkFIABEJ9NnnWtND6oP/dqaUKnDHhMgP5dCrx
 rv38rpiBe15T09n5rSEc7NdpEX2zo5hJVfz9onpBoJNDX2WFugl63SoxNd1Ms1EToyfL
 ideZcIWRj14qyUOQQ/jReKFuKFYE33YjigL01JI0MoMzdbEIBzymfpiKRO+HFqJh4Rto
 Inng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551309; x=1775156109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fhkUA1UVesD8yNrP4RsQIbF+Lt6WpQrbgggJ/VjIv9U=;
 b=VWQXzwF0fv3xBdkFnXhb8IU69VG+nCgeY89EngipYdA0e6Gl/81y5Bcf0nHU9OUL2P
 h+qEUnruINxEkeiu1bEeQ1LsL78sQrfq0pbETvlAgi15o3SN9atAaPiL7zJaOEU178fe
 DqVw6bXncBmOiWU/ahcv1AUr/1L3AVTvJBOxahZL/Bt/t7LXdpsqpaxuLDgECctgdRoR
 8FgcNVURC1rmWXAgvpSuAK/ELFp35fOOnypB0Qk2kZZMGCY1HLTtKkIs3LalV2JIu1jP
 Ue6uxedduHh50K9MRPnIpXC7FdIzX57oHhgVz2Glephu9A4jeHltqJZkRE40dEGiamf9
 3cmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0zYB0Iwb4RyLHKwv/NO5LkwUoOKI1eAkXwq59UQxMQ2YlshM42F+I8RfZJWzqZ98ijuW6ea/L@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzhw3eAhDOefQKFCeT8cr3d9B1OT5rB5ppi5ra1zHjr4A+G8f0R
 h0tUuFF9BkaclKaTCB7gR+mJNJMVfirsgz/9e2XrqxxBTw/W/qSRJ/1i
X-Gm-Gg: ATEYQzzAU+/ZUg/xTrHX3fBtDcT1AMDrxywR89RFJbab8do2qJnFHbhYyyLWwQgUWvY
 Hyp4RLAPV3YrqPaP+9PjNEoGpI0mtoSJe8uUouxfsmGOxOf98Uqep2gsq9SmvLRBEmkmEofX5Y/
 aEsMBFUiwg8V0oaVmff4HJHFgepXbWFOhsgidC7kMLzlxibsnTxPoW6gmRgZe4XPITmi8n8SJGa
 rjPtX/CwZlmHKvDtZlasqXnC/HZ8Y7Uqg6a+aGYmc+jPK7TvfdbiC7SwfimQQp9NpLTjeRxnstv
 ICL1Vd+ZBkv++QHfcbb/KLpv3Bho/fH25ixsb+o2kp5SpCfSnEV9KlGFMoJg2kJdK/m+BkGe2iX
 ccTgSrxLAtVUKqgCjp4J2z1jwEFxA+ifiZ4SK2Ek1Fa/atwQenFSIpM3cRcyW7nTQZqGNxbzxhp
 ISrCIqcBfRgreGhN26zkLztvDL8hbU+GXCnl6zb1BqCQsvT8DE
X-Received: by 2002:a05:6871:820d:b0:404:1250:1c1f with SMTP id
 586e51a60fabf-41ca6d160c2mr4341523fac.5.1774551309361; 
 Thu, 26 Mar 2026 11:55:09 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:08 -0700 (PDT)
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
Subject: [PATCH v12 26/69] dyndbg: detect class_id reservation conflicts
Date: Thu, 26 Mar 2026 12:53:30 -0600
Message-ID: <20260326185413.1205870-27-jim.cromie@gmail.com>
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

If a module _DEFINEs 2 or more classmaps, it must devise them to share
the per-module 0..62 class-id space; ie their respective base,+length
reservations cannot overlap.

To detect conflicts at modprobe, add ddebug_class_range_overlap(),
call it from ddebug_add_module(), and WARN and return -EINVAL when
they're detected.

This insures that class_id -> classname lookup has just 1 answer, so
the 1st-found search in find-class-name works properly.

test_dynamic_debug.c:

If built with -DFORCE_CLASSID_CONFLICT, the test-modules invoke 2
conflicting DYNAMIC_DEBUG_CLASSMAP_DEFINE() declarations, into parent
and the _submod.  These conflict with one of the good ones in the
parent (D2_CORE..etc), causing the modprobe(s) to WARN and fail.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v9 - fix WARN() by adding new 1st arg 1.
v12 - drop maybe_unused on range-overlap fn
---
 lib/dynamic_debug.c      | 25 +++++++++++++++++++------
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ce512efaeffd..a7f67ecbc4d7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1085,12 +1085,17 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
-static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class_map *map)
+static bool ddebug_class_map_in_range(const int class_id, const struct _ddebug_class_map *map)
 {
 	return (class_id >= map->base &&
 		class_id < map->base + map->length);
 }
 
+static bool ddebug_class_user_in_range(const int class_id, const struct _ddebug_class_user *user)
+{
+	return ddebug_class_map_in_range(class_id - user->offset, user->map);
+}
+
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct _ddebug_class_map *map;
@@ -1098,11 +1103,11 @@ static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (ddebug_class_in_range(dp->class_id, map))
+		if (ddebug_class_map_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	for_subvec(i, cli, di, users)
-		if (ddebug_class_in_range(dp->class_id, cli->map))
+		if (ddebug_class_user_in_range(dp->class_id, cli))
 			return cli->map->class_names[dp->class_id - cli->map->base - cli->offset];
 
 	return NULL;
@@ -1295,9 +1300,7 @@ static void ddebug_apply_class_users(const struct _ddebug_info *di)
 	__di->_vec.len = __nc;						\
 })
 
-static int __maybe_unused
-ddebug_class_range_overlap(struct _ddebug_class_map *cm,
-			   u64 *reserved_ids)
+static int ddebug_class_range_overlap(struct _ddebug_class_map *cm, u64 *reserved_ids)
 {
 	u64 range = (((1ULL << cm->length) - 1) << cm->base);
 
@@ -1320,6 +1323,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1344,6 +1348,11 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_set_module_subrange(i, cli, &dt->info, users);
 	/* now di is stale */
 
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
+
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1356,6 +1365,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	vpr_info("%3u debug prints in module %s\n",
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
+cleanup:
+	WARN_ONCE(1, "dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	kfree(dt);
+	return -EINVAL;
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 6c4548f63512..fc599bbe605e 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -128,6 +128,14 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
 DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 
+#ifdef FORCE_CLASSID_CONFLICT
+/*
+ * Enable with -Dflag on compile to test overlapping class-id range
+ * detection.  This should warn on modprobes.
+ */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+#endif
+
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
 /*
-- 
2.53.0

