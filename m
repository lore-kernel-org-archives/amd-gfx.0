Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D708C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC1C10E08A;
	Tue, 11 Aug 2026 12:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxaGPbHP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3043410E08A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 12:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu//OvmLkyfr9myYJ00SfAVm4kfGiEoCmOuVIxlT/S3aCMw0Cwh7MLHkhb9MIzq+2hMpxMNCmuLIu2bCIi16ldwfJ9k72vwQ8Qw1ajuFFikEKQtk8dfy3T1gRqOG0Z9je/L+awVdvvKXPnk8GrDBnTi8BbIwYAmInoOPeJhDs1fYqP0+ckheQfc4JJLf76EXyDrgWxzcRFF8g+uXLXAYbh27YjhLR1E5yv2bL4n8ToA1yy36Q7GzM3kaSOzbuQwx9Xl3AqTHeUx7bjcPHDgL3GnVDYpP+1x2APf5qp6voV1bCOtbKCf/eAkOie4ucrIpDR4f8B+h5uKn4WnMhPaxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTO8jNjXttth93yvwwtprF6U2i9an4OeFQZKlcK/EIg=;
 b=owYT6ZwVbCAz6fHv9ephOKxeSN5kad54fJCRUv5grjSLT6RvWGMlHa/VVcqUmVFkseF1hEIQnpM+QdF1dbrGjzEBIh/gA+oQQNUsJE85cwXD+bd1lJhiHVmBKYPOmW3ZcfTM2rWdHAFxPaHHWNgQ8KJfWo8mYVwdMCF3QwRZnfRgb00lWmjfmjfMtHpOMMJcjfz2ul6NkDyKhEFMCXmR35pRH7b6sX2zbBQ7RyBbpBCBiPKziFUKGygNx4tKiYzSiSRdKsec036w0VfYELXh0YmnhNZvHp/p0rjDy6UoVaEc7eYig6SoRuGTtQPqR3u0FrNIEpwtUtxPefRT5b7TJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTO8jNjXttth93yvwwtprF6U2i9an4OeFQZKlcK/EIg=;
 b=uxaGPbHPlfR3VFQQY9ee50HVGlzUvaOTJN535ZRsfPIMGRgVfXFrKveatje0Py8BLaqGjL/Q9DOdLydYFH9dqPRE+5lOwjHflQ8MDInNYVRc5GVV+a/UoP0B0dQ8yDqHI7HXeaAaG6V73oi7IWn1TNkIIKRQEWTrROuV6YN4N9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 12:39:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 12:39:18 +0000
