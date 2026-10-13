Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAA1CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E5010E795;
	Tue, 13 Oct 2026 09:51:36 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71A310F6A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoHDfLcjvH+CvLqPZfh2VmtWHNl9j89mS4/FpZf9njn2oCxCrX+n7HqW7q4jjnS6o54ulxI17tnr18+njuu1yuKvRUu5rPnIM/jtR3v2RNd21nl1FG1Df+e0oSanY8AS5z7da5G7amIhZEj7n7rRMpVMbhscWUZbrV9GgzCjqr7rrtqnmhGis4dSWcaeKX1hFIdKyz0jDPwcLl+qXSgR8WVH34D5UxGPdzB6OPTkMyfXeJZ5heItIwHOxGkcUiJGFbqHgO7IdrEtildQdnUku4E8I5RftTADlX2kli6E+/0ukfrylWIjBGMxcoqlUVLAN06cFYmi3znYp3sCqq54Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m0rcmveLzxhwrL1VDqvkJ3ooh90EY72FJSsQexijoA=;
 b=altvWQwPYxG8o3j10+FJdJVsRgH/PQKDUSodVCqpM6IqqeRgquk8dxTAhn92ohcyqjyCG/rpLmETIwlLYn4FHCUZKARbTyZRsxchrJJ4lzfeWFdpoMgtjuekq0gFJ6SIxiUCkiDZC0Kd+K0P9B2lRNNEcnEYK/JdkOGUU3EaDO6iTKTYNn+A5/EtgG/Dzmt7/P7cNOa2Uvf7EsySU8J90ZrVtdj0iOe2Qm1iOfhXEWMo4gmkgISozfM3LCNeBrKBsVvU9FHt6AufLILZYxEKVFg86x2hBDPdprDuY4XDW3c9ohvojcu/z9QLpPijctg6j85dk2F/4L4WXPsOuQYevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m0rcmveLzxhwrL1VDqvkJ3ooh90EY72FJSsQexijoA=;
 b=0tAIAXrYGn8XeWVG3OgXRQaQsj0+jBiZ1t8bAFX4c4lGTFpcXJvLwTQXAP2j/34rYeGsa9U7cIZqqAL+eToAgu3KEAHehoYFxOPOrU/0uvfvFW9TEvoiUHcY17aF9kws0PisRl//kddxwb6GLY6TDDM2AuuxT0EKBE3zXZMThbs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:51:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:51:20 +0000
