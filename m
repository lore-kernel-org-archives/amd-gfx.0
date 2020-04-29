Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E4C83003
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 05:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8DD206F0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 05:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gS2WGVi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8DD206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B736E14F;
	Wed, 29 Apr 2020 05:08:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2DF6E14F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 05:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6nF9a5G9ZfNenKTt6PEFRD12w6oL3HD2xjOZEKmB5gaHrYlCHNs+KTK0l/+NIoP/Pnz+Z99gkHXfJvzztfuSTK4A/b6HujKrV6QYlWdQdH/Wsfg2pKgKBH/W5UJCi+LQpK/+zgLpyNNH5TdsJ+7VJub9atjJD7wVvqgEJ8wZVwbFxeh9ZAmfDo+E46lb69wePUE3abAoymzKVIR0NhcWKeBkLjhHbl2I7KtuWeJXx2ddiM7WJTJf+VtSNUApPyBvANIxrNcN4mao6U2xJJS3ONBIH/BiHvzFEZGlwYPfl3sS9/o/YTq+skxqPfEgHYJYb64vWKlGl/7zSZOOyPdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfxCQipaTIW4fKZvIo0o0AKV9JUi8uwPRZOdOeNKiDQ=;
 b=N01bLXDp4HUwvFN7J3c9ZSZi3eN+rQ+keje+4+KbOWwp18sAvJCgAecLj50Euu6GF0g/9uXA9QKthsC2i7pKdvfqm0NcyqQdrhrfgVLBuKF7iOqMZYVq4wg+phOrO8w0adrJclYqfpac0y9wKZtgiIas+Aab/p/GsF1VSuSto0oQit+qsokb01dAu7BWMXIYPgUoS0sp0BrAz1B3uY0xB6osVFSTfhQa/S3IrF1MfWAiUa0ZYDHex+w+ycz04vsjyrvPkVD1y/wjd2tj1peduBhpegjfCdKVXgVr3zjrFk1QOvs9/jwupPVYGoTVkaKB29Kx5jTM1bIaJPdKgiE7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfxCQipaTIW4fKZvIo0o0AKV9JUi8uwPRZOdOeNKiDQ=;
 b=gS2WGVi3g7EINyFYxur/e2OdNLd991ZtP8ib7IILiEMNd26BMmHq6wNOMSspi+gj8IQ7USz2fZKqh/mubP8WaIW1llkXpdUTHu2F8uny+OuKb6SQPPL3WsIKnZ12Ik0h6dDCqW9H1k+GHEuPBPk2lLAQk+9B5hQdTNMhgv0fE0U=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 05:08:26 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 05:08:26 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Index: AQHWHeQFneDjep8xxUawreSEa51HXqiPjHKk
