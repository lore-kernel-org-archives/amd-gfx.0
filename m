Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BFC83006
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 05:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD634206F0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 05:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PgQoOPOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD634206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CE06E1D7;
	Wed, 29 Apr 2020 05:07:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C776E1D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 05:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7hOET3N6tI0wq08X00RoiAvioxeflpzQMA8ZLgn/sZIRxPTHcl9N+fiPFrCvEy6rF//IPiXDXC6K8+5uTfUsYUcPcg/CRW8APK5w/xV/VsBLx+366dV0iYjGihnJ23Q4xK7DnjeeinL3JSUH8aP22tjuk82MBLLK00gPB0aAfWInwjWaYiTWCdCzleQb35isR7qFHT1X4WZXg4IsY5mNDr5MTqive9q4C6FMDxyWzJIoiDyt8MwIPw+0btM50Cv22QtPrMBlOMwywqOvcnQcBZ9g9BrMEQ7fW7XgYMzSvdqjdPeqlQJdngu1+Q1kcp/lnyHzTk00kGeeVBgPzlxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BvmKSRjr4T6WjqUKVdgJuqdrRTNVRH1OWE/pg6dU50=;
 b=W8EU+K2EfxhqBioSHhrEI2mVYKqTxt6QhAiqvT80KUmaFlsGIQCwhRwnV+KGdQZyV4HO9NbgpBvNeLCXAdLiA4dJ7oZD/c/TQwR8NwqwLyAxBEA16pT0uya7m4H1o4EsdXJNA413txfhy5a+bcloyLn9EJ3czDCnxs1NIQHD+U1LLsuvLjpD0AYzZQqiTxTfywvtISx9lCDXs17mv9AZgrRPegnQ5DNK8h5TOWJJ5JL7HI3VEsb3nRidoIQIBhSuNRsxJAZUEeoNcNfmEfhNAr4hFdehV+nTstvDX6arBH69GpOfG3Bf1Akf1eI25zQPAcLLxzvoY6Jhyuft6DPwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BvmKSRjr4T6WjqUKVdgJuqdrRTNVRH1OWE/pg6dU50=;
 b=PgQoOPOPwVrkBaUc01mp0eXhrWjM2X7jjPIqvRcSmAaU/H07DBUtAn/usshEHZcCbtr/VWcepDdLrFJb5DcQ7CgmLvtFtvLxGy51j6QlZYDjy4d9LlE65CJkYXBr0TltJyfRgWF8lYsbB2DIKqNewukDDGkAScVTxpbLT7KAZio=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 05:07:04 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 05:07:04 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Date: Wed, 29 Apr 2020 13:06:39 +0800
Message-Id: <20200429050639.20859-1-jianzh@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To BY5PR12MB3844.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (58.247.170.242) by
 HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.11 via Frontend Transport; Wed, 29 Apr 2020 05:07:01 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2617e6fa-b42f-4b17-5556-08d7ebfb2828
