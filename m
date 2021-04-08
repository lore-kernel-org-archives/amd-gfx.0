Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B52C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 16:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B462661041
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 16:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B462661041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563836EB60;
	Thu,  8 Apr 2021 16:08:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F396EB60
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 16:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=besE0nAgh/xdV2gHvejLrGpgmlARjN3dHgRnRDXppIjs0+QGdcKk5MegxEgdR5nnzHq0R1bDSh8jeIprguMSvIDBMUVV3kTPPocqCTtSXcfj4O2opDPnlnUReJNIeITXfCGxz71TM+5UQU54MIx7vzvAghW5EdHAWYsedjilatzvsNtL+naXQJTKD+brLh9ADIeAk1R3KPiBkNoUyW1Q8gE0mFMITIkD7IlRHHKAP/0NRsUYE1uLMWAcfdDzfpUwhJ4xRcP7dIarOJLNU8EHDCP9BUnYOvcqapV/DYi78BoaTLNqO5ZFVhejPfKgJW0PSk9Qq9NUAjPzdnwkbbmPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8LTr4cLR8Hok0KSteAM1cnrnv3sgxst4VhqxvoKXAI=;
 b=iteFj5zgsnnoO/4wG0WwwChjISZV6gXWwuTseYGQ/aTICf2b8rnnzAZ2LEBiSQQaOub2D4LfBeHm+HvA9yU4z+34ZYvxgQ2fXRjPw3AF2e61FykzindadBTADvzV4qXep1PBPay/jJRgzyU9xYCiMflq4ODt0rtrs1vDV83cqnl/Dn6yZ3MP2AxZiXHaZNGk/xKRYmzcj+bd2VcyD0+7t01ME7T/kW6nAMzZAAoWnpZpe3mI1M3wvlxT9uSpyiSonVUvPS2bN6/D4tblE4cznCam1OXC7zPPC4meuF0dZy3Drj6S2GrveaV0DpXkYxLcwkHZMjshxkIKMRIxn2qZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8LTr4cLR8Hok0KSteAM1cnrnv3sgxst4VhqxvoKXAI=;
 b=3fq4HVJiR4w3Q+SZQISv+s/c9fR9rkMNcYIfnv5LH1owB5hc68SOvu7lxMu8HBLCx0w3ieC7Jt3tfYDwdSRO6btiJefkWiGw4mZuo0Fq9KsEovtcu/j7EEZQlRGeFEkDNX4pjXZB9IHwEDfQQ8m7a09TICpCVnJ5gwkwcU83sNA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 16:08:06 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 16:08:06 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
Date: Thu, 8 Apr 2021 12:08:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:2a1:d154:32b0:ff6]
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:2a1:d154:32b0:ff6]
 (2607:fea8:3edf:49b0:2a1:d154:32b0:ff6) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Thu, 8 Apr 2021 16:08:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27779419-387e-427f-a782-08d8faa87ec4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438156C8865807641EB31D48EA749@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7KN0nqg6R0i467NTFSra4M8IIb/ep3HdKLhb+I0j2xq0odSFFouDI4XBdCodYJeXa9uh3ztsJMvefRH5NIt3g1SKivbzeetQHxqfZhvt+B9s2UTSYByCGSYsnBP9bCq8QEAWFii2I6I5Cf/hdIRyI6E1T0uwNwz9PUSbuQaDy0sW/7BnmXaSakDbdl8FlBt/MhKSysno00f/3fddlceeOPhVf5c/BNBFYbtnaiG4EU8CW31e+vf7qt2Zo0OgrhLoTsMJB3ZMf5mlc1OOl/ecGfOXjmWzZK31yGGl/o3S1yja0jZUF9Mr93eg9f3h+3gFA4SfP9DdD45Xl3tOCk9Q9cOmsvl65KcEZecl2fln4fwR2Aj0O0SAkxwfRfX6oZXvXW6MDcb4HfQKO+ExMDsry/0q98L6KDYWwtpRtZUfd+wpoTq/cUHUrDwTycLDjYj94LVVNwx2cvjK2KYmLGc2yYbtuZEL/NoZeSa65hP3Vj/L47nP4wNjWKS7/I2MLqiQR0IZadINHcPfDgeqKBJUyHJRzjtN/3KzidHHpBmZMaQywGNRtsEglXzkOWqIKe72G2pRV/j136TVu9rEnIOP0BkZo+SJywxcDsLmTkD2/3If35z/KuQKlOo9Z8ZkQ1oqRRr+jHc5xNCniGAGukXMRilbHfbgATP66/3lIlIS0YTLD1nArh3U4SCeZtCHxXofMJ0aSpKjFQGIgq1EQCPCPS2OvEbKM7aQQSozQvpuhuL/3CJA8eAaL9LlDdw/xomhP9GlJ/euOIwWF948LfPDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(2906002)(5660300002)(38100700001)(86362001)(166002)(2616005)(16526019)(31696002)(31686004)(8936002)(52116002)(316002)(30864003)(6666004)(186003)(6486002)(33964004)(53546011)(44832011)(66946007)(110136005)(66556008)(66476007)(966005)(36756003)(83380400001)(6636002)(66574015)(478600001)(8676002)(921005)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3dlei9OTTh4UzdGY2UwZ0RCTGJvSmZaY2xnZTdyN0ZzOHdScGJEM281UHVt?=
 =?utf-8?B?M0ZyK3UweUYrekp0ejJySE5UZlpkT3lzbm9BSTI3R09VQjB0MkhKWDNicHVV?=
 =?utf-8?B?Z0JIMkovblRPanNDQTZjeDgxQTNjZVVEWklMWFVRRjRYSkJmeDFvMXlrc2dO?=
 =?utf-8?B?dC9laHhleWQ2THg3RTZudFh5dHk2R2t0VHFHbXZ0aTg0Mk15Vmp4UDJDS2lj?=
 =?utf-8?B?cnVsWmpNSnFVa2NtVG1udHJjZUtJNERXcHVDdWJERWdkM05SYnZNWmV0MFZN?=
 =?utf-8?B?dFpLMmpwNm5mRE9KNmsxOEc0Q0ExdVQ5dXhteldValo3MThacnhVT2FZdU1J?=
 =?utf-8?B?ekhQS2lNQUJ2UFhmTjhST0l5U3BKOCtRU0k1Wm9BTVRJcHkvUjJXY0tMVEl0?=
 =?utf-8?B?SjZPb04vRjhvYWVCZ2NFd0tEZlFoM29OQkVlTk5lODdDWjVuZE9lZ0Myb2Vo?=
 =?utf-8?B?VDBPWTZpMzd3Y0I5eHJRRmc1OUZ5UEg1N1piR29FNXBBbkpOQ0hYMUROTXhv?=
 =?utf-8?B?ZHJ5Z0tjcEdFVTdLVnorY1d0U1hUSHRXeXhVR2F6SkZLZWJUU0ZSaWF6bUhs?=
 =?utf-8?B?RHF6N1IvVHVQMERMeGxXY2IzOC9abkNLaTMvc3d5ZDZqTnp5TTdhUnNTYVRx?=
 =?utf-8?B?TVM1aEd1WHVYUnFYNHIyZ212NEMwaGZ3WDVTZmhCL1BGMVUxeWgxNEdFaVQ2?=
 =?utf-8?B?WVNZT2dPRDZUTWVEaXBGK2UrSzY3RE5zSFRpeGNoZU4zT1BZTmQ5NGdQVUVo?=
 =?utf-8?B?cWdmaDZNWXh6MHJkSUZtWDgzdktucGJTZWhhdlhWRVFqZXlyVkNwQm93OHpz?=
 =?utf-8?B?bTFLaHpkeXdtYWY2ZDF5TnpwS3VvTVBtMWVTKzdRMmVmSk1ML2RRajFCOGlL?=
 =?utf-8?B?QkVLVk5YamVkSWNJRmJ6ejNwQ0IwaUxVZTFZLytLOFU4eFF4YmNIaGpDM2Jh?=
 =?utf-8?B?ZVNZZVpMSUZBMUxFbjZyWjJFcGw4cXM4aG91TGtiQUsrWWRMV2N3OENFQk5q?=
 =?utf-8?B?bk5mbTVqNEJWZnA2b0pVRHVKQ09yMzBwcnlsTnlpRHdNenVnYy9WK2NSRmVw?=
 =?utf-8?B?bVFWbFB2RFJwRWFnd1pYdkszQTR6QjhvQVd2ekxUdDlMOFBvNEJ0Z0t5ZU9m?=
 =?utf-8?B?L0hXUW1LMmkrR3kzYTNiOFhxb1hWcnk5cXhOT0JjMVZ6bnNNSFJuRWtNR3R5?=
 =?utf-8?B?UFdRYlhmQzAyUmJlWUhHeEtMdEdUdnp0WGdvOTZZRS9neEpEc0ZvUjNNQ3Yx?=
 =?utf-8?B?TmY5d2ZTNUJKOFByWWcrUng4TlBUakdIRWp5U1lsb2VxeEg0clppR0FTeXFt?=
 =?utf-8?B?WkNERXdvaGRrM3FmVjJqVW03WTM2cm1VM1lycSt1US9Uc0FjQTl6blBKckUz?=
 =?utf-8?B?dU1jSlB2cUFhL09FZjZaUVA1cGJmQnVZRnBIUWxXRDhERCtaYzY1dFFhajVY?=
 =?utf-8?B?d0NTWGRldkRjY0U5RmZJekdyTWlYM0YvR285d2VLTUJCd0cvTGV2cFY0RzZr?=
 =?utf-8?B?MkVoYVhJRXJiOE5QSWRRR2IzR05ZQUxiVnM4amQrN1hNYkFKZVNNbkxHSDZP?=
 =?utf-8?B?UVNoSG9FWDhmQVVXQ1NBVnJGOTgrRlYwcWtTNXF5cnc2ZGFxdW8vYzBuYlFN?=
 =?utf-8?B?enEyR0pURzV0cENjUVRHVy8yMFQzTWUzZmZtL05LUTZTQXc5cGt3QisvTlFs?=
 =?utf-8?B?dWdsU21pV3RYR095bzFpN1JKa1hsTHUxeTFQamUvVDRoQ1NFVW5FdjFjeDd3?=
 =?utf-8?B?OFBkUE9JQnZFd1dZYXBCNE53K2Z4Qy82d2ZMM0JtWk5JWE1BczhNTjRpZ0ZK?=
 =?utf-8?B?TllacDAxUGtvWFVpZlpITmZleTRXZlRrc05KOUordlZna0hsK2FoL0cwWUhJ?=
 =?utf-8?Q?E/m1336XLdJHZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27779419-387e-427f-a782-08d8faa87ec4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 16:08:06.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmFlSojnGQM/9KZ00V/TLiHAVLidHYeW3rz64leYewX6rzvGO5GEBtq3uHSpEjbsa1/A/yEX1XDYPL6O8uibjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
