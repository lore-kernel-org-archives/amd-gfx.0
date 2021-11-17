Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB17C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 02:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C79613DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 02:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7C79613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F31A6E1A5;
	Wed, 17 Nov 2021 02:49:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD8D6E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 02:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT5ZGsm+F6eOBHnOuOEU5vfSAYpt/+YIlFGvFdjbgbwhwdVKnoUDSijT1g+gKQXFkksMEmbTcIpYl7pIgjf4Njvx1lJEEww5AhevUsRjG1+lidUdAQvs1gMQtjM/PgYoAjTT7vjGBxkZxvKtLvXW7Dz0yO0ydPmJkhCgF7CM+JE2MVqQxr0u6cwsS39+tUlTlsjtLbjyxlaXo8kzcjUsjvkm7Zjg05c4ppx2rrfsSeEEOgB7jtIu6WUirJ7Smfr6/kjr6e9i7IgcHQFAz3rsWSBPGv2WfIRPaULcG1Mrbqa+gvZepSgXaBrQQqNiF+6FBbYKn5dp84GWIxo+YiwHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuEF73OHnjdp5fa0K7UN6u8EWMIRnlpc4RaIQQw04wA=;
 b=aakUXt0kQ5mQ4o8ftAr+LNHRn3vBOhOYhf90AiSM40tyAfKbXEaQGAL3Y/ON+Erw60eM9843crq0iGSyDOgLuzHZsMg6kgu+s5IAnRLN8PJVIrY+efpyhuZLRm6ah/tLFSoNSQNg+gAQ8i92rsuMPrmYds3ImUJby+YkmE7WP4RVMLhSx72bu3Pl+1jC0IADnZ0qAik8d3e3IhGLgnHXhyaPiRCA6E0KQW39/cFWD4BzPm9+2vKhBNRuopen6wZGlMBVd1fBtkuHZlkxU8jpoTQXqQilkwe37MsO7f7JHhzkNSgnNXDzos8TUTSXjTmDc/mBP7gu0QUBoh+epyU1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuEF73OHnjdp5fa0K7UN6u8EWMIRnlpc4RaIQQw04wA=;
 b=AnK3HcSzT9y8urchf/ngBz86oF8vBMV8ZNRVwtfSW0iMMY4GtvQmSco7gqKDExVDJRqtMKkX66ByewkJHONggZEX2hMg1QiGv3JjxdbJoluD9/JH11HEsCdSNrOqIJEZJCH6eXoZk5fzMZWylb/wYumnsrDD5WacncmiFWRlzpE=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR1201MB2536.namprd12.prod.outlook.com (2603:10b6:3:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 17 Nov
 2021 02:49:53 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 02:49:53 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Thread-Topic: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Thread-Index: AQHX2tTp7XPlaQZb0kW7m+NhKxJ28KwG9RYAgAAQteA=
Date: Wed, 17 Nov 2021 02:49:53 +0000
Message-ID: <DM6PR12MB46504FB223C30B271F0C7E4AB09A9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211116102855.3775-1-tao.zhou1@amd.com>
 <DM6PR12MB26197FC5FC5D094BC9D5F33AE49A9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197FC5FC5D094BC9D5F33AE49A9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-17T01:49:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=46456e19-d113-4f15-a6da-22b65644b5a4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9050b05-de29-4fe9-0cd0-08d9a974eeab
x-ms-traffictypediagnostic: DM5PR1201MB2536:
x-microsoft-antispam-prvs: <DM5PR1201MB2536805B6A8E826ED48A49DBB09A9@DM5PR1201MB2536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sF37LEl3tWKZhr/JekqDAD1YN5YHVYoOj1IUn5B0Cyuc0I80A/c/aT0SB9CFYolDjV4mW4mZnolHDr/yaDlvxyAQZUSJXhc1S4uhNbYo9FpTmrY3NSYtUte4xSxbDPj/xWnRKXIBYC6xoFt/7BlisDIkD+niXQRbexJfIfu7bRDUP9FGhCAAkCfVtkm1NSbF3UvK3PKLu+JmUuAw0ldr+eXiu5xMifLXOscSBBK8GJqGAyCoOcPoehfF5zsTZqVFwQ5P1v2/D8ErJyW94ytW2W5AmtyCbx2faGUc6n6luvQ6tXXjyAE4ipv6hZ3BD1G0elGr+6m87LMg3l49FGbhQgJ9avY+QBPHAZt/uEbtZh6rQ8U6bchxdXNVoGTcecHuSjVkKLD6rpC0n27jj2X1bAHBFSNL5dxWMLggFwWWynmx/zApvAESWSYurvOgxKx1NKAeP8ICbM/bNUffsLxjaewWennU0vszcdq2lHxaqHZHNrndD5bgiKVlrWdFAeyRzuZpUlK9QABhxihEFIbnbyqax8m6Pdcja9hP7yKcmnMHKfp9yqxEw6mUgbnVwKiYnn4blut4rae0ukNpcYezGbCtpceUfRo6eKIixSu5GcoJA4D/NHkI16EmYsMfNe5PuW4QcKHvM/ib3UaYcaFiLje2ojbBewRV5CcT39HScOPHOBk9TRxpJP4ItNY7eeEfThIQSc31SRx2Aj49idP2ijx4MS7z2azUiPasO2Wf0mU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(508600001)(66556008)(66476007)(64756008)(66446008)(7696005)(6506007)(76116006)(38070700005)(316002)(110136005)(26005)(186003)(8936002)(52536014)(71200400001)(53546011)(9686003)(55016002)(921005)(83380400001)(33656002)(8676002)(5660300002)(66946007)(6636002)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+IvvRZxfsRWS9CDEW13dRAtnKQwh2WveGY/+bnleROdCMvtXiSNIlykRm07?=
 =?us-ascii?Q?awaKXlOjJjMQNvrpphEGRPcwYsAEa0MMVEd66RZZXNtSNhOZyW4gAUEYP16X?=
 =?us-ascii?Q?v1MSHUigLQvf5MArw66xW1nBJ867E1S3BQtr+EscIkUaZTMrMKejt4V2k0Rf?=
 =?us-ascii?Q?+ZfD19cgSsBsZRSQ1gE/UTm94b1LsllOceuutej18v855Ft0a4OC4b+rK1W1?=
 =?us-ascii?Q?6lq30D6G5s/iUBUzBntVsLY66FQAQVEnorO4QcaAz/z90j0dBzXZ61TBqeka?=
 =?us-ascii?Q?EN/SPYDAuiII40CTwQODVfCuPIzuO0dZzaUiDwJlZmPyQ0g2d21zUAueaA6H?=
 =?us-ascii?Q?ynbccyuU9NFRntYOSr5A0qR+ldhQTZnfRmGZgJZWGn6EuHFyOI/TrTAcYrSd?=
 =?us-ascii?Q?CoRp2QzZU3RErxLnsk8GPsQmCBBFE2fE46StdOEygWtWiQvRtvB47uRhW4Fz?=
 =?us-ascii?Q?DCj3t4AJNR3z6mdMG693Uqfyw9+XKT1f0BH0sb7cK60cesdpCpdFjvXcxc0l?=
 =?us-ascii?Q?F50V+QkwDuDTEJrfW8tDDfVK8PS8SoQP/mXNnio+6IYBjEE1KyhJsNXuPwXn?=
 =?us-ascii?Q?xSBvhrRvNexIdCL8tl3MZCGDVwmilLAr+s3cZiVxCnYYVfAvme53swRF7RJ9?=
 =?us-ascii?Q?xCMlVtKGlklSVoRLzpfYiIHaEbzKwgYT1lVXy5aFtXKXRwXkKYfpHG83GJEp?=
 =?us-ascii?Q?n7rd58xNBgPty6YS3iC6pqpe6VPlS2/XgN8C0Vlflla6t5yAaHy6axbXHulR?=
 =?us-ascii?Q?xoU7mJghILY06h9o34GVveOQp4QkY4Te0ihW/Yh1qTv8IrMvDY5maCg8ulqn?=
 =?us-ascii?Q?ysB2vtsx3aczU+gDMX0oOsvx9Gk+w1INqNigPKMwpzJ6JZYuQAa5tmwFMSPy?=
 =?us-ascii?Q?DCTh14snGKB05QD7UsEVzHXGdNBGdpGou1iNqPAg4yM1ox/okeuKUs8zNDdf?=
 =?us-ascii?Q?GD5C1N/SA6PYPHfAgGJqCDOlp6hHFmYPAFh1GrLa1tndqBbpzAa1F3WZb+Am?=
 =?us-ascii?Q?j+HAZWw3KB0tw//Qte8kxJ179phdbX8rkLe01+tcgZOKy5toHiSKpzkEnIXO?=
 =?us-ascii?Q?YXChs2idPLRj2o6TzDmj5q2HjMMgfVaN2pY2HMA7sQbdpYTChALo9vsHvnf4?=
 =?us-ascii?Q?JtdfsrVXt7NiGJnZVhhb+Zkoi8N31KfTFIwwvP5RkJ1GaPVVA+8FriVqj85o?=
 =?us-ascii?Q?nXVI+Op2HKprufmE+9MU57Zs1ROa1Hv0szD9p2hZ/pwa/H55SlYJI4LVi8tv?=
 =?us-ascii?Q?fH+E5dK6WGOeTynZR7rmW9leQm2yIfAjdIAXYItG3Q6Ta82V/c+qhGFuOGfY?=
 =?us-ascii?Q?f0Z8q9P//XnbJ5WdKHVDPWDNGKtjvx+ShRB6uBLwWX6YX6qjyAqk+ymtogAm?=
 =?us-ascii?Q?gtJALTp7YTWFICFpB5r4NddwEUf7BZWTfJdnd65+j8Lk2jVh9t9L+WxFIy0U?=
 =?us-ascii?Q?jJy9ygI72b9rEGVN7BCoXombLCehpPYFfM4A7ls9//pwYRPcT3QWPunxN+/H?=
 =?us-ascii?Q?DvBCpFAh3WyASBWfO4VaE57ExiEnNMJYN1FjyE20VA4kFysb4Bp/TuUipGoY?=
 =?us-ascii?Q?Mc8Yq0uRo123EMJ3axc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9050b05-de29-4fe9-0cd0-08d9a974eeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 02:49:53.3254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqwhJmBLhqW5c/yiMNw764hRUbRSjWFQKpqGHf7OQ9noGRu+iJ+9B7Q3XNPkG1vL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2536
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

Thanks for your review, I'll add {} before push.

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Wednesday, November 17, 2021 9:50 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Clements, John
> <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
>=20
> [AMD Official Use Only]
>=20
> With the concern from Guchun addressed, the patch is reviewed-by: Evan Qu=
an
> <evan.quan@amd.com>
>=20
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Tuesday, November 16, 2021 6:29 PM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Yang,
> > Stanley <Stanley.Yang@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> Lazar,
> > Lijo <Lijo.Lazar@amd.com>; Wang,
> > Yang(Kevin) <KevinYang.Wang@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
> >
> > If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
> > reset message.
> >
> > v2: move mode-1 reset function to aldebaran_ppt.c since it's aldebaran
> > specific currently.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  3 +-
> >  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 36
> > ++++++++++++++++++-
> >  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 -----------
> >  3 files changed, 37 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> > b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> > index e5d3b0d1a032..bbc608c990b0 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> > @@ -29,6 +29,8 @@
> >  #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04  #define
> > SMU13_DRIVER_IF_VERSION_ALDE 0x07
> >
> > +#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> > +
> >  /* MP Apertures */
> >  #define MP0_Public			0x03800000
> >  #define MP0_SRAM			0x03900000
> > @@ -216,7 +218,6 @@ int smu_v13_0_baco_set_state(struct smu_context
> > *smu, enum smu_baco_state state)  int smu_v13_0_baco_enter(struct
> > smu_context *smu);  int smu_v13_0_baco_exit(struct smu_context *smu);
> >
> > -int smu_v13_0_mode1_reset(struct smu_context *smu);  int
> > smu_v13_0_mode2_reset(struct smu_context *smu);
> >
> >  int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum
> > smu_clk_type clk_type, diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > index 59a7d276541d..e50d4491aa96 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> > @@ -1765,6 +1765,40 @@ static ssize_t aldebaran_get_gpu_metrics(struct
> > smu_context *smu,
> >  	return sizeof(struct gpu_metrics_v1_3);  }
> >
> > +static int aldebaran_mode1_reset(struct smu_context *smu) {
> > +	u32 smu_version, fatal_err, param;
> > +	int ret =3D 0;
> > +	struct amdgpu_device *adev =3D smu->adev;
> > +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> > +
> > +	fatal_err =3D 0;
> > +	param =3D SMU_RESET_MODE_1;
> > +
> > +	/*
> > +	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
> > +	*/
> > +	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> > +	if (smu_version < 0x00440700)
> > +		ret =3D smu_cmn_send_smc_msg(smu,
> > SMU_MSG_Mode1Reset, NULL);
> > +	else {
> > +		/* fatal error triggered by ras, PMFW supports the flag
> > +		   from 68.44.0 */
> > +		if ((smu_version >=3D 0x00442c00) && ras &&
> > +		    atomic_read(&ras->in_recovery))
> > +			fatal_err =3D 1;
> > +
> > +		param |=3D (fatal_err << 16);
> > +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > +					SMU_MSG_GfxDeviceDriverReset,
> > param, NULL);
> > +	}
> > +
> > +	if (!ret)
> > +		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> > +
> > +	return ret;
> > +}
> > +
> >  static int aldebaran_mode2_reset(struct smu_context *smu)  {
> >  	u32 smu_version;
> > @@ -1925,7 +1959,7 @@ static const struct pptable_funcs
> > aldebaran_ppt_funcs =3D {
> >  	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
> >  	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
> >  	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
> > -	.mode1_reset =3D smu_v13_0_mode1_reset,
> > +	.mode1_reset =3D aldebaran_mode1_reset,
> >  	.set_mp1_state =3D aldebaran_set_mp1_state,
> >  	.mode2_reset =3D aldebaran_mode2_reset,
> >  	.wait_for_event =3D smu_v13_0_wait_for_event, diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > index 35145db6eedf..4d96099a9bb1 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > @@ -60,8 +60,6 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
> >
> >  #define SMU13_VOLTAGE_SCALE 4
> >
> > -#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> > -
> >  #define LINK_WIDTH_MAX				6
> >  #define LINK_SPEED_MAX				3
> >
> > @@ -1424,25 +1422,6 @@ int smu_v13_0_set_azalia_d3_pme(struct
> > smu_context *smu)
> >  	return ret;
> >  }
> >
> > -int smu_v13_0_mode1_reset(struct smu_context *smu) -{
> > -	u32 smu_version;
> > -	int ret =3D 0;
> > -	/*
> > -	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
> > -	*/
> > -	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> > -	if (smu_version < 0x00440700)
> > -		ret =3D smu_cmn_send_smc_msg(smu,
> > SMU_MSG_Mode1Reset, NULL);
> > -	else
> > -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
> > -
> > -	if (!ret)
> > -		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> > -
> > -	return ret;
> > -}
> > -
> >  static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
> >  					     uint64_t event_arg)
> >  {
> > --
> > 2.17.1
