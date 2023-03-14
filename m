Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A952C6FD1C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 09:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1085310E750;
	Tue, 14 Mar 2023 09:27:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBB810E74E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 09:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNCsllEbZ/SYjjfRWwLL0NhwnaoertM4tGsN337QsdSNJzshoVbSyY8Aym6bbCXfxCY4djm+A0RAVRlW6oCCb4NQQgEoLmvPYz6Ks2Ro0ml/3f3Y5j+Szzheh/vrBCsf6kttX0RlOI6MXolgX/p/zWeM/8Mf5rDYjrgWDBFlgCP9hUiKXbKzyl56+TBZpn2QavFv5G8Ts9hXPCuyn1QYdg/PKWuao2L3zWVau/bjP34V3FA+e/5bTc0V1NhWhIoaCbLqQCciBoKvwgt0H94pOezV+/oGEoiOuooyEU3X1LGIzDejbglch4DMFi+pzT4F1/y55+iLYMwSaZdSrMDCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zH1A4kfpXobc3TGjEZJntw8peXJ3USUBKsj/kWxIio=;
 b=ZueTlHAKG4JcyiZlh9gXbSVbJPr/Dy7zoIAe4UThfXvC89/YVMRAIpGkjYsg1+UKByG34Rbp3lTk5qWQ5cczYeWCYbuKi0Klq2T9yEKqqVonxXXWdCBdGZgnwVIh+L3gXLXB+zPnQpicviPjpZeUlSLyCoh3yMjT20MJaAHqZtNBtAFt6/LXVLdwN3SAWsQpOclrp457oKOY35oPMcylW8wDbf/NDKfnqKpy05BRvlpIImsGxik18e9Rc0AeCxTGscsRrlqjCMgeCEln54pfFBS71pZgdCBTe1HAHglHoJDs0OBiK6jtadLYwpCmcczkwpzAIEQPB4+oprytQ8iwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zH1A4kfpXobc3TGjEZJntw8peXJ3USUBKsj/kWxIio=;
 b=4/EPD0dC59TCINF5j6iYVhEBxEjXN3iM6zcbL3YMyIgIB2yVxyFAgRv6q4v8mdqM+0jz5O89s7sK73eGy8mRKKbgyN9HVHVlbkcrkxGwKwozE1KMcVyDAyVULeM2KzSYLZspAXXOC73zIRYY1oM1+64hRmcZHaMaAOZThsat2y4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Tue, 14 Mar 2023 09:27:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 09:27:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Zhenneng Li <lizhenneng@kylinos.cn>
Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZVWchOYQLHNa2aE28tzC+yOJAD675dspAgACG7wCAAAR78A==
Date: Tue, 14 Mar 2023 09:27:54 +0000
Message-ID: <DM5PR12MB2469D03BB7F3A698DDE6B16AF1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
 <20230313025648.3103971-2-lizhenneng@kylinos.cn>
 <DM5PR12MB2469106B445537FF8F7EBA19F1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BYAPR12MB46140D57681AA4BC9E42E3DA97BE9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB46140D57681AA4BC9E42E3DA97BE9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=79413af5-bef3-4aa1-82fd-6149d86e86c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-14T09:06:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4976:EE_
