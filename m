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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549A0225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSyUg/P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549A0225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C436E834;
	Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3256E834
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:27 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id k18so16517400qke.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wVxam1VV6gnYybhKuuv5Brv5NztsqPwQ/+/ts0SYGn8=;
 b=gSyUg/P7tAgi0GXDxqpqSbstdsXAxrusZpkoIYlZ5422VAAxJbFqtfz/U8EbDbhYlq
 StRHuB+FOPMqKw39WJoDu04lY9m1vW4yZwx9wuWhpm+pjIkl5WW3UYRztpfgBM2wSHTm
 wasyZ3F3DX+sBTi3scCxpKdC0+agM9rD/WvzjYhFOmbn6eV875/U4KOXxUMVBLUVYTPq
 aEjsA585MGOlr/ehK+JmjYtNeSvv3j1+xZrg3ZgxXsGOP9GqL1b4h1ZqaGIBU+A6RKV1
 M5XK+aZUD/pFmdL4W4bnQKKUWICKb14WHGybbhHxQtYgwbSN0cSn40YU4XzfA36wz5mx
 dESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wVxam1VV6gnYybhKuuv5Brv5NztsqPwQ/+/ts0SYGn8=;
 b=dm7wDt1wSg9m92blfjfW8Y9uVeMPQGTtiyTNfqWbl6CQ/9gMsj4sub8MOfyRUaYEEx
 WnizfLrYy9SOxt6jAnFi4WxgwFenpawJViBwX8w+Pn4PhuDEwEazFL5EUACmxGLnt1jb
 IG77ccb+nFC5KsGr/VUCWXFAQsCwjjxQOiCM31PdRwVWpENDsaR4eHEXbsEQL16o+qYL
 bZYMn9tKpZpr1GCmtWijN00FirBxTCp0Glzwq1NND/yd3amHeG059v9GAHo3Vlp6uS5T
 dOu/zFucAXYeKcN/w+9l30Wv9xIcR2iwaCTmCI+eCzReeRc3rSz73DbzUR/eGUwpjnmc
 4QXQ==
X-Gm-Message-State: AOAM531qrBB8XXnAWb9rIkk6JBP+DcVSTa5BVgh6hpE2GiN9zdRLauQi
 A4i5bKviDuff3Bs16Jt6iIjhV2DP
X-Google-Smtp-Source: ABdhPJxWcqUFKJs/MahXC9qaa0KfcDcp+bj2O2Q1qf8vfpv7MllpGGkq46zEkHtFWaKN0t0wCYGVGw==
X-Received: by 2002:ae9:c313:: with SMTP id n19mr5549978qkg.299.1594751066742; 
 Tue, 14 Jul 2020 11:24:26 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/42] drm/amdgpu: add ih ip block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:25 -0400
Message-Id: <20200714182353.2164930-15-alexander.deucher@amd.com>
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

navy_flounder has the same osssys IP verison with
sienna_cichlid, follow its setting.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <Tao.Zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 471dc82fd1aa..fdabaf0db3e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -270,6 +270,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		if (ih->use_bus_addr) {
 			switch (adev->asic_type) {
 			case CHIP_SIENNA_CICHLID:
+			case CHIP_NAVY_FLOUNDER:
 				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
 				ih_chicken = REG_SET_FIELD(ih_chicken,
 						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index bc0181da25d2..5990b7b3796f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -511,6 +511,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
