Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E0AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 09:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D8D10E1F9;
	Thu,  9 Nov 2023 09:48:57 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F182710E1F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 09:48:54 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so972833a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Nov 2023 01:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699523333; x=1700128133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zI3JAeZLlSX/PMhrIdaWaAEe3wMM8uOfVKj+q3rvDS0=;
 b=REovOceRqFW2vsASeQmHAjzxDFgEkId+EhsTD5/8wG/nd1EXOxsN6MJAfNE48IYFhi
 WaP/JiV6Pg7TaEyrhhRGJt2wCVG0lkz3d0Kav0Xpmr0nI9fTMTmzDLZ3mAbnh3KahNB0
 IwmaYkPB+scVoiB6PqLz7hO9gLcYMf9OxeciRNSA4t7RMwISDBkj+AJ35ghq1o+Zntcy
 e8QRJfuZzXPxMWnLBk39+RI0YG48JRLGxaX/TmZp2ok1tS5dW7Ogqaq2CZQjiu1IKLBC
 siVG+fnq3xEOtzEKUeLMzY/yFzmmjO/itKOoFZgdmjxyNCdLjQmuIcKhAiTTDjQ5YdaY
 jDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699523333; x=1700128133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI3JAeZLlSX/PMhrIdaWaAEe3wMM8uOfVKj+q3rvDS0=;
 b=reymwxRHBwB9jJVbujm+q6JleJOF5wtP04/5cWV9zCFwF/LKLhf6y9B87mY2wxO3pj
 5/NiLDqSPsMUpYAoLbS4s8dtLUdJdQ+Rhy1N4BHB/pWMTyFdx3mfTWjMcWd65xkUkVxE
 TZpNjcA5ax9a3IML83LvkiJas9iYslzXn7fzAJqL9yC0QFbGp8+IPzNTIQSl6tIlL+Ag
 akHb9ZOsqqKOzsVL5mNOeqyYM6GxNO642vIZqoKGmU1bwCg20ho2utf21pt4g5CHkLr4
 Ac50k7+Hlhr2H1QCQ0Ruhr9XoAxL27z5FxJm03CgehzVIfTuBS/1E9CrWZV5rE8StxBk
 kYTg==
X-Gm-Message-State: AOJu0YzkEP20o5PShRJM4HxTuAnHUUtjC9JoAp7zk6HdoeQln2axNdfi
 vDJ8oWUFgIJvJ+LFRlzRwdzvuZudU65KUv/V
X-Google-Smtp-Source: AGHT+IH7c6KRWVRrI6jkP3EoIruORsBsZvxFrd+YGcqVq3Usa62V0axotUja4U/ILyawCgewNBLrIQ==
X-Received: by 2002:a50:cd57:0:b0:543:ba03:9b3b with SMTP id
 d23-20020a50cd57000000b00543ba039b3bmr3580221edj.25.1699523333166; 
 Thu, 09 Nov 2023 01:48:53 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1516:6100:36ac:9121:5531:de23])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a05640208ce00b0054130b1bc77sm7792401edz.51.2023.11.09.01.48.52
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 01:48:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: lower CS errors to debug severity
Date: Thu,  9 Nov 2023 10:48:51 +0100
Message-Id: <20231109094851.674657-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109094851.674657-1-christian.koenig@amd.com>
References: <20231109094851.674657-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise userspace can spam the logs by using incorrect input values.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index aafedb344c1b..af844c98f295 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1442,7 +1442,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (r == -ENOMEM)
 			DRM_ERROR("Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
-			DRM_ERROR("Failed to process the buffer list %d!\n", r);
+			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
 		goto error_fini;
 	}
 
-- 
2.34.1

