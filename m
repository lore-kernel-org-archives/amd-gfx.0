Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72159C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 00:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CBA10E17E;
	Wed, 13 Dec 2023 00:55:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F8C10E17E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 00:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4P9dxceUjZBvfKOE5IJ002schQgppGL0z/NrDuFxleWIEJmosLGkxkiBt7wFJTod03EInSezmmM2dZjdTGIfehEoM3V0TW2lvYEri3IRyA0V64sPZ/hjdbcSVYk97wFdIa8/oc8xlwuuBU4U1GAWLpVcAc2yxZQVr8ZndtJSItwjouSjfGLrnzggWQBbloC9DHJSMWFLk5PSzluntoDXuITC4AAS4m/ZGeVf0fTxwJPBDkdOLTEhxqfQvg0G8VmXknOX26yrqeoOTvcia64PnVCDuLksY69UY8mpGvCadTGcoz+ZKYfpLycqLz+jD44c210exazOC7snVdcyZ8rLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCsWEn25uC2RSWcztYqhbJYW6v8fdJGrdHno6bZfJbY=;
 b=kRqjjYwzZp9A8qEKoFphpNik/Da7wBquT+JG0VOhKtj3BY2WUKSsj8dcj8oc7twL+fXxDNO8YPmEWuur9lKGrgZ3hPqOkgdWjoSFKQhky2+4k6pMotOnPMRz0Iy8Cf0381PRiRdQnSrSdjY32GuHoaN6Bzi5axQjDoFV0iAS301xQtbrQrT4x6MIMQ/SSA6kBU6orVMgfGQu0p8HatH/346dytIEPm5Ot+g4aQ2pvQqPxvYy+ZMr2K5yZdKK1kEroQDi6T8u0jAmu7r/We8xkkUSbHlAEvtSN9Fk2Iz5VzkDMbnCojPNrCp/LlA4864jxoqJEoMwQor7u5wnWJO5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCsWEn25uC2RSWcztYqhbJYW6v8fdJGrdHno6bZfJbY=;
 b=d8/V3A/7VZx3v0xdBFNfUHs4zCAolzzSmS/ExRf+CrmM3Tdm6hZkbOYJdvxmV3YgvEiVbPLuvGameaZqtrAeSJn5Vlm3TobC4eNq6NI5fGRibhj7hvZiqnPHbsIKt3Qte4WkacLMGQpKCHHsKj5mgAf0d8A0Q/iHjds0pswleNQ=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.34; Wed, 13 Dec
 2023 00:55:10 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 00:55:10 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query
Thread-Topic: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query
Thread-Index: AQHaKWBcTFczVqz4cUmJC6OqmcSswbCmaYbA
Date: Wed, 13 Dec 2023 00:55:10 +0000
Message-ID: <DM6PR12MB5021CAF710E26D085BBCD92F958DA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
 <20231207225422.4057292-4-James.Zhu@amd.com>
