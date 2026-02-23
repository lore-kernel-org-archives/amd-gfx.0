Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E86DEA4FAE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8D310E269;
	Mon, 23 Feb 2026 12:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rxX85ZsB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7B810E269;
 Mon, 23 Feb 2026 12:37:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BA93C407E3;
 Mon, 23 Feb 2026 12:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B650C19424;
 Mon, 23 Feb 2026 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771850261;
 bh=6yEJzJGwIc7WthA0Os7u9sP1677ojVa4inC0ZmHF8hc=;
 h=From:To:Cc:Subject:Date:From;
 b=rxX85ZsBqjadtifvESDhlaU9SIZ3K5AVVBaf/0KYMPcyRp9XAQG0UG/opzzWYNAVl
 DruHVLTQwY6hOo7wK2bS5XNUxDcnnt62ID9quq7573ukex+rq7mp5V2W4RBLqG/reM
 tIMnN2huWrwL7AFOt0kkYeJTSf2+P/q8yWGA2j6o1TOscabYaY12+q1LMrshaH5zwU
 Q01xiPUX22kR9rQMKl8kD5pIQnugHUvxPnz3SHwZFPrL3HoYDrXHFdy5cJxNM5HRd1
 twbWbNKbbmrvucOVji+5JQcDkYm11PE+y0vE91LSkHBGeCRbs59GcrLoDAuO4SxfxB
 4hkQ3UJbA5cbA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ray Wu <ray.wu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] drm/amd/display: Remove conditional for
 shaper 3DLUT power-on
Date: Mon, 23 Feb 2026 07:37:06 -0500
Message-ID: <20260223123738.1532940-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 1b38a87b8f8020e8ef4563e7752a64182b5a39b9 ]

[Why]
Shaper programming has high chance to fail on first time after
power-on or reboot. This can be verified by running IGT's kms_colorop.

[How]
Always power on the shaper and 3DLUT before programming by
removing the debug flag of low power mode.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good. This confirms the key observation: `mpc32_program_3dlut()` at line
927 **already calls `mpc32_power_on_shaper_3dlut()` unconditionally**
for power-on. The fix makes `mpc32_program_shaper()` consistent with
this pattern.

## Analysis

### 1. What the commit fixes

The commit fixes a real hardware programming bug in AMD DCN 3.2 display
hardware (RDNA3 GPUs). The shaper LUT programming
(`mpc32_program_shaper()`) was conditionally gating the power-on of the
shaper/3DLUT memory behind a debug flag
(`enable_mem_low_power.bits.mpc`). When this flag is not set, the
hardware memory is never powered on before programming, causing shaper
programming to fail on first boot or reboot.

### 2. The bug mechanism

Looking at `mpc32_power_on_shaper_3dlut()` (lines 682-709):
- Line 692-693: It **always** writes to `MPCC_MCM_MEM_PWR_CTRL` to
  enable/disable power — this is the actual power control
- Lines 695-698: The debug flag only controls whether to **wait** for
  the power state to settle

The caller `mpc32_program_shaper()` was incorrectly checking the debug
flag before even calling the function, meaning the power control
register was never written when the flag was off. Without powering on
the memory, the subsequent LUT programming writes fail silently.

### 3. Consistency evidence

`mpc32_program_3dlut()` (line 927) already calls
`mpc32_power_on_shaper_3dlut()` unconditionally for power-on. The
conditional only guards the power-**down** (line 987-988). The fix makes
`mpc32_program_shaper()` follow the same correct pattern.

### 4. Stable criteria assessment

- **Fixes a real bug**: Yes — shaper programming fails on first
  boot/reboot, causing incorrect color management
- **Obviously correct**: Yes — makes the shaper function consistent with
  the 3DLUT function's already-correct unconditional power-on
- **Small and contained**: Yes — a single line change (removing one `if`
  condition)
- **No new features**: Correct — just ensures hardware is powered before
  programming
- **Tested**: Yes — `Tested-by: Daniel Wheeler`, verified with IGT
  kms_colorop test, `Reviewed-by: Aurabindo Pillai`
- **Risk**: Very low — the function call always writes the power
  register; removing the guard just ensures it's always called

### 5. User impact

This affects all AMD RDNA3 GPU users (RX 7000 series) who use color
management features (shaper/3DLUT). Failure to program the shaper LUT
means incorrect display color output. This is a functional correctness
issue, not just cosmetic.

### Verification

- Read `mpc32_power_on_shaper_3dlut()` (lines 682-709): Confirmed it
  always writes power register at line 692-693 regardless of debug flag;
  debug flag only controls wait at lines 695-698
- Read `mpc32_program_shaper()` (lines 712-751): Confirmed the buggy
  conditional at line 727 gates the entire power-on call
- Read `mpc32_program_3dlut()` (lines 908-991): Confirmed unconditional
  power-on at line 927, proving the fix makes the pattern consistent
- git log confirmed the file exists in the current tree with DCN32
  support present
- Commit has Reviewed-by and Tested-by tags from AMD engineers

**YES**

 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index 83bbbf34bcac7..badcef027b846 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -724,8 +724,7 @@ bool mpc32_program_shaper(
 		return false;
 	}
 
-	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
-		mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
+	mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
 
 	current_mode = mpc32_get_shaper_current(mpc, mpcc_id);
 
-- 
2.51.0