x-ms-office365-filtering-correlation-id: b9895b3d-2191-40a6-0988-08db246e63cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/0TeW3mb1EEs8yf0boUsfTDhak7fTmCijEzDkBMyLOnHDKwhI6mmZQ6XSi7TGQhH4F2zKBWQlChY1Xyl9Qnm6bc5uWWE91QVgsSM0jKUy24ElJfXswMws5fEQMb2glK3Rr6uKRA+0Mx6akuBZhK7KHIUNG9lBwH4wrBdNhC+FOJypi5h2NCkQ6yJv98CsSmOzPD4KVIHM0971BqDXPuByTmj9srNyniWFiC24dXZM+F1Cv9b76vYctvzity/fVMHvr97M2q/7hhIVExry/HpzF0mWUGDC/DtCkw8C23R5KTYcLWaAuXIP0+fsYlU3bOspS4Av2c4hwZKVBXE2U9YhgzwsQ+I5xSGA3ZgwWoEbgrvtIwf3E2pnuU2N1cppDA+VHZ6mETw8iL+vklEczJsNkSG6GBGm9GVfkN8QLL2ZcQtEHjyqoJoHnLGoQZndlDgoPq13w7XhSx2MeybljEKprZ5Vls8fes7AstOziWZUsTf2lRm+cKOj9+u5QdrSv49qbexroBC4K7nVE0dFnOzuZF5m1oZZbrSNbfFNWEcec0Zb7Qa23KuT3HIFYlYtwCVp1OBK2l/uxsT5m5LJpdAvEs3eT2O8BuQmhxYpM0GwnG/b+SUvOS8tZ/OpUdy7rH8r266wG9AMLWHsANsJ63J2NUTQkLe6Q9HbBCY1lJMjDV6rkIXklwMfp5O9RjBzWRiFxMpudynMJg8pnQEZH4yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(8936002)(5660300002)(41300700001)(4326008)(8676002)(52536014)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(2906002)(83380400001)(478600001)(6506007)(53546011)(71200400001)(7696005)(76116006)(64756008)(66476007)(316002)(110136005)(186003)(66946007)(54906003)(9686003)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m3ZcgdX46gzzuyK20TYZHqWI3FTwYngU6xhrWSMQKX7S1cTCrINokFzjl8/D?=
 =?us-ascii?Q?plOQWBfWlpWezYzjdQjUrANT9+Sb4ArhXkAF63HYkKyb9y09pXqlPFZ8b2dU?=
 =?us-ascii?Q?nSoiL3FzoBqh5TBc7BHDEyLnZrs2NDB4bnyio0N8JgRdPpikLrSyLVq+3y+l?=
 =?us-ascii?Q?IrDXm9jZG4aTATAHQuclAzBphGs+NYvL0aWurs1c302E9FXBv0ygs4dNUha9?=
 =?us-ascii?Q?pI11V8Lk1T77JDPiaDKSP+Fl6bnHTpUiD81gXHaPLpaZiJE8emAh5kaFREMW?=
 =?us-ascii?Q?0B3P6Vj1Ligg7C8E+XXrpOSF+AdyIb5WvSW24IythVkdvjRbm3te+FaOwexX?=
 =?us-ascii?Q?rHJkOlSJ5ZzMqYKKBGDws1aHW+YVZ53A9MZjDVIh1jlxNI5R6WSn7Ws/3CL8?=
 =?us-ascii?Q?jUzo7lBEwoho9J7q4kalj3lmfbflkqabmLxH4/G6hXgcR3qTR/3wdshLzhxP?=
 =?us-ascii?Q?/QprZDSRcxBxzh+A7sGl4E7lENfN9PO60ar1AYU8pcOWytJL2FLxg4CtJQKl?=
 =?us-ascii?Q?H3qkq4J1FCBkKJKJ+31+tNzVAErjKUTGCjmdiTJw3JxDUVSKKot2MP3Sz37J?=
 =?us-ascii?Q?MYoNRRi/o1ihYCLJlVvlFuS8bgDqO9ds+lMa4UW0Q34OILu3snU0zWFHWGTf?=
 =?us-ascii?Q?F8lM+YfHkl1Pe7FNGF4LCQZ7HB477XbLDw1n1KAlXlGlwmC+8xttnOYjvHaM?=
 =?us-ascii?Q?/Hod5oWFz3ZmlVhREd/Qgu/2uKjtE60NpupVGzg30mulO5COIFJL3VShJOzB?=
 =?us-ascii?Q?Zb6bskU56dybqy5TMdn6bB5sq7w3rAK9L/TITAVubh0fVaon88Sr88xHaOjB?=
 =?us-ascii?Q?Up82q2NEftUfC8bQxsptaQBZJit2cui/xeDYPstGqVJgz46i++FPiGMQMqSu?=
 =?us-ascii?Q?/GXZh32GpQ6ZmPnRq7HstCrcsN0IwVLpP/kxlLX+nNIl98ZPOGT8agQCgR1g?=
 =?us-ascii?Q?CL8dw5ErxOyj1QfxDAjV9jNLYtMUHW7uCXV9AVuouc2P06AxAh++r2iL1/3d?=
 =?us-ascii?Q?8ecr8GuDz+kUv1QiASCZ+/hhDbJb9lLXTFjcN6YN1JiZPZOTULRBOiYodU9v?=
 =?us-ascii?Q?aicQDPMfWji4FmS8V4wLlwxw6AldTCsrxUZIdMrPI9c6CQy3Z9fsHvzfw1zy?=
 =?us-ascii?Q?nSoP+76ACAeyi9zdET1EqrZz2HNmCEO1b0wvMTmsvFG2F3UDLCF17y4HJYiX?=
 =?us-ascii?Q?ILiOGi4ZQLir9R0Bg4h695kOtSQ3a1f1lLB9nncVy5iwlYcWKKQ0qIx3JhYq?=
 =?us-ascii?Q?DGyqsEmO9PcmB6nupTwn1D0DknUUUT2A6GNUQgEL4YwxbNHOIcw/lLHmHjQJ?=
 =?us-ascii?Q?4P93/kxh2fB8BuEUGL8jv79CbLg2TPrcztQf9DsN1rEfDRrRdgWRoLZzg4T8?=
 =?us-ascii?Q?YQc6eWRNP3Vc3hBgkALcYwio72waoZpZ44v0M1aA4uAzoJVRuWt8WkyHkpYA?=
 =?us-ascii?Q?MVwKqbnASX/AOMtXy7yGxk1Z4+UkL6NMC7oqmMcw++y0IWrerOLlWWdw5FOD?=
 =?us-ascii?Q?oglISGOSIIdZZW7Etd/J7Q6zeefsgpskYK3LqAevf5M71sZS7c9YwgvPsA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9895b3d-2191-40a6-0988-08db246e63cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 09:27:54.1816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+Qb+I3EgeOHuVJbGGSjlQy0o7VneOc4YamnX3bez8JgszjoWdrjVUFaJh9FJArRPXPdbFUIR+ADpf39y+75Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, March 14, 2023 5:07 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Zhenneng Li
