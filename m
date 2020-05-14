Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810FEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 07:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21113206B6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 07:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NKJWydT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21113206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84F26EAB4;
	Thu, 14 May 2020 07:14:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EB26EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 07:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtR+9j7jd8esggT3+xCQdGkFMkQRU+87DXBuvkzdQ3u5zSd6L69zro5viNzxtuF1VfdBdTmbXdtYyGzy5Oi1U4T8+KhMys5EQGNbMMnf8ZIAEO2Bzth6cdBRlLS3cb6E0CV/r7N+bk/TxD3cUrCdFIR7EEyLWECUEHdzo/V8V10SKUI/scLp3KdqMkv/EDrkEDF5D2wKtpi9HYfd4+Ab5Vxb24hvT9NpCLYFJbXMIlu8MrExrBxGnPPCaAtXoPxoqMcOdwSKAI4Gn1BUc5NcQ5DUKv54Pqo1YGk6eXBV2/U+lVPHc8fJ7J51P4jx0+x07Q66oXPAqCuh6wcqs3lWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY4HP1aJ1Fu5LqlUvYUxyy0eGy4SCJ3QhcufTatggdM=;
 b=JcaPSatp1gKvJrok31Q3q2NsbWbn/u3pBchJlBZNJ9IZ7/nZNK8MZMFoSjQuJ23djYlewCqa7+qwEsNI0/ngd2AHbqeFqc+WCogR45LkTZqgoYrXHMjQE4assReARHWhgn905hSwxj6jYCQo6UWjSlQyf5iHEBOEA1kJM+yi5DDluT0DQ3NjYn7ldBb+yGicUhtheEro9evnRjQUMPnHo8LAZBJLlueu01bJaNSA2EdGN8/Tb+ZZXTt6rYsT6zo1XvJWNcm62NCYRlMke/IlAiv209bhCRyOqUXUU0ppt3YYy3w4a8fNdxmUh9UVuIqVWCw4zbnQHcRZ6vdRp9qe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY4HP1aJ1Fu5LqlUvYUxyy0eGy4SCJ3QhcufTatggdM=;
 b=NKJWydT5E4AAailbqDGxxW8J+zL0KhfF3gTbF3db7apFNdlV5uQdFg2rzbxU2xdF+97V5z2pq0091f2KOA5JqMu+Kbr9F7nCBTTbuWZIGDrnTmRaNFaJ+82wTQcD6mKAGOvKO0cgb1RYj6rdia8X+Ddox+6OTPiOodpKvTWFeIU=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 14 May
 2020 07:14:48 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 07:14:48 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Index: AQHWKbC/pG8eHU1Ba0+gTrbzNUBwgqinJ7GAgAACQFM=
Date: Thu, 14 May 2020 07:14:48 +0000
Message-ID: <BY5PR12MB38445E32AE9812D05E924BF1E1BC0@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200514052952.19260-1-jianzh@amd.com>,
 <993d856e-1084-92c7-e43e-d9276acfad92@gmail.com>
