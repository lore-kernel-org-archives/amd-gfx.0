Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF07BC761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 15:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9AA10E6E6;
	Tue,  4 Apr 2023 15:59:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6F710E6DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 15:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuo++RItuSjmIK5X6PEbSX8ialaRpQqla8NOk3jYtPnvEnEO39JdM7DRiNXyih/OKTfNgLW1Gsez/xOV/CYrWHxP8RIhKwTEotNYAElUMFovPArGwqF8+mKdLmnYDbaZ5Pz2h/zYuZN+D6lJGojGKdLNaoLMrR0ujFC1/D7hsmaAfXFORpxAsMAPaU7Jnu2AIeOfDohL8Bb/sgsXYiMo7+TvyQEyMKnGzbqqWSbBhLQqnEMMbaV29mHYLohHZ//OZJ8DH2ribEaPlowfKFjQOCzDGvzhJjxFg5XuIgya4oRhbTin1/OPKIXdZtUIMCXxhrEIB1pzygc6OAz7SUWedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdhBqGh4jMvfU7tDxFUPdU6uHhwavHeDrHWHo4VTG+0=;
 b=jSC5fLnKB5fyGBWhG9p1pBwEU1Uy6Ym+ILNLbuDWksitc2Ciw/DyNcekL7vpJiBFqMYTg7Zka6CWHjwVSLCOcwB4GgFn2XqeS7tDY8mvj5Supec3xFwusZyKZj9pyNXPmPjU8conZ0dYMHxYYvbSjIikcRXVDXU4PwKvIu+ge1lEhyWpJm9PbaocyV4VDOvOmIM2qM1RNySqCIecdfR03TShKwzxbnXJ98PqNfv7SBm6cGSRvFh8YDRtmCtpT+3w5djzXXqW7mNPk26A6gGrYGlABY/0IF9dJ1Nz317ugeqqpT06vhTCkPUK2Z5CS0eQj3jyI1UoaaCySEsahV0MWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdhBqGh4jMvfU7tDxFUPdU6uHhwavHeDrHWHo4VTG+0=;
 b=puvdDtdxCWJSDcCUv+4fcADJ7WU1MJTWkYd/LwlkszAWyKSg4RP15YpTQ38FSeluXy63vt/gdYetD/6HB5Vd5oKbr4xHfYAvD1CHtmTdl5A86tPK/5ktc1YYas0PfY59iVZm2+IqvlVigMGzoSyKwPeMW9BuQalp4zqW2WIhnJ4=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 15:59:41 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 15:59:41 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Topic: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Index: AQHZZmbCA2ZPzf+tAEKr7pelPDereK8bKd6AgAAkU8A=
Date: Tue, 4 Apr 2023 15:59:41 +0000
Message-ID: <DM6PR12MB30678F470E502F9FED0D129C8A939@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
 <DM5PR12MB13084ED911E1EC100F8FC09B85939@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB13084ED911E1EC100F8FC09B85939@DM5PR12MB1308.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-04T15:59:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9383bebe-b219-4d56-9d60-c0ddce977a71;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-04T15:59:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3b006a69-afea-4350-85e6-c53b5464afe9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|SA1PR12MB5616:EE_
