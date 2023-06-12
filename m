Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F81C7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 09:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5163110E0B5;
	Mon, 12 Jun 2023 09:49:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1477010E0B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 09:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV9qAUToeicheAs65Ae2TYZjZ6medVtPumjJ+Pf3232LiO5IZ3IbTd39btK3ywg5Z/QWSe1jLKIiANf1PRzjo+1ABSt6I1a/JQD27nT5x4sJoKUe6ejbxOONsrQIW6xRuyaxeja9LXNkPA+JoSgqTgJAK4RBlsCjccZwY9QaoyFA2iEuAavArjUjvTwupRTPcXPObyJVEoIgT7St4r6fiG8D4tlTK39aSHT5enaHgYCa3jTA2ZS1W0gL4paA7WSaYXmy+lCqW061/Ke7V1BdphawlyeckuDzmBoH9N5o4cDsRXAkMZzoQoBTaPtk4YAQr+aK3mYpwWfoZTTNBiBnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDtATfBgQwAn4+wiTjco3PvoLJNm6KrNcUuXzxCOYp8=;
 b=mhih76tR5IYM2CpzSs4AhtMxNX/wp+O6/6KUjXaLzZ+gjBPbrTGhh9BXNYDo9qe2KvGh/cY4JNeaaSzowju6y7YWAhr+pphMq4I1mT5nWm8pgxtx8mkjkb35fybyvgiEWLSJz1hWsKeV4Dutpju2H+23JXqkPZekcxv53aoPcvPeYkdzmDMp/ZU1wMJipoBzVQfA5C63XjJ2eLpdEv+6DFz+kYHmSWFY4XIewwQqTQ8jRnxzkMziK1owWMqpxlslhzQxR2kKffZkhyNkyRZucYYLoPHb3Z6lSBN/g8GoNcg4LYF4JoGd4jtwistZ3ExU1PebL3kA6fXvF32DUiSHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDtATfBgQwAn4+wiTjco3PvoLJNm6KrNcUuXzxCOYp8=;
 b=ypBAXFmfQLaRFw2okWYHLC+m2tj5DRHN2arvIJ4al1XO8f8ZPVvDbIUTM7Z+mIhQ0d/o7ej/ReeiVfolWBPgdV1X7AqfsZtztHABo/RX7EcdIskNlc6fbOX9jFVJPo6JALzybxmvLU6ennLTHmBwKGs2ZO7HeSftagjWmkDBlZA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 09:49:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 09:49:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Thread-Index: AQHZnFH1dRF0Ls4VxUKwI7ZXJmGXp6+G13wAgAAVLIA=
Date: Mon, 12 Jun 2023 09:49:02 +0000
Message-ID: <BN9PR12MB5257745FABDF134FD5C7D9E8FC54A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230611104546.7383-1-Hawking.Zhang@amd.com>
 <20230611104546.7383-2-Hawking.Zhang@amd.com>
 <BL1PR12MB53345F9177FB21C89A44B4259A54A@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53345F9177FB21C89A44B4259A54A@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=238cc4df-8fcc-4703-aa18-7d6e987220c4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T08:26:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8510:EE_
