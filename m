Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BDDEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B5710E522;
	Fri,  7 Jul 2023 07:46:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC4910E522
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksnacznf4rQ/LnXEba+4KnfUGq/jqylTh3/0YOa+RShKNl3uI6yCSXXueH3gDaxlnJYsBZTxhX1OBYD77H5j4KeqEnLU+jrefCp6TyyZ153xH07TPOUTlKNXIagcFTkgzdL5/kt6nXDtHsdK1sNrk47r6i6WOEMR9owiR/d25UG6qTUY6hjK+8TFdygarmxg8MaQAyzCSWCbOBV5trYmDKU24lB65yinlPL8bZpZ26wdz0S5cdSMIKUO1HzngJTVqTEobs1aa6jcudHLeubvlqwjodth5gVsS/M9WT+O6Zxdu9+wpSdCwgrLaiqvnHmrW8qMQNIpW5loG3RpquZu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5AtItY5PasHPZRlfLidv0C0Eb/FyTy2znBAoPOQGdg=;
 b=W8MRQJtHPjk1f8vB6syj9Ttdk+SFTJq2yWugHOAAjOXAeyB70rmsRjF5oRVfzhIRPPeR1Owyw0QYdCLXDGWjKvk/Cl2el8SnH9IxZk9kRbPqrZEOQJMz6HXms75aJW4CTcK1zZ5F1il07AIzCFeZICyyYh4f1FF8RYrSo6EwtUX0k/+wPO06t6kPrMGXglWshkx1NY+PDSFuWgRuUMCU9WyYyLbe27rpyIYLxdeccHiHbRLVy1QHKHzZPKEsL3pyF2TZUBShAOZsmHXWkoHQKXRfcqHjh87/DAx4FF3Sr5gzATCCaajZLtKUX+slsxxfq/so0+ZC7ZdA7v4c/s/+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5AtItY5PasHPZRlfLidv0C0Eb/FyTy2znBAoPOQGdg=;
 b=kAGORbNHlAzrhiAMkrbEgYVVeRIVuNZAmjcdCQ/17IOQi03NQVJhADiEcRVoQyxDtp/pQxGKfoRDdt8AfjEzkQi4jX5XjbUZUxGwvui5HM+ERKvSnoa4H8pjMksZTBNQmh/e0CYGxEZdQrFQ26sZlpW7yoXeIdfWeujSHGr3FbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:46:07 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:46:07 +0000
