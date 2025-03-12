Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B002C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 07:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD6210E72D;
	Wed, 12 Mar 2025 07:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gpLgikq3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F7010E72D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 07:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf8WzU31+F5JXALhVQFu+HQ5JYWiIgb3n3rrxxyW0FZ300Ch1CI1HTW4fV8KSd4fUnNdj4KKGDLydwBpTSJ1hF0NAGQrpKv7wnFYPy1a74TxI05V9AjZZ4gQ20Zd9m+aDGIcj+hRGDSnqUpuU4YlKZFj+LB3QCRMffBglIgzRnm5b9nv4PUF118vRWsV5lvWYzQWyA15emgi2vkJk0S/h4aFFPM5OA1T1sK4dDIuNXhLJfqLZ1IFL280MxFfhqzpwnDzfa2FsCMDWOJQxb9S+tCqGb+dYKjBXKmvMFzRPa5SW8IqeP/R4LgkS9mX5BWFQT47j0gmrZs8cuay+VpouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqhfBlpTGk1ClZtRx5sALejAIYFJkuXJ6H7UhFHmnPk=;
 b=DA/frauTNnQQsKXc5A2W7PEMMqkeaJS92Et6hoFzDxfNjZBdFT0WHci3c9VTxd3b1Nzxb3YDZsac2ykNUQXZPbLglCdldlHF7/+gQWJiZ+/fY/oosaVeqUXA4y20mvPoOVSmOrydEAH41rtLZQFj5IfmiNiIksoDqfpwDD3VAUdXc38tSUfbnxi2XKgkhvILP5l3p231kVg+GSYNdfFzwgMY+cDp5xshziunySNwAdIJd9SkkO20Iu2/LsE7xM0yjmQgRHdIJ+c0nx/JFjb7ELmGLI7krgcyELFL+AIyPXY4djzHonHqPIm98M6ExhrOTsD+skKbZPG7oHMXx7YUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqhfBlpTGk1ClZtRx5sALejAIYFJkuXJ6H7UhFHmnPk=;
 b=gpLgikq3wyjKoBKIceHkkQ77gQRWT0cMx44Cq0xxwQjnhbFYNLtMHo5pQexm6/iJKM/Rpp6WT0r+ih05B0QIFFbW2xeyK4abQfRF4TxTSQzi2rrA/RbTi0Rxt8t4DcVAb/IZXd66src2deMpjYhpCT7MXcplj5DCKbOWuaMKCKs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 07:17:56 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:17:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Save PA of bad pages for old asics
