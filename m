Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07DBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 14:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2D310EBE0;
	Mon, 28 Mar 2022 14:12:41 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B4610EB59
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 14:12:39 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id r13so28954347ejd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z+zYhZ8Pkd+8m2VbR77DG4aHxzadpxmTKMDKQG9bXwQ=;
 b=p77WXgpeM11Zi7vHYnKqeoAMUhySnaewfkhul3YG4mgQuiB5BmDS9ZCZ5JJyTpUlbs
 HIC08nVmPpKWbgZ1MLCamXlkh9pWk9MnbY1D/9ppSrvQZZZiDQeDXEJahRNaRMGK4o1O
 nEFpCoHX1cbvurv3g1XScEQVxyw0zlWyC+l0j0JqOT4DOquGjb1Cap0tLbI2tPzgH1Ul
 gGM+kgoVSss5K8am1TKjjiCx8e5TqdNq2WEi4v4eyBd9ohwLd8VDJ4DQTRAsKqyU7Hl7
 T3unLFtFHlAvBXx23sqn0Kd5W9RJsZQ15u+VDbWNtoKtD0Fh0uat3djvYBP6D5srtysM
 5MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z+zYhZ8Pkd+8m2VbR77DG4aHxzadpxmTKMDKQG9bXwQ=;
 b=Akjc6IUslrjYDyhMLfJKTzVqlOWspMpKFjPIla7+H+UQKhbp7au7DPXFsHqI7k9hkS
 iFFLpiN8N0zDaAnjoUuDs13uZrTmMThSpST4HwD6KaGUD8Xloawg/xEK7fe3YsQ13WOr
 3RIsoPNHubGpTEHKJKzZSH++oLte7tNvrpp1T8+WleuMt5WQ1lLuIvRju6VpwbFfWP0d
 1atrB7YRFu/TNbBoChyljdb4oo/vVSi88Ljeq2iqmEq1s5BoS1CJQVanKLuR5D/pgomN
 LXk72f3AnwQqaF79cJXohWDLoabXPm4dvBGdkKSSZkgnldb2rgYuAMVZVsSurF2S3zCA
 6CJA==
X-Gm-Message-State: AOAM531nYReSzq8blTBQ1YWpsO9q3nXcGJRzxCnFbVHoXEwlpXSL4lW7
 7o3Imhu2eqovKO3hlZjzNY231pQje84=
X-Google-Smtp-Source: ABdhPJyTxPjeB5AWHdKRSPSaSWs9r1CpmSUsEM+TmhZTFzWMrASz6hiqSDWYyIgNxv72oQoCljwWMw==
X-Received: by 2002:a17:906:b107:b0:6e0:a25a:af6e with SMTP id
 u7-20020a170906b10700b006e0a25aaf6emr7071774ejy.359.1648476752461; 
 Mon, 28 Mar 2022 07:12:32 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 hr13-20020a1709073f8d00b006dff3a69572sm5896095ejc.5.2022.03.28.07.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 07:12:31 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix incorrect size printing in error msg
Date: Mon, 28 Mar 2022 16:12:30 +0200
Message-Id: <20220328141230.46059-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

That are bytes not pages.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ea0cde4904f0..f4a148917520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -472,7 +472,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 fail:
 	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
-		  man->size << PAGE_SHIFT);
+		  man->size);
 	return false;
 }
 
-- 
2.25.1

