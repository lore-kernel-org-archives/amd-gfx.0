Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9280AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 12:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3EB510E556;
	Tue,  7 Nov 2023 12:21:15 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFDE10E553;
 Tue,  7 Nov 2023 12:21:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 76501611B7;
 Tue,  7 Nov 2023 12:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A3C433C9;
 Tue,  7 Nov 2023 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699359673;
 bh=zRLYVJzEmMHhUfyTzu7p4rra2CVJwPd4o1lufCaMcWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YlwHoh4WMeqOKBDjLEZN7VGsuee58puePyVkjR1RZfWQG8EYqVluzcCUwKxjtd65Y
 2iSDMbB+53wwCabxGgui/gaoaydnd+v1vXNFdyCIyk05YJVxaZViSJtPdc2X5ByC+9
 b0+bQoJqaJ1og5udGKHzZ6fXx5pcB836b4BVmkjcEkpOuvE4DP9Nb4eYyE+J+Rqnaf
 g68hymVqYr/34H1T1naiYkGOK9sp/pXJL4wBwGNT2lJo5E6XZfIr6O7YnJpYgbNXYJ
 QM82QTPcipe9xiuLpZuZ0Du4W9MOlY0uyLoGlFe0dkElF9iprCb6XvE6YJtT2YpQix
 vO5q6xUlPNyrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/40] drm/amd: check num of link levels when
 update pcie param
Date: Tue,  7 Nov 2023 07:16:35 -0500
Message-ID: <20231107121837.3759358-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
Cc: Sasha Levin <sashal@kernel.org>, lijo.lazar@amd.com,
 dri-devel@lists.freedesktop.org, guchun.chen@amd.com,
 amd-gfx@lists.freedesktop.org, Lyndon.Li@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Xinhui.Pan@amd.com,
 "Lin.Cao" <lincao12@amd.com>, mario.limonciello@amd.com, daniel@ffwll.ch,
 bokun.zhang@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 evan.quan@amd.com, airlied@gmail.com, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 406e8845356d18bdf3d3a23b347faf67706472ec ]

In SR-IOV environment, the value of pcie_table->num_of_link_levels will
be 0, and num_of_levels - 1 will cause array index out of bounds

Signed-off-by: Lin.Cao <lincao12@amd.com>
Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4aeb84572e5b8..5355f621388bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2430,6 +2430,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
+	if (!num_of_levels)
+		return 0;
+
 	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
-- 
2.42.0

