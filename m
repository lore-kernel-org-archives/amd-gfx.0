Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E420CC433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9898223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYQ7wY03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9898223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE8B6E856;
	Tue, 14 Jul 2020 18:24:51 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B5F6E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:49 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so7959971qvb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ps/uqN50ibaPsKY3Y+v3codHfg6tumNjBbavX0tCPDU=;
 b=PYQ7wY03uzjC3o6HSzUw6b4UNMTqs0PRK0EuAF44qHYhwZ+HYFaIUD5ZYvicB1gTDn
 jVW46kLpHl5AuBuIkYG1H79HsGnJIujqgnUfVbCfA9AaQdC1MjJoZG48i0lNr9547w81
 9rxJRUwEH6apJwlEgvNfb9VXe49Co/VddKpfWwYgT5OqLswf5NGWcHsL+qc1MwLjO0UX
 +QNP9hWbP6fW9/mJwfmIP6nX05idkYG423KDXEalMABjxrNHx7geXfpeheaHj6hEuGX+
 VYU0ZypWh99+YAiLczt4qhMLBedUImwpYHM+ivmQq/RgEhUS5qCi37LvswHPLPby0/jU
 ohJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ps/uqN50ibaPsKY3Y+v3codHfg6tumNjBbavX0tCPDU=;
 b=OdguPh22D5cM6L17FyJk3S32nJ5MWT1NNNLfd2pLwHDVmUn7f/jlWAEAw9pEoYBvNQ
 yfC1Q0aTCA8j833zZkifY5e24cfgWTq0CA+KCqCBrHk/kArhqf01ygp55MEbpT8n50hp
 VMpHegJ94lxHV0qnqUd+13BEmN3Q0SIL5Fexw72fXGCABIJv84Hi8fDdrI7Yc7V+AHwm
 ZZL3/tVqQ3vw9Z6L+FhqeCqdDn3+aeWcue7Du6PU5OTmC/tU9NLNV0sNabO/KT3cCFp5
 oon0DvRp4nWmL+fvHvCi3Wp2nV/zxEOLcZ45mJerva8NwkZ/f2+qJYcdO8HCQpwRal3A
 +C2Q==
X-Gm-Message-State: AOAM531OesCY2qv6eefbC93f7ZuW0PizaxmWYPXIqT5ND/kyYeSwJlNJ
 nP6VYZc5On0mBygQv30bpL6DFaYx
X-Google-Smtp-Source: ABdhPJxgPXmkNW4j3nOCcfTc0KsO7mj3qmMhMHqs8bn5RZWUanNvt0pixFVJCXsKQBoiQfeIOnP+Ww==
X-Received: by 2002:a0c:aa41:: with SMTP id e1mr5699689qvb.117.1594751088667; 
 Tue, 14 Jul 2020 11:24:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/42] drm/amdgpu: add vcn ip block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:41 -0400
Message-Id: <20200714182353.2164930-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add vcn3.0 and jpeg3.0 ip blocks for navy_flounder

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e62426a2a929..0f567b4b94b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -521,6 +521,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
