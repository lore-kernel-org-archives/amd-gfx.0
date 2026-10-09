Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA3CCA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEEA112001;
	Fri,  9 Oct 2026 09:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Afnm9Gnb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33A4112001
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kx9ZYxckyZkaKXHyKitJs9Pjv4PWTfU8ZZIXJ68pmy5lsPPF2XEsU14s81MgIlqyc1lb7mGvygBuFCqJy2JiX1304JlAO+maAbVzF2gKYvTozja9R4IfTXxQ9+ZdvuGOlQeDye8F3E/88D8Ev+1f4xFRmDZJ+QkR5fWGK+G0y+RT4un0l3s32m8rijAR4Qp0APt/Lg8IpDalK4EvZjcLrlW1CWXgqTwBLvcb9nnAM1ZZ2f8AnVlKIXwKG5UtDNOF5RDwHJIppSVWq0cC3YQtfMplyxp0tFrq8lhCUtL85wklFD5T/m0v4Rdy58Qg+6u/2ngMzvmoQnW+fcvFkhuk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fszfiZd/MCznW2BAhbi2yWTH3ZCPSkuAVsCY8RMGIIQ=;
 b=dv8NzEFMO11+KeRnjEnJUGxokwv3iAsMg4qpi0BPQgVUY8LxUWZi6VcIDLogXoIVJjxt95TX0QVJlqJXP0HK7hZBJLMXoqMGoB+cx2Xx7n69tYkKEtO2ccYGvlWimHT1P6jXMn/pA4ASZ5+RddKeIxgO2+bOrF31kWT3qifYTyu3mpFnXwNNrKTVxmdJW08IByPLkPQT4+1L57EmBMhuVhJWnZVIe5ZgMUkkmgUyhrH1KROs+CoOECiiiMM1iLd4gnrXjGfS6RTn8152hNhLR6n2lTuYglP+g/jb3/Kov7+EX3S+Imk9hMOEHwXX637ZTBA0/4yM4nVyM37KZ88Inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fszfiZd/MCznW2BAhbi2yWTH3ZCPSkuAVsCY8RMGIIQ=;
 b=Afnm9GnbBK5quqc52KU3kzRRMDUcc4hPms7rKkS0fXA30AIsoW/GantNTX+U6gvKTm5krDlhPqj9DS433d+EeCHB/TtfS2Z/hg8xlf+PMTURbAaPeoOutW5dOv9YIdOzCGNLFB8ONcZnMNTgdV9Z9o+2EC5agPny17d4KqaxKcI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 09:46:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 09:46:27 +0000
