Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52410AB830
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6244F10EE23;
	Fri, 27 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I1fUeIbt";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F6710EBB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:16 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-67bad873c3eso872531eaf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551315; x=1775156115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Op8z6BF2VC082oV6Way2DdykcbiTU1bYqkraAfxcvx0=;
 b=I1fUeIbtPITKTkwDMr8kIeFxFQsvUf+AfZZdEsactlJj0XgkiTUNf3lnxJpeNZ9iG4
 K92c451L63v9SXNOZz0YsV1dQVwDx0Okat/N2rJ1Zt09hXGvK3wVnwsnKUc4ZI4pqte3
 FUvyRBvIVS/SKmVTailxyizfW1i5IDX3refRHrbQb/NLK6HKZkTZ6DKTIn37Ee+o/BUT
 OAzUbeLxEXvspdpwbdKMd5eZ8hps62SHKP4v0icCarPe6u27AoRifHFyjA5rtugZO8Gs
 2SNPIyRTsUCteyoGrGKB88AX5w1N/g/9Ug01YUlKQKq9+hp9GvhzHEyIrvXsYf1N3Ijg
 fqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551315; x=1775156115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Op8z6BF2VC082oV6Way2DdykcbiTU1bYqkraAfxcvx0=;
 b=o1m2LUB789KpKnxCQLMWQoynSTxAaWyEH0R8VNGfYu2svtAbZqG31Ww1ffBPyMbvf3
 mEeiwNyvzfJmg2ZVrZQdG+cTST0Z8csKuTfQyYKwa2hsOT5F6aUMvwGQD9qo08nBIw9F
 giURGvJTMuty75Rz6oNqBcJpxxOB3dg/JBnVoNGU2+tJm5GJxfNG7FUjSUADdI6M7UJW
 jyxRuVtjGT2L62htFbIC6UE9yeku1gGC2RH1ynhZI2YZ3/uPIn/vrhwMXDBU9BvaVCd7
 2IEL6QHNvt/isIUgNLCpheWwK4m0MJkhczwLJ5r9kAuddAdlDiO4IpjHiEpbYKdlVUcG
 N/5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuWXWs6exZsRdbygo9vph4+X4WU1fKQTQgqZ6cKrTOtlgmH/q31WdtorqLoyJUc+xUDal5sANp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxLL/ouFf2EzKB8mJQb+fv6yBxru4RajLsQ+R97fh4PURzVTqp
 CJYdl9knZo3Mc39e2hIH2sgMLB0uTCU28Jok4jerkuUtw/T6rO9PF2Bl
X-Gm-Gg: ATEYQzwT1a8i24g18HIIHavB61GABbRnLGpkMzhJwmdX1lNZSjxhbjsV2sf5wOivFEB
 a9B1YRxC1ZhkFK1cQfidV7v+E0IJ+mKrFzZzprO/kfcFqWL37IuprbcjHGoO1KkNB1BBYsC9ApL
 LB7fun5/f5rSvbUZaqUJcc+txwn56l3F3TOn+sd7ajA8NesTb/fa1jekmjruF+sBxiWA/LXlDZn
 7nnPshwBNQ9IjZ78oTAvvCDRBHrw5RqaT8Gpc2rY9YK6Imkbd5LpOZy7lUn1XGDAsAOYAD90gP7
 4gYVky6i+eX0B8VhVA4iX2ooKIIOI5X2XbtNv1xbTNh11ClvsQMuoHlwEqhNCAmwTyaRQkmH/10
 twbEuRNSAdwN3XE4UJBP7MaUKgTonbe4D+40jFzOhmKtzq+8hMD4lLWQPbs4JtUsgxoQjleY3R3
 7X+IjkU+yStKg9VLnUQnipV2G2ELNM4lZdtm9UvUMdqJCVpWLM
X-Received: by 2002:a05:6820:8c1:b0:67c:305f:ac67 with SMTP id
 006d021491bc7-67dff3cfa80mr4059105eaf.11.1774551315200; 
 Thu, 26 Mar 2026 11:55:15 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:14 -0700 (PDT)
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
Subject: [PATCH v12 30/69] dyndbg: treat comma as a token separator
Date: Thu, 26 Mar 2026 12:53:34 -0600
Message-ID: <20260326185413.1205870-31-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the many ways a boot-line +args can be assembled and then passed
in/down/around shell based tools, this may allow side-stepping all
sorts of quoting hassles thru those layers.

existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

ALSO

selftests-dyndbg: add comma_terminator_tests

New fn validates parsing and effect of queries using combinations of
commas and spaces to delimit the tokens.

It manipulates pr-debugs in builtin module/params, so might have deps
I havent foreseen on odd configurations.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  9 +++++---
 lib/dynamic_debug.c                           | 17 +++++++++++----
 .../dynamic_debug/dyndbg_selftest.sh          | 21 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..dbf901150587 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -78,11 +78,12 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
 Command submissions are bounded by a write() system call.
 Multiple commands can be written together, separated by ``;`` or ``\n``::
@@ -167,9 +168,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
 
-	module sunrpc
+    Examples::
+
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c6f3b0452dfa..16cff6c3b81a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -320,6 +320,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -333,8 +341,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -350,7 +358,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -622,7 +630,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 465fad3f392c..c7bf521f36ee 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -216,7 +216,7 @@ function check_err_msg() {
 function basic_tests {
     echo -e "${GREEN}# BASIC_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
-	echo "SKIP"
+	echo "SKIP - test requires params, which is a builtin module"
 	return
     fi
     ddcmd =_ # zero everything
@@ -238,8 +238,27 @@ EOF
     ddcmd =_
 }
 
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP - test requires params, which is a builtin module"
+	return
+    fi
+    # try combos of spaces & commas
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module,params,=_		# commas as spaces
+    ddcmd module,params,+mpf		# turn on module's pr-debugs
+    check_match_ct =pmf 4
+    ddcmd ,module ,, ,  params, -p
+    check_match_ct =mf 4
+    ddcmd " , module ,,, ,  params, -m"	#
+    check_match_ct =f 4
+    ddcmd =_
+}
+
 tests_list=(
     basic_tests
+    comma_terminator_tests
 )
 
 # Run tests
-- 
2.53.0

