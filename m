Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA531C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 08:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C1061165
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 08:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83C1061165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2359E8921C;
	Wed,  8 Sep 2021 08:54:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB1D6E15F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 08:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqWTKssh6Vxnd+ndbLWBToDiAWRzRSK3hRvSW6urOJuOldkruNhzkNnoQPuWjAeR4miNuV/zmaiqB76FDI27YRbvE9nGeSXt0MVplLn9pxyDflx13UASkX3zHdZCia4GTpxnrmoxy25MPTM18mltU2KVJs1sfUXJluXXR1d4B6RSBlstKZqNcwNF2OjjHN8ZogTomCcN8K3gcbKfAbhOlq3HWbCD1hOUQrov4ZAPVRs/MWoLfGBhwzAzfd+cIJFUrkw7pzYB0caTFhxiF2f2v4LD3FGDJWBe/w29C/yXOOvjVyvPNY1FU6cb7aYbQeHlfA5GEdvEyu0eFje++S12cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=x8lByMuLqlrkti1C/Wsy8qPFG+pt2OWgwCSnjXTUKI0=;
 b=VK/Z2t1s4dnHUZkAExN90n8DYPI5p06kDllZzlHI0N0k2r74t2p6jyYr020xqHJMc1UW8O6+hmbC1OdCvZyJ4FVuUb7cHzxws6l+je7QlipPJnAiyTOQLeYhWEBHeqMcA6pWON9JISBQhvAklVhuvfP56FlL0TV1TQNTZAAH71fNwrUSRlLu1ylyQQqlAeL+JXvINfkaiySQXU5BFrwPC6kE6dY+jwzw3f50f+PwmBP/zB6Dwb4kC3ztFjgPzXXpvzBT3f6yyfYG9GYFrDbk5RZSqKQQN1mfvwdz3QFnjk+dQCtJ+DfTSU4UAob7Sv9h+14/jAipVvxLcCq0suqsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8lByMuLqlrkti1C/Wsy8qPFG+pt2OWgwCSnjXTUKI0=;
 b=2m+wGY7b7lp1uchwK3+hy2VybZxnjy4x1kkB3Od33Bp7maxp1xURgj0TUB2uLdN2PqwSp2/EeyBbjpIri/PiUY568WHPdofmXu3Nd63QzyJKkPCajv3NEfzFgcfo/bhkW8Cbo8nZqhYLaoNzGgL64JckFKCHI6pwPrbGa7m44Wc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 08:54:25 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 08:54:25 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
 <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
 <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
 <82d8e743-1b0f-daa9-3bda-fc791dd1795e@amd.com>
 <7370b0d3-a179-1138-bbc7-728dcd131498@amd.com>
 <1b7ec90e-752a-3111-c226-25ec1d3c385f@amd.com>
 <0db529ef-e19f-550a-ae01-bed1a586765f@amd.com>
 <2cc7ef01-0871-457c-6f85-6ac78220b3ff@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <a586086a-13de-eb90-ffc3-40ffb0cae255@amd.com>
Date: Wed, 8 Sep 2021 10:54:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2cc7ef01-0871-457c-6f85-6ac78220b3ff@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f25:c400:f9de:83ca:92c4:6824]
 (2003:c5:8f25:c400:f9de:83ca:92c4:6824) by
 FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 08:54:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 979907eb-a52f-4b6b-db6d-08d972a64229