Thread-Topic: [PATCH] drm/amdgpu: Save PA of bad pages for old asics
Thread-Index: AQHbkxZHDoKXZrcMLEK+j1zGQZ60M7NvF3Zw
Date: Wed, 12 Mar 2025 07:17:56 +0000
Message-ID: <PH7PR12MB87969ED357C36E619ADC5826B0D02@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250312061537.1233118-1-ganglxie@amd.com>
In-Reply-To: <20250312061537.1233118-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b53e7f6f-8a2f-489c-aa55-cb1d8ecd3add;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T07:17:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB7531:EE_
x-ms-office365-filtering-correlation-id: 31d175ec-c955-411f-f248-08dd61360300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4RFdSAN3LUNKoB41kBg2NGdoveChxxtWn3QRxq3QYY7ILN47vTvqInvdiQBx?=
 =?us-ascii?Q?V+esP7HmoocyebRtX4roR9N99YQ3OpP43Epoz7nIRN2txfdmTLS3H5dQ1iLB?=
 =?us-ascii?Q?adg3GmP5WItH9qNLU4895Tiq7SLsjIBASrpxVubl1ZcN9Ekjtr57ZKvKXKwf?=
 =?us-ascii?Q?l13GH846xM9OU/V98PFHKksO7/EepJJ/2K7rOZO1INE77gwmjkXznIWxG6Uw?=
 =?us-ascii?Q?x4CrdsfvR1Xdru87+urSDOKRL6ZeXkzam05JOddc4AtkSEqf7uOjzcvr0inO?=
 =?us-ascii?Q?BLMHjmC1d03ojt3vmGRg8V2QI5F/58SkamSpd7Ep3VKZEzUTBn4UeQ26Knbn?=
 =?us-ascii?Q?7/6vAC4DlHCzap74xbtpAohqIMB6oCMU/VxawKanWPF2Y7Mg0daKNBAzhV+c?=
 =?us-ascii?Q?nphbjSDhTYoJcJ3P+unaXaxcBbfJGc4ShYlYe1dEiD1xak7bDq6UaUip5AVy?=
 =?us-ascii?Q?KNET7Ou4aAf1002+G6CO/KFSNL0X4p9eeCqqfFRLWGh1EWhfwdy1bYLQRH7S?=
 =?us-ascii?Q?GE+P27C7eWHvCOj0Ie+H3OdTGpEB6RiI6OBfAZQT7xmesMyXH3as+1+sruw3?=
 =?us-ascii?Q?avCBuUK3ewNu3estYtgOKdk2Y4jLb/PuO4FKYsE6cx2/xQ8KXmMEm7WETOUG?=
 =?us-ascii?Q?DZT3JCVuFOtq5aZFT2g2gpg+Kn6PC6vIF7TOBE2cEwZ8logJ1zYGEetMVO35?=
 =?us-ascii?Q?iDGpeCsHovCg/r8IlbiWnuFpfIO/WDEI+78qrwmICtkN33vfX6QU4EshEtZH?=
 =?us-ascii?Q?/qhsdqKDENIpC5z3/tmVMn3TuOZXgoOQLWQYyXrfYJGNvWDyrw6K5yRyNsBp?=
 =?us-ascii?Q?hhTj2Ag9/+jEv1gfFiEVbvC8r7gzmQ26N8/NLq6nQHJgjEoqSxg7XuF6H932?=
 =?us-ascii?Q?r1b3nBmuIvO29b37M9SN9yHCe+v0THO8mAeMPbz3nW7jIltEHTSCdoi7T/6s?=
 =?us-ascii?Q?/cGUnYr4PyrHBARQ0ElciYMG2iXdelZZf4GRJIYPXBFvxt50SZG1uctREDnz?=
 =?us-ascii?Q?V8H5teMgHH2JLbJQQnzfI/39/P14KKMeGLRw8zV+HXtBoBl0np+sq351DGau?=
 =?us-ascii?Q?vht5uEg5nmi1zPlEEFg43V2eZjQdNJCn3El7igrZg6crLfYJM8ufEMsQm3wX?=
 =?us-ascii?Q?ff7+K1864TfysYD7gzN6S5U4XTCcvrZFFVxsKg8gNE5tvsncFbwyTXGkuToL?=
 =?us-ascii?Q?u4I7S7bSZ6TgDGxrKt0qUHsnWEhFIU5i7PeO1dX3CVLm/6n5YaFY2JPJ/J+V?=
 =?us-ascii?Q?vGOiXcdFlxTS+41zof9m6OZLtBRypb4bfWUwWNM0/8reSYitsN92Q9h8Q/KO?=
 =?us-ascii?Q?uep10nnwQ/PZTm+MfZk46Fh277M24fWdzEY3K7Wg8Q51U5K6vu4Oe4ky6os0?=
 =?us-ascii?Q?u74bwkbuyFNA5bU7VhbEGCKpmCJUCGttbKEQ4tmF1tzrS4oOsYotUelsLLQq?=
 =?us-ascii?Q?HRwZAAi8rasiZbjhMgqUXPPnfvkOvPmR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmHw/ZI0DtT2YwP5ItJWt0mrPRRpPvLxac7tFUc5lRz6qrU8MSwLlQIgh431?=
 =?us-ascii?Q?a+bd1J/p2oUR6A3MOf6meTi8t6eQAglHEn31nwJ5lXOFiB7G+TqnyXFJquvw?=
 =?us-ascii?Q?gcjzqgDBoFnRoOVSsZQmeqFeQ8FxiF2QNygvT3Rl01HkLA8rrnbCA9QUptxD?=
 =?us-ascii?Q?lbOptF9mowDEra5kvElYcZpvR6SHEyVQGOvmyZbR/eznd58QyUYTO9+xQ4Y6?=
 =?us-ascii?Q?of6FfUq2spT2st1b/LLn7c4hfEJQeb8cP1fgtlhkKy3dCjuV2RabUcRyH46i?=
 =?us-ascii?Q?ItUZNCvab0cGiYAM2O4YEDVdVPOz+G3keh6SX2x1ttWozyUFgZtRL22xLsaA?=
 =?us-ascii?Q?sEWPlIXGIKGS+1XunJlFAqYGZlK877u2v+J0acuMXNnUZbnzw7po2L7UNHH4?=
 =?us-ascii?Q?tY8+ttaPj9WYjuoM3PkyBlu2X7paLbu4VwDO5QVZAF98EgqoKkos116We3iY?=
 =?us-ascii?Q?CCthUg0/n4e+FqhQ9H+TQ9TnqDjQzEfZl3dydMtMfLDuu73iwgei0HZ6oevZ?=
 =?us-ascii?Q?U90/7oWuyIl/nQkLh430PpJwIaRB+GlRQcxppSX8efot255staS6+K2Y1z5+?=
 =?us-ascii?Q?hXL4XUuxwT3odO0CJSAuRODcIZxut8Bzl4cGSBLrmgNzcVy4Pc5kKz2jG5LB?=
 =?us-ascii?Q?MhWqFAuxmXuyIJQ8qjcQapuecfUiZX0GIbngskNijEXXMPyrmkFgoRGr1qE2?=
 =?us-ascii?Q?PcQpjYyj3PWvirAPHBJ/YobtYxxVCx1QZf07TbQypTxShLvEFqwRM28coolU?=
 =?us-ascii?Q?y6+w3yNmwf1VFM3XtCnwDTNx/0ILQFE6XppVzpRSJvbtjNEikd4vFjzUzYER?=
 =?us-ascii?Q?mUI/7BrmgORXwzqSv5iE0wGMivcCteCt1l0AuuhKuWui86WRqmZYiVJy2oML?=
 =?us-ascii?Q?9yLcq3BT8EQVDImDPGb7GemGEsxsXb7xgVsUSgScBSd4295TXVnZRPe77TOB?=
 =?us-ascii?Q?Blgg/EZkF3anzLeBRzyIEjqLbWsVqDezpSxSDF7SnujpxYAKO0GSOOdG5brw?=
 =?us-ascii?Q?UIR6MnT9+qLCrGtggZsYdMskXO4blBCl/Io1gOtuTp8KBR3fCHKI3ZoHm4Hn?=
 =?us-ascii?Q?XcYiMtWQKJfP0ssYVbaAx7ZuSvXV7sncakBOb5czBaHam1Z6nejlWOPSiL2W?=
 =?us-ascii?Q?zud5hr4gq6UQiQZxOKS9/f78HWU9oCSKzqfo2bNAR6BIPvV/iU1/SGL2BeyQ?=
 =?us-ascii?Q?q4Wc0cv4Pz1NUkQz7C6wriynBCH4AOHOb8HcodpWteHYotMMYCCf2+d5cnXE?=
 =?us-ascii?Q?HFuskJYyUTiKqSFffAg8lpncuanBg6IUs66bxiv87xaCkLka/0CbnFa8dIdG?=
 =?us-ascii?Q?ftYtQ0C80F7Qo/gZqbS09/LX0TaXVJZ1c6Q0XRy5nJrAKH9q4maF4eBJitw0?=
 =?us-ascii?Q?GxJWdDlTeKGQzeb3S/vWP48BSlu6HcUAnl0ROJNLRYy808Jsi+v9pI1eiG8y?=
 =?us-ascii?Q?hSLeNQfSNh4XLwLTH7E2430p0waLH2yhJFX0FqKDDafeSOPa0dZtSYHFf2s9?=
 =?us-ascii?Q?4gV3ciDVJ6DMoC1YJhbyL0VvBYf98AbH3c9/px/yn6n/u+yWiOko5s+wRTLk?=
 =?us-ascii?Q?bM8WCt0482HLtOZ5SYc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d175ec-c955-411f-f248-08dd61360300
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 07:17:56.2581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0w8IPSbO2Nz5kZJdNn/NU1P9rq0JIczJf79x2Hz1WT2ecyeoxLe6y/KnOr9S3nZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Wednesday, March 12, 2025 2:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: Save PA of bad pages for old asics
>
> for old asics that do not support mca translating, we just save PA for th=
em
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 24 ++++++++++++++++---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  9 +++++--
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 285e3aa2bb2f..7cf8a3036828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2836,6 +2836,13 @@ static int
> __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
>
>       save_nps =3D (bps[0].retired_page >> UMC_NPS_SHIFT) &
> UMC_NPS_MASK;
>
> +     /*old asics just have pa in eeprom*/
> +     if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
> +             memcpy(err_data->err_addr, bps,
> +                     sizeof(struct eeprom_table_record) * adev->umc.reti=
re_unit);
> +             goto out;
> +     }
> +
>       for (i =3D 0; i < adev->umc.retire_unit; i++)
>               bps[i].retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
>
> @@ -2858,6 +2865,7 @@ static int
> __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
>               }
>       }
>
> +out:
>       return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr, ade=
v-
> >umc.retire_unit);  }
>
> @@ -2981,14 +2989,24 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev,
>
>       /* only new entries are saved */
>       if (save_count > 0) {
> -             for (i =3D 0; i < unit_num; i++) {
> +             /*old asics only save pa to eeprom like before*/
> +             if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) <
> 12) {
>                       if (amdgpu_ras_eeprom_append(control,
> -                                     &data->bps[bad_page_num + i * adev-
> >umc.retire_unit],
> -                                     1)) {
> +                                     &data->bps[bad_page_num], save_coun=
t)) {
>                               dev_err(adev->dev, "Failed to save EEPROM t=
able
> data!");
>                               return -EIO;
>                       }
> +             } else {
> +                     for (i =3D 0; i < unit_num; i++) {
> +                             if (amdgpu_ras_eeprom_append(control,
> +                                             &data->bps[bad_page_num +
> +                                             i * adev->umc.retire_unit],=
 1)) {
> +                                     dev_err(adev->dev, "Failed to save =
EEPROM
> table data!");
> +                                     return -EIO;
> +                             }
> +                     }
>               }
> +
>               dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
> save_count);
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 09a6f8bc1a5a..3597ecd9baca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -727,9 +727,14 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>                                    - control->ras_fri)
>               % control->ras_max_record_count;
>
> -     control->ras_num_mca_recs +=3D num;
> -     control->ras_num_bad_pages +=3D num * adev->umc.retire_unit;
> +     /*old asics only save pa to eeprom like before*/
> +     if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12)
> +             control->ras_num_pa_recs +=3D num;
> +     else
> +             control->ras_num_mca_recs +=3D num;
>
> +     control->ras_num_bad_pages =3D control->ras_num_pa_recs +
> +                             control->ras_num_mca_recs * adev->umc.retir=
e_unit;
>  Out:
>       kfree(buf);
>       return res;
> --
> 2.34.1

