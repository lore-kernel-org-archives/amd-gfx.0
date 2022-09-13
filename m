Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67F5C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 12:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4BB510E6EE;
	Tue, 13 Sep 2022 12:46:55 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0522E10E644;
 Tue, 13 Sep 2022 08:38:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VPem1l._1663058309; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VPem1l._1663058309) by smtp.aliyun-inc.com;
 Tue, 13 Sep 2022 16:38:31 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH 3/5] drm/amd/display: make dcn32_link_encoder_is_in_alt_mode
 and dcn32_link_encoder_get_max_link_cap static
Date: Tue, 13 Sep 2022 16:38:03 +0800
Message-Id: <20220913083805.22549-3-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com>
References: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Sep 2022 12:46:43 +0000
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
 Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These two functions are not used outside the function
dcn32_dio_link_encoder.c, so the modification is defined as static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:121:6: warning: no previous prototype for ‘dcn32_link_encoder_is_in_alt_mode’.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:136:6: warning: no previous prototype for ‘dcn32_link_encoder_get_max_link_cap’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2117
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index d6855d4f749b..fdae6aa89908 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -118,7 +118,7 @@ void dcn32_link_encoder_enable_dp_output(
 	}
 }
 
-bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+static bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 	uint32_t dp_alt_mode_disable = 0;
@@ -133,7 +133,7 @@ bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 	return is_usb_c_alt_mode;
 }
 
-void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
+static void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-- 
2.20.1.7.g153144c

