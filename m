Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1191EF531CA
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 20:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4DE10E073;
	Mon, 13 Apr 2026 20:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NgONo1Hn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DD910E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 20:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBG3ScNNJN8Ld2HabhEHmgsGpS8S3RFcuKKrXi1IqQ87xkizuDM6lrkteqvW/m8IjvXQoIQQ0Nyz9tb9HwU+zwOUlDeNH2elBWnbS912eObzztcQCaaA6+A+P4ZJnClPYvwtuALCehRzbLUssGMzrvk2TGFz/v52AjNeX9yucfhKpvkVq97zIj1NOji7/pYZsKDnvO+20CgxxvIaAm3dxwF+J0M3PdEZA39+H5IjolacpfRJ5X5GbrVNb6u/tLd18SxnBT6wyqUKztMiYDfmt1EtVJO0M69a4tTP6QT0k0x6gsmHaT4Z7byyLfMxrlzA3L/36WN7nYwbfO2ZDCL0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNIdLuPHAFwlYlD9KiBbiYQLhEqRLyjtooikKzW7Brc=;
 b=kHfttTyukUsbYqUniN69nF9nxeNgtauB+S1Sw2k+dVZdC7DyK7RSX9FmfjE/0Up4Uk2LLn32ClYtK0n5BBa/P+kSM0fHq3fj36t6x3Hg5pYVx97A83qY6LGb9O6rzCCMi8MWDtYMYnVJTqWy84wvIP2f5vwlFWsB+ZhvgH724rLfXJ2kPoXLcwa3g3O2KTTjUub1k66Oxw5YF0yhQD4dU1ZtUCnn3WwKwnphzXhuviY7vlGuvMpj/wI2MjrI/Jlo+ee3hz+mHQ9xs8VR07SBLxk4DvqR5lZcqy2NgLbrBsCVHpZgpT29R0xPDto2ms7dSd+S0AL3isYRlplCodIwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNIdLuPHAFwlYlD9KiBbiYQLhEqRLyjtooikKzW7Brc=;
 b=NgONo1HnyM/AcxA7Ryky1NGRL6QTI6EQPyY/nxAatyFuYiNDSxAjr94qrhpSNhKqcMbsfH10eGPEqTOMw0UqxOU3Bmig39r1CLTPMKOH+mhjOjDTAwXpDQvcSb902V2I+A3cjAtodIZVcm0a1xPb4ONYV1/MDLRRGgyOMS4Pnf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 20:21:13 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 20:21:13 +0000
Content-Type: multipart/alternative;
 boundary="------------00PDWLTpRn90pL0Gdk6LDyoz"
Message-ID: <247e2545-5349-44aa-a8a5-2d1c78ec0f98@amd.com>
Date: Mon, 13 Apr 2026 16:21:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: extend mtype override to non-contiguous
 pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260409224554.2813645-1-Philip.Yang@amd.com>
 <822bdce2-5edc-4ede-9f55-79acf2512e2a@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <822bdce2-5edc-4ede-9f55-79acf2512e2a@amd.com>
