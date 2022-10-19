Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3484C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A7810F12F;
	Wed, 19 Oct 2022 08:45:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E7C10EA22
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 03:30:31 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MsbpQ4FcWzHtpy;
 Wed, 19 Oct 2022 11:30:22 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:29:56 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:29:55 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] mm: cleanup with VM_ACCESS_FLAGS
Date: Wed, 19 Oct 2022 11:49:40 +0800
Message-ID: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
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

Kefeng Wang (5):
  nios2: remove unused INIT_MMAP
  x86/sgx: use VM_ACCESS_FLAGS
  mm: mprotect: use VM_ACCESS_FLAGS
  mm: debug_vm_pgtable: use VM_ACCESS_FLAGS
  amdgpu: use VM_ACCESS_FLAGS

 arch/nios2/include/asm/processor.h      | 3 ---
 arch/x86/kernel/cpu/sgx/encl.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 mm/debug_vm_pgtable.c                   | 8 ++------
 mm/mprotect.c                           | 3 +--
 5 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.35.3