Message-ID: <f7b59f29-66d3-48ea-b9b0-1c23e2f3f104@amd.com>
Date: Fri, 9 Oct 2026 11:46:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: amdgpu_vmid_mgr_set_vmid_mask to set
 up both hubs at once
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261009094001.3521891-1-sunil.khatri@amd.com>
 <20261009094001.3521891-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009094001.3521891-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d77aca-641f-4778-5d96-08df25ea304e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ArnW4l8QvOUX2dFWaEJEM2IagDn1ufnFKgWTMvAr4LyEtd5cXhIVLLjrOOT2JXM+iYeD1PgquTgS09THqPlPM3vM+p8B/wtiu9TMTAm6YYoYUG+lirHh7DHEYnjA9bBg46AEn2GgfyZopxwWlFdfdiat0oBvRqYGNQkGQBVLruDANq3t2+IX18IIgR7JChgVCoqEJvuCY10KXPyEe3CpVe3TyTv1dNEXCdlgn8Q3IGJGZ0+jFwp1EqYmLMRj3znkREGeVZSiuIxjDISmlavQBdgoki3IgntT3uYN09tX13hNfgLuFu8gfNoWlt/FBvYDqr8OubB3nMVUViUZUbwqyyARN1fJHAfBXitIcHEgDJ83VCQ7nhT9sYCgfiRwjkHu0v3KnrkvFWVbwRmYoHI+JjtASkZjsWHWvUCF32kZK15BQ096EXtBecIDj22T5r9BElZjHAmlyJYPDvZm90n96672VEtCMKldUeJfRb44a4oEHZ3o8aeargv3NSO/cwwQ337R1kxwBWMxzlPdMNnLzFiF56isybi2iIR9LTDzkPS4E8xqDVnW6KuUMSyKZgEekiKKMf6FpCV0zRV1QgBVjYbucHJVF5ZSFWep6z2yGiFGrj91MvKHP3UaWgR9aLEuJ6kA2DbNejjP9zj4ewea6hOnk+zElumQzUae7+5ot+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkUrN3Jqckg1SWtGRkw4TWpUbUwzWWRmRTQrbUxuUzFORUlpZWo0SmJub0tv?=
 =?utf-8?B?Yk4wMS9hMGY0NUZjSCtycXNlbGlXbGJ3cHRGYW56TnBFaHF0bG15MGEzUVRT?=
 =?utf-8?B?N202ZjR3RWJIaUlvVFlyUmhEdTZIMDJ6MUVFZ0c2WjhxRFJ4S3NFQjhJZFF4?=
 =?utf-8?B?WWQwZWprWXVYQ3MvMVg4RzEwSitYc2twZm9hK3RTZU52WkQ5UENSMlRUdFpX?=
 =?utf-8?B?UFNuRFdxek5Zc0Z6S0IxeDcvK2d0RFBGWkpiQ2dYSW81TzBaVjY1MWNCdmFp?=
 =?utf-8?B?dG82NUdsakpIRWlGamRoS0lrN1hNQTBIOHVZc3FmU3ZKbWY2TFBpY3hyQlpo?=
 =?utf-8?B?Snd1dU5NQVM1cUx5S1NzTmRqN3JpRFlJdkcwcWY0ZHBrUER3RDREUTUxdWdp?=
 =?utf-8?B?dm1SOXNTRCs3ZWt3aXVnTHJoOXpYWmpWVUNXSWhtMHRmanlnd3NXU2V6T0w5?=
 =?utf-8?B?V0w1QVFtTU0yNGMxcGdSSlZqaXJyTEJoVVpCMi9kRWFuTVdaYXpCYkdaUC9p?=
 =?utf-8?B?S212MlQxYTNVS1lzZHVQdGsvQUxnbHNINDlGTmp2ZEJiTDNzUFN3bWZHZlFY?=
 =?utf-8?B?Q3dZbmxqcVQrOEFxcUFuVWwrWXlXYlJGS001bkhnbDVrOVdyTmYrU3d4UXVD?=
 =?utf-8?B?NVpCZXd5UERUYjVOSUFyNWdGc0hIWDZhOEFYU3ZDQzNxb28wbGVRMW9PRjRE?=
 =?utf-8?B?eFAvQ0kyeE9yaDdvSDdqelA4V0FpM2xvQjFlemNlcVB0VzhqbVl3cWNhYlFu?=
 =?utf-8?B?ZmNRUVBIeHMxTjNaUklTTDMrNVpuZlBKQ21ZWHNqd242Q0Zuek81ekV6VmRY?=
 =?utf-8?B?VjgzMDhGeDIvS01wUERqdzFzRkF4K1V5RDRIcDdNQjRXakF2amhwTkRQSkpZ?=
 =?utf-8?B?Yng4WmNxK0EzN25sNkNJS1VlZjl3WjVXbUJlTDFDSjBNb0U4SXYxR2NTWm5X?=
 =?utf-8?B?RWMwaDIvUXdtZ1BYUmY4aEp4RzE4SWI3SFVhREtVR09QTUxQLzBEWFZRNWgr?=
 =?utf-8?B?Y3phWHpYNEdPK05BclZpWWFJakphSkl6Rm1SVUNqbnVhTit0UmZlRDd4MVdz?=
 =?utf-8?B?SUg0aFFEd2VRNVF1K1lNQzh1NW1ZUi9ieGJzWlhpeXZRRzhTRUFKYnpnaWR2?=
 =?utf-8?B?VGRhRUN5Tk5LanBKMmFqbFEwRlhyR3laMHgyQW1NQmliZjdyNXRsYmVlTUE5?=
 =?utf-8?B?VHZ5THVuTXI4OGRpNldLUXh4M2h5SzhyMFVGQ3h5RmxEcEtweGh4T2NQMGk3?=
 =?utf-8?B?U3Z4cFYzY3EyYnFJV21xYmFoSXpocmJZMXd4SFFlblA0dDJLNTNuVDdpNUx3?=
 =?utf-8?B?bVd2QUlnMGZXaGlXZFhTOWpwRW5CZldrYjFZWXRmZnYxZVJ3SGFvd2w1TFhi?=
 =?utf-8?B?aCtmSEJOdmxEV1YwYXZ2SzFWaVNHWWVzSkhHUTJVNWtIN1JqY2xHeWs3VVhy?=
 =?utf-8?B?eFB5RGM4ZGlYMkloWGgvNU0rbUZEK3d0MXdQNjRlTE9wZ3JOVjI2ZDZLMUFn?=
 =?utf-8?B?ZHhiaHVWTkRvMythVlNrRnhLTkRJZHVxQmpFR1o4RmQ3dlV5dGE0ZUpuWjh0?=
 =?utf-8?B?MFZlUjkwZ2dSYW9BQi8xaUZRRGo2clVIbmdiMjdDN0lRS3JxN1U1NzU0M3Qz?=
 =?utf-8?B?UGZGOUR6b1RBWjNHMFRKZUNrZ1B6M0cvajJtQ0RmQXV4TXRGR2dpSEdCdkV2?=
 =?utf-8?B?TFVKUCtMbE9tWHNRaW9zVzlEQUhubXJ4U3FabVB2Tk4zYlhISzZSZXRmTkdv?=
 =?utf-8?B?K2ZtNjU0bGd1ZVhRcjhtYTgwODlJVi92bkN6VHBDTGlOMGhGU1FDS1Z4WmQv?=
 =?utf-8?B?T1NyaTcyM0JaSzRRTTFIbnlJSy9ONzY1YVBqTkV6cUVlYlBEMmlqckJ4djlr?=
 =?utf-8?B?eUQ1aVptZ0FlU3k4SmhXT1hDMEd5UlFaSU9xbGNBOUtwUGZneUNEMzBxRjBO?=
 =?utf-8?B?anQxUGh1R0Q4Z2l5Q3dET1lyZnlUb2N2eXUxUmZEZHNOd2hodkIzbnQ5K2hR?=
 =?utf-8?B?Nmg4dzkzS0pWQlpBdEorOGFwUWcwQjFHZW9HYUMrR1ZlUURiRkJBR0N4My90?=
 =?utf-8?B?czc3TUJYbC83bFhhN1JHZVVpMzhVV0kzS3h6L2RCVVZFUkZTOTlzMmttcHB0?=
 =?utf-8?B?VU9mNlZWVlBDNld2UVB6RlpRdE5GdzRCSGYxNkxOR2ROZmRhcCsyWE5QOUpS?=
 =?utf-8?B?Z0NwSnlMU0RRL1h2ZHBWTFhNQnAyaWR1dTdZUktDaDB2SU9PY25FUnJqU0dr?=
 =?utf-8?B?cU11ZDZQdE8yRUZhTThmelVPVkNaMWZZM25wUXF6SkNsYmQ0ZkVybmh5UjVi?=
 =?utf-8?Q?srIEPNj6jGBnQTFFQV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d77aca-641f-4778-5d96-08df25ea304e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:46:27.6878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jya3zI/xG2ZiMUSy4MKOplm/P7llP1R0lyePeFFzN4cvfqs9qqKNBp/w+3p2v2l0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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

