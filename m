Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9156C982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 01:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7A610E117;
	Tue, 22 Sep 2026 01:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxWRQpYH";
	dkim-atps=neutral
Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com
 [74.125.227.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BDE10E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 01:54:30 +0000 (UTC)
Received: by mail-vs2-f41.google.com with SMTP id
 71dfb90a1353d-5c67e5292faso1588546e0c.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 18:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790042069; x=1790646869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8cyk+VZJdV3suIAqf0J24P3aiMZPO/cLIo47aUCTTlQ=;
 b=ZxWRQpYHXv7D8mmt5aMooyFMBDyDm96y2X3ZjqM3kFAg6OVPVmoFRblFg4Ze18AIYj
 JIWjfN7DXMBbdQ3yuAx2qu1Uz7G+7NzuNXMSxlHQFeOfkFsauhI4w268jZqk4Ezia7wP
 cw7tKKUYYkC9gjtI7kzttut7pFiAAP3GjY5gdNsPF30WAFaPSW/XYA+U5rnxdkqJyiYw
 wBNqoH0SwR53V0Eb4RDoYBpcmn4AV7P7MZLcvkeJ85fgpH2Wc7b8MBPtl0M2CFmFDI6C
 fgVDpd1CnlgNjazkFnSsg8vobzBHeOnUgOc2Znlgi/iPmmBkq+/KBzMTp2QWN3Hjrsuc
 ebYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790042069; x=1790646869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8cyk+VZJdV3suIAqf0J24P3aiMZPO/cLIo47aUCTTlQ=;
 b=N66C4AfdL0fOvHg5qJEIxpsJhu7GbswUEzKkDdw+Ph000RBcSLEMlh2O6QXy0u+gbJ
 1/2e3BjJ1kZpG0JQBxor+atD0n2j+9AksFQ2xO0Epp80cSqM0FYhNkJbUVo2dFU8Kds3
 KagyPJ7MSE/bD0AWCv3jllwkacYfEkUu7ScMU2HMoj4YG/0uQkiAlfyTLjmmfgBEiUtL
 2uCOET/MWTgHIeajtdG6QXLE1fRtXHGNOBR+XnxuCPd6f90YWDQlP1Vyqftin98u6gH2
 PvXyBbNpHKR1OudonE72ro9Si8sW7jdXS42kWdzs71oPXs6wqM4hHKaGlaIUq6dhiSbd
 yufQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKEdlJVVReQFz56QJ5rnFw9DXGe9VfeACCCkBItZC3m2Hm84s9o+L1l/Itfz+Vaeto7cFSq4l6@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8ZibqGb18BisNd4Ln84klJ0rIt025Gak7OsQalDgKLuPy1TIS
 LUTmDWuST7juywJUCXMgNrXCI9/Np6Nzxks8pQrVsSx3EaNIvAOk0zZg
X-Gm-Gg: AYBFou17eq9iqBpRm0scGuYT7NZfGv9zuPzARrVDYKgpH/qSvtp7//erH1WygIz4kVs
 wvQb2aMWiXnW9tLv2rjhuKFMG1NSNXU1+Sz5lu6UDZdg1aTJufz0yiElbEbvHj9yPVBf4PJPUbo
 rGCXB/5IRqRL++M9H1xlW1LMgD1dQaDttdCScjqT8EzZyGySOUXtfUirOEzugnx6ssIsvDpUfe/
 8J0l0gq7rGyFSSVtaBQOKbDNfS0WpLCWyN/Ux0TMz+01R+TGYXPb/1dZhWuDojZj/0++qn5at3W
 aRb4nNC8h5TZKVAPj5a+1WRvFdfg2TpF2CKFGrIAyTFcNCs0j4ZxJTQ/49rbL17FKOAd5MfHFM/
 WGqsUsdU2NqT2P1M/l7vK9rRvz4OXAXhCYscxE9uGB/oy1lLc/ebKHxu1pTAObf45e1TeA7VXC9
 pUiN3+BT5bv4a0EjnCvMZYIa2Ry62/J5qUyWdd/5WbtPcszM8IJ9A7gib3+z9og4uDfYcqKMnQ9
 s10OGZr0A4K/1N5LFA/yc43CG0g1mViilRgKE7+
X-Received: by 2002:a05:6122:3281:b0:5bf:8955:a8ce with SMTP id
 71dfb90a1353d-5c9b58fa150mr7030545e0c.1.1790042069444; 
 Mon, 21 Sep 2026 18:54:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2804:5698:1029:f600:548c:a202:2a24:b2c2])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9e7d09aa0sm314462e0c.10.2026.09.21.18.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 18:54:29 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown
Date: Mon, 21 Sep 2026 22:54:10 -0300
Message-ID: <20260922015411.116292-1-williandossantosdeoliveira287@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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

The firmware requested in gfx_v6_0_init_microcode() is not released
when the GFX block is torn down, leaking the firmware resources.

Add gfx_v6_0_free_microcode() and call it from gfx_v6_0_sw_fini()
to release the PFP, ME, CE and RLC firmware.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 95e939363db6..a5553d181d97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -322,6 +322,14 @@ static const u32 verde_rlc_save_restore_register_list[] =
 	0x00000000
 };
 
+static void gfx_v6_0_free_microcode(struct amdgpu_device *adev)
+{
+	amdgpu_ucode_release(&adev->gfx.pfp_fw);
+	amdgpu_ucode_release(&adev->gfx.me_fw);
+	amdgpu_ucode_release(&adev->gfx.ce_fw);
+	amdgpu_ucode_release(&adev->gfx.rlc_fw);
+}
+
 static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
@@ -3254,6 +3262,7 @@ static int gfx_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
 	amdgpu_gfx_rlc_fini(adev);
+	gfx_v6_0_free_microcode(adev);
 
 	return 0;
 }
-- 
2.47.3

