Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF27CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB1F10EAD5;
	Fri, 26 Sep 2025 18:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKweul3s";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FFA10EAC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:49 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-26e68904f0eso26270315ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909829; x=1759514629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrJUOGttvDcxWA0hFMwEv9AoInacMlz2adBs/AwRJsY=;
 b=mKweul3sMSxDQ3NYiWUpJIbCyfim6ZmHnK+BmxD+o8fOXHEJrT/CqzQfrd23CjIC66
 9dvpwTA66o0F8foZOvEp/1IqDgFsOazlPrLWZ6QHNBEF8/aEaTFMnlI2iWBFlcYT/G1W
 jGlm7kjHmDX0P+dLgAp8/4rT1maNSOvsyC1lEYW0q5PuRhaE0ITlwtDbO8FNC+/F5Grj
 gsX2uusLW4S2crHY0WPx4EmVxqTUQq9Y+hAAKJSmA6Kpvko4RH70broqpwx5WOu+ME4Z
 hFcbUdUgPjDvowaVa6MuZ5QOnlL1tLTN41MK8h72Pixr4lj0Uon4gxEmUipwe4ZQMdFB
 HBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909829; x=1759514629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrJUOGttvDcxWA0hFMwEv9AoInacMlz2adBs/AwRJsY=;
 b=r/bcjGwD2z2cCGT37CupBQVLIOAco0hBT9JmnQmtepjDQ130KTnlV5b9bEmOIXdSJ3
 tzzY+GWISXDQ/VfOsDZMNatHe3fbcx5FRWFwG84ygjzh3HN4fO1ym0QqyjDrd+sfS9dv
 ibiaFw4wBPYcq/VkLJcv/ZzFXP4xvijCnQaW8pbGnUSrmSOVw4ieXPtMWQ5nydu6v+VX
 reXI2O0usPgzgS8jl/Y9Uatza6cGpsJsy3xPjcn79AcXDjYeM+kq7ZclbUYXproMkrVo
 0AiktzJrA5Hgtbg74p817f4u/wNrALuDy/1mM1QgyLICnUAsQs3ly6a7WhsyKAlOCo23
 j28g==
X-Gm-Message-State: AOJu0Yw199se2uA1mLiia9fdlHxOn9wBKb79YaEc6Al9hGW0CyKrMFhc
 vERf1hrFJHrW01xUYX44/8eLpJ2CqtN1wsCkwgPcTGSL/raQycqqE17oKudgTA==
X-Gm-Gg: ASbGncvA2NEiO0biJpsd5a5n5F0FEcC8NtR9dcwa6U8/PoxGxMMSWaVs1Qdh/0snNWw
 hqTkgxOhBLB8BWxHRbKzBmXcElR4vWUUXSFzVXxNo1DwmwN+qB5O8jB82JXPxhKPhlbyBlRW1zG
 b31nblJRvBzjCiKpIhSiJar7u4elDsTv2LQV5raV6EayJIsZxAqpXV+HrURvuD8hYOhPdBRIP/V
 u1oaZCWEnC10Kj9vNSLY0XGpImiLWNBaSV6RIirktI4+t3EqyUHxf/41JPgpX4neSZWH26JhooK
 xtKzEY4Ou/3tpcqIXvxEED8mahVzgzZRDDz9ObcF2j2MdmpJGVQkmGPxtZOLuhDZm/GqC70COMM
 IqdQetD5vPO6kFHV8/7LdhZuwvkmzL5ryUQ74T+OtZ45FFAkv+ZHQ/JRh5b8js6yNtg1eOsADOw
 8O5NfbNNZgwZT1nowv3NbqgYyVpJiM6o5Lxf+/uUtL
X-Google-Smtp-Source: AGHT+IGQouYRSSvYNro65vK9umQ5fylMyzaTWSvr7gXZjmoWhXXuVCae4UWcDMuDqiqIB1Crkpm7XA==
X-Received: by 2002:a17:903:3c25:b0:275:2328:5d3e with SMTP id
 d9443c01a7336-27ed4a17a93mr99215835ad.18.1758909829089; 
 Fri, 26 Sep 2025 11:03:49 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 18/23] drm/amd/display: Make get_support_mask_for_device_id
 reusable
Date: Fri, 26 Sep 2025 20:01:58 +0200
Message-ID: <20250926180203.16690-19-timur.kristof@gmail.com>
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

This will be reused by DAC load detection.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 33d0ec38ded7..a126ca3a53fb 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -67,7 +67,9 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 	ATOM_OBJECT *object);
 static struct device_id device_type_from_device_id(uint16_t device_id);
 static uint32_t signal_to_ss_id(enum as_signal_type signal);
-static uint32_t get_support_mask_for_device_id(struct device_id device_id);
+static uint32_t get_support_mask_for_device_id(
+	enum dal_device_type device_type,
+	uint32_t enum_id);
 static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 	struct bios_parser *bp,
 	ATOM_OBJECT *object);
@@ -888,7 +890,7 @@ static bool bios_parser_is_device_id_supported(
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
-	uint32_t mask = get_support_mask_for_device_id(id);
+	uint32_t mask = get_support_mask_for_device_id(id.device_type, id.enum_id);
 
 	return (le16_to_cpu(bp->object_info_tbl.v1_1->usDeviceSupport) & mask) != 0;
 }
@@ -2179,11 +2181,10 @@ static uint32_t signal_to_ss_id(enum as_signal_type signal)
 	return clk_id_ss;
 }
 
-static uint32_t get_support_mask_for_device_id(struct device_id device_id)
+static uint32_t get_support_mask_for_device_id(
+	enum dal_device_type device_type,
+	uint32_t enum_id)
 {
-	enum dal_device_type device_type = device_id.device_type;
-	uint32_t enum_id = device_id.enum_id;
-
 	switch (device_type) {
 	case DEVICE_TYPE_LCD:
 		switch (enum_id) {
-- 
2.51.0

