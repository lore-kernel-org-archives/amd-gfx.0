Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE714C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C3C6101B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0C3C6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029626E0FE;
	Mon, 13 Sep 2021 07:15:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758926E0FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 07:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnk7M/De+xBEig5AiEcB7VNkwi2NmsR60QyQ+2joBBshu2KoU6mmtZNMvi2RfZlLKMKcFtPo6Eh3uqYWUf3gUAZ7dwjOMaqRVFcMAPTB1l52FZJMYW+fR5J1CUGRQj6LZ7ewgjKdB3Wfu/O7pntRKvEsy489hSt7y5gegze6RqF4zUKJF952dUwfLUaRWSuD6ephmb37koPACE536rLSmtT7AMEyGFk4H9ycpnuy1iAsXQerf3dZaHeHVhLFRhFv9s6NsQ1gnKOsDEAPrDL9nTbIIjmPsh+Wu7qFeZ2GMiRNxLxnXzrgtvs19DnT053Yg21VSBS2SYjZrDoLoLA1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=py8hl3Yx9U6ifDPWlsKuLC+xhWVr7jAuZVWslftpYeg=;
 b=GF6RIrFjlRiGE6uCIXl8afON90mFGgqWc5F/Y6985OFbE/pYwMES576tfeO7EwaR+RzLu/9zPO7RM1XgHoWuXF/xUMWDrl4h0wv55rcO99kAUARaAsO9Z/eGlXsut4hpGhognQRYslUOrs337T7FH63y6quVGQgxXEs7hO65sPIf25HOOEn2clRyL2DrCdM9STjZe6UBcHurXoc/5yLxL9OMKLG7ypoTcDRuntw/2EzpnLZNMidRZiKM+c+d70zuIjz/jPRQ++SSQvQD3CTjIuLR3gDf8nUT/nXusOVxO8wEqurY3tvFxrmExSmyw/c++picm2l4vqMeFiEJraxLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py8hl3Yx9U6ifDPWlsKuLC+xhWVr7jAuZVWslftpYeg=;
 b=UD31Dp7lERjPwm1a8WocSDG1UqrtCiJr6DWCdg+znc4AvLpb1JzhQPTwgqrNOPBOFW3vAKPO7dVCQp6DZKnxXn5aYxGiVqB9sX3+LT7NPAL3cYjbtloMtbrTVy1vAIQ2C3E+QgU6ugf9UtST5N5hfx0MN0D4W1U68ggBqyp+bxk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5370.namprd12.prod.outlook.com (2603:10b6:610:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 07:15:48 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%8]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 07:15:48 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSBy?=
 =?UTF-8?Q?ace_of_IB_test?=
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
 <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
 <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
 <c5dd6689-1f76-203d-3d1b-fc3dbfe7056a@amd.com>
 <5417fd27-b121-c73a-08da-1fab2cf65cde@gmail.com>
 <042106ac-b55f-351d-cbed-86a08ce60204@amd.com>
 <beb849ee-0cf6-53a0-a563-56400e6cfacc@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <687ec30e-ef63-0b55-8aa1-dbcf4b36f244@amd.com>
