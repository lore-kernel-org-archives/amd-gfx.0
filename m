Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2863C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D717410E689;
	Tue,  7 Nov 2023 19:56:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC44610E689
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdqw505rxtpuQewn7DSvvDw848sL9xv+wvpgWEmU9Ethnbii62lAgdeIkA4V3IhiPofk52kO+cU1k22QmnFGy9hyXPWpteUoqGXzCIxjcSUSjDKEHUVUGVylM78oAhUC83IwZqqG5t42d1o8iD8Nxe/GMzlRfNb687nWzeljG7o83MaVk9towrLXr4cmLDh1uVm3ZrTdY9p3ES/VKvEK2HwPSN1dl7/XcJ1lcjhsIlRRGPzawpID67Jy8HKaapHNneUnnceLyCvDNzWXH+/4Qbzs8sDuXROkpuCnZpami5OSkhiloplCWp4WK+p5dZL3RHz6BHNnai916FRMXOEAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWW0QsLfq+We04a9uil2B5xrHfwtOcGNdrpi2Exm/Aw=;
 b=A20Z7HeV4qtYehuWClveMDc5AvoRBLXvtEQ6/JYUGhsr9cIizM2royC3DPK8VVehYjDr/761atAVnUoNXFVVB2fyo9TCXYgRCArQsEM+ViSobakMrcBOfDvFII3kZAgxgKwc3CE39tM0a0g+JSRSdNwXP508LnwnILYTqzA/Hc/svXfXagZxpkaTuOlo8oL4GJMpt6alK+9KGAagsCMjDu1LCFj1uUanXHEy4BXmgabhdbpSFvxLE5edMwMpqYYeNgh7C6wcjREVNlPxvMEMFb++CgG6Snpylx1agcq+pHEDwIek7xCZ1sBK7hNDtmU7m8M6+k82G1JXyefm0hUPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWW0QsLfq+We04a9uil2B5xrHfwtOcGNdrpi2Exm/Aw=;
 b=03PWShlZhUiEGdrijc8NxlutRzrqnmQpqnbagbQcuFJPCobszAIFli03if162IQ1y5AZKYOI3jSXZQiL4lw2wRrR6tYtI1hccZFDceyVVvthPMv8z/8o5yUEmiorLOKL3kDouMKCnM2zzs+tgexu3LKtlMEzekzKGUulEP2CcPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 19:56:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa%3]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 19:56:55 +0000
