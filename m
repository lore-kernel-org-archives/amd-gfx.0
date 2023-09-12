Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF5CA0EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 01:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C4810E07D;
	Tue, 12 Sep 2023 01:11:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B6A10E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 01:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYOw54IVPZsTl5kjeYyLmBpVNomO9RcJuOmC7xUWLvcdBubIf23X/TrqPjO1hrm0ydUriNtbhdr2FtWXCH7tga9ZoBVL10yPFDl97YbpvjAn/rWUeCsTkRPX8Pi4wJomLQy/ZsOxQe/DgGBGj1WeGUTV5w7rS8Tmpa54Ar32xcjv9OrRP1Qj3mfjKyOemI1sWP44vHdB7zMGtMiwfm0aAuXpC/q6IX6P3poua3gVDdHoqRMfQkEfF3U18VhPJnMwDEN+aqDCoJMM3NGHIJnUTgeVIKx0MXAjIKZEWYN7PMyRFGlPlonbUj954xVXO4bXftyUtNnhyeVSsi+edjk3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlhpaUfNUivK9P1isvjZMTydKnzOsKeVjKL0rEzGeDw=;
 b=nyT1HOxRaaPVh3eHfcWEQR7eGumdoeYtvTz/KuhLz7Ms9S0hpWcLUx5HUUcep6iLWWQ/vVZxet5r3R6+0895OsxNs2tarSHoVGkYV6Nrb0ISGCELVRXEh4JSrKC2rwQrElbt1tuzburEnqOv0+L+CpHk/vhzJFRUB1zAvN7oZUdThJhAJ6cMsGyBpqAAz9juyxkej2HKjLe92spU5U7qEaghMgnsIBt4qhkXidZr1W5YjQ5Zj/saGpZcChx8+ULy1UxGQdXPJRavqyLTk52IBI07ywGWgPB2JnC51t+YGqVXbU1ziX+Suz7O78z2gkFixQ2dJP9wq7SXP1E+at+3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlhpaUfNUivK9P1isvjZMTydKnzOsKeVjKL0rEzGeDw=;
 b=0PobNpZHk2vvJmpzzJlxrxkqTDpAczCZNSmzvIymi3481cPoqsbh1b+r+roizdXq61QRvZoE8WlbQhmASEJQbipBNYkk5R/VTU3yS2ELc/ZifYhp8rWFf+gYfw2FQB/Q00xxdvGBjpoE4EcEYIFkdhop+NDvtZJauiS/zgPGliQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 01:11:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 01:11:48 +0000
