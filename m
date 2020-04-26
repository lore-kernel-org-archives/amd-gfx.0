Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B5C55199
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 10:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4138F20700
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 10:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DKufZXw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4138F20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C016E233;
	Sun, 26 Apr 2020 10:16:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4EB86E233
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 10:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IULSHyxyrGcUkcg/KlBuvEWC04mDBUJVYDGMbeGnPdOQXyHG2oF/IkiipSAqyjlphp6uM6ldwX2i7qtEy2QamD+OBwSM0f+ByY1B9yO16GvD9Wi0az+CijH40/9Ref++zH80Lu/o4yLz/s3Y2ptcIYRfxzJRzTVui5nKTgjJaOzxwMdMaoP+tz38fXz5MQLtGJgAHkgYBv0BxZXf5CWixWvda0K+Hxi5v73/cFg5+BdnydZvLea9XNt0RODvHQn26b2Oqh+UukV2KWoSdifiBjqdjBxmuzCirPAjsinkEfURfaRS5ZAPKBJfQfq+Me9xF+HX8Q85RzAlqDslmNgjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGWk3+9BUBOubp/BaFhj5Qrq9dc99FE+2SWOaPKF16g=;
 b=d5iqusGBC4fTX/5SZNVDRl+BnDhKrrlDE992Y065OBOIiAQyldNP9vhz9HXGsU0wwjxZKvkgga+5eWRS9ZkUSjcSygIM3sBk3opZChMhngPsI52dD6tDvNSlyY+dCzBP+7dbMswpo86x/jg7OCbXIercK1pIi1yjUQTd5JuShBa0MLgziUK7HsncXN3sMr2ZpGVeAM8/+ydmau/9eDN+a8G6+m/JtkM/kiwdlLD4ynkMntDMlOPw7xzbtPzIeQ5cVpcJ1/AksPIwu3F7b9+1ZJJZekdNEtMIlk4XRaXaYGFc44RA1qdF6lV+z/9xq4up7bW8DIN+Q1JmWY9Tz5i2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGWk3+9BUBOubp/BaFhj5Qrq9dc99FE+2SWOaPKF16g=;
 b=DKufZXw372GQpHTQO7QOnJKjjsA6T6XAMOFCEP3rZG/XIMoEBGJp5STCsye/jRzMInXygDeD1A6414QnrtOllFP9z3GL3T9teVMB8Z8xy2I47lqDaudKWoeRmbLgLXZPzMUDTBMqPOanPtlSOYd4Cc0bDg29cQ0vz5L6qPjF3ak=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 10:16:07 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 10:16:07 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v3
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v3
Thread-Index: AQHWGi4oJUotftJUdU+szN6XWPJESaiLMWdn
Date: Sun, 26 Apr 2020 10:16:07 +0000
Message-ID: <BY5PR12MB38449E957A02F61FF88D9ACEE1AE0@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200424114734.30584-1-christian.koenig@amd.com>
In-Reply-To: <20200424114734.30584-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ckoenig.leichtzumerken@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-26T10:16:04.876Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8b4c08d-5c86-4aa4-822c-08d7e9cad5d9
x-ms-traffictypediagnostic: BY5PR12MB3939:|BY5PR12MB3939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3939F4C2627130E30284900BE1AE0@BY5PR12MB3939.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(7696005)(6506007)(53546011)(186003)(316002)(8676002)(4326008)(66574012)(8936002)(5660300002)(86362001)(110136005)(9686003)(66476007)(66446008)(91956017)(71200400001)(478600001)(81156014)(2906002)(66946007)(19627405001)(52536014)(64756008)(66556008)(55016002)(33656002)(6636002)(26005)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kai3da93TK5WIgSiK5EX/zr33WtlSW70JJyNbcTEvMj6Ipg9nlyc8K5mNMUH9QOUU0wqS3F99++XeMvVK+8qNHU2lQRzeouJrAzT56SNQiw2dVSHi2usJlma9Ahvcl1NT1sPPH8sOiAFQoQCN/6ITt3w96HroWuFlDPINGzylIyXhbMui9JWDceIAiULVUY5a8rUJHKfcS3lNL/9amRQKp27da2Xz01vVDu22kVsd4E0s3saf5FxRDbn8utTVjkR2IPrTxyRrYZG6PinynzFgZiiu44/EEKzskTh9R0fQGgNzqv9HX0OSlmWO6n6TWYn1Pc70WQJeIjEme0fCfomiGgp14bS9FSfFV0MT2F8YY4qbSaRUxtmp1ostR8UVtTkTImV5zYxkm9PBQNaXh4ZwFPyC2hzyRUpDG+9fWlhvMM4gC26uXjtOdFjirFZGPD4
x-ms-exchange-antispam-messagedata: IcSaRsEw90MQ+6pjUEg/llOKghXElK8TIktW/N/Cw85qUG+CFVrGe2A8c2hFB/oxmuP+gjz9GhtJj0nh5lamufzbn23mI9nOXoW1DKg6tPljDNjOVj34CAAPboTEZ5mxZYGsT6ac5kAnEzn+xPeTwFEgJna8Ct6AyIRALtzd1WmK586l0Mr3AmqkLM9COWldb2CoedmMEZYTQ1q7c1h+v7I7hXGkYYoF+PvInbyA97o6rb9JL/64KSAkIFhwuIvHv0p3KQ5i9nGqhrQf7YEZtLSCVSIIpiDzpy7m9JY++M5cImv0dmWj5a00OiT1aIpeqI1Zmmz2PFqXax5BvpD46Eo2BLMeMsqeytthAg1HZGu3QBgwaHJlNj7VCRoStFhAizP6Ru8BIwULgBldm9SzvwmicH9BkTT8xbv2Q843uwqb6fHM966LaEz2aIftvqznCfk1NKwWUJRRC0fOeg9B6XexteiViJ9m6vfMXpLMVV/rwbOxz5Hw/9INLmPvggK3c3Q3Rkz9ge12llpPxM0Zqa5Oqd+zUw8UnOQC66u8ZOZU7OxW5ycDqyVUrrZ/PjNtrYDOPNhNDwnqmPoCu2HgZORFtN4ycJl1dKanu7S/vspMMi/WitCZ9EY+lsuNt7HVJE2mr89VFYv5lytTRXnH3GkFxVAzugA2sL/ePk4K8VJJTKhpRSMe6S1VUSFVmoZnyKpqHzmo6Rmp+Fhzn2/aZuPIWt2Bn49Usu1t+chvbN/2n+Ib+NMfoTG2pE8ZdwXmT1qo3GY3iA4OhGUBzgE9204YhF5AnSGejU6NV1cTJH8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b4c08d-5c86-4aa4-822c-08d7e9cad5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 10:16:07.4173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrMuDjLbUtMK8pO+I9+wjJBXT3+yE/M1O/ZfyS309kvVxoKbO910TcHgXOssA/WP
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============0348703212=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0348703212==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB38449E957A02F61FF88D9ACEE1AE0BY5PR12MB3844namp_"

