Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE987CD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C30B10EAA0;
	Tue, 19 May 2026 07:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPbL6wPl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F4A10EAA0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 07:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqNkegmMNCPS12W9D5/Y/Gxj0SfreqD6wes0ujbr4F+aUuivx7taXVvPSk/naOs2UTf2WI/DocXYDPaPgs2X1WZst/Qx/3FylYjLaTMRuxVvPFOzANVp3rjVQ8RmLLsdQDYvQ18qGpdB5umde/yOBR2K6fhtcYNzDgxtqjSMkF/PdQyQZ8Al3SC6Mzpz3h4RKJUp+krSJGnfWeVrmfddPdRpyozMHGZqN2fsnvI83sVrkT/BROJ5xMRR8ooftNBKe3Kiln+RMvfTTu5L8DXcTduscH5/Draq2haicgrpHfPQzazYQp3TtaujKj24y8/zduKs+UW1DISQMtuvnUjJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XOSVrmXMeq9IHqA2oPLy3IBGVko0ohqgAEgBQRUQCs=;
 b=fDJb9GWfAd97mWpb7x5xKMnkgOdR6YyN4WcJ1Sy5UVrQAt3UzdNCwKVd6DbMPLos8vYgNae7eZnPlGXod9TNvqrvs6Io844+OtCbdrMNcMAv4SJjtTBgvK3GxsUn3rdjBpqLF78k2pGoIUiAvqrWDam2QtPIaR9WOvxhu6XRstsmpLuYhWRcPMxT93qYmnBzqhz6GIaXST7FE9rpvzJwIsO0Hbmeugfz7clfp3CyP44NRnzc/ikw7ej717ORn9gPPJofgQ5DrCQOpIOwamBzRgw/M11IzEEkpWdjAuvtRyv0JV5MVNBMDgd/vcwIehiJSHt4rcJkc8WHAPuRB12kbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XOSVrmXMeq9IHqA2oPLy3IBGVko0ohqgAEgBQRUQCs=;
 b=wPbL6wPl9lE3aTcl5hDS2RE/CuUk5qrww0o3Mbd3/gDuQsYbqa7KetwTmL50HbFOA2E4/xKRlg5lklnfdh+mWjjXISj7aALWLWv9xQRjFcc8QugWYhWzCc8CaeLMffvIDq7Gb85yOi5Eh/LqVl9CvIDO4XEK5yK/7oTiPl7ikFo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 07:00:39 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 07:00:39 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: return error when converting records to
 nps pages fails
Thread-Topic: [PATCH 3/3] drm/amd/ras: return error when converting records to
 nps pages fails
Thread-Index: AQHc5pFtNAwvWn+mWkux/YE3eVJMkbYTq9LQgAE+9gCAAAJgIA==
Date: Tue, 19 May 2026 07:00:39 +0000
Message-ID: <PH7PR12MB8796424EB7787425C979566AB0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518064053.2778626-1-ganglxie@amd.com>
 <20260518064053.2778626-3-ganglxie@amd.com>
 <PH7PR12MB87968C198CFB0E3C5B94EE36B0032@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BYAPR12MB259733094FA6E477E818C3BAE5002@BYAPR12MB2597.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB259733094FA6E477E818C3BAE5002@BYAPR12MB2597.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T11:50:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB7907:EE_
