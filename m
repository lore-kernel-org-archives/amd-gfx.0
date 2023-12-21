Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A6EC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 08:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C3910E012;
	Thu, 21 Dec 2023 08:31:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82A410E012
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 08:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTcICvCB6bpr7S42hCuKbyhnz2kRi1yX9AJij0DvMB1tFA4dGEH4KzjgSKRdi+hcA3sFLVsj1/JCq6xtPsuxXPlX/Mc3a7Nxkfu21L3Hpw7aof/e+p6QxDgvSJYJ/MA/Vhezy7A8mprjctNJXxdytrfdNOn7ULmZboACQV7AAQiFif4BGDzRH9VJ6nY0Vmp+IDte/6nxIQD8OTqHDKROwItb2D2IMXI1bhCrRPUgf/LLq610mGLV/FbI05A+enJKLb93XFMXMontZPAzcXR6muo9Ie3D9aOKXgXzhpEQvGYjZC8WGkN9CiHJtBEoyzCpRUpzGyrOPXgb7T0PyyU+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRtbc8NT3K25/1jJMv++KA+YZjuCSRp/ts6mmb64tHs=;
 b=janrM5nuGRskV9gtZ86GmkkRacRhE2Ns2nSRCFzF8nZRY93JH34KwIYiOMirR8UAjgEjhPiTtK6C3a86SFVMzZL0szM0RG+AqTWWbPEB6EM1G8+k0AiZ7lwQJCjntUkie9VxEfTSRZQS2mhPSB1HLj29M/HCwB8Glkoqyjw1E2Xra0RYuYJ0lL3U+K8pkIGysWKNtgmXXHYMdDS9nnRg8qkkgIV4tCoOSmX171WrDhNcX64NA++8RX/NPfYR4TCWvi/9mNn8d+pIUoOUoQqm67ul6iWj4YeuN78T2zttror/FSNCQiwefqVY+bMsUhXJ7I8oBO6U2VgZJV3g3XJvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRtbc8NT3K25/1jJMv++KA+YZjuCSRp/ts6mmb64tHs=;
 b=iMkf5azeEYoM+9m+ETqnWwzaiV5d1ebvYWixRHRtJcsaEhpmkUHB4hi8ITIJdVehF7EhSjBp1xQSb6gXmuUnOsmtTWXlHR5o3d8M+ZxB41fKrNbDOzbWrjHmKm7/fZcVJxbfdlf1w2RlG4oOYUJBNJNfqQ2MUkhMrZuGrVUy2i0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 08:31:10 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::8fb0:a031:fb10:3bbe]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::8fb0:a031:fb10:3bbe%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 08:31:10 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Topic: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaM9PGPcrypl4D4ECx4ottEdHvK7CzaGXw
