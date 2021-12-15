Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B78EC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 16:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D0310E6DF;
	Wed, 15 Dec 2021 15:31:19 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Wed, 15 Dec 2021 09:29:40 UTC
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FC010E36A;
 Wed, 15 Dec 2021 09:29:38 +0000 (UTC)
X-UUID: f7c97c1c2b8a479baf36adbbbce09b56-20211215
X-UUID: f7c97c1c2b8a479baf36adbbbce09b56-20211215
X-User: zhouzongmin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
 (envelope-from <zhouzongmin@kylinos.cn>) (Generic MTA)
 with ESMTP id 1907932870; Wed, 15 Dec 2021 17:32:29 +0800
From: Zongmin Zhou <zhouzongmin@kylinos.cn>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: fixup bad vram size on gmc v8
Date: Wed, 15 Dec 2021 17:23:37 +0800
Message-Id: <20211215092337.340266-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Dec 2021 15:31:17 +0000
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
Cc: Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Zongmin Zhou <zhouzongmin@kylinos.cn>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some boards(like RX550) seem to have garbage in the upper
16 bits of the vram size register.  Check for
this and clamp the size properly.  Fixes
boards reporting bogus amounts of vram.

after add this patch,the maximum GPU VRAM size is 64GB,
otherwise only 64GB vram size will be used.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 492ebed2915b..63b890f1e8af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -515,10 +515,10 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 {
 	int r;
+	u32 tmp;
 
 	adev->gmc.vram_width = amdgpu_atombios_get_vram_width(adev);
 	if (!adev->gmc.vram_width) {
-		u32 tmp;
 		int chansize, numchan;
 
 		/* Get VRAM informations */
@@ -562,8 +562,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.vram_width = numchan * chansize;
 	}
 	/* size in MB on si */
-	adev->gmc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
-	adev->gmc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
+	tmp = RREG32(mmCONFIG_MEMSIZE);
+	/* some boards may have garbage in the upper 16 bits */
+	if (tmp & 0xffff0000) {
+		DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
+		if (tmp & 0xffff)
+			tmp &= 0xffff;
+	}
+	adev->gmc.mc_vram_size = tmp * 1024ULL * 1024ULL;
+	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
 	if (!(adev->flags & AMD_IS_APU)) {
 		r = amdgpu_device_resize_fb_bar(adev);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
