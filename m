Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888BCC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB5010E6D0;
	Mon,  3 Aug 2026 13:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dXLTqoto";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDBF10E64A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:21 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c16794450aeso476672766b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763399; x=1786368199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rPzXX+G4VGfwTrzNIkKvY9pqUDDP6P3qWAefhcPonro=;
 b=dXLTqotoNn8UBV//6hGuaU36LYL0umXSPelFh6L+lNINsxLhF1mjCm42PQ0Sy/uNwZ
 wB2qeN1tH9HSGgN1DUQSLW4gkngUdTZVmW3U9pinzvBk5ACsq+9gBx2QuuQSF1LmKn3G
 iYULTk2V4BYz2qAi2rJeVNPsDx17J9Imv9Tc5RpCdPsdHftIlq1/wGwp9b127CXxJBLU
 U88YpbebgWQGC9eQcR343GEQX/NFCq/5dlkvRpLXTKJGWGeYHiUcguv7JOqeCKUIdQhu
 McKTdHgJnplHSdkqi+ZyeH077AXcsGJ4nV+CTF/xm6wPec59+bO1lzpWng8yIWjlQaGs
 b/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763399; x=1786368199;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rPzXX+G4VGfwTrzNIkKvY9pqUDDP6P3qWAefhcPonro=;
 b=npKozhEx1UqPkVOBHfbQRGEyJQGRV7NHeB9qcKpkJrmdz460yD3RysdRlMqToJ3A5A
 RD8zJDiljJ1GPTrQEmwG4bWHuLEn612BmYpGgeHw/w8p6GygRU+h9KpMX9BEJnmpUpSs
 xofUaNFjqXzWoQFbHf/4FfB7vBUgCNTKbRSSNB8J7e/8DaFD21NK70YrvQrcMBCohrUO
 e/cCqhMFhPZKRnSG5NZokFUSHyKZeO3KypG5RNW7+ERcFreZWPOjSPRyNjtIjmTqUP/A
 hT0v8rOvzABx2xJL704UQeE152JYpy3J9LYKcblqCXwAd7OW9YUc0869Qjsy5eRqvrPA
 kA8w==
X-Gm-Message-State: AOJu0YxWnSF5OzvIIYiYvRrOpdMuPutLOxil34zgyWtU8hJnJtscIvFs
 4pDCdlYp2HArmXX8TigelqW/ju2DeOeaC9027or1+gkE161UmttwfvoOIDdSzE44
X-Gm-Gg: AR+sD13x1O+oUcOcTZ/FPrttzLv7bXuj/xDtOWf2Gn84X5ynf5dj597VXxx9hZ87nFo
 DZmDIcds4GEcX1+YHbJ9ea2YgzyU+AYV4TfHPUnBdoAj8ywf2PgwO16p06KdQZpwFLq4Y6i5fZu
 bsok7b4lc06kbx5lD/V+lrhsQPgqkBr8TvaRCDLaIpqIVYLGrGl1zX1xJSMDEN1ZIl1XRLGW3QL
 XkrJPYeHN6/Fndl6/IX7hY8iXQElGxZncuErYM+Zac8FuV4EAOYRJ3M/RSEXkcvAsXguU9zwux7
 xJgSEjTRLIvpp6UumKX0bKmTVdn3lWYQQs3g7ZiDVCG58QT6CzrWWEWAaafAlKr62ufSVunvTKu
 u/YLIBHT5HD2o2UX22P7CwnM1nTqfXjBkJaEjwzRsaJODojWSE6yDaGYMCD7PvyyydlW/fetkVh
 NtibbgA9izN39CCuYret3ru3mQXZ2AGpYbtuDalz3eltazUqM0tXvr2PhMG8mPsQJmW/yvvn0u6
 cbIhuN+2xS2cSe8QswXhi1Uj0ptras=
X-Received: by 2002:a17:907:3cc2:b0:c16:3074:6593 with SMTP id
 a640c23a62f3a-c1fe7ec89f6mr883259366b.12.1785763399423; 
 Mon, 03 Aug 2026 06:23:19 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/10] drm/amdgpu/gfx6: Adjust how harvested TCCs are set up
Date: Mon,  3 Aug 2026 15:23:06 +0200
Message-ID: <20260803132309.36326-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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

Adjust gfx_v6_0_setup_tcc() to keep it working after
a GFX IP block soft reset. On a soft reset, the
TCP_CHAN_STEER_LO/HI registers are not cleared so
the function needs a slight adjustment to how the
number of active TCCs are calculated.

Additionally, let's expose the disabled TCC mask
in the tcc_disabled_mask field, like on other GPUs.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index b1dfcbe9640c..a51403caa342 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1597,7 +1597,7 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
  */
 static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 {
-	u32 i, tcc, tcp_addr_config, num_active_tcc = 0;
+	u32 i, tcc, tcp_addr_config, num_active_tcc = 0, num_max_active_tcc;
 	u64 chan_steer, patched_chan_steer = 0;
 	const u32 num_max_tcc = adev->gfx.config.max_texture_channel_caches;
 	const u32 dis_tcc_mask =
@@ -1611,6 +1611,8 @@ static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 	if (!dis_tcc_mask)
 		return;
 
+	num_max_active_tcc = num_max_tcc - hweight32(dis_tcc_mask);
+
 	/* Each 4-bit nibble contains the index of a TCC used by all TCPs */
 	chan_steer = RREG32(mmTCP_CHAN_STEER_LO) | ((u64)RREG32(mmTCP_CHAN_STEER_HI) << 32ull);
 
@@ -1623,9 +1625,12 @@ static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 			patched_chan_steer |= (u64)tcc << (u64)(4 * num_active_tcc);
 			++num_active_tcc;
 		}
+
+		if (num_active_tcc == num_max_active_tcc)
+			break;
 	}
 
-	WARN_ON(num_active_tcc != num_max_tcc - hweight32(dis_tcc_mask));
+	WARN_ON(num_active_tcc != num_max_active_tcc);
 
 	/* Patch number of TCCs used by TCPs */
 	tcp_addr_config = REG_SET_FIELD(RREG32(mmTCP_ADDR_CONFIG),
@@ -1635,6 +1640,8 @@ static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 	WREG32(mmTCP_ADDR_CONFIG, tcp_addr_config);
 	WREG32(mmTCP_CHAN_STEER_HI, upper_32_bits(patched_chan_steer));
 	WREG32(mmTCP_CHAN_STEER_LO, lower_32_bits(patched_chan_steer));
+
+	adev->gfx.config.tcc_disabled_mask = dis_tcc_mask;
 }
 
 static void gfx_v6_0_config_init(struct amdgpu_device *adev)
-- 
2.55.0

