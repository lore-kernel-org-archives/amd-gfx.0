Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C60C79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 05:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B729E10E1CB;
	Thu, 10 Sep 2026 05:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bl0Wt86k";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A287310E1CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 05:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZVPqxkAa4nNAnRiABtxl/XtivOGqtH27sy7XDMofsnlJgdUpT6pWmALkmhc3uJ3fdagIDc5zBffb7V7rU5U5nHm8gQKoTeYYPyKz1xRVyR8Qq0FgMXDQTeVe01fIHo5pPHTSQt0/GAB8MSRuGL1WJ8kBYuQelqOsCh/Zs7ybWEVGDVmRIn4JmR67pr5AN1Bmn2RQsBgJE01xtWLK/qKp539C8QyELaFD3KUIR8tQbwpeXdCgk5mnWST0TKXVZg3jhMSLXkLyFrv8s+PyfUTWaOZWCtArYwJFeh057vNkAIIaq51ZxxJGLEubVktb2mJrrqoCxaf3l5PBbCf7AXQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvm9RhROeWvHxXDzT1oNxuZTm63LshWOj6oE42p19qc=;
 b=YYfcF1htTOXCX02aL3PTJhX0J9DW0jVHcnhKKMCuE2RkJA6wt6pqBxgah42/ViLz617r93oAnz2SWMTyOcdC1XvKa+1fVNt2YyJEXwlRLK54tQyDOFHb+qLpoj2ifH3VER7FhEY15ll/w9jxaQumJwKiKwO91sw7z+TGSP+PnkIwag8MjjA8XrIpfmwkVIiZGArzsFlQ946rmu3jDed1m+yNyvUlClEm9pLCfu6r+4gjYSp/rvzglTK0pX/4bIHd4ADSy711XtSST1HwXALoRgr7q1q+2XXFNspFmbiScumKGNoNOhnU7WmgCOe9Gvmdm12eSj6DqpraSh6/Glb5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvm9RhROeWvHxXDzT1oNxuZTm63LshWOj6oE42p19qc=;
 b=Bl0Wt86kOvGZ7+i/k+ehedTi/R3l92NrT+NJDLdckVY9xy10/wsWSmey1HYCLKp7oPqXpJ0ZHjfNtKe8XNXT3oQviKKsTNwPi3Ylw7uJtD0FSdLUgtEFlfkBOaECqbRXCiBkRSDLPh7FU/4XUVRS86K6NxlsT1CiDwZ+79wqmIo=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 05:23:38 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::ad) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 05:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 05:23:37 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 00:23:34 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <lijo.lazar@amd.com>, 
 <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <felix.kuehling@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amdkfd: fix use-after-free and multi-container gap in
 kfd_dev_mapping
