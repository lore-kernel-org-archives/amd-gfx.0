Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB325CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B4810E7F4;
	Wed, 24 Sep 2025 21:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TCA4Ty0m";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F4710E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsHu5iv60XAhs/V+MkVnVXpUPNWZw+I5qtbebRE+mpjg2wuJBccV2OhbK0yZd1HRGLXYgFOX286d3HvN9G0Xc9IHiVQ97GzG2EIEnfKjmmNyeQw429yuJehmkhx7KqL4PDuhPcWZz/RJNHbbdepWi0o9RRbgklY2NquEg1p4dPSELqFhOF9eSFJWvoSntWzr9omp9HjW5i9rlBpRzHRUWULi1Cq6/8XQr3+8reEDESPm0gibLBBieTEf4OtbwHYWAm7AcbnNy0p8jE+vQIiO/LLRemTORe4dvlAB3+ezyjF8ZmQiHbPE1GnlD/P+8EvBeakwsxyMdG7LxjGR53GLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjMg4y67GvSFK+QRgoktLMvu1LPkZEDr9KULIox2NFg=;
 b=UuYgkIloQ8m/MFfoF49j0VbZyyydy0K7VqckZLLUgYBxajy47KzPodWpbjS6HIGCca/mgYkycBa9rvDXjBMrYOgUxS9JcubPvfLJlvHQaLlRrQDZgbmVetR/+9R01v9o95oAhwLyc4nAMGX3unxInny7jAyCWsI0fBj2Wj4wA0cBCo7ur3msKRz0a3DVMvJgodbJ7Kz780x1ud62Ayw9SyF378JAVWXYEfKo1u7GXPjFmV4Uog+ZzXXFlqcFqMFOByGzfkza9sp49WBZZ3oRN1veh8N8wxBloxbekKrEmQEqeA6jT6Ifr+QjeuclmzZalQ8RFcnTGN1ZL4GqMHClqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjMg4y67GvSFK+QRgoktLMvu1LPkZEDr9KULIox2NFg=;
 b=TCA4Ty0mczCDGeVDPLhN8ytsR05c7ooaO/YtsTnF5gWPYB4wgvENFLaH1AvAuROlZsyn11lDd1IwBaE1spAn+s9bZy1/TZBHjgqNz0Bjp3RksgRFEx+gp/chG6DeOInPPBDoww4TS3QZGiVaXK/8mVt/a1yH5whf5apT8r7yTJc=
