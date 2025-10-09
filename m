Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D95ECCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27F610EB54;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EilnKP5/";
	dkim-atps=neutral
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
 [209.85.166.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1118710EAE1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:59:11 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id
 ca18e2360f4ac-92aee734585so48401039f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032750; x=1760637550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkrhZds/ll2Xl8Nzf4vLphQpqfGvsMLkRQg1rNtfyx0=;
 b=EilnKP5/bguJwDbH7skyWsqmXyM05iAaHIT2iIVH5lzM6U+dpCjwpEXucq3d/DeCS1
 Ixy/Xxq0zg1gmEDn0Z3VojcDNq6oXWLgWRuH9M+19Z6K0H5hTPINVOnmqoslttR5DYcT
 o5gaO70Q6F+Ski2MW+pagPdwB+tq09LphHvFIBu/p3tHr2Vrt3woqGG/evRpBOUdns6M
 iglzOgCNTwf6YhSTmqDOLwph2mPfrbEhJHvOTMGTCtBINpD9HtjgEjoGJxRf97pixT8c
 em05maBcLYL7ZA+XLvFL3A1A5h1VCsTakIh3QHd6jrjnOkgV0Di10HXnPzLtKfa/fdSd
 pvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032750; x=1760637550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkrhZds/ll2Xl8Nzf4vLphQpqfGvsMLkRQg1rNtfyx0=;
 b=juwZ6Wqj2ltp9FHHXy3BbEU9WbKfrxmeCx67gLpDY5m1oA8z/hDOS3vwUNaR6K1JZQ
 AYg/9V55WZf+5/MAWGiP+ZLT0pZadvzMd43nPsR+9WwAGneliToEiFoP3/9EopQ5Kjaj
 6uy3jRKXSy2LnOY3biI88lQb9pYu3/ZxggZRhAE45MCcKGwwJ+K7k/0rh0HpqsyyADCY
 XpDim3YQ8DJteqS5HSq4RRLs0zkQnnKJF3iMtymvq/HM466oLIxAQwv5TD4cB+gHyGyM
 6x0nqi7viMBheMB0DDAp2fA4lRtxKg0egfbJNfMWovjdl5/hjt4SGaFEvlrcOIGDF5D8
 3hXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBVJleN4rStgxOHtbrGIxIFJOLPv2WznRVD/5rTZsbVNSsihM16rQqd7sFTholpOfZRsbyeRKb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFr0fyCm/az8/X2p7wkAEokU+70IafFDfAWlpFRdcY4yiHiXiU
 R/1Czgq9abLc4InEvymslB0XGzhf29Fk/GwmAzxXoxj6mbu4gw7U9XVz
X-Gm-Gg: ASbGncswuRC2dLQ++5AAlHs52juq5W/Eade4/eBdDM4X9RgadrVpi55cqJ7bQOnPknz
 RbqF0mD5obKH6JUwgZ8Ad0Ez0hDQSr3kHCCuEu0CkFxBDOY/FCYPtCY7WAJUz13B5feOZSxnW6w
 rNBv1OZMWsNcrk5lWm3gJtSF6tBb4J69sQcTq+EoMtDoBcALy5AAIgkv4tepakJ3N6DYYh/h2Ao
 8KabIu+GvVP3btIxJZ3Tv5ti8+G0TxNRet3UZlkyeFDL5TedmsDPDQ6e082ESf5/2fU3XksXXm9
 i0prSF0ZDrL63Bh6E2vqrD269NgqB7kIUQV8t6ezglI1BtFOXEozGvpKWZzB5zZxSLTQACasJkz
 1nvjBXsC1SY45vIOxFYrQ8lk3WWxEpDaNjjOWu6e2SSzqyaHpO9EAFCi2tWN6BrexE0ciCQFOnK
 PheZEuMPdX9IGyeBpgk6cXTEDQD9UvGt407ezNbQ==
X-Google-Smtp-Source: AGHT+IFUtIEt4hZGGPIJzsczKNqnueKXhXvFJxzwNM//vyW6z4t8ra586gGXxFd/BYpLugooChengg==
X-Received: by 2002:a05:6602:492:b0:900:1fa2:5919 with SMTP id
 ca18e2360f4ac-93bd19882e8mr959644239f.9.1760032749970; 
 Thu, 09 Oct 2025 10:59:09 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:59:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 21/30] dyndbg: detect class_id reservation conflicts
Date: Thu,  9 Oct 2025 11:58:25 -0600
Message-ID: <20251009175834.1024308-22-jim.cromie@gmail.com>
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
parent (D2_CORE..etc), causing the modprobe(s) to warn

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
- USE doesnt need conflict test against DEFINE
  infact its wrong-headed - of course theyd overlap.
---
 lib/dynamic_debug.c      | 40 +++++++++++++++++++++++++++++++++-------
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 54f93d1d0ff2..f94ee518ed62 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1267,6 +1267,22 @@ static void ddebug_apply_class_users(const struct _ddebug_info *di)
 	(_dst)->info._vec.len = nc;					\
 })
 
+static int __maybe_unused
+ddebug_class_range_overlap(struct _ddebug_class_map *cm,
+			   u64 *reserved_ids)
+{
+	u64 range = (((1ULL << cm->length) - 1) << cm->base);
+
+	if (range & *reserved_ids) {
+		pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
+		       cm->base + cm->length - 1, cm->class_names[0],
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
@@ -1276,6 +1292,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1290,15 +1307,20 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	}
 	INIT_LIST_HEAD(&dt->link);
 	/*
-	 * For built-in modules, di-> referents live in .rodata and is
-	 * are immortal. For loaded modules, name points at the name[]
-	 * member of struct module, which lives at least as long as
-	 * this struct ddebug_table.
+	 * For built-in modules, di-> referents live in .*data and are
+	 * immortal. For loaded modules, di points at the dyndbg_info
+	 * member of its struct module, which lives at least as
+	 * long as this struct ddebug_table.
 	 */
 	dt->info = *di;
-	dd_mark_vector_subrange(i, dt, cm, di, maps);
-	dd_mark_vector_subrange(i, dt, cli, di, users);
-	/* now di may be stale */
+	dd_mark_vector_subrange(i, dt, cm, &dt->info, maps);
+	dd_mark_vector_subrange(i, dt, cli, &dt->info, users);
+	/* now di is stale */
+
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1312,6 +1334,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	vpr_info("%3u debug prints in module %s\n",
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
+cleanup:
+	WARN_ONCE("dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	kfree(dt);
+	return -EINVAL;
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 6c4548f63512..1ba4be9a403a 100644
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
+DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+#endif
+
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
 /*
-- 
2.51.0

