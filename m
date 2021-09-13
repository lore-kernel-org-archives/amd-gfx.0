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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 13:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44E661B6F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 13:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D44E661B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6F689BF5;
	Mon, 13 Sep 2021 13:50:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9D989BF5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 13:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e06bHa6abzE4NbpfcxBTq1xNfXnpCRb2K21kHMx7H8wRZZDa6JUSd5jG0k2Ia+TYiBS/kcCyb2C8bmfvJOKhNyfIXrI+ustMEnTkNcMj7ZvanENKkObBMHKAlj8/pDJrBaUQebbox2/acUjmn+IPnJNOrCnhOl2vgGARwCPd1rmt6MOOa2mo9yXiNkVQ9LDy0QvhZ4eJAUZwktcFXaUQeHNvySmea+0vEy9GTvm7citeDGUIDfw5J8hEjZAKMlKWmth0PMUiMliAYPE/Ovjo2MVYqB+jMRtUyflAYqesp+IlT6pQm4sTGSlCzhJlsH8eoDaK1vDp0KNJOyZmtRmNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vrQBMjK064dVVVq7Djv7ArRW0Uda696s1ipMEh/oUCI=;
 b=jfvbM3i+oOe5j4As5MzMKm/edCk/qo73sFj6Bn3zevUrd5qqVwoCoSfiKpWQkJC9o+rUtmOtbTX/fm+ADHhAzb1R9Nurt8FLy4DhE/xbI5LzJF7nBDCkD4oHZVdZxS80MJBmM2+iwmMBgAfKDfAAndScI+/wU2b030+duS11uqZmfi9nys124Ko6BZJwwHflees55ckz7g0shUksCqly8r/3c1M6WgKm9m04p0J9BoGiGLqYwtM58QgjBpnLg/OJC0xcuqGykKitPWmsXU3/bNbWGCFsauLwUhdFnRXH4BrFMpPO9eMtytN+QGFZhEPhRF0lZ/xzZnCDzCkpFCndHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrQBMjK064dVVVq7Djv7ArRW0Uda696s1ipMEh/oUCI=;
 b=AIV14732WpPWJceavrEyOObNDaCGDP899UG8ZlKnBWMqIBnuIRssnuGOxJkooIqpsM1+wR3Td5IEDsu3GZdOIuDzC6LBY60XOsOI6UbNeFF7Yb/oQ9gESdy2zKZUo4a179zV1k9GV8aJv2uUUXiICiDMxNbkYEhYc7OxhUasQ6g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 13:50:32 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%8]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 13:50:31 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6?=
 =?UTF-8?Q?_Fix_a_race_of_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
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
 <687ec30e-ef63-0b55-8aa1-dbcf4b36f244@amd.com>
 <DM4PR12MB51658EF37C6518E0F166DAF787D99@DM4PR12MB5165.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <49d5a097-2ea3-4984-c6cc-3df6af338a5b@amd.com>