Message-ID: <b25b2e4c-0d8a-4474-981f-740a4b060577@amd.com>
Date: Tue, 7 Nov 2023 14:56:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdkfd: Export DMABufs from KFD using GEM handles
Content-Language: en-US
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-4-Felix.Kuehling@amd.com>
 <SN1PR12MB25751192799E41D409AB0758E3A9A@SN1PR12MB2575.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <SN1PR12MB25751192799E41D409AB0758E3A9A@SN1PR12MB2575.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: ce89713d-c14c-4e9b-3ba3-08dbdfcbb180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0A7o0I4SqWBBEccqjEVlef3OO684SWsnxVUngErhOIewf5SaLlsp2stXKTL6gKangaPqr8MaZZLoMQtSd6GTS8UxJGNAQ0OVd1LZRrVTPVvI/MS7OuasnJyCxLKjHFcq5bTDXmik6mGQ+I6qE5PRTjTFehW8WU3QGGqDmzILX5QXbseur941+f1605UaUtEgG+sVG0Zn7WxkuWURdE+H1dpWbi6A3NtsPBJNAJLwqZpXWjQtkLwwub/7E+dLYlb9nVVJPOmSngwQsCB4rlqCB6cNmsPEHKHbLMUSeeOraITWGrQQBPE8e2b0hltPqRItBhkdjbJhL9zUqVWn7zo3Vtsl8CyvzeilmHUQAJc/CEsP06uvpiFE63qj1Co8Uy9FjPsDD1DZiLhNIW+TycKjorUibvTfG4iuiQuV2SWVtNrfGW/C2JhDS6VqOf4C1bEwORuciusIS4JR89DSrR6ebq/D0c+NjEtr899SH5OXHaaA8KfMRDcO28Rkq26BsIiKH0Dy8FfdIP62M3FLsL9iYDlE33rcm/X4RfC6TteRduOyb8fJ9UD0P7r67Qm5yVenyH7RH2F8UjdpuYH7s6evI1PFVBJsPNW97Mn+KFabyuwmIsSzadpgLVmdBbIv2AqYBHeC7Z+KybdSXjM7Padwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(5660300002)(31686004)(26005)(316002)(54906003)(66556008)(6486002)(110136005)(66476007)(6512007)(6506007)(478600001)(66946007)(36916002)(53546011)(8936002)(83380400001)(8676002)(4326008)(36756003)(41300700001)(2906002)(86362001)(31696002)(44832011)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME1pWUtrVHdqNjVndXVWdWRUT2JZZUNtZXpsR1h3czlsalNKUTE1UEY0QU8v?=
 =?utf-8?B?OTQrZVhYc0RYN3h0d0JadVBkWHJCVVNkT0tIdzZwbFFCL0FycDFpV0kvRW80?=
 =?utf-8?B?VTZCMjBYWkRsaUQ2aGVJbHh1dFNBb2JiQnlVbzU3VjZRTmY1UFJIWUZvMUJu?=
 =?utf-8?B?OGc0cG5pbDhmKzhWL2I4emozbmN3WGgzbDhXMVFQWjRabitoS0NIQmx0bVZS?=
 =?utf-8?B?TDgwZXBtRFB0RmdyY2JoS0VBTWdpSW01NEt3TG9uOS8yMFZWRmlSaHk4cmJ6?=
 =?utf-8?B?QmMyVngveUR2dzNPMWxjc1cvaEU4ZEs1ckIrSzVGU1ZIZ2xtaFZsbExwTnJO?=
 =?utf-8?B?MUl1eDQ3VEtSMzVVZXFUc3VzT2RlT2JsRVhNUU1JQTJFMTdyNGFsUWJNcDU4?=
 =?utf-8?B?dHRVcGNkbmhnYWdGbUFQcEVpaXBwRDZXTHRibjFEeGlMSWdYR3pIbUN5V3ZK?=
 =?utf-8?B?U2U3M3BSKzcweVhIcFlOczg4MEEvK3Y2N3g2c2w0ei9MbFM5TkhZNXNicWRM?=
 =?utf-8?B?ODROekROc1RoYW5XZVpIeWRqMEJiQS84QStucnZsaHp4L1MrWjhSNVNrdmpK?=
 =?utf-8?B?eUM5dmxGVnV3YVhLY09tb3pldDFwclI5amw2YVNvL3VOYVgxY1FuM21JOVl5?=
 =?utf-8?B?NEg0aDZHUnN4ZWMvemg1M3pVbWRIci9xOUYya2tjOVU4aG1INXdjd0loUzVr?=
 =?utf-8?B?TkZFVm1HREhSSGJkL09TekZHaUtwT1hQRjBkcVlmNjROdWxXa2IrLzh2RUwz?=
 =?utf-8?B?RE5iTHo3OHlLVDNNNUc5NnErR3VjbFErbFFOaHdmejM5SEtUTG5rY3pWdjFj?=
 =?utf-8?B?S2IvVmQrU1RBMFFmdXpPc3ptMnI5Wk9ZWkJKdkZRbHdMOXpQTk5wQndwelVv?=
 =?utf-8?B?QTNKQndmZVoyT2c1OXBmNzVMRjNObU1hK3R2cVp4Z20vUUtSUEt3VlpDTXFU?=
 =?utf-8?B?TytxZzYvQ2ZqcVVTbDhDZXRwREN1V0NOVms2ejFFWE1CS2RwaHRUM0dERzNM?=
 =?utf-8?B?aGliMzhkSXNnNmxPTjNkcnVyUGJDU1BiM09xRGxLa29uQWdxMi93QjlucGI1?=
 =?utf-8?B?VGZVWkhCVHFNNEFxQ0ZZUnNlNDJsdklZenVnWUlJYjZFbzRtU05TZzMxY2hR?=
 =?utf-8?B?YnlUTTZhck5PemNyZlF2SGlwampTS0RKR3hNNHFFVld0ZVNhOHd3d1Mrdk1O?=
 =?utf-8?B?NWF1UU1IQW81OW45KzFXTE5ndEdVYVZGSlRkZGkrLzNmUWZqWk0wMkFqQlph?=
 =?utf-8?B?dE9XSDBVQ0RMaUhKQVJ3ZHY5WUJtcEh4eTUwWGpkK3Z3eUZsaUVMazhCR3l2?=
 =?utf-8?B?RDZTT1A2SUg3eDR4WXZPdHo3cUo0MGcvRlJhMTh5RzFBZUpKVFZsd2NKUTVp?=
 =?utf-8?B?UC95WFFmcEJZL0lVNUxlaXlqMU11VGk5VTRGazQzWkV2ZEsvdlhzWnUyRGR2?=
 =?utf-8?B?cXN6VHRiREl2KzEwYUxWS0ZvZndtdis3WTNDTXZmUjcyUzRaV1FyN2hTejEw?=
 =?utf-8?B?SVNCZzZTbmcrZ2h0UjhHcXNFbkNrVkpaS1EySzJ0eEI1QjVwTXdoVkxWZnQ5?=
 =?utf-8?B?dHZPYVlaR05RcEJJbWQ1NUt0Wnd0dDMyOVgyR1hZMVV5NTJWVDNkeHVOK2I2?=
 =?utf-8?B?Vy9UUmNLQXdsUDJ3bU5zMTJHN3lnYWthcXU0V2o1aGhWN0NPK3BSU0l4MEZU?=
 =?utf-8?B?ZktJendvK1BUcmUrZFJwWFFMT0FGWVpBbHFnL3BjR2M1V3ZFc0tNM244RDIy?=
 =?utf-8?B?ZXJmc0tFdlgrU1VSQUdnR2FyOUZUTVdyMDZQWFlNb0VGZGRpRHVnMjk1Q3BB?=
 =?utf-8?B?WVh6eVFESU0xK3RCY1V4eEtVVGxRU2FjVlp5UmxGSUs5VHNqaHVFVUFaVUtM?=
 =?utf-8?B?bmpvZklac1hmdFZ5WGM0ZzUrVCtRREVWQ0VtWnFHWXFKd0Q2RXd3Rm94Y3Nn?=
 =?utf-8?B?VzYwZ0F1cjJ2MHRjZEpEL0xFdGk1MXRNTmFGS3ArdmtlWHJhN2tYOU5VbGZl?=
 =?utf-8?B?TnFma2dQU1Y5V2UzRGlsS0VVR0NTYnRLbDFldldpM1FKVzB1VERKZzFJdEFi?=
 =?utf-8?B?UEFsS3NSR3FaRjBZbWtqOVBJN1lWeUVLWUNKREtPUHpjRTlhQXlrcXVDTXdy?=
 =?utf-8?Q?Wdt/0OK4sM2Kq3mLu8FpugbsQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce89713d-c14c-4e9b-3ba3-08dbdfcbb180
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:56:55.3932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXVWxY2kaTbI2bPoTs29MUVfXQnnPmRg71lAdqL8WIyRt1WVPUz6fBFvHE7M8Sl02qNdZr+UCa0w0Xbr2zb88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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
Cc: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-07 14:44, Errabolu, Ramesh wrote:
> [AMD Official Use Only - General]
>
> My queries inline.
>
> Regards,
> Ramesh
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Tuesday, November 7, 2023 10:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: [PATCH 4/6] drm/amdkfd: Export DMABufs from KFD using GEM handles
>
> Create GEM handles for exporting DMABufs using GEM-Prime APIs. The GEM handles are created in a drm_client_dev context to avoid exposing them in user mode contexts through a DMABuf import.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 11 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 +++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 33 +++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
>   4 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 6ab17330a6ed..b0a67f16540a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -142,6 +142,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)  {
>          int i;
>          int last_valid_bit;
> +       int ret;
>
>          amdgpu_amdkfd_gpuvm_init_mem_limits();
>
> @@ -160,6 +161,12 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>                          .enable_mes = adev->enable_mes,
>                  };
>
> +               ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", NULL);
> +               if (ret) {
> +                       dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
> +                       return;
> +               }
> +
>                  /* this is going to have a few of the MSBs set that we need to
>                   * clear
>                   */
> @@ -198,6 +205,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>
>                  adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>                                                          &gpu_resources);
> +               if (adev->kfd.init_complete)
> +                       drm_client_register(&adev->kfd.client);
> +               else
> +                       drm_client_release(&adev->kfd.client);
>
>                  amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 68d534a89942..4caf8cece028 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -32,6 +32,7 @@
>   #include <linux/mmu_notifier.h>
>   #include <linux/memremap.h>
>   #include <kgd_kfd_interface.h>
> +#include <drm/drm_client.h>
>   #include <drm/ttm/ttm_execbuf_util.h>
>   #include "amdgpu_sync.h"
>   #include "amdgpu_vm.h"
> @@ -84,6 +85,7 @@ struct kgd_mem {
>
>          struct amdgpu_sync sync;
>
> +       uint32_t gem_handle;
>          bool aql_queue;
>          bool is_imported;
>   };
> @@ -106,6 +108,9 @@ struct amdgpu_kfd_dev {
>
>          /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>          struct dev_pagemap pgmap;
> +
> +       /* Client for KFD BO GEM handle allocations */
> +       struct drm_client_dev client;
>   };
>
>   enum kgd_engine_type {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0c1cb6048259..4bb8b5fd7598 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -25,6 +25,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/task.h>
> +#include <linux/fdtable.h>
>   #include <drm/ttm/ttm_tt.h>
>
>   #include "amdgpu_object.h"
> @@ -804,13 +805,22 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,  static int kfd_mem_export_dmabuf(struct kgd_mem *mem)  {
>          if (!mem->dmabuf) {
> -               struct dma_buf *ret = amdgpu_gem_prime_export(
> -                       &mem->bo->tbo.base,
> +               struct amdgpu_device *bo_adev;
> +               struct dma_buf *dmabuf;
> +               int r, fd;
> +
> +               bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> +               r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, bo_adev->kfd.client.file,
> +                                              mem->gem_handle,
>                          mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
> -                               DRM_RDWR : 0);
> -               if (IS_ERR(ret))
> -                       return PTR_ERR(ret);
> -               mem->dmabuf = ret;
> +                                              DRM_RDWR : 0, &fd);
> +               if (r)
> +                       return r;
> +               dmabuf = dma_buf_get(fd);
> +               close_fd(fd);
> +               if (WARN_ON_ONCE(IS_ERR(dmabuf)))
> +                       return PTR_ERR(dmabuf);
> +               mem->dmabuf = dmabuf;
>          }
>
>          return 0;
> @@ -1826,6 +1836,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                  pr_debug("Failed to allow vma node access. ret %d\n", ret);
>                  goto err_node_allow;
>          }
> +       ret = drm_gem_handle_create(adev->kfd.client.file, gobj, &(*mem)->gem_handle);
> +       if (ret)
> +               goto err_gem_handle_create;
>          bo = gem_to_amdgpu_bo(gobj);
>          if (bo_type == ttm_bo_type_sg) {
>                  bo->tbo.sg = sg;
> @@ -1877,6 +1890,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   err_pin_bo:
>   err_validate_bo:
>          remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> +       drm_gem_handle_delete(adev->kfd.client.file, (*mem)->gem_handle);
> +err_gem_handle_create:
>          drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
>          /* Don't unreserve system mem limit twice */ @@ -1991,8 +2006,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>
>          /* Free the BO*/
>          drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> -       if (mem->dmabuf)
> +       if (!mem->is_imported)
> +               drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
> +       if (mem->dmabuf) {
>                  dma_buf_put(mem->dmabuf);
> +               mem->dmabuf = NULL;
> +       }
>          mutex_destroy(&mem->lock);
>
> Ramesh: What happens if user invokes "free" using KFD IOCTL while the BO is imported and mapped on the device using DRM IOCTLs. Could it lead to inconsistent state?. For example the call drm_gem_handle_delete() will remove Dmabuf, close the GEM object. If user invokes free() using KFD Apis then the underlying object could be removed. It is not clear if this impacts devices that have just imported.

Reference counting should prevent any such problems. Both the dmabuf 
itself or the import in a DRM device hold a reference to the underlying 
GEM object. Using the KFD free ioctl only drops the KFD reference to the 
GEM object and cleans up the handle and kgd_mem object in KFD.

When the BO gets imported in a DRM render node, that creates a new GEM 
handle in that context.

Regards,
   Felix


>
>          /* If this releases the last reference, it will end up calling diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 06988cf1db51..4417a9863cd0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1855,8 +1855,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>          return num_of_bos;
>   }
>
> -static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
> -                                     u32 *shared_fd)
> +static int criu_get_prime_handle(struct kgd_mem *mem,
> +                                int flags, u32 *shared_fd)
>   {
>          struct dma_buf *dmabuf;
>          int ret;
> --
> 2.34.1
>
