Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5177C07CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 15:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B205C10E614;
	Wed, 29 Nov 2023 15:36:04 +0000 (UTC)
X-Greylist: delayed 327 seconds by postgrey-1.36 at gabe;
 Wed, 29 Nov 2023 15:27:58 UTC
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB7810E60E;
 Wed, 29 Nov 2023 15:27:58 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 29 Nov
 2023 18:22:17 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 29 Nov
 2023 18:22:17 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/radeon/r100: Fix integer overflow issues in
 r100_cs_track_check()
Date: Wed, 29 Nov 2023 07:22:12 -0800
Message-ID: <20231129152212.7879-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Mailman-Approved-At: Wed, 29 Nov 2023 15:36:02 +0000
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
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It may be possible, albeit unlikely, to encounter integer overflow
during the multiplication of several unsigned int variables, the
result being assigned to a variable 'size' of wider type.

Prevent this potential behaviour by converting one of the multiples
to unsigned long.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 0242f74d29df ("drm/radeon: clean up CS functions in r100.c")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/radeon/r100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index affa9e0309b2..cfeca2694d5f 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -2321,7 +2321,7 @@ int r100_cs_track_check(struct radeon_device *rdev, struct r100_cs_track *track)
 	switch (prim_walk) {
 	case 1:
 		for (i = 0; i < track->num_arrays; i++) {
-			size = track->arrays[i].esize * track->max_indx * 4;
+			size = track->arrays[i].esize * track->max_indx * 4UL;
 			if (track->arrays[i].robj == NULL) {
 				DRM_ERROR("(PW %u) Vertex array %u no buffer "
 					  "bound\n", prim_walk, i);
@@ -2340,7 +2340,7 @@ int r100_cs_track_check(struct radeon_device *rdev, struct r100_cs_track *track)
 		break;
 	case 2:
 		for (i = 0; i < track->num_arrays; i++) {
-			size = track->arrays[i].esize * (nverts - 1) * 4;
+			size = track->arrays[i].esize * (nverts - 1) * 4UL;
 			if (track->arrays[i].robj == NULL) {
 				DRM_ERROR("(PW %u) Vertex array %u no buffer "
 					  "bound\n", prim_walk, i);
-- 
2.25.1

