Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD8EC47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3268220675
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QfD+JYVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F218D6E7D1;
	Tue,  5 May 2020 15:19:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5FE36E7D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 15:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9m8V6RwCxl2Np6tBI0qKHBG9Dbww4dzBtL5pe3X2VDjBcpdaG3w8bm9YlvU0SMEYKdzoHl6f/Sb+eopXFfwEbJcoA84Armr4rBvcG2fOs0lIFHoTiArGUU0tXm6gY5lI6vGRS1AhWqrURaUB/eaXuyEK2CSmA/6CLfuXj49BkxsXQU1S8I0CNZc2q8x2K8T/hqyeZvGupn4oF3LDyySWxtaMUvVNubhXrUUfnY2p+6h18icChYyX2qXbNtGofjA+Z8Ky2cRvY5GwspdJJ4TempmiryD/ZqClB2gUCO0UH0LrfHeLZplgvi95dSWeXdaP2I4xTlLsN+rUEiXcFeylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUMAZEstm9DD9A4c1XXtok1C5rnnOO1r8ilvjUMxAGY=;
 b=eJRo3yWpClcZS7oSTS/8ZUu3MfXOtluCCyckiHsIn4XF1R1Yw1kbeR5mmYFa/HoA9AyzvELztLvU5zp/Hg/IVqudvYUjiDz+0qbQ63to38UoxBrcPEkhrLtgAu3vvmo8Bmq9xvl4WvENOFf4tGYhTyGj1+ejSWGIiFk2/lrXgenXSaAx2r+zAQWthMQU8h1pz1AwzD3YQN1cgv81kaPSfzAXg8Zf9kQTUqRKkIjBSMK5VfBNM4H+PUBr/H8bYFqkIvjvPnlkrF036nln2oTQfBgC/Zis5eoqAK0qNA78IC1dLW6iiQswOvJma4LAN3ahxLZoBhJ2Ws0Yv5rt1fBTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUMAZEstm9DD9A4c1XXtok1C5rnnOO1r8ilvjUMxAGY=;
 b=QfD+JYVHEmYo76L6D1o+LzvRMHaYIP9CeeNiFkiIp/vOKO4R15IBuXbPi0g2LWQWqXB0m6fuFOj3f3Wd9K4LidH8zLE/frilrmFjHaGSjY4L6NmMZY0g83RxTle3Xw5dblqz7EAY5OranujBLX8cGTue/zXiCOc5OwZenSZwUbg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 15:19:40 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.027; Tue, 5 May 2020
 15:19:40 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
 <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
 <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
 <6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com>
 <170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com>
