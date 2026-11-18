Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483A606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BYr/3n9x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC19B10EACF;
	Wed, 18 Nov 2026 09:39:34 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF6C10E7A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 09:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/GdRJmFA5AOkIDPkbIEDVajbWRZuTCs/9gZdPF3i24K4hw4owXrFJWLRNdx3QXUYW+luXh+2vY2/bVp8mYee0CRPPtT4yApC4IxVaJqsUcOYKKfDDWJ5ygykoOfz3e6NDTAgXI9RigAstdTzEBeB+DIZaUNCGw673EO5EZBpZ+8vWL3Wiy3VTRnFNi23Qm1iUUpMlOVv0og2/lMlv4qfTCIlKj8Q88iO/wfQcAzm1MPmUGp1nQb+d1ugs7wO8mpAed8A6xE/0jwnKzeFdc3PEHgX6Cn1f4mtPXgjs+9xxTF7ZUq6RqcqDl01BHmUidQSPTrFr/LSU62eLN2AUzwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X3uz/WZNAeExqK6uUZUuO6WkPJ4nt2GCqjkFd7TcF0=;
 b=w5m4dMo6tTuboz381picVS5NPWS42IY/vZSwjccZUKr2GTqrc2Ke+XKv9E1wWzVfZjAX6y1OfQ0z0l6j1prK7frFx0dc/wwEAo//QZnTk1yKi8RyN0zEuk6RqdHZXSe2uvAJ8WMXsW09/S3ya4SAQ0P00MSb6B08qcCr2ACJjSR4gADTuuCnFHILAZ7pqU5xzPym240NSXF98cxqr4dyqFBr3QSrErZEfALFq5UcpLYKTtJJF2hZYStNYLjNLvH7qwJ9GgRuzolkININPDvqFWQpqim/bDlZgxyO0cLuyx/CgyipSH5yIgO4wkflK39K/U5Rggd09h3JUgDNwqzRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X3uz/WZNAeExqK6uUZUuO6WkPJ4nt2GCqjkFd7TcF0=;
 b=BYr/3n9xZDrzP0WffwF8d7bA5+rotwecOsSDc4uRV5cWP45uu4o2aXXDN7DjT4qEDjDnrQGcL8zDF5eDbPyIZk1ej+rXqrhbcg5a+PtIkECUuM2Kw+cIq67hWo7yZXxHPda0CuxBoatqDndz5jKYm6s+8T1099+T6FLzqQ01w7A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 09:38:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 09:38:59 +0000
