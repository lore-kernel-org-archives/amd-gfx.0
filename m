Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBD6CCD1BF
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Oct 2025 16:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935C610E31D;
	Sat, 25 Oct 2025 16:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S0DEjgAF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361CD10E31D
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Oct 2025 16:26:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D34341B01;
 Sat, 25 Oct 2025 16:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BDFC4CEF5;
 Sat, 25 Oct 2025 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409594;
 bh=5tystpVkEqNEZc4CfOrdY95xxGcSj38cBLknZ9Ya3xE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S0DEjgAFhBuiOR9Bl9Z5Brd+uC80vXCDMqE2k9HRjcqYecLYtTd/op+g+vj5gjGpi
 HhUNEyOOsOl51qfMXO6f1If/opPLxbnTrxoYSwHIT0VDt4S/7F8KWjyEGVqHBB+KrN
 e70EShRAE++RXqNyi7Qr3SjWvo0I0qV8kD+nNL2PBW1D88KJXSVZzW2KizGbPq8W90
 tC/erPL6GFsTA1goOJ4fFLJaF5JOzoENfmxp0W8MTajrQAlt/ArGyCCB19QVBrgS+s
 rrGixOcNJ1TTNkkeqTBIqR2YrwrAOHwk+NZcjb4oRP3xBankZopmVbwe3mDN07hYj3
 1m52PVBhJYusA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17-5.4] drm/amdkfd: return -ENOTTY for unsupported
 IOCTLs
Date: Sat, 25 Oct 2025 12:00:12 -0400
Message-ID: <20251025160905.3857885-381-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
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

From: Geoffrey McRae <geoffrey.mcrae@amd.com>

[ Upstream commit 57af162bfc8c05332a28c4d458d246cc46d2746d ]

Some kfd ioctls may not be available depending on the kernel version the
user is running, as such we need to report -ENOTTY so userland can
determine the cause of the ioctl failure.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changed
  - Unsupported amdkfd ioctls now return -ENOTTY instead of the previous
    default -EINVAL on two early error paths:
    - When `_IOC_NR(cmd)` is beyond the table: `nr >=
      AMDKFD_CORE_IOCTL_COUNT` now sets `retcode = -ENOTTY` before `goto
      err_i1` (drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:3256).
    - When the ioctl number is outside the defined KFD command range:
      the `else` branch after the `(nr >= AMDKFD_COMMAND_START) && (nr <
      AMDKFD_COMMAND_END)` check now sets `retcode = -ENOTTY` before
      `goto err_i1` (drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:3270).
  - Prior to this change, both paths fell through with `retcode`
    initialized to -EINVAL
    (drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:3253).

- Why it matters
  - KFD adds ioctls over time; user space built against newer headers
    may issue an ioctl unknown to an older kernel. Returning -ENOTTY is
    the canonical “inappropriate ioctl for device/unsupported ioctl”
    signal, allowing user space to distinguish “unsupported on this
    kernel” from “bad arguments to a supported ioctl” (which should be
    -EINVAL).
  - This aligns KFD’s error semantics with kernel ioctl conventions used
    elsewhere. For example, DRM core returns -ENOTTY for unsupported
    ioctl types (drivers/gpu/drm/drm_ioctl.c:782), and many drivers use
    -ENOTTY to indicate unsupported ioctls.

- Scope and risk
  - Change is small and tightly scoped to `kfd_ioctl` error handling for
    unsupported commands only
    (drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:3244).
  - No architectural changes, no new UAPI or features, and no functional
    change for supported ioctls.
  - Potential regression risk is low: only the errno for “unsupported
    ioctl” changes from -EINVAL to -ENOTTY. Well-behaved user space
    should treat -ENOTTY (not -EINVAL) as the indicator for an
    unsupported ioctl. This is correcting an API bug rather than
    changing intended behavior.
  - Security impact is nil; control flow and data handling are
    unchanged.

- Stable backport criteria
  - Fixes a real user-visible bug: ambiguous errno on unsupported ioctls
    made feature detection and fallback logic in userland unreliable.
  - Minimal, self-contained patch limited to amdkfd.
  - No side effects beyond improving errno correctness for unsupported
    ioctls.
  - Consistent with prior amdkfd errno cleanups (e.g., “Return proper
    error code for gws alloc API”) and general kernel ioctl practices.

Given these points, this is a good, low-risk candidate for stable
backport.

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e76..79ed3be63d0dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3252,8 +3252,10 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	int retcode = -EINVAL;
 	bool ptrace_attached = false;
 
-	if (nr >= AMDKFD_CORE_IOCTL_COUNT)
+	if (nr >= AMDKFD_CORE_IOCTL_COUNT) {
+		retcode = -ENOTTY;
 		goto err_i1;
+	}
 
 	if ((nr >= AMDKFD_COMMAND_START) && (nr < AMDKFD_COMMAND_END)) {
 		u32 amdkfd_size;
@@ -3266,8 +3268,10 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			asize = amdkfd_size;
 
 		cmd = ioctl->cmd;
-	} else
+	} else {
+		retcode = -ENOTTY;
 		goto err_i1;
+	}
 
 	dev_dbg(kfd_device, "ioctl cmd 0x%x (#0x%x), arg 0x%lx\n", cmd, nr, arg);
 
-- 
2.51.0

