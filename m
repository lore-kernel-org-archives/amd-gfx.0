Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA02CAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E7710E10E;
	Thu, 25 Sep 2025 18:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXjpqJPW";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A1310E10E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:45:41 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b5565f0488bso944448a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758825941; x=1759430741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB9pzu5KqhF5/8eneBWpPPe1PbBFkTMqAKDrHhU2bhw=;
 b=cXjpqJPW4+VJEay8GZVLWSSPEa0P9lvkZjDMiN02malh/Ma+Ar5W9WxlfTu3uYfff1
 9SURgEZQbaJjqxV4ganVc5y7rh+fyvySx0wmmHtS17BG+2Dk1gHouLndeX6b0NWWc2Sp
 UuOnfKl3D1n6cfH4F55qIMFepLgGR/8YNUV3tehVi8ebuNzHxHMajW3nQjaOICB88wa+
 cAWBkx8k6w5AAtBYtYifEc/pH+3XSa4/xp2bJxCh4hpX+d1FevMwlo4Uyezz0RzBu2gv
 HYamCJSFhQeCOZnjnxG7enLIisyDw1J6KP5furXXE4Zyo5Wszl5pzCvcm4uoWibEeEO1
 Medw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825941; x=1759430741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oB9pzu5KqhF5/8eneBWpPPe1PbBFkTMqAKDrHhU2bhw=;
 b=vBDrF/xwgj4oMYQoM879cJxENnrMcaY8HMaABfbk2EWpvlL0N1qVxrJbc2pfHBo2IO
 372kktEYZTKHIpyxS1VFItJZTRqi/oGDhMmE9DLnq5jBjAVAFuzJdYLhKelitLXHxlsw
 TkX2qiPkS1Ed+uJHGK/mN9crIn1BynfWxJIJA8zuNjHSDmnAV5pVqO0nxwDGm2lXl0Fg
 NYd50OQLbNIRhLEuESCqBOHWrOqV5mKUbEEcw0ZTvuJol3TxfWGa/NJNLZuQc42hy1kj
 WPEDD5sOTyYB5EH++ylXuLFw7GaCjbbu1E1HWXC+GmzFALFEd/DAI7sGyYyxDHzz81nd
 MV0A==
X-Gm-Message-State: AOJu0Yx3/kg3UpV7HFasrLXxXVGrbdjv9kyFMRJgwnm1eaJ0b+RyurVy
 sWX1DkcENVEynlQL5Gjhe8veLRQsglNeNYxRa2IX1q23LgUzuaJNG11jvnowHQ==
X-Gm-Gg: ASbGncu52sVZ8xhYbwQHwPiRLOnSlo9pOehNeIavtjZvcHw6ouMYCqqm846TKqMD6Sl
 ENrD56Pdj6NC6eQxo/h2lohF1BnQC+9pcmaPQJ0UGx8Om9lTnW2gGz91y4A8IwfiTzE4QGPC1ZV
 40YvZgq3eEtDeVqMFjkYYuqzFHvI9ydtU7LE9AwiyU8tb/iNyD3datj+YQ0Ky7gi4VHaQKR54H0
 0KjvdWguVK1UCAJJequhi1tuT5fga1oT04GHT5e9pmuQZ7SBvRH/WeHY/IuxhsfSUDZhHlH1GBu
 kgI65vUOdIA2JFEkpUOaILrZLnWlbA4HVzmaLzSWSDSj34HWqKCI5Fwb/iZurT2S2KhJ0/CxuD1
 0tUDUYmOJ9mLXuJCfvTViV2uvhRl06qpHi3gOgNVPMKdf6ZzziueFD0IisLnv3DGGC167gSlPBr
 OBQBvZ2ZdE3AzgcxRVPPBIBENQaA==
X-Google-Smtp-Source: AGHT+IE5T5kPkQo7ACOy7OXBT1fHFj4IPz+v1sUIqfNJ6LF6uh+mqL/zc618ZXgqzsJDeBF/crZfzQ==
X-Received: by 2002:a17:903:2281:b0:266:ddd:772f with SMTP id
 d9443c01a7336-27ed4a06cd8mr47949815ad.9.1758825940696; 
 Thu, 25 Sep 2025 11:45:40 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eeb9a8ebfsm4244125ad.67.2025.09.25.11.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:45:40 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com
Subject: [PATCH 1/5] drm/amdgpu: Add additional DCE6 SCL registers
Date: Thu, 25 Sep 2025 20:45:21 +0200
Message-ID: <20250925184525.43290-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925184525.43290-1-timur.kristof@gmail.com>
References: <20250925184525.43290-1-timur.kristof@gmail.com>
MIME-Version: 1.0
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

From: Alex Deucher <alexander.deucher@amd.com>

