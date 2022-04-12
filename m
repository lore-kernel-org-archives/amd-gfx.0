Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAC2C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 00:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB1410FAF9;
	Tue, 12 Apr 2022 00:49:41 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B310210FAFE;
 Tue, 12 Apr 2022 00:49:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3BCAB617E7;
 Tue, 12 Apr 2022 00:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E6C385A3;
 Tue, 12 Apr 2022 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649724578;
 bh=+c2FCMYkIhAQb6pTpNufiCaP0nYl95lV9Tb0t+9Od+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o7232wlT1VSoRdzGHiBYwkEB8NOn4Dj77tj65t4ntHoUVXoPKf75cPv9CZPgmNLKV
 Y3lX4PQjPXJgMA5aWYQCMx4fRjkWDz8zYEHUAT7dcaN/7PX78f4By0bEJJ0XKW16VN
 VT745PeVJEhY82tytHjWPXsbRaPcaEmpkL8FBZOEYvgEgoSvVuDbs20Ra8wZHt7koU
 uNv2gcoPNkCMjxI26+VRbx+G7gh35Hjm7LWDiln0D5ajl7sPlK9osEYDbqnsXJWkQl
 O2ek5L/jvMgvJmkeW9nEFGCIZTa2LTJSEucNEE5mEq66ANsmBxzcaNY04uYVycqEcZ
 bw7Fmm8Zhd8LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/30] drm/amdgpu/vcn: improve vcn dpg stop
 procedure
Date: Mon, 11 Apr 2022 20:48:42 -0400
Message-Id: <20220412004906.350678-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004906.350678-1-sashal@kernel.org>
References: <20220412004906.350678-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, andrey.grodzovsky@amd.com,
 Xinhui.Pan@amd.com, airlied@linux.ie, veerabadhran.gopalakrishnan@amd.com,
 Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, bas@basnieuwenhuizen.nl,
 Alex Deucher <alexander.deucher@amd.com>, ruijing.dong@amd.com,
 James Zhu <James.Zhu@amd.com>, leo.liu@amd.com, christian.koenig@amd.com,
 Bokun.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tianci Yin <tianci.yin@amd.com>

[ Upstream commit 6ea239adc2a712eb318f04f5c29b018ba65ea38a ]

Prior to disabling dpg, VCN need unpausing dpg mode, or VCN will hang in
S3 resuming.

Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Tianci Yin <tianci.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2099f6ebd833..bdb8e596bda6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1429,8 +1429,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 
 static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
+	vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.35.1

