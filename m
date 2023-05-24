Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1969C7EE2C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA6410E639;
	Wed, 24 May 2023 09:46:50 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FAA210E562
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 01:15:40 +0000 (UTC)
X-UUID: 6a67f47f561b4074ae2ff3f65c70bfc6-20230524
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:6a8bc471-7e9d-4170-bdbe-3f1046c0daca, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-10
X-CID-INFO: VERSION:1.1.22, REQID:6a8bc471-7e9d-4170-bdbe-3f1046c0daca, IP:5,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-10
X-CID-META: VersionHash:120426c, CLOUDID:814b243c-de1e-4348-bc35-c96f92f1dcbb,
 B
 ulkID:230524091029R3A5ZFFD,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
 I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 6a67f47f561b4074ae2ff3f65c70bfc6-20230524
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <lizhenneng@kylinos.cn>) (Generic MTA)
 with ESMTP id 2132031019; Wed, 24 May 2023 09:10:28 +0800
From: Zhenneng Li <lizhenneng@kylinos.cn>
To: Chen Guchun <Guchun.Chen@amd.com>
Subject: [PATCH v3] drm/amdgpu: resove reboot exception for si oland
Date: Wed, 24 May 2023 09:09:51 +0800
Message-Id: <20230524010951.236634-2-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524010951.236634-1-lizhenneng@kylinos.cn>
References: <20230524010951.236634-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 May 2023 09:46:48 +0000
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
[    1.706570][ 3] [  T273] [drm:si_thermal_enable_alert [amdgpu]] *ERROR* Could not enable thermal interrupts.
[    1.716547][ 3] [  T273] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP block <si_dpm> failed -22
[    1.727064][ 3] [  T273] amdgpu 0000:02:00.0: amdgpu_device_ip_late_init failed
[    1.734367][ 3] [  T273] amdgpu 0000:02:00.0: Fatal error during GPU init
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


No virus found
		Checked by Hillstone Network AntiVirus
