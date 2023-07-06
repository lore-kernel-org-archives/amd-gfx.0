Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6796BEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 19:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A7C10E0CA;
	Thu,  6 Jul 2023 19:02:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BC410E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 19:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTISlhmgyRyhMjrUgEdPxByLLwTK6iyNhrcZ3EfTHVDyAWW35iIxCGYYYmXj53k1aYtgV+s+QqUtJKfS9/3744NZ8Wqut5p40zEATSm1ceixZX4tZ6dgjMPgZtfce1e9kg3W2Wc+UXcN4cjv5jE0Eu5gYb40VMU0zcvjhQzBg7QY1YzwCtZOryqNwvDiW+iTW+K07P4EN0ocgNJMBEqZw7iiovqyBkxQQtDKjg+9yotr9oKiA8dBdn7DCOsm231AZL+jo99CLg3WhcVgyaHhkaFHRke8eRsTAVsQg32mQj3qOGNCPZISuo18IbNWBpjyebsa6HfZ3G6P/xbhmCCIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBL8J4Lm0AMy800Kmi1YIjSMmiovlWiiqkS7NamJGWw=;
 b=dW3OAaRQ1ZzhC1VoC5lCiuyp5auCVzV/ayUZluH9v/oLYIi0SnONgxie3zD2TjkbiV9eAOMegCOG2jZu079CHCKZjlKaqhXmjop10IIBI6npooEW+ZpoHpkHmuLPbBlnRO+WizPvaq0hk2O1IiOWf7jOyhk2rW3DAZ5ORk8pOYcZ96H5xsm/XevGnnQkn5nHEQPfMwjbwo7Z8Xvx3xIpz3NjKZMa/tqdJKiBVSt4sghIFnN89ld0fven61M+wxiemvM9xjCcHr+nbU/yNbFbNigwfqN1pGODN8JeprIduQ1fifNeTl2vlLiHFWDwrrBTWmla5GnugzKOzF27Y2c0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBL8J4Lm0AMy800Kmi1YIjSMmiovlWiiqkS7NamJGWw=;
 b=r8Z3xMF1QhN3g4mIT3Z7L0Ib494vOoc8qhh5NGD8JZqHoxtpa3H/bYQQ5Nhg6cJciHuUnCqUDlB6DTN4KgCSR/eBzFLFzcuH02JVNc+wYiGMtq7COii0nOgp+ZYUcFpedK8xH0GRxU2q2AmDT+Uvrv3E3Jwt2BXUR1tZ8il/hlg=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 19:01:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 19:01:57 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
Thread-Topic: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
Thread-Index: AQHZr2uGJYwmp68hW0OhFec8XxaSQK+r7I8AgAEtGoA=
Date: Thu, 6 Jul 2023 19:01:57 +0000
Message-ID: <MN0PR12MB610131AF5FE932BD88BCA4B1E22CA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230705180633.21538-1-mario.limonciello@amd.com>
 <DM6PR12MB2619EEE05A3A9BF93E3024A9E42CA@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619EEE05A3A9BF93E3024A9E42CA@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4710c526-d2b5-422f-9bb4-bdbbe24cef7a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-06T00:58:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9086:EE_
