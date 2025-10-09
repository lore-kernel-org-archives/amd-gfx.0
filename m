Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287BDCCD198
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 07:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9486910E966;
	Thu,  9 Oct 2025 07:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G/CdmGhB";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD9B10E18B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 02:18:20 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso363360f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759976299; x=1760581099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqgyYd4Mgcg6Fw8yS9ue0bFgfT1RMe7FZ2RNvXUjHH8=;
 b=G/CdmGhBR8a1+aHP5IdNbdI+JPf336ResRn70gF5x6ZOuf+B+hZkUJP8lxAQDlWKHR
 0RwVrrktfEhgUacEjrfK9Ov6AVuCHwxZGD7MfUhwzMc47NjTOn9yD/JXJARFFnoxm1pb
 aWHjEMP8auCrJ0JwIvCZ72WE5UuSczTGxs1AhN6pQswvNfplAvg7rK+enARG1QFcAtzb
 7EW3FIQCIffVIiWoJxx0JlFNzboCv5PY8KtT4AqF5k3urggqYFbaswSNU34SjX5DfXZz
 tKW3fQsYgN6rJ0ve+zPEzgmCJzGoEyNs1sroO4cjuhwSoVJVGguHwSQd9+XYszPfYviS
 bjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759976299; x=1760581099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqgyYd4Mgcg6Fw8yS9ue0bFgfT1RMe7FZ2RNvXUjHH8=;
 b=i4TEcMa/cKL3IiPKl7qDpL68ElO3gkswkOffkLrn/j0ulSStS7M1MOcvU4HrCRMxDw
 q+gBJr8WTSMU/8Bd2sPDxPIY+g4o5L0j4NtdfHsHuomwQfbIngNL1HQpf/AmHy65IRDj
 ZKa8wk/DEHhu6INmsSa0xssMx5Jx7Z0xMxFF9NMMd0Cf6guxpapiTDnsKtUoBfqOnYFC
 MLAybDvxsa8IsncRRWKlDagF0wCFM37Sa8z9cDOo6+L/51CDZPi2ZMdnrUO0X9iB2FPJ
 HbxGgZrUh+YYbhu+o0b6fd10LOBy2Q2Hg5uT1rqhB+A+eUiRmsig1FpJfaz/1Anrbo2v
 ASTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhKYNZcaG0hyON74VuDM3rMI1OhKMGvSs5lRY/ySolkQTZZC02V0cLZKTX/W70gqorlgsE61rL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgI/DlT6E7eQr66JvP4kYwQhgZVZ4DFO0rTDWeI8omBtbIUUXp
 tBVFfOIrY/Ly5CsgbFVfHizv30+wLIa1cd0cTCJzYvkNtU1gQvRszlpS
X-Gm-Gg: ASbGncsSCKHtWiJyYe5E3GvgPk3Z33BZB9ckotc5JA1RzYC9YUiYkSWzXOpnkwdOgxm
 E+RWsB+z55R7+U5hhPCbOMnddHao6FzNA9VyFbM45i+IwK/CSrBF3fDSnbwZgUe6TTGWq+P6Xx9
 T4XoYyu6s0yznklo3If2tO1bzhhXkkd0tsBb5cWdp05RbxnodFgk5bl43AnCJGUDyUopaSjXlg0
 k0iB87dLFwWjBKmWfSPiMGXClJkvmBsMF/la45ttQWddSFA5oZ/e+rVMF/rgakg7YZjmNYUM1bt
 eCs0R2OgR1uM1Nt3LWOOVgKGFMd53mHAwinCoFeXnp3yT61XsKZbx7/EYU0pWueAYEdgjAr/nWv
 GTGsWPjHDfhDQptGa4S6Nr9CCXeusWyZhlRo9QXA9iNQRBYPwEcjsb57JAZv7mKw=
X-Google-Smtp-Source: AGHT+IEm5kdnFG09dYVzwvY+GYBWGh2ZZck+203z4lbF02DASvHUzeCJVzSdR5m2k47thehYE31uPA==
X-Received: by 2002:a05:6000:26cc:b0:3dc:1a8c:e878 with SMTP id
 ffacd0b85a97d-42667177b8emr2951904f8f.18.1759976299330; 
 Wed, 08 Oct 2025 19:18:19 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d7f91esm60094215e9.20.2025.10.08.19.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 19:18:18 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 mario.kleiner.de@gmail.com, hersenxs.wu@amd.com, Igor.A.Artemiev@mcst.ru,
 nikola.cornij@amd.com, srinivasan.shanmugam@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, eslam.medhat1993@gmail.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 5.10.y 2/2] drm/amd/display: Fix potential null dereference
Date: Thu,  9 Oct 2025 05:17:12 +0300
Message-ID: <1c15fc3dd25c509faa95cf8805a64c30b62529b2.1759974167.git.eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1759974167.git.eslam.medhat1993@gmail.com>
References: <cover.1759974167.git.eslam.medhat1993@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Oct 2025 07:45:21 +0000
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

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit 52f1783ff4146344342422c1cd94fcb4ce39b6fe ]

The adev->dm.dc pointer can be NULL and dereferenced in amdgpu_dm_fini()
without checking.

Add a NULL pointer check before calling dc_dmub_srv_destroy().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9a71c7d31734 ("drm/amd/display: Register DMUB service with DC")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b698d652d41f..0aa681939b7e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1142,7 +1142,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
+	if (adev->dm.dc)
+		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (adev->dm.dmub_bo)
 		amdgpu_bo_free_kernel(&adev->dm.dmub_bo,
-- 
2.43.0

