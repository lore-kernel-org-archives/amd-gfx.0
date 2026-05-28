Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710BACD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 11:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C911410F04D;
	Thu, 28 May 2026 11:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqkbhSyq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F6A10F04D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 11:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHaaRuVWIm10STZHuuVyroHl5JhLLA/QMLrS/ywKuvXVnDP7dZaK2i5g0kxKHMGLeCXMpbWhcW3SgodMjyh2cqn5iJpvz8HGsv1TrukONDJvoEcKQIkUzpZfjPxpco5p070yhzfhJwiiGT2DId73oYVxEspGpDH3M7ciI2vsMqyoDXh/61rcRkcZM4DmppFjtM/by2ZGFMd7p0Ruxaxe+dR3wrikSnqMGKVX+9pBoZdBIu5q9w769Vz9k1wwEqRfoOyPpT906TMD+VVxtjW+BqO8I1XfTYPTKt4S3xTBvZKR2vJZBmuusZ3clwNy9X0fm5Gcleim+dUNkhmemubOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SerhyFQUedsuRCKnOnWc2ACewSQChUpkPaxWWNkHM0o=;
 b=ifxUv+C9onWwIXTxFGbT0fSwMg8IcAZZaMLbfJZdnJWMoI/hGO0MoVuE1LjvSEM6pkIA507D8sRCMoqmO8Y7aIozNQlvdZuIn9uxp7pEe9mfxPgCxxpZyu+NY0zXdXVfbPzbmq/QYG3BCXCtc2Qn5lH21jArU7SpJzPGNRNa9yBNZm2jag1JwLSAxTzknL++JnshW3sNya/A66fsMJhvYHIN46OMYPwV4845LNph6MlJwqyMq8FvCejU8hjwximzjRwe9XcP4ENA5ccA+C3dNbb5mV49tMluZ8cYbRSzxRKhDbLPdWMj2A44/Lp6vPGraD4RnVFag5eG4hiQ1IaZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SerhyFQUedsuRCKnOnWc2ACewSQChUpkPaxWWNkHM0o=;
 b=JqkbhSyqI97CDQhdzPeSCSf6u/WU0vqvYNtLXUn+evjmBqmUS/nLQEOoW1ev0jfdbUX/Hu6MLgx6MWwUBZ1pf2zOyunCNgckpeTG3HNC7g8UkZxlktDrTIDTrlqTYyUb0m+wW5m/dSAsznDJXFEbq5IYvFk5pvcVwC+nvTHdO0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 11:29:07 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 11:29:07 +0000
