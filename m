Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDC8C05027
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 22:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F98C10E3D2;
	Thu, 26 Jan 2023 22:50:17 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B0F10E3D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 22:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fim63qfM7Y8oZEwcITKh4kt5qT3uMXzsd4+IoxiexBdZYJA88x4zkOxn7ZJJB7p6rHYbWY5BZhc2lqYCtAFOxr6V5CUSJJ/wVxf6jlmdrrZ1/MO6MjbxjIrbeQF7TabFsUOZbAoeI6PBj/pVUm1D9ebCiRWsZ6CXMJa2kuuujhDi8HlQRnMurjDsNZSVqDQxTh8CKOjK9cj7FzqrL5vKp8heBQp2ZOz/GSvr7QrYbTbf9VceQ7uYjy2dFqtwReGtxZa+z61TSZiFkHjpSBp+vpK6odDfclIlD7DwINcWn94NTWNgVWimt1CbJzzKmyv3sWmuWq8pBiE1UjQ7mm2Bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N65EsVWqAuVYPtrvIZ5gAxIPnTlaehe9AnlEnkT78Q=;
 b=G9i31BJmR09ha5Y13h0CXIT9I7cSKYO7hkiEGG3Y5dOFSV5JIhHGDTuG1KOacxU2HJgjou6zOID65eJ/3EgXv7LoBQcZ12DAakuBf+EBRZ0ZnejhWudH+72qPQV1J9TzOYEDVa/uptejITFjoz3q+Llko3Iva2jbC6EouJ8XlHAlZGtJaVyEjx1sjo+Coh5lOS+T40YkWIBeWOjPwexP1Uvh3OzzZasthEs6SeX4CPlQZrDxv99QDUzPJ3EaFpYXfuFvVLw9Q3bTI21C6s/HlqeEBwQkb8vKcvOiFQVWL5fVKZCUwAqzu0epp1auxwIjd7QPjypbv18X9MjUVWAiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N65EsVWqAuVYPtrvIZ5gAxIPnTlaehe9AnlEnkT78Q=;
 b=iWEPEDGQNl8jCwnq6yIDvnuVvw2a43Y2E4ttkObJ84fPZ0DIQVziihEFZF2w6GKRIUSoWETWi63N2F3KV8svXPhMe+h6098ok0ttZomZii+0SjdXXmk1UKqH44vWfzM0yZBTtCjcLO4tOHiicnV0Vcv9e5XR0or19RpKxtg0TGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 22:50:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 22:50:13 +0000