In-Reply-To: <993d856e-1084-92c7-e43e-d9276acfad92@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-14T07:14:47.598Z;
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
x-ms-office365-filtering-correlation-id: a2db9707-34e9-42c1-a0c8-08d7f7d67c9f
x-ms-traffictypediagnostic: BY5PR12MB4242:|BY5PR12MB4242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42426F2E7762B08924BF76AAE1BC0@BY5PR12MB4242.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fAhENhGV1+FfRK8UqvO8IqK+0ll1M42JLbuo54F8CJjnITiBWUAzWomit2VLCSDrZwkyujqmSmixWSzTEbwymbZCtl8URCdCV/BLPh+EWjUJ1qEiu05iqERnYhECDLlb88txdHIQo7kJbEE8++uwvNkRgtxx610ZCQrzwwgT4N9tnWT1bgr/XRolyJkyjG8uAz0mn0Q3mZCgbaMYPIxx003+D3Vr6qxqZvlkWA4IyM5KXbfA6TJw7fuHy7bF2+QzvLoYqXXHdfvBeRis8Hp/VyG56sj42EldeiFOtpv9dNxOp8aXsIp2XysloGXP9GCkQF+8HHdwEtRt/Tsj3SuB1DtLRW/btvvn8Y7Hu7vE691QSbSamR3jU5aITdkZgMVgd/+q6K08OwmttWFHVP8QL2USO/YbuJUXmD3DdWsFbfcnppOJXQYsrH6PMs5IT+s4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(6506007)(2906002)(110136005)(54906003)(316002)(478600001)(9686003)(26005)(7696005)(91956017)(66946007)(186003)(76116006)(66446008)(66556008)(55016002)(66476007)(53546011)(64756008)(4326008)(86362001)(19627405001)(66574014)(52536014)(8676002)(71200400001)(5660300002)(33656002)(6636002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: L6oJ58jwPcXuq76jIixnLoanxhBeEGk14xQTCi3QUYZdhzfl2vFlIHSfEcAu7HQDlBkAABhbvk66lmdg93N+6XnJJfmt62bMCsj1dezgTzmMKM8f2wAHIdKKRfnMHAyXoHs4pSFUixQ2NQSCUa9G1zShURLkmwajukFT5NAha2AIB35LiW2QsxMoXdR9vqQ/LuZyIoRMOFcvvE8AOsxM/h7maRGBqRV+CdORp/ycP0sYhlmf3/ISAi1orMdH8lfXyENKJ+EYaqWhEKDddIUKW9bImlDjPPs2jGnc7kQwhU3RexSIkRESVNXBg43lYguJJuChj+4+JUUHRDFITEqdmODHw6Y80TSEWObbBohEfN1NFybzAvbk1/HLTpjX9NxFX7x+6/AOvO3Ptdkjual6OnpF2GCKZ1/BzIdUNJf1zX6ko+tFu3jnXcaDuABMmSALWlPDo0814PdI754HTvllcWl3ImB/wT4UUg17kjAd7f5moQGb4Nm/P4OkGdFEiOee
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2db9707-34e9-42c1-a0c8-08d7f7d67c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 07:14:48.1493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5GMplM/LWg/GiVBhsaZZ6HwQpz6S8EuJu7Z8vD7i0dnMnosmgog7RjwB2BIMeiQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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
 Felix" <Felix.Kuehling@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1661115659=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1661115659==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB38445E32AE9812D05E924BF1E1BC0BY5PR12MB3844namp_"

--_000_BY5PR12MB38445E32AE9812D05E924BF1E1BC0BY5PR12MB3844namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,

wait_for_completion_interruptible_timeout() would decrease autodump.dumping=
.done to UINT_MAX-1.

complete_all() here would restore autodump.dumping to the state as in amdgp=
u_debugfs_autodump_init().

I want to make sure every open() deals with the same situation.

Jiange
________________________________
From: Christian K?nig <ckoenig.leichtzumerken@gmail.com>
Sent: Thursday, May 14, 2020 3:01 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Zhao,=
 Jiange <Jiange.Zhao@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhan=
g@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4

Am 14.05.20 um 07:29 schrieb jianzh@amd.com:
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>
> When GPU got timeout, it would notify an interested part
> of an opportunity to dump info before actual GPU reset.
>
> A usermode app would open 'autodump' node under debugfs system
> and poll() for readable/writable. When a GPU reset is due,
> amdgpu would notify usermode app through wait_queue_head and give
> it 10 minutes to dump info.
>
> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through
> the completion that is triggered in release().
>
> There is no write or read callback because necessary info can be
> obtained through dmesg and umr. Messages back and forth between
> usermode app and amdgpu are unnecessary.
>
> v2: (1) changed 'registered' to 'app_listening'
>      (2) add a mutex in open() to prevent race condition
>
> v3 (chk): grab the reset lock to avoid race in autodump_open,
>            rename debugfs file to amdgpu_autodump,
>            provide autodump_read as well,
>            style and code cleanups
>
> v4: add 'bool app_listening' to differentiate situations, so that
>      the node can be reopened; also, there is no need to wait for
>      completion when no app is waiting for a dump.
>
> v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
>      add 'app_state_mutex' for race conditions:
>        (1)Only 1 user can open this file node
>        (2)wait_dump() can only take effect after poll() executed.
>        (3)eliminated the race condition between release() and
>           wait_dump()
>
> v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'
>      removed state checking in amdgpu_debugfs_wait_dump
>      Improve on top of version 3 so that the node can be reopened.
>
> v7: move reinit_completion into open() so that only one user
>      can open it.
>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 79 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 2a806cb55b78..9e8eeddfe7ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,8 @@ struct amdgpu_device {
>        char                            product_number[16];
>        char                            product_name[32];
>        char                            serial[16];
> +
> +     struct amdgpu_autodump          autodump;
>   };
>
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_devic=
e *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..efee3f1adecf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,7 @@
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
> -
> +#include <linux/poll.h>
>   #include <drm/drm_debugfs.h>
>
>   #include "amdgpu.h"
> @@ -74,8 +74,83 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *ade=
v,
>        return 0;
>   }
>
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +     unsigned long timeout =3D 600 * HZ;
> +     int ret;
> +
> +     wake_up_interruptible(&adev->autodump.gpu_hang);
> +
> +     ret =3D wait_for_completion_interruptible_timeout(&adev->autodump.d=
umping, timeout);
> +     complete_all(&adev->autodump.dumping);

