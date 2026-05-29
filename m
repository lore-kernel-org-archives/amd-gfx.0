Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC39CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 08:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4736A10FAA0;
	Fri, 29 May 2026 08:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xmC8s0BV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2242B10FAA0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 08:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhSSpW4ggasCJcIzMpbSUDJv6xDumV4egB5hsQSt1kBIoUb2Ma0YW2DWioONoPMNlFP52jniUWkIg3nhO4Lg/qGXgelqbU1L6yS5qQfv8s8zUcaCunHazrmqcE9NWRynNOkOLz4vPP/WJdK72TS4KIT0Si2dIbQpX4KOzybHXGwcjzbbGxguqbfYJb1oRDNpKjkwfRO29xDXMMBPAkwix7Qjpy+zhLy7Yui7jer+9oQIwTLSvf0KLf5/1H4cpp07ZzYwOMtfAE9CNe7Oq0y5m/73oJKo/ReFZqNDzeuP455f2pwNOTPK/cheBqvR8ooPB6oM8W7GJOnCFoHD28pZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXvbioDDN5W37hmS8Yk2dlS+AZUu/u8gT9MVemYtWW8=;
 b=Ep0H+A48yYeHatllC4DbIcQlMJZlNjNc/6qileSavv7iwbxKiXhlATn7xZtSJ/Fe4yhv/2HCE1GPK8uERJ2Dp+7z91eDhnngrAP5rDFZ6QsVaTVHqffNmoVnVvenvFiQQqgYOxWJ+N/HShbTvFdaHx0qtuePOa7C6+cHOf0WLSgbr25xBTMVzVpLEJPVTxzb0cN+zqRscit+jAhipgKY2/Ym7RWMojcznvOn4bXspAchz5UaBwNoTzfJNW2mLj3IO7NQ7GBl0GJyiTT88+T+w3HvyH0Z+H8uo1OgrksMWKX8zr3J1vx1QNdRQXRG0BwGSLHuDQtWU1EeX/qYmUs1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXvbioDDN5W37hmS8Yk2dlS+AZUu/u8gT9MVemYtWW8=;
 b=xmC8s0BVt0ML+353gE5ILJR1la3waDnCLgktoTQjEmamdy6bTfVDldxZPLm7MppE0KqkkZ0E1ADAGn3aGMifaAJBEod0Zd6g94bg//zZwMEiKNrmRB65mWvwUJqraO9v9SsiqazWzNggBlEHTWROokpupcQj6DYzOAG2OJBDLig=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 08:11:35 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 08:11:34 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
 printers
Thread-Topic: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
 printers
Thread-Index: AQHc7zMiATTs52bkPUijEL4YACEOF7YklPtAgAAOzQCAAAMTYA==
Date: Fri, 29 May 2026 08:11:34 +0000
Message-ID: <DM6PR12MB2972702420A90D52439BABB782162@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529061920.357400-1-asad.kamal@amd.com>
 <DM6PR12MB2972DCC91EE8D0476171F39982162@DM6PR12MB2972.namprd12.prod.outlook.com>
 <DM4PR12MB503807B3B231B9FCFB6517588E162@DM4PR12MB5038.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB503807B3B231B9FCFB6517588E162@DM4PR12MB5038.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T07:06:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DS7PR12MB6262:EE_
