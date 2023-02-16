Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A819C636CC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64BC10E0E6;
	Thu, 16 Feb 2023 07:31:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA4510E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvH47NizA7nafG62lw8UzK0oIfp2FqLOxnDom2w0FA51rfsPaNvoDUwJ42yODynfrxAbE5zfbkT1QOB/awo+QiXUBfccU7EyPyboyFkFuIuugfMOSnA/uvhUGRiN5MM9iK9e4hmzw2xCtBApM+yAQHP1BnBojnHDPFacNmACPME7wVO5LwYXB3dKZcYjJfMSVLDRCDKjzlKaGrqwpsZuOF+gfF3nswDKxkm7Wofg9N847TVPAlHZICNAtPrSXtmfPahdWceIIzvhLc/vtXp/E8R80syztoLuxDCxXseESMFVizdL1M5lkp+rNK9DzIDhslKqmXT+g25n9WNlEhJ7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaClgfzLWW00NfB4v4p8TV/weLsGzXJQvkzFhj8SWqI=;
 b=GE3pTjT+Uw4xbbW27QXXaZ+F3vgtzi0V9kafgeafF2NlIXEuSSWV7KpAvBs4jHEpl75RcBUDs94jLyFfazgIS/IUCEPmGQ0jUZdfRrnMttoJ3vuKYibkmieh1qkcjIZTj0pIdqyQZiyRfYZqCbTG33ETqVbffQADsbFP2ZOuGiyl/Aidtcc2ujyCbPkuricbpf5cOHxuAHBmmJ6VqSHzK1eQ92kWKkFaAvihpyu2ItNCaJLOSiDPkK+xgr4fY2cnk5H1GssKoGcYzYocS9ja5OGcnJ1v6U+MrwDs2+WbblkfHT9yWUBpQSMmAE47Uvfcou3qElTbesn7hKbKX/Bytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaClgfzLWW00NfB4v4p8TV/weLsGzXJQvkzFhj8SWqI=;
 b=OxG6BEXc8uqHxURLa2SFTpgk/1LDz3OUdVyzGUZQjrQMvbJ5owkBAPJy5UG41spt0lsVStuM0EOeF2LRkadr5gMnRBErzsm8gmQQWDSLyyHk5vxSiHC1tLY/CJwbfN5PtM5Myfh3zHPLMysDSU9EtHDDYdQ6rJkr2F+Tq7DdY34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.28; Thu, 16 Feb
 2023 07:31:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 07:31:33 +0000
