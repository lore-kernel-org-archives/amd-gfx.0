Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2592C9833F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 12:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67ED410E5BE;
	Mon, 28 Sep 2026 12:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6qvgtuI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC9810E5BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x38ZBtQkuIqWmte853+pueNb+P43aBZKo0IgH9QMU+qnXJ2aPka8qtXoMkXnjzp1i/M+At3ys68fJNVfI2pVjU6Q4kRWG9it5iKSOA+45vnNROcmsxKMx6OTik92dOHCvCwwKuN+OkZq2iZi2xo1tSS0IWYiKysearWHcpHbeLR8GTppHmhgoFpgc+GPk1G8b9+hIKoafbxtgsdg8mtLMzSapz7xnEdR8IPAD8unspjgStr1Xb/0dlfbRkCm2pISY2POti+PX3uAtrjJB8WZVnWF5kC/KCEpv51Zqs8wjMgrxKjMx0cAz1VvyCj08eBTranatpLdEzOOUONwqHS6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaE+azql5REINsl1jfCaZNY91p+AnFHCN6opJAkhbao=;
 b=T00S5y2afvjeJ2Eg7/Im2fVetTaFVLbxc6LQCKDKI3jzCiD1W0FoX31OM15X11Cg6Jg4G8C6WhudJnmkMRpM2Ndi5IG/x/PhsFx/3gmU6sDuKP5CdI80fZepmeJ9P1QM0x59KZLj8McrlVrJbNIDVUH9rZ9lQNgFGWVFXXGWYxtkKkzdWpnOjOEdOvLQfBytmXDDidWv9THVYIgF95ikL9O9EZ4Ho/M64gZ1hXK0licTaBQ+/rnKgDOKp6KClVVtArC8Z2m1q64gh8Cyg49M0xFKUFC86JkKPp7nO4aM17jJsE6J+z7F939Z+Ub1/b/koXCuPBmIczpZ10p07Q97lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaE+azql5REINsl1jfCaZNY91p+AnFHCN6opJAkhbao=;
 b=S6qvgtuI6hBeg/QG+aXH42/xBiCZpPc2gpbuKbYrcYoLxcguOJzqB43ZWNJVU1QxY/ubTAiFNKg5GzZJ4ACJ+WraIGYJXpqSo5JWnF08DVa2UDPKQ+brA+RElmEpJj4vIoDp+5n4W3PxdDV3IZHmxmzV5NRdhPQvBJWyl0dpENY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:54:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:54:13 +0000
