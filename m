Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF612C5B56B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DF710E6C0;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFxOaEcR";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0762110E021
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 12:11:50 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so6266125ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191109; x=1786795909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qqtodrANULHy2HebqvyH0gpSUnDrF1cP92+56xd0b6c=;
 b=IFxOaEcRABrCwxu+m9I5y17uFiTiKh6aa0dQaqgiinMoGmEMA8cFaTs3WkLzouHmHo
 sgWtv2kVBkiwGr4YHid0mA0/+oq5+vEoWq4W9OxQ4IgMD5OQ7L555VeKuB2yiEXmDRIz
 T7XLL6KF/nQ3r8vcIdfPW/QRmyXCHmGm50VmGGjK9Mgz9lV6qYjjuu09PUxx9aNwnnOq
 dx7HlVBmr9jybSUtEbHJK1Ey9rQZ4EmN6E2clgb/L6mo+k5zbVf3OzMey+W6QmZghP5O
 PZ9H6YOkAuXGcaj9AMekVLxMJL0x1IKaWIXismZEUZqSSLSntelVqgayxeoFXr8XFR28
 ZOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191109; x=1786795909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qqtodrANULHy2HebqvyH0gpSUnDrF1cP92+56xd0b6c=;
 b=cPoA3U8OMrn+NqtlDOzQhvItQp4xZpEXFwzo0e7ap+i/No1IQDWRprnJi76txeRJWs
 izoFTXFlXtB4aKXOLlPIdr7NSDsXcuHOWT819APi/T0pe2mh08AH+CTLx1iFFZ3fzEBt
 hlcfjYbcqOqV0ci1if3pd0zFCdSGn5DeFZp/OEQz55dtTarUqGHJTNxE1pMXuTdtbRMo
 hcBEhGqonfQqOsHIL8OPNe5ttv1m/oD1ldjiHrSiFnMN7nMGgjy56oduhrO2xweBwEEc
 Y/VQS4HfAuSF+iYjSO0im7WJYlCGpMDfeZPwOaJzQovS6grQkEgVP05wL+E4ogv5yP9V
 9KUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRWORwaI/ViXeF4+mFKxfbo/ajWiKR7916mCx3qZLX9B0SybBFPEY0X6ZjRh/yNLjgWDIDhn+O@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFucxdZiidgKFWH1Cby0eK1FStc4T+f2X0jfLHPEH0tyDon7pH
 HdkGryqzDLxcSeghbohysS0Dx4ce8LAIBmtbeNHEAHyxmcMEQlRVv0zh
X-Gm-Gg: AR+sD123D7IAIoqqflKxltoTa1Edbvfnk+bb1yv5XoPI1Dksbxn/am27qgCayQu6xG/
 P/ghRdqEabMIFcdtmdV17WrH4jRqqI5eN0rjdpDpmRh+R3kHMWaM+AHV6skBWAGMf46rCOsb+KF
 Y3CF3lxRIQieDSm9AquPywtGfe1F7A1kITS/MFC/GKqZ6HOIFrxkqE24w0GFuA028393sUTAy1B
 /nYkPSdyCf+2WRAo36WRRtpvwAJY7cem5/TItBWmHb0ehbOWA62YayIPs2X4KmeZ8ij8t1Dw/LA
 towNYsBEhhzHHHjFHDfD+XGjewsUicglMzExK16GNC8SD7xz6+b+U0qKqgZwQ1r8lMiw/hMG+Ek
 op2J6bwTmO9qWETYLbuufICTXP6aHpq5Dk7tdwJfMKQlWK+WNkPMrHs2rUA3AsiAetqpRzzOaJ0
 JoS1cnH56Ms1W54JwU7b64MKpo9PhWVxzssTM1RsIzBlg=
X-Received: by 2002:a17:903:2383:b0:2cf:4544:104b with SMTP id
 d9443c01a7336-2d294b29144mr139478015ad.5.1786191109424; 
 Sat, 08 Aug 2026 05:11:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14dbedec6sm18151975ad.44.2026.08.08.05.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:11:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
Date: Sat,  8 Aug 2026 20:09:34 +0800
Message-ID: <20260808120934.2813010-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
amdgpu_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1aed121f4ddb..e814701bc8fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	amdgpu_driver_unload_kms(dev);
-- 
2.43.0