Message-ID: <6f116e7d-55fa-a17d-f9ce-93bb18a8a3b6@amd.com>
Date: Thu, 16 Feb 2023 08:31:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230215184356.2205-1-shashank.sharma@amd.com>
 <20230215184356.2205-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230215184356.2205-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 201c8ad9-0540-440a-7c93-08db0fefd3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WUfZKEKwA1dMU36M1dgHEc/bxSSrcx6QNIEWEyeXr8Cbwliquzji06469ZzupYBPZzL5QkB8arpJqrVH6F5YPmoUX7QRSgpuHHkQ3Xcx1z8hkQQvHFpM32uMpw1r0pNBCavJR3Zvlq6x022nWtlzVq+igq+y0Tlvy+sD5EcSeFJcl3WVmj5BHkrIR2MKV231Zsiaz9/cDMLyvSnqTQOQHyTq37F9kKQTw466/sxgUqgEAGmogp0ea9HPLGQgQ+SocFoPTk0ndoA/vspDdTuW8fhOECShE/ApkG+Qead2iknI5wI6bWGa/KWxJS308Uo/oQN2jxTix0ohFp+uJSlzgeodbr1Oxrm4Oc+4IIIVXUw+OlCXpFQ3GKnnJBmlYz50LNdt+0iDPmTT2B5OJg/FiO7PDfO3vwtRr1O+NVl3EQHj37hQ20SoMfDEC6oG+xSJfuoIC8fKwfXlofsVI4nPhUyGDSS1ZpIN5X4Rd5tF8dRyjlW6Z9J5N/qItatHR8S2cc0fUQoSgqI5cfeun4OpPfH5nw/Jg1q5jlXqEyBePhQAcUDqYouXz+B8GLREt0lAZL+Fd+7c1UVggUf7BauneNKJHA2n01QO8+gFBTaf9XlpkKFaO3POGIJTY/u0UYuBUw5bvM2tW0mXrSnfmPsqgIexCd59rpKY774JJKr6/2ZAphCwARs+5ux3G1JpVoDKcaNQbLckmUa4uFXtPfiqw16E6cy0velAzOX/pYT2TM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(2616005)(5660300002)(36756003)(6506007)(26005)(186003)(6512007)(6666004)(41300700001)(316002)(54906003)(38100700002)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(31696002)(83380400001)(86362001)(6486002)(31686004)(66899018)(2906002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JvRVBaa1d2ZmVvcjdRcS9VaFhtbWFNSlFsTU9IYmxlTzA1MjVkUEhyaTM5?=
 =?utf-8?B?WFJCS1pDMU54NE1CYU5MQVkrRE92T1liZ3pxN2lUT3JYNlNyZUkzVEJyMm42?=
 =?utf-8?B?RFNpakUvSmRveHIzNFlNZEg0aFRqMG9tV2tlajNtekZpZDNuZ0FZOTFLcmU5?=
 =?utf-8?B?L1N2WmJHTWRlT2ZndEFxSnkrZUNPMHc4UjBUSlFPZHdqWnh6ajVJVnY2M0tT?=
 =?utf-8?B?V2FoWFpkL05WUDBaWWlHNmQ5S2dFZkFqeXl0bExRYmlaRjc5OXREQWRjZnVw?=
 =?utf-8?B?WndOeXNnL3VuUWczQzhncUpwdVE5Z1ZoZEwzR0V2azJ1Ulg2OS9PZ0VJWHM4?=
 =?utf-8?B?SW9qT1N4dEY0QlNSOFM1c0xZcXAzNUJuMWZ0emtldEYwalFlc0hlMElKZk1G?=
 =?utf-8?B?Nm5INjJpOGwvRmkrSUJXbWgwYzlVU1JvdlBYR3A1a1VVN0x2R0RzVWk0d3dT?=
 =?utf-8?B?VSs1VmVDMGJ2NFVQaTFBeTZ3d3RIYmRZcERtbVhCSEpvd1g4L2g3M1pVamxs?=
 =?utf-8?B?Q3QxOER4NDRTNnpHUEs3bG5ZdzN0Qlk0U21VdzNkR0VsS2hZdm90UXg5dE9C?=
 =?utf-8?B?QzRtWGpVZUxBWEZPdGhwbzFQWGlYSzVEUHRzVUV2c0pITVNWOWFheFFiUm1U?=
 =?utf-8?B?c3VMQlVLK0wyUXFHTzBPL21LcVlxTGJZSjNnRzBZK25yUnMvTjlTS3M0ZWpZ?=
 =?utf-8?B?bTJsayt6NnVSVnlCRGZROG00TUJMQ0ZOaEZPMnZMMzNPZUdPelhIenlkOW9w?=
 =?utf-8?B?SGR5UkowSGhsNnU1QjFSckNIU2w0bXlsdHI0eFo3clczQXZrbHRjaHc0ZEx3?=
 =?utf-8?B?OTI2WWU3aWkxdWI1c3BPb1Jib2Y0MHVyY3BnZlByNUx2SDVaeTg3Mk1HRDVw?=
 =?utf-8?B?V2xaQWdEeDZVeG1WUFNjUE5PT0NGZ28vSE0zTEhNZlFHMXJ5MVoxRnNOV2xl?=
 =?utf-8?B?WlFuS1hrbVFDMW5ZazU0Ly9WL3dwaFpRK2pydEprRmhQQzJkbm1oWGdQaTdw?=
 =?utf-8?B?dWoyOGlWdlRKTWpmdXZzM0tEY1hLdEQxZXM5VWJSaDJUWG1nZkovd0c3WTZ0?=
 =?utf-8?B?bnUyNXdHNERKK2xad3NqQmlyZTN1dFJMdjBKZ2FTc2NKdTk4NWJzOURtNTMx?=
 =?utf-8?B?dUpkWWcybEFScTBoZTZVQUlueVhtVkk5M0ROekwxV0p3dGY2VFVCYThLZmNJ?=
 =?utf-8?B?MkY1c0h1a3orakN0WkE4eE8zRVVSN0l2Nkx4TkNTcDViYVlwOG9kTlVFTk5u?=
 =?utf-8?B?VHlHQWo4UHlVNFhEZU5rSkNtUUg1MFY2V0R2Z2N1RUxiWkR3aXlEUmFKeGZJ?=
 =?utf-8?B?bnNydTdZYlBpQ1o2WHJTN3VWYmEwekNlazVXbHdRN1NJQ0M1NnVBODRzTm1l?=
 =?utf-8?B?Rm5nT2VKQmxmVkorTVF5TURWZEJYUFR6dTM5RkZhK0JTaDNWOTloU3dXWGpk?=
 =?utf-8?B?RUwyb3o5NzB0T3lTSlArSUwwczg4S21hSXpjdUZLeGkwb2x5elFrekhyOHJo?=
 =?utf-8?B?UnNsVGJVcVNlT0ZxMkdWQW9zZngwMWhmalNpTDdRZmFUVDNKZHZPQ3NBaHlY?=
 =?utf-8?B?ejBSS2RDSVhva1R0UkVZYS9nWmttdnBrdzVLR2c2ZUowd1FnVlZOMGxPa29R?=
 =?utf-8?B?elN0ZDc1aGZ4QVZtbmg3azlDbVkxZXAwbnNUL1lzMmFqbFlua3JRaHdBeVhJ?=
 =?utf-8?B?NnNyMk1rSTV0UkpoemZ6VzRnNnVtb3owU2VtVW02WDJIa3RWK0licVNRR3l4?=
 =?utf-8?B?THRuQVFmaU1rZ1QwREhNM21TVjAzWDZwZERMYVY3emR0cFlwKzk0NHlpbGhz?=
 =?utf-8?B?bHZkOU1IcnlQZFV1VjB0eldpbWxzcmMvVGVCS2loR2kzcitvVFJiTHBCdEIx?=
 =?utf-8?B?SUhUcHVmUU94UWhkOTJ4K0dXR2JpMTFqaG9xeU5iaUExYW9VcFJlTG80RDFG?=
 =?utf-8?B?ZVl5N1JpQWJmVktscCttSmxIYnFVa0JRODY1TGp3WDBrcmk1b2RuejRGR0xz?=
 =?utf-8?B?eGNWYXFDMHNOVDdMYUo0TjBIRlB4L20zZXJRZlhYK3FqTlRIZHNURXQwaWwx?=
 =?utf-8?B?RW1ycFZZNXA3YlNzRlNka3A2N0gybVByNG9lREgrTUV4WVdrbjNIMHRFWmtu?=
 =?utf-8?Q?OFM3c/N5v8MHLqYHqj8ym0VNQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201c8ad9-0540-440a-7c93-08db0fefd3e3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:31:33.2214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOV6+WQRA5yoYrFmJPD/pVnRaeuY8Q3PuCKy5XRttPkjoeCLur+Y/lFdY9akkcax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.02.23 um 19:43 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
> context. As MQD format can vary between different graphics IPs, we need gfx
> GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD hander functions for the usermode queues.
> - Adds new functions to create and destroy MQD for GFX-GEN-11-IP
>
> V1: Worked on review comments from Alex:
>      - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>      - Reuse the existing adev->mqd[ip] for MQD creation
>      - Formatting and arrangement of code
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 21 +++++
>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 84 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>   4 files changed, 113 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 764801cc8203..0c825bdf12d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>   
>   # add usermode queue
>   amdgpu-y += amdgpu_userqueue.o
> +amdgpu-y += amdgpu_userqueue_gfx_v11.o
>   
>   ifneq ($(CONFIG_HSA_AMD),)
>   AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index ecf31d86f3de..963e38f654a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -82,6 +82,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           goto free_queue;
>       }
>   
> +    r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create/map userqueue MQD\n");
> +        goto free_queue;
> +    }
> +
>       args->out.queue_id = queue->queue_id;
>       args->out.flags = 0;
>       mutex_unlock(&uq_mgr->userq_mutex);
> @@ -106,6 +112,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       }
>   
>       mutex_lock(&uq_mgr->userq_mutex);
> +    uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>       mutex_unlock(&uq_mgr->userq_mutex);
>       kfree(queue);
> @@ -136,6 +143,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>       return r;
>   }
>   
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +    int maj;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
> +
> +    maj = IP_VERSION_MAJ(version);
> +    if (maj == 11)
> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> +}
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> @@ -143,6 +163,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>       idr_init_base(&userq_mgr->userq_idr, 1);
>       userq_mgr->adev = adev;
>   
> +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>       return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> new file mode 100644
> index 000000000000..12e1a785b65a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "amdgpu.h"
> +#include "amdgpu_userqueue.h"
> +
> +static int
> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
> +    int size = gfx_v11_mqd->mqd_size;
> +    int r;
> +
> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_GTT,
> +                                &mqd->obj,
> +                                &mqd->gpu_addr,
> +                                &mqd->cpu_ptr);