Message-ID: <99e70db8-7e25-4241-8b71-f3dfa41cfa4f@amd.com>
Date: Wed, 18 Nov 2026 10:38:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: reserve and bind the SPM VMID on
 every GFXHUB instance
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117165952.3558762-3-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117165952.3558762-3-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6da747-5a43-4d97-595b-08df4557c605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|261009223027099003|11063799006|4143699003|56012099006|5023799004|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZPoYE/0Gmol55Fz3Xio2HvOAFY4X8pX8gBAm4YJgMO8x91Xg4lOv0R6gnTU/3NB2xVfBUWNjvMB1inMTcpzfxkeTEx8Qoc/Px1HLD4i5ODzH5/6hsQPhF+ZKo9cWv9hQo/YvCC4apJjbjVUPnZ1aHE1/5Kvzj9nXI6cN6WGABs6Qrn1581+r0LqkzLJMvPJPC0fXoJdGOUkVKLfGWvwtg3FydSk9vZfuEWB79W+cdSIFHuZGKZH86ED2BrKmWAA6qK3kZcJfRXe9YOnVuA1wzvvDW+/1yDMm0th3x7gzoqXB2SyRbpojxgSM+w0dbTj7JaeVPl7yrfuDPXzqmVu/649BFOgnbwZg4+HV9NWIvOJFNYzD4IZz7qoTH42AbgId7Sc4FkyPN4ndRwGoYfd2DHaNgTuKIROiKoaSCauJZ6XcEhMEEXAwBWXNKYGeZoG1LceG4hyxs+tcH+o1Hkw3OETOCBM2sWz238ahQeMaLYNYlgsA7hlfjHVRCMsBiW1/C4vNmtJmODfxpyRBUyHEJbB5MAyFyEfKS8NhoZLZD0P2VRfYaSYnVVmy8o9t0+g9zMNyOIY19g81j46POnDSJ1uSuyaA8/58s5xEo16YlM4AW/7A8UVGo3jJNiX+AUKs3s67yF7DenuoLqWfoaTmAiwSHwp75nVdQa9TAbUuW3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(5023799004)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk42SnQ1NUgvU3hOTjFsZnpWazVxWTd4c2hVYnBTbk4ycnVnTC8xK3dadW4y?=
 =?utf-8?B?bnkvYjZyYjR5V0ZwUVlVTlhLd0E1dWVNV21jQkJWMng5di85TXR2YWlMRTRp?=
 =?utf-8?B?MHhHWWlJYy95aWNJSjFNeHFIWnZVN1kvMFM2bHV6WEtPUzVJRVJqeENzM2NK?=
 =?utf-8?B?bXZMS1AyVkNwdXZHMEF5elh3S25jTC8zbENvN3p3Q3pZRnRjQ0gyZ21UeTh2?=
 =?utf-8?B?VWVDcnlBUzBNT3J6VC85RkNZaFBCb3VFMjNERGRZbTc3U3V2UXlZNHEraFZa?=
 =?utf-8?B?YTE5MU5jd3VPNlVxZmkrYmVjVW5ZQnhkRUtCbld4QVpOL0JRS3pnSUlibEhL?=
 =?utf-8?B?WlIyVzAvMnhpTG5yQnRiV3c2WDMyNjdJNTRxNThjdkpjdXJEcXV3YkVjNUt6?=
 =?utf-8?B?S29oQUo0TXg4ZCtMbjJKU2NXWFlJUkFJRkV5Uy94ZFdESDZrQlhmK1lrdHl4?=
 =?utf-8?B?V2JxUGVaM045TmhMMFV2b2hlUElzL2xZa0MwakZGYWpiWThwUjJ0U2lpUUFS?=
 =?utf-8?B?emYrY1RFdUxiMkl1ZGxQMHdGdnFHRnROVEg5cnF3R0JEMnY0ZGFzQWFzcUxD?=
 =?utf-8?B?QmIwV0F5bHA0VE1jK2lZdE9GMDIraW40KzJjRzFOU21TUG0xckhZTFBXTElp?=
 =?utf-8?B?SENGUjJ0MzRZV0NBY1VZUm1HaDVMbGlhV0xURS8wQTJqVGdsY24xSUwrOUlw?=
 =?utf-8?B?eUdtOUNQYWJ1T3h1cXJMelVBN3dUbGJkd3lTajZvWkJ3RERUdmdXcTYyMkxV?=
 =?utf-8?B?ZTg2NEhaQUMwdXRMVlZudWN3OUFxTWFSNXdQdWFuOW1CZW5WUFpLL2pnYmU2?=
 =?utf-8?B?VTQxV1RjZGxNWVFzRjZpMUM4NnZzOGxrUFM3VWJJMmkwQm8zZHhWbXhmQ1JE?=
 =?utf-8?B?akM0bFQyRnhjVVdXeUhTRjVXSVdHbjFvaW92TzdqRTliaUp1dEVhc2lCaWRV?=
 =?utf-8?B?clFGVDZaczZLSTJZMUxIdWpqMkNnbFFTUEQ4NFd3Z21ISlQ1T1lONWRqUEtr?=
 =?utf-8?B?d2lYK29RTjNZVTdFc09lRFhNWmZVWksvNk9YbHROaGxPeG5rRHN0OGFsV0ZB?=
 =?utf-8?B?NHUvSFZWTWJVaUdDcWMrVFR1MjlaM0ZPQkxaWXhDY0tQd1dWaEdPSFkvd0FI?=
 =?utf-8?B?UXNEclhiQkdMTC9LS3FMdGZHQ0R0cDRPTzdNOUo0ZjJETTVvUjhDVFB1MFhJ?=
 =?utf-8?B?OC85SzNBQ3p0RTFzcnZVREs1WEs4T3k0R2RZUGFUaEJSaldCM2hLWUpPYjdU?=
 =?utf-8?B?VnB2SU5kdjB2TkV5Wkp5S1REWUtodE43aUo4WXFIS00vTG14M3FwUzJHMG40?=
 =?utf-8?B?TU54Z2FlNXQ2TWlneTJuUHdyaHVOZTE2M1UzZy93MGFBT1BlRFhZWmFHMmlJ?=
 =?utf-8?B?ekZzczB6NHI1b0tKd21OYWw1eVJMRDN2SW9vOVhzV1lIVlFDQWd5VGk5d3Rs?=
 =?utf-8?B?ZDJiN0tnTkVnTGRraE9RQ0JYZkEwam1KeTQ2RmZTUHFPdzlnbUlJYUNPakFC?=
 =?utf-8?B?NmZWc0d3d0V1bm9obG9YNUMrNVI4ZHNrRDBrc3c1ODdKS2tIUklsYkxydUR3?=
 =?utf-8?B?U0JTVys1ZXBzTGd4NllMLzFtWFJ3ek1kL3ArT1ZHaEd6ZnY4OFdNWjFPR2Uw?=
 =?utf-8?B?U3dDeHFsYVdTclREYlkxNlltSTNhcjA4S1ROU1A0S1ZHNnpsM3JPaVRjWGJN?=
 =?utf-8?B?bUQxT3o2WFQ2UFBYMUowN0xoMXcvRnlpTmdJOFJzSWFGMld6VGg2WHNNbEN1?=
 =?utf-8?B?TGZxSlorSmk2NS9heFpydUtTbnY1bzhhYkw4bmRCbU9kbzZRWE0vREJzQmFQ?=
 =?utf-8?B?WjJjVm9Rc29OTjdNeWlLNEtzVFZGMlkwOE4wTzhoN3VTc3dwVWQ1Qmk5SkEr?=
 =?utf-8?B?NmVGcWw0bFlPS0lrM0pVb0k5MU1VbHE3ZzhBYkw4VU5uT1c5dnFQRkI3bzNQ?=
 =?utf-8?B?T2RUUzk1T1IxVDFrRWtPQmtxdXY5c05XQUpRSFNzMzZONFZ3VTRmTHI1OTRZ?=
 =?utf-8?B?SzJXc3drR1ZkenZPUmRLMVROSFM5aFdBYXhoQnhOSEJhb1dtekF0aFVFemMx?=
 =?utf-8?B?eERMTmY4dyt4M1pYYnM4TEFDdk1QMnlmWUtVaTFkeTViMXd5TkFTcFFjS0Vv?=
 =?utf-8?B?VXVqR0RxSzhXYm90NjlnSjZvNjFMdm5DUTJaVmpMNHhZazdLcWpPWTNqbFNR?=
 =?utf-8?B?ZTJ5UFlEc3p3VVMyTlU0S2RCMDVzMnBMWnhWaVUxZEdreDQvRnZ3N1lrQkpi?=
 =?utf-8?B?Yloxb0JDR0swVStXaEJOQW4wS1NSN1RxOVJYazU2Z0tncEhNZERwQ01NZzc4?=
 =?utf-8?Q?+yN0q9PVsp8wVgd7Ot?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6da747-5a43-4d97-595b-08df4557c605
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 09:38:59.7850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BBvXbqeHcWrjmR3E6xYD7wk4+Iz5r4gAxNCblyhxkbpe83dTsTtzIN9HTbAY0uF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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



