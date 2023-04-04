Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18726C77B60
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9B210E701;
	Tue,  4 Apr 2023 16:26:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F27110E701
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnV5wjhD2OaoRMmk0Bu4KV0twkY9ozsqaLyluZl/+hitedLUFAO02UHhSBgoiUAdSZdBcsATHFEAlRQoTe5Aq9u4nsQFR5n764uRYuZndvNaB8on4pir5lc0X1Yf+VWt+A74DgHCEkXkYbKE/fc+gTrsVQnuBDnFTvWbGsIuUC6QuN0e8BI53yrBHqNZ3uRiSZ1lugRo+GKw+ZYl2fxCsVXKlHNVhsbNQHqYRWuYvddkfLS1ERyefGl6g/VoMrFXJt2tVlklwuGUByxTYfAbQt2ZUu04/kj2YvG6V8vABu9V5CMpDRINPXdh4GkoNkA1mU/tv8CQ2kBSKTuzTBPyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynoCNfKpXQOy4ea6sikAcUaxuZ7lws9RDtMlCmGc0Xw=;
 b=l+m6+sGY5i7y9a1QI33ZZLgVVqvxXJ5v0GdX7bh2aSRbzrJpC4eH8JC37CfeaV1YOisoTf3e0/vCKWm1Eea9Ln+tNp1hskJuBsBk4B9TABU3sPShERwLFe2XBVugbgibMa9gPLAK7Z4EpI5wBwJaRpHqRuQcyntfNNr1At0T1IT+t893EW5rTDAhu/5kVeHwlIbn8TnPMr25E1dYXbCmH7uP0IcjMtgRM+SpLMtZgDezUCdNPjhdAz/ibG0/KzVcj2P1DvBpyqDCGNtye3KE51UuC0Id7pev5i3o4VpDWybIdY5BRCQVm2kWJr9bpKNCTp9Gxf5M0VdvXc0IrI2lVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynoCNfKpXQOy4ea6sikAcUaxuZ7lws9RDtMlCmGc0Xw=;
 b=CkdMYe1n6nl/DiHLiqe4k2sWKAUQN38xH70vMVv7vytCGWeabYataA/gs+r03v2Sixop5TqS960vzU664mPwi1BG53pm63aWhBvSHBN4kPjmBzScVG8SVKGJtJko5GMNO9lBrsAL/lisAacNmK/Le8jnPsOPx4f911PgyvXEnFs=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Tue, 4 Apr 2023 16:26:05 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7e79:1de2:ff31:c84d]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7e79:1de2:ff31:c84d%10]) with mapi id 15.20.6254.034; Tue, 4 Apr 2023
 16:26:05 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Topic: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Index: AQHZZmbDMgCQFoG2gkmfKNBRkxRed68bKFWAgAAny4CAAAaQoA==
Date: Tue, 4 Apr 2023 16:26:05 +0000
Message-ID: <DM5PR12MB13084BF2A7B7C0ADFE3FA3B185939@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
 <DM5PR12MB13084ED911E1EC100F8FC09B85939@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM6PR12MB30678F470E502F9FED0D129C8A939@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB30678F470E502F9FED0D129C8A939@DM6PR12MB3067.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-04T16:26:03Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c3a71af1-e011-44ac-a247-a12616190d9e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1308:EE_|IA0PR12MB7675:EE_
