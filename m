Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6EAC4BA24
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 23:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B690222C2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 23:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyCwC90N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B690222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345436E183;
	Wed, 26 Feb 2020 23:16:27 +0000 (UTC)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D916E183
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 23:16:25 +0000 (UTC)
Received: by mail-il1-x143.google.com with SMTP id p78so672565ilb.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ka5lU/QsYZop21aC6TYUNK6utIWdU04koxY5N0YqQNs=;
 b=WyCwC90Neva3+AzMXCZHyJb6uohsbTHCe/rpuPZGZ/k06jNnaqL0D5ZkOheghyBdj/
 I/EjAyJn5Zd1QXz2KTUUyzkqmox1H2kryQ9oQeK4NRwQl2/j1HdR7KU61bNk9B1y79t8
 6E8Z3Otri68tuhfJ5tnI2Sg3EDCfSchEUEYDo4bJnfBIyBEt50iqT6Auy0KH4Br97ZkH
 DAbi5eXC95Kd2j+mK0/bmxi55piLBJUB+4VgXb3ERG27yeaMJuTzDmnSAk2O0Q1rZf+f
 45lHA1eMMc6T6nGZLVwrVcPO9aSjwP79Q2mIF0793tiLgIGI0wGrumTKU+0RR6ImRKrd
 zDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ka5lU/QsYZop21aC6TYUNK6utIWdU04koxY5N0YqQNs=;
 b=Ngv0vSfIk+VpX45m/sOr32nnYUCVWquGmVHOvQhesL2QTX8Q9/TpksLTLnAzKVcoxA
 0nIDetG+5ra6VLXD1KYUosAZckCccvUKzrFL99IfAsWU4x1ASlRPfAXXqhLMyESyImIK
 AcW0b+odHxVxg9bNuTwUUN62UczvEFmOCIGWxYDekYUAmsqbFzn+aJP9aigmzOiNQT3p
 B+fKQMLNmcOAVFt/9rQE3RIg9eOizxD5VRwN9yipcUh8NW7SjN9uY5sHwUUrPGVhaotL
 kMGP+xnt4CXcfGhKoTOMxs3cSHlqoc2GLd1NoQTzRX4Poht3zJCTACVG+XNCRxoAe+mV
 jN2A==
X-Gm-Message-State: APjAAAUnnHOe4AzWVeFgPAuwTLe4ZBMrW7j2DQWV9EbAaEowZKy0/TS5
 Lcvr1XkJ40zkEKQ6r9dJMi5JjUiHLpU=
X-Google-Smtp-Source: APXvYqyOaMVmplti3y/+IExLL0ubvFURwWs8ynmAukGYcEiYEnK2v5RTq65hFDZ6AoV9rJLwnatLVw==
X-Received: by 2002:a92:cf45:: with SMTP id c5mr1471286ilr.236.1582758984735; 
 Wed, 26 Feb 2020 15:16:24 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id u80sm1119912ili.77.2020.02.26.15.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 15:16:24 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 0/3] Implement SMU message register protection
Date: Wed, 26 Feb 2020 16:16:11 -0700
Message-Id: <cover.1582758921.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <CADnq5_NTd_dZAtN4yVyeM+Fp2w0Toy=tkvz00OwiYyC908W1Xg@mail.gmail.com>
References: <CADnq5_NTd_dZAtN4yVyeM+Fp2w0Toy=tkvz00OwiYyC908W1Xg@mail.gmail.com>
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
Cc: Matt Coffin <mcoffin13@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry for the extra email, but the mutex_init got lost when I was rebasing. Oops.

This patchset adds a message lock to lock access to the SMU message
communication registers to prevent concurrent access.

v2: Separate navi10 change out into a separate patch, and remove mutex
definition from first patch

v3: Re-add mutex_init to amdgpu_smu.c. It got lost in the rebase

For Alex's concerns, I omitted one of them, though I can re-submit if
it's still desired. since smu_send_smc_msg was previously around, and is
used in lots of places, I left it alone rather than replace every
occurance as it still makes sense to be able to safely send messages
without arguments, without knowing that the default argument should be
zero.

Matt Coffin (3):
  drm/amdgpu/powerplay: Refactor SMU message handling for safety
  drm/amdgpu/powerplay: Remove deprecated smc_read_arg
  drm/amdgpu/smu: Add message sending lock

 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  47 ++-----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  30 +++--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   4 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   5 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   5 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  35 ++---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  26 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  11 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 120 +++++++++---------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  87 +++++++------
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  69 ++++++----
 11 files changed, 220 insertions(+), 219 deletions(-)

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
