Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF6710ED66D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4040C10ED78;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q6no+N43";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC21210EBC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:18 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-4152698e745so497589fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551318; x=1775156118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxTkOltoVAiRQNIiLPEo11+229bHMC78x0TMXlU2wIM=;
 b=Q6no+N43+65q9sFKfNFUNdhoW2RTzKqvI7UUhWkMSrkh9zUGgwuVoswu0l8wPuQeN+
 PNULcTAawjFtiQapUe/eORdG6gsbe9avQ5tBL8nggZt8dDziroMpadTuxAmlJHT9YBre
 UehzYu+XDmPVr6QE6aO8i90BaJBJ9d2tzfyA1SkplBHAQ1bU+su+TvZnRzZvNOrWHGhe
 VqhI/ODPE8E57pcl+Mtyh3qOhttELMK6VARMgK0rBKo39ecIaU5MU0plVIhtbp6jR5Nk
 9G6wsjNQFsJis5hr2ZalJuJfHM77vPNnZk8e24jNWbN9G1sA2otVL/fhe4pY97uLGDUg
 bceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551318; x=1775156118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxTkOltoVAiRQNIiLPEo11+229bHMC78x0TMXlU2wIM=;
 b=SxQV4RgN1H0JRPUt3HCj2c9XaDGrBsMf3zaR/Z/JdhASDFNVxKB9mVeWrdPlEandkL
 Y/Ag8lT2ae4LYt5M73NpW7tgw7T6fd6thU1iiVByWAW+/OU97T7EM4HMkxaDcmR0fkeb
 Pag52LY08QYJxdg7d25oWENRotuRThZ+WjhpWHHVfJlVCw+CXGFbR1Dr/kjYUx/RVOk5
 5LASpPM6UCQw+RIRyqSrELspiF3hTDA2vzn0Lz6FYnmfh0+IkpKJtOrlwOBlcoz64OZf
 4nK4CuVHKACfVZdTqZAA4t56qJvCb+l26o0pqFekbIW+DhQB6a3xfbXzcpKFhcEEB57p
 Az7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUod77jxb5BqCvgSL6Bq0WBr+BqzunZs6JtDyF0qhTIfru/ID9E1F5HNilUJeFEf+79FuVzoYQQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUpnsxEhVtOJwgCqy3zCSoRwNV26eWxQhGrqk9FcXTZ38b7tda
 ioK0//GRN2jDCWa7SlmZjp579Y1d9mIjok8+n4b9BqeAjVm5NVI7nZlc
X-Gm-Gg: ATEYQzx5HuC2u6v//GdfcqUzdQKtuT1HRJ2ApjXtD/uW1Tz1/qypdLpcLR0SfyYY80H
 kUYGA9QHZLB6okMZFPLVRYainoZhUNG6xxtV6V7d6q4LpK2tuPi0J241KuSKgg8z3qwnAr+vMyJ
 AinH5f0w5ZSJ+0Jj/XYkCNUsUrnk4gH7rpR4j4FyTzaXgV//rR7ErA3etvcDuydOfA1kBUe9ika
 1c/645b7Bk5sXSyn9d1GqAk8XwPynrfSoLhLQQetyk2VmmfO9O9tQ2K+vJfcSJFbo3sn/kz6f8d
 5a24KGiqqvDjMvHuCbYKgFRkxgofBU7bvmh39UmJ5LwO9Eo6MUWbSSUf9fR9Z9oy19MX3FkBoEd
 WMLzz82gLsZu0/AhMj3EJk2pxeC8+lceOvFPix+8+bqq8NNUAxgaFJ7lVDlLi2ZqThVPT7IIJKJ
 J6Qrc7T8HTCVSch8uq8YXsx4YewajdneeQf83Tk46bzsIhaqDP
X-Received: by 2002:a05:6870:b0eb:b0:3eb:7a2e:34a4 with SMTP id
 586e51a60fabf-41ca6ff26a6mr4833606fac.28.1774551317851; 
 Thu, 26 Mar 2026 11:55:17 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:17 -0700 (PDT)
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
Subject: [PATCH v12 32/69] selftests-dyndbg: add test_mod_submod
Date: Thu, 26 Mar 2026 12:53:36 -0600
Message-ID: <20260326185413.1205870-33-jim.cromie@gmail.com>
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

