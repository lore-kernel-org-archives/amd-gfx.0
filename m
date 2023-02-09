Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C1DC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 13:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B3810E227;
	Thu,  9 Feb 2023 13:33:28 +0000 (UTC)
X-Greylist: delayed 12992 seconds by postgrey-1.36 at gabe;
 Thu, 09 Feb 2023 10:48:07 UTC
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFBD10E0AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 10:48:07 +0000 (UTC)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PCD9K6t9Qz8R03x
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 18:48:05 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4PCD9D0gGPz501Qq;
 Thu,  9 Feb 2023 18:48:00 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
 by mse-fl2.zte.com.cn with SMTP id 319Alpag050447;
 Thu, 9 Feb 2023 18:47:51 +0800 (+08)
 (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid31;
 Thu, 9 Feb 2023 18:47:54 +0800 (CST)
Date: Thu, 9 Feb 2023 18:47:54 +0800 (CST)
X-Zmail-TransId: 2af963e4cf5affffffffd643d4b7
X-Mailer: Zmail v1.0
Message-ID: <202302091847543326041@zte.com.cn>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <alexander.deucher@amd.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBkcm0vYW1kL2Rpc3BsYXk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXI=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 319Alpag050447
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID
 63E4CF65.000 by FangMail milter!
X-FangMail-Envelope: 1675939685/4PCD9K6t9Qz8R03x/63E4CF65.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E4CF65.000/4PCD9K6t9Qz8R03x
X-Mailman-Approved-At: Thu, 09 Feb 2023 13:33:26 +0000
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
Cc: jani.nikula@linux.intel.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 qingqing.zhuo@amd.com, xinhui.pan@amd.com, rodrigo.siqueira@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 wenjing.liu@amd.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 george.shen@amd.com, airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ye Xingchen <ye.xingchen@zte.com.cn>

link_hwss.h is included more than once in link_dpms.c .

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Fix the U+00A0 non-breaking space in the subject line.
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 9cdfa7f7dc77..0c26b3589608 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -51,7 +51,6 @@
 #include "link_enc_cfg.h"
 #include "resource.h"
 #include "dsc.h"
-#include "link_hwss.h"
 #include "dccg.h"
 #include "clk_mgr.h"
 #include "atomfirmware.h"
-- 
2.25.1
