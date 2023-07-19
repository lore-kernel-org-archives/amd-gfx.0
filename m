Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE384EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 04:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2810110E3FE;
	Wed, 19 Jul 2023 04:53:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0059510E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 04:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LneUgZuBgAejOJVxevgv1JX5J8AEvA2KVCvoaaf6XSoiqvAnGJ4yBqdW6VWU9+gixpvT/LcgYesQxt56dY4QnDH6FENufVhKQPModul6Mp5OdZnf8tFKg0XesagjT8oYQFgxnElE8poCIkJ4goopbXdZ/ozgC5YEyPo8GmsfGZ73Y6Q81DSxouXZycssYmuhEw+1x6bb84foVoEUt2zSjNjDCG9i4oFp4sqoXqg361+NLa4qNXymnQR+W0O09x4jHXXZw89ru2KM71W5Lca26yQVp+MW5LgvzHTv/aLHacui1bzJbIlOuVzOr+FiN310WUiZ6mS9P+xSwHAQlBIXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgwbMFB4V/jT0YjWWcs20+QUFtGio7sJUPaLs8zGThA=;
 b=lDora3+gDy8nwKoj3WOIgr9a3/O82B5LOAECkY+jAEXpv5Se+0LX3x2fVUekAlo4ytq1NaU/cb2AJv5bRLACxmiPZ4wDxSOfqRlCM9UO3dWmJH9yqfckhizZPwLE9vZvNyoor/n012JXu3pSexCfaJ/U/JoYZMQ6RI/KdD0gvcSFGGSYxooxtAM4YichpJLr/1d0dA1X5SV8FAWHbivcVY1lcDRn5xnIQnH9fktbF3LAhM/ykcoEND7957aaK2iEvq5ZLnRpJ4MThxULAXZcciy71yCNuSv1fV9+p8du/e816i05Xw6vqbbEhpWEtzOGM2EFwE0t6mfIjjWJIJ+i2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgwbMFB4V/jT0YjWWcs20+QUFtGio7sJUPaLs8zGThA=;
 b=W8MLNPnyu4JUROiK3vEIKr08YbT0xCp1sS6yVUzSfDAPQb6+aAEKoMwAh3KhDvnNpEFrE3avQJU4g2hHOUlsLSN4wGle+bWV+bVY9Rwr4TwzpXc1f5zWP69mrEksfxXp7mW3ANwmnVA+HesaubGTvVxKRmV+967stVWPZkQ9CQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 04:53:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 04:53:01 +0000
