Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D17C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0C210E9C4;
	Mon,  6 Feb 2023 16:57:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229D310E9FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDRZVMWhOF1r9aLOHtIH/zaKcw+j2LkoIKdwwSloGxO/sb0xHUg3bVMWLG5tCPecA3NcQIZi6jkIX6bpCsQMEoixYCwbEyMEH8TpRtcfy4G7OLqDqBzo11Jn/k357SvvXRbfeXjh8xkGPRWgZYRDAx3SQUbItaVQYd79XKnpuaXxwsRGtWRhyn/UbuJ648npJwDsrj38BZaRXg1beHxeMZt8exwUc7jEPp6Gm+pVmUpRDpxU4Zbdsd/KwAzkHXhFj8JI++NrmgqR8KYCMjondymaL0QI2/efKBe2GnUe1lNSQcrtIy3Mn2f7Ux+mT/yFCJ+cIBqOyPiBkZ3UlJPopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II7jpJ0Yo6NvLTC43CQc8XpGMyzyr2CuJNBh1HlAURo=;
 b=TxCqF5GxRYOK+7DZxt+T8scqf6/SoOP+cjgDtnGmpk5w/DRzU+9s/Cu5ahA2FtRUzD0Ce+9x/NbcCEimUDYBnraHo5BcSu4CaCwQ7kuZA3IJu+MqMWYyS3+DHKtL9rHLLq/uCOu8sTbAbjAacThzxm9S0JIm3ZI8xBX2bF2jgIVJPh/ga8izkgMovR3kVEr20pYNxlH3tBykkmihaiAKR4uz2R6FNgfm4bmL32zINxsAV8fjLfeaPH+oM0XV/ISpoLUZpK2FakcbveQScYSooyao3pWQoVFSEPYwWftbxdbu1at6Sn+6/yXm+5MGeIaj/A6OtQO1kK3u9HqcOU0S3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II7jpJ0Yo6NvLTC43CQc8XpGMyzyr2CuJNBh1HlAURo=;
 b=3gzVYCKrlR2xmBEZzGiL3VS109z2+ZwyM4KZMWSodkwf0uhlWhwWYaASlsFPAxKT53nyps7TCvYbG6moPEnEhIcaNONki3qWtN4LyTFvm7UsdZwnqt5KWkewFge2/46BZUc/VnnoFZjmbKQ1SHkEnxU7HqtQAe2YAKZTn20Rqg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 16:57:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 16:57:32 +0000
