Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55051C46CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 17:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8AD10E0A2;
	Mon, 11 Dec 2023 17:23:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE72910E0A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 17:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUt2iPyDZYo4SDN0UIPi6Mpv9eOI5DThXAfne3TkHn6QqkHtbpfITkJGtcaDl4MBz5wxRqrLMRY+lbKzvjrtY0ABagwA0/3OTopSNcP2BIMwGWoLqY7d0J0TC1IG+sDPKQvPeFN/DqcGCEyn2EunO+IER3McTGy3uy1lp5VbEx+EyCmeg/5GNc/J2bcZW3DlM1+gaTbGcgB4k8P1eVLTEBItihM9wKBLbYv4qE2xkXOgrXCS95MRhDAC4INq4I0EmTy0L5m1VipdqCikxCksyRHXIGEFP2b5HkR7h0gNAXKgmZrAcmsiSQRig1aLYpRR+D9xSIa8UKPA+aDzWganXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM0wfCSvU48X7vLEdVA7T9RtS22Z2NP6L/ti2QYRWDQ=;
 b=V7qYPFjxH1Cj2r9SGjT26QA4ltIdtUPUhHtdYFmv/ynaOi+V/R6N/1qzCY2aXZROSOFSvyKSucMy/42e8Tztump+5gXvpQM0seoKg8Klrl23Gok+3Jo//naeCQtl+9K+iMApNr5JTIOLuwCa11xguFMqxWoBE2UZrkFkLXmXRDTOELuRJFh0OZyYs1YtpfIkClO9mSYK43wW84l9CJTtPQ4a2mDEz/ofg7SzyQ1qwl0yjYqSq17xW84DAWKnA/sW2zpKtMjehf6XdOkEXGmP7x+92ah+2EB/RWFfgil7oqMJ5eJQD0gAhPymGN+cqHm1Qa5qC1uccFHbdHU6Q9AVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM0wfCSvU48X7vLEdVA7T9RtS22Z2NP6L/ti2QYRWDQ=;
 b=FX9rQV1287XJWfZd0+BanY6ifYpARNl0CBccNmqE4dwfCt/xayiTXakorgp6ehW8b0ojfW012vxdFq7w8ix4pWGUUk35c8NtyEhijfdLR5x6Msl3v7xDe4wbLd7pW4S3tuoATi9Io/KXghbgOnrFIAeIeoV5kaQf9Tc83CxO3Lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:23:04 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:23:04 +0000
