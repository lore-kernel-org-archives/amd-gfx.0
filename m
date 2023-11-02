Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38815C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 12:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F15F10E858;
	Thu,  2 Nov 2023 12:45:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE43310E858
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 12:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PESYD3uy+v8Aowjb3I5W7e89pZXycny67EFO5TATaSUzgQzHcEqEfdtxXPcbePWyjVPIAJDsP4jcaiEQqI/OD9++6cFSg8F0+jEnh5ph+IbeY1uu6vmttuHwXuaDFE38eR9tq4vAvxma1Ua7ZcBunpXmZ6LAN2XNKwRp4sL66xVVq4Csklw0u9KMHNGAtQRS5WXYHm9n7NsNLx7VKd9gl0TIgS1HeGVC4gGG3BidZdj/Lz9aWeSuOIz324vupOXL72inDip/h1k7Xt3B0edq+fo/QIyPta6BrYLqocGTvAT73WUUMu7kGOEgMWt3f6o7cFsZSTb9ueSpT6mDn8hYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rqrVStNjToO7Iuw2KMLJ7CMTXnsBqYGXiNxo1w5s3k=;
 b=AhErtHa7dnU6ZUAsjj6KsOu4nO9eCmxsJD01qOXVM88eTljYWs967mue2uPXgfbeNjEYyyhqwVZglcbKWf2W3dd8jckOuVEe7gnEcGaFbAoBPGuKq9FiwOCrI76npc0BiY7R1uJSUON0ZmaHoWOqPn5VF53CNME00+XOolL8XSAwKlrzMjURgrHkEK3yLZS8LwxwbQ3USDIADAE0KgPGjdMh4ynw6cNrPw4ULnu/RmDLtFDcTTtb7nQY9UuggnJHlFjDwWfGr13SSYKA2KwhcEJnogNVE1hiFQPNX7YpPWxG5+clEZWPkyhw67a/nNaStwZW4BcNBB7HXU7GUqDRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rqrVStNjToO7Iuw2KMLJ7CMTXnsBqYGXiNxo1w5s3k=;
 b=ka8P5tBEIQOy/uGGmBVuBeKm38eId70bjxzALz8bz5RxaZeKZIW+t5Kj8x1eT4kNC3q4RxmdAgocv6fKm7hzZ3lK2yYyiF9afk6J37zDV5br6bj1eint+7TzfIEmFy1BCj2llkPhu/9ZU1TH3K9dUvBbVHPSSIT1ZDQyUOCD12M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 12:44:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 12:44:59 +0000
