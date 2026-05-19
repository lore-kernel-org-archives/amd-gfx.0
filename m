Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96B9CD5BA1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD1410EB6E;
	Tue, 19 May 2026 08:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9dENNWO";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FD810EB68
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:42:07 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so35359545e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180126; x=1779784926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US/uJr3A8rs9O7YPbhuSazQpk/LIBgGcT4X6/s5JUe8=;
 b=Z9dENNWOeCwogAZEvGpapgURfVHpG3pPKf2j+OnnN7OFXu4ro0CY1PhsiJ8BNTPi0T
 tWwgHAIh1uLK+pR1IXobNqjfB0BGx97R/0Rxh3uWyL6ft22WAUCLF+Kv676F87onQj2v
 pdfFMD/xuRUJGPUc5q8d8rMPtZnH3ryuDs5n97k9dC8K+g0J7RQdSxxP1yZThyFQdOl5
 JUZIrB5xzy0YhWXMEDTGbt5SQsCi+q9pUCBbPPMDJo+lphTBQOuwoufWQnU4xMCyE2Lz
 rNV4XfDQPLDWWiI3JHWAjm5GOfmuG13qzitxw0GKG7R8HQAZVvN6cPXAJNPJJm+wL786
 Dttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180126; x=1779784926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=US/uJr3A8rs9O7YPbhuSazQpk/LIBgGcT4X6/s5JUe8=;
 b=ChiGa9CCenZPTCrNLW7z4kx1zwbhWjUPp7znuLEYAfGkAJupoRol0I9VVrs/TrfHtH
 zl/5uaQ187BGlSsmP+Qn43RJSR0FcjPfIyw/6fWDjtENPu1B2I0SFSP4FARK/SNx/QHg
 PU4R+ay50CvM18hzEHmhNFoVlxg3GSpmKTD60NkoBbv1TGjKLHyj0RljLpFbUtab0jnS
 V5+RU2dECKoNB/nZW9SRUfbgbE5YrlYp7TOhLTFPh3OenF5wdrJPz80tumvixdRiTi5h
 tzQWNiaB+I5TDBpY9e+OvHPg+VGjE7Go5TAVEpM4/DDy/fudSSyDROreFgJP2cirDOs8
 lvSA==
X-Gm-Message-State: AOJu0YxR19WjhdIhBzDbEg0rcLwQWGDDATbLIhDYQMYWyOVd/+WG8UWw
 CYywxxm8lsHz9EF2DISa0R0TVs1bdArV1XKfKU+b9p8zeNReoB+wwxi2kgJKiw==
X-Gm-Gg: Acq92OE19mXssDiRvGA9hLlfKFTH+mMBDFouJiQ1CyQZQ/YCYpu37yLpuD3bsrUKr7+
 uNgmapEy9OADVWLiMdLpl9Ihj5DkJ3AD0UQMCQipM8B0no9wAd9ZbA06qBK0QeM4Wds0aSq/TFS
 /aSv4WgCVqq87fY61EslhLMU/gyO9adCSBWC8PJx3me6odPyhtnJs0XPf9bbOMQA9XGVbQ/DZnZ
 3hwJQBYmecUt3IH9hTmCxwYSHGRbgm+4CZIjcVaxfBSm6av4sc6q7/eqK9J1PpH578NWXwGHoys
 9p1aNeIHKz85LneUvFH+dbOpOUm7MR8FZuQf59zmxaDwTLnH3ITEqOQl9igVArAGf52+vMdDgXV
 l9W5gyL+qXzztGPfMbtiuh/WsEqVivMk/reAksv38rAYXErzTC9n1QbdL2eYOftyTtGLX37xa58
 NAnSRNNf4/w8mzoJFvK8Aty0UI/jHhNH0dBd4addbaKEz+E2WhqfJT162jcbWwP7sN
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48fe61f2768mr211167335e9.15.1779180125834; 
 Tue, 19 May 2026 01:42:05 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm141935945e9.0.2026.05.19.01.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:42:05 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd/pm/si: Notify the SMC when switching to AC
Date: Tue, 19 May 2026 10:41:58 +0200
Message-ID: <20260519084158.72960-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519084158.72960-1-timur.kristof@gmail.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>

There are some platforms that don't have a dedicated
GPIO line to manage the AC/DC switch. In this case,
the SI SMC automatically notices when switching to DC,
but needs to be notified when switching to AC.

Fixup and use si_notify_hw_of_powersource() which was
previously hidden behind an "#if 0".

This fixes some SI laptop GPUs to be able to use their
performance power states after switching from DC to AC.

Some affected GPUs are:
FirePro W4170M - Dell Precision M2800
Radeon HD 8790M - Dell Latitude E6540

Co-developed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 04f3ba5f8f46..832953941266 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3888,16 +3888,18 @@ static void si_notify_hardware_vpu_recovery_event(struct amdgpu_device *adev)
 }
 #endif
 
-#if 0
-static int si_notify_hw_of_powersource(struct amdgpu_device *adev, bool ac_power)
+static void si_notify_hw_of_powersource(void *handle)
 {
-	if (ac_power)
-		return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_RunningOnAC) == PPSMC_Result_OK) ?
-			0 : -EINVAL;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	return 0;
+	/* Check if the platform already manages the AC/DC switch via dedicated GPIO. */
+	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
+		return;
+
+	/* The SMU automatically notices DC, but needs to be notified when switching to AC. */
+	if (adev->pm.ac_power)
+		amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_RunningOnAC);
 }
-#endif
 
 static PPSMC_Result si_send_msg_to_smc_with_parameter(struct amdgpu_device *adev,
 						      PPSMC_Msg msg, u32 parameter)
@@ -8166,6 +8168,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
 	.get_vce_clock_state = amdgpu_get_vce_clock_state,
 	.read_sensor = &si_dpm_read_sensor,
 	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
+	.notify_ac_dc = si_notify_hw_of_powersource,
 };
 
 static const struct amdgpu_irq_src_funcs si_dpm_irq_funcs = {
-- 
2.54.0

