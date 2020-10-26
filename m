Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD786C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 18:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7492087C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 18:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOPmEVV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7492087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A986D6E153;
	Mon, 26 Oct 2020 18:14:22 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE0E6EA64;
 Mon, 26 Oct 2020 18:12:49 +0000 (UTC)
Received: by mail-pj1-x1042.google.com with SMTP id l2so3481121pjt.5;
 Mon, 26 Oct 2020 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=5HO3BVg0bRzxOwVnCXHaH7lLzHwWVLX1pNvQSsPVR34=;
 b=rOPmEVV1mJNejym0bVuvH9D4QxMR/bgR/uiSbmV/sI7ehBqx9zE3tPQI3irbzRxDDd
 NVkrepuMoOB1w0rze3dUFqEABBGq17D70yo/wQS+XFRhJ1knlr0TapHWZeaLm0lLgVCk
 ajbJ95GkSBe22vslkDkxh0/mNDW9UCzxwEqwbcAtBcZ3rWDFT8cs/8wr40BP+cKqQAHf
 Xqaj+8TzKs8sGYoowwCqyFoKjAJxNF44AEdMxKebFyX5QZoG10rCJsWZXnAoU8L+BFA/
 TxvFoEMzVN/jfugVoIQqz07xC2kpg1KYm5gwFSxpUVe5PR3Uwti4rO2g8TWdiFD7Ja6N
 cmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=5HO3BVg0bRzxOwVnCXHaH7lLzHwWVLX1pNvQSsPVR34=;
 b=hXlSbc0VccIgVJs9qn0mJu9n/q1FBOEwjh40BYF3GzEXKhhD07Ew1vTkdgQTEjzT2V
 jLWFVO4Fi1pELUWl+Kge8Oi3b4gB9ZwgDsOvN6hnVIcS2SkRjazfxghTT3Tfu9YTkAMG
 6g75I3ExMv+IAVcqTvUFbzcovGuL6Q2BPihLbKo9/z0Q1mQi4ihNTILEffn2Yittjkn/
 Wgjt244F4j9bGuTwqXbcvwSVcyWIFgsljG+RtgTghFbKOykkE7DdQXcYpMOnuWdi4I0C
 LaSQemZ1nIEz5y9pQRNvVjfYSaMkrZnqurpxx+yQ22S8t1KCjjH6QhP0bgICPYhPkNcU
 +zpA==
X-Gm-Message-State: AOAM531SG8mKgF7z9x/owqeqHsTeNVIy9sJ53M3+tbjaFL20cY+2BmsP
 SJEKHrsSzCMusywKECEgACvLq0Na/UQ1XQ==
X-Google-Smtp-Source: ABdhPJw3MC9VJsJhf5LCjsccN1B3MXJSG0DukEpFAVyN8RH/TmAVMPOYgh2O/ngXwLl+nzdW6ZCrPw==
X-Received: by 2002:a17:90a:ca:: with SMTP id
 v10mr22381893pjd.18.1603735968845; 
 Mon, 26 Oct 2020 11:12:48 -0700 (PDT)
Received: from adolin ([49.207.196.21])
 by smtp.gmail.com with ESMTPSA id m3sm7813796pfd.217.2020.10.26.11.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 11:12:48 -0700 (PDT)
Date: Mon, 26 Oct 2020 23:42:42 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [Outreachy][PATCH] drm/amdgpu: use true and false for bool
 initialisations
Message-ID: <20201026181242.76bf3b6gx2yx7hr7@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 26 Oct 2020 18:14:22 +0000
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
Cc: airlied@linux.ie, Felix.Kuehling@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, sumit.semwal@linaro.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bool initialisation should use 'true' and 'false' values instead of 0
and 1.

Modify amdgpu_amdkfd_gpuvm.c to initialise variable is_imported
to false instead of 0.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 64d4b5ff95d6..ba4bd06bfcc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1288,7 +1288,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
 	int ret;
-	bool is_imported = 0;
+	bool is_imported = false;
 
 	mutex_lock(&mem->lock);
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
