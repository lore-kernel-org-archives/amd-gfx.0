Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0863FEC8759
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8877910E267;
	Thu,  7 Sep 2023 20:55:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B488A10E7D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+y+z00V4ETdbkJzyG6FYSadv0Sy44u6qvk5+wmV+5zmZX24+YNSDVmTw+AXoZZDznEyN8k+bsiUPO0ALBL9ls1Djf4Y0X5CFOoLDEPZ8JnrMD/CbVthoqFHNEEgazcAzPSobyjKv2oI/Kxrmp654dtAHfvlJNuSSZcAmlyK3p2pp8G2tdhODqi5vqVnXXotElxg2u4QdclEdXBahkreHqLYNFg3mxfC1WAqe0HCJ1yUeRV1gEZ5N6ZWjgfPy9cHadZjrus4dTZii2WaRa8WC0QJ0JBHgzKN6idRSH85edRJikwBBBbKNi93T6gbMnCvwaK7Kf7ERuXDt/w5lTL6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1z67t8rUBs/HHLD0is5nVNS6COvVh87oATE8oP5wkA=;
 b=YJMOOz0mHU0mYRoV42OPwVhFvhXssb35qTUCCEIOambwFCKj8C4dhCqdjHMLp43LY1bqHugbpieNKT2A2OlX6xPWp9W4RkPkb78v+PbZ4NgJLFnjVhFb23cl7UM+CgOJtsVoIYJrt2F9jzZgYJggfgnJlLOWQSVVd3DTHX3vQ/hmdhP4wOonArykx6ZHbBiu3UnfOuWU4E6o0SWIMSxbGMYbZMCWDarxmR5iFYCFVKyBtZ2u5MdRLQloYgKtTmGM7Ao0H9rFTG4/Z2yKV5DOL1Bsi6AUtVnYWdXyCEUttFrh2CkZUJZyok/wXmCM4RN1gdTt7o+0D0f1cI+ju30Esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1z67t8rUBs/HHLD0is5nVNS6COvVh87oATE8oP5wkA=;
 b=bz72rUloPrjewmi9qJV9h5oXa6sWMVm1vQLIyWVHLXQJVMG3fR4lpxbs70BFv6aTiXaTjVQhirE/XW9RDwk4JmF8CfY9UsqXT8VuHs+SlREylg0iNie+hZW0rhVtp+HRG3/I7oQ1zwotu01I/dC9oN5bhbJUhpVZZPbrGorYLIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 20:55:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:55:36 +0000
