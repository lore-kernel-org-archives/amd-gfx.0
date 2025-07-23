Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B938EC87FCD
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A0E10E80F;
	Wed, 23 Jul 2025 15:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDbUB/Aa";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BACD89196
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso56169035e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286313; x=1753891113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cT0B32NTl7aFc1KRckpae57/sS1O3c6Kojzb6e4sa8=;
 b=nDbUB/Aac44DdiPaD+ma5gEiWb7TYs3X98hAPQg8XKs8M6ucmKH2AYemRcmiWnZa4U
 ZMQlOtjZnSMy5tHFSZSKXh0MAFUvUf5R2vUL76h69cnBzhPxXoRUmihhbaajS/5GjJrV
 0EkJ6X21oylyID/Ypavmy8n9iB3pCTAr1oBBz063HarSJchfEcu+LUYf/8kanhdxS1wS
 yogTeTStpvVF3/riSPnmcycO3agZUdbCrWSFiIl1GMFDNag2fgAEVuCpd2oEvjejT/t3
 UVBcXXxtfPm5Q2PdL3+44sJwPpX4uTz+Memt+0l+LY6BtBvt0cUB5unUd/ZACbA92Se8
 XlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286313; x=1753891113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cT0B32NTl7aFc1KRckpae57/sS1O3c6Kojzb6e4sa8=;
 b=P6aDUh7CBT5NS8yRNefYrz05CeiberYR5Snu/M/GXDh4VtrVuho2Pbkz89QhHK05kp
 KACgdtg8ExEAwhxS4RBjSRUuyYVWmYbi1iElTjmTGK93aqglWwVe6rfBxqPODIGXvAls
 kyphh/7xA/th4Ite/wSNLjXfjYknXeh7vWxkCUO+s3fJyRKrtjciX5Il6v3nTXYPV+3u
 jU7nrmk82560gBcgxtXRWXs0lS4bDnyCTe4VAEvDfPSE5YjsUIQumC0iatt3wTNIa0sx
 bsVNqDlck6lRtHspG9wlC8/TOinbx5LLGfRi2EOGXaE0TjYuFnz5AP/UPE9N8U3KFoRG
 wvtA==
X-Gm-Message-State: AOJu0Yz2ssJs9IaxM+asdf2vyk5bka6V09uZZ11uAuTRtgNfY54RQwOd
 YaHDhgS9+KgmnED0ciuVD++lfHC/oI9nya0HGhGZYn3P4Y8+VX4ZfNBBrqJjXA==
X-Gm-Gg: ASbGncs0LG+eRN1bcRnp0GUgSwlGpxYd6C0u63oY/KyfLrU48HEfPTWklBRz+Pfo8Ou
 hREOuq6nx/D734MKgBAYLiFMolc/W2WMIb+HaoulRGC5cTkZr6S9SnSgxCYOgTay4/FauP3GutV
 co2Yl/gjT/EY+erhueQKes6Z+gcEAS2c276WUc7r3qdq9RDungNb+9DMzUohBzbhzWAzdjWDrN6
 PTBy81f5G9dCGhOI3hn+MdetFEHvMyjGtyY89mM9/2bDSnugKSpbmqKJI5mahIyRApBDVdJPHWy
 VGLAUtiOgulRpb8zHeUHr3lv/jURULJp7tmfG3Evpx+sK0B8fzJhrRFXY8RYg25byw8hQuytIM5
 TgnLFEDjpBl1rN3Drb0QW6NjcniPLgKIxGU1zd4Y/s1KvE/P0zLf7W+Bnl8rxRERF9GZc3dZKQO
 x+A161LPilg0FrJgER8xJAA6LSVg==
X-Google-Smtp-Source: AGHT+IHtUd9PyJOsHF7lTZFJfxIuBb6h3Vxi+aA8hYbpyc8rcUm9HHrS6C7/tk75188PqrB3YBEkBA==
X-Received: by 2002:a05:600c:630f:b0:456:2bac:8f8 with SMTP id
 5b1f17b1804b1-45868d485b0mr39467465e9.16.1753286312577; 
 Wed, 23 Jul 2025 08:58:32 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 16/20] drm/amd/display: Make get_support_mask_for_device_id
 reusable
Date: Wed, 23 Jul 2025 17:58:09 +0200
Message-ID: <20250723155813.9101-17-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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
index bd61ed6cafab..44f71757508f 100644
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
@@ -891,7 +893,7 @@ static bool bios_parser_is_device_id_supported(
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
-	uint32_t mask = get_support_mask_for_device_id(id);
+	uint32_t mask = get_support_mask_for_device_id(id.device_type, id.enum_id);
 
 	return (le16_to_cpu(bp->object_info_tbl.v1_1->usDeviceSupport) & mask) != 0;
 }
@@ -2182,11 +2184,10 @@ static uint32_t signal_to_ss_id(enum as_signal_type signal)
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
2.50.1

