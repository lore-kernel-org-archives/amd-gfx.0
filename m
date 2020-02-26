Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7365C4BA2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 23:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCC724650
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 23:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT62dgWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCC724650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6DC6E27F;
	Wed, 26 Feb 2020 23:05:41 +0000 (UTC)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071B76E27F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 23:05:39 +0000 (UTC)
Received: by mail-io1-xd42.google.com with SMTP id c16so1054973ioh.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 15:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cHRAj+5KwFTKG9w+Oa6ZXBKPEh8T2DAAjaT6RDgAntw=;
 b=eT62dgWfE2jsVL31FQ/WYbAYhGDUSix+uSMWC5EtOyPV/YuBkP1g5s4gEnDwCP5zuV
 ss3yypNyC1CvjCkI1q9BQ6CMfy2ecXVqwH/+4kAxwxHgrX+4WEr2im+YmBZx0ULlAuFc
 t9hV5QK2xg/QrGjlOO2jBzHDhPxFQFuP/5c7SNRwy7QUM7IkTzQiYHsY18qeGPHtg/mQ
 MwuEdxpEC74kEznO50vJPL5duiws+ZKmpolEYWN/V4p4mMohitUVbzs1RaVgZmmWZvES
 dPYz+XOXVOzm8df4YodBUBf4EZvO3PAp0FR/G6vDwrDm2nu3RTxw69lVH9FPcdaE7WwW
 v9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cHRAj+5KwFTKG9w+Oa6ZXBKPEh8T2DAAjaT6RDgAntw=;
 b=fUFIC2cwkh23OLw6u12rj+kiiymJy11eLvnWhWtBLmKSqnCvrw4HxS9hyrI9HpVJwy
 EFT3+dzvD7q6np3nD5U0ALWez2sVT5lSrJT0Q9GIEQNHE2p+WhvhYnOAFEJ3RksF5roA
 89D77d1hFeEiPS6W5gJ5ZTDgG74Xp9CAN4WEukxAmWmX7use8eNRL1FnGPxlzRnajIRj
 6KQFWQ7Lzz2oI9OtR55I7nmiTHmqxZUMeLOvnL5EbralGmEAs3xuFX1/UGdp0UArMUP3
 NvgxyiIV61H+7aIPr6YgzT3yhirCNuiIfx5eXWKXqPnumcXeph14kETC3qj5EDGDNfU+
 KXNA==
X-Gm-Message-State: APjAAAVn1uqmOow+SgHKCpVNyu5I3XzpzX6uH7L2akgMyE29BBD670wG
 JG/Wh6cIh5dpLGFGbUR9iSLdwRZZvL8=
X-Google-Smtp-Source: APXvYqwCJW2XJ5552TYscVyQJ1r7fOCoH9ww/14qDFiwGIgxKOgtc7tvSwuKHfrO/yEKC4s4bY+odw==
X-Received: by 2002:a5d:87ca:: with SMTP id q10mr1120131ios.192.1582758339103; 
 Wed, 26 Feb 2020 15:05:39 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id r14sm1191177ilg.59.2020.02.26.15.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 15:05:38 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/3] Implement SMU message register protection
Date: Wed, 26 Feb 2020 16:05:22 -0700
Message-Id: <cover.1582756642.git.mcoffin13@gmail.com>
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

This patchset adds a message lock to lock access to the SMU message
communication registers to prevent concurrent access.

v2: Separate navi10 change out into a separate patch, and remove mutex
definition from first patch

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

 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  46 ++-----
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
 11 files changed, 219 insertions(+), 219 deletions(-)

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