Received: from BN9PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:fb::28)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 21:33:31 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::71) by BN9PR03CA0053.outlook.office365.com
 (2603:10b6:408:fb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 21:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 21:33:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 14:33:30 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 16:33:30 -0500
Received: from [10.254.37.133] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 14:33:30 -0700
Message-ID: <67469860-de5f-4d8b-bf7a-eca5f64b968a@amd.com>
Date: Wed, 24 Sep 2025 17:33:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: revert to old status lock handling v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 <alexdeucher@gmail.com>, <Sunil.Khatri@amd.com>, <Philip.Yang@amd.com>,
 <Prike.Liang@amd.com>
CC: <amd-gfx@lists.freedesktop.org>
References: <20250911120950.3343-1-christian.koenig@amd.com>
 <20250911120950.3343-4-christian.koenig@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20250911120950.3343-4-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: c4378d8a-0c27-47c0-52f7-08ddfbb201f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2E1dmpmT2J1UjBoRFhwcDlWOEMxbVRtQnc5RkxlcHVzczhzaU5QeTdWR0JM?=
 =?utf-8?B?ZDh6RmhHTm9ZTHBRUlRsbXpncnMrRXlmN0x2aDRzN1RrZXJUSi80czJuRkxD?=
 =?utf-8?B?cFR3eUFpb3MrS0x6Z2FROC8rNnQxS2x0K1g4OWZiQ1FsSEYvdlgzK0FUQ29O?=
 =?utf-8?B?S0VNZHI4Ynp1MW12bzJQcGF5c1VmVzd0VDU2dWhnSWZUZTNCczNHK2k5VmVz?=
 =?utf-8?B?cTFScWN4cjdVVFk0UDRybFArT0F2ZDRYMDVBckI0Q1ZuQWZCZ2RjdmQvbHlh?=
 =?utf-8?B?alFpKzlwQW5zNExUUXUwQUJpV282N3Z4blhCWU9RcVVDVk11R05LZmlkamdR?=
 =?utf-8?B?Wjg3MnRHL0ZIVi9vMkpXOVduVkYzQVkvUWlOM2pKSUN0eUVzcG9BNVJFNUMr?=
 =?utf-8?B?bFFxdFE4ZTdjZFJBZUtLb0FpdUpqcXpoK29iSElGTmZ6eFhsVjNybnlhM1JP?=
 =?utf-8?B?S2VuWFRocjNJSTNFbktycmR6SWR5dVNzN0NJbjdwOGplakNXT09wb1J1Q0sw?=
 =?utf-8?B?RHZXcjBWMTh1SkU3L1Z3SWxyMXBUT3J3ZjJpSktFdXRMRWh2SlNSUFVFand1?=
 =?utf-8?B?WmF0MTlTVHVxV3FFSEtTWjJJRk0rKzVCcUc3c2dNc1ZXNzhpRmdFaklLRjlv?=
 =?utf-8?B?UXVmc0VMZUVub0IyRGxtcmtBZ3ZPQjU4bU1XNkVIOEZjMHAxcnhqN3BsYms5?=
 =?utf-8?B?SnhhRzVrY3IwYzdoZ3l1aEQzS3pIRGdjS3lvdVZhZFVTcW1FbmhPS3VGZkhr?=
 =?utf-8?B?RDNXSkhQK2Qyb2w4dUN0SUhsSGhwSHZmajFYM1dyQ0I3VG45V0RnSXVvRmts?=
 =?utf-8?B?WjViNm5sMm1OQ1lqWHlFVG5QTFJLZzhKNnFHaytucWRFTkR1dWF5aFRqeE5j?=
 =?utf-8?B?MVY2MzE0bTlGT3gzZTJHcTg4NnBJbnY2NDZXcWNOdkpHc2lZZVQ3S2dQUTBm?=
 =?utf-8?B?eS9EdHk3ZHVVbGxsWGIySGxrOU9iY0F5MHlLaytBMXFiekNlM2Z2OUo5ZUtD?=
 =?utf-8?B?MkZhK2ZFbnZ3d3VienVZNU5VbUppdmVHaUtUUElDYkgvMlBGTmVVVE5HRVE5?=
 =?utf-8?B?QUhFd1VPV3I2SWozRXhBMXR0aHVuMXJHTCtMSW9EVWtCVkRKTGR6UXkyUEpx?=
 =?utf-8?B?WnREdzdsTHBEU2gwK3hVVlA4VHNvc3lvSlZRbVV4cjlydkx2NGkrV2J0MUc5?=
 =?utf-8?B?cmhielRqdHF0cWtrQUorQVo5T3dRRGg3NlBvRHRacWxITEh1bkZuZHg4cXdC?=
 =?utf-8?B?UHF2Y1dWNmhLMlh6bk5nNzByK1E0UlhVMXAydXVXWENWNjV5cGhDdG1hQVY5?=
 =?utf-8?B?di9oeEdyVENWL1ZuWnZRZjNCbVI4dlhUeFR4NEtNSFBHNloybTJRSlk3V0NI?=
 =?utf-8?B?cDgyWGFmNnU2RmtzNjFyc2w1azUrOTNKNnpGdkF0Z2tGWExEWklpZ285ZDhB?=
 =?utf-8?B?Zkt0WXM2K1RrZ0JlVnpqRDZSY2c2TXJUQlpvcEw4bnhRdjdwSDV5V00wczBO?=
 =?utf-8?B?eTc0TG03OWZRT0d6enJGR1RpTk0veUkvd1BBVVErNjVwQU5FaHU0dHlJSDdM?=
 =?utf-8?B?Y0ZxZy9wZU5EbExrbGpVNVVYZ291ZFhoWGxhQXBVZXdncU11NmNia0w2QlhS?=
 =?utf-8?B?aVRlamN5N0V4Z2M0dUlSS295cjNadVhlMk5keGxLVjJaRWt4TVhCellMV01Q?=
 =?utf-8?B?N0dUODZobFJJSmMxWUJhbStuVDJ5MDh2MDlSUTgxbUZaNWZ3YUxKRXZWbXNG?=
 =?utf-8?B?UHN0MUg0cksxSVBVeDZjRjE0NTQxTXhxYTJCbU5HRXRxVjR6ZkF4VXUxOGFN?=
 =?utf-8?B?LzNOWU9IRGoyQXZTcExTYTAzRkZ6WjlzUEQydERpQWFtYUQ3NElFSy8vZ2Jy?=
 =?utf-8?B?VklsNE9zZzU3VmFPcjZkbjI5Yi9YQUJhQW5paTJORm9rUEVuZ1JrMzI1YWg4?=
 =?utf-8?B?Kzd3Z2lhQnc1QUVZbHV4VERSOEI4NnN3c0xuaDdsTmxaak1aVDFWbUZGQWFH?=
 =?utf-8?B?Y3hUWURDNG8xVGRYZzRkQUxJRnZTUmF6K1J5M05ZSWlPalZ4UzNDbEJ1S2R2?=
 =?utf-8?Q?UPQ1sx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:33:31.1773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4378d8a-0c27-47c0-52f7-08ddfbb201f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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



On 2025-09-11 08:09, Christian K=C3=B6nig wrote:
> It turned out that protecting the status of each bo_va with a
> spinlock was just hiding problems instead of solving them.
>=20
> Revert the whole approach, add a separate stats_lock and lockdep
> assertions that the correct reservation lock is held all over the place=
=2E
>=20
> This not only allows for better checks if a state transition is properl=
y
> protected by a lock, but also switching back to using list macros to
> iterate over the state of lists protected by the dma_resv lock of the
> root PD.
>=20
> v2: re-add missing check
> v3: split into two patches
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------=

>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>  4 files changed, 93 insertions(+), 102 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> index 0ccbd3c5d88d..428f5e8f1cfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -679,12 +679,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *ad=
ev, struct drm_exec *exec,
>  	struct amdgpu_bo *bo;
>  	int ret;
> =20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>  	while (!list_empty(&vm->invalidated)) {
>  		bo_va =3D list_first_entry(&vm->invalidated,
>  					 struct amdgpu_bo_va,
>  					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
> =20
>  		bo =3D bo_va->base.bo;
>  		ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -701,9 +701,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev=
, struct drm_exec *exec,
>  		if (ret)
>  			return ret;
> =20
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
> =20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index d0c95fb0ef81..fc36d61567d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>  	struct dma_fence_cb cb;
>  };
> =20
> +/**
> + * amdgpu_vm_assert_locked - check if VM is correctly locked
> + * @vm: the VM which schould be tested
> + *
> + * Asserts that the VM root PD is locked.
> + */
> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
> +{
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +}
> +
>  /**
>   * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>   *
> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
>  {
>  	int r;
> =20
> +	amdgpu_vm_assert_locked(vm);
> +

This is causing a warning with the following stack trace. Should callers =
acquire vm->stats_lock beforehand?

[    5.046056] ------------[ cut here ]------------
[    5.046057] WARNING: CPU: 3 PID: 750 at drivers/gpu/drm/amd/amdgpu/amd=
gpu_vm.c:138 amdgpu_vm_set_pasid+0xe3/0x150 [amdgpu]
[    5.046194] Modules linked in: nf_tables vfat fat amdgpu(+) snd_soc_dm=
ic snd_sof_amd_renoir snd_sof_amd_acp mt7925e snd_sof_pci snd_sof_xtensa_=
dsp mt7925_common snd_sof mt792x_lib snd_ctl_led snd_sof_utils mt76_conna=
c_lib snd_soc_core snd_hda_codec_realtek uvcvideo amdxcp intel_rapl_msr s=
nd_compress mt76 i2c_algo_bit videobuf2_vmalloc drm_ttm_helper videobuf2_=
memops snd_hda_scodec_component snd_hda_codec_generic intel_rapl_common s=
nd_rpl_pci_acp6x ttm btusb uvc snd_acp_pci drm_exec btrtl videobuf2_v4l2 =
mac80211 snd_hda_intel snd_amd_acpi_mach btintel snd_intel_dspcfg videode=
v snd_acp_legacy_common gpu_sched snd_hda_codec btbcm kvm_amd btmtk libar=
c4 snd_pci_acp6x snd_hda_core drm_suballoc_helper videobuf2_common kvm bl=
uetooth wmi_bmof mc irqbypass video snd_pcm cfg80211 drm_panel_backlight_=
quirks rapl snd_pci_acp5x snd_timer drm_buddy snd_rn_pci_acp3x drm_displa=
y_helper pcspkr snd_acp_config snd snd_soc_acpi i2c_piix4 joydev cec rfki=
ll snd_pci_acp3x k10temp i2c_smbus soundcore mousedev wmi amd_pmc acpi_ta=
d mac_hid fuse
[    5.046223]  nfnetlink ip_tables x_tables ext4 crc16 mbcache jbd2 ucsi=
_acpi typec_ucsi serio_raw roles atkbd libps2 polyval_clmulni typec vival=
di_fmap i8042 ghash_clmulni_intel nvme sha512_ssse3 hid_multitouch ccp ae=
sni_intel nvme_core sp5100_tco thunderbolt serio i2c_hid_acpi i2c_hid usb=
hid btrfs blake2b_generic xor raid6_pq dm_mod crypto_user
[    5.046236] CPU: 3 UID: 0 PID: 750 Comm: (udev-worker) Tainted: G     =
   W           6.16.0-MANJARO+ #121 PREEMPT(full)  5581d345f4f5e1e764643d=
15b2e2deacb80ec100
[    5.046238] Tainted: [W]=3DWARN
[    5.046238] Hardware name: HP HP Spectre Laptop 14-fd0xxx - 5CD411LN4C=
/8CDD, BIOS W81 Ver. 00.46.00 05/10/2024
[    5.046239] RIP: 0010:amdgpu_vm_set_pasid+0xe3/0x150 [amdgpu]
[    5.046355] Code: 50 06 00 00 eb 80 48 8b 86 60 03 00 00 be ff ff ff f=
f 48 8b b8 78 01 00 00 48 83 c7 68 e8 95 7a 7e ce 85 c0 0f 85 46 ff ff ff=
 <0f> 0b e9 3f ff ff ff 49 8d bf 48 fc 00 00 89 34 24 e8 77 a9 7f ce
[    5.046356] RSP: 0018:ffffd21fc26f36f8 EFLAGS: 00010246
[    5.046357] RAX: 0000000000000000 RBX: 0000000000008001 RCX: 000000000=
0000000
[    5.046358] RDX: 0000000000000000 RSI: ffff88bb4db401e8 RDI: ffff88bb5=
1da3c98
[    5.046359] RBP: ffff88bb63bd8000 R08: 0000000000000001 R09: 000000000=
0000630
[    5.046359] R10: 0000000000000000 R11: ffff88bb51da3ce8 R12: ffff88bb6=
3bd8000
[    5.046360] R13: 0000000000008001 R14: ffff88bb46b6e800 R15: ffff88bb4=
6e80000
[    5.046360] FS:  00007fc90e27c880(0000) GS:ffff88c2ec841000(0000) knlG=
S:0000000000000000
[    5.046361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.046362] CR2: 00007f80bfd0d000 CR3: 0000000111de2000 CR4: 000000000=
0750ef0
[    5.046363] PKRU: 55555554
[    5.046363] Call Trace:
[    5.046364]  <TASK>
[    5.046366]  amdgpu_driver_open_kms+0x110/0x2b0 [amdgpu d618420326a9dd=
0453fb7178a4017b35db3575a4]
[    5.046491]  drm_file_alloc+0x207/0x300
[    5.046493]  ? drm_client_modeset_create+0xd7/0x110
[    5.046495]  drm_client_init+0x7b/0x160
[    5.046498]  drm_fbdev_client_setup+0x96/0x170
[    5.046501]  drm_client_setup+0x6d/0x90
[    5.046503]  amdgpu_pci_probe+0x319/0x4b0 [amdgpu d618420326a9dd0453fb=
7178a4017b35db3575a4]
[    5.046624]  local_pci_probe+0x3f/0x90
[    5.046626]  pci_device_probe+0xd7/0x260
[    5.046628]  ? sysfs_do_create_link_sd+0x6d/0xd0
[    5.046630]  really_probe+0xdb/0x340
[    5.046632]  ? pm_runtime_barrier+0x55/0x90
[    5.046634]  __driver_probe_device+0x78/0x140
[    5.046635]  driver_probe_device+0x1f/0xa0
[    5.046636]  ? __pfx___driver_attach+0x10/0x10
[    5.046637]  __driver_attach+0xcf/0x1e0
[    5.046639]  bus_for_each_dev+0x78/0xd0
[    5.046642]  bus_add_driver+0x10e/0x1f0
[    5.046643]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu d618420326a9dd0453f=
b7178a4017b35db3575a4]
[    5.046767]  driver_register+0x75/0xe0
[    5.046769]  ? __pci_register_driver+0x5f/0x80
[    5.046770]  do_one_initcall+0x58/0x390
[    5.046773]  do_init_module+0x62/0x240
[    5.046775]  ? init_module_from_file+0x85/0xc0
[    5.046776]  init_module_from_file+0x85/0xc0
[    5.046780]  idempotent_init_module+0x106/0x300
[    5.046785]  __x64_sys_finit_module+0x6d/0xd0
[    5.046787]  do_syscall_64+0x94/0x390
[    5.046789]  ? touch_atime+0x20/0x210
[    5.046791]  ? filemap_read+0x39c/0x3d0
[    5.046794]  ? __lock_acquire+0x4a1/0x22c0
[    5.046796]  ? __lock_acquire+0x4a1/0x22c0
[    5.046798]  ? lock_acquire+0xc9/0x2f0
[    5.046800]  ? __might_fault+0x3e/0x80
[    5.046802]  ? find_held_lock+0x2b/0x80
[    5.046804]  ? __might_fault+0x3e/0x80
[    5.046805]  ? lock_release+0xdd/0x2e0
[    5.046807]  ? __rseq_handle_notify_resume+0x366/0x590
[    5.046810]  ? trace_hardirqs_off+0x44/0xb0
[    5.046812]  ? exit_to_user_mode_loop+0x3b/0x140
[    5.046813]  ? do_syscall_64+0x16b/0x390
[    5.046815]  ? trace_hardirqs_off+0x44/0xb0
[    5.046816]  ? exit_to_user_mode_loop+0x3b/0x140
[    5.046817]  ? do_syscall_64+0x16b/0x390
[    5.046819]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[    5.046820]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.046822] RIP: 0033:0x7fc90db1876d
[    5.046825] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 05 0f 00 f7 d8 64 89 01 48
[    5.046825] RSP: 002b:00007ffe53a77d28 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
[    5.046828] RAX: ffffffffffffffda RBX: 0000560845137e30 RCX: 00007fc90=
db1876d
[    5.046829] RDX: 0000000000000000 RSI: 00005608451392a0 RDI: 000000000=
000003f
[    5.046829] RBP: 00007ffe53a77dc0 R08: 0000000000000000 R09: 000056084=
51393a0
[    5.046830] R10: 0000000000000000 R11: 0000000000000246 R12: 000056084=
51392a0
[    5.046831] R13: 0000000000020000 R14: 0000560845135280 R15: 000056084=
5137e30
[    5.046834]  </TASK>
[    5.046834] irq event stamp: 179341
[    5.046835] hardirqs last  enabled at (179347): [<ffffffff8f3da95e>] _=
_up_console_sem+0x5e/0x70
[    5.046837] hardirqs last disabled at (179352): [<ffffffff8f3da943>] _=
_up_console_sem+0x43/0x70
[    5.046838] softirqs last  enabled at (173244): [<ffffffff8f326884>] _=
_irq_exit_rcu+0xe4/0x100
[    5.046840] softirqs last disabled at (173239): [<ffffffff8f326884>] _=
_irq_exit_rcu+0xe4/0x100
[    5.046841] ---[ end trace 0000000000000000 ]---

-Leo

>  	if (vm->pasid =3D=3D pasid)
>  		return 0;
> =20
> @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm=
_bo_base *vm_bo)
>  	struct amdgpu_bo *bo =3D vm_bo->bo;
> =20
>  	vm_bo->moved =3D true;
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
>  	if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
>  		list_move(&vm_bo->vm_status, &vm->evicted);
>  	else
>  		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -	spin_unlock(&vm_bo->vm->status_lock);
>  }
>  /**
>   * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_b=
o_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>  	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
>  }
> =20
>  /**
> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_=
base *vm_bo)
>   */
>  static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>  	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
>  	vm_bo->moved =3D false;
>  }
> =20
> @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_b=
ase *vm_bo)
>   */
>  static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	spin_lock(&vm_bo->vm->invalidated_lock);
>  	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	spin_unlock(&vm_bo->vm->invalidated_lock);
>  }
> =20
>  /**
> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu=
_vm_bo_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)=

>  {
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>  	vm_bo->moved =3D true;
> -	spin_lock(&vm_bo->vm->status_lock);
>  	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -	spin_unlock(&vm_bo->vm->status_lock);
>  }
> =20
>  /**
> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdg=
pu_vm_bo_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	if (vm_bo->bo->parent) {
> -		spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
> +	if (vm_bo->bo->parent)
>  		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -		spin_unlock(&vm_bo->vm->status_lock);
> -	} else {
> +	else
>  		amdgpu_vm_bo_idle(vm_bo);
> -	}
>  }
> =20
>  /**
> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm=
_bo_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>  	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
>  }
> =20
>  /**
> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(stru=
ct amdgpu_vm *vm)
>  {
>  	struct amdgpu_vm_bo_base *vm_bo, *tmp;
> =20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>  	list_splice_init(&vm->done, &vm->invalidated);
>  	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>  		vm_bo->moved =3D true;
> +	spin_unlock(&vm->invalidated_lock);
> +
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>  		struct amdgpu_bo *bo =3D vm_bo->bo;
> =20
> @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(stru=
ct amdgpu_vm *vm)
>  		else if (bo->parent)
>  			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>  	}
> -	spin_unlock(&vm->status_lock);
>  }
> =20
>  /**
>   * amdgpu_vm_update_shared - helper to update shared memory stat
>   * @base: base structure for tracking BO usage in a VM
>   *
> - * Takes the vm status_lock and updates the shared memory stat. If the=
 basic
> + * Takes the vm stats_lock and updates the shared memory stat. If the =
basic
>   * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to=
 be called
>   * as well.
>   */
> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_v=
m_bo_base *base)
>  	uint32_t bo_memtype =3D amdgpu_bo_mem_stats_placement(bo);
>  	bool shared;
> =20
> -	spin_lock(&vm->status_lock);
> +	dma_resv_assert_held(bo->tbo.base.resv);
> +	spin_lock(&vm->stats_lock);
>  	shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>  	if (base->shared !=3D shared) {
>  		base->shared =3D shared;
> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_v=
m_bo_base *base)
>  			vm->stats[bo_memtype].drm.private +=3D size;
>  		}
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>  }
> =20
>  /**
> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo =
*bo)
>   *        be bo->tbo.resource
>   * @sign: if we should add (+1) or subtract (-1) from the stat
>   *
> - * Caller need to have the vm status_lock held. Useful for when multip=
le update
> + * Caller need to have the vm stats_lock held. Useful for when multipl=
e update
>   * need to happen at the same time.
>   */
>  static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *ba=
se,
> -			    struct ttm_resource *res, int sign)
> +					  struct ttm_resource *res, int sign)
>  {
>  	struct amdgpu_vm *vm =3D base->vm;
>  	struct amdgpu_bo *bo =3D base->bo;
> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct am=
dgpu_vm_bo_base *base,
>  		 */
>  		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>  			vm->stats[res_memtype].drm.purgeable +=3D size;
> -		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)=
))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>  			vm->stats[bo_memtype].evicted +=3D size;
>  	}
>  }
> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_bas=
e *base,
>  {
>  	struct amdgpu_vm *vm =3D base->vm;
> =20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	amdgpu_vm_update_stats_locked(base, res, sign);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>  }
> =20
>  /**
> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_b=
ase *base,
>  	base->next =3D bo->vm_bo;
>  	bo->vm_bo =3D base;
> =20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	base->shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.b=
ase);
>  	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
> =20
>  	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>  		return;
> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm=
, struct drm_exec *exec,
>  	int ret;
> =20
>  	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>  	while (!list_is_head(prev->next, &vm->done)) {
>  		bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
> =20
>  		bo =3D bo_va->base.bo;
>  		if (bo) {
> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm=
, struct drm_exec *exec,
>  			if (unlikely(ret))
>  				return ret;
>  		}
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>  		prev =3D prev->next;
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
> =20
>  	return 0;
>  }
> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>  		       void *param)
>  {
>  	uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>  	struct amdgpu_bo *bo;
>  	int r;
> =20
> @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
>  			return r;
>  	}
> =20
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->evicted)) {
> -		bo_base =3D list_first_entry(&vm->evicted,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>  		bo =3D bo_base->bo;
> =20
>  		r =3D validate(param, bo);
> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
>  			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>  			amdgpu_vm_bo_relocated(bo_base);
>  		}
> -		spin_lock(&vm->status_lock);
>  	}
> -	while (ticket && !list_empty(&vm->evicted_user)) {
> -		bo_base =3D list_first_entry(&vm->evicted_user,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> =20
> -		bo =3D bo_base->bo;
> -		dma_resv_assert_held(bo->tbo.base.resv);
> -
> -		r =3D validate(param, bo);
> -		if (r)
> -			return r;
> +	if (ticket) {
> +		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> +					 vm_status) {
> +			bo =3D bo_base->bo;
> +			dma_resv_assert_held(bo->tbo.base.resv);
> =20
> -		amdgpu_vm_bo_invalidated(bo_base);
> +			r =3D validate(param, bo);
> +			if (r)
> +				return r;
> =20
> -		spin_lock(&vm->status_lock);
> +			amdgpu_vm_bo_invalidated(bo_base);
> +		}
>  	}
> -	spin_unlock(&vm->status_lock);
> =20
>  	amdgpu_vm_eviction_lock(vm);
>  	vm->evicting =3D false;
> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  {
>  	bool ret;
> =20
> +	amdgpu_vm_assert_locked(vm);
> +
>  	amdgpu_vm_eviction_lock(vm);
>  	ret =3D !vm->evicting;
>  	amdgpu_vm_eviction_unlock(vm);
> =20
> -	spin_lock(&vm->status_lock);
>  	ret &=3D list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
> =20
>  	spin_lock(&vm->immediate.lock);
>  	ret &=3D !vm->immediate.stopped;
> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *a=
dev,
>  			  struct amdgpu_vm *vm, bool immediate)
>  {
>  	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_bo_base *entry, *tmp;
>  	bool flush_tlb_needed =3D false;
> -	LIST_HEAD(relocated);
>  	int r, idx;
> =20
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->relocated, &relocated);
> -	spin_unlock(&vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
> =20
> -	if (list_empty(&relocated))
> +	if (list_empty(&vm->relocated))
>  		return 0;
> =20
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *a=
dev,
>  	if (r)
>  		goto error;
> =20
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->relocated, vm_status) {
>  		/* vm_flush_needed after updating moved PDEs */
>  		flush_tlb_needed |=3D entry->moved;
> =20
> @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *a=
dev,
>  	if (flush_tlb_needed)
>  		atomic64_inc(&vm->tlb_seq);
> =20
> -	while (!list_empty(&relocated)) {
> -		entry =3D list_first_entry(&relocated, struct amdgpu_vm_bo_base,
> -					 vm_status);
> +	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>  		amdgpu_vm_bo_idle(entry);
>  	}
> =20
> @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *=
adev, struct amdgpu_vm *vm,
>  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>  			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>  {
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>  }
> =20
>  /**
> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device=
 *adev,
>  			   struct amdgpu_vm *vm,
>  			   struct ww_acquire_ctx *ticket)
>  {
> -	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo_va *bo_va, *tmp;
>  	struct dma_resv *resv;
>  	bool clear, unlock;
>  	int r;
> =20
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va =3D list_first_entry(&vm->moved, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>  		/* Per VM BOs never need to bo cleared in the page tables */
>  		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (r)
>  			return r;
> -		spin_lock(&vm->status_lock);
>  	}
> =20
> +	spin_lock(&vm->invalidated_lock);
>  	while (!list_empty(&vm->invalidated)) {
>  		bo_va =3D list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>  					 base.vm_status);
>  		resv =3D bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
> =20
>  		/* Try to reserve the BO to avoid clearing its ptes */
>  		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *=
adev,
>  		     bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL_SYSTEM))
>  			amdgpu_vm_bo_evicted_user(&bo_va->base);
> =20
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
> =20
>  	return 0;
>  }
> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,=