X-MS-TrafficTypeDiagnostic: DM4PR12MB5200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5200889A10ED17D71C4202DA8BD49@DM4PR12MB5200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sSJ/0bRuNk+9M33IeH89qNGp0EaXGVLM96MO4bHZdvKJ8H9lnnANNhNK0aDcEWuBK1ojhIlULbin99+MZ95rBEfCERcdlvLRN+EnQmy+uK8oJ1i3+cJ2nhUB1j9uCIxYc1cKAeIN88HsiB3eyp4JVlhAaJ+hUzMmsZpJcajIvlJJjqFbIY11khO7qwdF/qcLmCMBeltr0LST0mKGNpyC98hvkx64jswB0CX5Kw9JCwl1MBP0VkguogVntHUMeiSRLVS0+22vQf5jBeOZoocBO6ugNiMLpTN432anWQvIWEhzxmeJuq3PFEeyFORDGq5pO5y4Jbq07upWBauPhX38feUAST3pcDY154LFqnpkNViIuFuSlsGS2f054lHopXIHs/5/VL2oPN145E9PnWSu7wdIW9SdiX81L3l842A7V2l3s5i93HhFr12YZU1L6qwDuHokZRJd6INwSXsFeU1w6envQrSthD6PEe5GjqvPNSKAmiKJ/Fdk8JU5aqhDGC25RM1vBHJSxUISb1bLNkD6ZbojlKYpGcIwlo9KPRH7dq07De5Ubf3qu8JGV1oHKW8twQqiAxTOm2Jv+RtiBS3wVeG+4oTxgKr7LmnOousaEBVorasoUmk42ijupVnothGhwKa3n6U6AeJEaEDiZ8gG92yauC56J0OI0AzJ3AiD9jUXOwE/c8FOD4ywAMrngUF+MCvj55C04FHse8Q2GwZSPOJhXPsyGxrybApQr3BYhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(36756003)(186003)(66556008)(66476007)(53546011)(6486002)(8936002)(5660300002)(38100700002)(6666004)(8676002)(31696002)(66946007)(4326008)(2616005)(31686004)(86362001)(2906002)(52116002)(316002)(478600001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFk4K3R0U0hQNlpYeTVCV0toWSt5ZkJCOVVaMHBab2VacmpBMlRLUENwQ1FR?=
 =?utf-8?B?bi9UQUZXaUZXaWFuaXloNTdYeTRMSzNuY0NEZkpFUllpVTNnVzZPQ1UwM1Jo?=
 =?utf-8?B?NUNMdHRpOXhQd0tNL0xMTXlTcHYvbjltbnIwN0pHWG5iN01EeVhlUDBQVkFL?=
 =?utf-8?B?TzZNYisrZ3pxWldxQW1lTXdNWmJRcFQ2bllYMW83bEM5TjVWNnBBL3BhL2hP?=
 =?utf-8?B?b083SEFxM0JUZzZMOHg2S1VzYjcrTTJSK3gzT3B5MWRmeGM1eW9RelpEZWxS?=
 =?utf-8?B?bVhha09FVTNGNWtyVWtmRktNNEkyQkljLzdOdEhObWs0TkhlTzVXNEFCb0o2?=
 =?utf-8?B?OEZuWkpUUG9MQTRIVDc1akRRaWdiYXBiZGJabldwTThXdEt2TWlFcXdzL0Mz?=
 =?utf-8?B?eFJoY1kxMWdrTXp0OUFya3UwWk4zcHY3eGpyNGFveTY1Qk4xVGNzTEtnN0Fs?=
 =?utf-8?B?aTEyR0IwMjNyVGg3bk4wMHlHQXhyN1pmb1J3WGdPUmhqRGM3Ni9QU1VZbXFG?=
 =?utf-8?B?cENIdjdZRHFnU0IwSWMzQjdLK1ByOWk2ZStwVVhFd1hRcG5MZ3FSQ09jdTRi?=
 =?utf-8?B?LzlCeGUvTUdTSGhsRFVLNHpuTGRhZnljS3pjbXpQU2wxemZIY0EvLzRrcGpR?=
 =?utf-8?B?NnQvMGE0RDAyVDZ4VlNjZWozS1ZIdzBmbi9FR2ZWcWdEYThoM1gzMmtWM1c4?=
 =?utf-8?B?MW12TFpWdW8rb3NMZUpkL1hnUENFZHp5a1FKak1jMURsN0owWmdOMkJneFZL?=
 =?utf-8?B?akN0YmJwRk1zR0VMRGZIaHlQazN2MGNOQ0JvTWRZd2o1c0dpOStoaW1BeTJs?=
 =?utf-8?B?RU04REYrS09Qa1hYQTFVWlA1WGFSUVlRNTd1SzhFWlVjRGUxcnhla2xZOXNu?=
 =?utf-8?B?WHJnbGtvMUpMbjB4U3ljT21iMXhOVUo0UG9ITk9YbDNCVHoxWjIweUtnbXRM?=
 =?utf-8?B?TVVtd0t1SzRadEQyNDl6RWV1U3pGZXk2WjJ0V2IvcjJnNXlhYzM3Z1UzN1Nh?=
 =?utf-8?B?cTJmdlFodUViQ3QzZkNLWG9lMURqSkt1WERWTlZPclljR1JBL2Z2cjRqQTBk?=
 =?utf-8?B?TjhFQ2xJQnFMeDRHbDdDNXVBRFRiL1hMQ2Z4QTZwdUVMaW5nOHlaREpCOHNv?=
 =?utf-8?B?eXVOZThLU3NVakxVdnVCcGlBQk9HWGJRZXF4OHlLUktBS3B3NWNSb3cxcUFG?=
 =?utf-8?B?YU1NZS80dTRhOWJ0eEZ4QWgyLzdaaUFGM2NHZFU0OUVvV0ZGTXJkQ1k3dU04?=
 =?utf-8?B?akY5RFZhcXhYaW5FWmphQ09BUHFsUDMzT0x1cnUzRHBoakdSOGR0R1hPZVpH?=
 =?utf-8?B?eXF6a2dBQm54aWdEcUsyeDRseW53dVFhVnprVlV4TGNHOUhlR2QzTmEvd24y?=
 =?utf-8?B?TFlhOGJKbFh1T2t2bWZLblZJOEdZZWhUZTh6S2RGeTF2VUVMdERlbGZnWUdj?=
 =?utf-8?B?cHltUHdoaEdEOWJuN3l1dFJJenJSaGlRL083cTdLeGVpbDB1Y1kzc2pBWmVW?=
 =?utf-8?B?RE5pSG1oTXF2NmJrNlQyZzRmdXZOQ1F5SURPTldXbkFxekNhd1N4Rllmd25p?=
 =?utf-8?B?RmJvcWxaYnYxWXdEQXFWZUFib2hnZ3Nqd05NNktYNDBnUlFoN2lCZW85R2w4?=
 =?utf-8?B?OXhreUxDU0YyY3lzTGFCN0pwd2hZc0l6Qk9tL0YxOURCbWpYSjRST3lmeEdF?=
 =?utf-8?B?S0p4YlhzYzV5NGV0ZjFXMDJUb09MTWlSM2NpaE54TE5VMGpMOEkxWGJQYU9W?=
 =?utf-8?B?WXM2MVNrT2JsRGJzanpyNEVyT2ZGck44VHdkSFhFYm5rSHNnMkhMQnYwaFZM?=
 =?utf-8?B?WS8reE5XSHNKN201bWRwZEszbW5UWkJ3aVVIcVdJVHpoYmhHOVlzWURwUWhK?=
 =?utf-8?Q?f7+jVXeSIv4ty?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979907eb-a52f-4b6b-db6d-08d972a64229
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 08:54:25.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7VcRrotZXUUnGUm2ZUrm4ewasLAabQZ8pETSaO1wJCiJHATxTFHR9ZRy/z2LQ2rb3XX5CrQOsdODqLfo7Z9sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
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


On 9/6/2021 6:45 PM, Sharma, Shashank wrote:
>
>
> On 9/5/2021 5:01 PM, Das, Nirmoy wrote:
>>
>> On 9/5/2021 10:03 AM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/3/2021 9:44 PM, Das, Nirmoy wrote:
>>>> Hi Shashank,
>>>>
>>>> On 9/3/2021 5:51 PM, Das, Nirmoy wrote:
>>>>>
>>>>> On 9/3/2021 5:26 PM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
>>>>>>>
>>>>>>> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>>>>>>>> Use debugfs_create_file_size API for creating ring debugfs
>>>>>>>>> file, also cleanup surrounding code.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 
>>>>>>>>> +++++-----------
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>>>>>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> index 077f9baf74fe..dee56ab19a8f 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>           if (!ring)
>>>>>>>>>               continue;
>>>>>>>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>>>>>>>> -            DRM_ERROR("Failed to register debugfs file for 
>>>>>>>>> rings !\n");
>>>>>>>>> -        }
>>>>>>>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>>>>>>>       }
>>>>>>>>>         amdgpu_ras_debugfs_create_all(adev);
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>>> index f40753e1a60d..968521d80514 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>>>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>>>>>>>> amdgpu_debugfs_ring_fops = {
>>>>>>>>>     #endif
>>>>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>>>                    struct amdgpu_ring *ring)
>>>>>>>>>   {
>>>>>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>>>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>>>>>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>>>>>>>> +    struct dentry *root = minor->debugfs_root;
>>>>>>>>>       char name[32];
>>>>>>>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>>>>>>   -    ent = debugfs_create_file(name,
>>>>>>>>> -                  S_IFREG | S_IRUGO, root,
>>>>>>>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>>>>>>>> -    if (IS_ERR(ent))
>>>>>>>>> -        return -ENOMEM;
>>>>>>>>
>>>>>>>> Why are we doing this ? Why to make it void from int ?
>>>>>>>
>>>>>>>
>>>>>>> We tend to ignore debugfs return values as those are not serious 
>>>>>>> errors. This to sync with rest of our
>>>>>>>
>>>>>>> debugfs calls.
>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Nirmoy
>>>>>>>
>>>>>>
>>>>>>
>>>>>> I am not suere if completely removing the provision of return 
>>>>>> value is a good way of doing it, we can always ignore it at the 
>>>>>> caller side, isn't it ?
>>>>
>>>>
>>>>
>>>> I just realized while making the change debugfs_create_file_size() 
>>>> is void return, so we don't have anything useful to return in 
>>>> amdgpu_debugfs_ring_init()
>>>>
>>>>
>>>
>>> Ah, it makes better sense now. Probably just a mention in the body 
>>> of the message that we are moving from debugfs_create_file() to 
>>> debugfs_create_file_size(), will make this change of return type 
>>> more logical.
>>
>>
>> Yes, I have that "Use debugfs_create_file_size API for creating ring 
>> debugfs file,..."
>>
>>
>
> My bad, I was too focused (and a bit confused due to uasge of 
> clean-up) around the code change.
>
> Suggestion for message: Use debugfs_create_file_size API for creating 
> ring debugfs, and as its a NULL returning API, change the return type 
> for amdgpu_debugfs_ring_init API as well.


Thanks Shashank, I pushed the change with your suggested commit message.


Nirmoy


>
> With (or even without) this change, please feel free to use:
>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>
> - Shashank
>
>> Nirmoy
>>
>>>
>>> - Shashank
>>>
>>>> Regards,
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>>
>>>>>
>>>>> Yes, we are currently throwing an error msg and ignoring it. I 
>>>>> don't have a strong opinion regarding this, I will send a v2 
>>>>> restoring previous behavior.
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Nirmoy
>>>>>
>>>>>
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>>>
>>>>>>>> - Shashank
>>>>>>>>
>>>>>>>>
>>>>>>>>> -
>>>>>>>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>>>>>>>> -    ring->ent = ent;
>>>>>>>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, 
>>>>>>>>> ring,
>>>>>>>>> +                 &amdgpu_debugfs_ring_fops,
>>>>>>>>> +                 ring->ring_size + 12);
>>>>>>>>>   #endif
>>>>>>>>> -    return 0;
>>>>>>>>>   }
>>>>>>>>>     /**
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>>>>>>>       bool            has_compute_vm_bug;
>>>>>>>>>       bool            no_scheduler;
>>>>>>>>>       int            hw_prio;
>>>>>>>>> -
>>>>>>>>> -#if defined(CONFIG_DEBUG_FS)
>>>>>>>>> -    struct dentry *ent;
>>>>>>>>> -#endif
>>>>>>>>>   };
>>>>>>>>>     #define amdgpu_ring_parse_cs(r, p, ib) 
>>>>>>>>> ((r)->funcs->parse_cs((p), (ib)))
>>>>>>>>> @@ -356,8 +352,6 @@ static inline void 
>>>>>>>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>>>>>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>>>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>>>>>                    struct amdgpu_ring *ring);
>>>>>>>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>>>>>>>> -
>>>>>>>>>   #endif
>>>>>>>>>
