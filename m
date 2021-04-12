Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28580C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 19:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C986061357
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 19:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C986061357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6668B89286;
	Mon, 12 Apr 2021 19:13:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D5889DC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 19:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHUoC5cMiBWi3buq9l97anMtjDaqW5khsxZzqmkAy+nxsmEhdlUsRd40bO70nc9J4eV2F1NDAYBcWkTgbd7VMMbrdMt0FPsknLjXvH/opaeKXV4B5/CPWinfetDbCG4aYWROHvKncii3YqbeCK6STTAxC2pYSgtX8R/XiE40vh9Au2uHYqOHfMavJFkNsc/rkeJmOEmlJS5ZoFyPX3YvFuvCMGPfqp2YKJN5sqmq5uWoFSD/p+/K7uX0gipPHNB50AS18RA1+/7a5xDZ5pXDeSdr18x6iBjhJIkrxvb7+3DfodnnPIA0mkzZPWPZM4I3TsVBbOUZI8EedKrGKs1Stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gCg17Gkl+ovpEbkGmR8uqoqvbzAoPMJxSnHfdrnjko=;
 b=SxOMNIplT9lZliJLw+BE8ZKb4EazIy78ewkKvW/MXfC/05u1uSWgizgGcwWo50yPy1Wd4O4+T8kuBuN+JZQT3r1vwASLCRdOwdS4e4XhNPvEzKmInC2U41Z1l9Mu+mTSgMVM/6InuM3e57DfmULW2b4tfugC4WMayFT7GHAZx6f+MdjEIlazh5evg4wSzaBY0bmxgxV07g9kbTidt3LIZwQmleibnubsT7t4ybVQY8+eblau8+rMQve/u7q5ouL50I8+h/85+jE6KNdZDLIPNzu5QUGa1BkFHFHup3g5UOnr4A3lVwAil7FcOWbfDJJm8+A8HkhVzrn4BRV+XBcUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gCg17Gkl+ovpEbkGmR8uqoqvbzAoPMJxSnHfdrnjko=;
 b=K93CifecyGjmg9YY145mDXgB6kefdKEh1UL/pM/r34brySxl7NdqZO780B3QQ9i8wkS3mZpA2VJZgq/vzfAKx27JT57IoTZyvtc9eO2l4pq4OsmAHg8XsJUVsqwhWneUWQJbdqPi/2fwd6/Q/QWVyOORbzntfLtVwG/bDgl2o7A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 19:13:01 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 19:13:01 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
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
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
Date: Mon, 12 Apr 2021 15:12:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
X-ClientProxiedBy: YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::35) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
 (2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5) by
 YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22 via Frontend
 Transport; Mon, 12 Apr 2021 19:13:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f17ade-9e05-4bb0-6c4a-08d8fde6fd5c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542DE20496135992D50632BEA709@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wUapA2mQwBZuHqpOrbl0gXjI97cBO4rbadIyHw9m7yA4xccRdf0H46HJbH7pqYDvv1aT61nNLhyxi9XOXlNrsEFrzclsd0jroIy21P5nqNFiszx6qqr3NkyMhqyOdUqmFVaRUHYZteHZrkzlsHvzAhN1F8gLPeMlndIfkfgLRAfNBMLSsMdd7VF830dRufSJxWBWSSOSaEeAjIr4A6Nu1e84To0e7LLjRWAn8easEbhhuIX5ijPjPNAGQC4Qwjm59la4c1OWWco/IO7dqopyoVUSEVwLVjHKo1bsJ9TvQghjPqk0q64JzvewbRFRwv/kl+K8w23D8Bfyh+p3bBNz2qVblGtKhfoeS6g3/VsbbIXHYEsY3j+cK2pKqJ/2Fqidu4/ZeK9QZ2XRkA/9gHlvbaCUWtaz6/5TSM39FInnHEyijcLty6SxzRYCfFbSvJPj/+WOHioNE/JY/ehchS5pFUdpRLeD+L5ZPUUTItAnzmubzzZjod4K8XNa/eOy0OzIqoxA9ftY44ISZjUYfztK1N4ZBIBKpjcASMj8FyBH0XNV6GHF2WOzD5leHyPlY6RiUODXG9IfoKb+Hj19B+NiPC77CLiQ2rGqGPBTd4iKzmy/4XhEq5IZ4bxLjW/rqQztleiNTvwi2hoCoBYfa6kqpAqKMz/DTBDW9wJ6IexXVhNxlA2QsvlNe3YDOZ09XuKEKKbFsQmaNxR0IRvb46ROPGtbNZl7y4tImT4A/BD1iXq3dro0sjUfNOh4L1YyhVcO4iPbrgp1cuP1ovCULUeug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(6486002)(33964004)(52116002)(5660300002)(966005)(16526019)(36756003)(44832011)(2616005)(110136005)(66574015)(166002)(45080400002)(31686004)(316002)(8936002)(66476007)(66556008)(66946007)(30864003)(31696002)(186003)(8676002)(83380400001)(478600001)(86362001)(53546011)(38100700002)(921005)(2906002)(6636002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eEF5dHMrTFMzbjVSZFY0NVBDdUM4SDcxUVYrN3ZtMFN1SHQ1bVRUajB2eWFy?=
 =?utf-8?B?NGZ0WG9kdnMxTFB2UnRNeGdOaUpSVEFoRnJOQ3p5YjN6c25VcEozcWFhNUY2?=
 =?utf-8?B?SjhNRlpaYkhUdnFUVUJPV3hsTzQ0SXJIMjZVaFF3bWFDcVUzSVltUnRKeU9T?=
 =?utf-8?B?ZTFBVE0zWXlmTWhYTjJOR3J2bHlCN3hONlBheXM2RHRKSWVvV2ZVSXlrTUto?=
 =?utf-8?B?MitnQlVWcU9LSW9KUFdVaDN3TVlndHJZYmxIMmhHUEN0YVcrbmNna0cwN0FL?=
 =?utf-8?B?bndxYUtBWlFDTW50elhBREUzSkVHWE1nSWFpRFhSVTROK2FFQjNsaHpTaDFp?=
 =?utf-8?B?cFBzNm0zVlJoY2hvUDlEVWcrQmJoT2l0b2VIZjB4THFJUUFZQmdGeXdNRThm?=
 =?utf-8?B?VVZNWElCUkE0ZVB2bGRyRUJJNDZieitYaXEzUkhkbXBRTUI2K21COTlQR3lW?=
 =?utf-8?B?WjZOUFVZZVFzRVhZZndIWnZuN3pQemRaWGNnK2cxS0dDam1RenlKZytsR1RY?=
 =?utf-8?B?WkNJb0ZUNlR1RzlWRElZRVpHN0RoczRVOW13UUZXVXgydXlibEZWMWFWRmpk?=
 =?utf-8?B?aU93dy85TUlXbXpTTEVPRk9iditmOUhQd1VMQ1lablEvUHplbXZjcTBWRk9M?=
 =?utf-8?B?ZFJpVXlYdVVCYTdnZ0JWSjZTeVF6ZGJ2YWxiMWJjSk03ME1CV1pVU2RJanQr?=
 =?utf-8?B?ZXFYaW41NDRYcnpCWmE2UFJzaXcxeEF0cFJKMUw1TjUwWWpEWkpwSC9HbVUr?=
 =?utf-8?B?MXFSQ0NWZWRTQTVjN3lMa0RVRWExZnVKd2RwSHJiejBiSk9aQzFwd01mSmd5?=
 =?utf-8?B?dlZUTFlFOEJxckFxVldocjVoVi9VcDBsekdRL2V6RUJMQWpqTlRwWTlzWjdr?=
 =?utf-8?B?NGR3RlNyR2I0a2FCdjlUTHV1ZUlOSW5ueVQzeHd4Rmw4bjM2NDU4WWJRYVE3?=
 =?utf-8?B?VzZVVzJiZjN4NE4vakRTTUEzTElWbGpjRmxFWit6N1ZseHRhbUR4V1QrOE9o?=
 =?utf-8?B?YjVNRFgyU3l2VFgxeWdub1VsM0lOUzA4dDdreXM1M1lTeEt1dVhIbllNMldR?=
 =?utf-8?B?aHRQcWk0NXhrSTE1Q2tHVW9zTE9kWXFMQ3BQK0FlUVFNRkRlbXk3UUxYRGlW?=
 =?utf-8?B?TVdGMFBYQXpWSitGZGoreVZ1V2IzV2x6WGk1bkh4YmJZOFFwY0tkb3R0aGZt?=
 =?utf-8?B?ZUVCMWxDc1Zaa0M4TElneTlDQkxnNlRra2syb1lhUWUvOXEvNWNHcUQ2enI0?=
 =?utf-8?B?ZTE2Y2R0VGdTUG5FbkJOb1g0TFpWUUNEcmQ5TkxWRkpjOEZQbXBvUjdFclFh?=
 =?utf-8?B?TXc1SkJESjRxQVV4MDN5UXdVRVZQM3BWVHhNc25XM2tQUDlMVGZRUG5mYTlt?=
 =?utf-8?B?SXJmTHlDYTZKeGNHSjRUN1JwUFBQQk0xSHR2eUdpUnRDVlhiSm9seGVhVHhS?=
 =?utf-8?B?NTM4eDJiUDhLa0hXZjY4WFZqVTVxVjY3UXRlWFp3eFVKMDQ0UTVxc1BRSVNW?=
 =?utf-8?B?TXZwWmszUHlZVHZ6M25QNXdkUzhqV1dyTU8xbDZOVjdhVlREa25SUERwMHYr?=
 =?utf-8?B?ZVg5VkVCUDBjeEtINkt6bmh2L2tLejdHMnNvYmwydUE4SHNkbU4wR3g2ZFhl?=
 =?utf-8?B?eHU0ekkvL3ViRWtSbXpjb0k2MXloQThRVlI2YmZuQUVqdkVsSW5XMjdhMk03?=
 =?utf-8?B?SW1CcmJ3M1EyNUppNXpDQnFZUlZYWHV6b3E5RFE5ZDV5UUNCbllFczBqbGhw?=
 =?utf-8?B?Z0tzN05lTkUxOGZBMjhmeWpNYUZIa3doWnU4ZkZJdjMrbFhRVVlnK0NkZTU4?=
 =?utf-8?B?clg5SkZxM2kyeUlQQk9nQkxGSjBPWGN4bXFlRlo3Y3dOd1FuRUI1OHByRjkv?=
 =?utf-8?Q?AE+of++XCjTBh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f17ade-9e05-4bb0-6c4a-08d8fde6fd5c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 19:13:01.1191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZvIb40b6h9zCSG5c8Vi0ZQquJT8GPoB/kX4SYBicsGsS/kl1KqSs1BlpHVzY41vINmPCayMZVaHDJPLz1pgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
Content-Type: multipart/mixed; boundary="===============0445089755=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0445089755==
Content-Type: multipart/alternative;
 boundary="------------4A65C46D0983C891D6E787EB"
Content-Language: en-US

--------------4A65C46D0983C891D6E787EB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-04-12 2:23 p.m., Christian König wrote:
> Am 12.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>
>> On 2021-04-12 2:05 p.m., Christian König wrote:
>>
>>> Am 12.04.21 um 20:01 schrieb Andrey Grodzovsky:
>>>>
>>>> On 2021-04-12 1:44 p.m., Christian König wrote:
>>>>
>>>>>
>>>>> Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:
>>>>>> On 2021-04-10 1:34 p.m., Christian König wrote:
>>>>>>> Hi Andrey,
>>>>>>>
>>>>>>> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>>>>>>> [SNIP]
>>>>>>>>>>
>>>>>>>>>> If we use a list and a flag called 'emit_allowed' under a 
>>>>>>>>>> lock such that in amdgpu_fence_emit we lock the list, check 
>>>>>>>>>> the flag and if true add the new HW fence to list and proceed 
>>>>>>>>>> to HW emition as normal, otherwise return with -ENODEV. In 
>>>>>>>>>> amdgpu_pci_remove we take the lock, set the flag to false, 
>>>>>>>>>> and then iterate the list and force signal it. Will this not 
>>>>>>>>>> prevent any new HW fence creation from now on from any place 
>>>>>>>>>> trying to do so ?
>>>>>>>>>
>>>>>>>>> Way to much overhead. The fence processing is intentionally 
>>>>>>>>> lock free to avoid cache line bouncing because the IRQ can 
>>>>>>>>> move from CPU to CPU.
>>>>>>>>>
>>>>>>>>> We need something which at least the processing of fences in 
>>>>>>>>> the interrupt handler doesn't affect at all.
>>>>>>>>
>>>>>>>>
>>>>>>>> As far as I see in the code, amdgpu_fence_emit is only called 
>>>>>>>> from task context. Also, we can skip this list I proposed and 
>>>>>>>> just use amdgpu_fence_driver_force_completion for each ring to 
>>>>>>>> signal all created HW fences.
>>>>>>>
>>>>>>> Ah, wait a second this gave me another idea.
>>>>>>>
>>>>>>> See amdgpu_fence_driver_force_completion():
>>>>>>>
>>>>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>>>>>>>
>>>>>>> If we change that to something like:
>>>>>>>
>>>>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>>>>>>>
>>>>>>> Not only the currently submitted, but also the next 0x3FFFFFFF 
>>>>>>> fences will be considered signaled.
>>>>>>>
>>>>>>> This basically solves out problem of making sure that new fences 
>>>>>>> are also signaled without any additional overhead whatsoever.
>>>>>>
>>>>>>
>>>>>> Problem with this is that the act of setting the sync_seq to some 
>>>>>> MAX value alone is not enough, you actually have to call 
>>>>>> amdgpu_fence_process to iterate and signal the fences currently 
>>>>>> stored in ring->fence_drv.fences array and to guarantee that once 
>>>>>> you done your signalling no more HW fences will be added to that 
>>>>>> array anymore. I was thinking to do something like bellow:
>>>>>>
>>>>>
>>>>> Well we could implement the is_signaled callback once more, but 
>>>>> I'm not sure if that is a good idea.
>>>>
>>>>
>>>> This indeed could save the explicit signaling I am doing bellow but 
>>>> I also set an error code there which might be helpful to propagate 
>>>> to users
>>>>
>>>>
>>>>>
>>>>>> amdgpu_fence_emit()
>>>>>>
>>>>>> {
>>>>>>
>>>>>>     dma_fence_init(fence);
>>>>>>
>>>>>>     srcu_read_lock(amdgpu_unplug_srcu)
>>>>>>
>>>>>>     if (!adev->unplug)) {
>>>>>>
>>>>>>         seq = ++ring->fence_drv.sync_seq;
>>>>>>         emit_fence(fence);
>>>>>>
>>>>>> */* We can't wait forever as the HW might be gone at any point*/**
>>>>>>        dma_fence_wait_timeout(old_fence, 5S);*
>>>>>>
>>>>>
>>>>> You can pretty much ignore this wait here. It is only as a last 
>>>>> resort so that we never overwrite the ring buffers.
>>>>
>>>>
>>>> If device is present how can I ignore this ?
>>>>
>>
>> I think you missed my question here
>>
>
> Sorry I thought I answered that below.
>
> See this is just the last resort so that we don't need to worry about 
> ring buffer overflows during testing.
>
> We should not get here in practice and if we get here generating a 
> deadlock might actually be the best handling.
>
> The alternative would be to call BUG().
>
>>>>
>>>>>
>>>>> But it should not have a timeout as far as I can see.
>>>>
>>>>
>>>> Without timeout wait the who approach falls apart as I can't call 
>>>> srcu_synchronize on this scope because once device is physically 
>>>> gone the wait here will be forever
>>>>
>>>
>>> Yeah, but this is intentional. The only alternative to avoid 
>>> corruption is to wait with a timeout and call BUG() if that 
>>> triggers. That isn't much better.
>>>
>>>>
>>>>>
>>>>>>         ring->fence_drv.fences[seq & 
>>>>>> ring->fence_drv.num_fences_mask] = fence;
>>>>>>
>>>>>>     } else {
>>>>>>
>>>>>>         dma_fence_set_error(fence, -ENODEV);
>>>>>>         DMA_fence_signal(fence)
>>>>>>
>>>>>>     }
>>>>>>
>>>>>>     srcu_read_unlock(amdgpu_unplug_srcu)
>>>>>>     return fence;
>>>>>>
>>>>>> }
>>>>>>
>>>>>> amdgpu_pci_remove
>>>>>>
>>>>>> {
>>>>>>
>>>>>>     adev->unplug = true;
>>>>>>     synchronize_srcu(amdgpu_unplug_srcu)
>>>>>>
>>>>>
>>>>> Well that is just duplicating what drm_dev_unplug() should be 
>>>>> doing on a different level.
>>>>
>>>>
>>>> drm_dev_unplug is on a much wider scope, for everything in the 
>>>> device including 'flushing' in flight IOCTLs, this deals 
>>>> specifically with the issue of force signalling HW fences
>>>>
>>>
>>> Yeah, but it adds the same overhead as the device srcu.
>>>
>>> Christian.
>>
>>
>> So what's the right approach ? How we guarantee that when running 
>> amdgpu_fence_driver_force_completion we will signal all the HW fences 
>> and not racing against some more fences insertion into that array ?
>>
>
> Well I would still say the best approach would be to insert this 
> between the front end and the backend and not rely on signaling fences 
> while holding the device srcu.


My question is, even now, when we run 
amdgpu_fence_driver_fini_hw->amdgpu_fence_wait_empty or 
amdgpu_fence_driver_fini_hw->amdgpu_fence_driver_force_completion, what 
there prevents a race with another fence being at the same time emitted 
and inserted into the fence array ? Looks like nothing.


>
> BTW: Could it be that the device SRCU protects more than one device 
> and we deadlock because of this?


I haven't actually experienced any deadlock until now but, yes, 
drm_unplug_srcu is defined as static in drm_drv.c and so in the 
presence  of multiple devices from same or different drivers we in fact 
are dependent on all their critical sections i guess.

Andrey


>
> Christian.
>
>> Andrey
>>
>>
>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>>     /* Past this point no more fence are submitted to HW ring and 
>>>>>> hence we can safely call force signal on all that are currently 
>>>>>> there.
>>>>>>      * Any subsequently created  HW fences will be returned 
>>>>>> signaled with an error code right away
>>>>>>      */
>>>>>>
>>>>>>     for_each_ring(adev)
>>>>>>         amdgpu_fence_process(ring)
>>>>>>
>>>>>>     drm_dev_unplug(dev);
>>>>>>     Stop schedulers
>>>>>>     cancel_sync(all timers and queued works);
>>>>>>     hw_fini
>>>>>>     unmap_mmio
>>>>>>
>>>>>> }
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Alternatively grabbing the reset write side and stopping and 
>>>>>>>>>>> then restarting the scheduler could work as well.
>>>>>>>>>>>
>>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I didn't get the above and I don't see why I need to reuse 
>>>>>>>>>> the GPU reset rw_lock. I rely on the SRCU unplug flag for 
>>>>>>>>>> unplug. Also, not clear to me why are we focusing on the 
>>>>>>>>>> scheduler threads, any code patch to generate HW fences 
>>>>>>>>>> should be covered, so any code leading to amdgpu_fence_emit 
>>>>>>>>>> needs to be taken into account such as, direct IB 
>>>>>>>>>> submissions, VM flushes e.t.c
>>>>>>>>>
>>>>>>>>> You need to work together with the reset lock anyway, cause a 
>>>>>>>>> hotplug could run at the same time as a reset.
>>>>>>>>
>>>>>>>>
>>>>>>>> For going my way indeed now I see now that I have to take reset 
>>>>>>>> write side lock during HW fences signalling in order to protect 
>>>>>>>> against scheduler/HW fences detachment and reattachment during 
>>>>>>>> schedulers stop/restart. But if we go with your approach  then 
>>>>>>>> calling drm_dev_unplug and scoping amdgpu_job_timeout with 
>>>>>>>> drm_dev_enter/exit should be enough to prevent any concurrent 
>>>>>>>> GPU resets during unplug. In fact I already do it anyway - 
>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>>>>>>>
>>>>>>> Yes, good point as well.
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Christian.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>

