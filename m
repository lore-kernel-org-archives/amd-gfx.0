Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E856EC61DC6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B5210F2B9;
	Fri, 28 Aug 2026 07:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V8J7JM0R";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCAD10F0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 14:47:54 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ceab75934dso27836735ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787842074; x=1788446874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qbEkvagZ9qeyC6jVzXtKZoIKK94uFwUXLSPjBHZM3eg=;
 b=V8J7JM0Rj15bm24auYSHftMMRQ4ETDou08h2eVJPgpjLJ0UnP72o7TVweVywCA3QW+
 TquoAMFAijwJkMkYZj1aJbEFWNKkVL1Z9RosMItnwwpBHmnbAsLlCrgdsBJvpSAAEhwN
 dNvJxDWAXbEq4UnR4D9GisyJmBnF3+5oVqKuWQHqoh+JPryOPL6G3Jl98uzOcZtBjFXp
 IRccuO9HOyxx6V06Y9+ItpFb0z4Ud0HSO3PdUdr6D+zahD7kT6maLrBrRyOO1L8KPtAM
 N+RGePH+2Bv7wcEW3EfsVKhnkfl+0Zmasb5LmcxzXqpEbFzbWO495VO2IXCHsoyAnhYC
 beqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787842074; x=1788446874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qbEkvagZ9qeyC6jVzXtKZoIKK94uFwUXLSPjBHZM3eg=;
 b=PI4I/C8BKmDT3hxKHu2MMdkgFTZJ5ra2WXgajUDuGdwMFj0xvencFDHvJmTK30fieo
 ycF2Bz5JB0xgp8tjEVWxbDy13+CkcTq9Hk/b670MaQzJ5i9DTdx/p/9fF7DgHWYlaqhg
 CYPrpSB3V0F0hriv0wpV2rXHOt/ECYNumqHAlLRp/Yw69wewwatlx2n/TMqWBecW3Xka
 zzGaTZsR5JhZcN/gRdpYR37Fu6Qb1D5jDTAGII9GDsOCpzkCm7DyQGGlTwBF+VXqwWEG
 juy/OOWT4PTb5awha5q5rwFz2BIgAjLEd36/CI3PCNksPnna/kEb8DpMtkWANQxINCug
 KPKQ==
X-Gm-Message-State: AFuF++n2EA6hY0qQGau2tkJtcy3+Bp7dvuAHlO2S4CKTg0DuPURYhPiV
 oHWzd35DCnnewDhxq1mlrcm8rrZ+xfszp03M54nPYDFBzHCBeeOk/juox2QuQQ==
X-Gm-Gg: AR+sD12wtPByXi5JERuho9+A7vfGeQ064/3LEjt31kX2MSOn3kZRDdD82ZEey4Vl+uA
 2TSjYPK2z+20OphoEcmZAMhlINdABySwXPSqXeBlYFugA5QpllIN51YN1aWVU9j6px1FgBOnRGV
 ZGYdfg6SgCmoYm8IN4u1LU56diSibLnM8bemIw9dHDJV5/awE1xeiEegytFEhhYleMOugnD0q3G
 1coBq2oSQJZJ4N6ebwdHVcWOY2I3MqShNiuf33lieKw0Q6T1SMxC41SuRwrpJtMBbACQOVWgHfu
 24yphW8oAAUeIQK/FEqJWpYGBiGZob+WVPn17VltQYbZKZ3MIfcHC3mB2fswuu+qnIgAa2U3mQG
 dZeIV/Evsu8NtcwX3LcdE4APgpn8Id/IG9v7w9EeRgC794qeKvFJ0ozknrDSCfsduBMZUHFX5YY
 PUlfadjINatsvrBddjbcEk2VL6ZImWWez69Y5ahy3zkbJygSWRfMAQtC8=
X-Received: by 2002:a17:903:2383:b0:2d7:71e:575d with SMTP id
 d9443c01a7336-2d707af8a58mr304661165ad.9.1787842073561; 
 Thu, 27 Aug 2026 07:47:53 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d704c2bb7dsm17953815ad.71.2026.08.27.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:47:52 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/ras: drop redundant memset in
 amdgpu_virt_ras_get_cper_records()
Date: Thu, 27 Aug 2026 23:46:13 +0900
Message-ID: <20260827144614.487229-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:59:57 +0000
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

kzalloc() returns zeroed memory, so the memset after the allocation is
redundant.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 1e83cb5064ff..f021719ff0a8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -298,8 +298,6 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		return RAS_CMD__ERROR_GENERIC;
 	}
 
-	memset(out_buf, 0, req->buf_size);
-
 	for (i = 0; i < req->cper_num; i++) {
 		batch_id = req->cper_start_id + i;
 		if (batch_id >= overview->last_batch_id)
-- 
2.43.0

