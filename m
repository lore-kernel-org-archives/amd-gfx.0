Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49BF36C5C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFFD10E557;
	Mon, 20 Apr 2026 12:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TYAeRrY1";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D02010E555
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:49 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so20320475e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687048; x=1777291848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBf1Sz12Kwcpg+hEM5GsZsjs1GKhk0PmN9hBFVBfF7s=;
 b=TYAeRrY11zjR/zRSAbtM6TMFGsLdhJSyvQAIADdNfEoECHMp866X05xCIuQcaGvGtm
 fE3SHJXEkuwe3G+BOzmckxGmOIH3WMftZdN2dj2yfd1RculvZrfOdyoxLYRFUdz9Ym8y
 Yoq2DY++B/hUk2tyqFnHrRf2ob6UKtBrUkNnxsqUEe9xDaNLEo44OOm5Gr5xfEVCa2/t
 SjL2FgedrfJTd2HQij3/ursQ2FMGSDxBpD5cdAWvphjCMCUutY1uFI87M3nnOPpR6Ycb
 SzHaqkBerJsW+dZ8TKtlJWdJDAYE4ISiiZjnYazh+d6+Gfj/m6OmaZIFaqRQYmrv+iU5
 YFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687048; x=1777291848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBf1Sz12Kwcpg+hEM5GsZsjs1GKhk0PmN9hBFVBfF7s=;
 b=dB1zC0vpRQCN+kOZ4xJiFxb4NZmHAGr5ABbSUNf1rT1LKllO7MaC5v+RZa4GNMF+Gy
 Nvfdbqap551QdwzbEoTULvHgMRB5mtVqFwkfyCtXCHC1ImoJE6CkxpNvgelwqcp/9Ynm
 0m2zQtZKAzuCMixYBKNz4D2njjpa1UMbLg6/SyF1exjuXTq3WEWcs+7PIwbS5u7lnXOU
 LZuaAvIEUOnjlmfxlJZk/QeFg15EXOCQASzeykBR10yOAozZET8w0vLMqXgAG69jM9dg
 wyEL8kos3yi81WM7ZveUl+P7yLR4E43xy9y+L/6SbPwxeRI4qwXsRw6VL8DMZEhZuXsr
 r44g==
X-Gm-Message-State: AOJu0YxZJF9E93Jd/HZ+vBmeYEMtrnwLSkpmTEdh+5ojen59teTqtNTB
 WyNkEW4lCLQtB5GXgSGL6i7K3deMQd0jPHmdYyRPHlveDszu81JAuCIfhQXsrA==
X-Gm-Gg: AeBDiet8mYNsuDgsZ7c+whIeqBZnl9y3IKoYLsoIdFGLN1ZjIUyp6kW1lVjMf2rjtu2
 n5fHCT+Q+EtLZ8Q7DfMHnn/eB38sOLGiSVNIWZVqrZEdxTqiVReQb4J4BFeNdpd9XejA5A231bS
 W30j0bCB3CPYDHXAtdkGIrVUIQShXuhs/0BbuLNDX+yOJXQrTluqZjXtOMErkHjX2AMKZ3t0SrT
 9Wktt6ltqkDvJtxkMIZ36lGFkWQq0nEFvnLVJoWuxfQ1YH+Q6o1U94tqaxa9LAD4tyWncMeenCn
 U9CBLbZvpLEVcoUF4p6c9u/73K4mSeUqPVKgW6xGAcOyf62CHGhwKo2RdpaHzE3RgDhba6+YUq3
 iz804DyQkNU4NqrXpd2o9aeg+c1M6DvOcVzbewy2JaUD3zttnVnTWQ8DzEO6Ux7HZXKwfs90e0R
 bCJ/FUTsuf9T0dXFQYWhqcSuNSOllBw+IuhrjP34QMnu1bv+zfwxnI2EeuOz0ySrP7g0a4GUW3A
 EyDbw==
X-Received: by 2002:a05:600c:42cc:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-488ffb14a0cmr79633345e9.12.1776687047737; 
 Mon, 20 Apr 2026 05:10:47 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:47 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/7] VCE1 fixes
Date: Mon, 20 Apr 2026 14:10:37 +0200
Message-ID: <20260420121044.155030-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fix various small issues regarding VCE1
and the workaround to ensure the VCPU BO
has a low 32-bit address.

Timur Kristóf (7):
  drm/amdgpu: Add alignment to amdgpu_gtt_mgr_alloc_entries()
  drm/amdgpu/vce: Align VCPU BO to nearest power of two
  drm/amdgpu/vce1: Correct firmware offset mask
  drm/amdgpu/vce1: Remove superfluous address check
  drm/amdgpu/vce1: Check if VRAM address is lower than GART.
  drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
  drm/amdgpu/vce1: Align VCPU BO GART address to nearest power of two

 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 32 ++++++++++++++-------
 5 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.53.0

