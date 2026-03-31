Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD971061B30
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 03:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C066710E247;
	Tue, 31 Mar 2026 03:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kyTrzKgr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E6B10E247
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3hsJZyOlrHlSOiOlCZAL9FWQCvKPVwnuI9RBLdp7ZWHzJjNcfA0nkRI8iossmULcoaIn+KnocUkJdZrHb0lz3VlpOEqp7B4+OJiagDxVKo5IVkUKOT6IFvJOW1Jie/nXd0ztgdVF7kXlAD8RQ6as3qwypsrRGP6u/15kKCvBOTNmns4f1D7+jsIPD7Uc6NCu+TQjmXcMtilWBEc0HUiu39vJZhO/FFdQYNgiN4aFD5hQVj7UOFsjlXktLcHw3+Gb7mEGoq28Br8ez0ESQ/TTFd/d3WaSGzVqy/5Z2eGo2m8G/FRI21SW/FhVQA7uDx4x5uZrWPQaJhOHpy03w/a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyhWjJzjTcrDqSNDXc996szy0dYrNXT1ugZk87GGuj0=;
 b=egfSqUYebmN7VF2QQxx8jWXUbbOmAl6A4I5/Rr8/mf+o3NXKE+ZFpPtdi1dldNX7pEWrjTRoIAtDWZQIASK3uKq89GMlUlOeQJ0iZafkHkd2uUt24yz4swrTIqOnDKZJQ5wHeYZ485oSyv5SQ8YoXTB0N7vFLVJQyko7LkG0NlvV+FnQlLoT8WrFtNvoPsOZH4tfNjaqCz/5tR8UHZTJrqnxEFHchJWFvs0opxyepZbuiNooxjGRgRbZuw7n4jr9EPUDUuE5B3ofRuDZ44KwA1AILf21tJNiE4Y/MlCem+58nyCoEVQwK/7rPROC/VPMMjMW4Ze4c60gDeYlblWGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyhWjJzjTcrDqSNDXc996szy0dYrNXT1ugZk87GGuj0=;
 b=kyTrzKgrzbO0/aWdzAbkwRoqB2CVsnBI8AwZt77AJkBTBou8PSWHquU57mAieGZbE/Nb2toC0HW7LW+w7dKLRx5X7p8isNbpIA7OMk7/9ho1IPp8XawfKI3S+xi52NDMXcEBWRuHl60IMGf/ksmOGa89trcbD7aGAbOp6EOAJ/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:46:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:46:42 +0000
