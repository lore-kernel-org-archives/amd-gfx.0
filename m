Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D261093168
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 03:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0806E10E1AC;
	Fri, 20 Mar 2026 03:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4p2gLfwV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C974D10E1AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 03:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWW0ivSWoVgubv6eNHZfKfNW2eobVXtVK0nCCuO/J859MkpnyJhUqljlg5/Cdw3wEQoK26l8JVbf4AHRDgEAB3NdbnS0fGUGwWm+OrmkLQfVrN8IZ9zJaZyiW5/7vZEksK4PgFSceJCh2R3VyvYCd7kihIli71FBTsFhr0sgz+IwyG5Zk4gaejjYPFI0ZygN4Ft+rewwMeIGA39jcxtq+q0kVc7GCQy16/3pM/YrJS3V/OMyXWfMp20iSSuLa1GDB8Voyvv01up6GuJcpLobXDGpXytEpJgM/HEaw1L2P42QZOXTxnOW/3gMIAhOaigpHcLHCy0V+XELkjTLlj2i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SViElfFM3k0+coSJX2WvQZ7wWG/YFZBnb2MKDCWmgYw=;
 b=CKvCv+6v/w2wsq0/MvpbXBQJw0FcJlh0cYVIigCj2fSUnluB25y7vfeeogIp8pmGyCcc1QKSP/r4vjgMdyQF+2179RQYiSSCQ4jJHcCz0OrIUrpqhgAkM3l9cQlzj/jYYKVOnSaSTH0CUbtHApGkcsPPpxUnKlnQ8jxO1YN3xebAzsC9GcT/OT386Ly+5EsDu56Y4sUGkNFwJ/77pd6FxUSKYAPIoy5rAgSefnY1r4ayGbF/gp7FUcTOM/ThJIpffRvT0xrFzNC52JGjJYGupyotwfqS7gWWeWhzCD5NSmNPVBfSwDK/WLKR6Zp/RND9MmZKx05GItPMik4MCquxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SViElfFM3k0+coSJX2WvQZ7wWG/YFZBnb2MKDCWmgYw=;
 b=4p2gLfwVngKTxIfS/BVo3au5NYaTuidbuRPyO9D6ly2B8FvVRRJsdNsmr87ABEHXw2C3w9t248+IROIHCd9IvXsmBIXmAsJFqsa2pYs2ifnFxShzMvNq670//idAhTN3N+QwN9HSVls/g9WJLHhNorWhXTPFfioQDKBe+9xdS/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 03:13:45 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 03:13:45 +0000
Message-ID: <80732b5f-27a9-4969-8afe-98f3156c725e@amd.com>
Date: Thu, 19 Mar 2026 22:13:43 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com,
 Perry.Yuan@amd.com
