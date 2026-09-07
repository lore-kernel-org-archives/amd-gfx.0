Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DCC79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F5010E68F;
	Mon,  7 Sep 2026 07:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6gPwZ72";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3728810E68F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 07:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2qeaZ7rjoUsTVa5/t8I481q2TY3qEnuCG6ykG1o0r0Qpz5FMTDWtoFTRZKwKO9eURxbsAXCSJQqueMgGWVqrM3/e7LiJbaveLZXUhwOVG7eFPZ+6qXSGIhXwNaPLu/hIyg90BiO8S6QTDx/Ns7BZwvbZ18Msg00zZNFap8Z73j4Z1YRm5i8+5Bfxv0MOEnq9KkU015ilac8O/yCywZ1NpOSZZmhjpCdaLEwQ3eyvbegyOd6ViM5qBY9a9U+uAdajhDJcB9RXZ0hx1/o2/ptwGsq+zR8e2olPX+luYa1W+uB+03TORikM6JJMpkBgC3NlFUXf9TnQAmGyDoAVef+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDri6PozMM8M1jHYI8WLpQrefbXgbZ4TOmCV6NIEXF4=;
 b=K7GALWK5D27ex5/2jmAutKvMUEk1wa8eax9Xke9Z/stnzNZvCesyVgEhGGOI82jVqB6d0s9/ALvTr9wwRCptI/WOW6a/EjwN/WzNnhl/ee8KYFbmIcAk1dVDdakis/HHWl4imfXUaKXjCWF0YdpnY072iWwRdCZ1qPbL/uHHgEZ3m757V6gCjvOtUACReb9f2XHJngvksK6rjGFr5UYtv50OnPOlDOwY8cX9duu24r6yPNLxlAIrbFay/cNsDtkKastHsg/KZSGvz+fV+/3QC24jqFL/4jdCOCpDkcegViQ1+FxOqeJlrfVbV2IrkAYrTN5I77NJdlX6d36h57xXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDri6PozMM8M1jHYI8WLpQrefbXgbZ4TOmCV6NIEXF4=;
 b=L6gPwZ722X8viHtoSPFH/WJtiqfa7Bdka60tVHFh3tSY/mUkVVkhfbXvgCiPblFKw4duHHEdfwtgz/0R+e3lclie7LGHcWbNxG6nTQvG6a9KGO8z/k6sisl7hXVsg/BcVC69LOcWwZl7+6ukOnNgu6BR5VPSpamn+tR6NNu86VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 07:05:02 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:05:02 +0000