--_000_BY5PR12MB38449E957A02F61FF88D9ACEE1AE0BY5PR12MB3844namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi @Christian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>,

I pulled your patch and tried it. And I have some doubts:

(1) I can't fully understand the functionality of read() in here.
(2) amdgpu_autodump can't be reopened. Because wait_for_completion_interrup=
tible_timeout() would decrement autodump.dumping.done.
(3) When there is no usermode app listening on this node, amdgpu_debugfs_wa=
it_dump() would stuck and reset can't be performed.

So I made some changes on top of your modification as version 4. Please hav=
e a look.

Jiange
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, April 24, 2020 7:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Pelloux-=
prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Zhang, Hawking <H=
awking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Z=
hao@amd.com>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v3

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

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index bc1e0fd71a09..6f8ef98c4b97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -990,6 +990,8 @@ struct amdgpu_device {
         char                            product_number[16];
         char                            product_name[32];
         char                            serial[16];
+
+       struct amdgpu_autodump          autodump;
 };

 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *=
bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..b1029d12a971 100644
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
+       const unsigned long timeout =3D 600 * HZ;
+       int ret;
+
+       wake_up_interruptible(&adev->autodump.gpu_hang);
+
+       ret =3D wait_for_completion_interruptible_timeout(&adev->autodump.d=
umping,
+                                                       timeout);
+       if (ret =3D=3D 0) {
+               pr_err("autodump: timeout, move on to gpu recovery\n");
+               return -ETIMEDOUT;
+       }
+#endif
+       return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)