Message-ID: <05fe244b-6239-49a2-a618-068069972bdb@amd.com>
Date: Tue, 11 Aug 2026 14:39:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: keep PRT mappings off the vm_bo state lists
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260805102230.4060525-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260805102230.4060525-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: b45d273d-480a-4dcb-18d1-08def7a58f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SAWxJ+V09TWdteLVcjNd1hnwK26Czp2XBIPxLyIayA8YhM0fcvJYGl51Dls4k6ARteionWD4r0aU5DJMl/hA5yuxYkMDVj1aC/E1/DzKmZeHv5hiiyQbiifmUX049BfuVp12014kTn+pVWVDLFnBqh0RwFwI9cPJR/XxBL2gdtBsSLrF+v2Jl3azsWxTHTERiv6jbFJQ82GoLjphBVZmSqMJ7WhLLZQhfio/w+Xv5a6sM4HBN83AfOGayjWXwZcKKFkmax8rRmSI1sHgLiiCVH98HHnvL/eMr03L7USo5gARZ/U4Sw9UWLDHxztmZYMBQ2pdVco5hT6thTXS093n8t41WRtTRiA5VsNrgq14a4fOm2FkpfPnr/X9ArK/HdZWnYPI6g2BArNsUIuMAcWcD4DdFBsEzfNqdaTXtmOB7AxlQhZQAVvUHsgvqcZ+FHMTFGxI6G37N/2pEQ//E1Vgp8Pj+Yc+1kWIqPPtJqwq+NY4Qg/2rU1baa4CvgAFFjfx4r4jEFA1cC3ZtO667bHmULmIVLP4obUkYgp4wqVQU6W12d5ahCL20fCtquuloi6/5LEbJcHbYS6zIy+KjzsLR+5svS4KCbXgJFfYR+kHpXhxZd+Vxouy3TNWdy5I4u3lNq+j1JK768SR+2w+9rbr0fx7UKPCL0CqG9D+PJPeyKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBKTzhuVjZVK1FJelZzRzhXUnFoaEFlQTFxa3BXOXNEcEZoM1ZEellYL1Ax?=
 =?utf-8?B?MnRuMkZUZEF5THl2TnNvWnlNOUNrUm8vWm0zUCtKdmkxS0JDUE5VRUtCNXVE?=
 =?utf-8?B?eW1DQU1hWmtQRlYxRWE1UHBaaWNIUnJ2V3l5WGZIV1ppVjNhY1J2ai9HdFB0?=
 =?utf-8?B?WGJsMzU2ZmhPK0t3cWRnVTdnZWdzR001QlhsdGFIdzZKc0FUM01za043SGhJ?=
 =?utf-8?B?czZxZU5qb2NWSkw0MFVyc3dzdEJMdW5oZXpKZm1DSEljbGxEZ1lHa2N4UjRq?=
 =?utf-8?B?THpHdlMra1hNcGh6Z2lxN1pOSW9LMGFXWkNxTjJNcDRQR0Vid0t5V0Vud2g1?=
 =?utf-8?B?dXNXa0YyU1d6QzJmK0srTkhLUXVrMVpkZVVmWEd0UnhsTnZWbDAyWDhBRkNX?=
 =?utf-8?B?VlBLbWNhL0oveHkyK1lGQTRCeFJrMytxM1RIaDBITXdnZlU1STRMd2ljbFFj?=
 =?utf-8?B?UGlqa0R4ekZqdkZidkhKWHBxa21wSW1vMElYaWN1cUxscTdJVlphbTBUQTZy?=
 =?utf-8?B?TmlJMGtxU1pwL1R5VElrT1daaW9vUER4YmNrd0ZzR2pKR2IyaXNVRmp5aW15?=
 =?utf-8?B?NHFrRFF1Zy9JUjJ0bTYrdkpvMHdrSEVDSkZiSEt6eFNiOUxMUlNSMVFqWDJj?=
 =?utf-8?B?YXVnMzVVaXorWHQ0K2hIZ2lSUVBreWJKZEcyaVVVREdTbnRheFQ4akF5cTIv?=
 =?utf-8?B?b2VOYjU3cGlUSlBXU2UxWkpGZ0FmUXJPdE5ENVRiYlRlcTFmRU1oVE9zY1ZK?=
 =?utf-8?B?RFo3UGNlalVHTTh3cExCcCtnTzdPL0crdk5raTUxejc3ZjFubVhzSVFsdjdS?=
 =?utf-8?B?bDhza1JwbDlCdlpCb2NnczNCRkEwTWpxbmR1N2IvblhuQVE4QS9CelAyTjRp?=
 =?utf-8?B?ajVQMkVJOWZEcDFyMzR5Wjd5ZnZwdnRraWJnQUw0ZHpBcGdxc29MUmFzOXBM?=
 =?utf-8?B?alNvRWk4OHdaeE1TSnRVZkVTejZRNjRocGFqbE1DMnkvWkYzNy9ZZ2poeUhj?=
 =?utf-8?B?TjVkM29TNGFYbnJMTThYOXNxMUNWNHJOYUx5VFJZdFFiNUlmOXRBc3g2aEQw?=
 =?utf-8?B?Y3p6VFcxWFcraStUSXI1OHY3MjY0NG5rNUpGeEo5S2txbWxVYmZscTVZYkRp?=
 =?utf-8?B?SnNYQ2dsbU9UYkJKQVdDZXVYbSs3M3RmdkVqeHhFcWp3RzhEdUhPNTgxS1Fm?=
 =?utf-8?B?WlZrYUlCa2VRd1ZxTndydWJyMGFDSnhVVmNmaytKREFsWDFuYUlDRlJXZ3py?=
 =?utf-8?B?aG9JK3J4SG9GV3NlUHRVMUF0TDZyZWxsZ3NRdkptVEJLM3dyZjl3ODZ2Titt?=
 =?utf-8?B?bHNIM1ZWMElXTDFJbCtlVGVJMVBvZkhjOERuR1pQeW1VTTRwUnB6N29SeHJR?=
 =?utf-8?B?MEg5a21ueUNFMGNpQ0hjd21weFdlV2poV0g5U0VuMU5lRUllVjBNT3ZRZlIy?=
 =?utf-8?B?RWFIMWtSQWhzUUdnOVBkV3FHano2V1hITnE1S2ZiS0Z2dW5zam9VZisxNDgr?=
 =?utf-8?B?enpLQmltRHk3a1Zlei9VeVQwR2NLUDdPQTRpUXVnRDdRWkNwTmNOa0JNZUhl?=
 =?utf-8?B?d0pwcFY3bU9JQTJSbEtQeGhZQk5IUWVPaVJwdmYwTTNqQTdyV2lYM09PeEQ5?=
 =?utf-8?B?RUg0MVpWeXIzeUFHL0dOS0hRb0gxMzZSZlhJeGQ5Q2MwRUZtRlM1UzdBaEpC?=
 =?utf-8?B?Si93UTJNQVp1RnU4RUdFLzg3QUZPY2taWGNGcUNqdWlHbFNDNEY3a3p6ZEhR?=
 =?utf-8?B?WnJGQmZZTHBKNVZVNDZhcSs4MzJKbFdac3NPYjdWWWIyWUNoR2pIbFB4UTBv?=
 =?utf-8?B?WTNFSS9TSjBmTkhKMzdtRFdtNG5xaUVBdUYxVm8vWGlPWjhMdVh5WnV1eEgz?=
 =?utf-8?B?ZDFVMDg2ME1JWWNmRTdDRVNoK0U1T0lySTUwTEZmOTNXTWhqdnM4ZHVJVHBz?=
 =?utf-8?B?QWN0TDR2a3dRazA2SVVFcWRSdWwrdExhUlVkcXhtdkpzZVFzMTBNeHVTSVRl?=
 =?utf-8?B?a2htQ0tKYnM0ZUREUUNvckRDamJJQTJ4dlBIWjgrMmdYS1BvUVRxeFdJbXE5?=
 =?utf-8?B?TUNQeEdLNlhiNk5sTCsvZXdGTzhnUzZrdFZvOXZGY2JOSDl3RlpibFEyTDZR?=
 =?utf-8?B?L1RzVEdWOEplT20yeHJFZWNMSElJVnFqTGp1ZWpoTVFURnQzSnBLNnhNNXho?=
 =?utf-8?B?dDRUc1hmSHF5VCtDRk9QbVVGOUpVeWdyN2hGT0tyVWtPTVNvR2NUZms3M3A2?=
 =?utf-8?B?Y0ZMY3ZWL1laNU92ZXJ5MXNnVHdia285MnVVWHFJeVlqem5QWlhLeVVYeW43?=
 =?utf-8?Q?2S0ErG+IdB2okJJeBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d273d-480a-4dcb-18d1-08def7a58f80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:39:18.3923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2AV+h02Bqtg0RKDmkuES4ur5KWZJ8SsULaB0SUBFKBvLq+Oya+KD+e35xVpuThI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
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



