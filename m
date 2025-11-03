Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89231CCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102BF10E4CD;
	Mon,  3 Nov 2025 22:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CznazDQ/";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFE810E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:20 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64034284521so8523255a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208659; x=1762813459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZjnKLSGON319lBQpwize3TjI1xg2rjo6M0OdadZAIg=;
 b=CznazDQ/v0OPA95zPusyi2R4yqzi+8hiNc7Ym2F98yepPOy3/8UA2iMZC3S/YNglcF
 nz+qt/7+v5kj3AmX7LTOYT55mQqUQxh17aIyOFz7b1IeC6X4/F3Zy+sooa3HDMNyVKg/
 RSd9EQVm4xlhMtQLrWosGC6XSzx0Ks2UraWNt3KA5igHdhky7yy9LjkKwYOjr2KnUf3F
 YQSvMDLthPhcM5aKMyez8iLTcVBjKCUgHFxafbK6oJa6TT62G8oNvpWLOXTDMIQeQcFs
 MVvGC3EdzzvWJ6GuyuJaxSvrquHmoaXS1SYEutpeE9ghw74XD9VxGi50eFBvHgnpQdzZ
 4ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208659; x=1762813459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZjnKLSGON319lBQpwize3TjI1xg2rjo6M0OdadZAIg=;
 b=rCy8YB8oCgFjddDEh6vfzX6UE4vEq/Auv+SVmSjK4hH0ibvRkFIhXHpp2iILs8LYi0
 YMTj+2mk09VNo+oB5NkHICxkDWIh9HUEft13YHFYSz26BL29HnkbDWiAdLeAQ7HKFuMl
 V14hX9gOjFWId+qHIpwBtxlg5W7/61PQDKbn1SMNHydQ0BwBQJBUQoECCsGK0P1ykkS9
 cTUyGfxk/TpUXwea+laGKQDeDGiVwYKo9Acitp3toyPZX5kHp8jnxz4u0d3STi0JIoiW
 X6PwmuARCdE7nmJi2PeYgZMlWxYx39GHVTPIjmw3XaKeAsHgKKguoz+SuL5KZC0CaiKD
 dqQA==
X-Gm-Message-State: AOJu0YzC7TpZlGnhREWuu12QfTZo8+cv14TGshDJJfKhU4mGTmtEXWPA
 ot3P9VueC4Gl3iBISjLITKxOB3D6owOHi+gz6Ti4WCfsNsWpReNItyap/V8BT2WS
X-Gm-Gg: ASbGnctkd8QzR51h/mPPAxWBXbAC9KESwX4Uq4km9UjQnAncj3M717Ajn5g1Ml/AlcM
 fScJXmG6IyFc/dbLLoEXBfDD8bOljusoJXxlngGzw3KDH5KcdqUmmoLuIK7IinGwDP1cvIPaYdh
 gFq8Me46LSp3lCFRQCBfChfdDUaa75dJoBlhS+XLKxbV5pQ/FpcNn70la7Hof7i0vuA/q2I8fz+
 CidpNiyv6klfeZnhHW5pDOLxk1BzNZM3a3MjwRU8p131fhlnNDRGUP9dvm3UmUlwnc/+Ko1SZsC
 C0+C/s0GmEqki+ZEjRh+XwlkwwQDZFxx7aTG7lDZEYPyLFMvmv2FYahn+Dt+HaTAYEnCoPIbOTM
 Z5RDhj6cWJnHzXVfzeF3GFMS+DIyTnsDFKw6Eaba755sUflS682X9l8LYCjNsZgKOnfnRnBfS+U
 24IqUUUmoe7FW9ODu8ET0=
X-Google-Smtp-Source: AGHT+IF+W7+RmVJK0AbQ6Ce/tEzz88iiYQbr3TaCluu2C2mDyt3lmqaUnNgjqGnhUX2s+0hTiOT/Fw==
X-Received: by 2002:a05:6402:51c9:b0:640:b825:183d with SMTP id
 4fb4d7f45d1cf-640b8252621mr5748885a12.14.1762208659018; 
 Mon, 03 Nov 2025 14:24:19 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:18 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 14/16] drm/amd/pm/si: Hook up VCE1 to SI DPM
Date: Mon,  3 Nov 2025 23:23:31 +0100
Message-ID: <20251103222333.37817-15-timur.kristof@gmail.com>
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

On SI GPUs, the SMC needs to be aware of whether or not the VCE1
is used. The VCE1 is enabled/disabled through the DPM code.

Also print VCE clocks in amdgpu_pm_info.
Users can inspect the current power state using:
cat /sys/kernel/debug/dri/<card>/amdgpu_pm_info

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 3a9522c17fee..bf7ab93b265d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7051,13 +7051,20 @@ static void si_set_vce_clock(struct amdgpu_device *adev,
 	if ((old_rps->evclk != new_rps->evclk) ||
 	    (old_rps->ecclk != new_rps->ecclk)) {
 		/* Turn the clocks on when encoding, off otherwise */
+		dev_dbg(adev->dev, "set VCE clocks: %u, %u\n", new_rps->evclk, new_rps->ecclk);
+
 		if (new_rps->evclk || new_rps->ecclk) {
-			/* Place holder for future VCE1.0 porting to amdgpu
-			vce_v1_0_enable_mgcg(adev, false, false);*/
+			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);
+			amdgpu_device_ip_set_clockgating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_CG_STATE_UNGATE);
+			amdgpu_device_ip_set_powergating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_PG_STATE_UNGATE);
 		} else {
-			/* Place holder for future VCE1.0 porting to amdgpu
-			vce_v1_0_enable_mgcg(adev, true, false);
-			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/
+			amdgpu_device_ip_set_powergating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_PG_STATE_GATE);
+			amdgpu_device_ip_set_clockgating_state(
+				adev, AMD_IP_BLOCK_TYPE_VCE, AMD_CG_STATE_GATE);
+			amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		}
 	}
 }
@@ -7582,6 +7589,7 @@ static void si_dpm_debugfs_print_current_performance_level(void *handle,
 	} else {
 		pl = &ps->performance_levels[current_index];
 		seq_printf(m, "uvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+		seq_printf(m, "vce    evclk: %d ecclk: %d\n", rps->evclk, rps->ecclk);
 		seq_printf(m, "power level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
 			   current_index, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
 	}
-- 
2.51.0

