Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4344AC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF68310F199;
	Sat, 16 Jul 2022 14:37:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBD710E00E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 23:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCFqS2iP0INW3+tIe+aOt7a9kc+qN8CQp2FWExfvgfzJChiCLbECJiWEOyr5XXYfpztP9IeXk4AdjFwSSAwxwmnUiH9XkJhcwBkv6SPBo+vnqx+YClVD6JFgmZo5ExuBF55wa7m3z9UMey8+qXXnfaXGQCugUkRFYODnO6cdJiOuWdT0FaS5dN1hEvCpMXOUBDeWXz0gQj+rWV0axsksuRHWQEcAYmhhPgwNaMmDzhBFTJ6oKhkKNrzRhqG4xm2NNP5yuP/sEhhWpF+C6wcNOx5E7eW58tm9y7In8l7lORREl+RcH4f/f6aSbJs4B1bnjz5i4hO5jnGXTJpls+ARDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXFB6o3QKlVo1kjXaV8k5U8P4r8Vk0Ung+S5D++DFV0=;
 b=Q3VTUZfUrxLj3MvlvO202rjZjWSnr5QrZERKBaso2TM8V8+xWoPt0Aigb+EPDr43xwT2F3jDQtIeqdfrk2L9a3E1fSFNH3OhMUQh3wudOJhXUQ5qahQesjEgibFDxowgijCrwN2138Dktw9ypJP+g/xDtrgKM40ON8mES9cECG8vMJEISrgdXRUELUKlJmWWC1xxR64bATeD5IyArZK5+h6bATnK0Gw5uBgcmaV2tARAIq6S/g1DCv8GKq8B4uwgGIB3YsR9UC7VibHMZsa1QI1iIeW4zZ7EKFvHK591XqvSZ7tLGoF+PpPekAoAqg58zB1pXwUupd8T3iO1v4bxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXFB6o3QKlVo1kjXaV8k5U8P4r8Vk0Ung+S5D++DFV0=;
 b=OfMN39M68QpBeXfTZJtWS8KlWE8JlRD7By0o1KAkyUhTLGc7qQZ6W4g2BFKs7YtJ2J20owduLPKXv0LqMqUeTVt743uekCyOwFHCJ6ELGp9ELmT9BnW7wkRyRGZg5BdrqALKhnnQoh8+wiNLPfVpKrs0L/ArsjPT6JFH0RiDnjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 23:00:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 23:00:02 +0000
Message-ID: <ee7aefc4-947c-995e-f5b6-205f11fab5cc@amd.com>
Date: Fri, 15 Jul 2022 19:00:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <20220712015604.7697-1-alex.sierra@amd.com>
 <20220712015604.7697-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220712015604.7697-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:610:cc::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccce54e4-2f7f-467a-a8fd-08da66b5c042
