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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93319C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0B1207DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzR0Nbdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0B1207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134916E148;
	Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EF689FED
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:04 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so442320qvb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcs+lcIBaeVk+b5PyWkFz0iqoau08EeD8QEslLV2wtk=;
 b=gzR0NbdkmRjm3k/121juHfouGWzJcYndHMcWT65ODMnch9GoNkLZdi4em94G2/P+im
 Xg6ZJE9uvzrRxkMHTWigs3PvqkcuXkW+ZUnT8TziGhMMnPBfXE/kbYp9AbPq+uta508o
 p8q8sah9QBsQTlq3x1sEzu5QRwmXr6OiJwA7u/fItU3nZEtZsjVHOhfQ4W0ysi6J54NU
 idashsfygjHE+K07WwmDQfessuxbTH2fVFm3lRWiK79l3xG/xZrUPy1eA5rUaIvoLMqN
 sKuWLRuH6Sd1e4vAi2tY+diT7BsgNXfAdyFVlLOH8r3PSd0xjeilwu8u3DUmuFtQT1s9
 moAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bcs+lcIBaeVk+b5PyWkFz0iqoau08EeD8QEslLV2wtk=;
 b=jNb7DfCVQTLWoox3J/7i/5Zl9ObvjUg1VUSWLheCyEoUN7oCpQQtzjOgyv7Xa6PoTm
 2/aqBHUfKCckXsbz2hI68/A4Nrt1fRWy6OpF12s/mOhOeddsOr3qVWotV6ZH8TsNi1/k
 4LDXp1AGfA52xQ5evzALFsNtYTvTynwL0lzVts4v76rIv3g+4QN7hvKe5xoN1enVLaRZ
 8jYht8DHE1Kf6xTdUYPt+H2+4jBtn++z62/oRuIphukEKp4YVlfeliU/x3Au24UMPD/2
 DBGwy/xXOpwObRs6BrrV/spK2Ibc/9kAedcYziPaXi52uOYoyLyc68RUD1qXqJ6uDzWe
 JJpw==
X-Gm-Message-State: AOAM530O5ViRCmXFbyBpbDbC6nF5tuKriks9vLVY/pZxfeRxcsCJpRZ6
 XvjwEOswUAB9UfEKvgXtEnlNgr/g
X-Google-Smtp-Source: ABdhPJyRxth3UEFCSHojOmnNNP58e4xG2TT3Y2mRr90iKrrRA7DvUJ5X45Hs4iZNusdWeHClzmHNew==
X-Received: by 2002:ad4:528d:: with SMTP id v13mr6964398qvr.90.1591034583568; 
 Mon, 01 Jun 2020 11:03:03 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 014/207] drm/amdgpu/soc15: add common ip block for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:26 -0400
Message-Id: <20200601180239.1267430-11-alexander.deucher@amd.com>
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

Add common ip block for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9466dc52df53..fd250e46cca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -483,6 +483,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		break;
+	case CHIP_SIENNA_CICHLID:
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
