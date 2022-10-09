Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AE7C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Oct 2022 23:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D40010E2BC;
	Sun,  9 Oct 2022 23:50:38 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A4710E2C7;
 Sun,  9 Oct 2022 23:50:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 84ED060DBB;
 Sun,  9 Oct 2022 23:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE13C433D7;
 Sun,  9 Oct 2022 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665359431;
 bh=mME9mzndmhSJSi2ktRj1yzveQYGUE9uDYtgIpq1E8RQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TQTBozsHgXW7ytUw5A6Bf0qrI05+khsArmsSvuZxFuSRhOifJO3SOu+m9MNA1AO4F
 AL65bQhfHRFmg7e/3NS78sCum7yfmjsnt8LQcLKFC9QROz9X03ZFYWRILV0M8B+3jO
 Wyhoz1OXDehv/wVLng6lV38jxngIEqZEzvt3mBD1jx1KoB5rylqBnm+c31QLVxGCdr
 jgv5/2VpWUHwdj8NQUZyap+n8EIF1goun8GG5Ey+5ZveVpvaNign/y7kEW1KbuwfXd
 QiEhtmjAyKTBRQREPBXqciTrD/IHBKSduJxKYUH0NAscA5HsCKQrJYTc+zuV1RVhR4
 bHcNKhbC9fhZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 15/44] drm/admgpu: Skip CG/PG on SOC21 under SRIOV
 VF
Date: Sun,  9 Oct 2022 19:49:03 -0400
Message-Id: <20221009234932.1230196-15-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009234932.1230196-1-sashal@kernel.org>
References: <20221009234932.1230196-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Sasha Levin <sashal@kernel.org>, tim.huang@amd.com, evan.quan@amd.com,
 kenneth.feng@amd.com, Likun.Gao@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, sonny.jiang@amd.com, Stanley.Yang@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 James.Zhu@amd.com, airlied@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[ Upstream commit 828418259254863e0af5805bd712284e2bd88e3b ]

[Why]
There is no CG(Clock Gating)/PG(Power Gating) requirement on SRIOV VF.
For multi VF, VF should not enable any CG/PG features.
For one VF, PF will program CG/PG related registers.

[How]
Do not set any cg/pg flag bit at early init under sriov.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6e564b549b9f..224fd7effd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -583,6 +583,10 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
+		if (amdgpu_sriov_vf(adev)) {
+			adev->cg_flags = 0;
+			adev->pg_flags = 0;
+		}
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
 	case IP_VERSION(11, 0, 2):
-- 
2.35.1

