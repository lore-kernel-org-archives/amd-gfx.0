Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0513FC2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84F920736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TXoFQaOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F920736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D76A89DB2;
	Fri, 24 Apr 2020 08:51:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B4389F6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/VMBleZayvkti6fBMGVjIs29ScGsyecMO+Je+dmXPqxglHSY/CTwgm0YPg6mFbcW254f5Cgbs5gQhxbSfQoBfnON1FhP7nTdlag1dX47dFRM7wCVqUFDWdWcbq9/SEZcoDlUA2nJGDzF2v2khsouj7cyOWko2J7HTsDiMkxgKWdvg+RJn05FiFOL7WHZkhLD3XtAJfrcQRw6QjSrgSwtzHzrrEakKehF9rDtxXMh+ZUVf7frhlCtxrQJsQ7m934KkjUdpuX88lITbVvpbQPxr0/5/XAggYgsH0hAT7nu3OkPB8BTQGQcwVG+ZL8wjQ57jMhDYpPooI9x+LB5wTLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rch4pSKY6OgCsvTHFL/w5Tfu5FqPY8kKE9L7ngqo4j4=;
 b=ISGGeVTJgS6Qgdukyxv+QIIQfbWdZFzDaQwrJwjcmyrt4UvZBfCjA+GMHlGhmg9Y80oLnMuOK1j/OJJHwGXTnSSzRjEZTvMnkwJPyZNyqxKx75RQCA0EpU5OnmSoU8MnSlSq2/8PqnedcGSLnV7qmcScasxJw1ksIyNXhDeXEFm7JX7aGHCdgXIIy4kz0UouoPzSu9UhMh8vPxuqlx6jcIpkffc5Uf4ZbDDmnwT/9OkrXdQyt9K+3TBr2fO60t64RBaviAaHmgpCqb1iwdRjGek8Tt/3VdZfeDOCWLFgFNpgWXpROUo09jUbhL30p0hrwLcOwtJAzgalwMeSEayvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rch4pSKY6OgCsvTHFL/w5Tfu5FqPY8kKE9L7ngqo4j4=;
 b=TXoFQaOtm8HujYs766+jEvpCXR4V49/TdcPmt+ndDT9AdJECd9KPkhOtZI+ZHbxLX+Izr7Vh8HBj7v/wI/63A2c6f3nY754OwqWfqNzZ0Z+voSHXCPH04zE6RYw1pyMfkwrwUZoyDWFOaPQ2DUNCvF7BUP8HkjDZnlzYgY4OA5M=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 08:51:38 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 08:51:38 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset (v2)
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset (v2)
Thread-Index: AQHWGhVYON5qIqW3D0akV3GWhtmcOqiH9pHn
Date: Fri, 24 Apr 2020 08:51:38 +0000
Message-ID: <BY5PR12MB384413FA337705F878C1961AE1D00@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200424084943.27169-1-jianzh@amd.com>
In-Reply-To: <20200424084943.27169-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T08:51:37.461Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fac9611b-0e47-4cbf-d0fb-08d7e82cb363
x-ms-traffictypediagnostic: BY5PR12MB3681:|BY5PR12MB3681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3681905AA48E3B4ECCB03627E1D00@BY5PR12MB3681.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(71200400001)(66446008)(8676002)(186003)(316002)(53546011)(76116006)(478600001)(81156014)(91956017)(66946007)(26005)(64756008)(66476007)(86362001)(19627405001)(54906003)(6916009)(7696005)(55016002)(8936002)(33656002)(52536014)(66556008)(6506007)(2906002)(4326008)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: orERfef8tjo53Cfzvq4S3PjIoIXXwtg8u4+aBsqD9kr8GOrsTZSdfpUl+Dl5CSEM9LB/2I+JxQIIGEAYk7PdysgY0esHU3JhOW+zdCqUhRojfT1GV18p0JkgNrPnMkIEyoGK9irNeqqmiDc86GTCdiIUwfWaxU5XQ5ezTAT9fVdxlQetDFBsZLb8aGlmkhP+JcAbTi5eoQblyyyAyUJeZ6I83LjwVmYeZxqaSEAhL+bPxvxB44dur9ILF4t5E5VnN//p6ZxYTaznn6Gelk463MK3qtJ3P4vTdSSSuBxRZrzeSHrxM45qCV9fynTcxAFW0gwaXmF1PVQgn1jzksVPjTlBnjwHsUNep8KsagA2D8vu8mRrgUTbjN+/6C3bGtT+YGqfkq2Llwes6CHC5Os1XG+HlZiu+ed4wk5p+DRz5NOWnq5B2Z6pZE98/2KUR3FT
x-ms-exchange-antispam-messagedata: xatTz3mm4JIzK+MI2Wlqfc5yTRx6f51UVKn9bcoAoQxjauC+gPhpb7o25/Efo/Kp7nPHhKhISpqmx0mLAkN0+HMuAz3XQCUBWOT6TeOJTTsixpa2+4U23NLT8aQDAG+Y50ERYuemwBK63aZOtIQ3Mg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac9611b-0e47-4cbf-d0fb-08d7e82cb363
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 08:51:38.1213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ph5v7d088Tt98G8Q5yczrwXJBrpdN5AwCIbQzO/4bOuZQED8+arE5SPs88ORMHAW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0874251592=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0874251592==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB384413FA337705F878C1961AE1D00BY5PR12MB3844namp_"

--_000_BY5PR12MB384413FA337705F878C1961AE1D00BY5PR12MB3844namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi @Koenig, Christian<mailto:Christian.Koenig@amd.com>,

For the completion restore, I have tested the patch and it is working.

It seems that in release() function, complete() would restore the completio=
n.

