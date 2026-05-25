Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD06DCD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F01E10E2B9;
	Mon, 25 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZV4tewi";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9B110E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:14 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45e7c636e74so4987763f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709513; x=1780314313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejhL1U4VICHx8A94Ci1FX9fF8v1hc3K0KJRXB+HfGSQ=;
 b=EZV4tewi6/e1gB7uU9WmN6tlcPDxgRJ3qFo3ey7PbE3nYaLEPF2TEIyWhu+ZTKrPOV
 hAl6CNxGV6Cx4CPxI8Gu2hOM6iBpyrdYpgrPqpbbtmrtmt4Os8k34yXMjLEoIovbsWgl
 s2f9USfqSoVnTmUhr6HlpEV73X/D9z7hHMdaRHBs9wTRSxFTZ9TkBlXSX6NNGCqsjJ+e
 PVnRJSgj72yrU+T4mp1pxhz7Wpu8wSEtS2YTMkH1Zwm4DfSK8HFIl8lCaRcYbzh8IkfM
 /SCLb38zNCDNQ9isppVNLLQI+xsVHIiGgX9JH9eADf4UNzLXWxj4DfEuDaW/5E61oUly
 v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709513; x=1780314313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejhL1U4VICHx8A94Ci1FX9fF8v1hc3K0KJRXB+HfGSQ=;
 b=V+4rKehSlsmd8EZxGwWhEl4AcZ2RIuGElX8DvFkfYk9Hxhtk9sBcNPY3688azK307U
 Vm3VywE1rVgBJAzhp+CiYv8yuGuKYdeLLvDapx5HCjFFUWNA5MDNNgwRmGE5J2i5jbFw
 QYiMYH/G5g99EWLjL9V87qZuMpFfoampM8SZXIJ9GXKjqg5+oFdU9QU5RW14Yz+4KPS6
 bbFtqKQL+YEz9ddXgbeMcw0Hwc6IArO7iXiSpH/4mta6vFGcB8MN0fN71x3xfmjQUIUo
 pAAwNM7BfpK32y2qd2Z4rh5TJl4D7KZc0zSXQ2wzfWt+DBQNvT761dLajn5zXN/U5Vf6
 F/Aw==
X-Gm-Message-State: AOJu0Yxk7RVGnCx0E/iVqvjwbBwA6FIt2u0+dKjy9j1zcDMckdKAClYs
 iEiOUH7Jl2VWkvLRC1KdOPCGp+Uc3Df4ryGwoWRPhX1W7NAI5LMKVFVqF8lU3w==
X-Gm-Gg: Acq92OHgB12oV7Ivpsl0yr5rKfsCTLeJBBeO9A92E+CV0791yzf8im8DSUZBguw2gPr
 pFWgco2LwjwTAXRJuJDfYadu1xtyaZm7MFFwmqQaD37M7WoHkVN78HawZ+XvDtiTUw757OvB4wu
 hmNs7wRUBz5kRFkUEMEwktplTFArgZqm7w+E3AqahxkW98RyMC2iWdNojz8b+K7bl9egKLjR2qD
 IyZQ6NMfQ9xRliZB9RJQkhc50iDyCcrk5+8gVv03oUB1Phxg3H4reIcHJUjK7ZF3snzbbu7O+9D
 FLwODL2x4KxdQreA/J851d6j7x8UQbgbNe6IrV8w342tdscTvooCWEk0n382MyTUIj0yvojQ6aO
 hQ6GgTIWovZ3yAMOVsC9PUe416P84zZXFUVrb5QdZi07kmiyLdE7apuzQYBV0v72DdBxz/L8l6X
 fzMk/4v6yUECEk5/IbM98IDjQz0C084Fwn49D0eh/Y5YyBm/FURFfgYzL9rn29obXsQEux5LVPH
 A8=
X-Received: by 2002:a05:600c:3d96:b0:490:5429:1513 with SMTP id
 5b1f17b1804b1-49054291bbamr155246855e9.6.1779709512605; 
 Mon, 25 May 2026 04:45:12 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps with
 other interrupts
Date: Mon, 25 May 2026 13:45:03 +0200
Message-ID: <20260525114507.24566-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525114507.24566-1-timur.kristof@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
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

Different interrupts may have different timestamp sources,
which shouldn't be compared.

If we compare the timestamps of retry faults to timestamps
of other interrupts, it may result in all retry fault
interrupts being filtered out, because of the different
time stamp source.

This issue was observed on Strix Halo.
Solved by storing the timestamp of the last page fault interrupt.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..52258f1341c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 	uint32_t hash;
 
 	/* Stale retry fault if timestamp goes backward */
-	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
+	if (timestamp == adev->gmc.processed_fault_timestamp ||
+		amdgpu_ih_ts_after(timestamp, adev->gmc.processed_fault_timestamp))
 		return true;
 
+	adev->gmc.processed_fault_timestamp = MAX(timestamp, adev->gmc.processed_fault_timestamp);
+
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..77eb15380284 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -361,6 +361,7 @@ struct amdgpu_gmc {
 
 	u64 noretry_flags;
 	u64 init_pte_flags;
+	u64 processed_fault_timestamp;
 
 	bool flush_tlb_needs_extra_type_0;
 	bool flush_tlb_needs_extra_type_2;
-- 
2.54.0

