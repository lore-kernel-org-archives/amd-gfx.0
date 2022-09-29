Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E7FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 11:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6ECD10E5C1;
	Thu, 29 Sep 2022 11:10:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F8310E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 11:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxzT8xhwJvEHJPJW+gERpzCKhwd9CCkeN6/OAwhqIu0+bNVn18v4yx2+P8+mqHN2ms/afmgwC6DBgQVjKWtZHjQJ+Y5dq/ch87Z61sjbX15jnbQO+GGwk0JqUB17HRh2lI1bE482o4JpC5DWPjlELNokSwTD+rpo5TOPPYlwORY0xKUAD1QO1IMjyfKxSFIlq+CZCsrAYTUtKRhEzOSq6joZ9L6sBe2/gvBaJb3yMD4iOfyKegUZhDLhHuDPDCMhPIOIjXMaW9ugzhAQFtTCqPg9KwlmdyEXeQyEzeBOV0blSzsK88nBu51UXjUCxE+naZGtXGZ3H5xTZkz1Zgmj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2snjJUwQQ0OXbAgOEF16SlimlmhINlw52K88aocG2g=;
 b=kY9m4UGv463okNaWEZobA+Ppw4eB7R/NErvw9WLV5nY/6e0XTwS3GO3hkN+xWAoKyVwFltJ+OPOEOps2rVyF4oNBCXjajWCiP6/pYyWP8LxQuXqPQvJ26zOvyqB7l4jKV87SmR7uZivXteIpV1bskYk+LAi3GnHJ6S7ckGPKttO0VoyOe8Qc8LIOkBI2wmF/F+JAyuWLp1/x+1oDQaZ+qO5WLGpNZ1d4d7ky14ne5alERTkyFOn25/SBcEyah8iK3hC1HwCFfu//EhF3MqVgXKrEiyWN38UtmLjZ2uwOrWGMLwABjCzYh0Xwia5VB75Z7vRXvxh4JE2fIN5N+4vy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2snjJUwQQ0OXbAgOEF16SlimlmhINlw52K88aocG2g=;
 b=fe5zSmweYYQT963IX42ezczDht7US5eohtwUGhTqOiigHYJYeCLRYLST3gexurWrl6XRlHH8tUAocFINbv2tXY1rCrmZf+ccRXCgkLm/D68CRrTTjBx5Lo9BjItwkIdrRmM6fFqTGvlodehFLUNI18ubsppQlC+6LAkO9j4HHrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 11:10:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 11:10:47 +0000