Message-ID: <afc9b3ff-dfe2-4c22-9c9b-da995b4821ec@amd.com>
Date: Thu, 2 Nov 2023 13:44:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable seq64 manager and fix bugs
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231101162602.4122-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231101162602.4122-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd3bb17-4d99-4887-1585-08dbdba1866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxEpNm55qT7h9GL3Prk12zqPk9YhSzidWuID3GEs3gloE9S9sBP/zu0UB/Jn0GLAVYDB2gm3/iDAjT/XvVghdviR1jdziIYyohyAf340TjQ1Tiw63qxPWpEf/GjcTOkdvoodb2bm5ZtE3AM6Qrp7pYY2pxwDfUQna0xkCbbCXPUN9gp1nbXN9sm9E5LkHkuwsMBMA8gWUI5WFfn7M6cBhdOW+xxDAqUVyQDLU7C2ZVVVdEiGx65ujvrhlI0a2KDaKpVqQ3WjBoGnZPX095bpOugaP+vaqJ9P5EXUq3kgm9hbmS+7zQNn9SboSQDaWW/o6qFWwpCXn6IfQkXfXh/w9vs0o+GmTaXVkFDxwnR43p7jzB9eSmoXGqmvDrzFAhLBav9xC6XqMpUS2ilgAtrqRVN+pUMEl7j0kUJtQAYbVP2bW26sWki8BFA8hAFC8+924giQATcrNpdxKlBKQckEFn1mlaAKGqZFYcKrQYq0+mACLAe6MnzGnAUBTQOx/Ngb3Hc5HAfaa9c3Y6hI6vJ19TXaQ6fqvU0Xe+SwbQcScAP2+NmCEvKjXj7ro46InAOn7rnIdNH9Bk2uXxKSLH88f5CMdfr9q/3oGxcBj3hg208IeGbyKl+o5JoMIGT/Vqi2BUcUHhsnXMF/M3iIEufXWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(66556008)(66946007)(316002)(36756003)(6506007)(6666004)(6512007)(66574015)(2616005)(26005)(38100700002)(83380400001)(86362001)(31696002)(478600001)(6486002)(8936002)(4326008)(5660300002)(41300700001)(30864003)(8676002)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRnRmNreVR4b3gvQ0p4Sm9SWnRLc29SUDNuZ3dML1h5VHp0Qkl1cU1ldU5O?=
 =?utf-8?B?bDgxbU9UMFE1OTROTWZicDdKSWd0c09Oc3BBV2VNUzdJZ1JBZFhKdXVidGgx?=
 =?utf-8?B?SzBUUzhZbVllT090YVpPZm5Oa3dPdlFwWjhTdVBtcHluNHVTZ3c3SHdDNWtD?=
 =?utf-8?B?emZDaVB6NUI4M2hsT25xWktYbzVFcVloL3I1SXQzNFc0UWVnWC9FbEZ4cXFV?=
 =?utf-8?B?aHgvVHRzaXNpMkZjd3lyRFl3UHN6cjZqOWJLOGoyNytpSDhRMjZrOExTbkFJ?=
 =?utf-8?B?ZXo3ckdES2xFZVlCcTB0alM3S05oaWc2UmpHeHBCZTlJR0dZaGM5elB0dVFv?=
 =?utf-8?B?QnpqUWpxZ0Nlai9HYmUvNXZHWmduUlI3Mnl5TWZqeXQ4OXpIN3lBbFpkZGtt?=
 =?utf-8?B?bDFCaUdtcjBpRkJQQytERHF6am4zdnlvRjZtTzZ6NGxEY2F1eG9mUkg1SHQw?=
 =?utf-8?B?NGQ0LzJxS2pYVlBpV0NQT2lDdHBxVFRWb08wRzJBcFNoZUpmcEVZZ2UwTHRP?=
 =?utf-8?B?T3p5dFk3YU15eXNiYmRsL0U3ci9TQ1I3MHZySEk4U2JQc3VCWHhoMmZ3K3ZO?=
 =?utf-8?B?aFpRaXdCd0RSN0lYRDNEeEJDM2J0WG53S1ZBbi85dWppWXI1SHRXdXFxcXor?=
 =?utf-8?B?R1g1c2VXWlRFMitFV0QwdWJ6b1B2TmRJMDdKcXJVOTZZQ3dZbURHV0dxUURl?=
 =?utf-8?B?aXdzZlBZaGlEeWo3ckdKVG8yRDhOdEhQK0NZRmZuMFgzOFFud3VsVytVSjM2?=
 =?utf-8?B?N2VwdVJ4Y1RzNWtwanhpUEgzWlpQZHRBUUNMcGFCUFhVbDhJdkN5SkNleW1q?=
 =?utf-8?B?emp4WDdaTi9OeXQwWjA2b2NwYVVrdXZBUmNreUNXNDJ4a09MMGU1eUV6R3VS?=
 =?utf-8?B?MnBTM1d6WXFpVmMrcXN4NFVNVlhaeFdUV0R5ZFlUZWtFTDM5bGdEYlVBUml2?=
 =?utf-8?B?Vzh2Qzl1REovd3NtRDd3MmpSZjZTcTFIUU5sN3JFdTN2RVBtSStucDFxb3N4?=
 =?utf-8?B?WStsekFGT015S0ZvT09obDZ4NmFZZDVoZHQ3ckQ1K1ZjOWVWcnI4bEZuajUz?=
 =?utf-8?B?V3JVRlFBaWU0Y0cybHJHTDhWb0htdWU5WkwyaUlLNkZDSjlhNVRYRHAwN0RE?=
 =?utf-8?B?R3R5Wks5UGRrWVQwemVrZ0ZwY0NHRk1YUmhUcFNXbWRGbE1UWnJ6VFFaTVJl?=
 =?utf-8?B?UU1wOGwxdUY2WENBTUVrbUR6Z25RU1B3ZnhTSFNIOFdGVWd4VW0wZzUxR3Rw?=
 =?utf-8?B?M3cxcGl3SkpRbnBvaEdEZVhMZ01adGQ1NlRRcVRqNExlOFVwL0w0Q2RndFI1?=
 =?utf-8?B?eVdYVGJuQWRiTjhWR20xbTU1cEhoOXhsRTZTZ0xlL1JuendCZkpueS9ROHdi?=
 =?utf-8?B?OEhmWERSZ2o1ZVdHay9BYWkrMlY3RWJESGpRMWFoQ3laaHpiWGFzQW55cmlr?=
 =?utf-8?B?L0F0RXZXNWNMVENscStEQ1Y5S1QveXlqN0owUngxNWs2L1UwT0ZwdzV4S2RB?=
 =?utf-8?B?ZjNZWHc4RDFoYTA1S0VhS29nTXpHR2k2V1FQelVwTGpuc0JuaGY1VjBOdVl0?=
 =?utf-8?B?aWlpNHRobTNOTGVvY2hYbkV6Qks1NFMvdGhHVUNKWk9jSDl6NSt4MUoxS0Nr?=
 =?utf-8?B?aVJmYUtlc1AwSFZaaUgvSW1HVHhuZEIvWlIvbGQ4QTJMR1BOMzdvOUZUMVZG?=
 =?utf-8?B?ZVBsOStMV2RIYUpoVHJrdW9UUVhHWWVDOVZ2WFpwZzFGLy9ockl4ZVNFbXhQ?=
 =?utf-8?B?bExHQjNqS3BkWVBlaDFlbFQvREtYdWhnQjg1MWFnYjdWUk50RS8vMXVJQU5n?=
 =?utf-8?B?c1JoamhEbStXV1orMFN6SSs3OUtDcDFxT0dyeTJEdStUYUlOUHgyMGcwZ1pi?=
 =?utf-8?B?Q1ZNeFpYMFlvWFJ2SHo3a21yR3NaTGFwblg3Q3NXd0pQSUNJVUxmQ2RlRTBq?=
 =?utf-8?B?QS9DQ2k0YUxKUDl5UWxwSzBGcm03cGhMS2tyN00va1JCTld4ZHZaSUYrdGlt?=
 =?utf-8?B?Z3BwYzlHSXE5SERCcG5HMjBna2FzNG9UTElabUs3eFluTjJUTy9xcDRCZUcv?=
 =?utf-8?B?L2JJVGdwaWY2TlYvcW53OTM4WjZhTTNpa0VHcHlPZ0hCaTllYnV1L1BOOWxm?=
 =?utf-8?Q?El+8q+UUmEq2YAtb/bwzmQzXa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd3bb17-4d99-4887-1585-08dbdba1866c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 12:44:59.5981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvpPPCzPbhQr1cCzcGN1Y4RgLtC/8I8tGy7pbK0WIzy+vVXCBd3cxBuqvEInsHX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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

