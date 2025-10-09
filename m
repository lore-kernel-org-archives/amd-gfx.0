Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F65CCD187
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1A610EB52;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kvku9NrO";
	dkim-atps=neutral
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E347110EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:59:00 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id
 e9e14a558f8ab-42486ed0706so7397305ab.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032740; x=1760637540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcE2j/B1mQgeocNkBmpDERPavffRGmULzplmDVYobd8=;
 b=kvku9NrOswRYsjlEgn1sl/NcjwrnxTEipeGx4frB/0HfVzZBIOZqHPdPVxLXt8PxFN
 tSyNiCe/vEgCGQBV1t2hEMHlomml4NPp6EAZm0SdjFY8Gj17luL16jIzW3OY5cSyGSpe
 aJh7eh68zGIs/FiLwk/b1NEgDmtZuGF5jNY0Fe2g1nVFVqlRczsCNqiwoiBpm8qhHgRp
 E32p4UMlIb1e9BnZpjrUp3j2xD7tMaVOxKgoyeKt5p6y7Hl7jzo6+IqK77KTqHeaqRrO
 rFu/6BwONCJ8UIWGGwtB8NnO84X5SZ2bf6imzkYKEddt+F/kHR2P4SssdfE3LQb8pTqF
 eEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032740; x=1760637540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcE2j/B1mQgeocNkBmpDERPavffRGmULzplmDVYobd8=;
 b=hjkryYOUqhubcZ0d8DUyyM08WKTxANDDyvF5aoPSbDPkpahk3Ln6Ma/9UpPVrtZ1ED
 QtovtXe9Napsf/Cik5/gG3xJNh52Mp8ZK+ERk/rT+yHKRPRBZM7N1KaZtljKa0ysdw58
 kQR3QUGCIJe8VtBBsMEnD0ZYGB2+FxXaeg5CrN2jnQ8iJrvN9poCA7G2us96Yqz82WQn
 J4e1st66SxDrjtWF+Eheg7LLciTQAAY+D3xh3QTmk6yscvE8/pBPcDpOyWEIcG6x9PNy
 53xVs/sggGtLXasxHqKQT7v4lnaJKsSgpn5jxYARcB3SpQUV4E46BYQsGDJi/tMaQFD3
 4LNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVntpd7tIk+hmJHxfN8neOZZXtfrg2ICZyYcIUC4tye7VQJmHew1bvMPTM6pNZbPe8RD/LsIMBl@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywzz0zGFBZBMnBwxi1zPhw1U7gAcM6LsqGUUvHKGYpuYmmFQ5J/
 +UE6villR+jPubc3PQV+1zo/4nZnBZlwSVw3/mwTYbvbEwnicAkVlZXd
X-Gm-Gg: ASbGnctcMaY0RJnArJ0oUmsJYb5itXw4DDyHp8D7jpvSCFc+eQpV+ptTTHCL2H60WQC
 7bSq7GMIBOd9EwZ1cZIIXeSL3z76UrunkBvr0CVJsGl+AQscFo1YRlV7OE7Dtt3B8MwPCeI6ked
 2wIIVsoiJnHLj3ixzB5gB/ZwfcMglyg2BcwWtCRB6bYhBj05ttGB7EcroCRtGLrJq5d35j1GH0Z
 R26pApPLbaLSvXOolI0qTaMKlGsIhkiTT9N1x1Lt0BKGtJk8p+cmUr0BKV7OdIZfF+HmowlFfYr
 4LMjo5/Bodk/szZKSWIRBkd+2WHhcLEcv1KWn7QuV8br6Hm1xb6EGklWLYD9nAwINQCGDLDESS2
 07Kf3rCFHgyxUpqMnxqKsQ0MuEyJoV+Liof3yx+vHhTaVRNddy9x3Qj0j5pycHUEYNwlWTIK2Lp
 eWfG18wAfKiewLsPJKIZiNF76cnp8=
X-Google-Smtp-Source: AGHT+IHjqP+G+vhE18sYwPA5Xq+a2h4s4Xorq9ruFfYudOUTjoHfdl8X+oo47RIuEgvRTTKzlg/Fzg==
X-Received: by 2002:a05:6e02:2305:b0:426:7dd6:decd with SMTP id
 e9e14a558f8ab-42f873f4705mr67420995ab.28.1760032739929; 
 Thu, 09 Oct 2025 10:58:59 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 12/30] dyndbg: macrofy a 2-index for-loop pattern
Date: Thu,  9 Oct 2025 11:58:16 -0600
Message-ID: <20251009175834.1024308-13-jim.cromie@gmail.com>
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

dynamic-debug has several __sections, each with <vecname>,
num_<vecname>, and it iterates over these with a 2-index for-loop.
These loops are fiddly with the 2 names.

We have only 2 such loops now, but are getting more soon; lets
embed/abstract the fiddlyness in the for_subvec() macro, and avoid
repeating it going forward.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 283926530a43..ddcaa87f3b02 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -128,6 +128,20 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a sub-struct member in _box, with array-ref and length
+ */
+#define for_subvec(_i, _sp, _box, _vec)				       \
+	for ((_i) = 0, (_sp) = (_box)->_vec;			       \
+	     (_i) < (_box)->num_##_vec;				       \
+	     (_i)++, (_sp)++)
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -155,7 +169,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1220,8 +1234,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-- 
2.51.0

