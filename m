Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E0AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3582D11248A;
	Tue, 31 May 2022 15:32:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D5311248A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG5dDyCWcklq3dGULKV9TzDSJEQgJ2wtFzUeCaZ/z8jANXmfZQ6hhtPz4aCfo1QUbeZJIIW+uMRFkrMVVr2MuBBOryAVJ2YXNImw5T0PE1M8hx9Mh0Zn6YuV7mEfpUUpejIY9xn61qiYLhm5wIbIYhuQP6doYhErWlUrtNnrmvOXMpBMaaFt8rawadel2X86f7E12XNwWNSdTy3AVTSg3Wdq/eedgwyOtgr2KP/ipY/4UTz1yRHXvfclXQuoJb12PD7xnFT+rpApU95x45AKU5nlrJKIjmUd8e2SB8ktEOOY1PTyVaTGGO45KmyoDgmxR3iQvjqUcNzX6UYabic6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrJN8ZMBResD9Z+cuQzyYBjZJeVnm+3SiiQMJ8LFZUQ=;
 b=HmcotYNQOQ2tbyE9BfGcZH0isPABQgwf+1LGraEiHJe2aPD+uC8M7qjoFolNyzbze6sKG7sMmwpgBwj4yLGmuuVXY74+WpU4Jk+byxima1Xn2sQzZx1DwawP2kv02wRe8+y448khs9gBY7bkzEH2LxMECMRZX/DUOJ2rMMqQyG9/RysJrLt9QIQQHXEQ9HfvcH7JN13Gt7mTPfBx8gvTR7VkKefMZcAncd7c/yK1Mv+tRi3drissOzC70gLRiF5tmtA/N4QOaqQYS+PJX5MsOeYBqjCwdcxztSqBKV70Fp8mP/bpO3m7nzscLwV4fUuCfXj8qjJzUdBgeAWitznrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrJN8ZMBResD9Z+cuQzyYBjZJeVnm+3SiiQMJ8LFZUQ=;
 b=heBkmqhic1Z0wEiLyjTO8KfXNH/gr1QzGSz0cT/fryjCj3UKBoL2f1ulSQkEl5WRQl8bg3HJ7lC5Fkw9s2isWY6V1Tti7hIE7gRklG+70+r6flJ0lNt1zeRCVPIVG87xBPjq+VFKI61kVAN2H/cr8BOdnMdN30Ra+mhAgFjQE1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 15:32:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 15:32:01 +0000
