Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B9CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 02:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D82D10E009;
	Thu, 27 Oct 2022 02:11:43 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9EF10E5F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 00:26:47 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id z14so15712125wrn.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jMH6NbarRlIC2YyXd7lgXgFphUvn/dsCZiz0Rfu1Vkw=;
 b=CZU1bLheV1hEeTQ9KZ08EE75iVxKd/vYIPpAIBII0wz9pkPEAfqnnwaUP0YhdAOxEp
 efBFjeZS5yS/Eo43zYT9ocz4pgORfFNEhgbTDFDTn9rE/N1IWtiKiAhkiW5BdPMlFiSB
 iq3kWwvwgOb/sScvvx2XHOihror72shvw0uyCWxJ0/khyWAriuHwvx1quxcqVjSvl4yS
 5y+gcLqmn6KRoWhiRXfqKJe1hndhuKaQZ14Nal6JC2evQGc6UQbJbxfykfaNM8Ex0iuN
 TDotqJwiaD4VS4sPIiOpjEeH1DUv98d+bsLZ/tgwOif6HJcNtOQIVTn+nbGE3x2LxSsj
 M2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMH6NbarRlIC2YyXd7lgXgFphUvn/dsCZiz0Rfu1Vkw=;
 b=CS1r+zB/LQkeRZU28kj6p3RghN5prZOgOiP/6uc/ZUa6K0vOqq3bBdtfmdfFBzn+fL
 3eNrNu8i1yyfBABKmJPlqhiLVwQTvHHyWsg0pdBvYYVa4fmCmg8izdKwcS0gzHrjQgh/
 kJhNxl6h2Ffd5NQGqKNA0R2GHa3Uf+xloKJAh2JO5ox/2Hcd5jBr58cW9mwsoIQRfRTk
 UDK082n4sS6cnK1r54oEKEgez8Z6oLJizfLViJqEhaZylFhMmvvqPTYvPkU/OzGYCBM5
 cldV2iRUV9hsI9dIQZ59HQbIN9yuvtiyB5+GVcN12M5tyec5KhL3nVuAKCjh4Q8RrMLQ
 qQQQ==
X-Gm-Message-State: ACrzQf1v7RjO9mrlDj7/+4s5XhSczGlsaUtUIqOTJtRUQubHS2MVO8fY
 0/W9nJ4FM0qrxZDosTiIbVI=
X-Google-Smtp-Source: AMsMyM4w6WSLccvq7RJXCyU0YAb7qq6G5uD/sg/QjmGESZvpR92L4U01DLXoh7x/kXFKM7nI89qYwg==
X-Received: by 2002:a05:6000:1888:b0:236:8b32:cb47 with SMTP id
 a8-20020a056000188800b002368b32cb47mr3816241wri.601.1666830405816; 
 Wed, 26 Oct 2022 17:26:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b0022e66749437sm6519420wrx.93.2022.10.26.17.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 17:26:45 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH RESEND 0/1] drm/amd/display: add DCN support for ARM64
Date: Thu, 27 Oct 2022 02:25:28 +0200
Message-Id: <20221027002528.15983-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 02:11:40 +0000
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
Cc: Ao Zhong <hacc1225@gmail.com>, linux-arm-kernel@lists.infradead.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello everyone,

Recently I got a SBSA ARM64 workstation, and try to use it as my daily
drive machine after installing an AMD RX6400 graphics card.

Since the newer AMD GPUs require DCN (Display Core Next) support to work
properly, DCN is not supported on ARM64 platforms. Because some code in
DCN needs to use FPU, and aarch64 has no soft floating-point toolchain.

Displaycore developers have started isolating code that needs to use
FPU, and most of the code has been isolated. In the process of trying to
enable DCN support for the ARM64 platform, I found that there are two
remaining code blocks that are not isolated. Due to -mgeneral-regs-only
is enabled by default to compile the kernel on the ARM64 platform, these
two code blocks will cause the compilation to fail after enabling DCN
support.

I have submitted two patches to isolate the remaining two code blocks
that need to use the FPU.
Links: https://patchwork.freedesktop.org/patch/508813/
Links: https://patchwork.freedesktop.org/patch/508816/
After merging these two patches, we can enable DCN support for ARM64
platform.

I removed -mgeneral-regs-only CFLAG in the dml/Makefile for the code
that needs to use hardware FPU, and add a control mechanism in
amdgpu_dm/dc_fpu.c for ARM Neon.

Ao Zhong (1):
  drm/amd/display: add DCN support for ARM64

 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 64 ++++++++++++-------
 3 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.37.4