On 11/17/26 17:59, James Zhu wrote:
> The SPM VMID reservation made through AMDGPU_VM_OP_RESERVE_VMID is
> recorded on AMDGPU_GFXHUB(0) only, while gfxhub v1.2's
> setup_vm_pt_regs broadcasts the page table base to every XCC. On
> multi-XCC parts the two disagree, in both directions:
> 
> - the reservation only takes effect for jobs running on XCC 0, since
>   the VMID grab path checks vm->reserved_vmid[ring->vm_hub] and the
>   rings of XCC i use AMDGPU_GFXHUB(i);
> - the page table base is physically programmed on all XCCs anyway,
>   and conflicting reservations are only detected on hub 0's id_mgr.
> 
> Make the hub argument real end to end: amdgpu_gmc_bind_vmid() programs
> only the given hub, through the XCC-masked gfxhub callback where one
> exists, and amdgpu_vmid_free_spm() unbinds the hub it frees instead of
> hub 0. amdgpu_vm_spm_update() binds every GFXHUB on which @vm holds
> the reservation. The VM ioctl reserves the VMID on every GFXHUB
> instance through the new amdgpu_vmid_alloc_spm_gfxhubs() helper, so
> the reservation now takes effect, is bound and is flushed on every XCC
> the VM's jobs can run on, and a conflicting reservation shows up on
> whichever hub two VMs share.

