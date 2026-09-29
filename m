Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542C0CA5FB4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FA810ED99;
	Tue, 29 Sep 2026 08:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="eAmmF7Br";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DDE10EC69
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:14:20 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-142dd05d97cso4507483c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 20:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651659; x=1791256459;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XEoH4g84gk9XFCZN7uYIcwGzkc00ec8qVmnXddCOcQw=;
 b=eAmmF7Brw7O1EoF1zaMqE2xuKtOnjODivzbpYZ2Jd0K876I8O+u4uex3GjhEXHRhHY
 0EgVzEjVFGni4uFDm477e6naN6vPGUwG1F2NAHY6T3R8gDDna+VfX1piSrwLEZ43oZ4g
 MmxyFYE/CJxHBNQVxIp8CLP6Wo2P847dXJW8H7Dpy1X//uJDuElI+HQzDtsFDL3zI71r
 nd1gUAZyl80UVnaHIca+fKjR8tu9/9FZLYitvL01VQBqszbW9hy+4456fUJRQc/pFYkh
 +7vghq6ZdMIbW4Wc/71pVJIQeq6RmCvEAwiQ0Qlr+QY+jel3sQP+KhCUjvANqPB8keW9
 UySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651659; x=1791256459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XEoH4g84gk9XFCZN7uYIcwGzkc00ec8qVmnXddCOcQw=;
 b=g9AHnYKHGc6am+I0D4iR62XjI+cLUxySDuh0x1WEGbjeFkYt0ODS/SX8yl0+R/A948
 /N/XOsOvCKqpD7nYHZA5F4bA4Ao7krl68tqkDW/0dTmRh5nBChcAbcpe7zzWD7FFlyXX
 KPqkn6hrxouYHG/Vb8VYQZjNqbF2VbQdrLOEPulwbwEq+YDzwzClYuJcIuYvE8Y7FdYt
 gUIDd2//s9tL/o4n39UhQO0sYWCnWPIMJlljoc7ZysSVF195YN5bWHC5CA2EUhMElIi5
 fJnuMVj+9NuxRRNuUGo+8wX8JKUICkWg0GETysjVNlEp87xJi1IMqKVTvzIKmidz7KyR
 cnrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqzojURkPKQOfB25GDaIAIwmZMNmmlRCP8UnbfHi5g75ikE6kWgmv6J4+VeCsRbhCyBMUX0KK9@lists.freedesktop.org
X-Gm-Message-State: AFuF++mD/1KQL7OkAdf3jw0XvaRwZlpipgKN6JuDga8thr4Uv5+dsBgT
 N0mbmGh0W6Yxf/YYzqfc3WaLdLdp1ordHue9Zhh3OkducpqGdVmPFkF15E+jshE2Dt8=
X-Gm-Gg: AYBFou0rOBSRLAwvLwyP9sCGXfiQ26rEias7Uj5Dv45Ngon5HMWRT1pdOHULe0ETTX5
 wJHaV5uh+Ssbdk2fyUn3LL/hXOGTK9hlMJ9W2doCowc9FC3zuXJYYqA/IS/SsBX85t47gvCwtHP
 ZB6CVrhMrHECJ3wt4z0OUVSJRRKjwvCBMhQPGoLNNOLrOG4gE6T8RFxD9abQ/JyFh8ZOpSWgrn7
 QPnnZG+na3MAHDTXQmc6O9o6yBqfkuP6JUsQu1CZPoBNz3fsvv7JpPTJxXXC15iVc4E0EinXLx1
 32VpmqYrAWUui2rQ2EFmbBi1USOUBEnwiEG00scHBCkAPgS4l+7S0A/s6uMN/iEr+n/PNL8CHN7
 we23cz9qd5e+MTj6IvwV1XFphOO5q8pnm3u4wtX5tgsN4+M8zBgJwLPfPFQJ1HiHOWwZceWuMTz
 Q7Z9p2tFTJzsi5aU/qDlwGGF3k3Fe3dtlxmjSA4S1l8s3VqITYYAqqIQ0aMteMDUaOujCJGmzuH
 a9B3x3qKvrlQbDvYxfaqF/YALcW3TLPt22C+HipGwCQIiKqAkGT0V8I+v8jZ/BNDZeYLpc=
X-Received: by 2002:a05:701b:42d1:10b0:143:4710:a84e with SMTP id
 a92af1059eb24-146cec4be1fmr12051694c88.15.1790651659361; 
 Mon, 28 Sep 2026 20:14:19 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14a719057e1sm7529563c88.2.2026.09.28.20.14.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:14:18 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Check null pointers before using them
Date: Mon, 28 Sep 2026 23:14:14 -0400
Message-ID: <20260929031415.87382-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:23:02 +0000
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 1ff12bcd7deaeed25efb5120433c6a45dd5504a8 ]

[WHAT & HOW]
These pointers are null checked previously in the same function,
indicating they might be null as reported by Coverity. As a result,
they need to be checked when used again.

This fixes 3 FORWARD_NULL issue reported by Coverity.

[ Backport to 6.6.y: kept the applicable dm_state and dc_link guards; the
  vulnerable acrtc loop shape is absent. ]

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-49922. It prevents the applicable HDCP path
from dereferencing a NULL dc_link.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-49922
Upstream: 1ff12bcd7deaeed25efb5120433c6a45dd5504a8

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c72caac7b4d71..702c9f5c3d006e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6630,6 +6630,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state)
+		return NULL;
+
 	do {
 		stream = create_stream_for_sink(aconnector, drm_mode,
 						dm_state, old_stream,
@@ -8859,9 +8862,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
-			hdcp_update_display(
-				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type, enable_encryption);
+			if (aconnector->dc_link)
+				hdcp_update_display(
+					adev->dm.hdcp_workqueue,
+					aconnector->dc_link->link_index,
+					aconnector,
+					new_con_state->hdcp_content_type,
+					enable_encryption);
 		}
 	}
 
-- 
2.39.5

