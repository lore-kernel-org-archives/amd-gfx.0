Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33904C8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC58910E58C;
	Mon, 25 Aug 2025 21:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkmY6fX+";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B240A10E58C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:47:01 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so1665599f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158420; x=1756763220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUJuIyT0Skzo6LBSxXHMEC4kyE4YuyorVblJfPk1GCA=;
 b=QkmY6fX+cYj4HqKrKTsJrgjMZDrNDhU97y5NU4Zl1N7wL7cQllRyf53RBw8CG70Zfg
 0Z9w5ldK5/LbomY+oNhXI9YAFScYQ9yeGknh+Ry0KRWsV0G9c6oW25Dc3r2cuXnctqMz
 2+ZdjlCvE5qaIv0UwOMZbxOG/LZThNhcYJHXrM+TuM7NFwsvEuR1MkNm/Wszg3jeubeV
 7hMTCtTT+A4x6UIn/NtRg0iGgYt8IpOkoff8eVjMpElOltZ1FzWRE+VWPfTU8bLgHJrD
 vmfEL7j/Wkisd6CTvrDChXxKiS5Z03xOk0SM6t+qzkl2CzqjNB4QcNlOX1z59O+WPHa9
 3f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158420; x=1756763220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUJuIyT0Skzo6LBSxXHMEC4kyE4YuyorVblJfPk1GCA=;
 b=gqKquyHb+ZzmNSN9XLP32ujs+IoQdTxnVT/w6ug9sKj2ufspraN34yE3RPxODYQDyU
 yAQ1Ly9XQQlWcb+junGzW9QIBie0aKdqnqlgCUG6oZ8x/N6TxEF6wy5uXn5C1BFQ95dZ
 C41JCLVUZFxboqHE7203AaomFtFmTwXyKZ0NB6NOlPLbFcCwjnkK26aFgk7kBUmdkN/y
 /xMoAdrLEh5hHVJmFSuS/NdE0uDushOKTjCAq+4S/Ph3zLr6jZtebZkVW3j1Ghxe52sD
 IMwxPyfKl4ZfMxBubhjdI5YXs1RhuU/OoNpaxDoMN45UDeAnH/dbvf4Y4XBVbvY0xdyu
 ADqQ==
X-Gm-Message-State: AOJu0YyrkDFtJjisOVOIv8pZLwgRleo7iBfSztFCDmhR9VFOaCQnDIsz
 2WsU1bMWezXgY8AD2EdNfKJFxZGZPCYdXPtsuyBIPTlAxrn8Q6AljA+pbWsMbQ==
X-Gm-Gg: ASbGnct5EOaUCUozeHzTpceI4R0N4+oiUGjeYi8q86C0O0RTkwFr32a7lQ7uy8P4kOw
 noZe0nTkaGvarVaXktUmRIGdMTjP+k1TQaY9g2LGHgxo4SIANtsKbGOaM782oUiWy2m2nU+Tycl
 +lIi1lGUq6oiXvHGZZeDLxztRWtbeHf1/faSBvuh32eDczcTqJAuM5jIPAvL2zjO9YUdBJ2eQFc
 ntbSLTceV1vKFQCMg+7s7oOyUlqN8p2HbFX+u58eBncoTZV6yqqu2CiHc4keisDQc4laidDBxo1
 PC7cZlwfgsyYlpri0Kgo5GFavksK45yW/xijFilj/5ztZfL7RTB8qm+4/hBc48jWoSga2MfpgA0
 LqIw2bCUtHr9xA5cYPZHN8KGS10f+y6lnsfvG0yUBPZXcKtp4X9vs7AtUuQpNCgJOlphgsNb7Ip
 wHZxHfrHsIoKCDh/owBj+1Scvsp52Ln6lgZq4K
X-Google-Smtp-Source: AGHT+IHiq7lHsqXyMTjvmOABeqby/uMmY0dJF8JVRpkIAIwh1Jaj3+oze2dtdaDHDBgV8BYDEAUMCA==
X-Received: by 2002:a05:6000:18a8:b0:3c8:e475:6ed6 with SMTP id
 ffacd0b85a97d-3c8e475777emr5460746f8f.62.1756158420097; 
 Mon, 25 Aug 2025 14:47:00 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:59 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/8] drm/amd/pm: Fix SI DPM issues with high pixel clock (v2)
Date: Mon, 25 Aug 2025 23:46:34 +0200
Message-ID: <20250825214635.621539-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825214635.621539-1-timur.kristof@gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
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

We define "high pixelclock" for SI as higher than necessary
for 4K 30Hz. For example, 4K 60Hz and 1080p 144Hz fall into
this category.

When a high pixel clock display is connected, always disable
memory clock switching to solve some flickering that can be
observed on 4K 60Hz displays. (It's very subtle but noticeable
on Pitcairn and Tahiti.)

When two high pixel clock displays are connected to Oland,
additionally disable shader clock switching, which results in
a higher voltage, thereby addressing some visible flickering.

Ideally, these issues would be solved by introducing something
like dce_calcs, but we don't have that for old GPUs, so
ad-hoc fixes become necessary.

v2:
Add more comments.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 1e2aeea0b552..3fe6fa564e71 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3443,12 +3443,14 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 {
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
+	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
 	u16 vddc, vddci, min_vce_voltage = 0;
 	u32 max_sclk_vddc, max_mclk_vddci, max_mclk_vddc;
 	u32 max_sclk = 0, max_mclk = 0;
+	u32 high_pixelclock_count = 0;
 	int i;
 
 	if (adev->asic_type == CHIP_HAINAN) {
@@ -3476,6 +3478,42 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		}
 	}
 
+	/* We define "high pixelclock" for SI as higher than necessary for 4K 30Hz.
+	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
+	 * Find number of such displays connected.
+	 */
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
+			!adev->mode_info.crtcs[i]->enabled)
+			continue;
+
+		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
+
+		if (conn->pixelclock_for_modeset > 297000)
+			high_pixelclock_count++;
+	}
+
+	/* These are some ad-hoc fixes to some issues observed with SI GPUs.
+	 * They are necessary because we don't have something like dce_calcs
+	 * for these GPUs to calculate bandwidth requirements.
+	 */
+	if (high_pixelclock_count) {
+		/* High pixelclock displays need higher memory bandwidth.
+		 * Disable memory clock switching in order to:
+		 * - Solve visible display flickering
+		 * - Avoid starving other clients of the memory controller
+		 */
+		disable_mclk_switching = true;
+
+		/* On Oland, we observe some flickering when two 4K 60Hz
+		 * displays are connected, possibly because voltage is too low.
+		 * Raise the voltage by requiring a higher SCLK.
+		 * (Voltage cannot be adjusted independently without also SCLK.)
+		 */
+		if (high_pixelclock_count > 1 && adev->asic_type == CHIP_OLAND)
+			disable_sclk_switching = true;
+	}
+
 	if (rps->vce_active) {
 		rps->evclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].evclk;
 		rps->ecclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].ecclk;
-- 
2.50.1