Message-ID: <070288cd-6e11-4477-ad0e-c6ce061ec362@amd.com>
Date: Tue, 13 Oct 2026 11:51:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] drm/amdgpu: bind the SPM VMID's page table to
 the reserving VM
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013084937.972181-1-sunil.khatri@amd.com>
 <20261013084937.972181-13-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013084937.972181-13-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 3816f9ef-868e-4f6e-62de-08df290f887c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 904Q201VSixcwtPL+ddi1oZapcqAzNkng7UduTbSnHFMFlsDgnIgPdJq+t8YP47qQQNH0JK8nZNtJzFtKqPmtGLCIjIub7rwGmGOJnUEtykTcpSkppJKVzlnybkrmqKUWpPAisqQjpAlblExCXPAtob/HinBsjm8kJR84UvUUH5PQG4vz9aJdBzgzzqdTAAwwiOMzxP8SWhaK3WswxDEaWJb+ZbBYeDSDl4i5ChmOo9aSt0EpC+hSBrnlmmIUqQlcFyvD/GYRGNcpQ6h1pIKI6vBZyYv52NUIuUvuRbJ/71xIADdg6lyQJCFU+HxZFMRggCBv0YMbuLsdmN19K9QZOMhTTu9Y1zVZqgpd1mwL5Opgii5NLRW5lWVRNiG0HliAmipvYIcnoro+d+rn2hA1B/Pa1yM/0wRuFMtwEYVH9/TJcwh2HXMo/tYla1AHj8u1Qq+rGDFfMCx1e8QCncyUJ/WFxjpEZfzdaUoEsF5G6o9aHnGQHP+hSNiRiNXUdETg6kddGMhyL9WbHcYcnMLcli3Jp6KNs2+R9y9MxN+EcMVfoGHzJ/XiKP8GC+CnILbB0fNVIi6iw67GSAlIs9QDxw2+0cCidKrBoYHAVr9TeMEYO5Yraa+7WJbEtTUvCMTYBmVSWpu/75ESTxmLlGqplTNjk7iAxFlnHB9LFPPC34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXpCOWhwU3hhSlkwUDNYeFJURmhlNUgwTGNnMklwcHRQemdFSzFIQVVKRk13?=
 =?utf-8?B?Q3VmdVlKWlczY3NEOS84WkJ2Nlp1Qi9qVTVXOWkvczBodGdoMjZZQW5ERWFi?=
 =?utf-8?B?YzNmQkFGNC9obXVxOEplNkNsYkliRnZiNVhvQkxCSzJOWHRBUUxxYmsrMHVG?=
 =?utf-8?B?cUVHdkIrOVhxZDhOdkVIRTVnNGgxWjloOEZxWXhsM3hKYTk4N1dPVEY5QmhE?=
 =?utf-8?B?ckJqNWJuRngreWVwVVJHVTRaYTR5RThsdGU4ODZlMVJja0l2cDBUNkNpNWFS?=
 =?utf-8?B?ZWg3VDJlV05IeE1NYmpWU0s3dURpcUI1S29QU29JZUtrN0xGL3h6aGF4R1Yx?=
 =?utf-8?B?R3UzTFZHcTlHc002MVZKWHMrc0orNEw1NG9GUUtaM0lTMG1zVEhkaFI1TU1z?=
 =?utf-8?B?ZC9JcUxpTk9VZ1crc2x0MzUwTXlEblViUmdHN3dhRjVFT2Vhd0VublZtcGNh?=
 =?utf-8?B?bFVST0dHZG8ydm55Vk9lRnB0NWdrWUNMbmpmbkJrMnh4L09OODY5Y3piUlg4?=
 =?utf-8?B?aUZNNy9wVWlkNE9wWlBBNW5rczl6TVlNM0F0YXhTQlhxck5qdVFMUURLekVp?=
 =?utf-8?B?NEk2NG9uSDBFREI3NGdMZUpCb01tTUNnWTJnOGQ0NmltL01Wc2FUUWZxR0xF?=
 =?utf-8?B?YUpWV2VhUlYwWnM5WmMvZmhqR01YY2V1dVNocUtXTVBtYjQycXU3K1hXNm1w?=
 =?utf-8?B?Q3NtNXpKTFdReDVPVHJhQ2lYUURsSGUwM2dsMit5c1pnTDhoVkE3cGhQUi9o?=
 =?utf-8?B?SFBjelhDeGhBVWx2eEFYUm5JaTFBbDBZUUxpVy9hRzcvSVVuM0IxOTZjUnN4?=
 =?utf-8?B?RWFnOXlDVnIrWldqRmJSL0h3Y2pHVW0zeVlncXRQWWFmamNIOWV0cFRwWW1I?=
 =?utf-8?B?T09GR0NYdUdXaTFkQU9tbnRWSkpydEhZcFRaVVk2bUw3dEhta1BUQzMyZWdC?=
 =?utf-8?B?cXlZWmRtUDMvRERzSGxJZ0JZTXA3QlcrTFhnUkN5QTlZSDNxVzFFb1g2WlVy?=
 =?utf-8?B?S3FhZnlDclAyMWx1Y1ExK1JUeE52Mk5RcmpxMElnTm9YZVVFRzVodUE4VHNU?=
 =?utf-8?B?ZE5LamdsWkh2K2k3dVYrUFlyTDBiL0NxRDBWcWEzVmFmQUxYOGxMa3AvK3VB?=
 =?utf-8?B?OWFnS2l6VFNHWWE0ZFY0eThBc0JPRURNYzlJQ2lZLytvQ1FMRlpObWgwdVd0?=
 =?utf-8?B?TmhqU1RwbTcxdUZ3WTJtZzFob3loMjRCaGRHT01sZDB1aFN1MXFZRDdaY09O?=
 =?utf-8?B?MTY0TlB6cEQ5d3dHU2UySXA4V0k3aWQvSHBhVHlmUmF1R0hwemZha3Y1d1Uz?=
 =?utf-8?B?OURiaDFYWmNUMjdWbytJdmpFQ2hMeldTZGYzRGd4SVBZNmFFV1c2QzRLZ0dR?=
 =?utf-8?B?RmpaUi9jSkpieWRJd1hMZEFBaDlSMnd6eFNRZTdCMFVQbzRWYVUvb0dZZnRt?=
 =?utf-8?B?aDNFb3U5RktBaGp0aDBwT0M1VHZJZWYrdXBIQ2tTSkRMdzlSVjJOSDh6dksr?=
 =?utf-8?B?NC9JV000MXFxUjNMN0tjL0ZOeEZBdE1tMU14UHBIbzJ3aEtLRDlmcFNNTEV5?=
 =?utf-8?B?Qy91VjJlVEh3MHVkNGloYzhmVk5RYTVsY0hNNDJ4eGRMRXkvUXQ2dk1ZSlZ1?=
 =?utf-8?B?WWJtUXdWNVRManNLVGlTdDlnejhwemNhbE1uRTBVTWk3b0ppcWhKV2daOFo1?=
 =?utf-8?B?ZWtiZTNWTU0vVGduWkJOK1ZZcTBMYkNGeEdncjNIYy94a3pTaGxveW1EK1NW?=
 =?utf-8?B?YTJvN2NGY0MxcUIyRDBEWnpKbElNK2YzcDBEcys2Nmo1VGhPdHFjcnBkK21F?=
 =?utf-8?B?WlNhUDIwaWwvS3djQ05jNjgzU0pyRXNSMHJlYUZWZU03R1VCTGNISjJIRE9F?=
 =?utf-8?B?dlhqNGNsOENvbzF5TkdZbi9qNGxhTHorUUNrU1J4STVsQmVPU0FzREo1ZUx5?=
 =?utf-8?B?SEw1K3RkVmErQXU3N1dIR3l2SS95Sk9rSGI0blZqS1ZXQ1RYN1RCUnU4ckJt?=
 =?utf-8?B?UEpET2hRcjV6ajRndTZWcTRuRDNtNzdoMVdiTDB6SnUxU21QTVlOcnpoYWgr?=
 =?utf-8?B?T3dlMGdLYWlmNnhTTDRBQ0luMDhBaWRCaWlCaXppZ0gwSzBPQnhCNHk1cGsx?=
 =?utf-8?B?MUdBTDVCN3JkM3NTZElRVEU1dW01Z3BYK1ZaUjZNNUxhWXBvWGlZL2dyVzJP?=
 =?utf-8?B?UDJWSTA3OHZhRWNNRnFGSjA0QnY5SlNybi9LSHRKTFV4YWl0YmpDYjRXbUFE?=
 =?utf-8?B?T0RTb2YyZUxQRDIzMTRMM3FPT2xvY3AzOXpoaWE0Tzd1My9xcjRMb2w2WXFU?=
 =?utf-8?Q?E7OAifBhjvpUyOsk0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3816f9ef-868e-4f6e-62de-08df290f887c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:51:20.2997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HM2hbknwuHr+zjHsgUJtahOuiuu1/PnkUL6sapLssNgYMJAEjujKaf+advaPwPmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

