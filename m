Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB51C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 22:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8257011A8C2;
	Fri, 10 Jun 2022 22:31:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C160711A8C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 22:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoZMw2nIAaxUUrtHO+UNSMNuCnjuIRKDLvTYzNyz/nUaVUypjT07zm/neix8SN/jxhTG/xRZ3LlU/DkbNkiS4Bg5DoyJdLy8aZnWj8T9W54qhdU2nSF0QziqKmsuaaqHXlLVmdrQcRQdjHjn8qV2V6jOnKN7j32qZzM29MhYLMwfvcBxMXoBj0ckz8wC5/j/889d8f3JxZU64WL9iKPVdYZtG3VZhh/AmS5bGsC2JNvz+CsMqlxc8QrcOi5br9lGK0hgqIIIXXLmIbaCro9Wx6qnkyIwKm/Sgp+6B75PmeTYoQwr0Tsymml1RcEH8QfPgT+FJ0EZ3O2TdyTpWO8fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQvUDQcEZbr7bCW7kQq+Stl8lxc3K/tks1ClK1UaIHY=;
 b=AgJb12oR7w4Fmuxq60AzL1bIaZphHRT7XJZ+hYLr818VXY0FCL1aDMKBmx2TRURUdHd1KQxa6EMOyQOU+9EY63iUPwikuXcn+c1x7a5JM+ZMkgQt0pWhBq/rQIoZk807KTG/KaW8rmfH5OL2YcDpR7b6sat/BVlJfMBlWKeBHKCYWilmJJPGnbbpnFNDc4juZ2oAorhFB0hx7NS3SM4D+TCwNl0/fH6GF7jrJKhFq757OkCrvvcxbTmTz+2e+hARNJzHQ3flMR2CExxUaHlQLvhGvrzoIh2d+WQ658DrMUiESoUuC22vkmJA07X2In/6fmVhgPEfyFIiRzm8ZlmiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQvUDQcEZbr7bCW7kQq+Stl8lxc3K/tks1ClK1UaIHY=;
 b=giXQr5SA+NPPoFd4CPf9y2OqPSojgEP2XHHzNO9gTIC+Z/pnPwThvcYU62OgZjBmN/eYSnqXfe6Ir9bb8t6B4ETp9rchgA7l73fQPkYUGof/hBTuJiKODKBbdVzn3FBvqZtnIcuS9QurVjhY+HllpLvhcFs2/1AKcbDLI1BP22A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 22:31:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 22:31:14 +0000