x-ms-office365-filtering-correlation-id: bb3d7c8a-274f-46da-fe67-08db6b2a40c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axuh7eiEN0dfKV/a6GxemNtZf73cSH422w6Sgi1Zyz9ncd/NmFAVJsMzwCxP6K6vAmPo5Woqna8vZKTmkRAWIOw0C1jn88EhMqr+k1u+9j9PB3UdK7QVnOpWtYNOZnS7SzkEh3LqlQ9Z8Z9gnzfhTfRYyGa+3/tIcYSdHBcaufwBLbHdoRmIczhh2tBQWHCNQXYef5VeEYllg+o2hODzS5mplviBvJset2QcGDoJh90wtMxjGnWwIfbD+oyTlk5EECUCbags4iPdQX6AxE+KAbSN5s5/5UjaanVVqNk9hrXfE/GD4D10+TQfMYaLjyHv1MYz/uvGx9vsGdTLA2+h2CDJ1OdJ5OptgwRn6Vw49OWqjDTlbXKeo1vucpN2UN84SHfo5l7lhM3iuWiWSgvBL1aH/+wd387h5ZoKVAxdWEAMEXFKGEzyAkW82dUjR0LxFa4chlVTHj09SfXRLI8Qy/6ztnNwlw03+0eGOcOlyP/adTqT7RYGTRm/v+kaY8SU/GNZDDDB6vQITzZrqocE7nqnDPtFLTD39kBRovl7F9UDcay/mIe5Xq5sKiTajvqMaTy2TIqBjeaej1TGTlmbQkOwV/JL0ntFJjiXRvY3CzGLSWF5C6q6YZeOaZ70riD8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(83380400001)(33656002)(38100700002)(86362001)(122000001)(38070700005)(55016003)(478600001)(110136005)(71200400001)(7696005)(8936002)(8676002)(2906002)(5660300002)(52536014)(66556008)(66946007)(64756008)(66476007)(66446008)(76116006)(6636002)(41300700001)(316002)(53546011)(186003)(66899021)(6506007)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0jjC66NjnbpNZ6fFNzzx+JPZMh+jk9wvDn+9fqnYa41vsk+NH5pbRWRNr6ls?=
 =?us-ascii?Q?Ydvz1ToELAYF6kc7JxSnFOMIQAb9q34yRSwQcx5NjkIsxRpcAGNpMN5znstT?=
 =?us-ascii?Q?tAGocwQGPL/vJGbZJt4ovnBXKKkVZiRNkw7ygnguDK06rmyJRayinXRCqHLq?=
 =?us-ascii?Q?EQ5P7d0XxOoWXMtzJhN8LrZJSCtMn3USGz3bm2MiZYZ4Vr3wcAvgnyqqlzYn?=
 =?us-ascii?Q?t8+bZQ8nLGXvkGgkIb3qEs/lWRS3/IxStnnbkOIoQAWabBI6aVc99sNSjc5E?=
 =?us-ascii?Q?Mfc7GCwYTWK92WLHr4ObCES+S8S6SqTgMTlwD/TvtnPRj8mvS2PJjzDJwajE?=
 =?us-ascii?Q?HMbsOdSlnPUCPt1uyN5BFYAMj9lx+fLrvHWnd900PMZgS+oB8OyYgyS6JPKa?=
 =?us-ascii?Q?vNZgj0/rJjaC0Ya8x6IuwlbE4DlI4UkUc0TGp7e7bDmGKIaKbp9ihLoQ2Zad?=
 =?us-ascii?Q?nnzf+9OEC6sWrDRG9zcu66MoTgu5/sQs3WvEQezIKybVeblPm4/JycrLUk98?=
 =?us-ascii?Q?TACiSd+Zm5JkL82vDUwcVoaJt+zflMXFd/hyynLDjpjdIFtjQyM3yf0FGsRs?=
 =?us-ascii?Q?NquqAF1cgo0h9+MOyd3mK9FwPFiciL+RfsK2hDral5j145ibOJgnEx5pr4x4?=
 =?us-ascii?Q?vbYFiwtSDHfObqaHYg24keGfG+BOlbwxL/L3cPWoOyYZwBX2WfQRLU7ASE3D?=
 =?us-ascii?Q?0dn4Q8B0g9r2MeQArBTmDum61SrW26C9mzldsMVmDf/Py8FXjW7ZTGzpkmGZ?=
 =?us-ascii?Q?dDTg3EhP2w5xxuAkhrXlhXWpOYnmzldw+1H+RL//8VdlOQOcBtxj8Znx575/?=
 =?us-ascii?Q?xO+9HUIrA9xDqy82Oc/PjyQ8FMalmfL/ejv4ZfuFL3VfoGiT8flQ7tGIUB5Y?=
 =?us-ascii?Q?Ck+NeiF9AmaM/nc34LmAnAHog5saSIEoBhyWjciiTCqQR1vuYNc0HnWS2QKN?=
 =?us-ascii?Q?Yaj870RB9nFQ7w2dCjiT1LGBUlG7NqFAtbQfXwRNxeSTFSiYEEveCthygq9A?=
 =?us-ascii?Q?XnZHRnOc5nGNTn0EV7uEQfPwI3vHJdJ3dkXEVjdIPFvH3syqNZ4wdqnO+2Uy?=
 =?us-ascii?Q?aO9qQuoNKyT0wXYh+Sg2d2NbLmJ001thdvl5aaUl2YjpXGOlOujJ+5MtocoI?=
 =?us-ascii?Q?DnRdeNgDD4SgGv60tUZLiVFwBFPSHhaw3Fzvi2zCAlOn7h9mXDvLkjS8Ct93?=
 =?us-ascii?Q?kaQoKeegmnJ9u7IEn5AOlGOyjz3GGU6i+WzhJQLx/vSDd9tgwvOpYg6TcLy6?=
 =?us-ascii?Q?pTu2G1Ua1XhlU42U7/DVhm3P8/5VChJkoP7iWtljlsIiHfFK6Y6F0XYXXxvy?=
 =?us-ascii?Q?LxPa/VVu9yiff6EAQD4ujQxqoJYvO3YUZJHu1PPv6Qc1nk9HdIhTQpOI+gce?=
 =?us-ascii?Q?7efwCvfUoyijrZriURgl32fNUXyffYsbgSj4+UAiBiqeFe2rRjWGCQIRDw0S?=
 =?us-ascii?Q?SEp1jchsY2dwdAgeA4oE0KSZA5gTjdlupIPKl7a7RkiAIB8FwKavPmUjfDJ4?=
 =?us-ascii?Q?MzdH7GzARs2DXDvDf5LWKrPF8LkuhUdwpxybDEsohfdS9cz4pnkG+42ly6xF?=
 =?us-ascii?Q?lBCpAoPL3Da4MngWRMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3d7c8a-274f-46da-fe67-08db6b2a40c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 09:49:02.2579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HW2CClIfeyvjQVVKOGVSwL4bN32hV3q0dAr38qnZaY7MHoqkAO67jffu7KcMmi/xgyImCYGEq0Jg19ve5UGmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

