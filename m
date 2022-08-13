Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC61C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 01:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3854FB0C68;
	Sat, 13 Aug 2022 01:28:33 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5C1B1859
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 01:28:04 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id b96so3262948edf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=q8BzUOG1zgjtFP7qhpQ3S2huvrK89VyejzoaWrfBkns=;
 b=KP+khmcVUIXMQCUa3pX8wHbgYX9DrRU6QJt7/CyToziwKp2oHfA32V8kgMBQlNaij3
 jdjADqf0ckz6gJ0e+oDqDYTt4WtW6Is565G2LJpRdTHpN9wQP/QMGmWo0VoRWC5YvPcJ
 zBUIHEmjIuE+FIi2a+XxSBwKOmaLYAU41KI3dgPIPg42Dp1bdVFrUYMHr4EsTxZ5Lk5S
 pS8w80/HpvazJd1/aE7Akc/VbNMm5ZR8HtWgEDlpI5nEOWOG58OUf7msNg0XPjB7C7gp
 JXas5/nRgZ6lQRE6h4bPlJk4dtpgAMnoCqx5IwWuvs/WjPmsehrPIscHP6dl5nm3SnYb
 zJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=q8BzUOG1zgjtFP7qhpQ3S2huvrK89VyejzoaWrfBkns=;
 b=GsWVBGhO1Peu5IhRcypA3rVK2LU3BDaDObRASKkbWniVl4I+mX9qdvLN0ilq7jpDyO
 76LaaUOjU38eMWhtAZRMayayLpruyh4TkPfWZTFYNcNyN5zuopRJ/11a/xM7fYy/2bkQ
 mrl9O7DFfMFqMbsss+zAxkVaRQTEbA6VakAYmXxAZgu2Sxs5eo9Q32S29+4HmEMYN+0i
 SVmZl096aRo9vqRTh/JvF+JObsDkGEXQ3XGjBnJiJsQ9hQN3vgswI751atW4J6orjiBf
 TjRx4rxx3zjALFPD1RoCMts8ef/aFXlIzq826jhlVhY3b9KmuF0sbRQk0n+CsdQhbFgc
 /xgw==
X-Gm-Message-State: ACgBeo2oQRR+tjwAg4jRkoZyM00HJyD8bQx+swG2j5ZwRhLBwI0t3lDr
 z1ebpibHMBayC1eb4qcKlZ2gfA==
X-Google-Smtp-Source: AA6agR4hGgBAA0m1f7He5SbYr9WcLE97zoJkrnf97nj4YXPypMKIixDuWpiCElWd/ylj96n8/yaTtQ==
X-Received: by 2002:a05:6402:3550:b0:43d:e475:7d2f with SMTP id
 f16-20020a056402355000b0043de4757d2fmr5637439edd.166.1660354082143; 
 Fri, 12 Aug 2022 18:28:02 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id
 ot3-20020a170906ccc300b0072ab06bf296sm1342536ejb.23.2022.08.12.18.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Aug 2022 18:28:01 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu: Bump amdgpu driver version.
Date: Sat, 13 Aug 2022 03:28:01 +0200
Message-Id: <20220813012801.1115950-7-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813012801.1115950-1-bas@basnieuwenhuizen.nl>
References: <20220813012801.1115950-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: christian.koenig@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For detection of the new explicit sync functionality without
having to try the ioctl.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8890300766a5..6d92e8846b21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -101,9 +101,10 @@
  * - 3.45.0 - Add context ioctl stable pstate interface
  * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
  * * 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
+ * - 3.48.0 - Add AMDGPU_CTX_OP_SET_IMPLICIT_SYNC context operation.
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	47
+#define KMS_DRIVER_MINOR	48
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.37.1

