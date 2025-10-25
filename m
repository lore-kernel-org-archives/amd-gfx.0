Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7586CCD1BF
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Oct 2025 01:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E18910E045;
	Sat, 25 Oct 2025 01:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GxZVus3A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF2310E045
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Oct 2025 01:01:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ED73544E3A;
 Sat, 25 Oct 2025 01:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26689C4CEF1;
 Sat, 25 Oct 2025 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761354069;
 bh=6ZiKsKmTo0RJCIul+IFqyu/pr8d2o5E09pcxoSIVdsA=;
 h=From:To:Cc:Subject:Date:From;
 b=GxZVus3A/TsCipntPKMMp14RJnawnKL0tJ+fXgLQB5eWOZkG8m6PiUrhdBNBxnCIp
 8aQZBNUDJWiJI1ic39+zqvm+yxiVEO+UtLEdr10+3TdZhxWuBYhXr7A457TY1i4/Lx
 vWtHeeD3CF3kY0gSsERydWMj4z364Y2u/KOjBYULGh54yPOjwnJhN1T38/vEr3+q+M
 kvhpIsmsX+0CZ60WeQYC1fSrEJgGfyMu00OnjWjrilR1ELAU6zIdNMmBPzOmkf/dNJ
 sFZPs7djOPT2BO/NAZyQJ/fChHSGnVpjwBinq8wdZ7+EHVbEWNeYXo2v95CT0Ll4g1
 HiT3oNjoYiQWw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2 0/2] Fixups for cancelled hibernate
Date: Fri, 24 Oct 2025 20:00:56 -0500
Message-ID: <20251025010058.2417352-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Muhammad Usama Anjun's recent series for being able to cancel
the hibernate sequence [1] exposes a bug with amdgpu handling for
skipping the thaw step.

Because the thaw step is skipped in most cases, cancelling the
hibernate means that the device is left in an inconsistent
state.

Add support to the PM core to let a driver track it's frozen
state when an error code is returned during thaw(). This will
ensure that the poweroff() and restore() callbacks get run.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>

I suggest this patch series merge through linux-pm.

v2:
 * pick up tag
 * rebase on linux-pm/bleeding-edge
 * fix lkp robot issue

Mario Limonciello (AMD) (2):
  PM: Allow device drivers to manage the frozen state of a device
  drm/amd: Manage frozen state internally

 Documentation/driver-api/pm/devices.rst    |  8 ++++++++
 drivers/base/power/main.c                  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 include/linux/pm.h                         |  3 +++
 5 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0