> <lizhenneng@kylinos.cn>
> Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> amd-gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>
> [AMD Official Use Only - General]
>
> Hi Guchun,
>
> This patch doesn't look correct. Without dpm enabled, temperature range
> shouldn't be set at all. The patch posted by Zhenneng is good enough or
> better to skip late init altogether as it remains an empty function with =
that
> patch.

My intention is to prevent setting temperature range again in late_init, as=
 in hw_init prior to late_init, we have configured this range and set dpm_e=
nabled to true already. Also this is a draft patch:)

Leaving a NULL function in late_init looks good to me.

Regards,
Guchun
> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen,
> Guchun
> Sent: Tuesday, March 14, 2023 6:35 AM
> To: Zhenneng Li <lizhenneng@kylinos.cn>
> Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> amd-gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>
> Will attached patch help?
>
> Regards,
> Guchun
>
> > -----Original Message-----
> > From: Zhenneng Li <lizhenneng@kylinos.cn>
> > Sent: Monday, March 13, 2023 10:57 AM
> > To: Chen, Guchun <Guchun.Chen@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-
> > gfx@lists.freedesktop.org; Zhenneng Li <lizhenneng@kylinos.cn>
> > Subject: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
> >
> > During reboot test on arm64 platform, it may failure on boot.
> >
> > The error message are as follows:
> > [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]]
> > *ERROR*
> >                         late_init of IP block <si_dpm> failed -22
> > [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0:
> amdgpu_device_ip_late_init
> > failed
> > [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU=
 init
> > ---
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index d6d9e3b1b2c0..ca9bce895dbe 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct
> > amdgpu_device *adev,
> >
> >  static int si_dpm_late_init(void *handle)  {
> > -   int ret;
> > -   struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -   if (!adev->pm.dpm_enabled)
> > -           return 0;
> > -
> > -   ret =3D si_set_temperature_range(adev);
> > -   if (ret)
> > -           return ret;
> > -#if 0 //TODO ?
> > -   si_dpm_powergate_uvd(adev, true);
> > -#endif
> >     return 0;
> >  }
> >
> > --
> > 2.25.1
