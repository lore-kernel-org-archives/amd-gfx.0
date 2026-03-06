Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1537F01817
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D3710EC99;
	Fri,  6 Mar 2026 08:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqztcIfP";
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347E310E2F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 01:51:15 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-67a22322cebso1921341eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 17:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772761874; x=1773366674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rjic6E4sYgoKxkNkNG8eG+bbyrYHUHzf7UJjTOVCQkA=;
 b=SqztcIfPRBD2tzqtLW/ac+y64QOL4W5AmcXWlV5s3IMJ0/wV+UxfGqBD2FPCsXyyo7
 7IglWvDRmXuesxe5kiIZlkl7pI+FP0SbGRBMd6h/Cd+UbeJWF0vem7m+z8S1ZEuVhy81
 cHsJFbMc4hZP75EFN9h4zCalRU+/rNFKCazXgdYLvfNDMbshsmwsK7oj0tCXM4K19omu
 56i6eUMOkauW0wQWanr4wHKjWjCinUzm1QocTQ++wLIGxg2o9Qd+lpRwwz6dBa4+ehMq
 PhoTfnZDbJtyDZhp5NkrCE87+FmpTLq3pUSgf1shfuUluPctcEaXHq6WhJwU2xQAR193
 HDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772761874; x=1773366674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rjic6E4sYgoKxkNkNG8eG+bbyrYHUHzf7UJjTOVCQkA=;
 b=vao3gwZ+V/38r9+Xk/oAWzTszzQxBOV1CxsHSx8534KPi1zpi9gtWR4TQ18E7dJXJZ
 09cXoVnP5U/oR1IqOXposCzh1JnHvLpq6MoW5+tYeHrdEMJ58QcGTynlLtwt7yGa/frM
 mN7eiLQVvJtgsoctXIz3YC9ZokksJMxqC+E3NnJ5F2OPHROOGALPjG2NnMaHN/cC3wP/
 rnolEgQlUL8xJjugEaumil3eI5ZSTohNqcQ4sLO6LBg9aIq0DqvponT3CJx3Lc1A2Rtx
 aKlubj1O4S6JOi0uU4feSSit6Nf1K3rpUAjUm0ZGJMJxAYO2dA+hzlLeqroXXuz3TBGl
 OjhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiqT0cN2cQc0gAHmOSG8z3MsSfiu7JN6iuXkxroP2c9NfE2+v/KTeGWSF2NcZa+LKj36Su9Qjr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/g3huhYI89/bLeFamHrEyZLA6OrQBmsVtURx7zUKpqcpWexDy
 NssKR2tewt3abTii7K1ik9WpfyrAaEbS1L+mx8wBFhfDnTzQRaXvx62u
X-Gm-Gg: ATEYQzx6LYvK85XWb9m8Ca0A2yeI5PnS6pT7UMOm5SER5vxpweP6oJFscQW320jJYsw
 PRenXG2P5xE9Wl4rcwIMwbJN1y9XswIQTzu4EcRYLwsD1tvVoHkOz9Rc4dUWfSobzRXOqlWolQ1
 ujFeW8KMaNY8FDVwyP6rCNEzmBKYSU3TErxEwgtZ5ykI7MOg4MydqhRNSWkmGz2PJR7jlFFcJ1q
 HuMO4nacNGCuWG7znm2x8wEAMOTOWLGa4atX3eA5iCvF198Mo80EpR+oa9+zvb4O5ywBkOzQ/hZ
 ua7L5VrW1klKwXDHCokBxfZGKjhvpOq1c6UtwjkufyOZ+leCf1cAc4Wb7aUr+xDUfok1VFoYRD5
 b7/CnEsge+aFAmJdh80+AcrDRsLpqG6dN4jlUQstxdcM0ED0q7JUFeebKe+xcoUSGXPW5s+bOK2
 jZiNCjDIDuemrFHisZpNXOnW5nd0zw2G0ClETv651YTwFcUvdu
X-Received: by 2002:a05:6820:3103:b0:663:11b2:d61d with SMTP id
 006d021491bc7-67b9bca1e01mr428086eaf.25.1772761874446; 
 Thu, 05 Mar 2026 17:51:14 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:51:13 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>, Jason Baron <jbaron@akamai.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 7/7] dyndbg-test: test keyword !value negation
Date: Thu,  5 Mar 2026 18:50:10 -0700
Message-ID: <20260306015022.1940986-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306015022.1940986-1-jim.cromie@gmail.com>
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 08:52:54 +0000
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

---
 .../dynamic_debug/dyndbg_selftest.sh          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 09937dca3056..5c35d7cc5ecf 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -350,12 +350,47 @@ function test_mod_submod {
     ifrmmod test_dynamic_debug
 }
 
+function test_negated_keywords {
+    echo -e "${GREEN}# TEST_NEGATED_KEYWORDS ${NC}"
+
+    # Test 1: Disable negated subset from enabled set
+    # Enables all 6 in init/main.c, then pulses ONLY those that are NOT run_init_process (the 2 blacklist sites) OFF.
+    ddcmd =_
+    ddcmd file init/main.c +p
+    check_match_ct 'init/main.c:.*=p' 6 -r
+    ddcmd file init/main.c func !run_init_process -p
+    # Result: 6 - 2 = 4 sites (run_init_process) remain enabled.
+    check_match_ct 'init/main.c:.*=p' 4 -r
+    check_match_ct 'run_init_process' 4 -r
+
+    # Test 2: Enable negated subset from clean slate
+    # Negation !run_init_process should match the 2 blacklist sites.
+    ddcmd =_
+    ddcmd file init/main.c func !run_init_process +p
+    # Verify exactly 2 sites enabled
+    check_match_ct 'init/main.c:.*=p' 2 -r
+    check_match_ct 'initcall_blacklist[[:space:]]' 1 -r
+    check_match_ct 'initcall_blacklisted[[:space:]]' 1 -r
+
+    # Test 3: Enable negated subset with wildcard
+    # Negation !run_init_* should match the same 2 blacklist sites.
+    ddcmd =_
+    ddcmd file init/main.c func !run_init_* +p
+    # Verify exactly 2 sites enabled
+    check_match_ct 'init/main.c:.*=p' 2 -r
+    check_match_ct 'initcall_blacklist[[:space:]]' 1 -r
+    check_match_ct 'initcall_blacklisted[[:space:]]' 1 -r
+
+    ddcmd =_
+}
+
 tests_list=(
     basic_tests
     # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
     test_mod_submod
+    test_negated_keywords
 )
 
 # Run tests
-- 
2.53.0