Date: Thu, 21 Dec 2023 08:31:10 +0000
Message-ID: <PH7PR12MB8796A109025AD27C5401131AB095A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20231221060521.529095-1-Stanley.Yang@amd.com>
In-Reply-To: <20231221060521.529095-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8a9d4ada-8027-4e52-a0c1-6ece0fe25d58;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-21T08:30:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB7604:EE_
x-ms-office365-filtering-correlation-id: 1fb53f7b-f2cd-4821-67a6-08dc01ff2f48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVZH4f7RwWvAspKqas1FnOQ9oO+lmux2IiOH/i09Jxe7kHnXCXax3ulFdAM0gt2oxy9CDoS/6lu9frIJkfoe2zZwqr7ihC7fn1yEJ1ACyg/S4EpFt/jt4Eh3E56L0T7X66APNV7yhuzBKYcsBoakMCUsbHgJ2i6yNf0P0f/wvVD9sPxjZJR8PYQD6FE2W5oOAZk3lZMSCCMTDDxwFpq3XVE6HITcp9duzSgTO56OWNOhr30A9OWzBEZZGalioefARqUssPx0Z31shBf9aJJY9dliCtmNGas6Se5gZoyiY0MGgpjBrMiLWI3et4WNh0xdwvKSv9Xo6/64L5Qw2ZtQdm0vOzQmlNJ9+j5hUlm4QKdT36EZGrdI37NAAfITPsWJyyeNWxjuldG1vE/lgbJMVmRv+4/nSofz7N5ISmSrKs47RR/ug7mGYKTfo73qRKMGtk87oFvLF7UWFBE6StWp+MtpZdQekaD+kBZl1kb6Gwyz7fc+QgZHdxmJ2A7WNDKylwY2Jjhqm8cEKP7wMzO9hvklcsiU9vzbkjqPk8YD5Kyz+CY70YezT7l+745xUxM61QbvICuftR1BHu5RadTfaMAhSBz+jpLNJ0pYZw+rX7t6K5K9g8Ktcg6CIfbd9mV5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(110136005)(41300700001)(86362001)(52536014)(8676002)(8936002)(2906002)(33656002)(66556008)(6636002)(66476007)(316002)(76116006)(66446008)(64756008)(66946007)(71200400001)(38070700009)(55016003)(5660300002)(4326008)(478600001)(53546011)(9686003)(38100700002)(6506007)(7696005)(122000001)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TmQmX3KyHDtCZfn3nvady2KM8HFA+cCBR4UIDU7XBuodgLxlYypNXWg+2O6H?=
 =?us-ascii?Q?IhdpsSYmEkB8SXwnZDDwIt5YoR9WhZhKfjcbM5AbqVlddgGZEh6n2OGweGai?=
 =?us-ascii?Q?1U5vvG+K6R47MRJrbIiMxl3BC2ou3ImFeYrw+lvijasx5QJbv4Yt0rml7NWa?=
 =?us-ascii?Q?7vdFjGW4H8gHolk+TLqVHULBooDIOZfgvw/pI8VKktA1nl/JiuTGHeRwxUzJ?=
 =?us-ascii?Q?crha0oVtHAwTwvi+c6YmWyEbFCFFLZyQj8/QQr8EtOoUsgOveZIWRHnVTZ5s?=
 =?us-ascii?Q?mL/bybR17DoCZdDRpRZKWttaB061ixtv/kWMGPiQ93wRlAhhu8FGkin7XZiZ?=
 =?us-ascii?Q?yPgjdb4skpwLhr6I+H/jynb3G23qTOKaV7+jiaCpTWbD1V1d+JN6qjfoWvGm?=
 =?us-ascii?Q?TgNvc1BusS2OWnU8jwIL0TxQpo7f92PTbO6YHt0cAEJrOEn1e6Nl56mvUGGl?=
 =?us-ascii?Q?OVtDYbLOHazQrDQgmSPKqthmPm9OfdUlIpHkhgLUDQSBkd+DzwLY+J46psYU?=
 =?us-ascii?Q?z1gvoG1Dkjp8iqa+043q7AXyznKFm+wY0TCkDn1IJMYjastY8XBXhI8YLTGm?=
 =?us-ascii?Q?XwlTZ423UPp6Sg6fPolpVLS+HpkbgvoQ0d6DdtwLFeXw/4/UO1/CEfSWwJ4N?=
 =?us-ascii?Q?M29D3j2S2puTvbCE9AtbOI4nFP38SGIqeYnnfhMKggh0+AX/yt4YnUvdgJWJ?=
 =?us-ascii?Q?o9VjHBT9BQAFXgJr2/hC//gtEOYWhueSvc/Hi6Zi7t4Lb1WjCp66qKUDqcj5?=
 =?us-ascii?Q?MlDVf39kVZr2WFFzEZ3lZRmZdRD4PTzGH4PfWtp3tccC8cNqVeXkDQsVDlrc?=
 =?us-ascii?Q?KiTf4cNQ98bxPnVW+UJWGomLKgpdtyWpWq5xbDnU02F9dkiIPkROigjuKgeG?=
 =?us-ascii?Q?H5SSVuESZz4qWbGWadGm+0Jjm2aiX9uJjNh02CG0YISqjWd6NeDDMe2QMJkD?=
 =?us-ascii?Q?/SrcfeRzHCLXt+7t6WqgZ32YVVshnYeBCHVAPLWiVffDVficRDTddD+ZUYzu?=
 =?us-ascii?Q?qX7Fsv2Py9dNi9xOwihuZbfSAYB6OE/M1ySasIs/GnIORFNctYSge3BJ64zt?=
 =?us-ascii?Q?phc+BtuoxUXTg8oVGnARAHiI5p/xCYleDiOyNoTnhrXkY+9rKvxKZDLcnK/4?=
 =?us-ascii?Q?knJ6mOFN4RgmLncTqU5QvaerAEIqLnabdIpwugf1CXNmYlnMudD5j5ySuIeS?=
 =?us-ascii?Q?/w+onWVp+5Nd8/GOqou+opIpp29nP1/W5fNSnORvnAyH+5WH24NWQgi7h4b0?=
 =?us-ascii?Q?nEw0/1Rww8StYbP7lZaG+k9Hee5cyVb7m1QIqYfegZKbETMUcij4InmkVirP?=
 =?us-ascii?Q?x+uL4sLcyPGXVwg61DzdvV4BaU9oyyxfaCq6OrxK5MvPlYBiZvHkgdGQxzR0?=
 =?us-ascii?Q?4aa83yr6zMv54SjyC3ieaMeNMIxMyNPW6Ii59Pk6dYXTguyUlLZLAZUTXc1M?=
 =?us-ascii?Q?k/FGoO+91cE/D0ZXbXbUxWOm0CXgTN7aZi0CagLMAp6807adq74tdQoWNRWt?=
 =?us-ascii?Q?pCGle/t2gjmnZcrr3Bq/0UCIX8UBEM2zw3u0OjqimwfnY06d/h/yygC9Uu8S?=
 =?us-ascii?Q?/X8znntu5KFuf+pe+jA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb53f7b-f2cd-4821-67a6-08dc01ff2f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:31:10.0858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stnScwF8v5/uidSDC+X6rE3sdAmQKm5MOq7GQUaVhpvJ9hkFvWYhLJlAFAKmXq8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, December 21, 2023 2:05 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable unp=
