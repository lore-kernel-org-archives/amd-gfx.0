Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639AFC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311E410E5FB;
	Fri, 21 Oct 2022 07:31:01 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AB110E0F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 02:22:50 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtpCM5YgKzHv3Y;
 Fri, 21 Oct 2022 10:22:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:39 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
 <ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] kobject: fix possible memory leak in
 kset_create_and_add()
Date: Fri, 21 Oct 2022 10:20:55 +0800
Message-ID: <20221021022102.2231464-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021022102.2231464-1-yangyingliang@huawei.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 21 Oct 2022 07:30:36 +0000
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
Cc: alexander.deucher@amd.com, richard@nod.at, mst@redhat.com,
 gregkh@linuxfoundation.org, somlo@cmu.edu, chao@kernel.org,
 huangjianan@oppo.com, liushixin2@huawei.com, joseph.qi@linux.alibaba.com,
 luben.tuikov@amd.com, jlbec@evilplan.org, hsiangkao@linux.alibaba.com,
 rafael@kernel.org, jaegeuk@kernel.org, akpm@linux-foundation.org,
 mark@fasheh.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inject fault while loading module (e.g. qemu_fw_cfg.ko), kset_register()
may fail in kset_create_and_add(), if it fails, but the refcount of kobject
is not decreased to 0, the name allocated in kset_create() is leaked. To fix
this by calling kset_put(), so that name can be freed in callback function
kobject_cleanup() and kset can be freed in kset_release().

unreferenced object 0xffff888103cc8c08 (size 8):
  comm "modprobe", pid 508, jiffies 4294915182 (age 120.020s)
  hex dump (first 8 bytes):
    62 79 5f 6e 61 6d 65 00                          by_name.
  backtrace:
    [<00000000572f97f9>] __kmalloc_track_caller+0x1ae/0x320
    [<00000000a167a5cc>] kstrdup+0x3a/0x70
    [<000000001cd0d05e>] kstrdup_const+0x68/0x80
    [<00000000b9101e6d>] kvasprintf_const+0x10b/0x190
    [<0000000088f2b8df>] kobject_set_name_vargs+0x56/0x150
    [<000000003f8aca68>] kobject_set_name+0xab/0xe0
    [<00000000249f7816>] kset_create_and_add+0x72/0x200

Fixes: b727c702896f ("kset: add kset_create_and_add function")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 6da04353d974..e77f37200876 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -985,7 +985,7 @@ struct kset *kset_create_and_add(const char *name,
 		return NULL;
 	error = kset_register(kset);
 	if (error) {
-		kfree(kset);
+		kset_put(kset);
 		return NULL;
 	}
 	return kset;
-- 
2.25.1

