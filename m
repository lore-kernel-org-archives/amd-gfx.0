Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A059C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 21:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A184410E758;
	Thu, 18 Apr 2024 21:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hQDRg1w";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F15010E758
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 21:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgDb+uCMTSNI3x0Dz+5/o5fUwBi5S7UtH99t22LAHIVn4Ov8wBsLlVJFxcNO7jpWJRdk6e/EfYu+tRaKJbv+oWjrXtQojzxhn0Ghwd/Vuwj8kMoYsXWtUxPSoTmBfdRE/AAqq6FNay5YQezNSeqdvIORVi/JSKHOvk4jG9UHsUTqG5NymKP9k00YxAA9xzUg2Ycl8G+dNjYqabb3+apGHZkG9j2w+uEW7tjZYzh0IJ+yr51CrOsc10W3l81Fhu9XKHPCvVz7N+H9orB2yWqjy5+KtaXo/gW1o8JjcXv2xlPGTC35+8zeATSRc+56xj9zFecVcnQSild3LGj8btaboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbN2TFmc1IP0HsYM+WSVmY06OME7CF+jjT0JjogjXy8=;
 b=k7hrY1U2npbJH3mv46BZEpSpsec/zGrKPh6EG0EavoYO7orB0q5Xm/obpnQVlHdSNlUfdO11Wm8t1jdhxR0Te3/Y/dd+iwKsXGkpIitpahiDHvzjP2PSxXu7NGtpuVCl3dS+ASINnF2rtwSqxSz6SSt5Bu2u1LQRU54GzPwbTJPbZXUM25TpIBNq1H0jOuos3Zarpipj9Jsagd2CrX2yCs1y/lW5nVN9+gyF6qvMUdgZRSnvdOUnyoLtvyIJj8cdaChrgliKktVBA+04DSrL0paXTQM6cFxTXw9CkORrMpJQG6bv9gY2Y3/7mTiAMNlvIxW3AyLpXmNqjdoXzCuRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbN2TFmc1IP0HsYM+WSVmY06OME7CF+jjT0JjogjXy8=;
 b=2hQDRg1w1AeoFZ6PvCzQSBKkCBiqjaS3EM7QSd2zej2qBQCEp6pCt0XdVBqBx1nRI7IFDVdsedOt/tdT2jyam4iUUHz4cM3pfuCl5KSKS3w92cpL6FqffroDSv5YPA+G93H28rFGazVInDkVGFApmnPs/Mx12x7gAuYHRYx8JZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.41; Thu, 18 Apr 2024 21:24:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 21:24:40 +0000