Don't add paralell infrastructure, instead change the existing one to handle the vmhub.

Regards,
Christian.

> 
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Assisted-by: Claude:claude-fable-5
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 49 ++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 +++++++++++++-------
>  4 files changed, 82 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 08d3ff61edcc..704a30ad388a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -797,6 +797,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   *
>   * For VMIDs that are bound directly to a VM's page table outside the
>   * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
> + * Only @vmhub is programmed and flushed, other hubs keep their binding.
>   */
>  void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
>  			  unsigned int vmid, uint64_t pd_addr)
> @@ -805,6 +806,9 @@ void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
>  
>  	if (is_mmhub)
>  		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
> +	else if (adev->gfxhub.funcs->setup_vm_pt_regs_xcc)
> +		adev->gfxhub.funcs->setup_vm_pt_regs_xcc(adev, vmid, pd_addr,
> +				BIT(vmhub - AMDGPU_GFXHUB_START));
>  	else
>  		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9c879ac68352..41f3dba530e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -651,12 +651,59 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		id_mgr->reserved_vmid = false;
>  
>  		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
> -			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
> +			amdgpu_gmc_bind_vmid(adev, vmhub,
>  					     adev->vm_manager.spm_vmid, 0);
>  	}
>  	mutex_unlock(&id_mgr->lock);
>  }
>  
> +/*
> + * amdgpu_vmid_alloc_spm_gfxhubs - reserve the SPM VMID on a set of GFXHUBs
> + * @adev: amdgpu device structure
> + * @vm: the VM to reserve the ID for
> + * @xcc_mask: XCC instances on whose GFXHUBs to reserve
> + *
> + * Reserve the SPM VMID on the GFXHUB of every XCC in @xcc_mask, so that
> + * the reservation covers every hub the VM's jobs can run on.
> + *
> + * Returns: 0 for success, the first per-hub error otherwise. On an error
> + * the reservation is released on every hub in @xcc_mask again.
> + */
> +int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm, uint32_t xcc_mask)
> +{
> +	int i, r;
> +
> +	for_each_inst(i, xcc_mask) {
> +		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(i));
> +		if (r) {
> +			amdgpu_vmid_free_spm_gfxhubs(adev, vm, xcc_mask);
> +			return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_vmid_free_spm_gfxhubs - undo amdgpu_vmid_alloc_spm_gfxhubs
> + * @adev: amdgpu device structure
> + * @vm: the VM with the reserved ID
> + * @xcc_mask: XCC instances on whose GFXHUBs to free the reservation
> + *
> + * Free the SPM VMID on every GFXHUB in @xcc_mask @vm holds it on, hubs
> + * without a reservation are skipped. The same wait requirement as for
> + * amdgpu_vmid_free_spm() applies.
> + */
> +void amdgpu_vmid_free_spm_gfxhubs(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm, uint32_t xcc_mask)
> +{
> +	int i;
> +
> +	for_each_inst(i, xcc_mask)
> +		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(i));
> +}
> +
>  /**
>   * amdgpu_vmid_reset - reset VMID to zero
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index c134000eecfd..d2b225d0aa38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -129,6 +129,10 @@ int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub);
>  void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub);
> +int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm, uint32_t xcc_mask);
> +void amdgpu_vmid_free_spm_gfxhubs(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm, uint32_t xcc_mask);
>  int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>  		     struct amdgpu_job *job, struct dma_fence **fence);
>  void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6b4dc0276e27..bd9aa35933dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -589,30 +589,36 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
>   * register must track whichever VM currently holds the reservation instead
>   * of being set per-job like a normal VMID. Bind it to @vm's real root PD
> - * address if @vm holds the reservation; otherwise do nothing, since @vm is
> - * not the one that could legitimately change the current binding.
> + * address on every GFXHUB @vm holds the reservation on; hubs reserved by
> + * other VMs or not reserved at all are left alone, since @vm is not the
> + * one that could legitimately change their binding.
>   *
>   * @vm's root PD must be locked by the caller.
>   */
>  void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  {
> -	struct amdgpu_kq_vmid_mgr *id_mgr =
> -		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
>  	uint64_t pd_addr;
> +	int i;
>  
>  	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
>  		return;
>  
> -	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
> -	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
> -		mutex_unlock(&id_mgr->lock);
> +	if (!amdgpu_vm_ready(vm))
>  		return;
> -	}
>  
>  	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> -	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
> -	mutex_unlock(&id_mgr->lock);
> +	for_each_inst(i, adev->gfx.xcc_mask) {
> +		struct amdgpu_kq_vmid_mgr *id_mgr =
> +			&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(i)];
> +
> +		mutex_lock(&id_mgr->lock);
> +		if (vm->reserved_vmid[AMDGPU_GFXHUB(i)] ==
> +		    &id_mgr->ids[adev->vm_manager.spm_vmid])
> +			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(i),
> +					     adev->vm_manager.spm_vmid,
> +					     pd_addr);
> +		mutex_unlock(&id_mgr->lock);
> +	}
>  }
>  
>  /**
> @@ -3018,7 +3024,8 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		int r;
>  
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
> +		r = amdgpu_vmid_alloc_spm_gfxhubs(adev, vm,
> +						  adev->gfx.xcc_mask);
>  		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
>  			amdgpu_vm_spm_update(adev, vm);
>  			amdgpu_bo_unreserve(vm->root.bo);
> @@ -3027,14 +3034,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	}
>  	case AMDGPU_VM_OP_UNRESERVE_VMID: {
>  		struct amdgpu_bo *root = vm->root.bo;
> +		bool reserved = false;
> +		int i;
>  
>  		amdgpu_bo_reserve(root, true);
> +		for_each_inst(i, adev->gfx.xcc_mask)
> +			reserved |= amdgpu_vmid_uses_reserved(vm,
> +							AMDGPU_GFXHUB(i));
>  		/* Wait for the jobs which might still use the reserved VMID */
> -		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
> +		if (reserved)
>  			dma_resv_wait_timeout(root->tbo.base.resv,
>  					      DMA_RESV_USAGE_READ, false,
>  					      MAX_SCHEDULE_TIMEOUT);
> -		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
> +		amdgpu_vmid_free_spm_gfxhubs(adev, vm, adev->gfx.xcc_mask);
>  		amdgpu_bo_unreserve(root);
>  		break;
>  	}

