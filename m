Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66448C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5C6613B4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5C6613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03226E48B;
	Tue, 22 Jun 2021 10:19:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1820F6E48B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 10:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj7X34Jmfx2vJX3QNfXQhT52+vhI13drSAkVHZhm9xp4BLGC9MdZGn7eTEfmbDz2EXKX7uCgBEYwg2xZqzpAWiJXNKQ9iwoEf/4zn9oxzeifcg88xi/7BMgW7gExAgevMX0XqjJolqJqoLA7RUTu/b8A5KsKD56TJGhy9jD/dD3PoXzdjs9WwJwKDE3iSF4Q87355uPAUKb9uVbYfa7yxBQbeSjxvLkeZTIY+3/FTtvKOjDd4/FwQtKSgJ0NCvdujjCyrpzcBjkUtcwqgxYUALekOL13Ybg3GVbm62tar13FjgRV1/cAQLHEfkUXqoXvjoaiSVT5yiuFlCUE87thQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJPvoSJr52d5Iq3/9+X4QkmQigjeP5/6Wb9AeP0CFFo=;
 b=l8tRpYhGcXQfhDTlhq6r17pteE5NlVV+lP3mdv/+LnrLhztq+EQX17Qt+AYON3o/kzWpyPD7XV74Vr0yRlihk09pEGgrThvOKJAPIchVd+uARh0jARPyp8oljgIV0WCQGxVgP2wRJcs6s0Y7g9r+p49JuuOvu/P3ZLXyzyJVi6xOkx03X4IGQEReYGMe7bKSYeJbA3BmuhLTq+64ngKWq6/0tfYo0bbIodZDZ4uRwk4ePiJI6p+nRk/LT5dFUnnfCNDWEa3IuQa+Aqd2XD3h1Qb7naVvS0DnSkApKNfcvU7NIqS9BJ8YqZ205ZhgGXooZWGu3YXdlo9ma+rYAYatgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJPvoSJr52d5Iq3/9+X4QkmQigjeP5/6Wb9AeP0CFFo=;
 b=wI7xiJwNMQOhzICJEIgibXyf9DjqDLf1fAJA/Vojmail4InOhrgkM27k2/KTSX1byVx076x3j9TQCYa21b7a9DOudhhZpMbfsJJeP/6yr3bw3gkC0HC2YJNkXyRt+ITB8GbAPgi6/Xz06xTv9SmD+u8NFr/PTDaBkiQtw08aHCw=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 10:19:07 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::456d:de99:d28d:2287]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::456d:de99:d28d:2287%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:19:06 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move apu flags initialization to the start of
 device init
Thread-Topic: [PATCH] drm/amdgpu: move apu flags initialization to the start
 of device init