Message-ID: <c2425078-8c5b-49ef-a3db-f6795a1007c3@amd.com>
Date: Mon, 28 Sep 2026 18:24:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Shaoyun.Liu@amd.com
Cc: Davis.Ming@amd.com, Gavin.Wan@amd.com
References: <20260928103155.843597-1-Victor.Zhao@amd.com>
 <20260928103155.843597-2-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260928103155.843597-2-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2efda2-2035-4e8c-e84c-08df1d5f98f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JVR8Sjoo2J1qoUS0q1IFVKuMl/CCgqEXAMP30GEcCvmIT2pvQqQJ2qBHQfSDIJb6TaOUWMrhm6DckI1i2qMXrZCylQJ9QcUub8Gj7u8ZNABZwCiG2EsKEha+BnDhYZJp9K9hipkVDj9SLEeGHSqY+a/fjnwPL8Pso+m/QtzZGLqEPwCoyHvbx2YeHd1om3zaZWfLR8A2vbQH3Ltc+JhjH8dvoLmWCXf610Y7u2hven/LN/T/k98thiCxnuoyscEX6FDibTwWUXN37zma/Zf8usa2YMSK3Zvu98hMT4M4P2lS5ttXbvZeZIit0hCvB9xOH3b95VfkarsZqDqySKgPEL/4QLrdnv7FEMcv3aQPqJiWnVc0RZHwWNwFR70FyHJXcMKL4OYDffltfNp0oxRYXYY3aXUlq7kou1uwh6y0L+Oeg7HRf9F0Cge4kbqnkT19/A18vBfY4vvDgRHcYM5pYBPVnKFokSjgSzJkmkM96eYKvTvuEM9oUyw3LXx9MROHMr62B4aw1TU+7VKW5AfXlLEpQ46bkddA8IA50PXclbg61IiSQ3AqSkTvcs9H8b3NGdBpbuAcE2eH412DybydPfTagEIwfMTcsRr8/Vu1ail+0As+nEReTN1isSZPeb69IWKbCcSBkysV/RoqCJmx25MtDwYk+V19F0IOopIvEj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxuT2IwbXB5QnlvckhkTDlTZjVhZUY3QXVwb0pHb1VNdEUrTUxrZmtjendx?=
 =?utf-8?B?L3JaUjA2NnBOanQ5R0pldXJjcmplZ1JBL2JWWThyRXgxZnJ4bm5yTGFGK1Rr?=
 =?utf-8?B?Y0x3UTJreFhXb2NyWHpWQzBTVG01MTIxeEt0Sk5KUE1FbXdYbHpKZUJ6SERY?=
 =?utf-8?B?ZDNsVHB2N1d3T3NzVjFoczVrd0dvbG55MDdaM2grN3FrNVN0elZOUklUYjVt?=
 =?utf-8?B?MkdyM0JmRERYWEtZTC9CaVR6M2hvcEg3b3FJVWpZWmhvRlQ5UmpkOWhZRk9M?=
 =?utf-8?B?SHQrZnBqN3BKbkFuWk9VOTlxK0NvbUN0OGxIYTRlejQzejFGZXpDYW8wSXUy?=
 =?utf-8?B?bjkxbEcrNWwxWGlXbXJsWkdiVk16S1dGdTVjTy9QZW9TRzdMOHhCancyQmlF?=
 =?utf-8?B?TWQ1b3I5cXZjalhNejVTSmxGbXZUYVQ3WlJJTWxwdkh2R1REdm0wUzh6KzUr?=
 =?utf-8?B?Q2JTS1EvSCttbVh5NXVrVUhZODEyWXA4bTgwaGZJVG5VdUJybVZ4MTh5ZFYz?=
 =?utf-8?B?Q3VCQ1VGTWxSNWx0Mlp1STJ3MisxdnA4UXo3VDRHYmhMMWtXYjJBRERWRVZH?=
 =?utf-8?B?am9VU0VHNEF5MkNjbWozKzlMZFVyMUFkNVN4WTNSU2xYcHBPa3ppUTJyRVhT?=
 =?utf-8?B?akhhNDNhNkVPYjVyQjN1aXNkTm9hM0xNRFluenA1R1JxYmdvUmYzUWxRa2t5?=
 =?utf-8?B?WGVTeVdOT2FkY3lrcXJHNTYxM3BoWmIxTzVGeThhUXMveXlML3dRUkJYeHg0?=
 =?utf-8?B?TlRDVXp4OFRiSlI4YjJGOXR1eVh2ZDJtNlpWQmVDWWMrcVBWWFliWGxLRGs5?=
 =?utf-8?B?dkJ2UEdTWGUrbzZqdkcyZ1d6ZXlUeUJ5dUNnbnUyWVcyMGpzMldTVUNKVFln?=
 =?utf-8?B?RkMvQVM3V3VydTlNVEIzS1RDQW9ZcjZHSnJuTjkwMDMwL29zdHViRlFPZXRr?=
 =?utf-8?B?ZzhjTk1LMzlSRHIxbzcybUdBem8vSStoZ2VCVHNCYkdINTZJaXZFRC9ZbkRR?=
 =?utf-8?B?aFU5SitGL0ZTV0FDbW11UlZMUjdRTGJMVXF3YktvTnYyMUV2VnBjYnRPQXls?=
 =?utf-8?B?K2d4TGJ3NkNiQk5HLzZTdUFYKy96L3lGY0J6TE1GS21KdlgxaGRWb3VINDRx?=
 =?utf-8?B?QzF0b2Z4ekV2RlRuU3JzSWR4WVNSR2cxbi9QQWpyTFh0L0NWKy8wMFc4WUhz?=
 =?utf-8?B?TkVsZnMxOWVnb0srNkdJMTYvOXFTU0xwWXVDVU9GWlBuaktjRXQrd0JQekU1?=
 =?utf-8?B?aDBzVlh3ZkY3MVJCRk83ME1XSk5NQXV3WkNKYzhoQWl3SUpnZXlpMnlyTUF6?=
 =?utf-8?B?eVMydDdsWlZzeVdHQWFIN0YyWTJqNkp4NkVzR2NWaGIvT3RZN1I4cXUySVBI?=
 =?utf-8?B?ZVk4V3QwUmlMdlJnb2tKQnppZEdTU0pIeFovdWFkb1QzcE1FMys2a0JERVJT?=
 =?utf-8?B?eGhTWjZ1bDR3dERqam4zQWNPUGd3ajd4YWJ0SkM4c0dpeEFvOE9WM0JVSDZO?=
 =?utf-8?B?THFkSDV1SytWRHpEaHJNcUd3SDJjdHhvVU5FYnFtQkRhZ0FJVk9JUno1UzNP?=
 =?utf-8?B?Q1pOdnkxSWhpcERKRFNjK25vS1BvdTErVWFLZnBhOFlhc1RRT3hPZ09oOXI1?=
 =?utf-8?B?Ukp5WTRVcDlyMUJBaUU3bDYvejVOcUROTktSSHVQYlJpMXgzTWNMYXc5SkhC?=
 =?utf-8?B?eE95amlNdU14M1FiQmxFbVdTYWJualM5TDQyTTNyWitLVDk4TEdSSGdTSVZW?=
 =?utf-8?B?Y0hsd2t1YmF3eDFWeHRRY0RRWURsTjh0UHEvTHhZcmJoQk9La1hnVnQ0QjJF?=
 =?utf-8?B?aVNJYiswR2cxMEFqT1BlSmJ2YVVjK3p3VTBJUUkzWjV1d3cvQ0dzeklEUkcr?=
 =?utf-8?B?VUFoakVXN1Ziazd2QlVuQ21zK3RmdEk3RXFYM0NQNDMwU2dJK2hzSGpUUUtX?=
 =?utf-8?B?eW5QZzkxQjNaejQ3T2UzajlGRDVCaGNvYW5MZDEyL2tNNmZpUWZDR2VKTzBX?=
 =?utf-8?B?WjY2NWNxRkN6OFZIUU9objlVV2dkVmRacTRRT3ZIZ1ZWUnZPMzkwZnJtU0lk?=
 =?utf-8?B?NURVUmlNOTVJa1h4ZVhTS2swbkFzS3NNNVN3bkp5UCtWVDZiK0ZDMGhnU2xT?=
 =?utf-8?B?NEdSWWhNZnJLOWdBT29UVjM0NEF0dVMwRDJyUGJEN3pySWRzTkNnd0Z6VFZ0?=
 =?utf-8?B?TDFxNkY5OEl6cVNtS09UNjFCWGlyKzlEY2d6QjNLYTQ0ZDFCWmFzcUl2U0xU?=
 =?utf-8?B?QkFRSUp5RXJKM0d5MG9jbXZOOWZPajJ5QW5iTTdKNWcvTExVK0F2ZGFOenF3?=
 =?utf-8?Q?9gC93dSQEzOSCP2NKx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2efda2-2035-4e8c-e84c-08df1d5f98f1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:54:13.6387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7Tg/VIjf4yxi7iybsaS8GQL2vg8GNvJoPar7o5muo4t/ZWX1zDvpJXfzf0wJdIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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



