Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C2C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 05:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E80B221E9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FruX5hB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E80B221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A101A6E3C4;
	Fri, 13 Nov 2020 05:55:22 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC8D6E3AE;
 Fri, 13 Nov 2020 05:55:21 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id p7so8637334ioo.6;
 Thu, 12 Nov 2020 21:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eYYeE8QzaK5WeR5CogaBzFoKN/iYwCNInsED+Vqp3bA=;
 b=FruX5hB/MZOmxJ8vRFcWL+Lts43ENq5BFcHkJ3quR9C20dfBhINV2j1tnszWPkkFIQ
 5nl8UNp7bta+Rdo8PBJx57Aq+X0lKzXCL6KnJgqXNf8qtXjuO7Pa33s3y7YAudWVLZge
 84EHShtNzJfRNdk6ydso6YTIjUxsluv2LLehwG9VIhOAFgXOX6JNipTFtnhmd6K9Yi28
 Rp5SsK5Dh3Iis+IuaaImUVQt9wd8Tj5obVLzFTem1yTskHwWsigUQ2bpvDeoNCnZL4AE
 q7mlaGiLa4vOT26HYtg+Z6CyQljqQKry2aFo2d4Mg5bgKPb4F6QXvWo6ZZJKqeaYN8Kp
 eO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eYYeE8QzaK5WeR5CogaBzFoKN/iYwCNInsED+Vqp3bA=;
 b=sc+RUW1/GOuVNAD6bDd6hZDHdYTgmBwomr5gRlFayXDvJDWbjRYcNc14y3c1HezNty
 Ko2ETgJqhd8doZEUfOSvcTF7SHxGfJlP60+jXxnJU8+PnaAsuIA7ZaC0yWAxmODab/Fk
 PSkOlzqPGNEZxRxjEMYiw5uHJXJqKWF2jiIXftIu0GsP7+nZDeys1/bQJ3SMleea9JtX
 3kiNU+Bud6uDNLEBBDPyqrMZ2M8RwfyQ4zdPsnMRr6nWdmXIryyx7mSB80j8Ga1PgFWb
 xN3fXU4We50QRvbs6FGWNlJ7veZ720Y4VbdmzUvKYbNlpJ83AKvuza5O2NADvs1h8Llv
 NDsQ==
X-Gm-Message-State: AOAM530GYsp/+6MpTOumAknLZQARZ/ur6uHiB4gbJXk5nZh0+/H/hcAf
 FZ2KcClK/IgbAKtgYP0w8sQAK76aZsc=
X-Google-Smtp-Source: ABdhPJy9zrC3fUnmHHu39HsmbrtRl3DB555IsUvWXhC5Jhkd5kHj+1f3HP+MlRfX+bK97vBclSBKrQ==
X-Received: by 2002:a6b:d907:: with SMTP id r7mr630227ioc.37.1605246920834;
 Thu, 12 Nov 2020 21:55:20 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id a1sm3898761iod.39.2020.11.12.21.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 21:55:20 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.10
Date: Fri, 13 Nov 2020 00:55:12 -0500
Message-Id: <20201113055512.3963-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dave, Daniel,

Fixes for 5.10.

The following changes since commit 4241b0411c60a97f87a25ff4da92dac53beb3039:

  drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE (2020-11-04 08:43:50 -0500)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.10-2020-11-12

for you to fetch changes up to 38a2509184952f799d465b26279ef1bd36fb8277:

  drm/amdgpu: enable DCN for navi10 headless SKU (2020-11-13 00:30:05 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.10-2020-11-12:

amdgpu:
- Pageflip fix for DCN3
- Declare TA firmware for green sardine
- Headless navi fix

----------------------------------------------------------------
Bhawanpreet Lakha (1):
      drm/amd/display: Add missing pflip irq

Roman Li (1):
      drm/amdgpu: add ta firmware load for green-sardine

Tianci.Yin (1):
      drm/amdgpu: enable DCN for navi10 headless SKU

 drivers/gpu/drm/amd/amdgpu/nv.c                              | 3 +--
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c                       | 1 +
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
