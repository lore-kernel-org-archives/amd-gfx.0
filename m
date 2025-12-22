Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAF3E677EB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8187710E6CA;
	Mon, 22 Dec 2025 15:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CsOlhF+U";
	dkim-atps=neutral
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD2610E5D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:25:18 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so3931892b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391917; x=1766996717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6OB9Pa9Gle2V+EOSWrg2iFtsBZdBFQQ3jPBPibwDk8=;
 b=CsOlhF+UnKB6OCmBTP8MyEAME+Fi72rpZQ/deofplJuEYt9y+9aFZCGt1LKTV6fVps
 RuDSyos5j6v7MgYnPpGo9HUuOwApN/NZsXAu19U/7oC0PLg78sWs6kaRs7xpBAVtVRai
 dC3+LfvXfGh3yzJ/MNI0bf07UFNDrACDOl1hCnr3OsJjwFvYKpNHX/gjy8I332G/XMWF
 rlgNtVe75hL710nNf2SPhupkorHqlrFZd8+f0uj8MwE0cbqGT828oLXu+5TIh+AUi0YC
 G+hJD0N7pM/5cZbc1XFu+Tswh1RZFKB72r9josdCk3Vtfxxmb5UmFPsgKBQQ6Z644pQ/
 A1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391917; x=1766996717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6OB9Pa9Gle2V+EOSWrg2iFtsBZdBFQQ3jPBPibwDk8=;
 b=QnGHTh4jpycXOgOdH/0NJLXE6Smmtr0stNrouciY0xw59nSb2L/rCSWp3vxsP5xY68
 G3PEv9YPAvAzPjpxHRDwXiiF8Hd0QEVK4M8WuZ1TRycaddnRzxAyDoGxeKKhro/wYUVo
 SQYCzyXyIBAyffSd+wGp8Ioqi51CuveZZIpUgRKfftIjmWwa/DIqv57trh+hSD5yEVG9
 sBSPRQ9zFX59kO4zV3XA1o9ok/sO5cJfGa0CgKoK0vD9/ZU5KP9jT4oGLAwoEiNsOoWC
 TnkLhJfeJCz5Zmt3w/oZHuS1+cVy3jjxzScqs20pukugFVsF9rWtBd8M1/zzCwfvJXOW
 GO/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucJG8xAlEdN9XCulk8um6ADiY5/+SiXTnAd2ZiQFWE4q+JX1HuYp4vSLbLrjmCcSmngX37eku@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD6hyu1Hcd+gcfjp6rA3JFInPa587ioB0DWelD7CuA8e2E1pn7
 1PokeDQt8jAy3fAL9ZnCTmk1umzwc1THnsPVOC1VflzNRJsLk+Ee4h7W
X-Gm-Gg: AY/fxX5qOdG63XQ65WpAP7TMdDg3Ac3BBd4s6mF9hOTDk+h4WsVFlYrmOVlxMz2MjKu
 u+ggcZc3p4m6X1RwEUHcZVgHnhE3ckvZOOLXyZI17Zz6/PjFX9DyNexetAYfW/5Z5QJGMSyxVTg
 wVLBMQog/cH6GL01zBNMsk/MxnF5rHXbr3w/jsQW3NYZza3lymbFF7VMx4heIt7Y1QNspMVe3CC
 jXfUyXlY00v5K+pf27Ec+BEF+0vpWm0bifg7/BZKKqiIxKPHfMaCRY9Yp9MiW0bNh9j5b7U0sVH
 ULoQV0QvqXHwtdaXUYTE/NynLil1s7Omy14ueq4s/Azg1kVGYCDTDuPSMvvdqb+04vLSZRk80Fl
 AEf0T/JXwpwBHuY9wxve02ziAQKrtIGjFrotX56eousksAbcYgjP7JVn7KOiDKBVdoPTkUU3z24
 M91JlItRNP
X-Google-Smtp-Source: AGHT+IHMhCJxcqdCZRWx/qONCBKUX17SaWR7PpHRxbERjSaUq38+8Dckg7eE7Aqa1nDG0nfGy3nZYg==
X-Received: by 2002:a05:6a00:2c85:b0:7ac:3529:afbb with SMTP id
 d2e1a72fcca58-7ff648e9b90mr8900885b3a.20.1766391917524; 
 Mon, 22 Dec 2025 00:25:17 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:25:17 -0800 (PST)
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
Subject: [PATCH v7 22/31] dyndbg: detect class_id reservation conflicts
Date: Mon, 22 Dec 2025 21:20:39 +1300
Message-ID: <20251222082049.1782440-23-jim.cromie@gmail.com>
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
 lib/dynamic_debug.c      | 10 ++++++++++
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60c2142f8ac..e5a18a7d3780 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1317,6 +1317,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1341,6 +1342,11 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_mark_vector_subrange(i, cli, &dt->info, users, dt);
 	/* now di is stale */
 
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
+
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1353,6 +1359,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
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
2.52.0

