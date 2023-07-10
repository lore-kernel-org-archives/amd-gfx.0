Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5166CEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 01:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E10710E029;
	Mon, 10 Jul 2023 01:54:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE4110E029
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 01:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeOBtaGtDytv5g8voO9nlzV4+b/lAX9YhraFJ9pGfhrHt5Ltxxul1lxLybbEVgQMdy+ydg5yzzm6K2RNzgcmWnt3jNYSrmy3Iy528s0j426meOW7myMQaMU1GZFj6sfAKHoyiUSPvJqEK2M2DshdvaRLGKTWIV9hzTSX8DFuFsUM96UGjbhWlUk3CY/it/KsCGOASbWAxgoIlEKf7l/+2CtA4knZ1hJnXaXqYM6ZyUjBoaOYoyjed4YPxyEEVaUUHgcc8Th4Prw+3VCm7eeVRRjX85XrJoJ+DzuQA2E9Bvybk1PutbObMzU3dd/k6JM5nrhB3AwlE2WKjFQVkt0Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUUm/dj3YPWwzy6xeyA56uTXOty5g3yMr3JWX7D6HmQ=;
 b=Nm5B/wxmPUQo+G1gPyiBl7raeDAjTQgMPfGhimFwPLKXMktTrzUsvJE9a9ZfF5Hmre2LGdWRukVayDldW5oFCc0bEAQ2r6raQ5i5P5g2ldDlXfR/h3w1tGdwZZOqAQakAzZJ4H3Gkq/ogo5xf7zhiucy9mEAByQIemrcKevHUiBLXLLKHyp2nqAWHLx9EcNhVAL+Zi5emm8hZsl1xW2i2t9X52fEjkhxMWOzBi9Kk0V5/0eVpet6T3nKjZDHQwe+1jAIU/pz6cGFR9rlZHVmFuYbeBbi28gnUrUcc6ye9LSYgDl8JsjdfKJUwy70m0PY56c5c2mzphN4mCNITEeqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUUm/dj3YPWwzy6xeyA56uTXOty5g3yMr3JWX7D6HmQ=;
 b=VxGbnatOBMfz5R2HlHIRUtg9dRgk/amVfsHqZ/oyHRNu0EAhbLPwkfbsCzGZ+kktl9TwoEEZXgH8UyE7mRIwXUoR03KH5OV05tu9tUY8WGSS7e1ePs7ER9smDkEvUhtzzCiSdOSD6FsBqal/jcPOqh8QAGhk2SWP/1zZoXGWHKM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 01:54:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::25a9:4f48:2300:efe5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::25a9:4f48:2300:efe5%4]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 01:54:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amd: Drop amdgpu_device_aspm_support_quirk()
Thread-Topic: [PATCH 4/4] drm/amd: Drop amdgpu_device_aspm_support_quirk()
Thread-Index: AQHZsUOfXfPJT2wHrk2nsq2qHuGQyq+yO2zw
Date: Mon, 10 Jul 2023 01:54:14 +0000
Message-ID: <DM6PR12MB26197B684BAF112ACE9320FDE430A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230708022611.50512-1-mario.limonciello@amd.com>
 <20230708022611.50512-5-mario.limonciello@amd.com>