Message-ID: <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
Date: Thu, 29 Sep 2022 16:40:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: ff333960-cf4a-4178-e6b6-08daa20b4265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hd10YV9HqLM9VEbNAeJnCY1r0yURXS6/6CLePMCeWBv2pnLtuJxua9pWHibdhzJA5UtN6ifo136rxViSofqExgrUsEYiuwYEosf02bDQEJ2/5u3fs+xfJEb0G6dLC0gsbZTlBSm42MiovO6rmTnBn7KgapxDVlnHZtuaMyw0qOzw4AhJeivYXaBOQeD2nWj/PZ7rkOPXtrCGBoxB0thOElUzqR70wBjxUKbhWSlGmCtDkbhNnIN2dvhQbFG0JGCGsv15sjS3dfBXpPpGT9H8Vt+9USG1JHRp3sIDPvza9TmnI8QYDBP/rbVwunD2DCQPaxWD2F3VcOtGWtPTV0XBnqiOK8tPUwyBEgPNp8UTalRrDe1RwzIHCXSvxzhbrFXYxeGIKiKQtbdX9ieCPHGmHiiFlQDWNzT0MboQSHQGW4l8xjFYKhv5BCv+PuFYuTvZt/IdlcMQsEvfO6NukX+GhjIAFJXgV+tWkaBRT33gaLRVk0Hz8R3kCidb+UYmDq2EL/7uU4y8oQH/e91bU0dggN1Wc0Bw3OG/xpQB9jb19i0Od1X5QMqZVka5gNiTuvfOo2tGXWUyCn9IuPDX8ovkzdH8yCJkMawtdbaVtT7P37CybW/CMoDHgMGogBecMpffdTRV2V/MvELVhO+c6HieOXsPQUd5e0SbunXs7KD0fZ0RWaZM1YrqZIpfDp0oAOXdbLNscWYi06WhEvFuGqG81Km3kl6z1x3hcY+F3F0vtBWc4z0geGlK0qgQp5/X0YbiHCGdAbh8sxFJBoNCIqDgO3c8ZjKnTywXXhIX7XuYiyVhkYMe6xyHA1340YvM8RVjm3pFIvbwp+QrctvCLwtJR1UfHXiZBHbCf3B9A65unBCn9gq5r0F2N8e5m01lYnqx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(36756003)(966005)(478600001)(6486002)(31686004)(83380400001)(66574015)(31696002)(2616005)(86362001)(5660300002)(38100700002)(186003)(30864003)(6666004)(41300700001)(6512007)(6506007)(66946007)(66556008)(110136005)(53546011)(316002)(26005)(2906002)(66476007)(4326008)(54906003)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkdVcjhYQ0ovS0lJMVlDdVJIZm9pWXZkNG95cFhBOTdGeXBDWjQvMkRSVjVw?=
 =?utf-8?B?dHAvemh1OTNmR3hhTnZDc1JRczVjdnpsWE1zSzljRDBDREdzL2VLSGNkS1lK?=
 =?utf-8?B?Y3dnc1hoNzdGelpQYmV5K2pCV2M5cm05NnhXUER3UmJHaGtnVk5nS2hOaUpJ?=
 =?utf-8?B?YXpOS3RoMms3d1FSZzBBMnlVMUdodE5KK2ZCbVpnTWUyejZjU2t6UytPZ1Ey?=
 =?utf-8?B?NVhzV1F4VmhXbEFJSjhlT2FyOWMvUjZMYUc2ZlJaMzQycEFjTHEwNWpqMktJ?=
 =?utf-8?B?S2dlU0UzMEhpMlFWMkx0dzRQZS9PcVJSeFB1aTJCeU1tTDEzN2pPWjFpclcz?=
 =?utf-8?B?OGJVL2xKRjJhb3lVRndXYmZYZGFEVHpOUklORVVscTlkcmRidU02NkVrN0N1?=
 =?utf-8?B?azFzQktranlaSzY4R1NOcHRjdzlHbDZZVDJiYlE2anIrdkJkSFRBNVkrTzJs?=
 =?utf-8?B?VW5SNEdpZnJUZU81N3RKRjhTOG1KdnFCYXBSUnpMdG4yTTBEYVZNekNRcUh0?=
 =?utf-8?B?K2RWZEVXeWlBbnFYakJMMGdyVXkyc2hQY0VDZ2VjY1k5Y1BlMlR6R0h2cGpZ?=
 =?utf-8?B?U0lCeXJONXlKTjFRZnpnYVhkeWpibjUyY2NYNHFQTmd0NVdPNWswVDJWNGNj?=
 =?utf-8?B?L2plT1RmL0pEWlUyVHlNeTdraWgzdHZZTUxPNXYwUkJ3cGxPanpoc05TL012?=
 =?utf-8?B?RS9iVEhtdDZrcWtGWVFVUjNwWkRmNFR1UGxiajNTcTlNRVBmZDdDU0tFSkx2?=
 =?utf-8?B?VGpRTGRWcktDQXY0eUZuVU1aTmR2bEtwdlZ2djU5UW5wK2FhQ1RDdkU5VnhU?=
 =?utf-8?B?UDlqOGNkSWI2RW91Yi9jVlA0aDBLMGlZcWkxNEt2VG5DZzNkVGdvenEyU2h2?=
 =?utf-8?B?aTNiRkI5ZkJoMHJuTVg5TmZPYlRMb215Z2V5OFBISTg1Mkw1dFVpMjFYWCtV?=
 =?utf-8?B?ZzM0cUlUTHp4c2tQelJsaTRvUjVIRmc1OFNxOUF2VFRHZFNmQWlwWXhtcDlh?=
 =?utf-8?B?emtxS0lhazBLT2dtYnVlUlRpZk5lVldYK0ZQT0hRNmUzY1RoZUF4ZVN0Ti96?=
 =?utf-8?B?YS9FNnJmbVJab3NmOWtHbDlrSE43SHI1K2ZtUnFIeTJHcUZ5UG12eHlXY0pI?=
 =?utf-8?B?OWtzVGJaS0gwQUdDQjNxUEN3T0JRdHRGS0JJbU9BRVBjdXQvYmRXVDFlZW9V?=
 =?utf-8?B?a2wzWjA4OWwybnVjL0Y2N1crMHNrMTBxdGR4c2xZdUJrR2E5YUs1Q0lWQlph?=
 =?utf-8?B?aDU5TmUzelg5OFczakMzMTBmUnFya1Ntb2kwY0tGOWZyZ1pMRVFxOXBxVnYy?=
 =?utf-8?B?ZHUyWTVxY0EwWmFLdy8zdHk3THFpL3VIS0grc0RDWmM4bjlVVndPQ2lIQ21I?=
 =?utf-8?B?UDlVSEx3NTRoM3ZoRTRnZ0lEbVlyZ003UTBMNjQ4eVpPTHJNOFZTUkI5M1F3?=
 =?utf-8?B?cTRWRzIyTzQ2RW9BaDFhWUtxMTY0RU1UV2prSUp1eVFBb0hsbDRXc1lLOTZ4?=
 =?utf-8?B?WmNzWjdXWkpUQ2JmSzFRVnNzeDh0b2NXdDBiQ0pYbGR1S0lSNXdCWllvYUs5?=
 =?utf-8?B?STlzZTJnYjFaSmxJNWhCRVF4eUJLT3RZLzgxODlFTzRlUTMwM2YyWjNxV2h2?=
 =?utf-8?B?cy9TYi9GVUV5emFSMHJBUUY3WEZCc3ArSHFaNWtCNElBSDh6eUJXVjFjYk1B?=
 =?utf-8?B?bjNpbklRdVg5KzFRSnVCdjRseC8rVWpNd2Vzb01jc2xwQ0ZjRm5wNnJYQUYy?=
 =?utf-8?B?Skl4UzFxZnNqWk9YZDhBMUtOUHp5NlYvT1F1L21pZXRrOXNjSXE4S1NsR291?=
 =?utf-8?B?dlFDQ2dYbVB6dmdZMDZ1NHlObmVVMmJobTQyd1h3bGNsL3ZueEJQemZzeXJn?=
 =?utf-8?B?ekxyS0MvUlhRc2E2eFFxMWtoMFNGRTN0L1YwaVZ5V0lmYWZVYTdYMi9sMFY0?=
 =?utf-8?B?S3hhUjlaRjZhMUxRQmIxMHkrTjZkWnNZVTlsQXYydlRTUmNYSGlSWDRYYUJt?=
 =?utf-8?B?ZnFmTlpHcFVxVjljOGZtWFp5aFVOd05JZER2eWVMZ1JVeTEyM0N0bERWQ2hJ?=
 =?utf-8?B?R0dDNTZsNU8rb1g1M0xXRzl2VFFxQXc3SHJRVmQrYTdNOHhXbHkrWXhYbE9Q?=
 =?utf-8?Q?uPliiigmmlV5jx97u+5UEHIiA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff333960-cf4a-4178-e6b6-08daa20b4265
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 11:10:47.2098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKAJM+4UgunYR2AR5Ux221PHg4+PB/NcsE1S0W2TkK76lLqbL9FuTQ8yMmsUkVC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/29/2022 2:18 PM, Sharma, Shashank wrote:
> 
> 
> On 9/28/2022 11:51 PM, Alex Deucher wrote:
>> On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
>> <shashank.sharma@amd.com> wrote:
>>>
>>>
>>>
>>> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>>>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>>>> <shashank.sharma@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>>>> Hello Felix,
>>>>>>>
>>>>>>> Thank for the review comments.
>>>>>>>
>>>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>
>>>>>>>>> Feel free to add my acked-by, but Felix should probably take a 
>>>>>>>>> look
>>>>>>>>> as well.
>>>>>>>>
>>>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>>>> about the interaction of compute with graphics or multiple graphics
>>>>>>>> contexts submitting work concurrently. They would constantly 
>>>>>>>> override
>>>>>>>> or disable each other's workload hints.
>>>>>>>>
>>>>>>>> For example, you have an amdgpu_ctx with
>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>>>> process that also wants the compute profile. Those could be 
>>>>>>>> different
>>>>>>>> processes belonging to different users. Say, KFD enables the 
>>>>>>>> compute
>>>>>>>> profile first. Then the graphics context submits a job. At the 
>>>>>>>> start
>>>>>>>> of the job, the compute profile is enabled. That's a no-op because
>>>>>>>> KFD already enabled the compute profile. When the job finishes, it
>>>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>>>> unexpected.
>>>>>>>>
>>>>>>>
>>>>>>> In this case, it will not disable the compute profile, as the
>>>>>>> reference counter will not be zero. The reset_profile() will only 
>>>>>>> act
>>>>>>> if the reference counter is 0.
>>>>>>
>>>>>> OK, I missed the reference counter.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> But I would be happy to get any inputs about a policy which can be
>>>>>>> more sustainable and gets better outputs, for example:
>>>>>>> - should we not allow a profile change, if a PP mode is already
>>>>>>> applied and keep it Early bird basis ?
>>>>>>>
>>>>>>> For example: Policy A
>>>>>>> - Job A sets the profile to compute
>>>>>>> - Job B tries to set profile to 3D, but we do not allow it as job 
>>>>>>> A is
>>>>>>> not finished it yet.
>>>>>>>
>>>>>>> Or Policy B: Current one
>>>>>>> - Job A sets the profile to compute
>>>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also runs
>>>>>>> in PP 3D
>>>>>>> - Job B finishes, but does not reset PP as reference count is not 
>>>>>>> zero
>>>>>>> due to compute
>>>>>>> - Job  A finishes, profile reset to NONE
>>>>>>
>>>>>> I think this won't work. As I understand it, the
>>>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>>>> profiles. Disabling the 3D profile doesn't disable the compute 
>>>>>> profile
>>>>>> at the same time. I think you'll need one refcount per profile.
>>>>>>
>>>>>> Regards,
>>>>>>      Felix
>>>>>
>>>>> Thanks, This is exactly what I was looking for, I think Alex's initial
>>>>> idea was around it, but I was under the assumption that there is only
>>>>> one HW profile in SMU which keeps on getting overwritten. This can 
>>>>> solve
>>>>> our problems, as I can create an array of reference counters, and will
>>>>> disable only the profile whose reference counter goes 0.
>>>>
>>>> It's been a while since I paged any of this code into my head, but I
>>>> believe the actual workload message in the SMU is a mask where you can
>>>> specify multiple workload types at the same time and the SMU will
>>>> arbitrate between them internally.  E.g., the most aggressive one will
>>>> be selected out of the ones specified.  I think in the driver we just
>>>> set one bit at a time using the current interface.  It might be better
>>>> to change the interface and just ref count the hint types and then
>>>> when we call the set function look at the ref counts for each hint
>>>> type and set the mask as appropriate.
>>>>
>>>> Alex
>>>>
>>>
>>> Hey Alex,
>>> Thanks for your comment, if that is the case, this current patch series
>>> works straight forward, and no changes would be required. Please let me
>>> know if my understanding is correct:
>>>
>>> Assumption: Order of aggression: 3D > Media > Compute
>>>
>>> - Job 1: Requests mode compute: PP changed to compute, ref count 1
>>> - Job 2: Requests mode media: PP changed to media, ref count 2
>>> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
>>> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref > 0,
>>> PP still 3D
>>> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref > 0,
>>> PP still 3D
>>> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>>>
>>> In this way, every job will be operating in the Power profile of desired
>>> aggression or higher, and this API guarantees the execution at-least in
>>> the desired power profile.
>>
>> I'm not entirely sure on the relative levels of aggression, but I
>> believe the SMU priorities them by index.  E.g.
>> #define WORKLOAD_PPLIB_DEFAULT_BIT        0
>> #define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
>> #define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
>> #define WORKLOAD_PPLIB_VIDEO_BIT          3
>> #define WORKLOAD_PPLIB_VR_BIT             4
>> #define WORKLOAD_PPLIB_COMPUTE_BIT        5
>> #define WORKLOAD_PPLIB_CUSTOM_BIT         6
>>
>> 3D < video < VR < compute < custom
>>
>> VR and compute are the most aggressive.  Custom takes preference
>> because it's user customizable.
>>
>> Alex
>>
> 
> Thanks, so this UAPI will guarantee the execution of the job in atleast 
> the requested power profile, or a more aggressive one.
> 

