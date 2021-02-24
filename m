Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E245C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 12:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB6764E6F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 12:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB6764E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536B66EA95;
	Wed, 24 Feb 2021 12:51:17 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487B86EA92;
 Wed, 24 Feb 2021 12:51:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2012764F22;
 Wed, 24 Feb 2021 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171076;
 bh=asoP4vmNUIKzTu/WQvAJHOSjOZC5arPbeF1w0w2Iw3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LXehoa2M8EG1QDmCfTcMBeZ6I4aUvWYcoBgXf599cDzlVqcdxWSjS/cfNerwyU4J5
 ItnTEKdYxcNS+fbVpOBNU33KsIP4GYp13daXpUxXBRWtXfazb4MdfbAF6G/CfUqu2P
 hp3e2SBrB2E5dRLqRGFXplpr8FLHGJRu5d38GkNvGG/g9VBnoyj3O94lTx1xbucunZ
 Cncha98H1Y2e4YhEqgZWO96UV2ENNdgnG3BIaFiu4JxJzDiihMUntXKRwn0798emtt
 KCGlU8GywQG23g1HUsyYfjeayb4FMLYg+rkKO7f8GWWf8B+qCWZW+SLQA/W2b3S5an
 +T0pnkEucHR3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 36/67] drm/amd/amdgpu: add error handling to
 amdgpu_virt_read_pf2vf_data
Date: Wed, 24 Feb 2021 07:49:54 -0500
Message-Id: <20210224125026.481804-36-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125026.481804-1-sashal@kernel.org>
References: <20210224125026.481804-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Monk Liu <monk.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Chen <Jingwen.Chen2@amd.com>

[ Upstream commit 64dcf2f01d59cf9fad19b1a387bd39736a8f4d69 ]

[Why]
when vram lost happened in guest, try to write vram can lead to
kernel stuck.

[How]
When the readback data is invalid, don't do write work, directly
reschedule a new work.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Reviewed-by: Monk Liu<monk.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2d51b7694d1fd..572153d08ad11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -560,10 +560,14 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 {
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
+	int ret;
 
-	amdgpu_virt_read_pf2vf_data(adev);
+	ret = amdgpu_virt_read_pf2vf_data(adev);
+	if (ret)
+		goto out;
 	amdgpu_virt_write_vf2pf_data(adev);
 
+out:
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
