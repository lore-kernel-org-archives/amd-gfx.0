Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F004FEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 01:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E415310E199;
	Thu,  6 Jul 2023 01:03:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D9610E199
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 01:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCPJbG0b953nHJNxNsV4DtcS7z5CyabTW7ACkO3UJ4NfLvUAdKU/J43vdx+UPgeGzAmUmWS8vTJtsNY/MVZUSbM/H4bRixJ+55d+YofB4F8ENRJ8z5QHQahT19RWMm/wf6iZe46cmOgiUoC4h9ueOmA8+9/XkGlqm+pqFLlnEUf/z7n9g8FzsYw3soNWxxBERtcZ5xZ4zHZHLVarELzV6Fr1FeQ0Lm150g4upEykR/eVg+33aHVzjK0+NL4gR3u+0I+OZmE4/ejKR3Iqb8Vvkf+icWxBTyho/MMMg9lzOGu31ja4WFCj6Mp1ENE7x0A5x00mNuH8xw5Eg9jmQOcx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16O7yMl6UG7cnFCzpqIdHdSswV/pJMTJY7b+xFpzxj0=;
 b=N7SdALMFTRqSUN0GEQihcEOQTtVuDp43LlQzVIt87yBTNggGkdV8O2dyT/JtzbXHQUndKAHuk3MrZNjd65Zwub6y3/ZVkFhvF/yLBwKW5jMFhcRQ/HBL4eiIUFBiNZ7hJtu+j5dzsOcXOUn+n71J4x5Yr/rJjDhXlqvJcH77Fc45DfRGzMBxHp0SYClwPWUCwMRPM2WlpQ0lAqtO+gqFce5W2CRNidQlenuV5AE3Z3AOhz7XfEwKc+mmsGXHwloB4ICDTehhqSGt9jFg4CfsJ02ok+1EgSnXhydruaRZRh8xZ/o1EhUuWVGsiwD+XYRiH3+EUiqT4Kng05QkItmEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16O7yMl6UG7cnFCzpqIdHdSswV/pJMTJY7b+xFpzxj0=;
 b=Uj0RBLKv7IJoGFok7eqSO9u4a/YXcyyFR3QrpHUBl/4HoY/TT3Thdz6kxzHnvnR3mYV9Mb19LUeGKKyCZerxu0/uMggNGuytuYItY5b2uFT46cSEBLQoaSqL3rJDXWjHW/4Npjd8S2YCB4j/H/W9mmL8mx7MdJbUxBE1RpuCOeQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 01:03:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 01:03:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
