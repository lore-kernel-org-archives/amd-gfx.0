Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BD9C7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 08:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C5410E1C2;
	Mon, 12 Jun 2023 08:29:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B874C10E1C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 08:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb+vbvIw5lHkaubFz5/CEnlKCVGP9h6mW8QRUkAfw1imEoNWs+51Jgu1jRTE0l8hoRjQ6d8qOtQ9fNPJu2IOpggHrOSXtW8mlWjpX/pjgJEDjyse76zxa60uNHsk+cz63VgrItliG34hbDeJaxC2h2g5IezeE0CjLEM4Q6u50nFe6Ws5VH0ZXEb7dq4GpOXM50IK8USADOIo6XLK2q1UMkL770yyVPoulxVpyqNKLajKRa6Nc3ZlEw55p/2vMJ3GK0VXJkXe2qPCrcx0/6A4mLCTiP6fApSvEJtNFzHnWbNCB/pBLR5a6U4t48o9mdT9qIt/Ae85aoHTOLpURvRj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/V03F9cAZscABYdYgl+1SY6aVXWH7gft6Q84115yzY=;
 b=bD8DM0xIzIKzOZGuC+mGZxGmnczFn78wFU34DMooAtcEJZV7H7Dp4RPARYfq2SfiQatBQLWPVzKE15Wh4xgUndZOwJSGNrKI9lY17hQYIycHBN3p+UfRT9Mm72gGTFjZuJx+fzckJ/6uqPf7zGBC+AZjsQ4/q5R2tLuukJf3fmuU+wJ+NiZFFWW0WESAZ+ZJlUKb3t7+KYIdI1HOHwpdGK8RvIfo0c/eBtho2YOzZyQWANqcN6FxuaTSxKXm/8Nlrv47i+hGgdyAFTup2YJLdWO10FVpRktm2ktoeaAZLABF5TjjPKgAtpeP3hW46KYihDWG4aPL8bVCkocBdFkVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/V03F9cAZscABYdYgl+1SY6aVXWH7gft6Q84115yzY=;
 b=aKi0MNmMJQCZyivE3AuruXomRaT724dne6RHYSr8xaP+y8Nv7f0C6YrnNRhGw4OHQjCKF2rR7xIkprQQHXqIoWdcVNtfLMulsKA3lJl9WD8fuZJjAubNRXy/kG2Welbl+J9N9dFL0kkrbnYt6qUrn56OAl/YiAaGpo+J0bz6SXs=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 08:29:55 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::cc12:13d6:4667:64e]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::cc12:13d6:4667:64e%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 08:29:54 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
 supported
Thread-Index: AQHZnFH1YaUd2wsGC0qtjQnYmXtcOa+G1ozw
Date: Mon, 12 Jun 2023 08:29:54 +0000
Message-ID: <BL1PR12MB53345F9177FB21C89A44B4259A54A@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230611104546.7383-1-Hawking.Zhang@amd.com>
 <20230611104546.7383-2-Hawking.Zhang@amd.com>
