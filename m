Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD1C2BB54
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388E520787
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 01:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="N5VA5PzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388E520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aurabindo.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AE96EB35;
	Thu,  9 Apr 2020 01:42:47 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E2E6EB2E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 01:28:19 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id c63so2488797qke.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W+2Y0Xi530M87fNTrtIwP1pMSm7GqwPkRfMOed11GCs=;
 b=N5VA5PzWygwcF51uf54k+ipqv7JgkBJdnFyoVNkSZM2Y5Bl7CGNj1MEyoXmsSDXGiV
 tGmSgTfxguxY7RCreRX1mU1o7GwN2vzb8xJIQgiHGtvLCgqt/fvNs71MJR6ZKjMHhA4R
 lt+IQNlGF0X/xUSNtXAXNNVICu97RIexts3lt+IaZLSfr5FtJjFlTi1gWyvJ/7b1k14k
 zgWwfyNLYfNfUiCDTFwhJoWNEyszdYTyWtjsMtTPvFJm2VL/IxwXxox+6hgRy02EQlRv
 sGfEuGn3eDWrOKwKq2r/XI4vPkjlB0p8ZdV7huJhorql6JWRl/I6WjMUdNgDnu9XFblg
 nwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W+2Y0Xi530M87fNTrtIwP1pMSm7GqwPkRfMOed11GCs=;
 b=oyfkyFNwfwIGPhlu2u4ps4QYjUkXCFgo6SZ3E34Mzw86+Dyy8LG0dcQA6+fcKp6wwB
 MU/fai93GaZvMvh/X448cAk7OabPi+Qi9ymnVly8ITE6gBpx1pmWjiTrkNZ+BLVT9EwW
 e/9DVQ88G5f4Sg7rtMh2J0YXmcy3Yffk/zl7xczmJNJmtEveV65akKLbOW8hmg8Qq5Kp
 ROLISycg6KBf61iqSvrw1q5S89hDSj94h0bm3lSNF64GKJ7+1SznaBj5iPhjEAJrydAp
 3qAOCpTcC0kL8WMOL5C04qyixzA3D4pMEK75/Sp1Y1mOtoNwWVMD8hA9RO/A+5C1gK3K
 Yz0g==
X-Gm-Message-State: AGi0PuanRtcrx5GtTXTVcS82KQozIBDZW2XLNQTHDqn+VQro63x/Rnjl
 SByjE8q042u3a2lSiN0vnJvTIQ==
X-Google-Smtp-Source: APiQypIcnFZuNeQsehdaKyuMo95ePmC43hl4IAy8auSxxePTv47MMvGLLjTgt/bXZQrCEEnI0SdLgA==
X-Received: by 2002:a05:620a:15d1:: with SMTP id
 o17mr10479294qkm.457.1586395698825; 
 Wed, 08 Apr 2020 18:28:18 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca.
 [135.23.249.169])
 by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 18:28:18 -0700 (PDT)
From: Aurabindo Pillai <mail@aurabindo.in>
To: christian.koenig@amd.com, alexander.deucher@amd.com, David1.Zhou@amd.com
Subject: [PATCH v2 0/3] drm/amd/amdgpu: Add print format prefix
Date: Wed,  8 Apr 2020 21:28:12 -0400
Message-Id: <20200409012815.22309-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Apr 2020 01:42:45 +0000
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
Cc: airlied@linux.ie, Felix.Kuehling@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changes in v2

* Add dev_fmt format prefix
* Removed hardcoded module names in pr_* and dev_* prints

Aurabindo Pillai (3):
  drm/amd/amdgpu: add prefix for pr_* prints
  drm/amd/amdgpu: add print prefix for dev_* variants
  drm/amd/amdgpu: remove hardcoded module name in prints

 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            |  2 +-
 7 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
