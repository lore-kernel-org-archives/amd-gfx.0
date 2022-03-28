Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A572C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 04:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2152910E130;
	Mon, 28 Mar 2022 04:18:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BDD10E130
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 04:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emzLLoxJZg3SZokdIDRE0FPSqAACNJiff3ua5E6dDco862v99TJxEzC4mIT2Kucq3eFGHDNVzxIXbeDA0312ixgn7BFSYiv0GaqzYRcfAI1dAcvYdYcKHYGcBKXT/edBPpBiDTRihOB2qEpV0OFxmuWWJ0j+HbO+ICzr70fX5KY06RHIiFsJchWH+6XD9utXNThATkME2UVnuwGr7JnurShjZN7UiUMtu36t2YugEULmgeQocalr3I9qc14kZCstocnDdX+eBvAyyTR+I247C9nURZv+oXS8P2lixkUiRaLEGQJjSQm4CBUCOBjdYha2SYVM2g2SUt+OIfdRy3oxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjED5INTfPyooBAInZvR4iZLct2ALv58FcK5+Eo6ha0=;
 b=jl5X/fCFruLF65lhIAuLAXBsqX48NhSyTV2E8PKc7jrl0qr+P8TpTGJAbCkWp+YzR556T8FLgXDgrTzqZ4oU2sjA8waWYIIbPGCcUY8haPsKYppunjvEJ4gKX2XSAvhd3S3YqGIFI1nkHtXGJT0QIdPm6GQNuJ2TAjMTuXKzobKdy1rykSJSf99cnKoTlsCWSvbNUUM3/KGBKx+UVh8kkmhDuX1vqcfWaTwM/hToBgvGYD8AfDd2mKaapRYsFeBp+AHu77CVjmM/Z97hrBrRk3zAEgoZK711BwDTA3NtP7IpErz92I8Su0a8YuM/fGOSV/LtBNoLNhyfQigxsJNV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjED5INTfPyooBAInZvR4iZLct2ALv58FcK5+Eo6ha0=;
 b=GLfWbHG3EPhbzaBsQ5KhIiF/zcjOvJd/9s1k58uQ22BFLeTff4Jq62Ns+QrkKDflzX2R82MgwWNCkb5cZOadUJta4MxxYraR7e6OsxI5ExCvkZ1gpsbSavVN9vUxXthWWjzO0cYSQJKyEK3n/BULQwc6tckW+APZmSIH58XOkmM=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 04:18:51 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::d898:13c3:cc9f:d318]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::d898:13c3:cc9f:d318%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 04:18:49 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Index: AQHYQlaXfZxxWLPh9Um1pTGK9nHQ/KzUMHNw
