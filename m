Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D63C4828A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 09:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8EE1126CB;
	Mon, 29 Jan 2024 09:10:24 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE416112726
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 16:20:29 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4280f3ec702so5798631cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706458767; x=1707063567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DdPShsrtSjnJkieklYF0XOagkkrLbX3eYJLGUkn793s=;
 b=PGCE0NgpGoaBaZlWoqxu1dugkwHTkz5z2ub1rTqOUsDL0o40O1FmRHcDf9+tghnI5j
 z56SMz96huGC6w8WDoynwRXx8AVE8Q88YsospkuKVQL60tpzmSjR3dePbroSEds5t0f9
 y7bBF3AHr5WfbddPtxQItHvyuIwJcVdCNVtpztuvV/1Pbr0W/xbduVEDdFTc+RkhHHTu
 CIlK9T20v3O+vuYqaRdUXmB78tKtXpmfJYuLnok4V9m8H4KsulSFSEbkKZ6UVthWorrz
 FRG13OforRIXWM7GCy/9dw6Dp4QBGLxd5sVX9hAh+YXUa8ztU/0XghBcL5H9dvhevjr6
 pcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706458767; x=1707063567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdPShsrtSjnJkieklYF0XOagkkrLbX3eYJLGUkn793s=;
 b=oQptUF00Fmn8HA80zhOES2O1MfK0v1wu6EbklD8yPqeedIYnvUU35PtLo6Sps3HZ+1
 xAU3SLSIokfWW5bColnTBDnn22BdO1+J3N6+90VWcuz7SzY6WZwh6aC59ADjS16HHmU5
 KsxQHGnm62vLTbKeVaTyZ+AsHOgKW5Nw3MVhGiiFmChFnrZY0b/zgSGLd+lAqW5P3Y+U
 /LippGITo8ke9/DslieW1Muy/xLSJ0PJZF2kbvYFX+VMses0mac+yLTWG5kTTaHrJt1k
 GHkyMxOC2Stj3Jvp+DWLZdMrM7TQwiAMJrYArBPf6bg5d9UBLzZFJOaglAW0K/rPhj7a
 jsEQ==
X-Gm-Message-State: AOJu0YwfyYVIwJzUFZoIbJ27aG062uVxAVnMZcErVj8/GqiTKtdXW6R7
 PhBQ08HL2vU4GGwp9+5FE3u1FGim0Gr6HtQPSOaaSMj3tmT2jFM3btYv2E7N
X-Google-Smtp-Source: AGHT+IGHaTgJ9Ttm/Q5W5APm+Zvbvsrfd/1U1a0qmGhv7SDWxL7cGo39ipBZ2KcwVCUXV4jNuOUGWg==
X-Received: by 2002:a05:620a:1911:b0:783:944b:1253 with SMTP id
 bj17-20020a05620a191100b00783944b1253mr6128165qkb.5.1706458767519; 
 Sun, 28 Jan 2024 08:19:27 -0800 (PST)
Received: from davidm-laptop.home
 (hlfxns018gw-134-41-187-249.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [134.41.187.249]) by smtp.gmail.com with ESMTPSA id
 a23-20020a05620a067700b007838362da2dsm2336155qkh.111.2024.01.28.08.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 08:19:27 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] amdgpu: Fix crash when MEC2 firmware fails to load
Date: Sun, 28 Jan 2024 12:18:04 -0400
Message-Id: <20240128161803.1224103-1-corngood@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jan 2024 09:10:23 +0000
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
Cc: David McFarland <corngood@gmail.com>, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I only noticed this because my distro broke the mec2.bin symbolic link, so the
firmware failed to load.  This resulted in:

amdgpu 0000:0b:00.0: Direct firmware load for amdgpu/navi10_mec2.bin failed with error -2
BUG: kernel NULL pointer dereference, address: 0000000000000008
[...]
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x17d/0x4b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? exc_page_fault+0x72/0x160
 ? asm_exc_page_fault+0x26/0x30
 ? request_firmware+0x48/0x60 [firmware_class]
 ? amdgpu_gfx_cp_init_microcode+0x22e/0x260 [amdgpu]
 gfx_v10_0_early_init+0x722/0x8d0 [amdgpu]

The attached patch removes some code that looks like it was added by mistake, or
by a bad merge. With it I get still get the load failed error as expected, but
no crash. After fixing the firmware, no error is printed.


David McFarland (1):
  drm/amd: Don't init MEC2 firmware when it fails to load

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.40.1