Date: Mon, 13 Sep 2021 12:45:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <beb849ee-0cf6-53a0-a563-56400e6cfacc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 07:15:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 568388c9-3d12-4ad7-8d3f-08d976864f6c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53706F26227F50A2EE46CA0997D99@CH0PR12MB5370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Klf7iqwlPAdk7PRXJJX3PINY33M0DCwV4pFwhz0zJIIhVFkXTcAW9+JRINCfAUGaTBAe0KCvA9TJpoBmvebk2KqpvmMyALgc7akxGjHy8oY4XmGZl6fuVXqWzuUwKtVtRjvATIqkzwD1DYsB1jnCCuoNK2mxmBULYF8VNJngjEzpnTOjsouLQDryeP+r9RVFQTHpjKf+xkKcK1ZGeuZfHYkmDKKHCLmbZO8byzMSCDYboYhw9ehi1ILEEJUgbQSGFyqt8zKLxl7lQN0P/yy9iOEP6xXtS1+An/UvxHV5zvP+WtXN8jO3rrbclHiqsg5mCUzbAP+XphipjMgnF9tbd8t/W2fPxww2bspZpfbHfjzXpFQaPTMsnPTG5iwI0JEwQRpeDgUgtuGXXitja4uwqZIe7V3ZFeQDD2Vvt6Tvc4z13+3Mpd9uGUomdYChU9av82Be3KGUGm8KoTVHLiio/5u6J5/cc4WxxhqeRw3MFWa5CDRe05NTe6pD3RlIpAN9F5EoGsHzWTX4+IdYocaEvT1M8YIl5Dz6LHjcgoNGp9ekmA7LRaTtJu+EIexatfNMEftOR9Uvi31rqfYvspBZ/cPk/ykncfqnwR1T5k4VFO4F47eYaD6T8/Bh7OPuHmeSJSCedKENmQJOtxkVE1wqw+4DW83ZNBG0CJU+Tb6cvFXQU892fn88W1btt7DimUm2XsKxOPrxgRtDoouGC3PHOeWBoAzYNKqcjqyfZYtLJxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(478600001)(316002)(6486002)(8936002)(66556008)(5660300002)(110136005)(38100700002)(31686004)(31696002)(2906002)(53546011)(86362001)(4326008)(2616005)(83380400001)(66574015)(956004)(186003)(26005)(6666004)(36756003)(66476007)(16576012)(224303003)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUs0QUVLaDVySHVLNzJFNUQvN3c5RTVIdHJ0eUJVeEl1anEycURjcHFKeHF4?=
 =?utf-8?B?RDFZZjA1NzQ4MnZDcXlKcUpBbWNQaENCR1o2TEViOHZIOUdrLzhQdERtS3ln?=
 =?utf-8?B?OW9lMXlMdnp5WTgwQ3Uwem9KOVVHUmc5RlM3M0YvNjhmclNKU2ZDbW4wamxN?=
 =?utf-8?B?a2pjQkdpdUk5RlBUYzZPa2FHNEpoKy9oSUlEcVhvS1RjZFNkWjhMU3o0WThS?=
 =?utf-8?B?aUhlRlNITURFbTducDg2cmc3VjNEcDUrUVpqZ0k0b29jekozZzVuY1NOWW45?=
 =?utf-8?B?eVdGSjFrcmRzUWNnbjlWZE1aZFZCMHVTemp5WHNXZjJxYjZ0V3gxc0dsY3lU?=
 =?utf-8?B?Nkd2TnZPZkgveEU0SWJCcnU4Mzd6VzQrQU9Rc0FFdzlGWThsYm5CdWkvTmo2?=
 =?utf-8?B?bkN4UU5kUzhPb1EzSWQ4bTQvSm0yWnppMDl4eXk1TU1WTHhzZnVxVytNOHdY?=
 =?utf-8?B?VVJuS3ZzOW1jbkpFY0hNbHVqODhXTE05SnJ4QnYwbnZUYkt2emt4cmNmZ0Vt?=
 =?utf-8?B?emJ4OUNubUVpTWFFWXNZOSsycmRqYVpraTk5SGdza3p6UTh3eFBvY1Y3MlNh?=
 =?utf-8?B?bUp0bElHbzhnUllCazhUMFVKRlVpV29oTk00VG5LczFTKytWRVZsWFpNd3Ux?=
 =?utf-8?B?NGFDeTZuOTVJdDBjdmRreEtuR1NsVEtlMlh3aDVnZHliMDhOQVNScmZ2SUUr?=
 =?utf-8?B?U3U4UllwUXlFZStBaHZaQ3RoWGczZEZIdzVUUkZDOXZUTkR0TWN1NmRZNzJB?=
 =?utf-8?B?OXh4WHRzNjc3SDZzUjViSjhaV2lJS3YwVUJZYXUxeVpjQTFRS2NDOHpGOXpF?=
 =?utf-8?B?NzNpZFladEpDeUp4NVhvb0lMeTFvN21XRi91U0JmYnNmRmVLTUd4OU50Zllp?=
 =?utf-8?B?NmtBZ29pM1RSM2ZKRllXNlBvYi9ZRTVXR3RWV3BwMGJFMklPTWhIQi9RR1lP?=
 =?utf-8?B?RmpxUDBHVDZtWitMK2FkV2lvMjZTdEFCSlNVM3crMDQ3MUdCdGwyZjB3ZlN0?=
 =?utf-8?B?L3Z6MVg3NjRJQmhUZG01eUpRcUtKM2J5RmhRMjhwQWFJcUU3UUVPNmtXY21H?=
 =?utf-8?B?VHphR0IwVUJDYzFWV096UkRlbnluNnNjS2NYcHVNT0tVN3gxVlRoaHEvU09V?=
 =?utf-8?B?dDUrbUg4NmkvNERUeXYyT0ZFTHZYSW1abXM1ZzZtSWdZVlFGaGE1bXBoSENY?=
 =?utf-8?B?eUg4WnRzcDdaa0gxQlB4bnBoQTJKaFRjakx4WlVxRzBMYitsVDR1N1E1dnVL?=
 =?utf-8?B?Z3drdW92MFEwRmtRaFhQckFwWGhiRXpydlFiYTJlM1FkOWRiS0R3T1pQb2ND?=
 =?utf-8?B?Vm5YbjFLZEpXM1lpbUFFM3ZweG1Wb2cwRmRsTHBGRkppSnNTa3NrL2NQbkdx?=
 =?utf-8?B?clM3MEpWVFllQ1loMldQSVd6REgrT2FvU1NzWWNBZUhXYldVWWlvWUhyaU41?=
 =?utf-8?B?Z1RqOWF3U1NtSU42cFM0YUNuTzZabnFBakJldFFxQnBBVkpITCtKVkpDYm1P?=
 =?utf-8?B?MEc5aE8xM2hiMHRic083ZElQQWJ4UkZpK2hPYmZzZURsUjdRZ1hubEE2dWlO?=
 =?utf-8?B?SjVUL2I0MWdHWlB6ZEw0YnRCOFpPb1poWDY0c1ZrR2FpVFcvMXRwUlUwN3Qz?=
 =?utf-8?B?ZHBjcjM2TmpFc3NnV00xeXBtL1NRS0d0SUNFck5ZaGZFcWNMWm44eGZBajlF?=
 =?utf-8?B?L2tMTnZGUFpCVjJBVUlxclhiNjZPcnhlWFVZZmhWSUliWEYxbU1BQXhaYUs5?=
 =?utf-8?Q?Qblt6/oGKA8U9Mw0ZNivW3xklaXAnEcTD7Lyxzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568388c9-3d12-4ad7-8d3f-08d976864f6c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 07:15:48.1159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObW1Uwh1byXDl3eHBBbCnWqNE7HZtFhPcNLfgcqz1ViSGaJb59s0/y3cXl+7nKzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370
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



