Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6881C79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061EF10E03B;
	Mon,  7 Sep 2026 07:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D9Npz3b7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4540D10E03B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 07:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfwIMpXqP93ok2pk4A1qUS1x9NKQlYC/C4jY44vGtL2EEibkT2TvLZJf4tjEHCBayLLQ6WX/GI2EscX3vpGor9Xx9L2+UwmLxZqSKe6AGI5Nat+uyrI5YVvrAqYRWgUnFxmyGkBqWhR+OiNI5TxqC5fTyHv7Mauqr/vYVyCyERrppnHdq098xXHzGMFGtbF/MB3iLqLr44/GAP8BR8XNtv4+dXZoRxJVOfe//Q8u/NPPIILsoP52fV2XbuEqOFf1HZUuhF6W9DgPJqbsiB9cFDqngy3QmEJI055MxlzlYiUf18sMsh5tnPOqdmbjYl+rtW9Sfy7sr9IhPagHCPrnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egtr/nMjFrSLP851AjcpMsaAnGTrQqqTvt3ywMJoE6A=;
 b=jwjUZ2zRnVjj/U7t2cAca+10dWrNThsy1qaXxPp3NgWkJtyIkWVEyEINLRc3M2jDSctKvQt+4DjRelg3JBHHVYa2N7zMITwvtzafCnrz/4KxpKUnb8TvGoLwJ3AwTerLB29DYy73sB4srXFTIlvzVg4poFMDoyz7gQph7Er1EOFYow0izlkJGzFBMft8dFSeOGbnNzG/J2A1qu4nKduqutQz8YCYaId3pCgGwcXup+quaBN93awkbVBWHgTCQaJ1kwrnmVeD6f1ggVKi6tUrZ0WQyAuPtQgZ8CAv7XP/Sc3zfi4RyZTP8sMcMCzD7UFSApU2L3MEckGeT6mcApJBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egtr/nMjFrSLP851AjcpMsaAnGTrQqqTvt3ywMJoE6A=;
 b=D9Npz3b719WOwDloGbNLLTrE7KN6KLA18YTLap7ytLws4EP5wj9iGlsA4pOiqPmC1LUgmRDggWopPv1OaHqOAOfAS3cATXOyrxBGW7jJ3iZz7C0d+R3h7MOcmveAPaVD/eJR7qQU0fcwz08PaLKgucDGrye2m26hBGmaErtjO8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:17:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:17:19 +0000