Date: Thu, 10 Sep 2026 13:23:20 +0800
Message-ID: <20260910052320.255714-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f99fe4-3f93-4c78-e640-08df0efbaafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ezdIyKwizdnrc7eWAp01muFARbLPddCnV1B9pPZhqsNdMGAvsHprWhL9sPJ8T5qqpda+I0HiDhFUuRWK7wVZWKwXmIpfSrcZO4Mc2Hhk3KrrRWKarT1QYr3StqSRXflpqgEXXv5pXTWAYJBJ5feLp4r+P5Y65bZ74hAya+uVrBp0le+ny4VFr+8vnK6dGJCpJ1Kg80Ha/njs7Dm55wpT39B9qJu4lfVu1KlHOuTfih3/nBCH7+/js0T4Ol/qou4N4lnmAkCNnuX/LrREvBKqgj6N32AVaIS+pMr1ZMxm2u4dMIyQj//4lZGSbF+M9cFNYQO/WfmOwNLWZ0eRzWWE3k7btb7bcTLnn1SNUD/QFu4t3FxAm5ybTn2RNijUKwfcWnTj6Ah4comk+HodC13DCPbhbsfFJwGemIvl7Gf75mD73y19bEG19hvu7u0OyJtfcKnEfN81YjhyyPxki34rbqrdO4Z5LUv/YrayMi6LL5k7fNSK19fThTmwR9N80FLdAXd+G/AAtal3yBaZGxA82o5qFbMWPhd4RVJwsRK2VFbPOVJ4ChR9LU4kMPj/XVHzMVBwaajPHMcShJqgingh8A7AmDJB55UfVB+6+MdNMQbliRWnTpw9BsqE8cETvAOtxwGdJMc1sbak81dhXtI+weYFnrBDeo3qLXvFBA0cs1JF45wlHHv+IOHJt2O7V+qHhSwbVpwk2glxsWGaKsNWiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oN5UcW855YA7P3w4XAKckiUGIZFG3bAGMBcbz65fVSn4cySGXTeVfCdq8+IXGM+ReNRX7UmXOjHYG2mwbW8DqqUXt0NaCsgUhRMtXTUsL5Ig3f7SEHMc2u5mQXwrOvs8N6gc5vKNE/82ryjPwKDW6yzSq0VtEI8kQc/DBEkRlr7WYotYZ5uozdPVPirVkSYhmM0OD5JdXv19gGEiDPouv8MmhGrAV5TdAH5EuAPOzxDmIIK3w2N6y6kjdxH3gO4ruNnfuY0yvhcENFML2Qu1tJwZy3HW69TiPMwTayepgPlq+M7yOl/ON79uG8fZy4BHLNIxhMva5dnm9Pss+8DAXjLbl2awjiKayA83J67hUkpON0Y91jDic6TLPqHOMs+hXLteQefwXhM5PhtRg6ncuj6mpFUg4j7IGBQgU7cggLkKwPBK3C8kaZgUXZsI4DPg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 05:23:37.7762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f99fe4-3f93-4c78-e640-08df0efbaafc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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

kfd_dev_mapping caches the address_space of the first /dev/kfd opener
so that the GPU reset path can call unmap_mapping_range() to zap all
userspace mappings of doorbell and MMIO ranges.  This design has two
bugs that both manifest under SRIOV with multiple containers:

1. Use-after-free / rwsem deadlock.  The cached pointer refers to an
   inode owned by the first opener's container.  When that container
   exits and its inode is released, kfd_dev_mapping becomes a dangling
   pointer.  A subsequent GPU reset dereferences it inside
   unmap_mapping_range(), which takes i_mmap_rwsem on the freed inode,
   causing a hard hang observable as an uninterruptible rwsem wait.

2. Multi-container gap.  Only the first opener's address_space is cached;
   VMAs created by later openers live in a different address_space and
   are never reached by unmap_mapping_range().  After a GPU reset those
   stale mappings keep doorbell and MMIO pages accessible to guest
   userspace with no GPU behind them, risking PCIe transaction timeouts
   and NMI panics.

Fix both bugs with the same approach used by DRM core (drm_drv.c):
create a private pseudo-filesystem at module init time and allocate one
anonymous inode from it.  In kfd_open() redirect every opener's
file->f_mapping to that inode's address_space.  The inode is
module-owned, lives exactly as long as the amdgpu module, and collects
VMAs from all openers in one address_space.  A single
unmap_mapping_range() call in the reset path then correctly reaches
every container's mappings with no dangling pointer risk.

The hang manifests as an NMI backtrace on the GPU reset workqueue stuck
spinning in rwsem_down_read_slowpath() with a corrupted i_mmap_rwsem:

  Workqueue: amdgpu-reset-dev xgpu_ai_mailbox_flr_work [amdgpu]
  Call Trace:
   <TASK>
   kvm_wait+0x1f/0x40
   __pv_queued_spin_lock_slowpath+0x31d/0x3a0
   _raw_spin_lock_irq+0x51/0x80
   rwsem_down_read_slowpath+0xb3/0x550
   down_read+0x48/0xd0
   unmap_mapping_range+0x71/0x140
   kfd_dev_unmap_mapping_range+0x5b/0x140 [amdgpu]
   amdgpu_amdkfd_clear_kfd_mapping+0xd8/0x190 [amdgpu]
   amdgpu_device_gpu_recover+0x232/0x450 [amdgpu]
   xgpu_ai_mailbox_flr_work+0xb5/0xc0 [amdgpu]
   process_one_work+0x18e/0x3e0
   worker_thread+0x2e3/0x420
   kthread+0x10a/0x230

