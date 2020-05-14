Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ABAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 09:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1CA20675
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 09:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pTH6vda9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1CA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14126E2E8;
	Thu, 14 May 2020 09:18:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABE26E2E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 09:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixq2xNn537aZGMGnioR0B1bG4OCxL4HpTiEyxmMikILILDog/VM6uPG44//CZZLIfvfiNzcqlWyCCfbkqGRQVImlQlb/Eq6MAm4DKnlKu4lnKe1oZSG4gUngacKLIwMPz6VWJTop31K7tvqAiOtGm6KQ4A5z9RT9AzkjphpJvKmPqCq94URcKU2nJY31vwTqhrLcxggEHyohMgLcfoKS3+ZHHYBV3xVsFJhE2tador6M35CUatEP/+UOQ1JH3BD+I0oMnX421m2NdNpk6LGpaSHsoQPkfJGUqrW7NR77NQxSiMSAuXv8Ux8Fn5YapEFNVzVRMjPZAcCDnhb4Zz1RMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/1RDV3xzUn+QQ+k6Oy8CmobdUaTp6ZYc2S/MigBYVQ=;
 b=IYLRNg0NBEZUve/UAyP4jVabxJyPICOu7hlA0Pudwrp3GMBytjTOqy1fbtE7Fgjn5j7WmjKQxmxE6hErRvLeNvIA2z2oD1g1IZlPYCcmcUnu/MRqBV9Ul+j5PT8j5BMqPKxbjSHVL0l1VlMuHTcS0xEbFLcUDKfLe/0sMuUjPRC7pDwQGzsS2LkDEfUNS8dE4+Zh8thxT3l8CsNvnNOt5xbJ8wH8uQvqutrtnvkX0yXny8jE9HrDG/1NYFwpiGJMR9Q3VpR79gonQ4ArdIGxcgan3JHK7ECYwHkE2oJRe0bFJMwEJcPWqlSILbKdwvxcD1Q327Gg5wcSZNQAck30+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/1RDV3xzUn+QQ+k6Oy8CmobdUaTp6ZYc2S/MigBYVQ=;
 b=pTH6vda9q3BymEC8R8KT1UNrEeIpXWu7sHMEbU5g62hjYL46pB3LceeNEC+BFRlKURBudjkpKep6YgXQV0jE7BH1kLnVTbzxeMLiMNe9lh9ZIuTMxwyT0HEihwsOeUpn4jU/Q9Cfk5hnkg8mbBmfhrF85QnaULgwcEPKbWaY4p0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5SPR01MB0022.namprd12.prod.outlook.com (2603:10b6:a03:1a3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 09:18:51 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 09:18:51 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Date: Thu, 14 May 2020 17:18:28 +0800
Message-Id: <20200514091828.25155-1-jianzh@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To BY5PR12MB3844.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (58.247.170.242) by
 HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.2 via Frontend Transport; Thu, 14 May 2020 09:18:48 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 184e796f-11bb-45fe-e95b-08d7f7e7d0a5
X-MS-TrafficTypeDiagnostic: BY5SPR01MB0022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5SPR01MB0022989A672CD4FB3643D0FFE1BC0@BY5SPR01MB0022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8AEZzcnjNibj90UOAYBAbQmjYEewz6Vw/KRLJpba4x024PpRn8zR7sWqd1V7FFhQikD4hLDSH7mvd3dnb/gc2WhpcMOkEiDOqXpzbZBPCTAIu54w3BHMwKKMPP4gs/9Dye630ykl3HVB/v9Vz/YB1Funqi3OoswVCJtjdvmDkErF2GBfpK57NDTyWv3L1qKHy4BJ81f/mZ90ZSzL5cskpb0WocIHl5fsL5Rv7VeOD1SshUNTmHfMb8HlQ753GvQ2txX9yCr8rSJX7gdZLIZDU3b53p0nJ8M3YPGkKFbT/JYbR8xPEZhzyOyX+oZrbMAlXtbJrVSRSca3Nm3M7SDlr8OKzpUO1drsHb15nK0V63NMO3B20/InwwAKXmmYLd1twpqct5E5/FbRtIl7+oZLWUYPHJ6+Rqn/N/e7Fc/+PvwXD6DM+8504aampbhB0wp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(9686003)(956004)(8936002)(4326008)(478600001)(66476007)(36756003)(1076003)(6666004)(66946007)(6916009)(66556008)(6486002)(316002)(8676002)(186003)(5660300002)(2616005)(52116002)(16526019)(26005)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /l3Y2vQYpEieG8U7kGn4uy1C8D32F8HF6cLl+XiwkSBUptT2GN5kcWEmgDaAqCnKkkFKRRzgZxHzl7mGBYzrOcnggpxBtCaC6IIu4OYcXeIr4i2Xtv1zsAFh6sLSxRnOORwRKgywMt0R16Ce/um0dc3SgPuCREQHqjUsX6hiaKjzeMfDohDXKZlF0KwfDwm5GK91qhJ3fttvKdnZSLbYqnM1VeSu7zt5eMgvNnZ/eoPYk+7Xh/WJ+6zR38wltFV3V/Ibs8gMgYKgJDZiBT+d95PlHBjcc6+MWmGWnUQzxdvQf/gUSRxjeNkRdzw678wwZarEJi8/ZoyLtAca8wCD41gwVqXj7rG6zk05Egid78pc53m/nfAR3C8t1hJvCz5aTSuR6q9RNSIaTtC6x7O7cswnAPwf8OT5dUkaZlJhQSrAgIzMhodc/AaTyciJjaB66W7z0bWy+pzxiliMpvxlUIIni84xxd8URKiEDGemgwqepDJAY8D5T28e2db09Ah2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184e796f-11bb-45fe-e95b-08d7f7e7d0a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 09:18:50.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJH3B7WiwxUBiEdsfrO1ufSBtZOH5h7+Ty5doCQ3YB/10+4e4ejtYfJC+U6O3kJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5SPR01MB0022
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
Cc: Pierre-eric.Pelloux-prayer@amd.com, Jiange Zhao <Jiange.Zhao@amd.com>,
 Felix.Kuehling@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Monk.Liu@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiange Zhao <Jiange.Zhao@amd.com>

When GPU got timeout, it would notify an interested part
of an opportunity to dump info before actual GPU reset.

A usermode app would open 'autodump' node under debugfs system
and poll() for readable/writable. When a GPU reset is due,
amdgpu would notify usermode app through wait_queue_head and give
it 10 minutes to dump info.

After usermode app has done its work, this 'autodump' node is closed.
On node closure, amdgpu gets to know the dump is done through
the completion that is triggered in release().

There is no write or read callback because necessary info can be
obtained through dmesg and umr. Messages back and forth between
usermode app and amdgpu are unnecessary.

v2: (1) changed 'registered' to 'app_listening'
    (2) add a mutex in open() to prevent race condition

v3 (chk): grab the reset lock to avoid race in autodump_open,
          rename debugfs file to amdgpu_autodump,
          provide autodump_read as well,
          style and code cleanups

v4: add 'bool app_listening' to differentiate situations, so that
    the node can be reopened; also, there is no need to wait for
    completion when no app is waiting for a dump.

v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
    add 'app_state_mutex' for race conditions:
	(1)Only 1 user can open this file node
	(2)wait_dump() can only take effect after poll() executed.
	(3)eliminated the race condition between release() and
	   wait_dump()

v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'
    removed state checking in amdgpu_debugfs_wait_dump
    Improve on top of version 3 so that the node can be reopened.

v7: move reinit_completion into open() so that only one user
    can open it.

v8: remove complete_all() from amdgpu_debugfs_wait_dump().

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 78 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a806cb55b78..9e8eeddfe7ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,6 +992,8 @@ struct amdgpu_device {
 	char				product_number[16];
 	char				product_name[32];
 	char				serial[16];
+
+	struct amdgpu_autodump		autodump;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..d33cb344be69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -27,7 +27,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
-
+#include <linux/poll.h>
 #include <drm/drm_debugfs.h>
 
 #include "amdgpu.h"
@@ -74,8 +74,82 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	unsigned long timeout = 600 * HZ;
+	int ret;
+
+	wake_up_interruptible(&adev->autodump.gpu_hang);
+
+	ret = wait_for_completion_interruptible_timeout(&adev->autodump.dumping, timeout);
+	if (ret == 0) {
+		pr_err("autodump: timeout, move on to gpu recovery\n");
+		return -ETIMEDOUT;
+	}
+#endif
+	return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
+static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = inode->i_private;
+	int ret;
+
+	file->private_data = adev;
+
+	mutex_lock(&adev->lock_reset);
+	if (adev->autodump.dumping.done) {
+		reinit_completion(&adev->autodump.dumping);
+		ret = 0;
+	} else {
+		ret = -EBUSY;
+	}
+	mutex_unlock(&adev->lock_reset);
+
+	return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	complete_all(&adev->autodump.dumping);
+	return 0;
+}
+
+static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
+
+	if (adev->in_gpu_reset)
+		return POLLIN | POLLRDNORM | POLLWRNORM;
+
+	return 0;
+}
+
+static const struct file_operations autodump_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_debugfs_autodump_open,
+	.poll = amdgpu_debugfs_autodump_poll,
+	.release = amdgpu_debugfs_autodump_release,
+};
+
+static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
+{
+	init_completion(&adev->autodump.dumping);
+	complete_all(&adev->autodump.dumping);
+	init_waitqueue_head(&adev->autodump.gpu_hang);
+
+	debugfs_create_file("amdgpu_autodump", 0600,
+		adev->ddev->primary->debugfs_root,
+		adev, &autodump_debug_fops);
+}
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -1434,6 +1508,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_debugfs_create_all(adev);
 
+	amdgpu_debugfs_autodump_init(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index de12d1101526..2803884d338d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -31,6 +31,11 @@ struct amdgpu_debugfs {
 	unsigned		num_files;
 };
 
+struct amdgpu_autodump {
+	struct completion		dumping;
+	struct wait_queue_head		gpu_hang;
+};
+
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
@@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc41e8f5ad14..545beebcf43e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3927,6 +3927,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
+	amdgpu_debugfs_wait_dump(adev);
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