Date: Mon, 13 Sep 2021 19:20:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB51658EF37C6518E0F166DAF787D99@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::28) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 13:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f4ba93-ed0c-46ad-6125-08d976bd73ad
X-MS-TrafficTypeDiagnostic: CH0PR12MB5315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53155EA7A9E35319A29767ED97D99@CH0PR12MB5315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIDC4h+utBFzF2nZ4jFUKjUN+z83/S9/lfwwGdodjeFXrY5B/x9BZfxEZrHnnEGHQz45utIv5j4FOqyKGM8o+yxZpXBR+PBrpJhsHWZ0EXj9CDXos6165RqCW7e9wNOEHLAXkToYOrBVbYCGs1tB3rT2BYeXnjrsStBoDSpiM2HyBxNB3tZ/cKFWB2bRDYd5S8MhU002ZfSwZDcsFwSbwJgPpSGil3ICl/DzuB9he9gQryTGhHIHvCqNpEOnTx7ppSO9tC2nmyMk2FsDgZ7Auow4CfqkqcYxxRFxuYYSg0p7LVdCVNwelsq9Q42LRiBvRXY+YRMw8OJUN05pUF8F4LzCHFaVK5178zjz6JA/18/+mPmODUuj5E2Ss6jaSduGd3eY/rX53vyJbW7n1YlTQBLySy+OpT6ZwBVJOmO8pcmxUaCSwgUVPF6qMzPrMSXdnOBcOHGMn6MmG+Jg5Q+spe+PiXVRKXvcSmbX6+P4vP4tLebPVgjtUr6gjD1SPu2YtfBzVlOT4gx6baYgDtiAAATIGayHIThWNtIXOPYm2oD3KPps/mhQb3GC+r+kzrOjE1kC5B1HWrG4TZByFHXHthwu6Bg9vPpACvdOxS+Ef8nUiVU6Q2zfUpIdotLLB/o7TTvTgV97Yn2nZtalNpNAcXirO6HX9cLCOT4JhnefFPdjnVvrjNBVR5RmASC0iQoqh7llCLFYfqH6bb781kseXEhvYR/RTbxVsy2f2oQHLSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(53546011)(6486002)(83380400001)(66574015)(186003)(5660300002)(36756003)(956004)(2616005)(224303003)(110136005)(66556008)(2906002)(478600001)(8936002)(31686004)(31696002)(316002)(66946007)(26005)(4326008)(66476007)(86362001)(16576012)(38100700002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHA3NUZuZlJLczBDeGdwMHhjdzFPV2ZQNmhnQkcwNkJvbXdMTFFzcnJlbVdi?=
 =?utf-8?B?Rk0vKzAzaUxsN3N6RkFONUV5aGUzM1hzWVJsSy91a2ttQ2lweitBb285QWFn?=
 =?utf-8?B?ODVnYWxuTUdCZmlxS3VvdU1WSjNLYmVreVZXWGVuSHVhNUFWN0JCekVHNkF4?=
 =?utf-8?B?bjZlbW9GbGJuaWI3SXZDNVEwVnBkMi8rWGxMcHA5UDN3emdBODJQUnlUNXFr?=
 =?utf-8?B?S0ZFdmxFUVRlS3ZUaUVaTituSTFibDdxSzJOc0hPNldKbU9HSWN3c3dMSkRY?=
 =?utf-8?B?bDN5c1RpajdGUkhWNDFEbWgzWGZBMWY2eEFQRFZIdUNNZW1oeGlxYmhNZFhW?=
 =?utf-8?B?QjF1SEZjamNDUytLRjc2NFNSbVltRW00UmxjMVkycDRoeCttTVFBMmpTTnBr?=
 =?utf-8?B?Vnk3Smh5MnRRRy85RUx2bEJuczRrZmhJWUk3MVkyQXJhMkg5dmQ2U1Y3VHdT?=
 =?utf-8?B?VzlpU08rNFhvUFFNeEswYVpDUnFOZU9vOWw5T1lwTGFGL29mS3A4NDF2RFRL?=
 =?utf-8?B?RktaOGFHWEtTb2FKZk9PaWVDVkZMakY0ZWRwdGU0eERaMFgvTEVuYkhPWU9T?=
 =?utf-8?B?QUtPbE5Lb2o1S3dkbGQvajV5QlNDUzA3NzRFL3d4Y00wS2JFejQ1TXBpdHpE?=
 =?utf-8?B?cG1iRnMrNTBuTmpkMXJWdllCejNPTUFEY0lTQVhZczFlcWJ3TFQ4bmVtNk41?=
 =?utf-8?B?K2Nzc3RCWCt5OWVEUzhoZVF3ckJ2L1hZUUd0MGE0VUJ2Z0w0ZWROZ3pWa2tS?=
 =?utf-8?B?TDUzckxDa1BnRjJQNzVrMmhlRkVLd2dMYUJOTTl4alhWL1dIMnlMejQvUEZY?=
 =?utf-8?B?NFdEdVY0S1oxSmt3QUFReG5mbTdnb0xIM1hEb1Q0c25QcUQ5dlRMMTNDMVJY?=
 =?utf-8?B?WkhvNHoyaFR1OVVJYVY1U1U2Z2dwTDkwczVpazVOYzdzcHRtMTdJOVVpdDBt?=
 =?utf-8?B?UUtWaUlyQitZNHZ0Q3QyUGJ5M2hTS3Q0eTFsZ0pDYzV1enhmZDV1ekVoSEtN?=
 =?utf-8?B?RmFGVWYrWVE1RHVjeHZXN2RvYjY5eTFTY3dKTGpRd2hxa1k0NVRGZ1VId0xM?=
 =?utf-8?B?bkMvTnpPK3lVMXpVT1BHTlBxNnJTcE1YQW1xbDRGdFNES08zcThEaTZkMmJt?=
 =?utf-8?B?cHUwTWZEZDVxUG5QV3ltcTZlZWFmL05RR2E0c2RQVEM1eXltMGp1SzJmOE80?=
 =?utf-8?B?MXRhb0VWMVZKaHdvamh2WFZkL0xPWnBzQU9sRk1OakprYjN2Z1JMekQwZ0Uz?=
 =?utf-8?B?UzNTQmxjRWNhN2tCN2hEbkJUMCtwS0tOM05reHlDRE5VU29XUW1XNHlYTk9p?=
 =?utf-8?B?RGRLOCtST1RkQ05DSUdGdVN6Z1B0SER4OHRLdGRZOTRBeHFya2xXcnQ4YkRq?=
 =?utf-8?B?dHlFTjdzMTZZRzArMjZLSDl3b0xhVmJOUUxXZ2IyTThwZHFPaTc4TXo2elpv?=
 =?utf-8?B?cUI2ZFYyZzZaRHV2YVFxVnU2TERBYnJBODN1anFsWjhiSWkxeXREVEJIWFJ1?=
 =?utf-8?B?V0dkYy9ZUTdxcWhCZVkxYUk1L3J3MUI3SWJsYTBDdHpyUHNPN3RPR3Ezc0lJ?=
 =?utf-8?B?bXJTL1Bxa1BxcnFSVmNWQytnM0VGQnRNVHNCd0EzY29kdmFMOTV3NVBTTUlQ?=
 =?utf-8?B?clNvNHhZUDFJcUVobG5aVzcxLzBkZFIzNCtSMVRSL2w3V0gvWTNpa0kxVmtG?=
 =?utf-8?B?NVdhbG5XUXFSQnEycDVXS3RMeGpTdmpQV3hWK2l5alNlc2N2VUZEbDhjM3dB?=
 =?utf-8?Q?MiJjttzWCnQckEzZ7JEjtwGhTw+vLBauwszTcMN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f4ba93-ed0c-46ad-6125-08d976bd73ad
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:50:31.7039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl25xvh+WUngIPi92/sKoB6l4DypHRTO1T7/esICs3cegZAQndvk4HURXggUn9Zt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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

Thanks for the clarification Xinhui.

Based on Christian's explanation, what I understood is - this is an 
exceptional case in debugfs calls and the other goal is to avoid 
maintenance of one more lock just to support this API. I no longer have 
any issues with this approach.

Thanks,
Lijo

On 9/13/2021 12:53 PM, Pan, Xinhui wrote:
> [AMD Official Use Only]
> 
> Of source IB test can hang the GPU.
> But it wait fence with one specific timeout. and it not depends on gpu scheduler.
> So IB test must can return.
> 
> ________________________________________
> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
> 发送时间: 2021年9月13日 15:15
> 收件人: Christian König; Koenig, Christian; Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: 回复: [PATCH v2] drm/amdgpu: Fix a race of IB test
> 
> 
> 
> On 9/13/2021 12:21 PM, Christian König wrote:
>> Keep in mind that we don't try to avoid contention here. The goal is
>> rather to have as few locks as possible to avoid the extra overhead in
>> the hot path.
>>
>> Contention is completely irrelevant for the debug and device reset since
>> that are rarely occurring events and performance doesn't matter for them.
>>
>> It is perfectly reasonable to take the write side of the reset lock as
>> necessary when we need to make sure that we don't have concurrent device
>> access.
> 
> The original code has down_read which gave the impression that there is
> some protection to avoid access during reset. Basically would like to
> avoid this as a precedence for this sort of usage for any debugfs call.
> Reset semaphore is supposed to be a 'protect all' thing and provides a
> shortcut.
> 
> BTW, question about a hypothetical case - what happens if the test
> itself causes a hang and need to trigger a reset? Will there be chance
> for the lock to be released (whether a submit call will hang
> indefinitely) for the actual reset to be executed?
> 
> Thanks,
> Lijo
> 
>>
>> Regards,
>> Christian.
>>
>> Am 13.09.21 um 08:43 schrieb Lazar, Lijo:
>>> There are other interfaces to emulate the exact reset process, or
>>> atleast this is not the one we are using for doing any sort of reset
>>> through debugfs.
>>>
>>> In any case, the expectation is reset thread takes the write side of
>>> the lock and it's already done somewhere else.
>>>
>>> Reset semaphore is supposed to protect the device from concurrent
>>> access (any sort of resource usage is thus protected by default). Then
>>> the same logic can be applied for any other call and that is not a
>>> reasonable ask.
>>>
>>> Thanks,
>>> Lijo
>>>
>>> On 9/13/2021 12:07 PM, Christian König wrote:
>>>> That's complete nonsense.
>>>>
>>>> The debugfs interface emulates parts of the reset procedure for
>>>> testing and we absolutely need to take the same locks as the reset to
>>>> avoid corruption of the involved objects.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 13.09.21 um 08:25 schrieb Lazar, Lijo:
>>>>> This is a debugfs interface and adding another writer contention in
>>>>> debugfs over an actual reset is lazy fix. This shouldn't be executed
>>>>> in the first place and should not take precedence over any reset.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>
>>>>> On 9/13/2021 11:52 AM, Christian König wrote:
>>>>>> NAK, this is not the lazy way to fix it at all.
>>>>>>
>>>>>> The reset semaphore protects the scheduler and ring objects from
>>>>>> concurrent modification, so taking the write side of it is
>>>>>> perfectly valid here.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>>>>>>> [AMD Official Use Only]
>>>>>>>
>>>>>>> yep, that is a lazy way to fix it.
>>>>>>>
>>>>>>> I am thinking of adding one amdgpu_ring.direct_access_mutex before
>>>>>>> we issue test_ib on each ring.
>>>>>>> ________________________________________
>>>>>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> 发送时间: 2021年9月13日 12:00
>>>>>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>>>>>> 抄送: Deucher, Alexander; Koenig, Christian
>>>>>>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>>>>>>> Direct IB submission should be exclusive. So use write lock.
>>>>>>>>
>>>>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> index 19323b4cce7b..be5d12ed3db1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> @@ -1358,7 +1358,7 @@ static int
>>>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>>>         }
>>>>>>>>
>>>>>>>>         /* Avoid accidently unparking the sched thread during GPU
>>>>>>>> reset */
>>>>>>>> -     r = down_read_killable(&adev->reset_sem);
>>>>>>>> +     r = down_write_killable(&adev->reset_sem);
>>>>>>> There are many ioctls and debugfs calls which takes this lock and
>>>>>>> as you
>>>>>>> know the purpose is to avoid them while there is a reset. The
>>>>>>> purpose is
>>>>>>> *not to* fix any concurrency issues those calls themselves have
>>>>>>> otherwise and fixing those concurrency issues this way is just
>>>>>>> lazy and
>>>>>>> not acceptable.
>>>>>>>
>>>>>>> This will take away any fairness given to the writer in this rw
>>>>>>> lock and
>>>>>>> that is supposed to be the reset thread.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>         if (r)
>>>>>>>>                 return r;
>>>>>>>>
>>>>>>>> @@ -1387,7 +1387,7 @@ static int
>>>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>>>                 kthread_unpark(ring->sched.thread);
>>>>>>>>         }
>>>>>>>>
>>>>>>>> -     up_read(&adev->reset_sem);
>>>>>>>> +     up_write(&adev->reset_sem);
>>>>>>>>
>>>>>>>>         pm_runtime_mark_last_busy(dev->dev);
>>>>>>>>         pm_runtime_put_autosuspend(dev->dev);
>>>>>>>>
>>>>>>
>>>>
>>
