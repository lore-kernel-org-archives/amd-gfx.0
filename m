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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0DAC4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC04E2064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQPnKfag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC04E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D796E952;
	Wed,  7 Oct 2020 16:32:03 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084CE6E952
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:03 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id g3so2378648qtq.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H4j/9k8KxDZqj1oBUdRJHQ7J4dMjfoV0URxnJorwg0A=;
 b=KQPnKfagCOQYHAKHQ3PWtIf6TOWdffalXpzEiL+9lkEQJxuAAAbLbPy8q5787E+p5o
 3iAOiWwFK1Nwa+YzA4Bbjzr+Yi+vcdapnl9hAWLhfNE6A5RzGVhzUZE1zK+C8raVWG+j
 QiZ9o1SsC0l1g/j1D3NM3MrceDUV4Hx0oRM6vc9hDuBksyRfP3dQUxrv9n49W6ta5deV
 xZ/LlqeayX0ZCr942i+TbDicu4xsHwnfGoGxC9quF8m8J/rSLXScKYudRkBt3qGEklnj
 w9WAS0Emo78VDLq8x+8Apmw1rYhP8cA4Jmwg8YKbl9AkLyalxUVSVY3J3qP9COKpely4
 /ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H4j/9k8KxDZqj1oBUdRJHQ7J4dMjfoV0URxnJorwg0A=;
 b=LBBFzTx1tcRTeQo3FzddgPFhi1Z2ivL1kR3XVTVNq3+HTWaBfLV7faQcEWHUipwPOD
 9JdlR8cFgSgZPSuXjcTEvZueVdgaAarwuQjB4nn/flUeFVRvo8KrvfPbLri9c2TPCARJ
 SvV8UNikps4320cIhw9ReyeRRGnrQBUkcHzasRtjsLFkB69RDETRd6XqCcAkCqWN3Wsg
 Y4xr1zwSADKtWdkePL6nH1g+jv5kH7b4luJeBeyuMb3L2qXfjCoiWlJOH7fAiQ7z6wYM
 SD8242/XRetDd1M62Ol5gfhrBEv5trlMp0US1KWsJ7O4CxRt9lSVP8DIfOdKb9aLUs+D
 uJXA==
X-Gm-Message-State: AOAM532BnsPeqPLKTi3RryMGELoVekAiSgpNQ7nNe4uVpR+UBinSS6xV
 RVxnioTw+nJXUMcNYRFfqNRseNXAUkY=
X-Google-Smtp-Source: ABdhPJydAmD5KB2kNPKxrN2nKYIhfwK9lEAi7TRSwBxq1PwN1jrhqyzpegVUtqkFP0kxYYApbqxqig==
X-Received: by 2002:ac8:5bd0:: with SMTP id b16mr3973037qtb.296.1602088322000; 
 Wed, 07 Oct 2020 09:32:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/50] drm/amdgpu: add common ip block for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:56 -0400
Message-Id: <20201007163135.1944186-12-alexander.deucher@amd.com>
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

Same as navy_flounder.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a84ea80f6d6b..82c03e9f55cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -626,6 +626,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
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