Content-Type: multipart/mixed; boundary="===============1120823990=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1120823990==
Content-Type: multipart/alternative;
 boundary="------------D6D535DCFC67C599848609C3"
Content-Language: en-US

--------------D6D535DCFC67C599848609C3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-04-08 4:32 a.m., Christian König wrote:
>
>
> Am 08.04.21 um 10:22 schrieb Christian König:
>> Hi Andrey,
>>
>> Am 07.04.21 um 21:44 schrieb Andrey Grodzovsky:
>>>
>>>
>>> On 2021-04-07 6:28 a.m., Christian König wrote:
>>>> Hi Andrey,
>>>>
>>>> Am 06.04.21 um 23:22 schrieb Andrey Grodzovsky:
>>>>>
>>>>> Hey Christian, Denis, see bellow -
>>>>>
>>>>> On 2021-04-06 6:34 a.m., Christian König wrote:
>>>>>> Hi Andrey,
>>>>>>
>>>>>> well good question. My job is to watch over the implementation 
>>>>>> and design and while I always help I can adjust anybodies schedule.
>>>>>>
>>>>>> Is the patch to print a warning when the hardware is accessed 
>>>>>> without holding the locks merged yet? If not then that would 
>>>>>> probably be a good starting point.
>>>>>
>>>>>
>>>>> It's merged into amd-staging-drm-next and since I work on 
>>>>> drm-misc-next I will cherry-pick it into there.
>>>>>
>>>>
>>>> Ok good to know, I haven't tracked that one further.
>>>>
>>>>>
>>>>>>
>>>>>> Then we would need to unify this with the SRCU to make sure that 
>>>>>> we have both the reset lock as well as block the hotplug code 
>>>>>> from reusing the MMIO space.
>>>>>
>>>>> In my understanding there is a significant difference between 
>>>>> handling of GPU reset and unplug - while GPU reset use case 
>>>>> requires any HW accessing code to block and wait for the reset to 
>>>>> finish and then proceed, hot-unplug
>>>>> is permanent and hence no need to wait and proceed but rather 
>>>>> abort at once.
>>>>>
>>>>
>>>> Yes, absolutely correct.
>>>>
>>>>> This why I think that in any place we already check for device 
>>>>> reset we should also add a check for hot-unplug but the handling 
>>>>> would be different
>>>>> in that for hot-unplug we would abort instead of keep waiting.
>>>>>
>>>>
>>>> Yes, that's the rough picture in my head as well.
>>>>
>>>> Essentially Daniels patch of having an 
>>>> amdgpu_device_hwaccess_begin()/_end() was the right approach. You 
>>>> just can't do it in the top level IOCTL handler, but rather need it 
>>>> somewhere between front end and backend.
>>>
>>>
>>> Can you point me to what patch was it ? Can't find.
>>>
>>
>> What I mean was the approach in patch #3 in this series where he 
>> replaced the down_read/up_read with 
>> amdgpu_read_lock()/amdgpu_read_unlock().
>>
>> I would just not call it amdgpu_read_lock()/amdgpu_read_unlock(), but 
>> something more descriptive.
>>
>> Regards,
>> Christian.
>>
>>>
>>>>
>>>>> Similar to handling device reset for unplug we obviously also need 
>>>>> to stop and block any MMIO accesses once device is unplugged and, 
>>>>> as Daniel Vetter mentioned - we have to do it before finishing 
>>>>> pci_remove (early device fini)
>>>>> and not later (when last device reference is dropped from user 
>>>>> space) in order to prevent reuse of MMIO space we still access by 
>>>>> other hot plugging devices. As in device reset case we need to 
>>>>> cancel all delay works, stop drm schedule, complete all unfinished 
>>>>> fences(both HW and scheduler fences). While you stated strong 
>>>>> objection to force signalling scheduler fences from GPU reset, quote:
>>>>>
>>>>> "you can't signal the dma_fence waiting. Waiting for a dma_fence 
>>>>> also means you wait for the GPU reset to finish. When we would 
>>>>> signal the dma_fence during the GPU reset then we would run into 
>>>>> memory corruption because the hardware jobs running after the GPU 
>>>>> reset would access memory which is already freed."
>>>>> To my understating this is a key difference with hot-unplug, the 
>>>>> device is gone, all those concerns are irrelevant and hence we can 
>>>>> actually force signal scheduler fences (setting and error to them 
>>>>> before) to force completion of any
>>>>> waiting clients such as possibly IOCTLs or async page flips e.t.c.
>>>>>
>>>>
>>>> Yes, absolutely correct. That's what I also mentioned to Daniel. 
>>>> When we are able to nuke the device and any memory access it might 
>>>> do we can also signal the fences.
>>>>
>>>>> Beyond blocking all delayed works and scheduler threads we also 
>>>>> need to guarantee no  IOCTL can access MMIO post device unplug OR 
>>>>> in flight IOCTLs are done before we finish pci_remove 
>>>>> (amdgpu_pci_remove for us).
>>>>> For this I suggest we do something like what we worked on with 
>>>>> Takashi Iwai the ALSA maintainer recently when he helped 
>>>>> implementing PCI BARs move support for snd_hda_intel. Take a look at
>>>>> https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=cbaa324799718e2b828a8c7b5b001dd896748497 
>>>>> and
>>>>> https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=e36365d9ab5bbc30bdc221ab4b3437de34492440
>>>>> We also had same issue there, how to prevent MMIO accesses while 
>>>>> the BARs are migrating. What was done there is a refcount was 
>>>>> added to count all IOCTLs in flight, for any in flight  IOCTL the 
>>>>> BAR migration handler would
>>>>> block for the refcount to drop to 0 before it would proceed, for 
>>>>> any later IOCTL it stops and wait if device is in migration state. 
>>>>> We even don't need the wait part, nothing to wait for, we just 
>>>>> return with -ENODEV for this case.
>>>>>
>>>>
>>>> This is essentially what the DRM SRCU is doing as well.
>>>>
>>>> For the hotplug case we could do this in the toplevel since we can 
>>>> signal the fence and don't need to block memory management.
>>>
>>>
>>> To make SRCU 'wait for' all IOCTLs in flight we would need to wrap 
>>> every IOCTL ( practically - just drm_ioctl function) with 
>>> drm_dev_enter/drm_dev_exit - can we do it ?
>>>
>
> Sorry totally missed this question.
>
> Yes, exactly that. As discussed for the hotplug case we can do this.


