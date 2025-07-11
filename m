Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A86C83F1D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 10:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EE110EA1D;
	Fri, 11 Jul 2025 10:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Omqxqur3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C1110E277
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 10:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJB/ThWZWsDMGDHYj4zTRJQxKqRBLGcVz7Lx6M6LwjuHthtAiEA5r5Ym8hneDewpaU2KnbwoYxNPFxOSY2Ca7+HZ+virHwj1CM/A7MidzlKV7bZkw1dBahApQi3OLjw8ko0P3KLM7wAttmmKJUoGjIezZ8wurqTeNVgZh+IJ49yqoN0CgLhcrozQ3BQAon/rrYLraoKvcIWxXWanQXRpzyl40UnHXmcJUnvFzq8uTkjIeg0qsV8ZVxe5UEg9EZSsalHNrUeOX6Ynur3uLtCdNtX7FvVMxMgbeMtkXdqyMoKLkdtZft59KHsZVWbNluXK8IDCYY22mn6v/TDXwTwnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uOQQwx8TQs5Sg1IGHoiVK7gCrQskztXjxG9IKd42Fo=;
 b=TbQUQRBdQ5aWrJ9hL+Sltu95bino58dzDDGd2HymSDYnhchsQRSM22KqR0s/1xipN71wt+Ti/p/10IKtYqxTqc5aH35++ZRo2xcVX5nJ6iNFJ6LUgR9VlLhUMEsbK9AOMTnnLDhNZR1xxfeERcUUawV5sedh2ZBZzS4j+VE6EDsp3Tq09utlQk8iBll25cYSsgarLr3uz7scsNW0/zzW2WoSySqOZCNY56tlBT3H0yarEUSHtCqEoHctJCQYH0lTFxf8a/0mBk9eYI73unRiOQyDtxULp15xLbQmOBrooEleUcq1locXk0EYHDBCkJjYQxC5xjiTkshY9pR3By9dpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uOQQwx8TQs5Sg1IGHoiVK7gCrQskztXjxG9IKd42Fo=;
 b=Omqxqur3+3m4PfTLUhSECu6uxCyOISGfciP8Fnh7/Cp/V9oY8EoLlfEnriSPNpUMTECOUHnkgjBpO/CY7jtpKnMuNgpOJqc+7SaA95a9eXo4smBh9mO9nvSp9yXlgroVUw3nCqEmyNib3XpSoHau+QDH9Ysqb4h9uYDb/De+UgM=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 10:46:16 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::563a:16e3:6049:53ae]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::563a:16e3:6049:53ae%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 10:46:15 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: The interrupt source was not released
