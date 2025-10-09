Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D731CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924A410EB69;
	Fri, 10 Oct 2025 08:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pr4cV79q";
	dkim-atps=neutral
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F9E10EAFF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:59:19 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id
 ca18e2360f4ac-937b40137b4so98996439f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032759; x=1760637559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJonn1UQmdMquLncDUtZUHutcCuWRZij3zF+8bzYpyM=;
 b=Pr4cV79q9KSDyEl1Z8ear726se1VKpiVD+3vc411BP31rh5DY18MhfPozsktsr3CJb
 JhEQylfm0BmTa/dVCpX2Vo4MW6aOHf5ScWEDhOrNUlQOZK7BQB1YLrcL9a6df9K7LKBb
 sjiEmvFId3HPdv18yMriBZftBJbWqW9Ka61kBF+NazxC5JZTpSOmU2RJiCufJQioS+pu
 xSfw0I5ib68oh+U2+G3wSclge6+v8emryPDerd9MJpecarjltZqHxcE/fh+2cGAoK5Eb
 u5cyQ4lX7UHaewBesGd/Nl5vJ4+TDtVWcDOA7xI9Kg8yKBvpKPZG5EJKiH8WGs7035bv
 VexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032759; x=1760637559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJonn1UQmdMquLncDUtZUHutcCuWRZij3zF+8bzYpyM=;
 b=dsT1jr5hE1fchvbST7aYNf74KdDm9Mu6E8sMiHMdfDFrfTNRLxNwWRoc2Fp1Qhaq1I
 QH+T2CITG5HAfOUzuQlzkZaHA+YdVRTBiW+N5zZDH1iq0JdHdSyN8Q3+ZJYKCf/H1F/Q
 5f/fnMv2qVHRsRop6mJ+q3ETOfO7vsZe+YI3bBRelJdPiE4Dt1gj56yG+JuVFVqTtjP5
 z1KOOkZllOJYPIKAYx9jHIvIvivCbu/eD1ZajvmfrAY4rT/3OLlT+DiMLVFHmh+sljDO
 l4vFm+M5jvtXkjjjZd/9kz5xRipVW3+MnCyIP6gnMXtMpEIuXmyCqHnWy/CfHDgWSaYs
 jOmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxkoxCCZfKYeHShQU90XPyCmfyuqeBmtwD4zd792PSKHXM/oBIpVasgbzfrd8Ix+xvI2mEn9B5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq0QLJrrkvDn0CeE1SJj/ndjTr78eXuIVt9WWpcB00+BMtWi6D
 5jI0dF9wvB7mZhh5YRwTKxJZkFk3o7YNCSNnU8RBB6QTujZxinPbYv7F
X-Gm-Gg: ASbGncttw8dbs+DTPudt2ZwkMp2hZTp3i8VqQ6Kk8FefNVt5HAP5j5fwQgszIMwQuZu
 i3aiwkKUtRdeuajdUGkC4QBnRkgNVRQIOSJiuVhpP0KAUZ3bQvhlsnQXYP2kp3j11M/vmYT84PP
 itsBI0IJbpHZ3m0Dje84N1Co0eqqjg7GYj2rvGl5bzyoIZ+WM+kCHNd167F8u4Xj54gegINztJw
 LrLksDx1Pe1jD3qKHzJeT+634StV3nn5bEcialf4iKL3fenYfcVP/kukHUjK5mhI0K8zN/o+vvP
 mlAXL3sGhFy5v8DqGFJcV9sg6gK1s829oIT2AGsC8l3NdEytlvGdTEhXHJx6I3D8QjNI3d5UKlg
 up5+HHpphcMKNxMseHQGQxd6fum9RtA3GNbrLfAE7iK1NCTtx16JXGlW7cqdomP0xEtMXVXzwWp
 dkgNVS7XUahm69gx03vF4H1NdGibOhzl1RCy+Bcw==
X-Google-Smtp-Source: AGHT+IHVKXFMusdqiPmDW/wzqUDYexOwse+E0pYDfFVpPjytm/THWwTC1XlwfHUx8Qo1uHRSZGwKQQ==
X-Received: by 2002:a05:6e02:2489:b0:42f:9649:56b4 with SMTP id
 e9e14a558f8ab-42f96495934mr16480345ab.13.1760032758628; 
 Thu, 09 Oct 2025 10:59:18 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:59:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 29/30] dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(clname,
 _base)
Date: Thu,  9 Oct 2025 11:58:33 -0600
Message-ID: <20251009175834.1024308-30-jim.cromie@gmail.com>
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

The @_base parameter in @DYNAMIC_DEBUG_CLASSMAP_DEFINE exists to
de-conflict a second classmap definition from a first, by setting
different .class_id constants for all of the second map's pr_debug
callsites.

This gives the same _base param, and thus more flexible usage via
@DYNAMIC_DEBUG_CLASSMAP_USE_(clname,_base).  So now 2nd classmap used
can be deconflicted from the 1st used or defined.

