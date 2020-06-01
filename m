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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADAFC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C3420776
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka8jlqLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C3420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C749F89079;
	Mon,  1 Jun 2020 18:02:51 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221E58825E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:51 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id e20so472194qvu.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VG3u71XwZk+KGW+aN6psww3U3z+t8lviKU+pwRGLBgE=;
 b=Ka8jlqLq+m11tqkYfBuIv2hd01sUbTt/WgxJYn2L7xps07Gr+d/2SiRCyA03z3TX6l
 EZvZiERsEBpXTQ6qqA3TqF/CLWiDCgPKAcloWr9sMGubgoEkIpLfyONiZMtXnp87C8Cm
 8GUdV5u7g64CH/c8AtC/P00OiBCMESkHyRj0xLirA73pbMh2bm6/T8NuEoxXw7P5j2Pr
 13I1KRO0hfw3ne2JT4KzcExOh5LlCvy37qRaqGGKkOJ/pY30J88MMixQPBjBJ4/TobZg
 +iCIobfAUgG0KkAi6bV2TFO5iHUt/JFAhjyZO4JmqEK1mVJWBAxpqBSHLtJcVFQB7BtS
 9YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VG3u71XwZk+KGW+aN6psww3U3z+t8lviKU+pwRGLBgE=;
 b=B18FalSDwditvoBwI4l0+VJsEN5iMtZfyLKGS4+uRp40KRB5B4xDueuKf9BBBDAvOB
 mY+6kRSgfPl/JFMS34LlUihDzmM5DZCA0cXez/dENHMhGIKHLDjbbIryyayEzJOKuwVC
 BjlppfWy2TfEVMve0HD2kG+Gld5OcTeTF9MX6JYiJs9jCpmcbRmRnINkY8iwUjwquHT5
 zjjmDbO1Phdydge1qnm5WQ8sOVEshevYl/oknaOdg4QnBkm/rFHD7t7A1w0KkTaN92mE
 1hMkbgq9ONpHet7SP9YMz3l4DakxJKl0DIxPQFRwtyWtgn9XHphT7F0RTvxl4gH2ZZwn
 81bQ==
X-Gm-Message-State: AOAM531tflqN6IJrYZ3jE2KBNpvr2fBIMOtjH2VUv9N4P4FtHobpanFO
 3FKC3+2OXWqhThuV9/9J/DjBDINU
X-Google-Smtp-Source: ABdhPJwj68ubVTHe6zel2x05zvbEpljsrdoJclNTVT5pMSEjCYqXaggOVeq5vnzhaqaxsioV6otK4w==
X-Received: by 2002:a0c:e385:: with SMTP id a5mr22522234qvl.81.1591034570047; 
 Mon, 01 Jun 2020 11:02:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 005/207] drm/amdgpu: add sienna_cichlid asic type
Date: Mon,  1 Jun 2020 13:59:17 -0400
Message-Id: <20200601180239.1267430-2-alexander.deucher@amd.com>
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

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b633171281f8..5d1e445eef21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -112,6 +112,7 @@ const char *amdgpu_asic_name[] = {
 	"NAVI10",
 	"NAVI14",
 	"NAVI12",
+	"SIENNA_CICHLID",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index b1230e33d506..0c5bd1134460 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -54,6 +54,7 @@ enum amd_asic_type {
 	CHIP_NAVI10,	/* 25 */
 	CHIP_NAVI14,	/* 26 */
 	CHIP_NAVI12,	/* 27 */
+	CHIP_SIENNA_CICHLID,	/* 28 */
 	CHIP_LAST,
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