Thread-Topic: [PATCH] drm/amdgpu: The interrupt source was not released
Thread-Index: AQHb8kzaTBM1casrl0mgFxxDK3oNq7QsvW4w
Date: Fri, 11 Jul 2025 10:46:15 +0000
Message-ID: <SJ2PR12MB88071BABE0828E10D2B71EE9B04BA@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20250711101605.16301-1-cesun102@amd.com>
In-Reply-To: <20250711101605.16301-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-11T10:46:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|DS0PR12MB7746:EE_
x-ms-office365-filtering-correlation-id: e83adb4a-370a-418b-44f7-08ddc068294d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V9DFpl8xDOoKEwDUVEKxzxqzrUyFHlg6hdusYtgaFGqARR4vIhU5KBpMoKIZ?=
 =?us-ascii?Q?jKUcDUsBL2hsNhXzhP9XPUQwWW0j8/WdGReK7DaAK+88AiAG/JB+aFSUdBFB?=
 =?us-ascii?Q?ZwuaXa6YTD74zuB5TJvk8lHN/PTRJIk+ADXD8PWY7XM5FGHpLYr9dlisbmNK?=
 =?us-ascii?Q?CpdX2M5yIiLPGJeGvnyCAnGCxNQCoUXT3w5ZoLpN4uLjK9/YwnB7CLUZvra8?=
 =?us-ascii?Q?H7MaO5sgti5VhnbnSxJxdg0l+Fefxkmou1HLPHRNe5dU2qBz/Byu7ipHh49N?=
 =?us-ascii?Q?Z+yVS3t5URoJ0GsaDzyTGwFNtcbpLotq5KqRk3nrk/zwj0VUIZ9L5DNxyCmo?=
 =?us-ascii?Q?pHeS9THmwj4HeB68gUEn3uvH7QFcv4zcE0LZFwTcRQATeyhMPrkZZlMM6VTV?=
 =?us-ascii?Q?o3jYkkspYh4jp2G1GYVTvpwvbnaO/+UFyFzD1JgqnpBqk8WByKBmAkvMBSdr?=
 =?us-ascii?Q?tWc5m+u3QVUM5Nf46yAtox5OYep6/IY5Hu7sX1ut/u07osMrJ0Kfca0PZg2U?=
 =?us-ascii?Q?RSwm0LQH2GIYcytXY5pjZPE87/FXL6+ays0xVP+326ELsq/49YQqQA//DZb8?=
 =?us-ascii?Q?bnmuuUcnPjdCLN/AGJ1nDUnqFGXH/drbc0NgHOKWV+evbK5qu6R1E1zhIpwg?=
 =?us-ascii?Q?7sXAKaZOcyV7pv2DlYTHrdgc2T+t5WZ+ZlyjswMup5Rtk9D6dsG/UKmsF7Oj?=
 =?us-ascii?Q?MRc3JC17r6NBkwtCDBoAyJFZFJBRB34U8wEh+WYS+sUBRfj6kZBrVBJNs52T?=
 =?us-ascii?Q?96R3HWLzw7u7eGCmok5OfgkeNN9+XNrUxkrIbyPmyAMFpLsGey61TO7XKqu+?=
 =?us-ascii?Q?NwaaBtNhTgd5l4s3H4HT+gx++sPI42III6rj/eyAbKn83S/a5lpRlM60EAQO?=
 =?us-ascii?Q?6GXwv8WvIhnBJ9WRs6ZiBQhbjWOt0D7u0C42cfT51GC/5lmhhpp26zXW1iqk?=
 =?us-ascii?Q?EQdonvAd51UzxofpmU/1T6C7s/0Y0q0BCh+Vo5tkS6jP5AG9ZVCm0VSjf6EQ?=
 =?us-ascii?Q?ExCZAEGd91Whfqt7vv5Yjde5Lj72fLYAxjXkdKOPPL2TMciK7kA4YectRGTp?=
 =?us-ascii?Q?oZ3D5yMgLkYZvfDRgPYY5RZKbZrv5CguDUfy7b7SRNWCmqSriVdw4UyDnTXP?=
 =?us-ascii?Q?7KFyFKCq6TMVeedLRCAW0Bm1feyc7aNtEUeOVl6T9Dty4Dt/vqD/HkmeQ01e?=
 =?us-ascii?Q?0qoYnfFJ4rfQQ9dunWkSOWBBIm7NY9If+6UFF3arIeUAqoVeps3xgzluhWVn?=
 =?us-ascii?Q?uEDVEscq/d2lb9VS0x7KwtUyvzGPn8oRBgFgFlIT9kGgezbTVkADVGGQ/4o2?=
 =?us-ascii?Q?Gk8m8VG6o0go5ZLwWk8ZSvjp+6tA3ZuutD+GFtlrUSWCJyxX/7uCRlFN8hdb?=
 =?us-ascii?Q?ER1QUbi6YTM7C1xOTwXsuCahyKQBUNSesXHwFgu58ZiN3POQHxBavG2SLgL4?=
 =?us-ascii?Q?AwNu0nhPXaMec6sDguwZSSePP+Q74UiIFeflVWpGeVp1+1ZY6Y4SSRbKVqZY?=
 =?us-ascii?Q?EToJkr2h/kuz6Jc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A5mvfi7JDro1JeJWnVPSROqq7jo1bdTFEU20LLuX0DxLKqTx5QQR//wyOOg6?=
 =?us-ascii?Q?nQp/d8AlNJANfK3U3EZQw6rXxspNM67ox2kJ5m3nQ5OSMRowhVQo5ykMPWK+?=
 =?us-ascii?Q?eXT12JmkSciq5Yr0M1/ObqyIbmoAK7z3PSs1oD4QYcsieFa7KT/oKLngdR9f?=
 =?us-ascii?Q?ielHUL4XM74sKHDhxMRqDeIuwesWHd6FDIVzV6x9M72GvfOCnDQorycfOwO2?=
 =?us-ascii?Q?kvBaTBrzUbYekf+YKzFDscInl0ylgsGDXG0fTTg21maoowsk2irRABCYJwUG?=
 =?us-ascii?Q?gAxtsna3dz0XbqgeDulX5uguuR/sdraZGJgQWaIpYBV4QQ0dfVy5jLOxc1J8?=
 =?us-ascii?Q?xeqQMIkJ18EmWguyms07Oxr+G2O89XThQP6BOa5b925Q2ZvSsmI6aBamoaLU?=
 =?us-ascii?Q?+lo9JbWOEWKJXII5Vhijrz2DkWuhKnQ+2kXbgAqOtj47sD/I0w4pevJC+Phz?=
 =?us-ascii?Q?T7kFSey8KA/rZHW581jP5JrSpF5/6/5niR3WgPKFrV2X82BLk65L+nvzyZPl?=
 =?us-ascii?Q?UitRXMp/NdQJy1UVEXspJSx4XgYcFgQx0O4dj9w1oFqrphiLy379c+2r1B9O?=
 =?us-ascii?Q?kHIqiJGBPfG29EVsFLLZE2uBRwBxIWjadHX1yMMT657scO5D4q+43GtUJnMZ?=
 =?us-ascii?Q?0iyeZIwMUVqQdBwbX3FBHwmhhqJth76OvnU0ZBtctm70hvXLIyhjZDKvcAah?=
 =?us-ascii?Q?ggYM3kyMWPnZ+0EPE7LoWcUnAgOJNTEABEoaizDmFIf9G5ApyqpGTGjP19dm?=
 =?us-ascii?Q?mPxhAfXOoUdX4/eqG26gSXsDsWzSpITW3wfFQhWQBL7SUC0kmyvio3CBdaXH?=
 =?us-ascii?Q?cKW1YvNSrUT8SN1WgxhZmU1Q73Nm8eybHTrwBPybDuwAJCp2etIOJdrYHYDx?=
 =?us-ascii?Q?jbrUsvuEhaHhnUzBIGcAFZi3MTFd2JlRzonhbw1zlnVwOni97gIIAWCSdpGU?=
 =?us-ascii?Q?rwNQBhGt2eTg4/jOXs9hJPnpMVRA2RPjihKnvlUDrRoHU9fDe657FIFjZoq9?=
 =?us-ascii?Q?Gj2/6d/0foFvBwTa/T83/1gNO4YFeE7xK17ryIKqsQU1LP+E60kHzZT8X/aV?=
 =?us-ascii?Q?Y5qu59IbOhIUsVsdlWxgAdMIeu2z8jR/2XX440NuW8ve7f+21fogcFhxAN+b?=
 =?us-ascii?Q?bYT8SCMCB2s/n2de0Q5wBc4/Sa6EGdftiIYKIppp7d1Hum2BvfnBJFJmheiC?=
 =?us-ascii?Q?SSilbwFuqmLn6fuCFTUVE2otM4/bUKJ+YAqDyciHXi7g2mLb9ofz8UQnfIg7?=
 =?us-ascii?Q?dEEmO77QYs9FGM4k4Pq4DTiBxFtd3t/J7I2F0UYHG+PwlRRVSZCkzgtFV8lB?=
 =?us-ascii?Q?bNlHOOV/fT2/22XaI0BkLzC+Sj+33xfePsN+zVY0ikgEnose4y1GJEbKhjPk?=
 =?us-ascii?Q?z4Q02+7c3fkRwptWQfsawTi6ktIBolCg1bTWDm/0C9HuDbgCDv8Pt5G3So5q?=
 =?us-ascii?Q?e0TaVJacbxzKIGvOq8mYXSPLkijxTtLY0iKKERlsfXsNiGMkTLQJEPQcGFq5?=
 =?us-ascii?Q?BGHFqB4ADs4UoB1X1aDtEEkUJb0QDiNdVnrbV9pQFXAg7Fb58xy0ByYFW5k/?=
 =?us-ascii?Q?eVCPzvygwdkBC0o6e+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83adb4a-370a-418b-44f7-08ddc068294d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 10:46:15.8247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSbj26ugNVJxKr3UE7G9zz5SijqKvxbZA2VL7oprhb4+XGcDa3uhN0Ban+6cSvQb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Friday, July 11, 2025 6:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: The interrupt source was not released
>
> When the driver is unloaded, the interrupt source of the rma device is no=
t released,
> resulting in the failure of hw_init when loading again using bad_page_thr=
eshold.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index cdffe4a1559f..80cb8865c02d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -622,7 +622,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct
> amdgpu_irq_src *src,
>                  unsigned int type)
>  {
>       /* When the threshold is reached,the interrupt source may not be
> enabled.return -EINVAL */
> -     if (amdgpu_ras_is_rma(adev))
> +     if (amdgpu_ras_is_rma(adev) && !amdgpu_irq_enabled(adev, src, type)=
)
>               return -EINVAL;
>
>       if (!adev->irq.installed)
> --
> 2.34.1

