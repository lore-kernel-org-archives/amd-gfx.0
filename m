Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C313BC6FD20
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 14:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDACA10E5F9;
	Wed,  8 Mar 2023 14:14:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C53310E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678284686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m81gFkR2y1XD7ZSB1IHW7cdgZ+75l9heGqDR7NPaKd4=;
 b=JH6YCTjSyeaOVAHrPSBRmAwnuhjMogbaeCqnHQq+yIBu4DshANB7Q27awUINA+lE0wsP2G
 sVw2/dTzLTrFI7CKPla2f8hzlSIZm3ODZEJeWHsPQ+uX9s/IEMlxr3dwQv/btxaxM93ddP
 ehG7BBbY14C8na2CXViQoCeWjJ86bzU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-SDmAQ5-AOUW0sMfK2znEdA-1; Wed, 08 Mar 2023 09:11:24 -0500
X-MC-Unique: SDmAQ5-AOUW0sMfK2znEdA-1
Received: by mail-qk1-f199.google.com with SMTP id
 x14-20020ae9e90e000000b007429af46d5eso9344834qkf.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 06:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678284684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m81gFkR2y1XD7ZSB1IHW7cdgZ+75l9heGqDR7NPaKd4=;
 b=FWpy1ChysP7eXM68WlQCns3ek7UrdLy7rxszFRJm6mRVW1kuA0dr3hZIko3QQslfnY
 UMZRRQRGXzvUDC7vy37oGyDRe5gGk3TlZiwCJ2ggzmH3iXbtC8cKrYlgNMHfS77UFJwZ
 qFdIBrBINGYN+9M0ynNCLzwszucdARDlwmSciNWK7ruCQao/KISsW1iJHviV5pZq2qOn
 IEv3tfYrvGqI4/VEHWGJfYeKSMKPsH1WvekTUBxJ6O/Q39dZ656C+MtQy6Lm4tZQOkZv
 gCvl8CvoOi9p1SuU8WwmxxRowyzLAhvXloSJrezHoxHKy7Fv9Y70oByFJYCobFjrO8f/
 GQXg==
X-Gm-Message-State: AO0yUKUR/DrBbwPszFqnlKV9WnfG3OKxrQdkvLgYnyIAT+SbJOdZtVBc
 lsJWv7YD4+ytu5VB9h7bk/clcen5C+Lp96QKCV9bUrtWUCuGvMvApHiGQyl627ZvZJAy/l3fP0D
 ZLQ5N8ChVBZW1K5xPZoiprZ3zlA==
X-Received: by 2002:a05:6214:202d:b0:572:6ed8:e494 with SMTP id
 13-20020a056214202d00b005726ed8e494mr36527169qvf.18.1678284684065; 
 Wed, 08 Mar 2023 06:11:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/PozfFJrQLJrJyxgwp36xRY3RsiKsiNwx4ETYM7tgGHq8Lwp8dvr5WLBt6+Jo4Oiup/CBkQg==
X-Received: by 2002:a05:6214:202d:b0:572:6ed8:e494 with SMTP id
 13-20020a056214202d00b005726ed8e494mr36527115qvf.18.1678284683835; 
 Wed, 08 Mar 2023 06:11:23 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 q79-20020a374352000000b0073b27323c6dsm11187764qka.136.2023.03.08.06.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:11:23 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, wenjing.liu@amd.com,
 qingqing.zhuo@amd.com, Jun.Lei@amd.com, mghaddar@amd.com,
 candice.li@amd.com, aric.cyr@amd.com
Subject: [PATCH] drm/amd/display: remove unused variable available
Date: Wed,  8 Mar 2023 09:10:57 -0500
Message-Id: <20230308141057.2010361-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Mar 2023 14:14:14 +0000
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

With gcc and W=1, there is this error
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_dpia_bw.c:297:13: error:
  variable ‘available’ set but not used [-Werror=unused-but-set-variable]
  297 |         int available = 0;
      |             ^~~~~~~~~

Since available is unused, remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c   | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index f14217cc16fd..2f0311c42f90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -294,7 +294,6 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	int bw_needed = 0;
-	int available = 0;
 	int estimated = 0;
 	int host_router_total_estimated_bw = 0;
 
@@ -373,20 +372,13 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 
 		// 1. If due to unplug of other sink
 		if (estimated == host_router_total_estimated_bw) {
-
 			// First update the estimated & max_bw fields
 			if (link->dpia_bw_alloc_config.estimated_bw < estimated) {
-				available = estimated - link->dpia_bw_alloc_config.estimated_bw;
 				link->dpia_bw_alloc_config.estimated_bw = estimated;
 			}
 		}
 		// 2. If due to realloc bw btw 2 dpia due to plug OR realloc unused Bw
 		else {
-
-			// We took from another unplugged/problematic sink to give to us
-			if (link->dpia_bw_alloc_config.estimated_bw < estimated)
-				available = estimated - link->dpia_bw_alloc_config.estimated_bw;
-
 			// We lost estimated bw usually due to plug event of other dpia
 			link->dpia_bw_alloc_config.estimated_bw = estimated;
 		}
-- 
2.27.0

