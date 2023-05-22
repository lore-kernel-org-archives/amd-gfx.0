Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9953C77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 13:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3220A10E31B;
	Mon, 22 May 2023 13:06:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DE910E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684758623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9y4gjNLxaDEH24wDgPXKc3Vz5FcUbglHfFP6OwJ8o8=;
 b=e+8ABH2Hr6XRv01TWzWENYGo02ty0LL03ZBWAPlqIfpoodEtgqxFaTFBurJOOVLEvd258w
 fNmUdx9E1ypaSooqBh5G0v9mZLauFyMBE7QKTUe2P65oeGySmLCMksUyvsN7KArL02EPTx
 kvB870eB/eJDXlsLgW97ZadZ6AQqLL8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-mOTus00rP2qN-tIAqiWafw-1; Mon, 22 May 2023 08:30:18 -0400
X-MC-Unique: mOTus00rP2qN-tIAqiWafw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75935a16b8eso468644985a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 05:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684758618; x=1687350618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9y4gjNLxaDEH24wDgPXKc3Vz5FcUbglHfFP6OwJ8o8=;
 b=brlo/sBt2Xd4yHllW+h3xCrrLP+V5vEIzUYHRKdgS3zRvxulPJIkdcizYL+VHRXE2Q
 uYNpx3XnTvkKmoGpyHpIlLXX1iAF5cYubj8oDTJ16JiH1t9upp5/U2nB0f0Kw1ccfS8P
 xrrlxLRl4jvV/dZjoKP+DbcGbHkSjr+sAJi/tWWIwcTPS2v624wVDErabb2Gi11pk1Qe
 wLwDBWg8Gwb47sK9av9IKOrEQJZU83sXk7A+0x4N12xpunqi5mV7zRsq8ZdCSoG9z304
 UC08Kun107XRPdzt3VlCUid4wWDg+EFbFIaqH0w1EiBwstpYxF8cqlYL5/FkPODTYLP3
 EHMw==
X-Gm-Message-State: AC+VfDz8LlLYzEF+PYHWT/XSuC/GnLErHlUaMEeCV9d+obmU+jMJMdvR
 FAxj2+gxBjZZNKr/H/xAcplWVYEG+VE985Ah12lo3eEoi0DmsH1WALRqwyLVuN1f57mv53CcfbH
 MQeO9lLjUnwk/omLV3eUxhmyhmQ==
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:e7cc with SMTP id
 i5-20020a05620a0a0500b0075b23a0e7ccmr452019qka.45.1684758618194; 
 Mon, 22 May 2023 05:30:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UrjSsJpTeaszPdkFwHOjVAMcErGGwfWpKAhK1T9BLt1EUApD/wnEnOkzOo2gzy/Phl2q3lw==
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:e7cc with SMTP id
 i5-20020a05620a0a0500b0075b23a0e7ccmr451993qka.45.1684758617966; 
 Mon, 22 May 2023 05:30:17 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a05620a153a00b0075785052e97sm1670399qkk.95.2023.05.22.05.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 05:30:17 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Hawking.Zhang@amd.com, le.ma@amd.com,
 lijo.lazar@amd.com, tao.zhou1@amd.com, shiwu.zhang@amd.com
Subject: [PATCH] drm/amdgpu: remove unused variable num_xcc
Date: Mon, 22 May 2023 08:30:13 -0400
Message-Id: <20230522123013.1065975-1-trix@redhat.com>
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
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:2138:13: error: variable
  ‘num_xcc’ set but not used [-Werror=unused-but-set-variable]
 2138 |         int num_xcc;
      |             ^~~~~~~

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..63718cf02aa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2135,9 +2135,6 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v9_4_3_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int num_xcc;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
-- 
2.27.0

