Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18D1C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D47D10E3C1;
	Tue,  3 Jan 2023 09:32:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE5110E3BF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Fi2pvV8EiHkWH9GXuidAj3c1XpIb8maFFO3GabF4xAxzN6xDojLvGOI2ktuCFzRUeTMC+1QWO4/ReXnMrpn76+NS7LMJmUKeuNJGDky+nInZIBcdxgHmEoPajgOAeQvDE6kdHnJkClBEFvgUgaG2vEV4k8N7eXDn4l2T0bZ2a51XuAtyq6kCiuP12KLa/qRL35o2uxYgWCD4jYlGLbj57JDDm+9BSGbsaJN2JM+2V948DP5T0QVIqqonMAIbv/AxeifBChRebdW/DlUyTOvMgrGQJmIFlivKC3hNreKIJRJfmRX+pfFvEJjztU58NOnqX9ziHYc1OCX4Y8PkDp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/1NIHmKnXqsZU5IrDmH/o2iEU8AKBtr0rQvE06Mlbo=;
 b=KsrYDPmk9U88Pha9mJohwvj7LDTg8jpzHzUkK4Avys9n+CjLCyxQLc+wKKnzfrK4a75QGFCLPyi7ev7gyM25xdPwELrE1C6XMpsIbBnyBKmEIYfFIbdSTRVycd1Qk8tfvQJ12lVfnfyvAN8u8hUfZbPGFi6HFoKRWitiJqolitDPvV19T+3sUa1B2M8/ssz7MCLXNwa4duok+L9seplpokTYACXyz6Gf8lQScmov84QXonkhLAVwjeT+MDgHKCpTqST/GpkFOoVwfXsgbLxgN78ZdbkAmaHt9qiJjufOU+KMZJ4FfDPKhLiDKain+QfKQiF967Tgd76m5Y1gqo1qyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/1NIHmKnXqsZU5IrDmH/o2iEU8AKBtr0rQvE06Mlbo=;
 b=cODCGmZfF9h7JQwlgGkscLgT7hlkVAjwm0yp8R9Ip5LZ1CdKo3wuIUHAKxzV11mXWyo3KPvY6z1V+Yv4HHity64o85ck/CZNtqLz9k8013VCcFHalOg+kjOaE0lhcXB5IWM7r71kT0LE3RoYO/0GUZHDesiI22kR+Q177QKyfI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:32:32 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:32:32 +0000
