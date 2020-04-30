Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6488C47253
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD0B20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceBCHW+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD0B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C246E94B;
	Thu, 30 Apr 2020 18:37:42 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA056E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:40 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id x12so5880203qts.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dDv5JROJgboJpalP476J0pcMmzXb4vLutNZ5qsRkZ8E=;
 b=ceBCHW+kf25xVQ9WXkjOHRtX0/wbV2AOpsd01oj/Z4y9xyx11AJP8Xo9GGj/s3i9XQ
 J2SZyaTmJQZIJSAC5TUatZ+7UFhPBA3KRRDNLukF/90DZE/+kRgK8F7DgAwytbmgAiKO
 jRLUYJewZ3V88ljkgG9yAuCAebCeMuFVqFpOzjKU9EmtXbXEvE+662XUN9hc3nOxuLXy
 mCxFLyMVD5G8kJ907ZgQp00ibdLTmLyqtDKX2fJ4CV2o6kM4der7ebgP06uQyZ5O0Hdk
 H6loW5b0LLqZQ3KxsYik3QuAFHn2u488CN57MJV8DYGit8FOQUygmPc5fPQcwN801TrX
 oGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dDv5JROJgboJpalP476J0pcMmzXb4vLutNZ5qsRkZ8E=;
 b=C3s233sFwWNN3BryfhMpqsnGJnvjQ50oq52mXiIkxrQ1ows8jaXwrqu8aFPOws2EAJ
 7zD6JP2dVfxFKOyt141HQnaAMl2RpUfF5KfxqisY/lvPhMRkZZ/r4Cy3tmtXUE4UdB2V
 VSp4KNVE+MJnMLpccu0+coQ3SN3icY+VYTzyL+PZOVeXdEdfCF2piSukEbG3scRZYuph
 IfsE/ikcNsx3TsJWZb60xzMNEw+2XEgz3qqeQTAXAuufDFLnMzDQVDbLjHftH8fN+23f
 tKEnUkYooYVErjyVZ2XbXCw5NGeWHSJvJUhp5+8ggQxMcL+ALxTCwr+mXQ0Cho+JqHEQ
 Xfzg==
X-Gm-Message-State: AGi0PuY6t7IBJt73bb+ePkQqALdO5ULwXlUZUrBY2rcdLWTaSRpF7/EZ
 MKoa7XEFP+skW+fXlOAGD1kzkoPM
X-Google-Smtp-Source: APiQypKijNdstvErihPp33d6B5C8LH7z9lTlnf+kNt81jr62DkEBKVh8QUaJbAdRpcHVBQHUYaktWg==
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr5157448qta.80.1588271859710; 
 Thu, 30 Apr 2020 11:37:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdkfd: Use a systematic method to calculate queue
 mask bit
Date: Thu, 30 Apr 2020 14:37:18 -0400
Message-Id: <20200430183719.419549-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200430183719.419549-1-alexander.deucher@amd.com>
References: <20200430183719.419549-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yong Zhao <Yong.Zhao@amd.com>

The queue mask used for set_resources always assumes the queue number
per pipe is 8, so KFD needs to align with that by using function
amdgpu_queue_mask_bit_to_set_resource_bit().

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h            | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index a501026e829c..3f2b695cf19e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -149,6 +149,9 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
 void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd);
 
+int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
+					int queue_bit);
+
 /* Shared API */
 int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ae9547791813..e9c4867abeff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1089,7 +1089,9 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 			break;
 		}
 
-		res.queue_mask |= (1ull << i);
+		res.queue_mask |= 1ull
+			<< amdgpu_queue_mask_bit_to_set_resource_bit(
+				(struct amdgpu_device *)dqm->dev->kgd, i);
 	}
 	res.gws_mask = ~0ull;
 	res.oac_mask = res.gds_heap_base = res.gds_heap_size = 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