In-Reply-To: <20230708022611.50512-5-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=98b39db6-5858-445d-acd7-2fc581133e87;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-10T01:36:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SA1PR12MB5638:EE_
x-ms-office365-filtering-correlation-id: 50e80cad-5c49-41ea-15ea-08db80e89075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7mnWnJElrBsLWmeqGw+awDMfsguavC78z18v+nDU4lFM7VzYnS4/bBGKQSQV6S6AmM0HGkjuW6XUsw8sB77pYQ9R7aMlI0QI8y+IWWfhWa2DKFpLQRykYj1VOrzQu/zsASpGEsZcYFV/hJCaNkuT7UTwpTiIscrOq91O1SDin+IfWKXySZpXYizZSWGOUgbRh6ua+SJwSnqFlGndDV895f+H/ZNre4Bp/avQJz14Xjjv5D8gf8SLzyP1pax3sTpJwOZrRRYw5rAsXrhk7AfIe5nZSLeDQEoQoT+wVOEfxAatSlZcOeBd8JHQNvYBw7R/3rpQBtn7cwb7VVpQw0RI/ENOXBWsbo3CdztB11ma1wz1h9B+HlmI12Jdjb12BsQy2BYasBQp2484v2r/EKgkNh6ms119+9Y/++y7LTO6p+a3InBBnCeawuUJOvJvNSR0U+NXiEqDDY67RRGTX2DrRUNysyuM19YLx1nsRbLcdgNvs5Gqd48DSUuyIIRAAx45qOBmAbwjT6kmSLGBUxw30U6Dra/haFK1T0z4wEy1GLtej9cVG96pkBIRKgaieC3AWWXjglGCx9v6zS//Fc7lRTBp1CqTsyRQdu/ri5I93r2Ae4azO8CD/MX5AxyRe24
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(38100700002)(110136005)(7696005)(478600001)(76116006)(71200400001)(26005)(53546011)(186003)(9686003)(2906002)(41300700001)(64756008)(316002)(66476007)(66946007)(52536014)(5660300002)(8676002)(8936002)(122000001)(66556008)(66446008)(86362001)(33656002)(38070700005)(83380400001)(55016003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oM7omNfbeLK8s5H3waROSBqcT4gE1K0FTCAImzuze+7SxnNGn19oRKQ8gprh?=
 =?us-ascii?Q?bTxriA8DsbgsYPhZyL4RSWPPIXd+MVCmjCWeLE0SKmVpZRkZwe5T49KqHWuk?=
 =?us-ascii?Q?9fzFOe4Wm4Q2fOHKYvyQ7bKTjthNd57AtmKynUG7q6Qa0jvwor0ZKp5fvklx?=
 =?us-ascii?Q?IFnMAaheZIvHDqBeboPWNwgeOnWB0t7XJ84C1ShUlSoFBS1Iy1pIVxxpBBhU?=
 =?us-ascii?Q?UnrjBdfBhO5lMiGS1307ceEwXhmwLRe4ZJF09M72ee2rp+VPMh2niMb29fNi?=
 =?us-ascii?Q?WPTzspKivvEyVt8Z2xFRHC66Dwn5qC+WI9kkOviBmKApPntuF2T3wyNwI3Rq?=
 =?us-ascii?Q?6jKzXbjWetIyGX9cER6qPj1L5xOSQSDDjIh2IVj5n5OgiSg7Ryk3j+rI8QCo?=
 =?us-ascii?Q?hCSooRskLw+mvMLwx/rZlvH0x2SgnjEDdYC5lNc8wftMgy+PQBoduNbNfqhk?=
 =?us-ascii?Q?XHGAVzV7CTid1jjWKBjRfNHUOYauJphKvtQiuEwVuINojGgZ4wjpXIG2u9YJ?=
 =?us-ascii?Q?W0XCvLlWFfl1plI6rCNM+oku9axO1QzJb/x05QfSDY0E0Qr08faLz+4oosnn?=
 =?us-ascii?Q?g1GBcPH4tDfnEpRij/pdBiewgP47zT7ACeEKsUc4DseBnqLNMnGzsuhOvc5w?=
 =?us-ascii?Q?kZxFxzNOqJC6//iB0EkrI4VKqEl2ujxhoKDGGnHx83/WpRRw7m2ihmRIC37H?=
 =?us-ascii?Q?F5UV3rRdk+ZHLawKa3U77JHYCPM8f/cqIleSZ9Wghfr2oUx+0v+FjKSEcwZr?=
 =?us-ascii?Q?y4bVSG7KLk6+TxlzVkU3QLMJlGqp9G27faKkbgwa4gV+ctPpkhtas5bXQGd1?=
 =?us-ascii?Q?lN1RR245cIJCWyEVxjKqqvQxrIG6rRAAY+8t+Tr0TgNoxH+iBO8/nM3QyKHi?=
 =?us-ascii?Q?xrC5byDvODNfPeyhbYbg6hJejeh6EzUOSjVZVoc+8fyj+E2gIrPU9csNvoT4?=
 =?us-ascii?Q?c1iZPGIXHaWRWmwkvhXskZkHnosthFXaNGFJlwL/J49Iv174UhfV2Sav6eZg?=
 =?us-ascii?Q?5rvC5W4NVKRp2npV6kcpBsLkHOi6k6Pt2+zqECDv8Rv5nJKRKErAZ3R4DTmV?=
 =?us-ascii?Q?HODprYsyAA4L8674Kjc1QWaFAAl+M+Z1kQkWNrvKqH2mpYDGJYRaEYWoRoX8?=
 =?us-ascii?Q?BcyP+usYbebuvqNytZjKVuh2pWqYLo3QeGkFIkjevlZDm5PV5b7SwCVQoEz1?=
 =?us-ascii?Q?oFNp+GrmUjG5moJnMd/qCWd+2WqLSxgqxucI7keGjmrLUZu/Q2OAoUrgfR8p?=
 =?us-ascii?Q?m40oSmhoajn39KkzToIoUdl98HGnlW8vjF/UU80LnNa2kLVuegTPH4cPHuQp?=
 =?us-ascii?Q?k0LxcdK13/FZ7zpOfUOqSBd+vuJ+pCO/C88HGGQen/Enz+uPpDuCQfqGnicP?=
 =?us-ascii?Q?JGBZ2pD7rBMCTbPvjCJkfBIWNu4r0L8ccfm6ud7rUwp+sqHM17mnsA5S/GzU?=
 =?us-ascii?Q?hldZZ+0VSagv+iZ7Sr231u7lJ0H9NaS6FfnUgL5+iJG1zlvodwSfGdl3FuVL?=
 =?us-ascii?Q?FaNY7j+hRu0NozcWEICSS5+fd6T5rGfDbHa12MB2jw3qgfR6A/jFoe0GUYW5?=
 =?us-ascii?Q?1OYspzpRZKNVojQvcn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e80cad-5c49-41ea-15ea-08db80e89075
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 01:54:14.7265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1S8QofAiE2neq2KXhZhKBJ5aOX7lK2avc+ZdBoGhRiy4vvmk+bzPXN7Mp2tY7cZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
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

[AMD Official Use Only - General]

Patch1, 2, 3 are reviewed-by: Evan Quan <evan.quan@amd.com>

For patch4, it seems not quite right(at least for the naming).
Since although the ASPM is the prerequisite for pcie/lclk dpm features.
But the changes involved here are really for aspm feature disablement.
I mean even if pcie dynamic lane/speed switching is not supported, aspm fea=
ture can be still enabled.
So, using "amdgpu_device_pcie_dynamic_switching_supported" for the determin=
ation whether aspm feature can be enabled seems not proper.

Evan
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Saturday, July 8, 2023 10:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 4/4] drm/amd: Drop amdgpu_device_aspm_support_quirk()
>
> NV and VI currently set up a quirk to not enable ASPM on Alder Lake
> systems, but the issue appears to be tied to hosts without support
> for dynamic speed switching. Migrate both of these over to use
> amdgpu_device_pcie_dynamic_switching_supported() instead and drop
> amdgpu_device_aspm_support_quirk().
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 -----------
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  5 ++++-
>  4 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 813713f42d5e..6ecf42c4c970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1315,7 +1315,6 @@ int amdgpu_device_pci_reset(struct
> amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
>  bool amdgpu_device_pcie_dynamic_switching_supported(void);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> -bool amdgpu_device_aspm_support_quirk(void);
>
>  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64
> num_bytes,
>                                 u64 num_vis_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7314529553f6..a9e757f899f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1505,17 +1505,6 @@ bool amdgpu_device_should_use_aspm(struct
> amdgpu_device *adev)
>       return pcie_aspm_enabled(adev->pdev);
>  }
>
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
> -}
> -
>  /* if we get transitioned to only one device, take VGA back */
>  /**
>   * amdgpu_device_vga_set_decode - enable/disable vga decode
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 51523b27a186..71bc5b2f36cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -527,7 +527,10 @@ static int nv_set_vce_clocks(struct amdgpu_device
> *adev, u32 evclk, u32 ecclk)
>
>  static void nv_program_aspm(struct amdgpu_device *adev)
>  {
> -     if (!amdgpu_device_should_use_aspm(adev)
> || !amdgpu_device_aspm_support_quirk())
> +     if (!amdgpu_device_should_use_aspm(adev))
> +             return;
> +
> +     if (!amdgpu_device_pcie_dynamic_switching_supported())
>               return;
>
>       if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 6a8494f98d3e..f44c78e69b7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1124,7 +1124,10 @@ static void vi_program_aspm(struct
> amdgpu_device *adev)
>       bool bL1SS =3D false;
>       bool bClkReqSupport =3D true;
>
> -     if (!amdgpu_device_should_use_aspm(adev)
> || !amdgpu_device_aspm_support_quirk())
> +     if (!amdgpu_device_should_use_aspm(adev))
> +             return;
> +
> +     if (!amdgpu_device_pcie_dynamic_switching_supported())
>               return;
>
>       if (adev->flags & AMD_IS_APU ||
> --
> 2.34.1

