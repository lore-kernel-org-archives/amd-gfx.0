Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE82D10F50
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81D010E604;
	Wed, 26 Nov 2025 13:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AC3UmMK1";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C3810E5B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:07 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so564155f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163805; x=1764768605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohjSObyzRjho3veJmcYKtrvHBHbrgEKhGS1F+eG7598=;
 b=AC3UmMK1oK2YaTa0GgRYmWdWgl9BxSCbN2NafvfdUJJH9jxOx0OZripLSf79VLA3tw
 H/00Bb4DSgSClu/11Ok2lfVgl0XuGh0pLzxyJNaroSstckszDrDyttxKUdKzpszJoYyf
 vzSwcpzfCNOoIInD1go/KEnqGoTIGAw9tdIkHFlJI0R+GLA6B4CwCEHRNwvgG3pp3JuC
 nJtvs7hG69Vkz8l4Zn0wKrwSnJajxfXZm7G522Kztd58FZuX+Fy2/RapJcmdiZktAktd
 dWnPPtul4WoNAlMgyvjRwNBEFqgOHSJf62iMNQDYwOW4Oab/bGS/JmBPlRxE8TRP6RPV
 5Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163805; x=1764768605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohjSObyzRjho3veJmcYKtrvHBHbrgEKhGS1F+eG7598=;
 b=wanjosUfQsi+bIwpZ/ELlyHeR7xXeAvSg1AlCTDbOly+McupomODDGjRKIVyvJTgZe
 CKguDrjf3eF6IPmq1hURbvn6Phybw7p/NtvUUV1whgaKtkeFIbfZ4JTCXf1byMTuq9Av
 L2O4eSfq8Jf9ipueYpzQfcvLAPWTLr7wQTZwM5lKOqZmAc+X54Q4jzfqT2TpmU4jguDH
 3/NEYY4EMjq1rIiNyr0FJg84TjbAfDL6hrSNWW4ZBzA+IfWOUzQ/YW2AJlZNF1l0WGXg
 iFMV2l7Xkc9EzQfG5sTahQVUogM2IOAWji56RQU7nfqb3RMq3NH8b11RYhOfGkgohEtp
 p4qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFSYA0yEpfe5kJU/RlgneHwnD3jsUbr+Iebd779h2Apq3VEvDCqINFkhti7pa6uYQChMlG8OEq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYCHD+jk14Op0rZQvfWp9wvzcc15pqN5u+baAorpq/+8nX81MW
 dSNGkDS0UPYhvFBKlWgAaQ4rhTeXiiUZJyiWQyj1avAMiW1Lyy0kVdg/NusfpA==
X-Gm-Gg: ASbGncuKiS5RT0yL91SGzSewvDd35fQwmWgkC4p0IV0jn5bLSTlqC1G/aJ17bqra6Bj
 osu5152GV6scH1CwDUq7fy2DBij/eeorrmG+rzsPk3yRR1bHHRCpUi+scXMDBGw3FhALDGSI8Gv
 oaV4ukeUsOl7LDIMnnntlCeOsr8bqrIaR06DHtnh5xlnA/zQIEJiPuT7mqCV/ZlLRFrP6uw0TDO
 sTJ0J/mrtZQYuT6YZhiOAL+LqxQQGnSzSqmZg3S6mN0AZlIlHloRffG93Jc4UkhQZw8SxCi5CDZ
 AmgDDBYQKH2dyfTPZyIZgNN6xGwQTESmAr6OhJDRSO078fwJ6Tz70i/X0efaQ/3GoBzrhx6d/HP
 9HCAMILpnWh4o0c7F/iD4e96bSVsGz33Z2w26PvSDt1+BioTCJuI7MSuHz5t22lpKFkCyS+5cHF
 7ZztSHDNFy/AZ8I91lg10sx3yAghSsXXyxi8GMKEx/i+FNYXL1iwKiADkT84Haur+F5+uNLlhMi
 He5EFoWWA7qdq+TDxA=
X-Google-Smtp-Source: AGHT+IGA5nj4Dy1KWrvN8et8HVynlwIDVeAsjaAjB9Gm2jBh9fkoL78JE+FCSTULlhBYAPdpGKFeqw==
X-Received: by 2002:a5d:584b:0:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-42cc12f1d70mr23032082f8f.5.1764163805484; 
 Wed, 26 Nov 2025 05:30:05 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:30:05 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/10] drm/amdgpu/gmc8: Delegate VM faults to soft IRQ handler
 ring
Date: Wed, 26 Nov 2025 14:29:52 +0100
Message-ID: <20251126132952.150452-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251126132952.150452-1-timur.kristof@gmail.com>
References: <20251126132952.150452-1-timur.kristof@gmail.com>
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

On old GPUs, it may be an issue that handling the interrupts from
VM faults is too slow and the interrupt handler (IH) ring may
overflow, which can cause an eventual hang.

Delegate the processing of all VM faults to the soft
IRQ handler ring.

As a result, we spend much less time in the IRQ handler that
interacts with the HW IH ring, which significantly reduces the
chance of hangs/reboots.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index e1509480dfc2..6551b60f2584 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1439,6 +1439,12 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		return 0;
 	}
 
+	/* Delegate to the soft IRQ handler ring */
+	if (adev->irq.ih_soft.enabled && entry->ih != &adev->irq.ih_soft) {
+		amdgpu_irq_delegate(adev, entry, 4);
+		return 1;
+	}
+
 	addr = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_ADDR);
 	status = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_STATUS);
 	mc_client = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_MCCLIENT);
-- 
2.51.1