Message-ID: <a8ded005-e2d8-4163-be35-f1b018cefe74@amd.com>
Date: Thu, 28 May 2026 19:29:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>
References: <20260528062902.362031-1-honghuan@amd.com>
 <1e9480eb-24fa-4d97-9e4e-7120bf668f20@amd.com>
 <IA1PR12MB6435193DB8FBEFB4F4CEE093D9092@IA1PR12MB6435.namprd12.prod.outlook.com>
 <0b5ae36d-4045-4411-89bc-e779be98bce0@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <0b5ae36d-4045-4411-89bc-e779be98bce0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c045ae-0525-4502-0674-08debcac5434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9deKTbwCOzqIQsoKo5XaB/D2e3FD1E7smLjdd+eyVupO4bpiIi6PJ9i4TivnGqjE7bnWB2hb8H37C04Syfg/oXgng2uVcekKmtCWDJ7n95AU6gcC6M1VXK4FR5AbYNbn1igV2UDRBMjLbPrIBaX6M/6bOl+AP9OeLSSXxDQk1hKzpfNle/d9proE8Yr/0celSzoRJDpeARkwD9Tx7HhLBIKmZTH4QH66vTsLeMiHtqtrJR7lw7EHrITrUCn79gDgn69JNh9/FKT4FqYGdE2FXIiXZw+XDrM8daRPsDwpCARQL+qeoIGuQYtGvDUhU79LcEVZNyh7e/25Q5qXKMp6CfKMDOve2S7yX8UbBNKMlumSOiUYwQvQ3fBzTGLSWAuf9niwo/ZB5cRTlx5O6br5sXHNdiCKJrzI0i6/boyi6SRp5txyExa35P9I7TFyhQTF61szKJ51MGb4nUUl5BMJa0/qH3b1MYRnQmym0Gl9rnDZFAqywJnheD6/1fghiubXR0505r9IJ0YsVCoud+3YpZ+JvNK8fE6Hez0cEY2e7g7Ee/56BbxnQHL7LIRboMBKInBZaYYm4hiUK8kv6gS+s9Q1RZglCLV3+jbvm6CBPENIDJ6ZtZDqwih4odISUf4C3X1I2fIfWgdSL4/+/Kuwx/tRRkwjgVjsQiIgJlazLJ2M2xz+0XYTQntd5ZDrSsJy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hTclpuRFVPa3hlc3pldmtlNVlzRnNFcFFDbnE0Z09lcWZZYWhPbVZSOVZn?=
 =?utf-8?B?RkE4T2xVamtabStwTTRZaU54SjBWNXZHaFVBaWdMQnZkYk9GbmhEVGlrcnA1?=
 =?utf-8?B?Vm1NMnE3LzR6c01qTmJPV0I5RXM3NTgwSnNjNXk4a2tYTFNMMERCUzAvUmcy?=
 =?utf-8?B?ZWphQms1Ymk1eE5wemVxWWdhMGY3Umsvbk5MMVJBcW5tWXBmOTVJenpLZzkw?=
 =?utf-8?B?THVySkxpRVF2RzgvSlY0dU1RMnJESmZkalhNaVhXb3hoZmdtajBRbVFsV25K?=
 =?utf-8?B?WEErdlFzMEt4byt4aEtOeGJkV3B3cmYyNTBlcEdycjV0OVh0UTFjamYyU0lD?=
 =?utf-8?B?d2FJcmx3NG1JZ0dyYWFENW9nQVA2K3FwdFkxSUx6dWZ4L3N5b011eEpucld3?=
 =?utf-8?B?Vk5QNWlOQVQ2QmhrVWp6ci9rNWI5RlN1UDZFNXRQUXZJZCtKTTVoSEFpY2VU?=
 =?utf-8?B?QlUvTW9NcFJ4Z3hQSS9BVnN6blIvNkEzRC9xeWJoSFZxSkFYbGhpeHc4QkR5?=
 =?utf-8?B?cytJNVgwZVJvSER0enQwT0pUcm1XbzlYUzZyZG9CcjQwYUdwVTZJUmcvLzhk?=
 =?utf-8?B?R0hRL2RUVjRucWZEcFllVk11NFFCNFl3YWh1a2tiVE1sZ21yd3liNk10KzNT?=
 =?utf-8?B?L21yQ3Nrd29LMVRzdHdsaEk3ayttQmNPNm9jNWMvNVRjR3ZCZTE1R2Rpbmg5?=
 =?utf-8?B?ak16V3BRa1VoYmZuRER4R1dudk1xWGJnZ1k3a01udkh6SXJDRkJRNEttNFJD?=
 =?utf-8?B?cUVKL3l1U1R1OXc3dFNQU1JORG03U0g2dVlSREpWVUVaQ1pLQVpjN3l3eVRm?=
 =?utf-8?B?VUtuSG44T3l3SnJLNDlSOUZMTEhvclBhNk0vSXFhRnVYckVCVFNlUmFXS3Ry?=
 =?utf-8?B?UmFFc3gzeUJ3UlZ3dEwza3RqbVhHOUdobDZJaEpuYmJzWkFKWnZtZVU1S1RZ?=
 =?utf-8?B?VzhaaHZoeUdqZXBFNEZJeEg0TVJJcWhjeTkrTXVRY0U2b0xaZmh3T3NCc3pu?=
 =?utf-8?B?aFJNc2FKUk9aM0FiYU1oOGJvYkFiUXc0MHhreWNnK2JSY2ZiSDB0cHNmeStS?=
 =?utf-8?B?NGNlTWhycUMxZzBvQ0NPa0JBU0k4KzlEUGNwSU9Nc3ppRGIzNlFWbXphQ29B?=
 =?utf-8?B?U0haMzlwcTZ2MGJlWWVIZllic3RFVEtuRDgwYWJsSitrai9Xd1pOSUdFanA1?=
 =?utf-8?B?NWhndnhiSEhtOVhkUCszRXA3V0U3TitTMmhibFZEZmU2WnZ0ajA5bkh0UlNw?=
 =?utf-8?B?c01XNzRibnVidFl5K0NqTkxJRTFTbktoTlpoTmMva0dvQWpoZUNGc210TGpy?=
 =?utf-8?B?OXFLc1FpL0tZZkdZL2xrTDVhK3EzOHh1TU9mQ2pHb0J1V2UydnpEZ0NwcC82?=
 =?utf-8?B?TVRaYURFZDB0YmVhZzJBTDlxTXRFanltS09uM3pvNmlFQll3aUNUMk1jOG9s?=
 =?utf-8?B?aFNXRm1jN0w4U1pkcVM2Q3hJTDVYUFM3cUFkM29pcVk4c2h1ZWZYamE5c0RI?=
 =?utf-8?B?QkRWQ052ME0rWkpzcHRuZVMwMXcvaTFuUDJ0MU0zTHFaY3JPZkxYUUZwWHRr?=
 =?utf-8?B?ek4rQ0wwOU9lUnRqMWMxZVp4NndLY2FsZ1QvQVpNMlBwVEtRemhyZDFkMjNQ?=
 =?utf-8?B?N1YrUW9VUS85dnZObGhkMHRIY1lFckRyaHNrTnRjeTVpR1BtK0dKY3RJdTQ3?=
 =?utf-8?B?ajY1d3BrMjBYRlhOOVBkTVAzaUJlUlZyakFhcVczL0ZwNytZbWpHN2dDSHFu?=
 =?utf-8?B?SUYxTUd6eGxRajBNZExaZjNHSTI4MTg5VUZMQVpSOGx0NjhWM2xtOUdBOFZj?=
 =?utf-8?B?bm9VMEo4ejdvbXloTzlKdFVWTE9CTDRUKzJMZk5tRW40RXhLNzFEcHpiRXIw?=
 =?utf-8?B?ZlhPMVh1bEVsRlhzaUszL2JhOEZXRitESXl4VWY1cHU2Ly9lMWdkZU5uZzg5?=
 =?utf-8?B?ZUU0T2hlRk93aSt2ZlR6bUtOYVlOVGJyK0dEWUZQcGpFWkN6QUFJZ1I3MWdX?=
 =?utf-8?B?SGE1OUpsVGlmYlg1ZUVXY1hrTDNxVE9ubW9GODBXOWU2dS9pb21ESkMyWUNS?=
 =?utf-8?B?R2ZBbmF1aWxJY2dvYVR5TjVQN3ZiRlpsdmQxdklVeTkxYVdqOG91NTJ0bnZj?=
 =?utf-8?B?NDlkeGphaVBlWDNRYkNaMGU3Z2VTRjlncURlSThrYU1ZT29md0RRRXZjTUkx?=
 =?utf-8?B?aEhReTZocVByaUF1V3hNV1JKZVV3Ulp1SE5KRXUxM2xHYjVVbGN2MiszeHlp?=
 =?utf-8?B?VXhEWVVwTGp2eUlRdmduVnJHWTJlNVNnRE9Fa2ZjVjhSMHhaVlNlWlJaZXll?=
 =?utf-8?Q?Kpwu5AQj3Qb0Cq4zW7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c045ae-0525-4502-0674-08debcac5434
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 11:29:07.0039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4Hti1j0YzeIwf1A8hJri8J0KMySDdtJOf5R+MR3nYUw6N6KBeO2uMHdbXBo34p9iJ6MhGc/YZJiSyFbSfAgyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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



