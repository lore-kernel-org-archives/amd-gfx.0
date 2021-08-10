Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 02:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3FC60FC4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 02:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD3FC60FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CD489DEC;
	Tue, 10 Aug 2021 02:24:03 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.36 at gabe;
 Tue, 10 Aug 2021 01:31:09 UTC
Received: from qq.com (smtpbg465.qq.com [59.36.132.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FE589DFC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 01:31:09 +0000 (UTC)
X-QQ-mid: bizesmtp36t1628558589ti3iesph
Received: from localhost.localdomain (unknown [111.207.172.18])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 10 Aug 2021 09:23:07 +0800 (CST)
X-QQ-SSF: 0140000000200020C000B00A0000000
X-QQ-FEAT: q17Yoz/cMVqR4uTtLfutpf48qcsdxQjuDlUpWWh0NC4VeWbQIS/Rmlnvkm4j3
 YnxPUmqXHrwVKY0hObWnNURoZPiRDiSzgY0bKDBe5F0G+LdIwVIVc7aweL9eEU0uhJze6/U
 AacmjOuV6+1F/UW1q6TOIiJO8piJI0mu/vO3+o86Td52Ke+gVp26BsYFefefgKO2QKxIpPB
 SiNzbWwDH2LUSfW8ii2IQoKgZnzr2lkKY85zIh2X1JaFqoHsD6LXMi0VXLEJJXWauyqv/DM
 F7/50IIUczMI8n2s6mQ5zcdIg6zSB6GE/m+KB/aPfBABffppsZlQZUJRz4BbvrdYfg9zC/L
 CPP+S6Q
X-QQ-GoodBg: 2
From: zhaoxiao <zhaoxiao@uniontech.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, nirmoy.das@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] drm/amd/display: remove variable backlight
Date: Tue, 10 Aug 2021 09:23:04 +0800
Message-Id: <20210810012304.28068-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Tue, 10 Aug 2021 02:24:02 +0000
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

The variable backlight is being initialized with a value that
is never read, it is being re-assigned immediately afterwards.
Clean up the code by removing the need for variable backlight.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 874b132fe1d7..0808433185f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -177,23 +177,21 @@ static void dce_abm_init(struct abm *abm, uint32_t backlight)
 static unsigned int dce_abm_get_current_backlight(struct abm *abm)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
-	unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
 
 	/* return backlight in hardware format which is unsigned 17 bits, with
 	 * 1 bit integer and 16 bit fractional
 	 */
-	return backlight;
+	return REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
 }
 
 static unsigned int dce_abm_get_target_backlight(struct abm *abm)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
-	unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
 
 	/* return backlight in hardware format which is unsigned 17 bits, with
 	 * 1 bit integer and 16 bit fractional
 	 */
-	return backlight;
+	return REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
 }
 
 static bool dce_abm_set_level(struct abm *abm, uint32_t level)
-- 
2.20.1



