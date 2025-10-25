Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC04DCCF9E3
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Oct 2025 16:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C3010E29B;
	Sat, 25 Oct 2025 16:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EDztWJa8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9EE10E29B
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Oct 2025 16:13:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B0E560538;
 Sat, 25 Oct 2025 16:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E478FC4CEF5;
 Sat, 25 Oct 2025 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761408824;
 bh=aOarMjKzUQnkvIX7CTnvCUPOs0e77ay2ln+V8n0cGYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EDztWJa8VYdXOBjL6Y8SCuKQ7q0bVAIs6NMiPZgepyBL5qotpDR+Tlzly6XZgzQ7F
 /381u7oGCvwkBDxZr+rKihWH2FMab7mlUYAP+YedJTONc2dq29X6C6TWArl3oHW5LC
 OwW43xR7FxDlrJRKbuPVCFqCDa74hlDkCx+IcPMJkTzkgWkgZczFBir1FxS6FFAPuy
 rIgdhHLyLR4l6yVm2AosRDrJ5LHzATtbUIQsVSIWn7Agt6f6YDs7L7RRkOBJAsdWdl
 OHN9zi/MGSxcxo3DPkvnm2DRMOSrqbkD5hBQgr7afDLdJYZqfkaBYz6EaafSLPxwjD
 X3iYclOIw5YGg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Francis <David.Francis@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17-6.1] drm/amdgpu: Allow kfd CRIU with no buffer
 objects
Date: Sat, 25 Oct 2025 11:55:18 -0400
Message-ID: <20251025160905.3857885-87-sashal@kernel.org>
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

From: David Francis <David.Francis@amd.com>

[ Upstream commit 85705b18ae7674347f8675f64b2b3115fb1d5629 ]

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes: Previously, the CRIU path rejected processes with no
  KFD buffer objects by requiring both a non-NULL `bos` pointer and a
  non-zero `num_bos`. The commit relaxes this so that a process with
  zero BOs is treated as a normal case instead of an error.

- Precise change: In `criu_restore`, the validation changes from
  rejecting zero BOs to only requiring `args->bos` when there actually
  are BOs:
  - New check only requires `bos` if `num_bos > 0`:
    `drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2568-2570`
    - `(args->num_bos > 0 && !args->bos) || !args->devices ||
      !args->priv_data || !args->priv_data_size || !args->num_devices`
  - This removes the old unconditional `!args->bos` and `!args->num_bos`
    rejection.

- Why it’s correct and safe:
  - Downstream restore code already handles zero BOs correctly:
    - Size checks scale with `num_bos`:
      `drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2439-2440`
    - Zero-length allocations are fine; `kvmalloc_array(args->num_bos,
      ...)` and `kvzalloc(...)` safely handle `num_bos == 0` and
      `kvfree` is safe:
      `drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2445-2453, 2463-2467,
      2495-2499`
    - `copy_from_user` and `copy_to_user` with size 0 are no-ops and
      safe even if `bos` is NULL:
      `drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2455-2461, 2487-2492`
    - The loop over BOs naturally skips when `num_bos == 0`:
      `drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2479-2485`
  - For `num_bos > 0`, the new check still requires a valid `bos`
    pointer, preserving existing behavior where needed.

- Scope and risk:
  - Small, localized input validation fix in KFD CRIU restore path only;
    no architectural changes.
  - No impact on other subsystems; error handling paths remain
    unchanged.
  - Regression risk is minimal because it only relaxes a reject
    condition for a valid scenario and downstream code already supports
    zero BOs.

- User impact:
  - Fixes spurious `-EINVAL` on CRIU operations for processes without
    KFD BOs, which is a normal scenario per the commit message.
  - Improves reliability of CRIU-based workflows for AMD GPU compute
    processes.

- Stable backport criteria:
  - Important bugfix affecting real users.
  - Minimal, contained change with low risk.
  - No new features or API changes; aligns behavior with existing code
    expectations.

Note: While the commit message mentions the checkpoint ioctl, this
change updates the restore validation
(`drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2568-2570`). It still
satisfies stable criteria by correcting CRIU handling for the no-BO case
on restore, with the downstream code already safely handling `num_bos ==
0`.

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 43115a3744694..8535a52a62cab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2571,8 +2571,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.51.0

