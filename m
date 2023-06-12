Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7172BC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 06:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD35D10E15B;
	Mon, 12 Jun 2023 06:23:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A96610E15B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 06:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm28KutQ0+eLbdd6tdKdj+05NCn+d5NnufMH124S8RhZhJDiMqi/JIAR/qs6nRnT7RAzZjJRE8Li5JOiejjUZbHPcHoPm3XhbOrXpP5OWbxe4frJCdeJmMvowmW2o1bLBNeLcPH3+elpv1RgEl02AKF47WV3MVOYcA+7RlUMD3q7wLjFKhbvB96fq8P4HTQReSrCt8xfHoVSdyZO90VhPo0yHW6Y50QkV6lFn1/u2/TjN4QtETZcggYhrusOq1BS+MpUzduSQAfOD8K5x6cPN90DgG2WOqFD5bv8qS8kMw2fQHnexDpiTVOmUPal2W0ZJpNjR4Jom0sRJa04GXVJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3lYoy3HtABJ3i3RiRyeF2J+771SuNiffrwkLucvdzo=;
 b=jVXqBMix1n5YVPvv0FHpUgjoW0DFP7opzCSR3QaNmf/D6koXfUetIRGrrkVeoDf8PJPPhyIshczNIlBblfcJfOg8L86toHEWDusjNNJElLf20tlNp7caHe/DEU/LIL9bYBG2w7vDiwrsL/pKKAnUiBlJV9ZCkG1dhghcUThvl4/D3Td9HgKPKPtbmdpzM4n9Yr9em/2lgAXtY9BPXtxoDxXtp05dqH3E+DGUZVSGdQbaWAPJXWGJxYENlS+HwZiYul3Vu540z6lRwhnDHsl8zJJZ0HrX5Hds0R9diGWAB/Ec1F9dqOK5WqcoEI4m426IBHgj4eEfoZPbbJv4ROFI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3lYoy3HtABJ3i3RiRyeF2J+771SuNiffrwkLucvdzo=;
 b=nLT+ODuYLcCnk/Q7ncEZUv8+Ds+y+OTYHxGgVjEzwB2oKQ6lF9T7vi3Kx3gVtHdACMS8ElaeRg66WJ/wJsJnc4HfzoIu9cwsN/V5rUIM6zAFJFJzjG4ouK1WSXeuXUaDoVdg+PpA4Y5/bNjCVHQd/+fWGRfZaZjOTpt4nhcHiik=
Received: from IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 06:23:16 +0000
Received: from IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69]) by IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69%7]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 06:23:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Thread-Index: AQHZnFH1juJR7TxlvEuAaiEMsezNJa+GtA6w
Date: Mon, 12 Jun 2023 06:23:16 +0000
Message-ID: <IA0PR12MB8981C03566CB55F013B5CF5FB054A@IA0PR12MB8981.namprd12.prod.outlook.com>
References: <20230611104546.7383-1-Hawking.Zhang@amd.com>
 <20230611104546.7383-2-Hawking.Zhang@amd.com>
