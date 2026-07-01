Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF647C43602
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8310EFEF;
	Wed,  1 Jul 2026 16:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZgMMV/c";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AB410F000
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:43 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so3650875e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922661; x=1783527461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxAXRKeX6/H4VRe5/Fx6stfz5B7QeggGjmb6J7LfULg=;
 b=SZgMMV/cLdhPu3Y+ZI7Z/fBvsRCpitqa7WP1QCmZnM9c3cJs10t0Qmnr+dXvZYl+lR
 63zlgRmJt2LXHFOVk0c0egWAtnDF/lhef0ksfBk4mHNIr533mXMq3rIdLTnltCS4+TOi
 UuaQChSTOleOwEjHZg4aPBcCjrPFpH2MXVyhsyrsXLlPQRlreyWcpvY9FPQd67pgwgrG
 VuW1FzXFlNZmMVhXTWgevjyRIT5pb8OhbZmn0G5PcyA8LohJrh8LMtjfXYugo8niDvxx
 d871Nk1ESXJqBYmsiqCD/+niGBlwtYge0EXX6eywiZ6HPcDbErVsI030IMsmbUEEt6Qt
 Majw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922661; x=1783527461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yxAXRKeX6/H4VRe5/Fx6stfz5B7QeggGjmb6J7LfULg=;
 b=eRZGKqeJCtM2rbl0TX1iX8cTyWrAWHCmRZcupn44s/CEdV3/d78fQumSyslBuIGV7O
 Evidmcw4y5EteHoQHuZGT4eoeVVcwgaFHc8UtRgxf+BQHJMGYL7HK9TbSfSdr7SbbYnW
 +MK5YbmovjRBM34y9OWx3vRs3KkTB91wUKuSlqJqMyp8DRu0wjs+8B2PcgEJWytfvtJ7
 BV8/syJTbNtmmuw/xS/a2zlT08GbUMoic+K+UnLNFUUbeQiRgjpQqsd+AOFQSTG5D2cQ
 0UXUUFu1iwBePGw685LTLbQN7g46Cb4nQ4Yxwt8Y3A9PiSLajamcSdt7xK3b46RBJJu+
 OhrA==
X-Gm-Message-State: AOJu0YzZWA5mYI2kzkOxAjFm9Ot26vZWigOSvL64h66CMvEUX3XjNhvF
 NfsKqlsw79vXvxmCqsi0wmC4vos8TaHUKVHjT8R4aqfs76KrkSGGumqSe2SNLUZG
X-Gm-Gg: AfdE7cnEoJvsZJWh+DAbpXJclO5R7CHOrsyPFhVECfSaGbwKRMQUCa7G9Rw7b4igqJx
 EuwnT/aTU38ibvC5QNhkKbxilFiuISg9zPWLZOdhgrqda4YjEQQOvN9wkLbKkbhbGmFyV5dHIAF
 JITLq/qDF8q7RVvZz+m4fouC27j4vZpO/e1XTooABze4B5kq3kzJHUSuVES3pvpOvS88aUxgzoE
 rQvHbO4X8cBodbO6VcplUWJK+KGpxCDWRHTwTGJxv7TPWnrKViwYxzvJ7IQKQlpo42BEyAHsP9h
 KoMmxW0+oKI5l1HHyAeIPAS3l5N+n0DRwyTiTIWvAGlxEEXIKI3eZj5C/8BTL+1XvzwdMXmomUo
 oycg3oUA7i+vTwlrlDQRYjjl3+8tgpQqI6An4iDbktI/uTNcbGSggk4vtkGNdJc+ygGciA/qRZ8
 C2A//Toz3XA4E8TI3r
X-Received: by 2002:a7b:c857:0:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-493c2b4cdc3mr23639915e9.10.1782922661139; 
 Wed, 01 Jul 2026 09:17:41 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:40 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/14] drm/amdgpu/gmc11: Pass cam_index to retry fault handler
Date: Wed,  1 Jul 2026 18:17:14 +0200
Message-ID: <20260701161721.85681-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

This is necessary if we want to make use of the filter CAM.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c40d9c467204..18a53b9df77f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,13 +108,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
+	uint32_t cam_index;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (retry_fault) {
-		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+		cam_index = entry->src_data[2] & 0x3ff;
+
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
 							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
 		if (ret == 1)
-- 
2.54.0

