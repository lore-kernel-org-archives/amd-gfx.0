Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B72C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFBA10E4A3;
	Thu,  2 Jul 2026 10:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHxGrjcd";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE17410E4A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtSNeN6sHCufsyHRHhE9HctQHtQj1qB1peW0RUsgDjo/gpHTwSfMoNFdKXZkwANVuHKZEHhMphwZKIfbXzVwGtcNzULYKEozEXQ90L5Pot0p9vcJpF8e+gTIi48PLKrhUAJy7cHNBQEOXaJdqEh+Ke9kFNlk6UxwPjgz8fIFUeKOCCzJigCGFyZsKzO8r2EMmYW9Z8RlRUTquLUPFgxNr4OxbodPSZYjKraGVgUXkW0aKoEhTLUggztS+srT/MJiN7d7IWsiSf7Yu2MadLOdxJz7Qt7u/9yW55ZJayuEfxw7uT/84grRb5bIXoTfiBdSKlXvkVzjG62ndX2PeZ0s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muctr6vSt6CnA6ZmFSaBBJkJtNBpQORK+/g3f4lFX9E=;
 b=oDrWMelHR7QmvFvNYjFc681TUip8SLtRLdZ/9HrXKJ2JS1HSGPBnPTUkRJScrRsulOwfQ4hSmysTPpL4fRvTGPxDW9eju2gJja42XzJfyhy6niy7JnpBL3u5/0OnT1FFFYGDcpFMFgejKBvMOMJWSTUOurNFeV6a2vWd6wG/yG/7jpq1jlNoefGLUqAijRovKFMCE7rPAfElU/B48fzhiOGjdBTAlFK+/BZdbgZpVHdqnpa8mxzpzNPECQln83cfqyFSm4zJxnNiDp0ZOWW1w1uQHaQdkscK1EGDRT9xLSdp53Uc4IQZ6NsvYVVv/EktBRth+MbGr9o7CPPoEVwVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muctr6vSt6CnA6ZmFSaBBJkJtNBpQORK+/g3f4lFX9E=;
 b=CHxGrjcdKCT3Lk9Skin8JZR7AiaDaETuk6UUO8NHYlPU31S07+kLK9e+AePltkRussTEtGKPZ1frz8Z6gfqdYeLYdIq2NlgHfyaP8GBQRFEb3mYKtJI48ps3XKyr/MZexe067rgY/wFLusFN9yDjPWpVeS8Q4vS1ri5WqvS4Uts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:23:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:23:47 +0000