Date: Tue, 5 May 2020 17:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0057.eurprd07.prod.outlook.com
 (2603:10a6:207:4::15) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0057.eurprd07.prod.outlook.com (2603:10a6:207:4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.17 via Frontend Transport; Tue, 5 May 2020 15:19:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc333453-dd77-4715-21a1-08d7f107bad1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:|DM6PR12MB3913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3913779A8A0DF3B75C8A912483A70@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmjA5UsFbWplzHogwnj1SqE7hyAOxEVfIQOvnPUCbRbKfySjXbVFeUCuG72Thhz3UPPNnfZfGzpu7zO0uBE8m16rId/MRQsB7EIVBYOlV65Gwoy3a3o0rqPwjUuPMjBQvi/03lKjNo99KcaBefGOBSUP1ELXmDTdAN5PXrIefY97AdY49SopCFecBnzxwWh7lssk0K5nDAm9+Drp2Y6KrCTYjkEPmO/YJL6aHLEEJ3w8YIVnXxrUlOqlga2LLWUVcyx/pTilu3bk00gOs+2zJBu1F0MT6x+RLeL2BZxayS6pcy7Zac6bJoWxFsEol6TziHfzn/GPvgAvOXdZUbopg1dmrhJ8iS62iDvNMvFABdW4VBFhNIkOL2gyzBoj50k3eWvO6y8d1UQX4mNBtOdtQ26GDQW6qEmRULlcBmim0R4j89T6/vG0nVFII0F6Z/h0wofOHWl74U0QreAd91XD+5mLhoDnkcFMm2E/sR7ylXjTviN+6aCBKtrwDR/h4YSm9SE61LJjlHF2LNG7YjrqmI9S9Yqx5dKSNcMcX+np4jLrcFLrjzJNZJdGHn4x+wb/72KWAl6Ucc85CCpvvPD/jkMBcqCNBWA3Z8y1rZzTUD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(33430700001)(316002)(36756003)(8936002)(66946007)(8676002)(2616005)(66476007)(31686004)(33440700001)(66556008)(6666004)(186003)(478600001)(16526019)(52116002)(2906002)(33964004)(30864003)(966005)(86362001)(5660300002)(31696002)(6486002)(66574012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F32yDwFyYtvKfNWEqDyYfdWvNo77j3qkOXKhU5/XyMYTbGa+oGg/S0TzF4dD3zRW3UTHJemM6oBSIPta7E8VRLD9gNImtPqZnIbIMcLpayMweI2PtpwUZ2YbuFkCysaVw8i6c1UDGZrm+JQhihqu+53fkWvwk79VX3jsFAxuCvCJ3ORzcHHrqm40bSTVh6AyNzqgUC/1D+FRMokIybpEVFilzh5jtnORifsne4za7jKH7Mhyecz9wFgY1EIwiWvoHrQl8mI7x6PgTOJ6PUHeY9r90naO14E7jnL9pi9pSMm13kU5eWOsKcJLzE9clIBp530Lp8oSItcKGk2h020VTgla/VCMDh25R/OCKLzPDQmSAyXcLdew1Vc4jMW+IpKBS0eyEPdFTc24DxR/Iz964ev7Xtqvr+DganE2G2D6aj201tTf1Sx9M9oNP5xy+O8QkHMUKqfmZFoej96QmJt+NmNf1dbmYiVJZrIzgo9mMDFG+lv5eAf9x3xc6rUIlX1cqZTdtKcTy4M5I3FvmYmlCd6dhlyEPxpabAki0Ej/7GJOUX5PdRVqCBQWQ2pa0BhNF8LIraICQBjKlZZ9rdAY5SMUMe8mdG0Gj06drthzVEGebp80DKcfdgu+P8LSUDfZaVD7eP/VTPYs3ZHEXQmnH6sgTeJvD5Dw9VtyWBFtjLYcpTt+mYOnpf1BAjEqR35zxeGaMdV22VUXvgbRrYN7g23w7IpYyBfVPzCk97O+t8fx7k8AZMWyXTyFYgKke16u2g4Yyyi2AnDlsIreW+PPXx6z0seBfmY9vE1yF//CggON6dyJapNaLJkJ0/rzwdeLrdSPGmOOWXVQfaZ1Ji2k8kEBYObk55exN7itE+P0+pY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc333453-dd77-4715-21a1-08d7f107bad1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 15:19:40.0056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyziWpmWM00+ZapQmZNtslEsP3Kx86EqU/8whX7SuFFuVhu2wAUoHWWXJ7FPTlTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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
Content-Type: multipart/mixed; boundary="===============0424544154=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0424544154==
Content-Type: multipart/alternative;
 boundary="------------9643F2BA1F85A8F543051015"
Content-Language: en-US

--------------9643F2BA1F85A8F543051015
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.05.20 um 16:58 schrieb Felix Kuehling:
> Am 2020-05-05 um 3:47 a.m. schrieb Christian König:
>> Just to reply here once more, this patch is a clear NAK.
>
> Agreed. But see below. I don't think all is well.
>
>>
>> The references are grabbed in the call path of drm_gem_prime_export() 
>> and dropped again in drm_gem_dmabuf_release().
>>
>> So they are perfectly balanced as far as I can see.
>
> That is true for the GEM object references. But I believe there is 
> still a problem with the TTM BO references.
>
> As far as I can tell amdgpu_bo_unref can free the TTM BO while there 
> are still references to the GEM object from DMA buf exports. I think 
> that's a fundamental problem with how we have two reference counts for 
> the same physical object (TTM BO and the embedded GEM BO).
>

Completely agree, I also mentioned that problem during my talk on 
FOSDEM. But calling amdgpu_bo_unref() to often is a bug in itself.

What we could probably do to detect this is adding a BUG_ON() in TTMs 
release function and checking if the GEM reference count is really dead.

> I think the correct solution is for amdgpu_bo_ref/unref to delegate 
> its reference counting to drm_gem_object_get/put instead of 
> ttm_bo_get/put. The amdgpu BO would hold one token reference to the 
> TTM BO, which it can drop when the GEM BO refcount drops to 0. 
> Finally, the amdgpu BO should only be freed once the TTM BO refcount 
> also becomes 0.

Just the other way around, but yes the long term plan should probably be 
to merge the two.

The difficult is currently we have a mismatch what locks could be taken 
when we drop the references.

Regards,
Christian.

> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>> Am 01.05.20 um 16:44 schrieb Felix Kuehling:
>>>
>>> [dropping my gmail address]
>>>
>>> We saw this backtrace showing the call chain while investigating a 
>>> kernel oops caused by this issue on the DKMS branch with the KFD IPC 
>>> API. It happens after a dma-buf file is released with fput:
>>>
>>> [ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
>>> [ 1255.049727] #PF: supervisor read access in kernel mode
>>> [ 1255.050092] #PF: error_code(0x0000) - not-present page
>>> [ 1255.050416] PGD 0 P4D 0
>>> [ 1255.050736] Oops: 0000 [#1] SMP PTI
>>> [ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
>>> [ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
>>> [ 1255.051752] Workqueue: events delayed_fput
>>> [ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
>>> [ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 <48> 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
>>> [ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
>>> [ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
>>> [ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
>>> [ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
>>> [ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
>>> [ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
>>> [ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
>>> [ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
>>> [ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [ 1255.057763] PKRU: 55555554
>>> [ 1255.058179] Call Trace:
>>> [ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
>>> [ 1255.059025]  dma_buf_release+0x56/0x130
>>> [ 1255.059443]  __fput+0xc6/0x260
>>> [ 1255.059856]  delayed_fput+0x20/0x30
>>> [ 1255.060272]  process_one_work+0x1fd/0x3f0
>>> [ 1255.060686]  worker_thread+0x34/0x410
>>> [ 1255.061099]  kthread+0x121/0x140
>>> [ 1255.061510]  ? process_one_work+0x3f0/0x3f0
>>> [ 1255.061923]  ? kthread_park+0xb0/0xb0
>>> [ 1255.062336]  ret_from_fork+0x35/0x40
>>>
>>> drm_gem_object_put_unlocked calls drm_gem_object_free when the 
>>> obj->refcount reaches 0. From there it calls 
>>> dev->driver->gem_free_object_unlocked, which is 
>>> amdgpu_gem_object_free in amdgpu.
>>>
>>> Regards,
>>>   Felix
>>>
>>> Am 2020-05-01 um 10:29 a.m. schrieb Christian König:
>>>> Am 01.05.20 um 16:21 schrieb Felix Kuehling:
>>>>> From: Felix Kuehling <felix.kuehling@gmail.com>
>>>>>
>>>>> That reference gets dropped when the the dma-buf is freed. Not 
>>>>> incrementing
>>>>> the refcount can lead to use-after-free errors.
>>>>>
>>>>> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>> index ffeb20f11c07..a0f9b3ef4aad 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>> @@ -398,8 +398,15 @@ struct dma_buf 
>>>>> *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>>>>>           return ERR_PTR(-EPERM);
>>>>>         buf = drm_gem_prime_export(gobj, flags);
>>>>> -    if (!IS_ERR(buf))
>>>>> +    if (!IS_ERR(buf)) {
>>>>>           buf->ops = &amdgpu_dmabuf_ops;
>>>>> +        /* GEM needs a reference to the underlying object
>>>>> +         * that gets dropped when the dma-buf is released,
>>>>> +         * through the amdgpu_gem_object_free callback
>>>>> +         * from drm_gem_object_put_unlocked.
>>>>> +         */
>>>>> +        amdgpu_bo_ref(bo);
>>>>> +    }
>>>>
>>>> Of hand that doesn't sounds correct to me. Why should the exported 
>>>> bo be closed through amdgpu_gem_object_free()?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>         return buf;
>>>>>   }
>>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>


--------------9643F2BA1F85A8F543051015
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 05.05.20 um 16:58 schrieb Felix
      Kuehling:<br>
    </div>
    <blockquote type="cite" cite="mid:170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com">
      
      <div class="moz-cite-prefix">Am 2020-05-05 um 3:47 a.m. schrieb
        Christian König:<br>
      </div>
      <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
        <div class="moz-cite-prefix">Just to reply here once more, this
          patch is a clear NAK.<br>
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
      <p>That is true for the GEM object references. But I believe there
        is still a problem with the TTM BO references.</p>
      <p>As far as I can tell amdgpu_bo_unref can free the TTM BO while
        there are still references to the GEM object from DMA buf
        exports. I think that's a fundamental problem with how we have
        two reference counts for the same physical object (TTM BO and
        the embedded GEM BO).</p>
    </blockquote>
    <br>
    Completely agree, I also mentioned that problem during my talk on
    FOSDEM. But calling amdgpu_bo_unref() to often is a bug in itself.<br>
    <br>
    What we could probably do to detect this is adding a BUG_ON() in
    TTMs release function and checking if the GEM reference count is
    really dead.<br>
    <br>
    <blockquote type="cite" cite="mid:170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com">I think
      the correct solution is for amdgpu_bo_ref/unref to delegate its
      reference counting to drm_gem_object_get/put instead of
      ttm_bo_get/put. The amdgpu BO would hold one token reference to
      the TTM BO, which it can drop when the GEM BO refcount drops to 0.
      Finally, the amdgpu BO should only be freed once the TTM BO
      refcount also becomes 0.<br>
    </blockquote>
    <br>
    Just the other way around, but yes the long term plan should
    probably be to merge the two.<br>
    <br>
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
            investigating a kernel oops caused by this issue on the DKMS
            branch with the KFD IPC API. It happens after a dma-buf file
            is released with fput:</p>
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
          <p>drm_gem_object_put_unlocked calls drm_gem_object_free when
            the obj-&gt;refcount reaches 0. From there it calls
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
              That reference gets dropped when the the dma-buf is freed.
              Not incrementing <br>
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
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GEM needs a reference to the underlying object
              <br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that gets dropped when the dma-buf is
              released, <br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * through the amdgpu_gem_object_free callback <br>
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
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------9643F2BA1F85A8F543051015--

--===============0424544154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0424544154==--