On 5/28/2026 4:06 PM, Christian König wrote:
> On 5/28/26 09:22, Huang, Honglei1 wrote:
>> AMD General
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, May 28, 2026 2:54 PM
>> To: Huang, Honglei1 <Honglei1.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.Liu@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: move notifier_seq read back inside retry loop
>>
>> On 5/28/26 08:29, Honglei Huang wrote:
>>> Align with drm_gpusvm_get_pages() (drm_gpusvm.c line 1416, 1440) which
>>> refreshes notifier_seq via mmu_interval_read_begin() on each retry
>>> iteration. Without this, a stale sequence number causes
>>> hmm_range_fault() to perpetually return -EBUSY, leading to an infinite
>>> retry loop at the caller level.
>>
>> Absolutely clear NAK.
>>
>> This is exactly the bug 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages") tries to fix.
>>
>> The sequence *must* be grabbed before the loop because it protects all pages and not just the one from the current grabbed chunk.
>>
>> What probably needs to happen is that we need to move the retry label or just completely stop retrying at all.
>>
>> Got it.
>> But in my local test, the test KFDMemoryTest.LargestSysBufferTest always fail.
> 
> I mean that's pretty much intentional. Testing is for falsification and not validation.
> 
> Either the use case is not valid in the first place or the test is not valid.
> 

