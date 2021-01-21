Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD62FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 16:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509CA22DFA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 16:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509CA22DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14BB6E8FD;
	Thu, 21 Jan 2021 16:01:41 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC196E0D7;
 Thu, 21 Jan 2021 16:01:40 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id h22so2097595qkk.4;
 Thu, 21 Jan 2021 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=63pQYeRaLuZG7B+la3B+ygXFTkc6XtrvCV7w25iD7Nw=;
 b=BanZNc8DrfziIqFl0xe8VnUAdyg79knDm8Fn6xa7eLLStYjOL5aMklrFbB/0F3UTMR
 kSoDFg8wzHCjm+Ylv9+GWjJgFinZlKxVK2RWuaRK7eFoDWN+MmDoKzoOOZJyl4FLSig0
 q6bc0BIoBGsVL+2cB/xMe5KvsCma0oyFoLBCE59+xV7PXd+kcIuXGEc6+9+O1nJvin7X
 6BzAtWI26ofVFANz3Wlv9m6Jr8HBK1j6kYm8Z2eAQK/7z/LBVilKYNiH1oBxqZufZIgq
 eP8NjyE5uoY40zeLKl9pmyd5vZFTwD1bdFVddw7O2OSv6UD1GFzqUbiyCDhD8hKZvNlz
 XrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=63pQYeRaLuZG7B+la3B+ygXFTkc6XtrvCV7w25iD7Nw=;
 b=AfLBXozs7XoYsWp8Nwn9lhDf67HMlBesxRizOIdAR4k//re4JBJd3LvElLXkxlUG4r
 6/jENFSdp87G4ow+JUuv7H7lxl7JthXqDc+9lPSRbadjri8xzLv5VVy2huLP1GdAoX6z
 Me4QDInicH6vSNTVYgmCDa96C0I0DMUBW9I1+jzKhiIvim5Pw/xCHzhBqYxKR1hGRTH7
 1j93ReiI6IJ9e2yFhCaMYCEFdZZviEBbkE8Kut0YbMFbi/DdsQ8mgnzR+0edVpgpBV4L
 hppDXXzO5f2XUwfZvfSyShtNfkEA5Ykm1y7SXDh8XkPPzN1SmEDasBvopiwy+NTy3J9Z
 QuJw==
X-Gm-Message-State: AOAM530iX/1ojey69jtvncWuNhelEuXbSuZ1w5qWpCAhGBwkaHwxLZ0a
 JbDbSh5H20lRq8LsYZ+BHrIUWFjK5AY=
X-Google-Smtp-Source: ABdhPJwBRqYXEfaFfCHT72+TNoyvJaSQKtY7dH4YiWOn+LH9KC4NDghoIGeM6s9KfRCkxpXO4KwzYQ==
X-Received: by 2002:a37:9d97:: with SMTP id g145mr448147qke.300.1611244899159; 
 Thu, 21 Jan 2021 08:01:39 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.228])
 by smtp.gmail.com with ESMTPSA id m2sm3033140qke.117.2021.01.21.08.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 08:01:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.11
Date: Thu, 21 Jan 2021 11:01:29 -0500
Message-Id: <20210121160129.3981-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Fixes for 5.11.

The following changes since commit c8f6364f35f32786dd40336cfa35b9166d91b8ab:

  Merge branch '04.00-ampere-lite-fixes' of git://github.com/skeggsb/linux into drm-fixes (2021-01-15 13:26:44 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-5.11-2021-01-21

for you to fetch changes up to 39263a2f886817a376fc27ba9af14c5053f0934b:

  drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3 (2021-01-21 10:46:05 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.11-2021-01-21:

amdgpu:
- Green Sardine fixes
- Vangogh fixes
- Renoir fixes
- Misc display fixes

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3

Aric Cyr (1):
      drm/amd/display: Allow PSTATE chnage when no displays are enabled

Bing Guo (1):
      drm/amd/display: Change function decide_dp_link_settings to avoid infinite looping

Huang Rui (1):
      drm/amdgpu: remove gpu info firmware of green sardine

Jake Wang (1):
      drm/amd/display: Update dram_clock_change_latency for DCN2.1

Jinzhou Su (1):
      drm/amdgpu: modify GCR_GENERAL_CNTL for Vangogh

Nicholas Kazlauskas (1):
      drm/amd/display: Use hardware sequencer functions for PG control

Prike Liang (1):
      drm/amdgpu/pm: no need GPU status set since mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL added in FSDL

Sung Lee (1):
      drm/amd/display: DCN2X Find Secondary Pipe properly in MPO + ODM Case

Vladimir Stempen (1):
      drm/amd/display: Fixed corruptions on HPDRX link loss restore

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            | 84 ++++++++++++++++------
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  7 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 18 +++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  9 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  7 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  2 +-
 10 files changed, 100 insertions(+), 40 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
