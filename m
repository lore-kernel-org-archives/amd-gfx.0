Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36A3CD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871F610E355;
	Wed, 13 May 2026 20:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVG/qQmB";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4697F10E355
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:43:27 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4579531f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778705006; x=1779309806; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qYxXSxWqmWBWnzVr9vzRd64PfCqw5aQSFvOmZuFouD0=;
 b=FVG/qQmBMTMe5frdPc/yvlG8XbQuFSc3SRvhb3YEShyssnyKiKz1B2/kwi5up+wyBK
 aUa6y2PiMHH24imqPXP9CmAlFe6SDulVjt/eHoZ/tZlfD9W0qsk8gQs86Boh5RShIc4W
 qNKW/15W9I9o6rUdtKiDQjqgJjWyH/Md8Kqvf2Ta8KTjUnMMGD8B9J71bpGDyI35ISZS
 gI1ElX6PfZJX2ZiSApTpIwMPg/RPg679a7QwtTItesyNLBy3HEmB2RiaatS981+auZ92
 lsFUsd89KQbBCKOEQ4aoYemmI9AKjwDk09nv5XNusMEd4vBAfeFSHPH7KxRHCsfEIL5c
 lDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705006; x=1779309806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYxXSxWqmWBWnzVr9vzRd64PfCqw5aQSFvOmZuFouD0=;
 b=PW0ygThofJFUzMyAczQzmBeFGz/O40KqMowNmWuwb28suE5+7xgEffDdvOg7+h2mBh
 AXHn3qcBd1kfF7HByCFu5tE8Vv822RXnZak066bGDZtS81iaqgtPwYxcjsizkUxfL6FI
 t6/gD9HXUR1iy+HIxE/SJ9QS/Y5tgOd2/+8hPXajgWSHkQQUlrUrpe9Y7nhhR4M1CCcf
 KfMpXK5KplpyVyAZloPKfh+HaNCECjBztGpm0LJy95DtzHZpdVGdq0Jue9M2ToL2GhBO
 fjDf2ULho1GLKDLwwb+c7SmOAKql7tc2V9GRKZef9lJIjrjhbRVpNGLIQLNfB4kh1lgR
 NmIQ==
X-Gm-Message-State: AOJu0YzpgL+81Tz/vKstm8jdPpb723eKj0X6i7a+H8gwSLwc1rXDsNFU
 ulls8nwq8YltgO2C0JnySNBh8aJH1ErBdT4+Wm9CqpWo7EsQlrmphMbcgqXfEgtR
X-Gm-Gg: Acq92OG9bZfsCOaHbUafE3wmkC7Ttnpc6Y/hKpmvA5ngdmx/X7oBgOqIN5hQlLbIZSK
 +ksSvMvgxpIMTsmSml35TmJQb7RmVr0JkrpBd4ZQnRencVeOREzfOC30qXEHDgx9OyjjzYwdFQN
 zYQo/SLApDEtTKvnqa0nXI5Q//3vfGYrxXQKcGDhO4cwMhEa3tN+XlCAxwIrOsvdZ9ZbdwCeGgy
 DcJpqnNvmueVEEOD7mf+Wb/13pf2Ql5VASLA5CKiIvyYCLbpz7qCezc6xbDVm364o87fFqHZYuo
 Z96i1e65P+Lm0xuH0GaSn7MT5dLcF8qLZGzozm2zPoCyi4udnl8yog9vb3s+dOXn1RxsWHs+1bH
 /rHkSqEMHtPupfCDUuWKJHWK4ZUgtcucVhPnHRZfk6yX9sHluV8is9M3rUt2++l+dVOJWKDccf/
 D4e3cDlHFDltSt6srcrv/oSSEF0C6pMt+h+1acLfRJnbhyUq4MrIh5a6jW2RcDNuOy
X-Received: by 2002:a05:6000:2485:b0:452:65d:e108 with SMTP id
 ffacd0b85a97d-45c57de9d3dmr7904512f8f.3.1778705005691; 
 Wed, 13 May 2026 13:43:25 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm1308356f8f.21.2026.05.13.13.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:43:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu: Support DRM format modifiers on GFX6-8
Date: Wed, 13 May 2026 22:43:18 +0200
Message-ID: <20260513204322.73542-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

GFX6-8 are the oldest GPUs supported by the amdgpu
kernel driver, and the last ones that didn't support
DRM format modifiers until now.

On GFX6-8, the GFX block can only use pre-determined tiling
modes which are programmed by the kernel according to the
tiling mode table. The new modifiers encode all the details
needed for tiling on these GPUs.

For the exact details, see the commit message of:
"drm/fourcc: Add modifiers for AMD GFX6-8"

For a userspace implementation, see this Mesa mR:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41557

Supporting DRM format modifiers on GFX6-8 will
unblock many things in the Linux graphics ecosystem
that previously either didn't work on these GPUs
or had to implement fallbacks.
For example, compositors written in Vulkan or
compositors running on Zink, interop between
different APIs (eg. VAAPI / OpenGL / Vulkan) etc.

Timur Kristóf (4):
  drm/fourcc: Add modifiers for AMD GFX6-8
  drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
  drm/amd/display: Support DRM format modifiers on GFX6-8
  drm/amd/display: Don't use tiling flags anymore

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 111 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 346 +++++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   1 -
 include/uapi/drm/drm_fourcc.h                 | 207 ++++++++++-
 5 files changed, 601 insertions(+), 93 deletions(-)

-- 
2.54.0

