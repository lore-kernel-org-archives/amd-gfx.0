Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2056AC55191
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D4821569
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x8QO13D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D4821569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBA26E057;
	Thu, 23 Apr 2020 07:54:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895DE6E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikZ8nVmGY9aQp8dvUxzLf0/sUAUJp4J0xhqAIpKmd56rceEA3EVXGm+ZE/ma99FeFOmVGABufhK0apBldSk7o0eqHdmkYktFqZuWmElKYCACLY50uqfNDAnMN5k0hvcqXTVWtOuzWK/tIPGHxQmcUnbTgx8aRdHi5TlaFukJcKiNk3cjOaLKrqDzz8zKTDlEbf+tZMTyr6rHlWLD2IUyQxnNj5vF4h2tNxoGMoXgDdYauW5qyqZGzUmY9GqB+X/oKWTzSXAYQioBzz0qMkMcJ3dDoxjVlXhDRiyZkewf4yFTmDe8S3xOK1xByrVw57MpR7gS4r9AmqJnzKr7n2bWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWBMfRMVOBL2Zhf++UQVMLYpDb5wUT9c2PSftcFkm6Q=;
 b=SpPSL3GmwF65jxOg7a4anbGp57UEXiYfP0N6bK1QnKpO/x28mPEdesm6oruX+3LqxwgXN1eibTk2YeazZbtz4h0BxnhYuJU2gIIGPs6dAC9TQ3FYMZ7vmmDvZih36eG1TqoYBi3o2i019Aj/S9BATwAslykE/w2WThuidpVu2dqb13QOoSp1iYnOHnYOmGgOy61UUx2nQlhwh5IBmLyYQQz2FSjhZ9zrS7H4sDl/bUpT6m9+A0v/RV9xyRYL3NYwBAbPrjPoc3H7ndqSaxSnq5+glppqg7YAMcg5F8wlGjUSLkcA1V0IXJl3BIQYrPe7jaRKxruQXZgfmq6y861wWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWBMfRMVOBL2Zhf++UQVMLYpDb5wUT9c2PSftcFkm6Q=;
 b=x8QO13D1kfSOqIYWXJa1SGZvgZdyl7+W7/90facph4uNzlCkscNZlHBIWmhhN4Yx4nMmFL8SuLsgisukcgA/4N856TX3Gpa/KpFvmBgvdLm/wcM/wf+EVwYOyb40utGxs/oRjM1wdiorL4bZLd343YcEmvrIBdy0RaMWkVD/75M=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (10.175.89.22) by
 DM5PR12MB2344.namprd12.prod.outlook.com (52.132.140.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27; Thu, 23 Apr 2020 07:54:39 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 07:54:39 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset
Thread-Index: AQHWGT+cBLs1BrKebESBUdeGBMUE26iGU6JwgAACiMA=
Date: Thu, 23 Apr 2020 07:54:39 +0000
Message-ID: <DM5PR12MB17084210FA29054678C0BC1484D30@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200423071941.17440-1-jianzh@amd.com>
 <DM5PR12MB17086B8DDF96EA605925575E84D30@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17086B8DDF96EA605925575E84D30@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ccb65a0-76c4-4019-3222-08d7e75b9367
x-ms-traffictypediagnostic: DM5PR12MB2344:|DM5PR12MB2344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2344CA5DE9E12F0FF539570184D30@DM5PR12MB2344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(53546011)(66446008)(6506007)(2940100002)(81156014)(8676002)(2906002)(64756008)(66946007)(33656002)(66556008)(66476007)(8936002)(76116006)(86362001)(71200400001)(5660300002)(110136005)(55016002)(9686003)(316002)(966005)(54906003)(26005)(7696005)(186003)(478600001)(4326008)(45080400002)(52536014)(21314003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bx0rxbXFPc8Yrhlal3ZYnDLTJW15b701CYQ8fFb3Pmt0kpwXABlBc7UF+qb7IEM/Tu6xRBYegUlruB/TzCjaGD7qXHl0SfyiCsUMG2EK0g5q6VJrwudD6hBfqg8qX8pZmxXtcAl7ecfYAwK/CJBraJxf3PTOdBfVUT9WV/HjP+tzrJ6jF5MhYj2wtJgiDYBNaGcMsxuynnn/+3MNog5P5sq2stbU0VveiOjx7mBvn7XHDvCYh9L/tGh05KwkylrpPY9WJyVPBeJslvDT1ELlmsEvy1tp5YoMoStE/IQUQqonDSuaoye20LWfToWNqV1HlYQncAqaXtg8kmkMcBRZf0tdFplBkiQNPFvdF2e/CMqC86r+wSELxkcsL58ACvM3fjXoXqDLpxHEzZ44OUw5YSUpasg4I3lZml4bvR59bYebcWMfWPS+HLiZ2M/O4zYVSE9pn8NuapR1VbITBFjQGnVD6t9PpoEeFu4klZV6KjiAp/TZvMeyWERHOsLFPI6s1tRGweMjQ5AK4UFHL7yk0A==
x-ms-exchange-antispam-messagedata: 3f4bdNjV/s13CbEeUQZjtzjRKDznPINzVzGT3TR5z+iPnHC1bhl6CCkmFoZx9izijbzYZQUBHgymwdimWX/IyxEibqTK189e5DL3UHNVSpx3Cvdy7KsPksVTOxMIuqiS5ngukCnzW2UQYayYu2pUQA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccb65a0-76c4-4019-3222-08d7e75b9367
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:54:39.5419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SjF7TVjVHVzzr+yugzgNE2VfNeJbszhMfjfdjhIBmTcvNVloSAeGSb0BiTeXkAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
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

Oh, looks if the daemon is opening the node KMD don't have a chance to enter the path of shutdown/unload driver, thus no chance to return "kmd unloading" to the app...

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Monk
Sent: Thursday, April 23, 2020 3:52 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C2d5beed35028403ebe1708d7e75b4353%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232251473250650&amp;sdata=SmXKMH9LgbD5K2gkm6Vqysu%2FgvtHLtLoJpJGcLGFd%2F4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
