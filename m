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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30358C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6312077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTT1naE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6312077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D246E291;
	Mon,  1 Jun 2020 18:03:51 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A71A6E290
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:51 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id w90so8421790qtd.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yVMaITaYoiKjWJUjReyDa7TP3PMxKUBS/Eufu7DASQc=;
 b=HTT1naE1ruSaDymhZ3z95ALXTNT4U4U9+aBMPVAsuj8INj+OdmlDT301bT/dFiD1fA
 Ldj3Wnp+qaHUN59zJ9y6PCkv9l0wWIQUW6Fnx1KB2h1fB7hyLVed4SQFus6p4EadMtmx
 TVszLN0NnPn6KJNHTlS6rvzc5bkydEJ0+qGQxTXUGRizCZ/V0OSyU8El/kNlChUHns3u
 1Y25GFq76G6sytptsL4ZBnZWheHGJht8DU5DDWKn/r8ORoYemXSJI/g3Ur50LMHwj0K1
 dXmmd1LOZm0JaoctpgkmkXeGGFQ8x+jZI8fcg3GgL5XtDt2tvMWOHIJECDFT6phF6KRr
 MB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yVMaITaYoiKjWJUjReyDa7TP3PMxKUBS/Eufu7DASQc=;
 b=ZluapcvZEq+1vQFXSDfDgwk1nRu+lLWv+e+HfK3bH6cZrkam6CpxCqtgaez4ycpHj5
 OIgnQ5UVuChPxRjef2aUPOnBuhJi+HIfOEgh2Te9xcq31CBoCa1JUyfOmLEl9G2ybdDS
 6C/ftX0ED478v2DhIfU1otukwIzWC3f8KWnPs1LN4QUNdXpFAKi3dLrTuIEf0KGE4N/5
 /XfLZH0LrJMV58+PxOnOFwWhRFlg8FT0B3SJw1N5Yx4+kWwGCzhHH8Ulkww/gxepvN37
 frwsBmL4ksDvxOUdUYQfXStuyvfpZ7E6s91UupPoCs1sE8qrGZdP5ICwakXC2/t5aNvk
 /lxw==
X-Gm-Message-State: AOAM532lOvCtg1kfWiAeUEY8rrPirevwOK+D5ykd3MSlfVHZpqmawsEa
 4Fw6O6vbKgCYpaGh0VF1hZ4fbam6
X-Google-Smtp-Source: ABdhPJwohCY/F0DxibnOfNXhan/4ck7LwOxJQNZrjv/mhPIepCmZGoNnpRGYjzFd1ww6CUi390fiqg==
X-Received: by 2002:ac8:4746:: with SMTP id k6mr11634537qtp.234.1591034630320; 
 Mon, 01 Jun 2020 11:03:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 045/207] drm/amdgpu: skip ASD fw load for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:57 -0400
Message-Id: <20200601180239.1267430-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Skip ASD FW load for sienna_cichlid currently.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 679d96719410..982899aaad9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -432,7 +432,7 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) || (psp->adev->asic_type == CHIP_SIENNA_CICHLID))
 		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 9ec6e3819dff..427eccc649dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -103,9 +103,11 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
-	err = psp_init_asd_microcode(psp, chip_name);
-	if (err)
-		return err;
+	if (adev->asic_type != CHIP_SIENNA_CICHLID) {
+		err = psp_init_asd_microcode(psp, chip_name);
+		if (err)
+			return err;
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