References: <20260319073250.147808-1-yifan1.zhang@amd.com>
Content-Language: en-US
In-Reply-To: <20260319073250.147808-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:5a::13) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dab17fa-9f40-426a-125e-08de862eb28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: xUqUkhwm6fyNBXuSW+UDX06awtmtIylsRq7QaXuEqfDJIZn+gzyhIzuap34T3bWv+P5pvmKSKd8uJOYgSxd01jVUZgfg7Z2AZrABcJEiRUQs1nbC/u0wWTLlvmwBBAiqhldQUZ+moC2O6J6zDWOF01e6l6rx1cR6uXraxJ7XxVoFO6RjCe+bg28JOLPub4vtVxyzPqFsV6EapvaXPX4D59PmgBMKvAHTuYkGc2AO7AI9C01wW4lPm+htRbi+6F1tMX5GLdV37lFZFzgbUNwWtyMi2leLP+j1H6Fnf45zXZR7ET9kcmbtNSeluywvMRtQbXF4amOhre8Bspwp80d6c8bcBqYn0Od24s/LtUAtryrXyiPhOrvXQsrxEfYfLlXotoXJVnVCr5kTvq/Z+a44+Oe3HQ1AbQJr4Ke0AT+IwkKM/2uR8kxPOWkSoC+ZQlrx551cSwZuyqOvzjKWY0GbE0BNgw6rajqJ86+AGo4trkLTwyvSDfdMuMWS/D6J/KGf7zMqGPBtbUyUrVvzbCkkkD+47/T+LpNz8bJOnyFsLUJEqGPxK6oIIZAte6G21CKh/zMHkkrUGneNPBh+puNp+IGhiXTTz6E8UpS9M2UbCLsr81A2LDNRQO2tNjU2f2mcHc9n6rrgetBlmwTdIbIbSqo0L0gNt4i+WyQKDxqRW56iM5UkJMwuCZ8m+toAO0H6uG3wXlfJ87KyGpS9XhnFnOz+b86XN4TMFD9IZY0RUP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZpWEV4MlBPRlIrY01ES1lUNFEwZzd1dUpYZWhSOU4zM0lvQzVCdGJUQ2NP?=
 =?utf-8?B?ajRndVhYUjVQMDN3TXhTdTJVUmgzRkdMRlNpWlFKM1JwbG5hdFZuU3ozL3BS?=
 =?utf-8?B?c0kveGdrdWpKRVBzOEVobFBML29GbG1ld3RtU3oxaWM2Skc5TGp2SEcxT04y?=
 =?utf-8?B?NjJqQTlKcXdNd3RlWXhhT3kxVEgxL1h4NWd4Sldud3dITDh6TVhjZUFrSUxK?=
 =?utf-8?B?UXVoNnExcmpyS1g4R2hOM0FKUlNYYTBRTTdSZlpvbjNDbTdpRFQvRFV1Rnly?=
 =?utf-8?B?c29sQ3dnTlNEWi9QU1V5Y1U2Z3huQzRZeFRGR1FWKzVqRTFOM09UVnRvUTFu?=
 =?utf-8?B?Mk5HaDhrK3doZ2lOV1BlbTVNbFk1cFJkdGhRTzBockE0SnQvdTViU3U1b1lk?=
 =?utf-8?B?S01SUndhMC9mdHlqY2k4WmMrQmxzS3J4a1pqWndPNTZ2TnFsTmpnNnlUK1dk?=
 =?utf-8?B?VmE0enJnYWVxYzh0UkF6S1UvNTQ3ckRWS1RmOEZjY0IrcVNaL3BzeXZqeXJw?=
 =?utf-8?B?TmIxdURBdU5sQll5UnI2S3pHTzBRRGk1RXoyZ3JrbDZPdVZxTndpQXB3NXFI?=
 =?utf-8?B?Zk01VVJjb3ZrN2ZZOGdqeHNTNjQ1VGZ6akhXbFIvaXhRVWtTaUVuZE5rR3Ay?=
 =?utf-8?B?QTJGcWZWc1RoS3NlN3E1VVdNVFhYWjJhejhoSm5jeVBRQkFVbHF3dmd0YmRQ?=
 =?utf-8?B?MWRlNnppTE9OMmRKK2VWbGJ6TlpvcEsvWW9lMVVialZ3NHVCazl4b3UyUzBI?=
 =?utf-8?B?QkhhR3RxZ2U5VnFVTlU2dmt6RWcrWXluL2RhUzBZYURtU05heGZnTTkrQlFt?=
 =?utf-8?B?REJoWmFLWVVGV3FkZ3puYlFMeXo4ekhmeXU0Yjk1a2hLcm1PdldkMzRDV2t5?=
 =?utf-8?B?RDhiQzN6TmFjN09MSEVyK2xsRXZwR3lsT0hTQ2lyNDYrU3A2VkR0SHoyQ0NS?=
 =?utf-8?B?NmtQK1Awd2E0M0h2WlZoV1RVcjVjZzNaMEF1Z0ZuZXd1Wi9va1p4ckZMUjVk?=
 =?utf-8?B?Z3ZIWFBvbFRLbWYzdTRpcHdEdEpKYnVGSnRjcnpneTk4S3FVUGZweGFtQitG?=
 =?utf-8?B?WWVVaEdVYmE2Wkx2VitwRWN5UngwTlJ0RGZzZm1GRXdBTEJMKzlRT1JyS2po?=
 =?utf-8?B?VFZiZkljaHV0dmo2MHpvQ2M4TE5WeXBMRWcyeGJ4dEhIQkd6aHFUaDZ6VjhI?=
 =?utf-8?B?OS9KdDlJTnlUTU80ZTZ1TnZJTlcwTFRwUXFSM3ZFWkRjaHoycEpZKzEzWUVj?=
 =?utf-8?B?TU0zUUFFQWVJSXFUUDlQRStzZkltRG1QK3dScXU3dVMxeSt1Q3JKdmlrUTJl?=
 =?utf-8?B?YjBIMVBTUFloSkxSaXBKWGNicGN0YVk4cFlUT3RmT3k2b2NOWnhOeTJSYVJ6?=
 =?utf-8?B?RFQwZWhKSFFyd2dONWFtcy9KWGJ1SjNCUlpoM1djYklzTTlQNTM2bXpkOS9M?=
 =?utf-8?B?d2tabjFrYmpOVW14MlQrdlUrWW5ERmY0NkgrcFdDQjBJdFNvZkNyUDdYWFhD?=
 =?utf-8?B?NDIzaStUWVJGNHlxYUtPNjBRV0phWndmNDB5amFGSnc4NmhNUDJtV09KN2k5?=
 =?utf-8?B?VFFTdHpTWmNieHFFaVZIc3kzdWZmaVIwVnhPNllTcHpmOXd0MmRTa1QvZ2Vi?=
 =?utf-8?B?UlhpNDA0eHJidDJZR2NqVk5janJEZDZlZDU1M3RJdUtwUzZuUzErQzRrVGJZ?=
 =?utf-8?B?YlhtMHc2TFdZdjFaYzFwZTZmNnlGbHpYdVJKZzZlS0cvQkVZanZmTXJlYlBK?=
 =?utf-8?B?SHhQWkptTndoSFVaSGpDN0xjNlFab0pWaE9LR00zeXNUOXlTUmRwMmo1djRv?=
 =?utf-8?B?bzhROVZtNWk1S1NSRjZNZWc3SjhMQUhSQ3VHREQ4WHI2Sk1laHZnZ3RKNzQ2?=
 =?utf-8?B?bjRndWEyUWgybE5lcEtQOURDN09rOTNpRFZERnBESmgzR1FBV0dOV0p2Y3ZX?=
 =?utf-8?B?ZzBrbXRDL1N5Rk9BaVVkTUdXMDBFdzM3MUlobVJlWjdsOEUyV2JqWFJ2aHlz?=
 =?utf-8?B?YU9IT2xRLy92T1JQK0xVYUtWSEFpTDNxWlBCMUVZcmRxWEp4WkdLM2U4UXlu?=
 =?utf-8?B?MDdWSjRUU3AvNTVzaDB5OWk4djV5YzViMGs2VGZPallIMkdqV3dlRml2VlE1?=
 =?utf-8?B?OXBEMWVXYzlvTDJta0dEbFhVakJSbFVzUjlPSjdDNkJLM0diUnFBNXI4MmtI?=
 =?utf-8?B?eU9YU0lxM0tUbXRLbGNpRTdNRUV0elhmcjhSQ2J2eVRmWXZ1eWxROEg2OWtU?=
 =?utf-8?B?Y0xHRURidDlabm1qbVF2dVVRaWNjU0pTZENEUDg3S21ESWdjckhGUHZqaTNx?=
 =?utf-8?B?WjhYZ2tZMGpkcXJ2cDJ0NVlCcFlYL3o1dUJNdkpVSmtLR0Q5L2VRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dab17fa-9f40-426a-125e-08de862eb28d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 03:13:45.7033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIHQkYaT1/urHndMDiJm+sl4NsSoGsU8Lb3yYh3WvMdxdJOAy5XheFgTf+BqHgUh4fGLc94sgyz6Jv6ZC+Gl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
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



