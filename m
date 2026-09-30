Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B73ECA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 14:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D37610E274;
	Wed, 30 Sep 2026 14:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUDupyXZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134E910E274
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 14:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZw5SUKwhLTklayNuHNho/r1vRtFH8T9O7aWGg5OjowxlJfKbsQE1t3gTByLFo121eNq83Uvn/OFGRHg/EercLqPrFCrqAHoSF4VrhpkTUKGsYlyzf7VZ9bi1A0orgF69wqrebxk6cQNKurBxtsma9iSCs3JR7m1EoxKUgJU9F8dj0vSOxLPw1skbcH6WQigLbynHZCte/rYNtMuRUNntZYWYTAnJxpfYRNXyjgYgrI++p2KGNoZIUY0BJIC9ENWiSA6aK/owG4cWahr3PE9jryr9FLSGnULeT7s+EpBQAAeyEEu7FcKTQfZwwku1qEVwHeuoVxQzGpPFYtiW+SS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNuBDs1CO2Hd+nYaQxFvCiiJkon/FoOH6usmm/ceyno=;
 b=QO6jyo0NQUCLHGDRHLvhpnzlFxP0GmQ7rugfjCHJsy4S/zJQ9jijvdNMSi4oOGBGacck7guiT4i/6qZjMWsryA/kQkONZM4m3rS4qqprCfj2c3QXMP7wsKXshsls+6KGpPR2HDXpKFwnOkSvgYlLzE9MbvcMqDjtaDFAa3lMf+6za6GCTpGpFRbXeFykYMZNhXWVt2diJ7F5cAMTmbyVoPHODIcHhL+XyE2ILasw+aOLjBzfqlE2+RO3vVqzHdp23C/7DPWBZLH8czWaik3J/kFvppnU1w4jzoF5lahsTEFAMESmncbwBiyhKJJd3cDtyts+8vGU4rE0tU7iCBjtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNuBDs1CO2Hd+nYaQxFvCiiJkon/FoOH6usmm/ceyno=;
 b=wUDupyXZ0XQt7qlnRPGBUbPtnXOu5Fog1YINoSSbezGOOfO0JJKuk0o+ERdUvHZsCLuAlVzlzLpD5LLXLSod5eDcmvyVEdj8Jb2CMrc0LysY4f6q6r5neMWJ+LXUXhdiut2Kt5OAl3Lx26id9IjereDkBc/juQugrXldAdUe+sE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Wed, 30 Sep
 2026 14:28:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:28:02 +0000
