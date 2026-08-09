Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05925C5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E1810E6D9;
	Mon, 10 Aug 2026 06:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LY/ZRSiG";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3531010E11F
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:17 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso578006a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286777; x=1786891577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sLtiiUZZXVNzDzJlTEnHgJIHbIC7FJbLG16BtntNSAU=;
 b=LY/ZRSiGl7HitrMYIRiGhdkS+bT2zY2Rc81hk2dS6cFM5uKPF+oLKzXldDmJ/L3xUc
 5wbrTn08WzTrfuSe1g015RSme4rTyvUBnxQpjixO+Eo5zqJKUmG4vFlv5ujXU2cY7Aub
 fddVEBunMGkwSQ2EABpoFL6nYblkoeZZWI13qRsJNCTq5MN2lFONoJa6PTEPtE7hCEmu
 i9mkCUGErTn731Z3oI6AOekj+SRVHlXELSPhG3M7kbyvnu1Ssj5/fQwwl5sIadlmw8Oc
 3hqvIwfVj5n/RTQpFF392tf1Rw/02t8xJqprwuOuvabtciHZ5UpGWvmOD4wNJWRQkNVc
 IXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286777; x=1786891577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLtiiUZZXVNzDzJlTEnHgJIHbIC7FJbLG16BtntNSAU=;
 b=Q1AywkYQnoHjWoDlxNUrJjjUbF2W3cqiBOpRIPLd9GbPT1iux8o83a9MW3j0XltMw3
 PBbkajjXiDJPZbDjAiTSoQH57QnmyIyFhcIoq0+UP2DJIZFH4IzvWf9tRofXTFYZ1Xc+
 bGy71qUue+zmvPZ+L3vREH1LNkYlHHEZ/zjV9oXqZ7989dTEgD0NRf4gHvybQItlWiS4
 XCVknVaKgiovJZD9F3O7zLyTUhO1ZXYiHrIogwi1gOu679c4OyA1ee0cX7hWwt3844rg
 E1Nw52HmX9bkP35F9tM4PXtpP8hamP1wKyqIHe1CZ3n9duWZ4a1f1VFqmXYF/9iSuk0m
 Ix0A==
X-Gm-Message-State: AOJu0YzOHKQiXrQqGpGw25h8/Y8N3IwIgMZrBBwcdP8rLW01mLjuDWMN
 3OpiestwwLokoFkVHYrHFcimbTQfpdSB2Cf766icWZZwbZZDXYgYw1gg
X-Gm-Gg: AR+sD13epNlqQnX2lByDr9zjXHVFbxejeAmkEoAfs2lrXT3gwdDGthoBeBCPamtYFIy
 2CzV29B6LgJm6Rftckm1e0cq8mBCQPb1GEZW6v98u5+XpmBQWc4LgkVhm0/zT968ianw+Zn5WLl
 ADCtcZODTpOfQ1gmx5l8Euq9jLm//Q1Gror4oAq72IcL3UDYew3E+vnXlzgEQ3RCB+J0HHukqeK
 Gy2nUFf1sYwBbxAdfcnGmpbBmHHi+BtDY1uMDeZrGvHoYr8tSQLfkaubd3fffFlS8DqCIfeIZNS
 bJLcxV0KJGnhacG9JMTe+9RsasDZWcK1pqy3mB9j8ehC3eqafnEeYKzN/5jDMTRx3fVb8m0PJs0
 UexaP6sjGf5dcIhbis6aRg6LIqsC1Didt8lKtUGv8ucmpOJkXjd0Spk37ypqw2vDbFwvq+INvOd
 RRNG67XwvGBXAzjUlxxLtb7uYfCWB+5YRJ1erYXMrnRvI/tbrl1ms73H6nMNnaYPy9vJ/9v8Gsv
 lN+mMuK78s=
X-Received: by 2002:a05:6a20:4309:b0:3c8:ead5:bf7b with SMTP id
 adf61e73a8af0-3cb85ded991mr39942065637.4.1786286776550; 
 Sun, 09 Aug 2026 07:46:16 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:16 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 0/4] drm/amdgpu: Robustness and safety fixes for ACA and
 RAS drivers
Date: Sun,  9 Aug 2026 14:44:47 +0000
Message-ID: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

This patch series addresses race conditions, boundary check bugs, logic
inversions, and teardown ordering in the AMDGPU ACA (Accelerated Compute
Architecture) and RAS driver subsystems.

v4 -> v5:
  - Dropped former Patch 4 (NULL check on banks parameter) and Patch 5
    (snprintf buffer size adjustment) from v5.
  - Patch 3: Dropped invalid kfree(handle) from remove_aca_handle()
    since ACA handles can be embedded in ras_manager. Removed non-existent
    mgr->lock references and retained list_del_init() prior to
    aca_fini_error_cache().
  - Patch 4 (formerly Patch 6): Retained the original work cancellation
    order in amdgpu_ras_fini() to prevent work re-queueing, while moving
    cancellation prior to mutex_destroy(&con->page_rsv_lock) in
    amdgpu_ras_recovery_fini().

v3 -> v4:
  - Patch 3: Moved node unlinking prior to aca_fini_error_cache().
  - Patch 4 (formerly Patch 6): Updated the subject and moved
    cancel_work_sync() and cancel_delayed_work_sync() prior to
    mutex_destroy(&con->page_rsv_lock) in amdgpu_ras_recovery_fini().

v2 -> v3:
  - Patch 3: Updated amdgpu_aca_get_error_data() to return 0 instead
    of -EOPNOTSUPP for invalid handles, allowing global RAS error
    queries to safely pass through non-ACA blocks.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init()
    instead of list_del(), ensuring list_empty() correctly evaluates
    removed handles.

Sreeraj S Kurup (4):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and list cleanup
  drm/amdgpu/ras: Fix delayed work cancellation order during teardown

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 34 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  7 +++--
 2 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.54.0

