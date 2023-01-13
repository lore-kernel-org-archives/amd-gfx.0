Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E8C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 14:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E5710E191;
	Fri, 13 Jan 2023 14:46:58 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D535D10E15E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 10:07:47 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id q10so1246516wrs.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 02:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LgdeVYZ+deMRc/ei+kMH+4SXCwx2TEgssACm0boSjEM=;
 b=aOdehrQKCnmwEtX56FiU6NCxjPIOxuIzXVpC4QiHmPZZfby+fTkgW3dhSZ30bzAFEO
 Y2gywrOWSy7zPamNyLCa2YDVNJfJlhzq0zdCGsjAkZ/fE8Wh8Ev6ZXXrozy4BBe6yn4Q
 pUR+xr5aHbRnxR2gdgmWO+Qu+/VlILMMP1SWIcitWSmGt/GAljeuN43l7Zc/izzsBxHw
 totc1kX0LN9AUAEyA4GqlEPHJ93aWSTWZN0vwa0Qp5pGXXDq2DDyqYRayvKcySkyCtBU
 0wQCZzW0DJF9Mcr1JXtY3NQHRSKfQaeHOTuBGT6Rm5CQXkm1RWFAg8ZnHpEXgxU1pxEF
 Rddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgdeVYZ+deMRc/ei+kMH+4SXCwx2TEgssACm0boSjEM=;
 b=0QsTLBSge2fGW8z8sehP36PIktN7Ev2I1xCr5QDdqerQMWBeXLxYgEmWUGz6F6eWXq
 EGw0dIeyjlbnQR5vvC63UjntUcv9LxyE+mEHyEytZ4gzY3WOsAnuM6K0mMT5j7cTl82D
 y6TZYLL2AIOVsKvfM1BBMg0cgAuKGwqD7mlbBWs/NjhmhEZluFzkoA+YjKKFS22cASSP
 NOj7nD/AvjXoiJIRgY8ZN8suDRytsmSshrk46cTPVxATZuAO9dJgkXIxo/Axr4XSENui
 1fkpTXGcUVKP8vIWnfiCR9EA1XFVhUUxrnKa2+0PpjBx1l35m1X0xwZ1EOmNfXkvETV7
 bSLg==
X-Gm-Message-State: AFqh2ko/JyzLdV/u8MkyXTdhGxSF8w5/0KKx50oXXoF7D6JW/GflmFPY
 8yHeC/EyClX7dsndjwbd+TA=
X-Google-Smtp-Source: AMrXdXvsko1ZJDxi4t9nddmcNn062AcrE+xH8KlU5ueUwz/6CI/UwTOcW8zDwjENTNO4bcjlJLKg7w==
X-Received: by 2002:adf:e193:0:b0:2a5:74c9:a8c1 with SMTP id
 az19-20020adfe193000000b002a574c9a8c1mr22046389wrb.16.1673604466261; 
 Fri, 13 Jan 2023 02:07:46 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 bp28-20020a5d5a9c000000b00273cd321a1bsm18564014wrb.107.2023.01.13.02.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 02:07:45 -0800 (PST)
Date: Fri, 13 Jan 2023 13:07:42 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Add a missing tab
Message-ID: <Y8EtbpVGFJSDxM/m@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 13 Jan 2023 14:46:57 +0000
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 kernel-janitors@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Haohui Mai <ricetons@gmail.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
 Lang Yu <Lang.Yu@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This tab was deleted accidentally and triggers a Smatch warning:

    drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1006 gfx_v8_0_init_microcode()
    warn: inconsistent indenting

Add it back.

Fixes: 0aaafb7359d2 ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX8")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4fb577d047fd..b1f2684d854a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1003,7 +1003,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
 		if (err == -ENODEV) {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
 		}
 	} else {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
--
2.35.1
