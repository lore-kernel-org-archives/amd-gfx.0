Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBCA10FCAC9
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341B210EE95;
	Wed,  1 Apr 2026 18:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sda0i8ny";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C9E10EAB0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:31 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c18af885c0so7241372eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003971; x=1775608771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
 b=Sda0i8nyvJp8KmFeEMyAkVbYlT43zXBKJvvLdkTju/m5tXp6cShNtACBCif80XIys4
 26fbbpQoYoOuQlouK4T+cgVJZCFH6twvCtudPC/vOsH/LX1ofOKbl1pKKvHkm0MEAmpY
 82nA7zVU2657aQ6GW3IfqftElNtyX7rADKNPGtawcW5hWL947l8fS3IhEZwPUwiaHE9k
 mpq9OyZnt4MH97od70QcAgq1WLUyX8qUOg50H7vLeBwhH1inn112DhrmAkbWBXJr7u6u
 GWLLC72ZSfLYwI73L/udXmq+RDHq/Xaqlg1PbbnNbf1C29sC33oWrZ09RtZsHjJBTGNd
 XI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003971; x=1775608771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
 b=GRQdkPYo3lSdzgfbITkKMuhKus3gUSO4MLJU4S6ucjWu3fADpQtTlhrBqhEzOfml8K
 UUgyB0LUVQsEWHcXEAooUI2YLS+BSXP/S23zbLSsrYV75E0EDWcGVtWqITSMkmmrjGQS
 BsYF4oS/2rnfOwfwC9p2iWNO/rLrLkFNZOJZEZ7xIuLiJLPH2NN2+/5gtlALjtsYSBpF
 uoqim56DlNUqBwBEb/Lo2futsPhkDEm4l3/2eUf5x/r1koLLdkDHbCkZAdfcrbAtKcAj
 URMt9Kh989ysVookCD8NxIAxjlDhGSFSEB5zFKg0YlA6C5GmRY7vFz9juzKkxLGu817/
 zOfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN9raqo2CR6z0SYmA/HPspU36jOdDIlpllaNhzKltklnVSknDyK76Y/Oy6Yeyq+49m+hfI5rRl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoLbWNk4W6xv+W7i9i45jXHW0+fHJGgBgak3s1t3bVIPFLBT/V
 Q+8DsCpeBYuhssm9ui5mxlZ27VzlnYJbIrthEf/WRLmMjnCHn6YafVkP
X-Gm-Gg: ATEYQzzj8qVjnWLI0MW7kOBYBl7d5KglasjtEA85RJI9qYY5xSQQ2KWwjVxoDjcgcfD
 VfDmVNNhdLt5SHO20nUJwrfdMoSBM3ki8zsffPug8nPvggm20tNeXgxi5kWmDHZIqDFRevNaVqX
 vXK8z4/lm4MZOOlAFPXfz56LgBde4Q1Dve+zkU+06N86L752DpItvbKt4Avp8o5AdnF0JSm8IGQ
 p7jX3F17hmwZbBecGhl/WEmGN3S+rNDLIS5pY+n4dyhUaL/MIrVpVFQZNmLdVM5UBqDKtlZkRAc
 RnPcHQB4/SvJqFTrUjXRD8pZHTNYgOhlcfsnJnQnbKJm77nZfH8my0ARWu9aHvatvxJITQXHwi+
 wmQPG1W33z/nVzol2cMj5JvnqT5Bl16s9hgEgcomTUbw5/NXJL3kJryMY1wsXCwknoJiH49AyyE
 bhMpE0hYUd0eTlp4Cy1JErk4/jr6ZpPZ/dcxVf/FL/j4tPIyS3US/hWzQ=
X-Received: by 2002:a05:7300:8626:b0:2c0:cc90:a71 with SMTP id
 5a478bee46e88-2c930e6a365mr1054199eec.8.1775003970551; 
 Tue, 31 Mar 2026 17:39:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 01/10] drm/amd/amdgpu: decouple ASPM with pcie dpm
Date: Tue, 31 Mar 2026 17:38:59 -0700
Message-ID: <20260401003908.3438-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit df0e722fbdbedb6f2b682dc2fad9e0c221e3622d ]

ASPM doesn't need to be disabled if pcie dpm is disabled.
So ASPM can be independantly enabled.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d5e6d5ec69c8..dbee43c58741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1782,8 +1782,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
-		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0

