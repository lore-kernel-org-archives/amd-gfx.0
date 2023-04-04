Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D882FC761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 10:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643A410E023;
	Tue,  4 Apr 2023 10:26:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A4510E023
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 10:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB90in+QdGtnJX2fe/fObHG0Z0cwxs2/EAToqQXpYMM4w0UuC39csERSk7SC1o2H8w57fpZVk25PeZf22/CObi8VvkMVn7uIMo8MgrQYLJCzW4j3osnqKtNNqQfr5RDgltRAelWyS79NMjzxt5LfgtVdMaVPjiJEpfizv8jL+G1+s0AoAvNZempngaCAO7jG4L9Z4uVDQNXpYpkEAxN3ShZJqrSR651EehWWSxkmEWrISyUiK+NBmpYc1mfqyCjlHn/By7PVzXHWlFv2lei/jBh+SfHIKxAYL5wYfOWH5vFtNnC2mvPvDmQOBqDPzmrsprxZJTeYl1Ij019GSgSodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kkz0QoxkqdUq/ESLJ+sYB5GPMEPhXkQ2oV82F3JvGk=;
 b=KirUcyjQam0LD+869UhmbegRH4XZoFzU+rJJrNlf4vL4ujLERoBtQcb6stLPU/XR+nrirhs3s5+8hv2zEeMDNM3hojvOh3rdzprd1rvq/DwIzsKkXGLRjbede0Q6jvU7V8EmI8kCiAIVp4IlMWBm2+5umwuNiwxgc3HcyHiYAn/LNgcxIwa6BkMH8HJHOOA9S1uIJGUCSox5PUpCxtlMDozcZXJewrdZPFIPCJks98g5UdhPgg+HdCpRGS4PuWXmKw2LH7/ne+k8O5qxx63DXFWCwd5dZxQambnvyn0dNigAniMeAlHuwMXUFsFl9/P1IlJ2QOK+HE3/WNARsHYGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kkz0QoxkqdUq/ESLJ+sYB5GPMEPhXkQ2oV82F3JvGk=;
 b=msmtNPKvD+9VjBQY77eW+DSssixO0dwustRhHAueFz12AhFr8wzMe4hM4xkWQE21sh6BIEZbg4DXF4SzEDBpqsiuZ85KGdFtI53PNmQm+32HEdG/TnbeRiUiF6uj+zRrhV5Rrw9BaOQ4Tc+8eeG8mg8xqhe/KeZsiiHRIhN/lTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Tue, 4 Apr
 2023 10:26:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 10:26:36 +0000