Thread-Index: AQHXZ0q7hWgiS5FjqE+i2UWzAz9opKsf0WcQ
Date: Tue, 22 Jun 2021 10:19:06 +0000
Message-ID: <BL1PR12MB5237D369F630F0C3261C5D34F0099@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20210622094051.445023-1-ray.huang@amd.com>
In-Reply-To: <20210622094051.445023-1-ray.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cc4890f-3811-4637-db96-08d935672b05
x-ms-traffictypediagnostic: BL0PR12MB5523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB5523B85A572BEE9D0A7C6BADF0099@BL0PR12MB5523.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exq+TB6s6AUl1tfXjJDqZetuWPdPhHhxTk9z51/1ZfrrdGdFXuCDFTC9h25071lial7vixFsdMVhKZm9ol+v9lqYkYM4MsjMpYlvFVZp2cl88ONA0kPk+hr4QpnqLqju3Ev0unteFggVjdiGtk7CiavHEphJPnvOgiE0ERMiROsWGVGNf9G1JknNVSfRdL4gLZdC4zxobFsE5gsKejxzoTmumWgkiFSPQ5qgFlEPMz15hhkXSafoqb/3LNyGmZGwXHf8aS5aeLPgMcwcSLa40s5WROKPwmEn8aj5C3UMe3AddpzCPSb+wHz+W1IKUu/6o9mwD3ujUuEGcmOFXQcbALVsQVuRaiWgCI+3UhAT1Ci6uTcPlkATgRgax9iapPcflZsOAUyO52ZsRhdZW6IHd2w5e3sle90HOBtm3OHds8yj+nqLX2B4ADanmF6VD81YhsBOw0B2YiPT2kgskSeD2VqrKRqrwrhpiYtvz/OuH89LJewRd9RjF0ptr8at7d/PZCOm2G9rFe6NYoNSO/bP5er0WTDzNYD4CWfr5F/wiAqoX9gJ9XDm++IpOMhvuqJBLL97HiZNX7c8jSyTAtISQub+Eedod47AE6lvGfDnNTQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(5660300002)(53546011)(6506007)(9686003)(33656002)(55016002)(71200400001)(8676002)(478600001)(8936002)(122000001)(83380400001)(66556008)(66476007)(66446008)(110136005)(26005)(2906002)(64756008)(86362001)(54906003)(186003)(66946007)(76116006)(7696005)(38100700002)(4326008)(52536014)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SlQW9M2cuz/864ygL1CHT0/j5V2/T5n5Zv7EpopEu4n6/mv00llEWRcdC8rA?=
 =?us-ascii?Q?tKE+qBrVAn2jWDh3qOjRXzOutzH+YcbAKLNBQrJR1ZL2SnSqOCMaBP3u4V8h?=
 =?us-ascii?Q?yErEsgWgC9cwQT0LTemTeLx4qf+c4GFX2ro2JFFayVhCmSwGSf0yjlTr5hA0?=
 =?us-ascii?Q?kIMquaea/g6BXAmTNwCWIomLskq3VOVyfOkb1VHWg6H0dIZqyQR/V38CcqIb?=
 =?us-ascii?Q?uMMn90uZ/wRXcXLwcbpKjp9XiV1qDRC+nzP3jMzj8bvZ35iTRLc6Hh8LY68V?=
 =?us-ascii?Q?jJKG74V6AuReokGHwFKSG+HBuiWw0tAVzx8NnB5sOKAfVY4SBo/titEzeEmi?=
 =?us-ascii?Q?N/jMMuEuOkWnDr3ntGZ+pkKfwmp8eVyXyuyC8tDeSYsRw++uXehdAc4igR9R?=
 =?us-ascii?Q?aUb97II5FoOk9sucGx6jjgWBbF9AxLvvtBY802tNripmLagHKmGjnrQLex/l?=
 =?us-ascii?Q?Pxzr613lpKiT6GiW5h/ejoJFkbA1Ljx8763pLsZqPrA1lCy2xrRfFEZ+sqQM?=
 =?us-ascii?Q?Vrw9kSV2dRq5lQfrXlNxHbBtAmYLANSObdS8wMtZEkjR39K8tR92/bk+YHI7?=
 =?us-ascii?Q?CAn0GPOSOp7Cl+wumLHF7ferKzFyd3aBqgQPWrmdpMOC7MgyvldW4faiCr+n?=
 =?us-ascii?Q?5tEos8C50FQ3oucVkQ010oNGef6KoF61hxqVz4Xnpj4mYqO8DqQ/bo6qWF3l?=
 =?us-ascii?Q?NfRW5Is43yNKT5A5qXiC6zrrW/x1JNpOydVey1T9XvEhRxO/QfHXRO7st1kw?=
 =?us-ascii?Q?ZlE1QIl2meekTJ79SsdFLKbmU748snryehgmxNjkK2JddcLkjlRPRoNvXFN1?=
 =?us-ascii?Q?t87bG/zj2jUsia090AdIxdKxZKKDY3lr1fGDmsAwsQFlLwo6H3F32B2MO75G?=
 =?us-ascii?Q?G+2c1I6O7/9ZTATVdYzlnl5BQ6jq3eBNwIZtGPeDfKfNG0Mq8wLjakWm+Rkh?=
 =?us-ascii?Q?nYvYWkxaxO0aD8qQp/wl6H12VzDDU/dKm44MVptV5zZFUH/PVvy5DaNZ0x/H?=
 =?us-ascii?Q?ne0f+PRftluoi+3pbdUc/1DG8iI+HrcV5vlRoGYgKZxyen7jkYqAlP1nwrCQ?=
 =?us-ascii?Q?66mD4MVSo20F/sR/2PzowZrKfQtvpAM0TjVNXkMduJ8Cf6FLxS0+GFB1yTCn?=
 =?us-ascii?Q?tXk7kiEPyV9WAH7/1QnNRaEmZ8qTI6KJanHIlY4BLOQIYhg/Iq9TbRw86PiG?=
 =?us-ascii?Q?oXXqm1EP8xgHYcGgsQt90z74VBjrUYZRoVA6vHtMgtCMBZRU2H+uZD7/yLdp?=
 =?us-ascii?Q?BDx//wkYlAG8eW0qLKzu7O4JP/iuzJiXAVWqaUF1I1OQh3qJCPj9rHfnnZm4?=
 =?us-ascii?Q?AzikrgBus0qoRHWdO+2iNTHI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc4890f-3811-4637-db96-08d935672b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 10:19:06.7491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSLwIriPRJJ9yPGnIuSXoDZ8HvClQ+TkfetHcp/oQzHLUMvrxuB5jWiMoJivbIDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gong,
 Curry" <Curry.Gong@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, June 22, 2021 5:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yu, Lang