Message-ID: <5cce10d3-1732-4565-ba33-2463b9bc3748@amd.com>
Date: Thu, 18 Apr 2024 17:24:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: make sure VM is ready for updating
 operations
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>
References: <20240411081101.3883715-1-Lang.Yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240411081101.3883715-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 545f1b3a-b3ef-479e-78fc-08dc5fedf4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8WIjD3YBwqeJCy4x5SykPVQPExX2XlvjT7O61VdXmtH45WFWfUYu8/oN3KlHPUxQYdtAoR8eMkrIpC0wcG2TZ+AA5hsXlBaTYveKst51KM39vQLQndKLRku9Cv/PdtmXoO3H5xzWzHt+eo5ONcXP2rN61CMyvZd/+pB3ZS68gQhoH2KFt6DEbjt36mMvQNU0y+FpZAIyU4VgMnDZ4iRt8y+Z0p4b2+TzcAzAUg3kGDvOQUop0rfZchR0iSHTt1RgcHHUT+YPHqG0HW85XfimCxT08KwyFVv7EdvGl8/N9FCYEH5xdJ9OTivkiDIv77x4CgDsGFSHB8lqtR4zTwUd8YLEfBB6kB1qWvoCG0WIgMPLHOYP4OY+KYvW7esVAX4lvaJuwoHSRKPod7xmdSqQXQ+B92ShhW+OPWhv1qLGFjm7g16pr548H4Xygr0u00ggAIgzauiNGmM/Zf9QJeNtZ0/IbAbquKBo2uVOOC0pSa2h3rbEIeQH1mH2h/B44nGWHP9GvBhIh0AoQ8KCGuI4B9lZB+P4UksblqnYqByzqr2btW9geKXM9ttk5WwcmMYSUsU5rsDQh/P1dRIj+rB5utKBYrJzd9nQ0IdD9E5e/rX+eO55TmNYhTU5TaHzwzVGpKYOkIZ0pRv0u6WOcKV0OeibHpjqhb4RaOZDhwdddg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJZc3JiOWJYYUk4QmVqWDh3VDNHYlFtSlNRODRzb1pueS9FS0h2K3g1OXpL?=
 =?utf-8?B?c0VLRDBVVlFhWCtldmQwVVo0MHFYcmtGNmZpY1NKWjV6dExJc2lWN2JGeThj?=
 =?utf-8?B?dWhtSVQ1ZWFEb1hWMXBUYXpQUWM5dkE2Uy9hV3pTek9vdjBkbjhuMmxhOE9m?=
 =?utf-8?B?UWhvaXgvYWZKKzV5a1RmQXJmVDR0bUJ1Z2JtTGdjWXkwaGhCQ3FwekFmZ3pS?=
 =?utf-8?B?TVNYQXR4QkFIMHZoNFpHSXkwRzZueURUczU2cTNPOHhXVHltUkRsWnVaMWI5?=
 =?utf-8?B?eUZMaGRxUVY5M2JLT2VtS21hbEZOZ01URGtvdmtwZ0tRRFZPRXJQNGhTRjk1?=
 =?utf-8?B?ZjlPaGNLOVFUQVp0UGdRYkc1ZlhuRldETWFKcGVSU005dmVwRGJvOHVZMXpz?=
 =?utf-8?B?clBRRFdrdEdCb3VCbit4WHNESFJyYzlWWFlka2JtQzlWaVh3L0crckQ1VUVW?=
 =?utf-8?B?UHA4Zm1EUWd4dXJ3SjF5eVlyMGtocTVvQjE2a2VsYWNyQkMwYWxQMFVCOFU1?=
 =?utf-8?B?eEVHNVprVkdrampQVHBDemg0QUx6VlI1QjllYTdGbVZGTWdjQjY3THdBd2F1?=
 =?utf-8?B?OWJ1SlhUVlhYWEdtY1Y4ZThFeHExUWFpT1VhaENWTVVIWHk1RjduV2d5bEY3?=
 =?utf-8?B?NytoRXVNaDRsNHRWc09xS0h3a2xibk9hRVlEWUVjUXJmNTF0YkY3Nks2Mmdy?=
 =?utf-8?B?K0RlWDc4dG1YNFpwUm5rM3o3WTdZZVRlVk1FdWFLdkFNOENBaEdZcFBQUFpw?=
 =?utf-8?B?b2p2QlpTOUlFcGcrNC8weXdTWmc1eVBMZUpxMzlxSjZmVTdNakxqcmgrQ2tj?=
 =?utf-8?B?dDI1U1REbFFqQ2Rsb0xyZG1sSURaVGplZGc1R0l0WXo2TDJwb3lXcktSMGxG?=
 =?utf-8?B?c0RZYUE3L3dJaW9DZGlYWmZ3UEJnOXlWUHhONkJQdlB6VTBrNWRlNWk0VDh5?=
 =?utf-8?B?dXVSSUJrZFVPeWFDVUFYelhOTkduL2szblA0VkxVVEdCVzg2cHNEQUVUUVBa?=
 =?utf-8?B?eU4zZnBTT24xOTQwMHNlVldlM0FYbkh0elZFV3I4SGhxMFRaNU9ESS8wRGxS?=
 =?utf-8?B?L0NMdXJ1WVRsRnE5TGhETnc2N0lycCthVUxuMklpS1lhTit2eTh4UllLeDBl?=
 =?utf-8?B?RTh5dzVCS2dzVWxZYnBxRUpwRnJQWW1COEN5cVU0bkJwZWw3WkhLa0N6SzZB?=
 =?utf-8?B?LzVLMzhYaksxYzRqZExvREJOaUlPYW4xQkJzQkM1akw0dHVldlRtRnpHU21o?=
 =?utf-8?B?R3R5bUNaKzdrUC9DanRTK0JmOWZrYm03UHZ3dDc0OHFlNUlDVmlSVDg3bUpX?=
 =?utf-8?B?TFRWei9nQkVFOEpqUjVNUnhPaWpDK1FORXg3MjFHcHZtMS9ZbDVvS2FLOXFK?=
 =?utf-8?B?akk4ZEVhR3JJTDAyNFhTN3lmaGtaaFJNWU9ZNDc0TGNUWk8yRzRTV3BMakVE?=
 =?utf-8?B?dkd4RmFuQUhsOGFTMlNKK0tLNGkyWnhvYllxcTZnOUtsV2Q1T1NCNFBhK3ov?=
 =?utf-8?B?WElYOGpTQkdxbmplNTJtdndKN0dHUG9CU2szT2FiUWd6enhyY1h2K3BaOHp2?=
 =?utf-8?B?by9sVFZQS2VOakZwR0pzSjJiQ1FpdkIyTk5RNktjRTh1cTBnYzRYYWZUUjNL?=
 =?utf-8?B?SXYvK2hSRVNWNHJYajgyYkRJbTFGZDdYWVdKY3NDTzgwOUh1VzRWVHFTZWt2?=
 =?utf-8?B?MlBlamRjTk5YeVpUSktwTWNxZll2Y2tHS0xORFI0bzgrTEVsVGxXNU5CN0Ju?=
 =?utf-8?B?a0VCMWhzdGhSc1JWQ04vWTZDdVBuL3NXbm9ITHNLQlM4V2hEcEt4LzUzcHV5?=
 =?utf-8?B?U2MwaE9Zc0p5YUdpVkEwKy9hQTUyTlluUXRZUGtvNlNES25hSlB3UkRsNmYy?=
 =?utf-8?B?N0JFLzJkWDBnV2hrNlBoWEhobTZ1bncwbXdHc00xSnRWYWVkRWZkSUlJc2RW?=
 =?utf-8?B?ZmQzck82d3RrR2RuK0xpKzlsTGoyTVV3QWdaZk5MWE16VG5iOUJ2MmF5dzB1?=
 =?utf-8?B?alVBVjcwZVMrSnZnbzhsdVdTb3c3cGhkZjAvVDRBVUNWZk1zbDh5bkEyMWlj?=
 =?utf-8?B?enpkTVozK0QyL2JldG55Y3RJS3M5aDhsUVprMUVzTEdINGdkUGxWNncwQU04?=
 =?utf-8?Q?zJeRSMQs12XId8AFmQSJ925hc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545f1b3a-b3ef-479e-78fc-08dc5fedf4c9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:24:40.0052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIhwjqFD36Kov3Jts14YoSv3BoKKc6yhQLsuWVvDmVcaIJn1461wD5rCj+KlcVMtJqj4IGp+KqwCS3JO60Zqyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

