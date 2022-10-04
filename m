Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A379C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 19:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B63510E0A6;
	Tue,  4 Oct 2022 19:17:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CE910E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 19:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2+MOdrQlMYgLj7VseeW3FLukKr9GMgILqFsHZkW86QdQHj2frAu1YN4nG7eWJIScsNlFeHNtohMOV/06oSwi+4W/BuhFmlORQMvWjpnDabt9VD4JY7sXERCYWqNjURQ4DyyOSLBJ6QcXNIZNedH0z8ltuSvfgPlhxM5DsTCEBHmXG7ntLTWyqfgT5oWAu3ZZFYIxnMJ/HFyJeU86RWtwcbH4EWq+ytrfeKv37AOUrEC+LipxTLOepCnz0esf0NktZTW2DXk987Cu5uYNiQHTjV+s0DiWCEmcYKyiySwdab5ycN540yTYLYQQJ3I9J07osOVbty1JT3QVog0obzLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqFkVnxXNOWf8gPwPXi3rFxrvbOCFERFsgBjgRh/F+U=;
 b=dxW+qcRvf68CEMbX63R0ebTQ+WWMHrPfsER0qUrn3/dWfgN/ogjfoXBl4eNgxsh55ITjcv0peIhS5MJ5MwIMqV+vEWysutobaiGtFRUs48C27noHRcMPuM5bzjXSev2lrBql1i49Nwg3HRTXEOfZ9eTf7fSxlLs/Blbh+TccwRCgxgwak+XwOVRbGegcNu3BJdS20ZR7mjDa+fxZafURop4HebHE9Oe9padeHW8JeMLYgV349DfYx/BrPd+v64u68ugvErM0pcZy7wGlyPWmsJmykhD2lWYgX5q6X4m2O8xj0SSFV1vFy/MpSKPyzL+bDlRZwufkHKpFoWULGlbFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqFkVnxXNOWf8gPwPXi3rFxrvbOCFERFsgBjgRh/F+U=;
 b=K+bxRx91ZaE75nqBKJ4QYccrzPIGUET6S4V+HFGhRHD1ZIX2cFpWK3LtWrp67IL3X6iiSuZ8fC8OZG9+sxRrdswRfx+I4uX9ql1U8CA++n9HHTx3KZguxX3+qwJxZ64j4/Cn41nrSRD2cCL8nnP3X3wROMTuLJC550IM1Xk0mXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 19:16:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:16:58 +0000
