Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F2C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7752620736
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1sCPcecl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7752620736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143976E054;
	Thu, 23 Apr 2020 07:20:07 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680072.outbound.protection.outlook.com [40.107.68.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C22506E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt3qpj7y3ISruc3O06DrzjCeV1aGRrWtcrobWo+lBgOJlx6jAU1Ogy7Y82AryjVlonrDcZceCWtLs4Iygb8kGcrxvAlZwyKZUvJPzsOfeVW2KI50oKQ7sjQoEJEfvdfU/1JlfcW9b5Sf4/vHLrEtbQbbu/LsQnukdzUDvYkQw2L8l3ti5xXlWxYNdtbPIxnWqM4TQvysTvhfPkMeFl1EyCK/AkG/6hLKiPqUirKIj34FtywWKAah8rS/hvclkAO+w9MtkKHP4KmKyuPKG5uiPVsY74P5Pf8oeOfrXlqw6JpNU1t0abaBpdEsPA9iv/rLSjaA2+p+doOT5m3Cc+WcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyD/PrUPCgsHDNATysCbDVNCukKE1Mnt9aI0ON0oi1k=;
 b=oHCfQNUWmChfYm/84oWdMLkqJ5djfLHe1Kf5AaQ6dK4KNOHvBYzsPx9k9IJ+84Cf/hBIpTCX5QZab06l3Fe9QgQ1poyDAOUq+mIk3IsAaqXIZ1jdc5rIrwgLy8knDlYhTupGbLcU1I/xxb9/vbFUFj+eOuSls/QEA18lw9dVgGcT3Yg4XsKwnw9oQajo96zIw75ewzRGUEpNhd45AoMAU4bNAuYYjSrVQmY5V1+h3f2EXIzQ5dONzNFyx4Agpp7/XeUkKqKCosT4KmPO71G15vuv06PUPxwmWBEfH0CuyqmMSdpU76OKv6uTgQZXi50EI4cidPNI3mhsP8JVzxImhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyD/PrUPCgsHDNATysCbDVNCukKE1Mnt9aI0ON0oi1k=;
 b=1sCPcecloZm78mtk7cQLdZeQlXwDOxV1McW6RaO1pWXXRktD8UjPn4p+7qW3/EIVInrDT9dJmP8KTpywrfUD3VTYXXBxEy8z4CCpO5ruwi943fOdeiDlBUSTAC+c06DVcvCI6OxJSLwswAALHru5xYCV3cOTd5RGUEwramxGqew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 07:20:03 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:20:03 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Date: Thu, 23 Apr 2020 15:19:41 +0800
Message-Id: <20200423071941.17440-1-jianzh@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To BY5PR12MB3844.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (58.247.170.242) by
 HK2PR03CA0058.apcprd03.prod.outlook.com (2603:1096:202:17::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Thu, 23 Apr 2020 07:20:00 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 916d21d7-3317-493b-7539-08d7e756bd67
X-MS-TrafficTypeDiagnostic: BY5PR12MB4066:|BY5PR12MB4066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40660B479A7213FD576E7A46E1D30@BY5PR12MB4066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(8936002)(956004)(81156014)(66946007)(66476007)(8676002)(26005)(316002)(36756003)(1076003)(66556008)(5660300002)(2616005)(6666004)(186003)(6486002)(52116002)(4326008)(7696005)(16526019)(6916009)(478600001)(9686003)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7v1Yixwjd7DirvjI30wk2xANvymfTeRiASePSljKlVE+T+C/x9thTAaH8zynwvrIwKaBhVm5qNkLh6h27BLAzA4Z5e+28Xj+26AQvoR3kCoupR5nYSlycqNCPaHHBV9nPNVwYf2NUJZ11FPgzBCWa0RUqPLz49l9kUeHhDRLcxI5C3sYft4xx3iv3dwC7SfDU7sZGMUGpkIhi0LGIm8bmvHISj2uIBbRekrGA0BViHz64q902MPNoGcOwb1HS3CIlzsZGfVWi6r7wH0ztNTVcmV/eoLJvocVI9nB+ClKU6rmvHc+JCYnV+L0DZntJ3oQNH8bMfm8fVtViJ1g29spgn4PQSy64JzIaWooIOZPtIsg6mFlM910QXaOW7uREy+tks3dxq/bhvLpuWdEYmuJhiNir/SqX3RTJdw7mpuM8HuIbqnzfDfypWOn9NLMvADW
X-MS-Exchange-AntiSpam-MessageData: JE2R36KCQaWB8dVMYO+CawGobtkboqjF17p4qcUFDam4S4Uov7rG20uthlcHwCsSfJDUq7jRp1Fk4/tCmWdG6MEr4F0TrhFZfZ4aecjQoY3XrQl43BWKZrDcTqtWv5GY5YzghhbtTAOgzuyrL1fwng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916d21d7-3317-493b-7539-08d7e756bd67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:20:03.1639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WYdNaci1GEI1ma64/cfexgslfxsC5JA4n1o8rcyO1w2xEF2REI0zkgJiT+DQtLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bc1e0fd71a09..a505b547f242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -724,6 +724,13 @@ struct amd_powerplay {
 	const struct amd_pm_funcs *pp_funcs;
 };
 
+struct amdgpu_autodump {
+	bool				registered;
+	struct completion		completed;
+	struct dentry			*dentry;
+	struct wait_queue_head		gpu_hang_wait;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
@@ -990,6 +997,8 @@ struct amdgpu_device {
 	char				product_number[16];
 	char				product_name[32];
 	char				serial[16];
+
+	struct amdgpu_autodump		autodump;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..cdd4bf00adee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	int ret;
+	unsigned long tmo = 600*HZ;
+
+	if (!adev->autodump.registered)
+		return 0;
+
+	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
+
+	ret = wait_for_completion_interruptible_timeout(&adev->autodump.completed, tmo);
+	if (ret == 0) { /* time out and dump tool still not finish its dump*/
+		pr_err("autodump: timeout before dump finished, move on to gpu recovery\n");
+		return -ETIMEDOUT;
+	}
+#endif
+	return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
+static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct amdgpu_device *adev;
+
+	ret = simple_open(inode, file);
+	if (ret)
+		return ret;
+
+	adev = file->private_data;
+	if (adev->autodump.registered == true)
+		return -EINVAL;
+
+	adev->autodump.registered = true;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	complete(&adev->autodump.completed);
+	adev->autodump.registered = false;
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
+	adev->autodump.registered = false;
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
@@ -1434,6 +1517,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
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