>  		}
>  	}
> =20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>  	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
> =20
>  	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>  		list_del(&mapping->list);
> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, st=
ruct ttm_resource *new_mem,
>  	for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D bo_base->next) {
>  		struct amdgpu_vm *vm =3D bo_base->vm;
> =20
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->stats_lock);
>  		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>  		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->stats_lock);
>  	}
> =20
>  	amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2583,11 +2572,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>  	INIT_LIST_HEAD(&vm->relocated);
>  	INIT_LIST_HEAD(&vm->moved);
>  	INIT_LIST_HEAD(&vm->idle);
> +	spin_lock_init(&vm->invalidated_lock);
>  	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->status_lock);
>  	INIT_LIST_HEAD(&vm->freed);
>  	INIT_LIST_HEAD(&vm->done);
>  	INIT_KFIFO(vm->faults);
> +	spin_lock_init(&vm->stats_lock);
> =20
>  	r =3D amdgpu_vm_init_entities(adev, vm);
>  	if (r)
> @@ -3052,7 +3042,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *=
vm, struct seq_file *m)
>  	unsigned int total_done_objs =3D 0;
>  	unsigned int id =3D 0;
> =20
> -	spin_lock(&vm->status_lock);
> +	amdgpu_vm_assert_locked(vm);
> +
>  	seq_puts(m, "\tIdle BOs:\n");
>  	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>  		if (!bo_va->base.bo)
> @@ -3090,11 +3081,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm=
 *vm, struct seq_file *m)
