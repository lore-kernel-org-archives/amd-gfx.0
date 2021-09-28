Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6744C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 00:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1937861052
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 00:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1937861052
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hnu.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27F889D83;
	Tue, 28 Sep 2021 00:57:56 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.36 at gabe;
 Tue, 28 Sep 2021 00:57:54 UTC
Received: from qq.com (smtpbg477.qq.com [59.36.132.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BCF89D83
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 00:57:54 +0000 (UTC)
X-QQ-mid: bizesmtp46t1632790195tw1jgkm7
Received: from localhost.lan (unknown [58.20.74.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 28 Sep 2021 08:49:54 +0800 (CST)
X-QQ-SSF: 0140000000800080Z000000B0000000
X-QQ-FEAT: nnjWNCC3Pd2b6FQi5COo3XVZw8NRIvie/GWZqwA4gZn0/ccedwScm2HEILv7B
 yHdlwcNG/8S193gJ365NO9ENNG4kJi7ZuYZ7nv3rCe3CGMw2+P5MaLoqlQfvqZ9Pxa3Aigf
 9nbNqyfPL31DEm0/e6hVuzK6RUcrokjnKGpauzMxIx7Apo6auLHcWl4+fLPDkz5GYTtyRwO
 QhR8ceeAPgQ5PBiZnGgCBr9jzdNgA+833bBT9XwfLnHSYTWHNy5yu4xhcRAeWkS0wZqFBFo
 oi/KTkyEqaS8mRvKd1m+jwzDkU22VJUSh5Cghrxl8Pb989b0wD99wIWZElCntysLykiErZQ
 NKv3JrS0omvtk2Vq6exi4QH9onVQg==
X-QQ-GoodBg: 2
From: huangyizhi <huangyizhi@hnu.edu.cn>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 lee.jones@linaro.org, lijo.lazar@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	huangyizhi <huangyizhi@hnu.edu.cn>
Subject: [PATCH] drm/amd/pm: Fix that RPM cannot be obtained for specific GPU
Date: Tue, 28 Sep 2021 08:49:41 +0800
Message-Id: <20210928004941.6978-1-huangyizhi@hnu.edu.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:hnu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
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

The current mechanism for obtaining RPM is to read tach_period from
the register, and then calculate the RPM together with the frequency.
But we found that on specific GPUs, such as RX 550 and RX 560D,
tach_period always reads as 0 and smu7_fan_ctrl_get_fan_speed_rpm
will returns -EINVAL.

To solve this problem, when reading tach_period as 0, we try
to estimate the current RPM using the percentage of current pwm, the
maximum and minimum RPM.

Signed-off-by: huangyizhi <huangyizhi@hnu.edu.cn>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index a6c3610db23e..307dd87d6882 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -81,6 +81,11 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
 {
 	uint32_t tach_period;
 	uint32_t crystal_clock_freq;
+	uint32_t duty100;
+	uint32_t duty;
+	uint32_t speed_percent;
+	uint64_t tmp64;
+
 
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
 	    !hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolution)
@@ -89,13 +94,28 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *speed)
 	tach_period = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
 			CG_TACH_STATUS, TACH_PERIOD);
 
-	if (tach_period == 0)
-		return -EINVAL;
+	if (tach_period == 0) {
 
-	crystal_clock_freq = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
+		duty100 = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
+				CG_FDO_CTRL1, FMAX_DUTY100);
+		duty = PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
 
-	*speed = 60 * crystal_clock_freq * 10000 / tach_period;
+		if (duty100 == 0)
+			return -EINVAL;
 
+		tmp64 = (uint64_t)duty * 100;
+		do_div(tmp64, duty100);
+		speed_percent = MIN((uint32_t)tmp64, 100);
+
+		*speed = speed_percent * (hwmgr->thermal_controller.fanInfo.ulMaxRPM
+			- hwmgr->thermal_controller.fanInfo.ulMinRPM) / 100;
+	} else {
+
+		crystal_clock_freq = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
+
+		*speed = 60 * crystal_clock_freq * 10000 / tach_period;
+	}
 	return 0;
 }
 
-- 
2.30.0



