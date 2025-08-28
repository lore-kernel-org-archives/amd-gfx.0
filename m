Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB1DCA0FFC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0E210EA18;
	Thu, 28 Aug 2025 15:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKcgcxBU";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EF010EA16
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:19 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45b6b5ccad6so6226715e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393878; x=1756998678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qdCwOLdmjFkALqmEo08RBW9hPBlt+zyKJ8pKQewnj0=;
 b=fKcgcxBUikvX1wTPEUH6cisL1G0KV6YB7T9ApXw99XTvUteWy0jQOdsOtP9lbKtmOI
 vOCNhqCghTt1vxoDXhqNqb9Jq9pNjv0ZgA4FFCe+zxIp75zV4rjSP7yUDmp+Gktj3xq7
 /n7hVnS4/SPY6vBUOi/n6+JT3JIYCrQy68cbNi8xUhwtBxU8BIPhh4ZK6noH1GSY8rkU
 6vCeKVSIW5V/baIyRvOm3D204dj2L7+4XCX/zcBkr6y7dnx+AnDh5Ol6Ow3VcZnoyp4L
 6/JjuCL8S55Z4lo5w5crvrU/kkxJoKxABzhHJdNAM4S2VbwLjro6CXZQYmrEnknmaHjf
 01Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393878; x=1756998678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qdCwOLdmjFkALqmEo08RBW9hPBlt+zyKJ8pKQewnj0=;
 b=KNi+TKWi0s/H4Cki3wjHeVecEFiAHSWFwMNLpPPW7b4cbqQ9Mz0Xj6/8e5JZ5ZKT4h
 3F4Dh+g8zB9vjKMrydqzwxDUcOJMJs/SnB2YFXEjoj8+dlLJd2+ymLGAiFrw/5TR4v5C
 WvfY8mGAlNGxsGdqCN/kRZHTDmIXwxcQRPr9FRIxA3JvsJHYwwYau1aq/mv66tDxjHqN
 /UrjpfjtyOwdTYNU34ZHaeFgJvzw92RMSkT3sZVmr4qH4Ch9bYMjvhYAjQHcgPi+R5wC
 2XuSQkUBVIN4YuudDiGMCBEF3s+P7/2gd1KjYIvIYALnCOCoQH6bQSMe3D0ySUFSo1kT
 wJAg==
X-Gm-Message-State: AOJu0YxKlpE7/lPPI82namTPQKCTao1+NcyTsaemW7H1laXKe1phfdfL
 /RO+wM9we9jfSlfYuHX/2B6+/uRX8Jc7kWm2FmzYDidztHQlb77pPj/oCvuTUw==
X-Gm-Gg: ASbGncsO5T8HVafAEvbsxNUQ2JgqJWPaxQ1OFAuZ4+PWQuXzO1Jzg0beS8TgYguJSYz
 ek2/MsDc7VVO2LPvgQkQ8dpfKrXbaCiWn71JyIroFkXeDGwWQBxo0d4s+qPiw1T8iwDyV0MYE/F
 2KjKy54R3cOGyd2WguwUhRUQgTW5Jlc4jPezSUbGzp5hv/YEsmrS1dgC1d292Jr8tbZ8ewbMGGW
 Rn3LcmQwWkKWQeBZvbLSYw1zUjD993Y2m20eu6uUCItZlmovi/0sYuLfoybFcMiNLC08bp0Xhhn
 6WxLpIj1OmkoFTDUKfUyiBWSaDmtOiROySsCHtj+oh13EBiKPUkzJgCfhy95XFGQ1cwJkHy8HZg
 greAzvTa0Gs+GlhdvOtNu4BpTN1KzpHgabnU0M/6zTpNdU3lKS5abCNWvAjbDrcYltxpWDiC/R8
 WEDQvFKTpC5SXX/pS5H7nHalEU+1+0ZhxrL8lH
X-Google-Smtp-Source: AGHT+IGSTSIIFFu50+X0tYfh8CDnTr7qhlYkCuMQGvnLHuMcOjFNkEBW0W+3ZSXt93Bj0KHwIj6XAg==
X-Received: by 2002:a05:600c:354f:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-45b6a31a192mr73926565e9.8.1756393877614; 
 Thu, 28 Aug 2025 08:11:17 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/10] drm/amd/pm: Increase SMC timeout on SI and warn (v3)
Date: Thu, 28 Aug 2025 17:11:05 +0200
Message-ID: <20250828151112.15965-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

The SMC can take an excessive amount of time to process some
messages under some conditions.

Background:
Sending a message to the SMC works by writing the message into
the mmSMC_MESSAGE_0 register and its optional parameter into
the mmSMC_SCRATCH0, and then polling mmSMC_RESP_0. Previously
the timeout was AMDGPU_MAX_USEC_TIMEOUT, ie. 100 ms.

Increase the timeout to 200 ms for all messages and to 1 sec for
a few messages which I've observed to be especially slow:
PPSMC_MSG_NoForcedLevel
PPSMC_MSG_SetEnabledLevels
PPSMC_MSG_SetForcedLevels
PPSMC_MSG_DisableULV
PPSMC_MSG_SwitchToSwState

This fixes the following problems on Tahiti when switching
from a lower clock power state to a higher clock state, such
as when DC turns on a display which was previously turned off.

* si_restrict_performance_levels_before_switch would fail
  (if the user previously forced high clocks using sysfs)
* si_set_sw_state would fail (always)

It turns out that both of those failures were SMC timeouts and
that the SMC actually didn't fail or hang, just needs more time
to process those.

Add a warning when there is an SMC timeout to make it easier to
identify this type of problem in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
index 4e65ab9e931c..281a5e377aee 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
@@ -172,20 +172,42 @@ PPSMC_Result amdgpu_si_send_msg_to_smc(struct amdgpu_device *adev,
 {
 	u32 tmp;
 	int i;
+	int usec_timeout;
+
+	/* SMC seems to process some messages exceptionally slowly. */
+	switch (msg) {
+	case PPSMC_MSG_NoForcedLevel:
+	case PPSMC_MSG_SetEnabledLevels:
+	case PPSMC_MSG_SetForcedLevels:
+	case PPSMC_MSG_DisableULV:
+	case PPSMC_MSG_SwitchToSwState:
+		usec_timeout = 1000000; /* 1 sec */
+		break;
+	default:
+		usec_timeout = 200000; /* 200 ms */
+		break;
+	}
 
 	if (!amdgpu_si_is_smc_running(adev))
 		return PPSMC_Result_Failed;
 
 	WREG32(mmSMC_MESSAGE_0, msg);
 
-	for (i = 0; i < adev->usec_timeout; i++) {
+	for (i = 0; i < usec_timeout; i++) {
 		tmp = RREG32(mmSMC_RESP_0);
 		if (tmp != 0)
 			break;
 		udelay(1);
 	}
 
-	return (PPSMC_Result)RREG32(mmSMC_RESP_0);
+	tmp = RREG32(mmSMC_RESP_0);
+	if (tmp == 0) {
+		drm_warn(adev_to_drm(adev),
+			"%s timeout on message: %x (SMC_SCRATCH0: %x)\n",
+			__func__, msg, RREG32(mmSMC_SCRATCH0));
+	}
+
+	return (PPSMC_Result)tmp;
 }
 
 PPSMC_Result amdgpu_si_wait_for_smc_inactive(struct amdgpu_device *adev)
-- 
2.51.0