Date: Wed, 29 Apr 2020 05:08:26 +0000
Message-ID: <BY5PR12MB38443C7B1DE143B954671CECE1AD0@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200429050639.20859-1-jianzh@amd.com>
In-Reply-To: <20200429050639.20859-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-29T05:08:25.538Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75308fc7-3573-4302-0830-08d7ebfb5931
x-ms-traffictypediagnostic: BY5PR12MB4084:|BY5PR12MB4084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4084738D6D3619D31BA4DBF4E1AD0@BY5PR12MB4084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(54906003)(7696005)(19627405001)(53546011)(6506007)(55016002)(316002)(9686003)(8936002)(66476007)(33656002)(66556008)(8676002)(66946007)(4326008)(64756008)(66446008)(186003)(478600001)(6916009)(2906002)(86362001)(91956017)(76116006)(5660300002)(52536014)(26005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zD/E53PHROfpo1or6+TMyFw+dDqssLJHsEsf0ENEfYJAJ2LHL821m9BrQT2das/9zOLH0gpwYbv2wyT3lr+oUf6W1IpCT7wlu4xYPhPX8r8XJtcr2wW8pzi8Tb3WnV5GZoZK60tQO8j3Th3Qen6fH55DnJZZ7YETxzD4Zj5aaagoOmbI2VuwGBB4yyn4UzYWaCy/JImyeBPtugJdvEo7tvY5zm68mhb+vb+ZE2yQVTi4BIkKE8AJhiIBbQtD+KIDuXn7zxwOaAMe1LqQxQuL+okySM1m/dssuJwjWekNMdb5pOGA55B63fhkzFWit3Pwt3rDZnNAticwl3A9Pxodjdlb2/+ftdg6Kmv3lROLTlOeS4SOmbNi5zLB0SIE1QBBmCK8/ELaufN6Ls309sHovMxZRQjaaaO7JS5+GwVOUlMdWDo81EwdnYxmBHPE8UfQ
x-ms-exchange-antispam-messagedata: OhJ+1p2clROtliYxHkzT2E7+E9wMgMIK6Hx3gQSxH1uoFnQkJQxOhNcDMv2UBlOskCxKLkBxVh45yeC3c9+tqMC1d0GLSEjmkk/7kwFKJZ+SUzJYIm5wTwNCl++GsxDEnaXuU6UtMc48+Wb+S3ZmWfX6kwFA2ahcsSeFxTL/qRtvud9kGRsNYOvEsaNImcOfOkMvriCb2KgFmXj/FMPhpt2Cdv5GG3NaUk3DYc25h0C5kEsEuXrb+XlvtT9twdcw3Mz7swpPhcZ49dU3uE1Q+WVL7Rf4lW9hC+xD24wQPvGbcTYHkqRZ1wlyy9yP9KxkGDhyDETxPE0bkTnLtd3hKhGc++ZgJw1tf2Bwqf8rDGNjtW3sCzCcpqKpIjIFxicx36lHk3YeoFtcpSAbSa7rFxNE4ucI33wi9aznZnhmEAc+6g9d7cZ7POLqe3tLt/f1Cd9RTCmuKRVP6nUusbn2iR7PET+Wi1G/yleKK2KTRNIfC+qNiwD+3WUZlN3LV0Zm2HQjCw97liO/RT8GypcEaQS9JLUm2eHGnkK6RiBHhy7bLuTAMD+vNMOZH5HJOQumETxfuOwONSTTtdCgwMjlo1KRnIe1jAQJSDoW7OkEcvLLga+4iq0P+pl9BjGl5s0yvj6vPt2kQZxT2j2XGbC9P4GL//AO+B1F0tai+o4s//JR+0nNzsmdIOjHT+Wvy8xCTQjRIIXhc/X9q6pljW12C+rFjmLx6o8jgIiDQj1Prm9mivDKmBbx6VGr7oiIwisPP/eddg99/qj9X4PBEXKiLtH7zDEaMZmMNV2YUa0KKQI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75308fc7-3573-4302-0830-08d7ebfb5931
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 05:08:26.0879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eh2HTfgYCrTy1OKeT+gvfLDke02Wqx6r+K9RTIq+UifHEE7MjqaBhxw9JGbaAKf
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0486735764=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0486735764==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB38443C7B1DE143B954671CECE1AD0BY5PR12MB3844namp_"

--_000_BY5PR12MB38443C7B1DE143B954671CECE1AD0BY5PR12MB3844namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi all,

I worked out the race condition and here is version 5. Please have a look.

Jiange
________________________________
From: Zhao, Jiange <Jiange.Zhao@amd.com>
Sent: Wednesday, April 29, 2020 1:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Ku=
ehling@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Haw=
king.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zha=
o@amd.com>
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4

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
+       unsigned long timeout =3D 600 * HZ;
+       int ret;
+
+       mutex_lock(&adev->autodump.app_state_mutex);
+       if (adev->autodump.app_state !=3D AMDGPU_AUTODUMP_LISTENING) {
+               mutex_unlock(&adev->autodump.app_state_mutex);
+               return 0;
+       }
+       mutex_unlock(&adev->autodump.app_state_mutex);
+
+       wake_up_interruptible(&adev->autodump.gpu_hang);
+
+       ret =3D wait_for_completion_interruptible_timeout(&adev->autodump.d=
umping, timeout);
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
+       mutex_lock(&adev->autodump.app_state_mutex);
+       if (adev->autodump.app_state =3D=3D AMDGPU_AUTODUMP_NO_APP) {
+               adev->autodump.app_state =3D AMDGPU_AUTODUMP_REGISTERED;
+               ret =3D 0;
+       } else {
+               ret =3D -EBUSY;
+       }
+       mutex_unlock(&adev->autodump.app_state_mutex);
+
+       return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode, struct fil=
e *file)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       mutex_lock(&adev->autodump.app_state_mutex);
+       complete(&adev->autodump.dumping);
+       adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
+       mutex_unlock(&adev->autodump.app_state_mutex);
+       return 0;
+}
+
+static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct=
 poll_table_struct *poll_table)