On 2024-04-11 4:11, Lang Yu wrote:
> When page table BOs were evicted but not validated before
> updating page tables, VM is still in evicting state,
> amdgpu_vm_update_range returns -EBUSY and
> restore_process_worker runs into a dead loop.
>
> v2: Split the BO validation and page table update into
> two separate loops in amdgpu_amdkfd_restore_process_bos. (Felix)
>    1.Validate BOs
>    2.Validate VM (and DMABuf attachments)
>    3.Update page tables for the BOs validated above
>
> Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in compute VMs")
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 +++++++++++--------
>   1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ae9fd844623..e2c9e6ddb1d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2900,13 +2900,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   
>   	amdgpu_sync_create(&sync_obj);
>   
> -	/* Validate BOs and map them to GPUVM (update VM page tables). */
> +	/* Validate BOs managed by KFD */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
>   			    validate_list) {
>   
>   		struct amdgpu_bo *bo = mem->bo;
>   		uint32_t domain = mem->domain;
> -		struct kfd_mem_attachment *attachment;
>   		struct dma_resv_iter cursor;
>   		struct dma_fence *fence;
>   
> @@ -2931,6 +2930,25 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   				goto validate_map_fail;
>   			}
>   		}
> +	}
> +
> +	if (failed_size)
> +		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
> +
> +	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
> +	 * validations above would invalidate DMABuf imports again.
> +	 */
> +	ret = process_validate_vms(process_info, &exec.ticket);
> +	if (ret) {
> +		pr_debug("Validating VMs failed, ret: %d\n", ret);
> +		goto validate_map_fail;
> +	}
> +
> +	/* Update mappings managed by KFD. */
> +	list_for_each_entry(mem, &process_info->kfd_bo_list,
> +			    validate_list) {
> +		struct kfd_mem_attachment *attachment;
> +
>   		list_for_each_entry(attachment, &mem->attachments, list) {
>   			if (!attachment->is_mapped)
>   				continue;
> @@ -2947,18 +2965,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   		}
>   	}
>   
> -	if (failed_size)
> -		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
> -
> -	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
> -	 * validations above would invalidate DMABuf imports again.
> -	 */
> -	ret = process_validate_vms(process_info, &exec.ticket);
> -	if (ret) {
> -		pr_debug("Validating VMs failed, ret: %d\n", ret);
> -		goto validate_map_fail;
> -	}
> -
>   	/* Update mappings not managed by KFD */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			vm_list_node) {
