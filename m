Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6689BC44507
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 09:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD7A10E27F;
	Fri, 17 Jul 2026 09:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dw242yF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0029A10E27F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 09:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrjfeymBZW/hezEyNfwuoyS+A/l8WmP5f+gwqzV5TDDGOMCIl+K3DRUMLPOsRYUqPbCQ37OLuBLLGFUuAXrj5NOglNOIqWSnzW8Uvuy6qaqq85wHoWGbUUocU1kBx08IpSprTvLy9E+Q9SE5dAjTTcVShZzcCEXEIKnyd2HrgrWrPck3Nlh0qG93MdpmP5cIHrvL+Wgwf5oxclt7T/jaut5wyugtEWPbvr1MNTUsNNWFkVY2anXcAaK2IuD6TlSx5hcVwiK0mKSDr644nUkpdxfCDLKUfpa3SMlam2xzAFaTwF6hpxkPqXv3m1iXAv+dRxdBoQ5bDpc13MbRRGgekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE1HguFdL1y09jcBSI1UncPFQQhmYTtNqYO1tduzexo=;
 b=hjh0tdiNSy5btLqdr2+sb/8vRTsV2ozOjtT3KHKPbBqkfQq176wXzMlyyGLEDae3g/uB6LSaefnmZv06v0skgFB+F1juI1g5OKfZRcEckmEn1tQ41uyxLZ0F5CtXC0IGMet5tiIwrn2Jxxj+zQWLi6FJBWdbxD82t859LAgwmpGjQs31S1/NWLQJK8sEttjCNsJEJ3CPQHrUWBderxcbks49dW6z48A4UtwbOLTbc6VI6u8NVsVYIyhtljDa68DcsJWAkhEBC5AwJzFcc7pVASZpOXUfPLzeSLzWj2+i5B6lBO45EQOV6PNLxZYmzdF3GbTREJmzxqURRcP35WLaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE1HguFdL1y09jcBSI1UncPFQQhmYTtNqYO1tduzexo=;
 b=0dw242yFGkd86+r81HKG+JpYMJbJgz++vQ7Jibx+SQVTDhRo3D15ddhXdxAXc0lGSP7k7CTnzT8vbfYfj6PeVQ8CYxSUt6q2Nzqgq0LqQPN/TEnhlwMVld108SbAlpRfHppKdToACs14YHvAtKtLXtOzx7ori4GUWEGdD0sSIZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:13:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:13:10 +0000
