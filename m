Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F72BC021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 10:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5C910E1E9;
	Fri, 21 Feb 2025 10:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h18WZ9MD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4998C10E1E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 10:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/xW8xH9lZm0rPrVolotxAGd4hOUaZ9yhoFjgeq7Q34KiY1E5Nr66jajHTYDDSR7EGOFIT9eB/vrl/6xu9pyyvGZCKSzhq4Qc7s26MqASEgixIvnYCsJ+TkrA/yzCTKL7Ud58RUdJ8Ktrwyr+LxqEusjSVMEyoJkLklFEhBQc66nyqxR10d8Xh+Yb/krcnGtOiXAWk10hXhsvATUDYz50LVfZOd5NkUwuEaFyIxGSyBcbbiz6QnyY2J2TUz/qSJLAgw7v7Z/+z/bn18stiqiyJR+5pEL0yMQHc23QaqrODfPZD1PkjeMhoCsqxX9TjzRsJMWtL5kyCkAITuED2pR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCehT/RYvOSsghqkL7RHXa6G1dvFxx6j+JHJkqIS+KM=;
 b=VW7KpNrr+JjR847k8KH/SLwdfgXDj4FYe/7rRPtJXEUAqjjiTyjsjlOEP+SLvzQynvkW2svoj6o4cH0EBmOuY0FB9BBQ2Ltqb99ASAeNRiuU9Y4AsAp7VO/0rCN8aDxOWklq84cY4+SHI6qBgwgtl/fcZSXkYjAAI59mbvvE7V1t54QVhVsCtVh2tLCaW3YufCwpUlPxLAQLbK3kApul6U5yZFU6pudmH283ba49RAHs0xwnbkcjVzVeFW2Z+ldkUfSi2OHx83MiO+FfcQRDtTq9CYwPfsfK1VZbcWFFtWiNb5QMNUlmO8TV7XZ3yqM4Eob4aVDmVyTfiWTdInvaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCehT/RYvOSsghqkL7RHXa6G1dvFxx6j+JHJkqIS+KM=;
 b=h18WZ9MD3ksefCDKavrIBj+MK6vaQm+A10zXQKffGre4AN4zxABGCnUjVYoiV75mFJe29FvtrTzl5w6pXGhgV1AlyDmCTyRkyqLeSnZDgMhz33twMn/l0qRBUg/3tVh8SOEd/sYT2ccd/8UyR/j36PYfknE3ELI/UiLr9X+IBoE=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 10:18:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 10:18:45 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Refine bad page adding