x-ms-office365-filtering-correlation-id: c760cf41-59a8-4bc0-0539-08debd59e64a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|3023799007|6133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 8OEyvZLtoBoPrq5lYnPdYjkjo0AE9RUSCLwSPdV0sJ6l7T9yzrqGlAQhhyZIAbHOTSAy5W/WkXVB4V4BaXL1M3CqJeZIpNGMJVeFmIHmIvvIEJWOEXGfRwKW0AQn5ZsQxnigxk5FqjrIu2o3mRhflfHsVJ1Vt0ChQXaLUvENr+UL4NXD2ZpVdW9mMGTWxL6wniKiz5vCKsddgKZdiA37bX9ukASD2nuPU18uIlXM+ZPo3cxjesgb54Jw9qS8OgC4+ozYxiA/LCUtcnK6ldGJI7fVZsafnjMdXTx05Tr9O6o9vV9S9V9rcmUsAsyTKJeVnmAC7X6vDuCG5YyomH/bIHDRIDqguAkgX4JRit54gRVbzp837sEq/YadCMQjylvNjCEc44tBd22Cd2viECnDaeKby+z9WznjVPVCrKiB3v9e9hPg9A8krFSyzRvkRDLjgl2ELZGbts2EvdoVwbnVqDq8BfZ5yhSfp19G3EcYNN3rxFU6ITSXAvWJnh2bVCgrMqU+BnKx8sBQ1+wHXsrZGZ0lxYAoGGAD2v2V0t2N59WFS8CKzBzkcdnPm7frHc3A+gcmmdoaGLAUOVSBga1nTkNb8sgx83tK3N90jGUVbcahxTftayGnDtmXzOUVf346Jdjeh2lr+4xg9ExT3+v0ehQ5ZsmjlOxkTLI4NjEzJ5fFzRWPPD8VoJOEX92J8rTE5fBFBN5iDuMDxbqa1KFJeK/DiO4794vFc6BcaDL3rV9pQV5ADxftK057iX2ymmXu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(3023799007)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jSKN9258wWxJEg4HvBg4hpWxJHEkVTHfppauOT3Lx/FRAMVB6YgecR4+7mqf?=
 =?us-ascii?Q?NC08S+JpI1XGrHcFD60TDBHxaY0yjR+BCXWjIAez5QKuw5eH5kg7zp72TKKJ?=
 =?us-ascii?Q?CPRxgCwaqYTyCCFYrZihtyc3JwRsZRKgnowkgyaHsKxmeoVQjx2qFxYYBANT?=
 =?us-ascii?Q?IN8W5YNC5hIisSv4rkEZGb0sWRh3RPJDdgd0CpxpS1HKA1BCSDVZPRJbdwRa?=
 =?us-ascii?Q?rtnYagllWXLMiN897XVJtIelAS++5nYMOnf189okw7gJiFXFCwRzP7vHZi6M?=
 =?us-ascii?Q?OpxOIFBwurY/Ix+ZBpsRXkYOKsEQQvE5MLaL8HN3SLHLjxAzanAhsuFUupBU?=
 =?us-ascii?Q?D5E1q/p5StjGyhbNSz6TYS1LxMTGmPP1ciA8qc3cFf55+913djlgU8FNat9Y?=
 =?us-ascii?Q?wWEZP9LSXWYxK4xrzISiQGJJTGYRogBdnuLmsbbzEhCVSlxNHqHLbBbzpnFU?=
 =?us-ascii?Q?sZNjs4IAdbluowwmW0imaQs8tvvLa3o1CWSskQdOXbNRMknYTz/yu7NQNol5?=
 =?us-ascii?Q?1jB6/JSL9BCHpYupbLzGEuf1TYO78A6qQeBc4Xx5yaAmq/fBgA4E0NMSQDxp?=
 =?us-ascii?Q?fYc0IXlfsi5UZio9+kjxMM7DcKlzV80/ouEB8vxs6gdXMBUmxubeHN171Ea5?=
 =?us-ascii?Q?Ayn165zVpC0KteK3SypAwoKjBF1wSWp53atX7viXmMcxZDSfhxZNcw+8NEKO?=
 =?us-ascii?Q?PyKR63AFxKtidTv/K2ZxAAeDhQJLF+Bq6uYtsUGZVIf8HCTmuRsVdccMaVxm?=
 =?us-ascii?Q?yCzVdDYV6g8DYTUe2KHrw5xRhTF6YpVcvJZJP/e2x3zRV4JLN0ibr8YiqEQ9?=
 =?us-ascii?Q?bXFJ0KDDbYoIQXH59TKk9usXdmmEdEIIWwK+NhcsH/01KQDlkcZkxf1DZ9q2?=
 =?us-ascii?Q?YMoffTu00UvnmVWTogmUi4R8kAzbpHIT16Emm7Cndxt8p6xVcsil1Alg4F7M?=
 =?us-ascii?Q?dxMfXvttqrqBm41jxbmVrisBTyHfgxuH2ZG8JV+HcqpTE+Hf6EoZbTc3/Lkn?=
 =?us-ascii?Q?Bu8P/FUlKALJrGu3xHc4zFuBTQMxUWm+Fg7VfO3JM1YzXquJkb4v5eu2fEdu?=
 =?us-ascii?Q?tQFmBTrB1YyWboCnpZwDQX+brEEvbFE7Z5rSkfOXVB7sXlE7tV9tq0V7XVTB?=
 =?us-ascii?Q?bxhesEDa1ijKcJUSrNPie3usYFuDILQXT97Y/5xYvvCMHQElBdW1HqO+2NFL?=
 =?us-ascii?Q?k3gw4oD6Iv0vEwHKQP/JELOBKQLz8DaSe/m2Qe2NGR9vp05+lWaAyeh9Ghna?=
 =?us-ascii?Q?jawKGMoxZQRQLkHEwcCnrwshIw8YgFvcSpabtuFIjc3w0uaUdN6os6UqMIzZ?=
 =?us-ascii?Q?PKYoA5fCIjQoWsrqtZKl7KKZKMpzXaplTaUV2gIeMWqMQNjmt1gn5EBaxtZi?=
 =?us-ascii?Q?DARqDMVEHjGO8OtdeWXCPloumnX9FSPDfaZBl61xqbioILirkGtOTwKmdBVO?=
 =?us-ascii?Q?Axfmrhtl4dsnlxlYFlcZ2cT68oeoSpVz+0SIVH3KeoWRmVvtP+8PNp+xA8d+?=
 =?us-ascii?Q?dS0e2I2w/9KjneRi2YujhgR4JwrvOLhVQaUiBUObu2QppD2aYaWSZScM9zhC?=
 =?us-ascii?Q?WP2C+j74mdODW81NwTnJf20XX4jJm8MbhSEZ6UsEPe/Rayh325zip+kK6BBZ?=
 =?us-ascii?Q?2nyifHSvkTMnXWmL2DR8gEmtMxgL1odcL9zNKka/R45tuVyap+kf3tN4cNpW?=
 =?us-ascii?Q?4q1VJ1YOD1vaQznmgeAwoVUc7JU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c760cf41-59a8-4bc0-0539-08debd59e64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:11:34.6248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPi2XOlU+1Oxp6DQr2HUFlklmPNthJZCzltn0SB2Z0Ju2iCJGcCRQheOqsmKz9kd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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

