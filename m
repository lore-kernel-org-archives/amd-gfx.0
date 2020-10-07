Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E9C4741F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882402064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T25vxt20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882402064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8C56E95C;
	Wed,  7 Oct 2020 16:32:16 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4F66E95B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:15 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id j22so2395391qtj.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jzBBcKoRa6HCKMJoi6QM7/xAPKNDpw4I0Ie5Y9Fl6u0=;
 b=T25vxt20bg4ELsqZWmWNVuLT58EqRn6TUFdkjFMDvRUG3RfbieRvn5tFyDXNshJlST
 phwNNK7CU8tRd5h+Z9MjFtn/EMZSxdC4G66H2XQWMvFp1WGxzIbGhRqeB84FCn4Wtqtj
 YK7OgA59omz1nLfqHt61F8fH2G/GG7LEiOR5KLT6rWewQAl15ML9BKQKWpOU1fM4XkIe
 GplKH2iN/vkvxIDO72ixcBDOlUzyBi0RaZbWyzwikwzA39YAr5JV6NaZCW9PFkxUVWaY
 vDyRgJRM0ZdV6J8tkT+g0CRt4wRCdKvYenFw1Yq6P6fjLt/59h9aa6DAD5VwgwDk66K2
 RcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jzBBcKoRa6HCKMJoi6QM7/xAPKNDpw4I0Ie5Y9Fl6u0=;
 b=Zq5/ny4zc/YISFw+dZGEnuXC7BI28jBPQN3x3QvOFUX/7JuuxOY0JBUAQB0koh04OV
 R65i8l3Ednu/Lr1WeqpK6SNrUroytrXmiMv66OlvbeDFJPoOqcuSj0flK97aA0q1GHEw
 fVXxbqCc0L+N/rmHLHmyYZidV26tybuzA4hyDvnmcpPtndLKuGlYmBjJsZC/UYTVF0M7
 ljbMGD+qhPOQn5v0LxvXqsftWuvl9CF5T1vDRTQ/+Fnmbs+T0mRVAFHwj75qe+suMu4N
 H6CKCXpKtR/UKV+nUs6OUviospkRhBlKzN3RIUUQTFQ28iM5tp9hQZnRNXPrIcXQID+g
 RnvA==
X-Gm-Message-State: AOAM5316juFz6nXDqjVkUUvHrvm/hhf5CJk6vv89l+ftq9eNF52EpFlG
 CMHkS8vGQsLGnsH8mgwDu0WhYQfCkRw=
X-Google-Smtp-Source: ABdhPJzC5ozZ8LT26oJFZve0VfOVG40ukSd39vrZJdgrbyVN8tPlQOy3bG6oNNMpLxlW0k5LQJU2Zw==
X-Received: by 2002:ac8:1246:: with SMTP id g6mr4106955qtj.353.1602088334011; 
 Wed, 07 Oct 2020 09:32:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/50] drm/amdgpu: add virtual display support for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:02 -0400
Message-Id: <20201007163135.1944186-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add virtual ip block for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2974f45c4571..90ff9cdcb924 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -630,6 +630,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
