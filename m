Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5730C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 03:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 712E710E5BB;
	Tue, 29 Jul 2025 03:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="daVpvtfu";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2CA10E5BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 03:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS1D/6rDQubbyIZL4CsHPgzqD/Kvmn+6z0Un/LS+yahFUpxeP2Q60U435zj4arDRpHRJqwWdfMkwwuMmvNQSmaEXyatirVdCHC+cBWiQVO56uxmb75SyTL6xTXMIFmpxuE2zDzO5eEH4MOLbevuGNEDlO5DtfwWOgIRMIDLQbkVgB3npYd6jxgP4C28YdzLVOY7POhjXzlMzbt93W3EP50O6uXaYpy6UJYGsPnedklkE5wnvhC/HzR30/E+Rs/SZ3LM+8aeaRvc9/zr4IoXtJTLZHc9eBMDtmySWXfjy0Ft64XDk7WRvOhx969WV78OmXn/C0trPftY+w6/SUm16Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYexfkYBT+uykEs2h1N5wNtz2zqyTCJ6EPofy0fPL+8=;
 b=FM8YwFW3xu6r46QGQcU9/0d4DVAiiUwALNj81sI5Ruw+1Am5GSOB5L2Rx9w2BJ6jBeU84EJ0Xcuv4Oui0IrYShM89O3ZTMDcmN/v3/RYLwv/oUjKuS/dXJl1SRZ0ct0WkXnj3/e6krtiUEmjJtVF3hhMwQ1kKjMMs3RxLH9LuLaJCCs8aBRccErNgDZbvQ1G4BKXL5GrPJwCUQeyB5J2ZgAmtz0Pq4OZcqKbkZtn4psgdmrvX+DJnW2zo9UoW4wE2tc+StbQnxJOiYuR2mo3/3Hza/haLfSA3zGPWVYCenO730xx4HRSwOlBfJXnZyy65avN3Ye6QJaNTZw4XyTHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYexfkYBT+uykEs2h1N5wNtz2zqyTCJ6EPofy0fPL+8=;
 b=daVpvtfu1gqUktnoCgjhGAmkT8uRjpn8mcdDWWwgDTh6DS69O47nx1iAqWm4ebQ1el+7NxxA64/Iu7/uY8+BMWiw2c763AiwHAMEiEJIjQOsHV3Gj95HQOOl6v4BgdE43PbLnQK3S8NQvHXPZV5JAw8Eh0iWQiy/KyCIcde5220=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 03:57:23 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 03:57:23 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Avoid rma causes GPU duplicate reset
