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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006DC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406A4216C4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTVudCfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406A4216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D742D6E965;
	Wed,  7 Oct 2020 16:32:28 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F076E96E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:27 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w12so3469222qki.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6nFPG1exAyjzX+VfN3Lw9ES9uZHsJCpgv7KA8LrcHhw=;
 b=LTVudCfWkf+4YIWGVcAikBIWq8XoMZvmTU2QRmIAcde2NOY+bcMmutVp4IJomxmoEW
 W1dGeQaiFxdcsnDNJwnEIezpwz2NNd1+l3gQ5YzD83TwsP3JrEcUZDO2s/UnL4PFr6nc
 VEk2Xwdh65s/0USKEiIk8liTJREntdoObPSn1j/NOiGxh/YKeo6AjH6lhJbetT3+y8GL
 5xq2/QpzVdo1oxVEWqWlyYoCPVqLfLXlTYeWLB+DmtqqXXyShTWRotsETsEtsgSNaoug
 3oeCSyEZCvAnIvixXhqwAv8HIV1hlWR4oWvGl8HpbyXKAvljiWJCCoFaOHg3UJN5lkaS
 jpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6nFPG1exAyjzX+VfN3Lw9ES9uZHsJCpgv7KA8LrcHhw=;
 b=QIei+ZEP9xW8Xz4lVxAh6o2eOADAgzseObUl5OgcJolqBUbdkTpFXLB1sGB8wttRz9
 rBiY1k+AjC1JSccAsiZoC4b5TXCKiJNqI71hYAVBjgVRnYWY9sQxxqT8QCk3t9fUBYa7
 nknJy8+pMON+efX/K/LxAfLESxGx2noIKv0u4Wdbbupm5lBVwovkHYWzSIgjhhrIg03z
 fHULogvUWuLN8EA/f7SyQCv4GTK0NsMvshjfn+026Sk5zyRUoLhE5xWikP2mMWBk3Iu0
 gte9ce0svaf/r69wAYKR5+NkEtdLKGksB7hZTyURvjQaniR08wZ5KU4TMpA05VmpsfBS
 59BA==
X-Gm-Message-State: AOAM530qu6jvMr1ATlVWLxPGL7fXz8V6vFKNuzN3LCLI4q6NBeFC/4OD
 3iaEb/HLK6Iw/4PEke6FvzJZEgWIQYM=
X-Google-Smtp-Source: ABdhPJw9PC6OKkKQcPblloTSrUamEOrOF/Leab3Y43G/DMYtvKR7giQR9QeiowPNb1bBuA1nDCwrfw==
X-Received: by 2002:a37:6285:: with SMTP id w127mr3869655qkb.454.1602088346184; 
 Wed, 07 Oct 2020 09:32:26 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:25 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/50] drm/amdgpu: skip reroute ih for some ASICs
Date: Wed,  7 Oct 2020 12:31:11 -0400
Message-Id: <20201007163135.1944186-27-alexander.deucher@amd.com>
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

Add check before reroute ih setting, it's not supported by some ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1a69c212ce68..993846f1d89f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -438,8 +438,8 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	struct amdgpu_device *adev = psp->adev;
 
 	if ((!amdgpu_sriov_vf(adev)) &&
-	    (adev->asic_type != CHIP_SIENNA_CICHLID) &&
-	    (adev->asic_type != CHIP_NAVY_FLOUNDER))
+	    !(adev->asic_type >= CHIP_SIENNA_CICHLID &&
+	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
 		psp_v11_0_reroute_ih(psp);
 
 	ring = &psp->km_ring;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
