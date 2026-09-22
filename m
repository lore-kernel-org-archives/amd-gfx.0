Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654FAC982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEF110E868;
	Tue, 22 Sep 2026 07:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7Zgt6FM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F6510E868
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3T/6tb69q3z763GwsrWEBUU76PG0HU7OAsziQHC8Ju9w9nXr69OQFY3t+0o2KS6TiOgZqzVTZHolSBEUk1l5Q10kkY+kfnTWZYFvS8A7RednTQuYI/4Je8j8impanj5sQmnNRkBfSVDzrneMpwwNofF0TjoGR8QZFXWTB4ksxD/YNPHiOMniRqSKVtj1NKDcC+bFasmFt53m2jjhhm1Xko9H2gvlZNTH2zmUkNlXoWd9N5Ba6d3/HxQZDQ0IGBEgcp3JA8gzxao+uYV1WtBnCwq8HU3c0WHZbB4HDXMKJmPn3F0NyuoZmfxEFQo3+5sPjMSV3PK6KDy6+5fMK7xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eKoI0ObG1hXWI5XCp8+cFaM4jSTbofabF0WSpUxT4U=;
 b=KnM7xX18Gqi23iTrtwFPkjiqAoeITvvVcCD8rDl9ZaLr955upAvFQwGDzequTey0cAUwXy8dJ80tIJzqJQsZXEX/YUn+K8EweW/n2ed1xLEEUP5fQFcP1TXijut0I0lKboIQO0JWCLTEmFYVGR8fxJJ302vLFX0oPWr4RypkZ85DF6pziNbjEvLZqa79DvQ8ZwPun9bKhzGuqYdPzxrZ6MnKEharcfklUSvwRKarItX21xSrnlO5BGD5Y4g00Cl6VC9DMMkBBuDkRX/2XRhiVJn3KvJ8wAAK/7uz0yzsHGMUhFThjc7CFLFMXs6FIv7BM3r78iQpDBZcm3ScYy/b7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eKoI0ObG1hXWI5XCp8+cFaM4jSTbofabF0WSpUxT4U=;
 b=R7Zgt6FMOuo5CB3jD9ED7CCCCTWeoCnbEKiow6O8NJsxKJn/VSAS7rV7oiKM45tSEPjk7wuqz3NzejZlOr7pCB4n+pUbDnY/vqWNABqyMnjEDs0YjkU1A4vXcybC2cggrLTieb3xJPyJE5E3jYoMd4tYLVFHJCtJ8QHCbUqEogc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 07:35:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 07:35:35 +0000