Message-ID: <5a965497-a836-469d-ac62-7cf69baf6aa7@amd.com>
Date: Fri, 17 Jul 2026 11:13:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
 <20260708152729.3209550-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260708152729.3209550-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: afb8ad8b-f0ec-4984-e786-08dee3e39f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: XZLGvvXuK9k885RDENt79bNCOltcCDTL8Hyfjiy01edQJeWbFnI4DGvUBF/0UAZ6rOH2iMTuHM1/VLmrBhhAlRZiAtKgbuUkBGH0nYuKwuDgPR9AFax//hlpfQo18h7rBb+MKfPrGyQHFWfPD50zwhKvP194ldqGactT5ToFCmkGEdKu6NSa6poB3uZqrCH6ABF6rMbEO3fWPeHRDMSE7I8pYjvNKtKttBIdkiGyD8pgusHL8OBYGcwj/swqeUgvLtUGI3W+fokzkDISJhbh/Si2kBNH70jJGcWEYYfzn5efhUAjhEK9brEcQgucRHlDFqZ+CWVFPFgorGNIzE2fvM500HOya/dmRS4nh4nzsQQQl3KSGpRwSbmMPHjhkG24YoUVWRMG1L2tb6Dc8J0OBvTWVxdkC5ImeYuHktxkqqhMMGlf6usNAZyllZhAYhdIXKI9H4oJdkB5ksnt/8QQUZ5a/PpeYxJUS8f3BieEoGNjTHX8y6M6nkbd324+WGEtysF96hp89u2KX3LhPKlG0P7zDtHmmApkGFGvguHaTkgkePNY8hBBZCJ8niYaiokKj1GNwtYJgxOqXpjhXA8qP16W2BYa6xKHI0Ak3f+mNFk1gYtBu+NX8p+VkgUCephNvFMD9ttw4n1RXo0va0JnrpOJAlo75BZvNTSv6s1X4EU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlh1R1Y0K1lGcEIyUkdXckd2aEhCSlJEdC9BamdIYklLQkRhTHE4aUo0akxl?=
 =?utf-8?B?Y2pLZ3YybzRSTmhRTXJnbi82NitqQ09oLzd6UDRjSkNBbDVNUFpITTAyNWFI?=
 =?utf-8?B?KzA5UFVOQ2tOMVRZdFZnaDB2Q1hqTmNZdEdlTGtjWjV1QXVlUUJTWm1KSkg4?=
 =?utf-8?B?TCsrQ0p6OUhaeWpyYlJnRWZnYnB3Mi9xcGRrUk85QUZnY2N1Y1VSMUZJenJx?=
 =?utf-8?B?QU9FVlVHWHRPNVRWWTFVRFFYU3dDSHplSDJMRVJINDlTNWpNcFNPTjFtQUJa?=
 =?utf-8?B?N0c0NXp2KzljKzRlcGlBaEhIWHRoNFB5cmRSOGZyRzE5R1JrNC91UGl3MmNs?=
 =?utf-8?B?c2lybUZEaE1VUmxiSzB5dXBHYlRaVzczamVKUVc2cmJTUzkrRlVMNEpsK3di?=
 =?utf-8?B?TjFqR0EwMVowL2JSNTM5WGsrZWFDTEpqQUZlSE1LT2dZK0NWQitJQjhEQTl0?=
 =?utf-8?B?RWdOU1pWNEgrN3NsRS83aytSZFZIYlIrZzNMVkVWZDVuMkxQa1hRQzJiM0V2?=
 =?utf-8?B?VStQQ3o1c04rdnE1Slo0dVA3ekRvcnViNVBoMnAwSlZMUzdxbXdwdVFMajJ1?=
 =?utf-8?B?R3AxSXdPbVdkdEZuV2E4bWxKVGRpU3dyb1o4QUIrOE8yS2pmS1BiV2gzK29P?=
 =?utf-8?B?ZFgwLzdQek82eE5xZ2I0aFVkaVhwMXZ2bWc4N0hYMDgrYXZKTjJ2S0NuaVo5?=
 =?utf-8?B?a3dMU09EWnkwTU4wcHVXRmh1SjZpb1lMd0YxR0RRb1lpSE5wRXFEN2ZWQlBD?=
 =?utf-8?B?aHU5ZmJSNmtSVVlkMTRQeXpwaXg1WFIwOWR6clh0bVdwK0ppblhvQXc4V0o5?=
 =?utf-8?B?U05sNnNDbHZmQWNRQjErL3VZbW1nU002WGZsbnpUM2Q5enNPeE15RjFEdG1U?=
 =?utf-8?B?amRDZEF4ei8xdHdKV0ZiQXdwc2llNTNLbWZqbkx2eFFXbG1VNVJDR1FDdmQr?=
 =?utf-8?B?Y1Y4WllHSnBkc2NpV0cyWFJKdWphQ1hwU2JmaFlPZGt2MWpGOUZLeldPNzhC?=
 =?utf-8?B?UW5NSkV0dG5XTVZwRGVBL0NxM2svaGpac3l0alVnOGlVZE5VOVhhSnBrRWl6?=
 =?utf-8?B?Y3h5anJOa0hzWjY2cWU2dEFQOWR2Q3c0V1lDUFBSZE1Sa2Nnc2Q2SWloenA1?=
 =?utf-8?B?ME5WU0s0RlZkOXp5bTY0N3BHeWMxWWNDTWJObXVBR3EvSEQwcVhxRHdjRGlZ?=
 =?utf-8?B?Tjh0Wm9CM2w2Y09XUFNJRzExQ3NOL3FNUlplY2g3U2U5UEZjdUloUUF2bWpK?=
 =?utf-8?B?Y2J6QUZyUlJSemt2cnlJY3lLbHg2VlVnNHJCeFhuU3dzSnNzYWUzMHo3ZjRv?=
 =?utf-8?B?a3p5RE12UTBSUnhJNjhOL1paRGdyaWJOY0ZpR0tlOUNldlVLSm1HSWRTOXly?=
 =?utf-8?B?WHFUSlpTS2QyVEdWVnpqb2Z2ek9qVWJ5RVdyZXRyL1pYK2VmZi9ab2VsN2Nj?=
 =?utf-8?B?b3lrVGtXSmlRTDRLN1ZLd1l0R1ZHM3RSdFZYM3AxYXJlQU9jOE5Pb2FWUi9o?=
 =?utf-8?B?aFRqUnhtRk5vYmM4UWNpdnZaa2Y1NGVqSzFsSEppQWJ0MnpqQUJYOXo4ZDJv?=
 =?utf-8?B?YmJSdGIvU08yU0dnWlFyLzJLdkQwU0pkMGt2ZkZxMkx3c21kbXFiRUpyTXNX?=
 =?utf-8?B?Yi9hMG9janFIa05DbWI5NElZMVpDSEZHb25RM0Z6aGtGWWd3Vis0ajFob3FN?=
 =?utf-8?B?S0tSbFlxM25FUThteGpOVjJMWENIdkVNa0NSYW5YSk1kWlViZWdGMjRNWXds?=
 =?utf-8?B?ZXoydHkzeG1WbGZKbUF3QWIrbG1neWhYL002SndFRG9zekttVEYwUHR1QTgx?=
 =?utf-8?B?czFrWXpxdU0reGF3Vi91ZUxPZnlad1RESjhOOXlIMVZpNUZlS1FYK1ptd3Fq?=
 =?utf-8?B?VDdnZ3kyTXVOUmh3T09BN1BEalJWWjdkUjBpNEh6NVNIUHZrZU5qUjJzK09k?=
 =?utf-8?B?U3NPNm1Qc1UrcTRFNlk4V0h1eWovTGk0S09zYWU2aUE1QmtDQnlVdjRRQVJi?=
 =?utf-8?B?b29xWGwvTWVWcnhUdVAyVS9XT0hBN3loNzlHYjRMOTNiYmFUY3BmM0w1WFR4?=
 =?utf-8?B?bWJGdDNpT1pyd3BHMWtpekpGNnVCdU5GVWVwdWVqQndRK1JOZUtYbjl5Wmdi?=
 =?utf-8?B?RjY1RzdMT1hjbldwYk1RMGJqdE1yUG8wU2hSeTBTTzZaMGNSTUFPelF2UW5O?=
 =?utf-8?B?VllLZkZ0cGN5a3dnVlVSbkRBTVQ2Q1RuUkhCWlVpcWZxZmxONG5OeENnNnJh?=
 =?utf-8?B?UUVTY0hITGRRZ0x2dFNxZUNIQlJHU0FSRXhib0ZLNVlYQ3NkSHVnS0VWdGpG?=
 =?utf-8?Q?+tz23rHqZkGZJ84BQ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb8ad8b-f0ec-4984-e786-08dee3e39f1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:13:10.1673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcshY4/ROfOAgOz+5uk1q3FYbuo9eFzMis+qVuTJM8qSimJlDo46VNNUNVMosGCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

