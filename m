Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0380BC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CB5206BE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9qoILT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CB5206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6C76E0EB;
	Wed,  7 Oct 2020 16:31:52 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1C96E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:50 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id g3so2377950qtq.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8VGAxAn2hlKvOBpeXuawISfNMAP0TGtP2VR1ZvGfRVw=;
 b=O9qoILT2v4dghbmXYC6eLB3EDKdjL8SeA2+UhHndWUVrdfooN/Ldj4W9Fv1ihg8DCF
 2olPpwQqP2oSMEXXGyv+kpfHuuHJmE+BNVIzpe0T1HB/h0IQ1HYF+BT2kBgWAHgOgvGH
 Ha+IUvE3BpRehBjxOTiapeI58k0K5AbJCU6AfWc39OKQ7h3hQYV3M6Xs7syXjB0uU8c5
 93J1yHLaXO3GyimPdLBC9bQmNHI/+iINYO3Jn+g+TkCiVRIqd9OqxkHbjyIlj6FgyCPl
 pZF7F479HpSoXdpn5TJVqMnzPsktDGQIDYkU0XPMAaqF4wyEfRFH8XM8KXTbtqzTC8gJ
 kS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8VGAxAn2hlKvOBpeXuawISfNMAP0TGtP2VR1ZvGfRVw=;
 b=BjktwsPGQgLuHQd8UQ9jfON9/H9LwBurmJLKQybzvZ8+Olo+rzZd8M5zl+8/8bo73r
 iW9vkPCj7O4ZnWma/KvJjrMRzmgcdiu3TQRGpwvJtVIgrH1U2RpKbHSfyf6u3e3OtUJV
 oWer8cIuMRKpwkGPG1jnSbreLlm5iFsk41frvbYqEZ+VeFKKjlxXf7KF+WBULNgm/8RF
 k1Z9w8MuOKnxvdqmo1iw096pMOlnDgQ72DrMBEdUulrfYtYEHT3cIC5CiVOcwxu6pIKG
 5vbk1o9Ul0BfE5KDGzHjnT3j/9+NIpVTxjFU0FLJ6YjdKbD4gRdTTbWTqqtogrLlwLPm
 x8Uw==
X-Gm-Message-State: AOAM533f7Yl9Z8Y47qXIt4KU3ImmZ1lwKs34zceYF1Ntbh1QK0Bmi5rv
 dnIb3LTikc8kYfvsbTE6+XANub00hqU=
X-Google-Smtp-Source: ABdhPJyTGDorzSsnO7rj554v3EFVRfnZWymSk1WtOA4CkHPBimgp+USk2vzoTVccu1rpnqPUEbtFIQ==
X-Received: by 2002:ac8:73c2:: with SMTP id v2mr4146443qtp.106.1602088309539; 
 Wed, 07 Oct 2020 09:31:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/50] drm/amdgpu: set asic family and ip blocks for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:49 -0400
Message-Id: <20201007163135.1944186-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Same as navi series.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cea6cbbfc259..5de583295fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1996,6 +1996,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_NAVI12:
 	case  CHIP_SIENNA_CICHLID:
 	case  CHIP_NAVY_FLOUNDER:
+	case  CHIP_DIMGREY_CAVEFISH:
 	case CHIP_VANGOGH:
 		if (adev->asic_type == CHIP_VANGOGH)
 			adev->family = AMDGPU_FAMILY_VGH;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
