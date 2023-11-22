Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D966CC27C40
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEAE10E6A6;
	Wed, 22 Nov 2023 22:35:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E7610E6A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtgMf3OocbHayZm4iy+TWhhcnmlrN9wtEJ/zS0JDYjwhJwgzsK3YssF/1iN331zE3r1Ol3gK6V7+/fAnVpLdE0DinbyCiatSVayoOLEjR9zbqI1bA7MbBlIl7xK60WbXqZca/clSzM2DYQxAPNC9mHgGDmMRBN6w8MN4PPFSlEXVZ18FkO6lnz8QUw6G+L2++U6opcblOGCPG2Hs/EvOXVLg9DOTLPKsBht2QCqLC0rNEpvc2DVX2KM1ZA2p1lYE34FgRnMZDdBaqvHWTfoncQIr0bFwrqLPFCSTIc9QgYH8auHbzFdytLfiNrG9vMX5ZvqX+pc+TzkQw0jgeSz7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG8a0QVz/etFKkwChqE1YRilMgKdpXmGDpe3JOxl068=;
 b=UJV9rbEbxaAWon8KPALnF3Mz7CMpVuIRDwfnzNF9CK9/PV/d/UKkTvLDAzJ7VYl6v7/4ExkUkXZNqBZBjGmPX1NmYS4MrL7SuyM5dXTr7TUOFg16Zf1YixbXrpFQijq3pB4CtHPsCkGSEGxCJg7doH1ZM7cT0nh7LgFP4W6NmEaNNB97YbntfjRnzKw0JtO8ZM8LscfYBXoTmSGzlMZRLjpnM/arBfATrZpna9XDBKMY2gIibYl6avajCrri6w2xu1AGEBAWMEawmW/Ky7Hi4WaB+ChkyFMy8E0pFL+K3xV2RKEZhn+9bKMNcvzm2HmnbbOFvEyxfJ3A73NaUb/t1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG8a0QVz/etFKkwChqE1YRilMgKdpXmGDpe3JOxl068=;
 b=jSW4rHj0Jq/3GLj+EjZ7oVZmQAp32rPDM7xp6CdwNcxk3mGr4XXngBXf8kRe01RD2FOBK85irt+JNPaO95wyVhMUK3tL6c/7CBDaXct5aAdRaaMeTcOneYbMYIqvO+2PxJA8dZNF0WotgW/y6DdpBD1I/Uxc+ndNTxSVXbufq+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:35:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:35:47 +0000