Yes, under the current pattern this case is hard to pass for large 
system memory platform.

>> It can pass before. This case needs RAM size big enough to reproduce,
>> for some large RAM size CI platform, it can reproduce easily.
>> Maybe someone can else can double check.
>>
>> And I understand your concern about the seq scope.
>>
>> Would it be acceptable to just remove the internal retry entirely and
>> propagate -EBUSY to the caller?
> 
> Yeah I had a similar thought. I don't think the code should retry at all.
> 
> -EBUSY means userspace did something in parallel which resulting in the operation to not be able to complete.
> 
> So the only good reaction I can see is to abort and let user space or higher level retry.

Yes, and actually I think maybe there are two points need to be changed.
If we want to keep the retry tag, the retry need to be moved to the 
start of do while loop, the entire fault path need to be done again,
the previous 2G size chunks should not be skipped. The retry tag in the 
middle of the loop is meaningless. The whole range should be retry again.

And the latest seq number should be get when restart the retry. Or there 
will be a -EBUSY infinite loop when a retry is needed, cause the seq 
number never get updated.

This can be done in inside a function or outside a function.
If a retry is needed at a high level calling, modifications will also be 
required at other call points, and there are many places need to be 
modified.

However, even with the above fixes, faults in large intervals may still 
get stuck in endless retries. I got a the pages from a system with 60G 
of memory, memory changes are inevitable in my local tests.

Perhaps the better approach is to split the huge range into smaller 
chunks, like drm_gpusvm does with 2 MiB ranges, and get the pages and 
insert each one into the MMU notifier individually.
In this way, registration for a large area can be completed, although it 
will be time consuming.
But it's better than the situation of constantly trying again and again.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>> The caller already handles retry at a
>> higher level. Something like:
>>
>> hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>> r = hmm_range_fault(hmm_range);
>> if (unlikely(r))
>>      goto out_free_pfns;
>>
>> This keeps your seq placement while eliminating the infinite loop on
>> -EBUSY.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Fixes: 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 5d72878c8..ec0fe9044 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -192,7 +192,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>        end = start + npages * PAGE_SIZE;
>>>        hmm_range->dev_private_owner = owner;
>>>
>>> -     hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>>        do {
>>>                hmm_range->end = min(hmm_range->start + max_bytes, end);
>>>
>>> @@ -202,6 +201,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>                timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>>
>>>   retry:
>>> +             hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>>                r = hmm_range_fault(hmm_range);
>>>                if (unlikely(r)) {
>>>                        if (r == -EBUSY && !time_after(jiffies, timeout))
>>
> 