Am 01.11.23 um 17:26 schrieb Arunpravin Paneer Selvam:
> - Enable the seq64 mapping sequence.
> - Fix wflinfo va conflict and other bugs.
>
> v1:
>    - The seq64 area needs to be included in the AMDGPU_VA_RESERVED_SIZE
>      otherwise the areas will conflict with user space allocations (Alex)
>
>    - It needs to be mapped read only in the user VM (Alex)
>
> v2:
>    - Instead of just one define for TOP/BOTTOM
>      reserved space separate them into two (Christian)
>
>    - Fix the CPU and VA calculations and while at it
>      also cleanup error handling and kerneldoc (Christian)
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c      |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |  8 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    | 69 +++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h    |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |  5 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c        |  5 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c        |  5 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c        |  5 +-
>   11 files changed, 68 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> index 23d054526e7c..c7622efdafee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -28,7 +28,7 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>   {
>   	uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>   
> -	addr -= AMDGPU_VA_RESERVED_SIZE;
> +	addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>   	addr = amdgpu_gmc_sign_extend(addr);
>   
>   	return addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 849fffbb367d..f4455ed78e72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -687,10 +687,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	uint64_t vm_size;
>   	int r = 0;
>   
> -	if (args->va_address < AMDGPU_VA_RESERVED_SIZE) {
> +	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
>   		dev_dbg(dev->dev,
>   			"va_address 0x%llx is in reserved area 0x%llx\n",
> -			args->va_address, AMDGPU_VA_RESERVED_SIZE);
> +			args->va_address, AMDGPU_VA_RESERVED_BOTTOM);
>   		return -EINVAL;
>   	}
>   
> @@ -706,7 +706,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	args->va_address &= AMDGPU_GMC_HOLE_MASK;
>   
>   	vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
> -	vm_size -= AMDGPU_VA_RESERVED_SIZE;
> +	vm_size -= AMDGPU_VA_RESERVED_TOP;
>   	if (args->va_address + args->map_size > vm_size) {
>   		dev_dbg(dev->dev,
>   			"va_address 0x%llx is in top reserved area 0x%llx\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b5ebafd4a3ad..bb4aa14b868c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -894,14 +894,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
>   
>   		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
> -		vm_size -= AMDGPU_VA_RESERVED_SIZE;
> +		vm_size -= AMDGPU_VA_RESERVED_TOP;
>   
>   		/* Older VCE FW versions are buggy and can handle only 40bits */
>   		if (adev->vce.fw_version &&
>   		    adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
>   			vm_size = min(vm_size, 1ULL << 40);
>   
> -		dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_SIZE;
> +		dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_BOTTOM;
>   		dev_info->virtual_address_max =
>   			min(vm_size, AMDGPU_GMC_HOLE_START);
>   
> @@ -1365,6 +1365,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   			goto error_vm;
>   	}
>   
> +	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
> +	if (r)
> +		goto error_vm;
> +
>   	mutex_init(&fpriv->bo_list_lock);
>   	idr_init_base(&fpriv->bo_list_handles, 1);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 70fe3b39c004..108908a10b92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1325,7 +1325,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
>   		goto error_fini;
>   	}
>   
> -	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
> +	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_BOTTOM;
>   	r = amdgpu_mes_ctx_map_meta_data(adev, vm, &ctx_data);
>   	if (r) {
>   		DRM_ERROR("failed to map ctx meta data\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 64d4914001e0..63d8b68023be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -47,15 +47,33 @@
>    * Returns:
>    * 0 on success or a negative error code on failure
>    */
> +
> +/**
> + * amdgpu_seq64_get_va_base - Get the seq64 va base address
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Returns:
> + * va base address on success
> + */
> +static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
> +{
> +	u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
> +
> +	addr -= AMDGPU_VA_RESERVED_TOP;
> +
> +	return addr;
> +}
> +
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		     struct amdgpu_bo_va **bo_va, u64 seq64_addr,
> -		     uint32_t size)
> +		     struct amdgpu_bo_va **bo_va)
>   {
>   	struct ttm_validate_buffer seq64_tv;
>   	struct amdgpu_bo_list_entry pd;
>   	struct ww_acquire_ctx ticket;
>   	struct list_head list;
>   	struct amdgpu_bo *bo;
> +	u64 seq64_addr;
>   	int r;
>   
>   	bo = adev->seq64.sbo;
> @@ -81,9 +99,9 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_vm;
>   	}
>   
> -	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, size,
> -			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
> -			     AMDGPU_PTE_EXECUTABLE);
> +	seq64_addr = amdgpu_seq64_get_va_base(adev);
> +	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
> +			     AMDGPU_PTE_READABLE);
>   	if (r) {
>   		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
>   		goto error_map;
> @@ -151,31 +169,25 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>    * amdgpu_seq64_alloc - Allocate a 64 bit memory
>    *
>    * @adev: amdgpu_device pointer
> - * @gpu_addr: allocated gpu VA start address
> - * @cpu_addr: allocated cpu VA start address
> + * @va: VA to access the seq in process address space
> + * @cpu_addr: CPU address to access the seq
>    *
>    * Alloc a 64 bit memory from seq64 pool.
>    *
>    * Returns:
>    * 0 on success or a negative error code on failure
>    */
> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr,
> -		       u64 **cpu_addr)
> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
>   {
>   	unsigned long bit_pos;
> -	u32 offset;
>   
>   	bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
> +	if (bit_pos >= adev->seq64.num_sem)
> +		return -ENOSPC;
>   
> -	if (bit_pos < adev->seq64.num_sem) {
> -		__set_bit(bit_pos, adev->seq64.used);
> -		offset = bit_pos << 6; /* convert to qw offset */
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	*gpu_addr = offset + AMDGPU_SEQ64_VADDR_START;
> -	*cpu_addr = offset + adev->seq64.cpu_base_addr;
> +	__set_bit(bit_pos, adev->seq64.used);
> +	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
> +	*cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>   
>   	return 0;
>   }
> @@ -184,20 +196,17 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr,
>    * amdgpu_seq64_free - Free the given 64 bit memory
>    *
>    * @adev: amdgpu_device pointer
> - * @gpu_addr: gpu start address to be freed
> + * @va: gpu start address to be freed
>    *
>    * Free the given 64 bit memory from seq64 pool.
> - *
>    */
> -void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr)
> +void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>   {
> -	u32 offset;
> -
> -	offset = gpu_addr - AMDGPU_SEQ64_VADDR_START;
> +	unsigned long bit_pos;
>   
> -	offset >>= 6;
> -	if (offset < adev->seq64.num_sem)
> -		__clear_bit(offset, adev->seq64.used);
> +	bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
> +	if (bit_pos < adev->seq64.num_sem)
> +		__clear_bit(bit_pos, adev->seq64.used);
>   }
>   
>   /**
> @@ -236,7 +245,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
>   	 * AMDGPU_MAX_SEQ64_SLOTS * sizeof(u64) * 8 = AMDGPU_MAX_SEQ64_SLOTS
>   	 * 64bit slots
>   	 */
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_SEQ64_SIZE,
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
>   				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
>   				    &adev->seq64.sbo, NULL,
>   				    (void **)&adev->seq64.cpu_base_addr);
> @@ -245,7 +254,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> -	memset(adev->seq64.cpu_base_addr, 0, AMDGPU_SEQ64_SIZE);
> +	memset(adev->seq64.cpu_base_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE);
>   
>   	adev->seq64.num_sem = AMDGPU_MAX_SEQ64_SLOTS;
>   	memset(&adev->seq64.used, 0, sizeof(adev->seq64.used));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> index 2196e72be508..4203b2ab318d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> @@ -25,10 +25,9 @@
>   #ifndef __AMDGPU_SEQ64_H__
>   #define __AMDGPU_SEQ64_H__
>   
> -#define AMDGPU_SEQ64_SIZE		(2ULL << 20)
> -#define AMDGPU_MAX_SEQ64_SLOTS		(AMDGPU_SEQ64_SIZE / (sizeof(u64) * 8))
> -#define AMDGPU_SEQ64_VADDR_OFFSET	0x50000
> -#define AMDGPU_SEQ64_VADDR_START	(AMDGPU_VA_RESERVED_SIZE + AMDGPU_SEQ64_VADDR_OFFSET)
> +#include "amdgpu_vm.h"
> +
> +#define AMDGPU_MAX_SEQ64_SLOTS         (AMDGPU_VA_RESERVED_SEQ64_SIZE / sizeof(u64))
>   
>   struct amdgpu_seq64 {
>   	struct amdgpu_bo *sbo;
> @@ -42,7 +41,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev);
>   int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		     struct amdgpu_bo_va **bo_va, u64 seq64_addr, uint32_t size);
> +		     struct amdgpu_bo_va **bo_va);
>   void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index f5fdde5181f7..a6ddced833ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -359,7 +359,7 @@ static int setup_umsch_mm_test(struct amdgpu_device *adev,
>   
>   	memset(test->ring_data_cpu_addr, 0, sizeof(struct umsch_mm_test_ring_data));
>   
> -	test->ring_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
> +	test->ring_data_gpu_addr = AMDGPU_VA_RESERVED_BOTTOM;
>   	r = map_ring_data(adev, test->vm, test->ring_data_obj, &test->bo_va,
>   			  test->ring_data_gpu_addr, sizeof(struct umsch_mm_test_ring_data));
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ea8b5b644e3..ed95f01a62e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -134,7 +134,10 @@ struct amdgpu_mem_stats;
>   #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
>   
>   /* Reserve 2MB at top/bottom of address space for kernel use */
> -#define AMDGPU_VA_RESERVED_SIZE			(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_BOTTOM		(2ULL << 20)

> +#define AMDGPU_VA_RESERVED_TOP			(4ULL << 20)

Please adjust this define to

#define AMDGPU_VA_RESERVED_TOP    (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
AMDGPU_VA_RESERVED_CSA_SIZE)


