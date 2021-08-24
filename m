Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA5C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 07:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F816115A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 07:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81F816115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EE389B96;
	Tue, 24 Aug 2021 07:24:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6052F89B69
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 07:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYjhw+SIOFY7Em3dkqRMzP2BXSnM8P5xDGejUchFvyxAvy2tePol+W6jw6JXXF8e8ViwxZA4HCJpIzdpcemuJTb3izFCrb3oD/tzTmeVyGPjdKrleofNEFj4zVkZEqoT/ytUQtfFtNJlWS3szTXiLmudMczCsbT4vSBLe0n1AwZTXp33iunhIF6BqdWIkUs7ZWqR8Vp283hbAiPJzxzxTE0c1n9XT13012UBWKmQOnSvSR8g3JAciKBdhZ3h3mvgFZkf4oxU8lcosI12Dyuz7cSOXFvLawXA/llO44SndwTKP1QEclDzJHC3FROWVKMdOIJZmWnC7l52iiveVRYpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOSxA1L9uNm8pHFp8AVA7GZOqMmVPgIAGE8+JSaKHFs=;
 b=i9Fa++xQE1SV0RUWgDzMOFr0o5vxJaMwCQ+SDMgedzDETCMnrIolr0tZ/k7gHty4IXFJTotcbhY3DMm+FBc+cy1m47/8WtPL/mlljfyTiMwhNRHlQp9dsDgYhCRVZL9TTL5Q3y3Jvw+iZiY+dPFD8LBhDE1rfaphzJa+IhPhrBAEL/AESyA2Rv0Q2Gct2R5CSFPEjHUXEU3SdmnvvoNtv/lXn5v8oBPOLt4+5bsN11LDOVdsHq4/QBitLTKA/RF+4qxLF6TMe7g+sLBGaGfILMqeriKSYy+Pc3I+adNDTd1pESepyaFZqoNgc9u3Cg8NIWsI/owH7Ndwc1zP9Vew4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOSxA1L9uNm8pHFp8AVA7GZOqMmVPgIAGE8+JSaKHFs=;
 b=QECiE0KkKZaWc/QPIuxhAXjJFaGzFlge0obYODm1Vqi+xLZopPTsn97ILPPFJ7orVXsrWF7hpKnIdUvAYtn09v/KH2K+6cFNyM0D5JmaQJKvlohQYebq8g8oiIe2be8OEoQ9agkfGL9hmb1LQfFa9Cj+RaCt0+DqBzmDyNWrbJE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 07:24:04 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 07:24:04 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
 <6f77bb91-4ee1-3aaf-3ed8-cbccfdbcc0e5@amd.com>
 <6ef290ca-e79f-c2a2-539e-b5d2a5eb9b02@amd.com>
 <adff087c-ad28-b827-ad56-b1fb3b2dd50f@amd.com>
 <SN1PR12MB2382647752D0EFFAFC25E788F9C59@SN1PR12MB2382.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <fde6bb6f-2306-df84-0da4-4e7b30b27c4c@amd.com>
