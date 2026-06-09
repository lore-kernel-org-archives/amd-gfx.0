Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0F2CD8CB9
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 16:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A3310E357;
	Tue,  9 Jun 2026 16:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hs/EEE6A";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11D010E357
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 16:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMrMh8VN4GCyCDThrZyXVMphJ2ni/1M8TtZRdpsJCOioDPV6aETo8Wb4u0wQHIoSofM0Col9RpnFmE12lXQTMQ7I3X7TJRQasNpgjjHjYd+Sgk8A3ECFf1IaLWcZBXPPAj85mawnoofCzHjgz3LGIprK9ZxhsTOugTIThe06cll5W6su/1m5ZuoVUYjG3aBEvTg5icQ1x8nP2O1y8YD58x86Ejp8fuo9XPEUcH73X/gdFkvF1r6rZrsw2Y5+hBva5u4jK0rCBPCYG8B7IxePVLXaDAam+LMzIttTk+WHyuYGNHsH7kT2QZMUvDk/ufolFfcn2LmqEbOY7R5G9JSyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeDAPs7sRZgI7rHZAU2jMKgq4lgEoVztTDFrEr7UOsI=;
 b=BIW0r7lqyIZ7quEAc7jevIRnCeM7e3vBjXwdEbAjVErfrFQKQn+yxlOfHNuUrLRLbmcjxrakYSRnJ6FMV1tpffLJ6SA7i1K7a8J6WN2fyjFe2OQTgMDzIGVeq0BXDJsEn54WUQd7+h3khXSlfNWV5glsycXCXOGszZdmdJ25imCdS6kUYm/HbLJQrr80OHupfalimvrWl2qz0xGP7dj6o22TjF8irqGXbIwLth9iGkC79xW+VON+X+UqycoLHprHokBV5gZ5e8eEEqmUdbqErgjd02RuiUIMckb/sPYRJm8HSGDJDtE0BmmVKtx+rIg2GdndMi1ubzLCa1s4u7LZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeDAPs7sRZgI7rHZAU2jMKgq4lgEoVztTDFrEr7UOsI=;
 b=hs/EEE6AQWQjFVzXcehN3Rf9KebcpkJDsYw5u4l5b6s+eIaQqJg0SwZNn0QlMMelZjoWfJ4z1tuydEXo+tq3YZnTIssB8B8KQEgRX7oGDoWDmvtNLSDy4t5SYK0AlkCE4WewtDCgozRubzD08Lxf35wjcWSv3EL954Mtp6ic3yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:43:37 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%7]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:43:37 +0000
