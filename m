Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC2110FCACA
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC79F10EE94;
	Wed,  1 Apr 2026 18:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OT3D0SLK";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CEF10EBBD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:45 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12a695044a4so1791080c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003985; x=1775608785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
 b=OT3D0SLKkXPOMrQgUpMzdJaPKvOJCjSzDGyGC1ljU9U8Y76CHdEsQl4nNKc2O/+F/E
 G2hZwax5yUGaqGhs6XbxKGZRTOR0+PRPoAlVJX1ecnkjsF19+SQRWbyzlXv44eKRSdJd
 H4hK4m9tXOJSZAWLn0XjE1E1J4mhTMs07aIu88ayOeBU/D4WUXFTW7HpZErftSgDOu2p
 KoHjG1kVe8Tn881izR5khHQBTO1OmAPdgy4mUr5a9wxrxdR8Ay2yJZb7Up4c9D+XSTAe
 tgpCxDHsBlSQQk0rT3tzLKOCOmpArgNghb6DBfcT8fqJ8d+Xbfg2Z9kK8Aylmp75y0k6
 QXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003985; x=1775608785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
 b=BPi9DsWl6+jZMbj9DVK/10JZUBeMeequw4Di6unNsmRPOUPtM/GsG44MOElPEQr0NT
 adilvAI2i3C2fLxOM76/8sncAUjq1Q0bHpCIs/+GJmN+yO2MGkY9tPn5JZKTjw4a4Dfs
 qQDTWEyM70RY30jmpTrECLMhV2DQES9Qv3YrX/896VMlPQP6hjOcI8/SdpNZxMO09Vmo
 e7Y32xH0XNe0U/xurOiV5Wj5Hd2BkfddUXRq/0z9XJoxxzz+LjJz+AOTXsZWFYJjwQd6
 9umPN5zLezBccf+Yo/q6kZnJivqe32HEC0+lwuhYXm+vYSP0Zb4+esUYeSHRSmPT34Qo
 HvCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQ78E5nTf63KgzhuzgNgTMu1y3vyQkhlW2GXJISvbrlcLtCi3JnnqwZmFCA6LwFHdNi89jqd3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwwruA9E/dbLGRDSyBFYzEEtGBCzM1aOzWrcn8VyDQv3yhngkc
 flewGrYoh/mPVHRQMXTzLffZuJRVZN9CLX6ErxqiWu+e9oBzG/aBZxAW
X-Gm-Gg: ATEYQzy1jqJ5m4x7ud/l2RlUQQgdtOJPTxauf/klC6zhpcJvY0+n0kB1DvcLor0e8iI
 /VACBIzPK6KstSHBhaFe4NjnRKm+qKdMQiVYC7Xg7Qmk5LbyV8dO5d5q56yKJm2+k7ZxVXp6wrM
 tZe0O2T71ONO0o5rUGA23DMasvpSo341Xy/TupzKGIkbhLVdlZXt1KMfrBI0v8c7rRC/RwCMloc
 ajouJVIeJpjHX9F3pKGzN4zrJ/7R4CFOycbgSVhaSPN+Wb3pZ43NMn1WC8WSMnvPybTjPeVveDF
 aYMgjtusF4CFN0YgNGQeG1QSqZHWRbee0WdndOktYzLym8XqKnLpeY2SxqmyCZbcba6dJ52Qbcz
 ula4nwste21Ef5MSrWCU2Ri+5qPdo00FQbWDuCyYu6Ws56JzPu6ve0GdgTKgJvijHn/pMzyUtkh
 Nb1WHMqrp8cP6embTu2bEoRvsHhkRlXqgGVxvyHSYK4oH5c8sEy0KYSso=
X-Received: by 2002:a05:7022:68a5:b0:128:bc19:813d with SMTP id
 a92af1059eb24-12be65537f5mr896596c88.27.1775003984637; 
 Tue, 31 Mar 2026 17:39:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:44 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 09/10] drm/amd: Disable ASPM on SI
Date: Tue, 31 Mar 2026 17:39:07 -0700
Message-ID: <20260401003908.3438-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7bdd91abf0cb3ea78160e2e78fb58b12f6a38d55 ]

Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
It's unclear if this is a platform-specific or GPU-specific issue.
Disable ASPM on SI for the time being.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb3c6bfe2e6c..12d7e45a4245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1761,6 +1761,13 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 
 static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 {
+	/* Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
+	 * It's unclear if this is a platform-specific or GPU-specific issue.
+	 * Disable ASPM on SI for the time being.
+	 */
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return true;
+
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-- 
2.53.0