Message-ID: <dc13740d-666d-4296-8f77-062c6f32374a@amd.com>
Date: Wed, 22 Nov 2023 17:35:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amdkfd: add queue remapping
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-22-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-22-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 45956d03-b930-4b9d-0fb4-08dbebab5f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VHVjMRwadtiB9I1QoQNOS97gOijzLjDd5OQnUP/Ii0k0bVxuFTCQUC26kUJEfUtCRU+GePypUnsW1WUd610kgjITSNJU+Gi0vJJxae1wk6CWmDvgJ5uegamYRdbOOHCGGhZLLnh88uYEfqcCYZ4RtYbhhN0worqPXpZdI+0ExQjdU86EGLVgF+CkptUyCw10QIYlWBkExykRhga+TeFSsNvgRpGQ4iIl4f9G+mVnwSV6SwFrK3OIzwUSBVf16wMtW16lrQnSFQQi+wtEFzC0RTp34vbGx/YgcIZNCIPguoYBUZ7HLQ/21AKbab7ZQdlPEU9naNlnwpWCyA5kbqg7zpHHmeCshlSEA6e2sAlhG3ty+8Su0t2csZL14ZPlqD1i9KyXvkIYM58ssCtXm5/ucTE9ISfD2ljuUE018RFHxzkZ8nw5k+0YSVsShEKyjOlmYDP657N2EQQIOB3WOFYV0aNySkTdtSi6daNvrmktNm4n9zvU8b9zSNGuJQg4SFfubjgu/NjxmUhpBzT8XffII9ulKEu+kj/VayBSWVTruZqmQ58nFapat0a9caxGFcJjcDIDsuC6Un9Ft1EbDdzScdWz6L0hmIwJ3Uf0+k3dNh1yZCZ2nUXoVwhpTbY9/fa+U5V5LQ8t0mpCu51E/W5Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(83380400001)(478600001)(6512007)(53546011)(6506007)(36916002)(6486002)(86362001)(44832011)(31696002)(5660300002)(8676002)(4326008)(8936002)(31686004)(38100700002)(41300700001)(2906002)(66946007)(66476007)(66556008)(36756003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ais3VEVlUVZWODZzeis3NERCQmxoSjVrSmxuVUpVMTB4dVQ4dmY3b2hMRlh3?=
 =?utf-8?B?bkRFay9zeHNJcDg3WVRCZkVmUWhQNk4wcm5wcndxOTNtTlRzRUE5dG5wQktJ?=
 =?utf-8?B?RWpET2dPRWVkV0o4MHRkaEJyUGIydDBPeDd2Ry8wVEI3ZVZsS0dFK3ZvME9a?=
 =?utf-8?B?QkhUL1BySW9kK0xsMFcxemFqSDc3d1RYbXZHME5yL1hQL0FlRzZiYTBQZ0dH?=
 =?utf-8?B?Z0dlcjhNT2d1K3FhVkkrTDdnVFluU1d4SVg2cWszYm5NM0ZJSW1aVkgvNUt5?=
 =?utf-8?B?ZmVsTDdVRWVYa2ZUclh3TlRNVmlHYzF6aUYvUG9aUHFyanNLdGVHTEJJY0Ji?=
 =?utf-8?B?eWZpNmprQzFMNXJLOEU5dGpzSitVRlY0dHlENUZIM2dLUW1kRE1yNzFWMlNn?=
 =?utf-8?B?MW9XbGdtYjVPSmh2NnJ4RDUxRmkwYWt4ZnFRRnNJMnVHSWJsVkh2dEN6V2x6?=
 =?utf-8?B?STNFMnNOZGRYNkd0eUJ6OU9zazAzZkxuTXI2RGNjSkQyemdNQS9kTTYrQUlK?=
 =?utf-8?B?UG1nTzFMSFB3aVhHTzc2bFVSUWlKb0g4ZkJMVzlMcmJibmNqYUliYU9oUUx2?=
 =?utf-8?B?SGZFM1hFOFVGc1BXNzJ4cll4ZWxBZGYvU1JoaXAyRitMN0x5UTRmK1hnTXF0?=
 =?utf-8?B?WjhGc215Uno3S0czVjBUWGNTVFViZlZYYjIrQld5WVpqdElnSFNKMjFyMkNt?=
 =?utf-8?B?TzhlSi9Hd3JYRGhTdU5IWnB4NThCVWdCdDR1TkxJRHZsdE1lTzQ3eWFWWTln?=
 =?utf-8?B?eklyZ0g0WGpmd2dIWUNjSEc1ajN4MTY5bjQzbzg1eWhSNzlnNGlBNWZEdXFa?=
 =?utf-8?B?NWRvai9mOVBzU0NZSDdJdWZkVU8vT0lSaUd4VkRXMGJpRysrT2J1N2E5bjNB?=
 =?utf-8?B?WkJKSGFuQi85ZG9IZWx1N3R6MEhiekErQ00rUnFaYmR2a3FiNVVBYzlSMVJo?=
 =?utf-8?B?MXVkSE81amduU1dXSUwySFBQbmRtL3ZWVkhvM0EwMkcxZ3ZvUExuTS83enlk?=
 =?utf-8?B?azA0RE9EV1FDVTV0NHlPZmozZldQRWJYRFQ5ZnZzM0xEa0N5dWN4L1Qzd2Nl?=
 =?utf-8?B?N1ppQzZlYUlOek9zUHd5dk1iaE1Ha2c3NitKNHg5dG9od01XRVhBY25GWGhU?=
 =?utf-8?B?VzM3OWV3M09uQlB1MFEwY0NXV3AxWTJhMGhiVW8za1A4K2ZlTnUvOVNaRzFC?=
 =?utf-8?B?cVk1bkxrWWNVbi9ZQ3ZsZGpRTUtvZEdMc2IranVNZDNoeXhBK3lWd0pUQkEy?=
 =?utf-8?B?S3dETUZxZzREMmFMb3pUa1M3ZnhXbkdYckNyYjhXbW85cVVHV1YxaExBN09X?=
 =?utf-8?B?Vmp5MXVUa1NoVFJOQ0sxY0taZVIyalRxN0tSWFFrRGNMNEE4QkFLK0dZbG80?=
 =?utf-8?B?L3ZxNHhFOWx5RExjTEg4bEU4ZUR2aTdndDhVUTk1L2Nra3llOENtQmJjZ09k?=
 =?utf-8?B?RkwzRC9UZ2prWDY4NEp4SjdYRk1ZKzk2T1FtQ054dHRZVHlJZWdMbC9KNU9D?=
 =?utf-8?B?TkJ0Mi9vdTcxblN3Sk1FUFNwNE9EN3h3RGhCY2Q4RUVBdDV4TEdrWnhhREI4?=
 =?utf-8?B?N3hJZmV3SDdmeDRXVWg0cXdMRDFaYnlBMzdBY3hqUGFnTGxUVS8vdkNqMDVo?=
 =?utf-8?B?UndzRHZUbHVpTkhiaXJ2Z2J3RW1UU0NqaVVnWkQvRWZJUVAyYWpHRVFoTUhk?=
 =?utf-8?B?Z2EzMnlkQmJSckczano1WWV2WENoZitIZzRSN0htbndJWm5EOUFPS2R1YVJ2?=
 =?utf-8?B?dlE5Kyt3azhNWXpzeEhrckkxSURTdDRQUjlZTkJ5eGdSdTdadkJXZUxBYnFt?=
 =?utf-8?B?V3JNeXhOczU2M3loRU8zR0ZwdXZWY0U2bzBjODRhYllUaDhwazhnaEdhdEZl?=
 =?utf-8?B?b3VYREFUZXhnUDBkV3czQ25IZ0Y3SmhMYWRqZk9HcTlSVlEyQVRVSThrZnhE?=
 =?utf-8?B?OWFLSnhpZHlPeklTeFJ1SWh1eXRpcWExMVhHN2lMOUJ2TVM4a0ZvZS9xVyty?=
 =?utf-8?B?aFZzd1o2UDZ2Ymd3bUNidHlkWWdKbFZPNnczN3RiMnhwbkJGSXYvOFM5TS9w?=
 =?utf-8?B?NXdoMW0vWDZjeTYxejlXK25ZQXBGOStlQjVBS0hTNUZObTM0ZkxIam80bmVh?=
 =?utf-8?Q?/5mVbiWQox96ZkJ5kvsELrWee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45956d03-b930-4b9d-0fb4-08dbebab5f24
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:35:47.2216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIeMxmVlIXenreNAQPFZqTSFl1D/g7bKyro2SYYQR3fulyiQ4SqipCXdSCLMTyrXurHfuKCtCxQ1krZj79qdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-03 09:11, James Zhu wrote:
> Add queue remapping to force the waves in any running
> processes to complete a CWSR trap.

Please add an explanation why this is needed.


>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +++++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c          |  3 +++
>   3 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c0e71543389a..a3f57be63f4f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3155,6 +3155,17 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
>   	return debug_map_and_unlock(dqm);
>   }
>   
> +void remap_queue(struct device_queue_manager *dqm,
> +				enum kfd_unmap_queues_filter filter,
> +				uint32_t filter_param,
> +				uint32_t grace_period)

