Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9406AEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 13:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B2D10E46E;
	Wed, 21 Jun 2023 13:07:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3C810E46E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 13:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/+uXIGBOOOxi2Ejy9R4GLisRKiN59wYJFOvh5RSTj6uXD1CxMlKeZaQL4QObnyoqUjiMdKBkr/WEpfODF0YCd1JQkIT9VpUTXemZF1bWOLIKu63/QHlKbXXwalliSpiR/VthMkmNEa0MN8aEmUaiuGAfVGKmojxVItUxDpvTxQWzdvapBNqakpT8h2X+HvUO6rWrn75TzORfEm9DODTkHjN3Y7MTgDT431fItU2UxJgEY8peszxEN9ffVYd+zeNfGVoq29YAVxrTstvYRFapl+U/Ti2fMXThS92TLqZd0hW1k8iPuzq3EngKvQHGQ3SUaATBH8e5afZ+csUF0IEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+YYrr98M+0DcnCm45Mlse1f/bi91uWvE/erIIaTlqU=;
 b=UcXwqya5pj+1O5lKl4nLlIV87aOxOBKDnvmTY4aiwUDOizegG+dEsby5A4qhARqeYIDCysWBIvxV2SfL2loAbbTxk5wBZ6YIDgIqWG5FWzMPKClLvL2rpnqqol6oz/+cpHufaxbtxlmwNoTUEs6XxJsjnYa6ofVWN60QRDT7tPNfBnbaJIDpN+LIYI1+XUKkZgXNRhzsEn1PMH/OUEfyPX4vY8iQct4v+0x+yXDxajNQOySvgpG5BBM/CDA/rvPCYdoMsweRKEil//C6ZHqKeqYvaWcsnfE2NyxsW5qS7fDArS2y2EWUUqxZWCqlzsr9jD7rfomQq9hzRXdyQoWASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+YYrr98M+0DcnCm45Mlse1f/bi91uWvE/erIIaTlqU=;
 b=0Eleqvi5x+wxRpzU+uvxGUw4Yb/gS7JPVMt28TzkUPdUbS39wa6dpocCj17Wv3GCnIW0cQUJJOeUWSvnjcBwhaQGJZEskroc/qKSNWEuyC++MtzsNUjyBEdD125n9A/nO4tHHvGx6bcWVCf1AhxuuaXc0ZpCaBe2iwPafPMhbqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:07:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:07:01 +0000