X-MS-TrafficTypeDiagnostic: BY5PR12MB4147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gErvipqVciAvOKzo8O4HFg2rp06s2Qitg93GCmOKYZiwaUqWlnbKywjeI7eOlFdpBiGngVxH2dk+LuU6TBoxrJWSObLtxui5mzRLt76MG8kBR5/ReoL35oY+PLa6vdfasaj+PnOagpdBZBkIFDlh4sDeSR5hGoROxYeJ3haGKS8hAAqVePj0tak/p3H5RLKkbt9SvsZWICLVvScZ0Z0dWn0lHg0J4fqLCc8ANoOQk3pmR9aq1lw7zNe2eXNDy1D15KhuKVQ7OKlImyfBxx2jFgjTbiQ4SkaeW4FYB66bGXKzhJO2xYwQsMJVuqS/YPrJAtND1qhQyEzEJHA4tV4XKhX/X6ezwTX68sFJdPRZDusyfDlRiqcGSfgHdawCohddQCOFCXy0+BbcU8EYZO2e4iKzQE7l8PCBb3GMQR5mOzrqR3D4qZPFZbFwlx5SdKox94fdSEa6VZAPCNUq8xUyCql7f1/wu+t2M26ckCcn55GvIZL7xbazRkysL0jis1f0H/lGKC9F1VyUKIeTwrLpdimBlF2FDgHGGlZ2TTOfjrhTjJBD41sYGUVPGSNBbZ2cpzkMZ2DxQHvpnKTC5lgQgA9JFNnpMXir4EauNBvZ+hBYKssv6YTigWieL9+mp00vd3bpyygLWiu7ENYyV8/YRXiGBHjaklLsVuVRDI+zErkcH4y1BQJMhS2YK3DXx+GLfmj6ODC4edXySZoU0x1cnqChozg75gPvpJzPZ51u7owon9E3BzCWlWCyMEI1iEoUcp16ob6OfdFvgX7RPRICaXlVFND9LeegzC7lorneXl6ZscBXn24CJJmUhfmjvPqy8VoTto1NjHmKglloJ/m8IA3WXqV+bWCfgcOoZw6PzEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(38100700002)(2616005)(316002)(6636002)(31686004)(37006003)(6506007)(86362001)(6512007)(26005)(36756003)(186003)(6486002)(31696002)(53546011)(41300700001)(36916002)(66556008)(2906002)(66946007)(8676002)(66476007)(44832011)(83380400001)(30864003)(5660300002)(478600001)(8936002)(6862004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhvVGxueFFhTDYra1VYTU1rS0U2bTBHVGxJN1NKa1ZiaCtJRSs0ZGVscmM4?=
 =?utf-8?B?dzlyMFpVZWNkQmJsVHJGVnVwOFBUenM4aG1icktZSzFHSlBvSk02Q0ljalRj?=
 =?utf-8?B?d3NzSTNXWm9XVUE2UkVyclNSUzhYM2ZnUU50T3J5QXVMSVJOcEhxdDQyVWx5?=
 =?utf-8?B?Z056Q3JhY29lZ2tFajRPL1oyRTRuOWpWZlNodDlKQ3dXb3hYbUdMcGNJSWM0?=
 =?utf-8?B?b1J0U2pZcEdDSEppcjFSci9wWEJHMWVZZGMrZysxeHVCem04QndmVW9zVGNL?=
 =?utf-8?B?ZEpNNytvT3RrRlEzY0lQWExWdlNtL0dSTVY3UUp6NUE3QWlibVkyTHNFeDVU?=
 =?utf-8?B?Myt1OTBDaDBLaTkvblVLZTlObDUwRFFMYnFDVFdyRzltNy8vUlh0NDlvWS9J?=
 =?utf-8?B?VFo2QjdvMm1CbUFWc0Z4M2NUQ2V2V2U5Vnc2TDFjTkc3Qks1QW1xdTkyYThD?=
 =?utf-8?B?cldlaDRMcVBId2hMZUFkSXErKytFQnZ2Y3d3Q3haZzJwSzRnNks1bVFBakZQ?=
 =?utf-8?B?aXhTMHdyL1FKYVdXZGs4N0pORkxvamVaSEs4dXE1SktRNDVSU1lGVVBBSTZq?=
 =?utf-8?B?aGRETmN4SHhleW5IZlI3ZURWN2I5QXZ6TDVid1FvdGs3MjE1TjVtWUh3K2wy?=
 =?utf-8?B?SU9PSmNSUDZNbVFvZUhDcjZoZ1ppRVZjbmptN3cvazB0TndBQjE2NEpKUC83?=
 =?utf-8?B?Sko1TWdON0svL0VHTFVoL28rbTJ6dmFzMGtJWnBMeG1HT0pVdUZTRmtGZjFZ?=
 =?utf-8?B?WGVJWUNnMC9HVU5WZ2JTU041a0grOTFNaGlvUEFmcGxBZyt0VjVGTFdLMHVK?=
 =?utf-8?B?b0tZWUUwUTBER3JtS3QwNWRWNlJSVDBxUDdLdVlreTFmdjZ4UmJpVEo3ZjZv?=
 =?utf-8?B?T2x5c3UvY29yZ01RaWNuYTZaTkY4OTlETGx1dmFueFduc1BWZ3phUE5wUFZ3?=
 =?utf-8?B?NmtHT0RuUnN4b242SlloNzllWWhCRTlWVVhMdWd4aGJnK3B5clpJUnhoeFlS?=
 =?utf-8?B?UjJNUWY5OXRLQSs4QWVDd3NHdUNMUUQ1VFJMdHNROTFaUkxUWCtCNS90cUsz?=
 =?utf-8?B?cEZlZzBVTEtwNmo3eUlFOWw5ZXZneDRMcnl6UnU1N0tLQzgyL3lsQTZOb3JH?=
 =?utf-8?B?VGhtcS9TY1diWHkvTzM5OFBOd0NxbkdwSytEc2ZGcXFSWkd3QmFNOWlnQmZB?=
 =?utf-8?B?eXBSVkxqdjhTeUdaK1R0RDBRVXVxVzhDMjdCTldVaUQwbXo3WEhBN0RuWXF3?=
 =?utf-8?B?ZFZsR2xTSmFJSkdSd3VmUDJaYkVXRFZLUkRWUUNRbVFFQTAvMVFvQjFrRWhZ?=
 =?utf-8?B?c003Z3YvV0dOZ1ROOWdMdXdGOXo3UjhicXozVWpSSHNyRmVzakE3NHd4czNv?=
 =?utf-8?B?b25lN3ZDaFVralpHMEp4Tm1ialpYK3pYYisrWUppaFd3TnNYaEhDN1J2LzRC?=
 =?utf-8?B?clU5dTJmZFhqL1ZZcGNXT3g4a2dWMFRHYzdvS01mODZPTktMR1pENTRUZzRi?=
 =?utf-8?B?Um1rYnhaZVAzcVc3aVFvTHZHT2VwbkU0N1pCZFlZUmpLMFB1Y0ZXY2d1Q01t?=
 =?utf-8?B?d1lRZVYxZmczK0dhc3JvL3NjSjNpakZ4aHp5ZzluU3BnVTd4UTVINTM5c0tp?=
 =?utf-8?B?YWF1V1VycVNtUHhXZHFwRStpVkFpNnFpRnY5SnVlT1p3dWFHY1VKdVdNN214?=
 =?utf-8?B?aVhZbG4xNnJGL0Y4N0RDK2tyTUNYVDY0QU51MkNLUTNBa2czZ3VQamt0Wmwy?=
 =?utf-8?B?ZGJRZVgrOGpVME1kZ092MVcxQ3ZrNHlqMHg4Szc2cnBORlFqbWlvTUtpL1Bv?=
 =?utf-8?B?cWlhdnE5QWxzYit1MzZpRkRrRVJTZTVoUzhiTy9rck0rMlcvMERCYjdwT3VI?=
 =?utf-8?B?bzUrRmpSNkthOUVEMzVqejRVNDhIWERRQ0xjMzdlYXB0OENsdjZJUGFwZnp6?=
 =?utf-8?B?bHlueHplYWFFem9XaWJZOVBhVEJ0Y09lWnF0YWhNRjU4YmNZRCtEYTh3dVA5?=
 =?utf-8?B?alFDanN1d1hxZzJBb2VNVkVDVVUzMU9Nbi95THoyako0bTkrSzgxNi8vWWtM?=
 =?utf-8?B?TlpMaFM5NWViR1ZINVk1KzlnT2FVMFpVcjBEV0FGM3RkSi83NXRNTDBaTW92?=
 =?utf-8?Q?/bkK/R9XO4iAFWt9nLVRGTHaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccce54e4-2f7f-467a-a8fd-08da66b5c042
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 23:00:02.8460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWWmsqZlNG0/9bGrzETyScIBY8O5uSWYTb7zkGclB1ZrXYDNLNdNaVAf8hid6hjTeU5HDBaKDuogk1I53KC9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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

On 2022-07-11 21:56, Alex Sierra wrote:
> [WHY]
> Unified memory with xnack off should be tracked, as userptr mappings
> and legacy allocations do. To avoid oversuscribe system memory when
> xnack off.
> [How]
> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
> API and call them on every prange creation and free.

One question and two nit-picks inline. Otherwise this looks good to me.


>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 ++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 25 ++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 60 +++++++++++++------
>   3 files changed, 60 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 73bf8b5f2aa9..83d955f0c52f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -305,6 +305,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>   int amdgpu_amdkfd_criu_resume(void *p);
>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +		uint64_t size, u32 alloc_flag);
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
> +		uint64_t size, u32 alloc_flag);
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD)
>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2bc36ff0aa0f..7480e7333e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -129,7 +129,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    *
>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>    */
> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	uint64_t reserved_for_pt =
> @@ -169,7 +169,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
> -	    (adev->kfd.vram_used + vram_needed >
> +	    (adev && adev->kfd.vram_used + vram_needed >
>   	     adev->gmc.real_vram_size -
>   	     atomic64_read(&adev->vram_pin_size) -
>   	     reserved_for_pt)) {
> @@ -180,7 +180,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	/* Update memory accounting by decreasing available system
>   	 * memory, TTM memory and GPU memory as computed above
>   	 */
> -	adev->kfd.vram_used += vram_needed;
> +	WARN_ONCE(vram_needed && !adev,
> +		  "adev reference can't be null when vram is used");
> +	if (adev)
> +		adev->kfd.vram_used += vram_needed;
>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>   
> @@ -189,7 +192,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static void unreserve_mem_limit(struct amdgpu_device *adev,
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
> @@ -198,7 +201,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		kfd_mem_limit.system_mem_used -= size;
>   		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +		WARN_ONCE(!adev,
> +			  "adev reference can't be null when alloc mem flags vram is set");
> +		if (adev)
> +			adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= size;
>   	} else if (!(alloc_flag &
> @@ -207,11 +213,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		goto release;
>   	}
> -
> -	WARN_ONCE(adev->kfd.vram_used < 0,
> +	WARN_ONCE(adev && adev->kfd.vram_used < 0,
>   		  "KFD VRAM memory accounting unbalanced");
> -	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
> -		  "KFD TTM memory accounting unbalanced");

This looks like an unrelated change. Why are you removing this warning?


>   	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>   		  "KFD system memory accounting unbalanced");
>   
> @@ -225,7 +228,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>   	u64 size = amdgpu_bo_size(bo);
>   
> -	unreserve_mem_limit(adev, size, alloc_flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>   
>   	kfree(bo->kfd_bo);
>   }
> @@ -1788,7 +1791,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> -	unreserve_mem_limit(adev, size, flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>   err_reserve_limit:
>   	mutex_destroy(&(*mem)->lock);
>   	if (gobj)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b592aee6d9d6..b62ead8d70bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -260,13 +260,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   	}
>   }
>   
> -static void svm_range_free(struct svm_range *prange)
> +static void svm_range_free(struct svm_range *prange, bool skip_unreserve)

