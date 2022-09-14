Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD3C6FA89
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 09:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B04810E8BD;
	Wed, 14 Sep 2022 09:02:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F162710E8BD;
 Wed, 14 Sep 2022 09:02:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6B59D61999;
 Wed, 14 Sep 2022 09:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF070C433D7;
 Wed, 14 Sep 2022 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663146137;
 bh=D6yNkS8/rv3f4Kgw0Cl2PR7CDS5sCEdTlxNUZbRpUZg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FUxrWmKVswx5iLQJlNy9mkMpP7c/VG/VATG9p33vmnIAXosH1yEyaReTi0qDV2aa/
 snFxzPn+gdpxcUpVh/QymoZccAoSLXnNW+JyYuDwp9vXFjYM+7dKJxUm2a6qTZzZ/I
 jhY7mEb2reB6cIjU5siELL2mgBYGWZg/osnQidhpRkI81/D/11HWdhoHWLcOmXqNK2
 qAkd0bDiMMSZWovT387H4W+LCfQMbQrF/ZqrQmo12dnSP8dYObIysGQWKRUbfHZgAa
 N3o/vZ1liELjy7VimuMaDBV9C16xbnOtblhiWFm78X/8EkOVzHvcCSwn8wcvezPs1x
 shQTI1EUAME+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 20/22] drm/amdgpu: prevent toc firmware memory
 leak
Date: Wed, 14 Sep 2022 05:01:01 -0400
Message-Id: <20220914090103.470630-20-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914090103.470630-1-sashal@kernel.org>
References: <20220914090103.470630-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, tao.zhou1@amd.com,
 Guchun Chen <guchun.chen@amd.com>, airlied@linux.ie, Bokun.Zhang@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, Likun.Gao@amd.com,
 candice.li@amd.com, john.clements@amd.com, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit aac4cec1ec45d72bd03eaf3fd772c5a609f5ed26 ]

It's missed in psp fini.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88ba..9cb7d208a09ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -481,11 +481,14 @@ static int psp_sw_fini(void *handle)
 		release_firmware(psp->ta_fw);
 		psp->ta_fw = NULL;
 	}
-	if (adev->psp.cap_fw) {
+	if (psp->cap_fw) {
 		release_firmware(psp->cap_fw);
 		psp->cap_fw = NULL;
 	}
-
+	if (psp->toc_fw) {
+		release_firmware(psp->toc_fw);
+		psp->toc_fw = NULL;
+	}
 	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7))
 		psp_sysfs_fini(adev);
-- 
2.35.1

