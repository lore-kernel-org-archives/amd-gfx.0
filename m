Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDBCCD6E6B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90DD112719;
	Thu,  4 Jun 2026 07:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="lsa2IJO8";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FD9112083
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1780501204;
 bh=ZKrR5aUhBaKbID3EWhhs18EUWgAXM/AzlaE4P5/gR78=;
 h=From:To:Cc:Subject:Date:From;
 b=lsa2IJO8SDcw7nN5cugAw87ZOnn3CSsS+lxOi+x2pwS1TsLPevGJ7tBU/CteaMO62
 eF72ZebqLApbYrl9xB/3o7w7PhThl+w4ec8O762/v3lUdwFTcan8ZRbWWKB+l98AEr
 dWpLWDHMuNtVh8c/hNL9MIz0frFcW7DGpDRf2s0c=
Received: from stargazer (unknown
 [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id 1B18765987;
 Wed,  3 Jun 2026 11:40:01 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to DC
Date: Wed,  3 Jun 2026 23:39:12 +0800
Message-ID: <20260603153920.249671-1-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:55 +0000
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

The change from my commit c97a7dccb3ed ("drm/amd/display/dml2: Guard
dml21_map_dc_state_into_dml_display_cfg with DC_FP_START") was dropped
in the commit e6a8a000cfe6 ("drm/amd/display: Rename dml2 to dml2_0
folder") for some reason I don't know, so on 6.19.y and 7.0.y the
original issue (9070XT fails to work on LoongArch) has regressed.

As I've mentioned in my commit message, it was only an incomplete and
temporary solution.  As the mainline already contains the move of FPU
guard which should ultimately resolve the issue, it seems better to
just backport the final fix instead of adding the temporary ad-hoc
change back.

Tested with 9070XT (where the original issue manifested) and 5500XT.

Changes since v1: rebase onto 7.0.11.

Ovidiu Bunea (1):
  drm/amd/display: Add min clock init for DML21 mode programming

Rafal Ostrowski (4):
  drm/amd/display: Move FPU Guards From DML To DC - Part 1
  drm/amd/display: Move FPU Guards From DML To DC - Part 2
  drm/amd/display: Move FPU Guards From DML To DC - Part 3
  drm/amd/display: Move dml2_destroy to non-FPU compilation unit

Srinivasan Shanmugam (1):
  drm/amd/display: Fix dc_is_fp_enabled name mismatch

Wayne Lin (1):
  drm/amd/display: Fix fpu guard warning

Xi Ruoyao (1):
  drm/amd/display: Backport dml21 DC_RUN_WITH_PREEMPTION_ENABLED
    addition from DC 3.2.373

 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |   25 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    |   17 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |    2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |    2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    5 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   75 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   15 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |    2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |    6 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |    6 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   72 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   25 +
 .../dml2_0/dml21/dml21_translation_helper.h   |    1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  391 +--
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |   30 -
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |  379 +++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.h       |   60 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   34 +-
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   19 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    4 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    7 +
 .../dc/resource/dcn31/dcn31_resource.c        |    7 +
 .../dc/resource/dcn315/dcn315_resource.c      |    7 +
 .../dc/resource/dcn316/dcn316_resource.c      |    7 +
 .../dc/resource/dcn35/dcn35_resource.c        |   10 +-
 .../dc/resource/dcn35/dcn35_resource.h        |    1 +
 .../dc/resource/dcn351/dcn351_resource.c      |   10 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   30 +-
 .../dc/resource/dcn42/dcn42_resource.c        | 2355 +++++++++++++++++
 31 files changed, 3076 insertions(+), 534 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c

-- 
2.54.0