Thread-Topic: [PATCH] drm/amdgpu: Avoid rma causes GPU duplicate reset
Thread-Index: AQHcADgveW+x7Oj7/0Gfkpn7aaQekrRIcM3g
Date: Tue, 29 Jul 2025 03:57:22 +0000
Message-ID: <PH7PR12MB87968556FFD4BCF56595095BB025A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250729032323.74649-1-cesun102@amd.com>
In-Reply-To: <20250729032323.74649-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T03:26:49.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH3PR12MB8458:EE_
x-ms-office365-filtering-correlation-id: 49c0b0e7-69a6-4e1e-2e52-08ddce54060a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lg7QKLDJLVyKlHTTaz0sPD4EWB8LcO1raKn5qCGxwQLapsLBkPXCvyijv53W?=
 =?us-ascii?Q?RlPM6e8h2TmloQfd0X1YAFTmemjjn/3emAWtT6G9h7QHkK9mftvfVP2nVRyg?=
 =?us-ascii?Q?SMuNBr3orN8hiZw0sGkBeLZP73eDePHHiN/5ykPzEn8zbkUzsYAxLOSykfrt?=
 =?us-ascii?Q?403VgykKP+U/lG09bLNna7LyxA0oa6D8QnRoIWXgpGfngZ/7RswGmihcjvG5?=
 =?us-ascii?Q?J+zDgAOd05KpKO8RQCpvyvoZh7MQPAE4zEOVd4RMbMrOGw7k2jKIlFLE26qw?=
 =?us-ascii?Q?4isfqLsBbA2rlPrDEBb1ZThEY+jdXCFeoLageS+5Oxa92LIT4cdKrV4AOov7?=
 =?us-ascii?Q?qeMRjdb494GMZDREQ6ShANSPsjU5bQkPyoi/YEFcF0TlfT4yrgCLcQVvpp0Y?=
 =?us-ascii?Q?KxIVIgrh/hmvjs61/FrW/x3meX1MwfjWLqLZNpKuU0X1QaeZ8tl68wpu5Trt?=
 =?us-ascii?Q?3IdF4e0/BaX9jyTrWiOmFd8qUlgX+Mni+YUMXfu+MEvVlOiCkCL7aqm9qecS?=
 =?us-ascii?Q?1Hf0V3ONe1eAUUduEMW0KmMGO54n0dPLygcGk8/5BFbe/rUHyxdL3kV5VtHF?=
 =?us-ascii?Q?alTu4RlFk0vsi8jbRUnLNCDMY6yQIwSHuU2kGSQ/bGX3nVKTncvs/3HG0EoB?=
 =?us-ascii?Q?U7v1hdBgtxgKDYgLNDht431qXjBxBOAx8kYEhDpHBjPtNvDxSjz+m2nfcesC?=
 =?us-ascii?Q?u04XML/RTQBYgx09g7I7P/SpdQHBpygn1rZSdOxu38Vfi4jGAFxpjoCOEYlZ?=
 =?us-ascii?Q?zqE6aMTNaUlucOVgThSOaUgzS0M2DQuXaVlGtKIIuYBenjh6vKnCgOyno0Re?=
 =?us-ascii?Q?P3MQ5D2ano3FwyamlKq2tj645CgM0CjeBUVwlr1gZon8vCcgVrH3jURTXidV?=
 =?us-ascii?Q?nhe2uG88N2idreIRJw3X9AWJEKI7H7xLG3aqbKNKWC27ZqpgBw8brTsHYGmH?=
 =?us-ascii?Q?H+tH7V6EBBlPPCDDXvoHNLSnJVDkctW/+G2/qQvXewDEc56T3JgW9t3/VEL2?=
 =?us-ascii?Q?/fbefoc68F7PipfDOlR70QMeM1lZ/a2tjZk+rIYPe8shFbllWgR2ae5cXubN?=
 =?us-ascii?Q?0vgZgaxnwW/bS4XfLrMVnE/47l/IqEF8oF/vNgCaMGhiRoXw1eTsiGAlIgVS?=
 =?us-ascii?Q?025Ne7+BTRTGH/hPlPKYkcOuo2loAdGu2VVOT66VgBwOf5VD2QO2F4l8olz/?=
 =?us-ascii?Q?mV1YsJFexQ57IWCjrS8CvKo9meK+3iKztn/rsKhXBnD8e2ecj57F54nt1I3Y?=
 =?us-ascii?Q?scPE6+io6CKGl8Heh2bKjovyHGdB8Gn8vJ0tEu7mq2w5M5Y+71CkgnJ1yxar?=
 =?us-ascii?Q?zd4MDOfMXAfetgbVHsU6Pf7v17alJBPhOyHi1u4uQ88+6DteqD3X4tPTbM6P?=
 =?us-ascii?Q?uj1vUzx2pgkqkTLrpvE/ZRm67VJ4rWwvukxyvSkMiSr3+GeiMhgC+eyJB1g9?=
 =?us-ascii?Q?iOFyqG+S5Zdr10aC0XLvNoa3cpsJbIxbI7J/arb6VeZciLEgAyxqvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KB+elbWm+sCYCcGqWVKy5BWAYHskoV10yVTYg3LsfRih8mDetkgpZ6IiSNaw?=
 =?us-ascii?Q?HNH5tf1YHtQLoyqNSib1LbSzClpLzy3eKEzqzT/2AtdXDkh5YIneEdO5UTYZ?=
 =?us-ascii?Q?pP99uUNZdv2ih43JQM3MgujdXPGrsUJqFgQC+zPThjihHDWVayqwosAg2HLg?=
 =?us-ascii?Q?uPpBlxtDRKJVdOVKq7SvY3EAF2hI1yq3QTFew99LwB+kA5zUp+PGxdCs8Be4?=
 =?us-ascii?Q?qheHhkkiIaXFkVYgqQlERXmcOER0hUMPccyKcGwZADCYIa4e6tiXpoT3NlK/?=
 =?us-ascii?Q?+P7OOrmGC2KpzDHsdf2+Lc8gQPRj21hFAuLjZhUFli1yOkMyL1VQh54L2vxk?=
 =?us-ascii?Q?tRQg+RXmAu6b+RPfOd+/PozfwptmRSZKY+pv/IkZ7EwTQxgydLE5Vkni/yXV?=
 =?us-ascii?Q?8XINHcGE2eKkl+Msq/0yqd0nfDMwEop/+qAHJ6dK9sHLA1uK9V05UnUXsO+D?=
 =?us-ascii?Q?akai9VAsGL0OUpQTBXCF3ZCW7euYhmNRdGAvAUqkX8X09BSSoQoMS4hC+M7p?=
 =?us-ascii?Q?Vu8QhZttSJhOKNQ0gCxounuPU0cOaEND908rCSscyCvR/BUkwM+7s2yhcJe5?=
 =?us-ascii?Q?MlBjDRfebbfxTEWXqlHhjQ/hB//y3p0w/Xb8RX+15eahjhn7RA1oBywYNrop?=
 =?us-ascii?Q?WqfIYTemLLlwm9gpQ3h/lz2Ph7XlpJGQlRygtvM2mGOtIBdpK61zVgqXnFn9?=
 =?us-ascii?Q?PQwJvyTIlAdP+wvgE34FaWESWxC2QOd7O3YynifvB+50VHvzJjixVnLFhmOC?=
 =?us-ascii?Q?0vKAwbFV/JnpPh+9V5l1sITow/Pl2K4Qqbe3jlOJG7iVKCFj4/+O57XBoTnz?=
 =?us-ascii?Q?4/NON5PoaSm7L74/zvEBDy1nn1s+++p0kVNanjw80pin3uS73u9nSTbn22R6?=
 =?us-ascii?Q?SYQUtiiCXctlCjDkWCEZB16tzSVsfIztENhH5wLFCfrHyAmrDTdkiGMuh0KM?=
 =?us-ascii?Q?kb6eyr9hfahDwN4Us7Uk2nW4UtLz7IBROCcLO1v/exP4rPbhj0OQuprSoAJt?=
 =?us-ascii?Q?BMjO1v7BtQOa/hi8t1m+0pupanqa4hvOBRYesRRwjCAHvJBXAQBembt6N/TG?=
 =?us-ascii?Q?JT+nqDG+eWU17FkkNhNM4vwEn2LCsJ2C2YuFNvWLy/IQgUSy066wkHe54U4X?=
 =?us-ascii?Q?ZZ9dhigSrfc+S9pUJRdoop8NvhE5clomF01p1hy1Zf7Yze8xdYV2aY5ynnBh?=
 =?us-ascii?Q?K6UbCcjU0Y5IklSX1oE9Gty1L730UlHkFCmGPUFECdfsd7f104p/yWFYlcIm?=
 =?us-ascii?Q?4ySoT7jze2ST2wbe+9yw/2w2BMXozONVt84b7hHm4keChWPUZEW+yDXB2C43?=
 =?us-ascii?Q?s0txRnuNNpTYVoY8CDZKmyvQcqX56dj1kHYsF88liGDojZZBChh8HvxpFie2?=
 =?us-ascii?Q?VYf3E+cmupFgsOIe2m1V6ADgEFnyy8rNGO4olGUEnmzwWcTTQuR5V74c5pOz?=
 =?us-ascii?Q?5snra3zolxBFx2gkpVqqn+g9UEHxEHWEcCwxgHYq3TNDyVuf9YjgrbwO5JYr?=
 =?us-ascii?Q?lDVawfUjWLaHe3YyLmr6Utg5NonjtzP7Pglak0BVZZgO6EY+/lTAPr1XjL3v?=
 =?us-ascii?Q?v5d2zvtqYN0KZ+Er4Wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c0b0e7-69a6-4e1e-2e52-08ddce54060a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 03:57:23.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgm1a+6htFVl03uQGHhq7l2gez3Q8f+4tdnwaacyu4bV0RIyf2nY/f4EQL0ZzzwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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
