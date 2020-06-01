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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE3CC433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839BE20C56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX0F65FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839BE20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F756E2CA;
	Mon,  1 Jun 2020 18:04:37 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6656E2CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:35 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id z1so8471852qtn.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FrlWIH4W+Kb4QMhhxheXrd6dR0XSIsyCuX0daYx+wRg=;
 b=FX0F65FZ/mlnS7SFK+aOm1WkIRYEK0ZGdkv7svr9azWT2r7Ff/d/YsKAcBTzitE5DY
 EtMm0jT3vYDbSRkm4E9SI4Daf5ezByQ5G2K6+UPt/wB66bAkGIkk/P3Qf6lsr302dHuK
 xFlk0ibci29GgawEW18Z35lDsLzbDdp0Xvq6SWeAQBHoWNyr/XQUY7TW2w7GlGmV1z+d
 geHS94aU2AWA5upqrN20KHEn/wjJBF/fRhb6s64qYy+4uSpbxDuprSXo+G6IoAmlt3SH
 hOK+AIJao8l4Ha+V3yQEKAK5I9zJ2RpVhMcmCAomd1NQkfccOxYv5f10QuBIQZ70PZNl
 kfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FrlWIH4W+Kb4QMhhxheXrd6dR0XSIsyCuX0daYx+wRg=;
 b=mE5sIwFTsnjJnsD8r+TEUT8ZSJIZBulxT1uNrEbIshXmJEAgVGu4PZR+DA7K3GCAsc
 Mj2z3jO3M1Krjq1tvCHq5QeQimeS6jLr37MSCq+JdpagPcjl3IgFxui6tMvFZUTIV07L
 Tn16jUFGm/t2EEIwhUB/K+iVE5Shgjp1KMxVDl1/43ocYYNkR7ym1xL5Iwde+ehxHDnI
 K1t3NGBk3qUa4dpCTOmPzRb6ev0NvLmjJhjiibLj/RNq8ZVnQwPFIQ+SAPwbCFHe6aXI
 1pqbogWpmEehgydAtX/h7+YuBFw3IWcnWsTxBK3MBzyPxiAzQORmwuoRIU626zRuGcyf
 tSqg==
X-Gm-Message-State: AOAM5320NNBfkIQy2HRt4IG3Q+8r4C/vOLPTNybcod4nChooq9bIKPo/
 7FrnGRPJf1pPAw0uCHGpudR8COo4
X-Google-Smtp-Source: ABdhPJz9jlF0jY2ueExSqkTJNgMOWYxapvN20J0MdSKLtR7kX9/atWo8194u0o4dInpB66c+4TPLFA==
X-Received: by 2002:ac8:1b99:: with SMTP id z25mr23075197qtj.209.1591034674789; 
 Mon, 01 Jun 2020 11:04:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 076/207] drm/amdgpu/psp: convert amdgpu mes ucode type
Date: Mon,  1 Jun 2020 14:00:28 -0400
Message-Id: <20200601180239.1267430-73-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Convert to psp defined ucode item, so that psp can recognize them.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6c05071defdd..4ed542b69377 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1428,6 +1428,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_SDMA7:
 		*type = GFX_FW_TYPE_SDMA7;
 		break;
+	case AMDGPU_UCODE_ID_CP_MES:
+		*type = GFX_FW_TYPE_CP_MES;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES_DATA:
+		*type = GFX_FW_TYPE_MES_STACK;
+		break;
 	case AMDGPU_UCODE_ID_CP_CE:
 		*type = GFX_FW_TYPE_CP_CE;
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