Thread-Topic: [PATCH 2/3] drm/amdgpu: Refine bad page adding
Thread-Index: AQHbhA9ezPDXl8uhhUaibatzcUkn/bNRi5+Q
Date: Fri, 21 Feb 2025 10:18:45 +0000
Message-ID: <PH7PR12MB879612F8691DB0366DF2AD4CB0C72@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250221031835.1105893-1-ganglxie@amd.com>
In-Reply-To: <20250221031835.1105893-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f43e6d77-ce39-4ae0-874a-a41f11e938fd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T10:17:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB8068:EE_
x-ms-office365-filtering-correlation-id: 7c6f1439-d8a5-4f07-6542-08dd52611fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L8SKXP92PbGSo1ExH5KPELJHx6ci9urd09+8jCRiWMutYnXgjCeCzagEWwxi?=
 =?us-ascii?Q?QYeLg9tWTNLqJwc+KgbOkaGATqXRMP0UWpZgaJtrQPQKZ4DVQMnp3oOv/7L7?=
 =?us-ascii?Q?sX7BzEyNzLOwk1SxtB/Bp0uXEXb0zNJcBGpGQuD0jzRj3jXZq3buF1kVMVbG?=
 =?us-ascii?Q?eGlyPRMbQKhnjjmtJ/XUedhGKrgsdjSVjwQtGHT8HlaQ8GJGv2k/7MQkNhIz?=
 =?us-ascii?Q?QUdAkrAC6pAaujtsXdo7RsV9AZ+AP8ng/0fqWqoKspLREzz0wJNmmxS+rsUh?=
 =?us-ascii?Q?/HwJOUBTL4jBnOMz4htWAnm/cvLCpor9FGZ8DUiNcc5hznmmINEL0/cAD0Te?=
 =?us-ascii?Q?TSyEW0tT2ERJYfhnnlnwt2PtHiPyXwiFxI/LIw4KaY4fUFCWGphmQjW1sXVu?=
 =?us-ascii?Q?yap/UhlJlNuPXpt0YutkaUkeHHtBvwnJG1673Mh/Z65TR5Ceo8J0E26I1cJ/?=
 =?us-ascii?Q?YG8NC6/PeupxHcX5jcx9apYgTt8l+3HXnzXwK0K2aKJsy3vf4Od5+nNJzCEp?=
 =?us-ascii?Q?ZUXPGmP4WEdVD3XuLfBEWuj4fYnlxm/7m01f0jqI3fv13OwdwsLequBihbzS?=
 =?us-ascii?Q?j11dCOFiTpxIuW7hglqstzjy7OUCY0G6m3HfkZDeVdT4Ukg9eae8fYquw6Rm?=
 =?us-ascii?Q?QC0Iabi0hT1spsF/qawTSxi6oYVB+w3WlaKPUWiL6sjgTi9VP4rWDtFp6Ymf?=
 =?us-ascii?Q?ZVCohj7YiULY4VACWEimWyMhBMZErhyab995+Zb+izFg4nn3MBAkAD9DhDE/?=
 =?us-ascii?Q?FaeZ/4gqkLPhLILmbcWlGISnG0YS+x/tGHU6Uhc4ut6clzabiXee/eZsOMiw?=
 =?us-ascii?Q?3NPzDgYRuxgAMVGmAQOhiLsYoZNkYq11p4eE8E+lVDV1PNZr1F54EWk9Nrgj?=
 =?us-ascii?Q?M+cUt3mWL+7Jwqs1rpMUC/LucR/qd3BZjklvdzt+9Z5k6xf3lg4DY6Xafalg?=
 =?us-ascii?Q?20LixL+MV7DfQfSPpqj4iPe04Pzzic58kG4Qf428EBXh3fq4PPOY2W+dkibk?=
 =?us-ascii?Q?SSIn+k51CsuQQYK1Rf3BqBQ7rwX0HDeQowwjZnbbE6oA6l7yPGPQL4FKB5N4?=
 =?us-ascii?Q?kv1eFXgKAqe0yMDddyQOsL76GDzCDwL5V9pFbEPF6IcphW/QpiOoKcXMCdSL?=
 =?us-ascii?Q?S6m4/svJ5rMs7L3qN5Cvoqdlmc59+vHiLXQlrJPhfW1Eq8D001cWrzDYYN1+?=
 =?us-ascii?Q?qryOuMTvqc4qy21s53bt+8OQuiD2G5O9sBgLxF2vMGE8ZvsjkZBtQ2X/nH47?=
 =?us-ascii?Q?4rWY36cCeD94gqxT8CLuiCk6i6KjDWAUUkZPswZlRRr5xkIsCGWGSfoky4te?=
 =?us-ascii?Q?Js3w0GB0IOVjy5j0tiP+S4rWeFUxhYcTCAHEWqrdTJfKp+mvYXN3Y0vYmUnV?=
 =?us-ascii?Q?StM9chQ4YETc738rN5sy7SVfLB/qrxt6/J9lAQIWwqCFLxuagSnwembu/KxG?=
 =?us-ascii?Q?dayxQgk6n209h54TavKFyDHJIxONnpsI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9qw0LWyxa+INka2gKll3+iW/EFMhxx5b0QIs5xe+ParvOw9mX4NvHwseEEQn?=
 =?us-ascii?Q?FaLKFNwMMceeEkhQOOOQAmIjbOAALnWAuu5TjGQzOe5RulDiFIrOZJYAzqy6?=
 =?us-ascii?Q?11a0tX2b3UPYWOecKbx+uOeUwZG5aCtC6na5Vn9yUkiwdJXE5UHg6DzYgyli?=
 =?us-ascii?Q?RsCaR/yRGxTH5l9/Z4BL+H0bjK7FE4xL2gI/G5UDIYmvhw8/YcpmOLl6bhU/?=
 =?us-ascii?Q?MvXs05ReIrLhW75r4LGIqQRR09mtRbagRznylYV+sgPKHvlPOPZ/ss2Q9sPQ?=
 =?us-ascii?Q?Owm8EFGvZ0tCbQTWER/1FIHRb3IXEBQbN9CwjQEUoa1zKoihg94TxeqUPaYh?=
 =?us-ascii?Q?bQwFtbbQTsZUHCXxXKtwNG7qu/B4JUOPX6wEdNm5aUOE0z1CLOndUuP6rI/Y?=
 =?us-ascii?Q?JbAfDaUNdiALqvG3cq2pTEXJc5grAquO9VddB/g1BnqezhFDlcwRImUNkNaz?=
 =?us-ascii?Q?KKA9XiQHSvr+lAdGN1+WZUpplT4MyFEBWUOrY31+5vI/6SAa+uS1hYnPFXWk?=
 =?us-ascii?Q?GPE9dqRbd5k8+ajBow+tcYxgvzBNZNhndOS1FbNVYodUKDvmrUcPjPmWEozK?=
 =?us-ascii?Q?bPYSq+q41yEUmXhz6Ng3G3TPJPYlDZGTDeIb1ONhPHeZMBBBf3ROxQpNm6J+?=
 =?us-ascii?Q?3jYdooSfBHO7mGiFpmKMjBMpXaacdjBOoo1kSPWuNHFDcLGaccLQxG1X80Pf?=
 =?us-ascii?Q?/Llc6YGp8xLnAKIeRMd/ut0z5PCMTXufUrD7sIrLY6VDgE1/wndPTpbz9orz?=
 =?us-ascii?Q?gOEarcMiCcIoF6JjzkRotM1i142R8AzIuqOFcMhcHrBud6E8oHIFQnyCF5kn?=
 =?us-ascii?Q?eCF6fwR+1ikbonLUObzrNDqUHsYLIxyCjxTIIRHJxl0KxXaHQcWk5QNo6yRP?=
 =?us-ascii?Q?IMz14TnF65MBWM+FsZcY1biXXvCdLRjIyl4Ts6MS7t9SEaKBMf/5Kan4kiZc?=
 =?us-ascii?Q?fkJ2GQ/nj0Cc15lj8LA0ZHUEVBbzDIpk7DfUIjMP3QmrrH6k/2xYBQsMtyfD?=
 =?us-ascii?Q?VlI4hIhgX35uj9VHoyXFXOTqshCBzHnhvmhX9WvZ/gPArKjoKrHQn/0q22ut?=
 =?us-ascii?Q?U9zsdKAqLsD/lk33MyZpgEZ/TLQ0Tp0cWu8F/V/71z4RTarpTEPZA5XqjPBS?=
 =?us-ascii?Q?BuJGKvMFwNx2Slx0JtXpQo+yATx8v97cGi2BMj08ktp/CmwJr00+RqWqxKiV?=
 =?us-ascii?Q?ngVaZLN4xBto3ImJ60i/+A5rZDu3mpWlMl4xfPX/PI3pw6uSrdN1rrS2sQIp?=
 =?us-ascii?Q?zVT6pCs1xXBX9+ogV9vBpZRuXBsr6hXTG8bEyTSmBQVeNK8hKg12qflE8U8Q?=
 =?us-ascii?Q?mAhdoX/DttjXhwnOTxEPGAKWiD5LpV8KU380sJ/cgemwWH4s4baNJ7nqq+eC?=
 =?us-ascii?Q?TvWI5/nbCM1apdkN35r5Xy01P05Rajmf3MlX0JqnrPtq657k9vrsrrt2Vo0K?=
 =?us-ascii?Q?vyvmTUKyq2wFoiTDpyvKxrtz4sP7bXqva5irSWVfHzxgmvnwEUi6GgxYOQpe?=
 =?us-ascii?Q?ncBmlWWV5RNX6+hnD4aRWWtbudCY0CxGm85M5+dC5P3GuSVLA4jqkKwsX+11?=
 =?us-ascii?Q?x3DNzx518nGf/5lGVlQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6f1439-d8a5-4f07-6542-08dd52611fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 10:18:45.3452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKgihq/LC/D0xOM39Z5QTOpytQ9RLLAhwQ6qfaUckjFiuHtt+WP9KWtlbQEibpU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, February 21, 2025 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: Refine bad page adding