x-ms-office365-filtering-correlation-id: 919d4685-093f-4436-bb97-08db352949f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aI9wjXexbfs1vdyoL2VC37grfN/Nqii2JYT2MrfEjL5N77PqIUNIkF6qWyarVPX8lPUgTwAdXJvcz8GpE8t1yk0fAl1F8g9L2hlReU4IvlfAqVJJxxbpL1+71u++JCjYwn0aeb5QbvKfl3/KyP/L+ezZdx0nQXNHcXoshHg9grZIdNxZwLsy/6raUE1cATLn7xfKEi3zZMHTsmwPMkCzrp7E5h7ZGTfd5fuW1TmPCU3PoVuKd9fP98MeHz70sfB/0/KpDJMu97QGS89vsvI3iBbvaiGMDK84PTFtpZZYmYqFOxW+logJ2bhEWy+GjYsGvF19oLAkntUnDhzwQTDcRBpabUI+U49CskOivuu/yppbRDa1oaV8wG0gq+NdfLulNBkGx5F6UIYcksIkvplC/wkHrRjoSnYLH0DIQEGFZKBzwtL5HKkzOg70V3nn9G0wyDb04Ok6E9D0S4eq1tt0M3TPKnFgudSWN5mRjDpIiJrTKZTmTLyAG0E6Zv9mk8+MgUOjx3HMW4ajVwPJ1/ktWvXoa+VY+cZSfmHlOr1KReoat6vbyKMfDRULrfHXcYQY5j/QQUXU6sdCjuAJpn8Opg9WaMYzejRhL5fK2+B3EnoK9Gp3DTD9nsRabo/C0b3F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(64756008)(71200400001)(110136005)(7696005)(4326008)(316002)(76116006)(66446008)(41300700001)(66476007)(66556008)(66946007)(38070700005)(33656002)(86362001)(6506007)(26005)(83380400001)(52536014)(478600001)(122000001)(5660300002)(8936002)(55016003)(8676002)(9686003)(53546011)(186003)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cLTQNGhZqSd3QZiR8sRDKsMmDpJ4qNG6wakSiyg8Qas6l6/8C4pILwBbpE4n?=
 =?us-ascii?Q?QI2D4jEgf8PwBjjDPZN1KohP/v4exx0pXenZ4IPEvqQx5GLgnDzrsR0dQto0?=
 =?us-ascii?Q?B9/G1Gm+iRTpdsmgkTBA/ego1Ja1lBK1oZP/edpBW6CtCzp+dTg4vTjqsHwj?=
 =?us-ascii?Q?18FETJ8Nle5YJ3YxtxtaXPmNziyWMyLeSM8UA2KnhdyGprWpHpEG4X4ybicK?=
 =?us-ascii?Q?6YI8pFU5I9yIndrYfpek62cXNWKbN4Iqdi9Egim7R0wht8Esp6V9J83fIh18?=
 =?us-ascii?Q?2ePDaJ8ngfRaR3M3hoSyGXo31uGa9Of/leX65lm9EJXFvMyh4QSJTOeghYrg?=
 =?us-ascii?Q?fG4c0Ms/qWAu4OtFBmjRuLL7h1cYdke6ZaPh8JKMZWjpetbuYKUNjmUPlfgG?=
 =?us-ascii?Q?tUYQbav6ik9dIb47QJfqJEGX5xQ+oyOzxLq0gjCUZePvcG7NJKUw+92mF8c9?=
 =?us-ascii?Q?IZklSySCxHrS2ThvwELEbW3hmhLQ3DxV54C6O70mIAfUvyEbXSs8XvF7teo7?=
 =?us-ascii?Q?DUBFtkyoyeXLvFWaGxKP7lFpXmTnQDPjSp312SRF82+WxVCMS+egtMTqxJis?=
 =?us-ascii?Q?sV1NI40tOfjTJZBUsKiDAMNZucVdSxccc9ZcEtGMaPQ4btNK3zdvRUScMh81?=
 =?us-ascii?Q?A0k8YC4bQJ+ImyvLxATH0PEFhAbC5Kzb0RLhx+xKUSPgsj4EQ9iMu7WSlCqp?=
 =?us-ascii?Q?EGuTbEiNtqjDRXLKif0VQYmOqAuij+e6HdWEIozLs3FprksonbXZB2LiZvvO?=
 =?us-ascii?Q?mw9ZhEr+1JoeNHdSy7G60xhvrnW1AaP7Hwj9Uj/oZ1GD0G6ND02jpOWF6ZBa?=
 =?us-ascii?Q?oNYDZBd/YhPlNHR7gPNHIoRcYdBKbYvzd9z4KoVShDR6nZoWsHlJR2kgwd5O?=
 =?us-ascii?Q?zRQ2XS35EHwHyYH0Qndx2ZdgEpVrf07+72VuzPTpobm8suTmczbnzifDPOZ7?=
 =?us-ascii?Q?JjYInfd5t/SlOGwb58m+eUa21GZOOJ1i6FKLcgZtOLP/hXNHpgJTyrnDpZ9N?=
 =?us-ascii?Q?tnZ8ZMaaMu6aXQRnnlk8w5P5eVFpPk9qvPQtPUavomwiNb0nZCQlXyNEU/Jv?=
 =?us-ascii?Q?hICQKyDkFYNRfcqjYEsYr34BSOLxZDSH9IuDCV3P9nF8FB8g75NJTblGNcSn?=
 =?us-ascii?Q?e1Q/3TfwQBf7lhHk6jDEce30jFpDmrX/wAxUi85zfGdPv7AIG6iUIr3ovMna?=
 =?us-ascii?Q?HFZRCec5Emjm7aR7xk8j+/g635IBTbqTm0YoZ7aLgjQJmDhmrW58Cv4WzyXE?=
 =?us-ascii?Q?3qrQpGtjZoQCZY5LinMy7GZpdyHjF/wGbnbOziV4fiVj1IWHNojBKXvA829T?=
 =?us-ascii?Q?se1XQs/6EEkpiF6ERIunXH3gHER05g6j4aFC6pKAAt288iHuQ033MM+T1J3K?=
 =?us-ascii?Q?BjbY8MHpluILLKOz/1d3AS7esD6DKIa39fTA6epyoq5sW883DwAA9kZgHG3G?=
 =?us-ascii?Q?LykInAoqkBv+FpHqD6oRFIMa3cesuKcGEH+MgLxNE6XabXZG0087cjL9fLMv?=
 =?us-ascii?Q?A92ejcEMx4ygy4TUC6BrFSKtw3kjUZH5xs52JqvnrcnbYyj66oUsn3MfZDzg?=
 =?us-ascii?Q?z9Qxyup24VUY4Hl/rIw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919d4685-093f-4436-bb97-08db352949f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 16:26:05.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvGqNglR8UKOHSybiaDi4cnz9hj5PQr01Kt1F47TyhWLBVwU+A9g4RP9XjYpHiVrSFBd51xaMbuI0QVYTABqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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
