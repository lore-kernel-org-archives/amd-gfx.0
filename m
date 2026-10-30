Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AB606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgC9LuFc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0384112738;
	Fri, 30 Oct 2026 10:41:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9748112736
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 10:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7473640295;
 Fri, 30 Oct 2026 10:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865851F0093A;
 Fri, 30 Oct 2026 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356863;
 bh=wyEBsu61my2xRcWxxz/2MGS82lQFimJORgTUHt1Bg/U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mgC9LuFcRUG1bKE5lPmYGQ3TakPnq4qoAC+LcwGSGVPme/Znv+zFAKN2llpi2uYe2
 U+B2EJH7AmmDDN34aNDqYcJ12FlaNqMuscteVibC+NOWS4dFQGuIWPhys6kWGo/0Tl
 zXUlwdSmRjgaUeI32wTGKH2QPcAU6le5TrYuRwxJM1T1UDxggL9Pv84qJqfpSiLO7/
 qQJgfG/kfEkGCCKvecl+Zrybw/OyslZ7CJXmnZtj7r7Ik9bWy8JywMSLai/6R4tVoK
 BOuxQXKbMH+0oMtWqXOm0JXDg1yK5sFTHUFFINl/veDXpoFsgPgzyQYpTU2CFYh8Sr
 60Gn1A4WFtDJA==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Kevin Wang <kevin.wang@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: [PATCH linux-next] drm/amd/pm: fix up the amdgpu merge of the smu
 14.0.2 zero fan restore
Date: Fri, 30 Oct 2026 06:41:01 -0400
Message-ID: <20261030104101.3496560-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auNVlhF6DGyFYx10@sirena.org.uk>
References: <auNVlhF6DGyFYx10@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After the drm merge, smu_v14_0_2_od_restore_table_single() has two
PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP cases: the drm-next one and the one
from commit a2eae9f4fa1b ("drm/amd/pm: add zero fan stop temperature
support on smu 14.0.2") in mainline. The amdgpu merge resolution drops
the drm-next one and keeps the mainline one, which still sets
PP_OD_FEATURE_ZERO_FAN_BIT in FeatureCtrlMask.

Commit 8d4ce79aff1c ("drm/amd/pm: preserve committed OD features for
SMU 14.0.2") and its drm-next cherry-pick removed that update from both
zero fan restore cases. Remove it again so the file matches the amdgpu
tree.

Fixes: 0575e86c31a9 ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux.git")
Link: https://lore.kernel.org/all/auNVlhF6DGyFYx10@sirena.org.uk/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Mark, this applies on top of next-20261029 and is meant to be folded into
the amdgpu merge resolution.

 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 24a3d61d8ea66..62f16d17e22bc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2606,7 +2606,6 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
 		od_table->OverDriveTable.FanZeroRpmStopTemp =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =

base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
-- 
2.53.0

