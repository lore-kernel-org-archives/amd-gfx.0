Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117F9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D39A10E5FC;
	Fri, 21 Oct 2022 07:31:04 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B2510E0F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 02:22:41 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtpC82VSGzHvDB;
 Fri, 21 Oct 2022 10:22:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:35 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
 <ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] fix memory leak while kset_register() fails
Date: Fri, 21 Oct 2022 10:20:51 +0800
Message-ID: <20221021022102.2231464-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

The previous discussion link:
https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/

kset_register() is currently used in some places without calling
kset_put() in error path, because the callers think it should be
kset internal thing to do, but the driver core can not know what
caller doing with that memory at times. The memory could be freed
both in kset_put() and error path of caller, if it is called in
kset_register().

So make the function documentation more explicit about calling
kset_put() in the error path of caller first, so that people
have a chance to know what to do here, then fixes this leaks
by calling kset_put() from callers.

Liu Shixin (1):
  ubifs: Fix memory leak in ubifs_sysfs_init()

Yang Yingliang (10):
  kset: fix documentation for kset_register()
  kset: add null pointer check in kset_put()
  bus: fix possible memory leak in bus_register()
  kobject: fix possible memory leak in kset_create_and_add()
  class: fix possible memory leak in __class_register()
  firmware: qemu_fw_cfg: fix possible memory leak in
    fw_cfg_build_symlink()
  f2fs: fix possible memory leak in f2fs_init_sysfs()
  erofs: fix possible memory leak in erofs_init_sysfs()
  ocfs2: possible memory leak in mlog_sys_init()
  drm/amdgpu/discovery: fix possible memory leak

 drivers/base/bus.c                            | 4 +++-
 drivers/base/class.c                          | 6 ++++++
 drivers/firmware/qemu_fw_cfg.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
 fs/erofs/sysfs.c                              | 4 +++-
 fs/f2fs/sysfs.c                               | 4 +++-
 fs/ocfs2/cluster/masklog.c                    | 7 ++++++-
 fs/ubifs/sysfs.c                              | 2 ++
 include/linux/kobject.h                       | 3 ++-
 lib/kobject.c                                 | 5 ++++-
 10 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.25.1

