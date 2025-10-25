Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E54CCF9E9
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Oct 2025 16:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0AF10E2B3;
	Sat, 25 Oct 2025 16:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R1aEFZAw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066DF10E2B3
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Oct 2025 16:27:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 432F3601E8;
 Sat, 25 Oct 2025 16:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027DEC4CEFF;
 Sat, 25 Oct 2025 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409655;
 bh=5If4RKkdBtzkAl5b5AKRrIkgrNLj7g4EhyojiPv7HD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R1aEFZAwlpMAaWjwEcA7IzYGUUW7icAllZtPovQPugVOYbDA/6dQvcokq+R5oodLV
 ybMEH+goXmrsYmcQuBGgiHGJytwvtwxMSp0YFXwq5e5GfpoLGg+AFFgnixj+bGTpel
 ipz7psHSyVN6kLEXufkhzYB4HvYoxMHbN8eXdrG5uUNMHo5s+TLCaO0hSpqtQs2ROE
 rqddCljY4GT4x2bhZpcNyTl4ZmlAv6aodF1/iETWfyveMUxAD8nTxLr5mPrRp3mCwI
 UQmrNhm1ngDKxRz2O3+ZoiGubFGC3nTZMuMARbUb1nH5qc0aVLjYd7S7VlmsV8W4Jl
 v8oq2+2kfhvTA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Amber Lin <Amber.Lin@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17-5.4] drm/amdkfd: Tie UNMAP_LATENCY to
 queue_preemption
Date: Sat, 25 Oct 2025 12:00:39 -0400
Message-ID: <20251025160905.3857885-408-sashal@kernel.org>
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

From: Amber Lin <Amber.Lin@amd.com>

[ Upstream commit f3820e9d356132e18405cd7606e22dc87ccfa6d1 ]

When KFD asks CP to preempt queues, other than preempt CP queues, CP
also requests SDMA to preempt SDMA queues with UNMAP_LATENCY timeout.
Currently queue_preemption_timeout_ms is 9000 ms by default but can be
configured via module parameter. KFD_UNMAP_LATENCY_MS is hard coded as
4000 ms though. This patch ties KFD_UNMAP_LATENCY_MS to
queue_preemption_timeout_ms so in a slow system such as emulator, both
CP and SDMA slowness are taken into account.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changed
  - Replaces hard-coded `KFD_UNMAP_LATENCY_MS (4000)` with a value
    derived from the existing module parameter
    `queue_preemption_timeout_ms`: `((queue_preemption_timeout_ms -
    queue_preemption_timeout_ms / 10) >> 1)` in
    `drivers/gpu/drm/amd/amdkfd/kfd_priv.h:120`. This budgets ~45% of
    the total preemption timeout for each of the two SDMA engines,
    leaving ~10% for CP overhead, per the new comment in
    `drivers/gpu/drm/amd/amdkfd/kfd_priv.h:114`.
  - `queue_preemption_timeout_ms` is already a public module parameter
    with default 9000 ms in
    `drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:833`, documented at
    `drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:835`, and declared for KFD
    use at `drivers/gpu/drm/amd/amdkfd/kfd_priv.h:195`.

- Why it matters (bug and impact)
  - When KFD asks CP to preempt queues, CP also requests SDMA to preempt
    SDMA queues with an UNMAP latency. The driver waits for the CP fence
    using `queue_preemption_timeout_ms` (see
    `drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:2402`), but
    previously SDMA’s UNMAP latency was fixed at 4000 ms. This mismatch
    can cause spurious preemption timeouts on slow systems (e.g.,
    emulators) or when users tune the module parameter, leading to
    preempt failures and potential error paths like “The cp might be in
    an unrecoverable state due to an unsuccessful queues preemption.”
  - By tying `KFD_UNMAP_LATENCY_MS` to `queue_preemption_timeout_ms`,
    the SDMA preemption budget scales consistently with the CP fence
    wait, avoiding premature timeouts and improving reliability.

- Where the new value is used
  - Programmed into MES/PM4 packets (units of 100 ms):
    `packet->bitfields2.unmap_latency = KFD_UNMAP_LATENCY_MS / 100;` in
    `drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c:129` and
    `drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c:205`.
  - Passed as the timeout when destroying MQDs (preempt/unmap paths):
    calls to `mqd_mgr->destroy_mqd(..., KFD_UNMAP_LATENCY_MS, ...)` in
    `drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:884`,
    `drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:996`, and
    `drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:1175`.
  - Used for resetting hung queues via `hqd_reset(...,
    KFD_UNMAP_LATENCY_MS)` in
    `drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:2230`.

- Stable criteria assessment
  - Fixes a real-world reliability issue (timeouts/mismatched budgets)
    that affects users, especially on slow systems and when
    `queue_preemption_timeout_ms` is tuned.
  - Change is small, contained to a single macro in one header
    (`kfd_priv.h`) with clear rationale and no architectural
    refactoring.
  - Side effects are minimal: default behavior remains effectively
    unchanged (for 9000 ms, `KFD_UNMAP_LATENCY_MS` becomes ~4050 ms;
    when quantized to 100 ms units it still programs 40), while non-
    default configurations become consistent and safer.
  - Touches KFD/amdgpu preemption logic but only adjusts a timeout
    parameter already designed to be user-configurable; no new features
    introduced.

Given the above, this is a low-risk, correctness-improving timeout
alignment and a good candidate for backporting to stable.

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67694bcd94646..d01ef5ac07666 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -111,7 +111,14 @@
 
 #define KFD_KERNEL_QUEUE_SIZE 2048
 
-#define KFD_UNMAP_LATENCY_MS	(4000)
+/*  KFD_UNMAP_LATENCY_MS is the timeout CP waiting for SDMA preemption. One XCC
+ *  can be associated to 2 SDMA engines. queue_preemption_timeout_ms is the time
+ *  driver waiting for CP returning the UNMAP_QUEUE fence. Thus the math is
+ *  queue_preemption_timeout_ms = sdma_preemption_time * 2 + cp workload
+ *  The format here makes CP workload 10% of total timeout
+ */
+#define KFD_UNMAP_LATENCY_MS	\
+	((queue_preemption_timeout_ms - queue_preemption_timeout_ms / 10) >> 1)
 
 #define KFD_MAX_SDMA_QUEUES	128
 
-- 
2.51.0

