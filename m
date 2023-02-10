Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3F9C636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 15:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED0B10ED6D;
	Fri, 10 Feb 2023 15:58:01 +0000 (UTC)
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C434010E14A;
 Fri, 10 Feb 2023 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
 t=1676023251; bh=OSyoTpdJIQ68wdvoa27f76+Ft7Eat4Qqrj2ni75ZjlY=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
 Content-Type;
 b=dLN2v0lJNO/R9XxljsTYyDGzEDcp46LY7SNLllVfNCzD59qU1Xfh2AAjjb77EzHlD
 0iCewyeMeYqIgOf9b9gL22kOyJnhRoj1jaIRP20lGA/uckiiTteo1Y2WYCAzHKM14E
 86VlK2KInkvDzlH/OUhk76ITv+OKG7NbznBa4rmI=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Fri, 10 Feb 2023 11:00:51 +0100 (CET)
X-EA-Auth: Nf6tPsEPxv5OhlOXiVf8OdDvgK+wSKjuCHgTMdsYfS0p/LNkCjDFiz1fDavnjR+SPdxr0xlQkEZmnQxvn4NhObJwXjiOC9io
Date: Fri, 10 Feb 2023 15:30:43 +0530
From: Deepak R Varma <drv@mailo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Remove duplicate/repeating expressions
Message-ID: <Y+YVy7RaxnXokJ3l@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 10 Feb 2023 15:57:59 +0000
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
 Deepak R Varma <drv@mailo.com>, Saurabh Singh Sengar <ssengar@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove duplicate or repeating expressions in the if condition
evaluation. Issue identified using doubletest.cocci Coccinelle semantic
patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 4b8f5fa0f0ad..ae89760d887d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2335,8 +2335,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.ForcedOutputLinkBPP[k] != 0)
 				mode_lib->vba.DSCOnlyIfNecessaryWithBPP = true;
-			if ((mode_lib->vba.DSCEnable[k] || mode_lib->vba.DSCEnable[k])
-					&& mode_lib->vba.OutputFormat[k] == dm_n422
+			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.OutputFormat[k] == dm_n422
 					&& !mode_lib->vba.DSC422NativeSupport)
 				mode_lib->vba.DSC422NativeNotSupported = true;
 
@@ -3639,7 +3638,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
-					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_8
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe) {
 				if (mode_lib->vba.ViewportWidthChroma[k] > mode_lib->vba.SurfaceWidthC[k]
-- 
2.34.1



