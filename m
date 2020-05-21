Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BBAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A6820721
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkVgdUqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A6820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F172E6E24D;
	Thu, 21 May 2020 14:15:18 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A386E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:15:18 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id t25so5603270qtc.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eDqGyM+Gx0s1iQpHyyzhaB+Pfdu/J7l1ndZ+bKX3Axo=;
 b=EkVgdUqO6B96WAdRCQXmxc05Bd4ZpmOLdKShRiAY34BGJB2jt5iqvO9XLe8CgkzUb9
 zWvOVXFUVm0aSyDlfsUNDhbkyEZhKig7PoTiWsv0oGKyG5vDh0ekUwsVkk5He74CNTEw
 uwD67TUm19FC/9TbUIkOR7/tKAKnQlMY7nwZATc/xkM9FtJTnVjCjpc/DCmWxG+6e1Hs
 Sj5O8NzsHd5QmD9aqXqfKda1d9tueJU3lNSaNb+0y7/gTrSgFoZBbK9gzhvqxRthMbth
 CFlaDM7ve8CaLTF0JUzCU8FBDkXZEc14HQXz2dAcqK5VO1I4wQ4mHcol4Ati6j/ASzPl
 pG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eDqGyM+Gx0s1iQpHyyzhaB+Pfdu/J7l1ndZ+bKX3Axo=;
 b=mHPWJgFmmVA58PfU+13g+e/Gvro73oB8kIzdKSM/9qpxvRsGLqKFj3VqUon4YRyjW+
 I+pgTtPFQH+FSy1ryF+jqYU7UQSZxdX/rZE8B5TKHAeelXg+ncfXoNoyT4RnjsEUGRqH
 AYb+9xU6dTF6u5EsLVlGhtKUbWpqaj3GOHN+m3X4JvwLL8xA8j0pNCFDOdtL7ipntm1y
 YHS8WAf0AD+QKKDmlJEoTyv3dZ+dzpBkzhURrB7egO2Y92sqJbuOpR5FaJWOw5EBArwG
 sV8nl4lo2uD+op9NOsXOKKRYmPM/20uXXU55d49cQP17JcdqZnmSUB/2hcdcvR/cVD5y
 AtLA==
X-Gm-Message-State: AOAM532ITAUW27xKDY4WuFaOFfkriPjiji7OHm9tJZRP/FaXAGJjGbTm
 ZxNOW5iWIh9RcXk2KrlMcSV+UA1W
X-Google-Smtp-Source: ABdhPJx4YTbeYm8sWegF0BtQnYFogzpCpkoBnKJbyM4enjSo1g33exgzqEC6ABzS1+u664+qpiaRmg==
X-Received: by 2002:ac8:3722:: with SMTP id o31mr10634763qtb.175.1590070517339; 
 Thu, 21 May 2020 07:15:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v4sm4549599qkv.43.2020.05.21.07.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 07:15:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix pp_clk_voltage handling
Date: Thu, 21 May 2020 10:15:07 -0400
Message-Id: <20200521141507.1042075-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a typo with pp_clk_voltage that prevented it from
showing up.

Fixes: 4e01847c38f7a5 ("drm/amdgpu: optimize amdgpu device attribute code")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1150
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 2fc51f815eaa..88dfc61fa084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1746,7 +1746,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		attr->states = ATTR_STATE_UNSUPPORTED;
 		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
 		    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			attr->states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
 			attr->states = ATTR_STATE_UNSUPPORTED;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
