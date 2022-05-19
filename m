Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 23:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6D210E4FF;
	Thu, 19 May 2022 23:08:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D465910E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 23:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3R312paQ2qN/5DLujOZV4dc4231LXmpt4jthHZ97yBFZBZUTxzetQQQxxvK/rMCJGP6cweeCrNXxfe6PFEz4WxARqwh8coUN4oXEpGNgCbBZI8EvQ+8+ymuu7bcWjmHzSZFYBc8cJ1ll7L9QCNgvmVZL/WcqLZrFuB7czWU/yYOYu3O4ApExKWHGN/venToaXmNgili/9j6dfH5Pv1WwjABmlRqixCxX5mG46A8JR2Zw/1vckwF47Rge2jZu3zU8Z+/uQkdQDATH5Ck0Ts7kO864G2oLBJM877GaHYqypuO0wB7qWDRKTs1jjEA+R3S4oYyAGVsRMUoJqc1neY9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MymCaQs1XmO2HxMm3jr5BJtzO3Dht8OUoIdghcKVOVg=;
 b=Oa51N0Kebg6nNX16mJOTI5W7eFr5k2Jn7+GfUw58S02fvBCUiiLjQqhAQOEF9bfBi1SleYF/LVgjRx9OhrAs7uGxeiNW6YHNWBtflJlCm84TL5+WvRWWnq5Ys2w4orHLf+I1A+q6ISXzYXWpzY449lKyr9U0dWV242C0PELP42iewMiVFSARy6itSJYshHpY4bFkVCXHv92WY2VTIUn7Gfs98VtifurS8vE3yizir/ytud0w+YeY+Z/UvQCPO0z0620+P8UdW3wNQTuGirxLp4SfTZp+AE4hN6gpI3jjwwEpI6ER9DZ5PhW/9nXuH/TR0UfoBFUyIMvymZKT6+ht8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MymCaQs1XmO2HxMm3jr5BJtzO3Dht8OUoIdghcKVOVg=;
 b=EqRQXOdX9CXPYoi7EGPFklOjZU1O8GH9esftBoYcgDA0fBGqrVIKPYHDZt3hdGPYKEGeamLJ9P9sYxz/5Fe2ihB5YohRQIvgQHIe6fWUk8uVHQiQOwZDgCnLKj7KG08unqyMNuv3SV/e8oCL1eT2wYeUfXzIw0elC90E1DbAWo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 23:08:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 23:08:25 +0000
Message-ID: <9ec46333-ec80-f258-febc-7c7110cecf56@amd.com>
Date: Thu, 19 May 2022 19:08:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519162153.6268-1-alex.sierra@amd.com>
 <20220519162153.6268-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220519162153.6268-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45316c6d-aeb4-4ccc-aa64-08da39ec7a40
