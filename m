Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE941CAC5B3
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 11:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673D610E709;
	Wed, 24 Sep 2025 11:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hk3KUlcz";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC0810E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 11:38:47 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-77e6495c999so5253005b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758713927; x=1759318727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4rS7SFbGhDevM8tkC93xM0kejF9WpESgGrjW5TvxBU=;
 b=Hk3KUlczDvWYmdHjI9mAcbK3vhwBpLjfoeRpHjstScqGRPzEYuY5S3MQmeT7oS/l8+
 b8hgWBipi1Ibp/r4I1KWBJEGLiExO7XLO6iSa0JLhzmw71Mk8Qcf23pFgXtbApd+7Bb/
 V+mtPrvS01E894bfYJiEqfmqrFPT84Kh1clBV17Y1PPv3VmqSuQaiddH19QeijKfjB5F
 ldPAbhu3Y3OeppgtP5FcD61gsk4bQSd096l+yL+75rvUszJ5zUogB9z1m+pbKnxytjea
 ecmjuv/gySTuGSwwCepLzubgUf2F/xLmmt9bmduZNRTnE9FFu/w1fg4L6SRxHAK6xZkt
 KlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713927; x=1759318727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4rS7SFbGhDevM8tkC93xM0kejF9WpESgGrjW5TvxBU=;
 b=mEcRCeSDwMHpeQ27EcGEqSdaBtwlZMa2nHnDLT3JB+HqRJOYDa+wwmD7JWDCTYkd5y
 SR0HXqyuP6JLqJoK/lYof11hWZeOKloxJnApDp35vwn7sIdiF048HIA0OTPofmWSLWib
 M0C6r4aw1PEguRWn0tVd3iEmyCKmzuKEMaP2ozuK/eIT+qE4YBoLwsz4tNt/9FU+t6Vh
 dvqURwyCfynLfFlcFYFHsphu75TC2IxvWum0ZWIm2Ou3uoO5iRcHovRquexyAeG43xFz
 HWCtgGL7EI5bdvSKFGnvaFGnrsHho4oiLxVgz+21F4T924Ju8IilbLU04TlupCfjPphz
 gzyA==
X-Gm-Message-State: AOJu0YyPd1H8LdX5NxGEPxpJ1LDdSW5rlz1TWUx2xKJZssZjqRoOXdZ/
 +yw03YqLu5CTx0ZBl8QsOei3HcV7VI7A9E39j78KElPFNY8bxehcO5cpuwSvJLdI
X-Gm-Gg: ASbGnctUgVN8eFHiVfe7oieW5oMOy63f6cM2hQ7lnbOrod3KAA7bUPzrtMssA0MNLMe
 6zGXFTZYJ+4HPNUT1bVuWnliqBoR+gg/1zKF/g/e37L1TNOWVB6xdicRC6Xlf75iJuTyq4Ial+A
 2KZCHMrb/AV07tkVEbzNbmM8+AYdczK7wO5+E70hSzDXm+O5lSzO/j+I9AL3fOHR6LWIJEX4Gt8
 /CE2g3yOd/88m5724LuUsyokxzIsjmjJ9hqPyqfq6QIGoK+aG7Aq0y4z5CcyHVysrBFBu8T7H2J
 WjOHPsoEhxes7hDVgpygc0E1pvDW49PPbviQdKMw/lpILZVtV6hiCIEzaxnkBvaoyern6fgc7L4
 /uOKYD+TwSHQG5ZkWQLP+XaRQmV4gr6EKu5ecSZIbWoPn4TRXiYicNwM6+oiFbuLoZ44tq34meN
 gaDzIRzFlW24EwAfK3waxsF5WnHwKEF1BOOFPYD75D0QSD
X-Google-Smtp-Source: AGHT+IHnIFNkhVEy6PYdHZAtmjJMmi1Ky/CmY8ywqxDt5YkTHoraXailvqPGzZxW5dcfYJw5ssmSlA==
X-Received: by 2002:a17:90b:4f43:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-332a951c1c4mr7721593a91.12.1758713927237; 
 Wed, 24 Sep 2025 04:38:47 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be38382sm2142548a91.25.2025.09.24.04.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:38:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] DC: Reject too high pixel clocks on DCE6-10
Date: Wed, 24 Sep 2025 13:38:33 +0200
Message-ID: <20250924113836.57013-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Reject modes with a pixel clock higher than the maximum display
clock. These were never supported, but we haven't noticed the
issue until the YCbCr 422 fallback was recently added.

For example, the DP 1.2 standard technically supports
4K 120Hz YCbCr 422 6 bpc, but in practice the pixel clock is
too high on these old GPUs.

Additionally, there are two small code cleanup patches to avoid
excessive code duplication.

Timur Kristóf (3):
  drm/amd/display: Reject modes with too high pixel clock on DCE6-10
  drm/amd/display: Share dce100_validate_bandwidth with DCE6-8
  drm/amd/display: Share dce100_validate_global with DCE6-8

 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  3 +
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  |  5 ++
 .../dc/resource/dce100/dce100_resource.c      | 25 +++++--
 .../dc/resource/dce100/dce100_resource.h      |  9 +++
 .../dc/resource/dce60/dce60_resource.c        | 69 +------------------
 .../dc/resource/dce80/dce80_resource.c        | 60 +---------------
 6 files changed, 44 insertions(+), 127 deletions(-)

-- 
2.51.0

