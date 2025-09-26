Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0D4CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F4010EACB;
	Fri, 26 Sep 2025 18:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IeC18rpV";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DEED10EACB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:04:15 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b5579235200so1808886a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909855; x=1759514655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ptR92AIqaWm0Mts8g/4edbnWG4YSsDbG8KQyib28FQ=;
 b=IeC18rpVscXl5c93z3tIGFdravSvK3VnY/3ajXtJvcSXGX+agwh9bW0cfXHuZX0+ve
 vEA7P2ewb1xino3u2dyfObwGEB11qJd6XGdgm++XGQ7i+iDtOPS7JTI4N7m/860a7mcM
 kegM91xk1bsLuwz6VH6ZdzL9PfMFsA8XnP6fRPIWsVuvRK7xCPk+Sk3OMPchK6pirgEn
 Cn1Mn/80aqBIYyglUNTHhta7R4Mv0xHMWtgQN0ASyfFmlAIF5HvqSv7m8EgnU/DQ/oBV
 XmoZkIGWrkx1wnl8CS392U4gIWwQUhgI+4AgWtf/VZ0W6gKCfkChE+NKyCAcyucJZ3DE
 aQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909855; x=1759514655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ptR92AIqaWm0Mts8g/4edbnWG4YSsDbG8KQyib28FQ=;
 b=YpmsbzBCRMPevpgl09nqL1zeIW/nhxnF2kMHjLjjLCfi8a8T7P+UlW7PQn/q+6Ea+e
 xvhyuQW7sr4GmJMLakIEpoy1xxZLVykRQXrQpnr4zYC9GR4rmUh4vKjU3QSRocp5P4rw
 ZxitP2rYsUHR8VCdQQTn1VZEJo2s3aeXCAomXoKwNio7UMSN4xOVl279W9Kel3LRvcN7
 eZFDZO5e8w8TanpxKT18PlyPWwKhkqEZeb49F0nshlw42NE2+mzMFYuLp7zsNzVlq0hV
 0uhloN3DlrDaG46er/t/55z4Yq0/LoxVqScQnhS/pp8Ow33E1C4Iusbi4K7bgxMKpFMq
 kfRQ==
X-Gm-Message-State: AOJu0Ywri+aMRW6Lsy13eKCbnbw7942VF7i+Yc+0CTf5jcGXOlX3ASEh
 IRSPLLI0JtrCI4DPDi+VgFuDrPlDFDqN7/motrkbx4WddgpwlSvJrJaQycrxpg==
X-Gm-Gg: ASbGncu+ANewlOU/5qPtTRUQgfo/+n4V8oI2Qkod/qGacIHkNXR75tT1khM0Mlu3gVW
 nyfWFC8wgYfbvvBWi/9htI5kGozN9sA33DM9ssuYKcv8kuanb0Xuz1kAz0e01tP4zht/8GtOvgH
 /sgASH9kB60CX4Sit8wUTC+Kndyv6qq14VkTyv8TdMpsVdDzxvZ+jMy7ee5QEUbMDC+LFoi+a8u
 u/SrFuUGt/klYfSXWMfBgfiD+73yXLfCKN9ABrebnuFsqdVbNtBd4QwaKwotjcNZAYYRfvFa8j7
 shQdWSdwTNBTRneqvFZXBcDXbXYDx+3b+6Em0ApRC2ZS/bLTD5wmK/5pZQTV/9FzKZMgVNs0yh+
 pZUyqQq9ZXdQ6/KZMhVCNmhep2+D76cUQKssk7QX/zUI/4khyvSRPY9PQ3V4TWy+mWwIv1Djfh6
 JK7Iajnns05zxGW/g2gtnF1IyysQTtsw==
X-Google-Smtp-Source: AGHT+IHH+TRm3lqrVk8sZXRlxTU8ymRwpGoJuzHVklt3u2bwru5kMyDm9AgnifE63nN6GsDyfjLVhA==
X-Received: by 2002:a17:902:fc86:b0:269:8407:5ae3 with SMTP id
 d9443c01a7336-27ed4a60923mr104090795ad.54.1758909855016; 
 Fri, 26 Sep 2025 11:04:15 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:04:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 23/23] drm/amdgpu: Use DC by default for Bonaire
Date: Fri, 26 Sep 2025 20:02:03 +0200
Message-ID: <20250926180203.16690-24-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

Now that DC supports analog connectors, there is nothing stopping
us from using it by default on Bonaire.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..6fe715da88e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4184,7 +4184,6 @@ bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
 #else
 		return false;
 #endif
-	case CHIP_BONAIRE:
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
-- 
2.51.0