X-MS-TrafficTypeDiagnostic: MN0PR12MB6029:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6029131B4C0DC5BB944F23B292D09@MN0PR12MB6029.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG/W0bWgOnObTLhrnReL+AuEBJK0Nja9yE9k48Kkr/MtCPhJFl1s7ycvzUcz78g+k7vO3I/O+DFJiVj9BHfYkvUrbN726Hboo4a76noi/0zOPvl77tVp8IjORrDBApRhiL4yrlag42XXy3AOfPZYPW04ewCP+uQfNyWz650lstc44AvlZ6FGiwHbWUTk2wxBtilANAZ1LAAkg7Q7AsS+ueivOvKha27HnQwbT61g/XledNyCB6jyjWe5kXtzZS+sBAl0NoxiWptQai9SZ+sr7id0RjAXu0oNgYfgyTbbDym33Mo/nyLqjX0WXudKX2fz8zcvd5O0Azcbeo+I/AF3Ao1cd9U9V/lWS575SWPdCNUUEb8VQnV6MQCc31cYDeFAWJajSJNTLNN3WEbooo4gB1EdvNe2WtEktwrqUjV5m5Crj+PjaPcdZwATqUoBjbPRKhhcgCUnmbA2yFLDcOl9TY5ka+3jtzz3tvq2m/R+CqJ/iZeEt+ZKlEHUybZTl8cVr7q+XVw5JrF289v954XvZ47nHpYXvN17k2Vy2FkKy9Ui9OoeOCkEKUfJMuq0EIAtXhtcYL5YRh7O6D6QOfHBRR8H5snR6ysyfE1aw7D3l1bb5RYjN1f48VAwbbWY6iikLY29MM8OUxQuC7g1eD4LjOS0yfCn7vEfklAa6CPLGp/PNZBBQMxNXYHBd1zy4QYOku4q/4Dz/jTSC6eER6hOzK5PkNJ4kiGDwBmyd0SmdeD4sf5ivOL3fC2DKcdh2IxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(44832011)(8936002)(6486002)(6512007)(26005)(83380400001)(186003)(2616005)(2906002)(8676002)(31696002)(86362001)(6506007)(66946007)(31686004)(66556008)(66476007)(316002)(38100700002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFczbStkMm9hd20zK1pZc2sycUE4bkhURSt4MFBkYkw4dWdaeEVHUXF3Nm1y?=
 =?utf-8?B?VWg3VlBPMkZqNmxRV3M0ZHJRZFEzS0V5M1BYY1ZDa1FPYWp3Vm9SbzM1Z2pT?=
 =?utf-8?B?alhObFlTMmxWVEJjcWk4d2ViK2VYTVhTcHhsTjlxaEhmbTNoeGZoUjExTTMv?=
 =?utf-8?B?LzAxN0xxTTZvNHBTOGFkdE12YzlkcjZRSUdySGlSWEVHTmtpcUhPbmE1bUNK?=
 =?utf-8?B?aHQyWHVJeDRkUU9wUnU4djNkekt5QnZxcVVaaDE0MmRDcGZFdm9sOXhNQmxM?=
 =?utf-8?B?aWtwR3VWL1hVN05qM0pRR1ZOdUpTU3QxU3FROCswd2NIZUpDZXBYNVAzWkRm?=
 =?utf-8?B?b1dFdk5xcGQyYWRZU2dUM2ZFTDFhdnpER2ZZaXNXNUNKcUU5WFdSRngvQSt0?=
 =?utf-8?B?eFBMTHcwdk5ZK3dZdC83NXZXU1k1citZQkhyN3lNU0o5RjFHVFVHUUI0UlNP?=
 =?utf-8?B?UFpOTEFndlBIWklkaDJ5cFZmYk9VTEJUSnNPUjRNNzhvd1RVNnlISzYvRlBU?=
 =?utf-8?B?V3ZQeUZsanBreVBXZjJBRnhmUC9MeEhCWGNYQXp6ZDVwMWRpcHVjM3dMOFNs?=
 =?utf-8?B?VkdDN3cwTE10K3dYMW9WMlBxWnNicEtkemhXSE12aHdKQ3Z2MFJBSXdkcEdF?=
 =?utf-8?B?dTZtMm9PMGE2UGN3U1ZjNVZRaWF6aFlGUm1iMWE4bUloY2syUWRKVGR2N3p1?=
 =?utf-8?B?K3BLUFlhRUxacGltY3U2Y3dyTTFxWEh5bkZqTkZBSU00S1dxK1hsZHl4VDZ1?=
 =?utf-8?B?NTIzZWN1dWNxNXkxUGhBbkZMei9IdVZ4TzhQRHRTRWgxTmVIcEh3UlgyR2wx?=
 =?utf-8?B?MldGaVlKREgzaWJVQUFWM0ZPQ1BubHlrSFJOQUEvYzhsMktpUS9rR1l0ai9E?=
 =?utf-8?B?dmNOVC9BWTRuUFZqcVlMZis3ajVrWmZ1UklvWEFCcFJKTUZvWithaUFWYXFB?=
 =?utf-8?B?TGtVL0pBdlhpTzZMYkk1Qzl2dGRKUkV3YkxLdkF6VWFDQkp5U0JTelpXODZu?=
 =?utf-8?B?VElpZ2RMNWN1ZGZJcHA0cUVUMW13cWJhTGwraFFCOHFqRlVRU3E3S2pjYUdx?=
 =?utf-8?B?VGNBOGdNenJCMUozMmthcVhwdDh0Y3puQ2h0TjJZSnVXeG5vMDlXL1BCSmtj?=
 =?utf-8?B?YzRBTHNkN09OVDJZUThidm9UemVFN0JZc0hGbk5JdklBbUhPYkEvajlrSnAv?=
 =?utf-8?B?VUZUMjNDSGNmeUNpbkM5eUFiSmF5U1hWWnRMZEg1aERBL0YyTTRGVXRUNzhw?=
 =?utf-8?B?UFQyM01kdXdUTS9tNzhKZUp6RDl0a0ZxY3NXQkpIWG15WXc1SVJmeDZ2UUJt?=
 =?utf-8?B?YnF3aHl5aUtEV29MWWJGUG5LNWpwMlVyRUloYmNFajZvak5WSVB3MkhJUWxC?=
 =?utf-8?B?VmFtaVRXd0xDUWEzKy9UbjRHbEZGNkZ5YkhySVhRNDRnTEg3bS9XNzdtSTc4?=
 =?utf-8?B?czdwMVorYXdGcU9qVmNzSjNqaFgyYWR6clFvOXVyaFJvd2M4aDJQYmxFWTJU?=
 =?utf-8?B?dWFWaStyY1k0ZU5oQWJTK2MvWGpQVm1qeWx0cXBDcndtekFYUjJIZ3Ntd3BD?=
 =?utf-8?B?bjhkQ2VDaGFDenFYbG5KMFNHaWxrbUlDUDJPeERSVkZoVjJweUJ4N2hkRUx5?=
 =?utf-8?B?cXZLb1hlMER6anNIZ1Byd2VJem1PbVJzK3NXQTVzSU82eXNUWnowZGg0VFVH?=
 =?utf-8?B?R3B6bkpuYzlPRVJZOGkvaFl4WjA1OGVBWktoN1UzRll4a1JiQnVWMnhLYTgy?=
 =?utf-8?B?VnV6WDA1aEsrMG9mL1E3NG0xdWRVSzBUWjhtWkwrT29aaDdUVUtRREZDK3Fi?=
 =?utf-8?B?SEVNcEpObmpoM2xseDFOQ1pNQTZxQ1JYSk5nTVlzekVHNXVXUmxLNkIzL3N4?=
 =?utf-8?B?TkxINFhtRmNkYmFGMVVvRklZZktrZUNQRlRldERvdjVhWUdCSTNMenBRR0h4?=
 =?utf-8?B?MU9HaDlKMjdwdU5LL2h1UjNWUFZiTFZHTXpIK3JwaUJuVVFKQ2xhcjk0endP?=
 =?utf-8?B?ZlNETzQxdHpCNUJpanQ2RWJOOWNrTXdyNE1KSGVNM3Q1T1J0UHFpM0hwb2Rh?=
 =?utf-8?B?QXhpVWtuVlVkMEp5TUNlaGJ3T1d1NFljemdUTWo3d1BudWlaOHFrL3NPU2Zn?=
 =?utf-8?B?UlhjMTRsME5kQmErNjg5amxRNExVMFR1M2NFV3poMVRPQUdwdHBwM3c1UElT?=
 =?utf-8?B?K3YrM1kvdmdhSU8wTG5qUTFJWGNKS2JGY3A3ZE1wcFYvS3ZEUk5wb1psR3FH?=
 =?utf-8?B?UWU2WEhHakcxZFJ2UlhZMXFtOTliak1NSm81aE8rbUFaKzNUQWJIQmJyKzJ4?=
 =?utf-8?B?Wlo0eXYvNGd2dWhLYkhUU2wyYjJBNlNDVkJjd0N1blU1MEJ5aGFrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45316c6d-aeb4-4ccc-aa64-08da39ec7a40
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 23:08:25.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCwKAnTdb5u5hXGNE6zRz2RwxBl3iA3/RPGbqR2N7Iax00hR9oFRO+5PAhioHutubKFCx+Afa6MZEBxS73nHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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

Am 2022-05-19 um 12:21 schrieb Alex Sierra:
> [WHY]
> Unified memory with xnack off should be tracked, as userptr mappings
> and legacy allocations do. To avoid oversuscribe system memory when
> xnack off.
> [How]
> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
> API and call them on every prange creation and free.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 ++++++++++++++-----
>   3 files changed, 43 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..f55f34af6480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
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
> index 966714dd764b..615e2b34fe12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    *
>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>    */
> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	uint64_t reserved_for_pt =
> @@ -157,8 +157,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
> -	    (adev->kfd.vram_used + vram_needed >
> -	     adev->gmc.real_vram_size - reserved_for_pt)) {
> +	    (adev && (adev->kfd.vram_used + vram_needed >
> +	     adev->gmc.real_vram_size - reserved_for_pt))) {
>   		ret = -ENOMEM;
>   		goto release;
>   	}
> @@ -166,7 +166,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	/* Update memory accounting by decreasing available system
>   	 * memory, TTM memory and GPU memory as computed above
>   	 */
> -	adev->kfd.vram_used += vram_needed;
> +	if (adev)
> +		adev->kfd.vram_used += vram_needed;