In-Reply-To: <20231207225422.4057292-4-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f2f9bd4-d400-442e-8bf0-490ad635eba4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-13T00:48:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|PH8PR12MB7375:EE_
x-ms-office365-filtering-correlation-id: 13bd1d22-c5cc-4caa-0988-08dbfb762890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqvCXaxKPfa8A30qbVpKuCoy7zCQDT5X1JKJTVW4eoOYJYGQggomCw+Bd5khplYfeL1XeVomZCTgxM/GZNj9ab9lDv0KI2QnVUFGTljrjXS5fEaDAs5kozZ9Nva+nOMxPhkfX2RUmk8cWs3bm5R2F0qKkVhpH3oY1HOZY2nEIfCBmI2cStETf54CUFmEWQn6Ug+Kov4hnTpke2hjvyvF6tzrd1tvEO0VEjGf53pMfpkF7QsqMvjTpVqWNU8TYEUev32bKswmg5HAPcaDst2ytROSPbdKiC9BJBwBAJWKRPb+TQiyBgyQCObqQaDMydTW4/6sarNd2R8yplZoCGMGXLzW8590UmEhdgK0MQ+lNFb4/7lmK5ZrvKpjO0gYOUqmbkVm7DZQ2pjRsjOul7m1VBXAI7VQvcMX/hsp/u+ug2v0GLIHLBKGu2JOqgM8TIWacARXDP+Ds8lnXVUd6Xy6YL1PyakzWysFt1gj8NxzBOYA0Z7VlxdUiJwtfMvh3WXPSQKgrENNjnPTfjZVm0SKtaY3rBuuaQujVlfiAuKiWnQT8GUYsPfY8Tjqo5duZaC4ieMxm1Bosrsvll5SXL0H/4QbcOM82fMjVVG0+3Dj2xt+NzOGrj8LzCbl3nOCEb7z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(33656002)(316002)(86362001)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(110136005)(76116006)(26005)(83380400001)(9686003)(53546011)(7696005)(6506007)(38100700002)(71200400001)(122000001)(41300700001)(4326008)(8676002)(8936002)(38070700009)(52536014)(5660300002)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?apLMrJU4Sh46i0PUba2fEN9JOjdilfD+dqk7RS6zJ7ovKs2B7B9959ai6zpf?=
 =?us-ascii?Q?12O1EW7hSTIRe93OI9Wfv5nYjKNBmEo5nHpv9K0VKekFAg5ZJqAmuMAT8s7F?=
 =?us-ascii?Q?pL8Styc1xs28rPh2ZgLJfoekHpkOJJKOa8RzgEtBU6FIJR0VEt9ja/D9yu3E?=
 =?us-ascii?Q?tcXl+3l8KTESDxdvHEW7O1IinyIVXYfcH7AqrHx764YaTzwg1lZ4Z//vXxkL?=
 =?us-ascii?Q?Rpdz32IcO6E79PEtvFmZLx8gCcXrvrWQI1bSLnrRQgbRQrXpam/FK0QIRZfl?=
 =?us-ascii?Q?/vaG1qaKQASwvnDGn0dNFy2gjbhrgVMG2xkZV3i2oZX5qfLeIC8tspxAEIwk?=
 =?us-ascii?Q?/MlPf6sM59LjNLvql0MWZsNiItOJZ7KlCyOKMR1BDTiMQ4anIZ10kxknRxbL?=
 =?us-ascii?Q?82qJdLaLsuCkGBhPzNK3M5Qjy1VJNsQzHe8kbToUkDesL8zJpUEoQlaJmORQ?=
 =?us-ascii?Q?R6OShZtDii6SqaFNJnbW8C2CRugbfr4up6X6vLLbi1mLzj1+cqJwSBuWUO5q?=
 =?us-ascii?Q?EWRAC9In8ReDEq9XiFjPMNIywdzN8Yh/LWS6+gDPSHvCT2xadPZEODfxIExT?=
 =?us-ascii?Q?KWinv3jImUL0J77MDcmbEw0A30KJfvoYQp3ZndNUJOPgFR7ia2aKFLGnzhsX?=
 =?us-ascii?Q?JBpUAdGYtGOHR0wVRVca6oie4HxVE4lwzYSMaT/wy4OzSkc57QnulDCAzLCc?=
 =?us-ascii?Q?+GBZfOgxU0MniZMfmj8PwdWp/x9OlSNbsopJX2fVg333dc44fYS3m7jAXw2U?=
 =?us-ascii?Q?sQqY/0vfGJH4zB10HQBUBajWIH0P3r8hqzIxnfXGsF8Ycw3kYnn+eOyDEtqD?=
 =?us-ascii?Q?Vk+3d1MzagH//ECVPCQLKq2epal7Mp3bBRodzQqHbuwObLOQur7ZBP8j/h+N?=
 =?us-ascii?Q?ZuOSxOiKr04wIcio4JAfxkiRUtKGD0yXepJXPNV0iJ9TnbOGorr9W40Cg4mM?=
 =?us-ascii?Q?AWFvqjzbjHunSV4fsMXqzcDYWGekju+Jq4sCLuoQI16GEnrq/vPxVmqvN3Kt?=
 =?us-ascii?Q?S9izUS8ReifZDleT0ra8UUuRGcnhahbMt762Bjvq7ZcBjFww0NP0Q5eF4MxJ?=
 =?us-ascii?Q?25SOu/TcjJxhMgIpBGIna5BeCH2ITnp6yYEQWeIFJ5VBoUrMa+sKZCYhLPJt?=
 =?us-ascii?Q?gj4WLS9gp0zYC4DT6AVc6qM/gHHP9RfKLyDroSlui0eDgWHQ0EhWIB1cES2D?=
 =?us-ascii?Q?k+++8MUwbEMo5IaeuHQrQ2Vds9nKDPh3NctSCHR+jExdFY3REbWMF9Qx5eCl?=
 =?us-ascii?Q?BgS438YCvxETZIDpHr7+1svvQjSjmAyF0CiZzA0XoHGtkCQgPh0zyYb23Eeb?=
 =?us-ascii?Q?VxejPswWXPYgkN2viXwUnDGQFXk3tXAx6Gp4sB/FIcTjueG0FeHQJQumTu8p?=
 =?us-ascii?Q?NuFzhH9c7mmmJroip5Hnyo7CITFkSVNJGOzBUFRPz7OJKITt0opI3G5Ieoak?=
 =?us-ascii?Q?4Wz+n/9q//ASX/F0Cao9Uz6aRbsKfvcx1xR+DljiQQjG8NArk0DM6Rg540SY?=
 =?us-ascii?Q?68bsyP5ayOQMR2wuypCkBM8vvdS81Njk14cGsl4YdKzlXCEEEGs3CD6xMilX?=
 =?us-ascii?Q?zdmBkqYRoigOpW0RvT4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bd1d22-c5cc-4caa-0988-08dbfb762890
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 00:55:10.7762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knLB56P0O3HuZV/yBaPS7A+69uk6J/+OO2GytM0bBovmFSdOsotIFU8yK8usXch7TuExR3e8LrMlP6CB61iEDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Thursday, December 7, 2023 5:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>;
> Zhu, James <James.Zhu@amd.com>
> Subject: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query
>
> From: David Yat Sin <david.yatsin@amd.com>
>
> Enable pc sampling to query system capability.
>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54
> +++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index a7e78ff42d07..49fecbc7013e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -25,10 +25,62 @@
>  #include "amdgpu_amdkfd.h"
>  #include "kfd_pc_sampling.h"
>
> +struct supported_pc_sample_info {
> +     uint32_t ip_version;
> +     const struct kfd_pc_sample_info *sample_info; };
> +
> +const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 =3D {
> +     0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP,
> +KFD_IOCTL_PCS_TYPE_TIME_US };
> +
> +struct supported_pc_sample_info supported_formats[] =3D {
> +     { IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
> +     { IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 }, };
> +
>  static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>                                       struct kfd_ioctl_pc_sample_args
> __user *user_args)  {
> -     return -EINVAL;
> +     uint64_t sample_offset;
> +     int num_method =3D 0;
> +     int i;
> +
> +     for (i =3D 0; i < ARRAY_SIZE(supported_formats); i++)
> +             if (KFD_GC_VERSION(pdd->dev) =3D=3D
> supported_formats[i].ip_version)
> +                     num_method++;
> +
> +     if (!num_method) {
> +             pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
> +                     pdd->dev->adev->ip_versions[GC_HWIP][0]);
> +             return -EOPNOTSUPP;
> +     }
> +
> +     if (!user_args->sample_info_ptr) {
Should be:
if (!user_args->sample_info_ptr || !user_args->num_sample_info) {

> +             user_args->num_sample_info =3D num_method;
> +             return 0;
> +     }
> +
> +     if (user_args->num_sample_info < num_method) {
> +             user_args->num_sample_info =3D num_method;
> +             pr_debug("Sample info buffer is not large enough, "
> +                      "ASIC requires space for %d kfd_pc_sample_info
> entries.", num_method);
> +             return -ENOSPC;
> +     }
> +
> +     sample_offset =3D user_args->sample_info_ptr;

If there is another active PC Sampling session that is active, I thought we=
 were planning to have code to
return a reduced list with only the methods that are compatible with the cu=
rrent active session. Did we
decide to drop this behavior?

Regards,
David

> +     for (i =3D 0; i < ARRAY_SIZE(supported_formats); i++) {
> +             if (KFD_GC_VERSION(pdd->dev) =3D=3D
> supported_formats[i].ip_version) {
> +                     int ret =3D copy_to_user((void __user *) sample_off=
set,
> +                             supported_formats[i].sample_info,
> sizeof(struct kfd_pc_sample_info));
> +                     if (ret) {
> +                             pr_debug("Failed to copy PC sampling info t=
o
> user.");
> +                             return -EFAULT;
> +                     }
> +                     sample_offset +=3D sizeof(struct kfd_pc_sample_info=
);
> +             }
> +     }
> +
> +     return 0;
>  }
>
>  static int kfd_pc_sample_start(struct kfd_process_device *pdd)
> --
> 2.25.1