Message-ID: <3c2beb76-0d76-cb84-2dae-fad45b853618@amd.com>
Date: Tue, 3 Jan 2023 10:32:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <CADnq5_Pyk5AnsW7C2YX2uR1Y0hWRFW6774iAvmihFznpAvt1fg@mail.gmail.com>
 <d8c6e95d-0e81-83e7-5956-8086091d94aa@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <d8c6e95d-0e81-83e7-5956-8086091d94aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: b334c93f-7528-4563-f561-08daed6d7055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOnXGdX5L1aJd2MxbKSs+DAh+gckCWoULfp1rRlYmMLteEBb+p80gkAHwMl3kN9yalywCESmYF19ZWY+yJ+uy05LbMdh7yvJEb6FhCHzcg1t0p564FZqh3lHMqBUE7RxnSYQEiOGUvab9h7t8Mdu8rnarpyxGctx6IWQWI0giCX20p0Ge3GvAdO9aJ7Xd0ExU8bXxVue4z0IA7OpKuIPV80DEC9z/eqC9bWAPtfxypwn+6Afs1gOFE3Ezdll8Qsxb2jmLcGn3TpCYAa1jBG5pSuRTSY7644d2vtBq24ZziCDmYNbKXmbNDZGf5HgfrKZoM6F0JH5Rn7RPBOc9Y6WO9QQ69kX8FkSGeDGA4I+dhALQvjYf0q2ZKAvsQkPJq82pVwbk3mkTDLRQdotdDkDa/yhhrNIdmfCafHQ0JVPw4y17kJMDVF6tkKl6jyDqeSU1Q9arJgVwvzp25lnPupGssfWYZY73pq+cgPFTI10FNVXsY8sLBq5NHXkNnRaqRpZH6LDASEqN0JH3eEn/cE4/WF2Ib/I1RDdYEFN9XjHyHuXL7jDoKKv9722XdaTTYAv1QgcWWzW6CKmnpFtyBstREi20wnpAIgufh6Pnmn+xmdYEoDBJWyfFeSuHDCtARL8dfESIOh8WvarBVLl9lyJKNleExZ8RsY5bzI1m/b6KZHOOX0PERrWRN52zF5ikSb9RB0HwLwieLOPRStH7olUpDr3sn5ZG4AIWvQFMJiReQzvRZOYidlS1gP8wUkm4jiB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(83380400001)(66574015)(6512007)(6666004)(186003)(26005)(2616005)(6506007)(53546011)(31696002)(86362001)(36756003)(38100700002)(4326008)(41300700001)(8676002)(66899015)(5660300002)(31686004)(2906002)(30864003)(8936002)(44832011)(6486002)(66556008)(478600001)(66946007)(66476007)(316002)(54906003)(110136005)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlwYWpjbXNWejE5MW90cW1FVldaZXNBUmt0Q0VXMlo1Z3BTM2xpRVo1MjQ0?=
 =?utf-8?B?QVlsZnVrdHNvYzNiMU1PeFB1WENLZXE1VGJwSXRpdVVZdCtkSSt3VXZYcEdr?=
 =?utf-8?B?MlM2bkRBYVdFeFlQODRSeGZjL2xHM05CZGVNV3NOSkwzUzFBblh6VWo4Mjd2?=
 =?utf-8?B?aWNMV3hvYWlweURUVVZkdE5TcGJGeWh3ckNxVm1yUE9kUXVnREJqRGU4VmFw?=
 =?utf-8?B?RGFKSnZmMFpyM08wSlF3eEhnWnBST1FKR05kSGJJKzVia0hTTEh4MjhOQ2h4?=
 =?utf-8?B?QzdYSnFQTzZjdFNGWCtENlRuM1BtSlh5YURudEczci9XaWFmNjRsUDhJT0JG?=
 =?utf-8?B?M2JYWGtiYWs2STdPcTkzS05iTHVobzN6SU1JOFZXb2twZVkrSEhicjhDVkpK?=
 =?utf-8?B?Q1pobUFSUDN6YjBCVk03ZzBNREJmbUY0cHQvM2pXRmdCQ2p5Q3lUdnAzY2FN?=
 =?utf-8?B?WjNVSlo5WFZ6eXloaU1VaGdtL0FaaFFCeDFPMVN0TDlTZWhBSEp4akpIT0ha?=
 =?utf-8?B?NytQVmo4K0pDbWJHcnRMK0NhRlRINHhLQnZKaWM3TVEzM2JQREpvekpyL1Nv?=
 =?utf-8?B?YUh0Y0lxRTFkak82QklDelpnK2pkRHcwME41WXRTSStHNXhHblBpSkNVUzVy?=
 =?utf-8?B?SHo5YlRaMndQOXpLWlpIOXNmR3hqQUhld21jQzVtTnRrckZwUEtyNWwzOUdk?=
 =?utf-8?B?QitTUFhta0x0SmJVaWZhZlBpZWYwR0dLREx1WGpBREFzWkVzSmxyRjdld0xi?=
 =?utf-8?B?dTRhTDFhNWlFZitzTndTVVFORXJLdFdTMEZCUHhSUWsrQ3loRnY4MUpBa0xZ?=
 =?utf-8?B?bldVZ3Y0Rno3VWVhbzVoU0Y0M3FLOTkxQWRBUHp4bDFUajhXSTZBczR1MDFV?=
 =?utf-8?B?NU1pRmhWVWZsSStrYmsvTVRUdU15L24rNm12R005QUFoSlp6UU5waDdpY2dy?=
 =?utf-8?B?S2o2M1RVYTdyNk9GSHJEQ3Rvd0pKLy9qbWczVDVqNUsxR3NPV3VMN09KVUZP?=
 =?utf-8?B?bjNNTUxiYUQwOVVMdURrd0c5NDY5OXdIUUxTbTFTN1ZFMjhpVXZSTHR4dlhG?=
 =?utf-8?B?QmZPc29uOXN3bXJlYndnVFRuVitNRitVN201RXcwckxxbFFyZlRjQWdHYnkw?=
 =?utf-8?B?L29Dc3ZsbjcwMzBhOFNhSVlRWGg2VmdrcnJvQVd3NkdEVjVKd3ZQWVpSQjNa?=
 =?utf-8?B?NmNYVEMwcWxkVS8rOFNaSkx0ZEZXYlZPZjh0cHdaWjY2MFVMNkJxd0Z2dFBZ?=
 =?utf-8?B?RjRuQ1I1anJLbDd2YitiSjVDbXhwOUlyejVLRkZyc0tVdm9WZVdxT283ZFlK?=
 =?utf-8?B?RUxHODlGR0NiQW1ScThjbExQKzJTTUxUdVA2OWJJS0FVWTU2ZFFwczVmQUU0?=
 =?utf-8?B?Zi8vdmhFUi92TGtQV1VWZEkvYThWK3lCM1ZEbUtuNGpNUGxtbUN1V0ZUNlhE?=
 =?utf-8?B?WGNGWU1qTk9HdHFBMmV5SGE5djN2Mk9EQkRqSEQwZ0ZKRFdNTVBCeWYrMEZE?=
 =?utf-8?B?ZlYzeEczaVB4T1lZZ0hKRkM2bkVtNFdzY2NXYWl1Tmx5UE1mRk41V2xYZ0xL?=
 =?utf-8?B?VnVGbDZSVzh4aGRseTVFNk1JY0c3amQzditlWkJlK2R0UnZJMWlXZjJqdW5t?=
 =?utf-8?B?c3oraDdrWm1BckxaM2QxUDNsUGdnSFVDK1BmZG92VnlVeXFEZHl0UC9FeU9B?=
 =?utf-8?B?UCtIcGpFQ2tCMyt5QmdXaUVXTXBFdGlUQXZnVjFIaXRXQWlPbGZSbEE2U3lN?=
 =?utf-8?B?UWRBa0RDOFY5SW9Ib0RKOGlRajVxMHVydUtNYWFCZEFtZHZZeitRY0Z3Nmxz?=
 =?utf-8?B?NEE1WFVkYmtnQ25qcGFvS3ZoclNqN2VNZ21yOWkvenJKUmZKd1dOaDlxeEJL?=
 =?utf-8?B?aVVQc1Y5SlpINytoMlRaRkRJQ0hZRFlwRTJoRGlIemlxcGJpRVBSRVlDOFJa?=
 =?utf-8?B?VlZ3Z2tMT2U5d1B4OGtaeUEwTm0vc3NvUkJPaDd1Nzl3eDlLZy9aUGd0dkpE?=
 =?utf-8?B?M1hLdVVwbVlrYVU4VkNqcENSMm8vVGtmVEQ4THZXUlova0Fha01MOHJqV05E?=
 =?utf-8?B?UnJEVE8xSzRNWmVINER3SmVCd3hCNTJrd2ZBOFo2a0xwcmVhbjBMZDFGNnVF?=
 =?utf-8?Q?7McWX++QCE39sUNm9GQx5dTAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b334c93f-7528-4563-f561-08daed6d7055
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:32:32.1215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fa6q/yab5Hqx9NnGxcG43dD2Q32h08MZZ81qQB9hvUDwAgZ9t9SQyzRWPH44gNTjLm4281eIT626ROvsB13wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 02/01/2023 14:53, Christian König wrote:
> Am 29.12.22 um 18:41 schrieb Alex Deucher:
>> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma 
>> <shashank.sharma@amd.com> wrote:
>>> This patch adds skeleton code for usermode queue creation. It
>>> typically contains:
>>> - A new structure to keep all the user queue data in one place.
>>> - An IOCTL function to create/free a usermode queue.
>>> - A function to generate unique index for the queue.
>>> - A global ptr in amdgpu_dev
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 
>>> ++++++++++++++++++
>>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
>>>   5 files changed, 246 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>   create mode 100644 
>>> drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 6ad39cf71bdd..e2a34ee57bfb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -209,6 +209,8 @@ amdgpu-y += \
>>>   # add amdkfd interfaces
>>>   amdgpu-y += amdgpu_amdkfd.o
>>>
>>> +# add usermode queue
>>> +amdgpu-y += amdgpu_userqueue.o
>>>
>>>   ifneq ($(CONFIG_HSA_AMD),)
>>>   AMDKFD_PATH := ../amdkfd
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 8639a4f9c6e8..4b566fcfca18 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -749,6 +749,11 @@ struct amdgpu_mqd {
>>>                          struct amdgpu_mqd_prop *p);
>>>   };
>>>
>>> +struct amdgpu_userq_globals {
>>> +       struct ida ida;
>>> +       struct mutex userq_mutex;
>>> +};
>>> +
>>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>>> @@ -955,6 +960,7 @@ struct amdgpu_device {
>>>          bool                            enable_mes_kiq;
>>>          struct amdgpu_mes               mes;
>>>          struct amdgpu_mqd mqds[AMDGPU_HW_IP_NUM];
>>> +       struct amdgpu_userq_globals     userq;
>>>
>>>          /* df */
>>>          struct amdgpu_df                df;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> index 0fa0e56daf67..f7413859b14f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>>          unsigned long                   ras_counter_ce;
>>>          unsigned long                   ras_counter_ue;
>>>          uint32_t                        stable_pstate;
>>> +       struct amdgpu_usermode_queue    *userq;
>> There can be multiple queues per context.  We should make this a list.
>>
>>>   };
>>>
>>>   struct amdgpu_ctx_mgr {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> new file mode 100644
>>> index 000000000000..3b6e8f75495c
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -0,0 +1,187 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include "amdgpu.h"
>>> +#include "amdgpu_vm.h"
>>> +#include "amdgpu_mes.h"
>>> +#include "amdgpu_usermode_queue.h"
>>> +#include "soc15_common.h"
>>> +
>>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, 
>>> sizeof(__u64)))
>
> You seem to have a very very big misunderstanding here.
>
> access_ok() is used for CPU pointer validation, but this here are 
> pointers into the GPUVM address space. This is something completely 
> different!

