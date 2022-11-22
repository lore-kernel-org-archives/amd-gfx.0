Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B24C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5828310E4C3;
	Wed, 23 Nov 2022 01:44:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E2710E4C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiHcw98VKXg/yZp2wpWNTHg/TrZ/VlirPtusF7ZMDS81ATJEHRDTwhACljubZha/dWewi/jCG92Ifvz0+chSmuNRxm5CFLWyaZIv5BireNjr5aYCYmBC9aJPPq/6KZcZnS/akc7kAQdz+fENluESg5lCRj9HKolAZt5aCdrqM//oZEBNAVwpQwOm2JwDDv0zlHm16tSFJqDpU1LI/gv9Hdw4OerXmXovzgj/GyjIbEJ4dFgOSGDzXvmi+UaBOX2uJmmBGLn8RrYQhFicajaaKnHq0lYHpYhx1xM60Qw5HDkrAfJdp+TLRqEMZpq//328DRvw+pekFrS3HVZ9LD1cjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6HXRw0jmlQhSfxcHfNIHQayJGntFj5gEtRK2S9WuIs=;
 b=ExtHnH3wcPRxRzMsG3rLofXLLWLJk3bTnmSZQ9A/gmWE3fgPQPY7QKnufn8SM7hKAh0XPGvx5GjA/YUEhSN1/vNqBV/gY3LAgFRSVIjTpORLmW9L8J/DuU4+BMp+NYZwk259SOPVWNNrhBb7NY4sThpr2fymnAWLjgJaY9Zy/Tn8hqIgsEGG6RQgrN3w0/kqgFzmedFP4y29/fY1i37GY0fS9mhj2n0X6v66AuENWsqy/WRus/t5nQiLzUfZiMcGWzocQzRK+NNfVt+cdN0do3p2oQ+Je3eW6zKo3VSogkdpZz43maA3nJDIjZA7xy5PdXNtFDDQCSuhdxd3c6goqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6HXRw0jmlQhSfxcHfNIHQayJGntFj5gEtRK2S9WuIs=;
 b=s9bb8oVhtnoC/BK60FEh9Ku3TyP58xg8Kt9gMidahbuN3TC8kM48Q9m34xRYv8sBr2SG3+EOfPBYxAlhR0K4W4im7kiS6DdYFQKSxj6aA6RMnoRxD7SQWLCugOAdjj50S01V0DzoKhvSJ0E6hvhE3cScDFFnCq3wX44NA+VWP9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:38 +0000
