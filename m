Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C90C54EED
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jan 2023 08:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8161810E132;
	Mon, 30 Jan 2023 08:18:13 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F8110E2E2
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 01:39:45 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4P3cZ53Hbyz1DF4
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 09:39:41 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxde.zte.com.cn (FangMail) with ESMTPS id 4P3cYk0Pb1zBRK7W
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 09:39:22 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxus.zte.com.cn (FangMail) with ESMTPS id 4P3cYf4tlszdmX8h
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 09:39:18 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P3cYZ2KBQz8R039;
 Sat, 28 Jan 2023 09:39:14 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl2.zte.com.cn with SMTP id 30S1d71v045972;
 Sat, 28 Jan 2023 09:39:07 +0800 (+08)
 (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid31;
 Sat, 28 Jan 2023 09:39:08 +0800 (CST)
Date: Sat, 28 Jan 2023 09:39:08 +0800 (CST)
X-Zmail-TransId: 2af963d47cbcffffffffea16db64
X-Mailer: Zmail v1.0
Message-ID: <202301280939083976293@zte.com.cn>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <alexander.deucher@amd.com>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kZ3B1L2Rpc3BsYXk6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBoZWFkZXIgaW4gZmlsZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30S1d71v045972
X-FangMail-Bounce-Flag: 1674869958.63D47CC5.000
X-FangMail-Outinfo: 1674869958/63D47CC5.000/4P3cYf4tlszdmX8h/ye.xingchen@zte.com.cn/1
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID
 63D47CDC.001 by FangMail milter!
X-FangMail-Envelope: 1674869981/4P3cZ53Hbyz1DF4/63D47CDC.001/10.35.20.121/[10.35.20.121]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D47CDC.001/4P3cZ53Hbyz1DF4
X-Mailman-Approved-At: Mon, 30 Jan 2023 08:18:12 +0000
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
Cc: haoping.liu@amd.com, ian.chen@amd.com, dingchen.zhang@amd.com,
 sunpeng.li@amd.com, harry.wentland@amd.com, xinhui.pan@amd.com,
 rodrigo.siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, wenjing.liu@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, george.shen@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: ye xingchen <ye.xingchen@zte.com.cn>

opp.h is included more than once.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6475664baa8a..1a2ab934b4bd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -46,7 +46,6 @@
 #include "dpcd_defs.h"
 #include "dmcu.h"
 #include "dsc.h"
-#include "opp.h"
 #include "hw/clk_mgr.h"
 #include "dce/dmub_psr.h"
 #include "dmub/dmub_srv.h"
-- 
2.25.1