x-ms-office365-filtering-correlation-id: b2547529-60bb-4e58-0a07-08deb57455a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|4143699003|22082099003|11063799003|18002099003;
x-microsoft-antispam-message-info: CM12OaACkT8MH/myoLQnT9hs0heYNMhzdauGv+bb3SqjN7wUYNzMpJQa90cLRz//+V+/fxdHCuKMmGG3yQiCx8ux6cUyHMELCxrG5IFrJaSCFbemKOq4uxS/fcas14aUW7SpveUJ2XbXJTxdIUJbsgswDFL9vMeip0d7tBiSOeixXGX6XDnNAeQIEScMJc5z+4dWF3z6mg8fFbpYSknnUCdMkeUmgR69FUXrTs5HvOrUbrFJ1WukWM4pANxwQ0KIfCG3wMsMk1wmdI3pYUru2xkYAliXaQtzjQCLzqGU9ZjyhmNSwkZW7rH5xQi+dP5F8JkRKzRCqwfNGIY6YgED/reNbM172lZ/iND3d9xuEw+RU7isMr3YUSY+x8Phm8m4yYRpDgNE71CZkplFEJyMW14pUmNutlTZafYIdaCfKqiDu1cNgB/gToBHJZdqjdhAxc8L0IFlvqtlDqbDPKzB7Hon8FqdYi9bLbfXl+62evR0iCUdVi+DNRXpkMaeJtR+tWvncMVK6Xto7NABS9/6gfHnA+yiUlW/56gBxTavj3w2jLN2QmDszLpBh4bQ3Vh22nkQiWO7YaZB0ckHAOu4iA8vaCtcl2PPSjGaCpxnXj08uS/CyUFoGe9BaXVR3FXdkqa6yUvdqoNGWu2z4ugmxxHZsqF9E2MqsH+pi4j1AS43aTFU9tgJ7Qd8xBzknfsbz7PNDSFdEJsi7QL75+aturjLmEwh7/ejyzYLsrJsN7uSMVxqQJl+zL5nue6jdV23
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(4143699003)(22082099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k4RMe70IFzSoXkKk82kQRXpQV4BKcJ1EaGwxK1KRanljDmwG/y4hajMj8gr4?=
 =?us-ascii?Q?eekasdcAJXKQUjmtgwaT3bvwSP3B1WEn9Inw1mP6/nMqakfWSjTiy/IoQzeU?=
 =?us-ascii?Q?d+Hob9BG5RqCmo7ClnFN0nF419FU1mUmtZWu6wv7lpwzdd90070xJ4Jj8gpY?=
 =?us-ascii?Q?gDoWjun1ARQJRtlBlkaJXvEAHBPR6KqzpOLCyyzihQqFazPud1y+VRvGcC/X?=
 =?us-ascii?Q?s7nBoIxlqWQXixPeuKp8duRi1u8Sfy7nDBJ6HWuJh3v/dkmUouphlaVfg3Qp?=
 =?us-ascii?Q?TORfFFt5i5+HbpGvvGT6j87FTmDEJq0kgk74rcxNDF0dwmCXF71y7EVYHMj+?=
 =?us-ascii?Q?Kx+J3DnviadMZBkUR5uumAgauYJawNGBeIlwCL2+A52qPhRK0V7ZZAhPf9on?=
 =?us-ascii?Q?E8Fx15On/TbldudvWor/utPL60WmUzWwaO9eBoNSY3zO8TFQDnIGEuMlPfWF?=
 =?us-ascii?Q?JAaNsoquyA+St3zrbQxvwlXIFBCiVaPJEl2+t5u87UyQm/nmupiPK3PDiest?=
 =?us-ascii?Q?kGFgFDPp5nW5Wve2WpF4p15v41jBWOkH5uUNx/RPdetpnOE3rOXwx98lUxMZ?=
 =?us-ascii?Q?lNtVwQXMeZbhy876Phr51T29GhH1Wvl3OCMiKfvEZdNKmlE9ITcQ+zCIJsoa?=
 =?us-ascii?Q?04epFFwwG9ZkNsBOmhoiJUKk8fYB+8X/nJ7q4fNml3ZzGakVNjFmCJa0Nn/p?=
 =?us-ascii?Q?bRWIuf1v6gEVSRfv7evR7CE+vtLbsGLvNrSuEB1cMptTNvMWbIB9kNQolWTb?=
 =?us-ascii?Q?YYScZ4FcGTLZtrCDSI2GTBv4Q3pI366huc/SIcx/leKK3QQWJqvTPzGUpFqv?=
 =?us-ascii?Q?buvrXM+/dxtoFQDutDxuJFuu4utsaI/o6sCTmIRUBS49R8gkbb7Mpx+vSdmM?=
 =?us-ascii?Q?z9zA8FdYPzDGoAOYmYKTsvJO65iBQwNBvglKAx+w54gRbMKzgImwi2o114Ju?=
 =?us-ascii?Q?T1Y6tx8hQQLKNA8uMFoucnQXhpHZepDPg83U91a/7e1utBRToLnVdbj3C5QW?=
 =?us-ascii?Q?IFrHfEH44DEbZQ9lQ8G60dbcmg5tmaipzCzm/4vXBX55ADrsHq1orxbiNpUm?=
 =?us-ascii?Q?Z28fQ6PB+qOi06OrTJOBRvBvvmkzwhBKM0de8Do2VlX5XYlVPOqcH5A5sLYp?=
 =?us-ascii?Q?gkfQQX6Ee6Hz6AneTVFju4USfS4k48oNgLe+J4ZBWuiPWnAo2lx8BPMH8cbf?=
 =?us-ascii?Q?uLXXzdJLxN4G12ZcKiO0xWezbXDguMlPv47eXCyjfaVGO6QFMi/3e3vQfJQZ?=
 =?us-ascii?Q?g1IQZpKgh0xmZXfPh/sGciSOLqX6eLh5SMu5HrzWuDSLM6KNPngfmiASbN08?=
 =?us-ascii?Q?6lwXZE4XpbV082PvJJIVHvx1g32uYqFqkSnQSU4HaQILsxkmtS6jk+lpzmNk?=
 =?us-ascii?Q?kEUUZbTGUIp8jJ/ca0nhe5YsHf1mzr5XILlvA1odHjGXzxyVg2/k/z4CdCLd?=
 =?us-ascii?Q?Eb3lrEktpXedIH00FOKO6zl37nnD1d0C2opTzh0FyOjaeRZuKIrGdpGvyq5y?=
 =?us-ascii?Q?+GQPorZqNFy3JmKryA2+Gw2K3BqY1szd5I0sviEX8ESLP1AORqTAYUBiNtNM?=
 =?us-ascii?Q?ZAsMGTkILktIh/KMZXb7TeqZC7xbyyQOeA8Iuv7zv01uvJxI8Wylf2P7yCdm?=
 =?us-ascii?Q?x5cTH3nuZTJpDLGjmTb8fQr467/QEky+VlAEHS2WqMINBaxwO1B1/BQ64t7b?=
 =?us-ascii?Q?UzaZRuiitZhd2nmMtM36ggNgIC4hELEnBJXFRPG6C7D01Zxq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2547529-60bb-4e58-0a07-08deb57455a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:00:39.0610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X5u7KgP2eWiZUlDiRZKhCq77pO2Q8KIKgc6QGURigpxv5uWvcuhWmawNOit/VvR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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

AMD General

I see, then the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, May 19, 2026 2:52 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: RE: [PATCH 3/3] drm/amd/ras: return error when converting record=
s
> to nps pages fails
>
> AMD General
>
> Hi, Tao:
>         'Count=3D0' and 'Count < 0' both mean there are something wrong w=
ith
> bad page lookup, so they are both treated as error.
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, May 18, 2026 7:52 PM
> To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: RE: [PATCH 3/3] drm/amd/ras: return error when converting record=
s
> to nps pages fails
>
> AMD General
>
> > -----Original Message-----
> > From: Xie, Patrick <Gangliang.Xie@amd.com>
> > Sent: Monday, May 18, 2026 2:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> > <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> > Subject: [PATCH 3/3] drm/amd/ras: return error when converting records
> > to nps pages fails
> >
> > return error when converting records to nps pages fails
> >
> > Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> > ---
> >  drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> > b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> > index d4072350f48f..78db402182f7 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> > @@ -391,9 +391,8 @@ static int ras_umc_update_eeprom_ram_data(struct
> > ras_core_context *ras_core,
> >                       data->space_left--;
> >               }
> >       } else {
> > -             memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
> > -             data->count++;
> > -             data->space_left--;
> > +             RAS_DEV_ERR(ras_core->dev, "Failed to convert record to
> > + nps
> > pages!");
> > +             return -EINVAL;
>
> [Tao] are your sure the error is also fit for the condition of count =3D=
=3D 0?
>
> >       }
> >
> >       return 0;
> > --
> > 2.34.1
>
>