Message-ID: <55ee7375-c3d7-48e6-bc4a-1a24a664d07c@amd.com>
Date: Mon, 11 Dec 2023 12:23:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: make an improvement on
 amdgpu_hmm_range_get_pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
 <20231208230105.733781-2-James.Zhu@amd.com>
 <a7821e98-8066-4870-b41d-a57e7f04a2f5@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <a7821e98-8066-4870-b41d-a57e7f04a2f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::29) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4a0584-fb2d-4c5e-d19f-08dbfa6dd522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFxWLqfbdRr06CVUA2lInY0EeHbZld9e1JHN8DaKIRgcOwscGhryrvAhOsnhLMoSb6fkxXQjPJ/zu/kb+hfMoE6RuUbFuNnNfAo/9bOMaFjkdTCD/jh8rH9C1VFSBT9F95sSkhGdtWV6wyn9d86h0raiggDIaXo7QsF+uEZHGVoQrLfLly0VgBsGtN/oE9JTmS6+m3o2qb5BlsXywd/z9a4SbrdHgUqUBbqAmUPMtZab4mHT6lKokjibJwiquvyPNnnAjdGWEqankwj6zN/Z/3QdpJ26RGqJ7V2Msm3An2uJC18DEqqZa9SeDJQxcjdSFDmLp9HDqi7OD72k5K6Tbr/3vBrzuQBdNKLtQzJoJ8z4TlfFEMzesVcUCO3Xnb+3MnoBaYU8G7IrTyH9/cPOstHLD4OKUOIoo1MaAPiwUE1BW3nfw7qKMPtII2GWRYPNeA7tlx0Igin4CLI4gVQ11XkFU12DAAzWk9F0Hh3takQ24NdyJkRmPNZAw12k5DyYxG8NJ4TKfY5aHmfU0pQ1XIDhYZYRne7fofAdffzaYUcLLA3Z4odh+iA+gchILdO76pVAdMB4ENe4h4RczeE9Q24fLrAEiVGQ/mGGVeXZJBc0DQ9r6qSNNb4sE83PQcvOVa73xGagZNSUazqtc/2Z3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6506007)(53546011)(31686004)(6512007)(36916002)(36756003)(6666004)(478600001)(6486002)(110136005)(316002)(66476007)(66556008)(66946007)(31696002)(8676002)(4326008)(38100700002)(8936002)(26005)(83380400001)(66574015)(5660300002)(41300700001)(2906002)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdzYkFCMUE1NVpqSFVqczVJcTBaU1RLMHNPR0txZFFvdVVXRnAxQXNIcE9k?=
 =?utf-8?B?QnE4ZjF4MkY3LzJ2NUMwQm15cll1VCsxeVV1S2JVNWF2QUl4emZ2aGVyTk1Y?=
 =?utf-8?B?QTFVZHpTYW5BREk1emxmZ293NTYxcTV2akZzYXl4OEg3aVZ0Y0w5NDlMbGVj?=
 =?utf-8?B?T3U4Mmkxei9iSC9oT0ZiZ1llb3ZhNFdwZ3g4SUFSek9kZC9kcmp2KytGejVm?=
 =?utf-8?B?cW1DdWovSUtuQ0hnYm5TZklNY2ZnRGlDUUhuakg1aGlPWUR4Mis4YyszRENv?=
 =?utf-8?B?VjdRUE5aUG5QMDVya1N0S0RndXZwZCsxSllqODBjVUlMbVQ3eDgrUm8wR2h6?=
 =?utf-8?B?a2t6dmI2M1VuQVVyY3E0SnZSTmRWSmR3UDVaY0RWK3MxamJWM09JUjFhMXVK?=
 =?utf-8?B?V0k1QTlyNHVVZVB4dk8zdnE0NWpKZ2s4NmdYcGFaY1N4UGdWa0pUbXlISHZm?=
 =?utf-8?B?MldsRzB3SllBOE04bFpQd3FqN2NrUFc1RDZjZk04N3N5ZU85ZDVPT01UV3BQ?=
 =?utf-8?B?SVFsZllJMkp0dTBGa215NkoraURCTmlMNzNGSkNYa0FMbjRuWUdFSjR0b3U0?=
 =?utf-8?B?dWpRQzlJbTdyOE1id2VNb05UdHByd01COU1DZXhKTXpCbWFURFdjQXFRU2c2?=
 =?utf-8?B?RXMzUlhRRUZnalNvQTh1VjJQNEErWlhwNHY5YXFGWHN2TWNxSmo2SkdrUmJV?=
 =?utf-8?B?NnpwSGhFK0x1S2tZTVRpMHhjWHpNd1dkc2lRL3ZQdUdDdld5T1VFeGxOSE5P?=
 =?utf-8?B?RkpZYm5tUkg5aERISGF5YWw4ZTZQLytVZHlQSlpqcC9OY0lxOTByeDlIbW9r?=
 =?utf-8?B?c0ZGeHJ2ZzZrYWJacDB6OUNWSWd2NFpIQk5kY2NhcnQ1RUJGQzVMUVhXUlpr?=
 =?utf-8?B?SlVhT3FPMEMzV3ltQUluY3k3RGRRQjdXc3lNY05waTdxM2JnNHJ6bXJhN3Zn?=
 =?utf-8?B?MHl4dlJ2b1AzRTcxVGhvY21zMXllSFlHTDVneWNXL1RSWXp3N1dkRjBXV3Fm?=
 =?utf-8?B?WVdCb2E2RlZYb21OcUJ5QnJNRnl0eWRPZjdGZFdzeGQxNzhqZWRhblQrYk85?=
 =?utf-8?B?QUg3UXRMTFNkYjFkSUl3eWY3NGpVYWdNOVJPVFRTOHhScGpQNU43K2ZzVTVa?=
 =?utf-8?B?d2E3WTQ1Q09kWHBRbFIyQ1h4MENUTlR3bXZPT3l4UEU1eVlzWlZGbDRxY2lh?=
 =?utf-8?B?dXByMUhpdXNUZnduSHF4ZElFMTBnVDZnN2JzTnVqNEVERGIweDc2aG5zY3Z2?=
 =?utf-8?B?RWZmSUpObko5bnFRNDN3K05PR2pBYVNOT2xQbEhudnZmZXlkdlVPNjBiZ0ZE?=
 =?utf-8?B?MFBld0hjWVNwSHovRVJyTXhyaVV0U1BxWmJWSjNLeXBvQmtkeGtrT0lkU3h4?=
 =?utf-8?B?VGlzWTBxVFZHQTZMcEJiVXhSQlVSb0V6NkN3QU1zcS9kMVJCWWlpK0FNRXkx?=
 =?utf-8?B?WnhBYm1Ld0hrTVNURjJ1M0pCWjE0OVh3SDd1V1VEaU45cnBIVVVlTUtraTdi?=
 =?utf-8?B?eXZrWU85eVh0TGNFZkZzVkZoS0lNSitGMy9UM3dCcDBKQzNKZ3Y5L0FnQmgv?=
 =?utf-8?B?anpYUXVWek5WN3M0Slg3TmNSN1dXYVpmWTRKR2VOc0J5S3Z1UVFyMEdvWW1O?=
 =?utf-8?B?dDJJUEE0VEM2dmpqb1d5WGVMLzBtSWVPd29NZGJYU2ptTUs3eEVDTHpvMU5V?=
 =?utf-8?B?T3lNb08rK1BqSGJwa2RQMmt0czVjYTBQR1lsSHhMRWtnTVpWZURaWm1XTW43?=
 =?utf-8?B?aTVNbk9lejBkaTZpTWsrdFVUK1E1V2VhZU1EejhCL0hXendRd1B5dmMvMzFl?=
 =?utf-8?B?cDBpeVpLVEFyQlR4WlVPTmxIbXhYbnVHUXdJUmFDbDljZXpsckdoS3hTVHh3?=
 =?utf-8?B?TUoyUit0MFlnRTBjUDNIb09ScWlpVnZjY1RoZjZPNldlblhLaUlJb0RMQnBu?=
 =?utf-8?B?M05FTW9tQmRUaFVqdmt3MzgvekFhcHVMNkgrMDJmd3FlRXJLUHNWa1A5K3Qr?=
 =?utf-8?B?Z0tVajk5OXRuTDRQQlExZ3N5MHp0UFlQWDJtSHNhVkh5Nk5wL0FoejFwOE1O?=
 =?utf-8?B?Sm5Ka3dDZWNZa2FDM2VtcGtTYUpGNVp2OUhzcjF5VlhrS0NyZmxzbG5qKzJO?=
 =?utf-8?Q?FQOLn5JloghKFw9FFOZ1FzC58?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4a0584-fb2d-4c5e-d19f-08dbfa6dd522
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:23:03.9251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9wiiUWHaSa/RCNICXUwl3KPNNmk9ze4TDNZIHC8T33996+vsCvsQChFazLKDBgp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cc: Philip.Yang@amd.com, Felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-11 05:38, Christian König wrote:
> Am 09.12.23 um 00:01 schrieb James Zhu:
>> Needn't do schedule for each hmm_range_fault, and use cond_resched
>> to replace schedule.
>
> cond_resched() is usually NAKed upstream since it is a NO-OP in most 
> situations.
[JZ] then let me change back to schedule(); Thanks!
>
> IIRC there was even a patch set to completely remove it.
>
> Christian.
>
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index b24eb5821fd1..c77c4eceea46 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -199,6 +199,7 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>           hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>           r = hmm_range_fault(hmm_range);
>>           if (unlikely(r)) {
>> +            cond_resched();
>>               /*
>>                * FIXME: This timeout should encompass the retry from
>>                * mmu_interval_read_retry() as well.
>> @@ -212,7 +213,6 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>               break;
>>           hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>>           hmm_range->start = hmm_range->end;
>> -        schedule();
>>       } while (hmm_range->end < end);
>>         hmm_range->start = start;
>
