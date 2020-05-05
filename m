Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84EAC47257
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 17:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8638B20721
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 17:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bjwISKfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8638B20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B7B6E095;
	Tue,  5 May 2020 17:29:15 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEE96E095
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 17:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjvVz/3TJ3BsY8e1/Ppid7vxHgq3/KQFII+ke+gQLROQ2dv9KoZdnclrJwJdhRAYOAXVqiS9qBnq9S7FzGXbl+Tzf6SO1S6C08qYvc4O+GuI7a2adA8CQKWKP2SsQWGdxbehBqei7oA7TY0vFszn4OdF+2ORl87XZprcg2olAP7x96sHUcGebaFPJu/vExQW3/WGoJSEvblJFw/c872jCnRFLykd+k7rOW0WVXg6qHzLjWsw05lAKMRmEUCCWs0gLYOR2/cg4cb13aCDkyV7ZChzMrDQxYnHL6uB8gRNjgQy8inHBmAO1jfxCYH2RKpM/9J5l+EyqOx7R9w9DlrUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o/27BwTvpdPHunKBaALti2D/1ikTYR8rpN5P13S5Ns=;
 b=GPOuJrjlWXLjGTBXuvQlGI8ovG6wHMp/5ZXLRdRpSc0nKp3vg4PZBNPT0EdeY8tWT5xoxfnpUnJQtoE7ZGv+fgZIgdpRQi2DP4qMsA9NBYX5HZPyYL1LxAV/qIUexSfDs3uOHaDqgJLRDHfmcWlBYA9c/ETxv4hZIkL+nboUYP3RAo9idLE9NOJqTpBwvRkhv2iD/vBEKqzRSB6iCc7+6e4NEI7rKSjSvAjQtsSyk/f3mMeHHRWUhWwgfFWc8bt0m3j2LmbVnRtwMVuia9AyDlNleAiTUtcGoOg1N65sY3FGkME12KzwcsPYnZBlnil0gsDGKkyd4kdjOc6HKCWDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o/27BwTvpdPHunKBaALti2D/1ikTYR8rpN5P13S5Ns=;
 b=bjwISKfF28/69R1l8jB2vz1GMFPOqZE8JorN5FQEhn9gW387xjH4HkmQMok0T6BuBblXAtn5+r5h3tRnnO6e/omuvBK3mu3yv9ewGFo6ZkECS1+FuEO4SOd2D2sUjx075P9Rld5MxvEjKRfG4c5Zpvru1QgOYMmtTjHBS3mXu7M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 17:29:04 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 17:29:04 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
 <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
 <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
 <6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com>
 <170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com>
 <ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com>