In-Reply-To: <20230611104546.7383-2-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
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
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|IA1PR12MB8261:EE_
x-ms-office365-filtering-correlation-id: b91ba7e9-c859-4eca-ba3d-08db6b1f3304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldi/5InF1pit+CqJP2H1L1Z4JQHQuv2/u9vh+A+Ex0uZLKBsgDGjKqWA67jQntbcqmuT/B0HmPj0NSs7K64RsjlyokKQwIu5KCnSJskL80NP/3YKRM4nVwHCHQfP8Fxe+U1Y4TR9fEkSoD1wkOLT9noqJ3Zr3/ETDDUdBEUctx01w4jwcRVrlmpwKrew/rmHyeR6BIX7GMsrKcCxrvEB8NxaZj42V2YnfLD4ItBHskVvQfBTbMtfvSVdLPwUQwfCZ6KLQv3Zldg+gHhEBWJnrBWrO9HS9V8UnwQXL+lQi3NsaQm2JIDi1uxV3zIj3d2KZkwBA3ar7AHkp/SVOu40ofnYvAFngL/DJ+cAmcdmWtLaB0WudU+VAOS6XcB4fT0nMDcMO3N4TzXajLBr21DEZ3wxApFiC++WDrFc2/XTP1BL2wv0UbC+c4/HfArjjaQfo3bi+lfiSruVJof+8iGcB4j+v/UP7jq8TMWV0oET5JQAx/H5rU7q9eRKRSla1yu/gTTLpcffGeDaBqX3XkBdQYdXrlhtHJTYbB00TeGU5gjrSUcNuMJOiMpq5qKi3JI6qVwJKU64nr2CxuH09NFRZsHT5Y7RYhGkFw0tnuF15pp3H2zKf6mKtgLvDXQstJDX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(8936002)(8676002)(52536014)(5660300002)(76116006)(66946007)(64756008)(66556008)(6636002)(66476007)(66446008)(316002)(110136005)(2906002)(41300700001)(71200400001)(478600001)(7696005)(55016003)(9686003)(53546011)(6506007)(186003)(83380400001)(122000001)(33656002)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+b+98OjyxtXDrddFCTRR4u21vvDPiZ5kTu5YRxBd5KkFSN7p06LuXMydRgz?=
 =?us-ascii?Q?gHGCF/wKk03IH5E6C7aRm1WyepvMka7HCwaypnfNdXuqiDgP/i5ps4DRCDod?=
 =?us-ascii?Q?lfpZKC+qT/uQ+0h3TSyEvnxbnwQjJehsXpoVpfyq5jaRspwyArQvv90Yb7db?=
 =?us-ascii?Q?gWLycTNhwM2EpdavqfCc5QAJi+aupUKnqNTEQgG2cE98usXlGWzMg8lYIrjT?=
 =?us-ascii?Q?RwwKy9x1hMAOB6+x8jgdafyhsEEZPePVkffxtRy2PEcXM8VtzsQ68bGKdAid?=
 =?us-ascii?Q?VycAleKTiYqUGpZ+5K4x0Xjl4LIJBz+korgA/Clg8B8i8mROqfqPYfZAmLqK?=
 =?us-ascii?Q?MvlJw3hU4cU2NkE1dwuHsBvcMFimcgj0ZVyPnQb9tbZBF5zwFGITUNWjX/J5?=
 =?us-ascii?Q?Xe4FwC8cQT5fLTzbyB4lDgumaDfxcViGoGbn0VfAicvqrV+CQUYpsGyJK/f5?=
 =?us-ascii?Q?qy9BTIS2stFcBbUn5RvlXUGjqzHATM+bvszbHkFDXRwCfguL8JF8uIycETBK?=
 =?us-ascii?Q?iOKGzNuoNrsuLRO1JSVwTm0KVzxfhn5SpqeUm8GXRznkb9AW1IU037Xkfm3h?=
 =?us-ascii?Q?EJQ2yUSUmpzq86qXunqNN1EUSyyoSFrWNYGb5H7AedEnn6HvN57dm83/jSnz?=
 =?us-ascii?Q?ivm3IYHGS1RMpH9XGN5/JEv2AelIJa3JLzGCGQ2wu850NaK5qIhpFJvknx4q?=
 =?us-ascii?Q?Xk8986HqwwvGdOhoeSmskBLRlWjEvfXp9wXu5H5QlBDhjQ/Lv5kcLMtun4gm?=
 =?us-ascii?Q?1ezY28wDHpb083azV791H+hErMCeQ2v24nu1ZMKgArTH3BHUCIa/YSwfdZ8z?=
 =?us-ascii?Q?d6T6pz6Jo5LJbHIFfbKIRBa5diljpqGOBxSflRFESMtdBl9+7xpBNjoORL0n?=
 =?us-ascii?Q?EgMzflYyYkD/+pp2TR5p695uD0CZ+k2Ws6NclssMdhDA/vZ5KPRUUlS/+CaF?=
 =?us-ascii?Q?k/RHvJD0R/4TAVqGMQ6BOfIs6uRrMP9Qo4QG3zy2tPA/NN3NebM9KA84WEZE?=
 =?us-ascii?Q?EbS02TKyx2w6Eec+wtHIrvz1o7LCFnjqiroaQTYfJJoIrLRvPkXtJYlQ6c5W?=
 =?us-ascii?Q?hmUAhocTTW0+TEaIzEq9Ab79ar6ZjpCBIEeGCYxrQTt2dAFYtlL+T9rKd5kB?=
 =?us-ascii?Q?YkHhl0CtgsEjF0y8Eg1k0ol1LS01Ur+DiofJ3Mzwr3tN/y8hJcEVAlcrt5Yf?=
 =?us-ascii?Q?ACjpKohP+DxfShfg8qeLhvkXFH+OktFb7VdGpNTFASaVfDzkWcTKfstdMTsc?=
 =?us-ascii?Q?QaLvBfzTYccE/d4hb9Du+dBvE62iLUlRpaB+cMqV+/i2oEW/fHVEZe2ZXWs9?=
 =?us-ascii?Q?Y9zUI1WdFNt9h5M39deFvqa2xmth1wiiWs1FC/8htGLFf3J1Jajf0u1pzLZD?=
 =?us-ascii?Q?QSd7+30p9WAW+soFCCFpFvLv7sMCy6jmotdH7CMNCn0tYElLdTTk3kJ5eSb3?=
 =?us-ascii?Q?dveqj7ijjfqgFAmO2L0rs/Z4iAmO8+jic+WkQyKEvj6ex01YEGupLbPLnljx?=
 =?us-ascii?Q?1U3ANvQiqmlI1oVrpg5tovshKoEpawjdVrTx2kiKKRBbHeG9CH6LU1Uhzg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91ba7e9-c859-4eca-ba3d-08db6b1f3304
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:29:54.6620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAn7eORw9d0ikFdERt1OWTls385B1fcdlsDZRGHwhh5vP4GVelmJU+o8XYK+zRqCjiQgRuyXyRDFAQ+6gZzkzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, June 11, 2023 6:46 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>;
> Li, Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Enable gfx v11_0_3 ras if poison mode is
> supported
>
> GFX v11_0_3 ras needs to be enabled if poison mode is supported. Driver
> doesn't need issue an feature enable call in gfx_v11_0 late init phase. T=
he ras
> late init call is already centralized to amdgpu_ras_late_init.
> In addition, move poison_mode check out of common helper like
> amdgpu_ras_is_supported and amdgpu_ras_is_feature_allowed ensure only
> GFX RAS is enabled when poison mode is supported.
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
> @@ -126,6 +126,7 @@ static bool
> amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
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
>               adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__GFX);  }

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