Message-ID: <6f0ea6ba-078d-460f-9dd7-1b96c7e5bb00@amd.com>
Date: Wed, 30 Sep 2026 16:27:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: add amdgpu_vmid_uq_mask() helper
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930141823.4161298-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930141823.4161298-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fc344e-d92f-4b95-9e88-08df1eff08c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jWq+W44PlBbp525JLQcLQi48BI6fnTbETZanFlZX7npgB3Vy4ZsBi3TBJ2aYoHULswdBqz9Le8mxIjKZLQhHBhLRdzAiDFC2iDUOqq4Cx25nN/sdDSB96mTGbSJwikdVni7aPFaGvMISQYwH55hmQxYnfPb1TOaMdEEEh/9dIR2bjgi7ns9OvbkU4JXhthql2zFOuJmRmIgQgsyXMiPxnnkUsW0G2CuDmfNk3H8jdrAhfhYhJ8Yuk8Lpgf8rhaYCdxcCzCehJTNHqs0pf6GV10A75+F1so08vOKoMzCK9ua1Urx8py+zsvHy0yzLpzHVRlOur7P3S5Lc0+yxHH/98lZ8rKFoQ5qaMgXdlg6eYhWmGIdGbD4WqGkAzZHmiWfbY9FBnzH/xX3UDtPgQKsQLIYlV3HMUubvz1uYc3v/vz6i44vlV0Ex91+ANUziAXvZ0dg099TNspiBY/W4kQBhinGRjEQSiSdK29+I906nv3o+MTR82t2ulJCCGwwHJYitf079duc7jjof1uNBfPitWDPq02XGFS4Ole1kr3nYrLYqdZp2thH4Sd8a/TyuPDR2mxDqQOWhFiSajpvZosZlflg+lqgGWw4Vf56LbFHjG17u2YQ8+Ty2k5MAO0Fae1vsmOgUE/b/9F0diww1D+2L6KGYowjhcfa1IP0KWpTvM/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JtWExXMkd4b0lHdFo2RldocWNmb3Ftdk90UjBYclFZenRKT0pLNHBodzFS?=
 =?utf-8?B?STBlcVZQR21mTzN2anN1RFBSSnJZVHg5Vlg1TnJpSE0xWUcvQTkxbDNVSjdH?=
 =?utf-8?B?RWNEb29vdGVsb3ByNTZjRStQa0xnN04yMWt1R1JHaDk0Y0ZaaFFoWVZEbWRn?=
 =?utf-8?B?cUtDbUlkODlZTUVVNzg4Zk52dUpKY3FQcEJsbE1zcGR4Q2pFbUJIbVo4RGY5?=
 =?utf-8?B?Mk03cjd0anpDdi9QSXVIcWRISDZXZ3Z4SURJYzQ2dWhFcEw0L3NqcHVLTWtv?=
 =?utf-8?B?NGdYZWxabUphSHNZK2JxYzRJV2wxTFJCbUJXZEIzdXZkakJmc2RGb2Z3SDcx?=
 =?utf-8?B?ejlkbEVnN1ByN1VGS1lPeDRWVE9wRDJRT21JRTdwcURQajZ0MEp4eWlkZnFu?=
 =?utf-8?B?M1Z0eUlIa1FDM0ZpSnFCNjRnak4yOHUwUk9wLzhhT29KZ010Qmo0MjlWNzAx?=
 =?utf-8?B?N3llRis5dTZVTkQ5TzVkNUFJQ2VoMzM3QVlxUll0dGR4VTFpOUV1eUxYZDVs?=
 =?utf-8?B?aVFWQ1RhTmNjR1I2SnBvL0t5ZVBhWHZXK2JKZS8vSFdhNUNIem0xS1hYU0hm?=
 =?utf-8?B?cUpVY0NrNXRFUHdORWZsOHFkczFER2dRU0JZSWxqbSt5WUVqcFNJQi9tZzdU?=
 =?utf-8?B?OW9aZXkzbXNKQngyV0txeCs1ajk2ZWhqUFNzRUM0WXE1VlRRcmhzL2FncUZN?=
 =?utf-8?B?MmlCWFNBK3VYWW1Hcmw0dTFSQktPdmdkNHVqWVB4UFFGYUQvWUpyQWthTDNw?=
 =?utf-8?B?Y3JFSStiSVhaWUdRb0M5RWVQQ1I3ZmEvalJ4UjI5RXBWVk1qZjdNL3BTR245?=
 =?utf-8?B?Vm0xRk4yOWxvUVpNY3pac1p5T0xBRGxPQ0dtOFVPS1pnYS9pZU9RK3E2ZzQ5?=
 =?utf-8?B?Z3h1TGVHM2ZqT3hMQ2lQVG55Q2V5UmlML21Kb2d2M1JmenRNOUZVVmpGVWtE?=
 =?utf-8?B?d096eFJ0RGtZTnA4bzVVdW14RnIwa0h2QW9uWEN1cTNtK2gzWE5RYkdZMVV4?=
 =?utf-8?B?aERsNHFXaFdpRWI4VEtRQkhsMWRKZGRDZ2I1MDY0dGR4T2Z1TnVneEI4K1Fx?=
 =?utf-8?B?QUpMdE45aDlPeUh1U0pCZFkzMzZhaUJnaHV1bk1JOGZxaVZCVXEyd2NkMTNv?=
 =?utf-8?B?MkxwTGI5REw4RWNxdWN0aWdINkErSlNxUUlnS0x4cTB4bFZPYlVCdlg2U05O?=
 =?utf-8?B?SUlQbmtBdU94a0pnRUpDclFRckRReU9uZjdtTjZlVXZUMEJSdi9HMWVyUThI?=
 =?utf-8?B?a1ZYTS93bkY3Mi9ZTmo4UzRlMEt3aG43WTNVS0t5ZDRqUmtkUERCUVh1RWRF?=
 =?utf-8?B?K1h6OGpEdGdJY3o3azI0T2ZGWEtzbitROW5EazkyRDFhSXJCZGprbmI4LzZh?=
 =?utf-8?B?amsxWHFsb0dZVkVKWHZ6dE56Yk52RFhZNnZ0RGpiUXRSV2hNVjVrMWNBUGxY?=
 =?utf-8?B?ZnNtTyt6bEpqYnVYZkVlRmtJSjZYZnlqUHRlOEpldlFSNjNPYTBDVkc1bmo3?=
 =?utf-8?B?RFkrSHBVWExJNjFsN2F4bGMyUHcxcXdCbm5KRnoydFZIZnlSMExRclBlaUd1?=
 =?utf-8?B?aW1wVjJiLzhaQjBrL0dzWUVwODFMNk9TR2VlUkxTVG96bDZOVmdwb0J0SmhI?=
 =?utf-8?B?L0R3REFZMUtaaXcvU2U3U3ZwOER1bEZoRWtrQ2tOTmRKZEVzellMb3o5MkdO?=
 =?utf-8?B?N3B6WkE5NklEUlV3RytpU3g0MXdTSEcxRVg2TCtLQ1MzRVoyMkZNQ3JBZHQr?=
 =?utf-8?B?V0lwTkhCUTFmVWtZRE5KZnFuQlRYanhmN0F4NmtiVS96M1dDbk95d3piOXpR?=
 =?utf-8?B?K2RNeDNYSXlzOWkrVmRxWXpVWUtxRCtqY1BQbnVreFNUTDlsRlVlb2Vqc1I4?=
 =?utf-8?B?RUR3NllSeWJqL0xrbzhhVXgycVBsRHVhSnBLMkZudzdkTG1vWFd3Tnk3bElC?=
 =?utf-8?B?Tk5rSi9PT0NwVEpJNW5QdU1zWVZjVVRHb0ViZVh2R2JOd3l0L0JZcmkzZ3Jv?=
 =?utf-8?B?THh6R1R4cUQ0Qldaa1ZFR1ArU3lmQWRDVG1lL3p0Zy9YZlloek42YlRKU1VT?=
 =?utf-8?B?M0h2M2FUdHFrUlFBdkZYSk84MUdoYS85akF4dnZVQ1VNT01YZWNsWk04MUlN?=
 =?utf-8?B?NHRaUDlUVTRHNTN4N2FZU1lzN2RmSDRQSk56MGw1dXc4YmNDSHFqNDk1MXNi?=
 =?utf-8?B?YXBBcVllNUpUbXdZZkVSWVEyQUkwS3lBa0RjeURMSDdRUGdoVk1ZWi90SjVr?=
 =?utf-8?B?WHlQWm1aUkVjR3pKZ09JckRMZGZkODNuWTNselN0ellMZ1doL0hBZitHbGVu?=
 =?utf-8?Q?k/i8I2Bz35hloA8/nN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fc344e-d92f-4b95-9e88-08df1eff08c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:28:02.4635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjxU7CjOdKkk058C27+8jmBSjHYDdkPs///VkkuKZUdDZgf4rtNw/idRI2EsGJz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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

