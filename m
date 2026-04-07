Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345D8FF5136
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 19:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A6810E4BB;
	Tue,  7 Apr 2026 19:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fov/fOE5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACB810E4BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 19:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzYlwt1UfUEX7gBDfS9n+MFViJXXI4uZdJnEKCrbmivkQl0n8s/MSKLvm6ze8zMcFQluq0sAaA88UJ31yEZUzOx92ixUQ0LjBUk4Sf5N8WSgtEpndD3HShnXcuf7mp5czSH5x2fkqiC0vPBx+Aa6AD5NcrvaVQz+voAvNH7msmYUmoiDb9EzftZrQINJsIYUw9VVRZ5lJArcLvuB5FNtacVjOqBGZrHzwQcjyVBeWFeJ92wIv8gIWHVPPGwWtQQBUN22r5Vg17pSeNAFdUENwBIvpFiE4PHlxRmTNYxe+NgQ1zCsDbG4fOWNMQ9F8s3jX+A8ITYIGlZ8wSppGSgAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJV6UJ0MRmtDsZR+Rf6uOfS48/X33zCtgMMZJyJuSAM=;
 b=uV7zG1ElShvlVGcZktZBavEac0j8D6HB6NYMVAJz0XpWMP6u9U0QtJMCZXk4c2GghS+0feX0QYGaDjacESGg1uFFzYRdLA7Oa/+pd3fRJwNSdbbCW5tWrT8EqjUI+ILJDWsx5okUa87mRxYvZLavAG58wr8LraJy02Jb/B6DXQ3VBRZ5vaqAiiRHlARylvBEv8d2V3ktVSdTPG6j5B8NUUSxetrtnQpR3amwNHgNFSd6s0qEuG9LBg1ZYr9p0zdZtadrmTemF/+tIQcxSRcpUPRDoWyqSibE7sRnRNoQWCtGTGnOFtdeNkEfepF50chhj1B0WufaTm8XbzkORaaBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJV6UJ0MRmtDsZR+Rf6uOfS48/X33zCtgMMZJyJuSAM=;
 b=Fov/fOE56GUHkoL77rrW599HvFw5IqXP9Amjr5MLqQyFS5GvQaRr587mcPlGIhWrOIu2XnWqblITtoVsvDXtuzDrwvO0WiE8O6uooRt8YRf/o+CsRPamWiX8EEEG5S6ba/vhQlqK2UfFZFYA6iZPFqxfkipVwWPTBU8xXmOkaGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 19:40:55 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33%5]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 19:40:55 +0000
Content-Type: multipart/alternative;
 boundary="------------F3XcVrZJw1zyX0A2dTWLf8bw"
Message-ID: <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
Date: Tue, 7 Apr 2026 14:40:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, Kent.Russell@amd.com,
 Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260407133833.463741-1-Philip.Yang@amd.com>
