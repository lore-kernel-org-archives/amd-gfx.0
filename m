Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E190CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 10:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B078410E49B;
	Tue, 26 May 2026 10:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mgDn+EX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B73E10E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 10:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdbr9DdtaDvsHIzH27ARISvqJ/bNkUN8hRGDt+sYep6X3sDx/1bpRUa/+JaBQKnrA0EHIQpcKfxrtCD0Vpuk/a8r8jPVsNQtMDWb6VNkyU4MmpRhu21BXEdn0IYA6n3sLZKkYDWtsjgCYwsQ72GTMaIQ80KHGEhJhUdKZfOm2p9C2vqdJdLOZhCXtykTjL+hVQCO9mnSvYzYvbUgK0gSf9XNtqm2aSP3o4+TKKYE5U0iizlZoUAxpIhTYW34UVWUZBZhIsKub4r5XdAwQC2+WJlCgHvv/YBUJ20qPnnxeleRBKm1F7iOoZn74hOgNmk5f2wV71A6Xkk7NQYCL1T9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw0l3aw7DzHnY0hSpm8+fpi6je2jFXthF7pkyez9ULU=;
 b=Vnb7OeNLntkzlatLuEGQmpsZ7Zk13nq66wkvfOF6hEqi/Hv+Li/SoNJTrNymWCft8cjfXLlmQJnV7AJN8EJKYROdS0qVlHZr63b+BkEDB7NqywEcQJhsXWGRv+WIJWuXaMOxTMeOX5+5ojEMEdK6+czjLDQBkfZJuOWqcWxGLD19kFPAWbkQppcKdY10h+XDCqWG0XkNEnyGU7ORQo9JDSTWUYKMSgTzil6AS4DHGbDSD4VNpMGDIUDz7KKVdR7sC6fZ+Mi9QBp0Tj3m4vRSaJXF1PAMq4mStdj+6AQk1DmXJtUZtF0pv8lHkcUYH4WsPcWS8kcLnI28v432c6nCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw0l3aw7DzHnY0hSpm8+fpi6je2jFXthF7pkyez9ULU=;
 b=4mgDn+EXUo/P5huhHDxraN9ZaC8buwKH2cTBAkejAT/4XWN4MX2oTohs6ejcgcUZztiXiZbjypsI9crpIIPTRzdLjLS2qoViTJv23gm59SOAgKluBwYiV2fOXMk316971AHuUpknZcPakxKGX8bnvC3WEvl1BpKO+NIcVWGewsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFF62310189.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 10:48:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 10:48:29 +0000
