Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A78C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 07:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0541523B51
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 07:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0541523B51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D636E5AB;
	Mon, 22 Jun 2020 07:16:57 +0000 (UTC)
Received: from mail-m17613.qiye.163.com (mail-m17613.qiye.163.com
 [59.111.176.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8186E02D
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2020 09:12:02 +0000 (UTC)
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
 by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 03FEF4815C6;
 Sat, 20 Jun 2020 17:11:59 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/amd: fix potential memleak in err branch
Date: Sat, 20 Jun 2020 17:11:52 +0800
Message-Id: <20200620091152.11206-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZTB8dQ0pISUxOSk5IVkpOQklNT09ISkJJSE5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6Sww5MDgxPwIySCg0MRUX
 ITwKCUxVSlVKTkJJTU9PSEpCTU9JVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSU5ZV1kIAVlBSUhJQzcG
X-HM-Tid: 0a72d0ffb7d393bakuws03fef4815c6
X-Mailman-Approved-At: Mon, 22 Jun 2020 07:16:50 +0000
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
Cc: opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function kobject_init_and_add alloc memory like:
kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
->kmalloc_slab, in err branch this memory not free. If use
kmemleak, this path maybe catched.
These changes are to add kobject_put in kobject_init_and_add
failed branch, fix potential memleak.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
Changes since V2:
*remove duplicate kobject_put in kfd_procfs_init.

Link for V1:
*https://lore.kernel.org/patchwork/patch/1258608/
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d27221ddcdeb..0e0c42e9f6a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -428,6 +428,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
 					   (int)process->lead_thread->pid);
 		if (ret) {
 			pr_warn("Creating procfs pid directory failed");
+			kobject_put(process->kobj);
 			goto out;
 		}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
