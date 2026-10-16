Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444A7CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 11:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C043A10E147;
	Fri, 16 Oct 2026 11:33:23 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3DC10E04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 11:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQZ0KQAj0MDDsYepl1XzdRZX223m6MMpilz3C2jjDk3oBIPr97+jAC/MRCg7pk1aUewmAiFSOmx5SkT3HPaCVRWKUveYe6pOt63GZI8MleCv5rt0faUj7lFtTxsmH0B5dCP3yAOuRW8YAKBruyv0R7VIeRDuHBnD610M9ffsXZblmVq8GVOv7fm47L/dmYOAoltI0gYSMY23krs+Wl6yL+cRO/QmSb9lUyYW1TLHhCryzojF6IaAhuuJ9yTGBcru0ib6ojh6zbheidHrN0Ir7bZVMo7Np6bMFwpJKTSTflhHg42+RN+UpWgf9a0gBTx7uJMYr0IH8WoiY33G0jeZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+4Js+yVLecbnVg4x6kHzm0XIgbgBZXaQn5sIm5HT8k=;
 b=IO9xaAmW1us9QTmizt+OGIkoNra5v0ganCZ0tTOBKe+WkEg7bX/S6TfebaRyPnIzqoa+33jTjBWp7d5ErmoJuAJIS3VDy8fWUynpHu7UWE2AlpErIDWE4A4WSPWmRfzRUJG2u/6uG+QZDYNKQ7QhaG5jjdbS0IocerTQO0rw6UpP7eb+k9E6zEy3Ae2/x9EvDkGaDzcORvAetupaF6r2a13rk4bC1qRiHqeUQRAabYHG127CuMqIcMyvYAF5IMOhU9iTiCjJOX+QyNytQHTkGCmw+nDV7Wc0XekQSsCD0e48zZEdL8W/0pjy2m2D3yOCHuunEilosRLD9xwKebzdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+4Js+yVLecbnVg4x6kHzm0XIgbgBZXaQn5sIm5HT8k=;
 b=UpYybfSce64Ch9bDMpzPPuJVuMlCGpsEVgMnCsEcBUdR4kD1KVp2+AEPLkllR7BNer3sHdpXPH4DsQOnMltebAY/HymyO+Btyi8kQUkIKwoTYrj53KN/5SvEV8lWxX2sKg4ySOUPLsu9d9i0eGpOohzYipp0J7YJOVolwIABJHg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 11:33:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 11:33:11 +0000