Message-ID: <78e1b3d4-5e68-43f6-b82a-353fdcf22876@amd.com>
Date: Tue, 26 May 2026 12:48:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260526093210.55565-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526093210.55565-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: af54901c-b8ab-4f05-9b78-08debb14527f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|6133799003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: NgYC3iRC0WosZth/xadSYSfGBCv6TIAAyQKtjuus5K8UFGYcYV673gwyA6NyGGeirQ09KxeC7JK/atDidwRf7Ym85zypQ/qQBodumnjgceIvpEv7TNAfM/AB9YQ8A0YE1M6m0aAzH/UU2mA8yEt2t2pifsyjuO3FgzycsBKy3U+uBGrKgo68ge/3/ZCGgFrbU2D8knIoapY00iFUTXO35ENyyckyQ70mfxMwQI6fmd05LoytnXkKq54GvRCkvMd3VTB6T49kn74bTdvDrljfEAd5GlJPEmDGWD73bvLkammZT/tLGuaLZ4zP9eIPeNxcEDmxa9XJztmnHAdO2yaQg5XEzt9WjsH9hp0KxcV/B3vHcSoJovNA3vZKSKq8Z7+bF3Se/zuqKyhYG3Pso6bYmksBrDlHEwzRE/rbscn57Hq8XY/QUx/suX5eax9jhEAQ0Uvh4nZAQr868kRdwqfz25napnu7XAWqfBH0dQqM2vvW8bEgph1sb+/ltRp2cNPjlKAs7kjmVgdQ1CvLp391lbDlhVEUm5lKCjOF1zbfmU6CDvlYRxFbyLGezQK57RejBymRQikMJ6NGUq4cO8xYBMUPKUPHoS8dUFdFTU7ODW9XJO4X4zOvpwBeyVccnZswLJqrFDS6Nz6T8jHsrdSkWhCBC6cR1fwi1S3G6iBLqF3qUZxQrO5k/CkUdLDuQ/5g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpZQ0FSbVlGa3UrWEdKYUtzN2ZualZFZ1hTZm9Damp3TG5hSTJ3NFpCaFhs?=
 =?utf-8?B?RUFLK3pHQmR1ZVBodEt4VWR3MFZwaXQ5U1JXWGNqMWsxU3ovaEdaQ3MyemlR?=
 =?utf-8?B?b2g4VkJJWGVMYzZkUlEvTytpWUUyQThjZTlFSnVXMjdsRi9BZGwzbjhDbkNu?=
 =?utf-8?B?dTJjYUdVTGlvQ0IybnBTdzY1N2xqZno3VzVPdUlOWEw0ME1sSlhTSDVCbGNK?=
 =?utf-8?B?Z3ZuSW5GSCtNbGt4QVAzVzBMTUtMRHd0OWEvOWVPTVRjNUNpNFc3N2FkT3hR?=
 =?utf-8?B?dUF4SE8zNDR3alNCL01sRzExaCs2Uk82QVpOTFBOZG10VkpxWjI1RmVhZ0tn?=
 =?utf-8?B?SFhaUnhzTE9qand1ZGE1K1p2UTdaS3JoMEpLSWlFN2krdTY3eGNTZTNCNlgy?=
 =?utf-8?B?NDI1MEU0R0dsWUdMTU5ZKzQ1cjdTTzBQV28wa3V5THcwaXFPNFhLRkRkS0ZB?=
 =?utf-8?B?NWlZR0NYMW1aM1FvQy9meHlRU3BjNEt0Y0VzNGhTUDk0N09VelAxb1N2TUxw?=
 =?utf-8?B?QlVkbFFLdkVjQ0dOam5mNUM4cExvRFNFZ20vd1ZYMTMzUUtEeEFkZnFPRjNo?=
 =?utf-8?B?VUF6d3pKeTFqVzgvTkxkZWZYMmlXU054eDc3WG8zWis1UHJUWm1yQWtlYXlw?=
 =?utf-8?B?dFlsbTN5R3hZODFjWG81WFZtN2ZOcmVpQ3V1U0ZMeWZaaVQ4anVlcXRJMHQ0?=
 =?utf-8?B?Zm9MNElOK3ZCUU1LcDZQdHYvbUtCWUhJc2dINytvVDhKVHNJUnNrQSt6OS9K?=
 =?utf-8?B?bDRMUmlHekxXcUtlaC81dW9LMHZYY3RNU3JGRnlTVlpyNFFsZHkzMlJERXky?=
 =?utf-8?B?REFEMFJzUjhYL21IOUx6RVZ5Q2dSNWNwUDZIY2gxQURjcGJ2Mkd2bkx4Wm1I?=
 =?utf-8?B?cDBkQ1NPeDh4ZURVSU8xKzJDMzJvenFwTi9RaDdNdGlQWG9VRlhTdFh4cWti?=
 =?utf-8?B?VXlNWmlxaTFHMi9jeGFGcXFqNk91YVgrS2NpdXFWSkE2V0hJUEp0MkljTHgx?=
 =?utf-8?B?U253Q0R0Y2hobmN6ejFDbDNLL0lBcjhPb2VtTEJJR1VGQm94WEgzN21PU2M0?=
 =?utf-8?B?aTNQVGJPTDBOenM1UkRjMkdUT3VFT0ltZ3IxbkFaTkxHOHkvMGtaQTUvRThX?=
 =?utf-8?B?cmZPbW1WUGVYbisvVTk1MU9ZTEVJR1U2clAreFFLamxHc2pOTUtxTUVHUVBH?=
 =?utf-8?B?REgvWjJOT1FTcmwvRW9kOHNwT2RkUUFLRW1aZzhLT2phTGc4djRCMUJnTFdJ?=
 =?utf-8?B?YW83T0VxQ1g4eHd2bVpTUVUzVm81ZmtZQjdqcFlrNUl1dDlKZTZ0UUx3RWRq?=
 =?utf-8?B?QnIvTFkrY3hEWDNJMTA5RUZQbEVyTHNNYlhIbUpIMFNERW5vQ1VKM09Ub2RT?=
 =?utf-8?B?akZZZ1F2UlpNdWpWT2h2Z0xJbWo3MUI4Q3RZamNIR1M1NG80R1c4OEJCSjZO?=
 =?utf-8?B?eUJXWnZ0OWJrN29ZS0RZdkJ1cXJwTElqVEE2Q25BaWxTbzB5cHd1M2hTVUxE?=
 =?utf-8?B?OHoyR1NGK3BacE11bnVoRjNaSmFjWC9XTEdESS85Ym1mWTlJc3VXdUhNRERR?=
 =?utf-8?B?ZmtHRXpETUlTWityTjZZUUliNUd2TlQwUndzTlRZREcwR09odE1FMTFHTEs0?=
 =?utf-8?B?d1VQWUduMnN0UWVPamdqTEx0ZUxlSXJtdmVsdDEwZHUwQ003YXdrRFhHMTRL?=
 =?utf-8?B?cG5tMjVxTUxvUzllY2FlUEJrcmo5M0NPSlA0OUowRzNXbis3VzloYWh6bUdO?=
 =?utf-8?B?Y2VyTWZlSkNsYmN6cXc5RFoxU3dJaEptMXJxK0tmdDFtSWFPcDlLTWM1Uyts?=
 =?utf-8?B?cXBRNlVzcWVPRnRxU2pLc1M2TzdwRGdwMS82K0Z1SE05UTRUYUMzeDdTQzdv?=
 =?utf-8?B?a0pJaTlBOEZKYTJiL3J5dUhKK3dVU3lNTlhSa2c0THprWS9MSE12MTZqTW55?=
 =?utf-8?B?aDhpbkVBQStsL285dTZmTEV0b3A2ditmaTVzYVNNVG02ZUFGaHJUUm13YnRx?=
 =?utf-8?B?b0NwUTlHVU0zYmlyS2tad1ZqcWJyTldpaDM1NjgwQ1Jtckxxa2lNMmJuekZ4?=
 =?utf-8?B?ZXJMdmU1TWFJbmdPWHFIYWd6OE8ybWxiZ3IzN3djRllFeVdIM3oxZmJOc05j?=
 =?utf-8?B?MC93YnIvamg5VVc3ekorTFpzSzNEdmZaWnZaRGovWFpMenVDZURaRWx1MnRm?=
 =?utf-8?B?WlFWSzZ5dThHckROcE02ZVdIcUhzUzZDRXVUNXcrWDZUd1ZRSUFiRjhSaE1n?=
 =?utf-8?B?M2xBRVRnRjFXS2ZvSDR3SXMwaDIzbkcwZjVHRnByZlh5ZHZCS3ZMeG9vbHpq?=
 =?utf-8?Q?i2WtC+Ba4w6EiSC5gX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af54901c-b8ab-4f05-9b78-08debb14527f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 10:48:29.2936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB4Vc89KmevZF7E6CZ4Atl09UH/5Zr3PbCgengYuDJ0BhwmLg/+Wp7Co42KVEV1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189
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



