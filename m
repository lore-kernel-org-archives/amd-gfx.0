Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5BAE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 16:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD6C10E269;
	Thu, 12 Dec 2024 16:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jgw2+nBf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F197010E269
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 16:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkKCFceRdMYUrBjmV/5FJz6PFkZCQ3K9hpbn2iHwkPnaTLj42Rw1idfovcD6jORsLKa9R5qQh4n8ZxGldyAVySj+JZGQHc212rXgtz0msNlQfvuk2OyCZzUnibKyaN0fZDeVlwsSwfHsvtdjlQGVV1VG16l1K6/jWeDohab+bQeJGPmiWzKon4j7F+mlemUBReJHSe2yAssNNuY3GV75qIC+rURcvsqPBsHouHSygRj7dO4ZK1iNCrlUKYvRtsnSuMMEEgrC/whSuCmCxg8aKIF7ohQ0XRlxAzFMfyl8Nz0vdYzu/KAaNhL66hhE1FRecDSGy1KxHYvH2qWQ6EVEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awgTcEVt8L5h+gon7OV6zkGYRW7d9jL3/7TbdmRlBhI=;
 b=qIHvQh3W+sqwHqKhJ1BN44GxPVcLL6OLrWajl2YxtZ1wLQ9J2x+NMGcu9pAFpT5eDYaC8QwtBhAXsMozxF014Tg4sWDNncVIcH/tUMpyMQ7UsCLmqED95sMu8B4rQGJx+4s/IyqJB89SqURTEZGdAaBnyHxlSPexxU5rPsGP0WxVUM6tP+5RZk67KJlNWQ4T7CY+P6laDjs6hum1oxsyTEfkAYfAhMTxDBlOn0Gy5B3rRMhlexCGGBceGs+lTpp8O8rhoDA/0fY9zbWsK/+kvXqqTWwtuOkNNOlnihtCLhxF88EeUF0qFX4B3mjJs+1n0cghppiVe0dycYvUWtdUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awgTcEVt8L5h+gon7OV6zkGYRW7d9jL3/7TbdmRlBhI=;
 b=Jgw2+nBfBeRun/MK+Q7JmqMbd2+Cfq6Ldu0LRGsGkuTcxzPk2++UCM3qWxuZmfT59uFg34EZyVNLR5Q5BIzizoZznXTirt1gjTR2lufv68Mxc/XqmUiWcdalqdT5eEp9FxlJwbFjo6lr5Gi5jvbit0SxwTOUggxOuX5u0EQ6nw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 16:17:39 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%7]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 16:17:39 +0000
Content-Type: multipart/alternative;
 boundary="------------MvfNdFzbDWHhjc3mLGzw5Oxm"
