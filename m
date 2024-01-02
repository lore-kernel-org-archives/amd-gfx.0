Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D23C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 20:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2130E10E158;
	Tue,  2 Jan 2024 20:36:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E8810E158
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 20:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4GykjOF9YC44EdasXANBwUjb5e1AM8rJs+EzbnoSH6V6LV84MdKBFkcRpYb67R90fi/F88qskhH1Qjmpi5psfpUdm4P/VLJkm7IplZxkIWDyXTv3GMM4PYfmtg6Dt8wwfetIm29Kn2xLq4kqwZhiNXZ4zHb1UxHfTbyO9NKaDq7660pEAnSM+BkHqvP8W0/vKCxvyWP8suBMC/yJBXHBE3XanrEqtLmhkqFOjed2h0HyqZahPutLeipqAiMaUyyKyasteFoZ1FMWx2x8HLgXz0yOpQ6D5xvexExNclp5bzU0YVckSuH+b/s1ywWRoUgyVmwUUwsrSD3YqhCBTaT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH4Wx4Bpx6Fzpd1BNOAaqWksqh0/7p15fuNk8wi/ESg=;
 b=hrg4YtHOSdyQSIttY3QAueNpiNWTti3pPmbxlTKwiXx/2vSXeUvcP39rqguKcU01vA/eQK8GN0f8uzOR8hLvHrKEKgkn0X5GycxoqxvcrTEfxfWv7uhdWU2sHH0bLDKQJIhn2mT84vkoPC+HRG5/KYtZpNeTe5UwkJ+quYK8KtO30yAN2LsdsPezajJZz/SNx6Ri8J7AD5ThtYy3DmFrTSK4y/vD6jVhiCLYYKXM96wrRkIFfL8cLIMSv5MOnjbCiuRucZcXgwHemGdbLKBih6ZDsgqC2KQe8oPHRDvL9nsgLN5A7tB6JEoex1i4X9RrbGJ4ueFfpTSRxjBDyRtucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH4Wx4Bpx6Fzpd1BNOAaqWksqh0/7p15fuNk8wi/ESg=;
 b=Yerev1DmM6j1rmmMOe6iQ/ZjOlicQ1qN7NQjIkWxKnf/L/Nu2H+1Dedy+n1LrrLDS/rK+n2waqucJE25fSue23M+BfeWHry6zRJM15/vj3SglEIZRdnIjZC2U+rlentWdyU/ZCEr1p/hW0IUXb5H08y5cqnnu3zYvCzl6hjqObk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 20:35:59 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:35:59 +0000
Content-Type: multipart/alternative;
 boundary="------------LTvy8FxYaoVJWQmGwQnVxRin"
Message-ID: <22eb35fa-88bc-42ee-875f-d3ca9001ba04@amd.com>
Date: Tue, 2 Jan 2024 15:35:56 -0500
User-Agent: Mozilla Thunderbird
From: James Zhu <jamesz@amd.com>
Subject: Re: [PATCH v3 23/24] drm/amdkfd: set debug trap bit when enabling PC
 Sampling
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231215155951.811884-1-James.Zhu@amd.com>
 <20231215155951.811884-24-James.Zhu@amd.com>
