Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB70C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 18:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B92206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 18:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq07YBAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B92206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B68B6E53E;
	Thu,  4 Jun 2020 18:19:22 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB4A8999A;
 Thu,  4 Jun 2020 18:19:21 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id er17so3407535qvb.8;
 Thu, 04 Jun 2020 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xkaxrif0FSGbjr9bwXiaVJTEiIbdMG6J44e2+Z+G720=;
 b=Dq07YBAw5C44vH+1nK04G5uMKVcA/Lvoe49cmbpVvUFKuuEauaOiS5H0VK/5YfLNMF
 KsNOXYdH5pWzmcHwVi8PQM/qmPzppmCnAYGDjfRxFkEH1IcU7i3092eiAfNxmtTl8jLT
 4FjymaLCG9Iw+pEgNzum6+HJSiABkiLO+/Xfi2JckYXqe8Lsn8fM6/9gAR4HwWoO15TH
 MW28dvFl3IiRi70DbSUC2gMNEtl5XQ8915O6qqcYzgOZ0oEXl7Ll7fsbMgxow/IuVDWR
 7t1YycXRE85briTJS0c+IJ1DLBtsxlDB6DW9ltMDSNCXTtXp00BWN8KOZA1H95lX0k4h
 nFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xkaxrif0FSGbjr9bwXiaVJTEiIbdMG6J44e2+Z+G720=;
 b=BtnNosPePmrE4iq+stNRqxyVfs3XWzeuuwRvWOf9fxCV/x7nkGYc5Ns+GElpYidjdQ
 9kBIIPm/wPr+KjWtbysmDzkvp3jvt825nyYMwVbKtOibxsPENkgKbbNHTSJw2ASiaZdI
 tpvObuQgo1bLtS7Ieb/NvKM2IXAFJfpI+y7GWdQr+9WNiDxs1P72ylDceJVgTmER5ToQ
 CV3EWpFjJLZPrQ1s+dGrTZ9gmguMH/iiOtpDphMcnLeEwKziOXx0Ll8Ccupc0/2oR1fz
 uasLFuugCJEtVy9gYYBlOjMjvkkU4r0g4Zxcfz+clfeeVrL/8cZ+ZpgpBRmg7u7GXPys
 kWcg==
X-Gm-Message-State: AOAM533MejOwYrwktvzvJ6Jft/lZvp50TIN8j/dXhfBTp6SvWa7vEUfb
 IQMYSKMNitlIwI0Z0ks7JMm1yh1p
X-Google-Smtp-Source: ABdhPJw3vfz89wmkmGSaTcP8IDx8d9Vx8yBQq2NuJ9ivdRgORYf5ICoIa1ntSt+wFAZ1u2xZZA/35A==
X-Received: by 2002:ad4:5628:: with SMTP id cb8mr6004808qvb.39.1591294759963; 
 Thu, 04 Jun 2020 11:19:19 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id a62sm4875856qkg.71.2020.06.04.11.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 11:19:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.8
Date: Thu,  4 Jun 2020 14:19:00 -0400
Message-Id: <20200604181900.4609-1-alexander.deucher@amd.com>
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

Fixes for 5.8.

The following changes since commit 9ca1f474cea0edc14a1d7ec933e5472c0ff115d3:

  Merge tag 'amd-drm-next-5.8-2020-05-27' of git://people.freedesktop.org/~agd5f/linux into drm-next (2020-05-28 16:10:17 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.8-2020-06-04

for you to fetch changes up to a24eaa5c51255b344d5a321f1eeb3205f2775498:

  drm/amd/display: Revalidate bandwidth before commiting DC updates (2020-06-03 15:33:06 -0400)

----------------------------------------------------------------
amd-drm-fixes-5.8-2020-06-04

amdgpu:
- Prevent hwmon accesses while GPU is in reset
- CTF interrupt fix
- Backlight fix for renoir
- Fix for display sync groups
- Display bandwidth validation workaround

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/pm: return an error during GPU reset or suspend (v2)
      drm/amdgpu/display: use blanked rather than plane state for sync groups

Evan Quan (1):
      drm/amd/powerplay: ack the SMUToHost interrupt on receive V2

Harry Wentland (1):
      Revert "drm/amd/display: disable dcn20 abm feature for bring up"

Nicholas Kazlauskas (1):
      drm/amd/display: Revalidate bandwidth before commiting DC updates

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c            | 171 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  30 +++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c         |   6 +
 4 files changed, 207 insertions(+), 11 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