Message-ID: <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com>
Date: Tue, 22 Sep 2026 09:35:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e64906-8a61-4521-5908-08df187c16e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AQV0WI79AoljRgSFi5+tk+dGDraJF5DUDQqosBjTGt8H2AMCAiGMKzlRP0BbYRTowPPBRIQ9XeHvrsgm2p0qDzXoR7uKpo3px3kNZwqJrYuKubiDDSjr8kFw5k2muhhAWCLc2EThvzK6zM3oW5P4TOk8kd42kQc7/LTLJGTT8MW0kp4pvTx1M42/aHHVGEVaPL46IYWgeYwWKLYKzQDX+2ljMx7BA90lHsQgzWRCi4iL34e573nxVE+8sGn6fr+vLlgekLf9Qyzb3/+SnpB17n3a+xCsQwlEyceMSYPlKcBFrB7rkmxnbehENJyxAlUS4qMQH8T9Xku8oVS6uEY52o/P9gPpaiYABFPku8WeCOEHJI/yOQ8eq6J06lHNcm/reObwQb8njk7M25GC3bAViisdjdIHVHwmBUyHqR0tX9qvpc7bcBtikUxXJH03+53zR6e8QpXljWIsMBLcpI1TtM40ADVUm0timLEmRfTCzyLjzQ0p23aLxaofFqpXV45jmfFzRmsSDa2qN4Uqs+rVErsELk8Y8EtbHGPuj7LqGAfAHei3aaCdoRZ45tY6sWhMxeTb+Xb1Kddzchte1HTGnFddSZY3630R3IVkChNO9HxET8jrdhpyRsvD0GxO9HELNud601++TfNRReKMIJ4M8/WArF2G72gghknMoT0hOB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szd5aURQK2hONk0xODFOeE1oWlpkQmsyMG5OZHg3dDBNL1puWEg4SzljV2lS?=
 =?utf-8?B?U2hRbXpwTzBGSFhXRmsySG1zbytWczBRTkpTQmRibmY4aS9vVUJxMHdHVHNU?=
 =?utf-8?B?V2RLbHcyWDhGMmp3ODdQaDVCZEM2RVFQeUFCMm5jVGdWclZpTmRKUFI0RFNV?=
 =?utf-8?B?S0ttalFRQ2xINEN4TnlucU5xdTV5U0ZRd1FidGdFa0lmcWpjSnJ3USt0bWJj?=
 =?utf-8?B?NkllUldGNlRRZXNZTFZ1b0N4U3A5R2JEMzU1SzE1bnd6S3pVRG9VQjc5OXZV?=
 =?utf-8?B?d1hONkFNN1A0UzMwQVYxVmwwSGZjTTNCaDFMMG9KYkpiaWhWWjhJOWUvOHdz?=
 =?utf-8?B?WlM1d1UrYUNIRmtEZGN3R0dKeWlxM3pRSU5vT1VMUk14eVZ3L01DN3VuSUxv?=
 =?utf-8?B?QXdWUkIvUHQwdWJNQlZqdHR3dzZvc0txbHhiNnAvOXlUVVU3ZWxiK0htQUdG?=
 =?utf-8?B?d3BqZXhXRXhNUGNuRktMcklrRk1JRWpyWGtlQjJBODRseDA1cm51bEg1MEdC?=
 =?utf-8?B?OVBYZThwdCtDRWc2QkdqVkd2ZXRCOGN1Rit6R3dsN29TaVZBcTdXc1p3QlNp?=
 =?utf-8?B?MDBtdnNqRHpRUHkxV0Nsd1FHVkVpWXRUcDdMRUlOOWFZMmJQN040OEsvdHRO?=
 =?utf-8?B?R1kzWmE3cDFYSmRSTXdqdXF3ek5MS1JFdkVzRmxKVzVpaWJmcHovY0xsNFRV?=
 =?utf-8?B?ejNPWDBKb1E3NWEwZE9LMGtCakNUYUVscHpldHN4bUdubi9RZ0R3WjNQMFhD?=
 =?utf-8?B?UnBzTTJDSUVHYVBlVkxOVVFiYUZSYUtMWnFtRFBOa2s3T3lpaWJuNGhjeU11?=
 =?utf-8?B?WXBzNWNBcEYzNnBya2kyZE9rNU41bTN2aVBmL0VVWEdMT0VrblcvMW5TM0g1?=
 =?utf-8?B?V1RjZW5XNVY0cXNkVUVEUlg2bU5ZaWJybEx3cU1UZTNOQjkzNmlUODk1ZE5u?=
 =?utf-8?B?VXgva2t3aXJVaW9HaVgreElvRk5Jd3NtYjU5UXo4ZGNTdmlIR0h5OExlTlF1?=
 =?utf-8?B?TlZCS0JwMkIyUjBteGZzdlRzalJScytVd0dQelRmamJTbzR3M2s2QWNrWFRw?=
 =?utf-8?B?Q1pKeGhZcXA2SWZHOFIzVThCRXJhaWF3WlJpSW03c2VPN1JsTzdGNFB3ZXZv?=
 =?utf-8?B?MUxQaU5YeFRaNWJzalZjWjVvUFBtYm43NXE1Q0F2UTRzVkhFcXczYzFDVXY0?=
 =?utf-8?B?ay92NEFMMVMxSERRUmxGUkVJRmUxQk16OWVlcWJua1M0eFF6ejJFMm1qeVRl?=
 =?utf-8?B?TWpXQnBWc3JYRjltWXNpZ1lDamtYM1hJWGRRSWVqV2ptTU1Ta0pjWFJJVjIw?=
 =?utf-8?B?d2dQcDNOMXNQbTExaTYzNHhHNHBFMHJiZm1od1RYdTVDMTBhUC9mZkpGQkJn?=
 =?utf-8?B?K1YyU05qQmRzSzgzQUNJRmpBL1ZtMEc0YzhLeWtma2k1OU5scW1jRGR3MTdw?=
 =?utf-8?B?eU51SFd1eC96Rk41ODhHOUwwVS8veDJGZkJzaWliWkRHTkR4V0RmcU90MkJu?=
 =?utf-8?B?c2dOU3ZKT3ZQRHJ4QVo0SU1hWEh4VkJxeGI3Zi8xR0FnZDRmVVdrNEtQbXdp?=
 =?utf-8?B?UXcxL0swYW9MSm8zWXFma0s4RWVBTk5YcG5xY1dBNkJ5QWhVakIrMHdQSXpp?=
 =?utf-8?B?aWR6aG4yOGNldlFrWGJVNC9QeHU3bE1LRHJndXhONmExOEh3YnhZMDExUDc5?=
 =?utf-8?B?azVJdkd4dlRENEZYbUhEZHcvczlCTEtkS01qR0lzd2dHbm4vcWF4aWYwTWtp?=
 =?utf-8?B?WEcvWndIK3FxRDZ2TDdyVnhhZU1OTHR6d242WjF6Q0J1alZTZGZnbVIvNGpa?=
 =?utf-8?B?THdsTmpsRGx1VGhHSU9TWTAzaGswR0ZXV3ZqQXpheHZ1S2llYXJiLy9CR2ZN?=
 =?utf-8?B?elRhcURCa2FJbEg1TFk4UjlVY29CVXZ3TEhuMTM1bFNPckJKMzdLajdZc0xW?=
 =?utf-8?B?RktlNmlwcUVyNXE3bGpxYVVJQzhGeG01UFgvVnEzUE1sOUkzM1crbW5xZFdN?=
 =?utf-8?B?MVZORE1NeWFZRzFtditCdGliN3JuUUdQUm1ReFlNS01jSmgrak5CeWhyb1Bo?=
 =?utf-8?B?eGZicWU5Qzgwbk5mbUN5VFdkMDAxeFRpR3JNcml3eFBtM0w1S0F2MkdSc0VQ?=
 =?utf-8?B?Qkl4OHVaYml5MnY0UnAwWjRVdzhIa2g5RXpiQTNMdVduWnB2ZlJYL0JuY0t0?=
 =?utf-8?B?SDlqd1AwcjFDamppQWpQM2c1WGhOZ05zRUsyalF4UWhOZTUzV29kMHZtRk1C?=
 =?utf-8?B?VGJSTkdLVllhekN6UGFpREVTN0FsNVNNb0h6VVE1NG9kZHZ0bWNjYlkwNXVt?=
 =?utf-8?Q?KXiI48IF4tH6YMbqK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e64906-8a61-4521-5908-08df187c16e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:35:35.1437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZvhEEGpL5tGS3zNZTYl0PgrIa7yYt1imQCynhqz5/1EPKKC7zD2w29+KbC165gE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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

