Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B260FC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1F310F131;
	Fri, 31 Mar 2023 08:52:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC7B10F131
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HftUS7nwgiqQPNcO7+Dpvtark5Kn9iKoQIwpDEODKAA5+6d3A+c7wEm4ZFU8Lts36+ic4rglVtcxMd3sKE7w8DNTtLNNfsqQ8/wPVidi7m4gEESfg5L1u27YzPK1qJ2yQSQiscKggFNiGRL0spcOCPY73LjDn/OYBDOoKMy9Lh5vy2wOPKvo94cuu8gHR5JR1bTR/pJM5EOFoy31e4hCSogw2eN1OrOX1A5jwF19rauwoLcIQuG0/zBHHvl4c4dUobY6LLsu6YbuwcFmszMilXnhIxWRWp5sBjE88IDT6Zovz9g0UBiBsn512wS4D/fLg7dti4sOFgxvyrfJ5kFAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzgfGnrZSrwdalBxH/+HthOk8vf1eLYV4rE00jwK7eQ=;
 b=Rq0bplSnkeqSegS7aHPIczwiE3QJILF0t7AdYFbsYZYpXo34MMhoTb+NuRdVt9bL8rzhlVSwBiFtGez778YaOobfMursBQM9otbwRqKv59imYAyJypfmIB7VNHUTyzaUki2iGZbmPI6CupwHeT7ElpLg3aUiTHarNIh4+R5mFoLAkjzdv6pmuDf2fZjJq945lG4HffEHbGA3aAXoLZgVYYH73i1JtFBeXBK8e3r4K9X61BzA5vYW3Z6g9TEHsRDwPNxhud/zLhwHznN30+nbyo+SQGpsslU08pyTNVLKtrq2XgrSxZG4CVEXTOvrprTUv+qQB01ru+r72aNmnKX7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzgfGnrZSrwdalBxH/+HthOk8vf1eLYV4rE00jwK7eQ=;
 b=qPtiga3VISzhInjQ5069FgYKOW7jkamOdcRp0jb/+kYNYtN8AlOINX7Q6PvILbSBmExZ4wY7WBxNXqm+VGGrP9Cmi1LfOVafj/JZ/O1Khn7gdMVpEKvqqPwPDZHvW+j+e7BY+iS71i3bGCIkJnZEy812ncozpjGvnGFxsFzq2hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 08:52:36 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:52:36 +0000