+{
+       struct amdgpu_device *adev =3D file->private_data;
+
+       mutex_lock(&adev->autodump.app_state_mutex);
+       poll_wait(file, &adev->autodump.gpu_hang, poll_table);
+       adev->autodump.app_state =3D AMDGPU_AUTODUMP_LISTENING;
+       mutex_unlock(&adev->autodump.app_state_mutex);
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
+static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
+{
+       init_completion(&adev->autodump.dumping);
+       init_waitqueue_head(&adev->autodump.gpu_hang);
+       adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
+       mutex_init(&adev->autodump.app_state_mutex);
+
+       debugfs_create_file("amdgpu_autodump", 0600,
+               adev->ddev->primary->debugfs_root,
+               adev, &autodump_debug_fops);
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
index de12d1101526..51b4ea790686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -31,6 +31,19 @@ struct amdgpu_debugfs {
         unsigned                num_files;
 };

+enum amdgpu_autodump_state {
+       AMDGPU_AUTODUMP_NO_APP,
+       AMDGPU_AUTODUMP_REGISTERED,
+       AMDGPU_AUTODUMP_LISTENING
+};
+
+struct amdgpu_autodump {
+       struct mutex                    app_state_mutex;
+       enum amdgpu_autodump_state      app_state;
+       struct completion               dumping;
+       struct wait_queue_head          gpu_hang;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e6978a2c26b7..8109946075b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3912,6 +3912,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu=
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


--_000_BY5PR12MB38443C7B1DE143B954671CECE1AD0BY5PR12MB3844namp_
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
Hi all,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I worked out the race condition and here is version 5. Please have a look.<=
/div>
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
<b>Sent:</b> Wednesday, April 29, 2020 1:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kuehling, Fe=
lix &lt;Felix.Kuehling@amd.com&gt;; Pelloux-prayer, Pierre-eric &lt;Pierre-=
eric.Pelloux-prayer@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@a=
md.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu,
 Monk &lt;Monk.Liu@amd.com&gt;; Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset=
 v4</font>
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
v4: add 'bool app_listening' to differentiate situations, so that<br>
&nbsp;&nbsp;&nbsp; the node can be reopened; also, there is no need to wait=
 for<br>
&nbsp;&nbsp;&nbsp; completion when no app is waiting for a dump.<br>
<br>
v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'<br>
&nbsp;&nbsp;&nbsp; add 'app_state_mutex' for race conditions:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1)Only 1 user can open this fil=
e node<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2)wait_dump() can only take eff=
ect after poll() executed.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3)eliminated the race condition=
 between release() and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_dump()<br=
>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 14 &#43;&#43;&#43;&#43;=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;4 files changed, 109 insertions(&#43;), 1 deletion(-)<br>
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
index 1a4894fa3693..1d4a95e8ad5b 100644<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long timeout =3D 600 * H=
Z;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;autodump=
.app_state_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.app_state !=
=3D AMDGPU_AUTODUMP_LISTENING) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;autodump.app_state_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;autodu=
mp.app_state_mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;adev-&=
gt;autodump.gpu_hang);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for_completion_inter=
ruptible_timeout(&amp;adev-&gt;autodump.dumping, timeout);<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;autodump=
.app_state_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.app_state =
=3D=3D AMDGPU_AUTODUMP_NO_APP) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;autodump.app_state =3D AMDGPU_AUTODUMP_REGISTERED;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D -EBUSY;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;autodu=
mp.app_state_mutex);<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;autodump=
.app_state_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; complete(&amp;adev-&gt;autodump.d=
umping);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.app_state =3D A=
MDGPU_AUTODUMP_NO_APP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;autodu=
mp.app_state_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, st=
ruct poll_table_struct *poll_table)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D fi=
le-&gt;private_data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;autodump=
.app_state_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(file, &amp;adev-&gt;aut=
odump.gpu_hang, poll_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.app_state =3D A=
MDGPU_AUTODUMP_LISTENING;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;autodu=
mp.app_state_mutex);<br>
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
&#43;static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_completion(&amp;adev-&gt;aut=
odump.dumping);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;adev-&gt=
;autodump.gpu_hang);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;autodump.app_state =3D A=
MDGPU_AUTODUMP_NO_APP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;autodump=
.app_state_mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_=
autodump&quot;, 0600,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;ddev-&gt;primary-&gt;debugfs_root,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev, &amp;autodump_debug_fops);<br>
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
index de12d1101526..51b4ea790686 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
@@ -31,6 &#43;31,19 @@ struct amdgpu_debugfs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nu=
m_files;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum amdgpu_autodump_state {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_AUTODUMP_NO_APP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_AUTODUMP_REGISTERED,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_AUTODUMP_LISTENING<br>
&#43;};<br>
&#43;<br>
&#43;struct amdgpu_autodump {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; app_state_mutex;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_autodump_state&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; app_state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dumpin=
g;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_hang;<br>
&#43;};<br>
&#43;<br>
&nbsp;int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_debugfs_fini(struct amdgpu_device *adev);<br>
@@ -40,3 &#43;53,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ad=
ev,<br>
&nbsp;int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);<br>
&#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index e6978a2c26b7..8109946075b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3912,6 &#43;3912,8 @@ static int amdgpu_device_pre_asic_reset(struct am=
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

--_000_BY5PR12MB38443C7B1DE143B954671CECE1AD0BY5PR12MB3844namp_--

--===============0486735764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0486735764==--