Message-ID: <f3d6f606-da08-b2b5-43cb-2b8197c51f95@amd.com>
Date: Thu, 26 Jan 2023 16:50:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: drm/amdgpu: add force_sg_display module parameter
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230124151318.605240-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230124151318.605240-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:610:b0::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 208c82d0-0a5d-4933-8385-08daffefaeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjtIcH5DupHBxUqvy1WiGmMEFl+Sa9PhNyv884vJ7nrA2+BXqrzsXudVqoDGl+bjqyv7vy5Ds0Q34nPzCmagID1zCQifmA6/f2750Fkw7htAcmpjuY4Kyc54NYBajExqRmCbVB+DoTn+09yL3XIGS5jAaP3aYGQZ5kUSkG+7w/QHX85w/y5mTnVZuKqs5dlKw1wTKMe4t50OhUExxUyMPw4nX2iXDXqZF6RP+Zi5zu8L4B2g5HvstVDd72P5RVgMFyzIThOv4Vf5CycCGuaCumXbDSIe4xk7kSj4uC1ndBBn4hTl59klwPoNlBEoxwQqBiu0n7xHS81wq9WMtZHZ8/Exw4vkW023czMR72h5y8m5VvCIeukqHQEKmnZpHNY89UBZNiMYkIT39sFcc3bb97TdUm/BZAjtD8cGeDkbCaHjZFIiYkEkpYLQ5OOn+Z1KOytrAKp0dtywSyUtwsU6kUll1shiWyRXWHzb0OmEB1/hQ2jsACs2OpTIXBVCSJSVDoxae20Kv9CNQwX6uKB42NTikoiSqsGO7PQ9v6EQhpzUwrmcU54tUylFzlEhgQxRPw9lkvdEF8YCD6xUUn1t831mLFJi/27wWKJrtypXGP193AgClUuNESTH4SEEmxNaRTVHRQLr1EkOCmHUzQcdUgLUtE5UvLWt9I8OxT4//Mao9naWUIBylSlMiGrJ70xltVJUJCsswJeSAqPRhgRNsuJPUVWE/SM8GAX67EfX5uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(6506007)(6512007)(478600001)(53546011)(31686004)(26005)(186003)(31696002)(2616005)(86362001)(6486002)(316002)(36756003)(66476007)(66556008)(66946007)(38100700002)(83380400001)(41300700001)(8936002)(5660300002)(8676002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhOSXNiSnljNkRxWGt1RFhlOTBzTThlRUdqbml0NnRIcDhGc0JnU1o5S0FY?=
 =?utf-8?B?MXdtaWkrbFFJQ3JVZXJFQ09PK3FMV2cycXRuODFzc1V1T0lZc1VnWWI5UDJZ?=
 =?utf-8?B?dW1Yb2QwckFWUXBKMGdIYlRSMUR3THBmTUh0dnd6ZmNtenhFdEYxN0w2bVph?=
 =?utf-8?B?eVpENVp4elVLSXpOd1EvTjFoaDdvVEtlSS95RzdIYXovSStVcTJEWDc3dGJF?=
 =?utf-8?B?ZW1BNm5IaVNLOWRtSVNRaGpSSFplRDFsekZFUzdqT2NvSUsrUTFUaDU4WlR2?=
 =?utf-8?B?UWdRUldFSUx4UlBZQW0rMHBiSkZobFdUdERpVDNtWFpIVTBvajU0Z0NUMTJs?=
 =?utf-8?B?ckkwT2hCUnpsaWtCRFpvbEFpUXRIM05FYlZMcm9lMnh4NnRma2JNeHNxSVVw?=
 =?utf-8?B?SFZhVHh6bXNTQVBuQmxxVXEwYXAwRkY2K2pHbmtpZzZtSXA0QWF6MFVCbjFn?=
 =?utf-8?B?MG94ZUMrYnFZVDdnYmEvWVpuNmNYWlVWK2ZQTGF3eGRMY04zbnJCSzJLYzdp?=
 =?utf-8?B?Y29pUFV5S1JPTFJabktlOUZKOTNpRzZTRDhEbC9BeE5idHVJd05LdzZYaG9v?=
 =?utf-8?B?eDlqZ3ExNkVPY21SWE9EbERYbyt2QmNrdGZxVFlSVkk3WFFEQ3BFcHYwYlly?=
 =?utf-8?B?WDJwSmFOT2xtMWVaOGcwMnE3c1gwT1JCMGR3Yy9aTnBtVEFDL0liTm5Pa0VM?=
 =?utf-8?B?NDdJK3lMQzBLOVBlcnYxeklvT0tGblEzYWhGdjhkYWhBUUpUZzY3VWVkYWJ6?=
 =?utf-8?B?Tmk5K1RPMEp5K1Brb3U4V1RTUWJZQ081UVhGUWZ2ZFNPbnhPem1zeUVYcTRL?=
 =?utf-8?B?V0ZzV1JKOVpkZmh5SVVRM1BnYVdnemNyUDJWVmh2ZzR6a3VoUVV4S1pTdTZF?=
 =?utf-8?B?QlF1bTZBWGVmdHcvSnJKYWpXS3RhRURWNkxldUtXQVBLMFZBK0tLQVJvbG5y?=
 =?utf-8?B?Y2haZHp3MFBRS1dUc0tSa2ZyTU16Vi9MVVMwQnVlamxvU0NYSDhsMDFrVmo4?=
 =?utf-8?B?aU9OejQyTTU3NDBiWkJ5Vjg4dGsrT2dQdk14N1BsR1FxT1p1ZEtCd0NPcXB5?=
 =?utf-8?B?clo0NW9SK09QcDBHSys5aW1SMDdNZjVqT1FVTSt4OExIZnRqS3pPZVUzUnRz?=
 =?utf-8?B?YkVQUSticGhOU1lxNmk2by9mSnN2NkVMTk1RbzdoSXdBeUlPQ0x5MXArSWRK?=
 =?utf-8?B?YkJHNmVrRG9SYWQ2cHk0WkhvVkVQQXg4amhJWXREOFM4Z1cwbkNjbDBPZ0lC?=
 =?utf-8?B?d1UrR0NwejdObFZwMEhUczJuQnF1T1ZEbmhLSXRDQU5oUDdiMGxlS2hqU1Rt?=
 =?utf-8?B?eDRkcCtrTkxaMlgwSUJMWi9mZnlleVBHZ2o2M04rc1ZFeEJ3SnZTY0dHQWp6?=
 =?utf-8?B?aVQrTVJDQWJPQ0k0VzVkZjlpdXEveWJlSjhFSmIvMnFwSWRSY1Rlb2FGNEw5?=
 =?utf-8?B?OWpPQkRpYUZ6YzZCSk8rZjdTbkI2Y2FkNXU4dFVQNVdnQ0YxK3RJNHRYVDRq?=
 =?utf-8?B?cjB6R2NQMHRQRk5NQk1udzBjU0ZxSFdUa0t1RHhhSHJHc3J1MDJ0dzFhb0wr?=
 =?utf-8?B?QVE4T2lnM1pCNE13cno4aExkMHBJUlptWXR5WmJVVjhtQStYbVlZMk9CNERn?=
 =?utf-8?B?RjhmakE3cENmK0IrVmMycEEyZEV2dEJrSFVtZ1ZxdmU2ckNLQ1hnOC9QNTAr?=
 =?utf-8?B?TGMwM08wdkhYeURHOFE5MlU4Vi9tSml2RmVXeU9sbGlrYVVia1djQTlTcERo?=
 =?utf-8?B?bHNJWjAxTXdobzdzYkJDQjZ4RzlUeDBzcldOWTlqcmlMQVBzS3IyaTV3QThm?=
 =?utf-8?B?MTJuM0FCSjY1aVBmWktiaEt1SFpSMzk3ek1hVVdNSll4RXJPdFdSYXVYRXNT?=
 =?utf-8?B?bDljaGlzam1KVjNzblZtZHNhanhWb1dnOWs0ZVIrZEMvd1hvek84aDJFcVVi?=
 =?utf-8?B?SlFnWS9hMVFUNnZaVEFFeGdDSHRJQjVJa2JTR29ibzFScHROSGZOcXFqZzhD?=
 =?utf-8?B?TXMvUnVWc3ZUVnJ1Vjc0cFVFOHhiMjA3N0RHQUhjL2RxL1ZRRTFGS2k0R2Ni?=
 =?utf-8?B?NlI2Q3BrZklFYWRucDRPTmlaSHlsU2Nod1hnYTgwckNuS2dkSDhrNnpod3lv?=
 =?utf-8?Q?Xc4MSKbmAjOHiDf0ki7Vw18S7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208c82d0-0a5d-4933-8385-08daffefaeff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 22:50:12.9281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHbc56oQ2T6Ivkc3775tsAY3Um6QcimQWLKRe5BqJPSbzoYoCgh/UaANz+/VB4EuWqvmzijXO8LHhxFpOtHnuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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

