Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5624C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 12:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7455910E773;
	Tue, 15 Apr 2025 12:30:12 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A18710E109;
 Tue, 15 Apr 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [124.16.141.245])
 by APP-03 (Coremail) with SMTP id rQCowAD3oD1oSf5nr+UACQ--.19460S2;
 Tue, 15 Apr 2025 19:56:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/pm/powerplay/smumgr/vegam_smumgr: Fix error handling
 in vegam_populate_smc_boot_level()
Date: Tue, 15 Apr 2025 19:56:00 +0800
Message-ID: <20250415115601.3238-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3oD1oSf5nr+UACQ--.19460S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww48Jr4UWFWkJryUGFWfKrg_yoW8ur1xpF
 9xCr9Ivwn5JanxJFnrtF1IvF1rZ3W8JFWrCF17C340vw1Yqr1UZr4YyFyavayUCFyxGwsI
 qr17Z3W5ur4I9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
 VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkNA2f+Ih6YKQAAsU
X-Mailman-Approved-At: Tue, 15 Apr 2025 12:30:11 +0000
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

In vegam_populate_smc_boot_level(), the return value of
phm_find_boot_level() is 0 or negative error code and the
"if (result)" branch statement will never run into the true
branch. Besides, this will skip setting the voltages later
below. Returning early may break working devices.

Add an error handling to phm_find_boot_level() to reset the
boot level when the function fails. A proper implementation
can be found in tonga_populate_smc_boot_level().

Fixes: 4a1132782200 ("drm/amd/powerplay: return errno code to caller when error occur")
Cc: stable@vger.kernel.org # v5.6+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../drm/amd/pm/powerplay/smumgr/vegam_smumgr.c    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
index 34c9f59b889a..c68dd12b858a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
@@ -1374,15 +1374,20 @@ static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 	result = phm_find_boot_level(&(data->dpm_table.sclk_table),
 			data->vbios_boot_state.sclk_bootup_value,
 			(uint32_t *)&(table->GraphicsBootLevel));
-	if (result)
-		return result;
+	if (result != 0) {
+		table->GraphicsBootLevel = 0;
+		pr_err("VBIOS did not find boot engine clock value in dependency table. Using Graphics DPM level 0!\n");
+		result = 0;
+	}
 
 	result = phm_find_boot_level(&(data->dpm_table.mclk_table),
 			data->vbios_boot_state.mclk_bootup_value,
 			(uint32_t *)&(table->MemoryBootLevel));
-
-	if (result)
-		return result;
+	if (result != 0) {
+		table->MemoryBootLevel = 0;
+		pr_err("VBIOS did not find boot engine clock value in dependency table. Using Memory DPM level 0!\n");
+		result = 0;
+	}
 
 	table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
-- 
2.42.0.windows.2

