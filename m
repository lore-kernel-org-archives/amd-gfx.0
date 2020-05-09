Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED68C47247
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 09:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51755214D8
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 09:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KtBhrWea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51755214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8ED6E31C;
	Sat,  9 May 2020 09:45:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CA66E316
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 09:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOfHNmih39a86bI1nt9v/KFnwiIFofFLs03yK8Le6Zkieck4vmUb/+G10niY14XrPmDql9MZuTxweE3py2+S899HfAL5exDwaf39P309JIVQ/Eu6xSTYmGW1PMPU5RK/HQ4DxTb0795hXF6z2Q4USzwC9ttJCDln3fDycMQnCYZs6XWm7rGxlrH5QMdMEAdHUQJTVpqYyYIFo2Pjo8mdkUUI7tAqCPwk9L7o8Ij9ercd1OezX5U3eYaoSrro1zg3A1dlZvjeMXQJWQv8l6AohdKhaNvczoJDxoBhOF51hFX+1L2iqx1hcDKH4dEMeCm/XyXMCwWbgTP8GnaVUkUm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK9vmEXQUwG2cJf80RJ1oOrcN8MnTZ0L7kSCwcbWk3U=;
 b=fni/jxBsUj7Q8SgkrqO/jGgQ0u+iJTc835q1fXu0Mk0IPNHyeWMXwK+UvpV657Vs23oUswTBr5p8P5MO5p01k19j15RzxoJoDS8Tn9lL3Px9M1LcpEL1thNomINIlT0y4EE0Fi8aqu+TacU2FEG532WdwQPDnZzlZG8tjYsDa2Z6kBuBOKaxjl81juTRQKA8ETXOiB/c2JxjzPlc+6ScVTrdO6LYKQs4nMkkLw5KqFP+elc8+XiCL16Akscad4wIYrCJzgUwJDphOtg8b1/aX+SC3yADq3nf4YlyQghaj20G7vBSdwV5Q9L0IB6yH8Rbg069I2BSessQpKEvR4/KyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK9vmEXQUwG2cJf80RJ1oOrcN8MnTZ0L7kSCwcbWk3U=;
 b=KtBhrWeaEjpF+GT2QcflNZOHihzmviIps6vdLrMeZZ9jE0K1a0WGiEKxWrlq9yzUFnMxovsgQLELPY2QFDwjdOBbKziRaQvzRzSRk4jT7u0sdkdzmOpcpHLX+brKxpWRJUQisd4V3Re6uMTg4/mRo9lRdm02uBsfJd3t2QcKMwM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4002.namprd12.prod.outlook.com (2603:10b6:a03:1ad::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Sat, 9 May
 2020 09:45:30 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2979.033; Sat, 9 May 2020
 09:45:30 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Date: Sat,  9 May 2020 17:45:08 +0800
Message-Id: <20200509094508.28909-1-jianzh@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::18) To BY5PR12MB3844.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (58.247.170.242) by
 HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.12 via Frontend Transport; Sat, 9 May 2020 09:45:28 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea0b670d-d5a1-46dc-a750-08d7f3fdb5e5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4002:|BY5PR12MB4002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB400291083E5F5E36004947EFE1A30@BY5PR12MB4002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03982FDC1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVSiomE8ykB6Kw29uugyriQtxQAUaai3IMIwHT66PxXeoIb34z7LyS9W5H5Hp9qIFNusc+feeYSyfDgrQDhYjwSLYxceoETQ+pmK0YMSntrxf9dJ1+qDWKVI2Qhcjd87x4LLCVX8lgcJB/QV+O+/YzFfT2/dL7NgFrfluxh0EzqJvxXSERxGuZY35WW5QxA512NluW/giTKf5xufrVgtJVufLTYlkBRF2A6oaD7rXk3SRa/as0CLzrCUX8ezVBUdj8pgAc+P85MIcpya8UpO8SLhVN+trGcDMUQDEvKgQdMQszA6iG65uyW8MSSiRTF2Hx9fXXQ8eGwzL7jmG6c+zyIIuH0cdT7V5HjUmSnvwAGwgbVLmZ/NoyYk/5q83R9F3xSjhdu+Gt7KcLqlDdkhL98x+fIF72GDbcwRRqUTvDwXDlr680FraNDJd8QdJ/V2dL9xIp3vwfjx2O5PjhfiZIGLCOAHMVsaKzh9VJlOEHivJUZQWhjtxNcw7oHBQQil/uSE24oLyeCBQY7pwKGdVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(33430700001)(4326008)(66946007)(6916009)(2906002)(6666004)(5660300002)(26005)(956004)(16526019)(66556008)(36756003)(66476007)(186003)(6486002)(9686003)(2616005)(8676002)(8936002)(316002)(1076003)(33440700001)(7696005)(52116002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: K+uZlver4rfGxB2T/ktxkw9AdriscqdnIlbJsiT4xojeQI4D/QOXHzgbZ8Q4oM8CZvp/5FVBuZithnuWmi9Xw3PpuDLfbH68m1S2+bdB6nBOhgWfh/S9orQ+sPNS4MBg6gGb0/8t3gmtHIqsIwRoDb/IVG8pgArIOAW1RGxt6WYTH5vbMT5ItNDWKxHGLU630p/bLS/ewS6TM52VMQu+GBN7Vf4nRFNwJaTEW0/JbT7Nilfd9M3OABFFZ6XMl8ub20p2yZHU4rKVhQOcRRSsbuMXJLY3TvkqFz4R3T8QydF4JaPA6ZVB6b13h8rBuKKHM5Y42V2BaauoBq+A91H6LH1Eu0tMwVaHycRP2PPX9r1ibnbsk5Cq3q0UIh9Eh9GXXApN8YflnONjig59mF/DMdbRk3cPLwK9O3y5494oMohveVFSfRPuUrv9/8ROwfqA3FnVsiKrV/qebhudPyCXKpOWnM9Q+YeBI3IkZtkBg2zWxctCYLt4ZLKoY8cbPAGb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0b670d-d5a1-46dc-a750-08d7f3fdb5e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 09:45:30.3184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATt8UTwPsz946xDmcHhpw+p5Iqfkm4hKDpKTAIMPIM9VTD2wyPNjqqW4zzR1qF3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4002
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
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Jiange Zhao <Jiange.Zhao@amd.com>, christian.koenig@amd.com, monk.liu@amd.com
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
index 1a4894fa3693..261b67ece7fb 100644
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
+	complete_all(&adev->autodump.dumping);
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
+	if (adev->autodump.dumping.done)
+		ret = 0;
+	else
+		ret = -EBUSY;
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
+	reinit_completion(&adev->autodump.dumping);
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
