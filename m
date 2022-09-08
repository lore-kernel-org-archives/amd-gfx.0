Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8FFC38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 13:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DBA10EAE7;
	Thu,  8 Sep 2022 13:18:47 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EBA10EAE4;
 Thu,  8 Sep 2022 13:17:29 +0000 (UTC)
X-QQ-mid: bizesmtp84t1662643039t07ra0ze
Received: from localhost.localdomain ( [182.148.14.0])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 08 Sep 2022 21:17:18 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: +bXiSo2NuBcBlRYOxHLzXBtArwwG6UHyCDKxp/s0RZ6EVpfj/h3Vkndm6DbmK
 WRueeLfffZ5YPRqwhoIQBQzq+tHY0bTZvPklKVKSmJ84Q6gqG9ibDy5v5o3IJ/nMKJcPean
 XqxdTAw6Evc/DT9nHy2+QIczXwutQmBqUEaKJ4fFTgmOS7pqogIy6Rtzm2L5jbuOIIXmm+N
 KnCUmqaQIHSYsopDhJBwCgQq/XFPTAUB2nB2zAt64jxMCAZD8s1YiF/yDPc81ibQIPduGWd
 qB8gt5DhWRqHlHBUeLvJXQHv6mmOZbD8mMa4fL7S8W0kdhzXr12LDcFLFuxvn/rYTFMixOK
 RlkEKFm/qkW6kvt1pwqkx9VT586HLKrNO9ZNYzZowrfLEN+YH+zjmrY+34jNg==
X-QQ-GoodBg: 0
From: wangjianli <wangjianli@cdjrlc.com>
To: airlied@linux.ie, daniel@ffwll.ch, Xinhui.Pan@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH] amd/amdkfd: fix repeated words in comments
Date: Thu,  8 Sep 2022 21:17:12 +0800
Message-Id: <20220908131712.40442-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Mailman-Approved-At: Thu, 08 Sep 2022 13:18:44 +0000
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
Cc: wangjianli <wangjianli@cdjrlc.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 24b414cff3ec..cd5f8b219bf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2284,7 +2284,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 
 	/* Fill in Subtype: IO_LINKS
 	 *  Only direct links are added here which is Link from GPU to
-	 *  to its NUMA node. Indirect links are added by userspace.
+	 *  its NUMA node. Indirect links are added by userspace.
 	 */
 	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
 		cache_mem_filled);
-- 
2.36.1

