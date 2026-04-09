Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32685F364CA
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 22:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83ADD10E892;
	Thu,  9 Apr 2026 22:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPi+C+vG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A16910E88E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 22:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gODdafxCgYn+qkrxtPBl4aAF0R/R7nKtA9DFdETRdee1WPz8bofCsbaE+/INWmxjkIhx3gYNcKhqCWis9WU/bVQifzFhPa5asyIL9Qp55caFm7tlldjhZA2NO/aZB7xacUC77MF3+7pfKxPnPxIkjPmnV0BYMGx8qxbHQMWorV8OyYBMcXGspr+c/Q3atnhlDe0VUd7LijE60JuitRqp4j1HaKU+ryThad0oMCv70gy4g8LLrOAXv/5n4zEZ2EYemeWZe7oOc6qhWd5F3d32DKCGQ8GQWKZuDFb5KGMQLrEJVVKIa2O6clMfGYMAaiLOnLcnaJ2sHtNEe6r32LEKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSD4BgVH8475LLTsqQBMYLXzmQlfjC9fhwPQdZEH1Lk=;
 b=acfY2L053D4JP0U2Sw2ak8rmhZqXfo41xfxZNm7UcIGIjI9MPyad6S7sqUhC23tGWhQNU2/qheY5GaThwFUXLt7izmDhpT0m0RGTqwhiVJ0WB4UrV48252sUsOxpFzmEvVGQsnhuOCAJqUqWOqTQuXRw1UqLObcADsWT2Ua1C3XEuaL96ArI30+1Dz12dMUwi6TMoz9rCohjgSKp6Fii0F96QD/eSXhm3+CI8k0zKjBGD6+xFDvUlqC8/cgy9qauZexoVyOFHWjNB3RPrtb1KQO1BD4Ja8Jj2mtjS7FoAI9bLTaDeH770/NtMC4H6YKREoTN05NCSTeX1Nhaot1i+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSD4BgVH8475LLTsqQBMYLXzmQlfjC9fhwPQdZEH1Lk=;
 b=kPi+C+vGpGIp7xYt+K2kF+83uK+s+eksKQ+ZaGdYy3mz+WuZu+lZp2TAkh6ITt/pKmKz8Q3GLIEz3miNLUhSWZ2WFNPEe4apyVoSyt6WDnv/oiG+AbuQgwiAaXnys7CxMSz1yW0xGVDekC4W1a8ODZlZwjgGZ/NnKt0UUUcQaIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 22:32:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 22:32:03 +0000
Content-Type: multipart/alternative;
 boundary="------------XHCTTYXDvshSPd045dnYX7ao"
