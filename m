Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD17CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6717E10E7F6;
	Thu,  8 Oct 2026 12:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tkFgDTYq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5687310E7FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDmGvgs8Iz2R+z5DtnytdOlN0+p0eLqnf/a90PFOHsNcAOR5Jn7uOCin5bJ1+mNAnO80C8FtqNi3owXDtQ51BUtZybpVAxkZ+aegsg6RKh9NjKBoEln9Uv1UskXpZ5YM4zrNSOUAQKurL5DZu0oE3KU4jDVe7mZQ0fOQC+tprx5POJgdbKH0e0LzxzLeuXSr+NZinMKpfxBb4QansoFuttNgY0+48WCBHRujSiFfFfmhXaKwq3X5Lhy2LonCvEQQ0x5f7L5rCT0e9nwaEui1bB6+ALLbwQflZiT0QjB+VGyXfzi5I+i7ZOdq3RQEXzOY+Nsb7RxEQtd5EnkIxrDpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaYxPUzz2/MiZtMMRWu20tNGIkESTmMNRrGPbfVYLW4=;
 b=Y2qdovFSfSuDCEQcc6QB5d7yWLhoDAfaMkBVZhNNAcQykrvMs4Q0CXZyDdhUZqiCiNStmlg3ClSJml7wIUZDTB/T1J44a0QLGvLRFaqks2R1aVwfsw1wDoEthxhnHDji5n5t4pAlbupmdKqHKHa+HjG+l5zNUjwmd3+uN7TsQM/+s2i1e1jnNa+lMiJTC8Sz7yo4s+7z6gZvpjU7NylRYfxoIsJZ1LA+cwHsW+4e7TDONXaR2pagIXDLo27PCsM9GyF1wLDcEQSWONpJDTI1IlzLtcfNWb+c07XMvscq0QUeo10wRSoKefulO1eGSSeXvUD7chsuHgaJ9PHB9Wk9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaYxPUzz2/MiZtMMRWu20tNGIkESTmMNRrGPbfVYLW4=;
 b=tkFgDTYq3twXnbldzgvCybGZpHpS//G3z7n37WWs9jnK+duple8Tyl10iJsSivdxPSz35dopK5Wtx6hEfwe+HqRJErm1ynWVmlT072lkfVuHAQhiqCVq9OKvW3ZNzxZlo3N7aVVASt/Yr5oPSuEi/Tl2pvHvpRRxtEK9M9xCxFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 12:17:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Thu, 8 Oct 2026
 12:17:58 +0000
