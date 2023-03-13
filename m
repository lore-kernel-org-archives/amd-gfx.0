Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A5FC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78ADF10E4B6;
	Mon, 13 Mar 2023 08:18:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7C410E130
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 04:38:21 +0000 (UTC)
X-UUID: fc1b5c4b2bd744ae95c610db65a9a17c-20230313
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20, REQID:b125cdae-68d0-4ff9-8aee-d35cbe722955, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:35
X-CID-INFO: VERSION:1.1.20, REQID:b125cdae-68d0-4ff9-8aee-d35cbe722955, IP:5,
 URL
 :0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:35
X-CID-META: VersionHash:25b5999, CLOUDID:fd6593f5-ddba-41c3-91d9-10eeade8eac7,
 B
 ulkID:230313105653YN3UMKP4,BulkQuantity:0,Recheck:0,SF:23|17|19|43|102,TC:
 nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: fc1b5c4b2bd744ae95c610db65a9a17c-20230313
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <lizhenneng@kylinos.cn>) (Generic MTA)
 with ESMTP id 769191158; Mon, 13 Mar 2023 10:56:50 +0800
From: Zhenneng Li <lizhenneng@kylinos.cn>
To: Chen Guchun <Guchun.Chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Date: Mon, 13 Mar 2023 10:56:48 +0800
Message-Id: <20230313025648.3103971-2-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
References: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Mar 2023 08:18:21 +0000
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
Cc: David Airlie <airlied@linux.ie>, Pan Xinhui <Xinhui.Pan@amd.com>,
 Zhenneng Li <lizhenneng@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During reboot test on arm64 platform, it may failure
on boot.

The error message are as follows:
[    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR*
			    late_init of IP block <si_dpm> failed -22
[    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_init failed
[    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU init
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index d6d9e3b1b2c0..ca9bce895dbe 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 
 static int si_dpm_late_init(void *handle)
 {
-	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!adev->pm.dpm_enabled)
-		return 0;
-
-	ret = si_set_temperature_range(adev);
-	if (ret)
-		return ret;
-#if 0 //TODO ?
-	si_dpm_powergate_uvd(adev, true);
-#endif
 	return 0;
 }
 
-- 
2.25.1

