Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBCFC55199
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 10:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FDA2071C
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XfC37qUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FDA2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C5789FA5;
	Sun, 26 Apr 2020 10:10:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E566489FA5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 10:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt9XF3+xYPwoeUzxsaaiMc3N8pR8M0NSEN6u1On8aCwSguKGeRO3f8iuDu3jgq7aZZLwds7332iVJKmtB1PGUtNFUkVLcUTa9dX4MBkFdgp8dwUSMqaZ5Fhfq38fCIRtmb9R4+xikITnbBzSJYvHshKCiaHBE5+qUeNemJ6uIXI7dO5Jx113V99Nf34FaxbqjQysYAqRw008sI7qVI7oMIM7c78/PhC1EWQ5DaVJSfDzXPTV2O669vZaKIUWFDjv/NGjPT1qpgqh8uTsdZwUHOGEpR8+n2q9t4d0UdM2CO30Rd1p6TZphxNzNJ379ftDvRRXWYFZXhN5S/uziQRmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD739AEsLtJeOSoy7bLJhztJ5X4Kndr07wEyrmaIdxs=;
 b=RRPzbkDoDL1R4JHqBbOH/ulYH4ITb8vjX6uqY7pWSsRKNZkwayZY9kS+xNCVzrofOSm4nNnLdYoZoTTs2xAIYfTaE88WMz3ElTIYOydBp3X9nk9vwR59g5/9iLSxzxQ9xvy8k9jle/iOkXJl2JxuAx4/Dcv+NrFRdGKqTEW6d9MKn+ssV3jwNatP8bkJ1+FgbOLhBfZ0IIyInN4v5cnbdPhQqgq+51FXGokvBK5TyrTyYPSc9PJycsRRYS/RsERUDqmRlBg9HoVEKhtIEjQ/DqY+sEio39uAnkl9pjzJJq9sAKRV7Dt8ORsSIUZbB32Y1/bZQkuDYk19ee93AJ8ZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD739AEsLtJeOSoy7bLJhztJ5X4Kndr07wEyrmaIdxs=;
 b=XfC37qUBpSRj3V1pNxXqo7bURVcPE3Maowr+t+PG3H8A7MkUMpc18PkN/pyea7lErIMxuN4s921/10Y4fsG7aEmuUBT9Og+zHuAAyn0TGKiRkdh67/ByDXPOAcmiL0bNe5x1FuZ8vge0iVdsdo3AJNzWvFV6SU9v34ij7sccWWQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 10:10:05 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 10:10:05 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Date: Sun, 26 Apr 2020 18:09:45 +0800