On 3/19/2026 2:32 AM, Yifan Zhang wrote:
> Current apu_prefer_gtt setting only check gtt_size, which could be set
> by user to a larger than system memory value (via ttm modules parameter
> pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via ttm modules
> parameter pages_limit), system memory 31GB. In that case, apu_prefer_gtt
> will be set incorrectly. Take system memory into account when set
> apu_prefer_gtt.
> 

Wouldn't it be cleaner to do this in TTM?  IE test that a bad option was 
set by user pages_limit value and then show something like:

if (user > possible) {
     pr_warn("Requested invalid %d pages, limiting to %d pages", user, 
possible);
     user = possible;
}

Then we can always trust what we get from TTM.

> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
>   4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3bfd79c89df3..a6ee9d9bfafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   	int i;
>   	int last_valid_bit;
>   
> -	amdgpu_amdkfd_gpuvm_init_mem_limits();
> -
>   	if (adev->kfd.dev) {
>   		struct kgd2kfd_shared_resources gpu_resources = {
>   			.compute_vmid_bitmap =
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index cdbab7f8cee8..13cada7da4a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>   
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD)
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>   void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   
> @@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>   void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>   #else
>   static inline
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   {
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8a869fe41acd..4fba7d2f34a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>    *  System (TTM + userptr) memory - 15/16th System RAM
>    *  TTM memory - 3/8th System RAM
>    */
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   {
>   	struct sysinfo si;
>   	uint64_t mem;
>   
>   	if (kfd_mem_limit.max_system_mem_limit)
> -		return;
> +		return kfd_mem_limit.max_system_mem_limit;
>   
>   	si_meminfo(&si);
>   	mem = si.totalram - si.totalhigh;
> @@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>   		(kfd_mem_limit.max_system_mem_limit >> 20),
>   		(kfd_mem_limit.max_ttm_mem_limit >> 20));
> +
> +	return kfd_mem_limit.max_system_mem_limit;
>   }
>   
>   void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 714fd8d12ca5..df98ece071e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
>   int amdgpu_ttm_init(struct amdgpu_device *adev)
>   {
>   	uint64_t gtt_size;
> +	uint64_t max_system_mem_limit;
>   	int r;
>   
>   	dma_set_max_seg_size(adev->dev, UINT_MAX);
> @@ -2210,8 +2211,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	dev_info(adev->dev, " %uM of GTT memory ready.\n",
>   		 (unsigned int)(gtt_size / (1024 * 1024)));
>   
> +
> +	max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
> +
>   	if (adev->flags & AMD_IS_APU) {
> -		if (adev->gmc.real_vram_size < gtt_size)
> +		if (adev->gmc.real_vram_size < gtt_size &&
> +			adev->gmc.real_vram_size < max_system_mem_limit)
>   			adev->apu_prefer_gtt = true;
>   	}
>   