Message-ID: <e248e08e-a9c0-4a3e-bea9-ee682eb25be0@amd.com>
Date: Fri, 16 Oct 2026 13:33:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: bind the SPM VMID's page table to the
 reserving VM
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013112112.1449531-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013112112.1449531-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 296862bb-6c4e-4151-2dfb-08df2b79422d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|18002099003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: yOIj2sAQWhD6okd+1rZNLxrFPn4SLWPmjSEx59XKyu2QBTclTfbTHYTK4blVpJQyaOkxG4Agdj5eazJCcqwqAUhgsWfjS16XJJGLDGBDG+6GkJKWIItt0IK2MkOY5PwejhL4L8lt5g+rUl/5e6EdFPrCtDJAs8QqPBI07R3S+RtoQL+WLFhvWxbkTn7KsJ+pjELUYpqXhjmRrxQPNCSfjnIzr7cnb92+A1GA/jC1GS6LwZArXrBGIDG+p22yzFOqESd1XdLAQTq2khLvL8wyRK3/5WzZhw03rZwjZPDVSfT++NVrRDxCKO8rX5F5xJzrNzCeqrtndBES3jGEhn0Y1XXTjyinX9dBHrL/M1cKPH+rUYcpMhvpr/7oWKb7K9HP/ZGQ526lgDJDJYJsBPXTfooWzPH7igDiMtOh3iPXo6ySijfWg8MDQrYrxu90i+psbsq2o+p/mmKOjA4oc1Cghok08H+3G0DhedU0QrU8IGKvrMnaGQ+YJLMUxDOuIS3C7ZN842QS15BNfUD51NDkDK2Gh8H7AGaaAywwzcd9KW9Ua99NdeheSj1W1QEVrz2tzsPoCPFx2jVCtnUCC6DsrdxrfFxjb4eYJI0w2KT3LE2TNdyD3atsrNBkHyPSzrhrfBzwZA8iUbT8DLHpgZYfalXfPeSP7/p94/2IbitG3W0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citvSDJ1VzNWSmhyUzhmZlVYSzNwMHcyZldhSDNhZE9ER0VrWjlrQWZhNkIr?=
 =?utf-8?B?Z3NmdDd5WXUzWldLTm8rOUZtL1VzSFpQdXkyNnc3dEZVQ1lhZXJYVkZlUWUy?=
 =?utf-8?B?dm9tNnBTVncxaWdLSFZFcHpCNGdPMmxTVWJOeWh3OERSYVBpalJjRXVJKy9Z?=
 =?utf-8?B?Mmt0UWZIVnJxMGdBMHdadlF3enFsbE5ldzc3aFNYQkJnckRNL1VON0tOMmNr?=
 =?utf-8?B?T3ptdmtKbHlpbEpJZGFmL0pEby9NaE13REc2OU5NSkRVWXdmVnQvdE9EN2x1?=
 =?utf-8?B?cTEvcVlrQ3k1dVJSSmJkcUorNVk3N1p3bWFXLzdSUG1zQTVpdWtrdE5JQlRl?=
 =?utf-8?B?b3hVenJHeXk1MVI5NC9lMjhIcmdZV3NWQ21qZHpSeEtNRkl0MmdwWFg5dVU3?=
 =?utf-8?B?VHAvSTk1YzI3WFBoK0crSkJsdGtnSmZuV1IrZjRCTjVuZU1kVElFTG1pSitJ?=
 =?utf-8?B?MU1PWjZKOU9UUGhGWFRIK2ZRSk03WjZBMEVBNzUwcURPQUhaNlNWTTQybnlM?=
 =?utf-8?B?N0FQdWVGekdpQXdNQUI0d0N4ZkFHVmdxdVpCcEJSZWJxazhQTG9iRk1FZ1J3?=
 =?utf-8?B?aHIyODI3d3Zab01NcUljN2tBVUxUWmVmSEQ2aWN1bjRsZktreUQ1N0M4ZmE2?=
 =?utf-8?B?elBaTkJzbzdNTTZPQUtEQkk4QStKTWYyOHR5Sy9DQ2IvUDVIU1dUcHc0Qk5V?=
 =?utf-8?B?bW1NYWxrbEMvaTlMU1VyMlFNVGpiZkFsOUxhY1VVRUI5bnMvRmhraDZVSElS?=
 =?utf-8?B?NnpGVEFHek4xd0ovTnp3eTV2bzczOXZKTkJsRktLUk9KT0xlQTUwazZrRWZa?=
 =?utf-8?B?bk1qTXlqQm9NQlpVUlh6NEFmU0ZGQVk5TytSZGFMeHViRkd0NTc3bFJDQmlB?=
 =?utf-8?B?VzJ6a3REM0E4TE41THVMUE5tajNOTUxScDViakE5MENTWXlVcUVlc2huRWZO?=
 =?utf-8?B?Z1p0WnJkUGhhNWVPLzJ1eEpsam1xbUNSOEtCSWlpZWE3UVdSY3R4aEZDNVNX?=
 =?utf-8?B?ZzRRUGpKRFNHN1R5U1d5VHRwY0IvTVJzanQ5b1Rrd0tIT2d0QWZkR242dXlC?=
 =?utf-8?B?YlIwbTBFUVluU1luWHlNQm1VenhySlFWeWhBVjB3dStDaFBnQ1FydGFOVkFk?=
 =?utf-8?B?NFhBeVFiZUJuYjRteDNvdTZtNHV1RWk0VEd0ZGJHeVlsNEdmMDh4QWhOaldY?=
 =?utf-8?B?KzhtS1d0YUEwZDB4Z3FmeWduUkFCMDBDTXBsMHA2Q016bExJQUJJc1dQei9u?=
 =?utf-8?B?RHNpSmFPckJ3ZjJidkhNMHBPMFo4NGJSSTlzckY2ZWxwbVk4QUFBY21Kd2dX?=
 =?utf-8?B?RGVnTlNEZmxQR1E4YmNxK3VLMTlSY0UzYjRKZC83eGpvcS9JV2kvNkJ0L2Rv?=
 =?utf-8?B?UXNzZmYwSW5sdXhIYzNXb2xxczdqUFpORU1IRytONkFjbEJ3MkdLTHRmeW00?=
 =?utf-8?B?OTNhSElSUU1vTEVHbjVHMDFUelpQc1dXbGRmRjV3dVF5WHFvY1ZkTVorNkFv?=
 =?utf-8?B?YS9CUkhSMGtjcEc0R2Jobm5zUURBQTRVazRpMDlVdUhPaWJod3ZpdVRsRXFt?=
 =?utf-8?B?TnNGNFVEVlBlNCtTOXhWTWVrRmViRUJEZ004NHZseDhJZjJ0QUlZT0NGdkk2?=
 =?utf-8?B?TTlNWFhlUjlSaUY3SE9WbkY1WWp4dlhZS1BXS3FmTHdhMFhqakRSTFlreUxU?=
 =?utf-8?B?eUpPVGo2SG1xeFgvV2JyNlVhN0hWQ3VnZWhidDZGNTFmb0RwbDhocTJTR2xQ?=
 =?utf-8?B?YUtSNG5XYjBlUEM5WmJTUEEydEF5OWtRVGZZWmUzSE9CVWYvSVVCR2dYY0F4?=
 =?utf-8?B?WUdYVHc4NGFGMFB1cHNmeXB5TWFxd01jcUFkelhSV0M5OXpsWFlxNkFkVEVC?=
 =?utf-8?B?bHoxTEdiaXdBYnZudUdvQ214RzJ5K2dDUWpyUkF1Y2orWmUxTGFKSkFjMUdS?=
 =?utf-8?B?dWZQZVIvQUNLdU0zYVRLZDkzWXprbU55TFNOcnJya3JOaWR1RG5UeFhrOWsr?=
 =?utf-8?B?eTZBNk5lUVpVSi9uMHJOYVd6ZC9jeFVnSjNUU1RRZzVYME14a3AzVUUzSUYz?=
 =?utf-8?B?SGY5TFp3RGJCckdpQVI3eHRWYWQwOGRnVG9OZklDbkV3OWp1bWdTb2tvQjhD?=
 =?utf-8?B?UjkveGprUjkvWit0S1d2aUJJN1dieWt4aDFBTzRTY3hucWhKWWlOOVVLQ0dK?=
 =?utf-8?B?bUdOd0hveE04MkZPeTVLUDd3MzJuYU5YblZxQUNzQXVlYkpsMWk1RGNsb2xU?=
 =?utf-8?B?RHVZcTFLdHAycmo4Uk9ubEZRbGFBRnJCTkZWZ1o1Z1ltTVpaYkhWRmUyVldp?=
 =?utf-8?Q?JTbkahGzgzFRElCH7j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296862bb-6c4e-4151-2dfb-08df2b79422d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:33:11.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAFxBGbSYFT7OUgGrSnU9Pm7jIutXKtpD7nM7x4qx7PeW3hxrfCFAND4meptMxVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
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