Message-ID: <3a488ffc-1e9a-1ce1-b8f0-b8d9d5a02c3c@amd.com>
Date: Wed, 21 Jun 2023 15:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 06/12] drm/amdgpu: create kernel doorbell pages
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-7-shashank.sharma@amd.com>
 <20230621124444.2248-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230621124444.2248-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 40519eec-0b22-4af7-65f8-08db725866e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiDIynHhr85+Ga4SOGNMveU4sbcJxrPljcv0RI1ZtO7npmeulbLs3aEmD2wOwgjU5x65O2oe+l6GgfHhBBFbkyqKG5uGmMpsBEsDOjiRAzOgi4TR9KfvPt8w/41MP8O7c8GpHUGuecBjz/Zuqok+i8ce+Oa9xdP3BizYt4yqQbFalXQhY9bnDyasfkcHw2nGyoVmOix4Dkx7VXNIDd0124dGQ5LX/Vk9ImXpQF+MlbPEKuJrHcUrixVxqWbsPEEAzxLrySnfwcHq2Qg2zK+kjwb+HvD3FcMxV2Rjx80doef6W8Ptdxbys07jSRK7CpteNkflK1PF04P8G36FiQAOHXX3gz013FAVdqaIzB/o0dCZ/aMjth/mXhBfSnicflfRVole3UtWeQTP4JuZ70ZthtO4BgQ6djPU1T9m0EPklPILJ49SvsfHf5nnrSX1meYKHKR/mlA+moE3euc2zm+nFTC8HZtc6BFle4yLrMNL+BB/cnKdCtnrAGsOFAV+NBaciA+g6qUIVedszhkwN0kZ1Y3hQMqPOQ8Ez6mO/SrJRMRik2ic1K1VxEVDsFj8VLmYTwIpEXxseFQ7UhKPxqmtI+JdQ8TbJU7ARPnf8nrZouVH3voIfKr+iu35h8LG7t9KwfO0ov4wcj0r9O8/FYQplg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(2906002)(8936002)(8676002)(86362001)(31686004)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(41300700001)(31696002)(5660300002)(83380400001)(6666004)(38100700002)(6486002)(66574015)(2616005)(36756003)(186003)(6506007)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhIdHU3OHVTUmVYZ3BxWUN4WWgzbHVXNHUxUnhyMEprSDBKSTYrdXJEeGl0?=
 =?utf-8?B?ZGU2R01QRmtMM3ZsOXA3bVlQamZ0NkZkRWpsY3lmR3VTODFOK1FpaHg0ZnVC?=
 =?utf-8?B?blFjRFh1RkNyZTJ3UnhQM3pkcnRTVlVVNS9FblFtV3NlS2w5Rld4Y1h4M1ds?=
 =?utf-8?B?bkNvUmF0SzlpVlJVakt5QkFrQytrZ0svUFlEYXFjRVJ3VmFocnVEaGlPOXV0?=
 =?utf-8?B?SEJnNmY3MERhWUh5MVZXdFU3VGxnKzh1VWZCRWhjVlk5aWVBUnBCajdTU3Rp?=
 =?utf-8?B?RmM5MEEvRGlFeDFYSGJaRjBGWUV4NUxSV2o2TFJaTEZwNy8yZ0FaMHpneTRY?=
 =?utf-8?B?dWMyRTBTdTB0MDE3NkJFM1dPQzZtRlFYSy9TdEdSUk9halhoSFJ0VlM2c29j?=
 =?utf-8?B?b0JvQ3ZsdDFia0Y4S0dQdlZxZVFHQnAycjU3eHFUNHNIakUrRVpDT0lSMytG?=
 =?utf-8?B?a2phdlJHVGQrT2puK3FOOGtOR1ZwRDBRVUdqemJscGxiZEtZc0pPMUVEclhq?=
 =?utf-8?B?QnVxTCsrYlpBbngydW50UXBseTdPZ21zYWpEKzZKYXUzd0Fub2g3bnR4QVpJ?=
 =?utf-8?B?SEtGM1l4UkpSVHpxTVNVS3VGR1cxMDlvSDRpL2dJVEhyMlJBOXZEWE9TSlZV?=
 =?utf-8?B?OGUzcjFlYjdaVmpGbitjZlZDSE9ySXZSeW5sRWlQWmRFN3ZLUGNQNUU0NHpw?=
 =?utf-8?B?U29sd0MyMytSWTJTYnZrdUh6SGh1RDVPdG90ZDY3WmhZMUlKL3hhNUJ6aWJy?=
 =?utf-8?B?dGdnZFhCY29TYlRSRkt5Qytqc1o3V01MUHB5bTgweW1mY3AxMXloeFlVN2Mz?=
 =?utf-8?B?ek1XMEw4dTI3Ykdza2FTTzdUaFpUN3JiK2tLK2t2Nm14NXNsZGFsVE5WU01q?=
 =?utf-8?B?OVNkdnZYcDdmRVhvMXVPVENmNVI4dWswQkxtb1VBOGw2d3JQWGpkSzNsenNi?=
 =?utf-8?B?SkpoNWRYUXlUVDRMMG5zQWIzYVFvZzc0MGlZb1MvZC9IcXUxd2dteDV3Ym1D?=
 =?utf-8?B?dG9zNzljVEFRVGlFbGdMMHRPaWg4MmxKNm5BMld4aytUckZmTk5kUkx1TzBj?=
 =?utf-8?B?dDVWclc2VWVXczVwcW82QlBpdFF2azVscmRnTi9kYjY4SUVnMHJpczhNOHVT?=
 =?utf-8?B?SnpvU2dVMUlFZFdCYUIydlVPV1cwM2FTSm5ORUFUR0thUk5Bd05RME5UQk9x?=
 =?utf-8?B?K3JYeFFKemRpL2t3R1NrTGZxL09LK2pDWjRpeTBoSzhRdjhuaVhwTVZDTEpL?=
 =?utf-8?B?NnpGNm1pOVBycG1ndEVHMWwrL1RnZ3pQMGo5djQ4ZDlvL1BDNnRkaEttUXhk?=
 =?utf-8?B?OUp6dU9zOGhjMU5lMnFNSGUzS3ZRK1ZhaHVnNG1YVkdLZHlpOXoxZWoyNlFx?=
 =?utf-8?B?anJsL1NvWWhtRWE1a09teHY5NnpNOGlVTVhZamVwL3RQMTlERmJRT2NlWWFW?=
 =?utf-8?B?SnNIbDNmNmhBdytBUU9nSHdRWnF5S2lXRUh2UFV4Sm1uajlGYWFLcDJEYnJn?=
 =?utf-8?B?L2tndWdxSzBhazVqeUxFcmN6QS8vdVc4OWVUVXJPY0RZRHhoZm5ncnU5L0No?=
 =?utf-8?B?cGFsQjVreXNjVkJHZWh6a3VCSkFhL0Y5SmtkVVNXT1pGN0d5WkJoakgxNU82?=
 =?utf-8?B?SE9EcVBVb1VmOHBYSU5vTjR6SWE2azhjdDNQM0k4WHhXVUtqOVptUTMramZv?=
 =?utf-8?B?L2R1SlY5VS9hcjM0OUptcFUvSHVDcys3TGdCMkVFQjUrK21kOWcralpzZloz?=
 =?utf-8?B?REw1ZlNxMHM4emd4UHBaUUdRa2dwMy8xSThYZ1AwVXNOdDJVUzBuQytxcUdr?=
 =?utf-8?B?NmcwL1J1ejlHdFFidWNGTEFWY1N3RVhCZDd1ZU5RTFRZY1hPNDJGck9sbXdU?=
 =?utf-8?B?TGJQOTJzQVQ1OWxwZHlGVzJENCtRakZaVjFJY1A5N3JuZXFJKzBpMkZNVFBx?=
 =?utf-8?B?bGd5K3lpd1VGWjlUb2VkRTVMWkl3QzEwUVRzVXRQV1FjQzZINTZscXhNWWFH?=
 =?utf-8?B?d0pzMHZKb2ZodFRxYURVRU1xN2RYcVViZGxNeitGSXRIRkpMK1Y3S2hmVFpS?=
 =?utf-8?B?SVp0U2d0NS92blMvODdzd2VBTTJTaUNMM2NsN1pkZzl0aU8rcHpIeDBDMnRU?=
 =?utf-8?B?Y21udU5XNm9yU2IvVXpod1BkL28zMXRTSTRYckJ5aFd1UzU2R3JEd3lscWc0?=
 =?utf-8?Q?0ae0SJy5V1hCK/4TA6+0oAXfHPZljEjNCpROdd0ojV0D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40519eec-0b22-4af7-65f8-08db725866e6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:07:01.3739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsjAwcLmfi3VImF0U3VaY8hRKEQUyjjwtNkvfobKRRPzFkZVdIKEQBg2bbmQ6SGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.06.23 um 14:44 schrieb Shashank Sharma:
> This patch:
> - creates a doorbell page for graphics driver usages.
> - adds a few new varlables in adev->doorbell structure to
>    keep track of kernel's doorbell-bo.
> - removes the adev->doorbell.ptr variable, replaces it with
>    kernel-doorbell-bo's cpu address.
>
> V2: - Create doorbell BO directly, no wrappe functions (Alex)
>      - no additional doorbell structure (Alex, Christian)
>      - Use doorbell_cpu_ptr, remove ioremap (Christian, Alex)
>      - Allocate one extra page of doorbells for MES (Alex)
>
> V4: Move MES doorbell base init into MES related patch (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 52 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>   4 files changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 783e2b8b086c..002899edb9d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -31,10 +31,15 @@ struct amdgpu_doorbell {
>   	/* doorbell mmio */
>   	resource_size_t		base;
>   	resource_size_t		size;
> -	u32 __iomem		*ptr;
>   
>   	/* Number of doorbells reserved for amdgpu kernel driver */
>   	u32 num_kernel_doorbells;
> +
> +	/* Kernel doorbells */
> +	struct amdgpu_bo *kernel_doorbells;
> +
> +	/* For CPU access of doorbells */
> +	uint32_t *cpu_addr;
>   };
>   
>   /* Reserved doorbells for amdgpu (including multimedia).
> @@ -311,6 +316,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>    */
>   int amdgpu_doorbell_init(struct amdgpu_device *adev);
>   void amdgpu_doorbell_fini(struct amdgpu_device *adev);
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
>   
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index eb113e38f5e9..dd6744eb5875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -39,7 +39,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		return readl(adev->doorbell.ptr + index);
> +		return readl(adev->doorbell.cpu_addr + index);
>   
>   	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   	return 0;
> @@ -61,7 +61,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		writel(v, adev->doorbell.ptr + index);
> +		writel(v, adev->doorbell.cpu_addr + index);
>   	else
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   }
> @@ -81,7 +81,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> +		return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr + index));
>   
>   	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   	return 0;
> @@ -103,11 +103,43 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_kernel_doorbells)
> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> +		atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + index), v);
>   	else
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   }
>   
> +/**
> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Creates doorbells for graphics driver usages.
> + * returns 0 on success, error otherwise.
> + */
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
> +{
> +	int r;
> +	int size;
> +
> +	/* Reserve first num_kernel_doorbells (page-aligned) for kernel ops */
> +	size = ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32), PAGE_SIZE);
> +
> +	r = amdgpu_bo_create_kernel(adev,
> +				    size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &adev->doorbell.kernel_doorbells,
> +				    NULL,
> +				    (void **)&adev->doorbell.cpu_addr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
> +		return r;
> +	}
> +
> +	adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
> +	return 0;
> +}
> +
>   /*
>    * GPU doorbell aperture helpers function.
>    */
> @@ -127,7 +159,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>   		adev->doorbell.base = 0;
>   		adev->doorbell.size = 0;
>   		adev->doorbell.num_kernel_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
>   		return 0;
>   	}
>   
> @@ -156,12 +187,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>   	if (adev->asic_type >= CHIP_VEGA10)
>   		adev->doorbell.num_kernel_doorbells += 0x400;
>   
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_kernel_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> -		return -ENOMEM;
> -
>   	return 0;
>   }
>   
> @@ -174,6 +199,7 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_doorbell_fini(struct amdgpu_device *adev)
>   {
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> +	amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
> +			      NULL,
> +			      (void **)&adev->doorbell.cpu_addr);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 547ec35691fa..a403418d5eac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>   	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
>   	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
>   
> +	/* MES doorbells */
> +	uint32_t			db_start_dw_offset;
> +

This should probably go into patch #11 as well, apart from that the 
patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6d1587bbda52..c48e97646541 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1854,6 +1854,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/* Create a boorbell page for kernel usages */
> +	r = amdgpu_doorbell_create_kernel_doorbells(adev);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize kernel doorbells.\n");
> +		return r;
> +	}
> +
>   	/* Initialize preemptible memory pool */
>   	r = amdgpu_preempt_mgr_init(adev);
>   	if (r) {