>> Alternatively, we could add a single stop condition in amdgpu_get_pp_od_=
clk_voltage() instead of per-emit checks.

I prefer this way. Thanks.

Best Regards,
Kevin

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 16:00
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
> printers
>
> AMD General
>
> Thanks for the review.
>
> I agree that size +=3D sysfs_emit_at() is the common pattern for simple s=
ysfs show
> handlers, and for many SMU paths the output is small enough that PAGE_SIZ=
E is
> never exhausted.
>
> The checks were added specifically for helpers that append many sections =
into one
> PAGE_SIZE buffer, in particular pp_od_clk_voltage, which calls
> amdgpu_dpm_emit_clock_levels() repeatedly in a single show(). On SMU13 OD
> paths the combined OD/fan output can approach the sysfs page limit. Once =
the
> buffer is full, further sysfs_emit_at(buf, size, ...) calls hit the at >=
=3D PAGE_SIZE
> WARN path in sysfs_emit_at() and return 0, continuing the loop only gener=
ates
> warnings and does not improve userspace output.
>
> I'm happy to narrow the series, keep the return check only in multi-emit/=
loop paths
> (e.g. smu_cmn_print_dpm_clk_levels, SMU13 OD emit_clk_levels), and revert=
 it for
> small single-shot emits such as smu_v13_0_6 where truncation is not reali=
stic.
> Alternatively, we could add a single stop condition in
> amdgpu_get_pp_od_clk_voltage() instead of per-emit checks.
>
> Let me know your thoughts.
>
> Regards
> Asad
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, May 29, 2026 12:46 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org; Koen=
ig,
> Christian <Christian.Koenig@amd.com>
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
> printers
>
> AMD General
>
> The "len +=3D sysfs_emit_at(...)" is a common practice in the Linux kerne=
l.
> Its return value has no adverse impact on subsequent calls, so repeatedly=
 checking