Message-ID: <a3a99a32-baa1-4ea6-9c8b-b7994beb8f47@amd.com>
Date: Mon, 7 Sep 2026 12:34:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu/sdma: Clear SDMA rings after reset before
 starting them
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
 <20260904072850.321759-6-timur.kristof@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260904072850.321759-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: f10df09a-4c71-49bc-e1ac-08df0cae5668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: cwadfCze/KXHo8ZX2z/AA1rofFVCWGVetTgT+fP+s33wxusPqI6O4zpHeMjsM8YB4tPvkZb1G4dH67zcPaiERkLBgiuzM402whJsCxzxJgT3w396cfB6Sy2VmwpXyZf51SQvtphFaCGSK/fdsefaC6533jWdv0oFUqkIxOsnbLFHiE4yu+SpRYzVeiwSmM1+5IBFOARRguePkcCckdmZh7o6toEJ3ROnDlwZ0SI+izFSFNk+ys6C5ecwVAX3pxSt+egAN2BIWYK6nfM2fz5SR1EEZSaqpxA61S33UGWcv67VBzBIne5sJi1wLTXXo/L3GQCBDzHC8i1LjpIt7viBDG/FcOVzDjfW1GYXm8aCmkdexsXsIP7TLVQ8jGkg0KhN8tmtRDngj35ULcqlj5F0lUvv3lerd9ROmudW0AbOWoyDndJunhCbYDbekDRowUBLRdd+1rPde2LhQ+eHAIL/cp+zs5urFbIcFLQzTUVN/FzhDzNPG4lSA61l9Z3dN77C9r60zr01iflqvKiux1dqGxtVjoRTBV7M4t+6WywDRAmM6ylfKWXVdGp2Xw5zylNi3kAIsR3B4YFWRZ2baqpO3b1TmggaKkK9hEWZY92Geo72zHv+Eeu1XRLSfPDJAETxaaL9azerXDgoe+i0WuJzuBknCnY76aNtftppHR2snyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZpNUhTV2lpMURHemFvd0x1a0NFU3JnVEt4bkVZUWg5azl6REpuclFmaFMx?=
 =?utf-8?B?RExBMitnbWVZY2tFNUxFblloT1VCUDBYTFRqQXNjSDRreE1TMUpHWnBsNUNj?=
 =?utf-8?B?ZUpSVFhkZzlaWldKQnNSUkx1dG5oSEN1VmVycUhRVUxTMVpCZHZaeTdWTXJH?=
 =?utf-8?B?aUdWUlZCSnJyZEVGWW1FeDJXK1lvTnhqZExJdnduWEl3b1BhbHNuemZKN0Ju?=
 =?utf-8?B?cjk0OXhoc3YyYTNGOTcwWkw2dnl0SGg3TE9FdFhVM1plMXFaVndCWDJRZ2JL?=
 =?utf-8?B?MUJqRURMSkI2aHNyRitDZ0ZIL3lKQVhBNGVKYTN4L25QMWhIRjJjVzMyUWNR?=
 =?utf-8?B?UHMxdXhYZVZaeGE5NHNJMUhRNWoyY1FhQjVpMW91SW03L1l6UEFPRjJhSFY5?=
 =?utf-8?B?UE5qL1pxUVVXQnUwZXRWSmd2eGhDTjdieXcvMmhzbi9KbG9LKy92RHh0Q2cx?=
 =?utf-8?B?WDBGbExoTEM1R1RnSHZkdzRxckV1eVc1M3pOOXhsR25wd2Z0OUIwRFVXUVBB?=
 =?utf-8?B?OWEwc2ZkRUtGaTN0VUloTVdQbzc1b0c3U3gzSW9rRkhvek5oWitSM1RJLzNi?=
 =?utf-8?B?cmJUeU9hTURXL2NCNktrMnZEOWJDVmxzc1ArYUk2TFZNMTdETWRsSE4yUEk0?=
 =?utf-8?B?YjUxc3lhTGs4aFpOS3o4c2lqYWdvNldJenpqTEIyQnM0bnQwMlA2cWJ3N2NY?=
 =?utf-8?B?c1cxaG5HamVrZ0FOdTJiZG5oL1Z4YVhxSHNFaFpHK2xBazNLNEZUVllTcFY4?=
 =?utf-8?B?TlhBNDRka3NBeWFhU09aOGJKVXpxTVY0cVRrTE5IR2pZSWJ1Z21JdExBUmta?=
 =?utf-8?B?VXBLc0p0VWFxM1dyQU5PUmJhbHVITjRFcUR4a05Va3VML1hyd29UT1JsNHN6?=
 =?utf-8?B?WndRYmZlWndXR0VJekJIYW5JR1NXa0FuQmN6YlVnWWJ0ZXZFNVhRT0hRQ2p1?=
 =?utf-8?B?UW9JRXNUMFBocEltMy9zRVRXRnVzRndIQ25rbk94SkF2NkFHNHJRcVQrY0FO?=
 =?utf-8?B?QmprQktDNm1qN2xEa1E4REt0VmM1alhOWUdWM3YvWXR5Z0s0UGFiYXV6YytV?=
 =?utf-8?B?Nm1PbjNHU0tLUG9nbkp1cEx2VHh2VkRJRXU2SHVWM01GMVN0dGZ5S1UvejRF?=
 =?utf-8?B?Q1lKOHpRTGZaMzUvN3FDVm9ETGd3TXJWK2FnaWxLRzdNNmNRVzNpMzJkeG9m?=
 =?utf-8?B?dExYR0VBTEJ4Q1U4ancybytsbGkrRG9qR283eWM2Z2Z5S1pIaFNhR2Q5YjlC?=
 =?utf-8?B?a3dOcUw3aEEzOGYvdWIvUllmTVVjUXo2akdQMzE4RnB3SFdNVnNNVllYY1pR?=
 =?utf-8?B?T1BFWkJxajlMaEF3QS90djh3bGxyTzF3eDl1WmZINmxCQUdqTkhRajdlbS9v?=
 =?utf-8?B?dmFCb21ZYlJNaDhZbWhMUEFpNG9FcGZXSm45ckRkTWNWY1N3eFMyajFKQzd3?=
 =?utf-8?B?WjFXb1pjUUU0Q29PQllNSXl3OUZrYU93SG40a0JLdVpQOWd0MFBEZWRmTCtE?=
 =?utf-8?B?L0p0cCtQNHF2MzZ3U20wT2dSdllRMGFacjREWDVaZ1E4NlBtamhmT1ROYk50?=
 =?utf-8?B?NVRwcG5TWjNlRnNuUTk0cUMrODFsRm81cXVySVVwUmpLMWtucGlJMEd6YmNx?=
 =?utf-8?B?U2ZudFZHRHZtMUh5R1F0MFoycDR2SU9NdE4wdS8zeHBqQ2NGa0pXSU80RlhG?=
 =?utf-8?B?SCs0eEl3RHozcXNLK21EcGxOZ3lsUWh0TlhrcnUxWWNCNGE5aUZjWEFzTjc1?=
 =?utf-8?B?V1lXQ0loajkvRFZZV28zbnFWY3JDbDc5RTE5ajhEaHUxUFh1NkNsZnpwelJI?=
 =?utf-8?B?bVFhRXU5NllEOW5zNzczbDhmV0NUSndrTVk1UktPUGhLeklHRVFYdG83VE1n?=
 =?utf-8?B?RDl6ek9rY2s5WjhDTDR5MTM5SW5uNzlCcGdTKzlYeU9ydTRPNFhBbmFRQ3M5?=
 =?utf-8?B?b1BEaG03SzQzS3ZIczl5d1hzRTVGZGxWeFVFWnFWQ2J1TTU4QVRYeVI1REFz?=
 =?utf-8?B?YkZMTjFZSVZ2cm96M0Fjcm9zTWl2Yk1rMnJnMFZ1eG1JdDgrdmxSSTBwclFz?=
 =?utf-8?B?eStueFdwdFRiUWVqODhwcHJESXBaa1RiK2hiQWZrbmVBdWpMK1BXOUgwd1No?=
 =?utf-8?B?SzVWNjBRcElYREljSUlqRHU5QkFPK2YrNHN2UVFtL0czVlh4UUxzMWljdUlr?=
 =?utf-8?B?OVdJQU50ektkbU1PN0k4MTFvRUhOVGFJaU5IV1ozZmY1dW1JbTRsWmhQSEVz?=
 =?utf-8?B?TkVJTCtWSWdXdkV6dnJJVk1xZEIrNmFMTFFzZmVYUFdiS2FhRU9qUEpQTkY2?=
 =?utf-8?Q?BPPJV4O1YKZ1EVpltM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10df09a-4c71-49bc-e1ac-08df0cae5668
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:05:02.5086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gy2IESuEGaxAuau/BOv+6PJkJJObM06RatLQYgjlQqtvlSgQFgEVZbbskwbrCasN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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



