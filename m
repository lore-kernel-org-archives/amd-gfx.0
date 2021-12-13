Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B027C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 07:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36E510E136;
	Mon, 13 Dec 2021 07:48:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B313910E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 07:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3ORbyLaWo2fPcWGJiRVCE2220FNkwvfQ/2oHR9QBsk4abHdgSgaOBo6Y+vXfCi1y7QIv5f6v5p360G+t3N8/Pa2huIYESa+VEVpYQQJIgtUq5Twlt8uBNJjfUqBb6cxKGqokB17VbbUObT/E2P9KHGFYJYTNtN/qh/MUOghOgVhkf+3K+OekJzbAZD/6cQd7G+OwPHLSGYumFd95j2J67wGSVt1X3lGe0z6SYsdQw0c61c2R/hrDREOXxk3xdZCyq3vjZjVsn5H3mG+AYG8KH3hVhHkg/17X12eea5a8ZAnVpHdBi2ECuiTklkMGx6npxg1A8JPFFJl3zUdumqHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/ecXEc6UNkfjCZ0s/lWipd61hiy6EHjZOV7FeR65Zc=;
 b=fBIGMVMgndDNg0ottr5IswLptT5TL2/gWK/U8LJbvqjNCHu1+LyyA8Urr5bnaHelVhbmANtpJQ/lkM3GzF+rpo4wuHNAcaTFyFqRJlvkj106A/qp2BR9J5g+8uHk8snN4UpaPoNqnf946K/zpNUXGNHvmbx2W7tgW2ekdIedKn7pQoK9kl5usGmtHdGtVmNe2mKRYPc8HV45Spp2d0M4nzqWZaBVSyIzZjEtEkqCGdzl3pU6htOsJEGuxCe6wX1LqEix27YFPzM5AjiJP9RKX0kJ2mVjkbxnuEsIzH4VuSfjFe1CzsGk886zWJW0g2Tk8AslO5+hEZX9pP814txI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ecXEc6UNkfjCZ0s/lWipd61hiy6EHjZOV7FeR65Zc=;
 b=0Cy73WNXmPTG2xb5ODhXJ/TG08KEk8uUtarB4yVE9JJa5CsVZleDVSNiMSP3DspPtCMyRbICYleHS+YK1vCObWFQ3Yd/O8cAzd9jcSKIs5ZdQLMLzFtKj1NAqPu73+YhbZvnR1SGWknCYrHXoz3agiStkqYWd8HBjULucJO/7gI=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 07:48:28 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::f97d:23d2:78a:2beb]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::f97d:23d2:78a:2beb%6]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:48:28 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Thread-Topic: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Thread-Index: AQHX7J9vnfIcNbIgtU2ANF3bxNHzwKwq/loAgAUS01A=
Date: Mon, 13 Dec 2021 07:48:28 +0000
Message-ID: <BYAPR12MB3238DA80181DE182844F7F5FFB749@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1639014681-16853-1-git-send-email-Prike.Liang@amd.com>
 <DM6PR12MB26191BB3561752438A0F6DBBE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26191BB3561752438A0F6DBBE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=be50e9d9-e4a6-49a6-b606-c16bef44e2e9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T07:44:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2682dff-d931-4841-6700-08d9be0cf38b
