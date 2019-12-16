Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331EC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 21:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFA220665
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 21:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAhhi1gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFA220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212646E8AC;
	Mon, 16 Dec 2019 21:29:39 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E398A6E8AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 21:29:37 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id b12so1349592ybg.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 13:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MX5YVLc3X9hfzzCPaMfzTlfxrVE4GN/iEobydc26kdQ=;
 b=dAhhi1gDakbLnxifjJdMjuXa3oKttg4e/0eSB4u4ZlOXZfciQIfTRG7J1QoVzIkoB4
 yeDZJSNXHVRlIi3LDA1QxG5t9yTxBV1f4CZfZOQWq/J1dac+E+JL92HbFkDBuPTmCnRj
 TuUdoJ3rZ2zUIFcBixmgDT0C+82HkzOnWdcFRFjKfS15HnJQ+erFhBsDa2Gc8rUz/Vhr
 TJoKEXJBYtdapyKltGzNoMNJRhqLfnOe648I3b0XCQI9yqpM32o/W/b4daSAAsi5D8St
 J7llm0phPALd2T6vcKIocl+m5diZAplYe3S52yyG48VpjyUOzpTUHhoseDnlSIs4JlOz
 YfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MX5YVLc3X9hfzzCPaMfzTlfxrVE4GN/iEobydc26kdQ=;
 b=cp8qXJEQ4IM7jbe+7pbpIXRi655PAeAzgo/+ER7vc0UJ7GrtF6dqdEaRL6rlL036gx
 ibHgox8Y7AN6w4THM6yYyNwlx00FiNbtiaCZefVjZQUc3on15xXH9MEeC7/nKN5l0ICZ
 Yuwdejlf18r008DwYxRpEKDv2iWNfKLMtrK9jfUvN+Aatx29Db/ferdSfL+9FN/CaaS1
 5Dd6E5ropABPAefqWUXvSsMzCUbKQZdj5GBy/o+ayFb4f9y1hTZR+Or1KyHkMnj8ZCiK
 lFntwN7+X2cpSugALZst6pxh1DgU6NP9/+wdL87xVbS5Q5ihhu+XHoMdNvAAJiUdTI0Q
 P4Lw==
X-Gm-Message-State: APjAAAVfIj1fDeJwho0GK3p5B61zNwxh4e/dR9PM5sX1za9ENPliepjn
 4U/Z5A4wjAz5OEBBfzMSOszoD/fJcoQ=
X-Google-Smtp-Source: APXvYqziRGDC2NYGqRCaKNLeHTaZHZzgd4cIwyzBMq6LQvFB6gQ/i6CfTz/S0uzUpX73tPdPaGem/w==
X-Received: by 2002:a25:7451:: with SMTP id p78mr22349368ybc.229.1576531776830; 
 Mon, 16 Dec 2019 13:29:36 -0800 (PST)
Received: from brihaspati.amd.com
 (p200300C58F249500830CE7316915D0F5.dip0.t-ipconnect.de.
 [2003:c5:8f24:9500:830c:e731:6915:d0f5])
 by smtp.gmail.com with ESMTPSA id x184sm9133968ywg.4.2019.12.16.13.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 13:29:36 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amd/amdgpu:  add missing break statement
Date: Mon, 16 Dec 2019 22:29:52 +0100
Message-Id: <20191216212952.34442-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 8c066a8c7a9ac9a66 (amd/amdgpu: add sched array to IPs with multiple run-queues)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f5fe60465524..63f6365312d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -160,6 +160,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 		case AMDGPU_HW_IP_VCN_ENC:
 			scheds = adev->vcn.vcn_enc_sched;
 			num_scheds =  adev->vcn.num_vcn_enc_sched;
+			break;
 		case AMDGPU_HW_IP_VCN_JPEG:
 			scheds = adev->jpeg.jpeg_sched;
 			num_scheds =  adev->jpeg.num_jpeg_sched;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
