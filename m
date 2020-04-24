Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA0C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3534920736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UlDR4FGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3534920736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5D86EA96;
	Fri, 24 Apr 2020 08:50:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5BF6EA9D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbgZEafGgm5BbljsxzHmka369EUxRZ6IJ23EoxQWM2L/bTEK8PVjSV8DVyGeWszw9d00LDUQm7Q/3CwPh7dktRFndjhVHdIn393VMWEW2L3A0jS/HYmvSKn/n/IzHyAIsySNkBYK/NvsKeCLBsXaRezkj5c72UsZ1gkjYO0jZjNZYN3as/3NL+3uQ4kMUeEgByMbI1paLoGtbJxPEGyJpmDHID4wL4HTjIr2QCvZXsRdn3PfAbLKsx0YevRSB2yvcjBanEKX35ZKaFEHm+LeINuHOaPmtil9F47bOxYJl13Rt433Lxdt9UU1XgfQWJZFGWSOjWwokcnGwCgXFI71SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faYey4aJlCJahzWLEP8rWGIESGANw+5J/r+XnTwlP6I=;
 b=UBlmpIIrZTlP6to+Nm5fepL+pVD1D5dSeB+d3aS+KQYTtk83GbRRSZiiQDqi9oHU2ZS9L8hWTmEQtrHJ4Yo2Z+APby/X+nuuTa7ZsvXhsAmW3jcq5RTeKl/SzjsojRO30SHozLn7DdfJNvMhp28Q74pvCPxpMQs3vULwYexk6sDD4+Fpot6fGLwErjv3PH2ea4ZRi/H/ma/2jizGfOVq5WWsjO4sOorOgGwODoLR90jC8whhiHPJwjDQn1BsmFs4TJYbVO6IIjzlbWfBA7NHArSVgqvpDVi4uDNNR0xlve8e3zFdvKuMKXC7ml5+l7fURBmxbUPsjk9GPEPDDzdfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faYey4aJlCJahzWLEP8rWGIESGANw+5J/r+XnTwlP6I=;
 b=UlDR4FGlCFnzvXbwCcWHxdkDINRNC2+iUJfmHVZIGdt2kjziVsIGG0tV+Aa+lMooFHMtaTzvHheGLlkgtwZuR/Ug1+ykdGZ2ltAfeaeUqRBn7hcqwWVcY8bCHU9muyXgB3rkzel31Q3PdBn5Fo4pb0nBVuKbywWB2W/Qea69M90=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 08:50:04 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 08:50:04 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset (v2)
Date: Fri, 24 Apr 2020 16:49:43 +0800
Message-Id: <20200424084943.27169-1-jianzh@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To BY5PR12MB3844.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (58.247.170.242) by
 HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 08:50:01 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d69a76d1-ce69-4662-6047-08d7e82c7b1c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4081:|BY5PR12MB4081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB408123C0A99E692188A74790E1D00@BY5PR12MB4081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(5660300002)(6666004)(6486002)(81156014)(66476007)(8676002)(8936002)(316002)(66556008)(478600001)(36756003)(1076003)(7696005)(6916009)(26005)(52116002)(4326008)(16526019)(2906002)(186003)(66946007)(9686003)(956004)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjwduEWwnJEkE3QvzWOeGepvbVx+uBTOZMVcZKWXQoCycdFezwXFsgC/WREeaZ/F2pj4ldwgIpYDBuRDV0oo/eGgxjNRxw0xUWf+GD5KhO/jHJ4Q9Mmw+ideU0ZTAjaZAmZWHEkxcMiV6q/gplGrNbbLHPuD+dVvuB6q6d+MSB3IwE55Ifk8vzP8AsY5D2UBn/xnVjkJUpZBIBUZ4R/TCw8ZWPJHs/M6r9s40nF6kaabId1RtLYHgifo0ec9vHGfRzxWrtm3tenu9XfzwRIOBEddLzcxw0uIPWWJh2+tMeA4p+lF9r13lQJIVCIhsiRl3YtMFve0nlDNslmfceWMvXb9QJ3YQHt/cIOSQ/nwbmYspoqmcdUidF8+kpkwhOuj26/tSBJBM6pb/3G9Z6eMysN7v+f6Lafh1Pmd9YrCQBnR/OzorC8E2yIQazI2vUnT
X-MS-Exchange-AntiSpam-MessageData: 0ArdeI+fp/N39rFnk7htPFtLu4CtxZhwMifLEzTHr8x8dmMgUI0e/q2lqP+YwlCWqZBHqSGXw/s4T3UZd+grPtNXW6lE49v3iosB3W+Yyo2M/FZr2E6EzR3VkTelmxaXpO/+pVXr6Bot1LTFUOVhwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a76d1-ce69-4662-6047-08d7e82c7b1c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:50:04.2514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw6jS3NdVHDcXQ4Llm/Gu7S84N5QwEy8DAiLg7lRMsOpNwsKJx7kV1DFS70rB1o5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bc1e0fd71a09..34b8ce9fba47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -724,6 +724,14 @@ struct amd_powerplay {
 	const struct amd_pm_funcs *pp_funcs;
 };
 
+struct amdgpu_autodump {
+	bool				app_listening;
+	struct completion		completed;
+	struct dentry			*dentry;
+	struct wait_queue_head		gpu_hang_wait;
+	struct mutex			mutex;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
@@ -990,6 +998,8 @@ struct amdgpu_device {
 	char				product_number[16];
 	char				product_name[32];
 	char				serial[16];
+
+	struct amdgpu_autodump		autodump;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..693bfcaad312 100644
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
@@ -74,8 +74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	unsigned long tmo = 600*HZ;
+	int ret;
+
+	if (!adev->autodump.app_listening)
+		return 0;
+
+	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
+
+	ret = wait_for_completion_interruptible_timeout(&adev->autodump.completed, tmo);
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
+	int ret = 0;
+	struct amdgpu_device *adev;
+
+	ret = simple_open(inode, file);
+	if (ret)
+		return ret;
+
+	adev = file->private_data;
+
+	mutex_lock(&adev->autodump.mutex);
+	if (adev->autodump.app_listening == true) {
+		ret = -EBUSY;
+	} else {
+		adev->autodump.app_listening = true;
+	}
+	mutex_unlock(&adev->autodump.mutex);
+
+	return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	complete(&adev->autodump.completed);
+	adev->autodump.app_listening = false;
+
+	return 0;
+}
+
+unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
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
+static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
+{
+	struct dentry *entry;
+
+	init_completion(&adev->autodump.completed);
+	init_waitqueue_head(&adev->autodump.gpu_hang_wait);
+	mutex_init(&adev->autodump.mutex);
+	adev->autodump.app_listening = false;
+
+	entry = debugfs_create_file("autodump", 0600,
+			adev->ddev->primary->debugfs_root,
+			adev, &autodump_debug_fops);
+	adev->autodump.dentry = entry;
+
+	return 0;
+}
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_debugfs_create_all(adev);
 
+	amdgpu_debugfs_autodump_init(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index de12d1101526..9428940a696d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d601d5dd5af..44e54ea7af0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
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