Message-ID: <45ae7684-c25c-1957-bf49-8e690ce883da@amd.com>
Date: Tue, 22 Nov 2022 18:38:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 05/29] drm/amdgpu: setup hw debug registers on driver
 initialization
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-5-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-5-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 3733b03e-9d5f-45d9-aa3f-08daccf447fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8UjmVGtl8QDYbSNBrfTL+YDy/OVODNRpUj753iBImQNDaj8MUZmr5CfccUZKka2RSP6up6C0AaQ1Wo0FyysDDIKFFiFTuVSGj2zme98ZIz8kEJFdV/RyjD0YfH74fS7k0BK7tH+q3Kro4ahxpZUAbAr9xW4VdWa8Srvbm9B1r8WgLn5pp7CxAzyjpcO26rNGwMb6ad5eC4ShqxgzOQMqcZbW2BYYwbI/LnLpGTaZ/+S5YQ7G6qvSmdTTYevKQMxb5TPoMBsq94oRkyYZIUa/5eu8GJkGx2pfONmOSILZ3LeFikyfxqrAyI0i15I5VqMVbEaPfBsZxZgerBLXmN5WD6NH5PeJFdO5Ssj2st1uUM3c3bY4xAjBhIt/D/xQkQMcxs33KqFCIdTZuOB6xce1400c0EkpGQrpZck4WwDmpEglCiDOIpp+VOroibpWbfyFxC54wrhHhfus7+IqOYFZOzCEzPgbzKKupTfDdJYMQRqmEhVJ4qgLbhkTCfaKp7LAsp7L0YPAucukNJvaz8rRz3YQtT40lLPkEjw3FRL4bO87M/Rl6ZVdH2NLo+nDdafMlpI0cD16RFS9cD2p8HdJGDD9PSQvHO9Fhq0bnSPvpfp+vwuCSs1j8cLNIsIqlHdDqH0KZqXMNuCV/6b8zN5eoEY2APMvwRBJEDXb1WqgcDj6xZQdGc8spi+G/XFBlFA3WPFagGtbeesbS4kE6eLTxmmyxw19Jd4YfWzeDK7fKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6666004)(6486002)(30864003)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHEvdFRLS0IyK1VGTEtsRVQ3TW1HU3c5dFN5ZFJsam1UZU5NQzBHTDJzUlNJ?=
 =?utf-8?B?TysrMVBLNWFzdXFiRk12UVFNMDNQVGw2dXlnN0xzLzFybnAydWpyL29JQTJr?=
 =?utf-8?B?QjVtVzJQWk9iWTJhVk9TZ3Zlc2xWcGpFU2x6TVhWRWRMcHdSOXlhNEs3WnV3?=
 =?utf-8?B?ZFdSODJmR3NaS2hvTVhTNzlmMXo4SXVlZHc4TEl0TlB4ZHZyaGlrWWk4UVRI?=
 =?utf-8?B?VERVeTBDcnBaeUpRa1VUS0JvRXMxWUNiVmxLUE84TGxzV3N2T0VvM1pCOW43?=
 =?utf-8?B?MTB5YXQ4a1psdjZoOTZoSmIxaUhCVnhvRGRDM3FoNHUxT3hiUTBFZWNrUFA5?=
 =?utf-8?B?VkFhM2xlNGNndktONGQzdUNPNW8zaUhLYzh4MjRDUWQ2SWZtTmhnbWc4eGZh?=
 =?utf-8?B?R2xBVW02OGtoVkNQenJYNGZNOGFzT011MmZlMkVOUlZBWW53YzZmL3Z5N1Fr?=
 =?utf-8?B?OEQxWE1XVzRPd1UvMTdaOUNwRmdQN1NOWFM0RzlaTVJkTU83bEdUMitrRjAz?=
 =?utf-8?B?RjB1dHBZUTI0elYvK2JEL3o1VVROSENIdXFkc0FINlI2dkxYeWZ5OWNhTlNX?=
 =?utf-8?B?QS9pdmo3ZStielpMRFZHTU5jWDNEYVBRUWJ2cmFVYTdUdmFVRStXNHdPd2or?=
 =?utf-8?B?K1ZpMXJGRjRGSVhna2p3WjYvb2lLR3RMRXljUnYvZmhHaGpMZk1WeEpuRFR5?=
 =?utf-8?B?RGJnUXh1RDNMWWtHUmh2NSsxcHJ6a3VQUFZmUXhrazFxQTNZNEYybTl4RXl1?=
 =?utf-8?B?OGk4N0NWQnRPUGxKQ2Y4RHBjMGhwOW9pVVlmdDhMa2RmRjlXR1pBT2Z1ZlZQ?=
 =?utf-8?B?MnJiQ0dpalc0eG0ydDVQQXJncWhQR1RBYnp3VExyRFJyaUhTem12ZktXaGRl?=
 =?utf-8?B?aDBXQmNtNWxMeEhBZ2YwVHVKVVNjY1NvQkdnby9VaEJsNnhMOFp0TDlzU2dB?=
 =?utf-8?B?OHd4bTVqd09IRzdwbmo1eDJGdzN1ZWhPZExOZEdpVU14UFhENzM4dFdjTUFH?=
 =?utf-8?B?djNsczRkdytGdXdDSllSaFNvRjlITjB4dmpweUVYallIVUdMYmZENVFwRWYr?=
 =?utf-8?B?S0FaWk5iNk5GN2Z6dHYvY293Ymk0RlJsNXFjd2lJa3UyWTcvV2pIY3Zxamto?=
 =?utf-8?B?d0c4am9YQXJGRXh3bzN3SWtjWlFlOHRWNzhUOUxtSEtSR1dnb296b01yMnhC?=
 =?utf-8?B?UHN1UXJ0WmFxUmg1ZU1SYU5ZbXJmVE11NWhyaS9WQjNNVTZuVUpzODE2VHAx?=
 =?utf-8?B?YmNmOWtsd0tyRmVhN2Z6Q0x1UkpFeTBlNmtnQ0RuUVRIb1FGaUliRWtQWDhx?=
 =?utf-8?B?aXVFdzV0MXllTEFvbHR1R2hMZWQyY2QxZVhGZnBVYXJmYktkaDFBaVpSWkJ5?=
 =?utf-8?B?YzU2emd0WTNyNXhyYktsMmh2NDRKVm5iRmx2WVN4b3JiM3JaSGcwcUd5WEpE?=
 =?utf-8?B?N2FrbVo4RHkrSURha0dXQ1F0SlEvTW9lcHVNZTdjYnZSbUZ3N29yRkVWZDZE?=
 =?utf-8?B?S0xPK0psN0ZuM01wSjZSbk90VENIbW81QXBvRjJrNjl3N2xrY1lEYWRaMEdh?=
 =?utf-8?B?WkwxR0dBejJQNW9iM1BaOXZIWHhlOU91WkVwZENSRFpHK3dSNklWRVlPRHc3?=
 =?utf-8?B?eVErT01ScXIveTVTbVpWTHlyYWFBNW44WEFTYzJ0d3Q2Ry83RWR6Um12cjhx?=
 =?utf-8?B?NzZ2WkZqdnlYVXZ1a0FXYVlKOHNHZnVVTUR6dWJVaG1tQ0pzSDhVUXBFVVNY?=
 =?utf-8?B?dk14MDN5Q1FzVXBMc1ZpUStLSG5qc3o0eHhsUE9STi9qaFNBUDU4RlVwWjAr?=
 =?utf-8?B?KzVXSEdNV0VlMVEyV1hmWWhtaWlRWVpPbW5HNzhRNEVLM2Z5ZUNWWkxad2Fu?=
 =?utf-8?B?R0JaYVFZRjBEYUFlZlJZeERkZUpwT2l5N2hhOWJ0UHl4dXE5WkQrYXUzekZ4?=
 =?utf-8?B?YzVGQ0RoWnllK1c2c2pldnRJcms5czY1azlXRHJwSUpobTRneEJiZi9USTQx?=
 =?utf-8?B?cFFBVXVhQ3piQ0NkTXFOL3NxZEplcmtCcWsyYUtsUGR5SG1yendnMGMwRlBu?=
 =?utf-8?B?MERnb3Q5YlhEa2ZCL1h3Z29iMjlHYXlsOHMzei91cjlyYlZ5QWZnVVIvZldK?=
 =?utf-8?Q?xd9hOV8GGIUqBtuApoqRhK13a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3733b03e-9d5f-45d9-aa3f-08daccf447fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:37.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i43hk+/S0m7kbd6M6XMh2Vy7Fh5pGM26lGGHme2B647zPTwnRtV0A2SoFpf5U6wY2wko7pOyKQF5BXVCZyvEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Add missing debug trap registers references and initialize all debug