>  	id =3D 0;
> =20
>  	seq_puts(m, "\tInvalidated BOs:\n");
> +	spin_lock(&vm->invalidated_lock);
>  	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status=
) {
>  		if (!bo_va->base.bo)
>  			continue;
>  		total_invalidated +=3D amdgpu_bo_print_info(id++,	bo_va->base.bo, m)=
;
>  	}
> +	spin_unlock(&vm->invalidated_lock);
>  	total_invalidated_objs =3D id;
>  	id =3D 0;
> =20
> @@ -3104,7 +3097,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *=
vm, struct seq_file *m)
>  			continue;
>  		total_done +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>  	}
> -	spin_unlock(&vm->status_lock);
>  	total_done_objs =3D id;
> =20
>  	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_=
idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> index 74e61e45778e..829b400cb8c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>  	/* protected by bo being reserved */
>  	struct amdgpu_vm_bo_base	*next;
> =20
> -	/* protected by vm status_lock */
> +	/* protected by vm reservation and invalidated_lock */
>  	struct list_head		vm_status;
> =20
>  	/* if the bo is counted as shared in mem stats
> -	 * protected by vm status_lock */
> +	 * protected by vm BO being reserved */
>  	bool				shared;
> =20
>  	/* protected by the BO being reserved */
> @@ -343,10 +343,8 @@ struct amdgpu_vm {
>  	bool			evicting;
>  	unsigned int		saved_flags;
> =20
> -	/* Lock to protect vm_bo add/del/move on all lists of vm */
> -	spinlock_t		status_lock;
> -
> -	/* Memory statistics for this vm, protected by status_lock */
> +	/* Memory statistics for this vm, protected by stats_lock */
> +	spinlock_t		stats_lock;
>  	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
> =20
>  	/*
> @@ -354,6 +352,8 @@ struct amdgpu_vm {
>  	 * PDs, PTs or per VM BOs. The state transits are:
>  	 *
>  	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> +	 *
> +	 * Lists are protected by the root PD dma_resv lock.
>  	 */
> =20
>  	/* Per-VM and PT BOs who needs a validation */
> @@ -374,7 +374,10 @@ struct amdgpu_vm {
>  	 * state transits are:
>  	 *
>  	 * evicted_user or invalidated -> done
> +	 *
> +	 * Lists are protected by the invalidated_lock.
>  	 */
> +	spinlock_t		invalidated_lock;
> =20
>  	/* BOs for user mode queues that need a validation */
>  	struct list_head	evicted_user;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..f57c48b74274 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_b=
ase *entry)
>  	entry->bo->vm_bo =3D NULL;
>  	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
> =20
> -	spin_lock(&entry->vm->status_lock);
>  	list_del(&entry->vm_status);
> -	spin_unlock(&entry->vm->status_lock);
>  	amdgpu_bo_unref(&entry->bo);
>  }
> =20
> @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_=
update_params *params,
>  	struct amdgpu_vm_pt_cursor seek;
>  	struct amdgpu_vm_bo_base *entry;
> =20
> -	spin_lock(&params->vm->status_lock);
>  	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek=
, entry) {
>  		if (entry && entry->bo)
>  			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_=
update_params *params,
> =20
>  	/* enter start node now */
>  	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
> -	spin_unlock(&params->vm->status_lock);
>  }
> =20
>  /**

