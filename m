Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0E210ED675
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D277A10EE2F;
	Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kthUHBcq";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADD110EBBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:17 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-4042905015cso814427fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551316; x=1775156116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYQBxHr3Fa2/s6UIiugIdxA7TpYQIjo73GyHI23/HiM=;
 b=kthUHBcqk+fJJ76yOPy9z4VAL+anMzf9lKdoqEPDJSGej0Ug1feuuwzmOVD0FBSYf/
 hPn5QTH3tPUYAMbcRCzn5q200hq4VphT/tE39FioXhl5gHc+KvmBnbZ3aa6vG0cq/BWV
 Ag7vOotkkUralltAm17UePhNdsZuwn1gQaph48xa9+Sr4vmG4z8dIkaJ8tcHkNo1KrnT
 UOeZfb03cZDFBAksvohaHQ0OpdKFwuQUKNqMSqHoyFbDJF/2771miMOo/7eHABhEbNdd
 6KWB+uLGitjs2gaT3grqc5zYuygvqV96rkjJdcPUFCGNkUtesBIMM1SQl/X2/YG+LGZw
 cxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551316; x=1775156116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wYQBxHr3Fa2/s6UIiugIdxA7TpYQIjo73GyHI23/HiM=;
 b=WgIHGz03gjhibdDRCKX1oBAhqnWapXFSZG58MJWE7spRsMTxLAlJlpr7rFzTZP3tuo
 j3lUqYEue0MuQ14cjA3qrCKaqL3itR8QaNiXsu17Iqq7ah3mryw53zqDAbrVI3A9q3+B
 iQV1AUPxcx4wtvahxMg0nYKbUpU6kKj+k/qvHHms+rldEUpU4vVdZ9OVkcaErWvpCSB3
 XqSIvklXS1krGXJV5WDqZ3c9Dp+VTx0U45DgKXdd8+59/Y06AoSQXlYgui39sKz5N8FU
 NhRa25Ee4ck49RqBNM2aMN7v07mcMnSOpATt6jruN9P1lE5adCvw3w1/RObjrNhkgem/
 NCYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4T2z97HcVr/WYmN+jVdTCwKewusobS4buSxb/p2t0/osfeIuXZCvc4uvNdYFYhyAsqe38CN3p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEiED0u4OBU+NKL6BH/1BS+CsuwjzWpFIkp8fJRRyD8MFRFMEp
 JdZAX2aA6v7xhSSAnsVj03RRgr062YbXW+RTqTss4I+XS99QTeH6K9SZ
X-Gm-Gg: ATEYQzxNgP4eSlb6KFGrMqxb+JqtJ0SqSv+MrRxBywdq3MixLb3XtUn3+yHMUkg5yId
 oNNkudK0vDTNAHijVTE4nXvPT0HkQuuZGtZpbd0XJn0nss3hhO4TIOXVbeHWrbct2jQeaaJuNgp
 C8fwzb+REhXyJSh4W6bYgkWZH8aGGYr0q+21cBtqtadtLCD782BiLtw5TKQdEVlnCesc5Q3Inct
 ikcrwNlpl3Q7H5icKpu1oMu5zMfnJp/AD+aYNd6970Vr8u/O66vspwQTYLuVS7ncwHlPTPibORJ
 fFu/+uowcgNNdm6c5VI1QLTHCo4RX4Yep4jJLWV800Ln87Yi985FuZ9sWA6uRhs8IShIWtnNCYP
 bsrj8986jbGgkFuveWKPBjo1ughryS/XoYxsSuv2bPYGmO/89H5RgAquimt12dnLLl08XeMIxrU
 9RN92Cxq03oiZBJ+mn3h7uRhCzd//NCMMc4mRfK6jPxezFfsZa
X-Received: by 2002:a05:6870:16cb:b0:41c:4e6b:3673 with SMTP id
 586e51a60fabf-41ca6f4c6c3mr4241281fac.10.1774551316520; 
 Thu, 26 Mar 2026 11:55:16 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:16 -0700 (PDT)
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
Subject: [PATCH v12 31/69] dyndbg: split multi-query strings with %
Date: Thu, 26 Mar 2026 12:53:35 -0600
Message-ID: <20260326185413.1205870-32-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

Since commit
85f7f6c0edb8 ("dynamic_debug: process multiple debug-queries on a line")

Multi-query commands have been allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

That works, but it needs the escaped semicolon, which is a shell
special-char (one of the bash control operators), so it is brittle
when passed in/down/around scripts.  In particular, it fails when
passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-command
separators, which is more shell-friendly, so you can more fully avoid
quoting and escaping hassles.

NOTE: it does break format matching on '%' patterns:

bash-5.2# ddcmd 'format "find-me: %foo" +p'
[  203.900581] dyndbg: read 26 bytes from userspace
[  203.900883] dyndbg: query 0: "format "find-me: " mod:*
[  203.901118] dyndbg: unclosed quote: find-me:
[  203.901355] dyndbg: tokenize failed
[  203.901529] dyndbg: query 1: "foo" +p" mod:*
[  203.901957] dyndbg: split into words: "foo"" "+p"
[  203.902243] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[  203.902458] dyndbg: expecting pairs of match-spec <value>
[  203.902703] dyndbg: query parse failed
[  203.902871] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

The '%' splits the input into 2 queries, and both fail.  Given the
limited utility of matching against the working parts of a format
string "foo: %d bar %s", nothing is actually lost here.

selftests-dyndbg: test_percent_splitting

This does basic testing of classmaps using '%' separated
multi-queries.  It modprobes test_dynamic_debug with several classes
enabled, and counts to verify that the expected sites show the
enablement in the control file.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  8 ++++---
 lib/dynamic_debug.c                           |  2 +-
 .../dynamic_debug/dyndbg_selftest.sh          | 24 +++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index dbf901150587..0a42b9de55ac 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -85,10 +85,12 @@ by spaces, tabs, or commas.  So these are all equivalent::
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
   :#> ddcmd file,svcsock.c,line,1603,+p
 
-Command submissions are bounded by a write() system call.
-Multiple commands can be written together, separated by ``;`` or ``\n``::
+Command submissions are bounded by a write() system call.  Multiple
+commands can be written together, separated by ``%``, ``;`` or ``\n``::
 
-  :#> ddcmd "func pnpacpi_get_resources +p; func pnp_assign_mem +p"
+  :#> ddcmd func foo +p % func bar +p
+  :#> ddcmd func foo +p \; func bar +p
+  :#> ddcmd "func foo +p ; func bar +p"
   :#> ddcmd <<"EOC"
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 16cff6c3b81a..6430f77c7b9c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -626,7 +626,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c7bf521f36ee..513f6cb1db1d 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -256,9 +256,33 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
+function test_percent_splitting {
+    echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP - test requires test-dynamic-debug.ko"
+	return
+    fi
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+    check_match_ct test_dynamic_debug 23 -r
+    # add flags to those callsites
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    check_match_ct test_dynamic_debug 23 -r
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
+    test_percent_splitting
 )
 
 # Run tests
-- 
2.53.0

