Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05742606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SHgFDwSh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975FD10F9D5;
	Wed, 28 Oct 2026 06:33:22 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB2F10F9D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 06:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntp/NcbupeEFtbodkAP5crU0WX9ucPj9TsOTCQml/pPV8RRd32vzGol3/klY8EQY++U5vzmKymPgrN/imkydgnE8w38GXVkSoE9pwECrrg7KbVlw74fo6J4IkGyWZyiGTYEsPMMBrYJvhpbtrL900b36w5cxqWYvdhpA4GvcH7pgewbf5FNP68182yPpImIfFNmquGfl6KSdOwNbCJpKRfpTZBCZbtWfv4xxnojCULpUC1eQOkkHFAOznmyTOBRBs4rW7n5ubHfY53voZ23lxxisqKjGV9D+vW0KHf2oGA3xCWZmi3CTSnQTEgHI8rZzMIQXYfZs3XrxbDIki7Cv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2u79/7zwtt99hbXAPb1/MKffQ8TVkHeX9Czgq18YfU=;
 b=vLhJ3nxDq680wD5obpjdQnDLq1SofrvDFkTLMIuhpHwuKgeBUDt4qmYdC7oxDyhyaXFzLnw6f+BSVc75m8X3f4H4PIvlhT7C3u64LyvnoA5Yjm+ge0+9I91KvR5pL/599SbsTwjtrsG7I8iqwrQH0Lz98e8W7dBlL2EoBRvcrOd+iPrZstfICGlxN9m1i6DmGfBnipjpjGLmVJHG7ksqKra52nu/KhH57/Ulpla7zaoUEbpUiNSwavSKJjirUt+KlUAeXv8zfjNPlVMPpW/uqN9c1xxwU9oyXIVcjMW8AFqmlW1Kmt0/4bscc6Bjr3m4pn4r8ep0Vn++kHi4+OLNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2u79/7zwtt99hbXAPb1/MKffQ8TVkHeX9Czgq18YfU=;
 b=SHgFDwShKyB+naegdPjT5Ct3PpqJu3QZwM6AxXSKVZ8MLAvXBmvl+UnqwCcCyydowJ+APfZSVnxaqT+EVTamwOTICpLuvDTh0DayR7YUuKECFb4C0lyD/hBxV8rI0Vc9sZUxLUW2X5edahkSRvqilfkC60giHh+2xEiGdu2hOnI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 06:33:13 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:33:13 +0000