Message-ID: <21d63938-fb00-35fc-6356-1176c04ccd89@amd.com>
Date: Fri, 7 Jul 2023 09:46:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <dfd92e84-c51a-82cb-5449-b3bb9c1dd3db@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <dfd92e84-c51a-82cb-5449-b3bb9c1dd3db@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fc5df6-dc8d-48db-4cc0-08db7ebe3961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXZmAktItj4VUVbF2DyWiK96aq2tIO7yy5yXRgZ7czYlXbuIWNFKFls2JEVi8ztfn8A7JwZh06jShs+8xg9z6ivfmfM5bA7G+gJh9Lk2mWBOC9TyQKO8gb4NYh+h/6AHsE+IpLGT1uHKo4oEcVTjRuujyfCMlwXqDIo8531q1SQFjgplCea5lGfywkVwp1CtPr3aALzt4c12JdjqjBuR0Sb/GUGm8kglkQkqt+cP/SYm6rmzQErZFlte1AZB84hMw0J7NdLjuFTnM91EGbrA9ZQ6frPTYiJzj+7E/2M6UJaxW55eNe7Z+vnTuitd9ilf/iWIcFyH+vNiJDu/I4BJZIRRulBJ0XxfYe6FXggGFw0Dx84ZOhTtmcT3ksUONvRuBdUm0RS2KBQKj05QrV5TD0NtTwFjLnuplxDwsDfpMGX45ptXSPngxg86UacH7R4FKcyUXCPT6H6mwrTMCtZ9yt/2ADBJsV1z+iA21sxUH0m7a1cB6d56EvF6QBv7P0LByAVdBWD08NmGLj4WVG7cnJ2P8MI9d4e3LU2526HqFN6TRhROBLcrrxRNE1d7NAtWMW97QVPCpHPcJnJNq/+nD8iXPUxstHxdvD14bo4ChRFePNbpTil2vK++BM+tC0gi2UOq1iMA5Y91zEyrBR7moQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(2616005)(6666004)(478600001)(6486002)(26005)(66946007)(186003)(6512007)(53546011)(2906002)(66556008)(66476007)(41300700001)(316002)(4326008)(44832011)(8936002)(8676002)(83380400001)(38100700002)(5660300002)(36756003)(31696002)(66574015)(86362001)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTVBTFB2ZngwR2podXA2Rkxudm1WaDBXN09Zejg0dTMvUE9lQVJNaGRzcjBU?=
 =?utf-8?B?SUx6TnkweHFZblFNMnFpT2wzUEx6UWNmNWdrbWtvcm1PMG0vbmo0d1ZEemdT?=
 =?utf-8?B?R28vNXZNelZ6VXNZeFdUREtwMGE3OVhETzZYQStmdktxUXRESm4vc1p5dHYv?=
 =?utf-8?B?WUxYbFp3TjNKd0RDOVZOaWdocGlGQjhDMzZWRFBRSlQ5a3o5M0FBR0hLZ3VE?=
 =?utf-8?B?bUN3Y1NTMlVEMjdFMXd2dTFIYWpkb2lQMC9Dei9wQUpiUHVVM2UreEora0lv?=
 =?utf-8?B?Y21Tak9NMDBZRjRQNit6UXNGbkpMWXMvUnRFUndzUy8yeW8xUTE1WExWY3Uw?=
 =?utf-8?B?enp2OUR0RW1nODZGNzhKUGhSRVE2Zmk2eWdsbzc0d05Eb3RPbW4yb28rVmJ4?=
 =?utf-8?B?b1RCdUxIbUViOWRHSFNoNVZIbHJCOVRleHB2L2NMK0NvYVJvZCsvMEo0amdP?=
 =?utf-8?B?WUJLdnkyeHl2VTBXMEh0QnBLTk1LNFdMeksvZnVPQ1VKSVhtTUhFZlRoeDR0?=
 =?utf-8?B?QUVnM0tFZmxod1h6N2tOMDh4amMxK2JiM2Y2bmM5czRXTktDVEJXa3l5Z2Nw?=
 =?utf-8?B?QWVhMFhydEFhSUdLUXJaZForRTM2b0dIcjd4UDFkM0VwUXMxd1R4Z0hhb3Mz?=
 =?utf-8?B?cWxJczU3ODdBYWZLRDUzaWtFd1AvNVlBS0lvNGc3Um85aGwvTTU2bnRqZkxW?=
 =?utf-8?B?Y2c4YUlnVjgrR09RelEvS3Q5eEthbzQyZjJ3V2JHdHU5V0VHVjI1VmtZczNH?=
 =?utf-8?B?czZOQjVQUWUvL1hRQlBTVXFEWEZ3bk5jaHBkZzJXRVJJa0d6dnR2Wkp1YXFt?=
 =?utf-8?B?R3JVOGhwZ2ZUaGlVcDBlY1ZRdzBJQ3Z0ZzlBN0ZmNU8wWlRVazhFYXVrMmU0?=
 =?utf-8?B?RytHU3ROOE5OZUhQczFiZlZybjgrRGdIMU4ybXpqQVkzVDhnREFKWDRRTXNN?=
 =?utf-8?B?WUFYOU1lcVhYUUFNOUxiR3pyK3Q4dmdFN2NHeFdzWVRLdEJVTStEVE12TGdq?=
 =?utf-8?B?Wng1ZDVjRWd4cWI2V3V3THNHczJpU2tZUExvcll6ZHhUaUVqRysxNjZTZTVl?=
 =?utf-8?B?MkNFclU0b01JdFI2dHpwV1VaTjJQVDJ3SDVnY053MUZCUnNrMEZFekZHVm5P?=
 =?utf-8?B?WlZHM3dERTdRQnF6ZVRGSnJhUzhTZGgxVS9pSjJJdXg3ZmkwSyt1cEhwcWJT?=
 =?utf-8?B?ZTBzTzBZS291L050bG1yOTlqSkRWNmpjQyt3a3dBWWVEWjB0Rlh4Y2tsdWFV?=
 =?utf-8?B?S1Y4TVhobkZpelBQQ2JkMHFpejdjRGpYV3h4Z0JVN055NzRMd3dsTGdJa0FC?=
 =?utf-8?B?QzcvYitBY1NaTGgxaVVLNDRxK3M4MnkzbkNYeHcvNEs3VHBlZEdBdWNRZWxH?=
 =?utf-8?B?VEZCc2pvaEcxbmJiSHJyY3FaeENycDdCd0R1SVFsSHJSNWlLRmY1RDJpaEpi?=
 =?utf-8?B?bGJZblpOU1ZJb01tYmhZSEIrTXc5YzNOaVEwUzlibVNWYXhNNnZyVnBqRTJT?=
 =?utf-8?B?eFhHQStHNmRZZ2xrbkRpV1QvTWx0aU5EOWNZTUhodW8vZjg3K3hTM1k2N3Q4?=
 =?utf-8?B?N3U4ZW1yY3FqR0w3VGY0M054R1QwVXdtd1orU1lERDRiV2tnYkhOVlUrTUtv?=
 =?utf-8?B?L3JUbXdydU1oNnNhSWViU1d6QXpJVW9aOGlpT1JRRUF4eTNOSmdRd1VNbkdK?=
 =?utf-8?B?ZFRpTExxT1V0RnZyV2V6RHJIYWJGRHdQRzVDT3JiY0tZdnpncGpEVlh4c2Zw?=
 =?utf-8?B?ditNUndHUWdxWk1lbitjT2l0TDh3TW5ERGxIbG9pcXgwUU1sOE0rK2hjM2JJ?=
 =?utf-8?B?MnhJUHFUNkJ3N0Q2WWpsNDh5VURvd3RRZFFTM1ZrcVVLSUpSYVJiRCtxM2p6?=
 =?utf-8?B?NHQ2TXhGeXh1YmNzYldHeHRuR3RhMHFnSElCVXhReFZyTkUwOVI0Y1lvTFls?=
 =?utf-8?B?Zjg5dDlaUXhuaTVOMEEwZ2lCZXNEdjczSEJIM3hFZ2VyNkNQTnlTTy9DZ0Zz?=
 =?utf-8?B?a3gwRmVibkQrV0JaU04wTlY5MlJvUFhZWVJsbEJNaDhhR3dZejdOSm05Vm93?=
 =?utf-8?B?aDRzc29SdWFjUDFERVZ4SjRYdFhZNThxT3JoelkxQ1NQZnhzb2pxUEtqeExI?=
 =?utf-8?Q?JPIQU7V27mgQ4jovD1cwYhZZr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fc5df6-dc8d-48db-4cc0-08db7ebe3961
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:46:07.7633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rahx9RwKj42A9f0q/u1pBo64MN7LW3uuMEBiOHMcXQfa8RFkTzXxmiDMfJWPoNaGRDC4K2zF0fF9vscS7/ZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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


