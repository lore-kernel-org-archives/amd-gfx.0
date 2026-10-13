Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D91ACC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66C210E62A;
	Tue, 13 Oct 2026 08:12:24 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A51010E62A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/i9Dh7lOwmcIPjsAxsnicL/HfzkekyZcTc/7fPszQCpRGIVUZN45hy8/CywGcWRkIfi5e4AsgEhFY8A4+wDICRkRlzjrMxg37OGN5J37eDDF+aViJhkBfiNEgCsvLUn+4m+kOlAllLifFwRjAuKJyvUb9WuR915GIkYCPg3vppkYRDvMAFGe84chVX7o8bRZfl49/suxIBM2cBaGnk41x7M6k2v7Q1W2SyapMwZUGT6qB/vc9ijLFY52xrG1RqG/jrX4BN8W6/WD/o5U1NvEnt0OtP1uzydzvEMlNrtHfwZY35lMEpgir3RkpQY/TlYMbExWGy8peHwNp/lej8hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCcOjg7EAtMrYaXCLPLJTj88I7LZ7PVq4WS2mykMwT0=;
 b=iyZXrbj5swnyIdB9lz7gtBhh8uY0iQ0hR4Ilte20AnvNs7GI4T+AtRhO7zH/tp5ZhSjy7RMTZZT4TCUhlZfTumLwTh9BQQ/xDyOyrux7i6M0QIJF/igzx/jNuQ9a/11KZf4olKusJEEyqKr8kKqQNHILFTyWVpjXHxB3d3ERiMUTrpZXbymGl9CH7CztjU59yU88SDjVSWOAhssnojmJDCTFN5LbcO/Qqx7+BWIqdlp0ex9BoMieWbgP748wQFjDbqWUimfs+49+0QlbYgQkukxmToipQnontOXc6RBr8toYFUb+DMR4xgvCgDZyYme3BMCl89wyRrC2bVbjfudGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCcOjg7EAtMrYaXCLPLJTj88I7LZ7PVq4WS2mykMwT0=;
 b=mhaEr2zxoWfcmAz/nu6vyYCujq+6LYu/UfOZVS7Lzm08ZVw1APRC/UqbToI+S0C8c2GLiFVPDq+MbF8/qXTaSCyFzGO2NjuJaHha/h74DTmi8Srh6V8qtXVUVXgQTYn5Op+QMmW2sC81gvIPRA6h0RrpoEUFbFxc/dh9hukVGzU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:12:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 08:12:13 +0000
