Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58B4CD3427
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Sep 2024 09:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A30110E0A6;
	Sun,  1 Sep 2024 09:14:11 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4D410E9E9;
 Sat, 31 Aug 2024 01:19:49 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wwcch50y2z1j7qJ;
 Sat, 31 Aug 2024 09:19:32 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 3089E140158;
 Sat, 31 Aug 2024 09:19:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 31 Aug
 2024 09:19:46 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
 <felix.kuehling@amd.com>, <shashank.sharma@amd.com>,
 <srinivasan.shanmugam@amd.com>, <zhenguo.yin@amd.com>, <Jesse.Zhang@amd.com>
CC: <lizetao1@huawei.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH -next -v2 2/3] drm/amdgpu: use clamp() in
 amdgpu_vm_adjust_size()
Date: Sat, 31 Aug 2024 09:28:02 +0800
Message-ID: <20240831012803.3950100-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831012803.3950100-1-lizetao1@huawei.com>
References: <20240831012803.3950100-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Mailman-Approved-At: Sun, 01 Sep 2024 09:14:05 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When it needs to get a value within a certain interval, using clamp()
makes the code easier to understand than min(max()).

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e20d19ae01b2..40f9a5d4f3c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2224,7 +2224,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 		phys_ram_gb = ((uint64_t)si.totalram * si.mem_unit +
 			       (1 << 30) - 1) >> 30;
 		vm_size = roundup_pow_of_two(
-			min(max(phys_ram_gb * 3, min_vm_size), max_size));
+			clamp(phys_ram_gb * 3, min_vm_size, max_size));
 	}
 
 	adev->vm_manager.max_pfn = (uint64_t)vm_size << 18;
-- 
2.34.1

