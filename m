Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32F5C48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 08:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6040410E65B;
	Mon, 12 Feb 2024 08:43:28 +0000 (UTC)
X-Greylist: delayed 918 seconds by postgrey-1.36 at gabe;
 Sun, 11 Feb 2024 15:21:57 UTC
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4929510E309;
 Sun, 11 Feb 2024 15:21:56 +0000 (UTC)
From: Daniil Dulov <d.dulov@aladdin.ru>
To: David Airlie <airlied@linux.ie>
CC: Daniil Dulov <d.dulov@aladdin.ru>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel
 Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amdgpu/swsmu: Fix if statement in smu_baco_get_state()
Date: Sun, 11 Feb 2024 07:06:13 -0800
Message-ID: <20240211150613.3583-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.20.125]
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-Mailman-Approved-At: Mon, 12 Feb 2024 08:43:27 +0000
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

In smu_baco_get_state() smu->ppt_funcs->baco_get_state is checked for NULL.
If it is NULL then the pointer is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6c45e480fe23 ("drm/amd/powerplay: clear the swSMU code layer")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ee27970cfff9..0fadb6aacd4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2497,7 +2497,7 @@ bool smu_baco_is_support(struct smu_context *smu)
 
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state)
 {
-	if (smu->ppt_funcs->baco_get_state)
+	if (!smu->ppt_funcs->baco_get_state)
 		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
-- 
2.25.1