On 10/13/26 10:49, Sunil Khatri wrote:
> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
> userqueue never got its VMID's page table programmed. Add
> amdgpu_vm_spm_update() to bind the fixed SPM VMID's page-table-base to
> the reserving VM's root PD when that VM holds the reservation; it is a
> no-op for every other VM. It is called right after a successful
> AMDGPU_VM_OP_RESERVE_VMID (amdgpu_vm_ioctl()) and from
> amdgpu_userq_vm_validate_and_restore_queue(), the two paths that can
> actually change the binding. amdgpu_vmid_free_reserved() unbinds it
> directly to a dummy address under the same lock that clears the
> reservation, so stray SPM accesses fault instead of racing a new
> reservation's binding.
> 
> Both binds go through the new amdgpu_gmc_bind_vmid() helper, which
> pairs setup_vm_pt_regs() with the matching TLB flush for a VMID bound
> outside the normal per-job VM flush path.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 24 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  7 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 43 +++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
>  6 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 5d4276cd0f7d3..4204c3c750a8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -787,6 +787,30 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
>  }
>  
> +/**
> + * amdgpu_gmc_bind_vmid - bind a VMID's page table base and flush its TLB
> + *
> + * @adev: amdgpu device pointer
> + * @vmhub: vmhub the VMID belongs to
> + * @vmid: VMID to bind
> + * @pd_addr: new page directory address, 0 to unbind to a faulting address
> + *
> + * For VMIDs that are bound directly to a VM's page table outside the
> + * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
> + */
> +void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
> +			  unsigned int vmid, uint64_t pd_addr)
> +{
> +	bool is_mmhub = AMDGPU_IS_MMHUB0(vmhub) || AMDGPU_IS_MMHUB1(vmhub);
> +
> +	if (is_mmhub)
> +		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
> +	else
> +		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
> +
> +	amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, TLB_FLUSH_LEGACY);
> +}
> +
>  static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, u16 pasid,
>  					u32 flush_type, bool all_hub,
>  					u32 inst)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 76e6f1f96913c..d17055d4c50a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -444,6 +444,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
>  int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>  void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  			      uint32_t vmhub, uint32_t flush_type);
> +void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
> +			  unsigned int vmid, uint64_t pd_addr);
>  int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
>  				   u32 flush_type, bool all_hub, u32 inst);
>  int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 992f7cb3a3102..8e60e5fdd210d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -581,6 +581,10 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (vm->reserved_vmid[vmhub]) {
>  		vm->reserved_vmid[vmhub] = NULL;
>  		id_mgr->reserved_vmid = false;
> +
> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
> +			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
> +					     adev->vm_manager.spm_vmid, 0);