+static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *=
file)
+{
+       struct amdgpu_device *adev =3D inode->i_private;
+       int ret;
+
+       file->private_data =3D adev;
+
+       mutex_lock(&adev->lock_reset);
+       if (adev->autodump.dumping.done) {
+               reinit_completion(&adev->autodump.dumping);
+               ret =3D 0;
+       } else {
+               ret =3D -EBUSY;
+       }
+       mutex_unlock(&adev->lock_reset);
+
+       return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode,
+                                          struct file *file)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       complete(&adev->autodump.dumping);
+       return 0;
+}
+
+static ssize_t amdgpu_debugfs_autodump_read(struct file *file, char __user=
 *buf,
+                                           size_t size, loff_t *pos)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       wait_event_interruptible(adev->autodump.gpu_hang, adev->in_gpu_rese=
t);
+       return 0;
+}
+
+unsigned int amdgpu_debugfs_autodump_poll(struct file *file,
+                                         struct poll_table_struct *poll_ta=
ble)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       poll_wait(file, &adev->autodump.gpu_hang, poll_table);
+
+       if (adev->in_gpu_reset)
+               return POLLIN | POLLRDNORM | POLLWRNORM;
+
+       return 0;
+}
+
+static const struct file_operations autodump_debug_fops =3D {
+       .owner =3D THIS_MODULE,
+       .open =3D amdgpu_debugfs_autodump_open,
+       .read =3D amdgpu_debugfs_autodump_read,
+       .poll =3D amdgpu_debugfs_autodump_poll,
+       .release =3D amdgpu_debugfs_autodump_release,
+};
+
+static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
+{
+       init_completion(&adev->autodump.dumping);
+       init_waitqueue_head(&adev->autodump.gpu_hang);
+
+       complete(&adev->autodump.dumping);
+
+       debugfs_create_file("amdgpu_autodump", 0600,
+                           adev->ddev->primary->debugfs_root,
+                           adev, &autodump_debug_fops);
+}
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

         amdgpu_ras_debugfs_create_all(adev);

+       amdgpu_debugfs_autodump_init(adev);
+
         return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
                                         ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.h
index de12d1101526..3504c48e1564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -31,6 +31,11 @@ struct amdgpu_debugfs {
         unsigned                num_files;
 };