X-ClientProxiedBy: YQZPR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bab57c-ff15-41af-2064-08de999a3537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ev2T3+SNRnO0K612pjiod72/i0mCTTDIa7K7Qw5FfDCAaRjrFHfmrRIsbyd5aey3FvDrqMsuPiYWVDOQ+IEajKRn/yYMyA9+bfrGcNOA3VP2/17KdDp17m07xRobjMD2iktFUy0ZjBKJyrrlUbfB47JRkf7GHmm19TGfBynSaVdGo0gIuABq/CGxhikrdtBAy+UMwyPtImGm8C5Qaf/xUaOmM9Bezq7wO3c3ajKZN4J+a7NeB77VvKllrq5+mdbvBy2eF0DQmebB+YxnNRfs7UB18bSzJi9w5D6Lm9mhBW7xXJj3wdBj2kXlX4SBpB/SyZCbtrTWCAzqDmr4bVHlFRHHwSLGuC9ohO0j4xpd/i1q2HkKG7yxIE42uB6fBiZ6UBHiPGbiBVPs5Q3vUoUqThj+YyEO1AR7PgCbUO9CsP94tJA/qJlazeH9t+cgzPH802x+oF/X1cDGWLZuhvjrWWNs/9L/fVqmujUJMZQthA0nLkYvUa8vBe0iHAAiOA7qfe8PmjscTgRJXykv3jc2kby/Rzd42Sh7wx1J5JwjjoWF3+cXjZUlCOxyDGgxRyFoPRcdxe8QSYVIfzzPpsf4LwGBRTo0F2CI4pVaM2lWfjBMTuWn/pRR4sRd0glEx3lmKfzbZeEnx6XYhEvfYdX8mimp7e55KWlwZ9REbji6CTOml2p/Hx7WheGp3Vq98mu5fK1YPgdYsa2NwmmL/tdTZLwKvLQJs+4WEfItyFThggI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDJZakxrbXJPWWxCNmpXVnVJMnptSVlDaHpKNFQ5SDBmd29qZFRHOGNsaFhI?=
 =?utf-8?B?QUt5SFNYRFdCejZ1aG9XZHgxaTZSM2RtT3o0NXU4MmxlL0tTeElaT1VxWFhM?=
 =?utf-8?B?MkZUQnZuYXBFZGJGRmwvTVRISWNWV1p6S0tuYjJOdG9ITTA0Zkl3czJseGF4?=
 =?utf-8?B?MEVaOFc5ckF4ZTcyT0R0MEQ2WTg2VlpGOEhoU3RVcmt6cjA5ZzlOS2xoa0Vx?=
 =?utf-8?B?bzljdVc3Uy9wV2ttNTJvWExJbWd5UEdCRGR2alpRZzZhUGcxRXNFN0x6R2Zh?=
 =?utf-8?B?MWpuRHVwNldXR0VHTWZKclpDdEM0U3NlZ3Z6eDF5MFM5K0hieFJ0ZGpGS3dl?=
 =?utf-8?B?Q2hqT3hhTXFnTFd6NkcyWDcwR3Q0TGdiYkkrbUNZZHh2V0tRMk9NY0N2TjNv?=
 =?utf-8?B?QUJvakRpd09JTCttNlB5akFjbERYYUh0TTNxbGpWb2U5enBObW42dE9rdnRr?=
 =?utf-8?B?cGk4Tk1idStrMm5jNWs2S3BIcHBzQkVQYnV0K040T2MydldNaFhBaUNRbnVL?=
 =?utf-8?B?UFp2VGpueWJvU1FuNUdEeWJLbXN3S0VHc2duOWhsWGVrQ3FETmt0Mk1XblJa?=
 =?utf-8?B?UnJrNWlPTXlrVGxBMnc0YWJnVXd2ZUdqWENaOUx0SW83T3p6YzhZYTVMRlUz?=
 =?utf-8?B?SDJheVZRRW5UcXY4ZDhWYjhuT012dGs1S0dLSTVvUy9kNjhRdzN3a0FjVmpJ?=
 =?utf-8?B?a0xORXNqdHdrcjRnV25uMXFueGd4K0pianJ2MUxJRXVrbDVwSTlzQ2NCY2FZ?=
 =?utf-8?B?OFZYN0JOQks4QjFENERDN3hoRkk4cmxCSWZXSitRUzBOQlk4TklwOG5aeWtH?=
 =?utf-8?B?WThTb20rUVVsWTltVGt5OHhSaVNaaTlid0RXTWpXZ2tPaENsSmlOVzV1ekNx?=
 =?utf-8?B?bUxsK0pCU0dyOE9aVUc3M29JV2NrYWlRV3BDZHpHV1lncExScllTZXAvbDd4?=
 =?utf-8?B?M080MmVycnlLNmE1ektsK0lSd01RVDBZN1IrSGdUQU5ETnZhR3M1dnZMK2g2?=
 =?utf-8?B?YllIV1VXRDhacnJzRUJCUU13cVI2dzU3ZCtKcHVva0xQTmhYR2tPZkhvL2JX?=
 =?utf-8?B?eHBoa1daaFh3OFJveFdUZnN0VUk3OU16bkloTDNkc3E5RVJzWG10NzYzRE1W?=
 =?utf-8?B?eXpKT0pPclNmT2lkTGVYaW9kTGYyV3dHcW05SkRQSTc1dCsvMXh3NW1pa2Zn?=
 =?utf-8?B?N3RCUmhYbElrL3BsMHRxdktOY2swcml0N1pWYzR4YlQvajBHWGFRTWEvUHlE?=
 =?utf-8?B?WStrcGE1Z016bVNFbVNQUU1GV215ZDZ4dTZJd2R6Q2RrbWtuMnJEMVpmbi9i?=
 =?utf-8?B?ME1hcXU3dGFldnIvbThuZFpiSEkyOXFucTZYdWp6Y29jcnhlaDdjTlRhank1?=
 =?utf-8?B?REUwNTdWQkFYNGxmWEpzM3RNRCszdjM3WklsNzluVTNEUWxNaEdOMjBueE83?=
 =?utf-8?B?ZUd3cXpxR3NYQitYVGU4NnQ1aUxqUFc0cmFHL2dseEpqNFcxZkg3L1Y2bGMx?=
 =?utf-8?B?R1FGb3NRaUdxV3lBZ0diNzd2RFZFVkpodVRGQXZ0RFdoZ1ZPM0FjUEt3NzV4?=
 =?utf-8?B?eHpvakk5ZWoxTkRaZjdFMEY5UFBOd1BMT1p0eHFJWS9vbm53ZzdTeWpjUzh1?=
 =?utf-8?B?eFRJM3NscDJOMnh3T2ZrekNWZjBBbHFoTys5MEtaTEJUajJWVFZIQVhGRU4r?=
 =?utf-8?B?L0VrNzdOdnBwTFRVSVJYWFZDVjQvUStuUkVvcmhWRVRUK1Q3dmQzWTUrZkpC?=
 =?utf-8?B?U2d2dVNuU0RVb3AxT1pCTE1PQ3cvaHZVM3NyTURtQ3hTZHRoSzFPUExqMDBJ?=
 =?utf-8?B?Z0x0MkJzdVY0TnYzdzFFZUgzeU54ZzNkeUdRWmpaV1JkTFYyU3Yvd1dNb1o1?=
 =?utf-8?B?WTdmQkN6Uy9XSW9uYTVWTkU3NiszeTJweDdBTG1CWk1ucWxnRFhvaEFMZklN?=
 =?utf-8?B?djh0ZVNnMDNIeURwTjUwalZnUTNKdmhLQjBUbmNHSW5Gd1VyVUNSUEJaUXpY?=
 =?utf-8?B?M2pwMWx1SGJWa20vdUIzdjZVb0dWMFlBdmx1VXFmeWh1Ui8wa3g0NmRRM0Jk?=
 =?utf-8?B?MjR6SHhkOW92Z1hqKy9uLzFTeUN2SExFMVBmVkx6NzZXUXhKOGpPMjhiaDRt?=
 =?utf-8?B?ejZZNlFpV2I2RnAzaGlIT0ZkTE1JMGo1YVc0Tmg4VHRmNjdadVBqVVdlMDNO?=
 =?utf-8?B?TEVxQmhoakJFNjc4eEUwVXBVWXM3Zy9seDFST2Rid2FhUVkwOStQSktpS1ZY?=
 =?utf-8?B?WHMvWVMzMkR5aWRpQjZFVnNEMUFqTU9sZ2ZCVlFUVW9jTU02SFg3VUc3MG55?=
 =?utf-8?Q?PGukGTjjOzIchb54VX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bab57c-ff15-41af-2064-08de999a3537
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:21:13.1427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYqx/nikvOf95TkZdYgkJJKmQ/VRNN2YQ/1GWXrfueA6EpNP8vROcdjFzzuG0XtF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

