Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37831C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B502217BA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls3r49S7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B502217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8172D6FD62;
	Fri,  7 Feb 2020 19:51:08 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771F26FD62;
 Fri,  7 Feb 2020 19:51:07 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id d11so263293qko.8;
 Fri, 07 Feb 2020 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zOLmE9NmUX1Q77II+hYnRRqSiHkdjBeHkZCNTph3SIM=;
 b=Ls3r49S7O9sc/Mcjw2H9mvhSvTxJZwljw4PE0bOcNeIrkZPpe13LSBGYSGxB4OR8A1
 AyPvNEgSGjpdXdGapoFLApaN6AwUPHDcxQTi4/ILlAxxLsMz1+g6Bw95YZGPnxtmKotZ
 ZKzeEFkYIHUGlI/To5c7BSGP2Ie/4qo0FUwB4ULBmvmfYENDqYFSoW2CMem4YhJ6XvlJ
 GepNNq1JMjt7ASLBJBUfI+SEYIyxejiVSuFd6fp5nrz5Q2E4eJ7N8duJSVZcJ9UFyqxR
 zOgWXlr8f4UCMX3mS900rEZcioC0yeyNV4wUZ0NB7yN/5VURegRDV3gmmU8y+m4J68YX
 vP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zOLmE9NmUX1Q77II+hYnRRqSiHkdjBeHkZCNTph3SIM=;
 b=KnYr9dcBzi9IUCmFtgyvRMs3O+BGHq+liccUamoL6kfs91QbiUWJawShxhkXEWzJFz
 i3tq9xfdpEk/LlEmFA1C+uL2Uv9+4bNGJNNpUL/LA6wjOYgQWMyrj1mik7Wid3Nmt9NW
 ithNjL/sALLvd4JAqFFUJ7pqTYq4w/SJRp5sNQ0cg+5m7QoicUhEL+Qb+wib3wTaybPc
 2FTLQyXxtk293HskBrFPeW2rc8MMsOpdOkVnmz8OqbaV0QAoACR+28Snq1ARel9REDDK
 W9tShmPOOGgbzG970qpEQTtIlOeuyA/Fv5BpmsqaRtWRzmf5Cly3yW9l/CT3cPPOTsna
 QPZg==
X-Gm-Message-State: APjAAAWSIPtpxmZckZBOV+eSXj27TgQEZbELlFPnPyKcm9CB505l4GI/
 XFvjTTcmv7TlkiNqFiNYiCG01tW+
X-Google-Smtp-Source: APXvYqw79unrgKYmmcCEppCGWglVNyUh9Z5TWhfv0Se0+3HnSwv86HxtVwB4sSODitA2cUi5p/ZzMg==
X-Received: by 2002:a05:620a:21d4:: with SMTP id
 h20mr503901qka.468.1581105066242; 
 Fri, 07 Feb 2020 11:51:06 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w16sm1752226qkj.135.2020.02.07.11.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 11:51:05 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 00/15] amdgpu: remove load and unload callbacks (v3)
Date: Fri,  7 Feb 2020 14:50:43 -0500
Message-Id: <20200207195058.2354-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

These are deprecated and the drm will soon start warning when drivers still
use them.  It was a long and twisty road, but seems to work.

v2: Add additional patch (13/15) which should fix the crash reported by
Thomas Zimmermann.
v3: Fix dp aux registration harder, add missing kconfig guard

Alex Deucher (15):
  drm/amdgpu: rename amdgpu_debugfs_preempt_cleanup
  drm/amdgpu/ttm: move debugfs init into core amdgpu debugfs
  drm/amdgpu/pm: move debugfs init into core amdgpu debugfs
  drm/amdgpu/sa: move debugfs init into core amdgpu debugfs
  drm/amdgpu/fence: move debugfs init into core amdgpu debugfs
  drm/amdgpu/gem: move debugfs init into core amdgpu debugfs
  drm/amdgpu/regs: move debugfs init into core amdgpu debugfs
  drm/amdgpu/firmware: move debugfs init into core amdgpu debugfs
  drm/amdgpu: don't call drm_connector_register for non-MST ports
  drm/amdgpu/display: move debugfs init into core amdgpu debugfs (v2)
  drm/amd/display: move dpcd debugfs members setup
  drm/amdgpu/display: add a late register connector callback
  drm/amdgpu/display: split dp connector registration (v2)
  drm/amdgpu/ring: move debugfs init into core amdgpu debugfs
  drm/amdgpu: drop legacy drm load and unload callbacks

 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 69 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 17 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 15 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 14 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      | 10 +--
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c      |  1 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 13 ++--
 19 files changed, 140 insertions(+), 89 deletions(-)

-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