Message-ID: <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
Date: Thu, 2 Jul 2026 12:23:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-12-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 18082fb1-4345-4763-15f8-08ded82400b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: n8fgaij79ejNolypIWy9BbnD3uusSOmDqpwhYhqh5bVFU7T34zkt4Sh47yeDxbBnue6QvgCIRnaadTwpA8suMFhtLX6E+p2hkXSlO+OCrRpBtd3Z1JvVtDxGEpCiNhIGsWYumyZz0FiT+bi0DFBQIPZS5YI6KyBFiSs14iOi1Ll/Py9OhkfV8GxMEyPONcr2hbvfR/uNLQ+qVGZx94mPujBcZOY4k65lusW7hMLnwLzgB1ZEKRFs7669Zq3H1bX0+6TzBuRvE0+DKcEfjjTIiuBi/q2AO4Kp27GABtBWkN+pwLngMpm/rRVNUKtVyDIAYappZodkc+BqIP8ktqVMb0F9tquiOnmX/ATqiB7mi0Xaedp3bjUNQfKghKIbgEOejo0qEgxWWjnj/Adathyj0rlYyO4qxEE0HdwFxLFJ7xJynkLRwakE6PNQR5z65aiY6nGwobUuSqCloEqI5nk74jXFpRAcOEPdwqOAtHSZWfS5znYqbTvqWIQZHhtuPzwDY7cNiU0sRb+bMMwxfluzsuuKeQBoeUZ/3JzW5lYi3jB+AMqFVU9OLFS3k4gvaJa+V5wMN7Gii8fOYR48N7dH6QjoRSS0JoHpK8Zokdt0WWKWwfN2X8xFas80jO8ZAu06Vlp/76qqDO3K0BkZjyHce85PTZdrCjisCDfCSoCp9s9FAhGKyXp7Fy5EFxOyFWYQLxCu47GjQJnJx/TEJr5Q6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZ1aFNWSGFPa3ZEMzR2S2puenlTTUsycTcxcTczdnlla2FqK0lEY3Z5eTAr?=
 =?utf-8?B?YnhjMTQyL1VIVm8xQ3JNWVJSbWx0ci9jbnRteHJZRUUzMzNoaXBCWHVCaGNL?=
 =?utf-8?B?MVVRdk9zZjZMR0t0aHNET095VkIzaGMvOUlHSjZxd2hqRmdMdllRZC9qaS8v?=
 =?utf-8?B?cGxhWnFSTWoyT3E2UkU0ZFM5VTgrcEpJMzVicHp5c2taRDI3M1VrWTNFaUha?=
 =?utf-8?B?YkRSL3F3K1dBeXdFOWh4TnZZVmRMejVBMnJsWU1JVTBhKzlqSHJLOXhtM3Mw?=
 =?utf-8?B?OGhnZm54T3hUeUdra2R1Zy8veGVTR3NVS0VaOVR1WjhrcHJqc0RBK25JWEw1?=
 =?utf-8?B?ZHd4Q0dnWW1iNVlkQVNnZTJ4VFI3Sk9HdzRkb1FpSEkrRjloZmgyUDQ5bW5T?=
 =?utf-8?B?bUprYThWMTBBallSQmlMaXRSUllsVTdJNzB0M1NwYytpaCsyUjg1cXVRejdT?=
 =?utf-8?B?ajhqc0h0WEwzc1k2cElWdUF0M0Z5ZGhFZVB6ZDBHZE9sVFpPVDRFbkltd3V0?=
 =?utf-8?B?cWxoYWxObjN2NGhyTlJqREk1cXpwVHB5bEx6bVA4Ym8xaE5iKzZHTU9RbFJC?=
 =?utf-8?B?VTNlSUVyeVp1c2tvanE2aktZaEhFMlZEZ0xPOWphZkVqU2JGQkRrT3A1UVo1?=
 =?utf-8?B?czJFRm1MSThhWDZRTHczSDUxSWMvcWdYTGlYcFRZUFkwcHNkQngyajZhZUVU?=
 =?utf-8?B?RC9OckJNTEpBS21OWkhBYUFqNzRFcnU5NlpkTTZIcCtvTkxXZHVnczBLQ2NQ?=
 =?utf-8?B?M3VCbnJUdFJNMCtzWUQ5eGE3OWJ1anlpMWpCdUkxYnFQSXB2TityWURUVXpL?=
 =?utf-8?B?ZDhVTW5iektCNWc3RzFoWFF2L0Nqdmt4eXZ6N0hlQVNzdUowUjh4WndYV1F2?=
 =?utf-8?B?RTZuTmdhOEpmVTlrSVlnbEk4eklCcW5xSzdLUGJHREQyemlYcGJIVlN2RjVJ?=
 =?utf-8?B?TGlEajJJYjJPSmhjRnlqSjdRaWJKZGFXcm5CdDZtSkFBQmF5NDlld1liTGow?=
 =?utf-8?B?aGVMenl0M2tGUCsyWEVnMHNwdXduRjlJZzljQzYzcTFBdDB1cnF6S0xBOXNi?=
 =?utf-8?B?V3Fub21mT2l3VWRPQ2cwREJ0T3Y0Uk9tN3lMRHVYRHg3K29uSC9GNTBENkU1?=
 =?utf-8?B?bFpyQ1dWM1pOSkdNbDVyL3E1OFFkbGgraHl3V3cwb2t2bE04VzZ3V0ZsaWdZ?=
 =?utf-8?B?NW9oVTBXR1g1M2RJbmZwelpybmF0Q216WXdLYmJYWWRCZ3RldzIvMW9vZmZU?=
 =?utf-8?B?NTczVW9WMG5pUjIvcFgzZVVBVmRVendkVlZEa0dOSzJyVDA0Y2Y5bXJLOGtj?=
 =?utf-8?B?RlhYQkpVYzZ1dzZWckNiQW5LYXJXSUI1bEl5UGxMZ2NRZjlPbFpjVjRpVW5U?=
 =?utf-8?B?UURDU0k1MW1wenRmWkV4d0d1MUNlQTNhRkNBamlCc2FGMVloQTFvMW5BY25p?=
 =?utf-8?B?ZytjbjRTOWpiZ05qcTJ5aGJ5ZXRhaXFQbG03VW5JSTNSRFZKQmVNcGFLQWxa?=
 =?utf-8?B?WXQ1Mm1XcnJyUTJXeUVKeVFCL0VRM29XNG9VVTZWKzl5UmJGcTduOXBRL254?=
 =?utf-8?B?VkJtSDl1eCtoTFBlbHNDOUpHaDRyMnl1b3d0d1dnM1dKUnNPRWNNU0xZUXh3?=
 =?utf-8?B?U2pkeGRORTh6bWNFd1RycFJqQmpXa1VqS2NOUzZrMEU3dk41blhZTk1pd0Zi?=
 =?utf-8?B?MWM5ZzZJRHRSQSt3cTIvZXpRNjQ0Q3F3QkdvR21JQjk0YWxHbkFJVlZtMnRZ?=
 =?utf-8?B?UXZRQWZxUVo4SkpSc0hoYVRub092N0VPL2hqTmNQS2QyNWJHc2VFN1JwQmlJ?=
 =?utf-8?B?M2poT2xtL0RLV1NFMTZ2eXBJVXVUcnFlSWk3L2lDdDk5LytmN0Jud09vaDlz?=
 =?utf-8?B?Mk5KR3kwZFR0RDRDeVgxMGJyOVZuNTkzNTRnU2xwWVU1R2Exck9DaXpseEtE?=
 =?utf-8?B?ZXBFN202M3BGcWRLTEtFbXpFN0k2UUphbWl4d1o2Zy9Na3pFVUlBZFYrTHJs?=
 =?utf-8?B?QUhGQXIvSkNIR3NoWkZBbkpQZmtycy9TWUJocUNVeEN2elJaMW5nTloxZHRu?=
 =?utf-8?B?bVZ6YWVBU1JCUUJ4amw4Tm1xYjM1VEZDSTR0Z1VwN0dOYlhYOFVCc3JQa3ZZ?=
 =?utf-8?B?bllRK3RsSkpMRjRUY3puUmRFWTNvbXN6MDBLMEwzTWp5RElKTFpnb1Roc3I2?=
 =?utf-8?B?YVQ3aHZtR0NjamIyaU0rdGFSekhydmUydnZraHR6YWFCMzJ1aVpCd0F2cTB5?=
 =?utf-8?B?MTMxM3lXTjZBVUlldmtTb2IrYitCTGt2S01QeXdZWGhHWWxsdUlEeExvZzJy?=
 =?utf-8?Q?wUITZqYnHwFvT7hCnd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18082fb1-4345-4763-15f8-08ded82400b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:23:47.8434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZPXazqh0ChyAy/WYussZo/UuMyje9fajYdSoKlDEDtIwtSk6KbA7LnRCfrxeWlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

On 7/1/26 18:17, Timur Kristóf wrote:
> The doorbell is not working on Navi 31.
> Use the IH_RETRY_CAM_ACK register.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

I still haven't found any explanation why we use a doorbell for the CAM in the first place? Lijo, Alex, Felix does anybody know that?

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 65e5d21753f9..a97c85b0cb99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
> +{
> +	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
> +}
> +
>  /**
>   * ih_v6_0_irq_init - init and enable the interrupt ring
>   *
> @@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
>  	.get_wptr = ih_v6_0_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
>  	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
> -	.set_rptr = ih_v6_0_set_rptr
> +	.set_rptr = ih_v6_0_set_rptr,
> +	.retry_cam_ack = ih_v6_0_retry_cam_ack,
>  };
>  
>  static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)