Message-ID: <e6270791-f276-487e-abc7-4ee1a529f357@amd.com>
Date: Mon, 7 Sep 2026 12:47:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
 <20260904072850.321759-8-timur.kristof@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260904072850.321759-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0352.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ea413a-7d7e-457e-3311-08df0cb00da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xehsMxo85CPkjswtjzNeQwJHEaVwRTYUfTkqOGqkalDk8jHRbcojnfUHknXDfGedXMdQDbEDqOBAIonAaEmrXh4XglgdqAAjHqy3dOn41vNJEo+mXD2VJbgC6vte0TggE1yM01Kib0G2YziA5KEFlqh+oisnkLGtT3aRVnAjsr0vWOAQLajlsYkMgEMpVGr1NhbMcqqGIA1gHjrgcXbo9wf/aYTttyBkO+hiZtkaBq+STdNNTt60emPcoMOSIm7S/yMW7RBGnrRwCYiuePHVo4ZJO3KPWNzu4JstOK6rU1J0j9beqbTDAH1IkLJsJ5Ep2rdJ3XGUbNsIDsgRrs0kHqygRVB6pHSSja9IW46h7NIHZzx+Rl6Tdn0Qz+c8ZGDouXNWS3V6v2/YUbEvHdEN+ajlosii/ibOgJyv1i6Kb6/0faAmCF1sqmZszh+gUXrTZDu43O3va2eJ/f7BjAMywQwBsBOrC/ujklVbObvdDEDj50wr9yh9SxDJH591+XZEjoF9nG8gqMVn/Gt0WE9DXP1HtiHfrKF7DkkhsbGc+TcfMDFGXLu2CG+QiVMMdC0ZK0g6xXDs4VOM7/NfifGeY+5IAjrvZnop9yfwpK+9Qee38CJ28E8T+rCfA+OfnhEc1eAlZVwXW52ejWOpP02XIlCooE8rIU8e0j6ufMGHhnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hUMUNWOWVZY0tnYy9qRkVqcUt4Q1FZMTArUEdxdlhFSm14ay8wMk5DN0Rs?=
 =?utf-8?B?NHNPNjNjZ1NpdlBGTFFoSGNFb0w5Q2pRR2Q0VHpiTnowelhTQWI0c00veGIx?=
 =?utf-8?B?Y05QMktiQ0ZMTDdKYzdFOE9HdHhuZFF6UjUxeThTODNSVXB0eDVJdEppeDIz?=
 =?utf-8?B?Z21GdGErYjFydFBxbTlXMGhjd2V6R3lkU24zNHMyK25CV1RFSGZiSlBJK0Zn?=
 =?utf-8?B?a0YvY2diMVpqZHlYMXZwTXNaRVc5dnhyQ2JkTktHSkpMSmZ3RnZxbk4ydklY?=
 =?utf-8?B?RGtXRFhGVm5ycGlGRkZURjcva1lDUFc2dFRaNlBxS0FNQThSYzA1SEVaU1pR?=
 =?utf-8?B?RnFjSFNVOWZxbGhYN1pzekQ5SDZvcjZGS1hsK0VyamJOeVZwQzJ6MU1EaVRL?=
 =?utf-8?B?RHdUcGRyd04rb3NvckxEekdXdXVLeTN5NHJ5Q3oyVjkvZ0E1NmJoMzhlRjlC?=
 =?utf-8?B?NGh0UmtLRDk5bVJ6a3NhZldpaSt1UUR5cHEzanhYcW5HbjJQQ2dFdWdpTFJq?=
 =?utf-8?B?NFV6U09mNHBCZ0YrUkthN0QrN0ZoNzcvdkl4Y2Y2N251NmVmQnpDTmtHYlc3?=
 =?utf-8?B?aEVOQXVkVXcrMkFXa3VCVWxHZEZ1MDdYTDdRZHUya3dHUVZSdnRYdndEM0Jp?=
 =?utf-8?B?a2JaaWlBV3ZOUGRNK3VZM1phWE45RmdxUFNpcU5kZ0RWWjdCVUdPZ2plbys2?=
 =?utf-8?B?eGZHWDFOV3JPUEE1VWR1d0xCT2ovN29abDZFd2lMSEczM21sallDRGYrWWhK?=
 =?utf-8?B?RkV1YU1YRDVLNVlnMjREQmJ3NXFLb3RwSGlkTkxGelB1S2NqV3pYWnZ6V1M0?=
 =?utf-8?B?MVBpRGdsMUJ6QnFyalBHa0ZMWmxncXZBQWxqeVMwTVh4MGJEdEx5OFU4b2Z3?=
 =?utf-8?B?NlJ1cGUydkhwdWRQa25aak1IYUJDanR5UUIwQjAwY3pvbXJHSGZLRk1zMUtm?=
 =?utf-8?B?a3pHdzc3amE3VXpiM25YM3NPKzhMUm1KMXc4UzU1ZmRuUy9mME5JeUVLYmpD?=
 =?utf-8?B?TDRENWpsY0V1SFNEbWlwZnZ5SzV6eUhyOVhFSGpKNDQyc2d3WlMzQWtGY0c5?=
 =?utf-8?B?VnpvRFZzYVZ0b3VVQ1RYdFdUcXNHdDJXL0h4RVptTmRsQXI1VVloNHJGcGhh?=
 =?utf-8?B?QUxlVEVJLy9vZ21QbmFpblc0SnV4UjlOU1k3TlNORHo3MXNRMUpTVnY2YVo5?=
 =?utf-8?B?anRJdTJHVjNydDRrWEZTYzJNNEloQ09QcjBGdzl5UGpSUk1NQ1VnWVFHTkhx?=
 =?utf-8?B?d1RIalZxTmtENjNEQ2p6Wk96STJRMU04Zm1vUEd0UHBTWUFRQ3I4cmtLQmlB?=
 =?utf-8?B?S0JnbDhESWQ1Vjgxd3dNSllRa0QxNGFucTBpOXp1OGtUc1Z2eGNKZkFHRW4x?=
 =?utf-8?B?NTF1dThDRkVuZEo2Uk9FL2RVTEJkSjJJc0pTVXBZeVB5VVVUQnlVclc2Y2p6?=
 =?utf-8?B?Y1VpZEdjNUJQcFlnZ3V6WERLVXdFWVNaeUVSam9NTDJ4YnZUZm44cS9ZRURM?=
 =?utf-8?B?UjYvY0FTSUtjUWxKVWJXU2o3VEw0V2o2UmdPbHgvUUNqZ2Rxa1FQUXJobE55?=
 =?utf-8?B?WjlUYUtqM1J5VGhWTkpOYU9MMy9lNHBaeC9sYkNQU0lmYUlkVUZBS1RtQ0JM?=
 =?utf-8?B?QTFVK3J5QzE2QXRpVHlSVmZKYkxpRVhBOGRDd3dnZHNtVFhqOEZlbnpKY2hT?=
 =?utf-8?B?YzN1bUJGS09STHg4dk85OTVhVjdQZnMxM0FkRmR1Z3lCSXpBQ1RmeU1YRlpV?=
 =?utf-8?B?QXh3cE9mQ0tLcU1KK3lJeTUzV0szVXBKS0JkcHVYTEZNREVTbFViRktYYzVL?=
 =?utf-8?B?VUx4TU9UajYvN3h2cGRsdEhRZVI2OGozaUREY0ZtMkpzdzVmVG9hdFRibE9R?=
 =?utf-8?B?amZLcnc0MUcwS1BBeklJZkJPcnlVUnhoTlFpVFlDYllSM1gzZmZwSGZWcC9M?=
 =?utf-8?B?eGI3S0tNTm5xZW1adVpBc21KYmZ3bWRmMlhxVUdDbC9PbUhQUkgxZlBNaFMw?=
 =?utf-8?B?YWZJSVV6V05raDZlaXhIcGNwa3JHU2RSZjRLT2IxbDRPWC8xUGdCcHVDTTJl?=
 =?utf-8?B?MHEwYld2RTVQYzhhVC96U1JvanUyWElEK05zSnZPVTNpdzFHRmNlNm04elB6?=
 =?utf-8?B?dkEwYktwNnJyMVA3Y2F5VEh3WStoUG5meCtDcEx6VTZQb0VHWEtXZ2VGSmZQ?=
 =?utf-8?B?YU91ejRFWnBhUERiVytZd0ZOZFdLSHltZmw2ZCtRckwvTEh3cGVzUXdFNTlx?=
 =?utf-8?B?Sys1eU1teE8raVNyc2E0N2c5aUQ2aW0yMzNvY2lBRmg5clZCZncxSi9SV2Rt?=
 =?utf-8?Q?HGaSZxWipSA1AC9XpP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ea413a-7d7e-457e-3311-08df0cb00da7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:17:19.3813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFLIB1EU3S9dIzWmeFGxUW+WQejiL7v87+uLdrXs7tu9/jRIEN/WDe19jcIFS419
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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
> Remove the caller_handles_kernel_queues argument from
> the amdgpu_sdma_reset_engine() function and make it
> always handle kernel queues.
> 
> Now the SDMA recovery sequence is more consistent
> between callers for the KFD as follows.
> Before recovery: first the KFD is suspended,
> then the SDMA queue contents are backed up.
> After recovery: first the SDMA queue contents
> are restored, then the KFD is resumed.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 68 ++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>   4 files changed, 38 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 9eebd8380834..07aac5b3ea92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -542,16 +542,14 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
>   }
>   
>   /**
> - * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
> + * amdgpu_sdma_reset_engine() - Reset a specific SDMA engine instance.
> + *
>    * @adev: Pointer to the AMDGPU device
>    * @instance_id: Logical ID of the SDMA engine instance to reset
> - * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
> - * will handle it.
>    *
>    * Returns: 0 on success, or a negative error code on failure.
>    */
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
> -			     bool caller_handles_kernel_queues)
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>   {
>   	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>   	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> @@ -564,20 +562,23 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>   
>   	mutex_lock(&sdma_instance->engine_reset_mutex);
>   
> -	if (!caller_handles_kernel_queues) {
> -		/* Stop the scheduler's work queue for the GFX and page rings if they are running.
> -		 * This ensures that no new tasks are submitted to the queues while
> -		 * the reset is in progress.
> -		 */
> +	/*
> +	 * Stop the scheduler's work queue for the GFX and page rings if they are running.
> +	 * This ensures that no new tasks are submitted to the queues while
> +	 * the reset is in progress.
> +	 */
> +	if (amdgpu_ring_sched_ready(gfx_ring) && !drm_sched_is_stopped(&gfx_ring->sched))
>   		drm_sched_wqueue_stop(&gfx_ring->sched);
> -		gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
> -		amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
>   
> -		if (adev->sdma.has_page_queue) {
> +	gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
> +	amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
> +
> +	if (adev->sdma.has_page_queue) {
> +		if (amdgpu_ring_sched_ready(page_ring) && !drm_sched_is_stopped(&page_ring->sched))
>   			drm_sched_wqueue_stop(&page_ring->sched);
> -			page_fence = amdgpu_ring_find_guilty_fence(page_ring);
> -			amdgpu_ring_reset_helper_begin(page_ring, page_fence);
> -		}
> +
> +		page_fence = amdgpu_ring_find_guilty_fence(page_ring);
> +		amdgpu_ring_reset_helper_begin(page_ring, page_fence);
>   	}


Since this resets the engine, a different way may be to have something 
like below (similar to amdgpu_multi_ring_reset_helper_begin) which takes 
care of all rings in the engine instance.

amdgpu_ring_engine_reset_helper_begin(guilty_ring, guilty_fence);

amdgpu_ring_engine_reset_helper_end(guilty_ring, guilty_fence);

ring_type = guilty_ring->funcs->type;
eng_instance = guilty_ring->me

Thanks,
Lijo

>   
>   	if (sdma_instance->funcs->stop_kernel_queue) {
> @@ -612,22 +613,25 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>   	}
>   
>   exit:
> -	if (!caller_handles_kernel_queues) {
> -		/* Restart the scheduler's work queue for the GFX and page rings
> -		 * if they were stopped by this function. This allows new tasks
> -		 * to be submitted to the queues after the reset is complete.
> -		 */
> -		if (!ret) {
> -			ret = amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence);
> +	/* Restart the scheduler's work queue for the GFX and page rings
> +	 * if they were stopped by this function. This allows new tasks
> +	 * to be submitted to the queues after the reset is complete.
> +	 */
> +	if (!ret) {
> +		ret = amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence);
> +		if (ret)
> +			goto unlock;
> +
> +		if (amdgpu_ring_sched_ready(gfx_ring))
> +			drm_sched_wqueue_start(&gfx_ring->sched);
> +
> +		if (adev->sdma.has_page_queue) {
> +			ret = amdgpu_ring_reset_helper_end(page_ring, page_fence);
>   			if (ret)
>   				goto unlock;
> -			drm_sched_wqueue_start(&gfx_ring->sched);
> -			if (adev->sdma.has_page_queue) {
> -				ret = amdgpu_ring_reset_helper_end(page_ring, page_fence);
> -				if (ret)
> -					goto unlock;
> +
> +			if (amdgpu_ring_sched_ready(page_ring))
>   				drm_sched_wqueue_start(&page_ring->sched);
> -			}
>   		}
>   	}
>   unlock:
> @@ -662,13 +666,11 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>   		return -EINVAL;
>   	}
>   
> -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> -
>   	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me);
>   	amdgpu_amdkfd_resume(adev, true);
>   	if (r)
>   		return r;
>   
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index cb41453c1a19..5709d438e824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -153,8 +153,7 @@ struct amdgpu_buffer_funcs {
>   				 uint32_t byte_count);
>   };
>   
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
> -			     bool caller_handles_kernel_queues);
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
>   
>   int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>   				   unsigned int vmid,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 77f385b9ef53..796ea9f74763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1583,7 +1583,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>   	int r;
>   
>   	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, id, false);
> +	r = amdgpu_sdma_reset_engine(adev, id);
>   	amdgpu_amdkfd_resume(adev, true);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..f9fbc5628fb4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2576,7 +2576,7 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
>   				continue;
>   
>   			/* Reset engine and check. */
> -			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
> +			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
>   			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
>   			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
>   				r = -ENOTRECOVERABLE;

