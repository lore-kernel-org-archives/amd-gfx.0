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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F43C433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C352065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiZb/Zi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C352065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C838A6E08A;
	Mon,  1 Jun 2020 18:02:54 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD7A89C29
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:53 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id dp10so442003qvb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ANBVSpK/CPpq6IPwxo9nSMn6cV4B4PYmqzybXBqScsY=;
 b=OiZb/Zi6cXe5wpKCPWQO8+FGbTugdINH6PikKHRp0nK321GcUurvqH0mLq/PbdJiZR
 FpoSGbFMqLRyrmiMotZ4z5qS+bNS8BWEpgGqIlycJCWgeFthPe4oKypW4di35kmvQASl
 7IVEvapVUEcgDbRbhP0e4ghe/lg21KZVz8czGchjux4VcxWeJL+cnQNIzfUoNUf0ZWeY
 PChe2/+Zes7VYgcW66emaD/vF/2DglDabZX5Onv8xOPEsf0N15FJTCbI2U9FYnz33886
 cg0T7hBaK40x1VaLAOgE50OC500SBueY740m73FBXuus/lBBjl7PtF6A/sQjN+58SayK
 BGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ANBVSpK/CPpq6IPwxo9nSMn6cV4B4PYmqzybXBqScsY=;
 b=nkH8x3Pb7jwV3rQLJSrbkfR+8rGoxS3rgNtSV65Fz7JiG/vlnKS04uSKeR1060it7O
 9tQMsNTr6jUVsHcmUiZwuJH2eoRbuBWyEzWGo6ObnS2x00OArHk07semWCJtcKjGuv/r
 B9cDWMpIGovP+XfXwK+Qi+c1Wa8qyTgolaeAu0yBCMPWgB5dm/55Ht+QCiFYkU1+CiHC
 wygCVtdbfplIsbWmso1FQbYH3GxIA/Kwm9rx5Pj8S3pTOlrb0YW5qpyRgQSYL9wVHKEl
 7Zd9F2cM7/0OKPBiQPn2HMW5QgnPJrNfZnDcANRxwy33DX9Nob50wT0C5gGPj4qQf/au
 a1XQ==
X-Gm-Message-State: AOAM531/jFEZoCZ80kehaLZpijStLW7kwsFZM4vM3D1kNZSRYmGp3VkL
 UttOP8RKIZTWl8z7g3oFcj5TChB9
X-Google-Smtp-Source: ABdhPJwelTg2l0imueBz+TQArwstH8IGnVweS+VpvwCLGoLgC0t9LANVQsaAKNjhJD+D8BNYwNl91g==
X-Received: by 2002:a05:6214:aaf:: with SMTP id
 ew15mr22158867qvb.110.1591034572802; 
 Mon, 01 Jun 2020 11:02:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 007/207] drm/amdgpu: set fw load type for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:19 -0400
Message-Id: <20200601180239.1267430-4-alexander.deucher@amd.com>
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

Same as Navi1x.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 65bb25e31d45..74ac14466a78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -365,6 +365,7 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
