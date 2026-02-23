Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9535FEA4FB9
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD0210E37F;
	Mon, 23 Feb 2026 12:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OvxhdQxc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4645410E37A;
 Mon, 23 Feb 2026 12:37:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EA1A40C31;
 Mon, 23 Feb 2026 12:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A1DC19424;
 Mon, 23 Feb 2026 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771850275;
 bh=1S7CCT5hTU6hbmGT9oij8/dhMm2j+yuXL+cRd3wT9rM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OvxhdQxctWJMLPapfGhhik1H2/hxXrNYl5hC2yZ+w6Jp49a7tKGMUakMzA4jK/YU/
 JwDlPpsfzllqmTsYKW81K94Uu2TJ61g1yf205+C719WjADh2UwFz6HUfTKx6aGRGO9
 4BWKr3v3Yd/KGrAiIJ9H1P18OPl1+8Ff2WomyfV+k13GJtpDiH4bdUhzsf6XS6Km+M
 lDxHlj7D8eF0InEHxUflhN1lUk/zJtEjiakakm4nES1CUYEweYQ2vQQ3FIw6kFmCDQ
 aj9b4vxc7ge1rBBXE/W16jFq2CHtMUPWYkGBeyduFYqHCEWxEId53GqeW5qUAARLW+
 ZrUgCRzwBsZrg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Gangliang Xie <ganglxie@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Kent Russell <kent.russell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] drm/amdgpu: return when ras table checksum
 is error
Date: Mon, 23 Feb 2026 07:37:15 -0500
Message-ID: <20260223123738.1532940-10-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
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

From: Gangliang Xie <ganglxie@amd.com>

[ Upstream commit 044f8d3b1fac6ac89c560f61415000e6bdab3a03 ]

end the function flow when ras table checksum is error

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a clear picture. Let me analyze this commit:

## Analysis

### What the commit does

The commit fixes a missing early return in `amdgpu_ras_eeprom_check()`
when the RAS EEPROM table checksum verification fails for the
`RAS_TABLE_HDR_VAL` case (valid header).

**The bug:** When `hdr->header == RAS_TABLE_HDR_VAL` and
`__verify_ras_table_checksum()` fails, the original code logs an error
but continues execution. This means the function proceeds to check if
bad pages exceed 90% of the threshold and eventually returns 0 (success
via `return res < 0 ? res : 0;`, since `__verify_ras_table_checksum`
returns positive for checksum mismatch). The caller then treats the
corrupt table as valid.

**The inconsistency:** In the other branch (`RAS_TABLE_HDR_BAD`), the
same checksum failure already results in `return -EINVAL` (line 1728).
The fix makes both code paths behave consistently - returning an error
on checksum failure.

### Why this matters

If the RAS table has a corrupt checksum and the function returns
success:
1. The caller `amdgpu_ras_load_bad_pages()` proceeds to use potentially
   corrupt bad page data
2. Corrupt bad page tracking could lead to incorrect GPU memory
   management decisions
3. Pages that should be retired (due to hardware errors) might not be,
   or vice versa, potentially leading to GPU errors, data corruption, or
   instability

### Stable criteria assessment

- **Fixes a real bug:** Yes - using corrupt EEPROM data when checksum
  fails is a genuine bug
- **Obviously correct:** Yes - the `RAS_TABLE_HDR_BAD` path already
  returns `-EINVAL` on checksum failure; this is making the
  `RAS_TABLE_HDR_VAL` path consistent
- **Small and contained:** Yes - adds `return -EINVAL` and wraps the
  existing `if` in braces, 4 lines changed
- **No new features:** Correct - purely a bug fix
- **Risk:** Very low - only affects the error path when checksum is
  already corrupt

### Verification

- Read the full `amdgpu_ras_eeprom_check()` function (lines 1670-1762)
  confirming the two parallel branches and the inconsistent handling
- Confirmed `__verify_ras_table_checksum()` returns positive for
  checksum mismatch, negative for I/O error (lines 1429-1437)
- Confirmed the return statement `return res < 0 ? res : 0` at line 1761
  means a positive `res` (checksum mismatch) would be returned as 0
  (success) - this is the core bug
- Confirmed the `RAS_TABLE_HDR_BAD` branch already returns `-EINVAL` on
  checksum failure (line 1728), confirming this is an oversight
- Confirmed the caller in `amdgpu_ras.c` uses the return value to decide
  whether to proceed with loading bad pages (`if (ret) goto out;`)
- The patch has been Reviewed-by two AMD engineers (Tao Zhou and Kent
  Russell)

The fix is small, surgical, obviously correct (matching the existing
pattern in the parallel code path), and prevents using corrupt EEPROM
data. It meets all stable kernel criteria.

**YES**

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 64dd7a81bff5f..710a8fe79fccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1701,10 +1701,12 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 		}
 
 		res = __verify_ras_table_checksum(control);
-		if (res)
+		if (res) {
 			dev_err(adev->dev,
 				"RAS table incorrect checksum or error:%d\n",
 				res);
+			return -EINVAL;
+		}
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
-- 
2.51.0