Message-ID: <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
Date: Tue, 4 Apr 2023 12:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 felix.kuehling@amd.com
References: <20230404095640.3277840-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230404095640.3277840-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9c0b14-4b5d-404b-479f-08db34f711c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwUM3yWw+6b9CufENxnflpmmuaUIZj6jqMxtOJ58cyWw5QlMQHg+eSM/XZQT1brH5pppufbx7seB6Tl1Mm7J65Lc3GEhBxfIPqMDnnV7cjfH/tB7hjFyX/wRQjo/LBtSn5WMMXmeGk4sv0vmID2F0aT1HXPVobX0EewIikrRU6c2LQAaIYw5GcOhZngrE+77oMi+WTDFdq8EDFRX698JImdOKootS9LiLbO8ZyFYg2PP14BT2vQkJxKyVKV5rgkv5oChLAGP5ugd1I3udV562hiHLXoT1ysPFIZPXFihxsp8Eygwf4BnPPP0KG2od3/ZW6HuZC79RATpn7mkpvx+eCMPKIB4lqjtqpnV8hy9u3qQFW0CItMxvkvwDGsFhIWoW8dL9d3Ad40j5MGrW86JZ+k5VWy2VvtkcMi4SrQpPUnb+l5k+9knL9h2VffvQFmLRDuJu6pjacw06AJLkuUe5G/8rByrnBAKKtle34O4Li8c0ZM0hIU9jl/TAbi/muTevAtnU4acM7uWyOPyYxnQ/WMNys8iau9H8TPhimZX8fRRERei90AaY5PzHsZMLil/3W8mdCh3Ux86VTrXaG51V8v+n4PguFiDz634fBGDqFJqlPixZBn2KrH2Jo+HOFQHVnbxV02l7hjni+ZVBdjqNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(31686004)(2906002)(86362001)(5660300002)(2616005)(66556008)(8936002)(8676002)(66476007)(316002)(4326008)(41300700001)(36756003)(66946007)(478600001)(6636002)(6486002)(31696002)(26005)(6512007)(6506007)(6666004)(186003)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFvK2NtRE9wMTVpL1JoSlpyTk94aURDYnJ6bnpuOGtFbnJSZDhxRVlxc2lu?=
 =?utf-8?B?UWlnK1UzOXNCa0NPY1ZqQkJ3cmtRcGhwVXN4TkMwdXhZR0YzMVBzUUpKS0RI?=
 =?utf-8?B?TWhNNlNsN2VIR0paNkFNNEFYV3ZmNm9sMHZkR0lONmZ3aE1LV3FkMElZeGho?=
 =?utf-8?B?V0trbkhrUTFUYjVma0pFQVhMWTUrckZFY3c1VjBvMFB3dnd6SjF3RThNUVNj?=
 =?utf-8?B?Y004N2hrZlBEMFkxT0dWN3FIRTZJZTY0Mk1Wa2ZETGdXc1JjN1JsUmZpclky?=
 =?utf-8?B?ZVJTblA5UTJIUi81WVpCSWJYakhRU0NEMkhsYjhNaytZM0dZdFRVSktnWENy?=
 =?utf-8?B?ODcwQ0VrM0VOSEJXclc0eE5ZNGpINjAxbTNHb01qWlZBRDJWZDhKcEJmR1NS?=
 =?utf-8?B?aEpWb0luaXRUZk9UUVdmQnpuZWpOOGtzdnRMUmNjRW5zMEpTVWVZSWN2M0F5?=
 =?utf-8?B?VklXMnhydk5lbi9WQmZKSGxkcXMvYmdpRHI0dnN3M1FoLzV6ZFZBaC95OXBK?=
 =?utf-8?B?UG8xdzF2aVA4dzB0amg2WTlDM0x4OVg3YkxQV3VPTzlwYlJNRVBuVGFQMUZu?=
 =?utf-8?B?dnRYT3YwRlR2QzBsUDMwbU5PYzU5aDhUL2VSWVFmVEw1YUQySnpCUVdLWXFp?=
 =?utf-8?B?OTdKVHFCU1NoYjJYUlVScjNzcmhYeGp1MEc4aUFqNEpEbzM2WWduMnZ0Q2sv?=
 =?utf-8?B?ZHFXRFRjWUg5SExyUE03VllScDJGUjFjVXdaYjFzR3c2eTgwNUluNk5sbTAx?=
 =?utf-8?B?UGtObnRhVSt6eFMvbnIvTTNweW84MWc3Q295dmVYOTFWSkJubWhoNzc3UHBy?=
 =?utf-8?B?QnhTd1lwNFR4SEcyZFJwWklleDR6d2ZOTGpyaFptaWJWYStuS3FiV2lqeUta?=
 =?utf-8?B?RzFCMjB5TTFwYi8ySStPZnNQQXZ3VFNmVjJQQVpTaFBmdUVtck9ZR0xCR1Rk?=
 =?utf-8?B?cFBqTGg1eU85ZUljV1BFZDhhZldQQlB2NzJ2cmRXNEtNUzFiWmFPRGdYMW15?=
 =?utf-8?B?TGdaU0lkUmZ0UmFmNkZFcTRJV09tRFh2cDBGUXhJS3VtY0FwdTBmdUl2WXAz?=
 =?utf-8?B?R2ZvSUtGUjFUNkxuc1VTczdEeWV1Ujg5K244a1dXWmo5R1Nta2VOSVRNSE1F?=
 =?utf-8?B?Q1E5VW1xSjZtbFJjeTN0dWw2VER3Vjh1ZldCRktvK1BuSmp2SU0vdnZpdXdK?=
 =?utf-8?B?dlJ6bkFicnh6MFE3RUIxN1RDc0Z4WXN1anBDVXI0UWRjRmNpOHFWb2M5ak5B?=
 =?utf-8?B?Y25tS2o0VmszK01hR2YrR1d0Y3RucHljWDUveDNNMld4NkNobEtuckhCS21n?=
 =?utf-8?B?US9jYkFwUTI5TGx2eUJJUU1KZ1ptVnYyMGpvU3kxQ09TYW14Vjc3Q1dHRklY?=
 =?utf-8?B?Ny9PNmlnZ3NNQXlsYU8zOVBiVmlqbFdvcWZadC9DVzRyWUQwd1lHWnRYVk1W?=
 =?utf-8?B?ejBSOWlwRmc4Z3hQV3d3N1JyTVdreUVTTDVEbU5MTkUxbVFheFVtSXRzeEhH?=
 =?utf-8?B?dkZ0Wmw2M1FaUVN0citxc3QzTVZDUEVVbUY1N2UybkVSaDl4T3M4QlZxSi9j?=
 =?utf-8?B?WGpBTmt3REgwOG5pbitIR3kxcXoxeGJVdjZib1dOYjRDNzl4WXZPTS9OSEYr?=
 =?utf-8?B?NXN1RzhrZ0VINWZuTUlFK2kvV0RjZlZqUlB5dDJYYlZ3SVNZOW9yOU9GdUFM?=
 =?utf-8?B?YkZHUGFsVTAyd2NsNTRpMHpoNDE1Tk55SDR0WVh5aEp1RStSOHJsUGJLNHlY?=
 =?utf-8?B?cEdhQUhqSWJUMXhPRmRvNi9JckNETlE3dENjcW9vS296TFpveWo5UVdhMURK?=
 =?utf-8?B?OEgzOHJaV1ZsSGZmdk8yZ2ZNRjFQcllEeFQ1ZjRnaFJHeTBaTTJXYXQxdXF4?=
 =?utf-8?B?UWVSNEdzelNnSStybVQvYnVJNE5STEZBM3MzVm1VMHRnSy9Dc3ZZNkp1QXFq?=
 =?utf-8?B?SVVsUFJWdFhhWUprSGxWMDFlcWVPdFkyUEdRTlZCdFNRUGRvcE4wejMzcVpC?=
 =?utf-8?B?L1JYeUtodXFjbGUxNWl6cUltTndHalA1aUFYV3E3STJTS0VvL0JBanlNOHNx?=
 =?utf-8?B?NGF0TGh3d2JidEI1aVBnNFhXalNnWXB1S3c2a1Bhbk11dGtncWRYTGx4Tk5Q?=
 =?utf-8?Q?5hi4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9c0b14-4b5d-404b-479f-08db34f711c2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:26:36.6040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQQNT41l27N4dl+yWzl+Pp0MK/GT5q0WSOxODwuP5HAfSpNO4X/QlgiTRR96GQ9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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
Cc: aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.04.23 um 11:56 schrieb Shane Xiao:
> For userptr bo with iommu on, multiple GPUs use same system
> memory dma mapping address when both bo_adev and adev in identity
> mode or in the same iommu group.

WTF? Userptr BOs are not allowed to be exported/imported between 
different GPUs.

So how can the same userptr BO be used on different GPUs?

Regards,
Christian.

>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e7403f8e4eba..33cda358cb9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -804,11 +804,11 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			 va + bo_size, vm);
>   
>   		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
> -		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> -		    same_hive) {
> +		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && ((adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
> +			adev->dev->iommu_group == bo_adev->dev->iommu_group)) || same_hive){
>   			/* Mappings on the local GPU, or VRAM mappings in the
> -			 * local hive, or userptr mapping IOMMU direct map mode
> -			 * share the original BO
> +			 * local hive, or userptr mapping in the same dma
> +			 * address space share the original BO
>   			 */
>   			attachment[i]->type = KFD_MEM_ATT_SHARED;
>   			bo[i] = mem->bo;