Message-ID: <5fb61043-95d4-0cf7-0797-d44d10d01822@amd.com>
Date: Fri, 31 Mar 2023 10:52:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/9] drm/amdgpu: add usermode queue base code
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-3-shashank.sharma@amd.com>
 <CADnq5_OEWGcCxbcfLPvuA2rQdfw6QQDziOrOQ2SSF4y=-ocaRg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OEWGcCxbcfLPvuA2rQdfw6QQDziOrOQ2SSF4y=-ocaRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ef400a-d786-49a6-102b-08db31c5468b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRrwG/KQMsrelLf5Eu2RTQ7m57Pp5jNIdKh2cKMVTxnkJxXtGkF1XgjRogsZLIEEYR18OGW5mtZrLhTgoAVLskcTkT3CVKXnxMKAwMIIXjmVfEcDvsqvmNZZwnQZZZkE5lTWJA4lfoRqrpdEcEzORB16XntAMAaxR0fY48WqmB455gIhruxD8BhKNAlQc85HYDPY0x+cMR2z0M/bkgxW+gG3oIoNzdrXJC8SxVZ8TOuN9iykn8H6watglumhJIX6s8VIr+Drrr6Y27qMQ7RKvvBMvZo7noIeNWWegjoHbKsu8H1vevCPARH/oiU95Uys5l9zEoSNAQ7FPnLXdumDErYA9piLi9M4UgMoGW+7Jm5NJuc4OdOtssWDQ/uEFm2dyku5jZe2w/zr/gw2VzvQZ5PhHNBQn3H3h9PaBdYXTq3AKSjUayCv3Z1/3Z1qhZT22B5FQH86tUhmKWdXUujlEl8LrD2W/8yp/Owfm+4tvAMxGjSD9XR0B8IfCAKr9XlKqzm3K76qsm7x3OTBim2t+2u2fchdF5IjaTt3xKNIcpSwPCyiPJ8yAfSNLPfWzgXSSEPN8cobGxZ3bjg0x44yfoXKhXlfqfSHWQPjg6+5kzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(53546011)(186003)(6666004)(6506007)(83380400001)(26005)(41300700001)(2616005)(54906003)(66476007)(66556008)(478600001)(66946007)(316002)(6486002)(6916009)(8676002)(38100700002)(2906002)(36756003)(4326008)(86362001)(31696002)(5660300002)(8936002)(6512007)(44832011)(31686004)(66899021)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VzZEs1SGdYczcyRTNWYW13Qitoc3FQYXVWRTZxVmszVzBhMlNqalpJeVdB?=
 =?utf-8?B?MnRYWndXRDZjZHI1bCtMYVdtcnk2Snh3TWQ3MGRaLzc0Mk01M3BpemEyZUtk?=
 =?utf-8?B?bW1kTWI1UE1VZW5RbHVrT21iVnlacWhSclVwdUlRejZXMDNkeVgreEVQL1I3?=
 =?utf-8?B?QjJKZGtkVmdYQS9ueHVCbHZxd21wNmNWRjRhNzNmVWxDYm1qbmRUK3J6aS9x?=
 =?utf-8?B?NzVnSE9SNjVOdnpLVkdLV3VxdEgrMmZkQXpod1BuSWtyWml5MUdTdFRWTXdu?=
 =?utf-8?B?MGpQaW10aHBXWVhIM3RGT3RLT3Fwc2ZTbnFUZWh5Y0Y1UUVVNHBHdW1ORTI1?=
 =?utf-8?B?Nzl3b0pkZmxVYXZXL2hoaDlvbHJWMk9pMHRYRC92MHhDS3NvOG5ZUkpQamJQ?=
 =?utf-8?B?anR5anBVU3NvdkZQMVlVdmRBdlJYUVVETnJhM1czQXJKTlhsZWJYd0I2YTZt?=
 =?utf-8?B?VEk3UGtSMFFVRThvSFgrK1ZCRGxHNHg5N2h3b3RiSUNseUV3eXlmMFE0S0xI?=
 =?utf-8?B?Zkp6czRGSGcvVWhiWDN1UkpmTFU3SkZJemRrcU9kamNGSGZQV1pMRUg1R3NJ?=
 =?utf-8?B?WnBKTHRNaVFVQk5MRVBDRnJxUDdpNTcxRTVTL1h0WFhnR0tQMFVOMUx6RjhN?=
 =?utf-8?B?bXY1V2xyNGtqM0VmaW9LNnVUZ3VWQXJIb1RIRHVSTjd6blpUdEVnZ2xLMlNi?=
 =?utf-8?B?QW1UdkpRc1BFdzJMWCtvdG81YU9yY1BkdVo4dHhyLzQwMG9Day83UXh5WVQw?=
 =?utf-8?B?WUhqaVNoYnFReUg0OGU1M1pxNzB4dThlK2VLZWoyMXFlbWpweTFJbmZiaFIx?=
 =?utf-8?B?OWJkLzVLQTRqR0hOTldRWUdNRGhXS01Pcm1KbGVuMnBjRG1hV0I4aVRWVmZZ?=
 =?utf-8?B?Ynp4ZHM3Slo2NjRzNnV5STV3L09hNDJudk8wMVNoVytVOXdMYmJCU0VKZXpn?=
 =?utf-8?B?dldMQVNvV3lKUjJCUDZESEtISkY5UmtXakZxS1djblovcEsvVmN3SU1UNHl5?=
 =?utf-8?B?M21QTnYwbjdwcmpIQW5jeWJpQ0l2YWs4QzFiRGlBaEE1UHNJbmFyMkpKRU14?=
 =?utf-8?B?V3F5Tk9VVE1iR0hTV1N2UGlBS20vcjNJcnBheVVoNG5rTWkyK2ZGb2FhaTRN?=
 =?utf-8?B?RUVnQjJFeEZWR1RDTVEyNml2RWVRTnc3ZDZKUWFlOThWN1plalVuWXdUVUVl?=
 =?utf-8?B?WE9LS3MrRHpIRy9lbjFSQWlqYngvWHlRRWJVcmFiVWJLYmJ3WVRldzRnaElF?=
 =?utf-8?B?S1krQ2w4Ly9Sc2phNExrRG5NSUlZNk10cURCOWxBTk1NdEdHdXowYWwyVlhG?=
 =?utf-8?B?MzRTYTVqZHRzWlgrZHZmOU9QRTU4dXVOWG40VWE5ZGk4RFRyeFZOUnpuQ0JC?=
 =?utf-8?B?TUxnRHlIeFpqME5zcVYzNmZGOFFwM2NNblFmbGFyOWhMcjhqSDF3d1Zpazcx?=
 =?utf-8?B?UDVFMkFkTmNqcGVWd3ZUdmhZNmFJalo0dWRhV2tYZWZ4TzErTWYrV3BKYytu?=
 =?utf-8?B?a1hHYXgxeTFMU0xEQ1BVTk5LeE9FeGdRclMvZkltUlVjcFZGOGpQbHVhRi9u?=
 =?utf-8?B?VVc3Vlo2V1kxMDVtU3Zwa0xXMGlwWVA4ZlRLMFVWV0NSSlBqZlhqY2JROXpE?=
 =?utf-8?B?TFA1NmIrRTQxeTNJQmJ2MDRLZ3RoalpIM1pzLzFvTmliY2RGdUhaR0V1NFpr?=
 =?utf-8?B?dWNqVE9vZHZhckpDMHZhVnpnQ3R1N0VmN0lDcTFxU3daL1Myb2dLYmJtbEZR?=
 =?utf-8?B?NzdFUWR4YkhXZTVUakhieHlEZ2swemNsMXBZTmsvaEZkbXE2ZWh3M3hFMUpX?=
 =?utf-8?B?dXlES01ISFFRT1M3V2V6NHZyWTQxSmdFQmM5N3kwak42dkJzY0lPbklNdS85?=
 =?utf-8?B?T1IrNzlXa3gwdEd5Um9ZN1J4N2pyRHYrRUNQdklNemJCNG8xb3RYWEI3ME0v?=
 =?utf-8?B?SmFZeHM2MTY5SkcrK0RSWi9Ec2VUMndldldKTmk1S0VKVy9oVUlaL1pTSGVt?=
 =?utf-8?B?YzZobDRDVVJleXRKcG9pMENFTUU2LytJRll4Ni8zTk5FckQ2V2hIT010WG5m?=
 =?utf-8?B?UFhpSU5uUldyZkxwYjA5c2hXSERDc3N0cmRPc0hYR2l0MkpML01uaTdaRFFZ?=
 =?utf-8?Q?gUXWWoGs3514ueHflM8qI72eS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ef400a-d786-49a6-102b-08db31c5468b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:52:36.7629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AchBumxY4ppa1g1LYlYAn1/DNlk3BdRxWUDopaT0uwe+hf79t/neTecVzoOmBpGRF2w0OlyKbkbbnBuFMyBvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 23:15, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 12:05 PM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds skeleton code for amdgpu usermode queue. It contains:
