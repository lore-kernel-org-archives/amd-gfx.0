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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC7C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598DD2064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMqa5MiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598DD2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9586E97C;
	Wed,  7 Oct 2020 16:32:54 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74476E956
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:51 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id o21so2421046qtp.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=URpWmPSDM7brhAXWw6g9TJz52lkF75UrCCwM2/anyVM=;
 b=cMqa5MiBqvF6LY8CygROLoDbexPGqnfUni52T/4n9E1t10yP0aZw3qY1iti/HmC4cj
 rl0gkkdp5z53ik2dRrvRz/7oBhGe6xZxzWtBg4GAwCvMyYyxLHPkUB4u/4exMn0tavcI
 zw9YRi9c9bX4ySNiZN8cpYNWBspgdHduaVLnLt+s/KhYfFwrnakRFfJQZRwwHgTt7yaY
 Zbg+qAmeyMfPCkWF/frUNX6WHRbxAh4fX9hGmc4BBOXefurtL23zX+r5Kr3DZpfRj5Vs
 h1bUY/gYRsEr0UleyXMyAzMfrSUXtvd/KngAoXuqB/RMH4jJLNQeEq459EX2RPVk1zgf
 cDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=URpWmPSDM7brhAXWw6g9TJz52lkF75UrCCwM2/anyVM=;
 b=pWw7CgOQXBJ4NCBCn3ESp4xOPFELm8sqZlxprETZKTlCOgjJUYFWP1qcPK6rNqb7Js
 1J+b7xfOhyvqDuX7aAqiQTXXFcww2uDjVpueP15okbUVOpqDBPG/V/2ap9aU0OLCvcq4
 mdf4iJW35a1w593X6kLi91mwdoo3X3SL5GDW5q82boKm79UCevUs/lHd/Sv79ckpLIW2
 MGY84L2VL0FLcB4RoFrfIq6bw8fqh0lX3BHJvUgHv1DUJQrNWkPBd2YzJ7EKeJWk4vl1
 UNVo9iDpx31LevbrsaGsHjUDeQQMj9wvxMwElb7coV3hM5XFlrCMwaC9uhEXI+k/u87k
 sjsw==
X-Gm-Message-State: AOAM530PVy/wsE2yDzMXFy5IXpMMHJyg/isJV4LCxikVltySMqIZYGpS
 hm0J3+vDaNGDYCE/JLOcTX+ZvMG7xHo=
X-Google-Smtp-Source: ABdhPJzFjAlE516C5LFDuRqHGEKIzEBze6npP+/D2NvHE7QREMs42Zha64Uyg0W939RsW0HK37NUiA==
X-Received: by 2002:ac8:1246:: with SMTP id g6mr4109924qtj.353.1602088370967; 
 Wed, 07 Oct 2020 09:32:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 46/50] drm/amdgpu: enable ih CG for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:31 -0400
Message-Id: <20201007163135.1944186-47-alexander.deucher@amd.com>
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

Set ih CG flag for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index c73ad0482022..e6bc7f09ec43 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -919,7 +919,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS;
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_IH_CG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
