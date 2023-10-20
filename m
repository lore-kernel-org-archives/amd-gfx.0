Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E239C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 12:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA70510E5B6;
	Fri, 20 Oct 2023 12:33:13 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F3710E5A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 12:33:10 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so535505f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697805189; x=1698409989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ST2Sa6qHFKtFW9lOjwH6LlA/sU0BPX1moCeU7bOcVp4=;
 b=N2LhV9HDCVp2TLpiRYoK69mo6hLmOetZ6E587C9v4oS+uIVISmt57Bk5HoYOQNqulK
 4pjMUjOTcbj9I/V0XR1jwW1XdFd8hEQbSJCGCJj3tgsfyOux8A7BJTs8KSHBp0awJAU4
 174dJsS5/Q8hbQ9mqnBubsn2VR89/jq25PB19qo4iwmXvop3ScD6ga5/4mYUbDih7cPF
 eUv+oY6NiKZK8ItiR1dqSngU2HCrVKgA+cwycX9RNGXIyaYTtWAXVDdlHZaKJLNiAJjL
 y2S1nuZb0eqGxNx9pCWBn1ndbjxQYNWs8wxU1U7O5rj34wZy3CLp75hi5V7238uHusE/
 ducw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697805189; x=1698409989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ST2Sa6qHFKtFW9lOjwH6LlA/sU0BPX1moCeU7bOcVp4=;
 b=hu4i0wEFS/GfqeqzsPhkMbkvTG+/pkCNm/Li4hFVXZIY/FsSEVBGpMEXqkMBZkSjb/
 eijKox/tTaljmZXQEUDm6ic76wiUOeAWvPV7B4vvDA/kIvFr1TXRtVrPVgoDT+20YfwM
 LEZlU8fbt2kVD6ImbSwX8ZfZP5eTxX8kxSw3VZbdqU2Vx1ydSBZnKoL0wCPZHc17HDvh
 D9iOwGppO5+IRRt/JuLK9cPLgG3ozlUcThkz4ejuzLgGcY2AGq0A73BCHq/txmEYVIKj
 BYIxMurrdx5q70CbP4uxbAPorF1yAIHHp76KkjlzRRJskBKxBhO0J1tEtf8s0pNMB8r4
 JKQA==
X-Gm-Message-State: AOJu0YxHZpCgqHtPi47Cl8JkVH3jhtuPCPI0kvkarYXX2zG6HeUzu2bV
 qddsqRWMAVAXU3j3ngo7z0OOBhL1H73uNQ==
X-Google-Smtp-Source: AGHT+IFocB64hh2VotN24T6aZQAiEHerEdD5Iawv1X/F2qAtyt/FBgGBv1YCZb89v3qaaZ2wdmmnoQ==
X-Received: by 2002:a5d:670a:0:b0:32d:819c:5da6 with SMTP id
 o10-20020a5d670a000000b0032d819c5da6mr1080666wru.21.1697805189234; 
 Fri, 20 Oct 2023 05:33:09 -0700 (PDT)
Received: from EliteBook.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d5272000000b00323293bd023sm1626273wrc.6.2023.10.20.05.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:33:08 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Yuliang.Shi@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: reserve a fence slot while locking the BO
Date: Fri, 20 Oct 2023 14:33:06 +0200
Message-Id: <20231020123306.43978-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like the KFD still needs this.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 8abc1eb2987a ("drm/amdkfd: switch over to using drm_exec v3")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7d6daf8d2bfa..e036011137aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1103,7 +1103,7 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
 		if (unlikely(ret))
 			goto error;
 
-		ret = drm_exec_lock_obj(&ctx->exec, &bo->tbo.base);
+		ret = drm_exec_prepare_obj(&ctx->exec, &bo->tbo.base, 1);
 		drm_exec_retry_on_contention(&ctx->exec);
 		if (unlikely(ret))
 			goto error;
-- 
2.34.1