> registers on boot by clearing the hardware exception overrides and the
> wave allocation ID index.
>
> For debug devices that only support single process debugging, enable
> trap temporary setup by default.
>
> Debug devices that support multi-process debugging require trap
> temporary setup to be disabled by default in order to satisfy microbench
> performance when in non-debug mode.

Where is this done? I don't think it's in the MQD setup because that 
happens unconditionally on all GPUs.


>
> The debugger requires that TTMPs 6 & 7 save the dispatch ID to map
> waves onto dispatch during compute context inspection.
> In order to correctly this up, set the special reserved CP bit by default
> whenever the MQD is initailized.

There is a word missing here. "In order to correctly _set_ this up ..."?

This patch covers GFXv9 and 10. Will GFXv11 be handled separately?

Regards,
   Felix


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 26 +++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 30 ++++++++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  5 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  5 ++
>   .../include/asic_reg/gc/gc_10_1_0_offset.h    | 14 ++++
>   .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 69 +++++++++++++++++++
>   .../include/asic_reg/gc/gc_10_3_0_offset.h    | 10 +++
>   .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   |  4 ++
>   8 files changed, 163 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index af94ac580d3e..d49aff0b4ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4904,6 +4904,29 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
>   
>   #define DEFAULT_SH_MEM_BASES	(0x6000)
>   
> +static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
> +				uint32_t first_vmid,
> +				uint32_t last_vmid)
> +{
> +	uint32_t data;
> +	uint32_t trap_config_vmid_mask = 0;
> +	int i;
> +
> +	/* Calculate trap config vmid mask */
> +	for (i = first_vmid; i < last_vmid; i++)
> +		trap_config_vmid_mask |= (1 << i);
> +
> +	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> +			VMID_SEL, trap_config_vmid_mask);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> +			TRAP_EN, 1);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
> +}
> +
>   static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -4935,6 +4958,9 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>   	}
> +
> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
> +					AMDGPU_NUM_VMID);
>   }
>   
>   static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0320be4a5fc6..a0e5ad342f13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2337,6 +2337,29 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>   	adev->gfx.config.num_rbs = hweight32(active_rbs);
>   }
>   
> +static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
> +				uint32_t first_vmid,
> +				uint32_t last_vmid)
> +{
> +	uint32_t data;
> +	uint32_t trap_config_vmid_mask = 0;
> +	int i;
> +
> +	/* Calculate trap config vmid mask */
> +	for (i = first_vmid; i < last_vmid; i++)
> +		trap_config_vmid_mask |= (1 << i);
> +
> +	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> +			VMID_SEL, trap_config_vmid_mask);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> +			TRAP_EN, 1);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
> +}
> +
>   #define DEFAULT_SH_MEM_BASES	(0x6000)
>   static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>   {
> @@ -4609,6 +4632,13 @@ static int gfx_v9_0_late_init(void *handle)
>   	if (r)
>   		return r;
>   
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
> +		gfx_v9_4_2_debug_trap_config_init(adev,
> +			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +	else
> +		gfx_v9_0_debug_trap_config_init(adev,
> +			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index d3e2b6a599a4..cb484ace17de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -117,6 +117,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>   			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>   
> +	/* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
> +	 * DISPATCH_PTR.  This is required for the kfd debugger
> +	 */
> +	m->cp_hqd_hq_scheduler0 = 1 << 14;
> +
>   	if (q->format == KFD_QUEUE_FORMAT_AQL) {
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 0778e587a2d6..86f1cf090246 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -164,6 +164,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>   			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>   
> +	/* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
> +	 * DISPATCH_PTR.  This is required for the kfd debugger
> +	 */
> +	m->cp_hqd_hq_status0 = 1 << 14;
> +
>   	if (q->format == KFD_QUEUE_FORMAT_AQL) {
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index 18d34bbceebe..7d384f86bd67 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -5190,6 +5190,20 @@
>   #define mmSPI_WCL_PIPE_PERCENT_CS6_BASE_IDX                                                            0
>   #define mmSPI_WCL_PIPE_PERCENT_CS7                                                                     0x1f70
>   #define mmSPI_WCL_PIPE_PERCENT_CS7_BASE_IDX                                                            0
> +#define mmSPI_GDBG_WAVE_CNTL                                                                           0x1f71
> +#define mmSPI_GDBG_WAVE_CNTL_BASE_IDX                                                                  0
> +#define mmSPI_GDBG_TRAP_CONFIG                                                                         0x1f72
> +#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX                                                                0
> +#define mmSPI_GDBG_TRAP_MASK                                                                           0x1f73
> +#define mmSPI_GDBG_TRAP_MASK_BASE_IDX                                                                  0
> +#define mmSPI_GDBG_WAVE_CNTL2                                                                          0x1f74
> +#define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_WAVE_CNTL3                                                                          0x1f75
> +#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA0                                                                          0x1f78
> +#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA1                                                                          0x1f79
> +#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX                                                                 0
>   #define mmSPI_COMPUTE_QUEUE_RESET                                                                      0x1f7b
>   #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX                                                             0
>   #define mmSPI_RESOURCE_RESERVE_CU_0                                                                    0x1f7c
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> index 4127896ffcdf..08772ba845b0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> @@ -19646,6 +19646,75 @@
>   //SPI_WCL_PIPE_PERCENT_CS7
>   #define SPI_WCL_PIPE_PERCENT_CS7__VALUE__SHIFT                                                                0x0
>   #define SPI_WCL_PIPE_PERCENT_CS7__VALUE_MASK                                                                  0x7FL
> +//SPI_GDBG_WAVE_CNTL
> +#define SPI_GDBG_WAVE_CNTL__STALL_RA__SHIFT                                                                   0x0
> +#define SPI_GDBG_WAVE_CNTL__STALL_VMID__SHIFT                                                                 0x1
> +#define SPI_GDBG_WAVE_CNTL__STALL_RA_MASK                                                                     0x00000001L
> +#define SPI_GDBG_WAVE_CNTL__STALL_VMID_MASK                                                                   0x0001FFFEL
> +//SPI_GDBG_TRAP_CONFIG
> +#define SPI_GDBG_TRAP_CONFIG__ME_SEL__SHIFT                                                                   0x0
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL__SHIFT                                                                 0x2
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL__SHIFT                                                                0x4
> +#define SPI_GDBG_TRAP_CONFIG__ME_MATCH__SHIFT                                                                 0x7
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH__SHIFT                                                               0x8
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH__SHIFT                                                              0x9
> +#define SPI_GDBG_TRAP_CONFIG__TRAP_EN__SHIFT                                                                  0xf
> +#define SPI_GDBG_TRAP_CONFIG__VMID_SEL__SHIFT                                                                 0x10
> +#define SPI_GDBG_TRAP_CONFIG__ME_SEL_MASK                                                                     0x00000003L
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL_MASK                                                                   0x0000000CL
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL_MASK                                                                  0x00000070L
> +#define SPI_GDBG_TRAP_CONFIG__ME_MATCH_MASK                                                                   0x00000080L
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH_MASK                                                                 0x00000100L
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH_MASK                                                                0x00000200L
> +#define SPI_GDBG_TRAP_CONFIG__TRAP_EN_MASK                                                                    0x00008000L
> +#define SPI_GDBG_TRAP_CONFIG__VMID_SEL_MASK                                                                   0xFFFF0000L
> +//SPI_GDBG_TRAP_MASK
> +#define SPI_GDBG_TRAP_MASK__EXCP_EN__SHIFT                                                                    0x0
> +#define SPI_GDBG_TRAP_MASK__REPLACE__SHIFT                                                                    0x9
> +#define SPI_GDBG_TRAP_MASK__EXCP_EN_MASK                                                                      0x01FFL
> +#define SPI_GDBG_TRAP_MASK__REPLACE_MASK                                                                      0x0200L
> +//SPI_GDBG_WAVE_CNTL2
> +#define SPI_GDBG_WAVE_CNTL2__VMID_MASK__SHIFT                                                                 0x0
> +#define SPI_GDBG_WAVE_CNTL2__MODE__SHIFT                                                                      0x10
> +#define SPI_GDBG_WAVE_CNTL2__VMID_MASK_MASK                                                                   0x0000FFFFL
> +#define SPI_GDBG_WAVE_CNTL2__MODE_MASK                                                                        0x00030000L
> +//SPI_GDBG_WAVE_CNTL3
> +#define SPI_GDBG_WAVE_CNTL3__STALL_PS__SHIFT                                                                  0x0
> +#define SPI_GDBG_WAVE_CNTL3__STALL_VS__SHIFT                                                                  0x1
> +#define SPI_GDBG_WAVE_CNTL3__STALL_GS__SHIFT                                                                  0x2
> +#define SPI_GDBG_WAVE_CNTL3__STALL_HS__SHIFT                                                                  0x3
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CSG__SHIFT                                                                 0x4
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS0__SHIFT                                                                 0x5
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS1__SHIFT                                                                 0x6
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS2__SHIFT                                                                 0x7
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS3__SHIFT                                                                 0x8
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS4__SHIFT                                                                 0x9
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS5__SHIFT                                                                 0xa
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS6__SHIFT                                                                 0xb
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS7__SHIFT                                                                 0xc
> +#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION__SHIFT                                                            0xd
> +#define SPI_GDBG_WAVE_CNTL3__STALL_MULT__SHIFT                                                                0x1c
> +#define SPI_GDBG_WAVE_CNTL3__STALL_PS_MASK                                                                    0x00000001L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_VS_MASK                                                                    0x00000002L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_GS_MASK                                                                    0x00000004L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_HS_MASK                                                                    0x00000008L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CSG_MASK                                                                   0x00000010L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS0_MASK                                                                   0x00000020L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS1_MASK                                                                   0x00000040L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS2_MASK                                                                   0x00000080L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS3_MASK                                                                   0x00000100L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS4_MASK                                                                   0x00000200L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS5_MASK                                                                   0x00000400L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS6_MASK                                                                   0x00000800L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS7_MASK                                                                   0x00001000L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION_MASK                                                              0x0FFFE000L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_MULT_MASK                                                                  0x10000000L
> +//SPI_GDBG_TRAP_DATA0
> +#define SPI_GDBG_TRAP_DATA0__DATA__SHIFT                                                                      0x0
> +#define SPI_GDBG_TRAP_DATA0__DATA_MASK                                                                        0xFFFFFFFFL
> +//SPI_GDBG_TRAP_DATA1
> +#define SPI_GDBG_TRAP_DATA1__DATA__SHIFT                                                                      0x0
> +#define SPI_GDBG_TRAP_DATA1__DATA_MASK                                                                        0xFFFFFFFFL
>   //SPI_COMPUTE_QUEUE_RESET
>   #define SPI_COMPUTE_QUEUE_RESET__RESET__SHIFT                                                                 0x0
>   #define SPI_COMPUTE_QUEUE_RESET__RESET_MASK                                                                   0x01L
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index 3973110f149c..d09f1a06f4bf 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -26,6 +26,8 @@
>   #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
>   #define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
>   #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
> +#define mmSQ_DEBUG                                                                                     0x10B1
> +#define mmSQ_DEBUG_BASE_IDX                                                                            0
>   
>   // addressBlock: gc_sdma0_sdma0dec
>   // base address: 0x4980
> @@ -4849,10 +4851,18 @@
>   #define mmSPI_WCL_PIPE_PERCENT_CS3_BASE_IDX                                                            0
>   #define mmSPI_GDBG_WAVE_CNTL                                                                           0x1f71
>   #define mmSPI_GDBG_WAVE_CNTL_BASE_IDX                                                                  0
> +#define mmSPI_GDBG_TRAP_CONFIG                                                                         0x1f72
> +#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX                                                                0
>   #define mmSPI_GDBG_TRAP_MASK                                                                           0x1f73
>   #define mmSPI_GDBG_TRAP_MASK_BASE_IDX                                                                  0
>   #define mmSPI_GDBG_WAVE_CNTL2                                                                          0x1f74
>   #define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_WAVE_CNTL3                                                                          0x1f75
> +#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA0                                                                          0x1f78
> +#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA1                                                                          0x1f79
> +#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX                                                                 0
>   #define mmSPI_COMPUTE_QUEUE_RESET                                                                      0x1f7b
>   #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX                                                             0
>   #define mmSPI_RESOURCE_RESERVE_CU_0                                                                    0x1f7c
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> index d4e8ff22ecb8..fc85aee010fe 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> @@ -47853,6 +47853,10 @@
>   
>   
>   // addressBlock: sqind
> +//SQ_DEBUG
> +#define SQ_DEBUG__SINGLE_MEMOP_MASK 0x00000001L
> +#define SQ_DEBUG__SINGLE_MEMOP__SHIFT 0x00000000
> +
>   //SQ_DEBUG_STS_GLOBAL
>   #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
>   #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