Not sure if you need the filter and grace period parameters in this 
function. What's the point of exposing that to callers who just want to 
trigger a CWSR? You could also change the function name to reflect the 
purpose of the function, rather than the implementation.

Regards,
   Felix


> +{
> +	dqm_lock(dqm);
> +	if (!dqm->dev->kfd->shared_resources.enable_mes)
> +		execute_queues_cpsch(dqm, filter, filter_param, grace_period);
> +	dqm_unlock(dqm);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static void seq_reg_dump(struct seq_file *m,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index cf7e182588f8..f8aae3747a36 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -303,6 +303,11 @@ int debug_lock_and_unmap(struct device_queue_manager *dqm);
>   int debug_map_and_unlock(struct device_queue_manager *dqm);
>   int debug_refresh_runlist(struct device_queue_manager *dqm);
>   
> +void remap_queue(struct device_queue_manager *dqm,
> +				enum kfd_unmap_queues_filter filter,
> +				uint32_t filter_param,
> +				uint32_t grace_period);
> +
>   static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
>   {
>   	return (pdd->lds_base >> 16) & 0xFF;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index e8f0559b618e..66670cdb813a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -24,6 +24,7 @@
>   #include "kfd_priv.h"
>   #include "amdgpu_amdkfd.h"
>   #include "kfd_pc_sampling.h"
> +#include "kfd_device_queue_manager.h"
>   
>   struct supported_pc_sample_info {
>   	uint32_t ip_version;
> @@ -164,6 +165,8 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
>   		cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>   		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>   			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
> +		remap_queue(pdd->dev->dqm,
> +			KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
>   
>   		mutex_lock(&pdd->dev->pcs_data.mutex);
>   		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