Message-ID: <b258a347-1c56-4292-8845-373aa811fd14@amd.com>
Date: Thu, 12 Dec 2024 10:17:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: wq_release signals dma_fence only when available
To: Zhu Lingshan <lingshan.zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241212030611.8513-1-lingshan.zhu@amd.com>
 <0a02fdfd-7771-4a8d-be15-1e8eaa6d631a@amd.com>
 <40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com>
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 11703b5c-1793-4abd-e44a-08dd1ac87f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3EveUYxMENnU05FTVJsWUpkSmk3eWUrb2FKaVZnb0VWOVdLalBjNFRMeWFU?=
 =?utf-8?B?NjVyeHZhVEdPUWRtbWljdGFHUTc5TjRpODA1dU5oMWJBL1FwVXp0YzVaRTVy?=
 =?utf-8?B?UHl6YkIxOTdtbVk4dytnK2E1R1ZWWHNwaDZuM09LWEt6VUo5RWNrTytXUFFk?=
 =?utf-8?B?emtQbmkvaGYzTWZFcGlwL0Y2NXhwY3NYTnhVV1pkajM3TC9ERjNydVE2VlVL?=
 =?utf-8?B?U1haQ2pCS2hwZWpwd3NiQWdaQUFvakVwSHBKZWxvMW05MHVJcFlOeEdHSWd1?=
 =?utf-8?B?aGpjcGJWSnVPR0h4WEhXcFdkY1h1bU16VkZKRkRUM0dBNFU0ZTJqR1RUUzhj?=
 =?utf-8?B?T3hUTWFjRzB4b052UkFEVkZuaFdoSjJSTy9qMHNvdTBUbkRLQnpQYm9QMWRY?=
 =?utf-8?B?YWNZclNzWGxpVkw3ZEoxQVdlbFpocEw0dDBVRkN2LytQakNiZnF0MkRSV0dm?=
 =?utf-8?B?eXo3VENOM2FmRE9POWxkSXh5Qk5YRTZyWlFScFhzSXJpQWczM0RrcVkwaE5P?=
 =?utf-8?B?WitMQ2lodTVocnFaK3J2RGQrN3BZaTB4RTBPTktMNTJLWElqZy9xb2FNdjlS?=
 =?utf-8?B?MEJpRWRBTFV5VkREOW8wUDJjcFpXU1RqK3BEZUxGTWJWVVhQWDBSazZoUW00?=
 =?utf-8?B?MENyaXJadmhDcnNXZG1qVDg1enM0KzlkN0RsOVpUUmNTcVU5aW11bTVLemUw?=
 =?utf-8?B?Zi94bmF4UTJVa0RxMm9LaWx2K1Z4N3M4M2tIcEFidWF3SnFPMkpic3hENmdT?=
 =?utf-8?B?NytkaHd2SzZ5alBBN0JKbXdMSG1BQ0JGQU9qSlpvcEdoOUFKdG53ZXRFN0lR?=
 =?utf-8?B?b2FUanp4OGdMMEZvVmtsUVpwSURnWmhSOHNueUt0VHhQbjFERTZ5QThyWXJs?=
 =?utf-8?B?NW02SmhpODNuTlhNemZkYzZwcUVuNVlzTWI4TVl0aDRtL0xCamQwalUwRVZE?=
 =?utf-8?B?dlQ2UWE3L0NSTWcwZm0xY2xUaENiTS9YL3Z3cVU2NG9MRTBlRkc1ak9KSWpr?=
 =?utf-8?B?YTk3dDIvam1JQTJSU1I3MU1xanBqK2JPZEJFWmYxY2MzK1QzNDJ5eFVPY1lB?=
 =?utf-8?B?LzB1TXFwNnNlZWZ6angyUW1aOVA2UjcvT1Mrc09wTGlUZlhOZGFEVmZ4MHk5?=
 =?utf-8?B?VVlvZG15ZTN2NHYyR2M2ZDdlelZwMmJoaUtXVVhZZHI4TXJTZ3h2YmNKZVk3?=
 =?utf-8?B?NDJ3M0hWV1VWSWFlc1FjT0VFUGRVQUJYSm1sU252MVRDVEhjRk9nMTRYRUht?=
 =?utf-8?B?Q3E2aVdsNUVkeGlmN28vSU1TMStoc0ZZZEtua0dPVkUweFN6ZEdQRzBxRVB4?=
 =?utf-8?B?RW8rbkxEWjVIUmdsZ3kxMmFkQmNaTGJCZUg5WEJlenE3ekc0c28xRWpQNDZl?=
 =?utf-8?B?S1ZiVDhIMlEweUx4TEVJbUQyVlY0YU8zdVdWZGs2ZjdYeXpHRktoV3YyMUsy?=
 =?utf-8?B?QnNaQjAvK1d4T2RsaWVmaWhOZXNGTHBzWUpSZnFScjYvMEY1SHZSZzErZmRD?=
 =?utf-8?B?THplNElUTEtMRUNFa0JTcDR2bEYrVjhyS0FPd1ppNG5Zc1QvUUJMSFJxbjNF?=
 =?utf-8?B?TUtvZ2hzRHlJYVc2VUc4YmdiMllYd0RMUitiTXg4eWJSaFJiMEJwSGdPVVJo?=
 =?utf-8?B?Y1BIUjJyOXVNSk8zQnFvVWNIUnlUOGdwS2VNc1JZVytyY1NreU5hQ3pjZDJ2?=
 =?utf-8?B?VWRsYUt5OHpJWi9HQ2dGbHkvSE1MS2lEbHRSeHlaT2hyeTExRXhIVjJGZVkx?=
 =?utf-8?Q?igP5Uv1hoTwcqtIfgE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZqOWlPYW9SK3lqclpmQ1RXeE01alR5RHE1OFAzQXpqOTdJUHhNcm1LNjBr?=
 =?utf-8?B?VlpNb0g2SnJKM1BITnJlcEwxU1hyNUtqTjFsQVBYek0xb0FWN1JIQ3JPcmpS?=
 =?utf-8?B?VkhBcVdwcHJSOW1QZzFpc2lyZkRUNGthaFN2YkJrdG5iVkZ5R0dVT1hDWmI4?=
 =?utf-8?B?YXp1N1RTdGVrRmluV1pPL2c5NXRkWVczSzF6RDB4QU0rZVRxbGE5Y2ZoSUtq?=
 =?utf-8?B?aVg4V0gxbUV1TDhKM0dMQVozM3I1bVlLVkFhRHJUNUNxQ0ZrakFROTFOV0pn?=
 =?utf-8?B?YkEzbURyUDdpUG1WVHVOK0V6b0MrTmNIaUFwVllSTHV1K0JXdWVRUnlSWjhx?=
 =?utf-8?B?NVVFbWY4WnoxcGlhTDhhajFqS21sYld0OGdVKzMralM4OGNYa3FxUVIwa1da?=
 =?utf-8?B?R1ZWMjFPRE5CekJQaE5CU1dZVndwYVhHNjdZNkFQSlV1b0FVM1Q3UjNWcUFZ?=
 =?utf-8?B?U2pXTmlLblBCVk9Bc2xyaUpHMjRTVUtpaUtiNkt3eGxUWHRoR3IwbWZleXV0?=
 =?utf-8?B?ZnJLTWxlTzNqNnlSdzNLMll1ZTZlZzRGdmZVZjZiUUh5S1lFNWJiY1UvL3JE?=
 =?utf-8?B?dWozY1dSTU1EeFFGU01NR1l2aCtCNXVWV3VXa09NTnZERkNxUnEwdUFvYnI5?=
 =?utf-8?B?d2FRaHI4aGw0eDRYNngzUGtzT1JIT1d1V3Z1eWFEUnVQdm9UR0xVeUtTc1Vz?=
 =?utf-8?B?cENUSUdRN01wU0dDdjZuQmdjUUdrcEkzUTNtaGZHN01ZTkVRZzYzd0VEUHF0?=
 =?utf-8?B?T0RFa25qRFJ2TEYyWFYzbzJ1RThPOG9WbnFqZExHOEF4UzFiMWpJZEZaOGlm?=
 =?utf-8?B?OENiOUlXcjd1YVNJbFlsYTJiY2FSQTJJVGRCbVVXK0lCYnZ5NzZoWG92MHdI?=
 =?utf-8?B?WkcrWncvMnpyT3NHUUhqNnA2b2d4WW14bWpEbUFVUElMS2NhdFdieUZmM2xm?=
 =?utf-8?B?UFVCYnAzdVlGRzY5dGdvWXFWK3pXbXM1YzVJY2gySFgxYUh6MlI2U29HbzZ1?=
 =?utf-8?B?Ty9GcHBUN09VRGUxdi9pNHdXajR3Sm5Gc2QyN0hBcmJITWE3SXZSR1ZUam90?=
 =?utf-8?B?TlhTNzIzcm1ROXRQUE5pdmZ5OEVwQUloODNxVnkxUC9yMUN3ZXdETjlVdzZl?=
 =?utf-8?B?WmExMytibmtOTzA3NzU1elVlSHF3TUxzT2ZJZ1UrZGkxcjdMNVAyVU9vT1kw?=
 =?utf-8?B?UmJMWHUrRUYrdm12YXFrU2V2eW9Fdmd2aEhRWXNnWUtKWFVyRno2VWM5U2VR?=
 =?utf-8?B?VEIrOWpOaFBxd1RidTVIK1FMeXVmZHBudmFnNDlZSUZuenpWNkNWTzBRc1Yw?=
 =?utf-8?B?aVQ4TmZEV3dqdEplMi80clcwUjBONFVheWNvWXVJaEQ4OVI4M0pKeTNSMFNs?=
 =?utf-8?B?VlpmcGFjTXprU2t6MmEzb1hHeW1jbnJYdjVUemYzMjFBcUE5T2QyTDBvNlJV?=
 =?utf-8?B?MXFra3lEWDNObjZNNlBYaUlRNmc2ei9kL1BZVmJyRjNyR3pmVUR1UDVGdEFK?=
 =?utf-8?B?eHZubEsxZGxrRVltVWU2ZHJhNTA3Tk1uZ1hXSHlZQ0hZSnFLb1NaUmdYeWdh?=
 =?utf-8?B?TFllNk1yWE1EakNCVUN3ZjVBa1BUSG5sS1piVkpTYWJRbDVRTnBxTE8rbGZk?=
 =?utf-8?B?L0dMY0g5K1pMV2gwclVRQW1idFFaZlFrQktmcVBpdzNyWEU4Y210OFhHcUVn?=
 =?utf-8?B?NmVrWkFiUmduaDRrTUp3cE9FbEE4ZURJK0tCWHZYQWg0cUhxVkUrZGpIWjR0?=
 =?utf-8?B?anBGSzFLU0FueWZoeXBMNnlDckR0NithNjBrYWZRZDZPUTBqd2lmTVc5YkNl?=
 =?utf-8?B?TEY2WWNhMk41YnU0ZHJ4UU5WL09LQXlWd293TGRjdWNUdWd4VzlaVTQwWWhP?=
 =?utf-8?B?L28zS2hMclBtTkowSXpTNmx3V29md2thVGR3cmFKKzkxcTNMUUVSUlVjUjhV?=
 =?utf-8?B?MFdTditGbUs3SDkrOXFpNUt0Z3ZGWlMwWkxoYXBodmdMNFgxODBZb3pwNjlh?=
 =?utf-8?B?cDZVdVo3SjZwSmgxY01jZStKMHhQZ3RQb3VpUlpaOXQ5TVd5bThFeExvdE5j?=
 =?utf-8?B?NWx4cnpGYjd6Nnphek1zdE84cktKdDZJQTgra2xCOUJ6b1lqalNGamdTTXhD?=
 =?utf-8?Q?kpq8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11703b5c-1793-4abd-e44a-08dd1ac87f5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:17:39.1107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZloAKoRgEVWAYEFTse5g8edxnB9fNe5aKPywovwIntic4bmGDBfIX0bTo7o4pPp0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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