On 9/22/26 08:08, Zhu, Lingshan wrote:
> On 9/1/2026 4:50 PM, Zhu, Lingshan wrote:
> 
>> On 8/31/2026 4:21 PM, Christian König wrote:
>>
>>> On 8/28/26 17:59, Zhu, Lingshan wrote:
>>>> On 8/28/2026 9:08 PM, Christian König wrote:
>>>>
>>>>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>>>>> This commit introduces a new helper
>>>>>> amdgpu_lookup_queue_by_doorbell which helps
>>>>>> look up a user queue with the given doorbell id
>>>>>> in a xarray.
>>>>>>
>>>>>> This function takes a kref of the user space queue.
>>>> Hello Christian
>>>>
>>>> Thanks for your comments.
>>>>
>>>>> Well absolutely clear NAK to the whole approach.
>>>>>
>>>>> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
>>>>>
>>>>> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
>>>> Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
>>>> because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
>>> Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.
>> I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.
>>
>>>> Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
>>>> and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
>>> That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.
>> I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.
>>
>>>> So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 
>>>>
>>>>> Grabbing references from this side would obviously result in circle dependencies.
>>>> I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
>>> That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.
>> A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
>> depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?
> 
> Hello Christian,
> 
> I have not heard back from you for three weeks, I wonder whether you have any further comments for this series,
> or shall I make any improvements?

Well just completely drop that series. As I said this approach is a fundamental no-go from my side.

As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.

Regards,
Christian.

> 
> Thanks
> Lingshan 
> 
>> Thanks
>> Lingshan
>>
>>> Regards,
>>> Christian.
>>>
>>>> Thanks
>>>> Lingshan
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>>>>>>  2 files changed, 32 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> index 0a816b3c5ff9..e0639f844a8e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>  	return queue;
>>>>>>  }
>>>>>>  
>>>>>> +/**
>>>>>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
>>>>>> + * @xa: user queue XArray indexed by doorbell
>>>>>> + * @doorbell: doorbell index
>>>>>> + *
>>>>>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
>>>>>> + *
>>>>>> + * This function increases kref of the queue, the caller
>>>>>> + * must release the reference with amdgpu_userq_put().
>>>>>> + */
>>>>>> +struct amdgpu_usermode_queue *
>>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
>>>>>> +{
>>>>>> +	struct amdgpu_usermode_queue *queue;
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	xa_lock_irqsave(xa, flags);
>>>>>> +	queue = xa_load(xa, doorbell);
>>>>>> +	if (!queue)
>>>>>> +		goto out_unlock;
>>>>>> +
>>>>>> +	if (!kref_get_unless_zero(&queue->refcount))
>>>>>> +		queue = NULL;
>>>>>> +
>>>>>> +out_unlock:
>>>>>> +	xa_unlock_irqrestore(xa, flags);
>>>>>> +
>>>>>> +	return queue;
>>>>>> +}
>>>>>> +
>>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>>>  {
>>>>>>  	if (queue)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>> index 6412a7f7b6ef..8fc73862f64e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>>>>>>  };
>>>>>>  
>>>>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>>>> +struct amdgpu_usermode_queue *
>>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>>>  
>>>>>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);

