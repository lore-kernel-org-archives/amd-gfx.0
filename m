Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D95C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 07:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4805510E5E5;
	Tue, 29 Jul 2025 07:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyu6EPnc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C45710E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 07:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gly0RpTj2lmgUpD7imuqWnth2ZOz44G3mRPraKp+r4oIvpamnRcfIKUCpAJwR6SRxZTZ2nrrDP0BItdfxsQtetekh+Vp0VT9xNKlQrdcrPYtsRbrwYpxv8lgs3e4qp5/IA5p1f1bcxs6Injj833/VUmNjb5EbzCRmvBMM0HgQczUS0c7cqBmwjfmHqEpvmqKQQc0bL4kjJab5BeHv7uBxvMauf3AbXwokfHnFpTv0dzGzKD00VaacK/ZrIlILQyDBN7JbxCWXwUAF0K6MoPyQ7UO8tEhCRDa4snhyP3dnX1gD4BBonvh94be+RQWKaYM3vIgF90IGw47qTc7sW7IZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/+K0qdJgcKw18GXAL79sp4e4qJL7ofsVf43e0gA0Kk=;
 b=K4z34xGs8Zi1bxODqkCrRF/yH+ThUsbpg25Ot+PEnUe2zhla6E+gi0QJ7MJ72txjm9ThOMLZivyb8GxrVo4j07sLRKt9S2S7p/5NMwSHPILR5PFhlf6Nts26yTYLo0+7G4pzxjezKjUDuBiwFh1rgUvUfqFCO9AKUmXqeAehWDv8RgOQmlaR7e3QK3Xbmdk+X9GzkEdMuyVJYmoCmGGoGtit3Mc2pZEqvBNiLDpT7MurmOHqsSkx9N4KPAVOgTJXXX4oA4OZv6SpjTOgDIA6GoRYZj4WZEmrBOHrX8FW4nFQ3tI8uRZKa6VJJ5NYDI6/Sbpel4IY79WfYKSpKyAHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/+K0qdJgcKw18GXAL79sp4e4qJL7ofsVf43e0gA0Kk=;
 b=pyu6EPncUL2o2+AQnhEd56wjQRiIbWAHzVUvZLzCoEyb2GoXa7YH7u0epq74uHkfStzeIDl/qPGFlVMWPmrXUXSpeUwWoElJ+o6V6Lw4khtya1db0V1cEYRLvdrHZQvodfo0OtkUQ+5Y3UnxXr10QZHs3P6KhbEqUca9C3Cr8M0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 07:37:55 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 07:37:55 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Effective health check before reset
