Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B8EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 16:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16E910E487;
	Mon, 11 Apr 2022 16:43:41 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E799B10E487
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 16:43:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 32CA4616DA;
 Mon, 11 Apr 2022 16:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14499C385A4;
 Mon, 11 Apr 2022 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649695419;
 bh=tRPzFrKi58iaON1GV7j101ky0tw14bbNXKSh/h7xHs0=;
 h=From:To:Cc:Subject:Date:From;
 b=gMN5IJVTiOiTqtw3IXDtQ7okdkb5Cs4BL3aY6sqKhj5NIAHkhFgfKjRt5dk2W13Ob
 taJPv5icjPAgLUA/FajURaeTgI5wBWQQuKRuBzx21/UiT1idcpalVj9y6VSXOVQw1/
 6zv0GSY6UlbIdrkUnhmMMgSOotzJdT+qIXXp4Jh7xd3+Sj7hdMwypzdFba7H4IRLl8
 cz8MNMJnXTeHC1ovq4BKcEqqD4TFjs+5xMebSlidCl0W4z6vi3y4ggldvkgFJkQSVV
 3yUj+qLeNXnrdwA9BBHFblUqbjnzxcSNZzoNmegVZH68ncvI+GopZliH0kAwRXcm76
 NbTfN2TO5vLcA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 0/2] Fix two instances of -Wstrict-prototypes in drm/amd
Date: Mon, 11 Apr 2022 09:43:06 -0700
Message-Id: <20220411164308.2491139-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi everyone,

These two patches resolve two instances of -Wstrict-prototypes with
newer versions of clang that are present in 5.4. The main Makefile makes
this a hard error.

The first patch is upstream commit 63617d8b125e ("drm/amdkfd: add
missing void argument to function kgd2kfd_init"), which showed up in
5.5.

The second patch has no upstream equivalent, as the code in question was
removed in commit e392c887df97 ("drm/amdkfd: Use array to probe
kfd2kgd_calls") upstream, which is part of a larger series that did not
look reasonable for stable. I opted to just fix the warning in the same
manner as the prior patch, which is less risky and accomplishes the same
end result of no warning.

Colin Ian King (1):
  drm/amdkfd: add missing void argument to function kgd2kfd_init

Nathan Chancellor (1):
  drm/amdkfd: Fix -Wstrict-prototypes from
    amdgpu_amdkfd_gfx_10_0_get_functions()

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 2845ff3fd34499603249676495c524a35e795b45
-- 
2.35.1

