Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBA7107BCD2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F9F10EC58;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au+TW1wa";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EA810EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:01 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4673790ab85so1445619b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408240; x=1774013040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxTkOltoVAiRQNIiLPEo11+229bHMC78x0TMXlU2wIM=;
 b=Au+TW1wapgMyvc3Dzjn+VPZTiRP4wXMF3C/5RE8dkFAKXkzi3gagiqiO8pfy+y8yw7
 HHa19wwfN5OLn+EmY6iIyTwybTCyfSuJzqGlv0QajXCtaSG+THwiNQIEe81QIPVTacvW
 yvsLdWZSb67WarGNh1mebTFu4H0wKDsK92Xrxhv1ptkSg8EGPlxMv0ZKmbGOjxwIYmEP
 YvQWJshIgsEt/5rVRgCC0tVO5XCVN/mhNg+/ykNStlGw0AMmo2PXvnTyM/bfLJ8EuWom
 ShiUjDZal2rmemm7WncKnY6rTrSJ5AJ9rlyu4QJR5gOC6q3+Pzkv+SMLGIrl58Y97uvQ
 gNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408240; x=1774013040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxTkOltoVAiRQNIiLPEo11+229bHMC78x0TMXlU2wIM=;
 b=XZIVrqDJD77A53I1vyxIzmgTNJDQ+ihqrNeNkKFdCo85Kb7l4ygvscqVW0+T43RGwJ
 gOap2GO+zrsWY1zlSYjveDKPws8z3nd73Tc1c9ohy513jgtMyqeFwf4qHG8o7FRyl1Hv
 TkyPvZeveEg3lS14dfnxBLhdefWfLGa3YQpIywVRFnfNpbWRiX0aJZEZykzCf0MkrJvS
 BmcJKa7seIqxmBjhatqAwp5dJtfgIYfMAaCECt9VmBf6+5mLGHufa5kEsauYoV8TqvkR
 N3Lol1syO0Wva/ExwPXfsFXXP6yl3zBHqK46FtF7YQDXZAdQLN9D09FpV533kBlcDd3d
 ivBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc/PcACnSKtpb0VxygzuM5YF8nS3ggiQdgfwRFaFZk95X3NI2RA8VkTjUqwp1N+slz8OxTV4Vz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjBkrA5PUUCsy3009ECLje12QaGQLHVPC3uIEUQbcybMA7IUQX
 1NnGIr2KG1dMbRMkoi+wEECDNUWWrKDn6ZZ2nA6RJJekWQ0mV1a3cOhL
X-Gm-Gg: ATEYQzxY2fSUqml1mMvdHSIvkbWaXILuSNj0SHQyl5amTvJ4RHvQqdwEYWky6e/QFml
 YfBNf3BaVlIa5hTj87K+zr4q6iL7JqcWucyqwsgWpXgtwugdOnLHcj7iMXFGYXxQnTd2nbkYpGH
 E3sLaWXe5IeiyGvIUja2VXLoYSuaT2FNg/ABXnF9QYzCTohb+e12xIA8BoAs6WLfCX5R+55EIpM
 fQw9766DOf8gsuOzVkJjikCv5hB2u7Zqm99Cl0Y3RzW1qxV6p6od7eXSnPxO1zo52XmXg7/SDQV
 +ObtFAeh1bO86Q+VqJBIkWWhbEBDIPXb9cgyqlEvhSqBt4/sLxde8ZO2UKXRV56TQCV8UmQ1gos
 rJSN0/t3OSXuVgTS/RrTIkVKLTxrbWwJfwRsRc0+ToZ153pU3L6Fq+svxrQvccq0spIe+mn80h9
 VWh68lNPlYr0PnNjM2YjHn5wlRCFHcGuhd0JwdodR7P/h8RTeJ
X-Received: by 2002:a05:6808:5292:b0:45e:bfe0:21f2 with SMTP id
 5614622812f47-467570ecc8fmr1454885b6e.10.1773408240480; 
 Fri, 13 Mar 2026 06:24:00 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 29/65] selftests-dyndbg: add test_mod_submod
Date: Fri, 13 Mar 2026 07:19:54 -0600
Message-ID: <20260313132103.2529746-30-jim.cromie@gmail.com>
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

This new test-fn runs 3 module/submodule modprobe scenarios, variously
using both the generic dyndbg=<queries> modprobe arg, and the
test-module's classmap-params to manipulate the test-mod*'s pr_debugs.
In all cases, the current flag-settings are counted and tested vs
expectations.

The 3rd scenario recapitulates the DRM_USE_DYNAMIC_DEBUG=y failure.

1. 2 modprobes (super then sub), with separate dyndbg=class-settings
   check module specific flag settings

2. modprobe submod, supermod is auto-loaded
   set supermod class-params
   check expected enablements in super & submod

3. modprobe super, with param=setting (like drm.debug=0x1ef)
   modprobe submod
   validate submod's class'd pr_debugs get properly enabled

The test uses multi-queries, with both commas and percents (to avoid
spaces and quoting).  This is the main reason the test wasn't earlier
in the patchset, closer to the classmap patches its validating.

With some tedium, the tests could be refactored to split out early
tests which avoid multi-cmds, and test only the class-params.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 513f6cb1db1d..09937dca3056 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -279,10 +279,83 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP - test requires test-dynamic-debug.ko"
+	return
+    fi
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug \
+	dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    modprobe test_dynamic_debug_submod
+    check_match_ct test_dynamic_debug_submod 23 -r
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct test_dynamic_debug 46 -r
+
+    # no enablements propagate here
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    # change classes again, this time submod too
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    #  submod changed too
+    check_match_ct =mf 1
+    check_match_ct =lt 1
+    check_match_ct =ml 1
+
+    # now work the classmap-params
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    modprobe test_dynamic_debug_submod # get supermod too
+
+    echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( V1-3 + D2_CORE )
+    check_match_ct =p 8
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
+    # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
+    test_mod_submod
 )
 
 # Run tests
-- 
2.53.0