--------------00PDWLTpRn90pL0Gdk6LDyoz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-10 08:09, Christian König wrote:
> On 4/10/26 00:45, Philip Yang wrote:
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
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 51 +++++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>>   2 files changed, 53 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 63156289ae7f..7b7cbe054d73 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1099,6 +1099,32 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_vm_addr_same_group - check if two DMA addresses are same contiguity state
>> + *
>> + * @same_nid: true to check if two address on same NUMA node
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
>> +static inline bool amdgpu_vm_addr_same_group(bool same_nid, dma_addr_t addr,
>> +					     dma_addr_t addr_next, bool contiguous)
>> +{
>> +	if (same_nid && page_is_ram(addr >> PAGE_SHIFT) &&
>> +	    pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
>> +		return !contiguous;
>
> This relys on that the dma_addr is equal to the PFN and is a clear NO-GO from my side to that approach.

To add pages array for this seems too much overhead, to support mtype override if adev->ram_is_direct_mapped is enough.

>
> Question is why exactly would we need that in the first place?
MI300A with NPS2/4 or MI300A 4P, should use mtype RW to map on the near 
compute partition or GPU,
to maintain hw cache coherence.

As discussed offline, app may alloc with uncached flag to switch mtype, 
the test don't show issue when
switching mtype b/w RW and CC.

Regards,
Philip
>
> Regards,
> Christian.
>
>> +
>> +	return (addr + PAGE_SIZE) == addr_next;
>> +}
>> +
>>   /**
>>    * amdgpu_vm_update_range - update a range in the vm page table
>>    *
>> @@ -1134,6 +1160,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>   	struct amdgpu_vm_update_params params;
>>   	struct amdgpu_res_cursor cursor;
>> +	bool same_nid;
>>   	int r, idx;
>>   
>>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> @@ -1166,6 +1193,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	params.allow_override = allow_override;
>>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>   
>> +	same_nid = adev->gmc.is_app_apu && adev->ram_is_direct_mapped &&
>> +		   adev->gmc.gmc_funcs->override_vm_pte_flags &&
>> +		   num_possible_nodes() > 1 && params.allow_override;
>> +
>>   	amdgpu_vm_eviction_lock(vm);
>>   	if (vm->evicting) {
>>   		r = -EBUSY;
>> @@ -1198,22 +1229,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>>   				uint64_t count;
>>   
>> -				contiguous = pages_addr[pfn + 1] ==
>> -					pages_addr[pfn] + PAGE_SIZE;
>> +				contiguous = amdgpu_vm_addr_same_group(same_nid,
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
>> +					if (contiguous != amdgpu_vm_addr_same_group(same_nid,
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

--------------00PDWLTpRn90pL0Gdk6LDyoz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-10 08:09, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:822bdce2-5edc-4ede-9f55-79acf2512e2a@amd.com">
      <pre wrap="" class="moz-quote-pre">On 4/10/26 00:45, Philip Yang wrote:
</pre>
      <blockquote type="cite">
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

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 51 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..7b7cbe054d73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1099,6 +1099,32 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 }
 
+/**
+ * amdgpu_vm_addr_same_group - check if two DMA addresses are same contiguity state
+ *
+ * @same_nid: true to check if two address on same NUMA node
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
+static inline bool amdgpu_vm_addr_same_group(bool same_nid, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (same_nid &amp;&amp; page_is_ram(addr &gt;&gt; PAGE_SHIFT) &amp;&amp;
+	    pfn_to_nid(addr &gt;&gt; PAGE_SHIFT) != pfn_to_nid(addr_next &gt;&gt; PAGE_SHIFT))
+		return !contiguous;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

This relys on that the dma_addr is equal to the PFN and is a clear NO-GO from my side to that approach.</pre>
    </blockquote>
    <br>
    <pre wrap="" class="moz-quote-pre">To add pages array for this seems too much overhead, to support mtype override if adev-&gt;ram_is_direct_mapped is enough.</pre>
    <blockquote type="cite" cite="mid:822bdce2-5edc-4ede-9f55-79acf2512e2a@amd.com">
      <pre wrap="" class="moz-quote-pre">

Question is why exactly would we need that in the first place?</pre>
    </blockquote>
    MI300A with NPS2/4 or MI300A 4P, should use mtype RW to map on the
    near compute partition or GPU,<br>
    to maintain hw cache coherence.<br>
    <br>
    As discussed offline, app may alloc with uncached flag to switch
    mtype, the test don't show issue when<br>
    switching mtype b/w RW and CC.&nbsp;<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:822bdce2-5edc-4ede-9f55-79acf2512e2a@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	return (addr + PAGE_SIZE) == addr_next;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1134,6 +1160,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
+	bool same_nid;
 	int r, idx;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &amp;idx))
@@ -1166,6 +1193,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.allow_override = allow_override;
 	INIT_LIST_HEAD(&amp;params.tlb_flush_waitlist);
 
+	same_nid = adev-&gt;gmc.is_app_apu &amp;&amp; adev-&gt;ram_is_direct_mapped &amp;&amp;
+		   adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
+		   num_possible_nodes() &gt; 1 &amp;&amp; params.allow_override;
+
 	amdgpu_vm_eviction_lock(vm);
 	if (vm-&gt;evicting) {
 		r = -EBUSY;
@@ -1198,22 +1229,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				uint64_t pfn = cursor.start &gt;&gt; PAGE_SHIFT;
 				uint64_t count;
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+				contiguous = amdgpu_vm_addr_same_group(same_nid,
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
+					if (contiguous != amdgpu_vm_addr_same_group(same_nid,
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
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------00PDWLTpRn90pL0Gdk6LDyoz--