>
> bad page adding can be simpler with nps info
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 196 +++++++++++++-----------
>  1 file changed, 105 insertions(+), 91 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5420e2d6d244..439841a2d1c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2801,20 +2801,101 @@ static int amdgpu_ras_mca2pa(struct amdgpu_devic=
e
> *adev,
>               return  -EINVAL;
>  }
>
> +static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
> +                                     struct eeprom_table_record *bps, in=
t count) {
> +     int j;
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct ras_err_handler_data *data =3D con->eh_data;
> +
> +     for (j =3D 0; j < count; j++) {
> +             if (amdgpu_ras_check_bad_page_unlock(con,
> +                     bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
> +                     continue;
> +
> +             if (!data->space_left &&
> +                     amdgpu_ras_realloc_eh_data_space(adev, data, 256)) =
{

[Tao] space should be replaced with tab

> +                     return -ENOMEM;
> +             }
> +
> +             amdgpu_ras_reserve_page(adev, bps[j].retired_page);
> +
> +             memcpy(&data->bps[data->count], &(bps[j]),
> +                             sizeof(struct eeprom_table_record));
> +             data->count++;
> +             data->space_left--;
> +     }
> +
> +     return 0;
> +}
> +
> +static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device
> *adev,
> +                             struct eeprom_table_record *bps, struct ras=
_err_data
> *err_data,
> +                             enum amdgpu_memory_partition nps)
> +{
> +     int i =3D 0;
> +     int ret =3D 0;
> +     enum amdgpu_memory_partition save_nps;
> +
> +     save_nps =3D (bps[0].retired_page >> UMC_NPS_SHIFT) &
> UMC_NPS_MASK;
> +
> +     for (i =3D 0; i < adev->umc.retire_unit; i++)
> +             bps[i].retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> +
> +     if (save_nps) {
> +             if (save_nps =3D=3D nps) {
> +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                                     bps[0].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                             return -EINVAL;
> +             } else {
> +                     if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_dat=
a))
> +                             return -EINVAL;
> +             }
> +     } else {
> +             if (amdgpu_ras_mca2pa(adev, &bps[0], err_data)) {
> +                     if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE)
> +                             memcpy(err_data->err_addr, bps,
> +                                     sizeof(struct eeprom_table_record) =
* adev-
> >umc.retire_unit);
> +                     else
> +                             return -EOPNOTSUPP;
> +             }
> +     }
> +
> +     return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
> +adev->umc.retire_unit); }
> +
> +static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
> +                             struct eeprom_table_record *bps, struct ras=
_err_data
> *err_data,
> +                             enum amdgpu_memory_partition nps)
> +{
> +     enum amdgpu_memory_partition save_nps;
> +
> +     save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
> +     bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> +
> +     if (save_nps =3D=3D nps) {
> +             if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                             bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                     return -EINVAL;
> +     } else {
> +             if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
> +                     return -EINVAL;
> +     }
> +     return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
> +                                                                     ade=
v-
> >umc.retire_unit);
> +}
> +
>  /* it deal with vram only. */
>  int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>               struct eeprom_table_record *bps, int pages, bool from_rom) =
 {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -     struct ras_err_handler_data *data;
>       struct ras_err_data err_data;
> -     struct eeprom_table_record *err_rec;
>       struct amdgpu_ras_eeprom_control *control =3D
>                       &adev->psp.ras_context.ras->eeprom_control;
>       enum amdgpu_memory_partition nps =3D
> AMDGPU_NPS1_PARTITION_MODE;
>       int ret =3D 0;
> -     uint32_t i, j, loop_cnt =3D 1;
> -     bool find_pages_per_pa =3D false;
> +     uint32_t i;
>
>       if (!con || !con->eh_data || !bps || pages <=3D 0)
>               return 0;
> @@ -2825,108 +2906,41 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>                               sizeof(struct eeprom_table_record), GFP_KER=
NEL);
>               if (!err_data.err_addr) {
>                       dev_warn(adev->dev, "Failed to alloc UMC error addr=
ess
> record in mca2pa conversion!\n");
> -                     ret =3D -ENOMEM;
> -                     goto out;
> +                     return -ENOMEM;
>               }
>
> -             err_rec =3D err_data.err_addr;
> -             loop_cnt =3D adev->umc.retire_unit;
>               if (adev->gmc.gmc_funcs->query_mem_partition_mode)
>                       nps =3D adev->gmc.gmc_funcs-
> >query_mem_partition_mode(adev);
>       }
>
>       mutex_lock(&con->recovery_lock);
> -     data =3D con->eh_data;
> -     if (!data) {
> -             /* Returning 0 as the absence of eh_data is acceptable */
> -             goto free;
> -     }
> -
> -     for (i =3D 0; i < pages; i++) {
> -             if (from_rom &&
> -                 control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_MCA) {
> -                     if (!find_pages_per_pa) {
> -                             if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i],
> &err_data)) {
> -                                     if (!i && nps =3D=3D
> AMDGPU_NPS1_PARTITION_MODE) {
> -                                             /* may use old RAS TA, use =
PA to find
> pages in
> -                                              * one row
> -                                              */
> -                                             if
> (amdgpu_umc_pages_in_a_row(adev, &err_data,
> -
> bps[i].retired_page <<
> -
> AMDGPU_GPU_PAGE_SHIFT)) {
> -                                                     ret =3D -EINVAL;
> -                                                     goto free;
> -                                             } else {
> -                                                     find_pages_per_pa =
=3D true;
> -                                             }
> -                                     } else {
> -                                             /* unsupported cases */
> -                                             ret =3D -EOPNOTSUPP;
> -                                             goto free;
> -                                     }
> -                             }
> -                     } else {
> -                             if (amdgpu_umc_pages_in_a_row(adev, &err_da=
ta,
> -                                             bps[i].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT)) {
> -                                     ret =3D -EINVAL;
> -                                     goto free;
> -                             }
> -                     }
> -             } else {
> -                     if (from_rom && !find_pages_per_pa) {
> -                             if (bps[i].retired_page & UMC_CHANNEL_IDX_V=
2) {
> -                                     /* bad page in any NPS mode in eepr=
om */
> -                                     if (amdgpu_ras_mca2pa_by_idx(adev, =
&bps[i],
> &err_data)) {
> -                                             ret =3D -EINVAL;
> +
> +     if (from_rom) {
> +             for (i =3D 0; i < pages; i++) {
> +                     if (control->ras_num_recs - i >=3D adev->umc.retire=
_unit) {
> +                             if ((bps[i].address =3D=3D bps[i + 1].addre=
ss) &&
> +                                 (bps[i].mem_channel =3D=3D bps[i + 1].m=
em_channel)) {
> +                                     //deal with retire_unit records a t=
ime
> +                                     ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> +                                                                     &bp=
s[i],
> &err_data, nps);
> +                                     if (ret)
>                                               goto free;
> -                                     }
> +                                     i +=3D (adev->umc.retire_unit - 1);
>                               } else {
> -                                     /* legacy bad page in eeprom, gener=
ated only
> in
> -                                      * NPS1 mode
> -                                      */
> -                                     if (amdgpu_ras_mca2pa(adev, &bps[i]=
,
> &err_data)) {
> -                                             /* old RAS TA or ASICs whic=
h don't
> support to
> -                                              * convert addrss via mca a=
ddress
> -                                              */
> -                                             if (!i && nps =3D=3D
> AMDGPU_NPS1_PARTITION_MODE) {
> -                                                     find_pages_per_pa =
=3D true;
> -                                                     err_rec =3D &bps[i]=
;
> -                                                     loop_cnt =3D 1;
> -                                             } else {
> -                                                     /* non-nps1 mode, o=
ld RAS TA
> -                                                      * can't support it
> -                                                      */
> -                                                     ret =3D -EOPNOTSUPP=
;
> -                                                     goto free;
> -                                             }
> -                                     }
> +                                     break;
>                               }
> -
> -                             if (!find_pages_per_pa)
> -                                     i +=3D (adev->umc.retire_unit - 1);
>                       } else {
> -                             err_rec =3D &bps[i];
> +                             break;
>                       }
>               }
> -
> -             for (j =3D 0; j < loop_cnt; j++) {
> -                     if (amdgpu_ras_check_bad_page_unlock(con,
> -                             err_rec[j].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> -                             continue;
> -
> -                     if (!data->space_left &&
> -                         amdgpu_ras_realloc_eh_data_space(adev, data, 25=
6)) {
> -                             ret =3D -ENOMEM;
> +             for (; i < pages; i++) {
> +                     ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
> +                             &bps[i], &err_data, nps);
> +                     if (ret)
>                               goto free;
> -                     }
> -
> -                     amdgpu_ras_reserve_page(adev, err_rec[j].retired_pa=
ge);
> -
> -                     memcpy(&data->bps[data->count], &(err_rec[j]),
> -                                     sizeof(struct eeprom_table_record))=
;
> -                     data->count++;
> -                     data->space_left--;
>               }
> +     } else {
> +             ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages);
>       }
>
>  free:
> --
> 2.34.1

