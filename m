Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25F9C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 09:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EBB10E24C;
	Fri, 25 Nov 2022 09:25:41 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563DC10E0E8;
 Fri, 25 Nov 2022 09:25:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 68E69622D2;
 Fri, 25 Nov 2022 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED728C433C1;
 Fri, 25 Nov 2022 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669368331;
 bh=B62OES+YOnQQ6Yv0WIo/pUftJIfqLaBkNFM1pIRlO/0=;
 h=From:To:Cc:Subject:Date:From;
 b=XWjsOO2B24TFK3PAfHzTJAs2eADRomRdpdE/iy3C4mmB1/IPSisPHbwGOqWsFTIP3
 JQ10+8Ol7NVzD28vqtJ5z3R+3+Ui3pdtZGLLO6reKQSNrlu5XrncUcY/JGMc+woWyR
 bchexoyydsUGV3BzbUJekFeQWZjEz4Bs34tX8VPtlYV/ydLQphj1rvm6ECg7blsRUQ
 DoZvph2NgB5viQoshO3DaJ+73Xw2uS/k4WFMj9/68G/qM/3EH/PnCgxHwxcFtYzEKC
 Hq2QctAxMnQWsyUP1BAa6m9jN3PUuuYQB3JpAL23wPEN46m2R3RS3zzGojYtsZLQxu
 HkpA3ZRN+IC8A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
 nathan@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 ndesaulniers@google.com, trix@redhat.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
Subject: [PATCH 0/3] Fix a bunch of allmodconfig errors
Date: Fri, 25 Nov 2022 09:25:14 +0000
Message-Id: <20221125092517.3074989-1-lee@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since b339ec9c229aa ("kbuild: Only default to -Werror if COMPILE_TEST") WERROR
now defaults to COMPILE_TEST meaning that it's enabled for allmodconfig
builds.  This leads to some interesting failures, each resolved in this set.

With this set applied, I am able to obtain a successful allmodconfig Arm build.

Lee Jones (3):
  drm/amd/display/dc/calcs/dce_calcs: Break-out a stack-heavy chunk of
    code
  drm/amdgpu: Temporarily disable broken Clang builds due to blown
    stack-frame
  Kconfig.debug: Provide a little extra FRAME_WARN leeway when KASAN is
    enabled

 drivers/gpu/drm/Kconfig                       |   7 +
 .../drm/amd/display/dc/dml/calcs/dce_calcs.c  | 483 +++++++++---------
 lib/Kconfig.debug                             |   1 +
 3 files changed, 253 insertions(+), 238 deletions(-)


-- 
2.38.1.584.g0f3c55d4c2-goog