Thread-Topic: [PATCH] drm/amdgpu: Effective health check before reset
Thread-Index: AQHcAFbInaimGKUsSEWS2j/9iKRq9bRItq/w
Date: Tue, 29 Jul 2025 07:37:55 +0000
Message-ID: <PH7PR12MB8796120A8C09C1E697B272A7B025A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250729070117.76523-1-cesun102@amd.com>
In-Reply-To: <20250729070117.76523-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T07:37:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV3PR12MB9409:EE_
x-ms-office365-filtering-correlation-id: 42c4bd3e-cd49-4ca7-0d9e-08ddce72d502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?w+3g2hBVoELcXY8zBx70Rm2+jMw3LLiQ2NRufx3oQt9ZyEg/EcBHtNN1s6G7?=
 =?us-ascii?Q?JRZhd0kjgv5U4uN/KwyIswR/12+AOxE18xxFzuzCa1zdnSfJo81tANyWy+OD?=
 =?us-ascii?Q?dnEyzw3+glwZNHr/x3gKll839sZcA+B5Kl6A2FfKxj4ZH9N0dyP+jPub8f1O?=
 =?us-ascii?Q?dfycJKG+bH7uaCi9ZArtkH6/KBs8aIQaylztxwAb8pDAK1SAPeNGFltDI8O/?=
 =?us-ascii?Q?jzuMIhoxZkXpxrBv4kpkN7VtqtKP36ZG2NEi4WWEoBp+V6AZr4uOYNT6GC9U?=
 =?us-ascii?Q?z/zu69BzdnC7AbQrnbj6FYfwH0dIchgaYsfq3Q1WNF1nFPCz+gz1EbNz0fBs?=
 =?us-ascii?Q?xhXxSgQOOmjp3SWjAkFNWb4LjQ+gXSoitQZHVnBwz2LLOc76QdN2/b72tOBB?=
 =?us-ascii?Q?vHbFnw8P6Py9q2g8Hxo31z4VK2qvHgWIgstirGVKJhLiF/M3R5t6MhCX7s4d?=
 =?us-ascii?Q?sbZ1DBDPSusslOPxHWjTpMQAqbcM3BjdDwD1UmTkHRP9Lf25Z18ZdbdkfA6D?=
 =?us-ascii?Q?+Mi1v9VHBc0Cwmx8pykuEf1ciI/4j6BSSPQ8GgBD+hp2mGIRJJoHxnRriyPS?=
 =?us-ascii?Q?xdhWZJtIBAzZem5k/jHlWhTfsfadwDvPZyOFAmCJb8TBBmepsXnmsgXvqYaD?=
 =?us-ascii?Q?z/sM1nGfqiECgOf5LVw2zaePToY+E0OyOLFr5hEi2GK+yb1WuOrKdtGNRgqv?=
 =?us-ascii?Q?YCvZ//yUBPxKEL/M10sP3so/yrDCZsiFxQHC0nBK1jO59dPiKmeSXm40e8tN?=
 =?us-ascii?Q?/LEX5LebbUXy4y6nYkJ2ZZmYPSXV/XJ2z/2IUeFJjVZRG5k5NOZtvzfRvah5?=
 =?us-ascii?Q?/6kZlc/9qhyBJeGVQMbmGk+p9Gmc84bMYfwNdUyNVrWK1vdk0swY5EqWsFAs?=
 =?us-ascii?Q?aF4l1WZ6uJgxlpoPaiurzpq3nqKTdIWpi0Tf2HojtroB1hHmaSOSCUvhTjKO?=
 =?us-ascii?Q?TsyAq6ifDf4UOtbBaSnrbjDKtLK8Ug9dpW9aI1s8dqoa9NTyFdk49Cl8Clli?=
 =?us-ascii?Q?Y7co0oQPqqNGGOckLSXCd2UJYjxecBJuFKuH07DOP85Nxzk1ud7FZltmKz5c?=
 =?us-ascii?Q?Zn0l2NC2WLi3nI+iQ/k/nOWQFCkjHqjXb3GN9ZTI27PkbQa0oKskqz2ArqQ0?=
 =?us-ascii?Q?f5z4zZfOdTvyPE0W/vCZ1b/m1Toqgw1kc85DWtNonFuOv/OvrqkrdtJhSJrB?=
 =?us-ascii?Q?bKfpEUcjeVI5xsQUzLtRhNzZlbydRB0kHm7DwN2w79vZvsCiALMCiMGZw4B9?=
 =?us-ascii?Q?JBAhBKC8XlasJMwESUsjluiVaGm3IuDfXaBXiQzZDSa0YUv2FltTFEYMks75?=
 =?us-ascii?Q?qee6uAEYFBnOx5Kyfv0OpbJHtZgQer7MEc0w9nXmsi4pexDTjWDBxv4rxaJv?=
 =?us-ascii?Q?MzPuOmq9Z9eXRm1lfMPTPajmUai+y7RoYXHDZ1/yl+BsPv0EuCopwMYCVj6R?=
 =?us-ascii?Q?7jOUoIhTqDtoXGGjsgX8yIdOpyW2ycOxDFl1qebZnuzcHabi92KH5g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDjPc6ri2Q5uwUZrmUKdnXULtOWPzmP+2iZ5rqvmvsaRORer80fysOcgBmh4?=
 =?us-ascii?Q?UNdZZLujJwBBKgKSQPxIk5u8695l07QQNcA/1vNTLX5mchCKE5pKATAnG9Yf?=
 =?us-ascii?Q?GOwQpv6i8EeDJyak+iaAXwqCZ5gqwhmW0ftMqMbP37AxPMRBskN84dmPCa8y?=
 =?us-ascii?Q?TjkJHMHkjDe17Q2bi8M2mS9/LXoczjoyZ6W0wJ69ZSm8kNwUDmuKZQVsFb7a?=
 =?us-ascii?Q?x6gf+Z6mCjxxHbFrLzz6BCwdw+G31bUlSKVcFCu4h+4sX0fKIlLwHbo4iP3v?=
 =?us-ascii?Q?TrKHIut78beQxKo0zsTGc+XUfnYd+kut0DaXKAvBiDMXZDh2QsfegzrUmU7W?=
 =?us-ascii?Q?ns7+IB1muBQOD12be1uaJ8doAFtzcNBQpY5bINI7lDzRiR7C2xyDATPTk9is?=
 =?us-ascii?Q?mPBaTlG1M2PLK+1+hde3WYzwr/keQoJzOYCoUH7UvMNew95R6x51Jup/3NaI?=
 =?us-ascii?Q?5IGZcSR4L16KZuKubunrFZ/hlYUIP1n3P1nNjmU8WBUtaxMd8nmklfS/9ckq?=
 =?us-ascii?Q?7tZy9kDgXrYAEFhyllbC+DETuvBBMhHqJbZBlArlC1YdNIsRuZ+WtlHYtaRw?=
 =?us-ascii?Q?M/5Oh/WWHfI3zeSyLd5QZdu12oFi2x5gjXsGa6f2XQvuFvc44PLoSUnAqL51?=
 =?us-ascii?Q?ZCy7vsmbDGoFx8WN1GAAMXD5Ub/5HJsuHsj4bdUHlEPu8t2iLK/p8MZZsG8u?=
 =?us-ascii?Q?S5/Cj0Rt9XRw0pRYz4zSXabpkHle3mmGVjxGEvQN3Wuid8E1ukaMiSg3K3Vk?=
 =?us-ascii?Q?iZtZCv2NoRA1Jvzc1oFZ2l43rFHtIvtAHzyiVY0WkjUp5Asu0Lnq+/HPpkp2?=
 =?us-ascii?Q?G8/XQ+vAH73iCYOp1yyW6kHMoM+BlyeSjc3JctexVur+iIdIo5nH37AsMYBI?=
 =?us-ascii?Q?vieSArTU/6Z+QHGD2LE/6HJJgul5lWqBBTwGzQe1YdfQeFlBQoUoGGx0yCFV?=
 =?us-ascii?Q?wiz5wkEfQWlz3nQVRb0lveujxqk7jh11KqSohGK/se1C8V1Iq+P9yl2/Pjbv?=
 =?us-ascii?Q?p3dEYs6LN928vZqJYyXBSrg4GVXI2nbph7cPciI6sxQUGcwgjzOuVUSdn+O8?=
 =?us-ascii?Q?zdbTSMuvLlLADQ4+S1uVgyCLlSm5LjTl/uJY8eYplsgC7ibIzFgV6FZoNNuO?=
 =?us-ascii?Q?fAYEZID2Ft3lJRqbrzn/VeugZ8nRx/PD4bjNLI5G0N2nxVD5fRCj3NShVkhi?=
 =?us-ascii?Q?4bNyERDr7sMkckhSbeyDTuE8SFzaSZvyJ0cggqTDrRVDjzBshs59QxdXYO2T?=
 =?us-ascii?Q?VmixgncKckwP5Cl8y3xSb5dvCmiqryKl6i39QLrC0wKnJ5jXjVubk3q/sZPs?=
 =?us-ascii?Q?jXpUR6isq99YJcE42Ch7yXjezrBGRJtiD42iGLJkdXXWGWMA+mmwjLiq8Gyx?=
 =?us-ascii?Q?PeGKBOfaWHn+0ttmXfdvRIuiIGUTAiWycygSBMkVFlzDKMp0Qt9Na/q4WPXE?=
 =?us-ascii?Q?+Mi//P53zECn6fue6z1L97IHf37eoBwxiyfrlkaRvxDLTdznhy17Sj+b0sMM?=
 =?us-ascii?Q?KLIWR2HIEBFgp2/xjLFMx42ar7qLgheUmXq40IzXeNXRz3gStJdF7WG0znJs?=
 =?us-ascii?Q?wOqPAWobJJGticPDWiY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c4bd3e-cd49-4ca7-0d9e-08ddce72d502
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 07:37:55.1349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32rI89rbqHuzxa4MPGBO8FC1WtykQ0MeLYyxZ7dSwDVfjMSxUc8BYoGlbTGAccXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Tuesday, July 29, 2025 3:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Effective health check before reset
>
> Move amdgpu_device_health_check into amdgpu_device_gpu_recover to ensure
> that if the device is present can be checked before reset
>
> The reason is:
> 1.During the dpc event, the device where the dpc event occurs is not pres=
ent on the
> bus 2.When both dpc event and ATHUB event occur simultaneously,the dpc th=
read
> holds the reset domain lock when detecting error,and the gpu recover thre=
ad
> acquires the hive lock.  The device is simultaneously in the states of
> amdgpu_ras_in_recovery and occurs_dpc,so gpu recover thread will not go t=
o
> amdgpu_device_health_check.  It waits for the reset domain lock held by t=
he dpc
> thread, but dpc thread has not released the reset domain lock.In the dpc =
callback
> slot_reset,to obtain the hive lock, the hive lock is held by the gpu reco=
ver thread at
> this time.So a deadlock occurred
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++---------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 343155f5375c..efe98ffb679a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6128,12 +6128,11 @@ static int amdgpu_device_health_check(struct
> list_head *device_list_handle)
>       return ret;
>  }
>
> -static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
> +static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>                                         struct list_head *device_list,
>                                         struct amdgpu_hive_info *hive)
>  {
>       struct amdgpu_device *tmp_adev =3D NULL;
> -     int r;
>
>       /*
>        * Build list of devices to reset.
> @@ -6153,14 +6152,6 @@ static int amdgpu_device_recovery_prepare(struct
> amdgpu_device *adev,
>       } else {
>               list_add_tail(&adev->reset_list, device_list);
>       }
> -
> -     if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
> -             r =3D amdgpu_device_health_check(device_list);
> -             if (r)
> -                     return r;
> -     }
> -
> -     return 0;
>  }
>
>  static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *=
adev,
> @@ -6453,8 +6444,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       reset_context->hive =3D hive;
>       INIT_LIST_HEAD(&device_list);
>
> -     if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
> -             goto end_reset;
> +     amdgpu_device_recovery_prepare(adev, &device_list, hive);
> +
> +     if (!amdgpu_sriov_vf(adev)) {
> +             r =3D amdgpu_device_health_check(&device_list);
> +             if (r)
> +                     goto end_reset;
> +     }
>
>       /* We need to lock reset domain only once both for XGMI and single =
device */
>       amdgpu_device_recovery_get_reset_lock(adev, &device_list); @@ -6952=
,12
> +6948,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>       int r =3D 0, i;
>       u32 memsize;
>
> -     /* PCI error slot reset should be skipped During RAS recovery */
> -     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))=
 &&
> -         amdgpu_ras_in_recovery(adev))
> -             return PCI_ERS_RESULT_RECOVERED;
> -
>       dev_info(adev->dev, "PCI error: slot reset callback!!\n");
>
>       memset(&reset_context, 0, sizeof(reset_context));
> --
> 2.34.1