--------------4A65C46D0983C891D6E787EB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-12 2:23 p.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2894bf97-8c39-6610-c479-b089c46513e7@amd.com">
      
      Am 12.04.21 um 20:18 schrieb Andrey Grodzovsky:<br>
      <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
        <p>On 2021-04-12 2:05 p.m., Christian König wrote:<br>
        </p>
        <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com"> Am
          12.04.21 um 20:01 schrieb Andrey Grodzovsky:<br>
          <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
            <p>On 2021-04-12 1:44 p.m., Christian König wrote:<br>
            </p>
            <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
              Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:<br>
              <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
                <div class="moz-cite-prefix">On 2021-04-10 1:34 p.m.,
                  Christian König wrote:<br>
                </div>
                <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">Hi
                  Andrey, <br>
                  <br>
                  Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky: <br>
                  <blockquote type="cite">[SNIP] <br>
                    <blockquote type="cite">
                      <blockquote type="cite"> <br>
                        If we use a list and a flag called
                        'emit_allowed' under a lock such that in
                        amdgpu_fence_emit we lock the list, check the
                        flag and if true add the new HW fence to list
                        and proceed to HW emition as normal, otherwise
                        return with -ENODEV. In amdgpu_pci_remove we
                        take the lock, set the flag to false, and then
                        iterate the list and force signal it. Will this
                        not prevent any new HW fence creation from now
                        on from any place trying to do so ? <br>
                      </blockquote>
                      <br>
                      Way to much overhead. The fence processing is
                      intentionally lock free to avoid cache line
                      bouncing because the IRQ can move from CPU to CPU.
                      <br>
                      <br>
                      We need something which at least the processing of
                      fences in the interrupt handler doesn't affect at
                      all. <br>
                    </blockquote>
                    <br>
                    <br>
                    As far as I see in the code, amdgpu_fence_emit is
                    only called from task context. Also, we can skip
                    this list I proposed and just use
                    amdgpu_fence_driver_force_completion for each ring
                    to signal all created HW fences. <br>
                  </blockquote>
                  <br>
                  Ah, wait a second this gave me another idea. <br>
                  <br>
                  See amdgpu_fence_driver_force_completion(): <br>
                  <br>
                  amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq);
                  <br>
                  <br>
                  If we change that to something like: <br>
                  <br>
                  amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq +
                  0x3FFFFFFF); <br>
                  <br>
                  Not only the currently submitted, but also the next
                  0x3FFFFFFF fences will be considered signaled. <br>
                  <br>
                  This basically solves out problem of making sure that
                  new fences are also signaled without any additional
                  overhead whatsoever.</blockquote>
                <p><br>
                </p>
                <p>Problem with this is that the act of setting the
                  sync_seq to some MAX value alone is not enough, you
                  actually have to call amdgpu_fence_process to iterate
                  and signal the fences currently stored in
                  ring-&gt;fence_drv.fences array and to guarantee that
                  once you done your signalling no more HW fences will
                  be added to that array anymore. I was thinking to do
                  something like bellow:</p>
              </blockquote>
              <br>
              Well we could implement the is_signaled callback once
              more, but I'm not sure if that is a good idea.<br>
            </blockquote>
            <p><br>
            </p>
            <p>This indeed could save the explicit signaling I am doing
              bellow but I also set an error code there which might be
              helpful to propagate to users</p>
            <p><br>
            </p>
            <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
              <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
                <p>amdgpu_fence_emit()</p>
                <p>{</p>
                <p>&nbsp;&nbsp;&nbsp; dma_fence_init(fence);<br>
                </p>
                <p>&nbsp;&nbsp;&nbsp; srcu_read_lock(amdgpu_unplug_srcu)</p>
                <p>&nbsp;&nbsp;&nbsp; if (!adev-&gt;unplug)) {</p>
                <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq = ++ring-&gt;fence_drv.sync_seq;<br>
                  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; emit_fence(fence);</p>
                <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW might
                    be gone at any point*/</b><b><br>
                    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
                </p>
              </blockquote>
              <br>
              You can pretty much ignore this wait here. It is only as a
              last resort so that we never overwrite the ring buffers.<br>
            </blockquote>
            <p><br>
            </p>
            <p>If device is present how can I ignore this ?</p>
          </blockquote>
        </blockquote>
        <p><br>
        </p>
        <p>I think you missed my question here <br>
        </p>
      </blockquote>
      <br>
      Sorry I thought I answered that below.<br>
      <br>
      See this is just the last resort so that we don't need to worry
      about ring buffer overflows during testing.<br>
      <br>
      We should not get here in practice and if we get here generating a
      deadlock might actually be the best handling.<br>
      <br>
      The alternative would be to call BUG().<br>
      <br>
      <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
        <p> </p>
        <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com">
          <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
            <p><br>
            </p>
            <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
              But it should not have a timeout as far as I can see.<br>
            </blockquote>
            <p><br>
            </p>
            <p>Without timeout wait the who approach falls apart as I
              can't call srcu_synchronize on this scope because once
              device is physically gone the wait here will be forever</p>
          </blockquote>
          <br>
          Yeah, but this is intentional. The only alternative to avoid
          corruption is to wait with a timeout and call BUG() if that
          triggers. That isn't much better.<br>
          <br>
          <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
            <p><br>
            </p>
            <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
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
              Well that is just duplicating what drm_dev_unplug() should
              be doing on a different level.<br>
            </blockquote>
            <p><br>
            </p>
            <p>drm_dev_unplug is on a much wider scope, for everything
              in the device including 'flushing' in flight IOCTLs, this
              deals specifically with the issue of force signalling HW
              fences</p>
          </blockquote>
          <br>
          Yeah, but it adds the same overhead as the device srcu.<br>
          <br>
          Christian.<br>
        </blockquote>
        <p><br>
        </p>
        <p>So what's the right approach ? How we guarantee that when
          running amdgpu_fence_driver_force_completion we will signal
          all the HW fences and not racing against some more fences
          insertion into that array ?</p>
      </blockquote>
      <br>
      Well I would still say the best approach would be to insert this
      between the front end and the backend and not rely on signaling
      fences while holding the device srcu.<br>
    </blockquote>
    <p><br>
    </p>
    <p>My question is, even now, when we run
      amdgpu_fence_driver_fini_hw-&gt;amdgpu_fence_wait_empty or
      amdgpu_fence_driver_fini_hw-&gt;amdgpu_fence_driver_force_completion,
      what there prevents a race with another fence being at the same
      time emitted and inserted into the fence array ? Looks like
      nothing.</p>
    <p> <br>
    </p>
    <blockquote type="cite" cite="mid:2894bf97-8c39-6610-c479-b089c46513e7@amd.com"> <br>
      BTW: Could it be that the device SRCU protects more than one
      device and we deadlock because of this?<br>
    </blockquote>
    <p><br>
    </p>
    <p>I haven't actually experienced any deadlock until now but, yes,
      drm_unplug_srcu is defined as static in drm_drv.c and so in the
      presence&nbsp; of multiple devices from same or different drivers we in
      fact are dependent on all their critical sections i guess.</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:2894bf97-8c39-6610-c479-b089c46513e7@amd.com"> <br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
        <p>Andrey<br>
        </p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com"> <br>
          <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
            <p>Andrey</p>
            <p><br>
            </p>
            <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
              Christian.<br>
              <br>
              <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
                <p>&nbsp;&nbsp;&nbsp; /* Past this point no more fence are submitted to
                  HW ring and hence we can safely call force signal on
                  all that are currently there. <br>
                  &nbsp;&nbsp;&nbsp;&nbsp; * Any subsequently created&nbsp; HW fences will be
                  returned signaled with an error code right away <br>
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
                <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">
                  <br>
                  <br>
                  <blockquote type="cite"> <br>
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite"> <br>
                          Alternatively grabbing the reset write side
                          and stopping and then restarting the scheduler
                          could work as well. <br>
                          <br>
                          Christian. <br>
                        </blockquote>
                        <br>
                        <br>
                        I didn't get the above and I don't see why I
                        need to reuse the GPU reset rw_lock. I rely on
                        the SRCU unplug flag for unplug. Also, not clear
                        to me why are we focusing on the scheduler
                        threads, any code patch to generate HW fences
                        should be covered, so any code leading to
                        amdgpu_fence_emit needs to be taken into account
                        such as, direct IB submissions, VM flushes e.t.c
                        <br>
                      </blockquote>
                      <br>
                      You need to work together with the reset lock
                      anyway, cause a hotplug could run at the same time
                      as a reset. <br>
                    </blockquote>
                    <br>
                    <br>
                    For going my way indeed now I see now that I have to
                    take reset write side lock during HW fences
                    signalling in order to protect against scheduler/HW
                    fences detachment and reattachment during schedulers
                    stop/restart. But if we go with your approach&nbsp; then
                    calling drm_dev_unplug and scoping
                    amdgpu_job_timeout with drm_dev_enter/exit should be
                    enough to prevent any concurrent GPU resets during
                    unplug. In fact I already do it anyway - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8
 eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0</a><br>
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
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------4A65C46D0983C891D6E787EB--

--===============0445089755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0445089755==--
