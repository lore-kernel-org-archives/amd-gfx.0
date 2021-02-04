Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B1C433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A273364F5E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273364F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445A86ED9B;
	Thu,  4 Feb 2021 14:43:55 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632DF6ED95
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 14:43:52 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id d85so3480372qkg.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HbOlD/F7aTWBmjH1vy/QgZw5JmbopbNkzaT2mp9v68g=;
 b=BjNHJ9D3skcU73bGslGkdfzlHsvg8osYjAefoOrnUhdrZ1Ex1sr2xeUTUZKvjbfPq4
 NDsYfRFVIMK/8RIathhuFxr/n+hSuhmnQEJ2BkDgOAI8qoPBc0JRdKs2hBb04cBVilUS
 WOMnOEZ8uhrDUCZZgQ4HQnOcLwntOB0l8I9HeaYFmofUh4AFpfnvsZ6otqXKcLN7J+eq
 COFgzpM2teJkxSsZNDhjAKNHjf+E8W6jtUtls9Xhzlj1j2hRqxu04MUCPf6n1Fu5AVJX
 o/VyBepAPUzzD6qIIyKO7CrE1WLaURcb6oswaD+wKuPEWVfmc4rj43oRJ0VFHv1dyfyZ
 dUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HbOlD/F7aTWBmjH1vy/QgZw5JmbopbNkzaT2mp9v68g=;
 b=MvYEeUT7H9MJ+nBnD25MyAtOKuA93GZhUrS7SMy3shUnFS7VIk8Csa4C6L3SfVQaDa
 ytlKdunLmJGe+iWLZqqRiQK1rYosegHIfBGi5d53M1zfJBbrHmB/hFc+lLprFzJwpmju
 zMd+FqKgzrTLtPPop2+0YpmlPWx5IGQrmZ2PTSPxj6Y41TJaEJekMlW2ErTD5F4F3y51
 wQx7wbtlETX5jOBxZJrd1eQqfrqzeKqjMcfj6hN7S2udcEOgnshNWm929RcoPnCGQ0Ef
 QByUqrt2BhD2elzj8A6b6dF1f997OkiG7wdZOa0/GHxgOOUAttsGrJI51bUZ2MExBCFu
 3New==
X-Gm-Message-State: AOAM533v5XuOaFFz3m68ROA2fuWXHuiwanfDhlt/PFgC2SYwoPFl/nPE
 3B1okO2IMQmTXEX4WgwrlsOB9mxDGNc=
X-Google-Smtp-Source: ABdhPJwf573VBRaX9LEq55/h53KaQr6lh1yhng5Yu8QTxAxWJYFmI5JLylSlxMYIAXTK1fifSH+QgA==
X-Received: by 2002:a37:644e:: with SMTP id y75mr7684348qkb.134.1612449831475; 
 Thu, 04 Feb 2021 06:43:51 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id q18sm4735488qtr.74.2021.02.04.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 06:43:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend
Date: Thu,  4 Feb 2021 09:43:28 -0500
Message-Id: <20210204144329.52506-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204144329.52506-1-alexander.deucher@amd.com>
References: <20210204144329.52506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the flag used by kfd is not actually related to fbcon, it just happens
to align.  Use the runpm flag instead so that we can decouple it from
the fbcon flag.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 151c649e4d11..053e134b1245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3722,7 +3722,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 
-	amdgpu_amdkfd_suspend(adev, !fbcon);
+	amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