> <Lang.Yu@amd.com>; Gong, Curry <Curry.Gong@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: move apu flags initialization to the start of
> device init
> 
> In some asics, we need to adjust the behavior according to the apu flags at
> very early stage.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  1 -
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 10 +-----
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3f51b142fc83..e6702d136a6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1359,6 +1359,38 @@ static void
> amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
>  	adev->pm.smu_prv_buffer_size = 0;
>  }
> 
> +static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev) {
> +	if (!(adev->flags & AMD_IS_APU) ||
> +	    adev->asic_type < CHIP_RAVEN)
> +		return 0;
> +
> +	switch (adev->asic_type) {
> +	case CHIP_RAVEN:
> +		if (adev->pdev->device == 0x15dd)
> +			adev->apu_flags |= AMD_APU_IS_RAVEN;
> +		if (adev->pdev->device == 0x15d8)
> +			adev->apu_flags |= AMD_APU_IS_PICASSO;
> +		break;
> +	case CHIP_RENOIR:
> +		if ((adev->pdev->device == 0x1636) ||
> +		    (adev->pdev->device == 0x164c))
> +			adev->apu_flags |= AMD_APU_IS_RENOIR;
> +		else
> +			adev->apu_flags |= AMD_APU_IS_GREEN_SARDINE;
> +		break;
> +	case CHIP_VANGOGH:
> +		adev->apu_flags |= AMD_APU_IS_VANGOGH;
> +		break;
> +	case CHIP_YELLOW_CARP:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_check_arguments - validate module params
>   *
> @@ -3358,6 +3390,10 @@ int amdgpu_device_init(struct amdgpu_device
> *adev,
>  	mutex_init(&adev->psp.mutex);
>  	mutex_init(&adev->notifier_lock);
> 
> +	r = amdgpu_device_init_apu_flags(adev);
> +	if (r)
> +		return r;
> +
>  	r = amdgpu_device_check_arguments(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c index 455d0425787c..1470488a18e3
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1275,7 +1275,6 @@ static int nv_common_early_init(void *handle)
>  		break;
> 
>  	case CHIP_VANGOGH:
> -		adev->apu_flags |= AMD_APU_IS_VANGOGH;
>  		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>  			AMD_CG_SUPPORT_GFX_MGLS |
>  			AMD_CG_SUPPORT_GFX_CP_LS |
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index de85577c9cfd..b02436401d46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1360,10 +1360,7 @@ static int soc15_common_early_init(void *handle)
>  		break;
>  	case CHIP_RAVEN:
>  		adev->asic_funcs = &soc15_asic_funcs;
> -		if (adev->pdev->device == 0x15dd)
> -			adev->apu_flags |= AMD_APU_IS_RAVEN;
> -		if (adev->pdev->device == 0x15d8)
> -			adev->apu_flags |= AMD_APU_IS_PICASSO;
> +
>  		if (adev->rev_id >= 0x8)
>  			adev->apu_flags |= AMD_APU_IS_RAVEN2;
> 
> @@ -1455,11 +1452,6 @@ static int soc15_common_early_init(void *handle)
>  		break;
>  	case CHIP_RENOIR:
>  		adev->asic_funcs = &soc15_asic_funcs;
> -		if ((adev->pdev->device == 0x1636) ||
> -		    (adev->pdev->device == 0x164c))
> -			adev->apu_flags |= AMD_APU_IS_RENOIR;
> -		else
> -			adev->apu_flags |= AMD_APU_IS_GREEN_SARDINE;
> 
>  		if (adev->apu_flags & AMD_APU_IS_RENOIR)
>  			adev->external_rev_id = adev->rev_id + 0x91;
> --
> 2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
