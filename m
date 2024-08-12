Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F1AC52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 06:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B756B10E0D4;
	Mon, 12 Aug 2024 06:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvX5TSz5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9CB10E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 06:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TawCNeTEUaaoQ+cpTq5uPZOFwM0s7g7X0ItrzqGns8ZnykjlrHfD27GBdZV9PoIppOokH1JGYASyk2BKK86UmZ0PyBO1aExzlv/GrBCorn8tR0HciKNZXH6rlpbv0qy0EcOV9V3zymbM5IOIlmnB6lA+4wNSUWCFplMfy2MLPcjjIC6pbBFA9pXD3uphlRvsLmQdpPw2+Bidri/vsc8soeulLdNh6NmU2iM5n+yoSIkjk2YNKr8PUqEhkP5orIVq7XL8rjMq45an200MRNQ/BnBGqAsK++tww1cK2RHo0mw2sOwzKQ3Rh4XX2g4yr//t0/M4zcCzdJRf/UXXZXIRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3aUO/ZKMykoBMBcIJ+bKlvjSb2aEPmjEX406vzBHUY=;
 b=RtBxBnyKjLk0w7wRANJYCPiI7qfu18bBytCmd7BYDdr+8Y/wRc61drD1BAFVjr2+q5dMCsGiX1/Ukt5GNA+fjfBLjo+L1kyYl6rGB3Ll2ppoPgw/qVNX9XsqQxS4Mu1U0bvSy2pW9gCvd7CQzriFxNCZgG351L9AORnazukXUCCqOWyUfAaJXG8gSgmT+p8kQR2LMfWYCEmcfe5qfGV40Gc9jc2omO/TdBN967wO4N16qXb9kSkg7BkkfB1eYvG+RPtr/s78nzE5/EN9VwRWAPzp5UHY+6LcPhf9OeJluSPuOlsjyj8o8pUz8wKUjs3e6rnQVXZ+Ive+Eqs7ZOdeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3aUO/ZKMykoBMBcIJ+bKlvjSb2aEPmjEX406vzBHUY=;
 b=cvX5TSz5XEGHeGZ7pq5EF9ztZaXgJauk8hdyCIhOpQsgmyhYUsPxgUNs1IMuWCRhteGPDJ1HUzfsM8FZpWd70U0ZKlV4PHjxCLDGnurdhJ1S5XIjX0kIaYesMFiQHGo2J2vAVfKc4MDN9KXrolLB6DrEZcAiudgqnbOCR29yotQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 06:03:58 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.7849.015; Mon, 12 Aug 2024
 06:03:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Thread-Topic: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Thread-Index: AQHa7GdXCtBfTYGl40eD2/Rp0iTj5rIjIgNg
