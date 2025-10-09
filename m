Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC04CCD192
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6DF10EB59;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ck5GEFnx";
	dkim-atps=neutral
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C47010EAD8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:56 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id
 e9e14a558f8ab-42f6100475aso6135915ab.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032735; x=1760637535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxHzW7+krO7PJKBXdtqexN2OJeKAsxXfOckL+sZhGvs=;
 b=ck5GEFnxHxvXvPy9qpw3zmCKjuHbXXq9n0ZX0Px+NQxAGivQ49j+2qdGNGHyzqN2P7
 C8TA4HNLQ3+gegEybdwUMb/AzNa5GbXWBBhxt5OWp9h18TSW+c2f+Ma/bcMJGhAd72mO
 Xm4iC7vTXZPDHu9gwUor4XNBtL8IJkKxCzpqIBr6w87pLfQpZEdViXv+epSwZqBSEszS
 uXilV3W2JiGHEzVivlssw4Pq0Akvqi5S9o8n2gafdAV96twoyncm5ad8t4Grp08sDypm
 gBLv/F+UBEg4BXaocCPozY55rt2pQ1i69ih9hyMp4tzl2aQq1QG4ugVFmIeB5yZ6VFO/
 9hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032735; x=1760637535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxHzW7+krO7PJKBXdtqexN2OJeKAsxXfOckL+sZhGvs=;
 b=kkOFu7Cb9dBUq+Lb6TwNPoEenibqY38hNtmIvIGP+2qB5IMygPIraQh9bgZWf6nzPn
 fOvNVJSP0WOHDtU2KjbJwsRqwiYbhfpOnuN2ZKSNWCLtiSqteyonos4yhgaUeG7Bg1DX
 hXPX02inmkT8ftonNAZkbfIkWljgiZFEqjrMILW+yBGN5bV7QnQhSnbBXeY2J5cRx6mb
 1Ml14L6HL3BqTUSzAGWVR5AMEWiQSwpiHh3DgNymQz7Oa28g5ycuzcjHU6VDq3/DwBDS
 DvVsLuy3MQYL4RFl9CyMy5Ljbo5U3kGqE6nk4cNDSj4jpJk6lDG8DBt4epvLYE/rLwTb
 edCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUepO/rCme68BTPRhaXET41W3BTssTdKd8FN3qXX7vD4HSXgsxueihOaUKi1zPtwY/FHLscyWRp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWqYGXT2VQ7DCSVuOIJgr8QbRj3u71HuAai9xIAICg744arIdK
 y6NZE8Z0k2KsaEiyNpBIilXw23o2seq/RrFWH6fetBBRP2KuGBJrMtjx
X-Gm-Gg: ASbGncvTwLqB2Iityh+3MpUl6oxUrz7kcG8q9lur2PXKD8Pmkb1EDXlLhezQMDsxuXa
 kRlO5pXGTL19qmld/cNVkkc7sG/59zuRWGm1TQM+avSUmd+GgbpyWOBzFYCA61Rls42E3Vqw3Yq
 vtNKNlli5bhHgpXuuvzCa389roG2PF1sSnnDZS/e+ioJFn8BRLJ9XCHcdxtLoxvLBTH7O2QybHy
 o7b4PoBbI7xVLNtFZ6jtgoRcZJ/I4kACKECEGZnE1c3lvj90UrFr7t9G7H6Dz3PPOhU17kMIU7y
 eq3WfuyzpnlQTSaY8fWC5UW7E+AyAhvAl8mS8kc4iBRFT/Z6RsJotdZldQ8A3i6FlCeg3g0f1wA
 AkR0ZYSXwMIrpCti3VTWWuA6x0sFK1mjdm7W2YUF548N8VgXzV5fXudLMIGtJ88TPNsQEI2rzv3
 uQuO632yeLvqB+GGKK00j03iUmqMM=
X-Google-Smtp-Source: AGHT+IFEQVqHItn96Kc8TDNYahdPGtpH8o28572tm7Q+v8IZnToKzjnD+Tl3S+JyYpse/uqZNmWfdQ==
X-Received: by 2002:a05:6e02:1b0d:b0:424:6c8e:617f with SMTP id
 e9e14a558f8ab-42f87368781mr57791605ab.8.1760032735463; 
 Thu, 09 Oct 2025 10:58:55 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:54 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 08/30] dyndbg: reduce verbose/debug clutter
Date: Thu,  9 Oct 2025 11:58:12 -0600
Message-ID: <20251009175834.1024308-9-jim.cromie@gmail.com>
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
-v2 squash several verbose cleanups together
---
 lib/dynamic_debug.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2751056a5240..d9268d051a10 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -264,9 +264,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -499,7 +496,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -513,7 +509,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -529,7 +524,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -539,7 +534,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -557,10 +552,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
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
@@ -1234,11 +1226,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.51.0

