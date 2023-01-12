Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FC9C54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 14:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F195E10E8F9;
	Thu, 12 Jan 2023 14:08:09 +0000 (UTC)
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F0110E8EC;
 Thu, 12 Jan 2023 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
 t=1673531496; bh=ZAn7ZSvuny3A40ep6L1C3DqFhwPZfavNHTKFbfUsRxU=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
 Content-Type;
 b=hsLsYzmBjETINLz1Ja9/z1RFZVcBYUbHn7a9lGQeWWxVIR2aOvEaCHM3hW/0vW3Wg
 4uQveX+YjNjCQ7FeCzMA0owVm4zZaIibEUhv69J8B1+mduCsJuL/r6IvseMXRAIcLL
 UKBbH2XziNiSDioZE0ffoofCAATDAKel1aRhBse4=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Thu, 12 Jan 2023 14:51:36 +0100 (CET)
X-EA-Auth: Jql7kLVBTRErAY5Y8kPmRih3iDlhh+Av3Q2tRc5pWKa4/h+rUuSd4pAfiyzp58G/Z7umku8+u+IV1WMtssm9vCSzWYHyaSk2
Date: Thu, 12 Jan 2023 19:21:30 +0530
From: Deepak R Varma <drv@mailo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Conversion to bool not necessary
Message-ID: <Y8AQYhVkJjV86VXV@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 12 Jan 2023 14:08:08 +0000
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
Cc: Praveen Kumar <kumarpraveen@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A logical evaluation already results in bool. There is no need for using
a ternary operator based evaluation and bool conversion of the outcome.
Issue identified using boolconv.cocci Coccinelle semantic patch.
This was also reported by the Kernel Test Robot. Hence

Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 22125daf9dcf..1e39d0939700 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -105,8 +105,7 @@ static void vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	dc_allow_idle_optimizations(
-		dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
+	dc_allow_idle_optimizations(dm->dc, dm->active_vblank_irq_count == 0);
 
 	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
-- 
2.34.1