Date: Tue, 24 Aug 2021 12:53:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <SN1PR12MB2382647752D0EFFAFC25E788F9C59@SN1PR12MB2382.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::11)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 07:24:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c8091b-0684-4c39-aac7-08d966d026ee
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5507BA91203AE5A1D6317BA597C59@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkK0EOlMhWdtf/32SUji1FiYeiLil/Hke7bXvBoHW1D82wnBt2U3KoQMS0C1MZbprLd9E3ToouStctSvNAV2sssT8LMFSH82BejGkmfBWnitAQsXrhiH8lRoe5Cf7w23460t0fsxZKW6t1G9ko3UXRNCK8xSoxyvVa5fSfDXe27ucxO+i5jVjWgbUZwGe5EDTTcltvuk6czaxolCiQR6XxeCWcSjI398zY7SSjt8JooXIJKyGQ0tnArxHK4Z4E7No1i/r7qsl7wa6edQ3+uKFa5Sy1t4AqiE8G+vFd2PGbXX/aEmRDYjcrUzE4Mza2cDmG/aQhkdBf5Z26vvh4Kxjrp4dE7Xp+RolEU4hBZpyDImdSUvIj+JF+2oucDR/A0QDqlV7lgfcHdoNSrtgpsf1cnh91tnCg4WjzP94OlrMEYyX0Dgo311rqnDQHtZDvhApOn6iMs80/cwRf60xHEQwFO2ovXwV1Wl+fWMCXzipfhyzzufJlUlAfhvRMNYIQ6oUP6C66bKZ6tQ0sfkGWjYD51zbfafktYBYbwx6bMYmeUzxQjpylRqNj2qkbM/HlNAhU36dtoZO/YdOtzbZpixQV1FfnJKbeEgHJOW8yvjRGpvGbz4BjyNol623x8nRRmlO0syZ9Q9dvyFmv1DrQ6F66Mfuv/GJBY9lt+/HXQjyoDolz1IlPFC7FOFBseQu2BIvi02DxXF1utmjNLEbtEk//8YkDA1v/RcEkbgSuiJmVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(66476007)(2616005)(8936002)(66946007)(16576012)(66556008)(316002)(83380400001)(30864003)(2906002)(53546011)(5660300002)(86362001)(110136005)(8676002)(31696002)(26005)(6486002)(38100700002)(956004)(31686004)(186003)(6666004)(36756003)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS85dEw1c1BwOXJJZDV0bGdVamJKQWhxdG0rc1g0cjVvL01tYk9tbElrSVBp?=
 =?utf-8?B?UlJ3blQzYzQzb3U0aDM3cVdqUzU0ejZwVHdxbFdzVVNwdXUrdjEva0QrL2Uv?=
 =?utf-8?B?L1dPSG9nVXVpcG0vbjA0RzI0VEtuT2I4dmZ3THc3eVpqdFZxRlRkdzJ5emxD?=
 =?utf-8?B?eWpjUXAzL0p6bTZTR2tMTStNVEVEK3o4eXlneVFMTnJMM1p0c0lGVWVsaDFG?=
 =?utf-8?B?cGkxeXAzTDlBdjNwNWZ1TTcxZWY1MUpXTzA2WVVyYVhIclBhOGxWNE96QjlQ?=
 =?utf-8?B?cjJiQzFjdGxZdXhZZzVDK3AyZHg3VU5JaW5VU0dkRGFqYjRmNDFpWnkxWHky?=
 =?utf-8?B?SW5hVUZiY282c3RGUS9mNGRjZktoN0FQbzFDei95ZllqOS9vVG1wOU9QNThG?=
 =?utf-8?B?UXhRWFZGdXdWSkpMZzJKZ04wdmtWSFZ6VXh3UStoMUxoZEM0RWNSaklOc2NO?=
 =?utf-8?B?UnhNOHIwc0U4ZVNJNUhkN1hMU0d4THpzazhaVnVOaVlYK2ZuWG9zSVdPaUR1?=
 =?utf-8?B?b2tZVC9xUVlpd0pjQVZNRHV2L3h3QlRHczhCVjI3T20ya2N5WDlFSHdKUnpy?=
 =?utf-8?B?TnJkdXFJTWRQUnNNMmVGU20vbG9wdHRBVFFULzRMbHBuai9oRFp4Q3ExaHNq?=
 =?utf-8?B?VDJmU2cwQkhubGt6YnlqZzAwc3F4ajd6Ym4yOWZnZWJBN3VlbFFFbnRieTdh?=
 =?utf-8?B?NGtDaCtXcW5weC9yYlZvbGg0SzZNQkQxVis0ZU5ZYkxFV2pNdGVuTDZjd0J3?=
 =?utf-8?B?bTVnQ3M0TTg2U2p2VzBXcVlqei95L2hYU1F0V2psZkRZMDRKR3ZDbGtuOVV5?=
 =?utf-8?B?MlkrNjRLek92OEpIa0xwRko1VjJiK2dNdThzWDNncmt3aCtObU9nV09pVnpy?=
 =?utf-8?B?OVU2ODNlYkhYdE1SbnRjaUZBcEJlQ1I2TlRvakk4MGphaWw0MDFyR1pNK1NI?=
 =?utf-8?B?bzVqZC9HSmR5T2d4VmFJT2hKdldvZkR2c082ZGdNTXZMemdnUHF4US9mRmc4?=
 =?utf-8?B?UGhUdW1iL2ZPdTJvSW5zbWpKbUh1SFZSZUM3QUhtZHBiaXNBT0JRNHdsRVUr?=
 =?utf-8?B?OGIwYWF3S0FVeGo5QS8vL2pDL0FlMDVvcDdUQ3M3VEVzajNkdXE0SzFVOTdH?=
 =?utf-8?B?UHp5RlhvVzNCV0FyUmo1OFhIZWZxb1MxRHM5NXhlNG81aURtaGs0N21Ra2Jt?=
 =?utf-8?B?bDZmNWR0dmNWV2dlYUFHa1NqQjNhMHNrQktuZUJoa1E4TmNmRTdpTy9MVHIy?=
 =?utf-8?B?VVRmQ1JZUUt4dVhEa0d2cWxnQ1JZcnVhMnV6Uk9ESDVVZk9GeitIVUw2Z21X?=
 =?utf-8?B?MkdZMDRaRmVRazhURzNiNzFtR2lpSDN0dmdnOXVEaURHWU5KeUZwWGk0Mm9y?=
 =?utf-8?B?TWZtUTQ4YzBFS1pITU1nOFB6WWhXNDJ3ekhVY2tuMG56dmNpVncrVm1HQm8z?=
 =?utf-8?B?RURkRml2SXNqaFpTVGJRd3RzR0krQ1dTSnNENndnV3lSeURIdUViQ0tqak4z?=
 =?utf-8?B?NDY5SXBhZHRpT2dlWDVOWE1WUXRTZkFFY0t2bUE5ZUVPUWNGOTlFZC9aS2I1?=
 =?utf-8?B?bGx1cDRxaU9sMTZYSDllaFJZNjFUT09FM0VWTG1GWlJGR0FOU21yQUhFNUwz?=
 =?utf-8?B?UGJJUitiU00renE5WWFBT1hKTkZSRG5MZ2ZkQmdadC9tbDdXd0hIdTZId3p0?=
 =?utf-8?B?bG54Mk1Hak5XaWlid0FLRFFQMGZhZ2xFWHVvbnBzWjNZR3RLZUNvYmp3Qmg4?=
 =?utf-8?Q?xZYVe621f3Zt4k8b2JpBO9wzX5gmcBD1yF8lO/Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c8091b-0684-4c39-aac7-08d966d026ee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 07:24:04.5148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJWQxj8LH3mMgnG0N1llr6Wqh32w5CndGIi9qPmjLjpAUVfQlyaMSOUB4ETqpj+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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