Message-ID: <859ab8ce-6f32-4e10-9e40-1d007ca2a714@amd.com>
Date: Wed, 28 Oct 2026 12:03:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 6/8] drm/amdgpu: Enable UALink loopback mode
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-7-mukul.joshi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261027195913.1794477-7-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::12) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c7b48e-5d3c-4616-5fd2-08df34bd576e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261026140227099003|4143699003|11063799006|261021123027099003|56012099006|261021121427099003|261009223027099003|261022105027099003|10067099003|261022075727099003|261026121527099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: Z3QLPnZtD+bDtGYrGn0EfFxR4XOQr9cHauGpBHGMfEE6WITNklhP22KMYceSbBKIYEZ+6u7dgx7mIdGibfp9R89RipdpVqJuq4q/09y9tPpQ2QpT3h/FYcjZulCm3QKGALdL+Tg7AaKqZObLwJrEstnX0taO30JRT8ADrIVApNHEJP6faE5dx342Lw8VartndYw9YP3rFfo6LqQEoMlZMnaD3wzxfWWTUAx0FRz3vAN2BBTyWnh7HGbPp2UTBidiJyE6b98Eq275NQUiTumw/TmEUTe/1jARx+Bi1JBkHQgoT3vs63FGFflqKQZPieUYUV+y2M7fYINRO1pffVMP0HEjCvvNGFVKThDwS10337I4OoG1gK0ejZkwVTzqayx5wKeC/T+/EcXVkvUWmU+MLyn+5JwT3Ae1ccsNFxZNd0dmMiLFFu7SOglVKVCV2OKZWjgrp/kEqk9lqMWxWrsXL5tGPYVdVsZBjdigFRNff+/hu6VKApmvJUVBGlhFz1vZjOzdFJCiH5/rau1XItUV5u8Nufkko9CuIonTSMj9+8rqcpd/M3h5uW8SLPoYKwwPssI2NwnZLRCVZjh7kC/J6fTj+UHuaf1GuSBhCLSKalkM+hY4w9OcbWbfCwc5QWNiUFavnoVpnSCIOPMk8DtmeAesy/XAD4FYySYnB6KZlPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026140227099003)(4143699003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(261022075727099003)(261026121527099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU90VXg5amc3OGhDUW1tb2Fjb0dpUHJkZFdHR0FaQnNDc29pZkxlbVE1d09F?=
 =?utf-8?B?WnNQeTZHY2s3NDY4VlNvWEMrL0IwYmNQNDQ4L1pDcXY0VHFHTW9KelhlYnh2?=
 =?utf-8?B?bXlmc29uaVZrcVpRemVycWR5S2VnWGdwK0orR2tOWVBONGpkVy9LcldZN0ly?=
 =?utf-8?B?SGc2Q1h2aGVtM0NLSmtpa1UxSmdRT0xsY3ZPWkxpMzkvWnhGYkdNeGk4ZDNn?=
 =?utf-8?B?a0pTRXpZYk94WERoVm9mZ0cybVZQTHJwS1k2MUNlODlGaDNkWHQ4UmczSTZH?=
 =?utf-8?B?MGtxUlM4WlhsdTRQZUNYODRNYzdvckR4Qm1aVWVlSWJiKzdQZTB6UUluWC93?=
 =?utf-8?B?NmNRRjk0ODFlc2hhb202M1FaR3ExRmJGOHZ6QzNmYTlURzd2eEhuZ09GYXRU?=
 =?utf-8?B?a1NnNjlIcndYN2M5aURYNnlBZmMxeDdpY3JIZ0h3ZG9lNmNKSUxaOThYS1RJ?=
 =?utf-8?B?bmgraHZ4Z3pxMjhrVlViSGJBY0V6QUd6REpvTUNGQzN3R0FzYkU2R1BqdHZB?=
 =?utf-8?B?bXU1Ny9USVd2SUJ4YzFMMkpYcXBZQmp3RFp2ZUdhY1B6UWtYSE42ZDVnUVZ6?=
 =?utf-8?B?K3FxSG1oaWdRMjlGdDhLQ3hDT29UcFRwamx3REtLejU2OEpON0VmTFYvMmdK?=
 =?utf-8?B?N1RLNTBwOVJCczBNTDViMERENUJ2SGthWC9kQVR1bWNSa2tsaUQrTll2dkRB?=
 =?utf-8?B?YWhyV2p2QUUxazYrZHZsNWJmR3pGeFhRRkVZTlBla2hFeFpXMnREWGdQMHdK?=
 =?utf-8?B?VWI1Ui8zTzdMdVl6ZTZwc1JMTkhWSmhpcytrRVhLekVSbUdXR28wWU5iQlpI?=
 =?utf-8?B?OFVIUFJzcFpOUGJ3M01VZlVBRGR5VmFTdWVGaUtGVXpiRUFjVzNPUVM3ZElp?=
 =?utf-8?B?UmZHUHltM2pIdElFV2dLeXZORDN1WnhhMUFyb1pTS2hZOThSdEVhV2pKMWF1?=
 =?utf-8?B?Mm1mWFVXd1EreUt4cFRyai9YVGxVa2ZJMm51K2pTRjhSUC8velJHRm5sSmls?=
 =?utf-8?B?OTczUEVpS0doc3BaOXgzOXdYbmFTbk1YWE1MY0xQVVZPajRNYWRURXZtV2dt?=
 =?utf-8?B?cmZOTWYyeEExVHhrMy9IUUlHcE1uc1lkMDZ5dk5QRTFNbGF1VDZxT0ZYUy9C?=
 =?utf-8?B?c0l4ekdHOGtYNmZnMXV1bTRHNGxCbGlycnlHaklqeUFFcjhNMUtzTnlGRm9W?=
 =?utf-8?B?dFh1SE1id213L204aWtQd2d5TjBxYitUVkVFZnVrMzZNRUEwT0Z6amdOK1ZO?=
 =?utf-8?B?RTBnVVAwKzZ0bWVwNW1VdzlNeDJqZTZCWnFwa084NXNKUzZjbTJHa01GY3Uv?=
 =?utf-8?B?L2dyeGVUOWdnU3RsVm8xU3l6eUxJVFRKc014MEJlNThqVFlOQ0xoQnJKeUUy?=
 =?utf-8?B?WUQ2L3kvaG45TGtMK2JCclpDaFZJcWFxU2V6S0ljMzBaMUppUEdxWVJCRUtx?=
 =?utf-8?B?TGNESGl0TjFrNTVnM0ozWm1GNTROTFduZDRrU1pZOWFOUEhSdXpDeHkzeUti?=
 =?utf-8?B?NjA1WTZKeWxlRTNaRCtxQ0VoZi8yY3VZS2RYdVVCNzB1K3Q5ZFY5cU1BbjZ6?=
 =?utf-8?B?cUVlTEM4VW1PYTF2VEtOUDRVTFpuUUswNzFnWHdJdlVBZm5OSEoyZS9zZEJm?=
 =?utf-8?B?VElXV201Umg1eWVYK21PN1hJY2t0VEovUlErR2x3N2dWZWdlZVNRRFZCZUtu?=
 =?utf-8?B?aktEWjJmZGtxMHBYMTVZdXBjTzRkSVlBc0lQc2FRUzR3eWN6LzV0OXYzVEVK?=
 =?utf-8?B?Syt3bytOWGhYYnNGZVBZZEt4YmptVTllMnJNQ2FkWFhocUhoY3lLZlU4dlJh?=
 =?utf-8?B?c1gxYTJ6QUJ6aENuaWUzZThSakpsS0hudjVDMzNXTTdsd1RqcjNjK1kvOEhh?=
 =?utf-8?B?OERWMXc2bkR5aDcvMDlXNDRmb0ZpdFdOdmsvbngzcjNaZ3VmSnp4Y2VLaG5M?=
 =?utf-8?B?cHUrcU1MWDNYVERvZTVhc1dnc05GTENrSGZmNGlGZlBLTlpRMlRCdzZadVl3?=
 =?utf-8?B?YUQyY0pPNldsNFZoR0R3YVUycVVoUGxRRVFwUkFIY1FoQXJ2UXpYZHU1VXdC?=
 =?utf-8?B?eWltcll2SGJsR0pOZmVPckVIQ2Z2UC85bU95cnNDdEptWFRqa09CdDU4R0NW?=
 =?utf-8?B?Sm00KzFyY09nKzc1Y211VHp5YWhLeE9XR3VQc25rbWU1SmF6aVRzYTRJU04z?=
 =?utf-8?B?LytEVEkreUs5Y2VPaG9nNjR6YU1hY2FzMm9WNmJKNU5rWU9Ib0F0SWhhbVlD?=
 =?utf-8?B?Q0Urb1BwZThqWEovVEpvMkp4VzNETHhhUkNCaVBLOXBLUnYyUzZPY2lEdEVI?=
 =?utf-8?Q?MadgqKZu71u2rDJdva?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c7b48e-5d3c-4616-5fd2-08df34bd576e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:33:13.3198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S45zaXHrT4CIskw34tNgZLdEbo6weWEUh23dZnn/YG2akgvEvvL+cJfEUzZnNv0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 28-Oct-26 1:24 AM, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter (accel
> ID 1) and the importer (accel ID 0). This lets the existing tests export
> a BO and import it on the same device, traversing the UALink HW
> pipeline.
> 
> Add amdgpu_ualink_loopback_detect(), the single place that decides
> whether loopback is enabled. It runs right after the UALink info is
> queried from PSP, before any per-peer setup. When loopback is enabled:
> 
> - There is no user-space agent to configure the pod, so synthesize the
>    pPod/vPod configuration with both accel IDs active.
> 
> - Activate the device directly instead of through the cross-GPU vpod
>    activation path, which needs peer GPUs and a user-space vpod commit.
> 
> The mechanism that requests loopback mode is added separately, so
> amdgpu_ualink_loopback_requested() returns false for now. The normal
> activation path is unchanged when loopback is not enabled.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 ++++++++++++++++++++-
>   1 file changed, 123 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index e6272446ff4f..14b9c05a0f0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -63,6 +63,7 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
>   						 u32 sender_accel_id, u32 dw0,
>   						 u32 dw1, u32 dw2, u32 dw3);
> +static void activate_accelerator(struct amdgpu_device *adev);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -93,19 +94,130 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   }
>   
>   /*
> - * amdgpu_ualink_loopback_init - set up UALink loopback mode
> + * amdgpu_ualink_loopback_requested - check whether UALink loopback is requested
>    *
> - * Called once loopback mode has been detected. Allocates the ordered
> - * workqueue used to emulate exporter->importer interrupts in SW.
> + * There is no mechanism to request loopback mode yet, so it stays disabled.
> + */
> +static bool amdgpu_ualink_loopback_requested(struct amdgpu_device *adev)
> +{
> +	return false;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_detect - detect UALink loopback mode
> + *
> + * This is the only place that decides whether loopback mode is enabled. It
> + * must run before any per-peer setup, since enabling loopback changes the
> + * accelerator IDs returned by ualink_exp_accel_id() and ualink_imp_accel_id().
> + */
> +static void amdgpu_ualink_loopback_detect(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_ualink_loopback_requested(adev))
> +		return;
> +
> +	adev->ualink.loopback.enabled = true;
> +	adev->ualink.loopback.exporter_accel_id =
> +		AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID;
> +	adev->ualink.loopback.importer_accel_id =
> +		AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID;

A better place for this is amdgpu_ualink_loopback_populate_info which 
fills all the static info for loopback mode.

Then you may deprecate requested() also as detect() is good enough to 
find whether loopback mode is requested and sets loopback enabled.

Thanks,
Lijo
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_populate_info - synthesize pPod/vPod config for loopback
> + *
> + * In loopback there is no user-space agent (AIFM / xncmdclient) writing the
> + * UALink sysfs nodes to configure the pod, so populate adev->ualink.info
> + * directly. The layout is fixed and known: a single GPU alone in its own
> + * physical pod, presented as accelerator ID 1 (the exporter) and also owning
> + * accelerator ID 0 (the importer). The values are made self-consistent so
> + * check_vpod_info() would pass and amdgpu_ualink_metadata_init() programs the
> + * importer's ring buffers / GART NPA mappings / MP nHT receive metadata.
> + */
> +static void amdgpu_ualink_loopback_populate_info(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ualink_info *info = adev->ualink.info;
> +	u32 exporter = adev->ualink.loopback.exporter_accel_id; /* 1 */
> +	u32 importer = adev->ualink.loopback.importer_accel_id; /* 0 */
> +
> +	/* Physical pod: this GPU is presented as the exporter accel ID in its
> +	 * own pod. ppod.size must be large enough to contain both the exporter
> +	 * and importer accel IDs. ppod.id must be unique within the system
> +	 * (matters for 1P4G, where every loopback GPU is its own physical pod).
> +	 */
> +	info->ppod.accel_id = exporter;
> +	info->ppod.size = max(exporter, importer) + 1;	/* == 2 */
> +	uuid_gen(&info->ppod.id);
> +
> +	/* Virtual pod: mark BOTH the exporter and the importer active so the
> +	 * per-peer setup (amdgpu_ualink_metadata_init()) programs the importer's
> +	 * resources for the importer accel ID. Preserve the address mode queried
> +	 * from firmware if it is valid (keeps source-identification HW working),
> +	 * otherwise default to source-aliasing (MI450).
> +	 */
> +	info->vpod.id = 0;
> +	info->vpod.size = 2;
> +	if (info->vpod.addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX)
> +		info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS;
> +	bitmap_zero(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
> +	set_bit(exporter, info->vpod.active_accel_bits);
> +	set_bit(importer, info->vpod.active_accel_bits);
> +
> +	/* Only the exporter (this GPU's own accel ID) is a local accelerator;
> +	 * the importer is reached through the (loopback) remote/NPA path.
> +	 */
> +	info->n_local_accels = 1;
> +	info->local_accels[0] = exporter;
> +
> +	/* Mark the pod vpod-configured so the activation path proceeds. */
> +	info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_activate - bring up the UALink manager for loopback
> + *
> + * The normal activation is driven by the sysfs vpod_config/commit path via
> + * activate_local_vpod(), which derives the local accelerators from peer GPUs
> + * and runs a cross-GPU integrity check. Neither applies in loopback (the
> + * importer is not a separate GPU), so activate this device directly.
> + */
> +static int amdgpu_ualink_loopback_activate(struct amdgpu_device *adev)
> +{
> +	mutex_lock(&mgpu_info.mutex);
> +	activate_accelerator(adev);
> +	mutex_unlock(&mgpu_info.mutex);
> +
> +	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
> +		dev_err(adev->dev, "UALink loopback activation did not reach ACTIVE\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_init - set up and activate UALink loopback mode
> + *
> + * Called once loopback mode has been detected, after the initial pod/vpod
> + * configuration has been queried into adev->ualink.info. Synthesizes the pod
> + * configuration (there is no user-space agent to write the UALink sysfs nodes
> + * in loopback), allocates the ordered workqueue used to emulate
> + * exporter->importer interrupts in SW and activates the device.
>    */
>   static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
>   {
> +	amdgpu_ualink_loopback_populate_info(adev);
> +
>   	adev->ualink.loopback.wq =
>   		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>   	if (!adev->ualink.loopback.wq)
>   		return -ENOMEM;
>   
> -	return 0;
> +	dev_info(adev->dev,
> +		 "UALink loopback enabled (exporter accel %u, importer accel %u)\n",
> +		 adev->ualink.loopback.exporter_accel_id,
> +		 adev->ualink.loopback.importer_accel_id);
> +
> +	return amdgpu_ualink_loopback_activate(adev);
>   }
>   
>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
> @@ -495,10 +607,16 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	amdgpu_ualink_loopback_detect(adev);
> +
>   	scoped_guard(mutex, &mgpu_info.mutex) {
>   		amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info,
>   						   cfg_state);
> -		__amdgpu_ualink_activate_vpod_locked(adev);
> +		/* Loopback has no peer GPUs and no user-space vpod commit, so it
> +		 * cannot use the normal cross-GPU activation path.
> +		 */
> +		if (!adev->ualink.loopback.enabled)
> +			__amdgpu_ualink_activate_vpod_locked(adev);
>   	}
>   
>   	if (adev->ualink.loopback.enabled) {