I find it confusing that the bool parameters you're adding to 
svm_range_free and svm_range_new mean opposite things.

svm_range_free: false = update memory usage, true = don't update memory 
usage
svm_range_new: true = update memory usage, false = don't update memory usage

Can you harmonize these with a common name and a logic? Maybe bool 
update_mem_usage or something similar.


>   {
> +	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
>   	svm_range_free_dma_mappings(prange);
> +
> +	if (!skip_unreserve && !p->xnack_enabled) {
> +		pr_debug("unreserve mem limit: %lld\n", size);
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	}
>   	mutex_destroy(&prange->lock);
>   	mutex_destroy(&prange->migrate_mutex);
>   	kfree(prange);
> @@ -285,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>   
>   static struct
>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
> -			 uint64_t last)
> +			 uint64_t last, bool is_new_alloc)
>   {
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
> @@ -294,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>   	if (!prange)
>   		return NULL;
> +
> +	p = container_of(svms, struct kfd_process, svms);
> +	if (!p->xnack_enabled && is_new_alloc &&
> +	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
> +					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
> +		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
> +		kfree(prange);
> +		return NULL;
> +	}
>   	prange->npages = size;
>   	prange->svms = svms;
>   	prange->start = start;
> @@ -308,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> -	p = container_of(svms, struct kfd_process, svms);
>   	if (p->xnack_enabled)
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
> @@ -1001,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   
>   	svms = prange->svms;
>   	if (old_start == start)
> -		*new = svm_range_new(svms, last + 1, old_last);
> +		*new = svm_range_new(svms, last + 1, old_last, false);
>   	else
> -		*new = svm_range_new(svms, old_start, start - 1);
> +		*new = svm_range_new(svms, old_start, start - 1, false);
>   	if (!*new)
>   		return -ENOMEM;
>   
> @@ -1011,7 +1028,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   	if (r) {
>   		pr_debug("failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n",
>   			 r, old_start, old_last, start, last);
> -		svm_range_free(*new);
> +		svm_range_free(*new, true);
>   		*new = NULL;
>   	}
>   
> @@ -1846,7 +1863,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
>   	struct svm_range *new;
>   
> -	new = svm_range_new(old->svms, old->start, old->last);
> +	new = svm_range_new(old->svms, old->start, old->last, false);
>   	if (!new)
>   		return NULL;
>   
> @@ -1910,6 +1927,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	struct interval_tree_node *node;
>   	struct svm_range *prange;
>   	struct svm_range *tmp;
> +	struct list_head new_list;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
> @@ -1917,6 +1935,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	INIT_LIST_HEAD(update_list);
>   	INIT_LIST_HEAD(insert_list);
>   	INIT_LIST_HEAD(remove_list);
> +	INIT_LIST_HEAD(&new_list);
>   
>   	node = interval_tree_iter_first(&svms->objects, start, last);
>   	while (node) {
> @@ -1972,13 +1991,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   		/* insert a new node if needed */
>   		if (node->start > start) {
> -			prange = svm_range_new(svms, start, node->start - 1);
> +			prange = svm_range_new(svms, start, node->start - 1, true);
>   			if (!prange) {
>   				r = -ENOMEM;
>   				goto out;
>   			}
>   
> -			list_add(&prange->list, insert_list);
> +			list_add(&prange->list, &new_list);
>   			list_add(&prange->update_list, update_list);
>   		}
>   
> @@ -1988,19 +2007,24 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   	/* add a final range at the end if needed */
>   	if (start <= last) {
> -		prange = svm_range_new(svms, start, last);
> +		prange = svm_range_new(svms, start, last, true);
>   		if (!prange) {
>   			r = -ENOMEM;
>   			goto out;
>   		}
> -		list_add(&prange->list, insert_list);
> +		list_add(&prange->list, &new_list);
>   		list_add(&prange->update_list, update_list);
>   	}
>   
>   out:
> -	if (r)
> +	if (r) {
>   		list_for_each_entry_safe(prange, tmp, insert_list, list)
> -			svm_range_free(prange);
> +			svm_range_free(prange, true);
> +		list_for_each_entry_safe(prange, tmp, &new_list, list)
> +			svm_range_free(prange, false);
> +	} else if (!list_empty(&new_list)) {

list_splice checks whether the list is empty, so you don't need to 
duplicate that check here.

Regards,
   Felix


> +		list_splice(&new_list, insert_list);
> +	}
>   
>   	return r;
>   }
> @@ -2047,7 +2071,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
>   			 svms, prange, prange->start, prange->last);
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   		break;
>   	case SVM_OP_UPDATE_RANGE_NOTIFIER:
>   		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
> @@ -2610,14 +2634,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>   		last = addr;
>   	}
>   
> -	prange = svm_range_new(&p->svms, start, last);
> +	prange = svm_range_new(&p->svms, start, last, true);
>   	if (!prange) {
>   		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>   		return NULL;
>   	}
>   	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
>   		pr_debug("failed to get gpuid from kgd\n");
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   		return NULL;
>   	}
>   
> @@ -2917,7 +2941,7 @@ void svm_range_list_fini(struct kfd_process *p)
>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   	}
>   
>   	mutex_destroy(&p->svms.lock);
> @@ -3333,7 +3357,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			 prange->last);
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, true);
>   	}
>   
>   	mmap_write_downgrade(mm);