Message-ID: <c141612f-b7f1-4eee-8aab-4653f6aa30f3@amd.com>
Date: Thu, 9 Apr 2026 18:32:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
 <85348d6d-b952-497b-a0ba-943158c34ac1@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <85348d6d-b952-497b-a0ba-943158c34ac1@amd.com>
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f125d0-126d-42ba-9c3a-08de9687d260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|8096899003;
X-Microsoft-Antispam-Message-Info: thPrs4QcvSwa8oRp28kP8hc5ADtBmHEqABMC1WSn2Ex7G35/A9mc9d3sao3Txwhr1FcnL0nJENUplSW2gFzbLi//4hclMrWsAk8tmx1UqHgx5kgWVwMV/eaLu39lOYnFqCokhxW2+BzIzUXJnDRsCUQXao9vNS/3HcQfluEg3UHvPfBp3CnpiAe5Nld1tqe15w0uvWraHbAJSiBbEpRkbwjtW07ca7ccNln5Wz1lCJocRw8Jcv3/Yz1a/1F7LRw7qme9f1sFCL+a6fbLyU0YZTb+PdCtsx/xRhaP7/7QRYtgVRKxzwdhYYoDEmUl6vC31ck/m+IxihfGBG2jKePLufCdi9BsyV74h5XorwfiU+nuZbGjZMszNRGe4i+pqmuu8kZuDObJN1m+MBxU1n3YpUb8LUhV/Szo+Mz8fTlVlUgxYMVy8JUxSH60E0xC9f+t8DiEV2Tn95Act4uGZWvAZe9JfDBjcxnKYqAnibPvE1QnimmDtabiMe/p5lbtqPMkO05+qlouYYM24A1rHsCcUmg6WmgY3LWD9lVIH0a5pQ6uwgUUIVS9cNiggOo45nT5vXCFOZeht4B/XNRam1SfTA8acRpigSnGZe42Nu8tPTNKcwxfh6UWDN575QcghvMEkRXuwo1hjirY1WSlbAxqE81OB6rbmrZn0WzrGz0kvdeOYl+0g/wbC9fh+/acW0n4x2IqM+7duaBIdrfyJdf8sNDl36+v5uDwdXqRepiY5qY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlBMQ3pTRnJXckpPcW82aTRvTzk3RmticHRFN0pKd3ZWcUtqVTM0QVdpc0hO?=
 =?utf-8?B?NllqQ3FzbENpeXFhaTFqa3FDZkxMaWQ1NDMvaElUbTZhdk1TUWhzWUVtRFhQ?=
 =?utf-8?B?bDF5Ym10WTdTL2lQekt0M2RMdUFtSndPUE1DamV3ZDMzdUpicGJmamxYUmx4?=
 =?utf-8?B?Sjh2QXVLYWJGSERXWjMweUNIMCtpelhHck1kNUNwZWdFb2xEaWt4U3Ryc0tx?=
 =?utf-8?B?Rk84LzZRZGk1dnIwQkRuNEhQZ1RwdmdEUUs0MnE4Nm91TndySGZJVnpTTWNy?=
 =?utf-8?B?Q2hZTUhQcVBoSmlnbFhIWGsvaWlEdkpQcmhESDBoYWo0RkhrN1BTcGV0Ui9I?=
 =?utf-8?B?RlRMU1U2QkpLakVvVHAwb1ZhVGUrUkZURkt3MU5qQkZTcEpBRzJZODAwRzg5?=
 =?utf-8?B?TitwNFBZVG44d0VpL2E4L2NibE82QzRIV1duaGxGYlk4UFZxSkR6QzFhd28z?=
 =?utf-8?B?QlkxN2RNTlVrcnpoeVZLSVowam14cW5LajRZczBXMUF0TWVqWGU5cU5Qdnhy?=
 =?utf-8?B?QUN4bU9UV2NVVDRZWExPek5PVkhyeFF4MG13M3loeFQ4NjkvQ0krV1NES2FO?=
 =?utf-8?B?NnBHUjlsWGVvem9QK3dqWWlSVURCZmkzZStUWWdsSmZNbTFZSEtMUTFaV092?=
 =?utf-8?B?T2N5a3FvTk1McWoxaFdjdUd6MVJvVVlZVzdWeWFRY3ZFRE5ldzV1SlJvUm02?=
 =?utf-8?B?T2l5WVA1RHgxR3BPdmxLYmpFMHd2WmZqU1E2OWVIcVJKazZYeHFFamhRU2RR?=
 =?utf-8?B?cW1EWmg4YWE2YWpIOXFjRVBjSFFCazI5QkhPYmJLWmZwSmRvUlVJZnJwRmRB?=
 =?utf-8?B?SWpBMUNxZmdDNUlqVmdjbWhGaFR0MXNzS0RTNGRKSFpyMmJ2Q0hOeTFrNklr?=
 =?utf-8?B?cld4ME1jTzg2VnRWNWFaYklublFuU1pldXcyaVZVdDMyd1dsS2llZUxPZjhG?=
 =?utf-8?B?UkJQMnRNYXNRdWhxbE8rRU4wTVBPMzVhTHZaaTlucEZ3MjluVXorTm1wQlNV?=
 =?utf-8?B?Q25FcUlPbjVyaDhkbG5RU0dzbFBwQnVpcU8rb3NNdG5EUXY3eG1hb3lHOEZ5?=
 =?utf-8?B?VWN1eCtjQnYySWtsQkxLNk11aU03ajU4S1lnS2dCc3RJWU5UY1JGalRqL3g5?=
 =?utf-8?B?cmFGSkJCRFp0OUd4OGJ0bTd3d3gvNU9TT2wzU0JMSGJlR0JjSGRyQUFKciti?=
 =?utf-8?B?NUE1YkE5U1RKMCtHenVyNS9GU3lRZ0NYa1lqRGJJdzlVSGRWQW5uWlM1WnJH?=
 =?utf-8?B?YzhRMklIN28xSHJ2WWU1T3UyaUFWK0dKcEdQWlhjV0tQKzkwbVFzc1IrclFv?=
 =?utf-8?B?ZFArc3FMeFZnUU05aVNDMlJNMmVmcVhlRlZUVnpKMGNndU5KNWdrYnE2bXR2?=
 =?utf-8?B?SGlCY0NtRnhpK0lXQXVvQzRTRXd6Uko1SXExUXovREkyUFJmSlMwcFVPWkNr?=
 =?utf-8?B?cG5nWFM3aXZWNGFoNGlzUk9yTFE5Smhyc2FtdkFnazJMZHVJbUNVMjV3R3lD?=
 =?utf-8?B?MmlLUkpPRk5pZWNjU0lCampVOHdqMlM1cDZqVk0wQkNzVUZuUWtPWDJFY3k1?=
 =?utf-8?B?eEJaazkrR0lyQkJTUDArWkJSSlVkK0ltYUpHVUhrcVZnMHpMNHlrbHIvWHBD?=
 =?utf-8?B?Q1ZNelJwdHhsRmcxVjVrZTcwNWJaWmc0RkZ3RHd2eWtoRCtVdTF2RDNNTW85?=
 =?utf-8?B?S3hWVmJXOWZxZXhmVkw4R1VBdUhGakNUdFJva0xpd3pGc1BZYjhPL20xYjlX?=
 =?utf-8?B?dzFGY1d3ZVZwMlJlRUtsRnBBZ2dFUVgwdWxON2Rhb3U4dGhyZnljdVh6ZkV1?=
 =?utf-8?B?a3lKSUIxS1NJWHhtQW02OUExeXFDMFNETXJRS05JQjJnbnYvME1kWi9zYnhV?=
 =?utf-8?B?VkJDbHU2UjJLL0c5dTdqWDlCQ0xFSWtMdmRNcitXU1NQLzIreVgrZ3F3WVJZ?=
 =?utf-8?B?RTlrbW4ySVFxaUswSVJRVGp1WFBYS2RQNE44VDkwZXdydnhWZ1pCWTlrL0pD?=
 =?utf-8?B?OEIvSkZJVG5ST3ZicmlvZENPK2lHVDM4RlpvL0plaG9uZDN0UFBCR1NQRTBy?=
 =?utf-8?B?MGU0cVgxS2pGb3MyNkFKS3dIbzZXdktXM0NEVUkySjZ6MWFIc3ZLWFluS0Uv?=
 =?utf-8?B?eXpjcFRUeXNUSUNmWFFXeTRuVU9aS2hkNUFCUk5pTmhOeC9JQnp2ZlhFT3JS?=
 =?utf-8?B?NlRPcnh3OE9STEZYUm5NcHhscFh2OG1aM2VvN1BpeTZpdWx0RG1ndXJFRStC?=
 =?utf-8?B?SDI0R3VGUmZqRUt6eHR6NnpqUS9QaE1YRVpVZGpQNXdNeXpTdmZhZU9OcFUw?=
 =?utf-8?Q?FiGUPDlIrOw9ZsCrh+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f125d0-126d-42ba-9c3a-08de9687d260
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:32:02.8915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeKHeuHNL1/KkjuursXn/KMoFilHFMFF/BF/z1ZrQ0FQXB+gNe+gOZEYb3anaBEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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