x-ms-traffictypediagnostic: BY5PR12MB4967:EE_
x-microsoft-antispam-prvs: <BY5PR12MB49677D6043E619A26EA87642FB749@BY5PR12MB4967.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XGGXbLygS51+1xuB4S0XPnBu1YlivMPd5ZTRrrZKDL76fABFudQeyjvqA3hsDBnAFH+DWJhEAZedem4KbVOXm3utUVPHqEKcBShSWOrlotHoQ/2e/M+1yQIIeU28n+0QYnwfcw1zOOhjRROv21pkjktqRExfey2T5piSOx/C+73jDc7o+SgzCGm3alkc0pw7MKSnTbldyIMD7PumtgTgU0hNAMabLyl4iJcRgBWlDLC+dzOtw6HqlO5EIoqfzJPke13Nao8J81HIbuZurrSoFCAVY38tYp83dyhiL+gTMgj/+4y0e0L/V76vQb4M3e0s6XNPLC5nhRvWSqDhoMzxNwGZ5ZIdWZinWiXgPz5oK3ZX17VMb9XdPzbB5RRfkSN059/ITMhEklKgUuXLanWJNdso9iHhRrJWzzoDOJ0lwbcwOj2n8lYPn7wxcJHqitl4S7JKIxj7ZmSPTj/zbtMk6mk2bhno4ChyWlvGoQ65DAlY/I4HbQDKQVlGpNMgKG/CIzaCuwcTXRZS6wNyb1aNjhI5XzXItWyRqBwGZU6rM9hhe0N3n4yuHMrC9T0mG3F0h8lNqxL4XgoDGTvPbjC/67rsPxD1z4avluc82hMogjW6KV7kMeUY0Qo9rKP/bV2BIeYjJOdOPeWpXnS4AXl4WLcIqeETFhjpFszxaTv9XyjnVPMv7v15gcE5SIbdUb1n0uJYxAjfnKCOzik+lcRL858IqZ1tFkfQCh0yqbx3w8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(15650500001)(76116006)(64756008)(54906003)(55016003)(4326008)(186003)(8676002)(86362001)(83380400001)(5660300002)(66476007)(66946007)(66446008)(66556008)(33656002)(38100700002)(122000001)(52536014)(53546011)(9686003)(6506007)(316002)(7696005)(110136005)(508600001)(26005)(38070700005)(71200400001)(8936002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ceOEdYmzozteuK9XqPcxVUxpv3cMZS5cCs76LNft9M0KZcZDEQxH0oktg9vT?=
 =?us-ascii?Q?xo2KXuRU5bvxasUbF+tguDk1A0yUeNUv6Sra8hwy+7Ma/lIeuVY3AB5d5np4?=
 =?us-ascii?Q?A8rSv06cwiNh6WrITrbc0fzGE+pBr0E+liiEelxnPnXnoKdc2EpHH6eFLdD+?=
 =?us-ascii?Q?HG5X6wp5pl36BY2DDVRBUrzgTd7ZwxaEbJm6ZuPytqA7ailFaEs0i65McC2L?=
 =?us-ascii?Q?Aa0vYdcF/r+/9qxBwZdW59i2BwmlVaYgl72uazwH4zeCgbfd8IMq3JQYcPt6?=
 =?us-ascii?Q?+jVLa57fYvrCPloMZYwC3WPB2YT8dHBYhy1AgmrmHEQWzWe+iHTjxoqo4TdQ?=
 =?us-ascii?Q?Q3dU1RJH8QagnpQqxogEByWqiIGYwT/Qt89hU5fGDlqbYLAINENcREJcPS0M?=
 =?us-ascii?Q?xi8j2XWotHiXlIC5fNu2Wsn1upmLql8vEBUpOksdquoEak0ImHMdyFMwPGvI?=
 =?us-ascii?Q?9ewurVo6kwWRGrt1Sh8WnY58PhC8M+N/tJjdL39crrqxOIBcyFe1H8f8IzYD?=
 =?us-ascii?Q?7raL7+DxaLt5eGvFJMhMmOiL5Mpep+BKcl/O8bjDd2Rrs1c1sqw/3eibvw/o?=
 =?us-ascii?Q?3LRvpvNpHoqvWAPjG/3NlELvwFRK7yB8EMCAuJN5zBZGCl+BpelGhLtkwDt0?=
 =?us-ascii?Q?HwjgTIZIEQXt0Gg/ZmLO0r3/xCPr9tIXxSygX2hYb4MSNWFtD2aJsl9uJGGS?=
 =?us-ascii?Q?aYr26upT/pFKqHa1SWUp+JaT51WLoNR7loeKUAVrQeehoslw193kYA7czmU3?=
 =?us-ascii?Q?uP1nLYf+Sx0MYKSBKZmIfhrG6q+z5Lg08W5ZhcnxSr0LilBm2WeByo7i0RYy?=
 =?us-ascii?Q?uXz/OMafrMU6w6CSMMr+nM05552TOq45DTXaBmVUrZwiuHYRV63xKXIB/wpH?=
 =?us-ascii?Q?d6RCMDOq8hhf/HNKAXikOf7P/mEK8UUByvJuBTirqQXRKLsHwu/wLlDaM6Bq?=
 =?us-ascii?Q?70f5VJHs/weGDpgk3EG365aEk1QwiQgLTj+Fw6iRFdkGZOt5BCbhTs6ey6TX?=
 =?us-ascii?Q?w4+nh7suKupcWCjN01BQPL7zf+f3SW6U2GFZQVCBl/twdi6pPFTXXrIKo4Gx?=
 =?us-ascii?Q?s8Gj9gx/BgtTPIZDK5Ly258vX6WyXF2kgmlJrzjpBJ3Ldd/5cys9yvBH9ajM?=
 =?us-ascii?Q?CqVnBfQpYoorTo4WcQd1I5TixUYwvnqTPr2miGtdcLPmIRhxlrPnFGMw7Fdy?=
 =?us-ascii?Q?Wshi+ZITeVgZeTi6BB2l05zx/OmdxHWEs6IwY2ogeuhRTP4eLR0xYU90VYJl?=
 =?us-ascii?Q?ngyPZMYyjd/XhU9zV5xRjZmeYKs2hmk7tN0B+8eBmdFBqZa+SPwm96iXnUB+?=
 =?us-ascii?Q?2KKhsdiTo3nZA4TykV2H14n+z3Bjh8QOgIRg+tWk3pglTXrE77yBvU98fl+r?=
 =?us-ascii?Q?W9ihOv6CONxl9UqgIaw/3Te4k9zoc2xktf+WST0M1BZFb0Z5JbWSJ368koeT?=
 =?us-ascii?Q?DZUb3B6fwD9e4vvCEGJ+OOwsHi88JgIGGpaz/BkB0XO3co3hEbXBIU4Bvb0t?=
 =?us-ascii?Q?6y7HeL4/Y+IQZj8/KS1g3OFncPdvdoTEcH2CwEvysW6gFR7LKL1GUoChqC2m?=
 =?us-ascii?Q?SH8vcSLQJocFustE7uQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2682dff-d931-4841-6700-08d9be0cf38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:48:28.2441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUKeSfrFbYsC8yjiWnFJcG+t69WOmdA2b3zTrV+yOCuwiL1O+eh0jWVyoF32lkJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, December 10, 2021 10:15 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Prike Liang
> > Sent: Thursday, December 9, 2021 9:51 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Limonciello,
> > Mario <Mario.Limonciello@amd.com>
> > Subject: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
> >
> > In the s0ix entry need retain gfx in the gfxoff state,we don't disable
> > gfx cgpg in the suspend so there is also needn't enable gfx cgpg in
> > the s0ix resume.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 5839918..185269f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1607,7 +1607,8 @@ static int smu_resume(void *handle)
> >             return ret;
> >     }
> >
> > -   if (smu->is_apu)
> > +   /* skip gfx cgpg in the s0ix suspend-resume case*/
> > +   if (smu->is_apu && !adev->in_s0ix)
> >             smu_set_gfx_cgpg(&adev->smu, true);
> [Quan, Evan] I was wondering can we move the "!adev->in_s0ix" into the -
> >set_gfx_cgpg(for now, only smu_v12_0_set_gfx_cgpg() supported by Renoir)
> implementation?
> Also, considering this is only supported by Renoir, we may be able to dro=
p
> the "smu->is_apu" check.
Yes, the set_gfx_cgpg only implemented in the SMU12 series and we can move =
the S0ix protected in the smu_v12_0_set_gfx_cgpg() and drop the S0ix flag c=
heck in the SMU suspend/resume process.

Thanks,
Prike
>
> BR
> Evan
> >
> >     smu->disable_uclk_switch =3D 0;
> > --
> > 2.7.4