Message-ID: <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
Date: Thu, 8 Oct 2026 17:47:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260929034650.2393125-9-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f164d5-ae51-4e49-88c2-08df25363058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4j2/2m0SF+dtlpCvb1qYrHc30G3p4Qgs8VuBbPKxHFdPwetDdMMhlX9tInHDLW6cUYpGONl5Y0+3UqtWOko8kuPjGNHLFbOHlwm2qYZ2B0CR63PZzXZO7aWEcbcCwAGRPMhOyLYo/WiVECPUk56vYXRFvYPzK4y9TCodPdcjTJ27E4NheHESkhKYC0yXUfqPz1wk/rYSnZNWb9r1rLvL/qenmGb/m+Q06xvs7qV9BPbpZPjOlscLqmi1zD3x7vTYZ5+v5TY9pOjTuVFZRKsC9TKj0JBVuLQWwWmABF8wtC7Jx08HIsjhqzUjRVHEJJjlLeL90fLIyfIKwTvMlV3q9sKqMhsgdgwO3zp3GPTNTuJDuvuSRHP6c2gfOEF8llebJHL4qUCvlV6M2/r3GvZjAiWXn+eCo6ep0lKtc3dypvjKfjVq6cvx5y6CzJ176RNeGXXpyDOSDvo+Jx7U+aLMgIr5upNPbX04J4Zr8nG8m5vbZa8KRgjbqQt8KqitBOjYAdNn9usvbKdk6oZKdZKttzREqzUshgKboIZtUYYoCZP2xyeQnjnLEMl0TQDCVNArvNRrgj9Klu4eYckLdm3dI6Jf7umrgcBNsH6xZjDmQ+K5p8HtoCFjJPUQ+qKuiGX+YW4cytOM52Jz//e5a65Tghw0OJ5k0aTGxIf17+pru54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDF3dHZ6alM0UHVqQWJ4UFBUanBNTU1pdFVsK2xpVWd6UVEwTnVBOFMycTZW?=
 =?utf-8?B?V3pBYXhDaHdLZlk4NFNERmdtMnZ0WThUTHZkcHRYV0lJcGM3T2tGbEQvRHNF?=
 =?utf-8?B?aUVxMENvWG9rR1BZQ1FSQjRlQW9CTmlxb3Y1MElmc0VIZmpJN0FyK2ZiejZ3?=
 =?utf-8?B?MHJjSDcvb0JCSmZJQXgrZWJ2aVl2MHR0Ujk5YUE1aWQ5bytPSUtvY3lFdDZO?=
 =?utf-8?B?WjRhKzZHbktrd0FOZjhjSkl2RFpJWHd6VzdzVWxVMmNITWZKTFh5SXZKNVFl?=
 =?utf-8?B?Ty9HRStIQU1xanJPenRQYmNENVZaTHZHUlZvV0s5cUlaNzNmK2VpWnZQZXhs?=
 =?utf-8?B?L2p3NS9nZUx0b3VkeTJYNzdzb05QbldxVzF2THo5bEpaZ2pSNmNxMlhGTjdh?=
 =?utf-8?B?ZVYxbW9PSG9qYkFnenpyalNkait5VGtWK3BIK1NKaHpxNFl6Vjd4NXYzMnRX?=
 =?utf-8?B?WXgwSEE0bVVjK3pEbVcvaEx1aVJUMlNnc0xPZlU0blBGcGRBUUZOTWxPaDJs?=
 =?utf-8?B?NlJvWUVxQWxaeUxJTDFhdmJZd0JCZlZQUWdKcUcvRk1yMlh6cVEzM3NPTDlP?=
 =?utf-8?B?cW5OczllbThJbkh3TlJhR1ZXdjE5ZXE4S0RsdElnOGdnNEhBVlI0ekZ3RFQx?=
 =?utf-8?B?VzlPUUJJTlFMVUdpVzl3dmhlcG9FWDBNdXpBUGVoaGtWSFhlVnBUQkx2cldO?=
 =?utf-8?B?UnpsVklxdHBnRkY2d21vSlVLVTE1aE1EQVJZallMVEJab29BUEJ1STFUWEtB?=
 =?utf-8?B?cGFSU1FOMWtQc0Y4TjJhVG5ycWV4U1NNUUZzQ1NUUzR6dnJDQktsVTIwdmhI?=
 =?utf-8?B?VFE2aW1FU3BqRFVIQmgrTURZRTlKNHZmbW95SUhTYmp6dnY2SXNhSkJOMWhL?=
 =?utf-8?B?cGpqZGNDNDg2TjhiWUNOVy9OTzNhdm9BQ1cxUlNacjF2cWdsL1lid2VETEhH?=
 =?utf-8?B?U3NaNFBaQ2FKQm5NUjBlV3NXTTBxajM1T0pHb0RSQzlCY0dCR0VFWXNYYTdp?=
 =?utf-8?B?UFFDQldpaUN1cmpjZVFZRjdQdGxyeDRPK1dWWldnblFDY3V5NitRNnBGZyt0?=
 =?utf-8?B?VlJGbjRDNkFVWUNjbEhsWk5UQlR5cEt3SVFvcWdTRmhwcXF4TnZSYVBlVU5L?=
 =?utf-8?B?alNZais2amZDS1ZpQ2lyUkNKTGI1NFFZckhOUlByclVacXl5QVBJUy9XdGcz?=
 =?utf-8?B?RXFDdHhIMm5VSE9wYVNMeWM1UncxL2NYUldNbXJETXgyVHZQaHZTeHFvTENl?=
 =?utf-8?B?SytoNlUvZ0pWRkkrQXdXS3RGbk1UbWpuRUIrOTk1UXNMQ0lnMDI2Z1lJMGQx?=
 =?utf-8?B?NGZybDR3a2hUK29YNnBvOUhlK2F3Y0ZUSEZCYkZqYjZlSzF4cTNTN3FCT2l2?=
 =?utf-8?B?L0YxdGVFbmZxRWFkbFRHOGlnSzh3b0tTUTNOakM0Z0dIUnVlSzAxTVJGSGM5?=
 =?utf-8?B?ZkUrdHBKODAvVzJBUEt0UEtHQkNkSi9XenN0TktaNXRsLzFybVhpUWJ4eUVT?=
 =?utf-8?B?RWYzUEI2VTF0OE1xYWROTkJlTWVlSHJDWVRnMU5XMUFGVnhFd1RnOUFJaE0x?=
 =?utf-8?B?TmlOV01rSWsxUXFIS1MzM3BlbGsyb0JSdTBiL3lrOXJpV0ZVaXJGQnRzMlFv?=
 =?utf-8?B?MGFGaXVlOHdBRXJ2RUtVYmw4aWVhOGZaT0xjQWFDUDJuREFITWZlR0grNjE2?=
 =?utf-8?B?czZ0a3BSWUxsdDhtS0FyYUxvVjFjeXZWS0F4NHkrZkhibVhrZzFFd1hTdWQv?=
 =?utf-8?B?Y3U4VnJQdXZ6RmNaMHRvQkx0MTNlY0lsaDhtcmlHOU1pd0hmaTJiVzJ1bGxw?=
 =?utf-8?B?QVZYbW0vSk9nRHkxTGlEc2NZVmhvblBvbkV2Qm1zVHF6SStzUGJyUkticHpW?=
 =?utf-8?B?YTFraGprNEFSWEQ2TWFqQTAwTi9xNVdtOUdHRTVGOXdUSDhCV2RxeW42eWNN?=
 =?utf-8?B?aTFQOUVSVjdobDAyYlNqV3lvdm9tVzVSa3EvcDFteE95cHFqSmljWjZKZzd0?=
 =?utf-8?B?THdXVk5JVVBNcHFVcmJIM2VOYzZISmV0YWE3eVp5aCtaV1gvK1BjeHQ5akVu?=
 =?utf-8?B?VkpydEgxWnlPY2ZrT1V0OVBlZVJyR1JxeWRXY0RXanJkbytiVDFPc1IyTGNO?=
 =?utf-8?B?cFdJSG9QY3ZPMnQ4VCtORkRaR1VEZHdVZEsrTDJLVW5IYXI0NWlwdloyYzdP?=
 =?utf-8?B?YnRQelNGb01UbWtQWXRjelJiTTdOSS9tRmg3WGsvVVZPcUV0RkQ2ZzdCUWov?=
 =?utf-8?B?STVOTGtsMjUrRGY3d0h5RkZCS0JMN0hpdnphRTZMUEZNSzNxNE5UV1Y0ZVZO?=
 =?utf-8?B?d1poeEdrVlZSb3oyM1BjbU5ud0FvS1cwNENmKytmNkdYRTgwZDhzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f164d5-ae51-4e49-88c2-08df25363058
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:17:58.2928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0Q7j1KCDyI8GXbySQ/W+oCfMSC3YEMcrXAkNPyfLCA1C7YY6wd03qG8zQNBqppT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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