On 10/9/26 11:40, Sunil Khatri wrote:
> Set the kernel and user-queue VMID pools for both hubs in one call.
> The caller now just hands over each hub's raw kernel-queue mask;
> vmid_uq_mask_gfxhub is derived here as its complement, and
> vmid_uq_mask_mmhub is the fixed pool set here too, with npa_vmid
> excluded from both MMHUB pools, instead of any of this being split
> across a separate post-hoc fix-up or a field the caller had to
> pre-compute itself.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 50 +++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 13 ++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 +++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 28 ++++++--------
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 24 +++++-------
>  9 files changed, 75 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 55d6b2107d8f9..1c5bce0500ac9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -631,44 +631,48 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
> - * hub, and the matching user-queue mask on MMHUB
> + * amdgpu_vmid_mgr_set_vmid_mask - set the kernel- and user-queue VMID
> + * pools for both hubs
>   *
>   * @adev: amdgpu device structure
> - * @vmid_mask: kernel-queue round-robin VMID mask for this hub
> - * @for_mmhub: true to target MMHUB instances, false for GFXHUB
> - *
> - * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
> - * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
> - * fixed purpose) from both the kernel- and user-queue masks; the
> - * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
> - * directly by each generation's sw_init(), since unlike MMHUB's it
> - * varies per generation.
> + * @gfx_vmid_mask: kernel-queue VMID pool mask for GFXHUB
> + * @mmhub_vmid_mask: kernel-queue VMID pool mask for MMHUB
> + *
> + * Sets both hubs' kernel-queue VMID pools (tracked least-recently-used
> + * via id_mgr[].ids_lru), and both hubs' KFD/MES user-queue masks.
> + * vmid_uq_mask_gfxhub is set to the
> + * complement of @gfx_vmid_mask, since unlike MMHUB's it is always a
> + * clean partition of the full VMID range; vmid_uq_mask_mmhub is the
> + * fixed pool set here instead, since MMHUB's kq and uq pools are
> + * allowed to overlap. A VMID dedicated to a single fixed purpose on
> + * MMHUB (npa_vmid) is excluded from both MMHUB pools; it is the
> + * caller's responsibility to have already set npa_vmid.
>   */
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long vmid_mask, bool for_mmhub)
> +				   unsigned long gfx_vmid_mask,
> +				   unsigned long mmhub_vmid_mask)
>  {
>  	unsigned int i;
>  
>  	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
>  
> -	if (for_mmhub && adev->vm_manager.npa_vmid)
> -		vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
> +	if (adev->vm_manager.npa_vmid)
> +		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>  
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>  		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
>  
> -		if (is_mmhub == for_mmhub)
> -			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> -				    &vmid_mask, AMDGPU_NUM_VMID);
> +		bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> +			    is_mmhub ? &mmhub_vmid_mask : &gfx_vmid_mask,
> +			    AMDGPU_NUM_VMID);
>  	}
>  
> -	if (for_mmhub) {
> -		adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> -		if (adev->vm_manager.npa_vmid)
> -			adev->vm_manager.vmid_uq_mask_mmhub &=
> -				~BIT(adev->vm_manager.npa_vmid);
> -	}
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +
> +	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +	if (adev->vm_manager.npa_vmid)
> +		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 73ac1b18e8487..4dfcec76afed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -135,6 +135,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long vmid_mask, bool for_mmhub);
> +				   unsigned long gfx_vmid_mask,
> +				   unsigned long mmhub_vmid_mask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a95bfe22c640e..55d286275466d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -746,7 +746,6 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
>  
>  	adev->gfxhub.funcs->init(adev);
>  
> @@ -867,15 +866,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(7, 1),
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7b19c59a2f743..301ffb89c9672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -745,8 +745,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned int first_userq_vmid;
> -	unsigned long gfx_vmid_mask;
> +	unsigned int last_kq_vmid;
>  
>  	adev->mmhub.funcs->init(adev);
>  
> @@ -853,16 +852,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
> -	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
> +	last_kq_vmid = adev->gfx.disable_kq ? 0 : 7;
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(last_kq_vmid, 1),
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 9194130c25f29..e4a74cd6574f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -848,9 +848,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
>  	struct amdgpu_device *adev = ip_block->adev;
>  	uint64_t pte_addr_mask = 0;
> -	u32 mmhub_vmid_mask;
> -	unsigned int first_userq_vmid;
> -	unsigned long gfx_vmid_mask;
> +	unsigned int last_kq_vmid;
>  	int i;
>  
>  	adev->mmhub.funcs->init(adev);
> @@ -992,28 +990,24 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15.
> -	 * On GFX 12.1, amdkfd will use VMIDs 3-15, with VMID 15 reserved
> -	 * for NPA and therefore excluded from the MMHUB VMID pool.
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15.
> +	 * On GFX 12.1, amdkfd/MES user queues will use VMIDs 3-15, with
> +	 * VMID 15 reserved for NPA and therefore excluded from the
> +	 * MMHUB VMID pool.
>  	 */
> -	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
> -		first_userq_vmid = 3;
> +		last_kq_vmid = 2;
>  		adev->vm_manager.npa_vmid = 15;
>  	} else {
> -		first_userq_vmid = 8;
> +		last_kq_vmid = 7;
>  	}
>  
>  	if (adev->gfx.disable_kq)
> -		first_userq_vmid = 1;
> +		last_kq_vmid = 0;
>  
> -	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(last_kq_vmid, 1),
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 4e593e67221ff..a7c353d1ac09d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -768,7 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -822,15 +822,11 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(7, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index bbb5c42b9d4ed..4199300eab177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -941,7 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -1004,15 +1004,11 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(7, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 25d47d2c288dd..3f9ec7427319d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1051,7 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -1119,15 +1119,11 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(7, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 7ebf7b1299ff6..3a8dc15ef95b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1849,8 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
>  	struct amdgpu_device *adev = ip_block->adev;
>  	unsigned long inst_mask = adev->aid_mask;
> -	unsigned int first_userq_vmid;
> -	unsigned long gfx_vmid_mask;
> +	unsigned int last_kq_vmid;
> +	unsigned long vmid_mask;
>  
>  	adev->gfxhub.funcs->init(adev);
>  
> @@ -2019,8 +2019,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1..n-1
> -	 * amdkfd will use VMIDs n..15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1..n-1
> +	 * amdkfd/MES user queues will use VMIDs n..15
>  	 *
>  	 * The first KFD VMID is 8 for GPUs with graphics, 3 for
>  	 * compute-only GPUs. On compute-only GPUs that leaves 2 VMIDs
> @@ -2032,21 +2032,17 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	    adev->jpeg.disable_kq &&
>  	    adev->vcn.disable_kq &&
>  	    adev->sdma.no_user_submission)
> -		first_userq_vmid = 1;
> +		last_kq_vmid = 0;
>  	else
> -		first_userq_vmid =
> +		last_kq_vmid =
>  			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
>  			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
>  			 amdgpu_is_multi_aid(adev)) ?
> -			3 :
> -			8;
> +			2 :
> +			7;
>  
> -	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(last_kq_vmid, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	gmc_v9_0_save_registers(adev);

