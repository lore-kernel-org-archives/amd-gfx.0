Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B712BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 02:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5659D610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 02:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5659D610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93516E4DD;
	Thu, 28 Oct 2021 02:44:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0496E4DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 02:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBwSpjTZh7Hnw5aCswqJu2NI/pwNig2Dl3JoGUL+6FABRwn36LYLjN4metYli9kkm4Pwu2nxZ5A451g2XVwl/l1tOBJIYhL45a+coeklymtsUA2W/HYtYQbazPpPB6+au97tUc+S8YFlBSzUrvkvywDpCFOFwC8O1audpYbGjYISnsaE/Vj2vhbdOsZC/cmPsmJJg5ulkSd/O31ufS1YutnVF15UcIRHExPae3RKAbNSzqhiEcbltyQ4RhOEJoRLPrmPchdYIBSHih+gSYxWpvzCG/3A6yz8LJzINY90OMlrAMFUa7Q7jpJyxrk3b+4OSFKkSNPd+ujK9ITrS/03qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E55Rin/Uu4sOBHSr9uZpD+/KS8W9jcn8rNs1PBRfq7U=;
 b=j48CXTby+ddkUkLmk3tqpUiV2wwIm/hnm+0LINpwIUaoaeb0bA/CaeOdw2FRrqsa8H6EJw/Cm51VVFUK5i/LEnzxFMpMRU07O9hlV9FN5VFWVb0qzzTuCOjBqJ++hFqS/sWguaCiprvqH2CzVZYaJZt0kwkHBs6MT6gdX5QsclhzeQSlXdlzVTmABGc1m1LSi+UCOqXzGbSNKB1Onc8gfSFxSBn2uUt+DWVWs1hFpS4e1YS4rTHhC1Pczm8Ui5+EMO8t4RDCuu84x5uQ8IKr/3hxFfAkSpIaRajDrngi84eeGIsuJC3Z/1yfuZ40wen3g5Y7r0dINkwoLoHYQS7SRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E55Rin/Uu4sOBHSr9uZpD+/KS8W9jcn8rNs1PBRfq7U=;
 b=RLT6DxYS54ZdwQ+yfaeNFtBE4akCgDyyc2kFZ6HbMY+6vlxG81j4Urnmzs7i7WeezYtcfhQKI0FF60T+8bVhLayXW83aogQYXErfTUA6/k1APV423io7GGNNiLcj0udXd0rtB5/i9RKckSfe+KmY5f8zZS7aUCIS4HUDv7ekRXw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 02:44:04 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 02:44:04 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, jingwen.chen2@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
 <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
 <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
 <fe55f902-1473-dc8d-3011-808fc93c7e5c@amd.com>
 <9df71fc3-9862-59c0-56d6-9e325d15192b@amd.com>
 <3c7449a2-a6ef-28a6-ca0a-7c749ca3f093@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <df99eee9-8b11-bd4a-0f1e-08e4baaa9712@amd.com>
Date: Thu, 28 Oct 2021 10:43:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <3c7449a2-a6ef-28a6-ca0a-7c749ca3f093@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To DM4PR12MB5232.namprd12.prod.outlook.com
 (2603:10b6:5:39c::16)
