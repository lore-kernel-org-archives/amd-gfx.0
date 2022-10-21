Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7549C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A40D10E60C;
	Fri, 21 Oct 2022 07:32:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D8010E54B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 02:22:49 +0000 (UTC)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtp605R63zmVCd;
 Fri, 21 Oct 2022 10:18:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:46 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:46 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
 <ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] ubifs: Fix memory leak in ubifs_sysfs_init()
Date: Fri, 21 Oct 2022 10:21:02 +0800
Message-ID: <20221021022102.2231464-12-yangyingliang@huawei.com>
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

From: Liu Shixin <liushixin2@huawei.com>

When insmod ubifs.ko, a kmemleak reported as below:

 unreferenced object 0xffff88817fb1a780 (size 8):
   comm "insmod", pid 25265, jiffies 4295239702 (age 100.130s)
   hex dump (first 8 bytes):
     75 62 69 66 73 00 ff ff                          ubifs...
   backtrace:
     [<ffffffff81b3fc4c>] slab_post_alloc_hook+0x9c/0x3c0
     [<ffffffff81b44bf3>] __kmalloc_track_caller+0x183/0x410
     [<ffffffff8198d3da>] kstrdup+0x3a/0x80
     [<ffffffff8198d486>] kstrdup_const+0x66/0x80
     [<ffffffff83989325>] kvasprintf_const+0x155/0x190
     [<ffffffff83bf55bb>] kobject_set_name_vargs+0x5b/0x150
     [<ffffffff83bf576b>] kobject_set_name+0xbb/0xf0
     [<ffffffff8100204c>] do_one_initcall+0x14c/0x5a0
     [<ffffffff8157e380>] do_init_module+0x1f0/0x660
     [<ffffffff815857be>] load_module+0x6d7e/0x7590
     [<ffffffff8158644f>] __do_sys_finit_module+0x19f/0x230
     [<ffffffff815866b3>] __x64_sys_finit_module+0x73/0xb0
     [<ffffffff88c98e85>] do_syscall_64+0x35/0x80
     [<ffffffff88e00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

When kset_register() failed, we should call kset_put to cleanup it.

Fixes: 2e3cbf425804 ("ubifs: Export filesystem error counters")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/ubifs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 06ad8fa1fcfb..54270ad36321 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -144,6 +144,8 @@ int __init ubifs_sysfs_init(void)
 	kobject_set_name(&ubifs_kset.kobj, "ubifs");
 	ubifs_kset.kobj.parent = fs_kobj;
 	ret = kset_register(&ubifs_kset);
+	if (ret)
+		kset_put(&ubifs_kset);
 
 	return ret;
 }
-- 
2.25.1