Sorry that I'm mentioning this only now. But what is this complete_all()
here good for?

I mean we already waited for completion, didn't we?

Christian.

> +     if (ret =3D=3D 0) {
> +             pr_err("autodump: timeout, move on to gpu recovery\n");
> +             return -ETIMEDOUT;
> +     }
> +#endif
> +     return 0;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file=
 *file)
> +{
> +     struct amdgpu_device *adev =3D inode->i_private;
> +     int ret;
> +
> +     file->private_data =3D adev;
> +
> +     mutex_lock(&adev->lock_reset);
> +     if (adev->autodump.dumping.done) {
> +             reinit_completion(&adev->autodump.dumping);
> +             ret =3D 0;
> +     } else {
> +             ret =3D -EBUSY;
> +     }
> +     mutex_unlock(&adev->lock_reset);
> +
> +     return ret;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct f=
ile *file)
> +{
> +     struct amdgpu_device *adev =3D file->private_data;
> +
> +     complete_all(&adev->autodump.dumping);
> +     return 0;
> +}
> +
> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, stru=
ct poll_table_struct *poll_table)
> +{
> +     struct amdgpu_device *adev =3D file->private_data;
> +
> +     poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> +
> +     if (adev->in_gpu_reset)
> +             return POLLIN | POLLRDNORM | POLLWRNORM;
> +
> +     return 0;
> +}
> +
> +static const struct file_operations autodump_debug_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .open =3D amdgpu_debugfs_autodump_open,
> +     .poll =3D amdgpu_debugfs_autodump_poll,
> +     .release =3D amdgpu_debugfs_autodump_release,
> +};
> +
> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +     init_completion(&adev->autodump.dumping);
> +     complete_all(&adev->autodump.dumping);
> +     init_waitqueue_head(&adev->autodump.gpu_hang);
> +
> +     debugfs_create_file("amdgpu_autodump", 0600,
> +             adev->ddev->primary->debugfs_root,
> +             adev, &autodump_debug_fops);
> +}
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1434,6 +1509,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>
>        amdgpu_ras_debugfs_create_all(adev);
>
> +     amdgpu_debugfs_autodump_init(adev);
> +
>        return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>                                        ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..2803884d338d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -31,6 +31,11 @@ struct amdgpu_debugfs {
>        unsigned                num_files;
>   };
>
> +struct amdgpu_autodump {
> +     struct completion               dumping;
> +     struct wait_queue_head          gpu_hang;
> +};
> +
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> @@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev=
,
>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index cc41e8f5ad14..545beebcf43e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3927,6 +3927,8 @@ static int amdgpu_device_pre_asic_reset(struct amdg=
pu_device *adev,
>        int i, r =3D 0;
>        bool need_full_reset  =3D *need_full_reset_arg;
>
> +     amdgpu_debugfs_wait_dump(adev);
> +
>        /* block all schedulers and reset given job's ring */
>        for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                struct amdgpu_ring *ring =3D adev->rings[i];


--_000_BY5PR12MB38445E32AE9812D05E924BF1E1BC0BY5PR12MB3844namp_
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
Hi Christian,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">wait_for_completion_interru=
ptible_timeout() would decrease autodump.dumping.done to UINT_MAX-1.</span>=
</font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
<font size=3D"2"><span style=3D"font-size:11pt"></span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">complete_all() here would r=
estore autodump.dumping to the state as in
<font size=3D"2"><span style=3D"font-size:11pt">amdgpu_debugfs_autodump_ini=
t</span></font>().</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">I want to make sure every o=
pen() deals with the same situation.</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Jiange</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Thursday, May 14, 2020 3:01 PM<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.c=
om&gt;; Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; Kuehling, Felix &lt;Felix=
.Kuehling@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;=
; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Liu, Monk
 &lt;Monk.Liu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu r=
eset v4</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 14.05.20 um 07:29 schrieb jianzh@amd.com:<br>
&gt; From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
&gt;<br>
&gt; When GPU got timeout, it would notify an interested part<br>
&gt; of an opportunity to dump info before actual GPU reset.<br>
&gt;<br>
&gt; A usermode app would open 'autodump' node under debugfs system<br>
&gt; and poll() for readable/writable. When a GPU reset is due,<br>
&gt; amdgpu would notify usermode app through wait_queue_head and give<br>
&gt; it 10 minutes to dump info.<br>
&gt;<br>
&gt; After usermode app has done its work, this 'autodump' node is closed.<=
br>
&gt; On node closure, amdgpu gets to know the dump is done through<br>
&gt; the completion that is triggered in release().<br>
&gt;<br>
&gt; There is no write or read callback because necessary info can be<br>
&gt; obtained through dmesg and umr. Messages back and forth between<br>
&gt; usermode app and amdgpu are unnecessary.<br>
&gt;<br>
&gt; v2: (1) changed 'registered' to 'app_listening'<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2) add a mutex in open() to prevent rac=
e condition<br>
&gt;<br>
&gt; v3 (chk): grab the reset lock to avoid race in autodump_open,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rena=
me debugfs file to amdgpu_autodump,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prov=
ide autodump_read as well,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; styl=
e and code cleanups<br>
&gt;<br>
&gt; v4: add 'bool app_listening' to differentiate situations, so that<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the node can be reopened; also, there is=
 no need to wait for<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completion when no app is waiting for a =