On 1/24/2023 09:13, Alex Deucher wrote:
> Add a module parameter to force sg (scatter/gather) display
> on APUs.  Normally we allow displays in both VRAM and GTT,
> but this option forces displays into GTT so we can explicitly
> test more scenarios with GTT.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 ++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 872450a3a164..73d0a0807138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
>   #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>   extern int amdgpu_vcnfw_log;
>   
> +extern int amdgpu_force_sg_display;
> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a75dba2caeca..bc0eaf2330f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -942,6 +942,18 @@ MODULE_PARM_DESC(smu_pptable_id,
>   	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>   module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>   
> +/**
> + * DOC: force_sg_display (int)
> + * Force display buffers into GTT (scatter/gather) memory for APUs.
> + * This is used to force GTT only for displays rather than displaying from
> + * either VRAM (carve out) or GTT.
> + *
> + * Defaults to 0, or disabled.
> + */
> +int amdgpu_force_sg_display;
> +MODULE_PARM_DESC(force_sg_display, "Force S/G display (0 = off (default), 1 = force display to use GTT) ");
> +module_param_named(force_sg_display, amdgpu_force_sg_display, int, 0444);

To discourage the use of this from non-developers, perhaps it should be:
`module_param_named_unsafe`

That will taint the kernel when it's used.

> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2d237f3d3a2e..78dc5d63a6dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1515,6 +1515,10 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   	}
> +	if (amdgpu_force_sg_display &&
> +	    (adev->asic_type >= CHIP_CARRIZO) &&
> +	    (adev->flags & AMD_IS_APU))
> +		domain = AMDGPU_GEM_DOMAIN_GTT;
>   	return domain;
>   }
>   

