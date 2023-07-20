Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF45EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 10:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C6510E596;
	Thu, 20 Jul 2023 10:23:19 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Thu, 20 Jul 2023 01:10:28 UTC
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB97810E00A;
 Thu, 20 Jul 2023 01:10:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VnnjpEl_1689815115; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VnnjpEl_1689815115) by smtp.aliyun-inc.com;
 Thu, 20 Jul 2023 09:05:16 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH -next] drm/amdgpu: Fix one kernel-doc comment
Date: Thu, 20 Jul 2023 09:05:14 +0800
Message-Id: <20230720010514.54342-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jul 2023 10:23:18 +0000
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Yang Li <yang.lee@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use colon to separate parameter name from their specific meaning.
silence the warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:793: warning: Function parameter or member 'adev' not described in 'amdgpu_vm_pte_update_noretry_flags'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 83e1923f6775..96d601e209b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -783,7 +783,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 /**
  * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
  *
- * @adev - amdgpu_device pointer
+ * @adev: amdgpu_device pointer
  * @flags: pointer to PTE flags
  *
  * Update PTE no-retry flags when TF is enabled.
-- 
2.20.1.7.g153144c

