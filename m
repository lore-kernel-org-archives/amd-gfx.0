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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4109C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E09A223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtwxcf09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E09A223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE2B6E7D4;
	Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5F56E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:15 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id b185so16549161qkg.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Y7Re0RtdTQUP2XUiyU7fY1V3Om4D7ip4d6mshpnnLY=;
 b=Dtwxcf09L7nhfBPRPnJMSI8Nn6wXArpL8OKFImCbv2ZG13rduxlrqbX/h31aZ1yhZK
 feQYgWX9p3/FB1Ya9oyfdE9gPXImz9d90Dbc7SSUZIDTVY/e3DpfPikEAwgDSJuCmCzw
 IgQtTXcTcOVg69wNWwmnrlwOQaIqTwG5zzGJyUTt94LGcA/U9CBNq7YfpvXJplVIRwhl
 A5+jY/RkobFza/MX5Wl/2+hzqx3aJm1hqiIbiZ/siV/Ocb5/56iBR3jjmtlJ1CwfAhYK
 Tq1yz3StEEO4GfRxgKNyTCMxh5ES/cUXfl4tKXtyFEoC87hLmiOyqNQ+kNhPcufHVHXI
 x5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Y7Re0RtdTQUP2XUiyU7fY1V3Om4D7ip4d6mshpnnLY=;
 b=GzWEdeY3jwe5UgHd8RgV9Lht7Zghq9/PaOorjl46eW4CXQU6VHxi41ceJK0fC3J81w
 CSO9W0DzxLz0URKJ0CPQyycK4jheONsc+LKhZeDibHhDGTRjZp4rLUXVNvZV0fvXOeDn
 MdJ3cyBh/eOHvq6XAgYZQAlqjrEt1TDtKWkVj36k0Js1jMuOKgBL/9Q/vJNQLa7bkXCF
 SMQogFpK8REdGdukA4znFHyI85ZNaRaRywkF40JS1Mv7xMGqoK2YPMIet9eH7LUawRps
 CGJ263me2L57dq7aZep1GwR8rEtXL7Cqi5QgDoibS4PGwJG6bYCKOnL+uAOWbWtLIuAe
 M2zQ==
X-Gm-Message-State: AOAM532WUBA+tHgA3Nn8ZgMcCRBoX/KOAm3MaSZ6iltNd8GdaWmigmEl
 fnmTZAvHdaDlmL0ZS1+iOGQvcVp1
X-Google-Smtp-Source: ABdhPJzcMcFOJem0kcXP/Aol/K7QSaZgFlncQJRZpGTtCdN0Ntu/t2AAnJW6uGuHuq0iU0BAchhDoA==
X-Received: by 2002:a37:a20d:: with SMTP id l13mr6098101qke.296.1594751054254; 
 Tue, 14 Jul 2020 11:24:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/42] drm/amdgpu: set fw load type for navy_flounder
Date: Tue, 14 Jul 2020 14:23:15 -0400
Message-Id: <20200714182353.2164930-5-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Currently navy_flounder only supports backdoor loading type.
Will switch to psp load type when psp is ready.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 744404a05fee..43af71c3202c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -394,7 +394,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
-
+	case CHIP_NAVY_FLOUNDER:
+		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
