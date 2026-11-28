Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9332606A31C
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Nov 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8wF0dD+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C5D10E1CE;
	Sat, 28 Nov 2026 16:26:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5B710E11C;
 Sat, 28 Nov 2026 16:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3CC4600B9;
 Sat, 28 Nov 2026 16:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A101F00893;
 Sat, 28 Nov 2026 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795883170;
 bh=0Ic80AEaRx36IaB+hMrIQN80NyUsmhjyvx3E1suBk1g=;
 h=From:Date:Subject:To:Cc;
 b=S8wF0dD+DCNopucU0gLQ0JpZZVzjFaCn7IJf3Rux+O4FovmcAVov4P5t/nrN07NSZ
 v23I7ioNRbCbKTHnuJxvw1LHQo9ZcGQagLtYCZ2GCHmSOBTGqHEiUKsu01sa9+virt
 QZDfLztl9/epcOOBzSEj4JaL14e8D2vxcIvoZsQOpeAO9xI3jeALVrO38YiHnVGWfx
 3e7fEVoVY4gAmpR6tNgizYHto3Jex4bE5f2xCCQkCanwVrS50sH+EtgJWHVtl5pFd8
 bIX1FAzxk5aRQ6GSCq6JudOJ3AqQx08O4Aeks1HMJ0FTxZ7V/JhtbwXGm1wkYdCrxh
 SKfn/w7mJChdA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 28 Nov 2026 09:25:57 -0700
Subject: [PATCH] drm/amdgpu: Initialize data to NULL in
 imu_v13_0_program_rlc_ram()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-amdgpu-uninitialized-data-imu_v13_0-v1-1-e2c0ddb75ee7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXNTQ6CMBBA4auQWTsJrdJYr2IIKcyAY6SS/hAj4
 e5WXX6b9zaIHIQjXKoNAq8S5ekL1KGC4eb8xChUDLrWRil9RjfTtGTMXrwkcQ95MyG55FDm3K3
 q2NVoG9Pb02gaSwSltAQe5fW7XNu/Y+7vPKRvGvb9A0sbSqKHAAAA
X-Change-ID: 20261128-amdgpu-uninitialized-data-imu_v13_0-956b94f659dd
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>, 
 Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gBmpC7sVg3kQTwjqKfmrRg3ricTg1VnhwUHCCU43UDk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDNncDHOMq2PmfbxjXjyzQ4YtvTRLwcnDLO77FOsrFuev7
 ordHre6o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzElY3hn52h3nHe8wIzoxKi
 Tp63//GZ3TozuTrSOtbGhO+8lt6FtYwMLxSb2LoPeD9M2XjgqTLjnbJJbq0twa+br53U/vmh6+1
 ZBgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang warns (or errors with CONFIG_WERROR=y / W=e):

  drivers/gpu/drm/amd/amdgpu/imu_v13_0.c:264:30: error: variable 'data' is uninitialized when used here [-Werror,-Wuninitialized]
    264 |                         program_imu_rlc_ram(adev, data, (const u32)size);
        |                                                   ^~~~

It is not wrong that data is passed to program_imu_rlc_ram()
uninitialized but since this warning happens early in clang's frontend,
it cannot see program_imu_rlc_ram() is meber called due to r being
-EINVAL and even if it were, data would not be dereferenced because size
is 0, so it is never actually used uninitialized.

It is bad form to pass uninitialized values to functions even if they
are not used, so just initialize data to NULL to silence the warning, as
it will need to be properly set up when support for calling
program_imu_rlc_ram() is added.

Fixes: 9caddf5f7de7 ("drm/amdgpu: Add imu v13 ip block v2")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
index aea418be444a..eb18c7d3e120 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
@@ -253,7 +253,7 @@ static void program_imu_rlc_ram(struct amdgpu_device *adev,
 static void imu_v13_0_program_rlc_ram(struct amdgpu_device *adev)
 {
 	u32 reg_data, size = 0;
-	const u32 *data;
+	const u32 *data = NULL;
 	int r = -EINVAL;
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);

---
base-commit: fc652f23f1c3c727e561ca66bafd58000208e3a9
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261128-amdgpu-uninitialized-data-imu_v13_0-956b94f659dd

Best regards,
--  
Cheers,
Nathan