Add a WARN_ONCE(vram_needed && !adev).


>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>   
> @@ -175,7 +176,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static void unreserve_mem_limit(struct amdgpu_device *adev,
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
> @@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		kfd_mem_limit.system_mem_used -= size;
>   		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		adev->kfd.vram_used -= size;
> +		if (adev)

Add a WARN_ONCE(!adev) here.


> +			adev->kfd.vram_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= size;
>   	} else if (!(alloc_flag &
> @@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		goto release;
>   	}
> -
> -	WARN_ONCE(adev->kfd.vram_used < 0,
> -		  "KFD VRAM memory accounting unbalanced");
> +	if (adev)
> +		WARN_ONCE(adev->kfd.vram_used < 0,
> +			"KFD VRAM memory accounting unbalanced");

This could be simplified to WARN_ONCE(adev && adev->kfd.vram_used < 0, ...).


>   	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>   		  "KFD TTM memory accounting unbalanced");
>   	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
> @@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>   	u64 size = amdgpu_bo_size(bo);
>   
> -	unreserve_mem_limit(adev, size, alloc_flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>   
>   	kfree(bo->kfd_bo);
>   }
> @@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> -	unreserve_mem_limit(adev, size, flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>   err_reserve_limit:
>   	mutex_destroy(&(*mem)->lock);
>   	if (gobj)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 835b5187f0b8..1380c2fee0dc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   
>   static void svm_range_free(struct svm_range *prange)
>   {
> +	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +	struct kfd_process *p;
> +
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
>   	svm_range_free_dma_mappings(prange);
> +
> +	p = container_of(prange->svms, struct kfd_process, svms);

You could initialize p in the variable declaration above.


> +	if (!p->xnack_enabled) {
> +		pr_debug("unreserve mem limit: %lld\n", size);
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	}
>   	mutex_destroy(&prange->lock);
>   	mutex_destroy(&prange->migrate_mutex);
>   	kfree(prange);
> @@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>   
>   static struct
>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
> -			 uint64_t last)
> +			 uint64_t last, bool is_new_alloc)
>   {
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
> @@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
> @@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> -	p = container_of(svms, struct kfd_process, svms);
>   	if (p->xnack_enabled)
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
> @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
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
> @@ -1825,7 +1843,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
>   	struct svm_range *new;
>   
> -	new = svm_range_new(old->svms, old->start, old->last);
> +	new = svm_range_new(old->svms, old->start, old->last, false);

This won't work as intended. When a range gets cloned, one of the clones 
will be freed later. So when freeing that clone, you also need to skip 
unreserving its space, because the other clone is still holding it.

Regards,
   Felix


>   	if (!new)
>   		return NULL;
>   
> @@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   		/* insert a new node if needed */
>   		if (node->start > start) {
> -			prange = svm_range_new(svms, start, node->start - 1);
> +			prange = svm_range_new(svms, start, node->start - 1, true);
>   			if (!prange) {
>   				r = -ENOMEM;
>   				goto out;
> @@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   	/* add a final range at the end if needed */
>   	if (start <= last) {
> -		prange = svm_range_new(svms, start, last);
> +		prange = svm_range_new(svms, start, last, true);
>   		if (!prange) {
>   			r = -ENOMEM;
>   			goto out;
> @@ -2585,7 +2603,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>   		last = addr;
>   	}
>   
> -	prange = svm_range_new(&p->svms, start, last);
> +	prange = svm_range_new(&p->svms, start, last, true);
>   	if (!prange) {
>   		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>   		return NULL;
