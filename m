Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE7606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AQx/PXfd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2448710E785;
	Thu, 29 Oct 2026 07:17:51 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E41810FFA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 07:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwVKxiRORMy+LvyuDvvpnwQ/cMVy3lFUvVtkxTpV5E3GZBD1nSBxxWmB7V0DFxi2e4+6fRfWIew2bCR181pnX2q3dTR6y+BHOr3Yj/rGGXFz/b7kwrQI1FsJeogzJ1UyxhipZ8zkgUSp+zTtQkbBUowJBuux2UExQzYBA9Vh1ZJ+4zqRNh9ZEakwUNN5jCZw7WFDkNsVc4HxBKze6HYPHrGZ9zOEGyCChBaQoY3ciyWdjZUBIUkLjszNpx6l4/wsjLBBP5KU9EATiSDruweepZdUgaj0q6spa+v5udx2ETLDqhJ1Q61VjpRhupiQk83mVTMeWu6Oykj7T5Qa2XrdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3r+HC0Ao1m2rHt6cmf++yQBXke8OlftY8b+s+rBUBA=;
 b=PleJh1JcDIJLMUurW/a6l9F5Uht1nF/Mff1i9WJAmvDYH4SSd207Kb5NsmZjEpAOdHK3z9tpA01eBEEYtFkvLeWnCinN2HNIJtmZSXivoOnjhAmQYTQEeU4TxQ0HHd10N7kr6jxkeUPgeps/6XiT1achxDYPi9JeGexkWM8PZVLm+uDTEpJNkfEtfJ7MPMFw0OnqH3OuHFuScF7kCtVQuK2R22QDaFR5tc5ZjnvKe703KI4CR9GoJ1d7Hg8M7MvUUdYu0ZTOd9G8ugbz3dGURz6J+D3K1/UdTYweN27AunuLV9GH+/OMSgmpaZVrojdebwDhE/4oF9DQnR5mesYCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3r+HC0Ao1m2rHt6cmf++yQBXke8OlftY8b+s+rBUBA=;
 b=AQx/PXfdCwBKlBOK4LCA8xXC71npSwsSbT0uJReyqO4R1THgRXiSdj6KtFiL6yH7zmiMMq4sjt8tX42jC3QU1y8K4TsfiaYi52bhYhnTlPq/C4dZQMtMKcrRGYHFz6U8oedeXHivWgY7NC1+udZ5mK4VADzsc3S5i21xhmEfeNU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA6PR12MB999200.namprd12.prod.outlook.com (2603:10b6:806:450::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:17:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:17:41 +0000
Message-ID: <81952163-1c79-4eed-babe-5b48656b5ff9@amd.com>
Date: Thu, 29 Oct 2026 12:47:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: program the SPM VMID for jobs on the
 reserved VMID again
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20261029070403.22012-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261029070403.22012-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0062.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA6PR12MB999200:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfafb98-f0e4-4663-8160-08df358cb837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|11063799006|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|10067099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: iCZq3p/BaxL7Mgex2ioW+9AwJPQzrKBUo89Lwk32trjwY+vy03wckFCOhEMF4oKFez1KJ/PV5lYaLOOuCC1biJNLkebHLy6cPSUQJHCtyNloAnA9V7Ixz6N6LK48jtUufyrXaxBkS0au5uZZaHaaA+f6oPt1A5reGhJHEQs5mM5eLWNzGGz0aHnILMsZ++YcceMHpLL1o5wCSgkVAMPNKUYU36PQn+0U0wToDfCdi0DweN+6gIPV4XFYhGn9GcKmLJEi3P1hIUb4iGle+Hl/xdHS18dOKJ2BN0D73ILjcQVwkYg/ZQxrRrAWLcHH8cxRO68TlQCK/CxNrfg53prETCnNjvZjDed8dsOV3v7aAPijg+npfm10KKJx4JKqg/bk7003WyOA/N0g0yCqen6zF7ENCW9JGy1X5iagkv5Twfm2VBxTwP9eZswoZV3eMhM+N9Fec5X07fGGXqKpqhQwxQkAum8Y+MsytH/6rqN2bh8FKxAhCk3OALUuzC7Y4Wcdev9LjFbKyJqW8ZqlKXmDfQBHybhQgyawfiKmd6F9cOS3HBODGTEnj9hHzCsHWh9uJzA0cbD0W1p/bul1bdq7S2mksZO3yqzQ/JLLqmPSKO6yj4/rvUfjbWydRcSPKu6kqL21I15avHppY7C+gM1ScrZ4p2gzyHPFqfO86F7+UlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZHbkpnZGF5U1ZiUWpXSFh5SUpRTjlXaUxObjlFZVZNd1o1ODdKUitMcWdt?=
 =?utf-8?B?OE9CbmIzMjdmQ0xDVmhIcFlqblVqdU11enBxZmZqWXFtbmFXUXFGakxyM21x?=
 =?utf-8?B?M3BZZm5DYkx3cDdkSnpyNEtwd0M4ZnFURThzd2NYVFF5N2psWFRZQmZYK2VC?=
 =?utf-8?B?b2E1ZHg1V25GOUZoWEZSeWU5QkhvakhiQ0RhbmhSa0xvd2tId052cThocHVa?=
 =?utf-8?B?MjRDeWpkd0VGZHJ3aW90Wmk4TE1zSk1UN3RKTnNMTXUyY3FlWHlSYnlIenc5?=
 =?utf-8?B?dTZYZU4xUGZ0SmR4UkR1dkROa0tUd0J2blRTR0JnWEZhd2szOE1rcEY4VEJq?=
 =?utf-8?B?WjM2RFdkNXVoN3EvZWNrSEF0SncrRHkzWlI0Sm1HLzRnb0NkWUV1VVI0Vnk3?=
 =?utf-8?B?YnFlQ1BZT3dkcUhNMGtwM2dBZW1LUU1WVGtVbmVSbzN5ZlBjWnBDYmxQNUk5?=
 =?utf-8?B?RFo0S2NxaU1yVmNJaFdGNGJmYmVYeHlJQVh2SmlsazR2WTRTcUl5RlBQTWpO?=
 =?utf-8?B?eU95M3UyWGthck5LRkl2OC9NOWJuWmYxdkYyWUZ4WGtpNVJDYXdTVVlaSVpW?=
 =?utf-8?B?Y1QvQUlES090TW03ZUZ4dlpsWEh3bGpJRjgzaGZ5TVlRRmtzR0JJTWZwNXhq?=
 =?utf-8?B?OWdUeUtRMUhEd2dUVFprMWQ2SkF1RGpGeFVTTE9MamgvYkU3R0hoZFZPQmc0?=
 =?utf-8?B?ZUxtR0s5RlM4ZGRmZjJPSnhXTitEZFlrcUFHaTNnTVMwTlRnQUlDVVhDbnRQ?=
 =?utf-8?B?aWRwOENuTDZyY3cxbi9mZWRGVlYxWXRjR3U2TklxbUZMTGFPb25hbGp1bnNF?=
 =?utf-8?B?MkFqakQ4V3ZvYUpGakJKWE9oMHI1emRrVkFhTUQ2OHpGMlpOM0NFLzh0Z25U?=
 =?utf-8?B?RzZGcXRqVURnNzJ6ZEtSOGF4enR6YmY5aVE4QUphT0NiOHo4Qnc5bGFEaDZH?=
 =?utf-8?B?YzAxMDRhRTFZdlhFSjEzanBhQWppME1UbE5jZG1yODhNUFB4ZEhYWFdmd3li?=
 =?utf-8?B?elZRa2Y5SE80c0kzdlhYSkZBbFQvZkdCakhsdnBNQllXZEtIQlRZaUxDWHBx?=
 =?utf-8?B?dW5abU51S2kwbnJ1eS91QzFhZ05sZkVIV2NTWnlucGg5Q1BQNy92VElMQmMv?=
 =?utf-8?B?ZmhXS1pjMXNwZWhSMDFsbEdlYlNIVm9vMXV6ZGE4ZG1oZEROK3RZbXZlTkxo?=
 =?utf-8?B?Z2ZBdFNVdVdkOTA2eHVoY1JPVEI4amNZVHg4d0xvcVhkeVNBWlpKcXAwMmJn?=
 =?utf-8?B?bTh5TTZvcklKei9NL1NXMHJ3YU1JR3ptRkdKVlM2WHJwT0x4OE00Q1BmaVVO?=
 =?utf-8?B?azFLRi9tNnFGWUo4MzBZQWRBRU5wUTd3UXdzbUM5dnk0RnRqZE9OYlM1YUlh?=
 =?utf-8?B?NUhETTNkM3BLb0taaHlZN01kK25hbkJWNXJBeGZvUXNJeGU4eWI0eDUxVk1i?=
 =?utf-8?B?ZHk3ekQ2K0RFTWNkZ3Q3K3VYODBUUUQzSnFoaGY5R0tvd0F1MnprQktvZ3lz?=
 =?utf-8?B?OGtkUFhzdTNKMmpuMkpQYXVCYXZNdEtwcWl6QzhCellhUlZMU0Rpb0ZHRCtD?=
 =?utf-8?B?ZEdZT2V0N0l4K2p1T0pIaysxWHZpbmZzRmNEVGZYd2tzb3BKYXNudDk4YjV3?=
 =?utf-8?B?TGdFWEpBakNRbncrTC9YYlZRd2tDLzZDMjVzVk1jZjhuMCt5RUNhTG5PREIz?=
 =?utf-8?B?MDFjeVpSczhqRnNBaUJIWHdMamFNQy92NFVBejR0R3dUSHJMMDlMODl4V3JB?=
 =?utf-8?B?azUrRjBDTDhGeU9HQnJZeVRhbEdwaXVhZENuTmtmcERuZmo1azRPWVdHL1hh?=
 =?utf-8?B?aDJQakdUU2JIellkbnB0VWRDdEQwRVBIUk1HUHZPQlUwcTVpenM2alFzL1Fs?=
 =?utf-8?B?dzJ0bTllSTMxSEhXem41QUdJZFNMTlYwWUUwNkIwZlJLcGJKL2xOaGJ2MkNa?=
 =?utf-8?B?WlJHTnVzNDJqSHdCeHZpN05iWURtUzB2UU44Zyt1Wi9FSjkxUHI5bGkwZzgx?=
 =?utf-8?B?cklwbzRFd3M1S1ZzS25EMjAzVGpJYVpabDNSck9LZlJzQUprRkZpbkF3akdv?=
 =?utf-8?B?SmpCZjJWWWpkc25SWUtyS01DbU1ObVRDejg0SUtrYzVTSWRZMU9vTk5IVEEr?=
 =?utf-8?B?YjNJK0VJNnVDb2pQMnVsaEFQQjh2eG4wQ0d5UXlJaGpDWVNJLzhLY29aRlVW?=
 =?utf-8?B?cVVRNlhSTzBlc1NCZUwrcDVhaDUxZlpVeHMrSGM1cU5UR0wyWjFnRkxmS1pQ?=
 =?utf-8?B?UXQ1a3ZGR3Y5ZUVLc25MaUdVYkJKQ1FOemZsV1dxcnVhaWxKYWpjdklyRjg5?=
 =?utf-8?Q?3o4k/iskX/u1vqwIAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfafb98-f0e4-4663-8160-08df358cb837
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:17:41.3674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyK8qVg19HvJiVbVaM8A4/ZTdMFS0cr+hr1oP9s/BU3+pZB2dVHMmYYDDgFhjWbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999200
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



On 29-Oct-26 12:33 PM, Jesse Zhang wrote:
> Commit 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM
> VMID update") dropped the RLC_SPM_VMID update on submission, as the SPM
> VMID is fixed and programmed once at init. RLC_SPM_MC_CNTL doesn't keep
> its value over GFXOFF though, the RLC brings it back as 0 when it powers
> GFX up again. So once the GPU idled, the job of a process which reserved
> the VMID for SPM runs with the SPM writing through VMID 0.
> 
> On navi48 RLC_SPM_MC_CNTL reads 0xf right after hw_init, 0 once GFXOFF
> was entered, and stays 0xf with GFXOFF disabled. A COPY_DATA of the
> register from the IB of a process with a reserved VMID gives 0 instead of
> the reserved VMID 15:
> 
>    $ umr -i 0 -go 0; umr -i 0 -r '*.*.regRLC_SPM_MC_CNTL'
>    gfx1201.regRLC_SPM_MC_CNTL => 0x00000000
>    $ amd_spm --run-subtest reserved-vmid-spm-vmid
>    RLC_SPM_MC_CNTL in the job: 0x00000000
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  8 +++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 ++-
>   5 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index f98a7c6797b3..ec0883df91b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -126,6 +126,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	struct amdgpu_fence *af;
>   	struct amdgpu_fence *vm_af;
>   	bool need_ctx_switch;
> +	bool emit_spm_needed = false;
>   	bool emit_gds_needed = false;
>   	uint64_t fence_ctx;
>   	uint32_t status = 0, alloc_size;
> @@ -194,7 +195,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   
>   	/* VM sequence */
>   	vm_af->ib_wptr = ring->wptr;
> -	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_gds_needed);
> +	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
> +			&emit_gds_needed);
>   	vm_af->ib_dw_size =
>   		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
>   
> @@ -209,6 +211,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (need_pipe_sync)
>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
> +	if (emit_spm_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +						     adev->vm_manager.spm_vmid);