--------------XHCTTYXDvshSPd045dnYX7ao
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-07 19:06, Felix Kuehling wrote:
> On 2026-04-07 09:38, Philip Yang wrote:
>> On multi-socket MI300A APU systems, system memory pages mapped to the
>> closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
>> cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
>> excluded non-contiguous page mappings from the override. This caused
>> incorrect MTYPE_NC for scattered local pages, leading to cache coherence
>> issues.
>>
>> The override applies to both contiguous and non-contiguous mappings.
>> When pages_addr is set, resolve the physical address via
>> pages_addr[addr >> PAGE_SHIFT] before passing it to the override
>> callback for NUMA node lookup.
>>
>> Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
>> pages on different NUMA nodes as non-contiguous even if their DMA
>> addresses are adjacent. This ensures amdgpu_vm_update_range() splits
>> page table updates at NUMA node boundaries so each batch gets the
>> correct mtype override.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>>   2 files changed, 50 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 63156289ae7f..f8fcbf079bf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
>
> The function name is a bit misleading. It doesn't return whether the 
> pages are contiguous, but whether they are in the same "group" (same 
> amdgpu_vm_ptes_update call) by some pretty arbitrary criteria. Maybe 
> call it amdgpu_vm_addr_same_group.
>
>
ok
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @addr: current DMA address
>> + * @addr_next: next DMA address to check against
>> + * @contiguous: current contiguity state of the range being built
>> + *
>> + * Check whether @addr and @addr_next are physically contiguous. On APU
>> + * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
>> + * also breaks contiguity so that each contiguous batch stays within a
>> + * single NUMA node for correct MTYPE override selection.
>> + *
>> + * Returns:
>> + * true if @addr_next continues the current contiguous range, false otherwise.
>> + */
>> +static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
>> +					     dma_addr_t addr_next, bool contiguous)
>> +{
>> +	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))
>
> Isn't page_is_ram always true on APP APUs?
>
There is address (probably doorbell) outside ram space mapping to GPU, 
without structure page and cause crash inside pfn_to_nid.
gmc_v9_0_override_vm_pte_flags has the same checking too.
>
> On the other hand, I think you need a check here that IOMMU device 
> isolation is off (adev->ram_is_direct_mapped). Otherwise you cannot 
> infer the NUMA node from the DMA address.
>
yes, should add !adev->ram_is_direct_mapped
>
> I'd put the condition for that in the caller where you only need to 
> check it once. Then replace the adev parameter with a bool same_nid. 
> And while you're at it, you can add some more conditions to make the 
> fast-path more likely:
>
> 	same_nid = adev->gmc.is_app_apu && adev->ram_is_direct_mapped &&
> 		   adev->gmc.gmc_funcs->override_vm_pte_flags &&
> 		   num_possible_nodes() > 1 && params->allow_override;
done in next version.

