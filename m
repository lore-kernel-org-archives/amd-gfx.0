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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 20:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2755764E35
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 20:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2755764E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C839A6EE63;
	Thu,  4 Feb 2021 20:05:01 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355426EE63
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 20:05:01 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id n15so4616292qkh.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hat+5qMxK/YW75busIYe9uJl427/84XduJWjrFaUwCw=;
 b=UCcnpz/1mz6Zejkb6IzFRMcanywj/4CGzESoFhboqdpQJWjNfjze1RH0fvpCuofR3X
 a2mu9Kz+dXQgwt0TttssnlDBlj+qBVw939m5//IzwZr2DhscraXiJGmab60+ysJPAGwM
 6cd7T7AlFQ+fnIhyp+6oE8NQeWSTEfoByH6dMTmtN3LXTSqztXsARwb8F1uibQYebBsc
 wWI/fNSN3gBFxv9HNB6NgoWRQQIMIlQAPvp+/XoGe6/62Vl9AJoQbeCydGDSod3zkFV7
 t8rx+6v0oDFTlYLkQgR0yawJOgDCGNdEfxzkOe7QjQAFeN44IZ5aN6/TkFjbVUy9a1kr
 fcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hat+5qMxK/YW75busIYe9uJl427/84XduJWjrFaUwCw=;
 b=HyJuwhspSFPBeNnD7gYYpWcnAwzWnT/CCD1rL61h9XQXeFXR+pBYhb7KLJevPxNFiu
 fNIFWxIhs/rl62XdYg8b11VAwNlbPEaIaoCxb29oQil1InAtKC1LN31rpJytmZmgMk5t
 0rzZJjh+ktrYIGmERTReeCfCGwXRtEMss7rBzJzSM1/EPRgWjDfJcVIDLQuwT6V6339y
 BlumTSVj6ZhHcEzkB9WxcH7IvNomiIDBtvdWj01BaEkloc2e2zxD3fZX/oA2ntWtbzTC
 cDXcNMkZ5iJgM6XG/mJ6kY2CS7DCLiVjuD9OkBatDWgbQq3iJSi1zoRe8ymYJHog77yq
 4guQ==
X-Gm-Message-State: AOAM533Cg+TemHT5j3gwK8wdU1Yx3qf6GVRBCU8Qo5hzmubixMhQLdMz
 rvYhQr2uW6orB21d1JDJ2xN45hTrBI4=
X-Google-Smtp-Source: ABdhPJw1VHMePfzC3al06iqqK0OPEzvswJROWtzlaeOJvm9Fl/HHHzFRMqy2HLZn5tGG81Cfhr5KJQ==
X-Received: by 2002:a05:620a:1111:: with SMTP id
 o17mr937972qkk.122.1612469100292; 
 Thu, 04 Feb 2021 12:05:00 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j11sm6270714qkm.47.2021.02.04.12.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 12:04:59 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend (v2)
Date: Thu,  4 Feb 2021 15:04:50 -0500
Message-Id: <20210204200450.1900-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

v2: fix resume as well

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0ee6514ee55c..b7ebd424bbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3734,7 +3734,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 
-	amdgpu_amdkfd_suspend(adev, !fbcon);
+	amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
@@ -3818,7 +3818,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			}
 		}
 	}
-	r = amdgpu_amdkfd_resume(adev, !fbcon);
+	r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 	if (r)
 		return r;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
