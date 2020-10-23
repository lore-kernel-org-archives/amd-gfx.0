Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93CC388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 15:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1047520770
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 15:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC6RdHw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1047520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9915B6F8A3;
	Fri, 23 Oct 2020 15:20:51 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58B46F8A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 15:20:49 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id e6so1181693qtw.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lhwnAfyibP/kp/UZT95g3YM5vHptC9XQKrCHgo7Mc8E=;
 b=YC6RdHw1vZCncvHeul/hjEiICNQM4IZjRrBTznaucCSiHyTALotAaD2dZ34A/GWH/v
 QQuI2t2PZhW+0xXeIMokqMJWAE34gnGFZBW0SWc6eCfQTtIOwSGYSjsTYLq8HvyogDwL
 mYmeszpRhENXRY3xEPZJXqaoruoekMA9+JU2m+sBnesI+8LvDhcnEA1ngTjOnqGczQWB
 o8Cg0p71TGB4gPKHZunNIZd8KKc2Dhptw1ZWxN9E8neUr+J2ePpKpVkIQufTeqjKrOOT
 pZg2jxgFehlONkEBI3SlHzHt3/k2JDPkGhgFtDNNWfObXAOv9BTU4/PMSMdEEYlhTGZL
 rTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lhwnAfyibP/kp/UZT95g3YM5vHptC9XQKrCHgo7Mc8E=;
 b=a863tQ+94gsBsJxIlzUQVLXWu0eow/Rkv5ogT/telAP4lIagEA3cdIl5X0o2FuXd/8
 ttrwFj46QygoyXlA18HAEXo9qcGQwTxpApjVpD36Id0vbe+9S/9vLogGwcWTIeT+3jZe
 4xTpkmMqiLfMX1x0UPtV5Bfnt3AFwrOt76ZUcvuea0GUiwLVSGoBrvErflDtUD2nKBTm
 wOhdLm5u7Q6V4J82HLm9csvFGKBsAHZ+VO8I5MC3L5dKCN1zdSyH8CnEc8RTnyEvZRfK
 i7jhifE3jKWxV2qQM1gzw7tSjy32GDtjP7EURLGl3GugMy9MUSDrPE4CpLSvInYO8igc
 ol2w==
X-Gm-Message-State: AOAM533txUKqKu3O6k1dqgQyxRzVXkwuj5V384G/yIXEtwkBNVEnd35L
 Q6BUcwIfAQht/FioTO2FkDV6dAhBG/s=
X-Google-Smtp-Source: ABdhPJy4Kz62dfqkibL3QGR7bRWoqZsXPhYwafOGG5Jrm3kB86L8V1+LZo5LB40XXLo/PJ88qOq90A==
X-Received: by 2002:aed:3ec9:: with SMTP id o9mr2596127qtf.185.1603466448938; 
 Fri, 23 Oct 2020 08:20:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id i20sm905824qkl.65.2020.10.23.08.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:20:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Enable GPU reset for vangogh
Date: Fri, 23 Oct 2020 11:20:33 -0400
Message-Id: <20201023152033.373128-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201023152033.373128-1-alexander.deucher@amd.com>
References: <20201023152033.373128-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GPU reset when we encounter a hang.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a7c95b3205ef..0601509f4262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4178,6 +4178,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_VANGOGH:
 			break;
 		default:
 			goto disabled;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
