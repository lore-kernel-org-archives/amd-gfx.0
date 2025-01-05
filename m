Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4867AE77199
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2025 16:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7A810E289;
	Sun,  5 Jan 2025 16:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l0TTrS1Q";
	dkim-atps=neutral
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084A110E057
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2025 05:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736054542; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 bh=Wljkv1GsVHfF2eKoBazJ8rmswBvsObUQp71Pkdhcj1g=;
 b=l0TTrS1QumuRTRYhSHbOGlXHgPZq3B83eORYaZ2KkqYchUIqBzt3rV2UX8ENl44HVn/3GU3NErKMKwYjYE1s8hBg1BGf3po6pPyQpqWMbE+oqWHwq95010laOG4Z08/N6TScthJuijYziLuWbrge3rN15p7w6W5mL8ccSuOlxbo=
Received: from localhost(mailfrom:shuox.liu@linux.alibaba.com
 fp:SMTPD_---0WMxtq9N_1736054540 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 05 Jan 2025 13:22:21 +0800
Date: Sun, 5 Jan 2025 13:22:20 +0800
From: Shuo Liu <shuox.liu@linux.alibaba.com>
To: Jiang Liu <gerry@linux.alibaba.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com,
 lijo.lazar@amd.com, Kent.Russell@amd.com
Subject: Re: [PATCH v2 1/6] amdgpu: fix possible resource leakage in
 kfd_cleanup_nodes()
Message-ID: <Z3oXDBgDvgbVpdpX@shuo-ali-mbp.local>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com>
X-Mailman-Approved-At: Sun, 05 Jan 2025 16:40:26 +0000
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

Hi Gerry,

On Sun  5.Jan'25 at 10:45:29 +0800, Jiang Liu wrote:
>Fix possible resource leakage on error recovery path in function
>kgd2kfd_device_init().
>
>Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>---
> drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>index a29374c86405..fa5054940486 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>@@ -898,15 +898,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> 		if (kfd->adev->xcp_mgr)
> 			kfd_setup_interrupt_bitmap(node, i);
>
>+		spin_lock_init(&node->watch_points_lock);
>+
>+		kfd->nodes[i] = node;
>+
> 		/* Initialize the KFD node */
> 		if (kfd_init_node(node)) {
> 			dev_err(kfd_device, "Error initializing KFD node\n");
> 			goto node_init_error;
> 		}
>-
>-		spin_lock_init(&node->watch_points_lock);
>-
>-		kfd->nodes[i] = node;
> 	}
>
> 	svm_range_set_max_pages(kfd->adev);
>@@ -921,6 +921,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> 	goto out;
>
> node_init_error:
>+	i++;
The err cleanup path can release node itself. So the following
kfd_cleanup_nodes() may do a double free? 

> node_alloc_error:
> 	kfd_cleanup_nodes(kfd, i);
> 	kfd_doorbell_fini(kfd);
shuo
