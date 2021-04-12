Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF2C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 17:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F304A6124C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 17:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F304A6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951B889CB2;
	Mon, 12 Apr 2021 17:44:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABA789CB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 17:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhzdKGAGQ3eFu6WCP3lhg+OlwGmr1Ny3zFWdBjcWsJ2jtuJ8IwAlFz9xyNLMInhmKN/7teHwllRZN+2N5/zWgrbDm5efMxq3H2XytShXs17YJpTDgB4v6atg3IGOraQmMXj8zZy8aN/3n5o+NGF6SY3o0GLNouOI7NcytMlBiO5F4X0bqO+dQsXWNrBzWyfU8kNqhHlcN5tF8j7w4WxSI273rvZoRoe3N8MPXbODeOnzgiWd8raO1K5OyTO31wfvFfcADJ+OLEVfadZAlPLNJjYGm04WddZTGMBMnMxhrbR34pcR9nPfpfiM5MPMcNq9Zu3YkE3GfkCX/Io6Yq7GgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4yc+G9uhAPVO+bVSWFrl2caK3yGg4r8AWOeEQCMrXQ=;
 b=oAuz9PYRJO/Yl65kPxlrLIVwiVcyUqf5SSOumbc5mhWQSUU5JXait3NgzhP+F7424uO6EH4z5SpVeBPhLed1x0ovTpfJYLeKg/In+gGx1AN6HD6WucylIZvto0OAu/yrQyio4owEEHw9vJvmh8i8MAOghkBCAR+mIV+UgttZXfiGsx88dOngTQztHXMD7vvNrDIM2MdI5eI3AunSAIxqTFua++yf7somzJyFr3IOyfzfiS2VFyGS2uSMw4Dvq94z51Hl6gt0AvNRYFo6qfR6JG+RVwB4+S1+AMUEXS6TZX8g1+Im0e8bQQH8ln2m0iPTqEOBySl1GYVV++YILJAwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4yc+G9uhAPVO+bVSWFrl2caK3yGg4r8AWOeEQCMrXQ=;
 b=2TO5Ygkf84e6G08HEHUmI7DYxKu6m3gaV1kqKFyBgOWLTgcTVkyRBiQCwM3aKb5m8P/p0LyQs3ktl3OxLq2gOfK92p4OlTZquvjaS/OXeNBf5rlKmG47m+juavVq+Pht2NokAO3KFCQRJxmXfdsoWY1tzVaROsxpw6uRgjWvucI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4605.namprd12.prod.outlook.com (2603:10b6:208:3d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 17:44:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:44:52 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
Date: Mon, 12 Apr 2021 19:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c]
X-ClientProxiedBy: PR2P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c]
 (2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c) by
 PR2P264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 17:44:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b08b8870-f87d-4c4e-8a8a-08d8fddaacc5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB460556A590581A54D5C532E783709@MN2PR12MB4605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IUTTfPUAXZ5AWFYOmSc1Nmb2ci0j3vbWVbOSs+rvhg836ZbctO6qi0OIRUSiZjz+jiJWCtRrY4pJCeKoWV3Nu1fb3hTnNTpqdqrVwxZoFSk/sudZdhuGuUtz2Q/zdKxiD7OU3rd8p5qmLMcPDZlBPUr6HRgb5zMepk/GCztDxudL2yvWpHBs1EPdM7sOUONZ1CQS6OXdW+t4Z8ZJiZTF1T7leYg2EnsyhkSXxUc6uSNpvcHTY8ECR09k3xGd3/iEE+QO9kmhbRsbxEoqPFH7rN0t/HLQOHIVDrzX39iDkAXY7y26tMrv59x/OxpaOVcvKbmphZlhHEc40UwfKlT1qm3FvszYNTrexVxgEknjJPa5vGbPvMfGUoJJOcN+mj8Bp7UfTD15UiBLX/5eEgtfd9AplAPLOMMoVKuZa2DFO61o5XAZHDxIyaFkbCFQycmSUpUGd9jc0KmC5QqUzon+oBddrvf+ipicrLMHKPh4C2wDPWEAPXMi2nEz3AR0TL33y3Q9KBL6Eu4+JAVb86eHs7zrOdk5rmfneMfmGeGkEed7tXMrgdBF6yfiiq61BvLOsFIJEEKi9UUilFrlMqMIbVPyRGjx1ppJf/pQx79Hb2iDt4RgO7MB/ZzfzjurfB8nc+DYK4H67IbvrwbzlZp2gX14QXQMvjvQcwasEn7V30j8C120ZD+ehW8nMC8M57Wt27bQ2QwAUj7MASS4sYQ3eqCg2Y+GcPXy8TNkNtLNnTg2FE/3ttzer3yZ+LMg3M5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(5660300002)(30864003)(316002)(6486002)(31696002)(86362001)(110136005)(45080400002)(186003)(66946007)(33964004)(66574015)(53546011)(83380400001)(6636002)(66476007)(52116002)(166002)(38100700002)(921005)(31686004)(36756003)(2906002)(16526019)(66556008)(2616005)(6666004)(8936002)(966005)(8676002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bkM0ZmRDL2pTTTZsQU82M0I3TldhYmFDeHRsRlNSV3NpbFNvLzFoaTZEa2Zp?=
 =?utf-8?B?YmNFSlN5TjdYcVlmcDRkT3NTMnRjeHRUYWMvb01xSDZMYmJSd3VqdFRKdnF1?=
 =?utf-8?B?dm9NcVJpV3dGVlhKdzJZZWp6RHgwaFFEdW43UzdrVVZYYjZwVnViWFRrQ0hm?=
 =?utf-8?B?NGNBQkxURXAyUkM1YlBGTWpKbUxBQmRlcit2R0QwMFBCdG1COHZoMVExUzhn?=
 =?utf-8?B?UW5iMXdlS0h6YVN2R3hKV1NESFFtSmF5OWc4YXN0djZXbkwzQUdVbVBCRXJC?=
 =?utf-8?B?WlowV3g2Qy93dUVaMzhPenZhbSt2ZGMwRUlxVVBsVkU0SThsOVExaXk3c083?=
 =?utf-8?B?V21nZ2VHcWJGd09LWlFESTZhKzY1TkdTaWxFTklOM2YzR1FTTHc1dlF3YlhL?=
 =?utf-8?B?VWN4UGlvS3BHZUQ4SFk5RmFraHpMNHhIYnlIcmJrMHFuVnREZ0FPVVZlSmpz?=
 =?utf-8?B?dStqZVZJblA4QlBpM1V6SXhZQkttWHBuK0Y3SzF4VEN6c2JPUFVSZVhDZERD?=
 =?utf-8?B?emxlMC9LaWFheXFMRFNYSVhuVzlzUXdnb2tlbElqb0N3WnFyRDl0RkJlUTdU?=
 =?utf-8?B?VkRtNUJXZkw1aS9CWFRKN1NoeERUNU9UYjhnZTFUaTFwQ3lXNlgrUkdDZmdq?=
 =?utf-8?B?eWRYT3JHQlgreDVudzhYZE04NVJkeElCa21wTzVGMFZlSmhwSEZ6OUZUc0V6?=
 =?utf-8?B?ZkJnemUrN0xzODBHdmNQdUd3M0pRQzBPLytXazROeENKTUFWUnc0cGJUZ2dS?=
 =?utf-8?B?Y1VtN3Ereko0TGpGd1dIVTFpaU9rNlRUajlYdUVobmF4c3lMK0c3Q1U0eHdi?=
 =?utf-8?B?QTFOS1B0MTlCZ0g3Nmw3TFlDNU5tbDJ6QjRZbWd1UEl1U0lJUVY2RTlaaW5H?=
 =?utf-8?B?NFdQUTVoL3dHdFErUTlBa09MdmFyOXpaeDRXdmErZVA3ZjVUSGxOSXJLaGU1?=
 =?utf-8?B?Q3lWNTBMOS95MlhrSE5LZ0FVajh6a2dZbWYrbUxDc1VmU21OUDFMVGVhejc2?=
 =?utf-8?B?d2tvSTNRN2RKR2hIRmY1Zko2ZFFLWVBUTWJoRFBaVDFCWEVQd1Y5cXRQTEJO?=
 =?utf-8?B?YTJWVGFlekU1bHBkZGpqYWxwVWp5NCswbkQrWTFSSkxjRzN1Z2RMQkF5YUc0?=
 =?utf-8?B?cll5RjY2S0xiMTFzSm0xdEFMMzBJQWpsR1QwdVVrYVZVQkZLT3BRODBXMmF1?=
 =?utf-8?B?ODNoY2FZVjdJZnZYc1QwL0pYcFFONDNYRm9aOENBRUVxMG51MFpFcFpXd3ZJ?=
 =?utf-8?B?UnVzMGM1K1dlZHJKc0Y0R2tsVHFsb1psRHpxZ3pFQjZzdTczSFhMcWhOTkpx?=
 =?utf-8?B?bk55Y0F3ZytqUXY4V1BSb1JaYVpaV1NucFJuQTNDcFJLNEdGbkYvL29ET2dl?=
 =?utf-8?B?cFVoS0htT2padVpPazdOUG5XcC9ucXJaTDZuZUtmS00zdnRIUFdlbHVkSk5l?=
 =?utf-8?B?aitwNGF1WEN1YW5mbTQ4ak0yeG1VQlNFNi91MTYrYS9qRFpUSWZuTXJEajJS?=
 =?utf-8?B?dVc5Nmc3OGRJUmVQSzlZUllZZU8zUU5jcHQ2eE1UYXBlN1ZCVWZSVUs3Nm9s?=
 =?utf-8?B?RzJtdDNtU2wrV25ZY2VYN1ArSDRHWW93VXJjd2x2Qy9YbFZ4THl4ZGw4dDIv?=
 =?utf-8?B?cXQyZllnZFdpeUpiU21CdnNWNlMxaGhEZGlGMjNIY3hYTkhEc2hkR001dkY2?=
 =?utf-8?B?bGszYmlTTy9xUURnWUtWaWJsOFZXVUlCZ2RNS2wwSUpyRmtzRXdVNmFKVzRE?=
 =?utf-8?B?STkrM0lXSi9aTVJhd2ZNRDUzMnhyYzRxTlJaUlBtMW55TktrbUJpeHczaThT?=
 =?utf-8?B?ditBVjNDK3dWbDRZVnNxYWJOUkY2YStEc3N1SCtTaEFNd1F1WDdyTGxWNnVD?=
 =?utf-8?Q?OkSOG5pTp7qvm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08b8870-f87d-4c4e-8a8a-08d8fddaacc5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:44:52.1277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMvbq6iwijx0BvKSqN4/TgyIzkeuDUUi3i/U7BT4BAHvzxP/66rgs3WrqXoPSQXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4605
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
Content-Type: multipart/mixed; boundary="===============1359104462=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1359104462==
Content-Type: multipart/alternative;
 boundary="------------2EF8923EF3700BA65F70DB26"
Content-Language: en-US

--------------2EF8923EF3700BA65F70DB26
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:
> On 2021-04-10 1:34 p.m., Christian König wrote:
>> Hi Andrey,
>>
>> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>> [SNIP]
>>>>>
>>>>> If we use a list and a flag called 'emit_allowed' under a lock 
>>>>> such that in amdgpu_fence_emit we lock the list, check the flag 
>>>>> and if true add the new HW fence to list and proceed to HW emition 
>>>>> as normal, otherwise return with -ENODEV. In amdgpu_pci_remove we 
>>>>> take the lock, set the flag to false, and then iterate the list 
>>>>> and force signal it. Will this not prevent any new HW fence 
>>>>> creation from now on from any place trying to do so ?
>>>>
>>>> Way to much overhead. The fence processing is intentionally lock 
>>>> free to avoid cache line bouncing because the IRQ can move from CPU 
>>>> to CPU.
>>>>
>>>> We need something which at least the processing of fences in the 
>>>> interrupt handler doesn't affect at all.
>>>
>>>
>>> As far as I see in the code, amdgpu_fence_emit is only called from 
>>> task context. Also, we can skip this list I proposed and just use 
>>> amdgpu_fence_driver_force_completion for each ring to signal all 
>>> created HW fences.
>>
>> Ah, wait a second this gave me another idea.
>>
>> See amdgpu_fence_driver_force_completion():
>>
>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>>
>> If we change that to something like:
>>
>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>>
>> Not only the currently submitted, but also the next 0x3FFFFFFF fences 
>> will be considered signaled.
>>
>> This basically solves out problem of making sure that new fences are 
>> also signaled without any additional overhead whatsoever.
>
>
> Problem with this is that the act of setting the sync_seq to some MAX 
> value alone is not enough, you actually have to call 
> amdgpu_fence_process to iterate and signal the fences currently stored 
> in ring->fence_drv.fences array and to guarantee that once you done 
> your signalling no more HW fences will be added to that array anymore. 
> I was thinking to do something like bellow:
>

Well we could implement the is_signaled callback once more, but I'm not 
sure if that is a good idea.

> amdgpu_fence_emit()
>
> {
>
>     dma_fence_init(fence);
>
>     srcu_read_lock(amdgpu_unplug_srcu)
>
>     if (!adev->unplug)) {
>
>         seq = ++ring->fence_drv.sync_seq;
>         emit_fence(fence);
>
> */* We can't wait forever as the HW might be gone at any point*/**
>        dma_fence_wait_timeout(old_fence, 5S);*
>

You can pretty much ignore this wait here. It is only as a last resort 
so that we never overwrite the ring buffers.

But it should not have a timeout as far as I can see.

>         ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask] 
> = fence;
>
>     } else {
>
>         dma_fence_set_error(fence, -ENODEV);
>         DMA_fence_signal(fence)
>
>     }
>
>     srcu_read_unlock(amdgpu_unplug_srcu)
>     return fence;
>
> }
>
> amdgpu_pci_remove
>
> {
>
>     adev->unplug = true;
>     synchronize_srcu(amdgpu_unplug_srcu)
>

Well that is just duplicating what drm_dev_unplug() should be doing on a 
different level.

Christian.

>     /* Past this point no more fence are submitted to HW ring and 
> hence we can safely call force signal on all that are currently there.
>      * Any subsequently created  HW fences will be returned signaled 
> with an error code right away
>      */
>
>     for_each_ring(adev)
>         amdgpu_fence_process(ring)
>
>     drm_dev_unplug(dev);
>     Stop schedulers
>     cancel_sync(all timers and queued works);
>     hw_fini
>     unmap_mmio
>
> }
>
>
> Andrey
>
>
>>
>>
>>>
>>>>>>
>>>>>> Alternatively grabbing the reset write side and stopping and then 
>>>>>> restarting the scheduler could work as well.
>>>>>>
>>>>>> Christian.
>>>>>
>>>>>
>>>>> I didn't get the above and I don't see why I need to reuse the GPU 
>>>>> reset rw_lock. I rely on the SRCU unplug flag for unplug. Also, 
>>>>> not clear to me why are we focusing on the scheduler threads, any 
>>>>> code patch to generate HW fences should be covered, so any code 
>>>>> leading to amdgpu_fence_emit needs to be taken into account such 
>>>>> as, direct IB submissions, VM flushes e.t.c
>>>>
>>>> You need to work together with the reset lock anyway, cause a 
>>>> hotplug could run at the same time as a reset.
>>>
>>>
>>> For going my way indeed now I see now that I have to take reset 
>>> write side lock during HW fences signalling in order to protect 
>>> against scheduler/HW fences detachment and reattachment during 
>>> schedulers stop/restart. But if we go with your approach  then 
>>> calling drm_dev_unplug and scoping amdgpu_job_timeout with 
>>> drm_dev_enter/exit should be enough to prevent any concurrent GPU 
>>> resets during unplug. In fact I already do it anyway - 
>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>>
>> Yes, good point as well.
>>
>> Christian.
>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>
>>>> Christian.
>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>