On 9/13/2021 12:21 PM, Christian König wrote:
> Keep in mind that we don't try to avoid contention here. The goal is 
> rather to have as few locks as possible to avoid the extra overhead in 
> the hot path.
> 
> Contention is completely irrelevant for the debug and device reset since 
> that are rarely occurring events and performance doesn't matter for them.
> 
> It is perfectly reasonable to take the write side of the reset lock as 
> necessary when we need to make sure that we don't have concurrent device 
> access.

The original code has down_read which gave the impression that there is 
some protection to avoid access during reset. Basically would like to 
avoid this as a precedence for this sort of usage for any debugfs call. 
Reset semaphore is supposed to be a 'protect all' thing and provides a 
shortcut.

BTW, question about a hypothetical case - what happens if the test 
itself causes a hang and need to trigger a reset? Will there be chance 
for the lock to be released (whether a submit call will hang 
indefinitely) for the actual reset to be executed?

Thanks,
Lijo

> 
> Regards,
> Christian.
> 
> Am 13.09.21 um 08:43 schrieb Lazar, Lijo:
>> There are other interfaces to emulate the exact reset process, or 
>> atleast this is not the one we are using for doing any sort of reset 
>> through debugfs.
>>
>> In any case, the expectation is reset thread takes the write side of 
>> the lock and it's already done somewhere else.
>>
>> Reset semaphore is supposed to protect the device from concurrent 
>> access (any sort of resource usage is thus protected by default). Then 
>> the same logic can be applied for any other call and that is not a 
>> reasonable ask.
>>
>> Thanks,
>> Lijo
>>
>> On 9/13/2021 12:07 PM, Christian König wrote:
>>> That's complete nonsense.
>>>
>>> The debugfs interface emulates parts of the reset procedure for 
>>> testing and we absolutely need to take the same locks as the reset to 
>>> avoid corruption of the involved objects.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 13.09.21 um 08:25 schrieb Lazar, Lijo:
>>>> This is a debugfs interface and adding another writer contention in 
>>>> debugfs over an actual reset is lazy fix. This shouldn't be executed 
>>>> in the first place and should not take precedence over any reset.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>
>>>> On 9/13/2021 11:52 AM, Christian König wrote:
>>>>> NAK, this is not the lazy way to fix it at all.
>>>>>
>>>>> The reset semaphore protects the scheduler and ring objects from 
>>>>> concurrent modification, so taking the write side of it is 
>>>>> perfectly valid here.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>> yep, that is a lazy way to fix it.
>>>>>>
>>>>>> I am thinking of adding one amdgpu_ring.direct_access_mutex before 
>>>>>> we issue test_ib on each ring.
>>>>>> ________________________________________
>>>>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> 发送时间: 2021年9月13日 12:00
>>>>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>>>>> 抄送: Deucher, Alexander; Koenig, Christian
>>>>>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>>>>>> Direct IB submission should be exclusive. So use write lock.
>>>>>>>
>>>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> index 19323b4cce7b..be5d12ed3db1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> @@ -1358,7 +1358,7 @@ static int 
>>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>>        }
>>>>>>>
>>>>>>>        /* Avoid accidently unparking the sched thread during GPU 
>>>>>>> reset */
>>>>>>> -     r = down_read_killable(&adev->reset_sem);
>>>>>>> +     r = down_write_killable(&adev->reset_sem);
>>>>>> There are many ioctls and debugfs calls which takes this lock and 
>>>>>> as you
>>>>>> know the purpose is to avoid them while there is a reset. The 
>>>>>> purpose is
>>>>>> *not to* fix any concurrency issues those calls themselves have
>>>>>> otherwise and fixing those concurrency issues this way is just 
>>>>>> lazy and
>>>>>> not acceptable.
>>>>>>
>>>>>> This will take away any fairness given to the writer in this rw 
>>>>>> lock and
>>>>>> that is supposed to be the reset thread.
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>        if (r)
>>>>>>>                return r;
>>>>>>>
>>>>>>> @@ -1387,7 +1387,7 @@ static int 
>>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>>                kthread_unpark(ring->sched.thread);
>>>>>>>        }
>>>>>>>
>>>>>>> -     up_read(&adev->reset_sem);
>>>>>>> +     up_write(&adev->reset_sem);
>>>>>>>
>>>>>>>        pm_runtime_mark_last_busy(dev->dev);
>>>>>>>        pm_runtime_put_autosuspend(dev->dev);
>>>>>>>
>>>>>
>>>
> 