Thread-Topic: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
Thread-Index: AQHZr2uLNIjsXUQr0kenRVXfxzb0Na+r6xEg
Date: Thu, 6 Jul 2023 01:03:40 +0000
Message-ID: <DM6PR12MB2619EEE05A3A9BF93E3024A9E42CA@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230705180633.21538-1-mario.limonciello@amd.com>
In-Reply-To: <20230705180633.21538-1-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
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
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SJ2PR12MB8717:EE_
x-ms-office365-filtering-correlation-id: f00d520f-cc57-4a3e-3bde-08db7dbcd661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVWwlMiCa2Xt8IyPc05cF+NmpIueICS/T718WAPp7Otgn8h9K5pyvUmHrur/7O3xg2KcBrqtR0delfpyiUs0r0rog0iTosmnvUDUTTbv678ICwsPZCZvDHOCMtdy4KZWko6fEZ3uDy9M14V5mC/A1bIbPQDTQUWzKTedR1gvYcIFUpZgYuJ0XBJyZr7MCHtaSAOjobmIldMoN9wappZySlwFLYwMK1LtWdPRy7eUu26JRQUJBPucTCL1Tb4VS2M6VJ6dyThlTgs07JVVn8FCNUbeACIV4oKhZIiMoh5fqZLCX4WHijYJVqSHuTEcm9Y8GlbmJzcPLyvp3/daLHILQKE/0U1UfqbSpSa5uu9sHzgq7sckMTYcyB+Tk78yj1HT7myHhU7KyF7Fy5nshN9NzAhkCTMZcVqkUfFyA0Nq6IPZr8YvWW6Zk2ec/OLEnx1KbXclq6qt5P+HE9zrdsojNI+R6tyjdlNzhYvTvx2poIMXUOaAziJYu4zjYDAt8uqIsQNen7NG03eBNJEWxLqbr9wR+AhbltX3+a00Sk767XiPSCvVccGSyW1PevTTPZ4QS5XZNG+Ikr3ULbb7Iw4NN5VICkanJWN+RnzLjaszp39hcw/VIyylY1JxsyRB53Sj07vw5dYPKLCF+yFDzqz8Dw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(186003)(9686003)(316002)(53546011)(2906002)(55016003)(8676002)(8936002)(52536014)(6506007)(5660300002)(26005)(76116006)(64756008)(41300700001)(71200400001)(66556008)(122000001)(966005)(66946007)(83380400001)(33656002)(4326008)(66476007)(110136005)(54906003)(66446008)(38070700005)(478600001)(38100700002)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lXJcWekshqogbSfjBIBWwaakr71J8Rt5x41iqNiSL/DSxKxA+PPb1SjuorUb?=
 =?us-ascii?Q?DrViaeWpLhrsYhnIQilFv+BpC2MhCGQbikwPuC/4S69rSyqnIzYHe/05hD/G?=
 =?us-ascii?Q?/+e/nsXAhDUfDFSvdUn4mOAMnIqJBVQlyBYxqC97BnoMt0knXiUVAzQl3gNM?=
 =?us-ascii?Q?3JTYSJP0Ls0do3144tsbsZ0/rYfjhaMuVHS2vzs8M1BLoB8eCXl6SbToGzve?=
 =?us-ascii?Q?2qz34Roo2n3D6MmnqNB3wIskJFmWQaZHgYwN825iqka7fqw1zK1VOGmt8Za8?=
 =?us-ascii?Q?oOJ2qpnXC4Yn+UyusjXK2bkuIfJJDhmD4e98sFNZSxaQ9iGtmc2tsG7NxJu1?=
 =?us-ascii?Q?hEXL4yDogDcVOrGa+1g1qhKUlesT0ZDnpi2nhnAo7yteaZUh0IRcz9MH/bQP?=
 =?us-ascii?Q?/mN6T57SblC+De4u/4n/KnM14ZdUpXnwmoS1BT7seUmcHif6imIgAbDd3DHN?=
 =?us-ascii?Q?YN3ViMe+wwrDH/iF51/mBG/hP4lfqW/2F1BgtCE0LTe3z8ljmZSqGGWPahYT?=
 =?us-ascii?Q?nxGQaEKNw8xfIkIMwzxAUcJKdjFxji87C0EnmqhPAf6JrSUs0GW4vGF/mdbG?=
 =?us-ascii?Q?xBywM3J+IQaaIKrmQoUZilRr5iEJvkaJ8Qzbjci6a24I8vScFpySvqLIIlBQ?=
 =?us-ascii?Q?1fqbx/OyTMeH4BliZQtZJEXa2CmURik6ULxofCyy7rZDceHkrjqWtYYQNjuf?=
 =?us-ascii?Q?XEcFrQ9snvjcSFcrdPHy+UjEkwrKr4yioc6Ezcv3M38YosSou2dyh+GpjB4p?=
 =?us-ascii?Q?Dl6dHv8yFZh8xeKY4T1ggB7up/FNjWcNwHn5dupO8Uh+Ur08wu2mOyp2hgD1?=
 =?us-ascii?Q?WxSZZ/BZoUqsccNYYMc2NPRtkFH68Si+2LYy6bscmlZ2kKtNr9OLzYcBk2g2?=
 =?us-ascii?Q?0Rg2VxU1mSJsdL8aIYjIMx3CZuxJr95IRIR3o4zxI0Cfy9BFM+7rc+RP9ZQg?=
 =?us-ascii?Q?ryo1B/GhLSxLb11XGggxrbP9ckfvORNENFFSXav1BdhRlD+k3Ey5HuFhfs5h?=
 =?us-ascii?Q?fqXTbdwXVEnn/g7WzMTG5pbueChhyGr2emSbpbdXw6monwaqmPuTqHZPSTxL?=
 =?us-ascii?Q?If1jbuhIp+psdjk8jdEwX+UY07/HlBnk5OIxvB2SZ784GQz0RyWcAJKHQ6qP?=
 =?us-ascii?Q?6dmRuGEBUjjv+sh+1jmHt9o+0XoUvQhToGkCSwndMX/AmAR90UgaE2Iv9xs6?=
 =?us-ascii?Q?8GoiyFJ/gYBsfZrTfdFlNEVUJLCD9V2nNRpJ8OoD5tk6WakBpiZHMj7Ffmtc?=
 =?us-ascii?Q?96mT5xOZM2vkWc9/edbSk7Pd7av3o3suu7iTHXE5VQ6Ls2UuzzGnM8A/8rpp?=
 =?us-ascii?Q?VWo5WYvC1Q7WapC1bDb3OcdeR2VQVqTXP7+LMT1a0w5SZjQTIkUGKL4mM3On?=
 =?us-ascii?Q?9WZ3crL/Kr0C9ZsX0XSHbAeWW4wMyd/Oj/VtWQDV32U6OxI1YoDkIE8xJqNE?=
 =?us-ascii?Q?ZBewTg+7uIvDpqsyD5olenPC1S3fnzMPtrSZaMguvhcHlkMTsZNLmw/celhW?=
 =?us-ascii?Q?9kyLtAKa9jv2Lx0NkfNUEZpbA8Vhu4X1QxRWLYNi3gm8SOIdYvMj/iLB2HfP?=
 =?us-ascii?Q?q6DgJ3fPfpht3gCBHSk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00d520f-cc57-4a3e-3bde-08db7dbcd661
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 01:03:40.6752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMbDSZ9ajJLWUtudb2ow4gvID3+UaYHjULpG19oi9NAkoarygJCNrZ9i7dtucObR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
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
Cc: "koba.ko@canonical.com" <koba.ko@canonical.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