On 28-Sep-26 4:01 PM, Victor Zhao wrote:
> [why]
> VF timestamp queries need a TSC sample independent of CP/MES.
> The SMUIO path is not safe on VF.
> 
> [how]
> Capture via RLC_CAPTURE_GPU_CLOCK_COUNT and read the consecutive
> count registers with amdgpu_mes_rreg64().
> 
> v3: check errors returned by amdgpu_mes_rreg64()
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index d6f70d33201a0..83be620d7204b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -3168,10 +3168,37 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> +static uint64_t gfx_v12_1_get_rlc_gpu_clock_counter(struct amdgpu_device *adev)
> +{
> +	uint64_t clock = 0;
> +	uint32_t reg;
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
> +	if (amdgpu_device_skip_hw_access(adev) ||
> +	    !adev->mes.ring[0].sched.ready)
> +		goto unlock_reset;
> +
> +	mutex_lock(&adev->gfx.gpu_clock_mutex);
> +	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
> +	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
> +			       regRLC_GPU_CLOCK_COUNT_LSB);
> +	if (amdgpu_mes_rreg64(adev, reg, 0, &clock))
> +		clock = 0;
> +	mutex_unlock(&adev->gfx.gpu_clock_mutex);
> +
> +unlock_reset:
> +	up_read(&adev->reset_domain->sem);
> +	return clock;
> +}
> +
>   static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev)
>   {
>   	uint64_t clock = 0;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return gfx_v12_1_get_rlc_gpu_clock_counter(adev);
> +
>   	if (adev->smuio.funcs &&
>   	    adev->smuio.funcs->get_gpu_clock_counter)
>   		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);

