Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775EC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F25C2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8c6xmGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F25C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26056E372;
	Mon,  1 Jun 2020 18:22:57 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FC389E35
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:56 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id g18so8453667qtu.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gvwad/ys1zXMbYFnphvcykZR2UmMH/gYV8Z0KLJ4qH4=;
 b=P8c6xmGE8R3sXV8FuLFzSeoW8SomCTks8sgFG8GkjqbaFIRELXJGvJcjffyAoYiFUR
 tPruO49dDko9i9I9foYvaslt6mahmqKlZu8PSIJpjuJ6bQa4Z2CJZo4CWr/W+c78ozrM
 Yv691s6bWkVNjRn349eetPF2nMlunfTJngj01uoAmAB4XjvjVVS1660P9IQ7k01hvvvV
 /qm3DR1nphF5601dugjsopVVuL4qxPVfmtmEMYnHB4SYho4HqeGRG3jWNtDw+mGxkHb0
 HemfphHozQn8G5kPBATNrGdogEW8Eg9iPCFrzo1SOg4O6BBhSpTme6oMYpqTT/88c2+Q
 N+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gvwad/ys1zXMbYFnphvcykZR2UmMH/gYV8Z0KLJ4qH4=;
 b=KLswQdyD6DxXcM+xJmsVo7fVPJVvdB6DpvPVytzVE3dZurAf841GQtUV2ycc6UstUS
 bxbDSn5I7Fypbp2auxqFyW5oMDtbWiY9892reJ7W78f47NGjAop64Ka+olMw30Eww3RF
 j8PCeADG0cBsaLrPuE+dVu8QPWzf2EanJ37yt8158yQSLGRtEFNBNOpDoSTSXS0HnKyC
 IuA02gjYyMzkWrf2QyFLyG+lrEx01RUBydIxUPi3YJjaIfNi4BiEt8lBTDVxCxVgNoHt
 F+w6/EpxzcMaEA1XoBiWwYipBvwCIo03/lQ2FxWSPRs588EHx4rMBSr523RW4DAEtSO5
 x8ZQ==
X-Gm-Message-State: AOAM530toND0ATijn8zCg/jrDKfoz8b/y8a5YveCfjBmwumLjgv5en2F
 h8KUg0MGIl91EGDxtg2zdQL8p4xv
X-Google-Smtp-Source: ABdhPJzLTiTmPb9kDuIFbtwJWHzriKDwV3DXY375hCPTkFdwItOoPRAP+HKBmVBTl0LD6FvW2BlKKQ==
X-Received: by 2002:aed:21af:: with SMTP id l44mr24137986qtc.124.1591035775601; 
 Mon, 01 Jun 2020 11:22:55 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 174/207] drm/amd/powerplay: let PMFW to handle the features
 disablement on BACO in V2
Date: Mon,  1 Jun 2020 14:20:21 -0400
Message-Id: <20200601182054.1267858-85-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

For Sienna_Cichlid, PMFW will handle the features disablement on BACO in. No
need to have driver stepped in.

V2: limit this for baco really

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 24 ++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 870fe32437b6..343139a5c7a6 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1532,6 +1532,11 @@ static int smu_suspend(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 	int ret;
+	bool use_baco = !smu->is_apu &&
+		((adev->in_gpu_reset &&
+		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
+		 (adev->in_runpm && amdgpu_asic_supports_baco(adev)));
+
 
 	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1549,15 +1554,22 @@ static int smu_suspend(void *handle)
 		return ret;
 	}
 
-	ret = smu_disable_dpm(smu);
-	if (ret)
-		return ret;
+	/*
+	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
+	 * on BACO in. Driver involvement is unnecessary.
+	 */
+	if ((adev->asic_type != CHIP_SIENNA_CICHLID) || !use_baco) {
+		ret = smu_disable_dpm(smu);
+		if (ret)
+			return ret;
+
+		if (adev->asic_type >= CHIP_NAVI10 &&
+		    adev->gfx.rlc.funcs->stop)
+			adev->gfx.rlc.funcs->stop(adev);
+	}
 
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
-	if (adev->asic_type >= CHIP_NAVI10 &&
-	    adev->gfx.rlc.funcs->stop)
-		adev->gfx.rlc.funcs->stop(adev);
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, false);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