Date: Mon, 28 Mar 2022 04:18:49 +0000
Message-ID: <BL1PR12MB52377CA1DE88B5AC30114333F01D9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220328034650.1983337-1-ruili.ji@amd.com>
In-Reply-To: <20220328034650.1983337-1-ruili.ji@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T04:16:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bc18edfa-ad05-401c-9d6b-4ca473a0fc83;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-28T04:18:46Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: c67224a7-7904-4363-b3de-884038934212
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09007123-4d17-41e5-6421-08da10720f35
x-ms-traffictypediagnostic: BL1PR12MB5875:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5875A055862D64747368C190F01D9@BL1PR12MB5875.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OdMHfBsM8NiejZb1fluW1KymuE9DzLmSoH8yp/34qU3MQL08PeLQXVmlNwpYVbylyNyAgEpjgvd/Z4yU98AeieC31O4QAw725vAm9fkUm4oSYkoZjQ9KhRJXRpKo8vFgs1qivJoyGYXBmqay2ihxYCgM+7PjN2Kmc+KL57dsEiJ14KejGA/31dorgPCZm91ra6nqsCVH3BfN5+vg1sX/1RWprpsFAjup1vv4+EZunw8HxHWErXx/tdVHBbcQ8qg2FDpSkv+6Q8XhAFLoMzM9zHgxhZa6ikqrPREjFFXvDtiyPCVgc/N055psPbk9/vOZlbKA00UmILwYOqKtnbXpZpuz0TDl3WySpAwehXJ5CWn2iBKHBlN4fr8LM1AsPmRg6nwMJpSlE1PNcjWG2aYhIY60IfhWqHhR1TB3N6B/tgybcy5YMq58X13Fgt4xjL3RJhwZ1DLF+YOCRX5lILpcg2JrsGX+0EbBGryA+b3ExDtBkS5T3JZtI9xAhWl6Q0cAMlOGJoUZ3P5Wi5GtJ6zvV48wlYdIp3NN+TMuwsYjaJwCBEK6oPTaKVlfbKwNRZs13KgnbYkar+DIyDsm/uDAr/Fv+MhusAWMyOdsuJaX4QU6d8YkF72AgvhddWlhf/G/IJrZVTKma1/Xxapy7hc1g3SwF2S/m6gvTfPBvCkcoItjHJxHzwGo3993tnn3x+R5XdTuV4LgwMXjSbc83nJ+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(110136005)(54906003)(9686003)(8936002)(52536014)(7696005)(8676002)(86362001)(71200400001)(122000001)(33656002)(6506007)(76116006)(508600001)(53546011)(4326008)(64756008)(66946007)(5660300002)(66446008)(2906002)(83380400001)(38100700002)(38070700005)(55016003)(316002)(26005)(66556008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xDn2D/nQ6DLn1xrrpZW0OsZ5is5rAi3WQq/vmS8TneeTZzRtJxiZ5zv+nrBF?=
 =?us-ascii?Q?80mWOO9ozlDiQi8Pwv/PgZW78XoSQlNBG9g8Ae7yoVse4h8KZJ8cNrojItXq?=
 =?us-ascii?Q?HvZRMa2mnKkx9oaklRuAhysZVhQkZcIN8k7baKtDayLpzST9NBMntOY4Ec8Q?=
 =?us-ascii?Q?IzHA+OXfeoTstVgcjA4vZvKKfaCd3LhxXCsZOU1b5EUHt2kfQON6VlJwq4my?=
 =?us-ascii?Q?pyRyqVqhnQadIieg9r/VpHGMXac8dp/qXv1fxiopbVPFJOUWUclLSy2Eq1u6?=
 =?us-ascii?Q?kDcx6UeVVVOZFY1itkIJzkaQGhDAp2xDCdkoRb6OMOtU69g+n0KtknoUF2qx?=
 =?us-ascii?Q?6jHGxEYRO40F0EF3a1LOFg3NdoHsiNJx1/qO1PDS019P4s4Nw8JAlPYlOcVD?=
 =?us-ascii?Q?OAm+jxJvK1iWVmRTVJgciRep9m8zxHvgLFW2MUr8J1T6+PLrC7x5QyGS9QcG?=
 =?us-ascii?Q?/41XSeuoxb4lD/2GvXVjsN+U0/PlqYZhkNjjBrXFhEx5P9HscBkWWkCjS3lA?=
 =?us-ascii?Q?8wPCjevBrROBik3JSV7o9SE5PVrTuMWxwZtYg0xWvgxmzZ2Lf72T+3ZTF6Ol?=
 =?us-ascii?Q?20Z6Pg3OCpzhM9qqq2nKLEs7GFvOUFDkighrVMuoajnrA2KnpBalAWL8xp/F?=
 =?us-ascii?Q?OrD/xyJapELmdQh1CRVto5+wlRLgpg/bHUhK7LR3dAJl7C0Z2NjECcMfpJXx?=
 =?us-ascii?Q?7E/Xf/F11kNYIiivpN6FEOjLTZzTNJHO+4hb8x6gVrCSoxJMq23iTSHhl/f7?=
 =?us-ascii?Q?Jk+ZvCTfK3dy8V2Lj6WGG1tGK0/fOsncn96zhhj4+/O8INSaPD8xVLcuKsWk?=
 =?us-ascii?Q?wA4mk3Nw3On92hwx1hQQcCpvTMuBMvDQTh4KbmJhBFxdahJ+3swFDMBamgYF?=
 =?us-ascii?Q?P4waXFzCDjP6OUNd413FKO0KIOksAgkpsSP7eK85K6VuXks77lEcCT+n9VRN?=
 =?us-ascii?Q?PuXcgNCMeDBTfAzNwN3advUXxuQOqZCcEyWy37ITEJR2tGQ+Gd1m8vwzsAiJ?=
 =?us-ascii?Q?BjqoPc8ShhJzEQn3GjQMTkgCg7zd4DrrERzINZJDj2q1ydJYulPvXOPX9kMr?=
 =?us-ascii?Q?yt9gEzMX+kFZ2a5XUQFsTyMGeyQKJ3GlbdCZ7z9Bwik68dzrJ/scEEBHDzgZ?=
 =?us-ascii?Q?lDvYDC3HZOqx63d2+eTDIqNSBX7NhIVUHlQwfvrI0zdGzp6Z3BQ7UNjVptys?=
 =?us-ascii?Q?Lt4sp2DbzSco6hu4lWgrdWHbP39+6+nWabXzaZNU58HXXTlL30z/oH2tQ0LU?=
 =?us-ascii?Q?bf3VO0LTyUBSMDMZYkF+TkCZJa215/8XEkWqTU9Fsp4womS3AvmFxMQWzugt?=
 =?us-ascii?Q?uYMXZDKK4F4mEcM4GZA0sKO025/LHdQhl+ddUJHPJpPAih+ywRhoO21FSDfT?=
 =?us-ascii?Q?v+SzKDXXjqaIfbCG1LJggmIwiri1Sx2xWa2Z/g//l73/Aw0ZgtVkTuh7cP2T?=
 =?us-ascii?Q?U+J9S4qCk996la0WLvnwUwELlhpdczK6Sk96wGPQ2edIV2KA/ea/9n8LHU7m?=
 =?us-ascii?Q?thtRpJIuSa2ZgplWWW04ZYcQEehv70SnyQ5zWAr1mHtzCbVixSghrml4ZrF7?=
 =?us-ascii?Q?k6JJzIG2T+1CU7H/GxvAWJ3pJyGQciqiM98uBTow17zviAev9kd+V1dL75Qa?=
 =?us-ascii?Q?yibD70tSGor5h1HSF56HNeDmtwqNOwTv5YS5G/VbJSWryp4hzJzmamA7zvzz?=
 =?us-ascii?Q?CjRe+tY3zLR3ypZ6MuF0W8wg0IY1h8gcm/ucTDF94gMf5Zv7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09007123-4d17-41e5-6421-08da10720f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 04:18:49.1945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+Bk2iqNFqb8WU56DM2RhMhS1sXdFnV3nQ2/hGlD1HhrRVd2L8jQI1wloiYjxG04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks Ruili. Please remove Change-Id.
With this fixed, Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: Ji, Ruili <Ruili.Ji@amd.com>
> Sent: Monday, March 28, 2022 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Ji, Ruili
> <Ruili.Ji@amd.com>
> Subject: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
>=20
> From: Ruili Ji <ruiliji2@amd.com>
>=20
> RMB shall use 0x1580 address for GCR_GENERAL_CNTL
>=20
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Change-Id: I10a85891986f31411f85fa3db46970aaa8a5bd03
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 99df18ae7316..e4c9d92ac381 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3300,7 +3300,7 @@ static const struct soc15_reg_golden
> golden_settings_gc_10_3_3[] =3D
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000242),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER,
> 0x000000ff, 0x000000e4),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210), @@ -3436,7 +3436,7 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_6[] =3D
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000042),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER,
> 0x000000ff, 0x00000044),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210), @@ -3461,7 +3461,7 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_7[] =3D {
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000041),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER,
> 0x000000ff, 0x000000e4),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210),
> --
> 2.25.1