Message-ID: <3b271f03-2351-4d0d-91f8-407ec98d28ad@amd.com>
Date: Tue, 13 Oct 2026 10:12:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] drm/amdgpu: bind the SPM VMID's page table to
 the reserving VM
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013075644.775162-1-sunil.khatri@amd.com>
 <20261013075644.775162-13-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013075644.775162-13-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 480b1c6d-06dc-49e5-6ff6-08df2901afc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261009223027099003|56012099006|4143699003|11063799006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l/CTBPvqLsxsV5XS1nYcjkYIXtIUUK1LHfMLiipPtYFRgsB5pp/FKILwZl5508gaRqeMxx87qldToKHkOimjAVPhAUKOWiwdoI1cbgTprKCRluDclwzMwHdNo+ppKpO/9ZPsQYwHyZKtJ6r63BHlGK0HrzNkrocYYlEa60Ojrd122RKkPMGSs6q3WLmuGVGI+8p3/eeCR4EpcjD8xJedelPsNwaeFt2lmyS2gGu1Zej1ZYmH5fcTYadCGRp1xcMbVx0wRiuDFGN2LHjBuZtCDvh5U5XYZ7shFihVoLr5+3Ef4FdpWbplg6S6PW48fUs6tb4RZSYvOeI6OFw8ZStMN3rNECQaL7gjL/lz6SLEMPtzsvPKuLtU0FR4k5+qtVuHJSAFgN4J28N/F1qhFGT1Sg1qDsQog5H7RgeFUMcCCnMfY/2SwSgBnECCqQGtWVRpe3HrMrLYLUOlaCmO2tq2WE2iVo6ik4FXaQk6XaXVj7IbL6LoiB9qgHgQu9U7m7OSymcTCXmCliH9b7U5ZLeb1HSSR9USQ4QSrX4Er10ASK0lNPttkKf6Vgws9AxpfJKw41sHbSyI8iZfK/N/LAjnia5nJg7njFL5TfJSb20J5v84wjoezXB6aq8gg537506FFhICZUQk8/3dmpmjYu/gMKP8/btnrMUZS2BDNBgLdKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NPMUtvY3dGbGJHSWFtUXdjaGdDYzNMTVZLMndEOUYrbVZmSWt5RkExM2kr?=
 =?utf-8?B?WXNRbDJhckY3U1ZaUk5GMW9HUXhIWDZ3KzYvNUJKeXlJeFVNMU5hZ0JJNUhr?=
 =?utf-8?B?K1VwQWxEOFF5TGROVklJMVBFVW9Uc0wrSDNLVmZ6YjNyaEhVdDZleW9PNWx6?=
 =?utf-8?B?b2ZhSVZPckJSZGNVeTBleldXRktyMnJzVW9PQ1JvMHdQT0JYdWM1L21NTmxY?=
 =?utf-8?B?YUtMMVNxMDVSenRjNm9sVnREM29BK0ttSlhFMmc5SHVXOUhPN3lxNGlWdkNV?=
 =?utf-8?B?c0dlUTJLeENlODlPL2ZmUXd5c1VZamc1NEFhY2VHczV6L3FGWTBZYUpsTSsz?=
 =?utf-8?B?ZE1LRnpZQTNlVnUrMkduNXhTUytoc0hFWi9FMDlJT2lGMm5wNzhZTnhVSytZ?=
 =?utf-8?B?MitFUzBkMkloR0dvdmJlWUd4K1hXSk8wTk5BTWpCaHhMc3hRSnlXNkphaGRM?=
 =?utf-8?B?b203TmdiU0p2M2VZNkg3Uy94dENhTHBXaGRWa1lFSjV5WXdoTDlnOGE1eWUv?=
 =?utf-8?B?V3NLdWVIbWhubkY4MDViQ2pRRkxKUE5LZkk3MFVTZnhGRndrL0dyN1dqemxM?=
 =?utf-8?B?Nys3bkhudGhhUXh1bDc0WWRKNXN6dVBsNmgxYzFueDhOMVRLdVhDMnZOdHYv?=
 =?utf-8?B?VGZYN2JMamEwczlPQXFqVUtQVGVXbGR4bGR1cHZSUEYwZzRQOThmb213WEVq?=
 =?utf-8?B?eFFGOVV1R2ZoZm5reEVQLzBScDZOSERXVlMwN0VOY1hqQlBKRmcybERuUmM5?=
 =?utf-8?B?b0R1WWMxZTRTanBxSGlsY3RlWlptS0hUcS84VHBmcDkxMEFhYU9rNlF0VmhF?=
 =?utf-8?B?aUplNlBQREFybVZZeFYwcEw5dkZqNGNMYXF1djg5S1dTQ0laRXhwM3dQV25h?=
 =?utf-8?B?R0tLU0Q2bEFYUnNoWTRQSld2OGVKMGdueG95V240citkUVQxdWFHYzljU052?=
 =?utf-8?B?ZU51UjVtZDEwKzFkZkxKekVNS0tuSHdTSW1JcEdraHg3S1Q4NndNRFJ2TjNH?=
 =?utf-8?B?LzV0dVB2R3pFQy8vU1lQNGI4bWRXejBhb2RSRW4vaDRXN2I0d2t2V1MwMVNZ?=
 =?utf-8?B?ZW1uUFljL0IyZ0xEcTd3UGJ4K1NFNDVxdUd1RUQxbnN6QkRtMElldTFBUlJr?=
 =?utf-8?B?RTRzL21rN3VRK3VhNEs3aUVFd0EzTXNrdTlDekVNYS9vcjlmc1BUNDgwNjlD?=
 =?utf-8?B?eURUZkJGVW53WC9CNFA3MzdCc0J6dDBTZ0xTWWNoVlRSRzYwYlVLV1ZzckJV?=
 =?utf-8?B?QkpDZnlwZ1FTd0NScGRTRk9Kb0VXQ0xjUWZwblpmZVBQblZmQktlcG50REhG?=
 =?utf-8?B?dEdsbXZhM1p0TUEzM2FVMHI3c3kvSDZSR3FDanBOTFlzeWlPeGExS251R0pN?=
 =?utf-8?B?czlwUnFTSG4vcjhTOHhLRGRKbXBjV0NFSVdNdzdwQ1RSV0tHalJxdXMxb05k?=
 =?utf-8?B?djl3Nm9SeURtMGZxYnR0TGRHenR3dzRVRWZtT3hSdy9pS0FZWmRoK2FSN204?=
 =?utf-8?B?L1B6Wm5iaDdBR0lLZ0NwdUdjUE9RSUV3MEh5dlpmRUpkVmZNZmFmTGNPdTVl?=
 =?utf-8?B?SzVZREk1Zmp6eG02N3YwdnY2d0IrcGN3YlpqdFhIUVVHRG1DWUY3TTRYdFgw?=
 =?utf-8?B?OXFoTHJGQnlHSVcxbFBEM0EwQ3hqd1ZpVVJOVU9KbTQ4NFpQcld2NDdxNS96?=
 =?utf-8?B?NEdUTzFCT1lja1B3NlZBaGxQMEVqSmIyVTI4aGlxNm9KWFdHL2dIVVc3K3dw?=
 =?utf-8?B?cDYzMFU2SWExYlBGWmRVZDA2YzdFWkxWOVZ0YU9KTUpnTlJHbVcvWCtnL0NV?=
 =?utf-8?B?S2UreUtDaDQ2dG5qODgxM29NV2pueWJ6WlFrRUcxMWQ4Y2UxYVNTY0lUOXY1?=
 =?utf-8?B?Y0lSWFprc0cyU3Zia1E1R1VKSDYyVS9NMEw2Q1pyYVJEczVkelhMY2Zjd0U1?=
 =?utf-8?B?VzJ1ejYybkZ0Y3d0cnlxVkpoN1hYSjljaHZGNGtPWEVQc2NTSEtBSk1MSWpI?=
 =?utf-8?B?b0hKOEpkTTBIQ0tweEZsN3ZPRkx5ZGFkMFFJNWZJVldROXpnN2g1QzdWeWlm?=
 =?utf-8?B?SWl3ODl6dnM3SFAvYTV6Y0RVSmNnTk83MFg5OFZOdFU1aFZIcWF2ekk3b2lD?=
 =?utf-8?B?Rmtlc0NqR0FDR0NTbTlLcm80RFlPVTYvRnBrajZCU28xNUdMZHZWM1BsOUtI?=
 =?utf-8?B?ZEI2U1oxeVZMVnUxak1wbkZEZCt5V0pVSExBeTAwUlIxYzdMdmVtTS9aMWxO?=
 =?utf-8?B?Yk1Yc05sbTN0eEFKK0grWGhiSmVlanhmZTd4MmNLVDBka3F4cHVoYlBYeUpF?=
 =?utf-8?Q?VYiHGU7UcJkQBZbXz6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480b1c6d-06dc-49e5-6ff6-08df2901afc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:12:13.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMNfkmo52QgEHcl98ch+73oJXoioYXKHzS6AH1nIURaoqX70yWpvKoSSeIKq1UeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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



