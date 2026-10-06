Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5489CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 21:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4131A10E228;
	Tue,  6 Oct 2026 21:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bop6a9jH";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D4710E228
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 21:16:13 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2e8c710847so146408466b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791321372; x=1791926172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YOC/vCrCb/Mi9jmeFF74V+DUhyC/gntWibNcItaH5PA=;
 b=Bop6a9jHgc7NrnnV1YCDMqPStx05Ev4FiZ8kD2DVdf/tCKbcNevwQCVxcZSRgTQrqr
 khe11O4tmTe2/6TaMk/6pDKnl2U5I5eZumukX+dLmD+C8S7MA7i+2O9Mi0QroPcMHohX
 PR6cbytTetEB2AMOpJZbwO5AQ0Rdu4+jZIE9eT4nPX43ogIOkgEV9/MNYl7nC++rp8ep
 pfiVZ/30d80fduPj9T0kuD7mTyQGnTCZ1ONJ8UO5+pDzmZagCAu3lzMmcb6UuqKRpp03
 QQNu6B7vXLE8YtSc0C3+j4g/XgRMYKpZGNgMiKtPcUbogez8tQZ17gZ3mbjeqpkQ9XUZ
 Xaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791321372; x=1791926172;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YOC/vCrCb/Mi9jmeFF74V+DUhyC/gntWibNcItaH5PA=;
 b=Msb6eMqWycev0AAG50d3JEUuMi7lCGWjUZ46rcAbKVTw/i1poqQRjhS85Ala1JRgzF
 i80FTBJlkph7VWJXE912Qd3xPOC+KCE/fP0bhlY84eS65scF0Kaqv/3xjUMrtjqFjwgp
 6Lnchqn/8UpnVxtL2kRQNJez0iGy41OH800Pw30EfuXr7i+aNmYQAelBK3AN2M+x3qjA
 PRd3COmreuHXwGmDycnJ+nTHFR5Ho4AvnIoYNGiGVUfuP420LpIp9C+1QdO8Y+8VF3Ix
 PvA2grXDPk34/aH2AZpkU9LuEeOXmBBUGJXC/sOJO5yjBtSvD36gxPIUgAZ5DMVfnJGR
 llAw==
X-Gm-Message-State: AFuF++mHP0jf9n5ZwOf2HEMgekHV+ihDzTRw7wO34CFuERfM0MbD8EO1
 KtpYbYfZ3CzaMHAN2Ta3pqLEvnfQFF4oO/Yh+WQdpBLNpPbFVHONVvqdhpjK4g==
X-Gm-Gg: AYBFou0owrBb585MZ8z/upmVi5szguQIi20L93aPd1GTm1mMh1bNL49OMP7OxBYTnxZ
 nVaP56Ujv8U4MEvLkKbMWj+EC4L2usbRfNod5YhDhuCo4XqEH0Fb6RpMr687VntqJsElepaJume
 v3xuohGCiqzUF+wqxcAtWMP3F9YZscLe/qIGJzKKEAdVPsyL3n4pIdDZeCatOo2rqxJIu3xd/Uo
 a8t+eRBs+7G8ip7XLUFRYUMLVbq/dunufvXzODW5wOrq4pPh7daz3EHiN5jRftfJEs6CsdgmvKS
 sQwe326x1zf1f7fxm2+DAya3Zb/G316vBmKU84VPW0uEXNwHPrF5j39DZX09ZWvaR7ydXKfe0JL
 iVnwBbf0HIYLmlrOzEfDgqDt8nybvv0PROilszyqBHlspE8bc5u29GgQGNVLPzWXh/swsfzk2+b
 9n2xzOsl6tv8GKWxAzYGUeIKpLlqLYWJMRrSgU7YZzKZWbtykPU6YuyxxEcmHbwoLD8JQLtGswH
 y87TvIR61CqHWY9MdEeaRfO2WBG6J+huQfTrbxXZe0=
X-Received: by 2002:a17:907:3f1b:b0:c2a:fdb5:31f0 with SMTP id
 a640c23a62f3a-c317bb4d27cmr32334666b.1.1791321371533; 
 Tue, 06 Oct 2026 14:16:11 -0700 (PDT)
Received: from Timur-Hyperion.home (86FF63C5.dsl.pool.telekom.hu.
 [134.255.99.197]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c317bdb3050sm9878466b.11.2026.10.06.14.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:16:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Rosca <david.rosca@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu/uvd3.1: Fix checking whether UVD firmware
 keyselect was already set
Date: Tue,  6 Oct 2026 23:16:07 +0200
Message-ID: <20261006211607.75407-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The PASS_MASK is for a different register not for UVD_FW_START.
It was a mistake to check this flag. It should be enough to check
that the register is non-zero.

Fixes: 13e4cf116dbf ("drm/amdgpu/uvd3.1: Don't validate the firmware when already validated")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index b72a0c34425a..ff7128a11cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -288,7 +288,7 @@ static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
 	int i;
 	uint32_t keysel = adev->uvd.keyselect;
 
-	if (RREG32(mmUVD_FW_START) & UVD_FW_STATUS__PASS_MASK) {
+	if (RREG32(mmUVD_FW_START)) {
 		dev_dbg(adev->dev, "UVD keyselect already set: 0x%x (on CPU: 0x%x)\n",
 			RREG32(mmUVD_FW_START), adev->uvd.keyselect);
 		return 0;
-- 
2.55.0

