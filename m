Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3CC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 05:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBAB6124B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 05:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBAB6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C646E16F;
	Tue, 13 Apr 2021 05:36:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9316E16F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 05:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM8Gv3xEflbnGS4miTIn++7Q4CJxeg/cGT1IEOWViJ5hrfYA0aGbcfVEkebjXF91bXnq6AGywdAu98AqmF430yqY+EtS/Fv9EbrWwX3K0TtN/tyeaVAZuNLFm5biTLzhV9GZPHXU+HtQTj3DXcjAgNHJjbFRlJi8A+NGytBD6o1QQJJ2AmW9cvhZqtE7jLYropRStfjJgamgYAY5M/ms9JRfxfkf/g2+USiwJsq7t1rNa/5CmHfitLscUhc3pFcf3MedqEx/Qm1FnuxGc+XSwQbP1+t+Gxt5sbXHI5hmL/3jzO/QXa63E0fw7m2Ru953t3fnGRhsznhJYjjiebSQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDYAuLu3hSvqC4u7JM4KGlU0ifEiADL7QQ5otGrmKhc=;
 b=UtNlybBJph08GQ4ol3IkAkKgo0vuSx7Z/qR98x2CYGFzUSFtbz5nq6xie79G3OwawzWDJEnO/RnZfVoZtBSjHQ4BhQJCAcInJN2NdYJxBtsHZ46hXnzIVHY2dwmdvGSM/6dujRIFWa+17kRs+DlJygxCjenrikfvKbe5J2RF0M3WtFvVQEGqEtJQ66vO1BYtbg6SXHeLBR3q+S+vAFF380Dc0WAcF0Q6hrzuwFK4Uje++Yv9+18peWOTdTQZaWucZkPPkUatTCAEyypu/enIB97IAe2K1n4JSbcmERYvkALJy+f0SBbht1ori1yRlrJ6Iy7D/unu3u4ePce2IFJ0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDYAuLu3hSvqC4u7JM4KGlU0ifEiADL7QQ5otGrmKhc=;
 b=SP7oO0DU5pfE2nJNH0cTiWUzZU6f7ThOglfJbXfws8uCp1NufiJ18foQ+dfAfCyelCkGA8SuXqWC018u8FzB9VZrp/v6j5MldLzL3U6oH4diXEnFrTvIbhy3ShMHFVOJpOekYpCqi24Q7kiwXKmfY2z9J1BNt/tidGE0n/apfJY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 05:36:48 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 05:36:48 +0000
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
Message-ID: <d7a44895-d6c8-7528-51be-ae08188ff1f6@amd.com>
Date: Tue, 13 Apr 2021 01:36:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
 (2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 05:36:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58cf7426-f570-4d11-9836-08d8fe3e2164
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4462BA8020800CB4FE84BE72EA4F9@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qn4hlrzERnQ2LVWFap2YcKnUpqMk0rIypmii4twL6LOMHpTMYurl029Hm6OkvKn0hgJn8VZPirVSGtldVm+vwVotnaKg/7dx/xMjK6VXut0mT/EC+7XMGxFYP3VG4WCEsHduMe+CyIPVOJH97up0rBvLYjKIv1I9TA6/3INAyoBuXv2HcXWqKWd0URGfB6M5aW20xr4TYtWb8TOeCeaWEjWRK+ynxR8KE/ypTtPz64T9MhOx1kgwukEa0Sv7BV7asoV9qAERgVibGAQG6y36bjSAN2Omn/Lgxes0vusTr3O9Orb6vw/FGaVTSCynOeD1c/ZB+MjZW/qJ1EGUGgRfC4fJUZZ8bDVyoNa+5wnKgrrYJ2hqSEvSmvxD+MSJ8N4A4l8+xv63vMPeoXKcAUAxxIS7oAcXRo8BqGSVEyw7v9TtyjKb41l/1iHhNnQCDYsOvMWngdKauKtpWXvrGYpz4rVpJ7cbYPTHTBbP+PenII1f6REPLYFZYwnQGWZodHOmCU/CKrPYi1EbRa3GuHc6+EFnOd+sfMPXSseU7/Wj5oeac/EnJhSES0FzsHwZ0FcjQDbX/oF8rzHk2JoD4RbhPxWfrbT/faeSSZypL1gx2toGefMys+uWnLim/InViYNT7S6jlJ5uVfPe9Jbw3txpNbclT18thTleZqbB+GKWoDIDUkXydI4PIcrgMDQPmFffXxJXFp2Tw7CD+VJEEVbhJBrYbLYveFND6IUGjrmQYi32ukuoJBWOmrDKIYqIcOMM32khjpggovI/TV1SvKafuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(966005)(2906002)(2616005)(66476007)(16526019)(186003)(66556008)(30864003)(66946007)(316002)(6636002)(166002)(38100700002)(8676002)(83380400001)(52116002)(36756003)(33964004)(53546011)(921005)(6486002)(66574015)(478600001)(44832011)(86362001)(31696002)(110136005)(5660300002)(8936002)(31686004)(45080400002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFVFTkFJY2l2bHhYOGlxYWJKaTF3MUd2bHdkejNaRzR3TGJ5NHFiVzg0MHA0?=
 =?utf-8?B?QmxuL3RaTk4zaTJ1cU1SU3dCdk9EYlJIK1UwTFFzbFJsemhpZ1Z3dlNhOUlp?=
 =?utf-8?B?aVIvUVlINGY0SzB5d2sxOElJNmNzNXpDL0tOYVFzOFBzdk9EWFJwREo4cXFN?=
 =?utf-8?B?ZXlFa2NNQ24wU21meW1NRElzaXJFdndhQzBNSHZGZGNwMnBmOFYrNU00WmxD?=
 =?utf-8?B?WUJVeTE0dU5VOGtTWjM2SzFFL1preUJUYVQ3QWNQcGRKMTBtOVZFTDRRbzg2?=
 =?utf-8?B?ODVIaE55d1MxcFd2aDhyRkFJTGltdEROQjN5ZC83ZndSaCtOMm9KcDFWV1hu?=
 =?utf-8?B?SGJ2REpublI1N1lpREowZEFlWTBZeDZJUGNNNmxxeFNGM2ZSUlVLbTlhc3hn?=
 =?utf-8?B?aUhIRTVOSTB5cWVTdCtuYUYwYTdrZGtFYXFXb1BzSU42QmpKVXk0bDBXUVI2?=
 =?utf-8?B?eTZQYzJ3dndic3JiMXoyTWJxK1FVdDlJN2NYdlNHYzNQWU5jcllqRlpSVzMr?=
 =?utf-8?B?TVFucEFSWVdBeDhodW1QajBUU0VkL0NVQ2VxRm8wUVVKTmZUamEwQUZqVGNr?=
 =?utf-8?B?OUo3Vzd1eHpvVkpIdXJZclYzaUdmSnZDMkVYM0tMMHZvWDhBN1NGN2ZZS1Ra?=
 =?utf-8?B?ZTlYeThJQjJZdUxqU0JHK3FKd1VkY1lVWkZ2MHJlSDczZVZ0UEY4dkpWWjV2?=
 =?utf-8?B?MGhRYUNHNGZOSzZSY05DQzluQkxwVExWRG5RdEtPSHl4dTgvR3k3WHp0UTM1?=
 =?utf-8?B?S1h1dUJ2RlF4UDZwSlhyQWV2WnpSK1FQeXlOQ3VKRDVEdlZCQUY4Z21ucDJV?=
 =?utf-8?B?em5yNnNyU2cxNk5UVDFhL1hub0FIaUVROHBFc3puQkJCY25JSFpxYnFOemRX?=
 =?utf-8?B?aGpjK21TVGlwZ0FKZzVBdXdxdnVGR0RSdUo1NkNxT05RTXBuWU5kdHZwNklx?=
 =?utf-8?B?VFh6b1B2Vk90ODRHNXQwK3ptZHArQWpJSjk4bjU2RlNpS3QvOUE5SGt2N3FT?=
 =?utf-8?B?NGY3a0RZU0tpajE0TDNLSVZ4SElEMlJwMXYyZUF2b1JTTmdXQ2tEQlFMNHhK?=
 =?utf-8?B?TGxYK3lkY1hTWjVFMkNwbCt1WHcxR21EQWRJTE1WZSs0N0Q2Qk5pc1h1ZGsz?=
 =?utf-8?B?bk10S3g1VVk3endUY1pLT2wvWEJXejlWRy9FNUYrQm44WGdKUDUxVEtZMXY3?=
 =?utf-8?B?bldjNVBiTWRXN2hKRmlOTEt1VlQ1VU82cDZwOTBGQngzQmxqMmNjejhSVi9k?=
 =?utf-8?B?UUlzTGFmRWVyRXVNWkovL1I4dVJFaDNGWDBFdkxua1MyUE1xWmJYcEhaZ3RV?=
 =?utf-8?B?RTA1eEQyU0dxdnBLeHI4SVE3YW9KUDhHRjFTSy9ETmVYRG4rMzBrWmJCeGd6?=
 =?utf-8?B?dDlFSjZaK1l4cTAwQ3NFZnVJa1RYY1l0TlFweVVCNERGcFZwRjU3em00WWVw?=
 =?utf-8?B?QkFQYU1hQzJ5OVEwbjd3Y2FMb2Y0WGM0ZlZPQTIxZ1QrcGN4Z3RpYmYxa0Er?=
 =?utf-8?B?TTg5ZmRIMHRXd1V2cDcrYnRRR1pGSWUrUU5tQzlmNzF2YzN4Wk1sMFh4NVdM?=
 =?utf-8?B?Z2g1RWxyekNmMFFaZWp3M3c4Unlrc2hmWFh2ZnIzOHJqQmIzalFFNGI5V2ZZ?=
 =?utf-8?B?L1VGamhGcUNkWUg4UE40MU5GUHE3N0loNVNBclpkdEhYR2FQTHM2eWxCcGtV?=
 =?utf-8?B?a2I5YllUVm1sakhzdmlwSEJhTEY1SlhjRlUrTUR5R2xqWlloOHFJbmtJUS9V?=
 =?utf-8?B?TnFZUEgvcXJlVW1SQ3E5K1d6TnFEOTNlcGgwS2pwelJ3enVkb0M3YlFoa1B2?=
 =?utf-8?B?aXFHT1phYkZ4OVcydldpVVQ3alJpTHZNQnZnbWtSVk9QN2xwZ2ZpbEpxcEp4?=
 =?utf-8?Q?2og69uC9gG4bv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cf7426-f570-4d11-9836-08d8fe3e2164
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 05:36:48.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPu2YtQUnDQ+V7SonbrL0Gk0qRioXHYHKrd7ZvDCvGfO/WqSqvUnz52CDi+2Fmx0nRkAN+fw10W6vT7P9RoIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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
Content-Type: multipart/mixed; boundary="===============1239200055=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1239200055==
Content-Type: multipart/alternative;
 boundary="------------9CD3D3ADDE953724F884E5E2"
Content-Language: en-US

--------------9CD3D3ADDE953724F884E5E2
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


BTW, I am not sure it's so improbable to get here in case of sudden 
device remove, if you are during rapid commands submission to the ring 
during this time  you could easily get to ring buffer overrun because 
EOP interrupts are gone and fences are not removed anymore but new ones 
keep arriving from new submissions which don't stop yet.

Andrey


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
>
> BTW: Could it be that the device SRCU protects more than one device 
> and we deadlock because of this?
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

--------------9CD3D3ADDE953724F884E5E2
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
    </blockquote>
    <p><br>
    </p>
    <p>BTW, I am not sure it's so improbable to get here in case of
      sudden device remove, if you are during rapid commands submission
      to the ring during this time&nbsp; you could easily get to ring buffer
      overrun because EOP interrupts are gone and fences are not removed
      anymore but new ones keep arriving from new submissions which
      don't stop yet.</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:2894bf97-8c39-6610-c479-b089c46513e7@amd.com"> <br>
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
      <br>
      BTW: Could it be that the device SRCU protects more than one
      device and we deadlock because of this?<br>
      <br>
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

--------------9CD3D3ADDE953724F884E5E2--

--===============1239200055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1239200055==--
