Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB83C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011BA1137BB;
	Thu, 14 Jul 2022 16:45:24 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E421C1137DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:45:22 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LkL2V1yX0zDqJ6;
 Thu, 14 Jul 2022 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817122; bh=LtTJoOMXTYblHOmEzFD9Z9+ZWWSU7JPSs4v5n5un1fQ=;
 h=From:To:Cc:Subject:Date:From;
 b=PL2sHy7GJK/zmyS0ugXaxPdsM2NvrBgGUbCbtC1VyI1LR+HxHpmRhPm5QqDttXqfz
 ZUlD+SBOROEpyD2NjKQ4ZMynMnbc2IJh7qEEUGGFob0UZeZKXU7ggSiHoHTrNencXs
 BeiE+eA4XxWiyaOxcTTs1QHG1Il5dYngoPaFDfHk=
X-Riseup-User-ID: 5606EAEC306D01162A019378FB2E7187901FB4B30771F350631FF2AB1AA21580
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2M4cTmz5vW1;
 Thu, 14 Jul 2022 16:45:15 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 01/12] drm/amdgpu: Write masked value to control register
Date: Thu, 14 Jul 2022 13:44:56 -0300
Message-Id: <20220714164507.561751-1-mairacanal@riseup.net>
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
should be written into the control register instead of 0.

Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index f5a29526684d..0a7b1c002822 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -339,7 +339,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 
 		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
-		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
+		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 780a8aa972fe..f57f4a25cf5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -333,7 +333,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 
 		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
-		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
+		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
 	}
-- 
2.36.1