Message-ID: <b0ec2b8a-478d-4f15-afed-39a288a40cea@amd.com>
Date: Tue, 9 Jun 2026 12:43:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: add sdma queue counter for gfxv9.4.3
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260604174526.131849-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
In-Reply-To: <20260604174526.131849-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::9) To SJ2PR12MB8650.namprd12.prod.outlook.com
 (2603:10b6:a03:544::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8650:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: c415bea3-148c-44f6-156b-08dec64640d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UfQkQmEytUSiuwMi9iAqV7xJRMStr7Q7Dws5xncEe+gIEfBI/+vLyQOgIk27jZdNGMK2InQuJ6kMsTXFf0mYkY1jJZHK+dZ4zmIoXJ+ObQyBS7gE7qmTlm1BTcOOVYjPttkRhJoFN82wISRftkMDKh+RheebSaPjNwkFuLJ52aaNF/oNXa6uPH3LakDnsOFGEOt5Wzri1bSA4P4LXVu/3glOQeEuKWEfyVHYm2qNMNvnSJ/vby3ZOxk4pqHTooopi6SxHEOTtx7mWfEI8IIb1X3PzWCorsnx7McQ+r2DnMknLq3fHvh43fCjMkic+olXCthdqLaN787TQyABkv+cdp01y6y908aWMMvhgYCUcMjgh3a6NBlxvlnFuzqt/26Okn1K8WHjdzLoN0ZqVS9AEWoVggsnlDSS8/g/ASG3cGYtLEurw1fa76dIYbCPFPa6AcqqJwum9h8Wglg51wYR0L+uMQvmNvEFL8ylGnpdTcwQlscwJC/ezO932tH/fQzZWL1ulFEbWqRJV9Yo169CtstOFOJHD4SGhjDSB5kQald8jTC98XK6vK9ICYx6cdhVZ4jmt/F7sA9lPfX6xScFmD7Ji2+tIZfhufefxSSEKQphHVVrHC2bE2HY+2eK6U/mIP774lJz/fcyJAqY0pyhPp52Z0XIXtASuFKlBDojJXGmMT6cQEO2CcGO6MvJ9iP2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUVRM0VJeDk3REVBbWc0czUyN2QzR3BmS3MwVHN6ZnJzOGl4UnY4dlcrRnpE?=
 =?utf-8?B?TGQ3VGNpU0xrTGFIUk1sbWp4blBhU0ZhbkNLWm4vOE9VVHh6Z2pXM1Z1cjFV?=
 =?utf-8?B?Vzc2cmgzbUJFYlBHY3pQR1VScFI5NFFrNnNrSXJsb2NUM2tjcno5ZXhVTU9s?=
 =?utf-8?B?Q0xoTmExNHhUMldmUHFYa21iaDRrUjhTazNDdDhYYURMandLaXV4QTEvTEgy?=
 =?utf-8?B?TUlWQ0dBcU9kQWk2U1VTM0ZOaFowWkFyMHdiajBKcnNsZUg0MC9oQjlPdmpt?=
 =?utf-8?B?bzF0SG10bHNZOWI4Sk5iSWZQSTBIZWdJRGt6aG5ObC84MFpQdDNqU3lJYXBW?=
 =?utf-8?B?WEZuZkZOQnlsWFRMYTFhTHVGZWlQa0FJdlZJZ2JNbFo3OGJqRGNVSXdqMjU3?=
 =?utf-8?B?bnRVRWlGMnBWM0N3MVkwTklLMm5DOUM5WU5EbTgxcUtTZllSMGpPTVdoc3ZX?=
 =?utf-8?B?VnFJRGRvS0JjVjNPcVZlZldrSW16SkFwL0hHd0ZZbWF1ZHBEdEprQzA0NEF6?=
 =?utf-8?B?dERLVXo5Wm1nc0FuRTYxUkVacWVzSTFFdFpkT3FTQjVDcjV0ejFBblo4a0xh?=
 =?utf-8?B?bDNDNU9jSjdGdXdTWFMrWEc0ZEhDS0hrMlJFN0RhbEdLK09JQzdmbjVncVBQ?=
 =?utf-8?B?SVUxVXh4anNQTWZlR1pXeEkzUGZPUlV5RDEyTEMwWkUzY1pSZlhBL0RkbnVU?=
 =?utf-8?B?QlFGbG9UcC9LNUV0aFA5bTkrRk85MHVZZG5kVlZJOEJuRmVVNW9uTGFiVkpG?=
 =?utf-8?B?SUxYT0hWME5MRTNLZmJldW1PaUFlaFNyWVdQVmlTeVh2WkVrRWU0OXFnQWNN?=
 =?utf-8?B?KzNKQVJiQzRYLzVoVWE5VXV6OFFvVW1FZUJKa0hEclVndTlzY3UyMWdidm1q?=
 =?utf-8?B?dEJWQXpvRmJ3bXVBV3NPaWFMY0Q0TUUxMlo1SncrM1lmbEp6Ni9jNVB0Y2F0?=
 =?utf-8?B?Q1Z2QTVrRTUrZ1hob044TTR2TnpBZml1T3BRUm1tMlQrYmVZdlFLYTBWQU56?=
 =?utf-8?B?L2xlSXdaVjN0WXMvVndMeHR5S1hPTmNvM2k2VnRxdmdBZXc0SWMxMTVhcGtL?=
 =?utf-8?B?SDBtcktOdXgzdzdnUjAwWWVwUVJDZ0s3YlNSUVRRZ29ueHYwcFltUkdwRmVu?=
 =?utf-8?B?bUc4aVVVMWRydTE0VWs2VmM5WnViYnNvM1VuTUc1bUR1V2paRC9laFdJSmlp?=
 =?utf-8?B?MlVhQXJ5bTVvVklCdGppdTRjR3lPOFIxZTZsV0tHMVAzUFhRM3VKVHd0R3dP?=
 =?utf-8?B?bDE3ZW80OWtQNFl6UXRIYlR3SHM3ODlYVjN1WWVidVR4MXE2MTNlS2g0ZS9y?=
 =?utf-8?B?UWxjU1ZMK0tRdk1uSUhGMER1eG5ob3FUNU1kelpuNVBCTVdKYTA1VnhNSDU5?=
 =?utf-8?B?OG5LZy9ieloyQzRrRVhDbGFFT2srbm5MQmozK0cwVnV2c0VTZ21jT0srNlkw?=
 =?utf-8?B?NncrUk1lY1hFVW5keWQvd0NZdjYwWUQvd2Q1TlhvbFd5MU1ydW00a1VSbnBz?=
 =?utf-8?B?QzhMYTRmQnp6RXJQczRyNHU4YzJTNENmb21QS0ZSWTdTME1CQ25jVDl3SEMr?=
 =?utf-8?B?Y2NSSHlvV3RrUGxOT3pKSGxMNnBIRXlJWWFTNUpGa0hWc1RBVDdoUXpqb3VX?=
 =?utf-8?B?TjBNdE8xRXl5QmJLeVpCaXhEUmJsMkZaSVUyK1VtRGx0Y3o3MWxINFBvc2tC?=
 =?utf-8?B?SUIxa0pyMjU2YkU2OHBmcGpFZGdHdDFXRFlUOSs2RnZJc1VoM0ZzZlNCeEtR?=
 =?utf-8?B?bGtRR0NQVXdmSXBUL1gwOWs0SmJPUG1lMFpqZVQ4RGZRaklUNVUwcHRJblls?=
 =?utf-8?B?VUo4TUs2VFl1TmRNMlZOYVExZDVTcFU0TzVTZlVyWEZIcmVmL09tcklMV0No?=
 =?utf-8?B?aWRwR05kNmZDZlRmV1FOc2NRWUZRV3NQU0FGV0RxRUtnWmZHWmJOczJNdEpS?=
 =?utf-8?B?QmFwQXlwMWlPMWFaWnM2bVo1Z1VWcEp4aXk5eXQ0Ykpoak4xQ2VScUVCcERY?=
 =?utf-8?B?dEQweDhFdEJuT0FiWkNjSHUrL2syQWxuNmR6ak01THU2QVRhajFrcCtTNEFG?=
 =?utf-8?B?ZU0rUy9TeVhvR2JULzhXcWRLZGwyaktKZzAwQkMwbi81RzlMRytqd21VMm9T?=
 =?utf-8?B?VVVkMm13Z2NCQWJXTzdzZlpqek5jWWIva2w0d3JMckp4dXliTVpVU0dBSnBE?=
 =?utf-8?B?ajZQc3NCd2VvV0t2MWZobUpVN3BXTnFxRE5RdHpjNVViaUR5WVY0MVk3MEtJ?=
 =?utf-8?B?Um8zNytGZ2l4NjQ3b2F3am95c21Ia1VmWW9rVis2TEFHWVk0VCsvMXRGQnh2?=
 =?utf-8?B?Sm1OaXJVVCtib0d2MWtQZm52TXk4TFVFeUNROUZkbGo2WjBBK2h2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c415bea3-148c-44f6-156b-08dec64640d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:43:37.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwWfTTz9Zh0l05GuwdggF6yJrXfE03OK26v6LEb3cpzaHuoly5Ec7sGK+PuXorQ/rSzSVPHCGKbHajOewm8JDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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

There should be a CP FW version check that supports these registers.
Some comments inline.


On 2026-06-04 13:45, Eric Huang wrote:
> since gfx 9.4.3 HW is calculating accumulated activity counter
> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
> will still keep the way to read from memory at rptr+8.
> 
> v2: read dynamic counter directly from utilization register
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 51 ++++++++++++++++++-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 +++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 ++++-
>  .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +
>  drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
>  6 files changed, 89 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index f46c59118304..16bad244c091 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -35,6 +35,8 @@
>  #include "sdma/sdma_4_4_2_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
>  
> +#define SDMA_QUEUES_NUM_PER_ENG	8
> +
>  static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>  {
>  	return (struct v9_sdma_mqd *)mqd;
> @@ -584,6 +586,52 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
>  			ptl_state, fmt1, fmt2);
>  }
>  
> +static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
> +					void *mqd, uint64_t *val)
> +{
> +	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
> +	uint32_t sdma_rlc_reg_offset;
> +	uint32_t sdma_rlc_rb_cntl;
> +	uint32_t engine_id, queue_id;
> +	uint32_t engines = adev->sdma.num_instances;
> +	uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
> +	bool found = false;
> +
> +	if (!m)
> +		return -EINVAL;
> +
> +	for (engine_id = 0; engine_id < engines && !found; engine_id++) {
> +		for (queue_id = 0; queue_id < SDMA_QUEUES_NUM_PER_ENG; queue_id++) {
> +			sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
> +						engine_id, queue_id);
[HK]: sdma_rlc_reg_offset read could be move inside the if condition. Saves unncessary register read here.

> +			sdma_rlcx_rb_base = RREG32(sdma_rlc_reg_offset +
> +						regSDMA_RLC0_RB_BASE);
> +			sdma_rlcx_rb_base_hi = RREG32(sdma_rlc_reg_offset +
> +						regSDMA_RLC0_RB_BASE_HI);
> +
> +			if (m->sdmax_rlcx_rb_base == sdma_rlcx_rb_base &&
> +			    m->sdmax_rlcx_rb_base_hi == sdma_rlcx_rb_base_hi) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +

[HK]: Needs a if(!found) error handling.


> +	sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
> +
> +	/* Read sdma activity counter from utilization register
> +	 * if hw queue is enabled, otherwise read from MQD.
> +	 */
> +	if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
> +		*val = (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_HI) << 32 |
> +			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_LO);
> +	else
> +		*val = (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
> +			m->sdmax_rlcx_utilization_lo;
> +
> +	return 0;
> +}
> +
>  const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>  	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>  	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
> @@ -623,5 +671,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>  	.trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
>  	.override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
>  	.setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
> -	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
> +	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
> +	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b934863312d0..a65161659f74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1067,8 +1067,15 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>  	/* Get the SDMA queue stats */
>  	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>  	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			retval = read_sdma_queue_counter(
> +					(uint64_t __user *)q->properties.read_ptr,
> +					&sdma_val);
> +		else
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd, &sdma_val) :
> +				 0;
[HK]: What ahout 9.4.4 and 9.5? Do we we support those now? Otherwise, it will silently report 0 and not error. 

