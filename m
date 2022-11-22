Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C289C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 14:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B86F10E3EA;
	Tue, 22 Nov 2022 14:37:42 +0000 (UTC)
X-Greylist: delayed 1907 seconds by postgrey-1.36 at gabe;
 Tue, 22 Nov 2022 11:53:41 UTC
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FD710E07E;
 Tue, 22 Nov 2022 11:53:40 +0000 (UTC)
X-QQ-mid: bizesmtp72t1669116099txffgh0h
Received: from localhost.localdomain ( [113.57.152.160])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Nov 2022 19:21:37 +0800 (CST)
X-QQ-SSF: 01400000000000E0R000000C0000000
X-QQ-FEAT: +ynUkgUhZJlLDq+nP6+uedbXvgas1IUa13PrtWgKs2DOViskOswrChYt+MFKv
 Pl7pXSgPAC9YYzk66eyueb4WltFQHvZSCvT3pmXv1se7I7PYRHHS2+1FKm7VBkBJICOOW8B
 kK3W9lrRUW/buANCKL1Wyp2c+1nEoipKiy6JgwdUq3RRSUWkt6Otm7FKIjn7koJ3WcNt5U1
 HCfEsmgZBOHhvElsFR/C8Zo/QMfTfy3Tuj/xOWkzr1h7gtV6oVBaD9kndG5aPvZ5y+5HrWm
 +IB/Qsw+TMBz8rvwDV2InH89ZTSvxtWCalAOe4Gh6p8sl8iI1ql3AyD0jf9HTaHiiQ5H9jU
 0cXEbZXTvvLg/v9KKHunEUcUQkl8vYnVIPxMovw9J360ql9NDpQpoyOBRfLR9AO/8hLpun8
 K5v013a9cN8=
X-QQ-GoodBg: 1
From: hongao <hongao@uniontech.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
 aurabindo.pillai@amd.com, roman.li@amd.com, Jerry.Zuo@amd.com
Subject: [PATCH] drm/amd/display: Fix set scaling doesn's work
Date: Tue, 22 Nov 2022 19:20:34 +0800
Message-Id: <20221122112034.30080-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Mailman-Approved-At: Tue, 22 Nov 2022 14:37:39 +0000
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
Cc: hongao <hongao@uniontech.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Setting scaling does not correctly update CRTC state. As a result
dc stream state's src (composition area) && dest (addressable area)
was not calculated as expected. This causes set scaling doesn's work.

[How]
Correctly update CRTC state when setting scaling property.

Signed-off-by: hongao <hongao@uniontech.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3e1ecca72430..a88a6f758748 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9386,8 +9386,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		if (dm_old_con_state->abm_level !=
-		    dm_new_con_state->abm_level)
+		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
+		    dm_old_con_state->scaling != dm_new_con_state->scaling)
 			new_crtc_state->connectors_changed = true;
 	}
 
-- 
2.20.1