dump.<br>
&gt;<br>
&gt; v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add 'app_state_mutex' for race condition=
s:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1)Only 1 user can open this=
 file node<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2)wait_dump() can only take=
 effect after poll() executed.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3)eliminated the race condi=
tion between release() and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_dump(=
)<br>
&gt;<br>
&gt; v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; removed state checking in amdgpu_debugfs=
_wait_dump<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Improve on top of version 3 so that the =
node can be reopened.<br>
&gt;<br>
&gt; v7: move reinit_completion into open() so that only one user<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can open it.<br>
&gt;<br>
&gt; Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 79 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |&nbsp; 6 &#43=
;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; |&nbsp; 2=
 &#43;<br>
&gt;&nbsp;&nbsp; 4 files changed, 88 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 2a806cb55b78..9e8eeddfe7ce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -992,6 &#43;992,8 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_num=
ber[16];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_nam=
e[32];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[16];=
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static inline struct amdgpu_device *amdgpu_ttm_adev(struct=
 ttm_bo_device *bdev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; index 1a4894fa3693..efee3f1adecf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; @@ -27,7 &#43;27,7 @@<br>
&gt;&nbsp;&nbsp; #include &lt;linux/pci.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/uaccess.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/pm_runtime.h&gt;<br>
&gt; -<br>
&gt; &#43;#include &lt;linux/poll.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;drm/drm_debugfs.h&gt;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; @@ -74,8 &#43;74,83 @@ int amdgpu_debugfs_add_files(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)<br>
&gt; &#43;{<br>
&gt; &#43;#if defined(CONFIG_DEBUG_FS)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long timeout =3D 600 * HZ;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;adev-&gt;auto=
dump.gpu_hang);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for_completion_interruptibl=
e_timeout(&amp;adev-&gt;autodump.dumping, timeout);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dump=
ing);<br>
<br>
Sorry that I'm mentioning this only now. But what is this complete_all() <b=
r>
here good for?<br>
<br>
I mean we already waited for completion, didn't we?<br>
<br>
Christian.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pr_err(&quot;autodump: timeout, move on to gpu recovery\n&quot;);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;#endif<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static int amdgpu_debugfs_autodump_open(struct inode *inode, stru=
ct file *file)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D inode-&gt=
;i_private;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data =3D adev;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;lock_reset);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;autodump.dumping.done) {<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reinit_completion(&amp;adev-&gt;autodump.dumping);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D -EBUSY;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lock_reset);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int amdgpu_debugfs_autodump_release(struct inode *inode, s=
truct file *file)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D file-&gt;=
private_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dump=
ing);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static unsigned int amdgpu_debugfs_autodump_poll(struct file *fil=
e, struct poll_table_struct *poll_table)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D file-&gt;=
private_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; poll_wait(file, &amp;adev-&gt;autodump.g=
pu_hang, poll_table);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return POLLIN | POLLRDNORM | POLLWRNORM;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct file_operations autodump_debug_fops =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D amdgpu_debugfs_autodump_open,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .poll =3D amdgpu_debugfs_autodump_poll,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D amdgpu_debugfs_autodump_rel=
ease,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static void amdgpu_debugfs_autodump_init(struct amdgpu_device *ad=
ev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; init_completion(&amp;adev-&gt;autodump.d=
umping);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; complete_all(&amp;adev-&gt;autodump.dump=
ing);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;adev-&gt;autodu=
mp.gpu_hang);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_autodum=
p&quot;, 0600,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;ddev-&gt;primary-&gt;debugfs_root,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;autodump_debug_fops);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_debugfs_process_reg_op - Handle MMIO regist=
er reads/writes<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -1434,6 &#43;1509,8 @@ int amdgpu_debugfs_init(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_debugfs_create_al=
l(adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_autodump_init(adev);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_add_fi=
les(adev, amdgpu_debugfs_list,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ARRAY_SIZE(amdgpu_debugfs_list));<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&gt; index de12d1101526..2803884d338d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
&gt; @@ -31,6 &#43;31,11 @@ struct amdgpu_debugfs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_=
files;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;struct amdgpu_autodump {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct completion&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dumping;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct wait_queue_head&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_hang;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);<=
br>
&gt;&nbsp;&nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; void amdgpu_debugfs_fini(struct amdgpu_device *adev);<br>
&gt; @@ -40,3 &#43;45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_devic=
e *adev,<br>
&gt;&nbsp;&nbsp; int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);=
<br>
&gt;&nbsp;&nbsp; int amdgpu_debugfs_firmware_init(struct amdgpu_device *ade=
v);<br>
&gt;&nbsp;&nbsp; int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);<b=
r>
&gt; &#43;int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index cc41e8f5ad14..545beebcf43e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -3927,6 &#43;3927,8 @@ static int amdgpu_device_pre_asic_reset(stru=
ct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset&nbsp; =
=3D *need_full_reset_arg;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_wait_dump(adev);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and =
reset given job's ring */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_=
MAX_RINGS; &#43;&#43;i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB38445E32AE9812D05E924BF1E1BC0BY5PR12MB3844namp_--

--===============1661115659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1661115659==--