Message-ID: <f04e3c88-70f5-9b8c-43fc-a26ea61db21a@amd.com>
Date: Thu, 7 Sep 2023 16:55:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/4] drm/amdgpu: Rename KGD_MAX_QUEUES to AMDGPU_MAX_QUEUES
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906154429.216489-1-mukul.joshi@amd.com>
 <20230906154429.216489-4-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230906154429.216489-4-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0184.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 325226fc-c0d9-445d-40fa-08dbafe4c901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfB5YRyLiFvVOFjmtmBQjL8qGnlmQZaDniJ2pS6XGgKPWHcJbSF0Z7IP1khHueI7ylKxsbrtmjvvcW+Uec9yP41TalLDjQNWOJdrDTqpNO7w+IHfZKxQVYr+MKTRlfbYqirVHwW/jiV7Gza1AtChdja8tqePVB8X138QoWIJ+HvfjEpzj+hNaonQwF50o9ktsyWljN/ljQePuXyVZSPNNLItIOaA3ZoihdL4D/N5oKt2u13cr6MU1qmMVqaL3LCz7CRMkGwLOeoigPum59iKid9ueTqZo3fJNGXE4ElbODUHk4xaBVo07uu/ev1DcMjq02XF4gJYY6OzvtheoMHMI7ikcPY3E6qRmWHcAxORZJUgD/n0ZP8ud1+h2HFCkcOGjVnadCIgt6Sp4PXOQVjpU3wXlrU+gnduYmoZ3AqKmz+QC58WXhOowKH/vU94MFKtXr2x0uZAKU2GlmNblZdKbhLZfHCGNOiOmIgmVMc47pIjBHB6A8z6W5ung3jeXjpsVQK0kfq49gKZF8mQ+451d6GtJRhwU6whS5rqna0gbveXotd/bhSdV1w32Rz5E8F2Q8a2Zz4oG69NWyeKwi8YFGWtt0AsHjIB0NX7o70GsIXfHQX47KlkNIpk/Dz5hB5A1bvsLf7+2vv+buc+jDNKyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(186009)(451199024)(1800799009)(5660300002)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(44832011)(31686004)(316002)(2906002)(38100700002)(83380400001)(36916002)(53546011)(2616005)(26005)(86362001)(31696002)(6512007)(6506007)(36756003)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZNUkVGdnZxN3RjS3FrdUw3c2V6eWRrMFpZTDhneENsV2VOQlRuUFVTS04w?=
 =?utf-8?B?SERXcWtxMzhoa1pZcFhqN3dmdWdHYTZoUUUzTXNoWXVzQndVR01FZzZnVGNQ?=
 =?utf-8?B?SnU2MEtoeEd6SWZKbWtITkx0TjE0VEpBTWVwcU1lR2ZieFZyREZkRDZQUkFI?=
 =?utf-8?B?V09XVWx2azdvQmUvQXV0cllYOFBDaTRqS1E0V1IrRFNoQmNaUXc1TjQwNy9T?=
 =?utf-8?B?YTRnUEZ1czdMK012bkV6N3Z1R2NhQ29YWEY3K245b3JjeFQ3WEo1ZkpCaGhW?=
 =?utf-8?B?VVFMZGlLRkMxNmRKWlNsS0JqR21aaGtaU0wwQlI4VnpFV2NRcUlIbUFxdTl3?=
 =?utf-8?B?c2lLQWVWVmQ2N3RMNWxhcEJWN1JaekVRVWlTcTBaWmRsMjB4aVNoeTBNNW04?=
 =?utf-8?B?MzVvL0RVbFZxUjZQays4MFhkK0hHMjdUVTVWZGlmSmFVSUU0eHhTSGd6Q1R5?=
 =?utf-8?B?TENHSjQ1d2V2Z3ZqanFyaG9LdnZMSnVDQTEzdGhJQnQ2SVFMbzR4TGxia1po?=
 =?utf-8?B?WlpZZXRSMkNWZThoNGxvNTA4b2IyT2dlQnduT2xGbnoyaUJPeGY1cTFXK0tQ?=
 =?utf-8?B?Y2RVWjhkbnVPVGJTZHNlYThRQnVuMWc1ZUJDTHBPTktJMDh4RlVERS9tMHdE?=
 =?utf-8?B?NGtWTjE1WGs2Y2drbENSck13NVhGRW5PQTNrU0E2d2xwS2cvSktCUzh3K2FD?=
 =?utf-8?B?SVBEOEViS05WMHZzWk1hQSszM1I0YzhNNlJxWDRXZXdhazlnbTlGZGFodHpW?=
 =?utf-8?B?VVNaYTBKWmJmNmFmYTVVT1lIZ1hOaENMeWVtQVVVYmkvZUZVQUx3Mm5IYTAy?=
 =?utf-8?B?R2IxTm5zN1FQb2lxWkJ0QUE0OTNZWmg2NGhJTU1TOUZhZUxPb2VWcGFILzZt?=
 =?utf-8?B?b1NEZWsvN0ppcmNZK2tibGVraUZyK2VRTFJTV0JtSC9mc1djWnpHMllaTXYw?=
 =?utf-8?B?SlNCVTdGK25LUXhKa2tXWC9uNTk3dTNNYkQ2N052RWdhZGUvQUZpSXA3VVpj?=
 =?utf-8?B?dFEwVmdxRVdGODRhZytVeEZhSFlzWkExQmRBa2c0akUvOEFQcWlGWWEwV09K?=
 =?utf-8?B?Zmsxd1hWR3I3b0xsUGpFa0V5WnRja3NzbWx4OStpWHFya1I0K2VlM0xWNGx2?=
 =?utf-8?B?OVg4RUl1ancwalhtbUNlbzRtT2JwZmh5b2x3R1hRaFhqbWx3N2kwaXpuWWFI?=
 =?utf-8?B?SW9qZklmUDE5U2Z3NUNrZ3NydHFic0dWZUNqQUZINGM0S0c4aE8wTHdrdVkw?=
 =?utf-8?B?YWk3aVcyVGVzSEYrQUtXVmtNaFVVMnhkWXJONHBTOXpwRHo3bjk4bi95azBQ?=
 =?utf-8?B?cXNCUVZRYjNKc2xidnBVOUl3RmRoTlpsVUx0ZU1GMFNRMEY5TXM1UkVFbnRy?=
 =?utf-8?B?Zkpqdm44WXF0NXlvTEJNdXBid202SVBUYTZmNFRrUGZtM3c5SzJ0WUlYUk1k?=
 =?utf-8?B?ODJ3U01lQlM4NEl4QW94VEJzUFVwTHlEeGJvRUVxSDBITEN3akl0QlJ5QjNO?=
 =?utf-8?B?SEROMXRPZFFvWnVyY0ZqQjZDM2hqZ21hRnRNTWQ2OXp0Ny9VWDlrbXFXTFU5?=
 =?utf-8?B?V0hGbnNQOWJBcDFISjk1UUVGZ1dGZzJzZHpMYlJMMG4vbkVQQWZ1VWlXZG1o?=
 =?utf-8?B?blkvSU43d0MxaW1Xd0ZBUmVMaGdqcFJmMkYrb2t0eitRbzkwdDIxMUZ6SEZN?=
 =?utf-8?B?YVhnQWw3UnRTemd4dHl2d2lmTUlleHJjeUdoK1g1SmpGaE9Db0tabVhCZUVG?=
 =?utf-8?B?Wml6VEt4Nm9EVHVPclRYbVlXbG9Ja1FPa1IrM3l0MUtldzJtT3djSFE2VHJi?=
 =?utf-8?B?TVFUcFdRV2pUODdERi9mUWlpWGxTcG0rVENZTVo1Ukw4aHlSMTJwZTBpOFFL?=
 =?utf-8?B?VzVkRFhDYUR3cjRzS2ZwTlc5aUZhMHhVNzdvYUg4cnptWFdQYXMrRi9UcUVV?=
 =?utf-8?B?enIrUG5sRERidUJDUEE2Z0pOK0tZYXZRZW53YktmdTE1a3daYzIwMHZNRE0v?=
 =?utf-8?B?eThGN0VIVVZjUmNMRnk5TjhwUW1hY0hlYzhEc0NaeVRjMi9mdDFFbWtpM0V1?=
 =?utf-8?B?RzR5bVNVY3BjczA3dURUT0czMndKbkplWU8zU3g2bW0vSXI1dEdGOTArUitE?=
 =?utf-8?Q?Kn8FBCf66WCqZmlPWWiiXKBrI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325226fc-c0d9-445d-40fa-08dbafe4c901
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:55:36.3880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBT22SZeD0IUJ/SM6N+4Co1fC6aeNkZUTuNUxHZOUgWpmq1Rkw/XvX4uqBZafiDUoIYQ/E/JWhs/Dzdr/lqgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

