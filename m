Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C7C2D0BF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 14:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216A320725
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGvG1OvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216A320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7E06E58B;
	Mon, 16 Dec 2019 14:03:36 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311D66E58B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 14:03:35 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id b19so6839174wmj.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dqr9mBhgV+gBZPcKDLhvZpTyGbwr6dceXxILfiPmr5E=;
 b=VGvG1OvMhFHB1VjPqTQTKEnBc8aaY9ppD9tFO70viVUN3ozUc8MorDAxtIVt3pTFUX
 aLXBsBZZ/eJSMo2ipoPwtD2I1j99K9ejEAfq0uAcBKPtqay32b8IWrPFqbqAC7p1vuob
 tIyskAMv4OhvW25+0tzXWNUJzXG/ecBDyJBvo7uaEy7GoqgUoHJdmbxkZzFgLzqwQVDv
 5IUoo+6bcdM4Z8nAGpFMdgVTwJCgHov29hSUXi+0WFo8HMEshC0uREOc77kFkzcAKqaH
 Pn1fAZumy1+QbKaS+K+4FH5ynl8kdE+VEXjO8MqqiWsASl2KVYOjeG4qvCqPn33hhBDN
 pgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dqr9mBhgV+gBZPcKDLhvZpTyGbwr6dceXxILfiPmr5E=;
 b=sczg8gTk6jbGjgQi9V0uVh3R0xVh1IWmZXY/PmOQMZPdMr7a1UihP2nrNNM36u9zpm
 /BnYdQzi/Sbip6qmD8gXP3Hp3Nm91YJdoEYP1eWvktXQbxOOEnnqT5o5CmCSjGXmt7yK
 ytQsu+WOBIssKE9+xk4XA9orpWAmf3fwsjLN1lyRhAZ731ilRWSev/DQ3waOELHTQPfI
 KisNAlGemMfrpjpHv3rxpRiaFoiDPZAaIHCcXebrL5sjmPqjk5h6OX8wbFr2Qd35uWGO
 CkgkKeuA5hQ2+iVyUI6y2ugKuKaZ4j1jT1OI1/b4hO7zsjmfaVd0MDi3i2t/F+Z/4wuL
 khiw==
X-Gm-Message-State: APjAAAUt6mM1W4smPsq4LI7WpAWV91kIDWrLpkX0Qf0urfDTsTyLyluu
 z4oUVrjw4WbX3fgPccH5G73ZFBFB1hM=
X-Google-Smtp-Source: APXvYqy/D5DFTkEKTu/wMMFf7akpVwrisck0mF8fi+Bu1XOez6SzUWj/d0+M0QUhdrPrWf4BkRt4UQ==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr32202240wmf.136.1576505013367; 
 Mon, 16 Dec 2019 06:03:33 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F249500830CE7316915D0F5.dip0.t-ipconnect.de.
 [2003:c5:8f24:9500:830c:e731:6915:d0f5])
 by smtp.gmail.com with ESMTPSA id s15sm21624021wrp.4.2019.12.16.06.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 06:03:32 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/4] drm/amdgpu: cleanup entity creation
Date: Mon, 16 Dec 2019 15:03:44 +0100
Message-Id: <20191216140348.6023-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2 Changes: rebased 0003-amd-amdgpu-add-sched-array-to-IPs-with-multiple-run-.patch because of
a5c191e9cd09a8fa697865882619692b4dba8417(drm/amdgpu: fix JPEG instance checking when ctx init)

Nirmoy Das (4):
  drm/scheduler: rework entity creation
  drm/amdgpu: replace vm_pte's run-queue list with drm gpu scheds list
  amd/amdgpu: add sched array to IPs with multiple run-queues
  drm/scheduler: do not keep a copy of sched list

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 113 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |   5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |   8 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c      |   7 +-
 drivers/gpu/drm/lima/lima_sched.c          |   5 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    |   8 +-
 drivers/gpu/drm/scheduler/sched_entity.c   |  77 +++++---------
 drivers/gpu/drm/v3d/v3d_drv.c              |   8 +-
 include/drm/gpu_scheduler.h                |   8 +-
 24 files changed, 176 insertions(+), 156 deletions(-)

--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