X-ClientProxiedBy: DS7PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::11) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dd76f9-fd56-422a-dc8b-08de94dd9573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uIHJ0invn9rfd0agZ8qTOGyFp599yL48uuh3CT9tDzSC7CJa0A1yY+GiioSSxceaHTUt8l52NKeH4fFNpgCaDhDK+nRKbQRC8xMsV9CQ4RHCBsRPLlSeVPB9YafLcQvbfl2FXntTOVrYI2wXqlnnRkHf4x6IAGjivgpxanttaikCzRAlHvsTdPFBa3JIqtRnPLLUH0MrnI3OG4ShcsTtEBjwUk7SHiVBRFIJfRYdcZnBdXTqy674ixl6ciwuv/CwDbLOTaVZOjMrdEAj9lPrzSaI9aUnVkvIHOCNYWhnhmvgZZ3uupYtdAdhP4DzSeI8VmDhtxOZHqQU5EAIie3pV1FiaWxa1RORkZUBSFtacAUMxB9FOfm/cf4D1KNWIw5oyXBDTB9ZIEg8a0I2JHxz6Do3jQff8upobZijNaevaUsjJtKtTc5F+hYKUHwg6gndry7TvpagdR+BojTr3B58F53ceFJDjW4HghAqm0VMigvQPyqxdy0gqW19DveJCjVSs6LbNNSJsR4i3bMnDpoVeNYJ5iK+QsJBJWjTm2gUIosvPbTg6rq4YZgbqcQgKlXdwR4LucF+W3GsbB/jw8E97CaveMMyZZOfIIfqwFqMCtr2yP/jvjySlHMEk55tOqJxeZBY4eZChqdTlu6ncWVO5ml+XnfwwFcAn0suZBkEYUop4lCb9ddlCTOvH7Kli7XI4Hg8L5DzhFeFTz+yaku7pptG4r1++ctpzkATOsdfFFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRnN3dqdldCZHVNM1BNbjd6czB3Z3ozQzJ2VlViSmZKWDhJbjczZDNSNnNY?=
 =?utf-8?B?SVA1ZnljUXQ4TXdnY2Fwd29ZNVE5NlpsYk1vMjdGSGdYczhyRy9oaG5CWm14?=
 =?utf-8?B?NkovME40Si85YUtOV0taRzVxOS9SdEswN2duMHVtYmQ1TkQ2eW9Qa21QaHNl?=
 =?utf-8?B?R3FscHZLa2ZMWUlraS9jdVRYTElZV2NNR1RKUi85VW9ScHpRcTI2aGRrL0dL?=
 =?utf-8?B?d2k3OXcrV2pacVhMUDRSUGhEZnRnVTJ0ZTJRSDZWRktWT1dPK01NNDZ2eHht?=
 =?utf-8?B?Y0doTzB6WVNocTZ4Sk1rTzhOdHJzbnpPTmFHa2tzSjQyRG5LQnNkY1NQQnFz?=
 =?utf-8?B?ckNkTFZzNVdlaDU5eEdmbEdJbElubmowNjE0WU1jQkNJcTRSakw4VG4wRW1x?=
 =?utf-8?B?RFo5dHA4emE0eEQvSXY5cGFBOVRrSDBHUDk5Z1loeVdWbVJvZUlub3lCNU02?=
 =?utf-8?B?VEQ5OThZZXVYZzZCc1MrWWk3Q1QvT3BPNVozZE9Pdmc0YnUyeStSemN4YllB?=
 =?utf-8?B?WDB0SWlBUDhVbmFaV2JLOUZ5bWpZdlhQemhmbElwR1UxaHlKbUVUaGpkK1JB?=
 =?utf-8?B?ekh0U29tYXNlWm40OUU1cXNJcFQzajcyTFFRellsb0RMR2JRdUNIUC85S3hI?=
 =?utf-8?B?dTlsQ3ZScmNmTUExQ1c2SmJLRlRFWEcxeTgzMjF2a3NDTktXNDI1YkJVckRm?=
 =?utf-8?B?aDc2NnNteEpTOHNpNm0vVVlJZWxJMDRIUCs2bElveGttZzlnNkhsaWJaK295?=
 =?utf-8?B?NTgrcmJlV2ZZS2w3VUd4YzZIbk5ZOFQveW9OT1RHQzFmcGxjQkI2a2d5YjBs?=
 =?utf-8?B?U3h5QzFaU2hPOE9aa3lhVlhESGZPaUVvVzBiN2o3Z2k2WU9xNk43ZUEwTTZK?=
 =?utf-8?B?aFh5TXY4aG1TS2N5WEpDejVwMTlidlRtNHNhYzBIR3Z3eDBFNHNSNXZSKzhm?=
 =?utf-8?B?QzZjNlhFZzNMWWtLdWVTZjFSejkwNGJPa2RHS01rQTY0OEorZ2lHL3VTSFgz?=
 =?utf-8?B?bmV1YWNzMHhpNEZaS1lYUUpwaEZwU3d5WTdUOHRQQXhnd1MzSC96ZDFKb1RV?=
 =?utf-8?B?Z1F4NzRtRXNrQm5VYzRTZ2ZoNWVnRmcwRGdkSHhFajB3MWI4ZlFPd3pwaGJG?=
 =?utf-8?B?TitHWXFsUFRDT083d0ZZTDhUYkl3K3hGUzRtaytjaW53SmlaZlp5TFB6ZHV5?=
 =?utf-8?B?MFFqclNMLzFsY29RV3BvclBrRGFWdVZrc3NpblpBcUo2eE5xbVFwQTdKVXV5?=
 =?utf-8?B?U1ZDbVMwdCtUVHpIaU1nK0N1MVc3QVJnTWN0dm56MTd6SUZoekw5SlM1MFI3?=
 =?utf-8?B?SzFCcHB2WExsVkpjay9NOEI5K1Q1QlNkaWUwV1BrdHVDUndtZzBrVnVIbzcz?=
 =?utf-8?B?RGVmWWtlVFE3cGR5OG1hb0VyTGExMExEL3JYNllOU29KSERPSDJOd3RqaWda?=
 =?utf-8?B?U1oyZHJWQ1V4MC85dVk1NFFpRnVwd2FZZVIwaWRBQnBjOU9hbWxzVER2ZEQw?=
 =?utf-8?B?SDkwZmp1dEE4RFNRS2FXejB0RXBpUlZTTlJxakRKdVJkY1dFcXZFWmsyUnlR?=
 =?utf-8?B?R2F4K0hMNW9JZzY4NElEdDROWVZyM1I2ZytuT00rcHFwVldhSTkwZEd3Wjla?=
 =?utf-8?B?VS9TMjN0NWRFY2w2aXF0c0k0Tk96R2hkeHVYNnJkRmdHeHI3dGxNM3RocWhT?=
 =?utf-8?B?L00yYVFJWFRsVkF4a2x1S1Y3NmU4THNUbm1VUzVRQ2h2MWt4M2J5NXFScHp3?=
 =?utf-8?B?YmVZTlhCQ1daYWlqUUtQbmdxRllqMUsrYmdnVHo1eXJoQlNrMiszOFNMM0J5?=
 =?utf-8?B?ZkZvZzlTZmhPbEt4RjNWdXZ4djF6cWNGazlDcERRRDQ3RE1ZN2F3V2p0SXB5?=
 =?utf-8?B?a3YxL25Qa1JkT1REWG5pcFNJK1pyakNhM0ZYNzJPOFphTHpzZTZTdVg2aVhF?=
 =?utf-8?B?WEY1VHZPZldVZVo5aXJPVURkMG5ZUkkzUFhsMEx5c25tMDkrdGRCQXJ2blRM?=
 =?utf-8?B?cjdZSUl6M2lPU2doSVpXL0xwdDNkK251R0lBci91Ry93dHdQRlhTNW9URVdP?=
 =?utf-8?B?bHhIaTY5Z1BrdlJRbkFLSWNzUnhaTFM0MndYWk5Vb09MNlkveHFJREpFcFNE?=
 =?utf-8?B?d0lxK1VFTlY5dzFEN29TbWI3UDJNUEtNV2tHUU9GNDZWR2NYVm1QakpPZkgy?=
 =?utf-8?B?NU9ob0hLaXAxbVMzZkp0MFd4cUxNOWF2M0orU1pmYlFrc2p3Q1EybHE0a2NG?=
 =?utf-8?B?SnJhRWFST1FDK3R0SGJiU3dUcGNTcjRXbFk1MXBJM1pndVordkhzWGhZTURr?=
 =?utf-8?Q?jvysTBYUTxpQVFggKp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dd76f9-fd56-422a-dc8b-08de94dd9573
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:40:55.1014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0luJuSyl5XnKBaKPIcV66xg4lFCDhejAIEZg7tc7WjHkBi2WWbrVdFxQ1+ilhNYs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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

