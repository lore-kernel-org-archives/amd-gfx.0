Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F73C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 15:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716AB2065F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="acUCzcbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716AB2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D25B6EB2F;
	Thu, 14 May 2020 15:15:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECC46EB2F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 15:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ2A/0EjmI9kfu1K9EiCUTbZYE0SnCtTMapLvL2+04FaMNf+qDkrDr4BsbEwbLnlOSQ3i7xV5hyOH4ZU0IbkppXZ2pb11L/KaWgz9k54/jjcTDisbfBY5yEjKzSHPAm4llgg/TzF1irixGHQjMT/FSjWU4fViBNAh85Q/2GyOJo0e3Fl+4Fq+ldNBSrg6wC4WS3Yq3kLEXpLH9iQ0NayrPUAx6Rw7hTjGjXtlZZ7yiiQ/NbR2e0Y9XN3dweetH3wIq6f7ZOoo/JTEI/TOOeDUC7VkNKqh3wt44AX2PpwYJCLQTkAAPuD9rD2Ty+yWRvKpVfcTE8o0COVInOqpYs6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKRXV3D7xA2xdQgUTpAxr2d8smwJ8aWEd37DKcCoSH4=;
 b=SRT4s/zonxbupUgrW/AUj5el00EG5UR0AGL/2NIMKpshBBzIVPaXRYzkeDRf+w8PxcmZLZ4tpWRl/+FitlQisXIREL6dq28GoF30DGJCCSiG+u6I5KyvDkWowJB7b8vOvPCQp6cwoDZb89iKb8MMjdN33qs3jCo0slfjeDFMC2aKFkROZGf7FSlkNybp8eXTjH0Wz/ff9jcfieapES2MwSCz9ajgyzmGaOlfbaXT+eJ7ICg1Dq6umTfqh3isIHordwDTqoLzJ7OpkeZ3WgH44efDKH3ByuKLi3mjmfV7hrHU8xJp0K9HIgZKjHYZhPQLRMOlXfkZYeow3ekRQuCMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKRXV3D7xA2xdQgUTpAxr2d8smwJ8aWEd37DKcCoSH4=;
 b=acUCzcbA6IzH4l2ovqGoUqGWSkAnPA72A9V8vyw1cz623oXSmCI9gxxPm0218IHy1gxcIMXldmgmXV5OmvLWqcRQlc+XFKUk3aRW0m5sINB6m94VIRxYGH/TihEllUkZaHr6tpUwovtPbTHcELpdRaJ6gyfgsvByyeqHyW9JXmU=