Message-ID: <b8b95ee3-e608-a996-db65-cb02c418620a@amd.com>
Date: Mon, 11 Sep 2023 21:11:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] drm/amdkfd: Move dma unmapping after TLB flush
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230911195517.8548-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230911195517.8548-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: e006817b-ff07-4bdd-f87f-08dbb32d3d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhfrA6Nk7k38sISC9AKxyLytXS5FVynRMd1GIPL/nl5qOsXF8i00fu7PTBwvSttIBwjg/LY85w5S6wj8o98MgEyDkU+iryITP8M3G0S/n0/Ko/oread8DJN9jrhHBxon0mANZ+Tz6jRXLI8DIk7aidYbrwPUzoOFxzFVISPulnbMNQsJjsYm+hzbL5Z0NHVXJblSiAkZg85Y1L8wXHldDyNy5/nLDcI/a7Bkw3/Mpp1W1YC3CPMbIkbpEVrEym0venLm61I7t60EesdP9XAfvGUgTkDpmI2lRtY4fRhocSaOKcI2hwazHlXJGRUt4j4D6HA28mVRw18WsbN08UGn6l81QGOkYloawK/Y1miCEiXQsp8Bl102JR7bk1gizSood5DSOgJuO1JMNAbpxw0uvTQwQ6RioElvCh972FZTlqo6LxGIF+x5HK/pmW+ZbbY14UztbNlNfbkoqWnSqBRaeuv3EVNZu6d8z1yO3QXSI5FGx8deTmFzoebQgrRI8PkniZuhcuQ9M5C1/FRnfEjBM3St0cR7eCK6rqf6iFvBGtSNWjs2AbNXUkNKMaNMHPwjAEIIq3M4cHLoDirwvF6MgAk5Xc5WdsgJjPMQcJFmNKk0jF+j7T7/JMJTpcYXGP2zZrS5JdtnUSJ3iJi0hWX1Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(186009)(451199024)(1800799009)(31686004)(8676002)(2906002)(31696002)(44832011)(36756003)(86362001)(5660300002)(38100700002)(8936002)(83380400001)(478600001)(26005)(41300700001)(316002)(6486002)(6506007)(53546011)(6512007)(2616005)(66556008)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnlWdnB3RERWa2JaM0tjKy9GbHdQbG5uSkViUDdaWWZ6UlZ0c05vWklpdjJJ?=
 =?utf-8?B?MUNrdHZSN0pQR0NGMncxNWdNQW1ZQU1uMXhyVndINy9XS1pZU1g0bWwzbkVp?=
 =?utf-8?B?VVNKQ3h1TzdsRFZnS0NQWVlRdjF6dit1VWd4MUdtekpQenoxOTFZNnVvMUY3?=
 =?utf-8?B?c2U1ZzFuRU41MktEV3RkT2xMZXRHdEd0MTM1a044L1VVUGNETWlJOEhRNk1m?=
 =?utf-8?B?a2VPZXZ2MFNPVWIrcUVwTUU3dGtTNTZhUGhTdUxaTE5ZQnl3NXIwZmw2TFJD?=
 =?utf-8?B?cGlBNVZiam1XelYrOElzaEhNQVc0SHVocFdPdzdGNVU5VUF5SFExWWZIUng5?=
 =?utf-8?B?ZURUdkc2dVdwS0NCNDBTbmpjUGR1RjBDbytkcHg0TnY1NC96QTY0YmhnVlJI?=
 =?utf-8?B?ZS9qK05DNE8xdURJK3VBdGRta09sTGJOK0RONDkxVUJCNDZpSVJvZDh3TGl3?=
 =?utf-8?B?Smp1RWhRQ2lJQi90akdYZVNXYXRVRzZzTGlNcHNXU1hmdWVSYTh0WTM5WlpR?=
 =?utf-8?B?ME9Hakp4K2dFOGZ2WllveTlTQlJ5MEhuTDNreWJMaUpCbnFIUWpwMi8vc0tF?=
 =?utf-8?B?MW9uSWFhUzl3SExMNWdwM3plQUl1TGthNFAybGNIYjBkMVFOaUtsYjJOVytF?=
 =?utf-8?B?TDYrajM2V0pnT3NqSzc4ZzVLTnZQRit6Ynd1bjBDSitCRGI3aUlBeEY1aWN0?=
 =?utf-8?B?TjdBaXlJTjQ1RzMrWll6U05YdW9MMFAyTTBBYXpXVk1jR3A2NHlBZFlHcHFB?=
 =?utf-8?B?bWNtMWlmWUU3T0Y0NGxTM0c0aFNtbVQvbDdoZW1yVWN3eTZ5ZWRqcWQ2cjNh?=
 =?utf-8?B?U3BEVnd4QUx0bUgzTnFHdXpnMnMrNXlCQzlWems2b1VVQ3BZNUVPY0I0dnEv?=
 =?utf-8?B?eGRLWVp2ZEIrUzM4c2VxSEkyNWNqeDIyV1BIVURHdWM2UkNQbVBMRGpaWHVm?=
 =?utf-8?B?d1hxT0dERnZwL2dQdm9xNy8vM2U2VWt0dEZDem5UZFppOTN5enYvYkhhbmpm?=
 =?utf-8?B?cEdCZjd6enlqV0dnNHhXRzNNdDFrdFI5VWxCL04rbVQvUmJyckJaakdmMk54?=
 =?utf-8?B?eFpJSExiaSsvY2VGTWhDNTlmYWYxTzhic1MxazdzZFZyTjRmUm4wdmEwbkRF?=
 =?utf-8?B?NzhpNjVZWEZxdUlURlQvRDl4MDREME4wa1l3UzJFUmZJaUNrTlZZU1lUN01J?=
 =?utf-8?B?VzdZYUxnL0wySWs3cE55VGg5Z1VrOEFDa0VIL0kzY0xia3FjM3V1U1FRS3Y3?=
 =?utf-8?B?dEV6QnlvbDNSZTRjRTdORFFQRlFBZ1FmSld1Y3BlUG9xQ0VuZmttaGJZMEtU?=
 =?utf-8?B?VXJrRGhyU3dMTm9FRjVhQlJ6MnBmVHFBOUxNaVRsa044c0wrMmFmSE1yMzk4?=
 =?utf-8?B?aTJsdU0rc2xxeGpzMm9HenVua0Jvak10Yk5HaTRBYkh2SjZhbHJNOGl5VEtE?=
 =?utf-8?B?enZCL2RMUlJOK1hlZlRLT0IvbVl0UjMxa2lnMmNrcWJCTlZnVkNCd004T2tw?=
 =?utf-8?B?TzdZVlRUU3l5b1R6dzh3Sm9VRXpIeG5BdXZvdUxiMkdKdENUdHpacVVFZU9Y?=
 =?utf-8?B?S3BPaDhNWndpMGlYR1FtNVc5Q3haNmlUMzZVdjIyb2Q3R2hjWVBlYUNCTlBy?=
 =?utf-8?B?aFVZc3JWcXhHaTlmNU1WQzNjbW15TEppTDJkN2xzTTFob0hoZnVMajJXL25w?=
 =?utf-8?B?WlB4ejFRVUUvdXVDeW9FSjkrVDlyZ1BNdjFGUmI3WC9FUmhuQVA0QTBlR21o?=
 =?utf-8?B?eUFjeXluSlRWOEZ1bU1CWXdpL05aaWVQdEhrWkFzSGVjVnpFcXA3Vjh2Yk9n?=
 =?utf-8?B?ejlEb3g2alVwNEJnWUNyMUt0QUtGMSttRitmRGsrZmxsRTRxcDgrVnR6REdP?=
 =?utf-8?B?NUlGVUw5cVZwcnc3cWVWcmpuUDhxQWNxT0MvWWxDVS9zRDl1bGtTTGJ4ZFNi?=
 =?utf-8?B?ei9VbTRaOFRNT3FCRDBVaWRNWUlsdXBYL05SUkd4c3hJRkw3SzB5VDQwdGh3?=
 =?utf-8?B?ejFrWHBmY2l1NlorZlZPNG5hbGJIemRtcEhFZzFOZ1JDQ1Q5M0lQNTUxR01M?=
 =?utf-8?B?eVAxN3lyMzhPbzluNVQ2cS85djNCRHR3RXVZQ1JoYmRUa3lTczVkNTZET0lE?=
 =?utf-8?Q?t1qArzhQQ44VtHnxP8zG2IT6o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e006817b-ff07-4bdd-f87f-08dbb32d3d52
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 01:11:48.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhRj4ixonSVp6mdUJ/depStqWRvgS432agKiOq0/4p69soa+I68AyuVUapWjRi5oUYJtm2+hLj3UAs+6M1iJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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