On 10/13/26 09:56, Sunil Khatri wrote:
> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
> userqueue never got its VMID's page table programmed. Add
> amdgpu_vm_spm_update(), called from amdgpu_vm_validate(), to bind the
> fixed SPM VMID's page-table-base to the reserving VM's root PD when
> that VM holds the reservation; it is a no-op for every other VM.
> amdgpu_vmid_free_reserved() unbinds it directly to a dummy address
> under the same lock that clears the reservation, so stray SPM accesses
> fault instead of racing a new reservation's binding.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  6 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 37 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  1 +
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 992f7cb3a3102..0ad94b09c6b46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -581,6 +581,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (vm->reserved_vmid[vmhub]) {
>  		vm->reserved_vmid[vmhub] = NULL;
>  		id_mgr->reserved_vmid = false;
> +
> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs) {
> +			adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, 0);
> +			amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid,
> +						 AMDGPU_GFXHUB(0), TLB_FLUSH_LEGACY);
> +		}
>  	}
>  	mutex_unlock(&id_mgr->lock);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index de992405ed718..3967dadb8d425 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -568,6 +568,41 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
> +		mutex_unlock(&id_mgr->lock);
> +		return;
> +	}
> +
> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, pd_addr);

That function seriously needs a wrapper in amdgpu_gmc.c.

> +	amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid, AMDGPU_GFXHUB(0),
> +				 TLB_FLUSH_LEGACY);
> +	mutex_unlock(&id_mgr->lock);
> +}
> +
>  /**
>   * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>   *
> @@ -630,6 +665,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		amdgpu_vm_bo_needs_update(bo_base);
>  	}
>  
> +	amdgpu_vm_spm_update(adev, vm);
> +

Wrong place for that, this needs to be in the caller of amdgpu_vmid_alloc_reserved() and in amdgpu_userq_vm_validate_and_restore_queue().

And while at it please rename amdgpu_vmid_alloc_reserved() and amdgpu_vmid_free_reserved() into amdgpu_vmid_alloc_spm() and amdgpu_vmid_free_spm().

Regards,
Christian.

>  	if (!ticket)
>  		return 0;
>  
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