--------------F3XcVrZJw1zyX0A2dTWLf8bw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/7/2026 8:38 AM, Philip Yang wrote:
> On multi-socket MI300A APU systems, system memory pages mapped to the
> closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
> cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
> excluded non-contiguous page mappings from the override. This caused
> incorrect MTYPE_NC for scattered local pages, leading to cache coherence
> issues.
>
> The override applies to both contiguous and non-contiguous mappings.
> When pages_addr is set, resolve the physical address via
> pages_addr[addr >> PAGE_SHIFT] before passing it to the override
> callback for NUMA node lookup.
>
> Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
> pages on different NUMA nodes as non-contiguous even if their DMA
> addresses are adjacent. This ensures amdgpu_vm_update_range() splits
> page table updates at NUMA node boundaries so each batch gets the
> correct mtype override.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>   2 files changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..f8fcbf079bf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   	}
>   }
>   
> +/**
> + * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
> + *
> + * @adev: amdgpu_device pointer
> + * @addr: current DMA address
> + * @addr_next: next DMA address to check against
> + * @contiguous: current contiguity state of the range being built
> + *
> + * Check whether @addr and @addr_next are physically contiguous. On APU
> + * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
> + * also breaks contiguity so that each contiguous batch stays within a
> + * single NUMA node for correct MTYPE override selection.
> + *
> + * Returns:
> + * true if @addr_next continues the current contiguous range, false otherwise.
> + */