Good point. gfx v11_0_3 doesn't support sram ecc. We should *not* let KFD r=
eport SRAMEDC cap to user mode - it will result to wrong shader compiler wi=
th ecc enabled for gfx v11_0_3.

I'm leaning toward creating per IP feature matrix to deal with the cases th=
at hardware just supports partial RAS features. Let me think about it more =
and get back to you.

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Monday, June 12, 2023 16:30
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Li, Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1=
, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode =
is supported

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, June 11, 2023 6:46 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley
> <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode
> is supported
>
> GFX v11_0_3 ras needs to be enabled if poison mode is supported.
> Driver doesn't need issue an feature enable call in gfx_v11_0 late
> init phase. The ras late init call is already centralized to amdgpu_ras_l=
ate_init.
> In addition, move poison_mode check out of common helper like
> amdgpu_ras_is_supported and amdgpu_ras_is_feature_allowed ensure only
> GFX RAS is enabled when poison mode is supported.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 49
> ++++++++----------------- drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 26
> -------------
>  2 files changed, 16 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index dd7cdc234d7e..35e70860d628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -126,6 +126,7 @@ static bool
> amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
>                               uint64_t addr);  static bool
> amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
>                               uint64_t addr);
> +static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev);
>  #ifdef CONFIG_X86_MCE_AMD
>  static void amdgpu_register_bad_pages_mca_notifier(struct
> amdgpu_device *adev);  struct mce_notifier_adev_list { @@ -757,16
> +758,6 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *ad=
ev,
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
>               struct ras_common_if *head, bool enable) @@ -797,7
> +788,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>       }
>
>       /* Do not enable if it is not allowed. */
> -     if (enable && !amdgpu_ras_check_feature_allowed(adev, head))
> +     if (enable && !amdgpu_ras_is_feature_allowed(adev, head))
>               goto out;
>
>       /* Only enable ras feature operation handle on host side */ @@ -
> 2420,9 +2411,9 @@ static bool amdgpu_ras_asic_supported(struct
> amdgpu_device *adev)  }
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
> 2431,10 +2422,16 @@ static void amdgpu_ras_get_quirks(struct
> amdgpu_device *adev)
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
> +             adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__GFX);
> +
> +     /* Enable gfx ras on gfx_v11_0_3 if poison mode is supported */
> +     if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3) &&
> +         amdgpu_ras_is_poison_mode_supported(adev))
>               adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__GFX);  }

[Stanley]: For GC 11.0.3, it's better not expose AMDGPU_RAS_BLOCK__GFX to k=
fd, may be with below is more reasonable.
{
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 8e4124dcb6e4..84030289ac96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1996,9 +1996,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
        }

        /* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
-       dev->node_props.capability |=3D
-               ((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX))=
 !=3D 0) ?
-               HSA_CAP_SRAM_EDCSUPPORTED : 0;
+       if (KFD_GC_VERSION(dev->gpu) !=3D IP_VERSION(11, 0, 3))
+               dev->node_props.capability |=3D
+                       ((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOC=
K__GFX)) !=3D 0) ?
+                       HSA_CAP_SRAM_EDCSUPPORTED : 0;
        dev->node_props.capability |=3D
                ((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC))=
 !=3D 0) ?
                HSA_CAP_MEM_EDCSUPPORTED : 0;
--
}

Regards,
Stanley
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
> @@ -3115,26 +3112,12 @@ int amdgpu_ras_set_context(struct
> amdgpu_device *adev, struct amdgpu_ras *ras_co  int
> amdgpu_ras_is_supported(struct amdgpu_device *adev,
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
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; @@
> -
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