Hi Shashank,

This is not how the API works in the driver PM subsystem. In the final 
interface with PMFW, driver sets only one profile bit and doesn't set 
any mask. So it doesn't work the way as Felix explained. If there is 
more than one profile bit set, PMFW looks at the mask and picks the one 
with the highest priority. Note that for each update of workload mask, 
PMFW should get a message.

Driver currently sets only bit as Alex explained earlier. For our 
current driver implementation, you can check this as example -

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1753

Also, PM layer already stores the current workload profile for a *get* 
API (which also means a new pm workload variable is not needed). But, 
that API works as long as driver sets only one profile bit, that way 
driver is sure of the current profile mode -

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1628

When there is more than one, driver is not sure of the internal priority 
of PMFW though we can follow the bit order which Alex suggested (but 
sometimes FW carry some workarounds inside which means it doesn't 
necessarily follow the same order).

There is an existing interface through sysfs through which allow to 
change the profile mode and add custom settings. In summary, any 
handling of change from single bit to mask needs to be done at the lower 
layer.

The problem is this behavior has been there throughout all legacy ASICs. 
Not sure how much of effort it takes and what all needs to be modified.

Thanks,
Lijo

> I will do the one change required and send the updated one.
> 
> - Shashank
> 
>>
>>
>>
>>>
>>> - Shashank
>>>
>>>>
>>>>>
>>>>> - Shashank
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Or anything else ?
>>>>>>>
>>>>>>> REgards
>>>>>>> Shashank
>>>>>>>
>>>>>>>
>>>>>>>> Or you have multiple VCN contexts. When context1 finishes a job, it
>>>>>>>> disables the VIDEO profile. But context2 still has a job on the 
>>>>>>>> other
>>>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>      Felix
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 
>>>>>>>>>> +++++++++++---
>>>>>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>>     #include "amdgpu_ras.h"
>>>>>>>>>>     #include "amdgpu_umc.h"
>>>>>>>>>>     #include "amdgpu_reset.h"
>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>       /* Total memory size in system memory and all GPU VRAM. 
>>>>>>>>>> Used to
>>>>>>>>>>      * estimate worst case amount of memory to reserve for 
>>>>>>>>>> page tables
>>>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>       void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device 
>>>>>>>>>> *adev,
>>>>>>>>>> bool idle)
>>>>>>>>>>     {
>>>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>>>> -                    !idle);
>>>>>>>>>> +    int ret;
>>>>>>>>>> +
>>>>>>>>>> +    if (idle)
>>>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>> +    else
>>>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>> +
>>>>>>>>>> +    if (ret)
>>>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>>>> compute mode\n",
>>>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>>>     }
>>>>>>>>>>       bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device 
>>>>>>>>>> *adev, u32
>>>>>>>>>> vmid)
>>>>>>>>>