x-ms-office365-filtering-correlation-id: 0603bb08-09a5-4791-2120-08db352599a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uer6Z09UvjVknEhqqh4axhGBpnhKAtJke+33UmdLlnLaOPVPdHNjmxCBoBWhbuZdZly82TSwFiJ0qbV69MP1Vq23vvPsWlUJ/9PLAd94Z23vw2lRFe5YNNA/TJBUV3PV+jHn4ck7iGet8NOGqNrQubISWgnbywoLv+9vuIUD46/SsOFq8+JJZIOdOUAYEcaPdb0gB1uXnV0Ev3NahxJscnmoBI3+lkuWwoOxBFNZiDmSKMuuzbAGM8lIJTRGpL4/7iWlRbgZ0zOBKPZ4t1Nq52WYnOTQbjnxQznEPcTN2MKcS/x+n9FKKk2gzcefV78EC8fFDk9klylpuTliTfnSHDBO+ySJdfhVGIUIwo1dUFgKZujyQoW7aLSCBHq6vHjQ4CNMjBZks6lAYI4ovr/stu3bAaMO0ItmgpnlUro8Y80vmauxIt8qCJxXjrxq0Z7Isk1V0ritHXmmbV72Fjf2KTf9uuWypisMew+Xiq0gxQ84ls+UMVirZqD5m4c8lZPpiyyQMfleCeWf1dEADLOYxflgvMj4Mm3Jk9+HyMwRX/Gq7DJMNG6KrTFNgDDKtpbIuSmlI74u3Be7NmlEAVHMTolGivsJEoZ8s9l/fxy/AR1HFjj3H8pLElF97+Cb4K+s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(71200400001)(7696005)(53546011)(186003)(83380400001)(9686003)(26005)(6506007)(478600001)(4326008)(66556008)(66446008)(66946007)(64756008)(8676002)(66476007)(76116006)(5660300002)(41300700001)(38100700002)(52536014)(122000001)(110136005)(316002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3BDKQCSZjyOWCaWoEpInH7biU7C2BJEIOCwiKDN9O7clvXWCh31v8oG9G2Rn?=
 =?us-ascii?Q?PPINfaAazxwFV9gzGa0eikGWgWXnwyr96TIXAgOUaLm1nAAAUVj4L129+PEk?=
 =?us-ascii?Q?T0jYa69h42iLkgM4L8HKV+TA2X3G5dQKAaolEPSBEvui/CY32RYKDFWExMhq?=
 =?us-ascii?Q?Q0Y4V5TaOdrtpl9J7iuu4ZVt/pSqun5NQKmTLs1PQ56cKkAREohaOvfsrtah?=
 =?us-ascii?Q?zVJ/Z6cbjMtEmGukMycj8TivPnjNVWBjuElg8lydE7VOoXHvR7rHQ8v1wucG?=
 =?us-ascii?Q?XCb2Dr6MPPcd8wMg9O79cYOlJR8racEpp6Gh/17vzKdSgCLRaZuYQN85j0Ou?=
 =?us-ascii?Q?7+Gi38OYy0AWSI4wB5SFrlVuJRpZIofciJjT9XJIuWEy/cmk34wy1gJzUQGZ?=
 =?us-ascii?Q?JCg8es7gjQredLMaDE5ef5qKrqU/I2fwt3fT9T0ZzzcRBjQrhmo+90tUVc7k?=
 =?us-ascii?Q?1eQUjhXPYheE94VuunLTqT8X6yK4eq3yXmMqxqkjPuVC+hR0BAp8qcljChJt?=
 =?us-ascii?Q?brzhcmb8bCg9MauW7SUanT56eO6yh5gWaZBQn4A03RrjfzVWKofsh6fq8+al?=
 =?us-ascii?Q?G6hlHAX9rfdxHDKJZup4puOQLkOR7NQcNk/G97TLuF8FBcszon2aAL2hUxE9?=
 =?us-ascii?Q?JUg1x2LP97be0qDUfYFi1XE7K80oFKEYyqEgD+Hys4xA3tkDkTK0oFCpW8rF?=
 =?us-ascii?Q?FP/O+OLly2HwjVfcJnAJFm9fakOt529rLpb0VnYj1F1f7mj1yszFN7A1oVOy?=
 =?us-ascii?Q?UiJkszlcIRiW8oWvUOb3+Y70OcKN4BckUk4fRb7A+TbPka6LOxSe4gpPiwaE?=
 =?us-ascii?Q?LXwsgA4eK0HDlE6tTDYYtJGDiLjYux44PctCGYSVMUprLnjroJ4d1WJ/juai?=
 =?us-ascii?Q?QOO+9mKO66S/IOhnJKQpmk3OI77gSch+pGdSYFuLLHJ9MHn5VCzeSm6GGfqO?=
 =?us-ascii?Q?C9O/xM5f6yuAZZT4Wfsz3cYzbR+ud00VWXuTlnbJLtRmfL1Z8kDb6bsoTfdq?=
 =?us-ascii?Q?OPuU668lWMwtFh/HeLfly5tkfn1doht0a4oiU7ItJfWux+gAStHRipX21nUo?=
 =?us-ascii?Q?36pNfPqxpuEQJDarJLwF6TXSfGIMqcPOR8SNbOl3sJRxf3eZLaUyZEjN7X92?=
 =?us-ascii?Q?ILpe2r5PFEc+nsDINv+uo68qOlsWwHyCoGZdP4oEyyRj49YpXV8PMBhprjPS?=
 =?us-ascii?Q?gLpJEVlA+QKhuQWd3/wxa8udmOU7A7pC4iShzeRoklamZI3eEBVaQguP0SHg?=
 =?us-ascii?Q?+G3WfoQobM7mOvnuLdYcCXYmtf84OUSQqUDO0VhwAbGfSDz76Y5aFPzsl+kc?=
 =?us-ascii?Q?dwwz/ujE+oU/SKiPbzyltH9ATBmfKufcCwkQEV3PWv3tsKBXlxavRCZ+VTvS?=
 =?us-ascii?Q?r9jrggs2EHg8HqLutxDeCeV/yEtpFQDwuAKSi1kl3XXEPQNavx/kfLvmvhoj?=
 =?us-ascii?Q?QBQVv5aHjOXPkNxvQj+vVM7759fNtbAgDc3qSaPMFPSFG5ZQA+xUyrykL2Jb?=
 =?us-ascii?Q?VdZFl/+JTvfo+EioKLoP7MPwXWXwBvMx5mM46Oo6mR7UNqJmSxa3VDyOCiKR?=
 =?us-ascii?Q?FPtiw+gGI0uPqNB2kWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0603bb08-09a5-4791-2120-08db352599a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 15:59:41.0581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKJAFiI7ZaJILH6vd8riMByXNenTYXOfNXJ1ASQLrMLyePO4o5f8ilL5zWVBZfel72CveuxhbRgbuo2DHKHC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Russell, Kent
> Sent: Tuesday, April 4, 2023 9:43 AM
> To: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and
> set CP_HQD_HQ_STATUS0[29]
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> [AMD Official Use Only - General]
>=20
> Comments inline
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Sreekant Somasekharan
> > Sent: Monday, April 3, 2023 3:59 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> > Subject: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and
> > set CP_HQD_HQ_STATUS0[29]
> >
> > On GFX11, CP_HQD_HQ_STATUS0[29] bit will be used by CPFW to
> > acknowledge whether PCIe atomics are supported. The default value of
> > this bit is set to 0. Driver will check whether PCIe atomics are
> > supported and set the bit to 1 if supported. This will force CPFW to us=
e real
> atomic ops.
> > If the bit is not set, CPFW will default to read/modify/write using
> > the firmware itself.
> >
> > This is applicable only to RS64 based GFX11 with MEC FW greater than
> > or equal to 509. If MEC FW is less than 509, PCIe atomics needs to be
> > supported, else it will skip the device.
> >
> > This commit also involves moving amdgpu_amdkfd_device_probe()
> function
> > call after per-IP early_init loop in amdgpu_device_ip_early_init()
> > function so as to check for RS64 enabled device.
> >
> > Signed-off-by: Sreekant Somasekharan
> <sreekant.somasekharan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 11 +++++++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |  9 +++++++++
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7116119ed038..b3a754ca0923 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2150,7 +2150,6 @@ static int amdgpu_device_ip_early_init(struct
> > amdgpu_device *adev)
> >               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fals=
e;
> >       }
> >
> > -     amdgpu_amdkfd_device_probe(adev);
> >
> >       adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
> >       if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D
> > KFD_SCHED_POLICY_NO_HWS)
> > @@ -2206,6 +2205,7 @@ static int amdgpu_device_ip_early_init(struct
> > amdgpu_device *adev)
> >       if (!total)
> >               return -ENODEV;
> >
> > +     amdgpu_amdkfd_device_probe(adev);
> >       adev->cg_flags &=3D amdgpu_cg_mask;
> >       adev->pg_flags &=3D amdgpu_pg_mask;
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index 521dfa88aad8..64a295a35d37 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -204,6 +204,17 @@ static void kfd_device_info_init(struct kfd_dev
> *kfd,
> >                       /* Navi1x+ */
> >                       if (gc_version >=3D IP_VERSION(10, 1, 1))
> >                               kfd->device_info.needs_pci_atomics =3D
> > true;
> > +             } else if (gc_version < IP_VERSION(12, 0, 0)) {
>=20
>=20
> What if we get a GFX9 with MEC v509? Wouldn't that trigger this too?
> Wondering if this should be if (gc_version>=3DIP_VERSION(11,0,0) &&
> gc_version < IP_VERSION(12,0,0)) thus ensuring it's only GFX11. Or maybe
> there is some better check than that. Either way, checking that it's < GF=
X11
> might false-positive on GFX10- too, so we should probably be explicit in =
our
> GFX check that it's only GFX11.

The previous condition is for gc_version < IP_VERSION(11, 0, 0), so that co=
ndition will (and currently is) taken for gfx9/gfx10/etc.

That's to say the logic after this change will look like:

If (KFD_IS_SOC15(kfd)) {
	<...>
	If (gc_version < IP_VERSION(11, 0, 0)) {
		<...>
	} else if (gc_version < IP_VERSION(12, 0, 0)) {
		<...>
	}
}

So this new path will only be taken for gfx11.

Best,
Graham

>=20
>  Kent
>=20
> > +                     /* On GFX11 running on RS64, MEC FW version must
> > + be
> > greater than
> > +                      * or equal to version 509 to support
> > + acknowledging
> > whether
> > +                      * PCIe atomics are supported. Before MEC
> > + version 509,
> > PCIe
> > +                      * atomics are required. After that, the FW's
> > + use of
> > atomics
> > +                      * is controlled by CP_HQD_HQ_STATUS0[29].
> > +                      * This will fail on GFX11 when PCIe atomics are
> > + not
> > supported
> > +                      * and MEC FW version < 509 for RS64 based CPFW.
> > +                      */
> > +                     kfd->device_info.needs_pci_atomics =3D true;
> > +                     kfd->device_info.no_atomic_fw_version =3D
> > + kfd->adev-
> > >gfx.rs64_enable ? 509 : 0;
> >               }
> >       } else {
> >               kfd->device_info.doorbell_size =3D 4; diff --git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > index 4a9af800b1f1..c5ea594abbf6 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > @@ -143,6 +143,15 @@ static void init_mqd(struct mqd_manager *mm,
> void
> > **mqd,
> >                       1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT
> > |
> >                       1 <<
> > CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
> >
> > +     /*
> > +      * If PCIe atomics are supported, set CP_HQD_HQ_STATUS0[29] =3D=
=3D 1
> > +      * to force CPFW to use atomics. This is supported only on MEC FW
> > +      * version >=3D 509 and on RS64 based CPFW only. On previous vers=
ions,
> > +      * platforms running on GFX11 must support atomics else will
> > + skip the
> > device.
> > +      */
> > +     if (amdgpu_amdkfd_have_atomics_support((mm->dev->adev)))
> > +             m->cp_hqd_hq_status0 |=3D 1 << 29;
> > +
> >       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
> >               m->cp_hqd_aql_control =3D
> >                       1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> > --
> > 2.25.1