Message-ID: <88d18f7b-68e3-bbe7-b7a6-9089f3cea9a4@amd.com>
Date: Tue, 31 May 2022 11:31:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 5/7] drm/amdgpu: Add work_struct for GPU reset from kfd.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-6-andrey.grodzovsky@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220525190447.239867-6-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4009da9f-779f-4f44-aaf9-08da431ab505
X-MS-TrafficTypeDiagnostic: MN0PR12MB5883:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58833EC4A2879B366C0CE53192DC9@MN0PR12MB5883.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zQD+6rWyZR3A0f3LHE9/ToyoD9xyRsMR9/Wv8Q8jza9zqysJkPKGFgBWVNDtpjNWUJzo58nJAXq0SqMUIxR/djCz/2GuCjkm+Q2MQXXA8LOn0kPYWUoFkFF+8pIXzJUUglggYhJQ76Tf88BfIAzceDt/vogWZs/wHPU6IUGs4s0Iidz6ySlmPSiBiH7kQZswNfcxBgLGlTGysasyfGfohuHl1LmKdbRTUa5Fuik7CaT2ysrvfYi+tBbc/TJtn781b4twImNW8MmL/SN3ubk1kYWin02C3Mz351qvp1fWx97ZSeTkOtZ2n9jPcDMznLT+xN71CBc0/gUN+nI3jcOxBVk+B4e8tCKa4dQR6TFqxpdSDmBoFYJOG/fX92/eD9VBK725BmAmWVjf+rDxaJ1BeDeu5RDLdISwjXKOw6KwfC1eJ4BClevEDn6sSIHelRO28wREyWgyPBIXX/Sm9yZh4aWgR3AsgwYbAHQa3mQOPi7ZV+FjqJXdp1Is+7eX1S9NiNh+TsFNJ3GtINI6kwb1X9dA/7O+mvjyrgWV9ZAscnGBb8vv890ZeBDqzyzBXiXLPqEH5sBpl4mKZq2C5uXZ1YjBy4QHIvFu8sktT0zfRvfFDONpSb1OVrYJJ72ZlXsKdOdOLlYZhqvQOmFwe/FxtbcJRg73O0wBUjWlMRhIZ6TRbAftJUqFKZlZU+g85kfcqsuB76fWmrldJyNixGDavgyId48avJSTGCJo/cty25oDh+uUhS9EfHfh60AXzqh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(36756003)(31696002)(38100700002)(316002)(8936002)(4326008)(8676002)(186003)(5660300002)(2616005)(86362001)(2906002)(83380400001)(508600001)(26005)(6506007)(6512007)(44832011)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUE1VmQ1RTlHUENYK3NkRXZ5ZmhaVnhpQXFkSFVKN2hOZEs4WTRsUTJLT1BN?=
 =?utf-8?B?WFVHYVlBSW43RDJPb0w2N09BdkhqRkRzKy91d2U4d3lxcFlzMFZqN0VvdDda?=
 =?utf-8?B?VlJRTmFJTnRIVFVnaXdxNFdXZ1pCY09Md2lvZUdsVjMxaHdoZ09ESGpFRnhr?=
 =?utf-8?B?UTk1clVDQ0V6cG9OMGpMeFFJMGNSTXdCdVlmTDdsMDIyUElvbGQ5Q3YyK3ov?=
 =?utf-8?B?VHZyMGVhLytUU2o2dVNweHZ6QnFNWnZUTWhvR2NjTDNlRXZxT2JzOVBNSStZ?=
 =?utf-8?B?Y3pSR0xNZk0vWnYxWEJsNWp5YU8rZ2RLNm9FOHpVOTJxczRzenpJK0dBVDRk?=
 =?utf-8?B?QzlWZ3JBVXBadG1ReVZvOHBoSHBUcnJTRitPc1B0N0swdUZlc04yYWJHK3NV?=
 =?utf-8?B?RHpXR04yRHJqbzhEbHN3em4vT0huejF6QXBhcURBZzdud2hHV1dqWjhQVDBP?=
 =?utf-8?B?eGU1azMyMW5lLytVUTh1U2x6VDF6SnJFWXNIOGkyQUlsS1dVRlNDeUF0am9Q?=
 =?utf-8?B?NDFiSUhSNlo5K2k4RDBJUXpFdmMzK2lHK3ozL2VDSXZkL29mWjdraDRlRGU4?=
 =?utf-8?B?ZWNvUjE3Z1hBc25MY2xhcUoxUXIyTWRvaUI3YVVycEVlTktLZVhZMDNjTFM0?=
 =?utf-8?B?Q3FNa0Zrb0Q0RTNyVzM0NXQrRW5MdVI5TDE3MDdPdjZwZm12OGdEcWZtNC9V?=
 =?utf-8?B?UlRXMU81L2JDTXFjbXJSbnFraE1Nc01TUFBQYm9YUUFGaVdLS1BZdCtJTSt1?=
 =?utf-8?B?SERwZzNZdGVwL1IwNjIxcXhvWS9PSTI2eGFlUDNMcnUzMmF2dDBDOUQvTUpv?=
 =?utf-8?B?V1laODM3OFFqdHFJS3VNRCtFZFBDY0ZYL1A5R2MranpFakRZVmpmc1NzdC94?=
 =?utf-8?B?M2UySWxPOWFTa1JCZkowc3d0MXd5WkI4Y0Z0ZlYwTDk0djlYV1MxdzMxRUgy?=
 =?utf-8?B?TVpXckdTL3BiSFJpOGhJQ1VxQ0poQ0MxSnBHdmN2NDAyOTFvQnhaUzRlcWNQ?=
 =?utf-8?B?cCtwbDV3bUdBY0hkL0NMNng5bWkvWVloQ2hwYWJxMktrM3R0bVZkUEdubVNQ?=
 =?utf-8?B?UzZjQytHSFpaQnY1UUdBS0tlNHZpV2xVcDA1ejFLeGZRS3g0SmxCTlhBK1V0?=
 =?utf-8?B?Y1VtZVVuOHhLQkIxV1lCY1FEdzRNaThLMjljOTlYaysvOXhxLy9Ga2ZnS0FO?=
 =?utf-8?B?bk9qNTlpSEtOamtvOWNxd1prRnphYjZYbXRabk1KWkY3dEZMbnlZUDRVN1U3?=
 =?utf-8?B?d3pGdzV4RVRjOGFHYjhoNW9mb005TGZiSFhteVBUemtKMitPdWhkVmhRWE5o?=
 =?utf-8?B?b05SN1d5ellzMzJ1UEpVSnlXbGJ0T2FWaC9pK2Nrc2Jjbm9wN011NThnbkYy?=
 =?utf-8?B?STVocm91cWVmaFFWQ1AwK09CcVBCNUt5UFIwTUpRM25WdDQ1UEhRa1d5alJC?=
 =?utf-8?B?cFE0anM1KzNFeVFmWkUyRytMYjJkQWQ1SEpwUGZoOGxsQnVvU2ZlN3RWVDFN?=
 =?utf-8?B?VjRxQk5mYUFSaTFyZlpUNGJvYXAwZlhabDNmcGhoMkt3US9EQUEwVFR3ZVFW?=
 =?utf-8?B?SERZdE56N3ZOZmo2cm54MDFOQklFSmZmRGNwelNwb1lZWlVyVHF0NFYvbFdC?=
 =?utf-8?B?em9oSlIwVFMvbHYzQTV6WVpkQkRsSWlpbnlQY01MaFJraXVQRUxvNG5EV2pE?=
 =?utf-8?B?bHV6bXUrNWxxMUt2K2g0cmphR3NSNXY2aDNvQkJ4Y2tIN2ExcHRKK1hZY0pH?=
 =?utf-8?B?cEF2ZFRVQjhzTFRrMUZtcjFBRmplMHlKd3Uxd1lOczFwVzFmRFdUSmo3OWwy?=
 =?utf-8?B?NThLN1JxMkRtQU0wZDhkT3R6MW5VbCtPNnI0MmxVcFBaeFdMWWRub0EzbDRF?=
 =?utf-8?B?UlFvTnNxdExOSUxDWG03ak1raDhRKzFrU29wY1ZaWWE1T0xTRHhra0QwRTBi?=
 =?utf-8?B?cVRSRlpFZzBRbW0vMVZ3Q2lpVWxzUXFhTlpEb0FQOUxCcEpHMDFQa05INWN3?=
 =?utf-8?B?VHJ5RUM3QjgveG9zcmRzRnc1Y25RS3dPbVA2ZDdQS3h5SVRrcDRSSlMrc1Fj?=
 =?utf-8?B?M0g3aTdTOU5NY2t2TFV3VDNiNkx5OFBoOE94dTY2YkJsZ0tnY0lEMnNqNEto?=
 =?utf-8?B?TE1SNmszdi9ieE53R0szNExUUCs2Wmk3bzBXUjVNM0N2bnc0bS93emQ3RUYv?=
 =?utf-8?B?QSt5MWZaQy93OEhXQ3FqTExVT1N1QThWREkreVZ6QllWNk1jbGNOOXAvaTZz?=
 =?utf-8?B?QWdVUi93K05xTVJkbkllUmxMM3B3UWdEM0VqVzRiOGViQ1FzNzFUY0RkdkZu?=
 =?utf-8?B?UzZxbXN2V1VIbnlJVCtVdmoyWmpiMzJHbVFPWUdzMzY5S2xQdTYydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4009da9f-779f-4f44-aaf9-08da431ab505
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:32:01.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFoJRcPWNq64aU06b1DdOixRD1Wo1WTQyJn2WxRO/Xgw1eRFymawAi/r4BSXcsdfWRnI1NmjO8wEteBrzUTrdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-05-25 um 15:04 schrieb Andrey Grodzovsky:
> We need to have a work_struct to cancel this reset if another
> already in progress.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ----------------------
>   3 files changed, 15 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1f8161cd507f..a23abc0e86e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -33,6 +33,7 @@
>   #include <uapi/linux/kfd_ioctl.h>
>   #include "amdgpu_ras.h"
>   #include "amdgpu_umc.h"
> +#include "amdgpu_reset.h"
>   
>   /* Total memory size in system memory and all GPU VRAM. Used to
>    * estimate worst case amount of memory to reserve for page tables
> @@ -122,6 +123,15 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   	}
>   }
>   
> +
> +static void amdgpu_amdkfd_reset_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> +						  kfd.reset_work);
> +
> +	amdgpu_device_gpu_recover_imp(adev, NULL);
> +}
> +
>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -180,6 +190,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   
>   		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>   						adev_to_drm(adev), &gpu_resources);
> +
> +		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
>   	}
>   }
>   
> @@ -247,7 +259,8 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_device_gpu_recover(adev, NULL);
> +		amdgpu_reset_domain_schedule(adev->reset_domain,
> +					     &adev->kfd.reset_work);
>   }
>   
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..e0709af5a326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -96,6 +96,7 @@ struct amdgpu_kfd_dev {
>   	struct kfd_dev *dev;
>   	uint64_t vram_used;
>   	bool init_complete;
> +	struct work_struct reset_work;
>   };
>   
>   enum kgd_engine_type {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bfdd8883089a..e3e2a5d17cc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5312,37 +5312,6 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -struct amdgpu_recover_work_struct {
> -	struct work_struct base;
> -	struct amdgpu_device *adev;
> -	struct amdgpu_job *job;
> -	int ret;
> -};
> -
> -static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
> -{
> -	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
> -
> -	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
> -}
> -/*
> - * Serialize gpu recover into reset domain single threaded wq
> - */
> -int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> -				    struct amdgpu_job *job)
> -{
> -	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
> -
> -	INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
> -
> -	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
> -		return -EAGAIN;
> -
> -	flush_work(&work.base);
> -
> -	return atomic_read(&adev->reset_domain->reset_res);
> -}
> -
>   /**
>    * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
>    *