On 29-Sep-26 9:16 AM, Prike Liang wrote:
> Protect media idle workers with a reset-domain read trylock. On contention,
> requeue the idle timeout and return without hardware access. Keep the
> ordinary end-use scheduling event, including from reset-time ring tests,
> so otherwise idle engines eventually power down and VCN drops its profile.
> 
> A blocking read acquisition would deadlock with reset-time synchronous
> cancellation of these workers, so the workers must only try the lock.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 9887a4f99aed..7b10260ad0d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -114,6 +114,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   	unsigned int fences = 0;
>   	unsigned int i, j;
>   
> +	/* Reset may cancel this worker synchronously while holding the writer. */
> +	if (!down_read_trylock(&adev->reset_domain->sem)) {
> +		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);

Is there any need to schedule this work here? Being not able to get the 
lock indicates that a reset is in progress already.

Thanks,
Lijo

> +		return;
> +	}
> +
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1U << i))
>   			continue;
> @@ -129,6 +135,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>   	} else
>   		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 17db7264269e..f851a6ecea1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -470,6 +470,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
>   
> +	/* Reset may cancel this worker synchronously while holding the writer. */
> +	if (!down_read_trylock(&adev->reset_domain->sem)) {
> +		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
> +		return;
> +	}
> +
>   	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>   		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>   
> @@ -499,6 +505,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	} else {
>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>   	}
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)