--------------MvfNdFzbDWHhjc3mLGzw5Oxm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/11/2024 11:30 PM, Zhu Lingshan wrote:
> On 12/12/2024 12:19 PM, Felix Kuehling wrote:
>> On 2024-12-11 22:06, Zhu Lingshan wrote:
>>> kfd_process_wq_release() signals eviction fence by
>>> dma_fence_signal() which wanrs if dma_fence
>>> is NULL.
>> That's news to me. Looking at the dma_fence_signal implementation on amd-staging-drm-next, it just silently returns -EINVAL if the fence pointer is NULL. I see the same in Linux 6.12.4:https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma-buf/dma-fence.c#L467
>>
>> Which branch are you on?
> Linus tree, latest master branch, tag v6.13-rc2
> https://github.com/torvalds/linux/blob/master/drivers/dma-buf/dma-fence.c#L467
>
> which is introduced by
> https://github.com/torvalds/linux/commit/967d226eaae8e40636d257bf8ae55d2c5a912f58

It is new.  I did not see it from AMD kernel either.

Previously I wanted put following dma_fence_put(ef) together with 
dma_fence_signal(ef) :

+	if (ef) {
+		dma_fence_signal(ef);
+		dma_fence_put(ef)
+	}

That seems neater.

Regards
Xiaogang