Thinking more about it - assuming we are  treating synchronize_srcu as a 
'wait for completion' of any in flight {drm_dev_enter, drm_dev_exit} 
scope, some of those scopes might do dma_fence_wait inside. Since we 
haven't force signaled the fences yet we will end up a deadlock. We have 
to signal all the various fences before doing the 'wait for'. But we 
can't signal the fences before setting 'dev->unplugged = true' to reject 
further CS and other stuff which might create more fences we were 
supposed-to force signal and now missed them. Effectively  setting 
'dev->unplugged = true' and doing synchronize_srcu in one call like 
drm_dev_unplug does without signalling all the fences in the device in 
between these two steps looks luck a possible deadlock to me - what do 
you think ?

Andrey

>
>>>
>>>>
>>>> But I'm not sure, maybe we should handle it the same way as reset 
>>>> or maybe we should have it at the top level.
>>>
>>>
>>> If by top level you mean checking for device unplugged and bailing 
>>> out at the entry to IOCTL or right at start of any work_item/timer 
>>> function we have then seems to me it's better and more clear. Once 
>>> we flushed all of them in flight there is no reason for them to 
>>> execute any more when device is unplugged.
>>>
>
> Well I'm open to both approaches. I just think having 
> drm_dev_enter/exit on each work item would be more defensive in case 
> we forgot to cancel/sync one.
>
> Christian.
>
>>> Andrey
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> The above approach should allow us to wait for all the IOCTLs in 
>>>>> flight, together with stopping scheduler threads and cancelling 
>>>>> and flushing all in flight work items and timers i think It should 
>>>>> give as full solution for the hot-unplug case
>>>>> of preventing any MMIO accesses post device pci_remove.
>>>>>
>>>>> Let me know what you think guys.
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>> And then testing, testing, testing to see if we have missed 
>>>>>> something.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>> Am 05.04.21 um 19:58 schrieb Andrey Grodzovsky:
>>>>>>>
>>>>>>> Denis, Christian, are there any updates in the plan on how to 
>>>>>>> move on with this ? As you know I need very similar code for my 
>>>>>>> up-streaming of device hot-unplug. My latest solution 
>>>>>>> (https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html) 
>>>>>>> was not acceptable because of low level guards on the register 
>>>>>>> accessors level which was hurting performance. Basically I need 
>>>>>>> a way to prevent any MMIO write accesses from kernel driver 
>>>>>>> after device is removed (UMD accesses are taken care of by page 
>>>>>>> faulting dummy page). We are using now hot-unplug code for 
>>>>>>> Freemont program and so up-streaming became more of a priority 
>>>>>>> then before. This MMIO access issue is currently my main blocker 
>>>>>>> from up-streaming. Is there any way I can assist in pushing this 
>>>>>>> on ?
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>> On 2021-03-18 5:51 a.m., Christian König wrote:
>>>>>>>> Am 18.03.21 um 10:30 schrieb Li, Dennis:
>>>>>>>>>
>>>>>>>>> >>> The GPU reset doesn't complete the fences we wait for. It 
>>>>>>>>> only completes the hardware fences as part of the reset.
>>>>>>>>>
>>>>>>>>> >>> So waiting for a fence while holding the reset lock is 
>>>>>>>>> illegal and needs to be avoided.
>>>>>>>>>
>>>>>>>>> I understood your concern. It is more complex for DRM GFX, 
>>>>>>>>> therefore I abandon adding lock protection for DRM ioctls now. 
>>>>>>>>> Maybe we can try to add all kernel  dma_fence waiting in a 
>>>>>>>>> list, and signal all in recovery threads. Do you have same 
>>>>>>>>> concern for compute cases?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, compute (KFD) is even harder to handle.
>>>>>>>>
>>>>>>>> See you can't signal the dma_fence waiting. Waiting for a 
>>>>>>>> dma_fence also means you wait for the GPU reset to finish.
>>>>>>>>
>>>>>>>> When we would signal the dma_fence during the GPU reset then we 
>>>>>>>> would run into memory corruption because the hardware jobs 
>>>>>>>> running after the GPU reset would access memory which is 
>>>>>>>> already freed.
>>>>>>>>
>>>>>>>>> >>> Lockdep also complains about this when it is used 
>>>>>>>>> correctly. The only reason it doesn't complain here is because 
>>>>>>>>> you use an atomic+wait_event instead of a locking primitive.
>>>>>>>>>
>>>>>>>>> Agree. This approach will escape the monitor of lockdep.  Its 
>>>>>>>>> goal is to block other threads when GPU recovery thread start. 
>>>>>>>>> But I couldn’t find a better method to solve this problem. Do 
>>>>>>>>> you have some suggestion?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Well, completely abandon those change here.
>>>>>>>>
>>>>>>>> What we need to do is to identify where hardware access happens 
>>>>>>>> and then insert taking the read side of the GPU reset lock so 
>>>>>>>> that we don't wait for a dma_fence or allocate memory, but 
>>>>>>>> still protect the hardware from concurrent access and reset.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> Best Regards
>>>>>>>>>
>>>>>>>>> Dennis Li
>>>>>>>>>
>>>>>>>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>>> *Sent:* Thursday, March 18, 2021 4:59 PM
>>>>>>>>> *To:* Li, Dennis <Dennis.Li@amd.com>; 
>>>>>>>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
>>>>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>>>>>>> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>>>>>>>>> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to 
>>>>>>>>> enhance its stability
>>>>>>>>>
>>>>>>>>> Exactly that's what you don't seem to understand.
>>>>>>>>>
>>>>>>>>> The GPU reset doesn't complete the fences we wait for. It only 
>>>>>>>>> completes the hardware fences as part of the reset.
>>>>>>>>>
>>>>>>>>> So waiting for a fence while holding the reset lock is illegal 
>>>>>>>>> and needs to be avoided.
>>>>>>>>>
>>>>>>>>> Lockdep also complains about this when it is used correctly. 
>>>>>>>>> The only reason it doesn't complain here is because you use an 
>>>>>>>>> atomic+wait_event instead of a locking primitive.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>> ------------------------------------------------------------------------
>>>>>>>>>
>>>>>>>>> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
>>>>>>>>> *Gesendet:* Donnerstag, 18. März 2021 09:28
>>>>>>>>> *An:* Koenig, Christian <Christian.Koenig@amd.com 
>>>>>>>>> <mailto:Christian.Koenig@amd.com>>; 
>>>>>>>>> amd-gfx@lists.freedesktop.org 
>>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>>>>>>>> <amd-gfx@lists.freedesktop.org 
>>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
>>>>>>>>> <Alexander.Deucher@amd.com 
>>>>>>>>> <mailto:Alexander.Deucher@amd.com>>; Kuehling, Felix 
>>>>>>>>> <Felix.Kuehling@amd.com <mailto:Felix.Kuehling@amd.com>>; 
>>>>>>>>> Zhang, Hawking <Hawking.Zhang@amd.com 
>>>>>>>>> <mailto:Hawking.Zhang@amd.com>>
>>>>>>>>> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to 
>>>>>>>>> enhance its stability
>>>>>>>>>
>>>>>>>>> >>> Those two steps need to be exchanged or otherwise it is 
>>>>>>>>> possible that new delayed work items etc are started before 
>>>>>>>>> the lock is taken.
>>>>>>>>> What about adding check for adev->in_gpu_reset in work item? 
>>>>>>>>> If exchange the two steps, it maybe introduce the deadlock.  
>>>>>>>>> For example, the user thread hold the read lock and waiting 
>>>>>>>>> for the fence, if recovery thread try to hold write lock and 
>>>>>>>>> then complete fences, in this case, recovery thread will 
>>>>>>>>> always be blocked.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Best Regards
>>>>>>>>> Dennis Li
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com 
>>>>>>>>> <mailto:Christian.Koenig@amd.com>>
>>>>>>>>> Sent: Thursday, March 18, 2021 3:54 PM
>>>>>>>>> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
>>>>>>>>> amd-gfx@lists.freedesktop.org 
>>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>>>>>>>>> <Alexander.Deucher@amd.com 
>>>>>>>>> <mailto:Alexander.Deucher@amd.com>>; Kuehling, Felix 
>>>>>>>>> <Felix.Kuehling@amd.com <mailto:Felix.Kuehling@amd.com>>; 
>>>>>>>>> Zhang, Hawking <Hawking.Zhang@amd.com 
>>>>>>>>> <mailto:Hawking.Zhang@amd.com>>
>>>>>>>>> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to 
>>>>>>>>> enhance its stability
>>>>>>>>>
>>>>>>>>> Am 18.03.21 um 08:23 schrieb Dennis Li:
>>>>>>>>> > We have defined two variables in_gpu_reset and reset_sem in 
>>>>>>>>> adev object. The atomic type variable in_gpu_reset is used to 
>>>>>>>>> avoid recovery thread reenter and make lower functions return 
>>>>>>>>> more earlier when recovery start, but couldn't block recovery 
>>>>>>>>> thread when it access hardware. The r/w semaphore reset_sem is 
>>>>>>>>> used to solve these synchronization issues between recovery 
>>>>>>>>> thread and other threads.
>>>>>>>>> >
>>>>>>>>> > The original solution locked registers' access in lower 
>>>>>>>>> functions, which will introduce following issues:
>>>>>>>>> >
>>>>>>>>> > 1) many lower functions are used in both recovery thread and 
>>>>>>>>> others. Firstly we must harvest these functions, it is easy to 
>>>>>>>>> miss someones. Secondly these functions need select which lock 
>>>>>>>>> (read lock or write lock) will be used, according to the 
>>>>>>>>> thread it is running in. If the thread context isn't 
>>>>>>>>> considered, the added lock will easily introduce deadlock. 
>>>>>>>>> Besides that, in most time, developer easily forget to add 
>>>>>>>>> locks for new functions.
>>>>>>>>> >
>>>>>>>>> > 2) performance drop. More lower functions are more 
>>>>>>>>> frequently called.
>>>>>>>>> >
>>>>>>>>> > 3) easily introduce false positive lockdep complaint, 
>>>>>>>>> because write lock has big range in recovery thread, but low 
>>>>>>>>> level functions will hold read lock may be protected by other 
>>>>>>>>> locks in other threads.
>>>>>>>>> >
>>>>>>>>> > Therefore the new solution will try to add lock protection 
>>>>>>>>> for ioctls of kfd. Its goal is that there are no threads 
>>>>>>>>> except for recovery thread or its children (for xgmi) to 
>>>>>>>>> access hardware when doing GPU reset and resume. So refine 
>>>>>>>>> recovery thread as the following:
>>>>>>>>> >
>>>>>>>>> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>>>>>>>>> >     1). if failed, it means system had a recovery thread 
>>>>>>>>> running, current thread exit directly;
>>>>>>>>> >     2). if success, enter recovery thread;
>>>>>>>>> >
>>>>>>>>> > Step 1: cancel all delay works, stop drm schedule, complete 
>>>>>>>>> all unreceived fences and so on. It try to stop or pause other 
>>>>>>>>> threads.
>>>>>>>>> >
>>>>>>>>> > Step 2: call down_write(&adev->reset_sem) to hold write 
>>>>>>>>> lock, which will block recovery thread until other threads 
>>>>>>>>> release read locks.
>>>>>>>>>
>>>>>>>>> Those two steps need to be exchanged or otherwise it is 
>>>>>>>>> possible that new delayed work items etc are started before 
>>>>>>>>> the lock is taken.
>>>>>>>>>
>>>>>>>>> Just to make it clear until this is fixed the whole patch set 
>>>>>>>>> is a NAK.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>> >
>>>>>>>>> > Step 3: normally, there is only recovery threads running to 
>>>>>>>>> access hardware, it is safe to do gpu reset now.
>>>>>>>>> >
>>>>>>>>> > Step 4: do post gpu reset, such as call all ips' resume 
>>>>>>>>> functions;
>>>>>>>>> >
>>>>>>>>> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other 
>>>>>>>>> threads and release write lock. Recovery thread exit normally.
>>>>>>>>> >
>>>>>>>>> > Other threads call the amdgpu_read_lock to synchronize with 
>>>>>>>>> recovery thread. If it finds that in_gpu_reset is 1, it should 
>>>>>>>>> release read lock if it has holden one, and then blocks itself 
>>>>>>>>> to wait for recovery finished event. If thread successfully 
>>>>>>>>> hold read lock and in_gpu_reset is 0, it continues. It will 
>>>>>>>>> exit normally or be stopped by recovery thread in step 1.
>>>>>>>>> >
>>>>>>>>> > Dennis Li (4):
>>>>>>>>> >    drm/amdgpu: remove reset lock from low level functions
>>>>>>>>> >    drm/amdgpu: refine the GPU recovery sequence
>>>>>>>>> >    drm/amdgpu: instead of using down/up_read directly
>>>>>>>>> >    drm/amdkfd: add reset lock protection for kfd entry functions
>>>>>>>>> >
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu.h |   6 +
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  14 +-
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 173 
>>>>>>>>> +++++++++++++-----
>>>>>>>>> > .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |   8 -
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   4 +-
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |   9 +-
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c |   5 +-
>>>>>>>>> > drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c |   5 +-
>>>>>>>>> > drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 172 ++++++++++++++++-
>>>>>>>>> > drivers/gpu/drm/amd/amdkfd/kfd_priv.h |   3 +-
>>>>>>>>> > drivers/gpu/drm/amd/amdkfd/kfd_process.c |   4 +
>>>>>>>>> > .../amd/amdkfd/kfd_process_queue_manager.c |  17 ++
>>>>>>>>> >   12 files changed, 345 insertions(+), 75 deletions(-)
>>>>>>>>> >
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> amd-gfx mailing list
>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>
>>
>

