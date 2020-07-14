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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02329C433EC
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECA0225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e95v1LQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECA0225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7A46E831;
	Tue, 14 Jul 2020 18:24:24 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5B26E830
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:22 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id c139so16495306qkg.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=imMyX4ulGgRQ3phHGCYYAOyLQKzVrrwuDR95xIEr15Y=;
 b=e95v1LQQPLsAqqsv1SXci0DoR0U00o9RTjpI2KYAv64mesErO/7mQyMS11Af2Nzr7K
 x1N2LiRSwdb5hHsuynIhwXYWDgPcrIxvgeriHXBvlYIJQBad9rYr28vI5kYEoyNj/2sv
 VcDivwOfe0xuiqojllZY3bL8ahTuUNunpOMsOmuxRZdMmpwrS09OzJrgF18aPZvuvffr
 GR3OazNCxx42ien6XfFu7nqmHcnX98wxd2twqeWZQOE5daQU/E+wyWVI2SVGmYPgfccg
 n2dqovV0+4fIIiL2zZjrWjX3aB7tuI10qhzGxQ707Mx2tlJMygtuxNP8lFtHm72NyGzk
 SNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=imMyX4ulGgRQ3phHGCYYAOyLQKzVrrwuDR95xIEr15Y=;
 b=p7RbMvo+vNetosWCMiHK/GQo131daRJcM07fXOVchXc6GmqkOn+6vfS0uiGYBqEbh0
 TLxUdk26p9ltu7EEfOEgirs5IwLaPXTXKdonihcqZmQXlkCAF0bNn5yPZa0wy5+ksb8t
 AK1yjRkqqXL1E1VL5L+O7r/ZYv7Dc72xtI0FadVcGVqFXg8DL3ym+MiRMN21qNYYaRzD
 TOhz/UoHc8Vr2Tc7m2muoW33v4MUEaXcXtQWjTcczif5txK1LhbEIv9indgEU5w1Rs1n
 Gx056s+Wa9xZFilh/5AAXuGF4MYB+UAnDK4wjAHuL56aiFSGYPLr522dbomJUKIBjmz9
 Qhfg==
X-Gm-Message-State: AOAM533k8mFpucNaLsVd8o213WQqn6Vex2j+YblL/cFuiLr63xfVLNG4
 wytVqOw60hqACLBEVTWzIPxhF0po
X-Google-Smtp-Source: ABdhPJyErTiyhzb0bppaCTywTHLtFWbOck6vvQQ+vLS9M1m4wVhDEL9crX5PUjI5+iiDsGZ1Mg/qcA==
X-Received: by 2002:a37:4050:: with SMTP id n77mr5775562qka.431.1594751061710; 
 Tue, 14 Jul 2020 11:24:21 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/42] drm/amdgpu: initialize IP offset for navy_flounder
Date: Tue, 14 Jul 2020 14:23:21 -0400
Message-Id: <20200714182353.2164930-11-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

since navy_flounder has the same ip offset with sienna_cichlid,
follow sienna_cichlid setting for the moment.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <Tao.Zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7c551dc2ccdc..a8260a51432a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -411,6 +411,7 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 		navi12_reg_base_init(adev);
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		sienna_cichlid_reg_base_init(adev);
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