> the return value serves no practical purpose.
> You may refer to other usages of sysfs_emit_at() in the kernel source; no=
ne of the
> existing examples check its return value.
> (this may be a widely adopted convention).
>
> Cc @Koenig, Christian
>
> Best Regards,
> Kevin
> > -----Original Message-----
> > From: Kamal, Asad <Asad.Kamal@amd.com>
> > Sent: Friday, May 29, 2026 14:19
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> > <Shiwu.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>;
> > Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> > <Asad.Kamal@amd.com>
> > Subject: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
> > printers
> >
> > In smu_cmn_print_dpm_clk_levels() and smu_cmn_print_pcie_levels(), use
> > the
> > sysfs_emit_at() return value, break out of per-level loops when n =3D=
=3D
> > 0, and use a shared out label before updating offset.
> >
> > Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77
> > +++++++++++++++-----------
> >  1 file changed, 44 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index 546e64e3ba9c..0a745afa8552 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -1384,7 +1384,7 @@ int smu_cmn_print_dpm_clk_levels(struct
> > smu_context *smu,  {
> >       uint32_t min_clk, max_clk, level_index, count;
> >       uint32_t freq_values[3];
> > -     int size, lvl, i;
> > +     int size, lvl, i, n;
> >       bool is_fine_grained;
> >       bool is_deep_sleep;
> >       bool freq_match;
> > @@ -1402,7 +1402,10 @@ int smu_cmn_print_dpm_clk_levels(struct
> > smu_context *smu,
> >       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk =3D 0 a=
s GFXOFF */
> >       is_deep_sleep =3D cur_clk < min_clk / 2;
> >       if (is_deep_sleep) {
> > -             size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_cl=
k);
> > +             n =3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
> > +             if (!n)
> > +                     goto out;
> > +             size +=3D n;
> >               level_index =3D 1;
> >       }
> >
> > @@ -1412,10 +1415,13 @@ int smu_cmn_print_dpm_clk_levels(struct
> > smu_context *smu,
> >                                    smu_cmn_freqs_match(
> >                                            cur_clk,
> >                                            dpm_table->dpm_levels[i].val=
ue);
> > -                     size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\=
n",
> > -                                           level_index + i,
> > -                                           dpm_table->dpm_levels[i].va=
lue,
> > -                                           freq_match ? "*" : "");
> > +                     n =3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> > +                                       level_index + i,
> > +                                       dpm_table->dpm_levels[i].value,
> > +                                       freq_match ? "*" : "");
> > +                     if (!n)
> > +                             break;
> > +                     size +=3D n;
> >               }
> >       } else {
> >               count =3D 2;
> > @@ -1437,13 +1443,16 @@ int smu_cmn_print_dpm_clk_levels(struct
> > smu_context *smu,
> >               }
> >
> >               for (i =3D 0; i < count; i++) {
> > -                     size +=3D sysfs_emit_at(
> > -                             buf, size, "%d: %uMhz %s\n", level_index =
+ i,
> > -                             freq_values[i],
> > -                             (!is_deep_sleep && i =3D=3D lvl) ? "*" : =
"");
> > +                     n =3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> > +                                       level_index + i, freq_values[i]=
,
> > +                                       (!is_deep_sleep && i =3D=3D lvl=
) ? "*" : "");
> > +                     if (!n)
> > +                             break;
> > +                     size +=3D n;
> >               }
> >       }
> >
> > +out:
> >       *offset =3D size;
> >
> >       return 0;
> > @@ -1454,7 +1463,7 @@ int smu_cmn_print_pcie_levels(struct smu_context
> *smu,
> >                             uint32_t cur_gen, uint32_t cur_lane, char *=
buf,
> >                             int *offset)  {
> > -     int size, i;
> > +     int size, i, n;
> >
> >       if (!pcie_table || !buf)
> >               return -EINVAL;
> > @@ -1462,28 +1471,30 @@ int smu_cmn_print_pcie_levels(struct
> > smu_context *smu,
> >       size =3D *offset;
> >
> >       for (i =3D 0; i < pcie_table->lclk_levels; i++) {
> > -             size +=3D sysfs_emit_at(
> > -                     buf, size, "%d: %s %s %dMhz %s\n", i,
> > -                     (pcie_table->pcie_gen[i] =3D=3D 0) ? "2.5GT/s," :
> > -                     (pcie_table->pcie_gen[i] =3D=3D 1) ? "5.0GT/s," :
> > -                     (pcie_table->pcie_gen[i] =3D=3D 2) ? "8.0GT/s," :
> > -                     (pcie_table->pcie_gen[i] =3D=3D 3) ? "16.0GT/s," =
:
> > -                     (pcie_table->pcie_gen[i] =3D=3D 4) ? "32.0GT/s," =
:
> > -                     (pcie_table->pcie_gen[i] =3D=3D 5) ? "64.0GT/s," =
:
> > -                                                      "",
> > -                     (pcie_table->pcie_lane[i] =3D=3D 1) ? "x1" :
> > -                     (pcie_table->pcie_lane[i] =3D=3D 2) ? "x2" :
> > -                     (pcie_table->pcie_lane[i] =3D=3D 3) ? "x4" :
> > -                     (pcie_table->pcie_lane[i] =3D=3D 4) ? "x8" :
> > -                     (pcie_table->pcie_lane[i] =3D=3D 5) ? "x12" :
> > -                     (pcie_table->pcie_lane[i] =3D=3D 6) ? "x16" :
> > -                     (pcie_table->pcie_lane[i] =3D=3D 7) ? "x32" :
> > -                                                       "",
> > -                     pcie_table->lclk_freq[i],
> > -                     (cur_gen =3D=3D pcie_table->pcie_gen[i]) &&
> > -                                     (cur_lane =3D=3D pcie_table->pcie=
_lane[i]) ?
> > -                             "*" :
> > -                             "");
> > +             n =3D sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
> > +                               (pcie_table->pcie_gen[i] =3D=3D 0) ? "2=
.5GT/s," :
> > +                               (pcie_table->pcie_gen[i] =3D=3D 1) ? "5=
.0GT/s," :
> > +                               (pcie_table->pcie_gen[i] =3D=3D 2) ? "8=
.0GT/s," :
> > +                               (pcie_table->pcie_gen[i] =3D=3D 3) ? "1=
6.0GT/s," :
> > +                               (pcie_table->pcie_gen[i] =3D=3D 4) ? "3=
2.0GT/s," :
> > +                               (pcie_table->pcie_gen[i] =3D=3D 5) ? "6=
4.0GT/s," :
> > +                               "",
> > +                               (pcie_table->pcie_lane[i] =3D=3D 1) ? "=
x1" :
> > +                               (pcie_table->pcie_lane[i] =3D=3D 2) ? "=
x2" :
> > +                               (pcie_table->pcie_lane[i] =3D=3D 3) ? "=
x4" :
> > +                               (pcie_table->pcie_lane[i] =3D=3D 4) ? "=
x8" :
> > +                               (pcie_table->pcie_lane[i] =3D=3D 5) ? "=
x12" :
> > +                               (pcie_table->pcie_lane[i] =3D=3D 6) ? "=
x16" :
> > +                               (pcie_table->pcie_lane[i] =3D=3D 7) ? "=
x32" :
> > +                               "",
> > +                               pcie_table->lclk_freq[i],
> > +                               (cur_gen =3D=3D pcie_table->pcie_gen[i]=
) &&
> > +                               (cur_lane =3D=3D pcie_table->pcie_lane[=
i]) ?
> > +                               "*" :
> > +                               "");
> > +             if (!n)
> > +                     break;
> > +             size +=3D n;
> >       }
> >
> >       *offset =3D size;
> > --
> > 2.46.0
>
>