One small nitpick:
It seems there is missing a default clause for the switch statement.
Will that hit the compile warning about "a switch statement must have a def=
ault clause"?
With that checked, the series is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Thursday, July 6, 2023 2:07 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: koba.ko@canonical.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [RFC 1/2] drm/amd: Extend Intel ASPM quirk to all dGPUs
>
> More failures are reported across additional products and so it seems
> unless we have a handle on the fundmental ASPM incompatibilities with
> Intel host and AMD dGPU, we should not allow them on problematic hosts.
>
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 +++++++++++++++---
> ----
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
>  4 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dc4dc1446a19..294a549e7499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1314,7 +1314,6 @@ void amdgpu_device_pci_config_reset(struct
> amdgpu_device *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> -bool amdgpu_device_aspm_support_quirk(void);
>
>  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64
> num_bytes,
>                                 u64 num_vis_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7f069e1731fe..ef22a0a6065e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1458,6 +1458,30 @@ bool amdgpu_device_need_post(struct
> amdgpu_device *adev)
>       return true;
>  }
>
> +static bool amdgpu_device_aspm_support_quirk(void)
> +{
> +#if IS_ENABLED(CONFIG_X86)
> +     struct cpuinfo_x86 *c =3D &cpu_data(0);
> +
> +     if (c->x86 !=3D 6)
> +             return true;
> +
> +     switch (c->x86_model) {
> +     /* Problems reported for Alder Lake
> +      * Volcanic Islands:
> +      *   https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> +      *   e02fe3bc7aba2 ("drm/amdgpu: vi: disable ASPM on Intel Alder
> Lake based systems")
> +      * Navi 1x cards:
> +      *   https://gitlab.freedesktop.org/drm/amd/-/issues/2458
> +      *   c08c079692da0 ("drm/amdgpu/nv: Apply ASPM quirk on Intel
> ADL + AMD Navi")
> +      */
> +     case INTEL_FAM6_ALDERLAKE:
> +             return false;
> +     }
> +#endif
> +     return true;
> +}
> +
>  /**
>   * amdgpu_device_should_use_aspm - check if the device should program
> ASPM
>   *
> @@ -1480,18 +1504,9 @@ bool amdgpu_device_should_use_aspm(struct
> amdgpu_device *adev)
>       default:
>               return false;
>       }
> -     return pcie_aspm_enabled(adev->pdev);
> -}
> -
> -bool amdgpu_device_aspm_support_quirk(void)
> -{
> -#if IS_ENABLED(CONFIG_X86)
> -     struct cpuinfo_x86 *c =3D &cpu_data(0);
> -
> -     return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_FAM6_ALDERLAK=
E);
> -#else
> -     return true;
> -#endif
> +     if (!pcie_aspm_enabled(adev->pdev))
> +             return false;
> +     return amdgpu_device_aspm_support_quirk();
>  }
>
>  /* if we get transitioned to only one device, take VGA back */
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 51523b27a186..4f8e696d9ba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -527,7 +527,7 @@ static int nv_set_vce_clocks(struct amdgpu_device
> *adev, u32 evclk, u32 ecclk)
>
>  static void nv_program_aspm(struct amdgpu_device *adev)
>  {
> -     if (!amdgpu_device_should_use_aspm(adev)
> || !amdgpu_device_aspm_support_quirk())
> +     if (!amdgpu_device_should_use_aspm(adev))
>               return;
>
>       if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 6a8494f98d3e..c413cac369e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct
> amdgpu_device *adev)
>       bool bL1SS =3D false;
>       bool bClkReqSupport =3D true;
>
> -     if (!amdgpu_device_should_use_aspm(adev)
> || !amdgpu_device_aspm_support_quirk())
> +     if (!amdgpu_device_should_use_aspm(adev))
>               return;
>
>       if (adev->flags & AMD_IS_APU ||
> --
> 2.34.1