Cc: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: Tuesday, April 4, 2023 12:00 PM
> To: Russell, Kent <Kent.Russell@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and =
set
> CP_HQD_HQ_STATUS0[29]
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Russell, Kent
> > Sent: Tuesday, April 4, 2023 9:43 AM
> > To: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support an=
d
> > set CP_HQD_HQ_STATUS0[29]
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > [AMD Official Use Only - General]
> >
> > Comments inline
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Sreekant Somasekharan
> > > Sent: Monday, April 3, 2023 3:59 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> > > Subject: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and
> > > set CP_HQD_HQ_STATUS0[29]
> > >
> > > On GFX11, CP_HQD_HQ_STATUS0[29] bit will be used by CPFW to
> > > acknowledge whether PCIe atomics are supported. The default value of
> > > this bit is set to 0. Driver will check whether PCIe atomics are
> > > supported and set the bit to 1 if supported. This will force CPFW to =
use real
> > atomic ops.
> > > If the bit is not set, CPFW will default to read/modify/write using
> > > the firmware itself.
> > >
> > > This is applicable only to RS64 based GFX11 with MEC FW greater than
> > > or equal to 509. If MEC FW is less than 509, PCIe atomics needs to be
> > > supported, else it will skip the device.
> > >
> > > This commit also involves moving amdgpu_amdkfd_device_probe()
> > function
> > > call after per-IP early_init loop in amdgpu_device_ip_early_init()
> > > function so as to check for RS64 enabled device.
> > >
> > > Signed-off-by: Sreekant Somasekharan
> > <sreekant.somasekharan@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
> > >  drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 11 +++++++++++
> > >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |  9 +++++++++
> > >  3 files changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 7116119ed038..b3a754ca0923 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -2150,7 +2150,6 @@ static int amdgpu_device_ip_early_init(struct
> > > amdgpu_device *adev)
> > >               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fa=
lse;
> > >       }
> > >
> > > -     amdgpu_amdkfd_device_probe(adev);
> > >
> > >       adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
> > >       if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D
> > > KFD_SCHED_POLICY_NO_HWS)
> > > @@ -2206,6 +2205,7 @@ static int amdgpu_device_ip_early_init(struct
> > > amdgpu_device *adev)
> > >       if (!total)
> > >               return -ENODEV;
> > >
> > > +     amdgpu_amdkfd_device_probe(adev);
> > >       adev->cg_flags &=3D amdgpu_cg_mask;
> > >       adev->pg_flags &=3D amdgpu_pg_mask;
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > index 521dfa88aad8..64a295a35d37 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > @@ -204,6 +204,17 @@ static void kfd_device_info_init(struct kfd_dev
> > *kfd,
> > >                       /* Navi1x+ */
> > >                       if (gc_version >=3D IP_VERSION(10, 1, 1))
> > >                               kfd->device_info.needs_pci_atomics =3D
> > > true;
> > > +             } else if (gc_version < IP_VERSION(12, 0, 0)) {
> >
> >
> > What if we get a GFX9 with MEC v509? Wouldn't that trigger this too?
> > Wondering if this should be if (gc_version>=3DIP_VERSION(11,0,0) &&
> > gc_version < IP_VERSION(12,0,0)) thus ensuring it's only GFX11. Or mayb=
e
> > there is some better check than that. Either way, checking that it's < =
GFX11
> > might false-positive on GFX10- too, so we should probably be explicit i=
n our
> > GFX check that it's only GFX11.
>=20
> The previous condition is for gc_version < IP_VERSION(11, 0, 0), so that
> condition will (and currently is) taken for gfx9/gfx10/etc.
>=20
> That's to say the logic after this change will look like:
>=20
> If (KFD_IS_SOC15(kfd)) {
> 	<...>
> 	If (gc_version < IP_VERSION(11, 0, 0)) {
> 		<...>
> 	} else if (gc_version < IP_VERSION(12, 0, 0)) {
> 		<...>
> 	}
> }
>=20
> So this new path will only be taken for gfx11.

Thanks Graham. I should've pulled up the file and looked at it in context. =
Ignore my comment then.

 Kent
>=20
> Best,
> Graham
>=20
> >
> >  Kent
> >
> > > +                     /* On GFX11 running on RS64, MEC FW version mus=
t
> > > + be
> > > greater than
> > > +                      * or equal to version 509 to support
> > > + acknowledging
> > > whether
> > > +                      * PCIe atomics are supported. Before MEC
> > > + version 509,
> > > PCIe
> > > +                      * atomics are required. After that, the FW's
> > > + use of
> > > atomics
> > > +                      * is controlled by CP_HQD_HQ_STATUS0[29].
> > > +                      * This will fail on GFX11 when PCIe atomics ar=
e
> > > + not
> > > supported
> > > +                      * and MEC FW version < 509 for RS64 based CPFW=
.
> > > +                      */
> > > +                     kfd->device_info.needs_pci_atomics =3D true;
> > > +                     kfd->device_info.no_atomic_fw_version =3D
> > > + kfd->adev-
> > > >gfx.rs64_enable ? 509 : 0;
> > >               }
> > >       } else {
> > >               kfd->device_info.doorbell_size =3D 4; diff --git
> > > a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > > index 4a9af800b1f1..c5ea594abbf6 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > > @@ -143,6 +143,15 @@ static void init_mqd(struct mqd_manager *mm,
> > void
> > > **mqd,
> > >                       1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT
> > > |
> > >                       1 <<
> > > CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
> > >
> > > +     /*
> > > +      * If PCIe atomics are supported, set CP_HQD_HQ_STATUS0[29] =3D=
=3D 1
> > > +      * to force CPFW to use atomics. This is supported only on MEC =
FW
> > > +      * version >=3D 509 and on RS64 based CPFW only. On previous ve=
rsions,
> > > +      * platforms running on GFX11 must support atomics else will
> > > + skip the
> > > device.
> > > +      */
> > > +     if (amdgpu_amdkfd_have_atomics_support((mm->dev->adev)))
> > > +             m->cp_hqd_hq_status0 |=3D 1 << 29;
> > > +
> > >       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
> > >               m->cp_hqd_aql_control =3D
> > >                       1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> > > --
> > > 2.25.1