>  		if (retval)
>  			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>  				q->properties.queue_id);
> @@ -2728,8 +2735,16 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>  	/* Get the SDMA queue stats */
>  	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>  	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +			retval = read_sdma_queue_counter(
> +					(uint64_t __user *)q->properties.read_ptr,
> +					&sdma_val);
> +		else
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd, &sdma_val) :
> +				 0;
> +
>  		if (retval)
>  			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>  				q->properties.queue_id);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0be2fd04e6d0..911f974e6bf5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {
>  
>  struct temp_sdma_queue_list {
>  	uint64_t __user *rptr;
> +	void *mqd;
>  	uint64_t sdma_val;
>  	unsigned int queue_id;
>  	struct list_head list;
> @@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>  
>  		INIT_LIST_HEAD(&sdma_q->list);
>  		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
> +		sdma_q->mqd = q->mqd;
>  		sdma_q->queue_id = q->properties.queue_id;
>  		list_add_tail(&sdma_q->list, &sdma_q_list.list);
>  	}
> @@ -193,7 +195,16 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>  
>  	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>  		val = 0;
> -		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +		else
> +			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev,
> +					sdma_q->mqd, &val) :
> +			      0;
> +
>  		if (ret) {
>  			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
>  				 sdma_q->queue_id);
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> index ead81aeffd67..8700f8190c7c 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> @@ -493,6 +493,10 @@
>  #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
>  #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
>  #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
> +#define regSDMA_RLC0_UTILIZATION_LO									0x017c
> +#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX								0
> +#define regSDMA_RLC0_UTILIZATION_HI									0x017d
> +#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX								0
>  #define regSDMA_RLC1_RB_CNTL                                                                            0x018
[HK]: Formatting error. You need to use space instead of tabs, I guess. 


8
>  #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
>  #define regSDMA_RLC1_RB_BASE                                                                            0x0189
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d34c869b182f..f3220794c108 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -361,6 +361,8 @@ struct kfd2kgd_calls {
>  			     uint32_t *ptl_state,
>  			     enum amdgpu_ptl_fmt *fmt1,
>  			     enum amdgpu_ptl_fmt *fmt2);
> +	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
> +				    void *mqd, uint64_t *val);
[HK]: #define SDMA_QUEUES_NUM_PER_ENG	8 <-- We already hard code this value in KFD. I think #define could be avoided if you pass in number_of_sdma_queues_per_engine as a parameter.


>  };
>  
>  #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
> index a2f81b9c38af..e0d387f08576 100644
> --- a/drivers/gpu/drm/amd/include/v9_structs.h
> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>  	uint32_t sdmax_rlcx_midcmd_cntl;
>  	uint32_t reserved_42;
>  	uint32_t reserved_43;
> -	uint32_t reserved_44;
> -	uint32_t reserved_45;
> +	uint32_t sdmax_rlcx_utilization_lo;
> +	uint32_t sdmax_rlcx_utilization_hi;
>  	uint32_t reserved_46;
>  	uint32_t reserved_47;
>  	uint32_t reserved_48;