On 5/26/26 11:32, Prike Liang wrote:
> Avoid xarray extraction and temporary array allocation in
> amdgpu_userq_fence_alloc() when there are no pending wait-side fence
> driver references. This keeps the common fence emit path cheaper and
> efficient.

That's an absolute corner case we clearly don't need to optimize for.

In almost all cases we should have at least one remote fence driver here.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..2a2bf13a513d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -226,7 +226,7 @@ static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>  	struct amdgpu_userq_fence *userq_fence;
>  	void *entry;
>  
> -	userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
> +	userq_fence = kzalloc(sizeof(*userq_fence), GFP_KERNEL);
>  	if (!userq_fence)
>  		return -ENOMEM;
>  
> @@ -235,6 +235,8 @@ static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>  	 * used as size to allocate the array.
>  	 */
>  	mutex_lock(&userq->fence_drv_lock);
> +	if (xa_empty(&userq->fence_drv_xa))
> +		goto unlock;
>  	XA_STATE(xas, &userq->fence_drv_xa, 0);
>  
>  	rcu_read_lock();
> @@ -256,7 +258,7 @@ static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>  	xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>  		   0, ULONG_MAX, xas.xa_index, XA_PRESENT);
>  	xa_destroy(&userq->fence_drv_xa);
> -
> +unlock:
>  	mutex_unlock(&userq->fence_drv_lock);
>  
>  	amdgpu_userq_fence_driver_get(fence_drv);