On 2023-09-11 15:55, Philip Yang wrote:
> Otherwise GPU may access the stale mapping and generate IOMMU
> IO_PAGE_FAULT.
>
> Move this to inside p->mutex to prevent multiple threads mapping and
> unmapping concurrently race condition.
>
> After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
> kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
> before free the mem attachment in case failed to unmap from GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 +++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 23 ++++++++++++-------
>   3 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 559f14cc0a99..dff79a623f4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -304,6 +304,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct amdgpu_vm *vm, struct kgd_mem *mem);

For consistency with the other amdgpu_amdkfd APIs, please replace the vm 
parameter with a drm_priv parameter and do the drm_priv_to_vm 
translation inside amdgpu_amdkfd_gpuvm_dmaunmap_mem.


>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b5b940485059..ae767ad7afa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>   	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>   
>   	amdgpu_sync_fence(sync, bo_va->last_pt_update);
> -
> -	kfd_mem_dmaunmap_attachment(mem, entry);
>   }
>   
>   static int update_gpuvm_pte(struct kgd_mem *mem,
> @@ -1305,6 +1303,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   
>   update_gpuvm_pte_failed:
>   	unmap_bo_from_gpuvm(mem, entry, sync);
> +	kfd_mem_dmaunmap_attachment(mem, entry);
>   	return ret;
>   }
>   
> @@ -1910,8 +1909,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		mem->va + bo_size * (1 + mem->aql_queue));
>   
>   	/* Remove from VM internal data structures */
> -	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
> +	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
> +		kfd_mem_dmaunmap_attachment(mem, entry);

In theory this should not be needed, because user mode is required to 
unmap all mappings before freeing the BO. If (mapped_to_gpu_memory > 0), 
this function returns -EBUSY. For SG BOs, you may run into this error 
message:

     pr_err("SG Table of BO is UNEXPECTEDLY NULL");

If you decide to leave this dmaunmap_attachment here, you may want to 
turn that error into a pr_debug and remove "UNEXPECTEDLY".

Regards,
   Felix


>   		kfd_mem_detach(entry);
> +	}
>   
>   	ret = unreserve_bo_and_vms(&ctx, false, false);
>   
> @@ -2085,6 +2086,21 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct amdgpu_vm *vm, struct kgd_mem *mem)
> +{
> +	struct kfd_mem_attachment *entry;
> +
> +	mutex_lock(&mem->lock);
> +
> +	list_for_each_entry(entry, &mem->attachments, list) {
> +		if (entry->bo_va->base.vm != vm)
> +			continue;
> +		kfd_mem_dmaunmap_attachment(mem, entry);
> +	}
> +
> +	mutex_unlock(&mem->lock);
> +}
> +
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 08687ce0aa8b..645628ff1faf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1432,17 +1432,24 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			goto sync_memory_failed;
>   		}
>   	}
> -	mutex_unlock(&p->mutex);
>   
> -	if (flush_tlb) {
> -		/* Flush TLBs after waiting for the page table updates to complete */
> -		for (i = 0; i < args->n_devices; i++) {
> -			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> -			if (WARN_ON_ONCE(!peer_pdd))
> -				continue;
> +	/* Flush TLBs after waiting for the page table updates to complete */
> +	for (i = 0; i < args->n_devices; i++) {
> +		struct amdgpu_vm *vm;
> +
> +		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> +		if (WARN_ON_ONCE(!peer_pdd))
> +			continue;
> +		if (flush_tlb)
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> -		}
> +
> +		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> +		vm = drm_priv_to_vm(peer_pdd->drm_priv);
> +		amdgpu_amdkfd_gpuvm_dmaunmap_mem(vm, mem);
>   	}
> +
> +	mutex_unlock(&p->mutex);
> +
>   	kfree(devices_arr);
>   
>   	return 0;