MIME-Version: 1.0
Received: from [10.65.96.204] (165.204.134.244) by
 HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 02:44:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda9113f-ebb3-447a-0ff4-08d999bccdfd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5197:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5197A4E7222F12A445ADFA94B7869@DM4PR12MB5197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkBrKXDkasOVHnoKl7NbyKzWq1oLnzr+ucmzWTuUngLFXVmhgRsxKyPPujvUlUd4l2Zfmuj+l61wE2HSkXAeE+vtgpcv32kLN0rDX2DXyp6RwBd3M1Bn240S+Af2MN6CjzjCV3d+Ux2kRdHAchwoWbxGXzJSds+E7p0Z3f8PW5ERYQfgTjw3HVXsXtOoZ5/zcVc/CQqMnTnZjP9bIIEJfOcW/PrVCyXB1RAYlKmH7Is6nXAxfW9195kYi3D61UR7WPS94g15j8Tz0HkXtPmcjqh81kcs5bWk8nBfUM09Qn/c7U6vECaaFbCxTUXMSQl5ST0W/R2FFszFlhlCVh0HwdvUlm7qlhEgQwkGF2PmTEUibks6jRL+MAkK+dwMLJzoSkvRwuLGoQIkFb18w+gyW7EudQxrpIiGI3dhAbZFR9uDDdq9mG3YTByN1BMcUOT/0K5DRy5a8S2E/sdvJBzC/gsxitxAnyO1KhRN2gcnf7DKeEHjdv0f5lIwCxsW4zUikDIqhuOLIH+5fDO3nyBulbgDn/twpOgZMBd1VOvx1+6AKoSLw0JXjFT/MiyOzp5TW8qF+Xx5YTHoOT3PVBiYKspgJ+lZ2jQzgDshe4epeceU9mBbKFtmNTKaS/0RKSgZrrc1WORuxizcVSHl9UTLUDqXbZV5JNFvEasm/xsrMLptKLmUn8/IhVq1d6MoUQAwdiVn1Kk6BYUfWcw1ZZ9UJt/+Ydp32OtLBsSUXgXDLD+CjfMOzwPU9+7mw0wO5yisybIAcLgKAoDCdAXYUEWWTXbpmuHlVGdvp77c94rhrEXR8t0ZXOVU0tuglK77ykdo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(8936002)(31696002)(66946007)(956004)(2616005)(26005)(31686004)(6486002)(66476007)(6666004)(38100700002)(4326008)(186003)(8676002)(2906002)(83380400001)(16576012)(4001150100001)(966005)(5660300002)(508600001)(66556008)(36756003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnI2VHVRTmE1QnpxNHFuV2R0QmRYeUhTR1lINWJuUm9BRmZRM0xhcDVTTUJF?=
 =?utf-8?B?eklMZnUwYXNpMUZiSVVJL2NKRDR2ZUVzZ2dTTjNTS3psUjlMMU0zTE02VG9h?=
 =?utf-8?B?MkU5MUd4QWMzTWtJQjVyNmFDMTZ0Sm9rZDNNQ1ZyRmZwL0RVRGdvbEdveWFp?=
 =?utf-8?B?cXJrOE5yNWpEOHN6cEpiNjl5OWkwSHlXYWJ4Vm1RNGdCeUlleWJDeHFFY0No?=
 =?utf-8?B?TXRrQ1FybTkzZEZWL25sWFZGYnRUWXlBWnpObHBKbFFEbGJmUTNaZnJSL3dX?=
 =?utf-8?B?eXV3MDFRdXExNjRpa0IvL0crL3VNaVc4MmtMcEl3ekI1R3hmazJGd2ZFb0tZ?=
 =?utf-8?B?K256S1NQL0JMZUs4RDF1aE5jc0VFZnZjSWc5dzl6Smx1SzhFamtoUnE2U20r?=
 =?utf-8?B?SmhqTGQ0ODRMNjA0akNZWTFnL0Qyd3lYYW9UMEhUTkV2ZGNVNkc4SGs1QUNL?=
 =?utf-8?B?NTlWTTVPc0pGVEFUT3dPaGxVQzRMaUZaeUliZjZCeFRYaWVvbkpacFljMjZL?=
 =?utf-8?B?WFBGNkptUnp1dlErMElweDFORHdtVk1GK0Y2OXg1KzVtZWNvOEdRUmNkcUtu?=
 =?utf-8?B?bG0renlxMjU4YzJlWW5SN20zT1I1U2RZcWdVR0hvbWJOY3pGc0Uveld2RzlO?=
 =?utf-8?B?czU0d2VNSDhBVzIxQ2xjNzNCYjRGTEhBeDgwZTltL3c1c0VZRkJ3SnJoU2hS?=
 =?utf-8?B?MFZaQ1FrL0FVVzkwY1dBM1hzWlBXd3dXM2ZMdXJmdjYyMVVWRXdScDZuSUgy?=
 =?utf-8?B?eTZPcWFIemthQ3dXbDFHT2hHRTlTT0pXMUhoY2ZuMDdkSmRTZWJEbVRydXRT?=
 =?utf-8?B?cmpLNXJYUW9ZRXA3Y0Q0YzFSU2x0US8vVlY1MHBYSTRyelVGS0ZzMDVoSCtF?=
 =?utf-8?B?eWVkWDUya1A3K3lOUjY3VlEySVR3TVMvd2xZZXplWGdUYkNJNFlPd0VWWDdy?=
 =?utf-8?B?ajBObXdDTWJkVE93T2laaUJ6YURUb3V5Q1g0Y1dlbnFyNjdDMG9jeGkyaE53?=
 =?utf-8?B?RXZyb0hPOGlkajRud0J5QUR2V1dEb0RZRnhkckFNdE41ZEwyMmx0aWdHZUhQ?=
 =?utf-8?B?dzN0dFVjT0x5NENiVjYwbkoyaXdIRXprMzQxVVh5NTdqamo0c0tiL3JmN1hi?=
 =?utf-8?B?MlB4d1J3RDVQVDJwYmtZZ29jN2hzUjh2YVJ3bXZ6NXNhaDdnNjRhUTBoQnAy?=
 =?utf-8?B?U1B1NWd1Wk1JNEJVZ3dycy8rK3BpUHJ3ZnEwS2NrTm5XN2pycEQzcU5iODRN?=
 =?utf-8?B?akpEKzVGcldzTFV6Mm1hTmIzYUhHUTl3K0R6Q2xnMXMwT0s2ZDB0MXYzeWc4?=
 =?utf-8?B?OEVXaDhwd3lNWTdBQzJqREIrby8vbDkrUHVpbWUrMkJ5enBRM1RpUUJzSlhG?=
 =?utf-8?B?dSt6YmNmYjBsUWQ1RXk1V0UvZXUvcGc4b2IyRzlkNTFjS3llNVdiRndwMTNZ?=
 =?utf-8?B?eXBZWDBWNDdpL2Z4eG1MTXRKRHhKWTQ1THhFb0Z2aTNRaGZOaFVxWWlvT25l?=
 =?utf-8?B?cTFSVHY3TmFUV2VCUWsrb0RqYUtPYnNWMnp2bS9LVzZpWTVTV3VidEZEemdC?=
 =?utf-8?B?NXF3bHkyR3oyT2dVaG9MV3NRRnZZY21GaEZlU0xvY1p0RStQS2JCSjZFeUNq?=
 =?utf-8?B?NFdYeDhFYWw0OVduZUpBY3R5Zk5JWlNWOTV4OFV2Sllid3pwNXpSSFBERzE0?=
 =?utf-8?B?L0NTNUE2K1N4L1RTZk82RHNlVWVsVisyQ1NpQTdYM3JueEthNCtqd0w0OW90?=
 =?utf-8?B?L25wempmL0dEVFA5WUdKZlY4MzJFVURTM0RpNnBCZ3JnQkFLZGNpcjNnMExK?=
 =?utf-8?B?VERyVlF3cWp0WTBURWV4Q0tsUFd6UDhReUxERXlqSi9Sd3Z0VlZybFo4bFZy?=
 =?utf-8?B?S0IydU95bjRZaitSUm5JS3F5ZXBHbUF3aCs1eGxubksyc0YxQ0EvdStwa0t6?=
 =?utf-8?B?SGVuZ0lNN3BUd001WUsweUhXNEI2SGRCTGN5RlZZM0MrbzFnU25GNzRDVVYv?=
 =?utf-8?B?amoreEkwZEZScyt4bDAzbHMwNDczMnN2bHpKQlY1b1UrdVF6MHZHNzNSb1A4?=
 =?utf-8?B?K0JUcjRYWG1OWGlwNkhUa05mVjRYbkhCWDR3bjZ5NmtPNUNVYk1DVldnbUdR?=
 =?utf-8?B?NWpuYTNjc3lDZjM5MkhEREpHOVBvcTFHb3kxUHhkaVJ2eUVkSG42dHhRakR0?=
 =?utf-8?Q?RMyLZW+ghVr8OFR9Piy4ANU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda9113f-ebb3-447a-0ff4-08d999bccdfd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 02:44:04.0054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtYfGi5DxWmv8FvxT2lFDmIYgIdLrlysQv3aQFr/1cTcp8nwsTZxaH0Z619p8ySiVJoEf+AB93/0yftj63e/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
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
Reply-To: jingwen.chen2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021/10/28 上午3:43, Andrey Grodzovsky wrote:
>
> On 2021-10-25 10:57 p.m., JingWen Chen wrote:
>> On 2021/10/25 下午11:18, Andrey Grodzovsky wrote:
>>> On 2021-10-24 10:56 p.m., JingWen Chen wrote:
>>>> On 2021/10/23 上午4:41, Andrey Grodzovsky wrote:
>>>>> What do you mean by underflow in this case ? You mean use after free because of extra dma_fence_put() ?
>>>> yes
>>>
>>> Then maybe update the description  because 'underflow' is very confusing
>>>
>> will do
>>>>> On 2021-10-22 4:14 a.m., JingWen Chen wrote:
>>>>>> ping
>>>>>>
>>>>>> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>>>>>>> [Why]
>>>>>>> In advance tdr mode, the real bad job will be resubmitted twice, while
>>>>>>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>>>>>>> is put one more time than other jobs.
>>>>>>>
>>>>>>> [How]
>>>>>>> Adding dma_fence_get before resbumit job in
>>>>>>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>>>>>>
>>>>>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 41ce86244144..975f069f6fe8 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>>>               /* clear job's guilty and depend the folowing step to decide the real one */
>>>>>>>             drm_sched_reset_karma(s_job);
>>>>>>> +        /* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>>>>>>> +         * to make sure fence is balanced */
>>>>> But that put in drm_sched_resubmit_jobs_ext is for the previous parent fence.
>>>>> fence = sched->ops->run_job(s_job); returns a new HW fence and the put drops the refcount on the old one.
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>> Hi Andrey,
>>>>
>>>> If I remember correctly, after we embedded the hw_fence into amdgpu_job, there will be not fence replacement in amdgpu_job_run.
>>>
>>> Right, I forgot that... What about removing line https://elixir.bootlin.com/linux/v5.15-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L265 ?
>>> What if you make dma_get_fence unconditional instead ?
>>>
>>> Andrey
>>>
>>>
>> Hi Andrey,
>>
>> I have tried this and this will cause normal jobs cannot be free(lacks a dma_fence_put).
>
>
> I can't see it  - can you point me where in that case you get unbalanced refcount ? As far as I see for a a normal job
> being ran in amdgpu_device_recheck_guilty_jobs the refcount on hw_fence is  -
>
> drm_sched_resubmit_jobs_ext->dma_fence_put -> refcount decrease by 1
> drm_sched_resubmit_jobs_ext->amdgpu_job_run->dma_fence_get increase by 1
>
> In total refcount didn't change until now
>
> Next,  dma_fence_wait_timeout completed successfully because the job is normal and then you delete that job from pending list and call the
> free_job cb which drops remaining refcounts on the hw_fence.
>
> I am probably missing some  dma_fence_get since you checked it on a device but I wonder where is my mistake ?
>
> Andrey
>
>
Hi Andrey,

The thing is the put/get is balanced right now for normal jobs in TDR. Changing this dma_fence_get to unconditional simply adds 1 dma_fence_get but there's no corresponding dma_fence_put for normal jobs.

And if this can be helpful, I try to find all dma_fence_get/put for a normal job in advance TDR based on the latest drm-next.

amdgpu_fence_emit -> dma_fence_init    ref_count = 1​
amdgpu_fence_emit -> add into rcu    ref_count = 2​
amdgpu_job_run->get after ib_schedule    ref_count = 3​
drm_sched_main-> add fence callback get    ref_count = 4​
drm_sched_main-> add fence callback put    ref_count = 3​
drm_sched_resubmit_jobs_ext    ref_count = 2
amdgpu_fence_emit -> add into rcu    ref_count = 3​
amdgpu_fence_process-> put after signal    ref_count = 2​
drm_sched_main->free_job    ref_count = 1​
drm_sched_fence_release_finished    ref_count = 0​

If we do unconditional get, this sequence will turn into:

amdgpu_fence_emit -> dma_fence_init    ref_count = 1​
amdgpu_fence_emit -> add into rcu    ref_count = 2​
amdgpu_job_run->get after ib_schedule    ref_count = 3​
drm_sched_main-> add fence callback get    ref_count = 4​
drm_sched_main-> add fence callback put    ref_count = 3​
drm_sched_resubmit_jobs_ext    ref_count = 2
amdgpu_fence_emit -> add into rcu    ref_count = 3​
+  amdgpu_job_run->get after ib_schedule    ref_count = 4
amdgpu_fence_process-> put after signal    ref_count = 3
drm_sched_main->free_job    ref_count = 2
drm_sched_fence_release_finished    ref_count = 1
>
>> I have figured out all the get/put
>>
>> for sched_jobs and only the bad job lacks a dma_fence_get, other jobs are just fine.
>>
>>>>>>> +        dma_fence_get(s_job->s_fence->parent);
>>>>>>>             drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>>>>>>               ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>>>>>>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>>>>               /* got the hw fence, signal finished fence */
>>>>>>>             atomic_dec(ring->sched.score);
>>>>>>> +        dma_fence_put(s_job->s_fence->parent);
>>>>>>>             dma_fence_get(&s_job->s_fence->finished);
>>>>>>>             dma_fence_signal(&s_job->s_fence->finished);
>>>>>>>             dma_fence_put(&s_job->s_fence->finished);
