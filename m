Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA4CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5699110E4CB;
	Wed, 16 Nov 2022 16:01:24 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC7810E4C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:01:17 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id u24so27182853edd.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jXZxR7txebuE6mJuqrwkNeA50mGymdJ1FweY06K11Pw=;
 b=WkYbbWUnRQRFdeXJGTbmqzaL3Vt0Epjt8PY9MyZdzQsMivhntIYT2Se50/undD+oXl
 F7AXkr9PouKYVQRenawGKuXkSvEhYddmiDxS+s/pfJQgtiZVf/g6DQeZGdhMPwEfEN/P
 zjHI9BXp7UI3sV1acbqzH+ZprerWX4+6nhefOHfH1vzdg3tfckXszxsbZ+A4NbC88wpi
 V0LQEfWAg5xOgwWVOCJT8BQmECSrbFM23iDpywpdfGP+tErpdTJY0FmskpPm48N1mkBd
 DNZHLPzsZ2EVjl/DpjON0V8VbapqagXwk+iDwc/2ffksGXS13Zwk3Asi5yDQDk7Zubhm
 k3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXZxR7txebuE6mJuqrwkNeA50mGymdJ1FweY06K11Pw=;
 b=5a8g2KUuPjGVjhUKiC6ML+zygIGTnY3Y0uI80+U2X2z4qkwih3smYKp6zV4kB6/huu
 t3mnN66Xxg1+e+IACeHMD4U2d47ZHy324qwSxnw2j4bb//g0Fh+sWRXemveJCkF3lth9
 w+VvPmyaPKseg1dciylPYu62t0RbOKKc1993sFiLSy60Ez1nY5F+fn6FbqeDPsVvdg32
 p3ADLuSuhq+fZzacYpPr1r96j3hX3oEYEUgy75GE+fol8qjLh+BAdCefZuIhox8kPF6I
 0ERTNmSo553ttAtgHPQ5lTOQxHDYW9U+kFFFeMxXmFhnLMGqAItHI2DM3GzrpOvyaLds
 /otQ==
X-Gm-Message-State: ANoB5pnI4PhzTotIyaLIOO0gfnkPEW9lUbFbfGewWrOKt+ju0qHCij5k
 +p7vsAnc+cTfALsxYLNapbcj43HNTZg=
X-Google-Smtp-Source: AA0mqf6pg99Ra8YmoTF0mBFYR0o5TNKQROaJrc3fsfV7wyAZZetKGP7aNHgjU2FiK0XGjggjjmmLRw==
X-Received: by 2002:a05:6402:60a:b0:461:92bd:21cf with SMTP id
 n10-20020a056402060a00b0046192bd21cfmr18872271edv.405.1668614476141; 
 Wed, 16 Nov 2022 08:01:16 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 lb17-20020a170907785100b00734bfab4d59sm7139097ejc.170.2022.11.16.08.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 08:01:15 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com,
 alexdeucher@gmail.com
Subject: [PATCH 3/3] drm/amdgpu: WARN when freeing kernel memory during suspend
Date: Wed, 16 Nov 2022 17:01:11 +0100
Message-Id: <20221116160111.3226-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116160111.3226-1-christian.koenig@amd.com>
References: <20221116160111.3226-1-christian.koenig@amd.com>
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

When buffers are freed during suspend there is no guarantee that
they can be re-allocated during resume.

The PSP subsystem seems to be quite buggy regarding this, so add
a WARN_ON() to point out those bugs.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d0d53e83a318..063bf6f69918 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -428,6 +428,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 	if (*bo == NULL)
 		return;
 
+	WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+
 	if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {
 		if (cpu_addr)
 			amdgpu_bo_kunmap(*bo);
-- 
2.34.1

