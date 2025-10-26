Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5664CCF9EC
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 14:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3983610E2AC;
	Sun, 26 Oct 2025 14:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h/lCt9F+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5294210E2AC
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 14:51:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ADF860431;
 Sun, 26 Oct 2025 14:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE8CC116B1;
 Sun, 26 Oct 2025 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761490262;
 bh=9kEgSAYsSigKfGGF1IT/ZkYyori9kizJe2q3r8cLExU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h/lCt9F+0irZPkrJVBk6ZU84xcZwkqqzLuiPamYzOpTuKgndSnsMaIQ/Va765AwDJ
 XGCQ5h4XCCPr9/mh0DY5dIK+EU1OkviDOHba6UkMyh+9qN0o8F8q3Cy0qstm9ickrx
 v3PZZJrqTQc4iXXjMPX+KUPgYAWiD1V86ullGce+6RgleoefPLCuZqgDsufzAHeSgl
 0T07BswjVePWgvb054D6WcvNnItrC+CpaV/wcOwqUWQkmCgl9LGM9ackNhFZ5nAj1k
 U6cViGlnmYSb01d1QrIlSGrbrx8g9y1aKo0X/+ufYvkpNmLrTE65WEhLppzuYwc9wi
 e8C1o9UUxZL1Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17-6.12] drm/amdkfd: Fix mmap write lock not release
Date: Sun, 26 Oct 2025 10:49:07 -0400
Message-ID: <20251026144958.26750-29-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026144958.26750-1-sashal@kernel.org>
References: <20251026144958.26750-1-sashal@kernel.org>
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 7574f30337e19045f03126b4c51f525b84e5049e ]

If mmap write lock is taken while draining retry fault, mmap write lock
is not released because svm_range_restore_pages calls mmap_read_unlock
then returns. This causes deadlock and system hangs later because mmap
read or write lock cannot be taken.

Downgrade mmap write lock to read lock if draining retry fault fix this
bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `svm_range_restore_pages()` can upgrade to a `mmap_write_lock()` when
  it must recreate a missing SVM range; if the retry-fault path is hit
  before the range is rebuilt we return `-EAGAIN` while still holding
  the write lock, so the later `mmap_read_unlock()` never releases it,
  leaving the mm’s mmap_lock stuck and hanging future faults
  (`drivers/gpu/drm/amd/amdkfd/kfd_svm.c:3022-3029`).
- The fix simply downgrades the lock back to read mode before that early
  return (`drivers/gpu/drm/amd/amdkfd/kfd_svm.c:3026-3027`), matching
  the existing teardown path already used when range creation fails
  (`drivers/gpu/drm/amd/amdkfd/kfd_svm.c:3053-3063`). This ensures the
  subsequent `mmap_read_unlock()` actually drops the lock.
- The regression was introduced by commit f844732e3ad9 (“drm/amdgpu: Fix
  the race condition for draining retry fault”), which is already in
  v6.15 and newer tags, so affected stable trees will deadlock under
  retry-fault draining unless they get this fix.
- Change is tiny, self-contained, and follows existing locking
  conventions; no new APIs or behavioral changes beyond correcting the
  lock lifecycle, so regression risk is low while preventing a user-
  visible hang in the GPU fault handler
  (`drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2896-2920`).

Possible next steps:
1. Queue 8cf4d56246c236935fc87384b2e2e32d12f57b91 for all stable
   branches that contain f844732e3ad9.
2. Run KFD retry-fault stress tests (e.g., `kfdtest --stress`) on an
   affected GPU to confirm the hang no longer occurs.

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3d8b20828c068..6fa08f12cb429 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3023,6 +3023,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (svms->checkpoint_ts[gpuidx] != 0) {
 		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			if (write_locked)
+				mmap_write_downgrade(mm);
 			r = -EAGAIN;
 			goto out_unlock_svms;
 		} else {
-- 
2.51.0

