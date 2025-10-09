Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF72CCD198
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C3510EB77;
	Fri, 10 Oct 2025 08:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="URlOWQQk";
	dkim-atps=neutral
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4F310EAEA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:59:15 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id
 ca18e2360f4ac-8c3414ad279so50550239f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032754; x=1760637554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vj6+/m+YvJ4nvGYtValsKBvS5LCfNDkFuITQxB3i5qw=;
 b=URlOWQQkhIzy+xOcdPp0QCKRMdb2vx82+AOolJYcPMKUPeaWdRCeiayqA7sy8mZPus
 h/cymNWNsmP6d3lusCKbo7p7Nl4nzTPdDHVH7bUVz2zpDasQeSOpwQjh78QNa+GyjywA
 S1l2Hq1eciO8VOb2CN7ItHjWpLnQANrllyLgdbgPDOqH2T80Qx26uRmtCtAnr9yAX+QB
 84whM33reLdXwzKhAnYA5uC4EnlIN6NRIPg7SeHkSAHgDQo0eXRofLYAcuiNTL5cxb/f
 GFh3VMsc7RZ2E/LJmXzxGzZqE63d9okYkZhQGKLIUoFLEd0CgASITJfX7Ajdz8/wAYj+
 AOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032754; x=1760637554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vj6+/m+YvJ4nvGYtValsKBvS5LCfNDkFuITQxB3i5qw=;
 b=Q1yp1OOzXOIkjh3YBp2KFcHmg7JKWlzZZHSkXE3MgKTJJvfaFV69qceg7+9q1+Oatq
 N/1PoFQErwquWYEtWHyL0K8H5hcHyGQrdMosoRr2V+Rhuth23Y/kiyzt1rXYKMXkiigA
 8XilAhV7CyjuU92z/jhl/jVb9fyyd4Sf7oBc4D0m9/sF4S6tq76QpwWLdwh/T6IgOlqr
 QqaCXWrfFoABJbU2uw5f05icxz+cf7ufWCmD8sPOXYXi+ob6hRy6WcxslmeFUGSFO136
 wc6mVYphgkUuRKXGWmoEJl0WwJgzBlpchu+Z2O0cfEZ7vMQpqe4iiwy2EiK4qvvTwsIn
 dZ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNG8dxpxGzR++caYAwFUUW53KHVtAlz1B7mwDOMiuiqZ3GmaWV5JJZdAXW/EMwkCbOr1fWKlN2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+gYfO9QtmHhYlHvf1hmQ0n2Xc70/RdKqloxIvNJHERt2PSzl5
 tLyXYX8Pakr9UEsJgPGfromfW/MvrWUgeMgw0iEvZ3QwLpUDIAI1bVfb
X-Gm-Gg: ASbGnctKjUTzfnVg0Y7y9Bx6862zkhRGYyhXSkUTvj8QGotd5hUdA6UTVww2ABu9mqT
 uMvZy0SNmwiNmTUxdZvYyAKl49Hhu3nFFExlC4hFyWuPYaQBfBDx1Vhudn0N7D5fCFYaOXfQ3ZE
 rP/MLoFWilK+6Ze2Ga5j/oyIPbS1vwg32ZaULmd3KhCrZn9R+CEsTCKJLDyUh615Ce4JFpiv2xC
 rpsbaKqnVX8O1DxpjYabVUpdwlgz/ZJ0+Api2uMyzX8q6jHN83qXLveb3dFRvd4XFQgMkTfW6cl
 FoN/myq++PO9DHUqVF/yez3Jye/8AqBj5sIr3n4K9PRYdqj8O2s1GFn3mRC4w6adY5zJDhsDIny
 5KRWLPvZJRBqTbpmquuXu2FmWU1LdK55gPRZJd5WePAlWz9Dzy7j9Y2T7K46b3Nvao29Ky1D840
 9SmJOL2/w1B5AGRiZDXfgeJountP/Oa1O6cLTSQA==
X-Google-Smtp-Source: AGHT+IF1wlfvaIMMrTodeuYFfX2PbnlKbpq3sHn29eEPjyMIjYw6+Qq5SpudC+MM1kOs5ShBVQ7J2g==
X-Received: by 2002:a05:6602:2b0e:b0:912:5455:f0b0 with SMTP id
 ca18e2360f4ac-93bd188eab3mr968983239f.9.1760032754468; 
 Thu, 09 Oct 2025 10:59:14 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:59:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 25/30] dyndbg: treat comma as a token separator
Date: Thu,  9 Oct 2025 11:58:29 -0600
Message-ID: <20251009175834.1024308-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
- skip comma tests if no builtins
-v3 squash in tests and doc
---
 .../admin-guide/dynamic-debug-howto.rst       |  9 +++++---
 lib/dynamic_debug.c                           | 17 +++++++++++----
 .../dynamic_debug/dyndbg_selftest.sh          | 21 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 63a511f2337b..e2dbb5d9b314 100644
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
index 9ae2d6458a99..b05d186e78a1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -299,6 +299,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
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
@@ -312,8 +320,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -329,7 +337,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -601,7 +609,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
2.51.0

