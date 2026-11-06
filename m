Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8D606A32C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LuOVn/HD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5360510E1C4;
	Fri,  6 Nov 2026 22:15:11 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5BB11302B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcaS8fdDyaiV62anC7M5P/XVLDSnk3OOyXBgT5THQBFiLtBbbVDQ6jjSfm/ybchd1TMxUghzXu9gKcp/tj3nQDAq59mG60q7ymPL5PjGSFf4vtqOFNkw2RKJQ0kFm5zB8J+JT39LrYSgr4Afs0Ssa3TyXY/7Nsq0h7bia1HOFBtoSfyagX+LQ8zaqqLvMo7+hsqTtCtnHZe9dNfKaZzIt0xZMyPZa/SjVxQWqCpkfmv1noKRoJCztvBvNZrskiTthQ45JW1JetlvHq16HtdlxRkgcZNSI/xUk14qT+2Sm2NoEUtZo65VLedt1DELV20p5LOUk92YF/oB+5vlqmay1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ4Wfqnlrr0D+yUUrqtXe2laVTpB2qitcXYSrbXmcq8=;
 b=o22Bc19VaUdQ7SLM8Hx/mnhy/Ehsof8bHCSEsV7ba8FsfRqK36PykRBUblEB7tCrEiVtS3y1IjNdXn53itzxmQFmh4XzziPcUMzJM2q0sIHLREvkJoU9NXTjhi5EQBks0fmmrcvpXVDiPzDHhTXR6kqcp7jKOSwPoEg/wVT9Q5pN/jU9/PfLp7rBCfAWn8C0PGsPjZzFoHIcZaDSLdbazIo+0zZuxArpQ988nT3UVd+gLN38eRImSl9W9JGWN5HMaKlFe33ghTW3XGagXM2zHfnrsdJjoG5xycwqAQyGu7MFhFSeLOlom2u2R6+3RKZ6jx5Q3ni0dDRYUyBE0QPnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ4Wfqnlrr0D+yUUrqtXe2laVTpB2qitcXYSrbXmcq8=;
 b=LuOVn/HD2i1ejxrD40Dkg794t5fYlEoiKd1vOJSzFhEg23SQYZDIvYfbhRmrdybprfwJuiASQxaTJpfh/kYI3tNO62rDrLhghDtycNeJ2RtJ+4a130y/LL/rZmKq2sWvbOKD1yXmDh6BZdIhVaR1TeVg3QoZyGnne666Dny8YaM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by CHAPR12MB999225.namprd12.prod.outlook.com (2603:10b6:610:2fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:15:02 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 22:15:01 +0000
Message-ID: <edc7cce0-612a-4aa3-9ce8-891a91a0772d@amd.com>
Date: Fri, 6 Nov 2026 16:14:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: Philip Yang <yangp@amd.com>, "Mishra, Apurv" <Apurv.Mishra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Faizal, Sahil" <Sahil.Faizal@amd.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
 <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
 <601d1612-ea3d-4379-9336-9c36e9485230@amd.com>
 <PH9PR12MB13592198ABB2BF96C9F290F41D9F6F2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <ee715a81-5643-4da7-a0b9-7205e34758b5@amd.com>
 <PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <39984cf9-fe4a-40e3-b076-20bea95f2127@amd.com>
 <fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com>
 <fe5c2998-f19d-4992-b87c-2a498fa109d0@amd.com>
 <fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com>
 <b312d42e-817f-46f7-8030-27c33265fbe1@amd.com>
 <b52094b5-97b6-46b2-a48b-16557626d259@amd.com>
 <70f0d067-2506-4ff3-997c-9c11402aab5f@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <70f0d067-2506-4ff3-997c-9c11402aab5f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS1PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:8:458::16) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|CHAPR12MB999225:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ca2b84-4cfc-4092-97ff-08df3c536695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|5023799004|56012099006|261021123027099003|261021135927099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: R6JiYO0CaYrsAuc1j9tDUJFsHU01u0xiTpVmJ6uJuTxfi8pjseE6fUHI0YSlcPuCVHBaI9NfVtCFNKT8FkA1C8aaIxe6FDCgrXaDi8I/iiFAR4G8AwlNA2M0zK9idH7MOwpfL86xxzPCnGOg8TbFZ7Lc3jHt83Ickj/HRahNIwjxOBGxRS0xPNVrqz6tUFFIe31ppy+Hpsr9I8R/RT/Qn2lqbGaDkTJIsf/ikOrsmv+kaLXyTKRJkpmxsgZ8IuTiVVKYiFLoRmAKkqgh3ujiq1KjMBG0wK2+ZfPkGDhgEi4lH2EfAKjr6QZm1ffSMi9qV4vlBCR+A7lh0VrUrgA61DvqXnUKx96YNKUSrUS7gskuZuV9oK6BaSvww8pjy7nYL6poaW9EW43WFCo79O25iS+T5xCXa6muHvEcRiJjnSMGkni0O6suKnRo4e4v3lGMKImDyFqcH7yXiXwZwKXtgKp2m222n1Weh34R4bLyygoR2v+VnvozI0HOGY0jrFLDKMEcu0b6c4TWHREmq9Z8WiSj4BcNP5tFwj45KVA2zdDxjcdZ7rjHSEbXf+OFNYy8C1BZ5YXJFIhUnJ3Fi6wMrw5RLHd8ime6Tz5XzAefrSc6ApaYZK6e9IHEW1XmdZeO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(5023799004)(56012099006)(261021123027099003)(261021135927099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzBZT1ZtWkhmL05kOWpaTzBvMC9kMVF4MTlIQWdaYXJnV3pERWkxMmJVcmhO?=
 =?utf-8?B?Y0F1RXZ4R0ZqNHpKY2JWMGhHeWJXbCsxeThNSU54NllsZ0N3RFV1eldvTkx2?=
 =?utf-8?B?T3ZxR3pwd2NiQnBrczdXM1o5UmJ1Q1c4TGJ3amcvZEI4cm5WOVZZU0o2Q3ov?=
 =?utf-8?B?UlJNb3psWGhJeFVHenh5MTdQc0lYaWpKK3hadmpoTU04SjhKeDkyblFjalg5?=
 =?utf-8?B?eFV2a1llYStnbnpRclF2aWdDODN6dG5pc1lWNUpaTUNWUmpHMUZZclo3enRI?=
 =?utf-8?B?ajc5L0pKT3QxOXZud3c4T1lWT3hrLzlYMWVKakFJZlR1WGVPUEU2RWgyYndx?=
 =?utf-8?B?S0hYdDdSNkxmTGhWaTZhT1RzaVFYRXhFYmZ1dkhkcUdGbmVzdXF2TUxqQUl4?=
 =?utf-8?B?YmFyNGxnMG5mUE1HN0lYZk5HY2xsQUJIdEd6UTIza2ovdmJLMEsrWFFRaHRP?=
 =?utf-8?B?V21pNDhWcWdseVUwRStCZHgvNzVMcWVwOEQ3WGVWZWxlWUVEaFkxbHBBaUVp?=
 =?utf-8?B?MDBQQWdNbmhITzd6c3R6ZnNJU3N5RVpDYXpRTHY2cCtWWWhoSmZGNDFBYmYw?=
 =?utf-8?B?R2hYUThVQ1BYWnkxWGlidFhZNDgyaTNUb2UyUGZ6bEtvT1k3ZEVzb3AveUtm?=
 =?utf-8?B?ZUQwUmVnbnFsRXgvWEFQbDlRWXY5YlNhWVJFdGFKcWRTbmJoanVrV2VMSzNy?=
 =?utf-8?B?dHd0aFFlWHhtWWc1ZSt4MlEwMkkwTkNqY0tQdlBxaHZERkpOUnFIVGZPMDJF?=
 =?utf-8?B?VkZLK29PNFVMWURteHdxM29HbjF5a3h2V2l1eHVHZmJuWE1qVGxTeVRSZXF3?=
 =?utf-8?B?Zm5rd1h3dlRka2gxeE5FdWV4YmtLZ2JNOFpNdmhTTnB6NE1hQUpHelVZWGlG?=
 =?utf-8?B?UnZ1RWc2UWszS2hhTEFwSXgrdVgzRnJxdGt0Y2RRckJYZm9hbDYrRnZkNnAy?=
 =?utf-8?B?aEtSNWNCUjd0U0VrbDJHdjhoaCtNMmpGeitXeFJiZ1lycjNNcXllSk5uNC81?=
 =?utf-8?B?YWQ1TWVHRnk5TGFENlJNTG5TRDFzdzV3RTJOSlpGN3FUZE9YZlREUWRoMGtL?=
 =?utf-8?B?YjR0VnZTdk0wNHp1U1RLeDVpWnFsSTdJdnErOTk5YWc0eEhCczZSN3g1eEp1?=
 =?utf-8?B?eDVaTGZybWhFUENoTjlDVVozVUhud3BJdXNxLzk4eHVNUWtJWjQxdHpWS3k0?=
 =?utf-8?B?VDJVU1NIZDdQV3RXcFM1UHprVzVIK3ZmeUhxb1RnU0xwL0lUUHlMekxZem9B?=
 =?utf-8?B?aXdnSnkyZ01VZ0pnblczVGdqV043WFJkMnphWXpHTEp6UXJyV2t5cEpZRnZ2?=
 =?utf-8?B?UC9HZmZtalhqUkFCaUowZ09Uc1liL0RDU3JMZjFYN3RvR2l2WjFVejd5S1NJ?=
 =?utf-8?B?NDJZVEdZbElYRHl2WWxFeU10TlZ1V3BxeU5XUUlubjhVNDFyclFwVEJybnlM?=
 =?utf-8?B?Mmw2dCtBS2lJVXJvVUJDZjNXYU1vZXlaVHZBVjVMT0hTV2pyVWVZUFRpTlNh?=
 =?utf-8?B?aFMvZlVUS1VHNkVqekwwKzdER3lLZmZyMzM5VFg2ekxoLzQ5WUNUcUo5M0hq?=
 =?utf-8?B?QkhZSmdkRFZzN256M3dpdFRKVUVFT2tUY2ZrbmFQZTd5aWRKNTZmRGlDejNx?=
 =?utf-8?B?QVJzRzN3ZWZ6dlBkdXIvWm02aXMyZ2oxUUJsOTRvQkpXbFUzRGxpbUMxa1Nl?=
 =?utf-8?B?cjUyTUZvTVcwQmpYRTY2cjM4SDY4RjJUQWZVNU9mbUdoWWg4TWRsaTZPRnZZ?=
 =?utf-8?B?NEdaK2tkanVlRnVoSUNDWGZFR1loYjVGTnpXU0hVdGplVXRtMUVwMzJqc3lF?=
 =?utf-8?B?YVNpVnE0UVZqQjVhdVdpTjd0UXNKWjNOSmxMbFVKWjFTckIxMXMzcFlBbUov?=
 =?utf-8?B?bnVaOHVUbHlMblI2RlRlaFJrUEFvT1NZbGFDS1BqSG9KYWd2TnNPNXFMZm1u?=
 =?utf-8?B?enAwVkxHb1ZmQlgveFU3UXpKWENuZ1NldSs3OEx5Q2VybS91bzFybHM1ZkVq?=
 =?utf-8?B?MVFQdldkUitIaWluVE5uNHFMdmxYOGxNT2xlUUxZRXpIZlBUWlh6eDRiS0p2?=
 =?utf-8?B?YjQrUnR0TzNITTUwTm9IcFlrTk1acmVBRXRvZk9Sc2U4bEUrRVF4akR2QjM3?=
 =?utf-8?B?UmhydFlla3lQWmpNYkF3K3IySVZDQnVrMklqZ0FhRWJVellOUE9aNHhIUVNl?=
 =?utf-8?B?WXFIZUZvdSthS1Q3OGc5ekRQeFlhSlVsekFjZHV1c0wxYVdhUEsrMEoxMWpN?=
 =?utf-8?B?ODAzeGhMdThjNHV5cjdwdk5VbkwvZXJwNzNEYWhEbW0zVy9SbWdBaGFaaXFM?=
 =?utf-8?Q?CIsVKgo5Gqec3qassJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ca2b84-4cfc-4092-97ff-08df3c536695
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:15:01.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5ZTbg49VrvEIWc4AVmrig88vpiss0tWjG70Dah0Fv31392n34AD1GyQ6SwFZqIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999225
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/6/2026 2:53 PM, Philip Yang wrote:
>
>
> On 2026-11-06 10:26, Chen, Xiaogang wrote:
>>
>> On 11/5/2026 9:51 AM, Philip Yang wrote:
>>>
>>>
>>> On 2026-11-03 13:43, Chen, Xiaogang wrote:
>>>>
>>>> On 11/3/2026 12:26 PM, Philip Yang wrote:
>>>>>
>>>>>
>>>>> On 2026-11-03 12:09, Chen, Xiaogang wrote:
>>>>>>
>>>>>> On 11/3/2026 10:57 AM, Philip Yang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2026-11-02 18:32, Mishra, Apurv wrote:
>>>>>>>> AMD General
>>>>>>>>
>>>>>>>> AMD General
>>>>>>>>
>>>>>>>> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following 
>>>>>>>> up on your comment...
>>>>>>>>
>>>>>>>> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
>>>>>>>> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, 
>>>>>>>> then |put_page()| (/mm/memory.c:3861–3864/). The extra 
>>>>>>>> reference outlives |migrate_mutex|. By then P's data has 
>>>>>>>> already moved to S, and the PTE points to S, so nothing else is 
>>>>>>>> wrong.
>>>>>>>>
>>>>>>>> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| 
>>>>>>>> reuses the |svm_bo| because P's pin keeps it alive. 
>>>>>>>> |svm_migrate_copy_to_vram()| then hands out P by offset without 
>>>>>>>> checking it, while |zone_device_page_init()| requires the page 
>>>>>>>> to be free. The fix adds that check where KFD hands out the 
>>>>>>>> page. When the pin is still there, the page stays in system 
>>>>>>>> memory with a valid PTE, and the next GPU fault migrates it 
>>>>>>>> normally.
>>>>>>>>
>>>>>>>> Mainline is the same. |do_swap_page()| now holds the page lock 
>>>>>>>> across `migrate_to_ram()`, but `zone_device_page_init()` resets 
>>>>>>>> the refcount before `lock_page()`. The race remains on 
>>>>>>>> mainline, because upstream KFD has no such check. My patch adds 
>>>>>>>> it. This has been tested and verified.
>>>>>>>>
>>>>>>>> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates 
>>>>>>>> as the fix needs to merge soon.
>>>>>>> This is the corner case I tried to fix with the patch 
>>>>>>> "drm/amdkfd: Fix svm_bo and vram page refcount". That patch was 
>>>>>>> rejected because we cannot take a page that is not free and 
>>>>>>> treat it as free and safe to use. The approach here makes sense 
>>>>>>> to me: if the page has not been freed, we skip it. With that 
>>>>>>> said, this patch is
>>>>>>
>>>>>> If the page has not been freed HMM page collect will set 
>>>>>> (migrate->src[i] & MIGRATE_PFN_MIGRATE) to false. The explanation 
>>>>>> from this patch is do_swap_page does not release vram page during 
>>>>>> cpu page fault recovery, then page collection by page table walk 
>>>>>> would see pte sill point to device memory, then not collect this 
>>>>>> page.
>>>>> This issue isn't with the source page, it's with the destination 
>>>>> VRAM page, which still has a non-zero refcount after migrating to 
>>>>> RAM. We cannot assume every VRAM page has been freed and 
>>>>> zero-initialise it, so we skip it and map to the GPU with the 
>>>>> system page instead.
>>>>
>>>> When HMM allows sys->vram migration on a vram page this vram page 
>>>> should not be used by someone else. In this case do_swap_page has 
>>>> not release the vram page, then data is still in vram, then 
>>>> collection will not collect the sys page correspondent to the vram 
>>>> page since the vram page is not available and pte at cpu page table 
>>>> still points to the varm page , then not enter svm path of 
>>>> sys->vram for this vram page.
>>> Right, the root cause is hard to follow. Let's start from the CPU 
>>> page fault: handle_pte_fault on a device-private page -> 
>>> do_swap_page ->
>>> ........
>>>             if (trylock_page(vmf->page)) {
>>>                 struct dev_pagemap *pgmap;
>>>
>>>                 get_page(vmf->page);
>>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>                 pgmap = page_pgmap(vmf->page);
>>>                 ret = pgmap->ops->migrate_to_ram(vmf);
>>>
>>> This is where it races with the GPU page fault. migrate_to_vram can 
>>> collect the system page, because the CPU mapping on the system page 
>>> is complete by then, and it reuses the same svm_bo, because the 
>>> svm_bo refcount has not reached 0 while vmf->page still holds a 
>>> reference.
>>>
>>>
>>>                 unlock_page(vmf->page);
>>>
>>> It then uses this device page, and svm_migrate_get_vram_page() locks 
>>> the page and resets the refcount.
>>
>> Yes, but the problem is this type of  vram page ref is not under 
>> driver control. When the vram page is allowed to be used at 
>> sys->device its reference must be zero. At zone_device_page_init, 
>> there is:
>>
>> VM_WARN_ON_FOLIO(folio_ref_count(new_folio), new_folio);
>>
>> If the page ref is not zero, WARN_ON(1) is triggered if 
>> CONFIG_DEBUG_VM is defined.  I think the kernel used on the system 
>> has no CONFIG_DEBUG_VM defined. Try kernel with CONFIG_DEBUG_VM=y you 
>> would see the WARN before HMM complain. HMM expects the vram page is 
>> not being referenced by anyone before use it.
> Good point — CONFIG_DEBUG_VM isn't enabled in our debug kernel build 
> at the moment, if defined, we would have caught this earlier.
>
>>
>> There is either driver reuses a page that isn't really free or a 
>> reference leak: a leftover get_page/pin, or a mapping that was never 
>> released. That is what I mean the root cause is not identified.
>>
>>>
>>>                 put_page(vmf->page);
>>
>> I think what you mean is this put_page at  do_swap_page was called 
>> after sys->device migration has began. Then the vram page is not 
>> released(dev_pagemap_ops->folio_free, or svm_migrate_folio_free not 
>> got called).
> no, put_page set the page refcount to 0 and call the release and 
> reduce the svm_bo refcount by 1,
If this put_page happen after sys->device migration(cpu paga fault 
handling has not finished, a sys->device happened on same range) driver 
would see the ref of vram page is not zero.  It maybe the cause.
>
>>  Then correspondent svm_bo is not released to ttm, then kfd either 
>> needs to wait the svm_bo got release, or allocates new vram pages for 
>> this sys->device migration. Either way the vram pages will have zero 
>> reference number when call svm_migrate_copy_to_vram.
>>
> yes, this triggers BUG in swapops.h
>> If it is what happened, it is a timing issue between cpu page fault 
>> handling and vram page release/then got reused. It is driver issue 
>> when decides whether reuse current vram pages or need wait, or 
>> allocate new ones.
> This is a driver bug. Another option would be to allocate a new svm_bo 
> rather than reuse one whose pages still have a non-zero refcount, but 
> that gets harder to handle in the partial migration case. Keeping the 
> page in system memory is clear and makes sense too, since the page has 
> just been migrated there.

Avoiding migration at driver can prevent HMM complain when do 
validation, but these vram pages may never got released, then cause 
other issues. That seems driver vram page ref counting issue, or these 
vram pages not got returned to driver.

Regards

Xiaogang

>
> Regards,
> Philip
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>>
>>> then drops the refcount to 0 ( put_page() has to come after 
>>> unlock_page(), otherwise releasing the page deadlocks.)
>>>
>>> Hope that explains the root cause.
>>>
>>> Regards,
>>> Philip
>>>>
>>>> If the explanation in this patch is what happened it is not driver 
>>>> issue. This type vram page ref count is not under driver control. 
>>>> Skip migration just covers the real cause.
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>>
>>>>> Regards,
>>>>> Philip
>>>>>>
>>>>>> If this explanation is right it is not drive issue. Driver does 
>>>>>> data migration, not decide which page can be migrated. There is 
>>>>>> contradict in this explanation. I suspect the real cause is not 
>>>>>> revealed.
>>>>>>
>>>>>> Regards
>>>>>>
>>>>>> Xiaogang
>>>>>>
>>>>>>>
>>>>>>> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Apurv
>>>>>>>>
>>>>>>>> ------------------------------------------------------------------------ 
>>>>>>>>
>>>>>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>>>>> *Sent:* Wednesday, October 28, 2026 6:41 PM
>>>>>>>> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>>>>>> Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, 
>>>>>>>> Harish <Harish.Kasiviswanathan@amd.com>
>>>>>>>> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that 
>>>>>>>> is still referenced
>>>>>>>>
>>>>>>>> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
>>>>>>>> > AMD General
>>>>>>>> >
>>>>>>>> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>>>>>>>> <mailto:Xiaogang.Chen@amd.com>>,
>>>>>>>> >
>>>>>>>> > The migrations don't overlap. |migrate_mutex| serializes 
>>>>>>>> them, but it doesn't
>>>>>>>> > cover P's last reference:
>>>>>>>> >
>>>>>>>> >    *
>>>>>>>> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| 
>>>>>>>> at /
>>>>>>>> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has 
>>>>>>>> finished and before
>>>>>>>> >      the function returns.
>>>>>>>> >    *
>>>>>>>> >
>>>>>>>> >      |do_swap_page()| drops its own reference on P only after 
>>>>>>>> |migrate_to_ram()|
>>>>>>>> >      returns, at /mm/memory.c:4851–4853/.
>>>>>>>>
>>>>>>>> Before do_swap-page drops the last ref on P the cpu mapping of 
>>>>>>>> fault
>>>>>>>> address has not been changed. Then at following sys->vram the
>>>>>>>> migrate_vma_walk_ops->pmd_entry will not collect this 
>>>>>>>> source(sys) page
>>>>>>>> because the address there still point to device private 
>>>>>>>> page(since you
>>>>>>>> got cpu page fault it is device private memory). Then 
>>>>>>>> (migrate->src[i] &
>>>>>>>> MIGRATE_PFN_MIGRATE) is false.
>>>>>>>>
>>>>>>>> If P got used at sys->vram, but P is still used by someone else
>>>>>>>> something wrong is in other places. Skipping migration does not 
>>>>>>>> solve it.
>>>>>>>>
>>>>>>>> Regards
>>>>>>>>
>>>>>>>> Xiaogang
>>>>>>>>
>>>>>>>>
>>>>>>>> > So, the GPU fault takes |migrate_mutex| legitimately, while P 
>>>>>>>> still has |
>>>>>>>> > do_swap_page()|'s reference. KFD gets P back without P ever 
>>>>>>>> being freed. VRAM
>>>>>>>> > destinations come from the |svm_bo| by offset (`cursor.start 
>>>>>>>> + j`), not from a
>>>>>>>> > pool of free pages. That |svm_bo| is still alive because P 
>>>>>>>> holds a reference on
>>>>>>>> > it until P is freed, so |svm_range_validate_svm_bo()| reuses 
>>>>>>>> it and the same
>>>>>>>> > offset gives P again. Nothing checks whether P's previous 
>>>>>>>> user is done with it.
>>>>>>>> >
>>>>>>>> > Regards,
>>>>>>>> > Apurv
>>>>>>>> >
>>>>>>>> >
>>>>>>>> > 
>>>>>>>> --------------------------------------------------------------------------------
>>>>>>>> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>>>>> > *Sent:* Monday, October 26, 2026 5:27 PM
>>>>>>>> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>>>>>> amd-gfx@lists.freedesktop.org <amd-
>>>>>>>> > gfx@lists.freedesktop.org>
>>>>>>>> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>>>>>> Guiza, Alejandro
>>>>>>>> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
>>>>>>>> > <Harish.Kasiviswanathan@amd.com>
>>>>>>>> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page 
>>>>>>>> that is still referenced
>>>>>>>> >
>>>>>>>> >
>>>>>>>> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
>>>>>>>> >
>>>>>>>> >      AMD General Hi, @Chen, Xiaogang 
>>>>>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>>
>>>>>>>> >      <mailto:Xiaogang.Chen@amd.com 
>>>>>>>> <mailto:Xiaogang.Chen@amd.com>>, thank you for the review. The 
>>>>>>>> two migrations
>>>>>>>> >      don't overlap on that address; they run back-to-back. 
>>>>>>>> What overlaps is the
>>>>>>>> >      lifetime of the VRAM page. This was reproduced with ASan 
>>>>>>>> and XNACK, which
>>>>>>>> >      make concurrent CPU and GPU faults on the same ranges 
>>>>>>>> frequently. As per the
>>>>>>>> >      logs (ROCM-31012 
>>>>>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012 
>>>>>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
>>>>>>>> > amd-hub.atlassian.net/browse/ROCM-31012>): * A CPU fault 
>>>>>>>> enters /
>>>>>>>> >      do_swap_page()/, takes a reference on VRAM page P, and /
>>>>>>>> >        svm_migrate_to_ram/() moves the data to system page S. 
>>>>>>>> The PTE now points
>>>>>>>> >      to    S, but /do_swap_page/() still holds P until 
>>>>>>>> /migrate_to_ram/()
>>>>>>>> >      returns.  *    About 66 µs later, a GPU retry fault 
>>>>>>>> migrates the range back
>>>>>>>> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is 
>>>>>>>> correct here, because
>>>>>>>> >      the data really is    in system RAM.  * KFD reuses the 
>>>>>>>> /svm_bo/, which P
>>>>>>>> >      keeps alive, and gets P again as the destination. 
>>>>>>>> /zone_device_page_init/
>>>>>>>> >      (P) runs with ref=1 (traced) and overwrites the 
>>>>>>>> refcount.  *
>>>>>>>> >
>>>>>>>> > How KFD reuses same P? From the description above CPU fault 
>>>>>>>> has not finished
>>>>>>>> > because  svm_migrate_to_ram has not returned, P has not been 
>>>>>>>> returned to KFD
>>>>>>>> > driver, so P still has reference count.
>>>>>>>> >
>>>>>>>> > Then GPU page fault happen on same range. For each migration 
>>>>>>>> on a prange there
>>>>>>>> > is prange->migrate_mutex to have migration on the prange 
>>>>>>>> happen exclusively.
>>>>>>>> > Then how can svm_migrate_to_vram enter migration if 
>>>>>>>> prange->migrate_mutex is
>>>>>>>> > still hold at svm_migrate_to_ram?
>>>>>>>> >
>>>>>>>> > My basic concern is a vram page can only be involved at one 
>>>>>>>> migration at a
>>>>>>>> > moment. If it is getting migrated in two migrations at same 
>>>>>>>> time with difference
>>>>>>>> > direction there is syn issue. Checking the page ref here to 
>>>>>>>> avoid migration is
>>>>>>>> > not fixing the root cause.
>>>>>>>> >
>>>>>>>> > Regards
>>>>>>>> >
>>>>>>>> > Xiaogang
>>>>>>>> >
>>>>>>>> >          The CPU fault's /put_page/(P) frees P mid-migration 
>>>>>>>> and clears its
>>>>>>>> >        mapping. /migrate_vma_finalize/() misses that PTE (263 
>>>>>>>> of 264 restored),
>>>>>>>> >      and    it's left pointing at S. S is freed, and the next 
>>>>>>>> /hmm_range_fault /
>>>>>>>> >      hits the    BUG_ON in /swapops.h:504/. The trace and the 
>>>>>>>> panic registers
>>>>>>>> >      match this page and S exactly. With the fix, the 
>>>>>>>> /refcount /check skipped a
>>>>>>>> >      busy page 705 times on the repro host with no panic. 
>>>>>>>> Regards, Apurv
>>>>>>>> > 
>>>>>>>> -------------------------------------------------------------------------------- 
>>>>>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
>>>>>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> 
>>>>>>>> *Sent:* Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
>>>>>>>> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>>>>>> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org 
>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
>>>>>>>> gfx@lists.freedesktop.org> 
>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org 
>>>>>>>> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, 
>>>>>>>> Alexander <Alexander.Deucher@amd.com> 
>>>>>>>> <mailto:Alexander.Deucher@amd.com 
>>>>>>>> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro 
>>>>>>>> (Alex) <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
>>>>>>>> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
>>>>>>>> <Harish.Kasiviswanathan@amd.com> 
>>>>>>>> <mailto:Harish.Kasiviswanathan@amd.com 
>>>>>>>> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
>>>>>>>> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
>>>>>>>> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
>>>>>>>> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero 
>>>>>>>> refcount and    leave those pages in system memory for this 
>>>>>>>> migration. When an svm_bo is reused, a VRAM page can still be 
>>>>>>>> held by an in-flight CPU fault (do_swap_page -> 
>>>>>>>> svm_migrate_to_ram). Migrating to VRAM then re-initializes the 
>>>>>>>> page via zone_device_page_init(), resetting its refcount. The 
>>>>>>>> fault's    late put_page() frees the page mid-migration, so 
>>>>>>>> migrate_vma_finalize()    never restores that PTE. It is left 
>>>>>>>> pointing at a freed system page and hmm_range_fault() hits 
>>>>>>>> BUG_ON in pfn_swap_entry_to_page() (swapops.h). If there is cpu 
>>>>>>>> fault the data is in vram page. If at same time driver is 
>>>>>>>> migrating data from sys->vram migrate->src[i] & 
>>>>>>>> MIGRATE_PFN_MIGRATE should be false since the data is already 
>>>>>>>> at device side. Then if you got a MIGRATE_PFN_MIGRAT sys ram 
>>>>>>>> page at svm_migrate_copy_to_vram after migrate_vma_setup, but 
>>>>>>>> cpu page fault also happened on same page there is a 
>>>>>>>> contradict. So, I do not see this scenario can happen or the 
>>>>>>>> real cause is revealed. Regards Xiaogang Signed-off-by: Apurv 
>>>>>>>> Mishra <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>>>>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>>>>>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>>>>>>> <mailto:Apurv.Mishra@amd.com>> --- 
>>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 
>>>>>>>> +++++++++++++++----- 1 file changed, 15 insertions(+), 5 
>>>>>>>> deletions(-)    diff --git 
>>>>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>>>>>> b/drivers/gpu/drm/amd/    amdkfd/kfd_migrate.c index 
>>>>>>>> 8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/ 
>>>>>>>> gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 
>>>>>>>> +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>>>>>>>> struct svm_range *prange, amdgpu_res_first(prange->ttm_res, 
>>>>>>>> ttm_res_offset, npages << PAGE_SHIFT, &cursor); for (i = j = 0; 
>>>>>>>> (i < npages) && (mpages < migrate->cpages); i++) { - struct 
>>>>>>>> page *spage; + struct page    *spage = 
>>>>>>>> migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] &    
>>>>>>>> MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << 
>>>>>>>> PAGE_SHIFT); migrate- >dst[i] = svm_migrate_addr_to_pfn(adev, 
>>>>>>>> dst[i]); - svm_migrate_get_vram_page(prange, migrate->dst[i]); 
>>>>>>>> - migrate->dst[i] = migrate_pfn(migrate->dst[i]); - mpages++; + 
>>>>>>>> /* + * A reused svm_bo page may    still be held by a CPU 
>>>>>>>> fault. + * Reinitializing it would free it under this 
>>>>>>>> migration, + * so leave this page in system memory. + */ + if 
>>>>>>>> (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; 
>>>>>>>> + migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
>>>>>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); + 
>>>>>>>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } 
>>>>>>>> } - spage = migrate_pfn_to_page(migrate->src[i]); if (spage && 
>>>>>>>> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, 
>>>>>>>> spage, 0,    PAGE_SIZE, DMA_BIDIRECTIONAL);
>>>>>>>> >
>>>>>>>
>>>>>
>>>
>