X-MS-TrafficTypeDiagnostic: BY5PR12MB4084:|BY5PR12MB4084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4084E6BBA36C9D7074A0455AE1AD0@BY5PR12MB4084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(52116002)(7696005)(316002)(9686003)(6486002)(8936002)(66476007)(66556008)(8676002)(66946007)(16526019)(4326008)(186003)(478600001)(6916009)(2906002)(5660300002)(956004)(2616005)(36756003)(6666004)(26005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OleeA+5Q3bDuB9pIWq8PWoTxZCQGyAwUdbztjxHwkxom3/SLvpeDH2m2K5VHJTdg0ZyNWmIMcXe+0JVr5C5u+ELdLqtdNeRVnI/X1plm1DT77XJWgxMA/xpbhB8iXkxVBWrwlM28Y7Svpsb3dC8Q2E4ordIi/wGhL9ZJAFZn5mAOIQI9v+Rz2QnrvgIikDqOVJIpKDgGFHh8XMsKRNbekLuAPy8LKSd9uHngr07Myl7mAVQlLXmqM+KrWdL4MbdN9Si6OMNArowoWteJy9oh9wZQSmlnuBif7LgK2POGu33jTgWEMmHI1QiBcCZUudPe72qe4raUML7wVhTQyZHbRExhkPYa2XXWb9Ku2t8+gcpLysZQIWoE06uTyBdqwzIUSgw4QsaccZMQdhzC8iJzANcc7ThvO3gnj8lBk3TQa355h9SFppHbFUPAgF/fdzNH
X-MS-Exchange-AntiSpam-MessageData: uI1XIDHTL7Tc9KW7C4Q0A7AqupDcnkX+5nvdeVGYnr3Lz+rjlH9rBFXmdrtgo1uJjGrwm+6rfeUplaCp4Otqczcr2PJQWTitA77GDFh+rhF1hMyUcBHF33CqpzxE/HbqK1Rx8OPtzLBIXN+91ShQTKk967WgSFOdn1IdQ5LbMClRroLKQpIrmdALHdf7GoTt89E9R/W5xEgTyhEGq3si7mVLB0OxajTK+KzOhv8ebwOnv49rgJL1ZdRW976bNVSPXgzJ6meYYt+WCR3fQN+RB/E5EZjQds/qykasOFWlbiB9kVahI/FT3qiUQ33FfCq66nSvayCuixL9ooqGzYQs5c599bTI5t0KF6x9UIht35DkD4hw2Z8OoOIx3vD2FKlD/TZw5ftRIoi/82Q4JaXlpc/XVFZQ7wfK1fgsXE9kF+KDXzgMsd4IT10u2nv758YcuN0d7PLab5KsA2+2rj0CJeQNDv+DC4a8FEUSVnbZjxDjXhyxD/nvjpTdkKRzOsLP0wnuvz/8DP87kyCjpcBJgTqCGgfT8VWe37qgA102mJijfcd/9xm3XmKLVqOEkH2acYrsFX/l7kcijPbuTDGBad339BO7FDMG27p+IV/LLbJBXfYRrG5adnZ3qS7n2ck1/gZc7bSM9MMbt2lsIugY7ytLG5VfKknsA3+UKYPqOqdVDWfsqKEU+kBj1a+te5rD8wfOjyYDJH6YRtMiJqKCqBqNAX0q5fE0pDOkLFDMm4rDA6Tk8RQRZB+IAvJk/Ftdkto0R/27E9mZkfEHD6q5s8IrfINkc0ZON5EZljFG/tE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2617e6fa-b42f-4b17-5556-08d7ebfb2828
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 05:07:04.4931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF5EU9uBG5iXK5b2pBhoTarnQS1SyurIlMPdMxzjLo8QYlI2AT5xNJMe6xJTSip0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 14 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 109 insertions(+), 1 deletion(-)

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
index 1a4894fa3693..1d4a95e8ad5b 100644
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
+	unsigned long timeout = 600 * HZ;
+	int ret;
+
+	mutex_lock(&adev->autodump.app_state_mutex);
+	if (adev->autodump.app_state != AMDGPU_AUTODUMP_LISTENING) {
+		mutex_unlock(&adev->autodump.app_state_mutex);
+		return 0;
+	}
+	mutex_unlock(&adev->autodump.app_state_mutex);
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
+	mutex_lock(&adev->autodump.app_state_mutex);
+	if (adev->autodump.app_state == AMDGPU_AUTODUMP_NO_APP) {
+		adev->autodump.app_state = AMDGPU_AUTODUMP_REGISTERED;
+		ret = 0;
+	} else {
+		ret = -EBUSY;
+	}
+	mutex_unlock(&adev->autodump.app_state_mutex);
+
+	return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	mutex_lock(&adev->autodump.app_state_mutex);
+	complete(&adev->autodump.dumping);
+	adev->autodump.app_state = AMDGPU_AUTODUMP_NO_APP;
+	mutex_unlock(&adev->autodump.app_state_mutex);
+	return 0;
+}
+
+static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	mutex_lock(&adev->autodump.app_state_mutex);
+	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
+	adev->autodump.app_state = AMDGPU_AUTODUMP_LISTENING;
+	mutex_unlock(&adev->autodump.app_state_mutex);
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
+	adev->autodump.app_state = AMDGPU_AUTODUMP_NO_APP;
+	mutex_init(&adev->autodump.app_state_mutex);
+
+	debugfs_create_file("amdgpu_autodump", 0600,
+		adev->ddev->primary->debugfs_root,
+		adev, &autodump_debug_fops);
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
index de12d1101526..51b4ea790686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -31,6 +31,19 @@ struct amdgpu_debugfs {
 	unsigned		num_files;
 };
 
+enum amdgpu_autodump_state {
+	AMDGPU_AUTODUMP_NO_APP,
+	AMDGPU_AUTODUMP_REGISTERED,
+	AMDGPU_AUTODUMP_LISTENING
+};
+
+struct amdgpu_autodump {
+	struct mutex			app_state_mutex;
+	enum amdgpu_autodump_state	app_state;
+	struct completion		dumping;
+	struct wait_queue_head		gpu_hang;
+};
+
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
@@ -40,3 +53,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
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
