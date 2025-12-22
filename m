Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A45EE677F9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0544F10E6CE;
	Mon, 22 Dec 2025 15:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WtYmD1gg";
	dkim-atps=neutral
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E29BE10E5D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:29:29 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso3830446b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766392169; x=1766996969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JUGCGjJm2Xj6X5n/nhoMCGHMBetXjpQki6LB/h6PNI=;
 b=WtYmD1ggtgFrs0WficCbcGKzrFVMvz5IRpHD0liYFd8eLpEOTi3bfjAd9uKGW3fIkk
 bwYe/6/NdtmvvCrNjt3laILhDYWlmljx0gU9L0BkigRZ9Lb+JCecU75/VKCW7NteP3KF
 0IomGj9nd1pzT2BHwWryXZCuYNYC3DFgy+JXcRI3Q7LJ/wIml9ssEh0wBRy/M47pDUwI
 O0dT0toX18vDq+6OGJy2V1IenOrAi7eCwhl/OwUTJ58lw1dg8UzrkcGjJg8ZW9RpVzO4
 26+mOB26t0D5qdbvcI3tsBAAYC4XIZOPTHNAXurf7eBdyAtvt0dxrAbEvLyOt8zU/aYj
 ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766392169; x=1766996969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6JUGCGjJm2Xj6X5n/nhoMCGHMBetXjpQki6LB/h6PNI=;
 b=Do00uInvs2WxIiD3jNQt3ducKVtEDfWlAR/R3XpSwl65trbmUZ/PnALBTJ2fx2//O5
 n4KliZf4Acn4LTB/WTbUOATa8mVk3VCYIdj0Q0npQMtLjLXgiXFwc+/NOF/4jhKRxqJ5
 ND61UksY+vSiTEu9y2sDfcU0qCd529wzrJKmv084KeTBhs7icxVJXJNv9JWfgNq++2qP
 tbUcs6Mc6wTvtOD7DhgUBWkXNXAt16oaZIXTTnEo2pAM9U/iK4WnCzFUCRwJU5y4NXRx
 9inHAUhnieXsyp8QxnUf6lwKw87krfzHuZtllZSTdQQa0T8Y9inVe83icdsdx7AUQsDD
 Vpiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaQ260MEDiy/BM6Z7RaPVC9pdM1DUHnkdk9nl/gq+2N++ckOuN9dW3p09L6ITd4yL6wXWbzSUF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEI9NTiu9Qhy3pjGIhq7tLmLiKnkP0mEDAAlUQg5ndb2ZyP/VE
 9w0HCqjzg7Ka0dDCMgjJ79EwuuAO3ZHKJgpa2Bc40EF2wHwTx59cme7E
X-Gm-Gg: AY/fxX5Hp/bVDDvoAAWsuyeGFUC35cWMPFjrycBtpeDtKW2uvrA1uDFrKNoPYlrY5Kr
 mZ0q60gO45POjEXpEB6sTCqVOshly9t7dXr8hxRhOPNw4yCZWMMKVLQD3Ot8zmup19ITok9iF29
 fBYhHVedLX5IcaF/ZfABQeEhBGA3eTMQq+65HebJSMCe0ho/kWWO0rmOJjP1UdLzP/CZ+OgvpRp
 6tvx6hEocxHIxuApRfpk/fXD++u/mdkT9wx80F2ERt5f4PHOmqOMn5E8bnH8UdoWgph1dwn/UY5
 Rdu41rUBTFEjmpDISg0LGRvI3Jxr3Rk28RdD89maaiylBq3uKX2kkkcVu+a0I/eBUNms0Hc5ZXC
 1VvzP6wqdMRUs326Uip+LzhE2lfTKmIq/IBbKw/mCL/tk57hayJnfrnQvJrT7pDop84gi6iwE8p
 mUd7+bwu7J
X-Google-Smtp-Source: AGHT+IEimmJ/Dttom6F34YWsdHH3XKVu5FJm4MVosU3HZTEdHiOovrYFxoO5oyh48i40FCdqR5InOQ==
X-Received: by 2002:a05:6a00:aa82:b0:7a9:c21a:55b4 with SMTP id
 d2e1a72fcca58-7ff657a6a53mr9194464b3a.28.1766392169447; 
 Mon, 22 Dec 2025 00:29:29 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7af29dcfsm9640064b3a.17.2025.12.22.00.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:29:29 -0800 (PST)
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
Subject: [PATCH v7 01/31] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Date: Mon, 22 Dec 2025 21:28:13 +1300
Message-ID: <20251222082843.1816701-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082843.1816701-1-jim.cromie@gmail.com>
References: <20251222082843.1816701-1-jim.cromie@gmail.com>
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
index 5a007952f7f2..eb5146bcfaca 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -171,6 +171,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
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
@@ -203,42 +249,7 @@ static int ddebug_change(const struct ddebug_query *query,
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
2.52.0