Message-Id: <20200426100945.17066-1-jianzh@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To BY5PR12MB3844.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (58.247.170.242) by
 HK2PR02CA0127.apcprd02.prod.outlook.com (2603:1096:202:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 10:10:02 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10a60f57-207b-462d-ad2e-08d7e9c9fd87
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:|BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39390C2B9E87800ED327DE10E1AE0@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(81156014)(2906002)(478600001)(956004)(66946007)(2616005)(5660300002)(9686003)(66476007)(6486002)(26005)(6916009)(66556008)(7696005)(186003)(1076003)(36756003)(8936002)(16526019)(6666004)(52116002)(316002)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gdwjgft3f9IEQt+9RuGDTAlkFT+zeW9nX0zXjSlMLFQd/pYSGBKFVMVioKYdihRHJJGEIa1V6FyzpcXAa2S29EQzESYH5ht8I9U2WkUzfqr4tVix4Qh2nEAa9ELMrkYMyty8zFozCXQpwwwlYzaq2NughTyqtQZ/vr8WHmKzekofhujQT511rxRNPMq6cT4oC4K2dQW1uu4pzwuSNbub72qfb0OTnU0cAyO/ksYkbgONhbZ0h7jud/I55hZfKOb3WSw5e2KLfBZ4MNDrS+FndpIR70yD4rSjPkxY5vqKaAcMUpGqiSM4zs4G+l3Gk+hWJtpgv3SiTrWZ15Bh6famMlNaeJtHPkuT01ITP6a+k6C8XC5FtuC/SuNxvIepElGLPfAuD9ujGNVf831QKOR8s/fccaXhTuFbnzuYi0s/VfK9zk76izyioUktME039Zfd
X-MS-Exchange-AntiSpam-MessageData: 34dV9OUbZGW2ocDwbvS56ome4K5I/ZL4hPnHWytdB6X3Id08TwGeAf42xtwmJ6NOXaMnmOIL6lufcAN8N4XwQ1qZbRMCE41jFMoV/uznahgymSVVKZeUnbePkPRxu6p0pFDuQtUHcs438pAMGMqqvxmMNm3xgjhIwJrWtEqhyVss9ym6uMQq0e8ic6TaFWs+HH8srPYBjcxnvyubpJV2wI+SUC1Y+osXOfJfKDpnexlGWJ4+0vitzjm/MASgJvdU6lOMkzP1zYM5UoaL+qDfzc174mluXsZHsocXqZudrPH/5xNgLNcQy66lpi9GRi39QtMDlVw2mcwKRIqOvMC9v5h/+lJ7VvMV8FqLGvod26Gw9RND6Suh+AiT3fa6ksdMFKflV5pqEBheq7awMmAX96uUW+O6pj/NHSK0VwImJjmopVbl2IaffZPZGiNZLG4j9KwOdJqwJtRutYhay9CwnqiQYhVJ5UMFNDhyW2DPTRFKCRQWn9Kv0tP8dKEgzmnFLrlEe6C5scOqZrRAiDjYkI9DF6f9Ws/oaFP2aIbx6SfM/M3Q8ZhJO6OSKE71cbrIp4ecAXxmh9wO/gkGPdflATofKSZ6KPAcw4HXxZ9P/oST0DQSl+kDJho1DzMPiybdetGVWs5Y/Ve6/sO0e7WNdqwJm4Ka3DO6f+LH7U6ekbT7y+4Kk+WvhHGox9tL0RcR8N21DeeFda/wZZx3uyMwcGuaivxyorEJQVDgs+6UB7gMAAF7C4CabTClLfcsdS+nRZXC+LwYKT3v+wfbS8FNQtEwDxzRQGPXiOcpKXTa2Ew=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a60f57-207b-462d-ad2e-08d7e9c9fd87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:10:05.0148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRbUFCv5JoBUJyYgbqmdTUXWEXTVMemOYVar9RgW931/zYHh4HmW7mSshR+nT0cD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
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

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 82 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bc1e0fd71a09..6f8ef98c4b97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -990,6 +990,8 @@ struct amdgpu_device {
 	char				product_number[16];
 	char				product_name[32];
 	char				serial[16];
+
+	struct amdgpu_autodump		autodump;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..04720264e8b9 100644
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
@@ -74,7 +74,85 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
+{
 #if defined(CONFIG_DEBUG_FS)
+	unsigned long timeout = 600 * HZ;
+	int ret;
+
+	if (!adev->autodump.app_listening)
+		return 0;
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
+#if defined(CONFIG_DEBUG_FS)
+
+static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = inode->i_private;
+	int ret;
+
+	file->private_data = adev;
+
+	mutex_lock(&adev->lock_reset);
+	if (!adev->autodump.app_listening) {
+		adev->autodump.app_listening = true;
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
+	complete(&adev->autodump.dumping);
+	adev->autodump.app_listening = false;
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
+	init_waitqueue_head(&adev->autodump.gpu_hang);
+	adev->autodump.app_listening = false;
+
+	debugfs_create_file("amdgpu_autodump", 0600,
+		adev->ddev->primary->debugfs_root,
+		adev, &autodump_debug_fops);
+}
 
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
@@ -1434,6 +1512,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_debugfs_create_all(adev);
 
+	amdgpu_debugfs_autodump_init(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index de12d1101526..72f6fe5c7596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -31,6 +31,12 @@ struct amdgpu_debugfs {
 	unsigned		num_files;
 };
 
+struct amdgpu_autodump {
+	bool			app_listening;
+	struct completion       dumping;
+	struct wait_queue_head  gpu_hang;
+};
+
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
@@ -40,3 +46,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e6978a2c26b7..8109946075b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3912,6 +3912,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
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