--------------D6D535DCFC67C599848609C3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-08 4:32 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com">
      
      <br>
      <br>
      <div class="moz-cite-prefix">Am 08.04.21 um 10:22 schrieb
        Christian König:<br>
      </div>
      <blockquote type="cite" cite="mid:b67ab565-e4be-0809-7021-cb59fd10464a@amd.com"> Hi
        Andrey,<br>
        <br>
        <div class="moz-cite-prefix">Am 07.04.21 um 21:44 schrieb Andrey
          Grodzovsky:<br>
        </div>
        <blockquote type="cite" cite="mid:1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com">
          <p><br>
          </p>
          <div class="moz-cite-prefix">On 2021-04-07 6:28 a.m.,
            Christian König wrote:<br>
          </div>
          <blockquote type="cite" cite="mid:e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com">
            Hi Andrey,<br>
            <br>
            <div class="moz-cite-prefix">Am 06.04.21 um 23:22 schrieb
              Andrey Grodzovsky:<br>
            </div>
            <blockquote type="cite" cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
              <p>Hey Christian, Denis, see bellow - <br>
              </p>
              <div class="moz-cite-prefix">On 2021-04-06 6:34 a.m.,
                Christian König wrote:<br>
              </div>
              <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com">
                Hi Andrey,<br>
                <br>
                well good question. My job is to watch over the
                implementation and design and while I always help I can
                adjust anybodies schedule.<br>
                <br>
                Is the patch to print a warning when the hardware is
                accessed without holding the locks merged yet? If not
                then that would probably be a good starting point.<br>
              </blockquote>
              <p><br>
              </p>
              <p>It's merged into amd-staging-drm-next and since I work
                on drm-misc-next I will cherry-pick it into there.<br>
              </p>
            </blockquote>
            <br>
            Ok good to know, I haven't tracked that one further.<br>
            <br>
            <blockquote type="cite" cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
              <p> </p>
              <p><br>
              </p>
              <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com">
                <br>
                Then we would need to unify this with the SRCU to make
                sure that we have both the reset lock as well as block
                the hotplug code from reusing the MMIO space.<br>
              </blockquote>
              <br>
              <p>In my understanding there is a significant difference
                between handling of GPU reset and unplug - while GPU
                reset use case requires any HW accessing code to block
                and wait for the reset to finish and then proceed,
                hot-unplug<br>
                is permanent and hence no need to wait and proceed but
                rather abort at once.</p>
            </blockquote>
            <br>
            Yes, absolutely correct.<br>
            <br>
            <blockquote type="cite" cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
              <p> This why I think that in any place we already check
                for device reset we should also add a check for
                hot-unplug but the handling would be different<br>
                in that for hot-unplug we would abort instead of keep
                waiting.</p>
            </blockquote>
            <br>
            Yes, that's the rough picture in my head as well.<br>
            <br>
            Essentially Daniels patch of having an
            amdgpu_device_hwaccess_begin()/_end() was the right
            approach. You just can't do it in the top level IOCTL
            handler, but rather need it somewhere between front end and
            backend.<br>
          </blockquote>
          <p><br>
          </p>
          <p>Can you point me to what patch was it ? Can't find.</p>
        </blockquote>
        <br>
        What I mean was the approach in patch #3 in this series where he
        replaced the down_read/up_read with
        amdgpu_read_lock()/amdgpu_read_unlock().<br>
        <br>
        I would just not call it
        amdgpu_read_lock()/amdgpu_read_unlock(), but something more
        descriptive.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        <blockquote type="cite" cite="mid:1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com">
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com"> <br>
            <blockquote type="cite" cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
              <p>Similar to handling device reset for unplug we
                obviously also need to stop and block any MMIO accesses
                once device is unplugged and, as Daniel Vetter mentioned
                - we have to do it before finishing pci_remove (early
                device fini)<br>
                and not later (when last device reference is dropped
                from user space) in order to prevent reuse of MMIO space
                we still access by other hot plugging devices. As in
                device reset case we need to cancel all delay works,
                stop drm schedule, complete all unfinished fences(both
                HW and scheduler fences). While you stated strong
                objection to force signalling scheduler fences from GPU
                reset, quote: <br>
              </p>
              <p>&quot;you can't signal the dma_fence waiting. Waiting for a
                dma_fence also means you wait for the GPU reset to
                finish. When we would signal the dma_fence during the
                GPU reset then we would run into memory corruption
                because the hardware jobs running after the GPU reset
                would access memory which is already freed.&quot;<br>
                To my understating this is a key difference with
                hot-unplug, the device is gone, all those concerns are
                irrelevant and hence we can actually force signal
                scheduler fences (setting and error to them before) to
                force completion of any<br>
                waiting clients such as possibly IOCTLs or async page
                flips e.t.c.<br>
              </p>
            </blockquote>
            <br>
            Yes, absolutely correct. That's what I also mentioned to
            Daniel. When we are able to nuke the device and any memory
            access it might do we can also signal the fences.<br>
            <br>
            <blockquote type="cite" cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
              <p> </p>
              <p>Beyond blocking all delayed works and scheduler threads
                we also need to guarantee no&nbsp; IOCTL can access MMIO post
                device unplug OR in flight IOCTLs are done before we
                finish pci_remove (amdgpu_pci_remove for us).<br>
                For this I suggest we do something like what we worked
                on with Takashi Iwai the ALSA maintainer recently when
                he helped implementing PCI BARs move support for
                snd_hda_intel. Take a look at<br>
                <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Dyadro%2Fpcie_hotplug%2Fmovable_bars_v9.1%26id%3Dcbaa324799718e2b828a8c7b5b001dd896748497&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C53db69e1b7aa4f35be2d08d8fa68e450%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534675736139059%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=98uBnVziedW6ja942T6RXMo0JEX%2FgV%2F7KT%2Fc2KwOjqs%3D&amp;reserved=0" originalsrc="https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=cbaa324799718e2b828a8c7b5b001dd896748497" shash="za1klQsHu8dYNc4jJ2xcM+fdrHHXA9hEAVpICD7y3F+Zv5aTf9+AmT8EpsRveG8An2xnALmCCv4EOoYAVBy3D8IoOKQwskp5zBkuRHekYzPGN4lLD5gHVOHoAKNjR8r6ApEiWGJsdp0GTyUkHWsp3XFwqVEvnhosdMMtXpzxH+U=" moz-do-not-send="true">https://cgit.freedesktop.org/~agrodzov/linux/commi
 t/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=cbaa324799718e2b828a8c7b5b001dd896748497</a>
                and<br>
                <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Dyadro%2Fpcie_hotplug%2Fmovable_bars_v9.1%26id%3De36365d9ab5bbc30bdc221ab4b3437de34492440&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C53db69e1b7aa4f35be2d08d8fa68e450%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534675736149057%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6E7B9GsmSq88uScSvTzZ3vZgMDhQrqasMHpyUCL19rM%3D&amp;reserved=0" originalsrc="https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=e36365d9ab5bbc30bdc221ab4b3437de34492440" shash="F8Qfbi7mtSpiKR76T6oz4q7R8Wrb2Grg5rj/kQFcKNA2bvm+a64nom566Qzc+tPuUI1JIOM5KFmusj9sqVlLaB/cqelunf82VYYYAA6P/9LBDQ3XBT9ocbzjzZ51+CV99qFsB+5Bd4SHymj1adB0MU/k/GhptqVXEi+b/rtC2b4=" moz-do-not-send="true">https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=y
 adro/pcie_hotplug/movable_bars_v9.1&amp;id=e36365d9ab5bbc30bdc221ab4b3437de34492440</a><br>
                We also had same issue there, how to prevent MMIO
                accesses while the BARs are migrating. What was done
                there is a refcount was added to count all IOCTLs in
                flight, for any in flight&nbsp; IOCTL the BAR migration
                handler would <br>
                block for the refcount to drop to 0 before it would
                proceed, for any later IOCTL it stops and wait if device
                is in migration state. We even don't need the wait part,
                nothing to wait for, we just return with -ENODEV for
                this case.</p>
            </blockquote>
            <br>
            This is essentially what the DRM SRCU is doing as well.<br>
          </blockquote>
          <blockquote type="cite" cite="mid:e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com"> <br>
            For the hotplug case we could do this in the toplevel since
            we can signal the fence and don't need to block memory
            management.<br>
          </blockquote>
          <p><br>
          </p>
          <p>To make SRCU 'wait for' all IOCTLs in flight we would need
            to wrap every IOCTL ( practically - just drm_ioctl function)
            with drm_dev_enter/drm_dev_exit - can we do it ? <br>
          </p>
        </blockquote>
      </blockquote>
      <br>
      Sorry totally missed this question.<br>
      <br>
      Yes, exactly that. As discussed for the hotplug case we can do
      this.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Thinking more about it - assuming we are&nbsp; treating&nbsp;
      synchronize_srcu as a 'wait for completion' of any in flight
      {drm_dev_enter, drm_dev_exit} scope, some of those scopes might do
      dma_fence_wait inside. Since we haven't force signaled the fences
      yet we will end up a deadlock. We have to signal all the various
      fences before doing the 'wait for'. But we can't signal the fences
      before setting 'dev-&gt;unplugged = true' to reject further CS and
      other stuff which might create more fences we were supposed-to
      force signal and now missed them. Effectively&nbsp; setting
      'dev-&gt;unplugged = true' and doing synchronize_srcu in one call
      like drm_dev_unplug does without signalling all the fences in the
      device in between these two steps looks luck a possible deadlock
      to me - what do you think ?</p>
    <p>Andrey<br>
    </p>
    <blockquote type="cite" cite="mid:8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com"> <br>
      <blockquote type="cite" cite="mid:b67ab565-e4be-0809-7021-cb59fd10464a@amd.com">
        <blockquote type="cite" cite="mid:1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com">
          <p> </p>
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com"> <br>
            But I'm not sure, maybe we should handle it the same way as
            reset or maybe we should have it at the top level.<br>
          </blockquote>
          <p><br>
          </p>
          <p>If by top level you mean checking for device unplugged and
            bailing out at the entry to IOCTL or right at start of any
            work_item/timer function we have then seems to me it's
            better and more clear. Once we flushed all of them in flight
            there is no reason for them to execute any more when device
            is unplugged.<br>
          </p>
        </blockquote>
      </blockquote>
      <br>
      Well I'm open to both approaches. I just think having
      drm_dev_enter/exit on each work item would be more defensive in
      case we forgot to cancel/sync one.<br>
      <br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:b67ab565-e4be-0809-7021-cb59fd10464a@amd.com">
        <blockquote type="cite" cite="mid:1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com">
          <p> </p>
          <p>Andrey<br>
          </p>
          <p> <br>
          </p>
          <blockquote type="cite" cite="mid:e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com"> <br>
            Regards,<br>
            Christian.<br>
            <br>
            <blockquote type="cite" cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
              <p>The above approach should allow us to wait for all the
                IOCTLs in flight, together with stopping scheduler
                threads and cancelling and flushing all in flight work
                items and timers i think It should give as full solution
                for the hot-unplug case<br>
                of preventing any MMIO accesses post device pci_remove.<br>
                <br>
                Let me know what you think guys.</p>
              <p>Andrey</p>
              <p><br>
              </p>
              <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com">
                <br>
                And then testing, testing, testing to see if we have
                missed something.<br>
                <br>
                Christian.<br>
                <br>
                <div class="moz-cite-prefix">Am 05.04.21 um 19:58
                  schrieb Andrey Grodzovsky:<br>
                </div>
                <blockquote type="cite" cite="mid:1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com">
                  <p>Denis, Christian, are there any updates in the plan
                    on how to move on with this ? As you know I need
                    very similar code for my up-streaming of device
                    hot-unplug. My latest solution (<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C53db69e1b7aa4f35be2d08d8fa68e450%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534675736159049%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HHrdXpxgWMfpe%2BQ19ZdOJf6RwR%2BQoWPvZ06uYffClWY%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html" shash="GVQbqltHHX6KbQ0WDhp8ddMJ6qpnm9sPdrjOSBXzvWQo2c/bVVf/lh7nQtCemkQ36+SGHr0k0tuaCQ3BMv2pxPYyh18UOd/ym/9Gz/Drur7kbuYaAE+FmfTsmRFD2IRjff1uFVT0bkEUbgdU8dNTQCUqqg0vKLPcLo5QavGXkr4=" moz-do-not-send="true">https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html</a>)
                    was not acceptable because of low level guards on
                    the register accessors level which was hurting
                    performance. Basically I need a way to prevent any
                    MMIO write accesses from kernel driver after device
                    is removed (UMD accesses are taken care of by page
                    faulting dummy page). We are using now hot-unplug
                    code for Freemont program and so up-streaming became
                    more of a priority then before. This MMIO access
                    issue is currently my main blocker from
                    up-streaming. Is there any way I can assist in
                    pushing this on ?</p>
                  <p>Andrey&nbsp; <br>
                  </p>
                  <div class="moz-cite-prefix">On 2021-03-18 5:51 a.m.,
                    Christian König wrote:<br>
                  </div>
                  <blockquote type="cite" cite="mid:378fdffb-99b5-2a14-736d-a06f310b040c@amd.com">
                    Am 18.03.21 um 10:30 schrieb Li, Dennis:<br>
                    <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
                      <meta name="Generator" content="Microsoft Word 15
                        (filtered medium)">
                      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
                      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:\7B49 \7EBF ;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@\7B49 \7EBF ";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
                      <div class="WordSection1">
                        <p class="MsoNormal">&gt;&gt;&gt; The GPU reset
                          doesn't complete the fences we wait for. It
                          only completes the hardware fences as part of
                          the reset.<o:p></o:p></p>
                        <p class="MsoNormal">&gt;&gt;&gt; So waiting for
                          a fence while holding the reset lock is
                          illegal and needs to be avoided.<o:p></o:p></p>
                        <p class="MsoNormal">I understood your concern.
                          It is more complex for DRM GFX, therefore I
                          abandon adding lock protection for DRM ioctls
                          now. Maybe we can try to add all kernel
                          &nbsp;dma_fence waiting in a list, and signal all
                          in recovery threads. Do you have same concern
                          for compute cases? </p>
                      </div>
                    </blockquote>
                    <br>
                    Yes, compute (KFD) is even harder to handle.<br>
                    <br>
                    See you can't signal the dma_fence waiting. Waiting
                    for a dma_fence also means you wait for the GPU
                    reset to finish.<br>
                    <br>
                    When we would signal the dma_fence during the GPU
                    reset then we would run into memory corruption
                    because the hardware jobs running after the GPU
                    reset would access memory which is already freed.<br>
                    <br>
                    <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
                      <div class="WordSection1">
                        <p class="MsoNormal"><o:p></o:p></p>
                        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        <p class="MsoNormal">&gt;&gt;&gt; Lockdep also
                          complains about this when it is used
                          correctly. The only reason it doesn't complain
                          here is because you use an atomic+wait_event
                          instead of a locking primitive.<o:p></o:p></p>
                        <p class="MsoNormal">Agree. This approach will
                          escape the monitor of lockdep.&nbsp; Its goal is to
                          block other threads when GPU recovery thread
                          start. But I couldn’t find a better method to
                          solve this problem. Do you have some
                          suggestion? </p>
                      </div>
                    </blockquote>
                    <br>
                    Well, completely abandon those change here.<br>
                    <br>
                    What we need to do is to identify where hardware
                    access happens and then insert taking the read side
                    of the GPU reset lock so that we don't wait for a
                    dma_fence or allocate memory, but still protect the
                    hardware from concurrent access and reset.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
                      <div class="WordSection1">
                        <p class="MsoNormal"><o:p></o:p></p>
                        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        <p class="MsoNormal">Best Regards<o:p></o:p></p>
                        <p class="MsoNormal">Dennis Li<o:p></o:p></p>
                        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        <div>
                          <div style="border:none;border-top:solid
                            #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                            <p class="MsoNormal"><b>From:</b> Koenig,
                              Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                              <br>
                              <b>Sent:</b> Thursday, March 18, 2021 4:59
                              PM<br>
                              <b>To:</b> Li, Dennis <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                              Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                              Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                              Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                              <b>Subject:</b> AW: [PATCH 0/4] Refine GPU
                              recovery sequence to enhance its stability<o:p></o:p></p>
                          </div>
                        </div>
                        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black">Exactly
                              that's what you don't seem to understand.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black">The GPU
                              reset doesn't complete the fences we wait
                              for. It only completes the hardware fences
                              as part of the reset.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black">So
                              waiting for a fence while holding the
                              reset lock is illegal and needs to be
                              avoided.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black">Lockdep
                              also complains about this when it is used
                              correctly. The only reason it doesn't
                              complain here is because you use an
                              atomic+wait_event instead of a locking
                              primitive.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                              UI&quot;,sans-serif;color:black">Christian.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        </div>
                        <div class="MsoNormal" style="text-align:center" align="center">
                          <hr width="98%" size="2" align="center"> </div>
                        <div id="divRplyFwdMsg">
                          <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;<br>
                              <b>Gesendet:</b> Donnerstag, 18. März 2021
                              09:28<br>
                              <b>An:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                              &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                              Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                              Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                              Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                              <b>Betreff:</b> RE: [PATCH 0/4] Refine GPU
                              recovery sequence to enhance its stability</span>
                            <o:p></o:p></p>
                          <div>
                            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                          </div>
                        </div>
                        <div>
                          <div>
                            <p class="MsoNormal">&gt;&gt;&gt; Those two
                              steps need to be exchanged or otherwise it
                              is possible that new delayed work items
                              etc are started before the lock is taken.<br>
                              What about adding check for
                              adev-&gt;in_gpu_reset in work item? If
                              exchange the two steps, it maybe introduce
                              the deadlock.&nbsp; For example, the user
                              thread hold the read lock and waiting for
                              the fence, if recovery thread try to hold
                              write lock and then complete fences, in
                              this case, recovery thread will always be
                              blocked.<o:p></o:p></p>
                          </div>
                          <div>
                            <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                              Best Regards<br>
                              Dennis Li<br>
                              -----Original Message-----<br>
                              From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                              <br>
                              Sent: Thursday, March 18, 2021 3:54 PM<br>
                              To: Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                                amd-gfx@lists.freedesktop.org</a>;
                              Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                              Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                              Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                              Subject: Re: [PATCH 0/4] Refine GPU
                              recovery sequence to enhance its stability<br>
                              <br>
                              Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
                              &gt; We have defined two variables
                              in_gpu_reset and reset_sem in adev object.
                              The atomic type variable in_gpu_reset is
                              used to avoid recovery thread reenter and
                              make lower functions return more earlier
                              when recovery start, but couldn't block
                              recovery thread when it access hardware.
                              The r/w semaphore reset_sem is used to
                              solve these synchronization issues between
                              recovery thread and other threads.<br>
                              &gt;<br>
                              &gt; The original solution locked
                              registers' access in lower functions,
                              which will introduce following issues:<br>
                              &gt;<br>
                              &gt; 1) many lower functions are used in
                              both recovery thread and others. Firstly
                              we must harvest these functions, it is
                              easy to miss someones. Secondly these
                              functions need select which lock (read
                              lock or write lock) will be used,
                              according to the thread it is running in.
                              If the thread context isn't considered,
                              the added lock will easily introduce
                              deadlock. Besides that, in most time,
                              developer easily forget to add locks for
                              new functions.<br>
                              &gt;<br>
                              &gt; 2) performance drop. More lower
                              functions are more frequently called.<br>
                              &gt;<br>
                              &gt; 3) easily introduce false positive
                              lockdep complaint, because write lock has
                              big range in recovery thread, but low
                              level functions will hold read lock may be
                              protected by other locks in other threads.<br>
                              &gt;<br>
                              &gt; Therefore the new solution will try
                              to add lock protection for ioctls of kfd.
                              Its goal is that there are no threads
                              except for recovery thread or its children
                              (for xgmi) to access hardware when doing
                              GPU reset and resume. So refine recovery
                              thread as the following:<br>
                              &gt;<br>
                              &gt; Step 0:
                              atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset,
                              0, 1)<br>
                              &gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system
                              had a recovery thread running, current
                              thread exit directly;<br>
                              &gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery
                              thread;<br>
                              &gt;<br>
                              &gt; Step 1: cancel all delay works, stop
                              drm schedule, complete all unreceived
                              fences and so on. It try to stop or pause
                              other threads.<br>
                              &gt;<br>
                              &gt; Step 2: call
                              down_write(&amp;adev-&gt;reset_sem) to
                              hold write lock, which will block recovery
                              thread until other threads release read
                              locks.<br>
                              <br>
                              Those two steps need to be exchanged or
                              otherwise it is possible that new delayed
                              work items etc are started before the lock
                              is taken.<br>
                              <br>
                              Just to make it clear until this is fixed
                              the whole patch set is a NAK.<br>
                              <br>
                              Regards,<br>
                              Christian.<br>
                              <br>
                              &gt;<br>
                              &gt; Step 3: normally, there is only
                              recovery threads running to access
                              hardware, it is safe to do gpu reset now.<br>
                              &gt;<br>
                              &gt; Step 4: do post gpu reset, such as
                              call all ips' resume functions;<br>
                              &gt;<br>
                              &gt; Step 5: atomic set
                              adev-&gt;in_gpu_reset as 0, wake up other
                              threads and release write lock. Recovery
                              thread exit normally.<br>
                              &gt;<br>
                              &gt; Other threads call the
                              amdgpu_read_lock to synchronize with
                              recovery thread. If it finds that
                              in_gpu_reset is 1, it should release read
                              lock if it has holden one, and then blocks
                              itself to wait for recovery finished
                              event. If thread successfully hold read
                              lock and in_gpu_reset is 0, it continues.
                              It will exit normally or be stopped by
                              recovery thread in step 1.<br>
                              &gt;<br>
                              &gt; Dennis Li (4):<br>
                              &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: remove reset lock from
                              low level functions<br>
                              &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine the GPU
                              recovery sequence<br>
                              &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: instead of using
                              down/up_read directly<br>
                              &gt;&nbsp;&nbsp;&nbsp; drm/amdkfd: add reset lock
                              protection for kfd entry functions<br>
                              &gt;<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 6 +<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;
                              |&nbsp; 14 +-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;
                              | 173 +++++++++++++-----<br>
                              &gt;&nbsp;&nbsp;
                              .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 8 -<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 4 +-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 9 +-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 5 +-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 5 +-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              | 172 ++++++++++++++++-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 3 +-<br>
                              &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              |&nbsp;&nbsp; 4 +<br>
                              &gt;&nbsp;&nbsp;
                              .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp;
                              |&nbsp; 17 ++<br>
                              &gt;&nbsp;&nbsp; 12 files changed, 345
                              insertions(+), 75 deletions(-)<br>
                              &gt;<o:p></o:p></p>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                    <br>
                    <br>
                    <fieldset class="mimeAttachmentHeader"></fieldset>
                    <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C53db69e1b7aa4f35be2d08d8fa68e450%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534675736159049%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2B64LB%2B3suBOH%2B%2FbXN4mhr%2FCgfDlNRoi%2BenSYsWOurDQ%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="TeRNvROWJaurDSQ7gP5++40x7JQLoYdVepQzy7epIwRgVxAdGrjDT3jCaFCrIiNpLGREmYhkmVRGJ0mWhrWPfj6SahZqQEAxlgmiLQkmQ+J2P5nKSUYzH9qu/aexO3+VMvmG6AxK4JL1JlF2G/q1Q3xZu4uws3HnydVyGsflcMU=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                  </blockquote>
                </blockquote>
                <br>
              </blockquote>
              <br>
              <fieldset class="mimeAttachmentHeader"></fieldset>
              <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C53db69e1b7aa4f35be2d08d8fa68e450%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534675736169042%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ebDRToHq4YK7AxDdXtg2kdLC%2F2ox8myMKsYeslgXzkI%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="dkXmK7PqfGm2oXK4c0Zx3ZRfTfbSzLozPDGcEK1N42hkXMyDTCMWnWAf1zgoNoS9geLPfaa9XJTFWC0fEz2fsTbu1Xmimj0QxVxlmOIklhYk64GBtwWPdIoljzoHprSUb6cylFAeqJSiRAVFuKKLRy6gE9rPqrW576tB3FmO0ew=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------D6D535DCFC67C599848609C3--

--===============1120823990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1120823990==--
