Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1C606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rj4Qi+/2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8489E112385;
	Thu, 29 Oct 2026 15:05:02 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBB5112385
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0lwJBf0a3lOOFTLcaatwETYOlHgB2K9x3GL43faBMlc4Oa39eY+jgNU0kFJDTgEKKbRvNtYw0bLhct34PtYDjr9UG3DYc87ukQj9LeoCuFzEcWl6OPPTHXEuZoVpfJ/TkK8abASXuT4dDbIOImDMpPXYU1SimjTf17h+ECPuiWZwr/kdmwsgClchBP0NEZUEYa0G3WQO5TrEO2dsc19ZaSLQtvEGxlvUJpmmhjC/JpoLBT5GEpOSoyg1pD6ue0xUYv9bh4oGLxcOIBHYkgAhC6FFWyQzatYbUx0voizdnt5TOlIIOrPje86X2qnDbkei+VAIXY5edmuEBb26qKE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHviPCbQqDeWRlqhDhe1+yKa4PeHp5K5SYr8A8jsX1o=;
 b=QsjsanDL4AOblwvFWi34WRff0j/loJLjOCCppdz3kFRQbr50h2S7DLrwHb3AeV1mnoVHvBhHrcazyBHEYmJGu6xvm+KuPcEGdtxF4vMdwkEnCEFOLk3vcM43pCzYIK+RpTXkQBCQVerHH85wpxmYgi9f4klmqHwBc1D0Zklm0sN/rvrRvApNVS2+3tWHDJ5qvQmaK1ldiHgM+U/FjDA43h8/XPKMROvAozxpeIIpVC0QSZ1w5kuOPOONDiBKrNmr8dcNpGrOSkjEy0lqZTa4tJoE+7Z0UTHiTJgTlm2E80FIAMu6Ua0wzxFp8xPsMtPyRl2gIbc4QBjEy8qbcd0r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHviPCbQqDeWRlqhDhe1+yKa4PeHp5K5SYr8A8jsX1o=;
 b=rj4Qi+/2Q9R5LVKjZKzESHfEm16mcrJVNytLbXn4sU2zeUhfaA8sr57DqeSQS2OXLJAXzInO60XWSyNhRzCjlSw5U3V5b6LA1d5NJvmpDHvk3NHUBlWItfAZ8HcgITcWrNfc+p2M2Fc8XDW3KqWTEUxKbgdi5eThpCUDWneC+Ik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 15:04:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 15:04:47 +0000