Received: from MN2PR12MB2880.namprd12.prod.outlook.com (2603:10b6:208:106::21)
 by MN2PR12MB3456.namprd12.prod.outlook.com (2603:10b6:208:ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 14 May
 2020 15:15:50 +0000
Received: from MN2PR12MB2880.namprd12.prod.outlook.com
 ([fe80::29e6:fe28:80a7:8bf8]) by MN2PR12MB2880.namprd12.prod.outlook.com
 ([fe80::29e6:fe28:80a7:8bf8%7]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 15:15:50 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhao, Jiange"
 <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Index: AQHWKbDl436qjL7rYUyrv4+UI81t+qinJ7GAgAADoQCAABSYgIAAcF4A
Date: Thu, 14 May 2020 15:15:50 +0000
Message-ID: <MN2PR12MB28800BAEFD8F6201B6EC1B41EDBC0@MN2PR12MB2880.namprd12.prod.outlook.com>
References: <20200514052952.19260-1-jianzh@amd.com>
 <993d856e-1084-92c7-e43e-d9276acfad92@gmail.com>
 <BY5PR12MB38445E32AE9812D05E924BF1E1BC0@BY5PR12MB3844.namprd12.prod.outlook.com>
 <2b3b8be1-2627-d58b-56f6-d6bb915aefcd@amd.com>
In-Reply-To: <2b3b8be1-2627-d58b-56f6-d6bb915aefcd@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-14T15:15:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=03729b54-1b30-42c0-a5b7-0000cd56ebb0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-14T15:15:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 05455974-bc37-421a-a981-00004168c5fa
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.86.5.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ea65f68-0f79-4b6a-b18f-08d7f819b00c
x-ms-traffictypediagnostic: MN2PR12MB3456:|MN2PR12MB3456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3456F8814E0990ED7CE94621EDBC0@MN2PR12MB3456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MwXte0vj2FDT2RpcGnzGWK8VXAuUBVGkw2cT/7NvYFuBzYSevciJLuYysdO5zawYO4+jJAnTmEPk+Vr+1nUzZOuNqfMo2Mc78Q3UlZw/VSSo4UTj2ogfcOnfZGpeuylDay74eYoyzkdkjXu1xthGe5Ho+vF89LZXZpBLNeFyzovXc0V14OQ11txQv5XEI4/boAnEbERI1s897ipYyWbLwk+eQwh4MibsWBV9NtNoYakBQQmolic/b+a0MCdLfs4G4Sa1jH04Ki5oS4rhNpEInlDn6Tk6ySIqZUXL1aruQRapP7i3VBw3nJCIWieQXiTd7vhZfirutGthaIrr1Yd3qOlaxYRGpxjKPjZeExAVBciQPKeqhAmIllI/Foqj6LVFiydGypFh+2B5wniCAnCGIUiYoO2Jtw9IFtDPuGDCSyW/tdclF6OGPBteJoCJmkE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2880.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(54906003)(316002)(2906002)(86362001)(110136005)(76116006)(66574014)(52536014)(478600001)(66446008)(8936002)(71200400001)(8676002)(7696005)(5660300002)(66946007)(66556008)(66476007)(53546011)(9686003)(6506007)(26005)(33656002)(4326008)(64756008)(55016002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tsnDM3Z23yq7IhXidfL7zRldLHGPfeqyuQyXhEj5l6s64PvYZ25q34mthQAel9WfCK6HcLsDLjwFqApl2nM2I6iMJWtuh6SpZjlW6NMNxTZfZ2b0zn+uoZjztos/wRmHBMZZf4B3EcTMgML0p4ygihkuQgWkjButk47SeitBU9BHyJc2f6VU1lDZDaUKb7EPyAkaDNJD7F0zfLyqe9fMAeg/YQ5M1b6dHOwhKdxNb1hD1JiXrYmoas9mKAw4x3CQzWQ0sEYX8EQbFdun7rw6WzFJjQXIcLlKq1/7g1JJwFpzMbN12vBZwdyujlzlP6DwKegW19x0pbopV9i75moLfqFBa34u1qH7LtqSdeBsk+7Til5qzj43gSl5KBjlxNWjoCJRlJ5klgRnlHnfkWpk8BTa2TrYmfNIzZg2vaj4jpQm955S/iXk85oaVsFPveTqxkS+Kg0M+iQBbtn8EaAScVV2959qi6DAuqQi1nUxDso=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea65f68-0f79-4b6a-b18f-08d7f819b00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 15:15:50.6587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZx3YR1HhC+m9UknwIWkeryIGKxdJ2WWoyTnpd4qmQFki/qz/GBH08huepoj+RlH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3456
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
Content-Type: multipart/mixed; boundary="===============0446325613=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0446325613==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB28800BAEFD8F6201B6EC1B41EDBC0MN2PR12MB2880namp_"

--_000_MN2PR12MB28800BAEFD8F6201B6EC1B41EDBC0MN2PR12MB2880namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi, Jiange,
      How to handle the case that multi-apps do the auto dump? This patch s=
eems not multi-process safety.

Best Regards
Dennis Li
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christia=
n K=F6nig
Sent: Thursday, May 14, 2020 4:29 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-prayer, Pierre-=
eric <Pierre-eric.Pelloux-prayer@amd.com>; Kuehling, Felix <Felix.Kuehling@=
amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4

Hi Jiange,

it probably won't hurt, but I would just drop that. You need roughly 4 bill=
ion GPU resets until the UINT_MAX-1 becomes zero again.

Christian.

Am 14.05.20 um 09:14 schrieb Zhao, Jiange:

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,

wait_for_completion_interruptible_timeout() would decrease autodump.dumping=
.done to UINT_MAX-1.

complete_all() here would restore autodump.dumping to the state as in amdgp=
u_debugfs_autodump_init().

I want to make sure every open() deals with the same situation.

Jiange
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Thursday, May 14, 2020 3:01 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com><mailto:Jiange.Zhao@amd.com>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com><mailto=
:Pierre-eric.Pelloux-prayer@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com><ma=
ilto:Jiange.Zhao@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com><mailto:=
Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><mai=
lto:Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com=
><mailto:Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com><mailto:Mon=
k.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com><mailto:Hawking.Zhang=
@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4

Am 14.05.20 um 07:29 schrieb jianzh@amd.com<mailto:jianzh@amd.com>:
> From: Jiange Zhao <Jiange.Zhao@amd.com><mailto:Jiange.Zhao@amd.com>
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
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com><mailto:Jiange.Zhao@amd.c=
om>
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


--_000_MN2PR12MB28800BAEFD8F6201B6EC1B41EDBC0MN2PR12MB2880namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Hi, Jiange,<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; How to handle the case that multi-apps do the auto dump? This p=
atch seems not multi-process safety.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Best Regards<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Dennis Li<o:p></o:p=
></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> amd-gfx &lt;amd-gfx-bounces@lists.freedes=
ktop.org&gt;
<b>On Behalf Of </b>Christian K=F6nig<br>
<b>Sent:</b> Thursday, May 14, 2020 4:29 PM<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Pelloux-pr=
ayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;; Kuehling, Fel=
ix &lt;Felix.Kuehling@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Zhan=
g, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu r=
eset v4<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi Jiange,<br>
<br>
it probably won't hurt, but I would just drop that. You need roughly 4 bill=
ion GPU resets until the UINT_MAX-1 becomes zero again.<br>
<br>
Christian.<br>
<br>
Am 14.05.20 um 09:14 schrieb Zhao, Jiange:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Hi Christian,<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal">wait_for_completion_interruptible_timeout() would de=
crease autodump.dumping.done to UINT_MAX-1.<span style=3D"font-size:12.0pt"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal">complete_all() here would restore autodump.dumping t=
o the state as in amdgpu_debugfs_autodump_init().<span style=3D"font-size:1=
2.0pt"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal">I want to make sure every open() deals with the same=
 situation.<span style=3D"font-size:12.0pt"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal">Jiange<span style=3D"font-size:12.0pt"><o:p></o:p></=
span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig <a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Sent:</b> Thursday, May 14, 2020 3:01 PM<br>
<b>To:</b> Zhao, Jiange <a href=3D"mailto:Jiange.Zhao@amd.com">&lt;Jiange.Z=
hao@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric <a href=3D"mailto:Pierre-eric.Pellou=
x-prayer@amd.com">
&lt;Pierre-eric.Pelloux-prayer@amd.com&gt;</a>; Zhao, Jiange <a href=3D"mai=
lto:Jiange.Zhao@amd.com">
&lt;Jiange.Zhao@amd.com&gt;</a>; Kuehling, Felix <a href=3D"mailto:Felix.Ku=
ehling@amd.com">
&lt;Felix.Kuehling@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Al=
exander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian <a href=3D"mailto:=
Christian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a>; Liu, Monk <a href=3D"mailto:Monk.Liu@=
amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Zhang, Hawking
<a href=3D"mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><=
br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu r=
eset v4
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 14.05.20 um 07:29 =
schrieb <a href=3D"mailto:jianzh@amd.com">
jianzh@amd.com</a>:<br>
&gt; From: Jiange Zhao <a href=3D"mailto:Jiange.Zhao@amd.com">&lt;Jiange.Zh=
ao@amd.com&gt;</a><br>
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
&gt; Signed-off-by: Jiange Zhao <a href=3D"mailto:Jiange.Zhao@amd.com">&lt;=
Jiange.Zhao@amd.com&gt;</a><br>
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
;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<o:p></o=
:p></p>
</div>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB28800BAEFD8F6201B6EC1B41EDBC0MN2PR12MB2880namp_--

--===============0446325613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0446325613==--
