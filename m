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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7227C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE33206FC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxxZgcb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE33206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60926E8AD;
	Wed,  7 Oct 2020 16:31:50 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C506E8AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:49 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id m9so2382065qth.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cy1TXh7bIDimScyku3HImAvme4cmnCNJT5hjhkhJ3QY=;
 b=jxxZgcb6D688WLduOSxUdSTgcQ0gA0/7WVZTs4tzFYp9Q+rcjCiwOTnqsscIu2m9zN
 DXchbe1+DsW2sZbM+k6JUK0EfgrNot/O6HmOuvKY2S8WM1aBldVLYTvdj/bNw6ds3yaL
 BXWFbvhz480XLddMbXE/TMsQEzt3eqPgeE58ia+5BXjOTp5VCm2Uzezs5+6B+Ysxpwhw
 xqhxWjVmj4tebFB7//7UvlZfPVRK6fMHYCeHE+i/c9w8W/KsW6Q4er0ovG8RyXPXDbD0
 jyCte86XWBC4HIJ07pTUddgb7oTZe9wjUcbOrQyKRvBTPnm0nvdEm7DCeZprYQnkNwID
 r7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cy1TXh7bIDimScyku3HImAvme4cmnCNJT5hjhkhJ3QY=;
 b=p/hxAwHCmRTTDG7Ye1BH+jTZ3iyDXLc8ShmAMrtAQya+x++PrCJ1/3/UfpNVvwL55Q
 1MY8ar0KBK/pww0X/7c91P/Y43GHdIqyrcRV/tyrJhUMAf3ePpeAHPEBvm6zmuNgUmyt
 jjVjvmMfPFzi9SKV5w6DShCp4oExPEWE9Bm4LVyNmOmpkbz9v9eaXCZ7MsDzNt6ZRqm8
 rVuD7gs8MqYzlNyBYcOmYsyFpKQ5AlD3y95mqUfxCB/x/bb5WI79HuCFYukXBieCS+gH
 /BF/MMKcofPaB0XomErdC4wJGa6Xqnoc9CoMbl0vwHppEwvd3pkHxifr3CpGrcsHl+gN
 JfPw==
X-Gm-Message-State: AOAM531+Agl0Mk5PBd0gYOPxae1BQgy6MRoqLjPjPSMa/AhxD/veMMnq
 dHmJwJh3PSzQXjn6LQhZkOgDYs6Hkc0=
X-Google-Smtp-Source: ABdhPJyyYxVsIRBO5Ji0lLTP8GZZ/cBzYAu0jCHbSSP9P+pU+YNMlyHvmF+eZCBnJZP2GHxKYuDFUw==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr4015496qtb.80.1602088308323; 
 Wed, 07 Oct 2020 09:31:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/50] drm/amdgpu: set fw load type for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:48 -0400
Message-Id: <20201007163135.1944186-4-alexander.deucher@amd.com>
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

Use direct load for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 676405171a4c..d068bffed742 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -396,6 +396,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
+	case CHIP_DIMGREY_CAVEFISH:
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