On 10/13/26 13:21, Sunil Khatri wrote:
> MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
> userqueue never got its VMID's page table programmed. Add
> amdgpu_vm_spm_update() to bind the fixed SPM VMID's page-table-base to
> the reserving VM's root PD when that VM holds the reservation; it is a
> no-op for every other VM. It is called right after a successful
> AMDGPU_VM_OP_RESERVE_VMID (amdgpu_vm_ioctl(), under the root PD lock)
> and from amdgpu_userq_vm_validate_and_restore_queue() (already locked
> via drm_exec), the two paths that can actually change the binding.
> 
> amdgpu_vmid_free_reserved() waits for all work that used the reserved
> VMID to finish, then unbinds it to a dummy address under the same lock
> that clears the reservation, so in-flight submissions don't suddenly
> fault and stray SPM accesses afterward fault instead of racing a new
> reservation's binding.
> 
> Both binds go through the new amdgpu_gmc_bind_vmid() helper, which
> pairs setup_vm_pt_regs() with the matching TLB flush for a VMID bound
> outside the normal per-job VM flush path.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 24 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 13 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  7 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 47 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
>  6 files changed, 91 insertions(+), 3 deletions(-)
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
> index 074c6942d83b0..e5d84a786c4f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -633,16 +633,27 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   * @adev: amdgpu device structure
>   * @vm: the VM with the reserved ID
>   * @vmhub: the VMHUB which should be used
> + *
> + * Waits for all work that used the reserved VMID to finish before unbinding
> + * its page table, so submissions still in flight don't suddenly fault.
>   */
>  void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub)
>  {
>  	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> +	struct amdgpu_vmid *id;
>  
>  	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[vmhub]) {
> +	id = vm->reserved_vmid[vmhub];
> +	if (id) {
>  		vm->reserved_vmid[vmhub] = NULL;
>  		id_mgr->reserved_vmid = false;
> +
> +		amdgpu_sync_wait(&id->active, false);

amdgpu_sync_wait() intentionally excludes userqueues (both KFD and gfx). I think that is fine here, but we should probably add a comment.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +
> +		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
> +			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
> +					     adev->vm_manager.spm_vmid, 0);
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
> index de992405ed718..7fd6215510a94 100644
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
> + *
> + * @vm's root PD must be locked by the caller.
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
> +	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
> +		mutex_unlock(&id_mgr->lock);
> +		return;
> +	}
> +
> +	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
> +	mutex_unlock(&id_mgr->lock);
> +}
> +
>  /**
>   * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>   *
> @@ -2958,9 +2993,17 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
> +		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
> +			amdgpu_vm_spm_update(adev, vm);
> +			amdgpu_bo_unreserve(vm->root.bo);
> +		}
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