Regards,
Philip
>
> Regards,
>   Felix
>
>
>> +		return (addr + PAGE_SIZE) == addr_next;
>> +
>> +	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
>> +		return !contiguous;
>> +
>> +	return (addr + PAGE_SIZE) == addr_next;
>> +}
>> +
>>   /**
>>    * amdgpu_vm_update_range - update a range in the vm page table
>>    *
>> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>>   				uint64_t count;
>>   
>> -				contiguous = pages_addr[pfn + 1] ==
>> -					pages_addr[pfn] + PAGE_SIZE;
>> +				contiguous = amdgpu_vm_addr_contiguous(adev,
>> +								       pages_addr[pfn],
>> +								       pages_addr[pfn + 1],
>> +								       contiguous);
>>   
>> -				tmp = num_entries /
>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>   				for (count = 2; count < tmp; ++count) {
>>   					uint64_t idx = pfn + count;
>>   
>> -					if (contiguous != (pages_addr[idx] ==
>> -					    pages_addr[idx - 1] + PAGE_SIZE))
>> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
>> +									pages_addr[idx - 1],
>> +									pages_addr[idx],
>> +									contiguous))
>>   						break;
>>   				}
>> +
>>   				if (!contiguous)
>>   					count--;
>> -				num_entries = count *
>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +
>> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>   			}
>>   
>>   			if (!contiguous) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 31a437ce9570..9e1607fb3b2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>>   		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>>   
>>   	/* APUs mapping system memory may need different MTYPEs on different
>> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>> -	 * to be on the same NUMA node.
>> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
>> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
>> +	 * node boundaries.
>>   	 */
>>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>>   	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
>> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
>> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>> +	    num_possible_nodes() > 1 && params->allow_override) {
>> +		if (params->pages_addr)
>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
>> +					params->pages_addr[addr >> PAGE_SHIFT], &flags);
>> +		else
>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>> +	}
>>   
>>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>>   					 flags);
>>

--------------XHCTTYXDvshSPd045dnYX7ao
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-07 19:06, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:85348d6d-b952-497b-a0ba-943158c34ac1@amd.com">
      
      <div class="moz-cite-prefix">On 2026-04-07 09:38, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">On multi-socket MI300A APU systems, system memory pages mapped to the
closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
excluded non-contiguous page mappings from the override. This caused
incorrect MTYPE_NC for scattered local pages, leading to cache coherence
issues.

The override applies to both contiguous and non-contiguous mappings.
When pages_addr is set, resolve the physical address via
pages_addr[addr &gt;&gt; PAGE_SHIFT] before passing it to the override
callback for NUMA node lookup.

Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
pages on different NUMA nodes as non-contiguous even if their DMA
addresses are adjacent. This ensures amdgpu_vm_update_range() splits
page table updates at NUMA node boundaries so each batch gets the
correct mtype override.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..f8fcbf079bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 }
 