Thanks, It seems like there is a misunderstanding in my side on 
definition of these input parameters, let me follow up.

- Shashank


>
> Regards,
> Christian.
>
>>> +
>>> +static int
>>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>>> +{
>>> +    int index;
>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>> +
>>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, 
>>> GFP_KERNEL);
>>> +    return index;
>>> +}
>>> +
>>> +static void
>>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>> +
>>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>>> +}
>>> +
>>> +static int
>>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct 
>>> drm_amdgpu_userq_mqd *mqd_in)
>>> +{
>>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || 
>>> mqd_in->doorbell_offset == 0) {
>>> +        DRM_ERROR("Invalid queue object address\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || 
>>> mqd_in->wptr_va == 0) {
>>> +        DRM_ERROR("Invalid queue object value\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= 
>>> AMDGPU_HW_IP_NUM) {
>>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!CHECK_ACCESS(mqd_in->queue_va) || 
>>> !CHECK_ACCESS(mqd_in->rptr_va) ||
>>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>>> +            DRM_ERROR("Invalid mapping of queue ptrs, access 
>>> error\n");
>>> +            return -EINVAL;
>>> +    }
>> Need to check the flags as well.
>>
>>> +
>>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
>>> +    return 0;
>>> +}
>>> +
>>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct 
>>> drm_file *filp,
>>> +                            union drm_amdgpu_userq *args)
>>> +{
>>> +    int r, pasid;
>>> +    struct amdgpu_usermode_queue *queue;
>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>>> +
>>> +    if (!ctx) {
>>> +        DRM_ERROR("Invalid GPU context\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (vm->pasid < 0) {
>>> +        DRM_WARN("No PASID info found\n");
>>> +        pasid = 0;
>>> +    }
>>> +
>>> +    mutex_lock(&adev->userq.userq_mutex);
>>> +
>>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>>> +    if (!queue) {
>>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>>> +        mutex_unlock(&adev->userq.userq_mutex);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>>> +    if (r < 0) {
>>> +        DRM_ERROR("Invalid input to create queue\n");
>>> +        goto free_queue;
>>> +    }
>>> +
>>> +    queue->vm = vm;
>>> +    queue->pasid = pasid;
>>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>>> +    queue->queue_size = mqd_in->queue_size;
>>> +    queue->queue_type = mqd_in->ip_type;
>>> +    queue->paging = false;
>>> +    queue->flags = mqd_in->flags;
>>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>>> +
>>> +    ctx->userq = queue;
>>> +    args->out.q_id = queue->queue_id;
>>> +    args->out.flags = 0;
>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>> +    return 0;
>>> +
>>> +free_queue:
>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>> +    kfree(queue);
>>> +    return r;
>>> +}
>>> +
>>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct 
>>> drm_file *filp,
>>> +                              union drm_amdgpu_userq *args)
>>> +{
>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>>> +
>>> +    mutex_lock(&adev->userq.userq_mutex);
>>> +    amdgpu_userqueue_remove_index(adev, queue);
>>> +    ctx->userq = NULL;
>>> +    mutex_unlock(&adev->userq.userq_mutex);
>>> +    kfree(queue);
>>> +}
>>> +
>>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>> +                      struct drm_file *filp)
>>> +{
>>> +    union drm_amdgpu_userq *args = data;
>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>> +    int r = 0;
>>> +
>>> +    switch (args->in.op) {
>>> +    case AMDGPU_USERQ_OP_CREATE:
>>> +        r = amdgpu_userqueue_create(adev, filp, args);
>>> +        if (r)
>>> +            DRM_ERROR("Failed to create usermode queue\n");
>>> +        break;
>>> +
>>> +    case AMDGPU_USERQ_OP_FREE:
>>> +        amdgpu_userqueue_destroy(adev, filp, args);
>>> +        break;
>>> +
>>> +    default:
>>> +        DRM_ERROR("Invalid user queue op specified: %d\n", 
>>> args->in.op);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return r;
>>> +}
>>> +
>>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>>> +{
>>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>>> +
>>> +    mutex_init(&uqg->userq_mutex);
>>> +    return 0;
>>> +}
>>> +
>>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>>> +{
>>> +
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>> new file mode 100644
>>> index 000000000000..c1fe39ffaf72
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>> @@ -0,0 +1,50 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>>> +#define AMDGPU_USERMODE_QUEUE_H_
>>> +
>>> +#define AMDGPU_MAX_USERQ 512
>>> +
>>> +struct amdgpu_usermode_queue {
>>> +       int             queue_id;
>>> +       int             queue_type;
>>> +       int             queue_size;
>>> +       int             paging;
>>> +       int             pasid;
>>> +       int             use_doorbell;
>>> +       int             doorbell_index;
>>> +
>>> +       uint64_t        mqd_gpu_addr;
>>> +       uint64_t        wptr_gpu_addr;
>>> +       uint64_t        rptr_gpu_addr;
>>> +       uint64_t        queue_gpu_addr;
>>> +       uint64_t        flags;
>>> +       void            *mqd_cpu_ptr;
>>> +
>>> +       struct amdgpu_bo        *mqd_obj;
>>> +       struct amdgpu_vm        *vm;
>>> +       struct list_head        list;
>>> +};
>>> +
>>> +#endif
>>> -- 
>>> 2.34.1
>>>
>