Date: Mon, 12 Aug 2024 06:03:58 +0000
Message-ID: <PH7PR12MB87962F13743F088E3572C0A4B0852@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240812032546.8006-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240812032546.8006-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ebb3a781-3367-4b10-aa34-8c2f250da1f8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T06:03:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB6068:EE_
x-ms-office365-filtering-correlation-id: 9a82ef23-6445-4141-cfe7-08dcba948e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Eu70oN7tjybEOgravipWrnj91NX/so0nASspZ89F7dKUjDdwAhO6H+U5/Koh?=
 =?us-ascii?Q?li02E/na4c7W72jItBtQugtpsIG3JDnAG3WsHbKJgCoKesiJUt4ZuzGdIQFX?=
 =?us-ascii?Q?xnLocHcDCqFG9Q/u6X0OwuqNfhMxEFqmqywr6w5FpFTTNsyokC4Fb6tuitgK?=
 =?us-ascii?Q?8+wpICS64a+vBZOlive/8GT2ITkg+Tsi4VR3WXzc/P/8zgPcZBSvRIi+ToHn?=
 =?us-ascii?Q?QL2aD9iiqGLJRet04RnJ/0rj00kQ/0bCKIzAfYUD5dH+yL/13TvFKCTeK0K6?=
 =?us-ascii?Q?Y7Rr0oACdsaFWNoSVhObN2i6lxmrtVvDCjPNn+6ABJQ+jKA8s8CuLzd7uxRg?=
 =?us-ascii?Q?kUaqBm25AfDDrBLWYL5N5lthtXFlFaS2DVUOwi2KmHnfUvsyhyaL4vvRFLry?=
 =?us-ascii?Q?XSc3m3PL6APboE4MFhHA88+bSnK84biQYN6X4NZb/b9lJTuDv2dOMl6j1qin?=
 =?us-ascii?Q?1lblgY0ruH59w7g7CTdfrug5rV/sWnch2mqfBYcXSGVbIb+zyIlkmsyrszEb?=
 =?us-ascii?Q?H+tYufL1ZCzqPvmq5bXUCsY93ySELxmkF5JxCPnEPoTWcdLwAWIcgxeHjHYN?=
 =?us-ascii?Q?+2mfFnts0HEnvmbJVSnatqYyEqBH1+Zly2G8BOe7vJ81Aj0GyDSyC/8Covy8?=
 =?us-ascii?Q?6TQEWdvFfBgMHxYcQfa7m+JrCJIr3aV8pAqXR+ad9djbjfVchYqzHZGWow6h?=
 =?us-ascii?Q?XUFuf2V7ZeSsCnhWXYxzpnWXwJtKcWgnvtmdFdDjg54oAjH8BHmmojGkx6X3?=
 =?us-ascii?Q?LvnjbmNsIEJ7YLSLqapVX/gP531gOa8ptbjXYfNywgvBxNcX2FHYVlaihj7d?=
 =?us-ascii?Q?iEfpbfHz3dXLvFt7RmHxlLO8gWlBqwbw7TTGquTT9iSNpq6lNwy8ks2SSf6U?=
 =?us-ascii?Q?rGL5hnMUbYVjYnEwtUEON0yNrhtFpIVVWG6Ek3Zt2e8Mbd9q4IaCJnXKxIYC?=
 =?us-ascii?Q?9jNtq+5MkoP44MORgGIqskcjcy/mrYBpWwvGv/Eb0GFVYfRt/Uu6ke2J1JYP?=
 =?us-ascii?Q?E1X3SKzT9Qh5QHbXyuG/ze1c3LJEw6qaHjYt3sredYp+E7YfnVnp+tQybjNJ?=
 =?us-ascii?Q?OEY9mP+m04GnWOo/SgY6aBxKJ01qUhZX5c0YyoDOGvM1DPpRenwFmbf7yBto?=
 =?us-ascii?Q?Fo5H42DZvEZzj1bROWyzuauCfcxSE9raRwNOCpD5A9/Sh6UUz/ph53hEMuTa?=
 =?us-ascii?Q?nlEeRUPGQWJlMdnb+cbLPvcHIlJJRGzO2K9lFYFFYxR8trvZCEuTt7pwjV/O?=
 =?us-ascii?Q?0aj+Cg401Bi1p6RcIKZket682nm0ETByzo8t/SDGag170rj0v+2TyWdJeHzP?=
 =?us-ascii?Q?O89aOLKOseQJuw/91gWC3t+32T5bjF0hrg6F1cALbQ8glm5srm0TLxNr4E7U?=
 =?us-ascii?Q?YxhZFkRF+0p/6a9yCRKa0TTebbAcNYbguNL2VPwHgkxftJWihw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rH1hroC26nU/P9oHVwvRKbrkTNiiy2kq76KMzpifwKs65QSOL4G6KGU3WR8k?=
 =?us-ascii?Q?HMJHwcw3k0QssjwCKN7PJa7ONMnK+FQ2/vQ+rKphusxyHN/fRYQ/wqhkQQrS?=
 =?us-ascii?Q?bW3DwbSWQKlIt6Zk/vCsAdZUA3SrXEmCtLyOzeZgN5LNPQDDPSBHmbqVHnQx?=
 =?us-ascii?Q?LRinjNSfXcZDJdTCyNLc40DP7zBcKhlE0QrA9v2F33ohVugGO0zOZtOpRUgc?=
 =?us-ascii?Q?y8DSXOz2MpxeNw88GwS8O+AwWzdMeKeZNqIwc4FdL0LowGrs5tBZ44Wqg7rT?=
 =?us-ascii?Q?UySYc+kZozL/+4q8N5EKosigc/YiBjhpv9SniWb1urdnKPWre42DI9ipZeik?=
 =?us-ascii?Q?sKkez7+La8N9xG8LF1AD1BUpx7alljRU5/u9UFeQi2XiU0ZIQ8boj0QqN2S7?=
 =?us-ascii?Q?lDFbLsTpDXcZjXvARcPqeve+xrI93X3dR9nojc05rCDcVH6kFBD/SAwceRkX?=
 =?us-ascii?Q?qZVSXNYPahEd9CvzVINNeAfOlPABjLPWbQXiwSwDB19x7MTKC570EkwEdcL/?=
 =?us-ascii?Q?LwaiMNRe07iHLTrs3ObyfM276ZOIufsgI1Jq+RLkb2uk42fqwqLu6IjYl05k?=
 =?us-ascii?Q?2S7bmbPwXIAzrOHxgzW/18w7/6sxSXhEvBrqYx5yn1i2JmFKWMYcXq2DQl3u?=
 =?us-ascii?Q?8NAtErspVTAlKDP6M9CfjBu0rZNk2t2IOJK70U5XDKQ/ssusYfFQ/YvzSa7I?=
 =?us-ascii?Q?j4i2E7rIy2wy/fy784ELy+1/RnTLiY25C7MTaHq1flTwf8oVCk4INYxgYBSe?=
 =?us-ascii?Q?axtZxKujxkMJ2KgrggUYiLg8MUREeId/9AU9EawodYl7kZO8LfxFbO+U7HWh?=
 =?us-ascii?Q?+BOegL3DqHTRZsfubxUHZlouA12qNrL5nVhrM0WRNniDspe4/D1XBcnRtonf?=
 =?us-ascii?Q?H79Nw2UZkeC+iElfBc5N6kaAQn8GVy56AsxLLQKcZrZts1KRLS0rqZhzX3xK?=
 =?us-ascii?Q?oivuFGtFcdn8/wRMu25GbJHWibPOd5tHj0ZAMoJwOq1jjbhJaKWoPHPfB6wU?=
 =?us-ascii?Q?xiFkRhmzEw3UclLn9YQQDaQwXIDYkQcA2pOlOA8Q816Wt7kAgRZYnkAjqO5g?=
 =?us-ascii?Q?VdaTMmJXk3xGZoTwmVTofSJcaUlAgHc8UDS0HwJvdJfia5JMOXGINtp/HmPx?=
 =?us-ascii?Q?uzuAeWqntYMR/ufSLdU+hvnYm+xANzEoC1ejPg2daBQ7V3Y+Lwrg5cMd1p+U?=
 =?us-ascii?Q?2ONUFohlgHKK0k6xKXpfgFav7yjY9fbkstootQlWdm7ZEQljvaOZfS/X2em9?=
 =?us-ascii?Q?ZbqQTVTuABgNi4ZVdLuLv4lfHNWCqcx3SgksJ1bnT80fI6Cdhl8os2k60qkY?=
 =?us-ascii?Q?oxARw0I3u8uXmg/pFz9mmHqS0MiWhAG7NFksWu+nIiqjZ9FxlEO+LYJEGG0N?=
 =?us-ascii?Q?5L16SCdZEg10Q97lkwbqp2MThk4ys0rFqld74Lp1YjDcUNWVIHWDBcsvbCC4?=
 =?us-ascii?Q?l6s5zt848b6FNHjwebyl5xyLwOpl4/SwtzeclOe1Xgptam/dgCqjtnEUh39Z?=
 =?us-ascii?Q?FkPypYcTIJa1XsY6vpSnw9mG156epDh1pj+4EKhRNRt2qHvdv/D4BW8ahOXt?=
 =?us-ascii?Q?9Y4+5w5SGtbVgaQYjog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a82ef23-6445-4141-cfe7-08dcba948e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 06:03:58.8214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NX06wFMzGnPBBwniuHZ7e1jj+lZ8aXi9ryrvbO9H1IPrdfO3hF9NFloRRZOQp+hD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Monday, August 12, 2024 11:26 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