1st the range-checking logic is refined into two distinct macros,
@ddebug_class_map_in_range() and @ddebug_class_user_in_range(), which
are then applied to the lookup functions: @ddebug_find_valid_class(),
@ddebug_find_map_by_class_id(), and @ddebug_class_name().

@DYNAMIC_DEBUG_CLASSMAP_USE* macro API kdoc is adjusted accordingly.

TODO: This is just an api placeholder, it anticipates a possible need
that may never arise.  The normal way to add a new classmap to a drm
driver would be to define the enum to avoid DRM_UT_CORE..RES vals.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 28 ++++++++++++++++++++++------
 lib/dynamic_debug.c           | 21 +++++++++++++--------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 588e03e8d157..d1e38158c485 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -87,7 +87,7 @@ struct _ddebug_class_map {
 struct _ddebug_class_user {
 	char *mod_name;
 	struct _ddebug_class_map *map;
-	const int base;		/* user offset to re-number the used map */
+	const int base;		/* offset .class_id range to share space */
 };
 
 /*
@@ -235,15 +235,31 @@ struct _ddebug_class_param {
 /**
  * DYNAMIC_DEBUG_CLASSMAP_USE - refer to a classmap, DEFINEd elsewhere.
  * @_var: name of the exported classmap var
- * @_not_yet: _base-like, but applies only to this USEr. (if needed)
  *
  * This tells dyndbg that the module has prdbgs with classids defined
  * in the named classmap.  This qualifies "class NAME" >controls on
- * the user module, and ignores unknown names.
+ * the user module, and ignores unknown names. This is a wrapper for
+ * DYNAMIC_DEBUG_CLASSMAP_USE_() with a base offset of 0.
  */
-#define DYNAMIC_DEBUG_CLASSMAP_USE(_var)				\
-	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0, __UNIQUE_ID(_ddebug_class_user))
-#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _base, _uname)		\
+#define DYNAMIC_DEBUG_CLASSMAP_USE(_var) \
+	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0)
+
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_USE_ - refer to a classmap with a manual offset.
+ * @_var:   name of the exported classmap var to use.
+ * @_base:  an integer offset to add to the class IDs of the used map.
+ *
+ * This is an extended version of DYNAMIC_DEBUG_CLASSMAP_USE(). It should
+ * be used to resolve class ID conflicts when a module uses multiple
+ * classmaps that have overlapping ID ranges.
+ *
+ * The final class IDs for the used map will be calculated as:
+ * original_map_base + class_index + @_base.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _base)			\
+	__DYNAMIC_DEBUG_CLASSMAP_USE(_var, _base, __UNIQUE_ID(_ddebug_class_user))
+
+#define __DYNAMIC_DEBUG_CLASSMAP_USE(_var, _base, _uname)		\
 	extern struct _ddebug_class_map _var;				\
 	static struct _ddebug_class_user __aligned(8) __used		\
 	__section("__dyndbg_class_users") _uname = {			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6e0c978bc7c4..68bd2dbdacfb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -169,6 +169,12 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  _di->users.len);					\
 	})
 
+#define ddebug_class_map_in_range(id, map) \
+	((id) >= (map)->base && (id) < (map)->base + (map)->length)
+#define ddebug_class_user_in_range(id, user) \
+	((id) >= ((user)->map->base + (user)->base) && \
+	 (id) < ((user)->map->base + (user)->base + (user)->map->length))
+
 static struct _ddebug_class_map *
 ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class, int *class_id)
 {
@@ -189,7 +195,7 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 		if (idx >= 0) {
 			vpr_di_info(di, "class-ref: %s -> %s.%s ",
 				    cli->mod_name, cli->map->mod_name, query_class);
-			*class_id = idx + cli->map->base;
+			*class_id = idx + cli->map->base + cli->base;
 			return cli->map;
 		}
 	}
@@ -197,8 +203,7 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 	return NULL;
 }
 
-#define class_in_range(class_id, map)					\
-	(class_id >= map->base && class_id < map->base + map->length)
+
 
 static struct _ddebug_class_map *
 ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
@@ -208,11 +213,11 @@ ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (class_in_range(class_id, map))
+		if (ddebug_class_map_in_range(class_id, map))
 			return map;
 
 	for_subvec(i, cli, di, users)
-		if (class_in_range(class_id, cli->map))
+		if (ddebug_class_user_in_range(class_id, cli))
 			return cli->map;
 
 	return NULL;
@@ -1146,12 +1151,12 @@ static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (class_in_range(dp->class_id, map))
+		if (ddebug_class_map_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	for_subvec(i, cli, di, users)
-		if (class_in_range(dp->class_id, cli->map))
-			return cli->map->class_names[dp->class_id - cli->map->base];
+		if (ddebug_class_user_in_range(dp->class_id, cli))
+			return cli->map->class_names[dp->class_id - cli->map->base - cli->base];
 
 	return NULL;
 }
-- 
2.51.0