>> - A new files with init functions of usermode queues.
>> - A queue context manager in driver private data.
>>
>> V1: Worked on design review comments from RFC patch series:
>> (https://patchwork.freedesktop.org/series/112214/)
>> - Alex: Keep a list of queues, instead of single queue per process.
>> - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> V2:
>>   - Reformatted code, split the big patch into two
>>
>> V3:
>> - Integration with doorbell manager
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 49 +++++++++++++++++++
>>   6 files changed, 106 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 204665f20319..2d90ba618e5d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -210,6 +210,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>
>> +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 6b74df446694..c5f9af0e74ee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -438,6 +438,14 @@ struct amdgpu_sa_manager {
>>          uint32_t                align;
>>   };
>>
>> +/* Gfx usermode queues */
>> +struct amdgpu_userq_mgr {
>> +       struct idr userq_idr;
>> +       struct mutex userq_mutex;
>> +       struct amdgpu_device *adev;
>> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> These function pointers can be per device rather than per userq_mgr.
> Just hang them off of adev and then each IP can fill them in during
> their init functions.

We kept these functions in adev in V1, and then moved them to uq_mgr due 
to one of the previous code review comment.

Which way should I go now ?

- Shashank

> Alex
>
>> +};
>> +
>>   /* sub-allocation buffer */
>>   struct amdgpu_sa_bo {
>>          struct list_head                olist;
>> @@ -470,7 +478,6 @@ struct amdgpu_flip_work {
>>          bool                            async;
>>   };
>>
>> -
>>   /*
>>    * file private structure
>>    */
>> @@ -482,6 +489,7 @@ struct amdgpu_fpriv {
>>          struct mutex            bo_list_lock;
>>          struct idr              bo_list_handles;
>>          struct amdgpu_ctx_mgr   ctx_mgr;
>> +       struct amdgpu_userq_mgr userq_mgr;
>>   };
>>
>>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b4f2d61ea0d5..2d6bcfd727c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -52,6 +52,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   /*
>>    * KMS wrapper.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 7aa7e52ca784..b16b8155a157 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -43,6 +43,7 @@
>>   #include "amdgpu_gem.h"
>>   #include "amdgpu_display.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>>   {
>> @@ -1187,6 +1188,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>
>>          amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>
>> +       r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>> +       if (r)
>> +               DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
>> +
>>          file_priv->driver_priv = fpriv;
>>          goto out_suspend;
>>
>> @@ -1254,6 +1259,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>
>>          amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>          amdgpu_vm_fini(adev, &fpriv->vm);
>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>
>>          if (pasid)
>>                  amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..13e1eebc1cb6
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,39 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>> +{
>> +    mutex_init(&userq_mgr->userq_mutex);
>> +    idr_init_base(&userq_mgr->userq_idr, 1);
>> +    userq_mgr->adev = adev;
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>> +{
>> +    idr_destroy(&userq_mgr->userq_idr);
>> +    mutex_destroy(&userq_mgr->userq_mutex);
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> new file mode 100644
>> index 000000000000..7eeb8c9e6575
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -0,0 +1,49 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_USERQUEUE_H_
>> +#define AMDGPU_USERQUEUE_H_
>> +
>> +#include "amdgpu.h"
>> +#define AMDGPU_MAX_USERQ 512
>> +
>> +struct amdgpu_usermode_queue {
>> +       int queue_id;
>> +       int queue_type;
>> +       uint64_t flags;
>> +       uint64_t doorbell_handle;
>> +       struct amdgpu_vm *vm;
>> +       struct amdgpu_userq_mgr *userq_mgr;
>> +       struct amdgpu_mqd_prop userq_prop;
>> +};
>> +
>> +struct amdgpu_userq_funcs {
>> +       int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>> +       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>> +};
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> +
>> +#endif
>> --
>> 2.40.0
>>
