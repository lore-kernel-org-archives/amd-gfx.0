Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3F2E677E9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0035010E6CD;
	Mon, 22 Dec 2025 15:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2qqyTQb";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1E810E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:27:53 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so4488873b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766392073; x=1766996873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3hNaVpAB+vi7bZ5p4r2BEr0xFTlYHYJVlfyEjZdNd0=;
 b=j2qqyTQbXw7KCUjtDVWpdZLKU/AL/mG3rbfsf1wFcD9vIdszYmtIwhwc/Gbe1FOk1H
 DfV+Ea/wXn1weHC7D6wPMV2ZXSpJ7dHLsnXFkM+au3Na3g/t+PfJHsHuyMU+uTYo+hii
 5wPWtlhkr7y9YPY1FAhqAGn49pEpEJL9C/bl+AseBxu1eIY31PZ6YczBjUGzShmXXvZY
 rNLldIg2ZpWOK+zb926PYu9dJnbU5YXAOoR+mz7I1XO0ukWBn7daZJEya9uzvK711y5j
 1eBIRdUqrx5jw5+71TNnYvgbsHtc4D180ty1G3JTA3T0jygOKCA68Z/MJHH3cPoqwEiO
 AV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766392073; x=1766996873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3hNaVpAB+vi7bZ5p4r2BEr0xFTlYHYJVlfyEjZdNd0=;
 b=LtFl1HU/EWNhVDS1nCmRj7KdTsbujCouPQrcx5//W8JoOH/P1GNhA7+oS0CF75h9Qh
 p4Ay3ZDUiOH5qx9T8fDsxnBTS2678Bl8l/SFBsobJwQgLjvDCAEfi1VsZ2YHUyn/Ot5e
 SzjHjHnfjLgx00VeBnH7TaxeS7rAjDOUl7MmsCbACVDTXx9pqAZm++TbsiVE3Ag5FeZ+
 XOOZRk9suQAP2cURLbIYWEpY2AeY4lc3buTeyFcHFf2Z03Tf1e0RH67B52ROZ1enuXC/
 L5bfdH/dg3jP0h86Q/VKwLYLLtvaoYsDDCw+4xcoqWUhq0aXCV0bF5a/I1YEAdieTkkm
 KYKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW82QQ6+1m/nSNtMeXRyvMe1i/G6szUnE32yGRC/qPzLw/uwA0+ef+cOGYj3A6hjl2yMX5gDQK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfrzSWhFG8AOr0QDrdreEPfYH2cK4ON2wIb33OoIFiQkHjwuM1
 oGjQb0+M05txiAgWG4wvm/CGDMUK0ESIiEAjM6ANhzEn5MzSFfrdbVT5
X-Gm-Gg: AY/fxX4kzVJNR2N3qPWvNf9NmnIVyBy30xC5Cc0e67U6oh5cmXmaSZMi6qAFLbG9Ij8
 Md+EFRP/Sogn0RJ3kF9+uY6s99nP8T5nd039vXy/XMxFNo9vlLWdmIY9RshO6vU/AI/TAxeiVU2
 vz5ouMwAWKkjFyKRQBRk880UChVkRE/pSBFr2zuwENqmIF3mWi5MXZ+N+5VSsEjYsqNfRYJkwfU
 rtSGm0hYRkUPlqDIer3+OcyBS6eXdfpi9ZGtKp2JOBzJmoPu7cun+bBBCBm2Bium/0KwWv3ukdQ
 hZROMkRCRFRIPTP8dVxmqmrbxUQhwK/AfWGFBPu6uefqvMmKJvalX4YMz7tISGjHH2mleksoyk2
 yiigv1nbMvTchiZgBWTW97/1iF9W3d8Ml0RfUZ3baJyio1muz7D+RHFMNZy48hsW3R5m0aLJhDg
 Aty+Rop0E7
X-Google-Smtp-Source: AGHT+IHrWaoINwKINIS2uQVVYNVnFRipbIxAPkhOusVnBjYyr1lqJHYW+COkqDtcwbbrVKaUvl+ojg==
X-Received: by 2002:a05:6a00:aa82:b0:7a9:c21a:55b4 with SMTP id
 d2e1a72fcca58-7ff657a6a53mr9191153b3a.28.1766392073152; 
 Mon, 22 Dec 2025 00:27:53 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:27:52 -0800 (PST)
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
Subject: [PATCH v7 28/31] selftests-dyndbg: add test_mod_submod
Date: Mon, 22 Dec 2025 21:20:45 +1300
Message-ID: <20251222082049.1782440-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
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
2.52.0

