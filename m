Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C517C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2764410E62F;
	Mon, 13 Jul 2026 12:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C0Fiaurh";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A520810E62F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:50 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso1833782f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947529; x=1784552329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/uTxEj2yTuZ36HP7TyCebyqbOFU6Rhjg6uBnVAfIYuQ=;
 b=C0FiaurhJzA7F+hQhGLbX/W6tdHue38IuKbmst2ltSBW/mci5xQ0gJUfCnbJA3a5Yp
 nFpxJk3JvdXsyU/MWPX5YXhi/L3Ho3xia5kXuYMLSDR6iONrj3pUwk10kntwkyeYyUiF
 iaMXnK/6y1lbmnoBXs7SnQ8wB0nQopYHGy2crIrdm86LonSV7bKYjzTEdTUsNg4ejHJB
 gcpk26BwE3D0fozzuUN7f8KykJd6YzpFQcqpNfOp8lhM+Ds2X+eaE6sxtA+nz6hJSP0H
 8yaYwLTujPe1d1xHbJLbhQbpXxIevwvDzj9AAmoIbmgAkx2A3QsjiWVSiUtl2RKt3wKq
 k7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947529; x=1784552329;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/uTxEj2yTuZ36HP7TyCebyqbOFU6Rhjg6uBnVAfIYuQ=;
 b=M8XKUYRFCP9rnOkaLWIgNoBeHcZnNke9hRmnccoiDyi0tIt7jDy7hVf21MYUnOcprb
 IdNMSWjdOdy8rkGAw3hscZvATTNC3BJswV1vHP+7VASLjz0Yh9hY6bO0PE18JWLCHbLr
 jq4z2oNmLuxkIpHLBOiiYZT8A0qxjENCCNDwtmTJhQOYpSHRydUHwg4dXdA085QwoUJY
 7FoODPnw2sX+utAQm9duapBE/2LwexPEKb8RltBhpiegCEY0IFjMC4YFmzB4l/6SOzOD
 EvHgrZ0I11cm7UbljOxCIQQhGfn30EX8lCmVdd1GUOhvhsyEhKd5/Hk3Armi36Hgd554
 gE9Q==
X-Gm-Message-State: AOJu0YzSwJPaYVvr5uo7sYDpWNfwjnEn44uakEWFXN+v+FZDm7h6II1l
 51TX3vL5rmiv8KiZKUXaW+MrUcY8XeiCniI/mjrIiFwqDFyHj/ELkCdt3p3qdw==
X-Gm-Gg: AfdE7ckQC1cCX1lEqOH+x19DTuQR0u+ZfUYWojBpsqbxJ5MFqhuBZ1n+06HXQJdP0sr
 n5qm9nlRsgamdsbDQ25yHhFGnU8zW/WTx+tD1ZYm44BLBz6Qu1uF2lTPATgxAobETCT+JAw9y2N
 1Sq3+RWOi3o7zi2126AMxaonziA+tHHp6pTDVko9SbudrNun+aXAUWCIWVQDe9CiZAjHmb7TJPb
 eC7g0tEU6uM0e/1tfoH+iBSmgZEpeRviRxmgL8sVuCgUwi+svHOmYRhPD4AIWudUsyo2wdeDX43
 9QkD5RKEaGwDZ0amtxmIf2TXCSr1x9yHIEua7TbwP/o0vUITQ1mmA+UG1blqBVwxGbDTLc0UBB4
 Y+xpTKYR3rDtMxoLgenZzvdtlmVhoR7z4myGKh3nhX7Nd06cplkNdO7+AhcvNGG4iDBL/9tkHfw
 j2Qary86STkfABEkjsZmDurlQ8zh1oXc4Sql9OL/+jMIjUxWopeCxk01893cnfebha
X-Received: by 2002:a05:6000:400a:b0:46f:7d90:8114 with SMTP id
 ffacd0b85a97d-47f2dcb50e7mr10284805f8f.14.1783947528958; 
 Mon, 13 Jul 2026 05:58:48 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/9] drm/amdgpu/gfx7: Return error code when failing to start
 GFX ring
Date: Mon, 13 Jul 2026 14:58:33 +0200
Message-ID: <20260713125838.30607-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
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

Return an error code instead of silently failing.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index a1a9f3fc4567..0ceadb107d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2576,7 +2576,10 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 	WREG32(mmCP_RB0_BASE_HI, upper_32_bits(rb_addr));
 
 	/* start the ring */
-	gfx_v7_0_cp_gfx_start(adev);
+	r = gfx_v7_0_cp_gfx_start(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.55.0