On 04-Sep-26 12:58 PM, Timur Kristóf wrote:
> The ring contains commands that were emitted before the reset.
> These need to be cleared to make sure the HW doesn't execute
> them, because they are garbage at this point.
> 
> Note that the ring reset helpers will re-emit the commands
> that are necessary after the reset.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index fbac732f3e01..66f278f77f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -593,6 +593,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>   		goto exit;
>   	}
>   
> +	amdgpu_ring_clear_ring(gfx_ring);
> +	gfx_ring->wptr = 0;
> +	atomic64_set((atomic64_t *)gfx_ring->wptr_cpu_addr, 0);
> +	atomic64_set((atomic64_t *)gfx_ring->rptr_cpu_addr, 0);
> +
> +	if (adev->sdma.has_page_queue) {
> +		amdgpu_ring_clear_ring(page_ring);
> +		page_ring->wptr = 0;
> +		atomic64_set((atomic64_t *)page_ring->wptr_cpu_addr, 0);
> +		atomic64_set((atomic64_t *)page_ring->rptr_cpu_addr, 0);
> +	}

This could be made as a small inline function like 
amdgpu_ring_reset_ptr(ring);

Thanks,
Lijo

> +
>   	if (sdma_instance->funcs->start_kernel_queue) {
>   		sdma_instance->funcs->start_kernel_queue(gfx_ring);
>   		if (adev->sdma.has_page_queue)

