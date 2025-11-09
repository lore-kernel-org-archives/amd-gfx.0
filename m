Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD84CCFA13
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Nov 2025 15:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F6710E24E;
	Sun,  9 Nov 2025 15:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FQ6vS8Ci";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741F210E24D
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Nov 2025 15:41:15 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso23338345e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Nov 2025 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762702874; x=1763307674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hXvqT5TYDwoUo437mqRGA8qGab9XPLv+qCIHqsJxvL0=;
 b=FQ6vS8CiG3EeLdrenm7Z8yhHzZ/QnyrTTh9UM1e+NU88J2XkjYAyb1P6E0MxDITsTJ
 PnwCYiJL6C3aLhUYwvpOancThz90QGPn1q9i7X2gnKhc3r6MsaqhGfUfKlzBOqviw4/F
 pZi4Qct7maO5CTcc0Z84qb8hIdVt2YQ+mr4tqPEqzyONhdKZKo5/wCt05LJJjw7F1RJn
 /g8Vw8Q4LkjE+WZNF33zAaI2VoqoavbRoBGtaWEhJTO6J2Bjmzmc19LFcP5ur95n7HAz
 zLKe39DYFJFi0xhn6w314fBLVIbdUxm4PbEPHTd8isWBSlyywjReDJPu5xzz2SE23gd1
 5dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762702874; x=1763307674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hXvqT5TYDwoUo437mqRGA8qGab9XPLv+qCIHqsJxvL0=;
 b=OT0L2E+8IzWjuh/tQ4SnYWnbhHtvDQNgHWRQzc0x3dVUCDbi8L77P6FeCmXuZtGIcv
 8ghbZtG+nLzMqwEJ65jdZ5/tvEJzhyghhIpguNLoi6zY/+gWKiV7ELEW56MXXFwGn2U5
 vRQpd2mUcMgAxrAjKLVMahSO0QNtkhfHuYqvUeF97WwZg4bc+xgMp73HntdMmDO4HnYl
 iQLknGrCx77NGrcX8+2riEnU1loyRiXSpASoESHloYDna/q7u34yPhIKxDySC71WanPQ
 AVjy8BOEzi97+Ep8QePoYhKXjtIdk0anDdvMtIoJ+r2U4Fyn0ZxP8TB3nkrTFQXuid9g
 I0qw==
X-Gm-Message-State: AOJu0YyX+B/vxMiOLx5ldUKYtFagIV8P1ARltPGycWWdVFVYNUlQsfc0
 Ul/4aIaCpHeH1lVuRIMFgTm9ggLScyWohLQWBOjlvEHR8uACJS6mmyh9GjJ+Cg==
X-Gm-Gg: ASbGncu+R7Y3ZBzQwOAWj2HnlrSs9YwsakftmEfHCx1d0NN+LvAAQQ/z5TznsNwX/Xu
 XFbDhfw5Ucxbl6cEYvR//oWtNufCWnxEm0jNDewD9f0vL502aGx9Jy1Mn2SGWackyA2s/vmZjBx
 ECR8N9B7A+XofjbFv8ne5Yv8ja6vm7WQpQMaDczEZ+d/cBf7CNVqzhLs7L6D7FF21pS5668IuR2
 rIBod7DcnKswtV6RDZm7i0ECd5jCIpGjoM6diEJxDuKfoGRBdLWle45f5tNmkMcxiNkq/oicoYt
 kH0v+dHc3UJYDqE7Z2vWoZtXLZfIfmNJT4XhA3M/VRKBs2KsxHTArzoxmZ2WTDZXXNVLnUb7lVG
 HAfnBU60Y0KJ7mhWUNDPiTOG4nKhiKI9nzS31BX+0/rMOb7aoBBZ1ZWDG++i0Z/YUiwABg6iW1Z
 BZQ39xHltXWYq8ewHptSnHOiwdkxe3
X-Google-Smtp-Source: AGHT+IHdsEWzKikyPFUHxyVqWANYkA00yzuo3OASp6YlItHHN0ocP38mV++qYmEEKVH7lPR2TQWGsQ==
X-Received: by 2002:a05:600c:4c98:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-477755b5694mr22976175e9.8.1762702873906; 
 Sun, 09 Nov 2025 07:41:13 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24e1:af00:6cff:cfe4:4da7:ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776a278a32sm78918505e9.12.2025.11.09.07.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 07:41:13 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/3] drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs
Date: Sun,  9 Nov 2025 16:41:06 +0100
Message-ID: <20251109154106.43279-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109154106.43279-1-timur.kristof@gmail.com>
References: <20251109154106.43279-1-timur.kristof@gmail.com>
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

The amdgpu driver has been working well on CIK dGPUs for years.
Now that the DC analog connector support landed, these GPUs
are at feature parity with the old radeon driver.

Additionally, amdgpu yields extra performance, supports Vulkan
and provides more display features through DC as well as more
robust power management.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 +++++-
 drivers/gpu/drm/radeon/radeon_drv.c     | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9f3846997f82..3cf36d28d27f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -641,7 +641,9 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
  * CIK (Sea Islands) are second generation GCN GPUs, supported by both
  * drivers: radeon (old) and amdgpu (new). This parameter controls whether
  * amdgpu should support CIK.
- * By default, CIK chips are supported by radeon (except when radeon is not built).
+ * By default:
+ * - CIK dedicated GPUs are supported by amdgpu.
+ * - CIK APUs are supported by radeon (except when radeon is not built).
  * Only relevant when CONFIG_DRM_AMDGPU_CIK is enabled to build CIK support in amdgpu.
  * See also radeon.cik_support which should be disabled when amdgpu.cik_support is
  * enabled, and vice versa.
@@ -2329,6 +2331,8 @@ static bool amdgpu_support_enabled(struct device *dev,
 
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
+		support_by_default = true;
+		fallthrough;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index ac175442d806..40dff6feac8a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -277,6 +277,8 @@ static bool radeon_support_enabled(struct device *dev,
 
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
+		support_by_default = false;
+		fallthrough;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
-- 
2.51.1