Date: Tue, 5 May 2020 13:29:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::23) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Tue, 5 May 2020 17:29:03 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cceb46ba-c092-4e01-a798-08d7f119ce9d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:|SN1PR12MB2589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25894BF6B555AF68DCB28EDE92A70@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWyWe/IIeRlyTtwwmUiCj+wOiM2RagIwDRqk5F6AAr9Cfidqzq20mRUPc46qzPhU12T/fvhn9WgcV539tyYcW2Y+99sO+SbxD+Mspr7dYQjTHYVigEHQ5Jjl5hEm2RapQM5xyo9y2uiXQeQRUbNQz4aiXdr8+xyPquIq0WyQgVm1MJir5ukLS49Ltx4blRyuHemb1SN696Mn5nmFmP0W4BphAFwJI5+GDLWB/hrXVUFXB6zSQOQUFZyUNV3/GE9aYBMwRtE3R7WWVH6q7vAOS0oEX+1wRE4HToCutnNqqOIdmiLtS+7YVQjuyT5dZ2bt0R/vAmjBp+wtuQc9hW85A5KjYIuGrX0EdanRTO5zi4f3YGkCID8u0KeFOVBITfvojH2UtXpuq7u/3AGBTDIL6XjVFYYKhuxsTqH/ChRhXyrjiL9rqvxrsdrJ+hJv7YxwP+dOMamqozHvkUB5tpUNsrZEb7Y80meJmLJnLva9iwfpTIBbtpYb1w7WrynTBmEKtjT6PbMtqbONNtYKsu/FAxUegt4cXrk/R9nVHtsm4hDQLWTE2vRZ0gIZwI/vHCZt4TLrFSDW252nFSTGjl3YNoOAcNWflx+FZPzczPr5Im8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(33430700001)(956004)(31686004)(86362001)(6486002)(478600001)(31696002)(2616005)(966005)(44832011)(5660300002)(33440700001)(52116002)(33964004)(186003)(16526019)(2906002)(66574012)(30864003)(66556008)(66946007)(66476007)(26005)(16576012)(8676002)(8936002)(316002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 71IuPRpRaHkO0YBcpX3hgGRUP/O5uYqeri+hOYaqu+eRYa+BMpcd6At33K9Y6yxE5+wtwSnCjIgse2QtA0kh8QvxbUltcXFQRz6OotWDVswh56GoNywIAvE6NeUNnh6aAqqbPSxu7d6LlnKarkEfolLOQBYNJm6yPtKpjBMeAsbiZsXj3149WlZZMSxqAAokh9ptvGMNnKe2bCUrd1hn0zktyizzpCspRhKnVnoPzal3N9obQ1BNQFAoN55n3YEX5zKC7LgI2KxoVLRxF7SABUNJDtFYjWCYCJB3WbpO+GqjGOmODDAmwkRH6Qpm/tAQFVkpbuKdbkFtonua8dJNtVXYQwhGmKrnrXrA6l8tVxrxTuu1YNX4aSPbBV419xFz/UXGZ2owQpJdxvkVIAt2fHMNa0J3AGGFMrDKDSe7p4Hdi+nxOVfFkXaRPriOHY8N5xY0e5eAJm5BjDhmSry1xiA2UhnZyPYok/KzhN1sb1V0tlPATccTDFGnXL4Gx7ZLMsRMEn0TOs63CbJbXaUMq54lleP3fSNDBSt4ANXn86M/MMBqJM8RozgfwUKSQfH3CFVwnSAco4tbbcfIZY6S2DLjJG9kfH4utIZTMUeZ6rBsljtU7RFooLp20lr6EKeAQ5h9vrU/D5YLRC+/suwW56lib1BvoFACMYnGnNcoQBmrFSz6Qw4beyn8X+YbUoCHkQYZ8yctoa+1o0XCdI8daVxtSGGBlcEL981q4ZEw5p1/CVlR3BATo/gcNB0pUDVWeCgGjXpXglBxp871PTh82FVhcvu/q1OfCsy+MaosKx8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cceb46ba-c092-4e01-a798-08d7f119ce9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 17:29:04.1298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNGDVg+b7U7kh8bPm8/evfDi3/AJT5iXUDkVFGGi1JwEGg293At15nZ43Eb+MKHM7UcnLZH7P+yC5n7ltNgNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
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
Content-Type: multipart/mixed; boundary="===============0060554663=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0060554663==
Content-Type: multipart/alternative;
 boundary="------------EDB8FD0A3BE32BE1396C5205"
Content-Language: en-US

--------------EDB8FD0A3BE32BE1396C5205
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Am 2020-05-05 um 11:19 a.m. schrieb Christian König:
> Am 05.05.20 um 16:58 schrieb Felix Kuehling:
>> Am 2020-05-05 um 3:47 a.m. schrieb Christian König:
>>> Just to reply here once more, this patch is a clear NAK.
>>
>> Agreed. But see below. I don't think all is well.
>>
>>>
>>> The references are grabbed in the call path of
>>> drm_gem_prime_export() and dropped again in drm_gem_dmabuf_release().
>>>
>>> So they are perfectly balanced as far as I can see.
>>
>> That is true for the GEM object references. But I believe there is
>> still a problem with the TTM BO references.
>>
>> As far as I can tell amdgpu_bo_unref can free the TTM BO while there
>> are still references to the GEM object from DMA buf exports. I think
>> that's a fundamental problem with how we have two reference counts
>> for the same physical object (TTM BO and the embedded GEM BO).
>>
>
> Completely agree, I also mentioned that problem during my talk on
> FOSDEM. But calling amdgpu_bo_unref() to often is a bug in itself.

That's not the problem here.


>
> What we could probably do to detect this is adding a BUG_ON() in TTMs
> release function and checking if the GEM reference count is really dead.

The problem is, that we have to guess whether there are still any dmabuf
references to the GEM BO. There is no way amdgpu can know that. You
can't make amdgpu responsible for keeping a reference to the TTM BO
while the GEM BO is still referenced by entities completely out of the
control of amdgpu.

Another weird thing I see is that amdgpu_gem_free_object calls
amdgpu_bo_unref. That implies that the GEM object conceptually holds a
reference to the amdpu/TTM BO. But that is not really the case. Amdgpu
never takes that reference that GEM is supposed to own. If it did, we
would leak all our memory because nobody would ever drop that reference.


>
>> I think the correct solution is for amdgpu_bo_ref/unref to delegate
>> its reference counting to drm_gem_object_get/put instead of
>> ttm_bo_get/put. The amdgpu BO would hold one token reference to the
>> TTM BO, which it can drop when the GEM BO refcount drops to 0.
>> Finally, the amdgpu BO should only be freed once the TTM BO refcount
>> also becomes 0.
>
> Just the other way around, but yes the long term plan should probably
> be to merge the two.

I need a short term solution. Because I have a bug that causes a kernel
oops with applications that are valid and correct, as far as I can tell.

I'm thinking a solution that doesn't require major changes to the way
TTM and GEM interact would put amdgpu in charge of coordinating the two.
Unfortunately that would mean adding a third reference count in
amdgpu_bo, in addition to the ones in TTM and GEM. The amdgpu BO would
hold one token reference to each of the GEM and TTM BO. When amdgpu
refcount goes to 0 it releases that GEM BO token reference. When the GEM
BO refcount goes  to 0, we get a callback amdgpu_gem_object_free. There
we can drop the token reference to the TTM BO. Once the TTM BO reference
goes to 0 we free the memory.

Does this sound feasible?

Regards,
  Felix


>
> The difficult is currently we have a mismatch what locks could be
> taken when we drop the references.
>
> Regards,
> Christian.
>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 01.05.20 um 16:44 schrieb Felix Kuehling:
>>>>
>>>> [dropping my gmail address]
>>>>
>>>> We saw this backtrace showing the call chain while investigating a
>>>> kernel oops caused by this issue on the DKMS branch with the KFD
>>>> IPC API. It happens after a dma-buf file is released with fput:
>>>>
>>>> [ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
>>>> [ 1255.049727] #PF: supervisor read access in kernel mode
>>>> [ 1255.050092] #PF: error_code(0x0000) - not-present page
>>>> [ 1255.050416] PGD 0 P4D 0
>>>> [ 1255.050736] Oops: 0000 [#1] SMP PTI
>>>> [ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
>>>> [ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
>>>> [ 1255.051752] Workqueue: events delayed_fput
>>>> [ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
>>>> [ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 <48> 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
>>>> [ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
>>>> [ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
>>>> [ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
>>>> [ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
>>>> [ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
>>>> [ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
>>>> [ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
>>>> [ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
>>>> [ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [ 1255.057763] PKRU: 55555554
>>>> [ 1255.058179] Call Trace:
>>>> [ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
>>>> [ 1255.059025]  dma_buf_release+0x56/0x130
>>>> [ 1255.059443]  __fput+0xc6/0x260
>>>> [ 1255.059856]  delayed_fput+0x20/0x30
>>>> [ 1255.060272]  process_one_work+0x1fd/0x3f0
>>>> [ 1255.060686]  worker_thread+0x34/0x410
>>>> [ 1255.061099]  kthread+0x121/0x140
>>>> [ 1255.061510]  ? process_one_work+0x3f0/0x3f0
>>>> [ 1255.061923]  ? kthread_park+0xb0/0xb0
>>>> [ 1255.062336]  ret_from_fork+0x35/0x40
>>>>
>>>> drm_gem_object_put_unlocked calls drm_gem_object_free when the
>>>> obj->refcount reaches 0. From there it calls
>>>> dev->driver->gem_free_object_unlocked, which is
>>>> amdgpu_gem_object_free in amdgpu.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>> Am 2020-05-01 um 10:29 a.m. schrieb Christian König:
>>>>> Am 01.05.20 um 16:21 schrieb Felix Kuehling:
>>>>>> From: Felix Kuehling <felix.kuehling@gmail.com>
>>>>>>
>>>>>> That reference gets dropped when the the dma-buf is freed. Not
>>>>>> incrementing
>>>>>> the refcount can lead to use-after-free errors.
>>>>>>
>>>>>> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>>>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>> index ffeb20f11c07..a0f9b3ef4aad 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>> @@ -398,8 +398,15 @@ struct dma_buf
>>>>>> *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>>>>>>           return ERR_PTR(-EPERM);
>>>>>>         buf = drm_gem_prime_export(gobj, flags);
>>>>>> -    if (!IS_ERR(buf))
>>>>>> +    if (!IS_ERR(buf)) {
>>>>>>           buf->ops = &amdgpu_dmabuf_ops;
>>>>>> +        /* GEM needs a reference to the underlying object
>>>>>> +         * that gets dropped when the dma-buf is released,
>>>>>> +         * through the amdgpu_gem_object_free callback
>>>>>> +         * from drm_gem_object_put_unlocked.
>>>>>> +         */
>>>>>> +        amdgpu_bo_ref(bo);
>>>>>> +    }
>>>>>
>>>>> Of hand that doesn't sounds correct to me. Why should the exported
>>>>> bo be closed through amdgpu_gem_object_free()?
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>         return buf;
>>>>>>   }
>>>>>
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>

--------------EDB8FD0A3BE32BE1396C5205
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 2020-05-05 um 11:19 a.m. schrieb
      Christian König:<br>
    </div>
    <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com">
      
      <div class="moz-cite-prefix">Am 05.05.20 um 16:58 schrieb Felix
        Kuehling:<br>
      </div>
      <blockquote type="cite" cite="mid:170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com">
        <div class="moz-cite-prefix">Am 2020-05-05 um 3:47 a.m. schrieb
          Christian König:<br>
        </div>
        <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
          <div class="moz-cite-prefix">Just to reply here once more,
            this patch is a clear NAK.<br>
          </div>
        </blockquote>
        <p>Agreed. But see below. I don't think all is well.</p>
        <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
          <div class="moz-cite-prefix"> <br>
            The references are grabbed in the call path of
            drm_gem_prime_export() and dropped again in
            drm_gem_dmabuf_release().<br>
            <br>
            So they are perfectly balanced as far as I can see.<br>
          </div>
        </blockquote>
        <p>That is true for the GEM object references. But I believe
          there is still a problem with the TTM BO references.</p>
        <p>As far as I can tell amdgpu_bo_unref can free the TTM BO
          while there are still references to the GEM object from DMA
          buf exports. I think that's a fundamental problem with how we
          have two reference counts for the same physical object (TTM BO
          and the embedded GEM BO).</p>
      </blockquote>
      <br>
      Completely agree, I also mentioned that problem during my talk on
      FOSDEM. But calling amdgpu_bo_unref() to often is a bug in itself.<br>
    </blockquote>
    <p>That's not the problem here.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com"> <br>
      What we could probably do to detect this is adding a BUG_ON() in
      TTMs release function and checking if the GEM reference count is
      really dead.<br>
    </blockquote>
    <p>The problem is, that we have to guess whether there are still any
      dmabuf references to the GEM BO. There is no way amdgpu can know
      that. You can't make amdgpu responsible for keeping a reference to
      the TTM BO while the GEM BO is still referenced by entities
      completely out of the control of amdgpu.</p>
    <p>Another weird thing I see is that amdgpu_gem_free_object calls
      amdgpu_bo_unref. That implies that the GEM object conceptually
      holds a reference to the amdpu/TTM BO. But that is not really the
      case. Amdgpu never takes that reference that GEM is supposed to
      own. If it did, we would leak all our memory because nobody would
      ever drop that reference.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com"> <br>
      <blockquote type="cite" cite="mid:170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com">I think
        the correct solution is for amdgpu_bo_ref/unref to delegate its
        reference counting to drm_gem_object_get/put instead of
        ttm_bo_get/put. The amdgpu BO would hold one token reference to
        the TTM BO, which it can drop when the GEM BO refcount drops to
        0. Finally, the amdgpu BO should only be freed once the TTM BO
        refcount also becomes 0.<br>
      </blockquote>
      <br>
      Just the other way around, but yes the long term plan should
      probably be to merge the two.<br>
    </blockquote>
    <p>I need a short term solution. Because I have a bug that causes a
      kernel oops with applications that are valid and correct, as far
      as I can tell.</p>
    <p>I'm thinking a solution that doesn't require major changes to the
      way TTM and GEM interact would put amdgpu in charge of
      coordinating the two. Unfortunately that would mean adding a third
      reference count in amdgpu_bo, in addition to the ones in TTM and
      GEM. The amdgpu BO would hold one token reference to each of the
      GEM and TTM BO. When amdgpu refcount goes to 0 it releases that
      GEM BO token reference. When the GEM BO refcount goes&nbsp; to 0, we
      get a callback amdgpu_gem_object_free. There we can drop the token
      reference to the TTM BO. Once the TTM BO reference goes to 0 we
      free the memory.</p>
    <p>Does this sound feasible?<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com"> <br>
      The difficult is currently we have a mismatch what locks could be
      taken when we drop the references.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com">
        <p>Regards,<br>
          &nbsp; Felix<br>
        </p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
          <div class="moz-cite-prefix"> <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 01.05.20 um 16:44 schrieb Felix Kuehling:<br>
          </div>
        </blockquote>
        <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
          <blockquote type="cite" cite="mid:551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com">
            <p>[dropping my gmail address]</p>
            <p>We saw this backtrace showing the call chain while
              investigating a kernel oops caused by this issue on the
              DKMS branch with the KFD IPC API. It happens after a
              dma-buf file is released with fput:</p>
            <pre>[ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
[ 1255.049727] #PF: supervisor read access in kernel mode
[ 1255.050092] #PF: error_code(0x0000) - not-present page
[ 1255.050416] PGD 0 P4D 0
[ 1255.050736] Oops: 0000 [#1] SMP PTI
[ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
[ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
[ 1255.051752] Workqueue: events delayed_fput
[ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked&#43;0x1c/0x70 [drm]
[ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 &lt;48&gt; 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
[ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
[ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
[ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
[ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
[ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
[ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
[ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
[ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
[ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.057763] PKRU: 55555554
[ 1255.058179] Call Trace:
[ 1255.058603]  drm_gem_dmabuf_release&#43;0x1a/0x30 [drm]
[ 1255.059025]  dma_buf_release&#43;0x56/0x130
[ 1255.059443]  __fput&#43;0xc6/0x260
[ 1255.059856]  delayed_fput&#43;0x20/0x30
[ 1255.060272]  process_one_work&#43;0x1fd/0x3f0
[ 1255.060686]  worker_thread&#43;0x34/0x410
[ 1255.061099]  kthread&#43;0x121/0x140
[ 1255.061510]  ? process_one_work&#43;0x3f0/0x3f0
[ 1255.061923]  ? kthread_park&#43;0xb0/0xb0
[ 1255.062336]  ret_from_fork&#43;0x35/0x40
</pre>
            <p>drm_gem_object_put_unlocked calls drm_gem_object_free
              when the obj-&gt;refcount reaches 0. From there it calls
              dev-&gt;driver-&gt;gem_free_object_unlocked, which is
              amdgpu_gem_object_free in amdgpu.<br>
            </p>
            <p>Regards,<br>
              &nbsp; Felix<br>
            </p>
            <div class="moz-cite-prefix">Am 2020-05-01 um 10:29 a.m.
              schrieb Christian König:<br>
            </div>
            <blockquote type="cite" cite="mid:70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com">Am
              01.05.20 um 16:21 schrieb Felix Kuehling: <br>
              <blockquote type="cite">From: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@gmail.com" moz-do-not-send="true">&lt;felix.kuehling@gmail.com&gt;</a>
                <br>
                <br>
                That reference gets dropped when the the dma-buf is
                freed. Not incrementing <br>
                the refcount can lead to use-after-free errors. <br>
                <br>
                Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@gmail.com" moz-do-not-send="true">&lt;felix.kuehling@gmail.com&gt;</a>
                <br>
                --- <br>
                &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;- <br>
                &nbsp; 1 file changed, 8 insertions(&#43;), 1 deletion(-) <br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
                index ffeb20f11c07..a0f9b3ef4aad 100644 <br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
                &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
                @@ -398,8 &#43;398,15 @@ struct dma_buf
                *amdgpu_gem_prime_export(struct drm_gem_object *gobj, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-EPERM); <br>
                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf = drm_gem_prime_export(gobj, flags); <br>
                -&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) <br>
                &#43;&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) { <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf-&gt;ops = &amp;amdgpu_dmabuf_ops; <br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GEM needs a reference to the underlying
                object <br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that gets dropped when the dma-buf is
                released, <br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * through the amdgpu_gem_object_free callback
                <br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from drm_gem_object_put_unlocked. <br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_ref(bo); <br>
                &#43;&nbsp;&nbsp;&nbsp; } <br>
              </blockquote>
              <br>
              Of hand that doesn't sounds correct to me. Why should the
              exported bo be closed through amdgpu_gem_object_free()? <br>
              <br>
              Regards, <br>
              Christian. <br>
              <br>
              <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return buf; <br>
                &nbsp; } <br>
              </blockquote>
              <br>
            </blockquote>
            <br>
            <fieldset class="mimeAttachmentHeader"></fieldset>
            <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------EDB8FD0A3BE32BE1396C5205--

--===============0060554663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0060554663==--
