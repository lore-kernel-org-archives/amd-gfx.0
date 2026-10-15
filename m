Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4A4CC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 21:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17681124BE;
	Thu, 15 Oct 2026 21:36:39 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DE91124BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 21:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+allVkGuEe63LxIr4IXWD0UKAmWdSD4yfb+oA97mk8ncx7Ouk/HKImHrkC4Y3i1VelUfmMt+dhG/M1WZMs7Jc/3sASJ3oxAHcyiY/AMQ5oSFi1ODpyWUU4U66UH9HoGLFbzWDb57Fv5mOkcBlvuGIKJP/vFjeUvUQYp3lHs9THa7n4YVjUEPtZEqmGirBIkSf9LxqX8UmGWZvE+z6rNjnai6uddJNYiL2iRgLzksr196lz9mFbDmFCaUDJdJp9PTF/4PU9a5H/CpJJyDRV5pi45gSi9ccNsoKjZ+SllTb/Uq41N+3n5Dg+RWBZCzXr2iXOU1ypsk5DL8NZgJDW71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaFN0yZbQCx5B/ARktqMGElzRo7OAMRWuMbHdYGlpNc=;
 b=fNFtzrNPVhiwyHMcaEXTFY6MiHYc+irwdZDuRGxL8U5kTlKVc/B3dEqVoCwyHEQLtu7EDR/PaoVEzxBDGmAvhDDVkZ+VQHca5ZCyARaQZDYToUwUVY55uwbQJpGsDTw7jJL9+Dqoj91jIMGU8B10gAHuSlwAqbq5IizCINtJncrmoqaldacl/tXwx9wRTgJI7FSlRW1/+hAzz12Q1vqp/Xk/1dIyRyqwuYJwuyMACMq+a2iW1ordUSiZB/xuP0CYpvFNpQ+KH5oYW90dKBJfTY43MAnd1GQJ9GKovoNkhNBSqVYhACJCPj8oSYqRQCFLiUGkEvdRcG0G1H6lMZexGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaFN0yZbQCx5B/ARktqMGElzRo7OAMRWuMbHdYGlpNc=;
 b=hofDSIn51WbaS5+1QwQKWrsUURTTLVdQOYcIzVYslnGotpE76pjDf2YOAOAqHwIdvauakbFuA73kJUwSwqMr/r0VD+lmNaicC24SVDsgKYKzpMpjGogmorPFtY9xkfBVOY33wARAP6eYr4A8BhTxanqQ9r+CkXB+lJChIdeL3kI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by MW4PR12MB7333.namprd12.prod.outlook.com
 (2603:10b6:303:21b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 21:36:29 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 21:36:29 +0000
Message-ID: <96e3f2f5-6419-4349-8c98-d7717d02a276@amd.com>
Date: Thu, 15 Oct 2026 17:36:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdkfd: don't drop an SVM CWSR reference that was
 never taken
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, David Yat Sin <david.yatsin@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 446144b8-06f7-4ce1-1386-08df2b045f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|5023799004|11063799006|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: EZdRYt9h4JprB28zBHTIGIJGnsjP/ajScxDBEffD2t4fC6n08ZOU19DyWc0sU4zyPyXcDmTeBPq4GebCwwxXccNJapEU+9lNZPyZ5ZprpVCoaY40RS3mMmF7HSXRMiZawRi2PLkdRwTwnNLOy8iqdCShNkUiJQVuljcjCxZbn0kXDVdFoVyC0SLwkiwaW1gx3BVzTvLk1qnJ7RsgG+1Lt0ar+U2EBI57FUr2x4ffI+cXsNKirPjzld5V/63xkF+0FbSOWnmZNM1cGvJA+9qoF5WNRSChTdnwMTvtn7EvEQwd7FCn2DCCZAV/pxtHtbz3fLFX3mtVtX1AjjwQHdVgGiZKWzMhwAEyygMPizrt3Fx3YFhhyyhP8hWHUgOXAQKKLyF6kwxxO1nva6xdXga2O5Xsi4ejI/yr0I3X61ERKZLfKZLekMzbx0gr7ecWaWSqQGykD37PEhlKzTaE6ZgwuqFIdFgrI1bEsieiwBI2RYLH6MXz+4jlI/ATalM0NBeo0Ti5HuSRwRSH+b2EGJRWsG1XtE6ggfrOfY+PGCla9JhbtNlSjPXEEwn99pIgEu+HYhLUabsDvT3ba54tpH0sZZ+KIyHyjVF+FK+Q5El76hn3wpWKHy/nGE6VP0pu8uSf2HwNys4+ULihtwgA54U2PjkV8W2bbAj0O1XwTvScc7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWUyUzJrcmtscGpEQkx5Y251YldsdFlHVTFMLzFtSnpFMkZmTFhGY2FJZW1u?=
 =?utf-8?B?RlV6aG9UcFBUTWtJai9iS0hQbUVhRW9kcXV1WTErVVg0cWYwcWladHluS01s?=
 =?utf-8?B?UUNYRXNTTVpnaGExQnQ3bjlETGppeEd3enIxWStGZi9sU1hIZG9qT0wvWXhL?=
 =?utf-8?B?cmhYOHVsQ3VPYkRlSGZia05iVCs0OEdBVlo3em5kKzd5R2U0eElIaFdYQ3J5?=
 =?utf-8?B?RlZXM0N0Smt3Z3lDNG1WVzIvNEo1U0NXNUt5NEZlYm5oYlJZYmN4VTJsT01N?=
 =?utf-8?B?NUMxV0lXVHZ6VmdmVTJucHBhMi9PaDNJK01DSlZNOFNseEdkM3pwYlpoakNS?=
 =?utf-8?B?RnppeGRET0hCQW02cktIWGovTnBZSS80TVczK0JRQStvdC9DeVVWQmNpZ1hq?=
 =?utf-8?B?NXY1NFo1Y3hvQVp5a2hTMWx0QkQvaTFGcjVINm1DTDRMWUhCTjE3bkQzQXFx?=
 =?utf-8?B?Y2Z4RmxnVW05Ym5VVlNIY1g0Kzh2SVlYeFRpR25hOHhxbXYzQVBObmNZaDNW?=
 =?utf-8?B?SjQvMFByZ2RPUGFsYUYxUnBucWJtUXZ2R3ZkRU5zb3JDdU00MklWWElVQ0Fl?=
 =?utf-8?B?VThpUmtGQ1R5Rkd2aTJMQis5Q25rSVZnRFJIYWU2TmNMdVJUMjU3QmJNbFJG?=
 =?utf-8?B?TktDWmNUWWdFdVNrZC9xUVJHNG1PeVJwTWNZMEVPanhlTVBQelhHUTkvMW5t?=
 =?utf-8?B?TU1INWIyMmhCRUswUlFXbGprdVhBOHdJSW9naXJyZ1oxM2xzNDBJc1N4ekxK?=
 =?utf-8?B?a2NRbEVjeVVJczZYejdyNzlRNm90NGhIQUlHWnNlK2Z0QVM1YWlsTlVYVzVs?=
 =?utf-8?B?Uk1HMFpEdnE5YnkwNDVaVnp0MGhqSlZkYXlXdFVneXZNYjNOK0VrYkRtUE9j?=
 =?utf-8?B?NFJqRlhiWGdFY0IyZkR6WXIyWUxRbDkrbHp5OHN1WllZUjFwL3BlNTJSK1NJ?=
 =?utf-8?B?MGcxeTEvc0lSY0lZbWRKbW9acU90cmRwb2Q2emF1TXNYNHBXQUQ1QjYwd09U?=
 =?utf-8?B?S1lYRjRrT3N6NHBQWi90MWJpOVhFMVRJbVM3RGVmMU9GeFRoVExVM3BrcUV0?=
 =?utf-8?B?NEhkbk56a29RbHI4bmt5TVpQNUUvZ3VZMjlXbUVvTzdic1lKcXVxMk42T1Jq?=
 =?utf-8?B?T1d0SDRaL2JyOWhiTnBFYVBwd3FMVUtsT0FLZnR2L1dhWkFtdTR0MFFwK3pC?=
 =?utf-8?B?aXd5clhPUWpJOFRlQWlNaDBBVVFyWHVod05tbWhSOVhYMHNZMTV0Vno1YVpa?=
 =?utf-8?B?MHI1aWJpMWdubjJxRC9YaW5ITUM1NFlacmREcnNFaFR6YitoeEFMQ3YxRUlU?=
 =?utf-8?B?QXorTnQ5cklEMEFOclRTRWY1d2Y4TkV2a3JlSEQ5ekl3MEc4SlpSY2YzMUp5?=
 =?utf-8?B?MWFuenpNT1ljaEVab0RFTkdobE81MU5tcm8vS1Y4V1kxZ2dmZWthMFBIaGlm?=
 =?utf-8?B?N0huaUFVeE5tamFYbUIvZVlIeWU1VHpiLzkyVGpKdG9zVWsrNERWcHE1eEl4?=
 =?utf-8?B?K0NkWXVvNWdnMnNxcDRRTW5QUVpKc1lHWnptVGVYWi9zU0N3ZHZUeWh1QWtX?=
 =?utf-8?B?MGgzSHk2MWk2bDl1RG5PVkdvT3IwQ05mbGJ4SDl1bTJRYXEwSTJaUUpveTBD?=
 =?utf-8?B?cjQ3dEdYV2xnVmdWZ1pNdGl3MDA1OTE4Tk1rajlUdTZaUFZGZXdwb3lENk03?=
 =?utf-8?B?ZVpXREd0UnhCWDVjTEI5NitTVDdXUXg5TFpWRGczZElVMU5HT2V2SG9vRjRN?=
 =?utf-8?B?YWxaTWNjN2NsZHE0WTJlaFFJcnZDeGViSkhiVGNFcXJ4OGpjNFBsOUNJRkE1?=
 =?utf-8?B?RUJVbExjNEFwWDBBNk1uU1VLakNHTzRFek8rZnpoRWorN3RxOXp1QVpaZ0VF?=
 =?utf-8?B?bERQcGp0K0JleXNaNVV6WEVDRTEra1hweDlDUGkySXA0elVUVE85YmV2ZVA2?=
 =?utf-8?B?a0V2eDJVSTZGaGpLY0lONnJVOG1UYVFYNTlHc2xkMUhQN0tIV0RseGI1TXEw?=
 =?utf-8?B?Y0JpdFhmUU5RSXBzN21EVDRZcU1JZVVXd1FTb0tNVmdrKzR4am9lL2lGMUdB?=
 =?utf-8?B?OFAxdkxpcUowRTdJZnI4UDhickRrOFpXYWxqelNBQi9qTlhCTDBTZy9Tc1d1?=
 =?utf-8?B?VFVDcVRRMGRSMHpqeHR3MTVWYk1BQmpaV1RNTlZpYXg0bC9JbkpVNGt2R21t?=
 =?utf-8?B?NG9yU2tlYkVybHlYSlg5MVZCdzJDdklQcHl1Wm1ydEFQeHJYbUNGUmczSVZh?=
 =?utf-8?B?eG1TNUNyRHpINys4d3Y4OWk5c3RjbjNrS3psUXA5TnJZTGN5V2pXcFZuc2hF?=
 =?utf-8?B?OW9zN1hrKzk1Y2RUNWRUeWRoVFhMNE5EWWh2YUM0S3FGOU9RSDZJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446144b8-06f7-4ce1-1386-08df2b045f52
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:36:29.2731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzkwXwWg5Cxmam5Mt3Zx89MxB6ZAqnB1sJRf9lSGq5FQNew3DqHBGGNDCKClv3Y9IbUpebqfk3Nfo+DfqeKdkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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

On 2026-10-13 05:20, Jesse Zhang wrote:
> When kfd_queue_acquire_buffers() fails, its error path calls
> kfd_queue_release_buffers(), which also drops a queue_refcount on the
> SVM range at ctx_save_restore_area_address. The SVM range is the last
> buffer acquired, and kfd_queue_buffer_svm_get() takes no reference when
> it fails, so on every error path this reference was never taken. If
> another queue of the process uses that CWSR range, its reference is
> dropped instead, and unmapping the range no longer evicts that queue
> while its CWSR area is unmapped from the GPU.
>
> On navi31, with queue A using an SVM CWSR range: munmap() of the range
> logs
>
>    Freeing queue vital buffer 0x..., queue evicted
>
> but after a CREATE_QUEUE that reuses A's CWSR address with an unmapped
> write pointer (-EINVAL), the same munmap() leaves A running without the
> message.
>
> Only put the BOs on the acquire error path. The warning and the eviction
> are back after the failed CREATE_QUEUE.
>
> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index ae3e7c54014a..6010a5d7a7eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -230,6 +230,15 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
>   	amdgpu_bo_unref(bo);
>   }
>   
> +static void kfd_queue_put_bos(struct queue_properties *properties)
> +{
> +	kfd_queue_buffer_put(&properties->wptr_bo);
> +	kfd_queue_buffer_put(&properties->rptr_bo);
> +	kfd_queue_buffer_put(&properties->ring_bo);
> +	kfd_queue_buffer_put(&properties->eop_buf_bo);
> +	kfd_queue_buffer_put(&properties->cwsr_bo);
> +}
> +
>   int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>   {
>   	struct kfd_topology_device *topo_dev;
> @@ -343,7 +352,13 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	 * dropping the VM reservation.
>   	 */
>   	kfd_queue_unref_bo_vas(pdd, properties);
> -	kfd_queue_release_buffers(pdd, properties);
> +	/*
> +	 * The SVM CWSR range is the last thing acquired and a failed
> +	 * kfd_queue_buffer_svm_get() takes nothing, so only the BOs are held
> +	 * here. Dropping the SVM reference would drop the one of another queue
> +	 * using the same CWSR address.
> +	 */
> +	kfd_queue_put_bos(properties);
>   	return err;
>   }
>   
> @@ -352,11 +367,7 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	struct kfd_topology_device *topo_dev;
>   	u64 total_cwsr_size;
>   
> -	kfd_queue_buffer_put(&properties->wptr_bo);
> -	kfd_queue_buffer_put(&properties->rptr_bo);
> -	kfd_queue_buffer_put(&properties->ring_bo);
> -	kfd_queue_buffer_put(&properties->eop_buf_bo);
> -	kfd_queue_buffer_put(&properties->cwsr_bo);
> +	kfd_queue_put_bos(properties);
>   
>   	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>   	if (!topo_dev)