aired
>
> The ecc_irq is disabled while GPU mode2 reset suspending process, but not=
 be
> enabled during GPU mode2 reset resume process.
>
> Changed from V1:
>       only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip
>       delete amdgpu_ras_late_resume function
>
> Changed from V2:
>       check umc ras supported before put ecc_irq
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28 +++++++++++++++++++++++++-
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++++
> drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +++++
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++
>  4 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 02f4c6f9d4f6..b60a3c1bd0f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -330,6 +330,7 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,  {
>       struct list_head *reset_device_list =3D reset_context->reset_device=
_list;
>       struct amdgpu_device *tmp_adev =3D NULL;
> +     struct amdgpu_ras *con;
>       int r;
>
>       if (reset_device_list =3D=3D NULL)
> @@ -355,7 +356,32 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>                */
>               amdgpu_register_gpu_instance(tmp_adev);
>
> -             /* Resume RAS */
> +             /* Resume RAS, ecc_irq */
> +             con =3D amdgpu_ras_get_context(tmp_adev);
> +             if (!amdgpu_sriov_vf(tmp_adev) && con) {
> +                     if (tmp_adev->sdma.ras &&
> +                             amdgpu_ras_is_supported(tmp_adev,
> AMDGPU_RAS_BLOCK__SDMA) &&
> +                             tmp_adev->sdma.ras->ras_block.ras_late_init=
) {
> +                             r =3D tmp_adev->sdma.ras-
> >ras_block.ras_late_init(tmp_adev,
> +                                             &tmp_adev->sdma.ras-
> >ras_block.ras_comm);
> +                             if (r) {
> +                                     dev_err(tmp_adev->dev, "SDMA failed
> to execute ras_late_init! ret:%d\n", r);
> +                                     goto end;
> +                             }
> +                     }
> +
> +                     if (tmp_adev->gfx.ras &&
> +                             amdgpu_ras_is_supported(tmp_adev,
> AMDGPU_RAS_BLOCK__GFX) &&
> +                             tmp_adev->gfx.ras->ras_block.ras_late_init)=
 {
> +                             r =3D tmp_adev->gfx.ras-
> >ras_block.ras_late_init(tmp_adev,
> +                                             &tmp_adev->gfx.ras-
> >ras_block.ras_comm);
> +                             if (r) {
> +                                     dev_err(tmp_adev->dev, "GFX failed =
to
> execute ras_late_init! ret:%d\n", r);
> +                                     goto end;
> +                             }
> +                     }
> +             }
> +
>               amdgpu_ras_resume(tmp_adev);
>
>               /* Update PSP FW topology after reset */ diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 09cbca596bb5..4048539205cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1043,6 +1043,10 @@ static int gmc_v10_0_hw_fini(void *handle)
>
>       amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +     if (adev->gmc.ecc_irq.funcs &&
> +             amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +             amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 416f3e4f0438..e1ca5a599971 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -941,6 +941,11 @@ static int gmc_v11_0_hw_fini(void *handle)
>       }
>
>       amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +
> +     if (adev->gmc.ecc_irq.funcs &&
> +             amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +             amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>       gmc_v11_0_gart_disable(adev);
>
>       return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 205db28a9803..f00e5c8c79b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2388,6 +2388,10 @@ static int gmc_v9_0_hw_fini(void *handle)
>
>       amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +     if (adev->gmc.ecc_irq.funcs &&
> +             amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +             amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>       return 0;
>  }
>
> --
> 2.25.1

