Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28918CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 20:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A775510E0F7;
	Wed, 30 Sep 2026 20:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EHISc3CB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DAAD10E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 20:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5kzwjgifj7JiIEdftOvN/c7gRbz09wHjlglZjkGZJDcpEHItGCa/Y99In8hBT+NSbqEhYS3Btx24mTzDpgNWHW0I/iD1GCg0GLKGE2wlmjqZJFfIIn5M6+CoVK/Jl2smH8+poyw7C2oTzP4HTTWT9f4RD2uVx4RbB9ExNQjZbtrqlhrnP1pbJ2ONFyPO67zPz93MIbNrQYxZdVPRSx08qJwnYZa7+uN4teycqZzxoTUFJFugQc9VizbzXlJIG5Bu7ni7YsJUptaMJjoX3BM4gzsBx/XkX/kdFU0hYM2I2H7dhJhCy9ftfpapXLGDBnp/IYcGXtJ+glWfl90GGro1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suLcHKYG9fG8obVZgjN1aFT5SlzMD1pHNkH/Tpx1/wE=;
 b=G0j0rwD9twGbqaEQQZ+Rjg8tRhDgmrh9GwBPobSgIG8MsLw8hbRtpe4A0628w+GwK3pYsboiN005EHJT/2FWRjcfeAnl/PhFwJ+w5Nf+ECWeBa7qheZ3sSZh09uDPpGVpsPBk+nwxxBY5OH+SGwGgo5Nmzc+jZeyTFEjJlz2Vd9evnbigaxp6j3HooU17+pjUwY8kvIV9rFl53GkCvcAqYCMKPtn8yK4yfsRveZMd+0QFdDltBr//Uv203O4nko3vjIlKU4VvV6n/tzZBaOuDB9xSTMJeZZl6BoF0BBpP9erX6hPApQ8ur5lgwxuewoqVjGUzF/YQzWAGeZmE4FQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suLcHKYG9fG8obVZgjN1aFT5SlzMD1pHNkH/Tpx1/wE=;
 b=EHISc3CBPb99NNMJ8UAc4OjMyLp1gCFHyFdXS5Tpu7bzyksikT2sT2tkt0KNGPOIzRWEfCIU9FxKesgiszNwSObBaKACOOBYzoR+60y+cuZggmaE7t2QX59GKCQSrbeawyOLdPPcDB4T9FrkgmmJ5jEQw6GBYZipn07NbuhmD8Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MW4PR12MB7189.namprd12.prod.outlook.com
 (2603:10b6:303:224::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 20:26:57 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 20:26:57 +0000
Message-ID: <b22fa0b2-6da7-4a03-8ea3-fcf15f1b444b@amd.com>
Date: Wed, 30 Sep 2026 16:26:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add amdgpu_vmid_uq_mask_init() helper
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhu James <James.Zhu@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930144341.66352-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260930144341.66352-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c81107-219e-4b43-463b-08df1f312c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2JuNVWZIJOXnHrm1blN9ay4bJ5eW/JmcgJiCtIuC95hccTOHxY9laLnXbheh1rD0E9ieIgVUdAkFZcQkhulfsZN3WIl3gHpn7/MQcdxP8w11BEZsstuBtbDafQY218sl6FgfJjTO+gbj5JHbxR8weE/zZF4yXCWydhYTKHHub3PViyW6btRdJeYmWC5sTpzLbY3rXuM8g24LtkqJPzb5Roy7LntGqiCfAGcLirbdc5diM64dmenbOHI25AyXN0O/G+m/qFOwHcDhn6i9bN5m7Zy7Q0UwmvatbUtjVag3SOvdwzfdIeZhpAjnxteVGS/gnsRvcv2E7r+65pNutGizvPPNR/tD6ZPvIPYbPEBIAarCoAbRx3k17/KkFoR3FW4t7MZrv/4JqD4YKoEoH0kE1+Lu1sebp9zzycuuxLzB7ClFXLuXUEomgTpDMrml9s25FdEfxNRlaNIpKKRMsPlDk4ahAxqRLKCPdMJjm3hXmaysKFFQbWrRlsqxwSdZrFxstZ1EVqiNhLVoG5l+oU/YpRlt3m2T6mOHEUNJlDKP+NO1wDyOwCp/cRIhTlL/P6vQj+7sPqmy9F7fh+w37ikf/t9cRinVUrm4B0OfXpxuwMA0HaqJD48a7IDIJMeRcJoSfvVvcezynhuHITop8XFGeTQNzWTjGlVpXBCf+QCOh6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJnY1oxYm1QeFo0WGhIM0M2aUo1YTd3bHphTmFWQUxvTXBFaWJxV2FRQ3pZ?=
 =?utf-8?B?V0pRcGxtR0k1NFhYK005cXhXUEp0OG1kU0I2cTlYaEs1OTNjTXFKRTRlMm9t?=
 =?utf-8?B?bFYxN3hoTm9lWk5hS0NwR0psNVZ3K0lvallVNjJSdnZjUVJHVHNJMTltaUVo?=
 =?utf-8?B?SW5SbVA2UlRrVUlQMjB4U0h6Zndwd2llSnNJN0haY2NUOTV4dzlHOE91dG56?=
 =?utf-8?B?VW9ZYjRJL3JnaitRSWY2UUlHczROekFaN3lpUUxqL0kzQTRLRXFZWnlmY0k1?=
 =?utf-8?B?aG9vVjQ3ZWNPbW5hWHVUNC85U3BWQXVhNzkxMGpGTDlNNUM4SVdZM0NBbThC?=
 =?utf-8?B?elpJajNHWEEzTzBLLzdZdzE0TGFTejRVWHk3bDBzU0VIMkdZai9CMVhWbnFv?=
 =?utf-8?B?SVR0Y3JBY1J3eEVGVzAzaEdUUFZyNjMzMU1XYUZabldteFhLTWhidWN5aUFr?=
 =?utf-8?B?M1BtNmVNY013UkM3SUxDZE5JZlplbDZwMXJ2cnhTR1JoK1gvRnBFZlZsVXFa?=
 =?utf-8?B?SDdDUWF2TlV1TDY1SVNwTXNqNk9XKzBLV2FNWXJPRkdXL1luaXRMczBMLzIy?=
 =?utf-8?B?RU1jZFV0cFVkMFFkTnlGTjdFcmR1dWRGYWFNVXpsNEtGUnMvYmlKYzdtdHNl?=
 =?utf-8?B?ZzRBNEJINUozaytVeERDSGowVFFscHZiSlF3KzBRN2xRMm5WcEE0R2JFcnZw?=
 =?utf-8?B?TEdYcGJ5OHN6d2pnT1BqaHdGWmFiSGNzdkhsQjd5dlJSc2xJWnFzNmZmK2tu?=
 =?utf-8?B?WTZZVGlMWE4wNFVkRVJvUUdWeFNVUk1icU5vQUtDQkJXTXpNMnRhN2lIR0Vs?=
 =?utf-8?B?QnpteDJOSmdjYWVtUExmVm5QRE0xdHRJL2ZwbUNUeEdDMkxydGZQWXZSKy9F?=
 =?utf-8?B?V1ZBVUVNRS9OS3lRWFdXa0VreTk3bUtaVUtFSXBqdk5wYjVFRkNZcHlabGs0?=
 =?utf-8?B?YXJLMXltdFk5YTRpbDViRzBxUXR0OCtSMDUwb3o1RU1paXZKMmJGWEJVWThQ?=
 =?utf-8?B?WVZoKzdlWWJ3UHp6MHN1a25nZ1FWalFFSWtBM2FBQk53ZkZaVmFaaW5ISW0y?=
 =?utf-8?B?Nm5xZm9RMUlQcXRNSXNUWlBZQmNOZ3I3OVh4SnZvNXBLNHZXZHpYSTNhSUZz?=
 =?utf-8?B?TGtqTVZCcnhIdWszaitSdWtweGpzdkQvV2k0ZkhQd1pDNXB0QVArcTh0VXY3?=
 =?utf-8?B?TklaUHE1YzVDdUhTLzRCTXNpNWhkNElBUUpDc0pSa3VxNHNiaitucGdjZzRz?=
 =?utf-8?B?M1RyQmJHc0pEODZvZFNHVHdxY2VsbGtPMXBSU0l2UjNrVzk5aDlYejYrMFRn?=
 =?utf-8?B?SmhIYkt3eEVnYmlwSGlDRnFoN1BCRVBycFFEeUU4RWtLei9COUhSSWtxN0Nm?=
 =?utf-8?B?Q2FCTS9GSGFZWVNrREF5bHV5c3hDN21DbU1URElsVDlMOUE2Y1lYRUdzTXJ1?=
 =?utf-8?B?MUNPbFZiNmlQTnkxZVQzZzljOUlJQzUzNktPWXRtZC8yZ2lLRWVBeHVzRWs4?=
 =?utf-8?B?TkpZa0NuKzA3di9UbTRxbDFhbnVLQkhPVkZDUk5aenZHOW9SSXF6dWczdXl0?=
 =?utf-8?B?V2ZzUG9FbFVkR2hEMHI1SjdOSzVjZktuRUt6RmIwZEJrMit1UmpQMmRqcnc5?=
 =?utf-8?B?bVl5QTA3L09yeDBrMEp0UjlVL0JUT3JWWkRjNzNCeXp5OWthN3g1cTFaNnR3?=
 =?utf-8?B?Mmx6d0ZOQUFtMjN2bWhZRkpoSnlDbHFEQ3Q4R1JMeFJ6MWI5bkRia2toNkpZ?=
 =?utf-8?B?N1c1N3lpYkFOMnVwYmlkS0xrWDZvaHFOSDZvam5QUDRXRkp2MXVTd2ZYS0ZW?=
 =?utf-8?B?Unc2SHhVTVVpVEQ2V0lNZDBEVll0RW1XZWJLclBUN2Nwa3NWMVBmVVVWbjFO?=
 =?utf-8?B?S3RCeGNnK01wY0tSSVdTUnUrSWRidDFtV1BtNDEraTBic3g3bEpUamJsblIw?=
 =?utf-8?B?SitFR205dFZNVmJ3NG5SYzNmLytPVEhjMlQ1YnRNYmhIVm80NE9WWDJxK3ZZ?=
 =?utf-8?B?OUE2SGVqWnd3OFZUNFhvZDVtcVFpMnRIcTd3NzlnaGN6TjFGMHpaWU1VWWFj?=
 =?utf-8?B?SFZZbVBneU56UlFkMUM4ZEc1NVJ2SlB4U0hUNWJ2eXFXRzBOQzJPV1VjVUNX?=
 =?utf-8?B?dVp5aE9mOUlnYkdSZS9kVWZwaitJa013Q2htbGdYVlE2NHBwVnRmRWVOV08x?=
 =?utf-8?B?TFlwazFFSWx6NXU1aU15V0dnNkhkN1UwZE9sRzZkQnV4cFNKU3NZclA5bmtz?=
 =?utf-8?B?QkF4TW5pYlJnbGdnWVQ0TXJqNWI2LzJwajVvN1ZtMVVha29BaCt6THZSdXph?=
 =?utf-8?Q?xXCyWc3AxyNKT+HdO2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c81107-219e-4b43-463b-08df1f312c52
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:26:56.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nv9NqvULRFBn0j9aZebSZzA/kucDTaOMWJOwXU6yZn+83fRXlxV8zpjUTj1VOj9dGuO61H78ga+/2JB5TVXZ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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

On 2026-09-30 10:43, Sunil Khatri wrote:
> Move the duplicated VMID-mask-above-first_kfd_vmid computation out of
> amdgpu_mes.c and amdgpu_amdkfd.c into a shared helper, called once
> from amdgpu_vmid_mgr_init() to set vm_manager.vmid_uq_mask_gfxhub/mmhub.
> MES and KFD now just read those fields instead of each computing them.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 18 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  7 -------
>   3 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index afcfb92fb9f5f..c59a8f99ecdf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -178,9 +178,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   
>   	if (adev->kfd.dev) {
>   		struct kgd2kfd_shared_resources gpu_resources = {
> -			.compute_vmid_bitmap =
> -				((1 << AMDGPU_NUM_VMID) - 1) -
> -				((1 << adev->vm_manager.first_kfd_vmid) - 1),
> +			.compute_vmid_bitmap = adev->vm_manager.vmid_uq_mask_gfxhub,
>   			.num_pipe_per_mec = adev->gfx.mec.num_pipe_per_mec,
>   			.num_queue_per_pipe = adev->gfx.mec.num_queue_per_pipe,
>   			.gpuvm_size = min(adev->vm_manager.max_pfn
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index f8bda01f3bca2..c4c1b2d1e3cd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -646,6 +646,22 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
> + * first_kfd_vmid, shared by KFD and MES user queues.
> + */
> +static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
> +{
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		((1U << AMDGPU_NUM_VMID) - 1) &
> +		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
> +	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +}
> +
>   /**
>    * amdgpu_vmid_mgr_init - init the VMID manager
>    *
> @@ -657,6 +673,8 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   {
>   	unsigned i, j;
>   
> +	amdgpu_vmid_uq_mask_init(adev);
> +
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
>   		struct amdgpu_vmid_mgr *id_mgr =
>   			&adev->vm_manager.id_mgr[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index d1e956cf8e5b8..8d813c68450bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -111,7 +111,6 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>   int amdgpu_mes_init(struct amdgpu_device *adev)
>   {
>   	int i, r, num_pipes, num_queues = 0;
> -	u32 total_vmid_mask, reserved_vmid_mask;
>   	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>   	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
>   				adev->gfx.me.num_queue_per_pipe,
> @@ -134,12 +133,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	atomic_set(&adev->mes.userq_hw_queue_count, 0);
>   	INIT_DELAYED_WORK(&adev->mes.userq_notify_unmap_work,
>   			  amdgpu_mes_userq_notify_unmap_work_handler);
> -	total_vmid_mask = (u32)((1UL << 16) - 1);
> -	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
> -
> -	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> -	adev->vm_manager.vmid_uq_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
> -
>   	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>   	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>   		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",
