Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AEDC7EE2D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 15:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4774D10E365;
	Mon, 22 May 2023 15:59:19 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C74A10E35F;
 Mon, 22 May 2023 15:52:49 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-76c64da0e46so76710239f.0; 
 Mon, 22 May 2023 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684770768; x=1687362768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OwP8XjPQvqKW6xBr4Aer+sS6LY6nG5MbxtpxV+9HcUY=;
 b=X1C5PR7OBPGQCgJeInQRtolY+16TDR0e9y+aXVcl4Jay+gJoMyO1YJuxDuH9ImE1cE
 IVAbKokBQmTIaTL75hJ9+LFxM9ABAln8+uKJLbsocGNXPoJTalFS+7XR6NwNR6e1b78U
 avZyV4HImz5dfs7/Ib6N9Q5U9UOFbgeYwedMvfgz1tGFcUFO+jOfSBxgnz7ITeel4R0N
 uEw3itrdiaesjXeRvUUqFl5dkLUaTFlP6VB8ZhXoixq89hAHpW9yxNx1v8+3fTClvI6f
 uKb7dMaW7JZZG9vsQcSNkyUngfI5YsL2gJBxZXr+s2IKWGCuuOPOOtZJ5BEOnukXDtex
 uVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684770768; x=1687362768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwP8XjPQvqKW6xBr4Aer+sS6LY6nG5MbxtpxV+9HcUY=;
 b=W3qK97mTWD7Dk/zgpaG1/kPDFwNe9nTwSwNCljTdQaYnR4VFRVM/n/R8ipCQFcPRqE
 cma5TS3er1ZsUSkTkCHC6/mcgEGNLuZBibWQrwURSmN9kTsxOJLWVMrzff/WgkhDCtmE
 MykT3CPkFX329oOU1s2Yk0aM7NgkaczU41c193JeMyZD+WEGm3V45QsmD0+bdew/+xq3
 sPNSvR/6k072bTjPkqfkxrBupTp5NKy2Knzap7kyxlEEvq6ImnkrMg5zc9kZeP6DcGSg
 aK2CMFMkAbMemtgpxmPiPHmjhvaxyOSmsBwlMp5LVrFHmfRPGvq8Vp/PoCnN7TaVmB/w
 WgOQ==
X-Gm-Message-State: AC+VfDwWbhh3XQTmu6jZVupgMJVeqgu1E+BYeOhSrv6fXzyEeDN+r59q
 R2itF5itvDHER7rgSY5pPes=
X-Google-Smtp-Source: ACHHUZ5G3QAr2j++n+RyksPqWsnu8OAn7GpwPYHS00q3/2krEKpXMvD4hLOEY5pAgdonIAEEU/YoQg==
X-Received: by 2002:a05:6602:2188:b0:772:af3a:76b1 with SMTP id
 b8-20020a056602218800b00772af3a76b1mr7076407iob.21.1684770767849; 
 Mon, 22 May 2023 08:52:47 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com
 (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
 by smtp.gmail.com with ESMTPSA id
 az11-20020a056638418b00b00405f36ed05asm1729252jab.55.2023.05.22.08.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 08:52:47 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Evan Quan <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with strscpy
Date: Mon, 22 May 2023 15:52:45 +0000
Message-ID: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 May 2023 15:59:17 +0000
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
Cc: dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Azeem Shaikh <azeemshaikh38@gmail.com>, linux-hardening@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index d3fe149d8476..81fb4e5dd804 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -794,7 +794,7 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 				struct i2c_board_info info = { };
 				const char *name = pp_lib_thermal_controller_names[controller->ucType];
 				info.addr = controller->ucI2cAddress >> 1;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&adev->pm.i2c_bus->adapter, &info);
 			}
 		} else {