On 07/07/2023 09:24, Christian König wrote:
>
>
> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    GFX-GEN-11 IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>> V5:
>>     - No need to reserve the bo for MQD (Christian).
>>     - Some more changes to support IP specific MQD creation.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>   3 files changed, 96 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index e37b5da5a0d0..bb774144c372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    /* We support usermode queue only for GFX V11 as of now */
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11)
>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>>       mutex_init(&userq_mgr->userq_mutex);
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index c4940b6ea1c4..e76e1b86b434 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -30,6 +30,7 @@
>>   #include "amdgpu_psp.h"
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>> +#include "amdgpu_userqueue.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .rev = 0,
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>> +
>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>> +                      struct drm_amdgpu_userq_in *args_in,
>> +                      struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>> +    struct amdgpu_mqd_prop userq_props;
>> +    int r;
>> +
>> +    /* Incoming MQD parameters from userspace to be saved here */
>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>> +
>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>> init function */
>> +    memset(&userq_props, 0, sizeof(userq_props));
>> +
>> +    if (args_in->mqd_size != sizeof(struct 
>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>> +        DRM_ERROR("MQD size mismatch\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>> args_in->mqd_size)) {
>> +        DRM_ERROR("Failed to get user MQD\n");
>> +        return -EFAULT;
>> +    }
>
> Sorry, I've just seen that now. Please don't have a copy_from_user() 
> in the backend!
>
> This is pure front end stuff which we shouldn't do in hw generation 
> specific code.
>
This is a bit difficult to achieve, as you know:

- the whole reason we moved to ptr/size based approach from 
fix-mqd-structure approach is so that we can support multiple MQD 
structures using the same UAPI.

- which means that in file amdgpu_userqueue.c layer (say front-end) I do 
not know what is the right size of MQD, its independent of IP.

- the correct size of MQD can only be known in IP specific functions 
which are in gfx_v11.c (back end).

- I may be able to achieve it by adding a new fptr get_mqd_size() which 
can return the right MQD size for me from backend IP function, and then 
I can move this copy from user to front-end. Does it sound like a good 
idea to you ?

- Shashank

> Regards,
> Christian.
>
>> +
>> +    /* Create BO for actual Userqueue MQD now */
>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>> PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &queue->mqd.obj,
>> +                    &queue->mqd.gpu_addr,
>> +                    &queue->mqd.cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +        return -ENOMEM;
>> +    }
>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>> +
>> +    /* Initialize the MQD BO with user given values */
>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>> +    userq_props.queue_size = mqd_user.queue_size;
>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>> +    userq_props.use_doorbell = true;
>> +
>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, 
>> &userq_props);
>> +    if (r) {
>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>> &queue->mqd.cpu_ptr);
>> +    return r;
>> +}
>> +
>> +static void
>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>> +
>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 55ed6512a565..240f92796f00 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -29,6 +29,12 @@
>>     struct amdgpu_mqd_prop;
>>   +struct amdgpu_userq_obj {
>> +    void         *cpu_ptr;
>> +    uint64_t     gpu_addr;
>> +    struct amdgpu_bo *obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>       int            queue_type;
>>       uint64_t        doorbell_handle;
>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_mqd_prop    *userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_vm    *vm;
>> +    struct amdgpu_userq_obj mqd;
>>   };
>>     struct amdgpu_userq_funcs {
>
