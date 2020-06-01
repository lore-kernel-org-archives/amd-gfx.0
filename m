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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBBC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F292073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyXcrWZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F292073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0516E2EF;
	Mon,  1 Jun 2020 18:21:17 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850D46E2EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:16 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id z1so8518466qtn.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LTx940D2dTEj8YwSnCP+fwhk0xkSc269yxfwtjOdEYk=;
 b=KyXcrWZV14UTOZT5qp7cx1y47djHNyi/fmVfM5m4+mpgkSv26+E2v/81pxUxNs8GqR
 WRA7raYmeKl7o18NsrgjUShR98VT4mWUcoXYAab8BpxIfy7tKvpsan1ONcMrtu0G+RJu
 rNMK5lfzqpvD5Us50pNJTZ+YvV1dgQx73QS6X/TbOq9TK7eNQsRM+xqJClN5cZZtarry
 diLUw0mR+Rs7fELvtTp81XCHfTJzziy/JORELlXv3aNuq9I48ITZeHtKeqbzBnAf3rDC
 VbnTCn3qRcfMvJBuOlpVDP7INnu1lPCiOUnrarOolkfP0Uk607IgibLb5ObzvqtwHMrR
 d3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LTx940D2dTEj8YwSnCP+fwhk0xkSc269yxfwtjOdEYk=;
 b=cjd/Uu6VRjr/Kg02+2O6n9vATeVX7ZqeqybB+7ZS4lO8zHM6tXqtM+5U08o5cpHAu+
 bGH8EcGwxSNZIIh5Pg9HQ8AGqL2AUQiWDCiChVdB41jLKL8kW5+QjrCj4GqNfr2PDv/A
 j+O7AjyfgU99XPMmhLTLccyCLL4AW5n1i12DZ1s2Hwx7BTDM9YoRu5iudAnvV8hXZv6f
 MLzLSIRfA0P0nrlvPHur6J3xl+dKar5v9vLip4YlEISJa8DRo5fj6/gyhS8UYNP7VFw6
 cUcoxAsiGnndqJriFgMaPN5ZLN/kesdEoO8H/0WUtWxbki31UBXB58IACmGtAyZJ3tiX
 EKoQ==
X-Gm-Message-State: AOAM5308GVGuKhiKElzxptuS0JAGQWbzoyvlxFbH1gDFwfna+AL+asTu
 /uw1xwiGyFbU8DSvypD1z5haD+vN
X-Google-Smtp-Source: ABdhPJwrRdZGLYmNJOh5Ld1atvKtmA45D36jHHc8zF0aqbo3JZmcu310tdU3b7BbAcj9EY4A+mqkoQ==
X-Received: by 2002:aed:35af:: with SMTP id c44mr23525629qte.349.1591035675539; 
 Mon, 01 Jun 2020 11:21:15 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 098/207] drm/amdgpu: only send one sdma firmware for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:05 -0400
Message-Id: <20200601182054.1267858-9-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

As all four sdma firmware are same, PSP only receive one SDMA fw.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4ed542b69377..2fd40d0d7a0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1683,6 +1683,15 @@ static int psp_np_fw_load(struct psp_context *psp)
 		if (fw_load_skip_check(psp, ucode))
 			continue;
 
+		if (psp->autoload_supported &&
+		    adev->asic_type == CHIP_SIENNA_CICHLID &&
+		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
+		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
+		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
+			/* PSP only receive one SDMA fw for sienna_cichlid,
+			 * as all four sdma fw are same */
+			continue;
+
 		psp_print_fw_hdr(psp, ucode);
 
 		ret = psp_execute_np_fw_load(psp, ucode);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