Content-Language: en-US
Organization: AMD RTG
In-Reply-To: <20231215155951.811884-24-James.Zhu@amd.com>
X-ClientProxiedBy: YQXP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::18) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bebf7d8-0391-4701-217e-08dc0bd26da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7EpWvAZdvEJTY7SlDQjKo41wYa8hsviBrnNj5WKmt/70l63tBVbCbAFYq0kx2E4iP97buqdL39l3EiMWr8eFeuuLSBN6x6M3l/aoSi1QTfNV182Xa98XwPY+57xdK3CF1JK0yKF1oWLHxfYbyxl8p4SXJfl/k5bbXHkeYsbLE2Lo5r2yp51IBuk1keF0Rim/RaqeGEU2BnRzsIqAU3zq3dShc5LQKZoddtf/OIhDKOTiGIW1WcaGPRrrRcZuROpsQ98xZ+3U9VeVFhkGEIn2Eo+1DDHrR/b99HSOg6AXaIn5rp2JgQtLFyoS3fHW1iG9QqpGzDTNv2gsRNedCqt9OXBzEFHBtovbKEeZwT+22NhM6zEX6bDgQJrt/SaGzzJ5T6wbNYVfUJyy1lFTTE1QfzwBXAX5Pn0orSZAaIRJbj+EOo1tYLmAvlINkH+BTMz60JrLdlbyP+Uhq4jDLR0dUruTCld/s834Gc3wHStXjvjl5KHK7AOy3+im3uylONcne05JNXZDpsea+mx/v1nPuzJxA9KGe0TtRbtfQu9npNEbbJVo+ltcww6t9mxNx6thhZpf8EActty2Edat9HE6DprwNaQ7NaNnnbz1ErF6By4WnBCRKvFPOv4N4lCbCnYfK1xMVNS8pB1IRK6H99GFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(2616005)(26005)(83380400001)(6666004)(66946007)(53546011)(33964004)(4326008)(30864003)(5660300002)(2906002)(41300700001)(4001150100001)(6486002)(478600001)(316002)(8676002)(8936002)(66476007)(66556008)(6506007)(38100700002)(31696002)(36756003)(36916002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9qdFVPRzdJWmhYMGhpT0lyK1Y3cDJHVGtHV3FVSkcyU29odHRuRXRUK29H?=
 =?utf-8?B?UUY3cFRKeDMwN1plRi9RY0JNTld6MWI1eEVFNkFuREhNRFRuNkZhdE9IRVZx?=
 =?utf-8?B?MFQ3bFFldkVoMDQxZFJIUkRwWlRYY2lDSThGaUlJRFZVcXZPeXhiaS8wL092?=
 =?utf-8?B?YVJyMFQvT2d4dTVEWjhrRmRSMGFkWGdKUEs0dXpqSnAvaEdDZ0xFK3lzRERt?=
 =?utf-8?B?N21sNXM0c1B1QS9qays5bjU0SVcwY3RRbGtUVzdPZFcrMHpqRVA5UVNNSk5i?=
 =?utf-8?B?aVQ4YUdMaFhCNUl4ektYWHlKdEdqcldVeVN4U0tNc2xvMTFCb2ZYVXRtOTBh?=
 =?utf-8?B?Sm0xWDU0ck9YNU1saDNYNkxiMjdiOUg1OXh0LzE2ZlpUNENLZ0tNMGZaWDQ3?=
 =?utf-8?B?YndleEk2RFhWUnRpdytJaFBSSWxkblVyTXlpdFIrTjZhaGNDcVVQVEFxQnF5?=
 =?utf-8?B?dXJjTXp4OW9KN2t5SmxJVmlPRDFZTC8zQTdzRW5OYmwxOWhrNElsWkZtck43?=
 =?utf-8?B?QXBvWmZQT01RT3d4K0c4ckFkNm80dS9teSt3cVcxM0ZybXFCcFZReTZJRmtI?=
 =?utf-8?B?Nm40cElOMXB1Z3VlL0Y0WlFkVlZxeXNya0xYL0tqTUNMQzZodC85M3ZUSW1u?=
 =?utf-8?B?U3c4dU5pQ3Vab29ST3dqTjlZOGpuQkRSaElUd0Judi9iSFo4cEZpSnhJa0lJ?=
 =?utf-8?B?R0VrZVI3cGZUWmVRd3pJVVA2a2djQmIrTVh2WXdCS2ZLbnZHOStnd2JBL21j?=
 =?utf-8?B?dFhKb1E4KzQ2ZFdhTG9kV1Q4L2gxRUQ0c1lWbzV1ejBmZy9XMmlna2Z3b1R3?=
 =?utf-8?B?VUJ6VzFwTXRxRjloUUx2MjQ1QzhlczJTNjNzcjRpK1hxQ2l5ZUtsbFJNYlBq?=
 =?utf-8?B?NlJ0MFI3aE1YRjVVZ01pd2tPaGZtaTBjK2xYMHp5VkNnL0JMZnozYXVnOW01?=
 =?utf-8?B?NXh3KzlaSmQzc042YkZHOGI0OFJaaE9CS2dUY2RyS0JQYjF0aW12TUNiZSto?=
 =?utf-8?B?VWc3VExaYlY0bm9ZWi9hV2VMUTFVYmc0ZXprVzk2d2FLRjZYa2tIekQ5RjdT?=
 =?utf-8?B?V29mNXk1WWJyWWpjV21HWG1GaVdib1FtcnBNdUd3U3lPSGdZaGQ2TW43aDJs?=
 =?utf-8?B?aDI4clBWREFod2dkOUN3bVZ4UER1SGxuSzk4UmJvd0luYnp0TnZmWjFla3dj?=
 =?utf-8?B?SHFUcWp6UkZTVnRRdWxGdEN2YmZjcWlzbTE3NnZYZ0NtekxOdzkrS2ErOGhs?=
 =?utf-8?B?dEJkaFJUS2tNOFZSd1F0d01sdE90TlRoUzFrSnlhSk0razBJdTFFNlFPaCtp?=
 =?utf-8?B?Lzc0a3Z6TFYyT1ZRQjIvT3kzTS84UkFzMjNBM0pYWnBqakFORmlUUFFuREJY?=
 =?utf-8?B?VjEwVFlJeEg4ck15blhwcVlPc25jYjN0aVEwbkVCMUdxdGovY3JUaXE5UStF?=
 =?utf-8?B?MDJ1ZWhNNzdUQXo4NEVlODBsUVZHMm0yc0RaanBzbUFkZGNHRk1EVFJmU0d5?=
 =?utf-8?B?QmpBV0svK2hvMDZLRTF3THlLOENSY1VXcndBZUpnYkdSKzNCTjdkaUNEWldh?=
 =?utf-8?B?WDRTOVYvbkJtQk84bnFBL2JkVkF5aFdHRmxkN3Nhd2dZaHBvTjZhWTVCU0x0?=
 =?utf-8?B?ZEtVY2lycWF2SkxhZ1I3d2I0TDkyVDZONXNLb0pmaWY3VUgwRk1ZN1RaMUY3?=
 =?utf-8?B?YlJ2T1RPREFMZldJdjdPUjZGWGRPUlk2Mi9oazA4SHMvYm5NaTZ4K0VDcUxm?=
 =?utf-8?B?NGg2V3Q1R0ltYklYQ2hQSk55aDV4ZlcrWEo5Vnh6QjJvc1hnY2RHQ3hBYldn?=
 =?utf-8?B?S3huZnRUcm5ZN1FLZUpyNmZmNHU3aTFJVHlDckRMOGxCWlZXZm84RjlsYVQv?=
 =?utf-8?B?NGN6K2ZaRW5YTXJJSDZ5b25jZmU5ZGQyL3pJb29MVUpOUFpMc09YbityU1Nu?=
 =?utf-8?B?R0kweDZVVk10Q1FjNVF5dHBPaW96T2pQWThrWmJhU3pIVVF4V3lnQTQzSTFM?=
 =?utf-8?B?L1N3bDVTTWdabFBmSk5TZkpRSmVmUnU5MWR1NllWZGg3bWNwL0tYZU1laGZJ?=
 =?utf-8?B?N1pXMys2WXFzMGtabnhncFJxay92MjdkckUrZ1dkYWU2dFpOMFcrVXgxQ3Ax?=
 =?utf-8?Q?4OoOHqU49J0XbBJbsim6ABiTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bebf7d8-0391-4701-217e-08dc0bd26da7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:35:59.3242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH8zz+fbZOTRiaK7Th8WV/tttX6Opj5eqFYp4NiK2EncXh5+f3GA2HinYB7b8nvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------LTvy8FxYaoVJWQmGwQnVxRin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-12-15 10:59, James Zhu wrote:
> From: David Yat Sin<David.YatSin@amd.com>
>
> We need the SPI_GDBG_PER_VMID_CNTL.TRAP_EN bit to be set during PC
> Sampling so that the TTMP registers are valid inside the sampling data.
> runtime_info.ttmp_setup will be cleared when the user application
> does the AMDKFD_IOC_RUNTIME_ENABLE ioctl without
> KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK flag on exit.
>
> It is also not valid to have the debugger attached to a process while PC
> sampling is enabled so adding some checks to prevent this.
>
> Signed-off-by: David Yat Sin<David.YatSin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 31 ++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c       | 22 ++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h       |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 43 +++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  4 +-
>   5 files changed, 75 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1a3a8ded9c93..f7a8794c2bde 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1775,7 +1775,7 @@ static int kfd_ioctl_pc_sample(struct file *filep,
>   			pr_debug("failed to bind process %p with gpu id 0x%x", p, args->gpu_id);
>   			ret = -ESRCH;
>   		} else {
> -			ret = kfd_pc_sample(pdd, args);
> +			ret = kfd_pc_sample(p, pdd, args);
>   		}
>   	}
>   	mutex_unlock(&p->mutex);
> @@ -2808,26 +2808,9 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   
>   	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
>   	p->runtime_info.r_debug = r_debug;
> -	p->runtime_info.ttmp_setup = enable_ttmp_setup;
>   
> -	if (p->runtime_info.ttmp_setup) {
> -		for (i = 0; i < p->n_pdds; i++) {
> -			struct kfd_process_device *pdd = p->pdds[i];
> -
> -			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
> -				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> -				pdd->dev->kfd2kgd->enable_debug_trap(
> -						pdd->dev->adev,
> -						true,
> -						pdd->dev->vm_info.last_vmid_kfd);
> -			} else if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> -				pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
> -						pdd->dev->adev,
> -						false,
> -						0);
> -			}
> -		}
> -	}
> +	if (enable_ttmp_setup)
> +		kfd_dbg_enable_ttmp_setup(p);
>   
>   retry:
>   	if (p->debug_trap_enabled) {
> @@ -2976,9 +2959,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		goto out;
>   	}
>   
> -	/* Check if target is still PTRACED. */
>   	rcu_read_lock();
> -	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
> +
> +	if (kfd_pc_sampling_enabled(target)) {
> +		pr_debug("Cannot enable debug trap on PID:%d because PC Sampling active\n", args->pid);
> +		r = -EBUSY;
> +	/* Check if target is still PTRACED. */
> +	} else if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
>   				&& ptrace_parent(target->lead_thread) != current) {
>   		pr_err("PID %i is not PTRACED and cannot be debugged\n", args->pid);
>   		r = -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 9ec750666382..092c2dc84d24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -1118,3 +1118,25 @@ void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   
>   	mutex_unlock(&target->event_mutex);
>   }
> +
> +void kfd_dbg_enable_ttmp_setup(struct kfd_process *p)
> +{
> +	int i;
> +	p->runtime_info.ttmp_setup = true;
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
> +			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> +			pdd->dev->kfd2kgd->enable_debug_trap(
> +					pdd->dev->adev,
> +					true,
> +					pdd->dev->vm_info.last_vmid_kfd);
> +		} else if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> +			pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
> +					pdd->dev->adev,
> +					false,
> +					0);
> +		}
> +	}
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index fd0ff64d4184..d7ce0b119dd0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -90,6 +90,9 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
>   
>   void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   					uint64_t exception_set_mask);
> +
> +void kfd_dbg_enable_ttmp_setup(struct kfd_process *p);
> +
>   /*
>    * If GFX off is enabled, chips that do not support RLC restore for the debug
>    * registers will disable GFX off temporarily for the entire debug session.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index d8286aabd5a7..6870548fc42c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -24,6 +24,7 @@
>   #include "kfd_priv.h"
>   #include "amdgpu_amdkfd.h"
>   #include "kfd_pc_sampling.h"
> +#include "kfd_debug.h"
>   #include "kfd_device_queue_manager.h"
>   
>   struct supported_pc_sample_info {
> @@ -39,6 +40,19 @@ struct supported_pc_sample_info supported_formats[] = {
>   	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
>   };
>   
> +/* Checks whether PC Sampling is enabled on any devices in use by this process */
> +bool kfd_pc_sampling_enabled(struct kfd_process *p) {

[JZ] why not add flag p->enabled_trap_type eg0x1. for debug, 0x2 for 
host trap 0x4 for stochastic. ...

.... update p->enabled_trap_type  after pcs creation successfully, clear 
when at the end of pcs destroy, then we needn't this function.

> +	int i;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		if (pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method)
> +			return true;
> +	}
> +	return false;
> +}
> +
>   static int kfd_pc_sample_thread(void *param)
>   {
>   	struct amdgpu_device *adev;
> @@ -99,13 +113,19 @@ static int kfd_pc_sample_thread_start(struct kfd_node *node)
>   	return ret;
>   }
>   
> -static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
> +static int kfd_pc_sample_query_cap(struct kfd_process *p, struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *user_args)
>   {
>   	uint64_t sample_offset;
>   	int num_method = 0;
>   	int i;
>   
> +	if (p->debug_trap_enabled) {
[JZ] Move to kfd_pc_sample(...)
> +		pr_debug("Cannot have PC Sampling and debug trap simultaneously");
> +		user_args->num_sample_info = 0;
> +		return 0;
> +	}
> +
>   	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
>   		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version)
>   			num_method++;
> @@ -205,7 +225,7 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
>   	return 0;
>   }
>   
> -static int kfd_pc_sample_create(struct kfd_process_device *pdd,
> +static int kfd_pc_sample_create(struct kfd_process *p, struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *user_args)
>   {
>   	struct kfd_pc_sample_info *supported_format = NULL;
> @@ -217,6 +237,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>   	if (user_args->num_sample_info != 1)
>   		return -EINVAL;
>   
> +	if (p->debug_trap_enabled) {
[JZ] Move to kfd_pc_sample(...)
> +		pr_debug("Cannot have PC Sampling and debug trap simultaneously");
> +		return -EBUSY;
> +	}
> +
>   	ret = copy_from_user(&user_info, (void __user *) user_args->sample_info_ptr,
>   				sizeof(struct kfd_pc_sample_info));
>   	if (ret) {
> @@ -275,6 +300,14 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>   	pcs_entry->pdd = pdd;
>   	user_args->trace_id = (uint32_t)i;
>   
> +	/*
> +	 * Set SPI_GDBG_PER_VMID_CNTL.TRAP_EN so that TTMP registers are valid in the sampling data
> +	 * p->runtime_info.ttmp_setup will be cleared when user application calls runtime_disable
[JZ] why don't put enable into runtime_enable with the same code level.
> +	 * on exit.
> +	 */
> +	if (!p->runtime_info.ttmp_setup)
[JZ] this check can be put into kfd_dbg_enable_ttmp_setup
> +		kfd_dbg_enable_ttmp_setup(p);
>   	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
>   
>   	return 0;
> @@ -321,7 +354,7 @@ void kfd_pc_sample_release(struct kfd_process_device *pdd)
>   	mutex_unlock(&pdd->dev->pcs_data.mutex);
>   }
>   
> -int kfd_pc_sample(struct kfd_process_device *pdd,
> +int kfd_pc_sample(struct kfd_process *p, struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *args)
>   {
>   	struct pc_sampling_entry *pcs_entry;
> @@ -344,10 +377,10 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>   
>   	switch (args->op) {
>   	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
> -		return kfd_pc_sample_query_cap(pdd, args);
> +		return kfd_pc_sample_query_cap(p, pdd, args);
>   
>   	case KFD_IOCTL_PCS_OP_CREATE:
> -		return kfd_pc_sample_create(pdd, args);
> +		return kfd_pc_sample_create(p, pdd, args);
>   
>   	case KFD_IOCTL_PCS_OP_DESTROY:
>   		if (pcs_entry->enabled)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> index 6175563ca9be..42525feefb85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> @@ -28,8 +28,10 @@
>   #include "amdgpu.h"
>   #include "kfd_priv.h"
>   
> -int kfd_pc_sample(struct kfd_process_device *pdd,
> +int kfd_pc_sample(struct kfd_process *p, struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *args);
>   void kfd_pc_sample_release(struct kfd_process_device *pdd);
>   
> +bool kfd_pc_sampling_enabled(struct kfd_process *p);
> +
>   #endif /* KFD_PC_SAMPLING_H_ */
--------------LTvy8FxYaoVJWQmGwQnVxRin
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-15 10:59, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">From: David Yat Sin <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>

We need the SPI_GDBG_PER_VMID_CNTL.TRAP_EN bit to be set during PC
Sampling so that the TTMP registers are valid inside the sampling data.
runtime_info.ttmp_setup will be cleared when the user application
does the AMDKFD_IOC_RUNTIME_ENABLE ioctl without
KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK flag on exit.

It is also not valid to have the debugger attached to a process while PC
sampling is enabled so adding some checks to prevent this.

Signed-off-by: David Yat Sin <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 31 ++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c       | 22 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h       |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 43 +++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  4 +-
 5 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1a3a8ded9c93..f7a8794c2bde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1775,7 +1775,7 @@ static int kfd_ioctl_pc_sample(struct file *filep,
 			pr_debug(&quot;failed to bind process %p with gpu id 0x%x&quot;, p, args-&gt;gpu_id);
 			ret = -ESRCH;
 		} else {
-			ret = kfd_pc_sample(pdd, args);
+			ret = kfd_pc_sample(p, pdd, args);
 		}
 	}
 	mutex_unlock(&amp;p-&gt;mutex);
@@ -2808,26 +2808,9 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 
 	p-&gt;runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 	p-&gt;runtime_info.r_debug = r_debug;
-	p-&gt;runtime_info.ttmp_setup = enable_ttmp_setup;
 
-	if (p-&gt;runtime_info.ttmp_setup) {
-		for (i = 0; i &lt; p-&gt;n_pdds; i++) {
-			struct kfd_process_device *pdd = p-&gt;pdds[i];
-
-			if (!kfd_dbg_is_rlc_restore_supported(pdd-&gt;dev)) {
-				amdgpu_gfx_off_ctrl(pdd-&gt;dev-&gt;adev, false);
-				pdd-&gt;dev-&gt;kfd2kgd-&gt;enable_debug_trap(
-						pdd-&gt;dev-&gt;adev,
-						true,
-						pdd-&gt;dev-&gt;vm_info.last_vmid_kfd);
-			} else if (kfd_dbg_is_per_vmid_supported(pdd-&gt;dev)) {
-				pdd-&gt;spi_dbg_override = pdd-&gt;dev-&gt;kfd2kgd-&gt;enable_debug_trap(
-						pdd-&gt;dev-&gt;adev,
-						false,
-						0);
-			}
-		}
-	}
+	if (enable_ttmp_setup)
+		kfd_dbg_enable_ttmp_setup(p);
 
 retry:
 	if (p-&gt;debug_trap_enabled) {
@@ -2976,9 +2959,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 	}
 
-	/* Check if target is still PTRACED. */
 	rcu_read_lock();
-	if (target != p &amp;&amp; args-&gt;op != KFD_IOC_DBG_TRAP_DISABLE
+
+	if (kfd_pc_sampling_enabled(target)) {
+		pr_debug(&quot;Cannot enable debug trap on PID:%d because PC Sampling active\n&quot;, args-&gt;pid);
+		r = -EBUSY;
+	/* Check if target is still PTRACED. */
+	} else if (target != p &amp;&amp; args-&gt;op != KFD_IOC_DBG_TRAP_DISABLE
 				&amp;&amp; ptrace_parent(target-&gt;lead_thread) != current) {
 		pr_err(&quot;PID %i is not PTRACED and cannot be debugged\n&quot;, args-&gt;pid);
 		r = -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 9ec750666382..092c2dc84d24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1118,3 +1118,25 @@ void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 
 	mutex_unlock(&amp;target-&gt;event_mutex);
 }
+
+void kfd_dbg_enable_ttmp_setup(struct kfd_process *p)
+{
+	int i;
+	p-&gt;runtime_info.ttmp_setup = true;
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		struct kfd_process_device *pdd = p-&gt;pdds[i];
+
+		if (!kfd_dbg_is_rlc_restore_supported(pdd-&gt;dev)) {
+			amdgpu_gfx_off_ctrl(pdd-&gt;dev-&gt;adev, false);
+			pdd-&gt;dev-&gt;kfd2kgd-&gt;enable_debug_trap(
+					pdd-&gt;dev-&gt;adev,
+					true,
+					pdd-&gt;dev-&gt;vm_info.last_vmid_kfd);
+		} else if (kfd_dbg_is_per_vmid_supported(pdd-&gt;dev)) {
+			pdd-&gt;spi_dbg_override = pdd-&gt;dev-&gt;kfd2kgd-&gt;enable_debug_trap(
+					pdd-&gt;dev-&gt;adev,
+					false,
+					0);
+		}
+	}
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index fd0ff64d4184..d7ce0b119dd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -90,6 +90,9 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask);
+
+void kfd_dbg_enable_ttmp_setup(struct kfd_process *p);
+
 /*
  * If GFX off is enabled, chips that do not support RLC restore for the debug
  * registers will disable GFX off temporarily for the entire debug session.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index d8286aabd5a7..6870548fc42c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -24,6 +24,7 @@
 #include &quot;kfd_priv.h&quot;
 #include &quot;amdgpu_amdkfd.h&quot;
 #include &quot;kfd_pc_sampling.h&quot;
+#include &quot;kfd_debug.h&quot;
 #include &quot;kfd_device_queue_manager.h&quot;
 
 struct supported_pc_sample_info {
@@ -39,6 +40,19 @@ struct supported_pc_sample_info supported_formats[] = {
 	{ IP_VERSION(9, 4, 2), &amp;sample_info_hosttrap_9_0_0 },
 };
 
+/* Checks whether PC Sampling is enabled on any devices in use by this process */
+bool kfd_pc_sampling_enabled(struct kfd_process *p) {</pre>
    </blockquote>
    <p>[JZ] why not add flag&nbsp; <span style="white-space: pre-wrap">p-&gt;enabled</span>_trap_type
      eg<span style="white-space: pre-wrap"> 0x1. for debug,  0x2 for host trap 0x4 for stochastic. ...</span></p>
    <p><span style="white-space: pre-wrap"> ....</span> update <span style="white-space: pre-wrap">p-&gt;</span><span style="white-space: pre-wrap">enabled</span>_trap_type&nbsp; after pcs
      creation successfully, clear when at the end of pcs destroy, then
      we needn't this function.</p>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">+	int i;
+
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		struct kfd_process_device *pdd = p-&gt;pdds[i];
+
+		if (pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.pc_sample_info.method)</pre>
    </blockquote>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">+			return true;
+	}
+	return false;
+}
+
 static int kfd_pc_sample_thread(void *param)
 {
 	struct amdgpu_device *adev;
@@ -99,13 +113,19 @@ static int kfd_pc_sample_thread_start(struct kfd_node *node)
 	return ret;
 }
 
-static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
+static int kfd_pc_sample_query_cap(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
 	uint64_t sample_offset;
 	int num_method = 0;
 	int i;
 
+	if (p-&gt;debug_trap_enabled) {</pre>
    </blockquote>
    [JZ] Move to kfd_pc_sample(...)<br>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">+		pr_debug(&quot;Cannot have PC Sampling and debug trap simultaneously&quot;);
+		user_args-&gt;num_sample_info = 0;
+		return 0;
+	}
+
 	for (i = 0; i &lt; ARRAY_SIZE(supported_formats); i++)
 		if (KFD_GC_VERSION(pdd-&gt;dev) == supported_formats[i].ip_version)
 			num_method++;
@@ -205,7 +225,7 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_create(struct kfd_process_device *pdd,
+static int kfd_pc_sample_create(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
 	struct kfd_pc_sample_info *supported_format = NULL;
@@ -217,6 +237,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	if (user_args-&gt;num_sample_info != 1)
 		return -EINVAL;
 
+	if (p-&gt;debug_trap_enabled) {</pre>
    </blockquote>
    [JZ] Move to kfd_pc_sample(...)
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">+		pr_debug(&quot;Cannot have PC Sampling and debug trap simultaneously&quot;);
+		return -EBUSY;
+	}
+
 	ret = copy_from_user(&amp;user_info, (void __user *) user_args-&gt;sample_info_ptr,
 				sizeof(struct kfd_pc_sample_info));
 	if (ret) {
@@ -275,6 +300,14 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pcs_entry-&gt;pdd = pdd;
 	user_args-&gt;trace_id = (uint32_t)i;
 
+	/*
+	 * Set SPI_GDBG_PER_VMID_CNTL.TRAP_EN so that TTMP registers are valid in the sampling data
+	 * p-&gt;runtime_info.ttmp_setup will be cleared when user application calls runtime_disable</pre>
    </blockquote>
    [JZ] why don't put enable into <span style="white-space: pre-wrap">runtime_enable with the same code level.  </span>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	 * on exit.
+	 */
+	if (!p-&gt;runtime_info.ttmp_setup)</pre>
    </blockquote>
    [JZ] this check can be put into <span style="white-space: pre-wrap">kfd_dbg_enable_ttmp_setup</span>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">+		kfd_dbg_enable_ttmp_setup(p);</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20231215155951.811884-24-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap=""> 	pr_debug(&quot;alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x&quot;, pcs_entry, i, pdd-&gt;dev-&gt;id);
 
 	return 0;
@@ -321,7 +354,7 @@ void kfd_pc_sample_release(struct kfd_process_device *pdd)
 	mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
 }
 
-int kfd_pc_sample(struct kfd_process_device *pdd,
+int kfd_pc_sample(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
 	struct pc_sampling_entry *pcs_entry;
@@ -344,10 +377,10 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 
 	switch (args-&gt;op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
-		return kfd_pc_sample_query_cap(pdd, args);
+		return kfd_pc_sample_query_cap(p, pdd, args);
 
 	case KFD_IOCTL_PCS_OP_CREATE:
-		return kfd_pc_sample_create(pdd, args);
+		return kfd_pc_sample_create(p, pdd, args);
 
 	case KFD_IOCTL_PCS_OP_DESTROY:
 		if (pcs_entry-&gt;enabled)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index 6175563ca9be..42525feefb85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -28,8 +28,10 @@
 #include &quot;amdgpu.h&quot;
 #include &quot;kfd_priv.h&quot;
 
-int kfd_pc_sample(struct kfd_process_device *pdd,
+int kfd_pc_sample(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
 void kfd_pc_sample_release(struct kfd_process_device *pdd);
 
+bool kfd_pc_sampling_enabled(struct kfd_process *p);
+
 #endif /* KFD_PC_SAMPLING_H_ */
</pre>
    </blockquote>
  </body>
</html>

--------------LTvy8FxYaoVJWQmGwQnVxRin--