Fixes: 102b2f587ac8 ("drm/amd/display: dce_transform: DCE6 Scaling Horizontal Filter Init (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h       | 7 +++++++
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
index 9de01ae574c0..067eddd9c62d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
@@ -4115,6 +4115,7 @@
 #define mmSCL0_SCL_COEF_RAM_CONFLICT_STATUS 0x1B55
 #define mmSCL0_SCL_COEF_RAM_SELECT 0x1B40
 #define mmSCL0_SCL_COEF_RAM_TAP_DATA 0x1B41
+#define mmSCL0_SCL_SCALER_ENABLE 0x1B42
 #define mmSCL0_SCL_CONTROL 0x1B44
 #define mmSCL0_SCL_DEBUG 0x1B6A
 #define mmSCL0_SCL_DEBUG2 0x1B69
@@ -4144,6 +4145,7 @@
 #define mmSCL1_SCL_COEF_RAM_CONFLICT_STATUS 0x1E55
 #define mmSCL1_SCL_COEF_RAM_SELECT 0x1E40
 #define mmSCL1_SCL_COEF_RAM_TAP_DATA 0x1E41
+#define mmSCL1_SCL_SCALER_ENABLE 0x1E42
 #define mmSCL1_SCL_CONTROL 0x1E44
 #define mmSCL1_SCL_DEBUG 0x1E6A
 #define mmSCL1_SCL_DEBUG2 0x1E69
@@ -4173,6 +4175,7 @@
 #define mmSCL2_SCL_COEF_RAM_CONFLICT_STATUS 0x4155
 #define mmSCL2_SCL_COEF_RAM_SELECT 0x4140
 #define mmSCL2_SCL_COEF_RAM_TAP_DATA 0x4141
+#define mmSCL2_SCL_SCALER_ENABLE 0x4142
 #define mmSCL2_SCL_CONTROL 0x4144
 #define mmSCL2_SCL_DEBUG 0x416A
 #define mmSCL2_SCL_DEBUG2 0x4169
@@ -4202,6 +4205,7 @@
 #define mmSCL3_SCL_COEF_RAM_CONFLICT_STATUS 0x4455
 #define mmSCL3_SCL_COEF_RAM_SELECT 0x4440
 #define mmSCL3_SCL_COEF_RAM_TAP_DATA 0x4441
+#define mmSCL3_SCL_SCALER_ENABLE 0x4442
 #define mmSCL3_SCL_CONTROL 0x4444
 #define mmSCL3_SCL_DEBUG 0x446A
 #define mmSCL3_SCL_DEBUG2 0x4469
@@ -4231,6 +4235,7 @@
 #define mmSCL4_SCL_COEF_RAM_CONFLICT_STATUS 0x4755
 #define mmSCL4_SCL_COEF_RAM_SELECT 0x4740
 #define mmSCL4_SCL_COEF_RAM_TAP_DATA 0x4741
+#define mmSCL4_SCL_SCALER_ENABLE 0x4742
 #define mmSCL4_SCL_CONTROL 0x4744
 #define mmSCL4_SCL_DEBUG 0x476A
 #define mmSCL4_SCL_DEBUG2 0x4769
@@ -4260,6 +4265,7 @@
 #define mmSCL5_SCL_COEF_RAM_CONFLICT_STATUS 0x4A55
 #define mmSCL5_SCL_COEF_RAM_SELECT 0x4A40
 #define mmSCL5_SCL_COEF_RAM_TAP_DATA 0x4A41
+#define mmSCL5_SCL_SCALER_ENABLE 0x4A42
 #define mmSCL5_SCL_CONTROL 0x4A44
 #define mmSCL5_SCL_DEBUG 0x4A6A
 #define mmSCL5_SCL_DEBUG2 0x4A69
@@ -4287,6 +4293,7 @@
 #define mmSCL_COEF_RAM_CONFLICT_STATUS 0x1B55
 #define mmSCL_COEF_RAM_SELECT 0x1B40
 #define mmSCL_COEF_RAM_TAP_DATA 0x1B41
+#define mmSCL_SCALER_ENABLE 0x1B42
 #define mmSCL_CONTROL 0x1B44
 #define mmSCL_DEBUG 0x1B6A
 #define mmSCL_DEBUG2 0x1B69
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
index 2d6a598a6c25..9317a7afa621 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -8650,6 +8650,8 @@
 #define REGAMMA_LUT_INDEX__REGAMMA_LUT_INDEX__SHIFT 0x00000000
 #define REGAMMA_LUT_WRITE_EN_MASK__REGAMMA_LUT_WRITE_EN_MASK_MASK 0x00000007L
 #define REGAMMA_LUT_WRITE_EN_MASK__REGAMMA_LUT_WRITE_EN_MASK__SHIFT 0x00000000
+#define SCL_SCALER_ENABLE__SCL_SCALE_EN_MASK 0x00000001L
+#define SCL_SCALER_ENABLE__SCL_SCALE_EN__SHIFT 0x00000000
 #define SCL_ALU_CONTROL__SCL_ALU_DISABLE_MASK 0x00000001L
 #define SCL_ALU_CONTROL__SCL_ALU_DISABLE__SHIFT 0x00000000
 #define SCL_BYPASS_CONTROL__SCL_BYPASS_MODE_MASK 0x00000003L
-- 
2.51.0

