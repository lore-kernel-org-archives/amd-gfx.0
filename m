Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B7C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4BD21569
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cF6DJV/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4BD21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DE06E15E;
	Thu, 23 Apr 2020 07:52:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214FA6E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVfi3HKWPw8ywpC0I4f1qHCs6f5AxAXYmjF/P82OhETRmbKWjCbyQylCETV6EGCrlreUJVg22+/XyYo4BSmVnJl4DoEW5ys5Hr6dbW15jhrzPMnEdGWO8mo8y2SnUTlUxPPVKoFV6auXHK7RjE0JHNzNgBtt29tsg6TbWsYD2n0AtrBuwliOk+vBNKZnByhP6iUkkyQRvPf5ACnmHUoo2if8QzAUDCFanrdd7Zo59npdppV20VWKHB5AOvAZ2SUEU3TIaPb82l33yaGkTSpFJm5aqGGB3oxAHbOpg8kgpvPN3mDEQxcjeOjGcvKt/QWVWeCv4+78mRJ+xgeiT31Zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQh9IjbfBTp5bZKQDlL53SQttlVN3eK5hQTKwgH7Z8Y=;
 b=KKCma+0RZ1ovpt5q5iyAnRtNY2fi30fQz0r2fUDZQwUciwXgHqgSjdfcR4PxrQ+oGQNLA8C8Lnb7dhxnyI26pDMB4EZfhjgYUCr+Eb5gAn2KQofgkCOGbmqA/UR2TWoUiSvJyBh/HfVUjCNCA0bE8VdeXFOLKpUKCAog40rmya7WvZ7gQRVdA34cU2R4pWr8cI/6fUZqOub/eIvH5OkVRycntIVIAOK3/HVrX9jOy6M88YwwmCMxFSnbdZAlGk+T5J5g2nY6CPCtWNqfXdc25lakiwQ5agq8DRjr0HB153tVTdsQY2d0u6Tv+8pri3pk+/8QhhBYfohaF7cHxUHs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQh9IjbfBTp5bZKQDlL53SQttlVN3eK5hQTKwgH7Z8Y=;
 b=cF6DJV/RCTNNjMDOfKgsgMML3gYuMbWNA8SwaLrxVy4o9+Lr4oR5375GmTZCblsJjLinkAlfPv6qdUtjX+XizK8g9YKD4uPJzAdnqJPvx+m7pbtDkcvAbJ5KJvzQ5ept8xJeucFj1njsbSUbaAeSMizQmR15d5FJWuH8pxPVZgU=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 07:52:20 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 07:52:20 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Index: AQHWGT+cBLs1BrKebESBUdeGBMUE26iGU6Jw
Date: Thu, 23 Apr 2020 07:52:19 +0000
Message-ID: <DM5PR12MB17086B8DDF96EA605925575E84D30@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200423071941.17440-1-jianzh@amd.com>
In-Reply-To: <20200423071941.17440-1-jianzh@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc0cb7ce-1b5f-4674-3dfd-08d7e75b402a
x-ms-traffictypediagnostic: DM5PR12MB1737:|DM5PR12MB1737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1737EC26F37CAE77BD88EB0D84D30@DM5PR12MB1737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(316002)(9686003)(55016002)(186003)(52536014)(4326008)(71200400001)(5660300002)(86362001)(33656002)(478600001)(2906002)(8936002)(81156014)(8676002)(66476007)(53546011)(76116006)(66556008)(64756008)(54906003)(26005)(7696005)(6506007)(66446008)(66946007)(110136005)(21314003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkwyXD9xJLUDi+lyPoznoRJjdawa7ZS09C9GHDJFyLFTiXy5pTXDFfg2UXSLoLoT6oHfvEPgSHA7HhKBCTwYWuy5KG6jzPJeFUvTf9CI01+c1NyhI5ozyFMIFV/NKbn0b/MT5bmqXBGKc8A5419/exv+r+o/hm28gHTuZgzfvdVI13ehYGdQcC1ZzyAm8yXlOOFnWUBIj5aJAhbGqLVsNjJvrCEkx69IxD1yAf7ZEHo27qVTzmPobACT+sTSBod1TCihpPzU7tY5Hk4YJUnndCYTIn65GQGN0l3h571dvJJKy94l00b1J+3P8M7kWTzYeby450uJJKsU6QsnhReoAXnqM6G0CFnWkBS9uj9l/fs1l3Vzi2BeOt/JM8Z91JP1ZH+XLq+yQ3zedrfa0nuV2JUG+OcUGYTUv+CFtjTVDEWfYgF5vwVyhDUb6BxFY2xGWqkb2h/qIZn5C1zGIxlMcjjLRIrkoItZfP56Tg7X+qUigANxzzLuTC/rbQ+SH5f9
x-ms-exchange-antispam-messagedata: xMKZXjOz3Bu6TR1pNC7cGA9OSqPuDLpY48i++lpu/OcgfqFuGWkjfL4g0u/bE5v6gW6ZrYmmFYKwMDVXblbow7QrsOwlxuo2BArylttXxbrwJLa6yCLvYqmv2ZajuLf2hln+DLl/h6VSU3ai3PkgwA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0cb7ce-1b5f-4674-3dfd-08d7e75b402a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:52:19.8855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2Gv9ArAnRkDZAOAnqrI9zh+k8hc99HOkFSa4vrWZ9zf0eTTP2/eC5ZFSZQCzmID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian 

Do you think we need to kill the daemon app if we do KMD unloading ? usually user need to close the app first and then the KMD could be unloaded 

If we don't want to manually shutdown the daemon app we can do a "KILL" signal send to that process, or we can implement "read" and let app call "read()" to fetch information like:
1) xxx process hang
2) kmd unloading

And daemon can close() the node if it receives "kmd unloading" instead of doing the dump 

Thanks 

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Zhao, Jiange <Jiange.Zhao@amd.com> 
Sent: Thursday, April 23, 2020 3:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset

From: Jiange Zhao <Jiange.Zhao@amd.com>

When GPU got timeout, it would notify an interested part of an opportunity to dump info before actual GPU reset.

A usermode app would open 'autodump' node under debugfs system and poll() for readable/writable. When a GPU reset is due, amdgpu would notify usermode app through wait_queue_head and give it 10 minutes to dump info.

After usermode app has done its work, this 'autodump' node is closed.
On node closure, amdgpu gets to know the dump is done through the completion that is triggered in release().

There is no write or read callback because necessary info can be obtained through dmesg and umr. Messages back and forth between usermode app and amdgpu are unnecessary.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 85 +++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
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
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..cdd4bf00adee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -74,8 +74,91 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if 
+defined(CONFIG_DEBUG_FS)
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
 
+static int amdgpu_debugfs_autodump_open(struct inode *inode, struct 
+file *file) {
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
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct 
+file *file) {
+	struct amdgpu_device *adev = file->private_data;
+
+	complete(&adev->autodump.completed);
+	adev->autodump.registered = false;
+
+	return 0;
+}
+
+unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct 
+poll_table_struct *poll_table) {
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
+	.release = amdgpu_debugfs_autodump_release, };
+
+static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) {
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
@@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,  int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);  int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);  int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
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
