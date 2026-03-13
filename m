Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6298107BCDD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5810ECA5;
	Fri, 13 Mar 2026 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IYeqMaEM";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C514D10EBF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:18 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-46726528f1cso1545962b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408198; x=1774012998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNdSdlXltBKavjCpq8HaVo39jGQFAT2gyMj0g9RRu6w=;
 b=IYeqMaEMsi0LSzryetP9LXkyDznlZDZuB6mxuWZbPlfYRG/6YhtgstRhr/tbhHmp2o
 vH/d86Yxfe87ZEmMd984Dx14A3hEmUMQphc6UtIIzjzdc+Lf0kVfYvxcvtaYLdO8GqEU
 bYToyy9rwdYic/IAYLRYM7RsWG7jTjOKyX/F6zxDlJlYGRd6zMhoZz7jyCCXglK+4kKQ
 0vxvvde5GKn9/dLBi5/QjGsH+Dqap553SH7nshPsMwoQ3hc9XrZOpMdtyJA4Cea1t79y
 7YQt6/0F5GtZIfVkGz2XFKb0K//c64SGdvDZ82oQrpdN+DrlY6wngLTb7wbnaI6EXNVn
 UsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408198; x=1774012998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sNdSdlXltBKavjCpq8HaVo39jGQFAT2gyMj0g9RRu6w=;
 b=LqDv56O90zJgG5lBxqs0/jOV2JXaVUe4Rf2s880lq3IbfyxwpOqtRxxjkiCDq0Lvse
 R4hGiLcXP/xwa5HwnEEx0Vj7j/ZZGvuPeXgs3fJgu4sRPiwsZdczbSwoJuTxEIKk5qZU
 euNzNgvp/bEjVmGDPyYhALS8wAijNibQ5sgpPaPLZfKxAYzUWR3QbIJANtrg6Ew52bia
 LQgBs5oepozl/Wn+bzExafaLvL2S7AE6yRQ5dJZ7ZcQxm0znck2+qzf97gUyIXpzmNBV
 dkIt4Z6E5UGIv3mXIKXGf0AnHo0bsyY9vykt5bZ1hCVUNuHME6cYP3h6EGJCbPlXp4ba
 oCnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNMT/7/eU4xHYHOTXNcUTuCUzimre9aDgHMZxagQxKKrq7fbTu0qvukfZKd+Ribs5j4d5OjUl6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA0ab7ozAPu6fiXgTemjw+Pr4w8nIRXaCUfXphR3eMm1U27lHk
 Yz0FiByEDPwW9e+4Wqo1y4BuuRCpotKVswtDFPIwSWQThjC9pS6ylByf
X-Gm-Gg: ATEYQzx0IWIiqFH6I2rzx9Dhr3jvWX8OGUKb9Dp/PeE6rkcyfu3UqZWSB45Q3kP5BAu
 32MtTjYJwUJbI5TLysrymufppmq8nCdSD8ZuDO0JbHzG329Dc7bXaER75s4uCtJrkpQ/eOAy9Ly
 +sFu8VjES2TBt9/Ij5sR2eLM9raPugOHZOKiVaOdgroB2GmlBJ7u0A9zj4HFkoNXKioTUkHpB23
 Gd00DwT5R7FrQVgIH84nDCXb9gxawkegVOU4eWVRyggKstfJhiEh4BxtMov0UJfcdmDCFS7RF/U
 TRV03WvRjTe9CWEwzA9lawwYrCyZySaXHNgJneOWRGus0IBS87nvf/pjPts0q83221kZQutfKzR
 3oDLvWJhrGWEnf0iQyhtfYClmroLxv4eEgxomeh4CZ/BYM6sIBLBmC2dER3UHnkIzFdcQ65YknZ
 8QUmbs6Zy5fNl+Uhm3a+FcIaZRU5jGMplvWgVZfyt/GtUA//wY
X-Received: by 2002:a05:6808:1b10:b0:467:254:b90 with SMTP id
 5614622812f47-4675704a335mr1610159b6e.10.1773408197894; 
 Fri, 13 Mar 2026 06:23:17 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:17 -0700 (PDT)
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
Subject: [PATCH v11 11/65] dyndbg: reduce verbose/debug clutter
Date: Fri, 13 Mar 2026 07:19:36 -0600
Message-ID: <20260313132103.2529746-12-jim.cromie@gmail.com>
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

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

Also reduce verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9575b92a8deb..3ae9ecabdad1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -276,9 +276,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -511,7 +508,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -525,7 +521,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -541,7 +536,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -551,7 +546,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -569,10 +564,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -1246,11 +1238,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
-- 
2.53.0

