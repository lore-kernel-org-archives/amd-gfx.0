Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81310C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D75561DC0
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D75561DC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E170789FF9;
	Tue, 29 Jun 2021 10:52:37 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6D16E364
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 01:28:08 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 pf4-20020a17090b1d84b029016f6699c3f2so819344pjb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sdAmp65hciYeluIbPve30oHR/GPcy6OyyGVJziF+xHE=;
 b=ajlC3Y2BbwpJvb//BGwKk0iVmUKdgr6EEkltyLi6EKddugzIYMyVm811CxYaTI5RZ3
 XRN3lZcqg0qg+ZKvi6Csnfs2+RUTbc+LchNfBOOelhMYtnA1/2shvLGUzCo6Cz8I6y6n
 Wgb5Dyeh2Nax5GQ3GRJeG23tObPIf5m6B4JIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sdAmp65hciYeluIbPve30oHR/GPcy6OyyGVJziF+xHE=;
 b=gzDawjVdsCVSDjvVzDfUCYOWa4RxEqDZ+d7CAmmxXeBzi3DcDmfrn0eGKG3Q7ijOqm
 1LtuX7tp7swPH/XxpGxTpuZH2OqCUMOwmmM3KlRGDchi17irjSQYtRUkD2yCO/SpmWFh
 rlTG15ekjD22jQbOva2vxeu5MqPvYosuFcdztT6RW/h6Scugu1Jekkii4m/t7J0RHpiQ
 1G1cgMeFFOoX3blkClX6d2sYwJSPKzKnHja6RtSLVV5xHq/6+Q2jkVLs4BojwXOkDLhg
 LpzCgOprT5pY40eaw1kF9rm/5fR4wVTMiKPJPUf088NeqcpN36TXjWhr0PGzfEEhMIUD
 ojpw==
X-Gm-Message-State: AOAM5312e7G5EVZPAF/Yl7zId7GH7eyFPh+RET880ngL6zhGlMI8r7hr
 /JX3vqHVm29QAyKH9Bq0Mh0jbts28gEdvA==
X-Google-Smtp-Source: ABdhPJxeHRsy5dAA1iYKi4mxjymB6XbfjeJZ1igdinqFlEjY7nzYbW2LIcSh8iUm3CRRIRAqczWUSA==
X-Received: by 2002:a17:90a:ba94:: with SMTP id
 t20mr16441598pjr.11.1624930087449; 
 Mon, 28 Jun 2021 18:28:07 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:7a14:49d8:be7f:e60e])
 by smtp.gmail.com with UTF8SMTPSA id u10sm15664815pfh.123.2021.06.28.18.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 18:28:06 -0700 (PDT)
From: Reka Norman <rekanorman@chromium.org>
X-Google-Original-From: Reka Norman <rekanorman@google.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Respect CONFIG_FRAME_WARN=0 in dml Makefile
Date: Tue, 29 Jun 2021 11:27:18 +1000
Message-Id: <20210629112647.1.I7813d8e7298aa1a1c6bee84e6fd44a82ca24805c@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Jun 2021 10:52:36 +0000
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
Cc: Reka Norman <rekanorman@google.com>, Will Deacon <will@kernel.org>,
 David Airlie <airlied@linux.ie>, Daniel Kolesa <daniel@octaforge.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Huang Rui <ray.huang@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Setting CONFIG_FRAME_WARN=0 should disable 'stack frame larger than'
warnings. This is useful for example in KASAN builds. Make the dml
Makefile respect this config.

Fixes the following build warnings with CONFIG_KASAN=y and
CONFIG_FRAME_WARN=0:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3642:6:
warning: stack frame size of 2216 bytes in function
'dml30_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than=]
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6:
warning: stack frame size of 2568 bytes in function
'dml31_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than=]

Signed-off-by: Reka Norman <rekanorman@google.com>
---

 drivers/gpu/drm/amd/display/dc/dml/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index d34024fd798a..45862167e6ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -50,6 +50,10 @@ dml_ccflags += -msse2
 endif
 endif
 
+ifneq ($(CONFIG_FRAME_WARN),0)
+frame_warn_flag := -Wframe-larger-than=2048
+endif
+
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN
@@ -60,9 +64,9 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
