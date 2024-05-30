Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ABCC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 13:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A41B10E611;
	Fri, 31 May 2024 13:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2DIovAax";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D6A10F0AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 14:58:45 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso620395ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717081125; x=1717685925;
 darn=lists.freedesktop.org; 
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=l5khecYMdKDHw89iJpsW1yiXKEfGunwm3+6Z9OsK0so=;
 b=2DIovAaxXcJxRMtoXLypgyNj/JUBbTFUv3kkF5ToH74UPXxP2PiA5wlyZXAjvYPsZC
 9is7ToVyyDiGVc0jcpvG8/PFEMhR8cNrtrSi7K9LDse6wi4Ikv7Y2l1sMCZg/uBK3Ti8
 WRWqABouoFyneJz9Gj8bW/i3zK9Cv2t9oepQGWaIqf7JrSHLgfyUBa2knA5XxvVp1zWy
 lBrpTkI7KuWu0VovPss5tlEghp5uVrgDh0i3oSg7sDnJgI4HTIxtVqBx8t4kfbLr/P9D
 G+Yl+CHYr40+xzfeiPsRM7JaNFDsjBUGfkgutZUhAonsR4cgzprUR+4p3KkgNA8gp8WB
 yEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717081125; x=1717685925;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5khecYMdKDHw89iJpsW1yiXKEfGunwm3+6Z9OsK0so=;
 b=amKTb6FjhaTcUW+pw+qDcV9lhojEInxOu3YW6hmOprFg308BYsikEMIuPbU6L4WxOt
 qSRd2OH5ogOwRj1UdrbjJutEIHuphqMmDm4DUozJ6UX3zxgXC8+4TFm1JsOLdf+gewmv
 PeMtj+AW4mPuDWhNshMU0wT/o+G8qHH02HiE694PUOP7uR5I7EQlLotFHXgK4bpTAxWO
 a2JprihrPx2Vpb06mH45aOU3tE26NWBf2FR0i+K70M44MSa8jlzwGRYIR3VOFdErCmYs
 OKd2sUmoKNxl1aHX4TQD//D1jBjiZ4XCE7G6nG0b4vlEsdkA1jleXx8uCu079AZgirpd
 KEBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3LFTSHXooRBYVlBbGULQRD3MfKcQoF+KegQnK5zaxHsghsqBbkvIW7jGsnzaJZexTxT+OrBAxyWzdGS2UeZq03C3yAu/wZqE7f3EKhQ==
X-Gm-Message-State: AOJu0Yyjd84pgfaKVf+erha02TZoi2WBu9yPVa6EKZoivZYUroxI4YQ/
 lesqzXriSTmcYsq5j0cQ55Z0CwyKNccrVSOQtbLYvi8phG27SsIuAuQoXBYt9LA=
X-Google-Smtp-Source: AGHT+IEKvEjoLbbrN4JdqK6X02tKZ1Vg/fjeNLYXxvvVYtupVhUWAkZyf5sli6+XANrywg1P87S/sw==
X-Received: by 2002:a17:902:ea0b:b0:1f4:8190:33a5 with SMTP id
 d9443c01a7336-1f61a3dd9ebmr24276305ad.56.1717081124823; 
 Thu, 30 May 2024 07:58:44 -0700 (PDT)
Received: from localhost ([50.145.13.30]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c967975sm119659155ad.152.2024.05.30.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 07:58:44 -0700 (PDT)
Subject: [PATCH] drm/amd/display: Increase frame-larger-than warning limit
Date: Thu, 30 May 2024 07:57:42 -0700
Message-ID: <20240530145741.7506-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, Qingqing.Zhuo@amd.com, 
 nathan@kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, hamza.mahfooz@amd.com,
 chenhuacai@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: alexander.deucher@amd.com
X-Mailman-Approved-At: Fri, 31 May 2024 13:36:13 +0000
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

From: Palmer Dabbelt <palmer@rivosinc.com>

I get a handful of build errors along the lines of

    linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: error: stack frame size (2352) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
    static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
                ^
    linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1724:6: error: stack frame size (2096) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
    void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
         ^

as of 6.10-rc1.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index c4a5efd2dda5..b2bd72e63734 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -62,9 +62,9 @@ endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
-frame_warn_flag := -Wframe-larger-than=3072
+frame_warn_flag := -Wframe-larger-than=4096
 else
-frame_warn_flag := -Wframe-larger-than=2048
+frame_warn_flag := -Wframe-larger-than=3072
 endif
 endif
 
-- 
2.45.1

