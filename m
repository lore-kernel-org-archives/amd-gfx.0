Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF80FC3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 19:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5464206E2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/z43g/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5464206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4246B6E39B;
	Thu,  5 Mar 2020 19:00:11 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7552E6E38A;
 Thu,  5 Mar 2020 19:00:09 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id p62so6402852qkb.0;
 Thu, 05 Mar 2020 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62xMGOF72+DyYnIfDQa4XtU/bMMRPJ9GeV109MbJnLg=;
 b=L/z43g/GZcPrGvdKwKcljasAuooDdv73yR4XywUQ33aaCiRk/OGdLFeCK3gP0KuJgh
 izbIo/7OWapyiiKg7zA0spil7hiUkLI2xOqBk8Ap+gLcJts9dhqEfHY4LOzIcm6UNo72
 eSUe3oHJurePTh5H2rj3pvggK02wPBG7TzJ7flgQCSii454sq3NNCn2GsGNzkD3WmDh0
 K3shakFaNbC/U/DNSB3/xU/3m+FHsB1adZwmd+eZ4da1zs1QUUBSlXu3vW/zgqc2jQCP
 TfnaCSlenc/mgmiMLeIA43iuE02kx+31Ik5b0N4o1tTC4K3xvVyfisvH8tJLFKPpyeoX
 MOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62xMGOF72+DyYnIfDQa4XtU/bMMRPJ9GeV109MbJnLg=;
 b=mYhjQ4KhO5wTHMqbOKIOlrq0XGsexS/t2/UbRTkynw/roUckzTEKDpNnop1LPm8rkd
 H2s8HefQOMFbQBfQyrs7kYOFpgVtu8AWwUsI2brcJ2DY+mFOh/Hy29BNZePLen8FKi9k
 8BpqMy1fFPjo0UtwRi+Abbn7CXGkSvCzH/ddEhbxo3gBXMR4JckH1JKXB7NNs4zT8ofF
 mtT3IA9qtIQNaP9Q1miZrmjSZ/qJdMwHLhBNFeALVIAqsvF0BwOjJRWCEDqNUoclYs1X
 6m3NCMIYJ/sP2bqfYZzzPFUqRVqqetNHo8/0b/pzcM/JY2TckP7T1lIITTUVqFhSQUI5
 4XEg==
X-Gm-Message-State: ANhLgQ1Mky3bmZt+Wx61E0mVlZfuPTKHALkx6Ui4X1GUWJ8PJLQZYYvA
 R4aHP2iTinIU7Ij8mhjVZM2Iy9Yf
X-Google-Smtp-Source: ADFU+vsd22mVb8QLW8pcae8sKV7+5keUfyCnGFyrQ+3HykE2gvErRbAdyQlscXCt7BWcEKodlSxV9g==
X-Received: by 2002:a05:620a:1345:: with SMTP id
 c5mr9422700qkl.182.1583434808299; 
 Thu, 05 Mar 2020 11:00:08 -0800 (PST)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id 137sm8007099qkf.40.2020.03.05.11.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 11:00:07 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu 5.6 fixes
Date: Thu,  5 Mar 2020 13:59:57 -0500
Message-Id: <20200305185957.4268-1-alexander.deucher@amd.com>
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

Hi Dave, Daniel,

Fixes for 5.6.

The following changes since commit 70b8ea1ab1d3ff3ad5c7491bf8995c912506da6c:

  Merge tag 'mediatek-drm-fixes-5.6' of https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes (2020-03-05 12:59:44 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.6-2020-03-05

for you to fetch changes up to 09ed6ba43e659474878b22d40b141a01d09ec857:

  drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3 (v2) (2020-03-05 09:42:08 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.6-2020-03-05:

amdgpu:
- Gfx reset fix for gfx9, 10
- Fix for gfx10
- DP MST fix
- DCC fix
- Renoir power fixes
- Navi power fix

----------------------------------------------------------------
Bhawanpreet Lakha (1):
      drm/amd/display: Clear link settings on MST disable connector

Hersen Wu (1):
      drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3 (v2)

Josip Pavic (1):
      drm/amd/display: fix dcc swath size calculations on dcn1

Prike Liang (2):
      drm/amd/powerplay: fix pre-check condition for setting clock range
      drm/amd/powerplay: map mclk to fclk for COMBINATIONAL_BYPASS case

Tianci.Yin (1):
      drm/amdgpu: disable 3D pipe 1 on Navi1x

Yintian Tao (1):
      drm/amdgpu: clean wptr on wb when gpu recovery

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 98 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 69 +++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |  4 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  2 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  6 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |  3 -
 8 files changed, 129 insertions(+), 55 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
