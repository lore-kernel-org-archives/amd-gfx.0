Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC54C47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 08:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2B010EB3E;
	Fri, 22 Mar 2024 08:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ht5GHuxZ";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Fri, 22 Mar 2024 06:14:17 UTC
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C2310F512
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 06:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711088055; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=ZnOfZWACaOxrEQs6ttoM82Jv+ZuQFuiTW3VGfaJ+7y4=;
 b=Ht5GHuxZXsL6hJN7RwjXkYAXVAGmnHg6MnDQMM2ZEyKwHiwVc9lENUV8auFUQHLrv74miwab+tAva2Kp9FRqP/mr9Q9MVAGsydLr/31qocBxLLiSl4YAuk3xRWUUes91BJuFEkvG25N1RBDCIY93t9i9FZmAOjvqQGBdUqOZsPE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W315rNc_1711087740; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0W315rNc_1711087740) by smtp.aliyun-inc.com;
 Fri, 22 Mar 2024 14:09:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: clean up some inconsistent indenting
Date: Fri, 22 Mar 2024 14:08:59 +0800
Message-Id: <20240322060859.120155-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 Mar 2024 08:26:32 +0000
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

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn351/dcn351_fpu.c:569 dcn351_decide_zstate_support() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8608
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index dc9e1b758ed6..1c16c5f2ce78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -564,9 +564,8 @@ void dcn351_decide_zstate_support(struct dc *dc, struct dc_state *context)
 			dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 
-
 		/*for psr1/psr-su, we allow z8 and z10 based on latency, for replay with IPS enabled, it will enter ips2*/
-		 if (is_pwrseq0 && (is_psr || is_replay))
+		if (is_pwrseq0 && (is_psr || is_replay))
 			support = allow_z8 ? allow_z8 : DCN_ZSTATE_SUPPORT_DISALLOW;
 
 	}
-- 
2.20.1.7.g153144c