In-Reply-To: <20230611104546.7383-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=04d08222-5f86-40c9-8285-7a12d510ab86;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T06:23:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8981:EE_|DM4PR12MB6421:EE_
x-ms-office365-filtering-correlation-id: c8cc1193-cfb5-45c1-ab2e-08db6b0d8207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksfXQdmjHsOSMoZy0tY2q8X5TaWU/gI+1RkObNazbwD3ile5fqrsg0zeQBhTZx2lz8Lj7JI1B3xl9VJ+kUetsqfkTA0EA/BkhuGL8peG93SgRiO5DmaweYGeoOoDShOBqINXg3Xa1r1xTenoZEnG/Fwq9XyIeuj03NW1YprS0dDgzhb4i8yU2j5Oj2dNZctjxgdIJR0Cv1IHNr1CGSWgXMZC/AU0AZgyLIbJgnwO8U/6b/3v3fXi9q4lzKBkV9oPHq1Ye6Y7+xhTQMgcQymMLgXwzxzB9PDYsUA7N1RatSujvNYmti7wkYL8Yf7v8vjRre+Vt8CPcQ6N4CQenGEFH1fWJECyYgv3WR5me6IkY/R+2qNSzzFpdOqeZvDtz2YamH76vN1uzxTG/YajwEDj7fHDlAA65vCUY+SWSMs2WdpE2LT0mOHaxFg+8lWE7Dq35mDIXYCgiB/f4Ju74gM3bWm/RSBFr562Nssytiqvliw8CdAheA65yDJDhgTD7JG9xPHJkXF/gIPFViZgGrWcT0jRGR3jTVpMJ4250PTAFQ7dzuOxXhAjhUyL+G2IcDHIifQxW/oYSqRFum8I+5d6kwoF59WPqo8Ir1iY2aw3MRo5+Y5RoCLIelym5zyvvA+5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8981.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(316002)(7696005)(41300700001)(83380400001)(86362001)(53546011)(38070700005)(9686003)(6506007)(26005)(186003)(2906002)(33656002)(122000001)(38100700002)(55016003)(8676002)(52536014)(5660300002)(8936002)(76116006)(66556008)(66476007)(66946007)(478600001)(110136005)(71200400001)(6636002)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ENMRSTIaAnvpC8Uu7Hr7K7ui2WVen/z3p3R9gW9HveEQW1yHxcnpfo21/84K?=
 =?us-ascii?Q?4Dq9FXQTfYostKgoXRSr75dkJ8SDqo1jeivti2aTgGAaj/ONg3b3M+/R7OSJ?=
 =?us-ascii?Q?Tb4kocAh06WpyjLwAR2pP8N+y6dB5XuXmkDXK2Y+dEWNsmz/a10GYrdKd7i6?=
 =?us-ascii?Q?x5Ltp/+l+Mc18hQFWxhdoQHlo2Xbps9/kyZ9hVdtWFyiviXrQQpk58u3BPNr?=
 =?us-ascii?Q?cScaga2kTr/dsHvmwKvEUWBXU5FPAfGG4ezM3gPQbRbZNGRsXKqeZs9FcD8w?=
 =?us-ascii?Q?r6sx8f87DYqR+aC7f/FWhXFgLDgSgsl1PBusCxVDFSWO1pWyR2iyJw4kW8fc?=
 =?us-ascii?Q?rBrlcZVp3HfUNNUkiP4w4SobWNoRpE81TY1wSCFEyp7Ej6oemXMW5V9u1tVy?=
 =?us-ascii?Q?YdUYrv0vyehmab+01QuK0aP285T0MGZpTS4bwaPbFeceP/h1B4vTrC23lzLB?=
 =?us-ascii?Q?83z7V7bng2uA8Z8qD9dt+kFL8ApS+RN6QkzNhcQKx8JNFydbVrluWbfPbxh2?=
 =?us-ascii?Q?UjzAqvDnaHBcdBjfsfdytzxV+XjnlB1F4gh81o+RtYD93h3AJo4x3Pa3OIA3?=
 =?us-ascii?Q?WZL/RjrgQ/ygIgx3bfrOHmrt2WttvHw5ottap2Vb1XrG2FpsnO6X56Bk2kl8?=
 =?us-ascii?Q?og+XG61tACqm6RJR5mQSy2sQMAkX1CJ2mwsdK1aEM379gCYEnb+k/0LJdtfm?=
 =?us-ascii?Q?WDleDD0rxzItO1xvNNViCv95N7Ij9rjMb6U+R+CwbqYDvBVVRheamRW1pjaM?=
 =?us-ascii?Q?yq5aeXyigRlJLemsoWnTCJ0Ow64C2dqucOCjPZgMurrrtd75jZzJzDGY52dm?=
 =?us-ascii?Q?jkI+SDsDDfOdYVHqN9T04sDhsDQ5qEB2y1iMsxCFD/LGtILygrks22oyaMHH?=
 =?us-ascii?Q?dRlgHWQ8yTd8nfQgQM03zJ9kuApUOCxix1q8EV61EFRMlVLOeKTms3CJ+zd1?=
 =?us-ascii?Q?yl3smaTVVR3tUsKTE/2hcftiw0U7BtSgbyeEzV7YacxK5OevxNEfHTjbZO00?=
 =?us-ascii?Q?xZDRF5qSTPgtyMZl5fMwa2CFhObcphMphIkfWkM/hRGJByXFMfDdGUOkuAIs?=
 =?us-ascii?Q?5LdCa+yhV+cIKxSSTjYpe4LlbkdvORYaLdC5zQOq9oGYkrd9nyS5z28aZ/B1?=
 =?us-ascii?Q?ljuO1oj2eeMKoT/xGcRFiX+HhBHFw5PLidifbBFuxEiwSp7Bk8O4ZzSB5SFA?=
 =?us-ascii?Q?0jXBEXWnHA4vxWeeEzJacFvzcylktW+7EwW0FXqJ6r5Sb1Gdb+EnzFR+EXwO?=
 =?us-ascii?Q?Q/weL86lPxPNx1HfsrGtTyZcBBR6wANKxqEQmyvbsRa+oU3RMAwPakApkhXF?=
 =?us-ascii?Q?dRVLmYlToBJ0V90bggRmK4EddWTFQRZuiKnK9E3kPE0Hq1ucjYmk0h27uMYN?=
 =?us-ascii?Q?rOBKcJY3BhnnhFvvgWWL4AyTTVJuyFccSEbGboxjnujXSG53F7+Qfg5Z7wE7?=
 =?us-ascii?Q?XUUJSrs5id4Yfs64NUARK7QREWbhl0QSBarKyLRZLL7LjZ0lZvXmmMz0HHX4?=
 =?us-ascii?Q?AUuWeb67mydiTUMQU2bNSqk5bejnu/yMlBmF1J08MyKnxsBs3vcPI8rattoq?=
 =?us-ascii?Q?N4ioHCxH+pIJVQ+q7LM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8981.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cc1193-cfb5-45c1-ab2e-08db6b0d8207
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 06:23:16.2962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlqfcjrFsz4QojnxrRjKqE107+u9/BxSSLHRkHuzq2vXx/7IAkBdumk7fvSW5F+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, June 11, 2023 6:46 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; =
Li,
> Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
> supported
>
> GFX v11_0_3 ras needs to be enabled if poison mode is supported. Driver d=
oesn't
> need issue an feature enable call in gfx_v11_0 late init phase. The ras l=
ate init call
> is already centralized to amdgpu_ras_late_init.
> In addition, move poison_mode check out of common helper like
> amdgpu_ras_is_supported and amdgpu_ras_is_feature_allowed ensure only GFX
> RAS is enabled when poison mode is supported.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 49 ++++++++-----------------
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 26 -------------
>  2 files changed, 16 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index dd7cdc234d7e..35e70860d628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -126,6 +126,7 @@ static bool amdgpu_ras_check_bad_page_unlock(struct
> amdgpu_ras *con,
>                               uint64_t addr);
>  static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
>                               uint64_t addr);
> +static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev);
>  #ifdef CONFIG_X86_MCE_AMD
>  static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device
> *adev);  struct mce_notifier_adev_list { @@ -757,16 +758,6 @@ static int
> __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>       return 0;
>  }
>
> -static int amdgpu_ras_check_feature_allowed(struct amdgpu_device *adev,
> -             struct ras_common_if *head)
> -{
> -     if (amdgpu_ras_is_feature_allowed(adev, head) ||
> -             amdgpu_ras_is_poison_mode_supported(adev))
> -             return 1;
> -     else
> -             return 0;
> -}
> -
>  /* wrapper of psp_ras_enable_features */  int
> amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>               struct ras_common_if *head, bool enable) @@ -797,7 +788,7
> @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>       }
>
>       /* Do not enable if it is not allowed. */
> -     if (enable && !amdgpu_ras_check_feature_allowed(adev, head))
> +     if (enable && !amdgpu_ras_is_feature_allowed(adev, head))
>               goto out;
>
>       /* Only enable ras feature operation handle on host side */ @@ -242=
0,9
> +2411,9 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device
> *adev)  }
>
>  /*
> - * this is workaround for vega20 workstation sku,
> - * force enable gfx ras, ignore vbios gfx ras flag
> - * due to GC EDC can not write
> + * Common helpers for device or IP specific RAS quirks including
> + * a). Enable gfx ras on D16406 or D36002 board
> + * b). Enable gfx ras in gfx_v11_0_3 if poison mode is supported
>   */
>  static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)  { @@ -
> 2431,10 +2422,16 @@ static void amdgpu_ras_get_quirks(struct amdgpu_devic=
e
> *adev)
>       if (!ctx)
>               return;
>
> +     /* Enable gfx ras on specific board */
>       if (strnstr(ctx->vbios_version, "D16406",
>                   sizeof(ctx->vbios_version)) ||
> -             strnstr(ctx->vbios_version, "D36002",
> -                     sizeof(ctx->vbios_version)))
> +         strnstr(ctx->vbios_version, "D36002",
> +                 sizeof(ctx->vbios_version)))
> +             adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__GFX);
> +
> +     /* Enable gfx ras on gfx_v11_0_3 if poison mode is supported */
> +     if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3) &&
> +         amdgpu_ras_is_poison_mode_supported(adev))
>               adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__GFX);  }
>
> @@ -2502,6 +2499,8 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>                                          1 <<
> AMDGPU_RAS_BLOCK__MMHUB);
>       }
>
> +     amdgpu_ras_query_poison_mode(adev);
> +
>       amdgpu_ras_get_quirks(adev);
>
>       /* hw_supported needs to be aligned with RAS block mask. */ @@ -
> 2659,8 +2658,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>                       goto release_con;
>       }
>
> -     amdgpu_ras_query_poison_mode(adev);
> -
>       if (amdgpu_ras_fs_init(adev)) {
>               r =3D -EINVAL;
>               goto release_con;
> @@ -3115,26 +3112,12 @@ int amdgpu_ras_set_context(struct amdgpu_device
> *adev, struct amdgpu_ras *ras_co  int amdgpu_ras_is_supported(struct
> amdgpu_device *adev,
>               unsigned int block)
>  {
> -     int ret =3D 0;
>       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
>       if (block >=3D AMDGPU_RAS_BLOCK_COUNT)
>               return 0;
>
> -     ret =3D ras && (adev->ras_enabled & (1 << block));
> -
> -     /* For the special asic with mem ecc enabled but sram ecc
> -      * not enabled, even if the ras block is not supported on
> -      * .ras_enabled, if the asic supports poison mode and the
> -      * ras block has ras configuration, it can be considered
> -      * that the ras block supports ras function.
> -      */
> -     if (!ret &&
> -         amdgpu_ras_is_poison_mode_supported(adev) &&
> -         amdgpu_ras_get_ras_block(adev, block, 0))
> -             ret =3D 1;
> -
> -     return ret;
> +     return (ras && (adev->ras_enabled & (1 << block)));
>  }
>
>  int amdgpu_ras_reset_gpu(struct amdgpu_device *adev) diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 690e121d9dda..11e0c574b9f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4650,26 +4650,6 @@ static int gfx_v11_0_early_init(void *handle)
>       return gfx_v11_0_init_microcode(adev);  }
>
> -static int gfx_v11_0_ras_late_init(void *handle) -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -     struct ras_common_if *gfx_common_if;
> -     int ret;
> -
> -     gfx_common_if =3D kzalloc(sizeof(struct ras_common_if), GFP_KERNEL)=
;
> -     if (!gfx_common_if)
> -             return -ENOMEM;
> -
> -     gfx_common_if->block =3D AMDGPU_RAS_BLOCK__GFX;
> -
> -     ret =3D amdgpu_ras_feature_enable(adev, gfx_common_if, true);
> -     if (ret)
> -             dev_warn(adev->dev, "Failed to enable gfx11 ras feature\n")=
;
> -
> -     kfree(gfx_common_if);
> -     return 0;
> -}
> -
>  static int gfx_v11_0_late_init(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; @@ -
> 4683,12 +4663,6 @@ static int gfx_v11_0_late_init(void *handle)
>       if (r)
>               return r;
>
> -     if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3)) {
> -             r =3D gfx_v11_0_ras_late_init(handle);
> -             if (r)
> -                     return r;
> -     }
> -
>       return 0;
>  }
>
> --
> 2.17.1

