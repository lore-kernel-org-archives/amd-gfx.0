Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D299BC2D0F4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 19:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFB92072F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 19:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFB92072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F2F6EAC1;
	Wed,  8 Apr 2020 19:27:43 +0000 (UTC)
X-Greylist: delayed 767 seconds by postgrey-1.36 at gabe;
 Wed, 08 Apr 2020 19:25:58 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274B46EAC1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 19:25:57 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MirfG-1iqWM210J2-00es0G; Wed, 08 Apr 2020 21:13:06 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amdgpu/display: avoid unused-variable warning
Date: Wed,  8 Apr 2020 21:12:46 +0200
Message-Id: <20200408191305.1179310-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:Hy3BKs9II3tOW07ZNAGp8CLbYOcHoW2PZhpkKmnkAWBjgtzXcnZ
 GrpGlVQEy43nUw6umYZpAwb8VQbjG+Nw1zkXIIAf20xcGD1u+J2Ojm0A0deCH+DfMNYPzVy
 eGoterPP18DDEKX5fN6riyV+w6An/VDD/gLRj1Mz19Dhum4hxWbMrk/3Q0fre++Dr2Wgyhk
 iBFRYQxl3ZW4CPmkUJaTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Xyhk2ZObg4=:lmZnPAzUIgwm/7rzlxsEQu
 /8r4m+re0r3CB2GwtEDM6OcyQ2aAWvPb1plVlczBIOdvux/12b/HiJIFscA7qXxr8Yk7Rir5f
 5iIMoRWB3i49MJ/W+cVF47nuxDGA2PwQjCkOTlOa1gb5w6sqbtq4uJx9uK6gsDh1Aef5v+mKL
 5IsMdf7ghETgk9TPJS5TQOTckl1Oq2g2mbtofdyXFv1yBXzqkAMJAc3DYjDTyPsAkVjOVKBZN
 NnRXYkMUBfBsOK+2o+02xvSVzZNivialXnW5ZeQ4/fNkImUjMqu4roTUvCTEKb75HiKdrDbEx
 XSTDcpWK+RAQZ1R1eiPJQGPxo/D4Kc3H+tkl83bVo9UOsvLei/sJ3o6a/KQxPT3p1DO6SR66/
 Vit2txlrddBcYPGqBMrKMdnyFoMchw2EPa2DmA5Y4L9p25oCdAenirHQU68POH26luX47HUGb
 MIJqacpOqJwHhOg/Iv7wYsqBelqQhRPhIzKlS28t3vKC3CW5QaYc7Fx7cH3KEDsiVEmQwHeZW
 9uaiWzfXQPckTj1mNObJN4WgsQn5t6iVcSGvZRc1aPhqc8rRgCvzwjDyg1H8zFtHsCfmZhYFY
 PS4l+xzYF5cRFW2qFV1mZZDl5blOyzO/JU+QBu26glB3kyEuHIua9ARVmbJH84LAogb/3inQ+
 uJ0YWlwYbO4n4dqganx0rW0uRoJJTTzjzZKt6dL1JQ04XNu92rRI6+HdOoYuF5j430ASlcvsh
 Vjt4rrQJpu1rrHXtsLtoNsNE4mGhxUMs1uu6xDfaKThj735uKHkmuOdlCFftx2fstF+yvwJyq
 qAbO/XixdJey4BDITQ7LC9W65DPoa2D6bWYkLCt64eKBhedxf0=
X-Mailman-Approved-At: Wed, 08 Apr 2020 19:27:42 +0000
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
Cc: Arnd Bergmann <arnd@arndb.de>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without CONFIG_DEBUG_FS, this newly added function causes a harmless
warning:

amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_connector_late_register':
amdgpu_dm/amdgpu_dm.c:4723:30: error: unused variable 'amdgpu_dm_connector' [-Werror=unused-variable]
 4723 |  struct amdgpu_dm_connector *amdgpu_dm_connector =
      |                              ^~~~~~~~~~~~~~~~~~~

Use an IS_ENABLED() check instead to let the compiler see what
is going on.

Fixes: 14f04fa4834a ("drm/amdgpu/display: add a late register connector callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3674d805a0a..8ab23fe98059 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -51,9 +51,7 @@
 #include "amdgpu_dm_irq.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm_mst_types.h"
-#if defined(CONFIG_DEBUG_FS)
 #include "amdgpu_dm_debugfs.h"
-#endif
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4723,9 +4721,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
 
-#if defined(CONFIG_DEBUG_FS)
-	connector_debugfs_init(amdgpu_dm_connector);
-#endif
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		connector_debugfs_init(amdgpu_dm_connector);
 
 	return 0;
 }
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
