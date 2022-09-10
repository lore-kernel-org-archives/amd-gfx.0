Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9AEC6FA82
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Sep 2022 21:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE1C10E2CC;
	Sat, 10 Sep 2022 21:17:20 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB7910E080;
 Sat, 10 Sep 2022 21:17:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 55FC360EB6;
 Sat, 10 Sep 2022 21:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465B1C433D6;
 Sat, 10 Sep 2022 21:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662844634;
 bh=vz5fOPB/0yc8mAdng/GhOFDcONd3/2mlwH7O9Qh8JFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZvKGYswPHe9xiZ/tsC6LIc+3HFqmVyW1IG8Gy6ni946eFQcze3pPloA8F8JfwEO3z
 p4l+iHXT/HqmXEeJm3pIXw8wfb9nbHxaSwDbUWjelLH4GwBLUNObFegFDtg8T/+b0t
 7lesb1OyZEY1dlFwq5afgesC79GFAemFsH8m9MBLd/kUvC4bEa1qVYmRCh+f/cNvtX
 rEjjfLanR4X1OQNXCuPghKMJIRrb3kO0uAZ9Qatytq0hCuGKo5XNAfDGqFYE2OVmm8
 +6QrGaGPKqTPe9U21lvET65bv3VR3XGj1P2LzlpLndXtV3k+ckVPpZQiEj8UDbiOdG
 R7wZdeys+Q+vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 24/38] drm/amdgpu: disable FRU access on special
 SIENNA CICHLID card
Date: Sat, 10 Sep 2022 17:16:09 -0400
Message-Id: <20220910211623.69825-24-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910211623.69825-1-sashal@kernel.org>
References: <20220910211623.69825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Guchun Chen <guchun.chen@amd.com>,
 airlied@linux.ie, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 Harish.Kasiviswanathan@amd.com, amd-gfx@lists.freedesktop.org,
 luben.tuikov@amd.com, Kent Russell <kent.russell@amd.com>, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 shaoyun.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit c8fea9273fd1be308668496badfcbd55183e0dd3 ]

Below driver load error will be printed, not friendly to end user.

amdgpu: ATOM BIOS: 113-D603GLXE-077
[drm] FRU: Failed to get size field
[drm:amdgpu_fru_get_product_info [amdgpu]] *ERROR* Failed to read FRU Manufacturer, ret:-5

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index ecada5eadfe35..e325150879df7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -66,10 +66,15 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 		return true;
 	case CHIP_SIENNA_CICHLID:
 		if (strnstr(atom_ctx->vbios_version, "D603",
+		    sizeof(atom_ctx->vbios_version))) {
+			if (strnstr(atom_ctx->vbios_version, "D603GLXE",
 			    sizeof(atom_ctx->vbios_version)))
-			return true;
-		else
+				return false;
+			else
+				return true;
+		} else {
 			return false;
+		}
 	default:
 		return false;
 	}
-- 
2.35.1