> recovery
>
> Add debug option to enable mode2 for poison recovery for testing purpose =
only.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 16 ++++++++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e6b641cb362a..c34819f947ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1201,6 +1201,7 @@ struct amdgpu_device {
>       bool                            debug_disable_soft_recovery;
>       bool                            debug_use_vram_fw_buf;
>       bool                            debug_enable_ras_aca;
> +     bool                            debug_mode2_for_poison_recovery;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index afe3b8bd35a1..be6b920933d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -133,6 +133,7 @@ enum AMDGPU_DEBUG_MASK {
>       AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY =3D BIT(2),
>       AMDGPU_DEBUG_USE_VRAM_FW_BUF =3D BIT(3),
>       AMDGPU_DEBUG_ENABLE_RAS_ACA =3D BIT(4),
> +     AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY =3D BIT(5),
>  };
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX; @@ -2229,6 +2230,11 @@ stat=
ic
> void amdgpu_init_debug_options(struct amdgpu_device *adev)
>               pr_info("debug: enable RAS ACA\n");
>               adev->debug_enable_ras_aca =3D true;
>       }
> +
> +     if (amdgpu_debug_mask &
> AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY) {
> +             pr_info("debug: enable mode2 reset for poison consumption
> recovery");
> +             adev->debug_mode2_for_poison_recovery =3D true;
> +     }
>  }
>
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned=
 long
> flags) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 816800555f7f..a355b2bc2214 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -164,10 +164,12 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     reset =3D ((dev->adev-
> >debug_mode2_for_poison_recovery) ?
> +                              AMDGPU_RAS_GPU_RESET_MODE2_RESET :
> AMDGPU_RAS_GPU_RESET_MODE1_RESET);
> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> @@ -180,10 +182,12 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SDMA3:
>       case SOC15_IH_CLIENTID_SDMA4:
>               block =3D AMDGPU_RAS_BLOCK__SDMA;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     reset =3D ((dev->adev-
> >debug_mode2_for_poison_recovery) ?
> +                              AMDGPU_RAS_GPU_RESET_MODE2_RESET :
> AMDGPU_RAS_GPU_RESET_MODE1_RESET);
> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       default:
>               dev_warn(dev->adev->dev,
> --
> 2.17.1

