Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC83C433F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B59227BF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MktB8KjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B59227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291C66E830;
	Tue, 14 Jul 2020 18:24:25 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063DF6E830
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:24 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id b25so13614564qto.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uzc+ABtnRXhr6HUcvJh7A5OEv0JAWiqkWbFvdtgXphw=;
 b=MktB8KjD8hvlqKG5phqOH5PR/oOvRFVnmyQAdhmJth/XuMtoquYWCOc2Fn6Iw6GS/y
 VwrhLQDfbvW6EvZCJcEXvCZ5kSeDlVsuQquOIok7OLJbSO5g38YlBlep3EAHsnoVH5yb
 Zdrfm33M/dctDsAm15kM6rmmuBtG9JifWfGoiPAajrC6fnoSCnifeNjrTxYC9uF6e4Qs
 anbZ+/DD83BloONnMg6Zvme8VKT+JrmS4U2ZNrcOKjO/thtP4PRc+MdA+0Hdmbx5exZI
 e9tJGbwsaWLLZPzkb6f5TU8iUjWAp6Z9YW9RQyi28pAY5Yoe4j3qT8EpTcZpIPCcttmj
 DEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uzc+ABtnRXhr6HUcvJh7A5OEv0JAWiqkWbFvdtgXphw=;
 b=PuJ526uX7jcUZBygK+zTrjWZKzUKG+5PIKKyICXsv8lYT0ZRfH4ked4izM/zuv9Si9
 h81D/D/hzsr1tTbWK2Bgg1blGmOaxVyOhTwcpGGLI41xZbhQ0w71gT1X+X+vy/IFR0CO
 1C54WNBq2aWjn4rD9OzIkWHvGyiBhplJ+rtmfZ+gRpbMcyAd18wxi9NvgFCc+CrN/Jtx
 iMpeuvhDZAGCqrDNp8LPtrG7dyRgK4O36wOLOfE4ANMHiEvS5YxkvxlN6iaUhNncGd/9
 OGLZgiva3dR6OuAilzTs2DGGi5Xw5tbIIyy9oEFvOtN4rSg+fILfc07W0rJnbiCIAQXP
 dRSg==
X-Gm-Message-State: AOAM533uFy4r9OQoN2fCzk0eJ7QMdWM96CuWQeoJACFT0AekasRvZWjp
 Jwg5WSHk3pTDK7HJGIYml28P69+y
X-Google-Smtp-Source: ABdhPJyao6Ns6PFnCfoPBVpsFF5nUgV4K75+GEhROHdl80eyIBMNc8tf2R+ppoZmyOKEKEvfHtsGWQ==
X-Received: by 2002:ac8:3563:: with SMTP id z32mr6125074qtb.244.1594751063026; 
 Tue, 14 Jul 2020 11:24:23 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:22 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/42] drm/amdgpu: add support on mmhub for navy_flounder
Date: Tue, 14 Jul 2020 14:23:22 -0400
Message-Id: <20200714182353.2164930-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

navy_flounder has the same mmhub IP version with sienna_cichlid,
follow its setting.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <Tao.Zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index d820fa02e6e8..5500f9d8d18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -390,6 +390,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
@@ -422,6 +423,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		if (def != data)
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 		if (def1 != data1)
@@ -443,6 +445,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		break;
 	default:
@@ -458,6 +461,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 	if (def != data) {
 		switch (adev->asic_type) {
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 			break;
 		default:
@@ -499,6 +503,7 @@ void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
