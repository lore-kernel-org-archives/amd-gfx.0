Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A2C48BE8
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 14:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8F460FE8
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 14:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8F460FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2136E5C1;
	Wed, 16 Jun 2021 14:51:53 +0000 (UTC)
Received: from mail-m121144.qiye.163.com (mail-m121144.qiye.163.com
 [115.236.121.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281766E5BD;
 Wed, 16 Jun 2021 14:40:45 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=oWdj3MK6w00kMAtjf/o9RCmgDwsKgplJKew8/BHJabycQZUq46eLHQuQX2Oo4fv2H9ivLhj3quexArV/B0rYvD0XFih9FxsqsuAE1Cx/NZq08r7C8b2FgNPpacqWitaHBb65FPt5JPZdcrxJbMLj7O8f9xg1PSeilNIrGLR4ewU=;
 s=default; c=relaxed/relaxed; d=vivo.com; v=1;
 bh=nzgfyB066oFaVBGEf/uxwlSYulIxyQZSrA3RBgxK6Bw=;
 h=date:mime-version:subject:message-id:from;
Received: from wanjb-KLV-WX9.. (unknown [121.229.73.16])
 by mail-m121144.qiye.163.com (Hmail) with ESMTPA id B6A54AC01F0;
 Wed, 16 Jun 2021 22:40:41 +0800 (CST)
From: Wan Jiabing <wanjiabing@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Solomon Chiu <solomon.chiu@amd.com>,
 Wan Jiabing <wanjiabing@vivo.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/display: Fix duplicated argument
Date: Wed, 16 Jun 2021 22:40:17 +0800
Message-Id: <20210616144027.27225-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQ00aTFYaT09IS05OQk4fTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6LSo4UT8cGU5PCx9IOTAo
 LxEaCUtVSlVKTUlIQ05PT09JSE9LVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
 SUpVSUlCVUxIVUpNWVdZCAFZQUlMS003Bg++
X-HM-Tid: 0a7a154465f2b039kuuub6a54ac01f0
X-Mailman-Approved-At: Wed, 16 Jun 2021 14:51:49 +0000
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
Cc: kael_w@yeah.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix coccicheck warning:

./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c:
55:12-42: duplicated argument to && or ||

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index cb15525ddb49..dc8b3afef301 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -52,7 +52,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 4;
 		*BytePerPixelC = 0;
-	} else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
+	} else if (SourcePixelFormat == dm_444_16) {
 		*BytePerPixelDETY = 2;
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 2;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
