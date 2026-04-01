Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C940810FCAD6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519010EE80;
	Wed,  1 Apr 2026 18:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VYMxOje9";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F6C10EBA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:43 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso6814907eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003983; x=1775608783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
 b=VYMxOje9Yq5qQWnW+DIOj/l8do8Iw5me6T0+kuVXAEBTKOyHYhLur+8oMlRhOMWSi4
 CvQFWiNzpJGW6Wbfx73sAL5UGcYycVK/I1ImwxghMiWt5T/9LlzRMse6hl2yjY4XMrpt
 Qx/Qay725EI/1+kMrsNpYANIT7whN2Sg3cnQyz+cWzuLYWhnZnyJ/Tm90Kpt3yKX6nQm
 DEIFmCv7h82B5r+FUz1Jc9VfWzgAiKSqkoX6SA/XPtpyd6bADgy/JhgbXDjfXd+MJ/mZ
 P+zBZtw9Xjx3Brql9/bfvzHBZB83g+teZCdmexZV8tZy9WzSPfsBDzDzBswcO26Mk8gA
 VxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003983; x=1775608783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
 b=Z7/gTvGCIyaaplgND2NoEhMvKAvIQU6ZxXL/oHavwA82fh5UdjRlx4rvF/Tc+mvvED
 aIGZASm8U0ltH0MRb/YydK0Jk9ZqiM0lKV6pPT+EKZ6QDLP/U0seof9aWHGutVWRdSls
 maxY/D3Meb/Z5G5PN9NdXeVGLjXVVBhXiab4prNcr5Ey84LG5KPGGcKhJdLkBvtORob1
 3/jIBLF5rziEjJE77hlBF+VM9TOAg6s68jpt2v4RCbDoUo6bwhr0hfGr/9DpjHceopx9
 Yyfl1LlxRx7pyAp48/sKlyYrepFopp8PKcpW7hKTLGmW/E/x3XyWzPz/aGDsCEuUoGO3
 eUbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3T9MGADwXXgvqrM1sSteQNDl0Mu5blk8m+/FdfeGohU+pehaHHTqaeJTKM8zHiMy+3PhctC6U@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUR3jQemRSH3XCdlHt4qe7VeUqqxjIW+PNK/3SSA4sLbpyR25s
 skIj+ZhbQlIv7dzBZdbUPLKwozZHdVRMZTNo2ZxytgSUTtohxudAW5RP
X-Gm-Gg: ATEYQzwOdnoXuwh8hBS06yUm7tMNt6q451n5SjI0k0i3x+vpKZPD5chDu04yWPb/5P6
 NADJzULlwkJTm0EyDXR1ueaPu2PXFDGDsiCBmAeRe33ExdQV8VPj2R8Xdbyr9YYD+RUHHmLiIkH
 wiTSwPr+f9M2J2gvvl+qDhaobAZ7VB+88CW7LDRa5IRhIMu2onh9Cm25srN/FkUpb7rWlWZjChz
 1b7GL9y0Dz5nKej8q0i39yE16Gt64gqFbaCoBsu04J/9xf/23ctI07Zx4+KVvd5kyxMQXNS0FDK
 TcRRi8/S4hYEdvJmeZr/bimj/vAWv2HRrKcMO7YEqYomzCcS+AoGobeAHhoTWs/e40sZ/URNLyw
 CWtYUBUwiVKf3aE9E5KqvI0Fxdan4kZkqTscVxvp5mGow6R5ot8yryDL2oJ5Z3fdHAirEO6UZqK
 l5pjLQXViHokz0OYnm3ba9ysoEFJIn874u6vX3pjmcxSQ6X7No0ot6r3Q=
X-Received: by 2002:a05:7300:fb8b:b0:2c4:b8d6:45ce with SMTP id
 5a478bee46e88-2c932aae004mr813092eec.25.1775003982823; 
 Tue, 31 Mar 2026 17:39:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:42 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 08/10] drm/amd/display: Disable scaling on DCE6 for
 now
Date: Tue, 31 Mar 2026 17:39:06 -0700
Message-ID: <20260401003908.3438-9-rosenp@gmail.com>
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

[ Upstream commit 0e190a0446ec517666dab4691b296a9b758e590f ]

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 978c024c97ba..3f9ea4fdc7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}
-- 
2.53.0