Message-ID: <a6778216-9170-120d-eae4-2c8000df35d0@amd.com>
Date: Wed, 19 Jul 2023 10:22:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
 <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
 <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
 <7c6c2699-0732-9e6b-4c5c-f36bcfa83814@amd.com>
 <844c21ed-fdeb-d6d7-f103-c4d0660544ae@amd.com>
 <BL0PR12MB2465A275C88351932936B5FEF139A@BL0PR12MB2465.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL0PR12MB2465A275C88351932936B5FEF139A@BL0PR12MB2465.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd1d093-8553-489d-d8f1-08db88140760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogS4x1u5Jc6zelJPrVHZv5tkshJzCgylTjmNpXgoGoVfgxiaKA9sPc5S6Y3FHYXdtpHCftg/rUKmEKcgOVTSBTOt0e1HACsO2leEU2dXh75i5UajxK4jgV0345hRXFSxkpoNdrXQW0vRydglVRGWn0EJc4z8YiYG4l9UQ7rkqojHm2jzxUMRghqvT4GRaWy+vOHt5fJ9yvv9Sj+35ETHUctQPl73L+DkUiErQXpf8ED64GuHF6MAbXGOmZmnPzZWTiUgOMQBHW5Th1EzuFVSg4+03PTGtXHZQ7GNkCsKVaJlcPraEwbMWAVBSi8Cdlg86JA7aQMOMNuOEvuhBaBLFsT7gdB7jfx692/BupQWOLLlqJq9VddtwgAqV0CdQCcNo/X/2JcYf2QVQkR2DfmD8J/WpCp3/tvAs7j5B7bbDJ0GYpbr2YH35LpDigH+KuA/kwLZazcBa4XF2js9RoYVHRAEd+9K6GNiKk40g1Qs8khfqEyZsZRF+7lqVVIldllfYtqgcRpz62Zcj1TjZ5CCmL5AIUQ0DU1EvifvxoZlppHPTe8DDoo1q64E8LnCXl248gnvN/7sb08AVZnvGvSRvd5i2nIJWgVprqh3pD6799dreFFlC8SJqkitWrcuaR27FJ4WcZPm2a8FOTzPycWqDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(31686004)(110136005)(2906002)(478600001)(54906003)(6486002)(6666004)(8676002)(36756003)(15650500001)(4326008)(316002)(66556008)(66476007)(41300700001)(66946007)(8936002)(83380400001)(2616005)(6512007)(38100700002)(53546011)(86362001)(31696002)(186003)(6506007)(26005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NNNllhSkVieitCRkhVV2RXQWN2RXg2YjJ6aFoxakU3NlRneGpINlFYbkND?=
 =?utf-8?B?bnBjalA0cFI4Ly9jT1FHVUNlZmNqa1ZwaXlDZDRDUW1qVmkxanp5aFdwWFBW?=
 =?utf-8?B?V0xocU8zbzBoOXl0VlZqU2RYaSt4ZVE5ZHd2ZHZtREVFcDZxOGdjZ3F4Tjl5?=
 =?utf-8?B?aXhidzUvZDV2V1dQZWRQYUk4WUI2N2NBc1BiT211WFpwUWM3N3NpSEQ0RFBx?=
 =?utf-8?B?dU45ckE1bXpEd2ZZUWh5Snl6NmlleThwY2x3Y2JGZW92bmttbkN3cFBkTits?=
 =?utf-8?B?SWg1RWNqZ1hYY1U3cmI4aCsxWXR6Mkd4RzVMYlczdUdwT29jQlREMHEyN1JO?=
 =?utf-8?B?TnZua0V6YkgySFVNWTdtSThGMnhsazhyaGhFdE1qMlIzd0p3WFg5dlMvbkhY?=
 =?utf-8?B?OGk1ejU5Qk1DRkpjeHRYWmNMOElwQnp4aGRreDN1K1Rxd1hNOUFqbnliK0s5?=
 =?utf-8?B?UCsvaFJMUkdibFhYMnQ1VjNUaFhFR1FEQ1JFY01xY3ZjeURqdnRjMTdwclcy?=
 =?utf-8?B?ajU1Wk1scU8rUm1sZmx0NWs2V3dYVWlpN2ZsVnBMbG5rTTd4YnhyVDNOb0Qz?=
 =?utf-8?B?Y1N1Rk9FUis5OThoVHN0eVdOMDBmeWQzQ20yKy94emVXWC9CV3JvMnp5T1cz?=
 =?utf-8?B?RHZhdENzS2w0R3g3cXFvckZKMFZrdlNORTFDSWE0MEN3VTVNelRtZmxSc2JL?=
 =?utf-8?B?ZlB0SHVDWFIrSnJaUlhZSU1VY3h4REVxTjdpZjBXUWZ4ZFJSa05rQ3greWRh?=
 =?utf-8?B?MFJoT1Y3SXpSOUo1a3JRMjkzbEFmeEJML2pyWUo3WkxvNEFqSzF0WHJvblkr?=
 =?utf-8?B?WUVuRVg4V0lpRlZ6RFArd0pOVDRFKzU1ZXhYUE9ZNUhzb1FORjB2U1F3SU94?=
 =?utf-8?B?R0hOY2VLMi9CNUw5NUx1V3hZenptRFQzN1ZvaitHYjJteW1palE3YXNMbnNI?=
 =?utf-8?B?UDdpeXVBa3FkUkZWT3RxbGJpNlRXQ0pKdHQ0Ni9pOEZ2NGYzNDREbDdqWUxl?=
 =?utf-8?B?MnF6RkpoYXIxUjMvRk40THJpTEpqa0o5WGNsMUFTSG5uNFpVcGNNK3BkRWhj?=
 =?utf-8?B?dXlua1JzM3E2VkRPRVhnVTlCWEUyM09mWVMxNG1VSXlWWW96ZStjcFhNOE03?=
 =?utf-8?B?TVZQMFdtYU4wemV2dXlvVGkwa1hHSFNuMGJzcU5BQUJVWk1JTTlCK01xNTYr?=
 =?utf-8?B?bHpaRnQ2WmhLQ3d0blF4enBJUHBUQ1c5SWZ1Ykt3ZzBiNHk2dXJtN0ZLT2pE?=
 =?utf-8?B?VmNSN3R5NGdFNTIyYU9MSThzUkMxRW1OWVVBWmdzVklQQVREcWxnTHYrSHdN?=
 =?utf-8?B?RVNvY0IzcE1KTzVvZDJ1cVNZckwvRnpHV3JlUFI0RFg1SlJvaHlPYXJkR3hY?=
 =?utf-8?B?YTJkeHR3dkp2Wm9hWmozTC81bjFHNXBId0ZPd1pqYXhaSTB2bDJZclM4NHVp?=
 =?utf-8?B?U1BMVUZaQjdCZTVnN3lIRlZqN0RNRnlLWldwOHJpcjFRS0dnWHhKcUpYc09n?=
 =?utf-8?B?YmFpTU9PNzNTVEVUenFTZGE1NVI0VURxRWZvWHNja0hTcGRNWVg0U0pkSjRz?=
 =?utf-8?B?bDNiL21zcGtIeE9QSGMxNDMyQjhCWXlrY3RITG9jSXdzWEpVeDl4VGd4RW5O?=
 =?utf-8?B?ajg4NkF5UTNaU2x1dHZzY0VxczJ1L3lGTG5ZblE4ekZndmt4aUFCL1MvdHRh?=
 =?utf-8?B?YUxQSEFiNWhWemxZSGZUODR6bjNUZy8vZjVjZitNNjhQTC9XQ3o2VVEzQ204?=
 =?utf-8?B?cC9sZ3hzYzd4Q25YTHF2b2JQR3p6YnA1UC9NcWQzeU5rR1VqKzloT2JtMkNG?=
 =?utf-8?B?QWRlUWxUOERQOEtyQ3YzV0s3VGVUOVVNd1piRFdZUmUyckJIYStLZUpRVXVq?=
 =?utf-8?B?cGs2SURVN1FlcTdCY2xreW83dXhNekR5aUV3Nkh2Q1QvM0VDbVFLbXZqU3hZ?=
 =?utf-8?B?UUhkZHpWWFRndjlkblhkVDhyN0hraDV5WDFER08yRnFPZ0hQSWNTc21pTExI?=
 =?utf-8?B?NXN0OEU5NElGVUpBV25wbEx6ZzRSUG1xTjNCa2FwSkFraDhHNXBJdXBJbVgr?=
 =?utf-8?B?a1hOdVlOT0Z5emYvWHNGblpuUkdHSCsxcTg2a3loaG5TOUxkdmduQmJoQ3Jj?=
 =?utf-8?Q?cwyzg1st9sVm9Yf1qHR3Zmjuj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd1d093-8553-489d-d8f1-08db88140760
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 04:53:01.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Ucnfll4CLqBSejP5njqxGRKOpWLxnVhQcHgFyluCkfBfF6XabITdUMve8ni1Lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/19/2023 10:12 AM, Chen, Guchun wrote:
> [Public]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar,
>> Lijo
>> Sent: Wednesday, July 19, 2023 12:13 AM
>> To: Zhu, James <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, James
>> <James.Zhu@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang,
>> Hawking <Hawking.Zhang@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
>>
>>
>>
>> On 7/18/2023 9:39 PM, James Zhu wrote:
>>>
>>> On 2023-07-18 11:54, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 7/18/2023 8:39 PM, James Zhu wrote:
>>>>>
>>>>> On 2023-07-18 10:19, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 7/18/2023 7:30 PM, James Zhu wrote:
>>>>>>>
>>>>>>> On 2023-07-18 08:21, Lijo Lazar wrote:
>>>>>>>> Not all rings have scheduler associated. Only update scheduler
>>>>>>>> data for rings with scheduler. It could result in out of bound
>>>>>>>> access as total rings are more than those associated with
>>>>>>>> particular IPs.
>>>>>>>>
>>>>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>>>> index 72b629a78c62..d0fc62784e82 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>>>>> @@ -134,7 +134,7 @@ static int
>>>>>>>> aqua_vanjaram_xcp_sched_list_update(
>>>>>>>>        for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>>>>>            ring = adev->rings[i];
>>>>>>>> -        if (!ring || !ring->sched.ready)
>>>>>>>> +        if (!ring || !ring->sched.ready || ring->no_scheduler)
>>>>>>> [JZ] any case for ring->no_scheduler = true, but ring->sched.ready
>>>>>>> = true?
>>>>>>
>>>>>> amdgpu_gfx_kiq_init_ring sets no_scheduler flag true for kiq rings.
>>>>>> amdgpu_device_init_schedulers inits schedulers only for rings which
>>>>>> doesn't have no_scheduler. However in gfx_v9_4_3_xcc_kiq_resume,
>>>>>> the ring is marked with ring->sched.ready = true;
>>>>>>
>>>>>> I'm not sure why it's done this way, but this is the case even for
>>>>>> gfxv9.
> 
> Driver so far still has some concept abuse on sched.ready. In amdgpu_device_init_schedulers , it's set to be true once setting up sw scheduler for the ring requirement, however, after driver is up, this flag works like a hint to tell the corresponding ring is ready for HW submission after ring test succeeds.
> 
> For this case, it's probably caused by amdgpu_gfx_enable_kcq  calling amdgpu_ring_test_helper, which sets sched.ready unconditionally based on ring test result. This will lead value mismatch between ring->no_scheduler and ring->sched.ready. If my understanding is correct, I think adding a check in this helper function which only sets sched.ready when no_scheduler is false will help.  So I will provide a patch soon to prevent this mismatch in future.
> 
> +if (!ring->no_scheduler)
> +       ring->sched.ready != r;

The ring.ready(ring->sched.ready) flag is used in gmcv9 code as 
well.This will need more rework.

Thanks,
Lijo
> 
> Regards,
> Guchun
> 
>>>>> [JZ] I think the sched.ready confuses people. here just means ring
>>>>> is ready be used.
>>>>
>>>> Thanks for the clarification. One question is then do we need to
>>>> check ring ready status for assigning xcp ids or just check if the
>>>> ring is associated with a scheduler?
>>>>
>>>> Keep only this - if (!ring || ring->no_scheduler) to assign xcp ids
>>>> and leave the ring ready status to the logic which really accepts
>>>> jobs on the ring?
>>> [JZ] I think keeping ring->sched.ready will reduce schedule list which
>>> will save a little scheduling time.
>>
>> Fine, will just push this one.
>>
>> Thanks,
>> Lijo
>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>
>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>>                continue;
>>>>>>>>            aqua_vanjaram_xcp_gpu_sched_update(adev, ring,
>>>>>>>> ring->xcp_id);
