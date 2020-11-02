Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF1C4742C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60402225E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i96sEWF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60402225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C90A6EB9B;
	Mon,  2 Nov 2020 19:41:40 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9B66E575;
 Mon,  2 Nov 2020 19:35:33 +0000 (UTC)
Received: by mail-pl1-x641.google.com with SMTP id f21so7336744plr.5;
 Mon, 02 Nov 2020 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2lbMlvM7aWGVHz4uVqI/5p5HZNqB6mCF18RFUVjf3IE=;
 b=i96sEWF+S8v5jjYJ2xNOpF2zGVRZAJkShGc54QxYUawVtICygWu5WTCoiCbQEzV+ur
 QvC3b2fo/4rZLGPGVaun1J/ktqTfl03ws0QjCMa1DTDdhm9hzamk4Pm6kfJE5h/wxv20
 csYlAvfdf+hh8WhkA1+6o6gi1uKShtzN1EdgEMn7FGsNoiz/ojY7TCcSY+VpGtezZFx9
 n7IL3oeFrmx18T4jcC00s+UUndq3+xsZFTXohM/4Wg5C3hCV4hneZ6RN/h2hSwFxjCpX
 2knpV3917P4KHvRl8IhS5uZxhohOtk2TKI2v2r2Ec4J8pgtLkuGkYl3nf9RmQEmi0paT
 CxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2lbMlvM7aWGVHz4uVqI/5p5HZNqB6mCF18RFUVjf3IE=;
 b=HwKVjYnaYN5zpOaA5KSnohtOa//rGneOHhLyIFsp1+H7QZcD1OKTa0ciIul4oMLCCQ
 6cbEHSq80FKEvUR/+GEenUBN32HobmOinb//vrzxNPFCY/JaEonbCf9bo3TSkPKrkr8N
 J78BuKea/Lx1xzMwQ7IzEkp2wH+8Qre5+/ndSrHuVrTjY1fI7aiV9UOE6+ihYImZwuEV
 KjRNP9NlcJPcxOJHnvnkbEcIjZeT/jlh1cOChjHbkoaP/35oNM3GOU4i+SEybbJqgVwQ
 6AcWcezxMACw2VY0U4aZRWSnaCD1JLb5MRWiKqDALfMnBq4uYd1Xj13GA3lyjtNM4TEh
 eyNQ==
X-Gm-Message-State: AOAM5336mFb2fJiZqwyowzwpVNkOmSsClhNoRTA8rO+obXradLvVB6yC
 W8czXjO8voY66FVTRsACMq0=
X-Google-Smtp-Source: ABdhPJxTjvCKuO1rp6ybPQ0KppAeZO2klLbBN64AHYKjstw2UMMyvJMBmN7RiFHs1EgkUYWlcrAWkA==
X-Received: by 2002:a17:902:324:b029:d6:ba15:90bc with SMTP id
 33-20020a1709020324b02900d6ba1590bcmr10902741pld.29.1604345731743; 
 Mon, 02 Nov 2020 11:35:31 -0800 (PST)
Received: from localhost ([160.202.157.3])
 by smtp.gmail.com with ESMTPSA id g85sm14651760pfb.4.2020.11.02.11.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 11:35:31 -0800 (PST)
Date: Tue, 3 Nov 2020 01:05:25 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drm/amdgpu/umc: use "*" adjacent to data name
Message-ID: <32f014be6bb816aa37b4c0670d2ee990ce596b60.1604345594.git.mh12gx2825@gmail.com>
References: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
X-Mailman-Approved-At: Mon, 02 Nov 2020 19:41:38 +0000
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
Cc: melissa.srw@gmail.com, gregkh@linuxfoundation.org, mh12gx2825@gmail.com,
 daniel.vetter@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When declaring pointer data, the "*" symbol should be used adjacent to
the data name as per the coding standards. This resolves following
issues reported by checkpatch script:
	ERROR: "foo *   bar" should be "foo *bar"
	ERROR: "foo * bar" should be "foo *bar"
	ERROR: "foo*            bar" should be "foo *bar"
	ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 5288617ca552..96d7769609f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -253,7 +253,7 @@ static void umc_v6_1_querry_uncorrectable_error_count(struct amdgpu_device *adev
 static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
@@ -368,7 +368,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 5665c77a9d58..a064c097690c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -170,7 +170,7 @@ static void umc_v8_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
 static void umc_v8_7_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
@@ -260,7 +260,7 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 static void umc_v8_7_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