Fixes: 378301794d5d ("drm/amdgpu: unmap all user mappings of framebuffer and doorbell before mode1 reset")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 71 +++++++++++++++++++-----
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..1d86ddfd6bde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -35,6 +35,7 @@
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/pseudo_fs.h>
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
 #include <linux/processor.h>
@@ -70,18 +71,54 @@ static const struct class kfd_class = {
 };
 
 /*
- * Cache the address space of the chardev on first open so that the reset
- * path can drop all userspace mappings of doorbell and MMIO ranges via
- * unmap_mapping_range().
+ * Private pseudo-filesystem for KFD, Provides a stable, module-owned
+ * inode whose address_space is the unmap target for all /dev/kfd
+ * openers during GPU reset.
  */
-static struct address_space *kfd_dev_mapping;
+static struct vfsmount *kfd_fs_mnt;
+static int kfd_fs_cnt;
 
-void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
+static int kfd_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, 0x4b464400 /* "KFD" */) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type kfd_fs_type = {
+	.name		= "kfd",
+	.init_fs_context = kfd_fs_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static struct inode *kfd_fs_inode_new(void)
 {
-	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
+	struct inode *inode;
+	int r;
+
+	r = simple_pin_fs(&kfd_fs_type, &kfd_fs_mnt, &kfd_fs_cnt);
+	if (r < 0)
+		return ERR_PTR(r);
+
+	inode = alloc_anon_inode(kfd_fs_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		simple_release_fs(&kfd_fs_mnt, &kfd_fs_cnt);
 
-	if (mapping)
-		unmap_mapping_range(mapping, holebegin, holelen, 1);
+	return inode;
+}
+
+static void kfd_fs_inode_free(struct inode *inode)
+{
+	if (inode) {
+		iput(inode);
+		simple_release_fs(&kfd_fs_mnt, &kfd_fs_cnt);
+	}
+}
+
+static struct inode *kfd_anon_inode;
+
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
+{
+	if (kfd_anon_inode)
+		unmap_mapping_range(kfd_anon_inode->i_mapping, holebegin, holelen, 1);
 }
 
 static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
@@ -107,6 +144,13 @@ int kfd_chardev_init(void)
 {
 	int err = 0;
 
+	kfd_anon_inode = kfd_fs_inode_new();
+	if (IS_ERR(kfd_anon_inode)) {
+		err = PTR_ERR(kfd_anon_inode);
+		kfd_anon_inode = NULL;
+		return err;
+	}
+
 	kfd_char_dev_major = register_chrdev(0, kfd_dev_name, &kfd_fops);
 	err = kfd_char_dev_major;
 	if (err < 0)
@@ -130,6 +174,8 @@ int kfd_chardev_init(void)
 err_class_create:
 	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
 err_register_chrdev:
+	kfd_fs_inode_free(kfd_anon_inode);
+	kfd_anon_inode = NULL;
 	return err;
 }
 
@@ -138,6 +184,8 @@ void kfd_chardev_exit(void)
 	device_destroy(&kfd_class, MKDEV(kfd_char_dev_major, 0));
 	class_unregister(&kfd_class);
 	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
+	kfd_fs_inode_free(kfd_anon_inode);
+	kfd_anon_inode = NULL;
 	kfd_device = NULL;
 }
 
@@ -150,12 +198,7 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (iminor(inode) != 0)
 		return -ENODEV;
 
-	/*
-	 * /dev/kfd is a single chardev so all opens share one inode. Cache
-	 * its address_space on the first open for use by the reset path.
-	 */
-	if (!READ_ONCE(kfd_dev_mapping))
-		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
+	filep->f_mapping = kfd_anon_inode->i_mapping;
 
 	is_32bit_user_mode = in_compat_syscall();
 
-- 
2.46.0

