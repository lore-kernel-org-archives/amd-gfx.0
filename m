Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9F1CE7A8A
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Sep 2023 13:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB0010E198;
	Sun, 24 Sep 2023 13:18:51 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CED110E19D;
 Sun, 24 Sep 2023 13:18:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A5CB960C38;
 Sun, 24 Sep 2023 13:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEEDC433C7;
 Sun, 24 Sep 2023 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695561517;
 bh=m8A5qV2svXzJAoVYad/DEMOjC6iKCTNtquyMarD5SsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LsJz6OxNjgZ6Ges+Wq8rr8x2kklbDti+PSyQ+ZrmtYmUoLeEROxefnboCK3aNYy8M
 UhRX/S/5jQe+mExvqhkbY+yxkHwYknksTvW+vyXquSv2pz92N1J2pszpmkusdbYbZp
 5XaL8uCIEhD/3EPch6JqXasi3YIrGl8AbSnz84rc+xL/94UP+FYWn49o099OM60pqp
 Carde3CZkkJt1h+44VNFYO8jaSGENA4KKBP5W1DB5H3QE4kgoTDMroR2/YtV2jqe4F
 RYmaxHdXO/fyrsUFba6kn3xI+mgGoD/eirHkcTUFAdfobuYiddwWmk/HTLJ7gpYEZK
 u7MXBTPPhN8/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/28] drm/amdgpu/soc21: don't remap HDP registers
 for SR-IOV
Date: Sun, 24 Sep 2023 09:17:38 -0400
Message-Id: <20230924131745.1275960-21-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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
Cc: Sasha Levin <sashal@kernel.org>, sunran001@208suo.com, Jane.Jian@amd.com,
 kenneth.feng@amd.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 aaron.liu@amd.com, amd-gfx@lists.freedesktop.org, shane.xiao@amd.com,
 sonny.jiang@amd.com, Timmy Tsai <timmtsai@amd.com>, daniel@ffwll.ch,
 veerabadhran.gopalakrishnan@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Likun.Gao@amd.com, airlied@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1832403cd41ca6b19b24e9d64f79cb08d920ca44 ]

This matches the behavior for soc15 and nv.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timmy Tsai <timmtsai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d150a90daa403..56af7b5abac14 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -755,7 +755,7 @@ static int soc21_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, true);
-- 
2.40.1

