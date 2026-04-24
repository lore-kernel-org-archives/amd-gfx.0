Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6394FB44D1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C8810F3F1;
	Fri, 24 Apr 2026 08:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFwFd9te";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31951890BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 00:49:58 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso2770312c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776991797; x=1777596597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6kEj1wIg3L0vvI4zp06FIgoSHqbRAMXfy1o/X7ZFcc=;
 b=eFwFd9teSks97nrru8NaAMf5TXjXmBZbnliKR7fwlkvN4IX0GRRH9B5QyE5ekX7GHx
 tpn8tEIUpmSY5zFvJRmzy0q3xPgiRF9n6n0ir/SecyWXO06NuQYxzZm3uWQNXlJLTUK6
 jqqHTy+ljEXQwqjqLQuJV5BYFz62ZQXZgwlYYuueXAr8c6l5KXFCYxd8OusuFycLvEnL
 pPJfSbnlpt325V0elZW4Eu4zBQc/O8zURViJ+6u+CsofvNjXof2u8Z02euoCEIR1JmRV
 KDlvz3m68bB2LZioJTdfBGttzSRCO+54vuyRkfuPSpYqGWmMTXsSEivqPSKtK0GHn33T
 ht6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776991797; x=1777596597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6kEj1wIg3L0vvI4zp06FIgoSHqbRAMXfy1o/X7ZFcc=;
 b=N6uLJViWt8KWnTCsdYcU6twNjM5jfp7mgvZKKWhDhal1k/Bv8qVxYFDoHNPMTrMZY9
 ccCFvm5R+sclNOhzK6JoQWX/e5fDy4QK7UJ0MXRm3XRTpu+OC3nJkXFieC6McA4s+1Ol
 wmtlnlj1fEXtsWN+kRK5NP4pSLoTAsM8YiHZwZEWviYnMTSUgVzvyXZ1PXGb8FUxquQe
 gB6mGxbUuFOnXHZ0A83ygJGGBvp6wr8iihBnlFS0pGt8DXsRJEJtqry8Yf8KFsCg+Vla
 jE/P49wJCZcdJVHsC4W5a1G52aEcIrxgQKWG0GOclMCidK2EK3BCeiQqERMlWb1SpIrn
 md6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YyhPdXjEC0RbgEVhkEqX/0TcmyvF9oCzz3GiisEW1a4bIBcCH0TGK6jqxQuxTY7JCHM4qvf9w@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeKDYsuV40GTnBiVOV+fbIWSppIItg5kNF7HQtXMNYbhE5LCKh
 ebgbN8VNU3GU4MbBdilRDmJPVgavWw0UK0Kfjq8/MDSPF3hy7Zy/DfyZ
X-Gm-Gg: AeBDiesA3NkFXpyWQo8uIlfTVwY2uraeG+B5J0XiZsByPzIaQ5JdZU8JKVPVlpcL/lS
 9idTCT2cRInrHe5E4GXrS2t5WcrchvRqnG7l5DYPEvcyRfpvW7YvUZAnUisjPk/MGugMfK/EQNT
 lYcYOVr9+PsSW+/Hqtjdh6KrgLUHfIeTMOKMxDdysHJH+QfPZf/xmMdgfYV4K4F8y/nSg+gQyn/
 Y+Jqz4zx+4ePlckeRyWzgHBna2JKyaGLh6o044wx73eAiCzn/r6FqWb4Pyy9E7LPxkyVhhsdSX3
 MYJpXlV0wZsRmAMg8r6GxEyzlhLZvvb0mxwc5yx/iv/7tMINwItd0HNPMLRI5NNbXU+FLme9P9R
 k0hpSHCQj0Gas5X+n68VYMJPbEGAQVwGAysxcln8GqRd9l2cE09OjkkrjNfe94Dg0+4Jn5Luz26
 uS9w96CkdtSBA/BgjqS0hdnxtriMirolb3BCwWrw==
X-Received: by 2002:a05:7022:11c:b0:12b:ec67:3523 with SMTP id
 a92af1059eb24-12c73f726eamr15041738c88.9.1776991797381; 
 Thu, 23 Apr 2026 17:49:57 -0700 (PDT)
Received: from osabio.. ([2804:14c:498:1391:e297:f15e:34f:a801])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a185a8sm30930634c88.9.2026.04.23.17.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 17:49:56 -0700 (PDT)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabrielsousa230@gmail.com
Subject: [PATCH v3 2/2] drm/amdgpu: move read_indexed_register to
 amdgpu_reg_access
Date: Thu, 23 Apr 2026 21:49:10 -0300
Message-ID: <20260424004910.21003-2-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424004910.21003-1-gabrielsousa230@gmail.com>
References: <20260424004910.21003-1-gabrielsousa230@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 08:04:49 +0000
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

The read_indexed_register helper is duplicated across multiple files
with identical logic.

Move it to amdgpu_reg_access.c as
amdgpu_read_indexed_register and update all users accordingly.

No functional changes intended.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
v3:
- split into two patches as requested

v2:
- move read_indexed_register to amdgpu_reg_access.c
- drop amdgpu_common

 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 ++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 19 +----------------
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 19 +----------------
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 19 +----------------
 drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +-----------------
 7 files changed, 26 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 540040c76..daefbeeee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
 	}
 	return ret;
 }
+
+
+uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
+			       u32 se_num, u32 sh_num, u32 reg_offset)
+{
+	uint32_t val;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
+
+	val = RREG32(reg_offset);
+
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
+	mutex_unlock(&adev->grbm_idx_mutex);
+	return val;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 4d88e5cd1..a1011af6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
 				    uint32_t reg_addr, char reg_name[],
 				    uint32_t expected_value, uint32_t mask);
 
+uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
+					u32 se_num, u32 sh_num, u32 reg_offset);
+
 #endif /* __AMDGPU_REG_ACCESS_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 030d80664..72edf5326 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -354,29 +354,12 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
 };
 
-static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
-					 u32 sh_num, u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t nv_get_register_value(struct amdgpu_device *adev,
 				      bool indexed, u32 se_num,
 				      u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return nv_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 27bcbbae5..87b398dd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
 };
 
-static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
-					 u32 sh_num, u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
 					 bool indexed, u32 se_num,
 					 u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc15_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7e4353d0c..93c002e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
 };
 
-static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
-					 u32 sh_num, u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
 				      bool indexed, u32 se_num,
 				      u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc21_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
 			return adev->gfx.config.gb_addr_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d1adf19a5..265db9331 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
 };
 
-static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
-					    u32 se_num,
-					    u32 sh_num,
-					    u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
 					 bool indexed, u32 se_num,
 					 u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc24_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
 		    adev->gfx.config.gb_addr_config)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 709b1669b..4a5fe8e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
 };
 
-static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
-					       u32 se_num,
-					       u32 sh_num,
-					       u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
 
 static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
 					    bool indexed, u32 se_num,
 					    u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
 		    adev->gfx.config.gb_addr_config)
-- 
2.43.0