On 7/8/26 17:27, Srinivasan Shanmugam wrote:
> VM lookup users now resolve DRM PASIDs through the global PASID xarray:
> 
> 	PASID -> fpriv -> VM
> 
> The per-device vm_manager.pasids xarray is no longer needed.
> 
> Remove PASID registration and removal from the VM init/fini paths, drop
> vm_manager PASID initialization/cleanup, and remove the xarray from
> struct amdgpu_vm_manager.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++-----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ----
>  2 files changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 11822bf832f8..579dbceecdc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2642,14 +2642,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
>  
> -	/* Store new PASID in XArray (if non-zero) */
> -	if (pasid != 0) {
> -		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	vm->pasid = pasid;

Yeah please remove the pasid parameter from amdgpu_vm_init() and nuke all the related code.

Apart from that the patch look good to me.

Regards,
Christian.

>  
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
> @@ -2657,11 +2650,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	return 0;
>  
>  error_free_root:
> -	/* If PASID was partially set, erase it from XArray before failing */
> -	if (vm->pasid != 0) {
> -		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> -		vm->pasid = 0;
> -	}
> +	vm->pasid = 0;
>  	amdgpu_vm_pt_free_root(adev, vm);
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
> @@ -2768,11 +2757,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  
>  	root = amdgpu_bo_ref(vm->root.bo);
>  	amdgpu_bo_reserve(root, true);
> -	/* Remove PASID mapping before destroying VM */
> -	if (vm->pasid != 0) {
> -		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> -		vm->pasid = 0;
> -	}
>  	dma_fence_wait(vm->last_unlocked, false);
>  	dma_fence_put(vm->last_unlocked);
>  	dma_fence_wait(vm->last_tlb_flush, false);
> @@ -2868,8 +2852,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>  #else
>  	adev->vm_manager.vm_update_mode = 0;
>  #endif
> -
> -	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>  }
>  
>  /**
> @@ -2881,9 +2863,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   */
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  {
> -	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> -	xa_destroy(&adev->vm_manager.pasids);
> -
>  	amdgpu_vmid_mgr_fini(adev);
>  	amdgpu_pasid_mgr_cleanup();
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 939f639cd8bf..f63364f128bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -481,10 +481,6 @@ struct amdgpu_vm_manager {
>  	 */
>  	int					vm_update_mode;
>  
> -	/* PASID to VM mapping, will be used in interrupt context to
> -	 * look up VM of a page fault
> -	 */
> -	struct xarray				pasids;
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
>  };

