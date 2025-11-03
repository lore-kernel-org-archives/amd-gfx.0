Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FD3CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E29410E4B8;
	Mon,  3 Nov 2025 22:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ivewYCSS";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370FD10E4B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:23:54 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-640b2a51750so3407402a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208633; x=1762813433; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rygbqPSTkTaRF2YXh0oPW0/6GhhbiO7ShaOt1NDQFjs=;
 b=ivewYCSSAM+VhYKzBrJqtwyEmFBnSMrem/H+vLGfst4udIdhTPF+l3HE7ZrQfYjiJq
 pdfIXso2GmXTIWZv1SPs/X2ZhFMhD1VAhySOKsROp2noIiJUOdkojvV0+HGps7nLMKLl
 dxMyWwhZd+8rCxwq3wrc3BmQHqlJtQFpmlwK7Mk2Z5sjbU8Av0k3Y6mQDrq5OYTDWhP6
 rcd/LlCFzUfBYhFhuWAtGGGT0Q2XQh6vAb8cZkN05kORt5osvP6vguG8TtfsNYU091gB
 e8g7K2TrAgrRdoVs4e9rERvq9O65L6TnQQIDDWtJGiNIFp7ASGbDdIoE43HIxqnzoGRs
 u5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208633; x=1762813433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rygbqPSTkTaRF2YXh0oPW0/6GhhbiO7ShaOt1NDQFjs=;
 b=MdSx5onzTYhZuHu6atRcb/0iPHq7i2t3kQxE1fCwZLViWCK9K1Ue66mNR3eC8xPaWl
 oRwpsjdHGdp1Y1KRvtZLTiToHJsdNPv0vmiWrdies+/ZkVqkdusU52mNWjv3J02ic4Z0
 6oJh1SWNekLVN0xSnXfi2f9RDsGMotQgw+MIypqheRFWheWnHGDKz4OFj9JPyLsm2fJ8
 YONRFSz49kR8iBsYRrvRgTEPWRnvRV0IbQALy7Iq/j3r6aRE4cln15s0wQ3/PRU7OfsC
 zHOJVEZvBN+TvilSlt7dm5AMpjpsi1EhgKAMeADDnzhp4VyRj/2dg7ZRoAZ7FiNza8EX
 X7xw==
X-Gm-Message-State: AOJu0YydZc4sFLq5w3oxH8pIwHZsk/ux3Y51FMb2501T/7iNvKG7ENi9
 ZUMtD3BEkyDWARDaY9E+gnp5ZPY8LwIcOxE+wIJj0ypWVfZ7zHriWKo704cc3nJc
X-Gm-Gg: ASbGncuSHqkDz15DN9VBO8T57RInVp3685Q9YG7oDWxabHkAFt5FR8cFTzPX6pwU6A3
 XcMMGlNF3q30/FgNlcNcSObmgGMUPYKODG8mFWWSBvew0toquBBvwF0QkB2ntLEKaOP7qnDmdxL
 zSyFhPlyX1yRVmiqU9NF3V65h5S4K14cXI7T3VazJdB5K1JQ/apwWo39iEtEmMp3Gp/SLkD8Xgh
 c+B73C7oZr37A/pdJBPFSn6aIoT0htLzU5xQk//dafXtaHxPqinXVMhRNO9MV3eDfBPzax4iA80
 3sNqVxWn0i/o4VORjmuRiV9gVrMbWaNItLngxfM+4BPcKr+ythIAlidos3jLGHwlxS2f67iAyYo
 2lDZqjoUq64ONjF+an05cO0Ku4r7/gbKS6rBdvR02cOiln+3fwB1RES4OQ5c4i7a0g+dMMtBClh
 tFq83jnWJx3wzoL8yRRQg=
X-Google-Smtp-Source: AGHT+IFV4oK4gklg2p6JGe60BZX51XfIJc1F2VFKEvYtq8rrr6tAklh7K4P28Xac7389Q+rod6NQbQ==
X-Received: by 2002:a05:6402:2548:b0:63a:5d3:6a1e with SMTP id
 4fb4d7f45d1cf-640770415b5mr11498808a12.33.1762208632488; 
 Mon, 03 Nov 2025 14:23:52 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:23:51 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 01/16] drm/amdgpu/gmc: Don't hardcode GART page count before
 GTT
Date: Mon,  3 Nov 2025 23:23:18 +0100
Message-ID: <20251103222333.37817-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

GART contains some pages in its address space that come before
the GTT and are used for BO copies.

Instead of hardcoding the size of the GART space before GTT,
make it a field in the amdgpu_gmc struct. This allows us to map
more things in GART before GTT.

Split this into a separate patch to make it easier to bisect,
in case there are any errors in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 97b562a79ea8..bf31bd022d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 		break;
 	}
 
+	mc->num_gart_pages_before_gtt =
+		AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
 	mc->gart_start &= ~(four_gb - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 55097ca10738..568eed3eb557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -266,6 +266,7 @@ struct amdgpu_gmc {
 	u64			fb_end;
 	unsigned		vram_width;
 	u64			real_vram_size;
+	u32			num_gart_pages_before_gtt;
 	int			vram_mtrr;
 	u64                     mc_mask;
 	const struct firmware   *fw;	/* MC firmware */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0760e70402ec..4c2563a70c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
 
 	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
 
-	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
+	start = adev->gmc.num_gart_pages_before_gtt;
 	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
 	drm_mm_init(&mgr->mm, start, size);
 	spin_lock_init(&mgr->lock);
-- 
2.51.0