Message-ID: <0881dbca-445c-4439-bb7f-15882ca36d15@amd.com>
Date: Thu, 29 Oct 2026 16:04:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: program the SPM VMID for jobs on the
 reserved VMID again
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261029070403.22012-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029070403.22012-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 121296ee-aabe-47e5-f31a-08df35cdf924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|261028144727099003|10067099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: so0NQaxt+B+oROnlOVJl6fI/SpQY5iR85d3PdBIPHiOtH/GKqRz4mNkOxZ1EBhlhR4tK3fPKp0IuLjAtO4gXdA27cRi3eHSLqp7f5MP8iGb16s9ZBuwyXtn8UjMednrFy32YrMM/4F0qFmknxRX5VqjR0rMq7l5gvBn5za88VJsRRqcIXXUspE/PxIS7Sts5eWiMsIrwksu0bLaauyRZrgFiZ5dpWoETbzn4uYjN3zc8zqaNcc8NnXZpRJbU94VaYyotrZa3HMvim9ph6n3x4SDRA69g7lHp4rI7kHRexIaAok7Vps+NK5bJABWucNx9bPzHgtW6ke8/5U2CJUg/eofhD8U+fdLbzZusyYO2jCC6osVecjoaIfsnS08Wy9bFOtKkjU69JqpcW2JShQ2bbtbAVIXHnqQHfuCP+85AiRT+ejBHiccjNJaaAT1e5hWNR+jPbZdT/Wu3MRcLvemrb0QL8fWJLOVy/p83sICnCzc3Rtybvv3Q/+ktUd8xjXe3EqSri0S5IBLSc+RjufYKcNEE53mnoXayYN8+PoJvsBjKPCg5zCf2w8WqH5ynO+T0slA/XnU5c5eGil2xWAqk2qIkpwtmbIwPIpndrU8JpIbFhLFla1AOCLhUXYtYDXRj9r78s3S3+U8yvZ2MAVp/yd/Gswobieu5m0ustjAHr2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(10067099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRFKysrN2p1UGt1ZjBzNFI1V1dJK0FNRHFNMXJ0YzhNV3pCN3J1S285azht?=
 =?utf-8?B?aWVoUURlS3h3OXRtM2tyaDd6ZzloZVUwMTlnWFNNRUJCeEpqZ2tlMGtKdlFQ?=
 =?utf-8?B?dDFHM2NaQm1FUVRGMVpjUVNhUW9Jalg0WmVVWU00cnRMZjdLNTlxRVUwYnV1?=
 =?utf-8?B?SmZwdm5EZzVGYUVnS09OWmZyMG9PbGdLdkI3bTFjWm9za2xVSjc3SFQrcFlT?=
 =?utf-8?B?Sm9zbnR2TjNCeVN1QjRmTzAxWXBzUW45dzhNZzlUbE9ScFU3MjEvQTBzUXow?=
 =?utf-8?B?NXkrWWRmanNkWnZwVVRwRGM3L29iTEd6QndxZmdsZWM3SDhrN1Fpa055SEJr?=
 =?utf-8?B?VmY1Qi9ORzJFOWYxbzdDK3FvcVgwSnJGNHpwaFVBNDcrUTFlOWw0ZjNUSkg5?=
 =?utf-8?B?ZGZMMjBheDRTZzJtaXpGNi9TSFM3NVNjWEZBVjBaSmRuczhQZTNDT0c3WGRW?=
 =?utf-8?B?bXo4bHE5cUxKT2tjTStHeGhwN1BzQVRpTUJpeTJzWTY3SmxUTDlSSkt4MkZy?=
 =?utf-8?B?VmZ1d0wrMEZaOFZMK21MS01wK1hXd2Vkck5xOHp3T3Z3YzdaaDIxSTVzQUV0?=
 =?utf-8?B?NUtpWStCM1UyazBORElNN2xBTitCMyszVkw2K0dzMmU2czlBWERyZW5LTFBo?=
 =?utf-8?B?RDRGNDZRMnRpdzgveWY3ZVpXRjRCL2wwdnJEbUtXSDFWbzdtTnZKK25lcGUw?=
 =?utf-8?B?am5mY0VCWGhVQWpZV2RtWkllU2pvS3lheUtxWUhXSzR6bG1WMjVBYUFBeDl6?=
 =?utf-8?B?dUY4ODQxb2U5a3FQYlRsVklqbzBwQUprZE4xejlaV0d4TjVDS3YvS05HTFF3?=
 =?utf-8?B?eXJRZERGbGhqQnRWdVd6OEVGcGxSMUVLY0tORXh5c1kybjNhU2ZLT1Q1dDE2?=
 =?utf-8?B?RGNlVTljWmNwMW9nMEVSRVdDWTNUSWE3ZGY0aU02UlNlSHJNSWlBcEZjM285?=
 =?utf-8?B?M1l0RkJoUlNyMlUrbUdxenBtd0JrNGhzZzhCU2h3Q093em5xSDFlakRncUhT?=
 =?utf-8?B?Uzg1K2RsWTArWXFSQlJUZHlzYkxBV1lFdmtJWGNqS3VpREpTM0NzR3NqUFR6?=
 =?utf-8?B?NGYvZUtaMjZ3eHd2OG9jK3I0UTdYdWE1VEZWSEdnT2hiV3o4ZHlQaFhCSXBQ?=
 =?utf-8?B?T0lSTW5LYUtwWUNvanRLYXlRNWFlN3dpSTJnS1dnRlFoQ0FGQTllMmdUUkRh?=
 =?utf-8?B?UitGc01TbEltQ1ppK0QyMUVmazdIeXE5VzdJUStVd3NORlkwRkRJMXpQc3Uz?=
 =?utf-8?B?a3Vna2tBSllJaFhmZ295M0Qzb2FHTnloTnF0UDY1T2VveVE4TmRJTHFQYkMv?=
 =?utf-8?B?MmtkYmd1bGFKTE5MMEgrMnVmK1U2akkvTnBsVXVrOE83MGMyQlk3Rk4vSDBi?=
 =?utf-8?B?bzZKOEF5aFRUZFh6cHNpOHhEMmd6bkt4VGN1SG5QalNWTWR0Q013Tk9CNlB4?=
 =?utf-8?B?ZXl0V1NreGp1dFhkR1RNSXR3YnJ5NHFnc3ZZZlVaRUpTV3ppSDFEZjVJNGZF?=
 =?utf-8?B?c1lIYzFubEw3WXUxdHdvK3ZTbFRsdlFCMlBlRG1HTmgrVGk2Y1FhMlByWW10?=
 =?utf-8?B?TVM2UCsrSUJ4NmpiTzB0T2gyNlpKMnpJZkxIWENoM3RJYnozRk9EY3F6NWc2?=
 =?utf-8?B?QnYrOUxVYkw2bURVVlBiUkVnSk1sdDBUd2NxTWNrak50T25UR1ZOTFRVbllI?=
 =?utf-8?B?NDYrb05hcVhzTUt2SnpnYXJ0b2RGWkNLWXZNVjZnMTdCZGtpcTYwNHJuQlB4?=
 =?utf-8?B?R1h4djBiRHZGOFZ5T3BhdUFoTFZyOUhxaVFHUFdZMkhMSTY5SU8xbHE3UlFh?=
 =?utf-8?B?Z0lOZjI3dS9NYzFFWW1mK09mV0kxd2I3VXBGN0cxMGZYQmpjcnV4Q21lcFNX?=
 =?utf-8?B?K1A5bEs4TzljaHNKbTdHZ1h4aXN4Y2l4WkdrRDZxdTJjYkd1Y3ZvVHpYb0dL?=
 =?utf-8?B?V3ZGZjByMkZlTFdDM1hUUERscGFNUFlGR3NtVmF0TTcrRkVvQXpsc0xZczNI?=
 =?utf-8?B?bVZUeU9weHFnSWVQQ3VNbFVwemNTRjIyYnNWcW11SFNtRnBSd29oU0NHVitY?=
 =?utf-8?B?NkdJMlU5aDZHUWp4MDVOV3Y0Z0F5dk9TOVUwT1BMODZqSUV4dFNKU3hXd3Iy?=
 =?utf-8?B?M3RrdmtuT3dlWEt4UzdxME1Nd285VEd1TjEycEM0OE1KNXUvV3UxdGp1MTcy?=
 =?utf-8?B?eThRckJ1bU5ER1hhZFZnb3hsVWkraE1NQXUxVUdjVWwxYkFMUmxlNHlqYU4r?=
 =?utf-8?B?ZE5qWG85OHAwNytMV3ZjNkVQU0dQWDdvYWJacnBiejFCWUdWWFpIaDRYaU1w?=
 =?utf-8?Q?OqT4ViONHMAndxS/AO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121296ee-aabe-47e5-f31a-08df35cdf924
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:04:47.6652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtjbJnYQiPl3QcSO3r7+4Ns6KvRXkp42sz6mVcJkMnOpNdRyL7rVJxT3vhhxUidk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 08:03, Jesse Zhang wrote:
> Commit 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM
> VMID update") dropped the RLC_SPM_VMID update on submission, as the SPM
> VMID is fixed and programmed once at init. RLC_SPM_MC_CNTL doesn't keep
> its value over GFXOFF though, the RLC brings it back as 0 when it powers
> GFX up again. So once the GPU idled, the job of a process which reserved
> the VMID for SPM runs with the SPM writing through VMID 0.

That sounds like a pretty clear bug in the RLC handling to me.

@Alex do you know where the save/restore register list can be found?

This here is not really an option since we want to completely nuke the update_spm_vmid() function.

Regards,
Christian.

> 
> On navi48 RLC_SPM_MC_CNTL reads 0xf right after hw_init, 0 once GFXOFF
> was entered, and stays 0xf with GFXOFF disabled. A COPY_DATA of the
> register from the IB of a process with a reserved VMID gives 0 instead of
> the reserved VMID 15:
> 
>   $ umr -i 0 -go 0; umr -i 0 -r '*.*.regRLC_SPM_MC_CNTL'
>   gfx1201.regRLC_SPM_MC_CNTL => 0x00000000
>   $ amd_spm --run-subtest reserved-vmid-spm-vmid
>   RLC_SPM_MC_CNTL in the job: 0x00000000
> 
> Update it on submission again, but only for the jobs on the reserved VMID
> and with the fixed SPM VMID. Unlike before that commit, a GPU reset must
> not force the update for every job: RLC_SPM_MC_CNTL is shared, and a job
> of another VM would retarget the SPM of the profiled process to its own
> VMID. The reserved path requests the update on every submission anyway.
> With that it's back to 15 inside the job.
> 
> Fixes: 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  8 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 15 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 ++-
>  5 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index f98a7c6797b3..ec0883df91b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -126,6 +126,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	struct amdgpu_fence *af;
>  	struct amdgpu_fence *vm_af;
>  	bool need_ctx_switch;
> +	bool emit_spm_needed = false;
>  	bool emit_gds_needed = false;
>  	uint64_t fence_ctx;
>  	uint32_t status = 0, alloc_size;
> @@ -194,7 +195,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  
>  	/* VM sequence */
>  	vm_af->ib_wptr = ring->wptr;
> -	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_gds_needed);
> +	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
> +			&emit_gds_needed);
>  	vm_af->ib_dw_size =
>  		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
>  
> @@ -209,6 +211,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (need_pipe_sync)
>  		amdgpu_ring_emit_pipeline_sync(ring);
>  
> +	if (emit_spm_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +						     adev->vm_manager.spm_vmid);
> +
>  	if (emit_gds_needed)
>  		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>  					    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9c879ac68352..124fb875c651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -434,6 +434,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  		return r;
>  
>  	job->vm_needs_flush = needs_flush;
> +	job->spm_update_needed = true;
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index f6577f82e6b9..ae569b4497f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -75,6 +75,7 @@ struct amdgpu_job {
>  	uint32_t                preemption_status;
>  	bool                    vm_needs_flush;
>  	bool			gds_switch_needed;
> +	bool			spm_update_needed;
>  	uint64_t		vm_pd_addr;
>  	unsigned		vmid;
>  	unsigned		pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 000c982816a7..7a8e363449a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -809,12 +809,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   * @ring: ring to use for flush
>   * @job:  related job
>   * @need_pipe_sync: is pipe sync needed
> + * @emit_spm_needed: does the caller need to emit spm
>   * @emit_gds_needed: does the caller need to emit gds
>   *
>   * Emit a VM flush when it is necessary.
>   */
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool *need_pipe_sync, bool *emit_gds_needed)
> +		     bool *need_pipe_sync, bool *emit_spm_needed,
> +		     bool *emit_gds_needed)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_isolation *isolation =
> @@ -823,6 +825,8 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	unsigned vmhub = ring->vm_hub;
>  	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>  	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> +	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
> +		job->spm_update_needed;
>  	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>  		job->gds_switch_needed;
>  	bool vm_flush_needed = job->vm_needs_flush;
> @@ -845,6 +849,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	mutex_unlock(&id_mgr->lock);
>  
>  	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> +	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>  	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>  			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>  	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
> @@ -858,6 +863,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	emit_fence = vm_flush_needed || pasid_mapping_needed ||
>  		cleaner_shader_needed;
>  
> +	*emit_spm_needed = spm_update_needed;
> +	if (spm_update_needed && emit_fence)
> +		*emit_spm_needed = false;
> +
>  	*emit_gds_needed = gds_switch_needed;
>  	if (gds_switch_needed && emit_fence)
>  		*emit_gds_needed = false;
> @@ -897,6 +906,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (pasid_mapping_needed)
>  		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>  
> +	if (spm_update_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +						     adev->vm_manager.spm_vmid);
> +
>  	if (gds_switch_needed)
>  		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>  						    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 06e0ddd60c7b..973ad7576d9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -449,7 +449,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		       int (*callback)(void *p, struct amdgpu_bo *bo),
>  		       void *param);
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool *need_pipe_sync, bool *emit_gds_needed);
> +		     bool *need_pipe_sync, bool *emit_spm_needed,
> +		     bool *emit_gds_needed);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm, bool immediate);
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,