Message-ID: <7bb97897-48be-4cc4-3802-201a16617b2b@amd.com>
Date: Tue, 4 Oct 2022 15:16:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Correct amdgpu_amdkfd_total_mem_size
 calculation
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221004164154.9021-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221004164154.9021-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 080ca38e-5730-42a3-6e7a-08daa63d01c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/5E7lQqfUBNi2KqCJY1yfs/DVv8duHK+jy2hLX3vs4B397wgbEIz58juYLH7CvQGSvNStt/7nFhzEV/h4NCCptNVfXSihv2E89F86Nq0FpJw3t74w6V/yduuV1cqWJYyOsToVhvhmaNuJ/pdsSlLkOss0FXWcNeMy+oZ4plDYVrKulaN3AnEbR/Izqci8Oum5zDgVcum47XFzSWZd/L5qomF54fEeJspWVJKgHJNaeqZLn/lWi6xT3YaYZkkiWhawufUs9kDipnARTRV98LAELY1wSHiWl0nAgLc44xRSIUUDFE/XwrdOVvk276bmHqHRfcMgOzRYGpiT8GuwSNnL8ZTxXRdavz6dakuXLKF6iTjvURTh6jyRJfJx2TOEiK48kLwELPrVg0kcWCc499c0yA8RweU8YFAWTxqA5DFpotoQDXeZH5Tq9M2q6YFAqezrvoU//H5mzP/zaNXMgcVle61RsF4wi81ixc1WxnVl5Me4Nmwc0f5cKMK9e5EWnp5RzL3lnOqXeyz0OV3oNCIAMVbZX1UrE/oxa3L51MrUmwg/XtSSDDVAOPAndJ7Y7Xqj6DzBOCt2bHyl7CEfEQUgPOim/3bIfAUXlsD0B+jqHI2billZqVww0mYEuHXssyBOY1M8v8DKMM7dbp6+awWARdHwQHh3UAeBIq1TL0qcd3Q/Agn8aMwysTzzhYg/2QF4wHuLT+3zLWhAQuVV5+DLQlaa7qI2hs0DRbsyG2GtAV7rY9PyUB1wTJIJmYtTREU3B86+5Bk6Tp9Vfp4lc0pjV93Fxab+WRRVnPg7mwNVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(6512007)(6506007)(8676002)(41300700001)(36916002)(53546011)(26005)(44832011)(66556008)(5660300002)(66476007)(8936002)(316002)(66946007)(6486002)(31696002)(478600001)(86362001)(38100700002)(36756003)(186003)(2906002)(2616005)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhFUEt4dHpnWFZPU1N4RURtOWlRTXlMK0FSWFUxdkhMbmpEeE9JZGtpVDd4?=
 =?utf-8?B?c2dlTVpORlo4VlJGVzB6U2VqSjJka1RRbGU0MUVyVE9pUUVUcUQ1NWU5bmUz?=
 =?utf-8?B?UzBrYmFwbFZuY3VjS09BNWJRYjVMVG5QWXl3empaZXpTZVpScEUvc0Y3bit5?=
 =?utf-8?B?cmJESWJ6TmxNdi9qTkRidUdCMlMzdHRlVWFxNHRud3NIaHU1KzNrdTdUMEdM?=
 =?utf-8?B?aVl6Z0kzNzdvWU1Vc2k1eDE2MlBKWjFKUUFmd2hQYk1LZGRHeUxJN1ZxTmJV?=
 =?utf-8?B?OXZONFl6cDU2UjVHMXZqUWdQQnFuUUY2V1UrcVVPMU0vTUhneGtjbW55aDNG?=
 =?utf-8?B?WDh5RGJBZGN5eXR2S0Q2blVIRXNzMWE0OVNQd29YTk1CU0xVM1lhL3daOWVi?=
 =?utf-8?B?Qy9sak90TCtMaG01eWhsK3R5TDhwRCtIeE0zWWcrdVJHTlQwNEdGcDlHeXdN?=
 =?utf-8?B?K2hWbFVOQ1R1N0RhbmFoYUFyY3E1U1lyNXRRRFBjSWYrYlFId3JZRlpQeHhC?=
 =?utf-8?B?cU01Zi9BQVNIZDRxRFBWWkZSL3gzN3dTdVB4K2puLzRaS3JwMzQ5cm5IQVJY?=
 =?utf-8?B?NTdOcm5lN2s1N0h3d0d5ZnE1eUcvZGFwOElNcG1vdm5Bdk1oaUg1WDdaQVBY?=
 =?utf-8?B?SHVzZEFvSEZjSC9mRVlIY2lXSS91UWlldUsrcGhjY0ErVm1kUW1uNFlDY1RE?=
 =?utf-8?B?RjY5MTVQT2lqMXluYlE0K24vUWJaalJyKzZiRHdIMEZZUVVlY1IwcWpINGVX?=
 =?utf-8?B?alppM1k4ZkhFZjJ3ZG5URUNDbnVjVnhiUXk0aXU5Z2pTM2pLVzE1QmJkVmdF?=
 =?utf-8?B?czMzUDdWMmZvZDJXcWJERUNOWmhtc0UwQXBFa1JZRkNZbDVjZnYvSCtFWDVo?=
 =?utf-8?B?RTFjN1d0Z3JuZFZWbEpyTVlOK2toM1lSTmFPSUtUSG82M01VeUhlOVhnbFp0?=
 =?utf-8?B?NzhEZE5FblNLdlduRzc2OGNXSDJjVlVLbCtuZFRoMExpSE16WFdGYlBwVjRm?=
 =?utf-8?B?RmYvWisxMjhwYWVid0ZUZ2pva3pNY1FSSHlObUZBOHhBL0h1Rkt5ZHcyR3lq?=
 =?utf-8?B?clovVFNzQy9aVkZJcEJjeVV6cmlhbDE5RlVPdk9taElvSmlQZS9xR1lOV25Y?=
 =?utf-8?B?aCtUVGtqUWZIbHNIdmwwbG43bjV4bEJZbUdHYkJEZnpkNTM4U1pJZXorVzBv?=
 =?utf-8?B?RDFDZ281Z3g3NXI1R2k5VzhBekdFZmo0ZHZqV0lnWGhsRTF6aC9uckdTcmJZ?=
 =?utf-8?B?T2haUTV0TGJ1c1AweXlScHVVeEtIU3h1dkFVYitpSlYzNnY5ZmJLZFVkd3hk?=
 =?utf-8?B?eHVqSVBpeTkzY3lQc0RSeVNvR0xJRlBtNURjWTNGMHg0WTcyU2I4MHk4cEhL?=
 =?utf-8?B?bUc0aWV6VGYvWXR5bmRGcGRoRlBHVlVueGduVjZ2VjFLZ29wemloT0VmT0t5?=
 =?utf-8?B?T0J4SlVYM2doa3RPang3NCtvdFNMYXlESmx0T1dJd0txaGhtOC84QndNUVJo?=
 =?utf-8?B?d1lGeFUxYkJkL2hyOXNvSnRjS0tkL1ZOME5tSC9HT01jbElqdGN0dDhoNmE3?=
 =?utf-8?B?VkpTRFZFOXQvRTdqOEM4emZ6UHYwcW4vMWZsZkNLOUExSDNpSUhlUVpvQktJ?=
 =?utf-8?B?WGEzMnRvM0toaVZDVGFFdmNHbzZRcTBVNiswV1lKeDZJUkp6bVNiYnIzRXZJ?=
 =?utf-8?B?SVYzcmNEU0dtOWo1dGVZb1puak5UdU9CR3lPSzFvdWdMTmNDNUZDTjZQK2dK?=
 =?utf-8?B?ZDc0OFRNbDkxVVUxaFdCZTI2ckJlWUtYQ3NBb2NwR1JSRzFaUDc2N1pQL3Zp?=
 =?utf-8?B?UWh6MTNNMTZBL0V0M1NNNWNheklqWmFBQk5lbDQ3V1BObjFBSmdIbUlnWU1S?=
 =?utf-8?B?c0dFSDFjbWZORDBzK0NOZUNwTUw0YjM1NXRCYjBqNVRkMytPWXZYS1FqRkFS?=
 =?utf-8?B?M2tBbitWWjA1ZUNqRWV0K0ZNbTZKZ1FWRm1yVTBFWm9CMThUd3p0V1VsODZQ?=
 =?utf-8?B?QVFySzErRGN6Y1R5NlAyRnRHbHk5WlN4WHRWQnpCNjR2SUcvdS9QdDZRbjEz?=
 =?utf-8?B?YUU5Wmo3YVBnNXJQRjdldmptbTcySHZQQzBwc2tQemp6ZGtQZ21xQ1lkNzhj?=
 =?utf-8?Q?CbdO5bvwkh/1wMjH3uz/3c3P0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080ca38e-5730-42a3-6e7a-08daa63d01c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:16:58.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nEejC6r9l4fSjTDEPReg45Bep0ykaRvF+5Fq1xnRkPTXDs44Yhs0VPZ79/MhTyqQZdkvFsBJOSV+cGzE2EiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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

On 2022-10-04 12:41, Philip Yang wrote:
> amdkfd_total_mem_size is the size of total GPUs vram plus system memory
> to estimate page tables memory usage and leave enough VRAM room for page
> tables allocation.
>
> Calculate amdkfd_total_mem_size in amdgpu_amdkfd_device_probe is
> incorrect because adev->gmc.real_vram_size is still 0 called from
> amdgpu_device_ip_early_init. Move the calculation
> to amdgpu_amdkfd_device_init to get the correct VRAM size.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Semi-related to this, there should probably be a reverse calculation in 
amdgpu_amdkfd_device_fini_sw to support hot-unplugging GPUs.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 9e98f3866edc..049d192c7cdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -75,9 +75,6 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
>   		return;
>   
>   	adev->kfd.dev = kgd2kfd_probe(adev, vf);
> -
> -	if (adev->kfd.dev)
> -		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>   }
>   
>   /**
> @@ -201,6 +198,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>   						adev_to_drm(adev), &gpu_resources);
>   
> +		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
> +
>   		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
>   	}
>   }