Message-ID: <684bf2f1-6e1b-42aa-9a83-73be3cbcbd82@amd.com>
Date: Tue, 31 Mar 2026 09:16:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use the xarrary for managing the pasid
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20260331025904.3387764-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260331025904.3387764-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0214.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e63db6e-4107-4299-af2c-08de8ed81f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 2f1GzgAiH2fSxGA/ms9xd2GEAxSpAbVSXB+plPZPj2fiSfDWHzRu9WV/bbLl9hpbx8VcQb84TdbDdaoA/QWzZcT5exbiLuJcs09brfC6LFqK/VKXXVwtOqnKsfOiDmdzyXWpXcC+DEGB52knxWOuq1WFSZNQmj7LyTbUMzVyftextpAFXhkEDiOMic97RrmOBBzCLB1+y5PgDeAG5y5KieNbyY4xQ4tAamW0QINj7+PffCAUx8fF6msP74BzHQm14ezGyIUZK4ba4wqfs4Wu9bzWkcM19mqpcmPb6v/dceIQo6j3Bg2PPbM+bpJ0xwt6mO0mCmZ7/DBCfPXY6w4qLOK9dJnYqHQ0msuNQQPIIXjZH967zMm9wrNyn4owom90P1IqlxAyhC++h/0ZQ0tPybXHFmvcyt6h2CPJPOiwu6oGAHscAr2+D+akKmBc96/kcF+vX8ueVqg3Fsdc0l0vaqZMYm7RHBWc87A8a7TWxlMkrX8BTujHGuGZ8iDfEYhiAFJrA/KMoga2TkmIi2u7euqeY1nI7T7KVChE629X8pYNKbHa+HtkgsM7rMHXHlEuoDEmnVuYAQW70ZohQAtkpAod73ZjR3iBIjuQNzoUemj7o/c2K62qamQViGsFX5g3urIJ76D1plKBdR8P8iOJD4wWu/E4kOsAiMPb1gkDt8VykRONYYdf+dqYqiX/qHZj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEF2V2lBUnNnOGpRRUJBU1BSOWwwWVZ4MDhyb2JoK3QrOFltOVhlK3R6STN4?=
 =?utf-8?B?VjJFTTBHbzlEUnBtdVUzQXQ5UmtqSWRuT29paDA2T1U3SktDS2orcUM4cmVr?=
 =?utf-8?B?UUVCNDAxVGR5aURvRGNYY0tlZUR2aGE5bldQSVFleTBEbkU0Nmp6M3lxSEFq?=
 =?utf-8?B?RmNmV1NvYlFnNFdxOHcydHVwRlpBRmhsYk9iYUJrK3kvNzNKUm8xeGFEcFFB?=
 =?utf-8?B?Skd6MHBKbVR0dzgwdCtiSUVTMTJTdnl6TmpWMmlJSEhJbFlmeGRMOXBrTUY4?=
 =?utf-8?B?OC9Jd09rUzdwQlQ4akxUYXRnTm5aTWp6Q2xKbkd6ZWszL3pTbnhZM0F5d1Fh?=
 =?utf-8?B?NVQ1Ulp6TUNPNVZZdGVrZzhpN05oeHJkT21nci82eG9KT3M5TzhuMzd6UGxB?=
 =?utf-8?B?WGVhNmcxeGRGcVhvUVFNMW1TdjJ4NkJPdkgrMGpXU1RESWtBU1RCeHpQSWNj?=
 =?utf-8?B?ZDBSbi9oOGg1UVo1S2ZSMW1GQlRMU2JuUXNBaU1nbEx1UStJVnluOWw1K3VG?=
 =?utf-8?B?WUtwRGlkNzM5cUxmWnlzd0dKSGhzclVCdVNTWlhBanVaVVRPM29QaHhQdVpu?=
 =?utf-8?B?QnZwVmp2WWx2N1FjT3BNQXZHdm1YaUdXeDZJV3hxMldxZVVNTWxva2JtRHh0?=
 =?utf-8?B?cndmYjhPUEIxczBCdUVCNGVlTjY5K2JGNXkxZyt1OHQ5UlVRRXF4TENwV2Ey?=
 =?utf-8?B?M0dOQ0tsOGNSV0MxSEg0OVBNUE5uU1QvZldoMzY5aWR1K0J3anpMMzd2K0Er?=
 =?utf-8?B?cmlXeXdJeU1YSExCZDdxdDJEbktkTWIxQVk2RkJPR0tDUkV0bnJKZmJPc1B6?=
 =?utf-8?B?MUJmNVZkSDdQTXZKYlA5cktROXdpUzdKckpDQXFPWWM5NEFQM1BqRThGRU9H?=
 =?utf-8?B?R05Sd3lIMXNCOGkwUHM0VXRHZU5jV3d0aExKanQ2TU5LWEg4dTc4bGpQQzJX?=
 =?utf-8?B?OUdrRzFpNExNOE9kR0ttdjlrbC9PS21CbHRTQllseEY3blc0V3NBTTYvSmQv?=
 =?utf-8?B?NXNSMzkzWjBvMDdEMzdDaE5oTmhhcEYvajRCZHNrdUY0RFJJeGRDK3NnUks2?=
 =?utf-8?B?RVJVc2tKbXpIdUVYMUZleW1yK1IxbFB3VmZMNEp0WTlqQTd4ZURyMmxUVTVk?=
 =?utf-8?B?NzBTeTVDdnc1Y2NKb3JqZjkwVTlaVnRqNDdmNTNDV0dBMVZiMnUwRmxIZlB5?=
 =?utf-8?B?dUhxQ1dJQm4yNkpOWTl3OE96L2V3WjcvZXRDUkNGVGEzZXFLcnJrdlUvbXBK?=
 =?utf-8?B?cUFkT1A0UkJTRWpYbVlRb3ZHVUpzRWx6a0hvYWJWc0RKT1BOM3dxRmZ5aVp6?=
 =?utf-8?B?T0VobzlLSHVOanZnUFd3Y3IwVlhhZWx5UFg4K1pKYUw0dW5Hbm81ZTFiMEx2?=
 =?utf-8?B?M3ppKytQRVdFTG14Y0NrOGxXU21mczhhU3BZckVTZlR5SXI2R3NkQi9LRXJu?=
 =?utf-8?B?b2xIT2VDekNTbWliZ3FWTXZlOVZuVmF1WjBUa0M3WDlaajlaUGVqT3kySkts?=
 =?utf-8?B?WGtZa0NKTk5yb2hwZS9HMWlwM3NBd1JMb0YyWkdKdzZ5ZE9ERStVYktraTh5?=
 =?utf-8?B?NXAzdEY3dFBmbkh3bGNPUnl2SkJIT0hjeTZCNTQ0QWl6YnkzWUZQblZwODlT?=
 =?utf-8?B?N0Y0bkFZQUQ1dVBsZlh2TDB6UE1rRzBzYXlUTVdTQmlFQy9WZE4rZmxqM0lB?=
 =?utf-8?B?elNmVXRVUXhXZ2FWYnpNb29xbXU5c2VSZlVMNXV0UWFEWmJTUDV4QnZYQUVC?=
 =?utf-8?B?R2pnek1NTzhkeEpqaVl5cmhEM0tBcnlvaEd6d2RmcEpvdlhBTFh2TDR6UWhJ?=
 =?utf-8?B?LzJyU1Vjb3hCMkg3dGdsMDEvY1pRa1RPaUk2T0tSby8rV2RESkNWUG1RL2Vp?=
 =?utf-8?B?d201RW1vSnZMcnpuMkhwckNMY2ZuWFFiTWQ4MnZJYm00MXYzZXVZeEpURkNW?=
 =?utf-8?B?U0VtbFd5TG0ycjFlUUsxemhjeXR1VHNocHZ5b1JseHd1WS8zTFdnb1FLbEVm?=
 =?utf-8?B?VFdHdXZJbSt4NXhoOFRuQ2pGa0tGS0dJTW5za21hMFNGa0UzS2EzdUZQTmoy?=
 =?utf-8?B?YWpORXdGSTVYVVpickdEY1h1Rm0xWEFaNlJ6YVk3bm9hdTVvU1NzK3loM0Vp?=
 =?utf-8?B?VmxDbjU5L3liZndlTzJ4eHo1ckZEaC9oa2YwZCtOYlg5TFgyeDVjZ25DVzdV?=
 =?utf-8?B?S29Oc1AwRS9zdUVUSFpkc0dDaFFBcXB3UmoyNHNtS3N5R3hoVm02ME5lVkRr?=
 =?utf-8?B?RmRTbEF6b2VvbFBmYVVmR2tyL0EwbWV0ZzUwcld5Q3BzUWhSQndRa3VlVFQ0?=
 =?utf-8?B?dEd4UTJ3WTlBaWVrYWRMMUFlM0UvZlpvZzlNTDBxQjJyRTltRXo2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e63db6e-4107-4299-af2c-08de8ed81f8b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:46:42.8196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzNQgh1z2JKkz0HCGYSex1Vzkq2gx+Jsa5PDPA4G/+SF0g7O3Y6CVS/9IOaw3gt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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