> Thanks
> Lingshan
>
>> Regards,
>>    Felix
>>
>>> kfd_process->ef is initialized by kfd_process_device_init_vm()
>>> through ioctl. That means the fence is NULL for a new
>>> created kfd_process, and close a kfd_process right
>>> after open it will trigger the warning.
>>>
>>> This commit conditionally signals the eviction fence
>>> in kfd_process_wq_release() only when it is available.
>>>
>>> [  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
>>> [  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
>>> [  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
>>> [  503.877620] Call Trace:
>>> [  503.880066]  <TASK>
>>> [  503.882168]  ? __warn+0xcd/0x260
>>> [  503.885407]  ? dma_fence_signal+0x74/0xa0
>>> [  503.889416]  ? report_bug+0x288/0x2d0
>>> [  503.893089]  ? handle_bug+0x53/0xa0
>>> [  503.896587]  ? exc_invalid_op+0x14/0x50
>>> [  503.900424]  ? asm_exc_invalid_op+0x16/0x20
>>> [  503.904616]  ? dma_fence_signal+0x74/0xa0
>>> [  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
>>> [  503.914081]  process_one_work+0x654/0x10a0
>>> [  503.918186]  worker_thread+0x6c3/0xe70
>>> [  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  503.931527]  ? __kthread_parkme+0x82/0x140
>>> [  503.935631]  ? __pfx_worker_thread+0x10/0x10
>>> [  503.939904]  kthread+0x2a8/0x380
>>> [  503.943132]  ? __pfx_kthread+0x10/0x10
>>> [  503.946882]  ret_from_fork+0x2d/0x70
>>> [  503.950458]  ? __pfx_kthread+0x10/0x10
>>> [  503.954210]  ret_from_fork_asm+0x1a/0x30
>>> [  503.958142]  </TASK>
>>> [  503.960328] ---[ end trace 0000000000000000 ]---
>>>
>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 87cd52cf4ee9..47d36f43ee8c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>>>   	 */
>>>   	synchronize_rcu();
>>>   	ef = rcu_access_pointer(p->ef);
>>> -	dma_fence_signal(ef);
>>> +	if (ef)
>>> +		dma_fence_signal(ef);
>>>   
>>>   	kfd_process_remove_sysfs(p);
>>>   
--------------MvfNdFzbDWHhjc3mLGzw5Oxm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/11/2024 11:30 PM, Zhu Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com">
      <pre wrap="" class="moz-quote-pre">On 12/12/2024 12:19 PM, Felix Kuehling wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 2024-12-11 22:06, Zhu Lingshan wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">kfd_process_wq_release() signals eviction fence by
dma_fence_signal() which wanrs if dma_fence
is NULL.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">That's news to me. Looking at the dma_fence_signal implementation on amd-staging-drm-next, it just silently returns -EINVAL if the fence pointer is NULL. I see the same in Linux 6.12.4: <a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma-buf/dma-fence.c#L467">https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma-buf/dma-fence.c#L467</a>

Which branch are you on?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Linus tree, latest master branch, tag v6.13-rc2
<a class="moz-txt-link-freetext" href="https://github.com/torvalds/linux/blob/master/drivers/dma-buf/dma-fence.c#L467">https://github.com/torvalds/linux/blob/master/drivers/dma-buf/dma-fence.c#L467</a>

which is introduced by
<a class="moz-txt-link-freetext" href="https://github.com/torvalds/linux/commit/967d226eaae8e40636d257bf8ae55d2c5a912f58">https://github.com/torvalds/linux/commit/967d226eaae8e40636d257bf8ae55d2c5a912f58</a>
</pre>
    </blockquote>
    <p>It is new.&nbsp; I did not see it from AMD kernel either.&nbsp;</p>
    <p>Previously I wanted put following dma_fence_put(ef) together with
      <span style="white-space: pre-wrap">dma_fence_signal(ef) :</span></p>
    <pre wrap="" class="moz-quote-pre">+	if (ef) {
+		dma_fence_signal(ef);
+		dma_fence_put(ef)
+	}

That seems neater.

Regards
Xiaogang
</pre>
    <p></p>
    <blockquote type="cite" cite="mid:40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com">
      <pre wrap="" class="moz-quote-pre">
Thanks
Lingshan

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards,
  Felix

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">kfd_process-&gt;ef is initialized by kfd_process_device_init_vm()
through ioctl. That means the fence is NULL for a new
created kfd_process, and close a kfd_process right
after open it will trigger the warning.

This commit conditionally signals the eviction fence
in kfd_process_wq_release() only when it is available.

[  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
[  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
[  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
[  503.877620] Call Trace:
[  503.880066]  &lt;TASK&gt;
[  503.882168]  ? __warn+0xcd/0x260
[  503.885407]  ? dma_fence_signal+0x74/0xa0
[  503.889416]  ? report_bug+0x288/0x2d0
[  503.893089]  ? handle_bug+0x53/0xa0
[  503.896587]  ? exc_invalid_op+0x14/0x50
[  503.900424]  ? asm_exc_invalid_op+0x16/0x20
[  503.904616]  ? dma_fence_signal+0x74/0xa0
[  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
[  503.914081]  process_one_work+0x654/0x10a0
[  503.918186]  worker_thread+0x6c3/0xe70
[  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
[  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
[  503.931527]  ? __kthread_parkme+0x82/0x140
[  503.935631]  ? __pfx_worker_thread+0x10/0x10
[  503.939904]  kthread+0x2a8/0x380
[  503.943132]  ? __pfx_kthread+0x10/0x10
[  503.946882]  ret_from_fork+0x2d/0x70
[  503.950458]  ? __pfx_kthread+0x10/0x10
[  503.954210]  ret_from_fork_asm+0x1a/0x30
[  503.958142]  &lt;/TASK&gt;
[  503.960328] ---[ end trace 0000000000000000 ]---

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 87cd52cf4ee9..47d36f43ee8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 */
 	synchronize_rcu();
 	ef = rcu_access_pointer(p-&gt;ef);
-	dma_fence_signal(ef);
+	if (ef)
+		dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------MvfNdFzbDWHhjc3mLGzw5Oxm--