On 8/5/26 12:22, Jesse Zhang wrote:
> A PRT/sparse mapping has no backing BO, so its bo_va->base.bo is NULL.
> amdgpu_vm_bo_base_init() deliberately keeps such a bo_va off the vm_bo
> state lists, but the tail of amdgpu_vm_bo_update() unconditionally called
> amdgpu_vm_bo_idle() for the !always_valid case, putting the NULL-bo PRT
> bo_va onto the individual.idle list.
> 
> On a GPU reset amdgpu_vm_bo_reset_state_machine() moves individual.idle
> to individual.needs_update with moved=true, and amdgpu_vm_handle_moved()
> then dereferences bo_va->base.bo to read its reservation object,
> crashing on the NULL bo (e.g. the userq eviction restore worker running
> during a reset while a user queue is torn down):
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>   RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
>   Call Trace:
>    amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
>    amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
> 
> Skip amdgpu_vm_bo_idle() when bo is NULL so a PRT mapping never lands on
> a state list in the first place, and refresh the PRT page tables
> explicitly in the userq restore path (as the CS path already does) so
> sparse mappings survive a VRAM-lost reset. Because the PRT bo_va is off
> the state lists, its PTE update fence lands in prt_va->last_pt_update
> rather than vm->last_update, so wait on it explicitly before restarting
> the queues (mirroring how the CS path syncs that fence).
> 
> v2:
>  - keep the PRT bo_va off the vm_bo state lists instead of NULL-guarding
>    bo inside amdgpu_vm_handle_moved(); a PRT mapping should never be on
>    the moved list in the first place (Christian)
> 
> v3:
>  - the PRT PTEs are updated separately, so their fence is in
>    prt_va->last_pt_update, not vm->last_update; wait on it in the userq
>    restore path before restarting queues, otherwise the queues could
>    restart before the sparse PTEs are written (Christian)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 +++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6d3ed55e9ab4..bcfbd7213dd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1070,6 +1070,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  	if (ret)
>  		goto unlock_all;
>  
> +	/*
> +	 * PRT/sparse mappings are kept off the vm_bo state lists, so
> +	 * amdgpu_vm_handle_moved() does not touch them. Refresh their PTEs
> +	 * explicitly here (as the CS path does) so sparse mappings survive a
> +	 * VRAM-lost reset.
> +	 */
> +	ret = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
> +	if (ret)
> +		goto unlock_all;
> +
>  	key = 0;
>  	/* Validate User Ptr BOs */
>  	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
> @@ -1127,6 +1137,12 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  	 */
>  	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
>  		dma_fence_wait(bo_va->last_pt_update, false);
> +	/*
> +	 * The PRT bo_va is kept off the state lists, so its PTE update fence
> +	 * lands in prt_va->last_pt_update rather than vm->last_update; wait on
> +	 * it explicitly (as the CS path syncs it) before restarting queues.
> +	 */
> +	dma_fence_wait(fpriv->prt_va->last_pt_update, false);
>  	dma_fence_wait(vm->last_update, false);
>  
>  	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 4c90e88e2e30..02e2e576f154 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1391,7 +1391,13 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  			amdgpu_vm_bo_evicted(&bo_va->base);
>  		else
>  			amdgpu_vm_bo_idle(&bo_va->base);
> -	} else {
> +	} else if (bo) {
> +		/*
> +		 * A PRT/sparse mapping has no BO and is kept off the vm_bo
> +		 * state lists (see amdgpu_vm_bo_base_init()); putting it on the
> +		 * idle list here would let amdgpu_vm_handle_moved() dereference
> +		 * the NULL bo after a reset.
> +		 */
>  		amdgpu_vm_bo_idle(&bo_va->base);
>  	}
>  