ring->xcc_id is not filled for all rings. Hence, if you want to collect 
some cache perf counters when say sdma (part of GFX domain) job is 
running, this doesn't work.

I had posted a patch earlier for this, but I thought the refactor 
already took care of this

drm/amdgpu: Derive RLC SPM xcc from GFXHUB

Thanks,
Lijo

> +
>   	if (emit_gds_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   					    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9c879ac68352..124fb875c651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -434,6 +434,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>   		return r;
>   
>   	job->vm_needs_flush = needs_flush;
> +	job->spm_update_needed = true;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index f6577f82e6b9..ae569b4497f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -75,6 +75,7 @@ struct amdgpu_job {
>   	uint32_t                preemption_status;
>   	bool                    vm_needs_flush;
>   	bool			gds_switch_needed;
> +	bool			spm_update_needed;
>   	uint64_t		vm_pd_addr;
>   	unsigned		vmid;
>   	unsigned		pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 000c982816a7..7a8e363449a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -809,12 +809,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>    * @ring: ring to use for flush
>    * @job:  related job
>    * @need_pipe_sync: is pipe sync needed
> + * @emit_spm_needed: does the caller need to emit spm
>    * @emit_gds_needed: does the caller need to emit gds
>    *
>    * Emit a VM flush when it is necessary.
>    */
>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool *need_pipe_sync, bool *emit_gds_needed)
> +		     bool *need_pipe_sync, bool *emit_spm_needed,
> +		     bool *emit_gds_needed)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_isolation *isolation =
> @@ -823,6 +825,8 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> +	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
> +		job->spm_update_needed;
>   	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>   		job->gds_switch_needed;
>   	bool vm_flush_needed = job->vm_needs_flush;
> @@ -845,6 +849,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	mutex_unlock(&id_mgr->lock);
>   
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> +	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
> @@ -858,6 +863,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	emit_fence = vm_flush_needed || pasid_mapping_needed ||
>   		cleaner_shader_needed;
>   
> +	*emit_spm_needed = spm_update_needed;
> +	if (spm_update_needed && emit_fence)
> +		*emit_spm_needed = false;
> +
>   	*emit_gds_needed = gds_switch_needed;
>   	if (gds_switch_needed && emit_fence)
>   		*emit_gds_needed = false;
> @@ -897,6 +906,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (pasid_mapping_needed)
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
> +	if (spm_update_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +						     adev->vm_manager.spm_vmid);
> +
>   	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   						    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 06e0ddd60c7b..973ad7576d9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -449,7 +449,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool *need_pipe_sync, bool *emit_gds_needed);
> +		     bool *need_pipe_sync, bool *emit_spm_needed,
> +		     bool *emit_gds_needed);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,

