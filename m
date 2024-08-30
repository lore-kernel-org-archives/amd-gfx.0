Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E528CA0EE6
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 07:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1578610E82B;
	Fri, 30 Aug 2024 07:16:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054A810E0B7;
 Fri, 30 Aug 2024 01:14:06 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww0XD4kZ9zyR6Q;
 Fri, 30 Aug 2024 09:13:32 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id BC85D140202;
 Fri, 30 Aug 2024 09:14:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 09:14:04 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
 <felix.kuehling@amd.com>, <zhenguo.yin@amd.com>,
 <srinivasan.shanmugam@amd.com>, <shashank.sharma@amd.com>,
 <Jesse.Zhang@amd.com>
CC: <lizetao1@huawei.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>
Subject: [PATCH -next 2/3] drm/amdgpu: use clamp() in amdgpu_vm_adjust_size()
Date: Fri, 30 Aug 2024 09:22:15 +0800
Message-ID: <20240830012216.603623-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830012216.603623-1-lizetao1@huawei.com>
References: <20240830012216.603623-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Mailman-Approved-At: Fri, 30 Aug 2024 07:15:59 +0000
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

