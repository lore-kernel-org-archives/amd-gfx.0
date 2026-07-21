Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDEEC4452F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD51910E932;
	Tue, 21 Jul 2026 11:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lSEvWEOf";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A99210E931
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:29 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so312289066b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634207; x=1785239007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+eUv84IbkpwWJOUmbAcq8neBB7ii1y2kjYFuh3GeXI=;
 b=lSEvWEOfUt6Kvvpxr0KPtD461HMePOanjMT3p6fs3BDAPBkm1I/+fm5wjmerZB1GK+
 ARB9pWbriQqMlO0c/viIyPX3ofACuJLJFRcA3mE12Xosa4d8VDrWRPdijaq3cSF0U7jN
 xo5gse14u+WW/b03x+OkN7KtEbefNXE0jfz3FgVHvqjExe0Ctd6nJ5QIbeRJn/wBALKQ
 d5V7hN1cO5J2Pxa9//e6/+aNoufaFbKVJ523las+T/QzNhjfP8nkgSgi3vebN3K7b88n
 AsVuljbScb7g6g2SynwDmyASJvi6BGzh3EryhmOgOBja4pUkF1rfWLPt+Qvr5FiRGaDa
 DdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634207; x=1785239007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+eUv84IbkpwWJOUmbAcq8neBB7ii1y2kjYFuh3GeXI=;
 b=B7Eaq4nArq/txBMl8BN0MIgLag0o0kj8kVqFoxhdvRyiFSlGdX4evTdO/8L3fJsAPB
 TlNsriGBMvSdIx+8EJvG0C5HemV5QDv00Z8jMclJVg8CwroAhZgWQk6bFd123fdGuTt6
 BeVw9fTDzRcN2oC6YJ/WRy7FPlSyedlCEFIErM2iL+6mXFXVUwvAQLIg9JWw9kfJV72i
 uha0o4VLdYDwFIspWmk6YqoqriOcxUV8GJdmlP1Ha2EEPuQeiCh+ANfKlgsILwEgPSZw
 nnxm6CP0asL8FQE9MBEp+uYuIzU8QFhggBMm0iEjFBwre331ldRgvmJFP+mIb6fY7RpV
 qkXg==
X-Gm-Message-State: AOJu0Yzps4VFH5M8ss1qAm5bDftJnda79iAAhPgyRPCXnI8Anl6dF1yU
 QI9+zCv0N5qqub2o2G296fj6HrCm2AUMrcoBfCYRtXp5MQqLVTc+CmIgsiyZcOYP
X-Gm-Gg: AR+sD13w3QgSUDthBiYgTmxpxpFpkLxyeQAGaPXmyafBJvlUraXAumqzowjW4pO9/bt
 MvTX8zf4oqExRNLEaik/S9HkcnJTEANEjzKLDJPrnCjLYlRkJzUjw8eb8tH4X/gOb+GBXuEYLUB
 spLogL8tnS/erXM6rDlRU+tIXudgO1rvhcX6a8B5a8k/b0nDi6s0/Uiz0sNtVotEQFiU/gFZ2E2
 rc3ovx63H4ER4kmskOG2yxNQWWXDNkq1IZmCejQDw98VK4SMBkTp6Lug52fGXHy6H1UxBXPN7DE
 tkLv1Iik1bK4mPcHdFEWyPhDZSBHeyq7CvIV82mvuud6svClmilvxbDjAt3MyYBDlgXfcb52k1u
 cedx32eArsjfBR41viZaIpPkRyuJLL2W5XwAqeXDCnGR3kqw+286sfy/qOm5iWBG8y42LwgHl2K
 co2j7yB8c8xkoICVt9gS6eiwbbZz93UJHeY5XvWvNHOsw=
X-Received: by 2002:a17:907:1c9f:b0:c16:9af8:c77e with SMTP id
 a640c23a62f3a-c16b46b642bmr674150966b.1.1784634207324; 
 Tue, 21 Jul 2026 04:43:27 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 1/9] drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable on
 GFX7
Date: Tue, 21 Jul 2026 13:43:14 +0200
Message-ID: <20260721114322.17535-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX7 supports KIQ, but amdgpu doesn't use it.
Change amdgpu_gfx_mqd_sw_init() to only allocate the MQD BO
for the KIQ on GFX8 and newer (that is, TOPAZ and newer).

This makes amdgpu_gfx_mqd_sw_init() usable on GFX7 without
any further changes to its functionality.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9d3b40c385c9..d763f0baf0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -419,8 +419,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		domain |= AMDGPU_GEM_DOMAIN_VRAM;
 #endif
 
-	/* create MQD for KIQ */
-	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
+	/* create MQD for KIQ (on GFX8+ where we use KIQ) */
+	if (adev->asic_type >= CHIP_TOPAZ && !adev->enable_mes_kiq && !ring->mqd_obj) {
 		/* originaly the KIQ MQD is put in GTT domain, but for SRIOV VRAM domain is a must
 		 * otherwise hypervisor trigger SAVE_VF fail after driver unloaded which mean MQD
 		 * deallocated and gart_unbind, to strict diverage we decide to use VRAM domain for
-- 
2.55.0