On 8/24/2021 12:19 PM, Greathouse, Joseph wrote:
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, August 23, 2021 11:37 PM
>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
>>
>> On 8/23/2021 10:34 PM, Felix Kuehling wrote:
>>> Am 2021-08-23 um 3:08 a.m. schrieb Lazar, Lijo:
>>>>
>>>>
>>>> On 8/20/2021 11:02 AM, Joseph Greathouse wrote:
>>>>> Give every process at most one queue from each SDMA engine.
>>>>> Previously, we allocated all SDMA engines and queues on a first-
>>>>> come-first-serve basis. This meant that it was possible for two
>>>>> processes racing on their allocation requests to each end up with
>>>>> two queues on the same SDMA engine. That could serialize the
>>>>> performance of commands to different queues.
>>>>>
>>>>> This new mechanism allows each process at most a single queue
>>>>> on each SDMA engine. Processes will check for queue availability on
>>>>> SDMA engine 0, then 1, then 2, etc. and only allocate on that
>>>>> engine if there is an available queue slot. If there are no
>>>>> queue slots available (or if this process has already allocated
>>>>> a queue on this engine), it moves on and tries the next engine.
>>>>>
>>>>> The Aldebaran chip has a small quirk that SDMA0 should only be
>>>>> used by the very first allocation from each process. It is OK to
>>>>> use any other SDMA engine at any time, but after the first SDMA
>>>>> allocation request from a process, the resulting engine must
>>>>> be from SDMA1 or above. This patch handles this case as well.
>>>>>
>>>>> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>>>>> ---
>>>>>     .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
>>>>>     3 files changed, 107 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> index f8fce9d05f50..86bdb765f350 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> @@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct
>>>>> device_queue_manager *dqm,
>>>>>     static int map_queues_cpsch(struct device_queue_manager *dqm);
>>>>>       static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>>>>> +                struct qcm_process_device *qpd,
>>>>>                     struct queue *q);
>>>>>       static inline void deallocate_hqd(struct device_queue_manager *dqm,
>>>>>                     struct queue *q);
>>>>>     static int allocate_hqd(struct device_queue_manager *dqm, struct
>>>>> queue *q);
>>>>>     static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>>>> +                struct qcm_process_device *qpd,
>>>>>                     struct queue *q);
>>>>>     static void kfd_process_hw_exception(struct work_struct *work);
>>>>>     @@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct
>>>>> device_queue_manager *dqm,
>>>>>                 q->pipe, q->queue);
>>>>>         } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>             q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>> -        retval = allocate_sdma_queue(dqm, q);
>>>>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>>>>             if (retval)
>>>>>                 goto deallocate_vmid;
>>>>>             dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
>>>>> @@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct
>>>>> device_queue_manager *dqm,
>>>>>             deallocate_hqd(dqm, q);
>>>>>         else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>             q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>     deallocate_vmid:
>>>>>         if (list_empty(&qpd->queues_list))
>>>>>             deallocate_vmid(dqm, qpd, q);
>>>>> @@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct
>>>>> device_queue_manager *dqm,
>>>>>         if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>>>>             deallocate_hqd(dqm, q);
>>>>>         else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>         else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>         else {
>>>>>             pr_debug("q->properties.type %d is invalid\n",
>>>>>                     q->properties.type);
>>>>> @@ -1039,42 +1041,93 @@ static void pre_reset(struct
>>>>> device_queue_manager *dqm)
>>>>>         dqm_unlock(dqm);
>>>>>     }
>>>>>     +static uint64_t sdma_engine_mask(int engine, int num_engines)
>>>>
>>>> Looks more like the queue mask for an engine, the name doesn't make it
>>>> clear.
>>>>
>>>>> +{
>>>>> +    uint64_t mask = 0;
>>>>> +
>>>>> +    engine %= num_engines;
>>>>> +    while (engine < (sizeof(uint64_t)*8)) {
>>>>> +        mask |= 1ULL << engine;
>>>>> +        engine += num_engines;
>>>>> +    }
>>>>> +    return mask;
>>>>> +}
>>>>> +
>>>>>     static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>>>> +                struct qcm_process_device *qpd,
>>>>>                     struct queue *q)
>>>>>     {
>>>>> -    int bit;
>>>>> +    uint64_t available_queue_bitmap;
>>>>> +    unsigned int bit, engine, num_engines;
>>>>> +    bool found_sdma = false;
>>>>>           if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>>>> -        if (dqm->sdma_bitmap == 0) {
>>>>
>>>> This is still a valid optimization and no need to loop through if
>>>> nothing is available anyway. Valid for XGMI loop also.
>>>>
>>>>> +        num_engines = get_num_sdma_engines(dqm);
>>>>> +        for_each_set_bit(engine, &(qpd->sdma_engine_bitmap),
>>>>> num_engines) {
>>>>
>>>> Probably a naive question -
>>>>
>>>> Theoretically there are 8 queues per engine as per the mask code. In
>>>> the below code, there is an assumption that a process will use at best
>>>> number of queues=max num of sdma engines or xgmi engines
>>>> simultaneously. Is that true always? For ex: there are 2 sdma engines
>>>> and 4 queues per engine. Can't multiple threads of a process initiate
>>>> multiple sdma transactions > number of sdma engines available? This
>>>> code limits that, but I don't know if that is a possible case.
>>>
>>> When you use multiple SDMA queues on the same engine, the work from the
>>> queues gets serialized. You can either let the SDMA engine serialize
>>> work from multiple queues, or let ROCr serialize work from multiple
>>> threads on the same SDMA queue. There is no obvious benefit to let the
>>> SDMA engine do it. But there is a drawback: Fewer processes get to use SDMA.
>>>
>>
>> The fact that there exists multiple queues and there is no such
>> assumption made in existing logic (prior to the patch) tells that there
>> is indeed some advantage of making use of hardware queues. For ex:
>> switching to different ring buffer may not need context save/resubmission.
>>
>> Just like different processes, different threads of same process may
>> take advantage of multiple queues. More interested to see the impact in
>> cases where the focus is on single process ex: impact on running some
>> benchmarks or in HPC where entire hardware is dedicated for a specific
>> compute purpose.
>   
> Each engine has multiple user-mode queues because we expect to see multiple processes sharing the device at the same time. The internal datasheets from the hardware team strongly suggest using one user-mode queue per engine per process.
> 
> With that in mind, the ROCr user-mode runtime attempts to create, at most, one queue per SDMA engine within each process. For instance, ROCr creates one queue for H->D transfers and one queue for D->H transfers. We want these queues to be on different engines so that we can get full-duplex PCIe transfers. If both queues are on the same engine, the engine will serialize the transfers (because it can only work on one command at a time), and we will get half-duplex.
> 
> The queue allocation algorithm that this patch replaces could accidentally yield two queues on the same engine. If Process A allocates its first queue, it would receive sdma0_queue0. Process B could then allocate its first queue, and get sdma1_queue0. Then Process A could allocate its second queue and get sdma0_queue1. This would yield undesirable and unexpected serialization between H->D and D->H transfers in Process A. In addition, I believe the old algorithm would allow an uncooperative process to allocate all SDMA queues to itself. Looking at the git history, I believe the old allocator is basically the same as the initial KFD SDMA allocator built for Kaveri. I'm confident we've learned more about how multiple processes should share our GPUs since then. :)
> 
> To your last point: even if we have different threads in the same process submitting transfer requests, the ROCr runtime within the process will submit all like transfers (e.g. all H->D transfers) into the same queue. Submitting those same commands into different queues on the same engine will not yield any clear performance benefit since the engine will serialize the commands.  And it will likely yield some performance loss due to queue-switching overheads in the engine. I think this patch yields a more fair allocation mechanism (e.g., no process can starve out other processes by taking all the queues on all engines), and it also more closely match what user-space expects (e.g., different SDMA queues can run commands in parallel).
> 

Thanks Joe for providing more info related to ROCr.

One other thing is - seems the process will keep waiting for the second 
queue (assuming first is still in use) to be alloted always on a 
separate engine. In the example cited above, do you expect a case where 
sdma1 queues are all full and Process A has to wait till a sdma1 queue 
is free even though there is a free queue available in sdma0 (by virtue 
of long/short jobs submitted earlier by other processes). Is that 
situation managed by ROCr? Or, as worst case allocate on sdma0 itself if 
nothing is available on other engines? Rather than going in any order, 
maybe another way is to order engines based on max free queues and give 
preference to the first engine not actively used by the process.

Thanks,
Lijo

> And thanks for the code suggestions up above, I will make those changes as requested.
> 
> Thanks!
> -Joe
> 
>> Thanks,
>> Lijo
>>
>>> Regards,
>>>     Felix
>>>
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +            /* Do not reuse SDMA0 for any subsequent SDMA queue
>>>>> +             * requests on Aldebaran. If SDMA0's queues are all
>>>>> +             * full, then this process should never use SDMA0
>>>>> +             * for any further requests
>>>>> +             */
>>>>> +            if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>>>>> +                    engine == 0)
>>>>> +                qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>>>>> +
>>>>> +            available_queue_bitmap = sdma_engine_mask(engine,
>>>>> num_engines);
>>>>> +            available_queue_bitmap &= dqm->sdma_bitmap;
>>>>> +
>>>>> +            if (!available_queue_bitmap)
>>>>> +                continue;
>>>>> +            /* Take the selected engine off the list so we will not
>>>>> +             * allocate two queues onto the same engine
>>>>> +             */
>>>>> +            qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>>>>> +            found_sdma = true;
>>>>> +
>>>>> +            bit = __ffs64(available_queue_bitmap);
>>>>> +            dqm->sdma_bitmap &= ~(1ULL << bit);
>>>>> +            q->sdma_id = bit;
>>>>> +            q->properties.sdma_engine_id = q->sdma_id % num_engines;
>>>>> +            q->properties.sdma_queue_id = q->sdma_id / num_engines;
>>>>> +            break;
>>>>> +        }
>>>>> +        if (!found_sdma) {
>>>>>                 pr_err("No more SDMA queue to allocate\n");
>>>>>                 return -ENOMEM;
>>>>>             }
>>>>> -
>>>>> -        bit = __ffs64(dqm->sdma_bitmap);
>>>>> -        dqm->sdma_bitmap &= ~(1ULL << bit);
>>>>> -        q->sdma_id = bit;
>>>>> -        q->properties.sdma_engine_id = q->sdma_id %
>>>>> -                get_num_sdma_engines(dqm);
>>>>> -        q->properties.sdma_queue_id = q->sdma_id /
>>>>> -                get_num_sdma_engines(dqm);
>>>>>         } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>> -        if (dqm->xgmi_sdma_bitmap == 0) {
>>>>> +        num_engines = get_num_xgmi_sdma_engines(dqm);
>>>>> +        for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap),
>>>>> num_engines) {
>>>>> +            available_queue_bitmap = sdma_engine_mask(engine,
>>>>> num_engines);
>>>>> +            available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
>>>>> +
>>>>> +            if (!available_queue_bitmap)
>>>>> +                continue;
>>>>> +            /* Take the selected engine off the list so we will not
>>>>> +             * allocate two queues onto the same engine
>>>>> +             */
>>>>> +            qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
>>>>> +            found_sdma = true;
>>>>> +
>>>>> +            bit = __ffs64(available_queue_bitmap);
>>>>> +            dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>>>>> +            q->sdma_id = bit;
>>>>> +            /* sdma_engine_id is sdma id including
>>>>> +             * both PCIe-optimized SDMAs and XGMI-
>>>>> +             * optimized SDMAs. The calculation below
>>>>> +             * assumes the first N engines are always
>>>>> +             * PCIe-optimized ones
>>>>> +             */
>>>>> +            q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>>>>> +                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>>>>> +            q->properties.sdma_queue_id = q->sdma_id /
>>>>> +                get_num_xgmi_sdma_engines(dqm);
>>>>> +            break;
>>>>> +        }
>>>>> +        if (!found_sdma) {
>>>>>                 pr_err("No more XGMI SDMA queue to allocate\n");
>>>>>                 return -ENOMEM;
>>>>>             }
>>>>> -        bit = __ffs64(dqm->xgmi_sdma_bitmap);
>>>>> -        dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>>>>> -        q->sdma_id = bit;
>>>>> -        /* sdma_engine_id is sdma id including
>>>>> -         * both PCIe-optimized SDMAs and XGMI-
>>>>> -         * optimized SDMAs. The calculation below
>>>>> -         * assumes the first N engines are always
>>>>> -         * PCIe-optimized ones
>>>>> -         */
>>>>> -        q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>>>>> -                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>>>>> -        q->properties.sdma_queue_id = q->sdma_id /
>>>>> -                get_num_xgmi_sdma_engines(dqm);
>>>>>         }
>>>>>           pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
>>>>> @@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct
>>>>> device_queue_manager *dqm,
>>>>>     }
>>>>>       static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>>>>> +                struct qcm_process_device *qpd,
>>>>>                     struct queue *q)
>>>>>     {
>>>>> +    uint32_t engine = q->properties.sdma_engine_id;
>>>>> +
>>>>>         if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>>>>             if (q->sdma_id >= get_num_sdma_queues(dqm))
>>>>>                 return;
>>>>>             dqm->sdma_bitmap |= (1ULL << q->sdma_id);
>>>>> +        /* Don't give SDMA0 back to be reallocated on Aldebaran.
>>>>> +         * It is only OK to use this engine from the first allocation
>>>>> +         * within a process.
>>>>> +         */
>>>>> +        if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>>>>> +                    engine == 0))
>>>>> +            qpd->sdma_engine_bitmap |= (1ULL << engine);
>>>>> +
>>>>>         } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>             if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>>>>>                 return;
>>>>>             dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
>>>>> +        /* engine ID in the queue properties is the global engine ID.
>>>>> +         * The XGMI engine bitmap ignores the PCIe-optimized engines.
>>>>> +         */
>>>>> +        engine -= get_num_sdma_engines(dqm);
>>>>> +        qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
>>>>>         }
>>>>>     }
>>>>>     @@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct
>>>>> device_queue_manager *dqm, struct queue *q,
>>>>>         if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>             q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>             dqm_lock(dqm);
>>>>> -        retval = allocate_sdma_queue(dqm, q);
>>>>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>>>>             dqm_unlock(dqm);
>>>>>             if (retval)
>>>>>                 goto out;
>>>>> @@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct
>>>>> device_queue_manager *dqm, struct queue *q,
>>>>>         if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>             q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>             dqm_lock(dqm);
>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>             dqm_unlock(dqm);
>>>>>         }
>>>>>     out:
>>>>> @@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct
>>>>> device_queue_manager *dqm,
>>>>>           if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>>>>             (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>             pdd->sdma_past_activity_counter += sdma_val;
>>>>>         }
>>>>>     @@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct
>>>>> device_queue_manager *dqm,
>>>>>         /* Clear all user mode queues */
>>>>>         list_for_each_entry(q, &qpd->queues_list, list) {
>>>>>             if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>>>>> -            deallocate_sdma_queue(dqm, q);
>>>>> +            deallocate_sdma_queue(dqm, qpd, q);
>>>>>             else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>> -            deallocate_sdma_queue(dqm, q);
>>>>> +            deallocate_sdma_queue(dqm, qpd, q);
>>>>>               if (q->properties.is_active) {
>>>>>                 decrement_queue_count(dqm, q->properties.type);
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index ab83b0de6b22..c38eebc9db4d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -576,6 +576,8 @@ struct qcm_process_device {
>>>>>         struct list_head priv_queue_list;
>>>>>           unsigned int queue_count;
>>>>> +    unsigned long sdma_engine_bitmap;
>>>>> +    unsigned long xgmi_sdma_engine_bitmap;
>>>>>         unsigned int vmid;
>>>>>         bool is_debug;
>>>>>         unsigned int evicted; /* eviction counter, 0=active */
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index 21ec8a18cad2..13c85624bf7d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -1422,6 +1422,7 @@ struct kfd_process_device
>>>>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>>>>                                 struct kfd_process *p)
>>>>>     {
>>>>>         struct kfd_process_device *pdd = NULL;
>>>>> +    const struct kfd_device_info *dev_info =
>>>>> dev->dqm->dev->device_info;
>>>>>           if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
>>>>>             return NULL;
>>>>> @@ -1446,6 +1447,8 @@ struct kfd_process_device
>>>>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>>>>         pdd->qpd.pqm = &p->pqm;
>>>>>         pdd->qpd.evicted = 0;
>>>>>         pdd->qpd.mapped_gws_queue = false;
>>>>> +    pdd->qpd.sdma_engine_bitmap =
>>>>> BIT_ULL(dev_info->num_sdma_engines) - 1;
>>>>> +    pdd->qpd.xgmi_sdma_engine_bitmap =
>>>>> BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
>>>>>         pdd->process = p;
>>>>>         pdd->bound = PDD_UNBOUND;
>>>>>         pdd->already_dequeued = false;
>>>>>
