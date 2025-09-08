Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B64CAC58F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B1110E881;
	Wed, 10 Sep 2025 08:01:13 +0000 (UTC)
X-Greylist: delayed 383 seconds by postgrey-1.36 at gabe;
 Mon, 08 Sep 2025 14:32:34 UTC
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8251310E543
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [159.226.95.28])
 by APP-01 (Coremail) with SMTP id qwCowABHoqR9575o6WStAQ--.1721S2;
 Mon, 08 Sep 2025 22:26:06 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] drm/amd/display: Add NULL test in
 dcn21_set_abm_immediate_disable
Date: Mon,  8 Sep 2025 22:25:53 +0800
Message-ID: <20250908142553.429-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABHoqR9575o6WStAQ--.1721S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy8KFWfur48Kr1kXF1UWrg_yoW8Ar1Dpw
 4UWa4FgrWDXan29ry7X3ZxuF47u393Gay2kr9rGwnIv3WYyr45tF4xG34YkrW3uFWrAF13
 AF4qgF4UuF1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjfUnBMKDUUUU
X-Originating-IP: [159.226.95.28]
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiBwoTEmi+suqcmwAAsF
X-Mailman-Approved-At: Wed, 10 Sep 2025 08:01:12 +0000
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

This patch is similar to commit 66951d98d9bf("drm/amd/display: 
 Add NULL test for 'timing generator' in 'dcn21_set_pipe()'").

In "u32 otg_inst = pipe_ctx->stream_res.tg->inst;"
pipe_ctx->stream_res.tg could be NULL, it is relying on the caller to
ensure the tg is not NULL.

So the dcn21_set_abm_immediate_disable function should also add NULL test
for 'timing generator'.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 61efb15572ff..50896aed8245 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -179,9 +179,15 @@ static void dmub_abm_set_backlight(struct dc_context *dc, uint32_t backlight_pwm
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 {
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+	uint32_t otg_inst;
+
+	if (!abm || !tg || !panel_cntl)
+		return;
+
+	otg_inst = tg->inst;
 
 	// make a short term w/a for an issue that backlight ramping unexpectedly paused in the middle,
 	// will decouple backlight from ABM and redefine DMUB interface, then this w/a could be removed
-- 
2.34.1