> Sent: Tuesday, July 29, 2025 11:23 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Sun,
> Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Avoid rma causes GPU duplicate reset
>
> Try to ensure poison creation handle is completed in time to set device r=
ma value.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++-------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ac7099d03e89..eea175874ba0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3356,7 +3356,6 @@ static void amdgpu_ras_do_page_retirement(struct
> work_struct *work)
>                                             page_retirement_dwork.work);
>       struct amdgpu_device *adev =3D con->adev;
>       struct ras_err_data err_data;
> -     unsigned long err_cnt;
>
>       /* If gpu reset is ongoing, delay retiring the bad pages */
>       if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) { @@ -33=
68,13
> +3367,9 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *=
work)
>       amdgpu_ras_error_data_init(&err_data);
>
>       amdgpu_umc_handle_bad_pages(adev, &err_data);
> -     err_cnt =3D err_data.err_addr_cnt;
>
>       amdgpu_ras_error_data_fini(&err_data);
>
> -     if (err_cnt && amdgpu_ras_is_rma(adev))
> -             amdgpu_ras_reset_gpu(adev);
> -
>       amdgpu_ras_schedule_retirement_dwork(con,
>                       AMDGPU_RAS_RETIRE_PAGE_INTERVAL);
>  }
> @@ -3428,6 +3423,9 @@ static int amdgpu_ras_poison_creation_handler(struc=
t
> amdgpu_device *adev,
>       if (total_detect_count)
>               schedule_delayed_work(&ras->page_retirement_dwork, 0);
>
> +     if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
,
> 0, 1) =3D=3D 0)
> +             amdgpu_ras_reset_gpu(adev);
> +
>       return 0;
>  }
>
> @@ -3464,6 +3462,12 @@ static int
> amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
>               reset_flags |=3D msg.reset;
>       }
>
> +     /*
> +      * Try to ensure poison creation handler is completed first
> +      * to set rma if bad page exceed threshold.
> +      */
> +     flush_delayed_work(&con->page_retirement_dwork);
> +
>       /* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu res=
et */
>       if (reset_flags && !amdgpu_ras_is_rma(adev)) {
>               if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
> @@ -3473,8 +3477,6 @@ static int
> amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
>               else
>                       reset =3D reset_flags;
>
> -             flush_delayed_work(&con->page_retirement_dwork);
> -
>               con->gpu_reset_flags |=3D reset;
>               amdgpu_ras_reset_gpu(adev);
>
> @@ -3645,6 +3647,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev, bool init_bp_info)
>       mutex_init(&con->recovery_lock);
>       INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
>       atomic_set(&con->in_recovery, 0);
> +     atomic_set(&con->rma_in_recovery, 0);
>       con->eeprom_control.bad_channel_bitmap =3D 0;
>
>       max_eeprom_records_count =3D
> amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7f10a7402160..662046ab73ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -515,6 +515,7 @@ struct amdgpu_ras {
>       /* gpu recovery */
>       struct work_struct recovery_work;
>       atomic_t in_recovery;
> +     atomic_t rma_in_recovery;
>       struct amdgpu_device *adev;
>       /* error handler data */
>       struct ras_err_handler_data *eh_data;
> --
> 2.34.1