We can use pfn_to_nid or page_to_nid to get which noma(id) the backing 
memory is at. pfn_to_nid uses pfn from physical address. You use 
dma_addr_t that is device dependent. It is not always same as physical 
address of RAM.

ttm_tt also has

/** @pages: Array of pages backing the data. */ struct page **pages;

I think using the pages to get numa id by page_to_nid is more appropriate.

Regards

Xiaogang

> +static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
> +					     dma_addr_t addr_next, bool contiguous)
> +{
> +	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))
> +		return (addr + PAGE_SIZE) == addr_next;
> +
> +	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
> +		return !contiguous;
> +
> +	return (addr + PAGE_SIZE) == addr_next;
> +}
> +
>   /**
>    * amdgpu_vm_update_range - update a range in the vm page table
>    *
> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>   				uint64_t count;
>   
> -				contiguous = pages_addr[pfn + 1] ==
> -					pages_addr[pfn] + PAGE_SIZE;
> +				contiguous = amdgpu_vm_addr_contiguous(adev,
> +								       pages_addr[pfn],
> +								       pages_addr[pfn + 1],
> +								       contiguous);
>   
> -				tmp = num_entries /
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   				for (count = 2; count < tmp; ++count) {
>   					uint64_t idx = pfn + count;
>   
> -					if (contiguous != (pages_addr[idx] ==
> -					    pages_addr[idx - 1] + PAGE_SIZE))
> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
> +									pages_addr[idx - 1],
> +									pages_addr[idx],
> +									contiguous))
>   						break;
>   				}
> +
>   				if (!contiguous)
>   					count--;
> -				num_entries = count *
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +
> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   			}
>   
>   			if (!contiguous) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..9e1607fb3b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>   
>   	/* APUs mapping system memory may need different MTYPEs on different
> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
> -	 * to be on the same NUMA node.
> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
> +	 * node boundaries.
>   	 */
>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>   	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
> +	    num_possible_nodes() > 1 && params->allow_override) {
> +		if (params->pages_addr)
> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
> +					params->pages_addr[addr >> PAGE_SHIFT], &flags);
> +		else
> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
> +	}
>   
>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>   					 flags);
--------------F3XcVrZJw1zyX0A2dTWLf8bw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/7/2026 8:38 AM, Philip Yang wrote:<br>
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

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
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
+ * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
+ *
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
+ */</pre>
    </blockquote>
    <p>We can use <span style="white-space: pre-wrap">pfn_to_nid </span>or
      page_to_nid to get which noma(id) the backing memory is at.&nbsp;<span style="white-space: pre-wrap">pfn_to_nid uses pfn from physical address. You use dma_addr_t that is device dependent. It is not always same as physical address of RAM.</span></p>
    <p><span style="white-space: pre-wrap">ttm_tt also has </span></p>
    <p><span style="white-space: pre-wrap">	/** @pages: Array of pages backing the data. */
	struct page **pages; </span></p>
    <p><span style="white-space: pre-wrap">I think using the pages to get numa id by </span>page_to_nid&nbsp;<span style="white-space: pre-wrap">is more appropriate.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:20260407133833.463741-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (!adev-&gt;gmc.is_app_apu || !page_is_ram(addr &gt;&gt; PAGE_SHIFT))
+		return (addr + PAGE_SIZE) == addr_next;
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
  </body>
</html>

--------------F3XcVrZJw1zyX0A2dTWLf8bw--
