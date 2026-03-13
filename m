Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C647107BCD0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6067010ECA7;
	Fri, 13 Mar 2026 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQxb+M3M";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA0110E121
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:22:54 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-467161c4b89so1364614b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408173; x=1774012973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vePjq7+VFJ5ZhNc2ZqKhZQksj6wQ9j47ntZTNCfs3mg=;
 b=BQxb+M3M8sWjG7rgFPAs4psBxvxkYKcRwfWYMoD+sMfaU0Dfu78TXmNtkje/jzXwkn
 Yx1X6aM9sQG/Vp4Qa5RM8TCW5UvxAJT1fFKF6gfgk7CvELqBZHtorQp5UYv520ICwhbO
 P3nsgdW/7wz3mpI8mOb/QJIZJPVcCB/9zOMXqAoV2xT2ShurvMfvLV3BAtK/LrxSg5Z+
 DdLt+NGEgtLEJ0hQnjZKUeizQeSs2cfPLvXJqOftvB19TPOO8FF49yCJuQ0cNm3ZyqbG
 hPiVUAfPPojiGjccbZkznakIVRJWWAJXqYRPJ1wuG+9/vXfmRwo7LlVGg6660WmAg/m+
 AkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408173; x=1774012973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vePjq7+VFJ5ZhNc2ZqKhZQksj6wQ9j47ntZTNCfs3mg=;
 b=oc6inQUNu/hndaxts/90monEGPY581DvXkFCi7TvZLvW2FPKFvogmZn/0+MBPWe9ve
 BjwJlxIuwUEiECEIO1bs5hvG9J17/XlJN7i9x5ybVSCeKI3Cm7odPURYZEqCMZ256DPn
 xqoxVHx9hPtwli12dbZUNRxPlu7HAWJpIE4lnLLc0JZtNHoU9fiQsLhrHfy0HoDQkaNh
 LzC2lskAGV/K72AkqQbMwhdpbGpZc9dwiEkbn/zrsbHQbGc6RnLQ256UJuLbQBw5VDa4
 5sVw8yS5mpOyq+b8OSWPque2OvFBdleTM0s5aZ7gwBCJEvTujFemWvqkGi5496DJlXmC
 IuLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXVpLBQ4mqQXqx1jMqA21MDx3tYkPNr8YAJ1ORrlEsLzWKER0Ca6zUP9ETHiCBch64hK9usJtN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjZ+hE1DIVxM7xCVdo+fyKJuCgGhKa7gShX5sL6g+zOpbkxFmE
 lUuvhsAO64MLyTfZq0phPxX7FWo0Th8eIVrmzflBPQmk+20WvIwV4JaY
X-Gm-Gg: ATEYQzwViCuV3Mw9CQ9bjP+lsHUfDL0vt8k4bZS56SOPtwD3CXYmOoLk0Hw+wy3gLFb
 s9ZXEeL3XlKz8RSZU9lneaJ7NYJgEVa5W2VrsVTXg6hH+XCF4DFT0hV1x1vvGtTd50opglAUHFM
 szM4ARSEyOxRWf8D4BYwFF8kAz4Vhdxd/r6zgQRVvuxDhzMPiJroZRO78t8Y0gp9UoyitGda3pp
 S8pnEnLqWnuIg+V0CK8MppDHF0B1H8FRqN9vziAVXJ+ZuDBseh1EDnJT/rp5ixRhqd0LJz2rg6u
 ILoQH9EO7zjyBK27r/wldoZgAKkobKZ3omWYhs+OkYQPyTM97QpX7mSLL186Yx/NKIrQ453Y5Vz
 PDYKiQZvE+ULdgv/KlyRlbiBCugNc6ZM9fHmORaqE2KK60Zk4tcSRxYu5Uhr//eufo8MVposMHV
 ZUweU8pWOc65kkjRkzkVQWR9BD1hATdMdPHJGBTdp39pmF0OlA
X-Received: by 2002:a05:6808:158e:b0:45e:e07d:85af with SMTP id
 5614622812f47-467570a2be8mr1583016b6e.2.1773408173272; 
 Fri, 13 Mar 2026 06:22:53 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:22:52 -0700 (PDT)
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
Subject: [PATCH v11 02/65] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Date: Fri, 13 Mar 2026 07:19:27 -0600
Message-ID: <20260313132103.2529746-3-jim.cromie@gmail.com>
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

ddebug_change() is a big (~100 lines) function with a nested for loop.

The outer loop walks the per-module ddebug_tables list, and does
module stuff: it filters on a query's "module FOO*" and "class BAR",
failures here skip the entire inner loop.

The inner loop (60 lines) scans a module's descriptors.  It starts
with a long block of filters on function, line, format, and the
validated "BAR" class (or the legacy/_DPRINTK_CLASS_DFLT).

These filters "continue" past pr_debugs that don't match the query
criteria, before it falls through the code below that counts matches,
then adjusts the flags and static-keys.  This is unnecessarily hard to
think about.

So move the per-descriptor filter-block into a boolean function:
ddebug_match_desc(desc), and change each "continue" to "return false".
This puts a clear interface in place, so any future changes are either
inside, outside, or across this interface.

also fix checkpatch complaints about spaces and braces.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 83 +++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..6b1e983cfedc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * callsites, normally the same as number of changes.  If verbose,
  * logs the changes.  Takes ddebug_lock.
  */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dp->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dp->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dp->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dp->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format + 1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format)) {
+			return false;
+		}
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
 {
@@ -204,42 +250,7 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
 
 			nfound++;
-- 
2.53.0