On 9/30/26 16:18, Sunil Khatri wrote:
> Move the duplicated VMID-mask-above-first_kfd_vmid computation out of
> amdgpu_mes.c and amdgpu_amdkfd.c into a shared helper.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  6 +-----
>  4 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index afcfb92fb9f5f..582be4f0a3b76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -178,9 +178,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  
>  	if (adev->kfd.dev) {
>  		struct kgd2kfd_shared_resources gpu_resources = {
> -			.compute_vmid_bitmap =
> -				((1 << AMDGPU_NUM_VMID) - 1) -
> -				((1 << adev->vm_manager.first_kfd_vmid) - 1),
> +			.compute_vmid_bitmap = amdgpu_vmid_uq_mask(adev),
>  			.num_pipe_per_mec = adev->gfx.mec.num_pipe_per_mec,
>  			.num_queue_per_pipe = adev->gfx.mec.num_queue_per_pipe,
>  			.gpuvm_size = min(adev->vm_manager.max_pfn
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 4e37de79f0318..c94a085bf6503 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -646,6 +646,20 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  	}
>  }
>  
> +/**
> + * amdgpu_vmid_uq_mask - VMID mask not reserved for kernel queues
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Returns the mask of VMIDs at or above first_kfd_vmid. Shared by KFD
> + * and MES user queues, which both draw from this same pool.
> + */
> +u32 amdgpu_vmid_uq_mask(struct amdgpu_device *adev)

That is a good start, but I was rather assuming that function would initialize adev->vm_manager.vmid_uq_mask_*hub.

And then we use those values for both the compute_vmid_bitmap of KFD and MES.

Regards,
Christian.

> +{
> +	return ((1U << AMDGPU_NUM_VMID) - 1) &
> +	       ~((1U << adev->vm_manager.first_kfd_vmid) - 1);
> +}
> +
>  /**
>   * amdgpu_vmid_mgr_init - init the VMID manager
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 21d6a41d1738a..8e450abf2ab0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -120,5 +120,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  				   unsigned long vmid_mask, bool for_mmhub);
> +u32 amdgpu_vmid_uq_mask(struct amdgpu_device *adev);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index d1e956cf8e5b8..9424d94af465a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -111,7 +111,6 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>  	int i, r, num_pipes, num_queues = 0;
> -	u32 total_vmid_mask, reserved_vmid_mask;
>  	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>  	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
>  				adev->gfx.me.num_queue_per_pipe,
> @@ -134,11 +133,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	atomic_set(&adev->mes.userq_hw_queue_count, 0);
>  	INIT_DELAYED_WORK(&adev->mes.userq_notify_unmap_work,
>  			  amdgpu_mes_userq_notify_unmap_work_handler);
> -	total_vmid_mask = (u32)((1UL << 16) - 1);
> -	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
> -
>  	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> -	adev->vm_manager.vmid_uq_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
> +	adev->vm_manager.vmid_uq_mask_gfxhub = amdgpu_vmid_uq_mask(adev);
>  
>  	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>  	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)

