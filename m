Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB41F3D605
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8759010E12E;
	Sun, 29 Mar 2026 16:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6jMeCWV";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C0910E0DB
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:12 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-486fb439299so33256565e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800191; x=1775404991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9gt4xHpf7P721YJMl1Y/s6e7LnOaa7T+QnU2bO/nPg=;
 b=P6jMeCWVQ81DCpP/H8b3KTdKRRSYRt5CZpjtrd9eJnms7x1GDyz21LZkCcXlh3Lu/v
 hBCiMsd/SBzXxrKzK1GJA+swtGPKqQcjstz8vQJiZUCLp89344MjWVsrtYWnd8c5TcQp
 lQ8XlefMsNtocaKJ5IW64AuVqRwqemReg4eDo6E5TlDQaDGLoszhr7K1VDRi7XYzc4wo
 r/bb0jXCCpRJQeWCenK5JwKeVnkBZ2xXJMx59e//SzjdVM8l70HwGZ7nN6TjVhCwqg4S
 iT1AbWNkL7op55O/k2ShC5mDLnnRTKGnF/eMadgsQS69B/McIbJMyGzqmpQ08DVh7w/Y
 Pd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800191; x=1775404991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9gt4xHpf7P721YJMl1Y/s6e7LnOaa7T+QnU2bO/nPg=;
 b=fAetDKQ96lnbKNTTnZqBKaUs7ZceByTHtUMgSSk7OzSRSMTOVJoyLXEY1k+9VgIv5L
 W5/LExfA7HBZx21YQk8HhnZ+/oZudpjxDSdeYP5ZGQDynfwTyedTeBjwS1zEtGdCQNPp
 vgkCfTP11RzX+uGQX82gyIRD/o+1uMYDDFc+0QadOI/54HiL9mm/MykEYD7P4bqhHLzW
 VYVMDfnrPhKAO+G/4g8O9u+mQPDPXelO8cOB95OUVRbcQzTFZWka53Sngu+sghuvXPDp
 bbwmiv9AA6UW4Y2x0RLkVSk4Q7o3Y/j4+ONXGTziuvswUY/+odIpwtR+pWi/UQOz+X/T
 V9Pw==
X-Gm-Message-State: AOJu0YxYq1UWv+uPe32+kHi8fehfWxVpCtHLFrgh1lzjC4WqS93lpNJx
 FPkQvBpmVtPVuLtywx4RyiLVHeKOnwZ+2gKxZG8x5dLWOkq4ByZ21jzF92hwGg==
X-Gm-Gg: ATEYQzyTuA30cOtTEIPcPxjcNiAyHcE52vGpcanRr/a4sfJ257qvseLal82JhV3L3fP
 cHSISZ5S38fkLmFnlGRWCgfdgPJ3/DutED/rystgbQ2J6IdD9YlIElivegEf20KT5CgW5Z42zZx
 p6GZc+4+4+6tRuwQWN178I8BLOHDqLVUwdhgweY5d8I0xmdbsdkQfipG6bvZzt2lqt3VLEEclpN
 RAxU9A6UUmmZOF7begKwqnmzVLAb/Rp6Tabk1hXtkaYxgWaRX9c/xU6uOsRHEjEnCFc+ePyjNxk
 74CT19r93oroU0HxxcUtYNEJjJ49tjKPNEKL6kT8dOSlMdlsmWS7TePAbfX5ufPWmVwFKy6n5br
 pC8vgzjrkHJ6VvkHZMg1up4eXhbEXdBgOOJBD9ecmgpTbb9XbowLiKDcGXxzB+t//F5GYEm2WyF
 ewRFWOagZIEvOwPmCOJEoXGMDz1K0yKPn0jQ2DFikEniIR/iQbQUew2WASKiulG9b7TaE=
X-Received: by 2002:a05:600c:c493:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48727ef163bmr150966955e9.4.1774800190945; 
 Sun, 29 Mar 2026 09:03:10 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:10 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/9] drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
Date: Sun, 29 Mar 2026 18:02:59 +0200
Message-ID: <20260329160306.3417458-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160306.3417458-1-timur.kristof@gmail.com>
References: <20260329160306.3417458-1-timur.kristof@gmail.com>
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

There are two known cases where MCLK DPM can causes issues:

Radeon R9 M380 found in iMac computers from 2015.
The SMU in this GPU just hangs as soon as we send it the
PPSMC_MSG_MCLKDPM_Enable command, even when MCLK switching is
disabled, and even when we only populate one MCLK DPM level.
Apply workaround to all devices with the same subsystem ID.

Radeon R7 260X due to old memory controller microcode.
We only flash the MC ucode when it isn't set up by the VBIOS,
therefore there is no way to make sure that it has the correct
ucode version.

I verified that this patch fixes the SMU hang on the R9 M380
which would previously fail to boot. This also fixes the UVD
initialization error on that GPU which happened because the
SMU couldn't ungate the UVD after it hung.

Fixes: 86457c3b21cb ("drm/amd/powerplay: Add support for CI asics to hwmgr")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 2b5ac21fee399..1d6e30269d567 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -104,6 +104,21 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 					 PP_GFXOFF_MASK);
 		hwmgr->pp_table_version = PP_TABLE_V0;
 		hwmgr->od_enabled = false;
+		switch (hwmgr->chip_id) {
+		case CHIP_BONAIRE:
+			/* R9 M380 in iMac 2015: SMU hangs when enabling MCLK DPM
+			 * R7 260X cards with old MC ucode: MCLK DPM is unstable
+			 */
+			if (adev->pdev->subsystem_vendor == 0x106B ||
+			    adev->pdev->device == 0x6658) {
+				dev_info(adev->dev, "disabling MCLK DPM on quirky ASIC");
+				adev->pm.pp_feature &= ~PP_MCLK_DPM_MASK;
+				hwmgr->feature_mask &= ~PP_MCLK_DPM_MASK;
+			}
+			break;
+		default:
+			break;
+		}
 		smu7_init_function_pointers(hwmgr);
 		break;
 	case AMDGPU_FAMILY_CZ:
-- 
2.53.0