Yeah that will break the uAPI and is not something we can do. The problem is that we need to wait for the VM to be idle.

Is the VM locked when that is called? If yes we can just wait for it to be idle before calling this.

>  	}
>  	mutex_unlock(&id_mgr->lock);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e29823ae8672e..d45357e092bb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1075,6 +1075,13 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  		if (unlikely(ret))
>  			goto unlock_all;
>  
> +		/*
> +		 * Userqueues never go through amdgpu_vm_flush(), so this is
> +		 * the only place that can rebind the SPM VMID's page table
> +		 * for a userqueue-held reservation.
> +		 */
> +		amdgpu_vm_spm_update(adev, vm);
> +
>  		/* This locks and validates the remaining evicted BOs */
>  		ret = amdgpu_userq_bo_validate(adev, &exec, vm);
>  		drm_exec_retry_on_contention(&exec);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index de992405ed718..05358e7d81cb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -568,6 +568,39 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	return result;
>  }
>  
> +/**
> + * amdgpu_vm_spm_update - bind the SPM VMID's page table base to @vm
> + *
> + * @adev: amdgpu device pointer
> + * @vm: vm to check against the SPM reservation
> + *
> + * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
> + * register must track whichever VM currently holds the reservation instead
> + * of being set per-job like a normal VMID. Bind it to @vm's real root PD
> + * address if @vm holds the reservation; otherwise do nothing, since @vm is
> + * not the one that could legitimately change the current binding.
> + */
> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +{
> +	struct amdgpu_kq_vmid_mgr *id_mgr =
> +		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
> +	uint64_t pd_addr;
> +
> +	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
> +		return;
> +
> +	mutex_lock(&id_mgr->lock);
> +	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
> +	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !vm->root.bo) {

Drop checking vm->root.bo, that makes no sense.

Rather call amdgpu_vm_ready() to check if the VM is actually useable.

> +		mutex_unlock(&id_mgr->lock);
> +		return;
> +	}
> +
> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);

This will probably cause lockdep to warn that the VM isn't locked, but I'm not 100% sure.

Please double check if the VM is locked here.

Regards,
Christian.

> +	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
> +	mutex_unlock(&id_mgr->lock);
> +}
> +
>  /**
>   * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>   *
> @@ -2958,9 +2991,15 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		return -EINVAL;
>  
>  	switch (args->in.op) {
> -	case AMDGPU_VM_OP_RESERVE_VMID:
> +	case AMDGPU_VM_OP_RESERVE_VMID: {
> +		int r;
> +
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> +		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> +		if (!r)
> +			amdgpu_vm_spm_update(adev, vm);
> +		return r;
> +	}
>  	case AMDGPU_VM_OP_UNRESERVE_VMID:
>  		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index b8aa45db1d844..2a2a2ccbaa2cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -443,6 +443,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
>  			      unsigned int num_fences);
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>  uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		       struct ww_acquire_ctx *ticket,
>  		       int (*callback)(void *p, struct amdgpu_bo *bo),