+struct amdgpu_autodump {
+       struct completion       dumping;
+       struct wait_queue_head  gpu_hang;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3d601d5dd5af..44e54ea7af0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu=
_device *adev,
         int i, r =3D 0;
         bool need_full_reset  =3D *need_full_reset_arg;

+       amdgpu_debugfs_wait_dump(adev);
+
         /* block all schedulers and reset given job's ring */
         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                 struct amdgpu_ring *ring =3D adev->rings[i];
--
2.17.1


--_000_BY5PR12MB38449E957A02F61FF88D9ACEE1AE0BY5PR12MB3844namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi <a id=3D"OWAAM395946" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nl=
r ms-fcl-b" href=3D"mailto:ckoenig.leichtzumerken@gmail.com">
@Christian K=F6nig</a>,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I pulled your patch and tried it. And I have some doubts:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
(1) I can't fully understand the functionality of read() in here.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
(2) amdgpu_autodump can't be reopened. Because wait_for_completion_interrup=
tible_timeout() would decrement autodump.dumping.done.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
(3) When there is no usermode app listening on this node, amdgpu_debugfs_wa=
it_dump() would stuck and reset can't be performed.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
So I made some changes on top of your modification as version 4. Please hav=
e a look.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jiange<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, April 24, 2020 7:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Pelloux-prayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;=
; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.=
com&gt;; Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset=
 v3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
<br>
When GPU got timeout, it would notify an interested part<br>
of an opportunity to dump info before actual GPU reset.<br>
<br>
A usermode app would open 'autodump' node under debugfs system<br>
and poll() for readable/writable. When a GPU reset is due,<br>
amdgpu would notify usermode app through wait_queue_head and give<br>
it 10 minutes to dump info.<br>
<br>
After usermode app has done its work, this 'autodump' node is closed.<br>
On node closure, amdgpu gets to know the dump is done through<br>
the completion that is triggered in release().<br>
<br>
There is no write or read callback because necessary info can be<br>
obtained through dmesg and umr. Messages back and forth between<br>
usermode app and amdgpu are unnecessary.<br>
<br>
v2: (1) changed 'registered' to 'app_listening'<br>
&nbsp;&nbsp;&nbsp; (2) add a mutex in open() to prevent race condition<br>
<br>
v3 (chk): grab the reset lock to avoid race in autodump_open,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rename debugfs file =
to amdgpu_autodump,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; provide autodump_rea=
d as well,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; style and code clean=
ups<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 6 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;4 files changed, 101 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index bc1e0fd71a09..6f8ef98c4b97 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -990,6 &#43;990,8 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_n=
umber[16];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_n=
ame[32];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[16=
];<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_dev=
ice *bdev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 1a4894fa3693..b1029d12a971 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -27,7 &#43;27,7 @@<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
&nbsp;#include &lt;linux/uaccess.h&gt;<br>
&nbsp;#include &lt;linux/pm_runtime.h&gt;<br>
-<br>
&#43;#include &lt;linux/poll.h&gt;<br>
&nbsp;#include &lt;drm/drm_debugfs.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
@@ -74,8 &#43;74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;#if defined(CONFIG_DEBUG_FS)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned long timeout =3D 6=
00 * HZ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;adev-&=
gt;autodump.gpu_hang);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for_completion_inter=
ruptible_timeout(&amp;adev-&gt;autodump.dumping,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;autodump: timeout, move on to gpu recovery\n&qu=
ot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;<br>
&#43;static int amdgpu_debugfs_autodump_open(struct inode *inode, struct fi=
le *file)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D in=
ode-&gt;i_private;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data =3D adev;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;lock_res=
et);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.dumping.don=
e) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reinit_completion(&amp;adev-&gt;autodump.dumping);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D -EBUSY;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lock_r=
eset);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int amdgpu_debugfs_autodump_release(struct inode *inode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; struct file *file)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D fi=
le-&gt;private_data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete(&amp;adev-&gt;autodump.d=
umping);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static ssize_t amdgpu_debugfs_autodump_read(struct file *file, char __=
user *buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size, loff_t *pos)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D fi=
le-&gt;private_data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_event_interruptible(adev-&gt=
;autodump.gpu_hang, adev-&gt;in_gpu_reset);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;unsigned int amdgpu_debugfs_autodump_poll(struct file *file,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct poll_table_struct *poll_table)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D fi=
le-&gt;private_data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(file, &amp;adev-&gt;aut=
odump.gpu_hang, poll_table);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return POLLIN | POLLRDNORM | POLLWRNORM;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static const struct file_operations autodump_debug_fops =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D amdgpu_debugfs_autodump=
_open,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_autodump=
_read,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .poll =3D amdgpu_debugfs_autodump=
_poll,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D amdgpu_debugfs_autod=
ump_release,<br>
&#43;};<br>
&#43;<br>
&#43;static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_completion(&amp;adev-&gt;aut=
odump.dumping);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;adev-&gt=
;autodump.gpu_hang);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete(&amp;adev-&gt;autodump.d=
umping);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_=
autodump&quot;, 0600,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev-&gt;ddev-&gt;primary-&gt;debugfs_root,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev, &amp;autodump_debug_fops);<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes<=
br>
&nbsp; *<br>
@@ -1434,6 &#43;1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_debugfs_create_=
all(adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_autodump_init(adev=
);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_add_=
files(adev, amdgpu_debugfs_list,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ARRAY_SIZE(amdgpu_debugfs_list));<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.h<br>
index de12d1101526..3504c48e1564 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
@@ -31,6 &#43;31,11 @@ struct amdgpu_debugfs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nu=
m_files;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct amdgpu_autodump {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dumping;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp; gpu_=
hang;<br>
&#43;};<br>
&#43;<br>
&nbsp;int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_debugfs_fini(struct amdgpu_device *adev);<br>
@@ -40,3 &#43;45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ad=
ev,<br>
&nbsp;int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);<br>
&#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 3d601d5dd5af..44e54ea7af0f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3915,6 &#43;3915,8 @@ static int amdgpu_device_pre_asic_reset(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset&nbsp;=
 =3D *need_full_reset_arg;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_wait_dump(adev);<b=
r>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers an=
d reset given job's ring */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; &#43;&#43;i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB38449E957A02F61FF88D9ACEE1AE0BY5PR12MB3844namp_--

--===============0348703212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0348703212==--
