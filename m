Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF86FC7EE29
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 13:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE04310E317;
	Mon, 22 May 2023 13:06:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77AD10E310
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684760463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5GS5iE0UNqVQ8KlXVjYhcfn3nzlvTGZU1mxp4La9+mc=;
 b=M21I7rp5InP2WlTtikqk9ghByu5/sIftBvgJUc0rvxeZcIhDSxPhEKGZZlCiV82d/SiT/d
 K21Mi+wFC9kDL73ZKKbZyBeYbhNq0TwyU3BZlLG3zgPWrqoe9o3peJFuLs7iwkAz6d/jRF
 muhhwc+a9KV6wTFnZ9LbHtafmydZTjI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-exPtdbO5MYSYSFQMNhdzTg-1; Mon, 22 May 2023 09:01:02 -0400
X-MC-Unique: exPtdbO5MYSYSFQMNhdzTg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62387e4de2bso82919346d6.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 06:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684760461; x=1687352461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GS5iE0UNqVQ8KlXVjYhcfn3nzlvTGZU1mxp4La9+mc=;
 b=U6xsozf1St8qJvbBgKjzm9aDQULHt35hRqTZmQtexVbE9G9r/dYIAOriY09uwiuF40
 5TUNbK3Yy4zh4shc+rHLd/e/CyruJzJcNVfHcFxGzSKVk/a0Mqq/pDF2c9Mi+p0IRYgi
 rJymXElsWPTwacfDPrAl9ro2o2i5Q3A7hA9TLu/pvj9pcLTPXxticCyf2B8TIYHeJcPO
 yaKoZNFcOlogRn/DxZW6EKn5/gCwXvgOuEyqNaJ0nsz7A5y4iNju9jlnzI+cVGIeIDWe
 F5nYKbsChGkK8semawoyXLi9t72g1aPrH27bRl7EmKjh0JtRQA8jcBP5g6jT1cxT2Ar1
 SRdg==
X-Gm-Message-State: AC+VfDzLoGJjXe/OZYuA6ZSotIZpAsKaIzaKl3bmPPansowhQ/PBhaH3
 ZHBO4/ABu9mmM6p6XKYKakwWOk9ZdYoZAZ6bxhtXJ9EvCNR4ymznwHZyQAzAu6WrwkERMqYlAyy
 N32OT/t4O0manHDt3PGHN5iQhiA==
X-Received: by 2002:a05:6214:d4b:b0:616:5c8b:582 with SMTP id
 11-20020a0562140d4b00b006165c8b0582mr21098478qvr.37.1684760460922; 
 Mon, 22 May 2023 06:01:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63Whwh0WVrdsRNMd+E6lr3sa4LBlkXrJV87h21RAe+9pE/lhzvsvDrelDpNH940vcQ+EvwJw==
X-Received: by 2002:a05:6214:d4b:b0:616:5c8b:582 with SMTP id
 11-20020a0562140d4b00b006165c8b0582mr21098447qvr.37.1684760460644; 
 Mon, 22 May 2023 06:01:00 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 u13-20020ae9c00d000000b0075783f6c2b4sm1678924qkk.128.2023.05.22.06.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 06:01:00 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Hawking.Zhang@amd.com,
 tao.zhou1@amd.com, le.ma@amd.com, Felix.Kuehling@amd.com,
 lijo.lazar@amd.com, Amber.Lin@amd.com
Subject: [PATCH] drm/amdgpu: remove unused variable
 mmhub_v1_8_mmea_cgtt_clk_cntl_reg
Date: Mon, 22 May 2023 09:00:57 -0400
Message-Id: <20230522130057.1066607-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 May 2023 13:06:46 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:760:23: error:
  ‘mmhub_v1_8_mmea_cgtt_clk_cntl_reg’ defined but not used [-Werror=unused-const-variable=]
  760 | static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] = {
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3648994724c2..00e7e5db7c28 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -757,14 +757,6 @@ static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
 		mmhub_v1_8_inst_query_ras_err_status(adev, i);
 }
 
-static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] = {
-	regMMEA0_CGTT_CLK_CTRL,
-	regMMEA1_CGTT_CLK_CTRL,
-	regMMEA2_CGTT_CLK_CTRL,
-	regMMEA3_CGTT_CLK_CTRL,
-	regMMEA4_CGTT_CLK_CTRL,
-};
-
 static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
 						 uint32_t mmhub_inst)
 {
-- 
2.27.0

