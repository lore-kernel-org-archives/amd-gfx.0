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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204AEC4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E1E206BE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTMKL43h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E1E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE616E973;
	Wed,  7 Oct 2020 16:32:49 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBF06E979
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:47 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id z6so3496729qkz.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0ieNhIKM4vnHHOE2O3cbQ25ZxrUKYn3Ng16sUps3kYE=;
 b=PTMKL43hFlVW+xReqK5N3GiBk0dk1kr4xnuC/Bhs1zaaJh30sEY6YQpuUXyItmY+Ga
 Zlww7tMmbO34KWTV2jSdqJn4JVGQAjgug0w2/xMdY9R+x9AbldcgvlK3n6RJAtruOixL
 G78gvenYMMX0MHepgXUdReYOECQ2F6X+XkZBgEYsr4b9S+jRJ0HT3X9CHLknnU7ins8k
 TUu6tg3KOXGE+0Y1CSEnSY00EhIulQCiYUYDBqxNtQVQtj1N3WHwsB1CuJsMS9eNHq4C
 9jbzQhVCpn4iz8czILBwWlvf1blfdBy6Do9FpBFZSOit34+0L5yZFwzMTerSka5YUx93
 Wdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0ieNhIKM4vnHHOE2O3cbQ25ZxrUKYn3Ng16sUps3kYE=;
 b=SPnlfUQa6GIsT2qjWcIginQkOdXJ5IMmbN71KGfqowLXQCvgH6uCEkt6YErqHjrmzX
 8wf+Qxbbg3H6gftlE6OV1zj5yBG8pVn3pvevUzSgp2daU8LuSsW52zJWQhEP/RMB5NUh
 OBjQMSeiInqBSWvqK4jABq7Z38P8z3XjHj6J99cDQWRIiPx9LwQ+Euh/TDSyKtV7D3hi
 ncHY2uKKabg5HGUi82aoqqO/V09/VuJ+hK67FlsqbDMKqYjSwOGNCy2Rg0UyYPKbxhRA
 NolI+rE70Y/tax4Y47CSnOqsY3QSMnp+06kS/uYxV88AXCuLPzkV8AOv3NSwlKIx6P5N
 F7Vw==
X-Gm-Message-State: AOAM5335UYtQ87PAguI/Zd7KKG4AXsKuGQlYWDIaX+RsSsF9U34dZ1OE
 o4LYikTzpez5jPZ+O6GWyXE997PZb60=
X-Google-Smtp-Source: ABdhPJxmtO8uojb9qrXvUGh5O6D4mhhcP3joAIphzsS1yw//QKcwTANPbEbLncwjjtXRfL3ZhJYlAw==
X-Received: by 2002:a05:620a:1275:: with SMTP id
 b21mr3481401qkl.135.1602088366655; 
 Wed, 07 Oct 2020 09:32:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 42/50] drm/amdgpu/swsmu: update driver if version for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:27 -0400
Message-Id: <20201007163135.1944186-43-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Update driver if version from 0x5 to 0x6 for dimgrey_cavefish, per PMFW 59.04.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 9edc9f24746c..84211c620417 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x5
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x6
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