+/**
+ * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous</pre>
      </blockquote>
      <p>The function name is a bit misleading. It doesn't return
        whether the pages are contiguous, but whether they are in the
        same &quot;group&quot; (same amdgpu_vm_ptes_update call) by some pretty
        arbitrary criteria. Maybe call it amdgpu_vm_addr_same_group.</p>
      <p><br>
      </p>
    </blockquote>
    ok
    <blockquote type="cite" cite="mid:85348d6d-b952-497b-a0ba-943158c34ac1@amd.com">
      <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+ *
+ * @adev: amdgpu_device pointer
+ * @addr: current DMA address
+ * @addr_next: next DMA address to check against
+ * @contiguous: current contiguity state of the range being built
+ *
+ * Check whether @addr and @addr_next are physically contiguous. On APU
+ * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
+ * also breaks contiguity so that each contiguous batch stays within a
+ * single NUMA node for correct MTYPE override selection.
+ *
+ * Returns:
+ * true if @addr_next continues the current contiguous range, false otherwise.
+ */
+static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (!adev-&gt;gmc.is_app_apu || !page_is_ram(addr &gt;&gt; PAGE_SHIFT))</pre>
      </blockquote>
      <p>Isn't page_is_ram always true on APP APUs?</p>
    </blockquote>
    There is address (probably doorbell) outside ram space mapping to
    GPU, without structure page and cause crash inside pfn_to_nid.<br>
    gmc_v9_0_override_vm_pte_flags has the same checking too.&nbsp;
    <blockquote type="cite" cite="mid:85348d6d-b952-497b-a0ba-943158c34ac1@amd.com">
      <p>On the other hand, I think you need a check here that IOMMU
        device isolation is off (adev-&gt;ram_is_direct_mapped).
        Otherwise you cannot infer the NUMA node from the DMA address.&nbsp;</p>
    </blockquote>
    yes, should add !adev-&gt;ram_is_direct_mapped
    <blockquote type="cite" cite="mid:85348d6d-b952-497b-a0ba-943158c34ac1@amd.com">
      <p>I'd put the condition for that in the caller where you only
        need to check it once. Then replace the adev parameter with a
        bool same_nid. And while you're at it, you can add some more
        conditions to make the fast-path more likely:</p>
      <pre>	same_nid = adev-&gt;gmc.is_app_apu &amp;&amp; adev-&gt;ram_is_direct_mapped &amp;&amp;
		   adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
		   num_possible_nodes() &gt; 1 &amp;&amp; params-&gt;allow_override;</pre>
    </blockquote>
    done in next version.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:85348d6d-b952-497b-a0ba-943158c34ac1@amd.com">
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+		return (addr + PAGE_SIZE) == addr_next;
+
+	if (pfn_to_nid(addr &gt;&gt; PAGE_SHIFT) != pfn_to_nid(addr_next &gt;&gt; PAGE_SHIFT))
+		return !contiguous;
+
+	return (addr + PAGE_SIZE) == addr_next;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				uint64_t pfn = cursor.start &gt;&gt; PAGE_SHIFT;
 				uint64_t count;
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+				contiguous = amdgpu_vm_addr_contiguous(adev,
+								       pages_addr[pfn],
+								       pages_addr[pfn + 1],
+								       contiguous);
 
-				tmp = num_entries /
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 				for (count = 2; count &lt; tmp; ++count) {
 					uint64_t idx = pfn + count;
 
-					if (contiguous != (pages_addr[idx] ==
-					    pages_addr[idx - 1] + PAGE_SIZE))
+					if (contiguous != amdgpu_vm_addr_contiguous(adev,
+									pages_addr[idx - 1],
+									pages_addr[idx],
+									contiguous))
 						break;
 				}
+
 				if (!contiguous)
 					count--;
-				num_entries = count *
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+
+				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 			}
 
 			if (!contiguous) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..9e1607fb3b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		amdgpu_vm_pte_update_noretry_flags(adev, &amp;flags);
 
 	/* APUs mapping system memory may need different MTYPEs on different
-	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
-	 * to be on the same NUMA node.
+	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
+	 * since amdgpu_vm_update_range ensures updates don't span NUMA
+	 * node boundaries.
 	 */
 	if ((flags &amp; AMDGPU_PTE_SYSTEM) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;
 	    adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
-	    num_possible_nodes() &gt; 1 &amp;&amp; !params-&gt;pages_addr &amp;&amp; params-&gt;allow_override)
-		amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
+	    num_possible_nodes() &gt; 1 &amp;&amp; params-&gt;allow_override) {
+		if (params-&gt;pages_addr)
+			amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm,
+					params-&gt;pages_addr[addr &gt;&gt; PAGE_SHIFT], &amp;flags);
+		else
+			amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
+	}
 
 	params-&gt;vm-&gt;update_funcs-&gt;update(params, pt, pe, addr, count, incr,
 					 flags);

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------XHCTTYXDvshSPd045dnYX7ao--
