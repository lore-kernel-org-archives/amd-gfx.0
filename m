Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C4CC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0217F10E798;
	Wed,  5 Jun 2024 12:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dy+Dhs3n";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEAC10E796;
 Wed,  5 Jun 2024 12:04:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 67E12CE1764;
 Wed,  5 Jun 2024 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5B0C32781;
 Wed,  5 Jun 2024 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717589076;
 bh=mhF2FMNKnJzLhKnTFHQyPQ5Vg1uXY8LbYLMJ+EGQuNA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dy+Dhs3nnUWzMDjtYr53dzY9b3qtqladJB+cCDZS/v/CA2stXsid16hOruWk2c5ck
 urkXTiHQ06oMa5FCtuvnSCPsTy0oK7DxgoytcqcU+8xQH2gqTQra1n+QBWeNEQwNbE
 tfM+Ap+RDDM58GSZkMospq+5buP9kHTFSY0AP2C1MlfRgrE/PHNsTm/CQu6tkkuyp3
 Y33xBCNFaD61fHnLfYZKVxFnC360WHM7Y3mLIStLqbRH7TuLCMdmNOQCJZmWLsZDXp
 RAsKpG2V8Pf4vjr8AtvWay9DzDKj/sV/BIJZCMQjmUT6giDVe6P3iOjJvwUpXlCX7y
 5k1wD8NA3XJrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, Hawking.Zhang@amd.com, candice.li@amd.com, li.ma@amd.com,
 aurabindo.pillai@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/18] drm/amdgpu: silence UBSAN warning
Date: Wed,  5 Jun 2024 08:03:54 -0400
Message-ID: <20240605120409.2967044-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 05d9e24ddb15160164ba6e917a88c00907dc2434 ]

Convert a variable sized array from [1] to [].

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index fa7d6ced786f1..06be085515200 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3508,7 +3508,7 @@ struct atom_gpio_voltage_object_v4
    uint8_t  phase_delay_us;                      // phase delay in unit of micro second
    uint8_t  reserved;   
    uint32_t gpio_mask_val;                         // GPIO Mask value
-   struct atom_voltage_gpio_map_lut voltage_gpio_lut[1];
+   struct atom_voltage_gpio_map_lut voltage_gpio_lut[] __counted_by(gpio_entry_num);
 };
 
 struct  atom_svid2_voltage_object_v4
-- 
2.43.0

