Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013B1C04A94
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 07:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB52910E673;
	Fri, 28 Jul 2023 07:45:20 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5377A10E63C;
 Fri, 28 Jul 2023 04:48:29 +0000 (UTC)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBw9H5nhFz1GDJX;
 Fri, 28 Jul 2023 12:47:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 12:48:26 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/4] drm/amdkfd: use vma_is_initial_stack() and
 vma_is_initial_heap()
Date: Fri, 28 Jul 2023 13:00:41 +0800
Message-ID: <20230728050043.59880-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 28 Jul 2023 07:45:17 +0000
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
Cc: stephen.smalley.work@gmail.com, Kefeng Wang <wangkefeng.wang@huawei.com>,
 paul@paul-moore.com, David Hildenbrand <david@redhat.com>,
 selinux@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, peterz@infradead.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, eparis@parisplace.org, linux-fsdevel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, acme@kernel.org, airlied@gmail.com,
 christian.koenig@amd.com,
 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the helpers to simplify code.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 01c7de2d6e19..308384dbc502 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2624,10 +2624,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 		return -EFAULT;
 	}
 
-	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
-			  vma->vm_end >= vma->vm_mm->start_brk) ||
-			 (vma->vm_start <= vma->vm_mm->start_stack &&
-			  vma->vm_end >= vma->vm_mm->start_stack);
+	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
 	start_limit = max(vma->vm_start >> PAGE_SHIFT,
 		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
-- 
2.41.0