Message-ID: <4b52c3f4-7823-55ba-4128-1e4cf2a8c46d@amd.com>
Date: Fri, 10 Jun 2022 18:31:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] drm/amdkfd: Add available memory ioctl
Content-Language: en-US
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220609233208.3415891-1-David.YatSin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220609233208.3415891-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ec7adba-4d09-49ac-289e-08da4b30ed87
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812BF55D5F59640A5A5464292A69@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6auEN7I8B6CEPTvLz7qK519ahVmAmNh2Sk4uNbzmHFwFWJvmkmVsjj55UrsK8C2Aa4/A0/1qOWI84/F9+UG2HBfHAzhajZqZx6oL9jNIj4uzCYtLpXEw4CTcj9EMgUcQRBQFhTegx21HkfPjzx26LLOJBGgwTveRkTbeD5pfjDWQIAUXrdUotWBcaAY5PzOwr4jxk/CAPBMpDWyfUA6uPPkpeTd1fDAqaSxRCDQa3e74k217bYEW6+0SWqHJunb1MIzrEJW7M/XPbOulfo4fogaGB/CzzjwDXu3cr/TnzyxUn25+GEWe1Pk88MyYKia6DSwaFC+w/rvlnTVv3t2gTa+fqCxr3307E2TkVBwhhcmW2PE3mBepodz5pDXmwzpSwuDTGNUDHPYB1QXETduyriMW4wVwZ5qZ2q3Nd6xxhN1kXTgZV1PT4J3AdkYFF7f3l5VNL2fm20PY8pN2PM4iZAZwd2ySY5c/5jWRC89I9GqpJnJ1W1lem0wsKcI4yE/G97yd7mN/nbgp7N8way6H/Seax2zvbhE5DRS1fg3BpRGEZUjAhzAjeONJls5AfRQkAOtpo+RTZ1gPtHgWw74i53MPRrFgRxlgcRsGaBmK7ccosmVsPEQGeqZ15tgRbbZQj8sQHIag0EWcaDv23d61ScwXA1QeW5G8tCmf98nU1+4Fvha8YT/v2K9ILPjzmhHSbnSx0ECwlWSveRXFkyzUpZ1WoXe7xt2VbEyiEJrxYNfmAg1YCq9pE/0knwzVEiqjJlYbVKWzRSLchiW/6FakT7blaNuA1rrzQTBK6ahLrMjce7Wrm+AxBj66hrnEg/PpDXC7cXi6OTsIuESBypq1Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(44832011)(2906002)(186003)(31696002)(4326008)(38100700002)(5660300002)(26005)(66556008)(6512007)(8676002)(66476007)(66946007)(508600001)(316002)(6486002)(31686004)(83380400001)(36756003)(8936002)(86362001)(6506007)(2616005)(966005)(131093003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJ0TTJJeWp2MGlzWFJDNy9ncUJvU0ExOXY4Qm1lN1BaWjM2ZUFPaTN1Z0hk?=
 =?utf-8?B?elFQRHBrRkNQcERUZHZGM0twYjhKN05MTEJsWVJocStJOThUWUxWR0FVUUIv?=
 =?utf-8?B?ZC9FZzQ4SDFYWjJrRVZkQkVYNXQzMXR1TWR5bjlpTmE5NFFsUG9aTCtDV2Y1?=
 =?utf-8?B?Z1lhbmdmS1ZGdXBhVU9vNVFveTN1eHJCVVVYVndsY1FtaUtXaFU2cGhHTWMz?=
 =?utf-8?B?VG9Qc1Y5eldiZWY2QUlpVXJPdkZzZWxDS0xGRG1SN1Z2RS9mR285TEY2VU5H?=
 =?utf-8?B?OExsUGlBelJSMStpT0RleStZRVFoSGFWc21hVnRFUUFveVpIbHVPeU5EK3hC?=
 =?utf-8?B?ZXkwK01wbGdhc3J5YWtsWlpVTHV2b0xvdUVraHdYVlhDSkNEbDVVZEQrSll5?=
 =?utf-8?B?RUFhOWtoNmVHZFNENW9WM05hdGVDYjFvVXBKOFh2N0dOUTRRV3hmZGZkbDMy?=
 =?utf-8?B?M0lCdFJrcnVkQXVoM001dDF5eXQ3SDd4bVFlbDJhZnFCNE0xZGIzTXNteFlE?=
 =?utf-8?B?QWh5b3JJSWwyakt6dm1tOG16NU9sOExvRHNCQUc1NVZUejZ5R1NKWXFNNVYr?=
 =?utf-8?B?ZEo1UFBMY2I1Y2wyTm1CbVFleGN5eTlKdDdwYjYrOFE5SklJWXVSenhxWDQ1?=
 =?utf-8?B?ZUFzSVRvUjBsbWJ1UlI2djZLNEk3dHcycmUwaEZJalhuZmhGZVBvUEFhcnc4?=
 =?utf-8?B?QkduWjcxV0U5RnJrMGFSMGVVdjRJWFZSdEEwNjdSbGY5NklHb2RBemZjOFlQ?=
 =?utf-8?B?UFNEbFBuWHZJZGdRSVhzT3FuSHZjM1NPUElvY25CZWJOa0FuMUZUNHJ4YVNB?=
 =?utf-8?B?bFZ4Q1Q2czJ1My9kVk9EVW9BUk96U0NaV1A4NEVLVzR3NkF2N0p3bVlNTUFO?=
 =?utf-8?B?VGkyTTVxc0l3YzFGblA2UkxobnBDMmpZNEgyY0crMElzeHc0dGROZEJ2Q0tR?=
 =?utf-8?B?ZzBUVWRhUjlqRjBseXpXUlpaOE5MYUZYNnEwQjJlWkNHZ2lKTXNMRy9Bc0ZS?=
 =?utf-8?B?dE8zNlZtOUh6c0lFRy8yQ1IydmpVbGdHUnpuQmRicCtJRVRuYUVnRGxjUHUr?=
 =?utf-8?B?Q1VnT3RVT3BOdDV6SE12NHA1ZjJ1Q2xpRW9GQWhSLzNqbmFiWnBPTDFEcDJN?=
 =?utf-8?B?R3FsN3Z1TEJtVENFYndPL3RTYVdTZEN5OTg3c2k4RGFlbEtSR1dsUUxHVWhN?=
 =?utf-8?B?MTVZN2ZySHR5UFBta09INFhZKytxNjJmcXRYYithZ2tVR2RseUFFb25Kb3ps?=
 =?utf-8?B?bUZidDBpQ1FvcXVSeUNzSWE2TVc1d2UxUytmMGhiVkhMdkU4Sk4wcEJ1TElk?=
 =?utf-8?B?MnpUNFV3UGdsTUtzeUFnakFmQ0V2R2pBMFU5bUNORkxvN1ZJT0duYTJpeXRJ?=
 =?utf-8?B?ekY2Uk1BOU52VWNZeHdvZmhhTENPSHlEeHU2cENETWVBb1Ard25nVkNQZjJl?=
 =?utf-8?B?Y0JhVXFJQnhNMnZnVnppSFhpMDZCdHVNYnBtU1EyZ3JaeWVha1hNbGI5QnJm?=
 =?utf-8?B?TFpZTW92bjlDeUs3bVljTlcvcjRsZUhIRkpGY3hZbUQ5aVFYa0NMaUtuelNL?=
 =?utf-8?B?RjlQeEV0SGZjUlJndyttR045TmFUYzJ6cXBXTTJQalRjbXlpcW5DNmNuMHJ2?=
 =?utf-8?B?bFdnbmZ4aDlOeG45MUVQZ1NuUEpTbnRlNWR1QUpwWUduTVc2cG9oNUw1Y2lL?=
 =?utf-8?B?WDMwMEo0ZW55RGNObnlWT0dmMmpIcTNQdmMyOHFYZlpsQWtoSlcza1h2SDlR?=
 =?utf-8?B?U2cxZG15NFpjeURBb3VPQWdjZ09PM1dsNkUwMURVaSt0VjZDYjBwSm43TVBy?=
 =?utf-8?B?cURGUS9heGpFTmRkTWRFMkxLZTNZbkcyeGhndnFpdTdwQy9NWHBmNjRYcWpq?=
 =?utf-8?B?REQxOWJRWTJsNHJSTU4rckFsZHIyMzhzdVdKRUMvWWdPMGhmMzE5M2haZCts?=
 =?utf-8?B?NktIaDFpSVhrMzljWnN5TDZZQW5DUmVMZjRZby9DZWhCQndPZTd1YVI4N2tr?=
 =?utf-8?B?N2U3QjVuY1RocEVWRGtncmhRRmIxRHpJMmdKcGRlcHpDKzE1MnM2VGVwbnE1?=
 =?utf-8?B?aitMUkxLLzRDWTY5N2gvc2F2T1d5MDBSRkRudUIvNUNVWE95emVhYTBFcGpU?=
 =?utf-8?B?eHlmUXNtMUFRdUdmZWdkWnQ0U1hvZUtZVWVLR00xaUJubFhWRjZLUisvblN1?=
 =?utf-8?B?Z2k3UXp3aFhHUkZTZkx2VGJjbDhsK3l2MkthdnZ2NXphb1BqZFg3dzVNUGNU?=
 =?utf-8?B?eVd4em85c2J2blZsTkI5YUh0TEVPaW5Pdm82MFVDdDlEQ1Azajlaa2FWR0VD?=
 =?utf-8?B?L0IzbXArdlRNcmlRalpXNzlkRnFYU1UwWUw3dW5Fakg5L1BVZ210Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec7adba-4d09-49ac-289e-08da4b30ed87
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 22:31:14.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQ8Ov+Yp4wVsrqleYT7O3wsPeRXCQSSE1zrsc0sA15sS11QJkh9Lc58pa1Q2RvxS9F9u0X/wCcDkTj8xjKRGVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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
Cc: Daniel.Phillips@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-09 um 19:32 schrieb David Yat Sin:
> From: Daniel Phillips <Daniel.Phillips@amd.com>
>
> Add a new KFD ioctl to return the largest possible memory size that
> can be allocated as a buffer object using
> kfd_ioctl_alloc_memory_of_gpu. It attempts to use exactly the same
> accept/reject criteria as that function so that allocating a new
> buffer object of the size returned by this new ioctl is guaranteed to
> succeed, barring races with other allocating tasks.
>
> This IOCTL will be used by libhsakmt:
> https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg75743.html
>
> Signed-off-by: Daniel Phillips <Daniel.Phillips@amd.com>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 38 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 34 +++++++++++++++++
>   include/uapi/linux/kfd_ioctl.h                | 14 ++++++-
>   4 files changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index ffb2b7d9b9a5..648c031942e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -268,6 +268,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>   					void *drm_priv);
>   uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		struct amdgpu_device *adev, uint64_t va, uint64_t size,
>   		void *drm_priv, struct kgd_mem **mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a1de900ba677..afd6e6923189 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -38,6 +38,12 @@
>    */
>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
>   
> +/*
> + * Align VRAM allocations to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> + * BO chunk
> + */
> +#define VRAM_ALLOCATION_ALIGN (1 << 21)
> +
>   /* Impose limit on how much memory KFD can use */
>   static struct {
>   	uint64_t max_system_mem_limit;
> @@ -108,7 +114,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    * compromise that should work in most cases without reserving too
>    * much memory for page tables unnecessarily (factor 16K, >> 14).
>    */
> -#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
> +#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
>   
>   static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>   {
> @@ -148,7 +154,13 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		system_mem_needed = acc_size;
>   		ttm_mem_needed = acc_size;
> -		vram_needed = size;
> +
> +		/*
> +		 * Conservatively round up the allocation requirement to 2 MB
> +		 * to avoid fragmentation caused by 4K allocations in the tail
> +		 * 2M BO chunk.
> +		 */
> +		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		system_mem_needed = acc_size + size;
>   		ttm_mem_needed = acc_size;
> @@ -173,7 +185,9 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>   	    (adev->kfd.vram_used + vram_needed >
> -	     adev->gmc.real_vram_size - reserved_for_pt)) {
> +	     adev->gmc.real_vram_size -
> +	     atomic64_read(&adev->vram_pin_size) -
> +	     reserved_for_pt)) {
>   		ret = -ENOMEM;
>   		goto release;
>   	}
> @@ -205,7 +219,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		kfd_mem_limit.system_mem_used -= acc_size;
>   		kfd_mem_limit.ttm_mem_used -= acc_size;
> -		adev->kfd.vram_used -= size;
> +		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= (acc_size + size);
>   		kfd_mem_limit.ttm_mem_used -= acc_size;
> @@ -1668,6 +1682,22 @@ int amdgpu_amdkfd_criu_resume(void *p)
>   	return ret;
>   }
>   
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
> +{
> +	uint64_t reserved_for_pt =
> +		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +	size_t available;
> +
> +	spin_lock(&kfd_mem_limit.mem_limit_lock);
> +	available = adev->gmc.real_vram_size
> +		- adev->kfd.vram_used
> +		- atomic64_read(&adev->vram_pin_size)
> +		- reserved_for_pt;
> +	spin_unlock(&kfd_mem_limit.mem_limit_lock);
> +
> +	return ALIGN_DOWN(available, VRAM_ALLOCATION_ALIGN);
> +}
> +
>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		struct amdgpu_device *adev, uint64_t va, uint64_t size,
>   		void *drm_priv, struct kgd_mem **mem,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 95fa7a9718bb..625e837f0119 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -65,6 +65,25 @@ static int kfd_char_dev_major = -1;
>   static struct class *kfd_class;
>   struct device *kfd_device;
>   
> +static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
> +{
> +	struct kfd_process_device *pdd;
> +
> +	mutex_lock(&p->mutex);
> +	pdd = kfd_process_device_data_by_id(p, gpu_id);
> +
> +	if (pdd)
> +		return pdd;
> +
> +	mutex_unlock(&p->mutex);
> +	return NULL;
> +}
> +
> +static inline void kfd_unlock_pdd(struct kfd_process_device *pdd)
> +{
> +	mutex_unlock(&pdd->process->mutex);
> +}
> +
>   int kfd_chardev_init(void)
>   {
>   	int err = 0;
> @@ -958,6 +977,19 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>   	return false;
>   }
>   
> +static int kfd_ioctl_get_available_memory(struct file *filep,
> +					  struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_get_available_memory_args *args = data;
> +	struct kfd_process_device *pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +
> +	if (!pdd)
> +		return -EINVAL;
> +	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev);
> +	kfd_unlock_pdd(pdd);
> +	return 0;
> +}
> +
>   static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   					struct kfd_process *p, void *data)
>   {
> @@ -2642,6 +2674,8 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_OP,
>   			kfd_ioctl_criu, KFD_IOC_FLAG_CHECKPOINT_RESTORE),
>   
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
> +			kfd_ioctl_get_available_memory, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index eb9ff85f8556..c648ed7c5ff1 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -34,9 +34,10 @@
>    * - 1.6 - Query clear flags in SVM get_attr API
>    * - 1.7 - Checkpoint Restore (CRIU) API
>    * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
> + * - 1.9 - Add available memory ioctl
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 8
> +#define KFD_IOCTL_MINOR_VERSION 9
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -100,6 +101,12 @@ struct kfd_ioctl_get_queue_wave_state_args {
>   	__u32 pad;
>   };
>   
> +struct kfd_ioctl_get_available_memory_args {
> +	__u64 available;	/* from KFD */
> +	__u32 gpu_id;		/* to KFD */
> +	__u32 pad;
> +};
> +
>   /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
>   #define KFD_IOC_CACHE_POLICY_COHERENT 0
>   #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
> @@ -824,7 +831,10 @@ struct kfd_ioctl_set_xnack_mode_args {
>   #define AMDKFD_IOC_CRIU_OP			\
>   		AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_args)
>   
> +#define AMDKFD_IOC_AVAILABLE_MEMORY		\
> +		AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x23
> +#define AMDKFD_COMMAND_END		0x24
>   
>   #endif