x-ms-office365-filtering-correlation-id: 16c11304-0917-4a70-8461-08db7e537875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAFQjpvRzITlrU0CNXlmpO9jUjq00UKu2+/hKimw13a6u6RiX34x4XrZBYI0SXIHSJguaJp6lAeplOoqZp0q1e72P+Ir4Jk9GwmSVSVk9zJVAlsEY6kJiejdUcAwjaDGzOtMfneg6VjuhZ3GXiCtXZWhfdFAuS+BqVD2LoMRoGJnfypHOZy/gvM/CVvLuhtpfAXsh7cEpefx5TnqUJVBtgeOaQ80NjFa+yhVYmD6IegKpDraOCg961OElXMLPSJ4TSbdsDrU68GFlimtvGuFDVYxIDwUqb8gxB55U/NpAP+DEsg1LOeULa4CfbaYRZH1R5QHgioPDlaMn3nGRQnOUZbSLjb5yd9T/JBKRBEe0rOO09sNcX62uw62qZPZoFauWlT4BvgAHuy9MlFWZ2YPC8jdiogbzqD9ltYBvpXqChtaa1ivSXfeG0GXIb3upnRmyEKHcK48hxKL4iSOBozriyR9VPl+h5/OG8jfB+It5gVcbsE528HgvXax5rZoKUH4qEt6fyhCC++ofnnh1PmwbDfRuHf9yLu0CAcJdZv5EqyvCjh1vU54M1r+486f8jL/TR0fN9cyMdkAhtGEpVUjuwW8Lg7GiZHo/fWVHUOZF5R1XPCUw92+64vb52/3dseCnRwWjGbubb+E04w2NU05kA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(52536014)(5660300002)(64756008)(2906002)(66946007)(66556008)(66446008)(4326008)(316002)(66476007)(110136005)(76116006)(41300700001)(6506007)(186003)(478600001)(7696005)(26005)(8676002)(8936002)(53546011)(83380400001)(71200400001)(38100700002)(122000001)(33656002)(966005)(9686003)(86362001)(55016003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wwalUFksi7hO3zI9MMIWksJERZmXHoMz0V7wFXdyP1uyVyqYDwKWiOW0qru?=
 =?us-ascii?Q?pSdlnzhE4x1GEFNrXaif/eEIWOYgw1S7xqMB2m9qBFakJjbftfb+NhS/JzeO?=
 =?us-ascii?Q?7I/FzNpDvzdyrkwYkPKRMcPoheUkyJcw0XgjrNJO4fHlZjKure06AfH1nLKn?=
 =?us-ascii?Q?s1dRMp2Qbh6fVMqcYIjlPIglZrKRiq4HnNnzb4LgHuBmvL6j7HqvtjnOJk3k?=
 =?us-ascii?Q?TNeqy7uHM/hOfuvQutLUJVHZv/ULB5bN++qqMIkK95RkiGtdSatf8hQzjs7N?=
 =?us-ascii?Q?1BYifGG/fLWS035P/Qg/3cwGcN9Z/vnPXtkjqLkD524ZujfPiejeuimF1PWi?=
 =?us-ascii?Q?0TkJ370QEJ/SXrNyZFUMuvbqx9mhmFlkvZctx9U79Bg4t03zPl1xnsFecl3s?=
 =?us-ascii?Q?TKirz1zfj+eJHH4KQHohm3860ShGTclFYBNPhitySLTg20Lj2Vh5u7tatznc?=
 =?us-ascii?Q?JOA5TpPE6DLLlOewOjhEBF1Bf4/WTugmuV3rHJh9uSz46LITkCic+AiTADV3?=
 =?us-ascii?Q?zjX3dmht1eHkJqzl+6Wma6+y2nkoSD+AZXA2YUbDqfaf8hMtDnBkqH6oSGn/?=
 =?us-ascii?Q?MEx8lxyml+d0s/qepKddOi1RddceV7SH65FN30AHwLaY6eLJvWAB43hnJLE5?=
 =?us-ascii?Q?FpFqJb3o8smvdVPdURkLrIefKhJp4v0405jrgsXfYEABmA1dXs6MtYjPbif5?=
 =?us-ascii?Q?MJASXcWEgfFJcagqXZ3tKModdpgC4vpzAW5m4av1PVMmsKQcMFW5UpK1SuRR?=
 =?us-ascii?Q?NxDFTapEQf+sFjZ/2/FV/cQAd/dHv6GddD/VCCgDeVm/MBHUirkv6cpo7qFz?=
 =?us-ascii?Q?Rl5w2QMtZ94fDdRnPevxCyRAuZQ1yvfRQOK9P0MQwhvgRwgxQSrzn+DdXruj?=
 =?us-ascii?Q?uohjo79iv/g+Ty16YPaoH/TeKAMEdWoX2/YeysX77twGfy5VV1+zg62o4hhC?=
 =?us-ascii?Q?bTHGCMKZnFNgIreh+7gXdR0stMoExqXjTb2im8gLBfuclSPLJxN/mqRbCyS8?=
 =?us-ascii?Q?eHG2JLvXZ8ks1mFSS98jtyrkg7puzTdA4A0LKYIyFnyFzeAF7+k5dNlrRuy3?=
 =?us-ascii?Q?c8AzDbLO7QqoctMjGm249DtKfIqVSRFM0BYhdCS0rnNhwWcsxcQ2MDDVWjV+?=
 =?us-ascii?Q?yV8unLukYr5iGyQaLp0WVAH+VA1G3L9o5nqZEmFgufxkvjTNi69tl4eiaP5O?=
 =?us-ascii?Q?Xn0TsYmUrNATQkmlawI0eqYKVxYnEghgsgp52D1aRfb0/NcS42TOcWlznX6F?=
 =?us-ascii?Q?9Kx70A+ZQwRPsRXvJ7nhGgW8O8RaJ26K4Eq1eQAY9iHJ+MzyxUpKZF2UxEC7?=
 =?us-ascii?Q?gYzVp1+PJ39s7Oe4ANn3bhsG2zuuoxKi80w0sBUlKrEmi9XGZCh+RhyQ34v/?=
 =?us-ascii?Q?3zPsWT9FqR+xWN0Bxuxo9Ygk8vf7M0QLd4mA1zOJpHSoIpTWsRDuyBg0o1oc?=
 =?us-ascii?Q?yIl8zRbRdUe9jT8D8eRmWitO5ZSTfyGUwqiPcoNtDh7qDc0VYxInpejK7gRZ?=
 =?us-ascii?Q?1P3uOfItQMYsjHeHNztYcO5hwOrilYpuUWN0RiFxirBVGGshJb8Pc0bv3TZI?=
 =?us-ascii?Q?TSkaGYZQy2qxL+GoBT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c11304-0917-4a70-8461-08db7e537875
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 19:01:57.1396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brE+YK2cvaxIMr+cYQN3IppY3PxszIiNd7yZEAhDNXneBzHICTZJtEqpfi96WVLkpWuPoNhSbV/d0Pces822tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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
Cc: "koba.ko@canonical.com" <koba.ko@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks.  I'm going to leave this series as the backup option, have another =
idea
that I'll have Koba try first.

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Wednesday, July 5, 2023 20:04
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: koba.ko@canonical.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: RE: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
>
> [AMD Official Use Only - General]
>
> One small nitpick:
> It seems there is missing a default clause for the switch statement.
> Will that hit the compile warning about "a switch statement must have a
> default clause"?
> With that checked, the series is reviewed-by: Evan Quan
> <evan.quan@amd.com>
>
> Evan
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario
> > Limonciello
> > Sent: Thursday, July 6, 2023 2:07 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: koba.ko@canonical.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>
> > Subject: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
> >
> > More failures are reported across additional products and so it seems
> > unless we have a handle on the fundmental ASPM incompatibilities with
> > Intel host and AMD dGPU, we should not allow them on problematic hosts.
> >
> > Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 +++++++++++++++-
> --
> > ----
> >  drivers/gpu/drm/amd/amdgpu/nv.c            |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
> >  4 files changed, 29 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index dc4dc1446a19..294a549e7499 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1314,7 +1314,6 @@ void amdgpu_device_pci_config_reset(struct
> > amdgpu_device *adev);
> >  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
> >  bool amdgpu_device_need_post(struct amdgpu_device *adev);
> >  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> > -bool amdgpu_device_aspm_support_quirk(void);
> >
> >  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64
> > num_bytes,
> >                                 u64 num_vis_bytes);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7f069e1731fe..ef22a0a6065e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1458,6 +1458,30 @@ bool amdgpu_device_need_post(struct
> > amdgpu_device *adev)
> >       return true;
> >  }
> >
> > +static bool amdgpu_device_aspm_support_quirk(void)
> > +{
> > +#if IS_ENABLED(CONFIG_X86)
> > +     struct cpuinfo_x86 *c =3D &cpu_data(0);
> > +
> > +     if (c->x86 !=3D 6)
> > +             return true;
> > +
> > +     switch (c->x86_model) {
> > +     /* Problems reported for Alder Lake
> > +      * Volcanic Islands:
> > +      *   https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> > +      *   e02fe3bc7aba2 ("drm/amdgpu: vi: disable ASPM on Intel Alder
> > Lake based systems")
> > +      * Navi 1x cards:
> > +      *   https://gitlab.freedesktop.org/drm/amd/-/issues/2458
> > +      *   c08c079692da0 ("drm/amdgpu/nv: Apply ASPM quirk on Intel
> > ADL + AMD Navi")
> > +      */
> > +     case INTEL_FAM6_ALDERLAKE:
> > +             return false;
> > +     }
> > +#endif
> > +     return true;
> > +}
> > +
> >  /**
> >   * amdgpu_device_should_use_aspm - check if the device should program
> > ASPM
> >   *
> > @@ -1480,18 +1504,9 @@ bool amdgpu_device_should_use_aspm(struct
> > amdgpu_device *adev)
> >       default:
> >               return false;
> >       }
> > -     return pcie_aspm_enabled(adev->pdev);
> > -}
> > -
> > -bool amdgpu_device_aspm_support_quirk(void)
> > -{
> > -#if IS_ENABLED(CONFIG_X86)
> > -     struct cpuinfo_x86 *c =3D &cpu_data(0);
> > -
> > -     return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_FAM6_ALDERL=
AKE);
> > -#else
> > -     return true;
> > -#endif
> > +     if (!pcie_aspm_enabled(adev->pdev))
> > +             return false;
> > +     return amdgpu_device_aspm_support_quirk();
> >  }
> >
> >  /* if we get transitioned to only one device, take VGA back */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> > b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index 51523b27a186..4f8e696d9ba2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -527,7 +527,7 @@ static int nv_set_vce_clocks(struct amdgpu_device
> > *adev, u32 evclk, u32 ecclk)
> >
> >  static void nv_program_aspm(struct amdgpu_device *adev)
> >  {
> > -     if (!amdgpu_device_should_use_aspm(adev)
> > || !amdgpu_device_aspm_support_quirk())
> > +     if (!amdgpu_device_should_use_aspm(adev))
> >               return;
> >
> >       if (!(adev->flags & AMD_IS_APU) &&
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index 6a8494f98d3e..c413cac369e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct
> > amdgpu_device *adev)
> >       bool bL1SS =3D false;
> >       bool bClkReqSupport =3D true;
> >
> > -     if (!amdgpu_device_should_use_aspm(adev)
> > || !amdgpu_device_aspm_support_quirk())
> > +     if (!amdgpu_device_should_use_aspm(adev))
> >               return;
> >
> >       if (adev->flags & AMD_IS_APU ||
> > --
> > 2.34.1
>

