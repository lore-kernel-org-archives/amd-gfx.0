Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D33BC3DA63
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 07:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DEF10E93F;
	Fri, 26 Jul 2024 07:40:28 +0000 (UTC)
X-Greylist: delayed 328 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jul 2024 18:15:24 UTC
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5540810E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:15:24 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 25 Jul
 2024 21:09:54 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 25 Jul
 2024 21:09:54 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
 <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jerome Glisse
 <jglisse@redhat.com>, Dave Airlie <airlied@redhat.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <stable@vger.kernel.org>
Subject: [PATCH] drm/radeon/evergreen_cs: fix int overflow errors in cs track
 offsets
Date: Thu, 25 Jul 2024 11:09:50 -0700
Message-ID: <20240725180950.15820-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Mailman-Approved-At: Fri, 26 Jul 2024 07:40:26 +0000
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

Several cs track offsets (such as 'track->db_s_read_offset')
either are initialized with or plainly take big enough values that,
once shifted 8 bits left, may be hit with integer overflow if the
resulting values end up going over u32 limit.

Some debug prints take this into account (see according dev_warn() in
evergreen_cs_track_validate_stencil()), even if the actual
calculated value assigned to local 'offset' variable is missing
similar proper expansion.

Mitigate the problem by casting the type of right operands to the
wider type of corresponding left ones in all such cases.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling informations v11")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. While I am not certain that track->cb_color_bo_offset[id]
actually ends up taking values high enough to cause an overflow,
nonetheless I thought it prudent to cast it to ulong as well.

 drivers/gpu/drm/radeon/evergreen_cs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 1fe6e0d883c7..d734d221e2da 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -433,7 +433,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 		return r;
 	}
 
-	offset = track->cb_color_bo_offset[id] << 8;
+	offset = (unsigned long)track->cb_color_bo_offset[id] << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, id, offset, surf.base_align);
@@ -455,7 +455,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 				min = surf.nby - 8;
 			}
 			bsize = radeon_bo_size(track->cb_color_bo[id]);
-			tmp = track->cb_color_bo_offset[id] << 8;
+			tmp = (unsigned long)track->cb_color_bo_offset[id] << 8;
 			for (nby = surf.nby; nby > min; nby--) {
 				size = nby * surf.nbx * surf.bpe * surf.nsamples;
 				if ((tmp + size * mslice) <= bsize) {
@@ -476,10 +476,10 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 			}
 		}
 		dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer size %d, "
-			 "offset %d, max layer %d, bo size %ld, slice %d)\n",
+			 "offset %ld, max layer %d, bo size %ld, slice %d)\n",
 			 __func__, __LINE__, id, surf.layer_size,
-			track->cb_color_bo_offset[id] << 8, mslice,
-			radeon_bo_size(track->cb_color_bo[id]), slice);
+			(unsigned long)track->cb_color_bo_offset[id] << 8,
+			mslice,	radeon_bo_size(track->cb_color_bo[id]), slice);
 		dev_warn(p->dev, "%s:%d problematic surf: (%d %d) (%d %d %d %d %d %d %d)\n",
 			 __func__, __LINE__, surf.nbx, surf.nby,
 			surf.mode, surf.bpe, surf.nsamples,
@@ -608,7 +608,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_s_read_offset << 8;
+	offset = (unsigned long)track->db_s_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
@@ -627,7 +627,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return -EINVAL;
 	}
 
-	offset = track->db_s_write_offset << 8;
+	offset = (unsigned long)track->db_s_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
@@ -706,7 +706,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_z_read_offset << 8;
+	offset = (unsigned long)track->db_z_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
@@ -722,7 +722,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 		return -EINVAL;
 	}
 
-	offset = track->db_z_write_offset << 8;
+	offset = (unsigned long)track->db_z_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