On 2023-09-06 11:44, Mukul Joshi wrote:
> Rename KGD_MAX_QUEUES to AMDGPU_MAX_QUEUES to conform with
> the naming convention followed in amdgpu_gfx.h. No functional
> change.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c            | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h               | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
>   drivers/gpu/drm/amd/include/kgd_kfd_interface.h       | 2 +-
>   5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 25d5fda5b243..26ff5f8d9795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -164,7 +164,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   		 */
>   		bitmap_complement(gpu_resources.cp_queue_bitmap,
>   				  adev->gfx.mec_bitmap[0].queue_bitmap,
> -				  KGD_MAX_QUEUES);
> +				  AMDGPU_MAX_QUEUES);
>   
>   		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
>   		 * nbits is not compile time constant
> @@ -172,7 +172,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   		last_valid_bit = 1 /* only first MEC can have compute queues */
>   				* adev->gfx.mec.num_pipe_per_mec
>   				* adev->gfx.mec.num_queue_per_pipe;
> -		for (i = last_valid_bit; i < KGD_MAX_QUEUES; ++i)
> +		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
>   			clear_bit(i, gpu_resources.cp_queue_bitmap);
>   
>   		amdgpu_doorbell_get_kfd_info(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 3c45a188b701..04b8c7dacd30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1037,7 +1037,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>   	int pasid_tmp;
>   	int max_queue_cnt;
>   	int vmid_wave_cnt = 0;
> -	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
> +	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
>   
>   	lock_spi_csq_mutexes(adev);
>   	soc15_grbm_select(adev, 1, 0, 0, 0, inst);
> @@ -1047,7 +1047,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>   	 * to get number of waves in flight
>   	 */
>   	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
> -			  KGD_MAX_QUEUES);
> +			  AMDGPU_MAX_QUEUES);
>   	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
>   			adev->gfx.mec.num_queue_per_pipe;
>   	sh_cnt = adev->gfx.config.max_sh_per_se;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 0ca95c4d4bfb..42ac6d1bf9ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -43,10 +43,10 @@
>   #define AMDGPU_GFX_LBPW_DISABLED_MODE		0x00000008L
>   
>   #define AMDGPU_MAX_GC_INSTANCES		8
> -#define KGD_MAX_QUEUES			128
> +#define AMDGPU_MAX_QUEUES		128
>   
> -#define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
> -#define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
> +#define AMDGPU_MAX_GFX_QUEUES AMDGPU_MAX_QUEUES
> +#define AMDGPU_MAX_COMPUTE_QUEUES AMDGPU_MAX_QUEUES
>   
>   enum amdgpu_gfx_pipe_priority {
>   	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4170e3d32630..6d07a5dd2648 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -92,7 +92,7 @@ static bool is_pipe_enabled(struct device_queue_manager *dqm, int mec, int pipe)
>   unsigned int get_cp_queues_num(struct device_queue_manager *dqm)
>   {
>   	return bitmap_weight(dqm->dev->kfd->shared_resources.cp_queue_bitmap,
> -				KGD_MAX_QUEUES);
> +				AMDGPU_MAX_QUEUES);
>   }
>   
>   unsigned int get_queues_per_pipe(struct device_queue_manager *dqm)
> @@ -1576,7 +1576,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
>   	res.vmid_mask = dqm->dev->compute_vmid_bitmap;
>   
>   	res.queue_mask = 0;
> -	for (i = 0; i < KGD_MAX_QUEUES; ++i) {
> +	for (i = 0; i < AMDGPU_MAX_QUEUES; ++i) {
>   		mec = (i / dqm->dev->kfd->shared_resources.num_queue_per_pipe)
>   			/ dqm->dev->kfd->shared_resources.num_pipe_per_mec;
>   
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 3b5a56585c4b..255adc30f802 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -123,7 +123,7 @@ struct kgd2kfd_shared_resources {
>   	uint32_t num_queue_per_pipe;
>   
>   	/* Bit n == 1 means Queue n is available for KFD */
> -	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
> +	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
>   
>   	/* SDMA doorbell assignments (SOC15 and later chips only). Only
>   	 * specific doorbells are routed to each SDMA engine. Others