With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> +#define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>   
>   /* See vm_update_mode */
>   #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 7f66954fd302..f8711998e762 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -434,9 +434,10 @@ static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)
>   	WREG32(mmVM_PRT_CNTL, tmp);
>   
>   	if (enable) {
> -		uint32_t low = AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
> +		uint32_t low = AMDGPU_VA_RESERVED_BOTTOM >>
> +			AMDGPU_GPU_PAGE_SHIFT;
>   		uint32_t high = adev->vm_manager.max_pfn -
> -			(AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT);
> +			(AMDGPU_VA_RESERVED_TOP >> AMDGPU_GPU_PAGE_SHIFT);
>   
>   		WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
>   		WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 61ca1a82b651..f86ed37cad6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -562,9 +562,10 @@ static void gmc_v7_0_set_prt(struct amdgpu_device *adev, bool enable)
>   	WREG32(mmVM_PRT_CNTL, tmp);
>   
>   	if (enable) {
> -		uint32_t low = AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
> +		uint32_t low = AMDGPU_VA_RESERVED_BOTTOM >>
> +			AMDGPU_GPU_PAGE_SHIFT;
>   		uint32_t high = adev->vm_manager.max_pfn -
> -			(AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT);
> +			(AMDGPU_VA_RESERVED_TOP >> AMDGPU_GPU_PAGE_SHIFT);
>   
>   		WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
>   		WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index fa59749c2aef..eab26db0f398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -776,9 +776,10 @@ static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)
>   	WREG32(mmVM_PRT_CNTL, tmp);
>   
>   	if (enable) {
> -		uint32_t low = AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
> +		uint32_t low = AMDGPU_VA_RESERVED_BOTTOM >>
> +			AMDGPU_GPU_PAGE_SHIFT;
>   		uint32_t high = adev->vm_manager.max_pfn -
> -			(AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT);
> +			(AMDGPU_VA_RESERVED_TOP >> AMDGPU_GPU_PAGE_SHIFT);
>   
>   		WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
>   		WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);

