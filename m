Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B04C4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 12:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2414D10E541;
	Wed, 23 Nov 2022 12:43:23 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9689D10E3F8;
 Wed, 23 Nov 2022 12:43:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 12CB161C55;
 Wed, 23 Nov 2022 12:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2490C433C1;
 Wed, 23 Nov 2022 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669207397;
 bh=be7RItbymvFf9t9+XrPeDGdWk6wnSf3Lociabth5Pj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WjxkFtMaCqxe8jj33SxseFpOU+NFLFxWgqZT0Jv9x3Y8XKYxphByC+FLRY024XcMF
 BwYKdgpDKc2pSyGc8AU/bLGQLnsgQBtIkZybcqkkO9ZdICYfpPWN3Iw9sudNOCZu29
 rTM0BR/kzztPIgO5aM0cuymir37b6lmGZUUGOwD8wvcwgy6a7oEIo5v1jI4DEaqGBA
 JkEG0b4VcdMQTZgyUf0M9rZlGsJAMXRyeYOO3kTqwoxEjvgsp78RPfVHCMQJXFxNWV
 zQe9k0pms74hr+te2dWaNIduEchGPIQKCrub7eVh0A8Xm5kaILozQ+LoNQyEm6fOgZ
 Tg7KDImNEpbVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/31] drm/amdgpu: disable BACO support on more
 cards
Date: Wed, 23 Nov 2022 07:42:18 -0500
Message-Id: <20221123124234.265396-17-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124234.265396-1-sashal@kernel.org>
References: <20221123124234.265396-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, sathishkumar.sundararaju@amd.com,
 lijo.lazar@amd.com, Guchun Chen <guchun.chen@amd.com>, danijel.slivka@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org, luben.tuikov@amd.com,
 Mohammadzafar.ziya@amd.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, evan.quan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 192039f12233c9063d040266e7c98188c7c89dec ]

Otherwise, some unexpected PCIE AER errors will be observed
in runtime suspend/resume cycle.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ca6fa133993c..82a8c184526d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -368,6 +368,10 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 		    ((adev->pdev->device == 0x73BF) &&
 		    (adev->pdev->revision == 0xCF)) ||
 		    ((adev->pdev->device == 0x7422) &&
+		    (adev->pdev->revision == 0x00)) ||
+		    ((adev->pdev->device == 0x73A3) &&
+		    (adev->pdev->revision == 0x00)) ||
+		    ((adev->pdev->device == 0x73E3) &&
 		    (adev->pdev->revision == 0x00)))
 			smu_baco->platform_support = false;
 
-- 
2.35.1

