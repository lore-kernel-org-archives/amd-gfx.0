Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFBC48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 13:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226EA613F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 13:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226EA613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E8D6ED1E;
	Thu, 10 Jun 2021 13:30:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A036E866;
 Thu, 10 Jun 2021 08:19:22 +0000 (UTC)
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0xdB6w0Cz6xDF;
 Thu, 10 Jun 2021 16:16:14 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 16:19:19 +0800
From: He Ying <heying24@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <airlied@redhat.com>, <bskeggs@redhat.com>, <matthew.auld@intel.com>,
 <Ramesh.Errabolu@amd.com>, <mchehab+huawei@kernel.org>, <Dennis.Li@amd.com>,
 <funfunctor@folklore1984.net>
Subject: [PATCH -next] drm/amdgpu: Use DIV_ROUND_UP_ULL instead of DIV_ROUND_UP
Date: Thu, 10 Jun 2021 04:20:05 -0400
Message-ID: <20210610082005.86876-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 10 Jun 2021 13:30:32 +0000
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
Cc: heying24@huawei.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When compiling the kernel for MIPS with CONFIG_DRM_AMDGPU = y, errors are
encountered as follows:

drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.o: In function `amdgpu_vram_mgr_new':
amdgpu_vram_mgr.c:(.text+0x740): undefined reference to `__udivdi3'

Making a 64 bit division by a/b (a is uint64_t) is not supported by default
in linux kernel space. Instead, using do_div is OK for this situation. For
this problem, using DIV_ROUND_UP_ULL instead of DIV_ROUND_UP is better.

Fixes: 6a7f76e70fac ("drm/amdgpu: add VRAM manager v2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 9a6df02477ce..436ec246a7da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -407,7 +407,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 #endif
 		pages_per_node = max_t(uint32_t, pages_per_node,
 				       tbo->page_alignment);
-		num_nodes = DIV_ROUND_UP(PFN_UP(mem_bytes), pages_per_node);
+		num_nodes = DIV_ROUND_UP_ULL(PFN_UP(mem_bytes), pages_per_node);
 	}
 
 	node = kvmalloc(struct_size(node, mm_nodes, num_nodes),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
