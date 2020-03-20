Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD84C4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D8420767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOST8mdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D8420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194DD6EB4A;
	Fri, 20 Mar 2020 18:27:57 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673F46E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:55 +0000 (UTC)
Received: by mail-pg1-x542.google.com with SMTP id x7so3508452pgh.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KXIs0c2VBGIQTmbpM/DTLIR/mdvQrDot0TZRqjKBjFY=;
 b=nOST8mdh12P7bLmVGhlGT9SsbpoguTLtIZBqk3ergCodN0EaJwEfy7BqJEuyzqPfcD
 fdN8lydf0Kv0chWh5BjpLxy3Kmt6Y6nw/fefSanC1ztATZBPuGia5UHayRvGIjevK/MS
 mx35RUBnMfA2PWuYf30epe3N+44GZhTM03PqPvyHNeMuTDWmIG6/aba/uQYnYu2LXLpL
 by6CMAcf4kDLkKrhTlck00RbCmo3F/b6alql/dZ5ESlwtqWxsp9GdSszEXmuMUnhn/bQ
 OdcKb6ASJjvJkIRTvNwr8ZaBjmJUz6vOsXhpF8zyI42mv9zA9b06bjrXC1lPwmvt2uZR
 adMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KXIs0c2VBGIQTmbpM/DTLIR/mdvQrDot0TZRqjKBjFY=;
 b=Ih8/kAdKP53VktJkXeoogpydyqvTNBDu9tyIwbQpZbSDSVdpc6b24TVAiiFZx5m5dj
 ZcSyZsfDQBYDKeYu2l964MZKGpELNh4PRygHx+Kxg+LyTihNBPW7/tY2iGbSfQ4Qwsmi
 nvF8cB70xm00xusxX6AwTEI9ULDKgEitoQhNRtnpSP24Shz+RKVATyYWm/SVEt3pfzir
 F2Vg8IFsiP55doLpMQzJi81lYdEoKeRl8MvwbAtYTGIRL0V8EaA9cOw+hm2LHIB1/VRL
 PLg6Xx4E46jPgZNai2jRzH69hEV+Y2a4eHrLc6JBtTPrzirbIESIu8HzuRcpPXX5Y8oi
 q0oQ==
X-Gm-Message-State: ANhLgQ0Ad1Ws/T0hFo+Q0dFsxXPLya9YfgSYpD1vUyArWJX0m9AMEaBT
 uInKs7V5armlT7goxnsXI3q185lW
X-Google-Smtp-Source: ADFU+vtOoKyBi9UeKV8F1pckNM7JyrwKN+397eOiLHc1fnUc0uObicnOi4kdSUJwKfXqpjMyQ52QwQ==
X-Received: by 2002:aa7:958f:: with SMTP id z15mr10788209pfj.130.1584728874747; 
 Fri, 20 Mar 2020 11:27:54 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:54 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu/swSMU: correct the bootup power source for
 Navi1X
Date: Fri, 20 Mar 2020 14:27:23 -0400
Message-Id: <20200320182727.3805-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320182727.3805-1-alexander.deucher@amd.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

PMFW may boots those ASICs with DC mode. Need to set it back
to AC mode.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f6d4b0ef46ad..2cfb911ab370 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1154,6 +1154,21 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 				}
 			}
 		}
+
+		if (adev->asic_type >= CHIP_NAVI10 &&
+		    adev->asic_type <= CHIP_NAVI12) {
+			/*
+			 * For Navi1X, manually switch it to AC mode as PMFW
+			 * may boot it with DC mode.
+			 * TODO: should check whether we are indeed under AC
+			 * mode before doing this.
+			 */
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+			if (ret) {
+				pr_err("Failed to switch to AC mode!\n");
+				return ret;
+			}
+		}
 	}
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