Don't use amdgpu_bo_create_kernel() for any memory allocation in your 
patches. This allocation is on behalves of userspace and can't use this 
function.

What we need is an eviction fence similar to what the KFD has implemented.

Regards,
Christian.

> +    if (r) {
> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    memset(mqd->cpu_ptr, 0, size);
> +    r = amdgpu_bo_reserve(mqd->obj, false);
> +    if (unlikely(r != 0)) {
> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +        goto free_mqd;
> +    }
> +
> +    queue->userq_prop.use_doorbell = true;
> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
> +    amdgpu_bo_unreserve(mqd->obj);
> +    if (r) {
> +        DRM_ERROR("Failed to init MQD for queue\n");
> +        goto free_mqd;
> +    }
> +
> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
> +    return 0;
> +
> +free_mqd:
> +    amdgpu_bo_free_kernel(&mqd->obj,
> +			   &mqd->gpu_addr,
> +			   &mqd->cpu_ptr);
> +   return r;
> +}
> +
> +static void
> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
> +
> +    amdgpu_bo_free_kernel(&mqd->obj,
> +			   &mqd->gpu_addr,
> +			   &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 7625a862b1fc..2911c88d0fed 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -27,6 +27,12 @@
>   #include "amdgpu.h"
>   #define AMDGPU_MAX_USERQ 512
>   
> +struct amdgpu_userq_ctx_space {
> +	struct amdgpu_bo *obj;
> +	uint64_t gpu_addr;
> +	void *cpu_ptr;
> +};
> +
>   struct amdgpu_usermode_queue {
>   	int queue_id;
>   	int queue_type;
> @@ -35,6 +41,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_vm *vm;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_mqd_prop userq_prop;
> +	struct amdgpu_userq_ctx_space mqd;
>   };
>   
>   struct amdgpu_userq_funcs {