Jiange
________________________________
From: Zhao, Jiange <Jiange.Zhao@amd.com>
Sent: Friday, April 24, 2020 4:49 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Ku=
ehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Haw=
king.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zha=
o@amd.com>
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset (v2)

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index bc1e0fd71a09..34b8ce9fba47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -724,6 +724,14 @@ struct amd_powerplay {
         const struct amd_pm_funcs *pp_funcs;
 };

+struct amdgpu_autodump {
+       bool                            app_listening;
+       struct completion               completed;
+       struct dentry                   *dentry;
+       struct wait_queue_head          gpu_hang_wait;
+       struct mutex                    mutex;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
@@ -990,6 +998,8 @@ struct amdgpu_device {
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
+       unsigned long tmo =3D 600*HZ;
+       int ret;
+
+       if (!adev->autodump.app_listening)
+               return 0;
+
+       wake_up_interruptible(&adev->autodump.gpu_hang_wait);
+
+       ret =3D wait_for_completion_interruptible_timeout(&adev->autodump.c=
ompleted, tmo);
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
+       int ret =3D 0;
+       struct amdgpu_device *adev;
+
+       ret =3D simple_open(inode, file);
+       if (ret)
+               return ret;
+
+       adev =3D file->private_data;
+
+       mutex_lock(&adev->autodump.mutex);
+       if (adev->autodump.app_listening =3D=3D true) {
+               ret =3D -EBUSY;
+       } else {
+               adev->autodump.app_listening =3D true;
+       }
+       mutex_unlock(&adev->autodump.mutex);
+
+       return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct fil=
e *file)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       complete(&adev->autodump.completed);
+       adev->autodump.app_listening =3D false;
+
+       return 0;
+}
+
+unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_t=
able_struct *poll_table)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
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
+       .poll =3D amdgpu_debugfs_autodump_poll,
+       .release =3D amdgpu_debugfs_autodump_release,
+};
+
+static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
+{
+       struct dentry *entry;
+
+       init_completion(&adev->autodump.completed);
+       init_waitqueue_head(&adev->autodump.gpu_hang_wait);
+       mutex_init(&adev->autodump.mutex);
+       adev->autodump.app_listening =3D false;
+
+       entry =3D debugfs_create_file("autodump", 0600,
+                       adev->ddev->primary->debugfs_root,
+                       adev, &autodump_debug_fops);
+       adev->autodump.dentry =3D entry;
+
+       return 0;
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
index de12d1101526..9428940a696d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
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
2.20.1


--_000_BY5PR12MB384413FA337705F878C1961AE1D00BY5PR12MB3844namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Hi <a id=3D"OWAAM218987" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nl=
r ms-fcl-b" href=3D"mailto:Christian.Koenig@amd.com">
@Koenig, Christian</a>,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
For the completion restore, I have tested the patch and it is working.</div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
It seems that in release() function, complete() would restore the completio=
n.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Jiange &lt;Jian=
ge.Zhao@amd.com&gt;<br>
<b>Sent:</b> Friday, April 24, 2020 4:49 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kuehling, Fe=
lix &lt;Felix.Kuehling@amd.com&gt;; Pelloux-prayer, Pierre-eric &lt;Pierre-=
eric.Pelloux-prayer@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@a=
md.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu,
 Monk &lt;Monk.Liu@amd.com&gt;; Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset=
 (v2)</font>
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
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; | 10 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;4 files changed, 104 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index bc1e0fd71a09..34b8ce9fba47 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -724,6 &#43;724,14 @@ struct amd_powerplay {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct amdgpu_autodump {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; app_listening;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comple=
ted;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *dentry;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_hang_wait;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; mutex;<br>
&#43;};<br>
&#43;<br>
&nbsp;#define AMDGPU_RESET_MAGIC_NUM 64<br>
&nbsp;#define AMDGPU_MAX_DF_PERFMONS 4<br>
&nbsp;struct amdgpu_device {<br>
@@ -990,6 &#43;998,8 @@ struct amdgpu_device {<br>
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
index 1a4894fa3693..693bfcaad312 100644<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long tmo =3D 600*HZ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;autodump.app_listen=
ing)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;adev-&=
gt;autodump.gpu_hang_wait);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for_completion_inter=
ruptible_timeout(&amp;adev-&gt;autodump.completed, tmo);<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D simple_open(inode, file);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev =3D file-&gt;private_data;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;autodump=
.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.app_listeni=
ng =3D=3D true) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D -EBUSY;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;autodump.app_listening =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;autodu=
mp.mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int amdgpu_debugfs_autodump_release(struct inode *inode, struct=
 file *file)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D fi=
le-&gt;private_data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete(&amp;adev-&gt;autodump.c=
ompleted);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.app_listening =
=3D false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct po=
ll_table_struct *poll_table)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D fi=
le-&gt;private_data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(file, &amp;adev-&gt;aut=
odump.gpu_hang_wait, poll_table);<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .poll =3D amdgpu_debugfs_autodump=
_poll,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D amdgpu_debugfs_autod=
ump_release,<br>
&#43;};<br>
&#43;<br>
&#43;static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *entry;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_completion(&amp;adev-&gt;aut=
odump.completed);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;adev-&gt=
;autodump.gpu_hang_wait);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;autodump=
.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.app_listening =
=3D false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry =3D debugfs_create_file(&qu=
ot;autodump&quot;, 0600,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dde=
v-&gt;primary-&gt;debugfs_root,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;a=
utodump_debug_fops);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.dentry =3D entr=
y;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
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
index de12d1101526..9428940a696d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
@@ -40,3 &#43;40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ad=
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
2.20.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB384413FA337705F878C1961AE1D00BY5PR12MB3844namp_--

--===============0874251592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0874251592==--
