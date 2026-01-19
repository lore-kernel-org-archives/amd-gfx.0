Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6346DD2ECE4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F274110E512;
	Mon, 19 Jan 2026 20:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PfeXiIM+";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9564A10E511
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:36:35 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso8270012a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768854994; x=1769459794; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3pI93xR4T5EEvBv+yIyB7XQsUc48BI8B4N87vos3Kw=;
 b=PfeXiIM+syoiLz0D4Pq3eeWM3VPfZA5v/HuAY0Ae/pLf3a93oczJWm9L0uhULiytgc
 UlRzKga+n13RB+2rGhRo0RDBty/1FmcargqvoFqdRI6rlnCgaza93F7lzofEb5CHX5mv
 b19DC20VKQJ4JWOmOMfNQxHIIICC5xCkj169TwZzn6QilNZtxJ0y2RfLEUDbW1fxlwfu
 8CUIFG2rtj/Q7FN1ns4TsDUBkDUahocmbcYQPvDwFq1XMlwcvzn6GYypqvNgfGpYoFKc
 8AsIYdRVb6frMZ5k0FiVaaSlRT1fNVobbLYmkaxAWzX/EEoLenlj/LhZmMwQLZV0Odzb
 cVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854994; x=1769459794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3pI93xR4T5EEvBv+yIyB7XQsUc48BI8B4N87vos3Kw=;
 b=MaOUhqnzM7/rW/ZKTzIAEy4EVR1G2RioC3hHjWFRTIHPPqk5MDcg4Z3kKVZlojnJuj
 +VMvM/w7r1BHJQHFLdcYU0HIN5zpJuZmbIj7QqBh0zJOe0g1gv7+GJt5tdQp70CZXEL0
 ulDMEBvSl3HSNtmQi0yKwBqdXCqgQ80gcJbcQo+qUHfoJPSP42a3vBjnCAyYAs+wDovP
 3aJf9QgRVMsUGErUEA9rHIgCQqjRpVnTPTp+1v2jlBTI9qpfFHm7/FCDvghqusv25YDg
 46LsYwM7/90GbiXGPJhbYuh0Qdo+5ZLFdkGicRUMh15sY8O70rMXHWPF+RBzPUNO8lQV
 nirA==
X-Gm-Message-State: AOJu0Ywu1RDQUFdKH5IzIoxNcyeQ9fouwrbjDhzDt8KMSPaNIFyMiRlz
 EP/LHUM3G0aurwrI+5KdRIbbejrvtAj44pKrvl7NH1cN1F5co3drOVKyRL9DtQ==
X-Gm-Gg: AZuq6aIorbDyQUKep+jlRuEsQp4PoVZBSfr4gejUSuNJHrbY+gF0gm3aaOcHZq7C1tJ
 I239xNatkPFsUzksJvc0o3pzCUxNx3RwR/62IPtr6cD6lxVXbLH+fuZpP2WIggV32jYTh1nvG55
 foRZ3VXK1xCQJZWpvMzSRh1Z6BcKDoEtfiKaX/aJ/iCJFr9/bhvhXyjTWHXwKA9qgXIVOu2DadL
 VOIwD3ri3JjjpJc/87Hi3Z73i81hpSysCI0ZkNSZLk5zgf1B+5Xz0qudAz6tv62hxOckd2nxgmk
 KzGilZ8IMrmFPkeuYwrby+DdE7E8xeeiEoRkDJUhVPskLZA4Z1DETh+qGMIZPCFbzqarnMSV297
 GD2ISZRCPlUzL6fbV+rH1UAHdHkYxNujI3b/NHAiQv68Be4cFHGFOunKiIn1ldQTnAeAURTchaf
 OzIgKUcOG4S1CCH6ei8aF+U05wm+7j3GALLv0BkoVkN2qpH9k9oF+gXcsWigwSEsJ9iDLdmStPe
 T8ricbIdLDR
X-Received: by 2002:a05:6402:40cd:b0:64b:46d4:5d54 with SMTP id
 4fb4d7f45d1cf-654525cc64amr8227012a12.11.1768854994041; 
 Mon, 19 Jan 2026 12:36:34 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce213sm11375492a12.2.2026.01.19.12.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:36:33 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd/pm: Workaround SI powertune issue on Radeon 430
 (v2)
Date: Mon, 19 Jan 2026 21:36:24 +0100
Message-ID: <20260119203626.16070-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203626.16070-1-timur.kristof@gmail.com>
References: <20260119203626.16070-1-timur.kristof@gmail.com>
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

Radeon 430 and 520 are OEM GPUs from 2016~2017
They have the same device id: 0x6611 and revision: 0x87

On the Radeon 430, powertune is buggy and throttles the GPU,
never allowing it to reach its maximum SCLK. Work around this
bug by raising the TDP limits we program to the SMC from
24W (specified by the VBIOS on Radeon 430) to 32W.

Disabling powertune entirely is	not a viable workaround,
because	it causes the Radeon 520 to heat up above 100 C,
which I prefer to avoid.

Additionally, revise the maximum SCLK limit. Considering the
above issue, these GPUs never reached a high SCLK on Linux,
and the workarounds were added before the GPUs were released,
so the workaround likely didn't target these specifically.
Use 780 MHz (the maximum SCLK according to the VBIOS on the
Radeon 430). Note that the Radeon 520 VBIOS has a higher
maximum SCLK: 905 MHz, but in practice it doesn't seem to
perform better with the higher clock, only heats up more.

v2:
Move the workaround to si_populate_smc_tdp_limits.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 87bab6c8564d..0f8f69481f5b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -2281,6 +2281,12 @@ static int si_populate_smc_tdp_limits(struct amdgpu_device *adev,
 		if (ret)
 			return ret;
 
+		if (adev->pdev->device == 0x6611 && adev->pdev->revision == 0x87) {
+			/* Workaround buggy powertune on Radeon 430 and 520. */
+			tdp_limit = 32;
+			near_tdp_limit = 28;
+		}
+
 		smc_table->dpm2Params.TDPLimit =
 			cpu_to_be32(si_scale_power_for_smc(tdp_limit, scaling_factor) * 1000);
 		smc_table->dpm2Params.NearTDPLimit =
@@ -3463,10 +3469,15 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		    (adev->pdev->revision == 0x80) ||
 		    (adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0x83) ||
-		    (adev->pdev->revision == 0x87) ||
+		    (adev->pdev->revision == 0x87 &&
+				adev->pdev->device != 0x6611) ||
 		    (adev->pdev->device == 0x6604) ||
 		    (adev->pdev->device == 0x6605)) {
 			max_sclk = 75000;
+		} else if (adev->pdev->revision == 0x87 &&
+				adev->pdev->device == 0x6611) {
+			/* Radeon 430 and 520 */
+			max_sclk = 78000;
 		}
 	}
 
-- 
2.52.0