--------------2EF8923EF3700BA65F70DB26
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:<br>
    <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
      
      <div class="moz-cite-prefix">On 2021-04-10 1:34 p.m., Christian
        König wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">Hi
        Andrey, <br>
        <br>
        Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky: <br>
        <blockquote type="cite">[SNIP] <br>
          <blockquote type="cite">
            <blockquote type="cite"> <br>
              If we use a list and a flag called 'emit_allowed' under a
              lock such that in amdgpu_fence_emit we lock the list,
              check the flag and if true add the new HW fence to list
              and proceed to HW emition as normal, otherwise return with
              -ENODEV. In amdgpu_pci_remove we take the lock, set the
              flag to false, and then iterate the list and force signal
              it. Will this not prevent any new HW fence creation from
              now on from any place trying to do so ? <br>
            </blockquote>
            <br>
            Way to much overhead. The fence processing is intentionally
            lock free to avoid cache line bouncing because the IRQ can
            move from CPU to CPU. <br>
            <br>
            We need something which at least the processing of fences in
            the interrupt handler doesn't affect at all. <br>
          </blockquote>
          <br>
          <br>
          As far as I see in the code, amdgpu_fence_emit is only called
          from task context. Also, we can skip this list I proposed and
          just use amdgpu_fence_driver_force_completion for each ring to
          signal all created HW fences. <br>
        </blockquote>
        <br>
        Ah, wait a second this gave me another idea. <br>
        <br>
        See amdgpu_fence_driver_force_completion(): <br>
        <br>
        amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq); <br>
        <br>
        If we change that to something like: <br>
        <br>
        amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq +
        0x3FFFFFFF); <br>
        <br>
        Not only the currently submitted, but also the next 0x3FFFFFFF
        fences will be considered signaled. <br>
        <br>
        This basically solves out problem of making sure that new fences
        are also signaled without any additional overhead whatsoever.</blockquote>
      <p><br>
      </p>
      <p>Problem with this is that the act of setting the sync_seq to
        some MAX value alone is not enough, you actually have to call
        amdgpu_fence_process to iterate and signal the fences currently
        stored in ring-&gt;fence_drv.fences array and to guarantee that
        once you done your signalling no more HW fences will be added to
        that array anymore. I was thinking to do something like bellow:</p>
    </blockquote>
    <br>
    Well we could implement the is_signaled callback once more, but I'm
    not sure if that is a good idea.<br>
    <br>
    <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
      <p>amdgpu_fence_emit()</p>
      <p>{</p>
      <p>&nbsp;&nbsp;&nbsp; dma_fence_init(fence);<br>
      </p>
      <p>&nbsp;&nbsp;&nbsp; srcu_read_lock(amdgpu_unplug_srcu)</p>
      <p>&nbsp;&nbsp;&nbsp; if (!adev-&gt;unplug)) {</p>
      <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq = ++ring-&gt;fence_drv.sync_seq;<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; emit_fence(fence);</p>
      <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW might be gone at
          any point*/</b><b><br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
      </p>
    </blockquote>
    <br>
    You can pretty much ignore this wait here. It is only as a last
    resort so that we never overwrite the ring buffers.<br>
    <br>
    But it should not have a timeout as far as I can see.<br>
    <br>
    <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
      <p> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.fences[seq &amp;
        ring-&gt;fence_drv.num_fences_mask] = fence;<br>
      </p>
      <p>&nbsp;&nbsp;&nbsp; } else {</p>
      <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dma_fence_set_error(fence, -ENODEV);<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DMA_fence_signal(fence) &nbsp;&nbsp; <br>
      </p>
      <p>&nbsp;&nbsp;&nbsp; } &nbsp; <br>
      </p>
      <p>&nbsp;&nbsp;&nbsp; srcu_read_unlock(amdgpu_unplug_srcu)<br>
        &nbsp;&nbsp;&nbsp; return fence;<br>
      </p>
      <p>}</p>
      <p>amdgpu_pci_remove <br>
      </p>
      <p>{</p>
      <p>&nbsp;&nbsp;&nbsp; adev-&gt;unplug = true;<br>
        &nbsp;&nbsp;&nbsp; synchronize_srcu(amdgpu_unplug_srcu) <br>
      </p>
    </blockquote>
    <br>
    Well that is just duplicating what drm_dev_unplug() should be doing
    on a different level.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
      <p>&nbsp;&nbsp;&nbsp; /* Past this point no more fence are submitted to HW ring
        and hence we can safely call force signal on all that are
        currently there. <br>
        &nbsp;&nbsp;&nbsp;&nbsp; * Any subsequently created&nbsp; HW fences will be returned
        signaled with an error code right away <br>
        &nbsp;&nbsp;&nbsp;&nbsp; */<br>
      </p>
      <p>&nbsp;&nbsp;&nbsp; for_each_ring(adev)<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_fence_process(ring)</p>
      <p>&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
        &nbsp;&nbsp;&nbsp; Stop schedulers<br>
        &nbsp;&nbsp;&nbsp; cancel_sync(all timers and queued works);<br>
        &nbsp;&nbsp;&nbsp; hw_fini<br>
        &nbsp;&nbsp;&nbsp; unmap_mmio<br>
      </p>
      <p>}</p>
      <p><br>
      </p>
      <p>Andrey</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com"> <br>
        <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite"> <br>
                Alternatively grabbing the reset write side and stopping
                and then restarting the scheduler could work as well. <br>
                <br>
                Christian. <br>
              </blockquote>
              <br>
              <br>
              I didn't get the above and I don't see why I need to reuse
              the GPU reset rw_lock. I rely on the SRCU unplug flag for
              unplug. Also, not clear to me why are we focusing on the
              scheduler threads, any code patch to generate HW fences
              should be covered, so any code leading to
              amdgpu_fence_emit needs to be taken into account such as,
              direct IB submissions, VM flushes e.t.c <br>
            </blockquote>
            <br>
            You need to work together with the reset lock anyway, cause
            a hotplug could run at the same time as a reset. <br>
          </blockquote>
          <br>
          <br>
          For going my way indeed now I see now that I have to take
          reset write side lock during HW fences signalling in order to
          protect against scheduler/HW fences detachment and
          reattachment during schedulers stop/restart. But if we go with
          your approach&nbsp; then calling drm_dev_unplug and scoping
          amdgpu_job_timeout with drm_dev_enter/exit should be enough to
          prevent any concurrent GPU resets during unplug. In fact I
          already do it anyway -
          <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
 iLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0</a><br>
        </blockquote>
        <br>
        Yes, good point as well. <br>
        <br>
        Christian. <br>
        <br>
        <blockquote type="cite"> <br>
          Andrey <br>
          <br>
          <br>
          <blockquote type="cite"> <br>
            <br>
            Christian. <br>
            <br>
            <blockquote type="cite"> <br>
              Andrey <br>
              <br>
              <br>
              <blockquote type="cite"> <br>
                <blockquote type="cite"> <br>
                  Christian. <br>
                  <br>
                  <blockquote type="cite"> <br>
                    Andrey <br>
                    <br>
                    <br>
                    <blockquote type="cite"> <br>
                      <blockquote type="cite">Andrey <br>
                        <br>
                        <br>
                      </blockquote>
                      <br>
                    </blockquote>
                  </blockquote>
                  <br>
                </blockquote>
                <br>
              </blockquote>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------2EF8923EF3700BA65F70DB26--

--===============1359104462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1359104462==--
