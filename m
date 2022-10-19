Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B04BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A9010F197;
	Wed, 19 Oct 2022 08:45:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FD910EA22
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 03:30:01 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Msbk81L6QznTV5;
 Wed, 19 Oct 2022 11:26:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:29:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:29:57 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] mm: debug_vm_pgtable: use VM_ACCESS_FLAGS
Date: Wed, 19 Oct 2022 11:49:44 +0800
Message-ID: <20221019034945.93081-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
References: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 19 Oct 2022 08:45:19 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Jarkko Sakkinen <jarkko@kernel.org>,
 linux-sgx@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Directly use VM_ACCESS_FLAGS instead VMFLAGS.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/debug_vm_pgtable.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index dc7df1254f0a..2b61fde8c38c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -38,11 +38,7 @@
  * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
  * expectations that are being validated here. All future changes in here
  * or the documentation need to be in sync.
- */
-
-#define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
-
-/*
+ *
  * On s390 platform, the lower 4 bits are used to identify given page table
  * entry type. But these bits might affect the ability to clear entries with
  * pxx_clear() because of how dynamic page table folding works on s390. So
@@ -1125,7 +1121,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	 */
 	memset(args, 0, sizeof(*args));
 	args->vaddr              = get_random_vaddr();
-	args->page_prot          = vm_get_page_prot(VMFLAGS);
+	args->page_prot          = vm_get_page_prot(VM_ACCESS_FLAGS);
 	args->page_prot_none     = vm_get_page_prot(VM_NONE);
 	args->is_contiguous_page = false;
 	args->pud_pfn            = ULONG_MAX;
-- 
2.35.3