On 31-Mar-26 8:29 AM, Prike Liang wrote:
> Replace the IDR based allocator with XArray and XArray's
> internal state machine can handle memory allocation correctly.
> 

There is already another one -

https://patchwork.freedesktop.org/patch/715381/?series=164079&rev=3

Thanks,
Lijo

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 49 +++++++++++--------------
>   1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index e495a8fa13fd..7b0afeddbb05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>    */
>   #include "amdgpu_ids.h"
>   
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>   #include <linux/dma-fence-array.h>
>   
>   
> @@ -35,13 +35,12 @@
>    * PASIDs are global address space identifiers that can be shared
>    * between the GPU, an IOMMU and the driver. VMs on different devices
>    * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using XArray cyclic allocation
> + * which naturally delays reuse. VMs are looked up from the PASID per amdgpu_device.
>    */
>   
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
> +static u32 amdgpu_pasid_next;
>   
>   /* Helper to free pasid from a fence callback */
>   struct amdgpu_pasid_cb {
> @@ -52,33 +51,31 @@ struct amdgpu_pasid_cb {
>   /**
>    * amdgpu_pasid_alloc - Allocate a PASID
>    * @bits: Maximum width of the PASID in bits, must be at least 1
> - *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> - *
> +
> + * Uses XArray cyclic allocator. Allocates sequentially with automatic
> + * wrap-around, delaying PASID reuse naturally.
> +
>    * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>    * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
>    * memory allocation failure.
>    */
>   int amdgpu_pasid_alloc(unsigned int bits)
>   {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>   
>   	if (bits == 0)
>   		return -EINVAL;
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	/* TODO: Need to replace the idr with an xarry, and then
> -	 * handle the internal locking with ATOMIC safe paths.
> -	 */
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_ATOMIC);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> -
> -	if (pasid >= 0)
> -		trace_amdgpu_pasid_allocated(pasid);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, NULL,
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_next, GFP_KERNEL);
> +	if (r < 0)
> +		return r;
>   
> +	trace_amdgpu_pasid_allocated(pasid);
>   	return pasid;
> +
>   }
>   
>   /**
> @@ -89,9 +86,7 @@ void amdgpu_pasid_free(u32 pasid)
>   {
>   	trace_amdgpu_pasid_freed(pasid);
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_erase(&amdgpu_pasid_xa, pasid);
>   }
>   
>   static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -630,11 +625,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>   /**
>    * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
>    *
> - * Cleanup the IDR allocator.
> + * Cleanup the XArray allocator.
>    */
>   void amdgpu_pasid_mgr_cleanup(void)
>   {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>   }