Message-ID: <82fa6b85-4f45-eb23-5e9f-88ca2d45c5b4@amd.com>
Date: Mon, 6 Feb 2023 17:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 14/14] drm/amdgpu: introduce doorbell bo in kernel
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-20-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-20-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 5413f105-79b8-4707-3539-08db08633d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zhp2i2r90PQV9wkOa9uMgf+9ZAwq+qrB7NRIitvtv5vNVTyj8kENNH2BMy4HDMdfgwxtl+NBXBN8wbs+lhW6gSKT6fc9yu25EuNWuPEgF2Ukt0AbGL2XIS9KmfZrXn2Li/Jr+3jr50D17IFnc9h7jQeMyX04KMRdbgMElmL7KV0AnZi2Lxq7H/D5V7K94CkOLsVDQSkmKfbX0oQ/bQmE81EntqmLZOfdvCnU3MFKqE3oiYUbf5Y9yQMYKXMMbWmmn/7lJmAQFEGAfBZxJ0mqLVph6SFSyLKQTfoog6vfsMa+Jans6YhK5QLTfWTPrDp3eFm1y6RRGfkkxxWW5J3ZW2wnwaNdKJH5Nk8qGTPBZySUlBl46VFtqk7rKpSEdaVcyDSVJ9iR9qzst1HKN4fZy49bKSOTF+wF95m9vaH01wL3UhjOx5dVxZivPoIUiDOYpKeq9gHyhbJSaC89AlKPNsv++ilQmUmc+pWHKirzfKPFR0TlhIHMUJDqdXts6W0o/ws/i2cbCr+m1jIuJJJMJnCIRjnu4DoNjnCdVYBxGQDj6NhfpV2CInICMXcFr7DAxGOdEvUjquExLJVrygjt01Vmd3vJefqV6euNEYqfTG8p69TL94DWEdiazSxfOAn4h3m7HnZQtlObFVmpHRxL0x+2ENDD5clOG/4RGZmVu+1r1VYV7fyajoEFryqvuwVgk/gTnq3Q+7v4j9CmCKskzVgvy5DWkFrmEeOoDAkVfBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(38100700002)(6486002)(478600001)(2906002)(6512007)(186003)(6506007)(66476007)(6666004)(8936002)(66556008)(41300700001)(4326008)(66946007)(8676002)(316002)(5660300002)(83380400001)(36756003)(31696002)(86362001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJvSy9RTTlFeGtjTjNvaXc0VkxXWjN5aXEyRGl5enlMK2g1eXlLT2pneGta?=
 =?utf-8?B?NUhCVmZoenBCMnNDRkEvM3E2aHptNk12VkNHeEtvNmJaQVZOeWlhbm9TYkdB?=
 =?utf-8?B?ZUVrTVlUM0wzNGJtdmY1TzArSy9DT0cvVkFjV0MyZnljOWp3eS9NdzFTN09v?=
 =?utf-8?B?dXJEYjBBWG44M1Npb1J5NURZb0hRNGdwbXFOWjB3SzdpTVlSMWpFWUlkbmdy?=
 =?utf-8?B?SGhDNXBZaTVFb2ZSbU51UkdKcnJjbGVuTTU1SGlhSkFkTVQ1d2xKMmJLZGR5?=
 =?utf-8?B?NmVrOFVUUGJTRnlmcjZxNkhkSUhXcktpTHdFeEJhN2VmaGRvQjdUMGJGeTdU?=
 =?utf-8?B?TytMMXJINld3THQ0U2dPbm83SitaU3p5Z0FGbHZWWWtnYXNML0I1VjRETGx6?=
 =?utf-8?B?NTl2YTlRdWJVdklqVE5mQnRJODBmUTZVRVhJc2hMUXRiUlJtYXVnZjhUYjl4?=
 =?utf-8?B?c0hVbUZ3QXJNY2wrZk5ocHB4bEtKRlplNmZURHFxWitQSW56cTBXUlpCNDJr?=
 =?utf-8?B?SXV1clc3MlRRQmV6c05yVGcrcUZ6c24rSjA0dUJTeUdwcldWdVlhTHp4Q2M3?=
 =?utf-8?B?ZGJ3YlJ6L3NIb1hHOWtZL2lLcUtZQUdOaVlPbTMrOVR0ZWtlME5STjZOS0ov?=
 =?utf-8?B?Rm8wTmhjWVJVUEZIWVErck1wbkdwTENPeXNZVmRkR0puYldvVXZ5RTJoWW5t?=
 =?utf-8?B?dVh2QzRmSFR0TituZG42a3hnellQdU9INStOZ1UxTHJ1VlZRTDJEcE5xVDJm?=
 =?utf-8?B?NjRFeVRsVmlqOUZaR3VER0FSRTI5U3NybnRTMkluRC9YY1I1V0ZLaWxiaG9u?=
 =?utf-8?B?UUp6eEZjWG55eTcyK1JaSXI4MEpTOXhHV2dwSTBGZFJqSTl6T0JTeEVMcXVl?=
 =?utf-8?B?OWk5MThlNmhtRkhuWFlEM00wUWc4Y1lPQjRCb3ROUk5MNmZSSUo2R1dpZFk3?=
 =?utf-8?B?cTZBN3pXbGdiVjRTMDNlNjliUmZ2MWlqSUt6dXZJZ0kraUhFNzdpRmljTzRK?=
 =?utf-8?B?aUxhdjNHRzg2d3kzZGkxcGo5bEdiYjF3ZGxNd3hzM29wYkZaZEJ2WEhneVVp?=
 =?utf-8?B?blBNdEVaTnVHK1FzNitIVW1jWFVJNityZEpraDFVWEtpNUdRTHpyN3Z2Rmth?=
 =?utf-8?B?V0cvaCtIUWIwakd0MEs5U295cjh6TGk3ZWxzZVU0eHJlUkt5MmVOamVUK1Vm?=
 =?utf-8?B?K0QyUVpyUmdUd2xuQVlaY3RHMnVJUnl1VVB4QVJWWDFDUTc3N1A3SStOc0lM?=
 =?utf-8?B?QldpaFBtSlFRbU1PcHkvaWxGZlRYUlhXNWJscWVhSnhrbHdtN1NQODZQeHpM?=
 =?utf-8?B?dGM4bUdoa3FKSFh3ZFk3SndzcURSZVVvanlCN0kwQUpuVERqQWwzbG9wZDht?=
 =?utf-8?B?b2NINDR5ZU5rTGJNQlNIM3RHeWdSeFlXL0trcldJMDdFV1hjMFplOW1ySE9v?=
 =?utf-8?B?c05LT1FJbFFxMnFzdVA4M0FUdnlOMy9UeFdlYW1HTXFETHpIZ0trbUx2eXlk?=
 =?utf-8?B?aDhTVmdNby9WcmU0Mi9WQUpzMkZDbFZFMDJPbis2TElVM1BmVk5VbHVVbEdC?=
 =?utf-8?B?dDFoZXlheWJrL0o3bVB3a3RWK3VhS3FjaEx3V1hqSEovTGwwVE8vR2F4emFs?=
 =?utf-8?B?UnhZcVc5cmJNbkswZW9yWTQvVmJXcERUVzg5TmlDdHIrWU1QZGFiWjAxZVY1?=
 =?utf-8?B?N25EQkNEb2tRMjdqNHIrS1czZmhwbmpFWlgxdmFhcHpSMFZiOFpYMGJuZDR3?=
 =?utf-8?B?QlJIcDZVRjdFOGdOMDU5NmwwYVlaS3lyVmpiNGpMS0UxWXlUUVJ1TG1lVC9J?=
 =?utf-8?B?WXB3SWNLeUo0aHl1WjhrMEJEWjBnazZ1RWRkTFZLWGxGdE9aZ3VoTFlZY1Rk?=
 =?utf-8?B?QklJZE9FaEl6aHBLc2JVMjlTK3g3cEtYcmJXbWZRd2hWZkZseHFqU1U3OVN2?=
 =?utf-8?B?enJXV0lwOXMxMWNEQk04bmJTWDhBTW5vUTVUM3BReHh1dTVCOEFnQnlFTWZG?=
 =?utf-8?B?c2dJVEFEZjZxNDdjV2ZRclpnSUtYQVl4Zm5aSjMxVTBoSUd3UkNvWFR2YllO?=
 =?utf-8?B?Z3lybGZTUG1xUWl5UXU3cU0wT0NJbUpNbklMMTNNODBwTndUaGlVMHljZFZB?=
 =?utf-8?B?WXBaUVI2UDF5Q0hSaXlVdTJ2STVBV2haR1JMeVhJMUFyMXdWQlpMbjNzOU5y?=
 =?utf-8?Q?cVs2isCCJpTxZxl1fKHyKX4cXiAh1cRGDD94c6xW7095?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5413f105-79b8-4707-3539-08db08633d1b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:57:32.6784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u6P4rwgsVlwEtYLvvMVDdLNwFmvjKXN40G1dKQJlGakTbatxykI5V3WJ5OmetVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch does the following:
> - Removes doorbell ptr from adev.
> - Moves doorbell.num_doorbells into mman.num_doorbells.
> - Introduces a kernel bo for doorbell management in form of mman.doorbell_kernel_bo.
>    This bo holds the doorbell space now.
> - Introduces mman.doorbell_bo_size: to save total doorbell memory size.
> - Also introduces mman.doorbell_va to save CPU address of doorbell BO
>    mapping. This ptr will be used now for doorbell read/write from doorbell BAR.

Please don't call any CPU address VA, this is a term we usually use with 
GPUVM.

Rather use doorbell_cpu_addr for this.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 16 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 24 ++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  6 +++++
>   6 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e1c1a360614e..dd3875ae1ad3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -834,7 +834,6 @@ struct amdgpu_device {
>   	spinlock_t audio_endpt_idx_lock;
>   	amdgpu_block_rreg_t		audio_endpt_rreg;
>   	amdgpu_block_wreg_t		audio_endpt_wreg;
> -	struct amdgpu_doorbell		doorbell;
>   
>   	/* clock/pll info */
>   	struct amdgpu_clock            clock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 28076da2258f..aea943e337df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -109,11 +109,10 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   		*aperture_base = adev->gmc.doorbell_aper_base;
>   		*aperture_size = 0;
>   		*start_offset = 0;
> -	} else if (adev->gmc.doorbell_aper_size > adev->doorbell.num_doorbells *
> -						sizeof(u32)) {
> +	} else if (adev->gmc.doorbell_aper_size > adev->mman.doorbell_kernel_bo_size) {
>   		*aperture_base = adev->gmc.doorbell_aper_base;
>   		*aperture_size = adev->gmc.doorbell_aper_size;
> -		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
> +		*start_offset = adev->mman.doorbell_kernel_bo_size;
>   	} else {
>   		*aperture_base = 0;
>   		*aperture_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7c21ffe63ebc..9c3ce1ae66ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -593,8 +593,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return 0;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		return readl(adev->mman.doorbell_aper_base_kaddr + index);
> +	if (index < adev->mman.num_doorbells) {
> +		return readl(adev->mman.doorbell_va + index);
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -616,8 +616,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
> +	if (index < adev->mman.num_doorbells) {
> +		writel(v, adev->mman.doorbell_va + index);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -637,8 +637,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return 0;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
> +	if (index < adev->mman.num_doorbells) {
> +		return atomic64_read((atomic64_t *)(adev->mman.doorbell_va + index));
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -660,8 +660,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
> +	if (index < adev->mman.num_doorbells) {
> +		atomic64_set((atomic64_t *)(adev->mman.doorbell_va + index), v);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 464be28da4fb..97298a98561f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -24,10 +24,6 @@
>   /*
>    * GPU doorbell structures, functions & helpers
>    */
> -struct amdgpu_doorbell {
> -	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
> -};
> -
>   /* Reserved doorbells for amdgpu (including multimedia).
>    * KFD can use all the rest in the 2M doorbell bar.
>    * For asic before vega10, doorbell is 32-bit, so the
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e38720b91958..8f0537f16cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1742,7 +1742,7 @@ static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
>   	if (adev->asic_type < CHIP_BONAIRE) {
>   		adev->gmc.doorbell_aper_base = 0;
>   		adev->gmc.doorbell_aper_size = 0;
> -		adev->doorbell.num_doorbells = 0;
> +		adev->mman.num_doorbells = 0;
>   		adev->mman.doorbell_aper_base_kaddr = NULL;
>   		return 0;
>   	}
> @@ -1759,13 +1759,13 @@ static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
>                                                       adev->gmc.doorbell_aper_size);
>   
>   	if (adev->enable_mes) {
> -		adev->doorbell.num_doorbells =
> +		adev->mman.num_doorbells =
>   			adev->gmc.doorbell_aper_size / sizeof(u32);
>   	} else {
> -		adev->doorbell.num_doorbells =
> +		adev->mman.num_doorbells =
>   			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
>   			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_doorbells == 0)
> +		if (adev->mman.num_doorbells == 0)
>   			return -EINVAL;
>   
>   		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> @@ -1775,7 +1775,7 @@ static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
>   		 * the max num_doorbells should + 1 page (0x400 in dword)
>   		 */
>   		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_doorbells += 0x400;
> +			adev->mman.num_doorbells += 0x400;
>   	}
>   
>   	return 0;
> @@ -1901,6 +1901,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> +	adev->mman.doorbell_kernel_bo_size = adev->mman.num_doorbells * sizeof(u32);
> +	r = amdgpu_bo_create_kernel_at(adev,
> +					  0,
> +					  adev->mman.doorbell_kernel_bo_size,
> +					  AMDGPU_GEM_DOMAIN_DOORBELL,
> +					  &adev->mman.doorbell_kernel_bo,
> +					  &adev->mman.doorbell_va);
> +	if (r) {
> +		DRM_ERROR("Failed to create doorbell BO\n");
> +		return r;
> +	}
> +
>   	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>   		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>   
> @@ -1992,6 +2004,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   				      NULL, NULL);
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
> +	amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
> +			      NULL, &adev->mman.doorbell_va);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
>   	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index a492de079c2e..405294ca9834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -98,6 +98,12 @@ struct amdgpu_mman {
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> +
> +	/* doorbells reserved for the kernel driver */
> +	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
> +	uint64_t		doorbell_kernel_bo_size;
> +	struct amdgpu_bo	*doorbell_kernel_bo;
> +	void			*doorbell_va;
>   };
>   
>   struct amdgpu_copy_mem {

