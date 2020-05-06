Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD97C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 07:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FF520663
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 07:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="riUx7sus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FF520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20056E288;
	Wed,  6 May 2020 07:15:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F4E6E287
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 07:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPxLe5o6LwcxGlD6OI8Ma38CgZE7Cwier/BNVyx1mJRMu7Oc4RYq+i1cy1YntUABDKWlIjIvxBDxlKOV9U14xd96Ht1WAYVA+0u9r7OfYw0kL48uKg+MTgOqC63KKCJ74a+AFEfkDJi7tovx5fhTfIZrhVyPcR0NrXmiK8XX0VWX1IXoXFFx65azQaKogGZ1Sv6icJk1gfOvxG1a2kLPvU0Yx0KNAsRFAHgDOKl+nD0+lKgynOfMTued2HWZwnFGxP1cPUMLk2mpdkMFhAJy2Lq6LEXp4RgpxnD+Hr5DuJ9ajxZPD1a6eISe0ED+6KbyFe21dwM1GDfEZ41ZXXQdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA9/3IfokFIkAw+JEUYmBMkKQt1QvIm+YYxkae+O+wc=;
 b=WDjrNl25Ibm0kASIMy8zZBdMRPkDB9KEiNSgr0HwzQXxSs0IRgzkU7lxE5oXnV0pNYmNfvg1IFyeW4CNTwMPBsZIO1CPA9kGL7wuwh4p1g/gBWcSpISA+iPvATLaYay09U4IawLG7NS2HTrg16Li1Yn7JZjJRkBqiwRoDwRIFVu0qk6GquY0HiEeuCZp9yv+4AVLTNXyQ41EcjM57vFTnxhhj77Rr91oDpAmycuHobGmGPXwFnG1llpkrtmfvNkg9PTBBg4RLxMMIC0n/ZqBj3QYI7TZQXrZxEHnEkN5CY0ukzgIwfJ3dTXNeM9ZNi5hShH6WGPtNhkQMfmPIrab1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA9/3IfokFIkAw+JEUYmBMkKQt1QvIm+YYxkae+O+wc=;
 b=riUx7sus5AWVjEC7mA7a9RjeQpj1kzjEC+Ixo2Hy5exQm+IZGt+j70L82JnGgihT3fShm793pM/Yj9VPL9jm8S8N8BqaPm9Z2ZKR+ZJXLfvsdTbbEWwKhx3yJCHesBv1uRCuhiRNz2LhK+r0lAzG8VLtYgZ9tsp8QQhzRVf5whc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 07:15:48 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.027; Wed, 6 May 2020
 07:15:47 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
 <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
 <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
 <6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com>
 <170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com>
 <ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com>
 <388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f978a495-1916-8fa8-b6fa-6f22372a016f@amd.com>
Date: Wed, 6 May 2020 09:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:207:8::22) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0136.eurprd07.prod.outlook.com (2603:10a6:207:8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Wed, 6 May 2020 07:15:45 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da81d3a2-b9ee-448f-e19b-08d7f18d4bbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3067:|DM6PR12MB3067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30670E9C3D5FF6F1F287124583A40@DM6PR12MB3067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTFdnzijB0UC27R3iPXIuZN9x/3M8u44WrgdcKxoeYvImd/vVED63mrd5DmAMhznGarYsWqIl7WxPm/rWcvJDaZzdhRAFpPgUuP3Up0+ZCUJAK+tLLgeI0Acm4jJOz4L9kqh2j6NVrASSlZ0Fb7kRleoo/aGqGXONJ2jU40eJrr/oyUi9/Q9uwdkuS2Vs+F3xG/2ysCVOrm5Z/lGO+1aGuKhEVgwZUs3S2xhNO1ryJl7tDvGRLd7AKTiedMfXKCOtilKYBoqSJOesVhNWt6mXPBxJrbwmbE2xPIw44Hx5+GFTS6UzCf72mf1fg4ZUr09AEsnM3QSYo6lw0tqPexRoV6WpeF1zXD5qSwhLG5GX4QuQn78ESGDlyaXpzaT3H+vC4du3tzHXcYNQrFG/z33KD6mzbwPa+dk3koxGlJ5dwUJiwu54h1hbNrtXjbtOA/NQCNrAxNvEe1e84WKre0RXm6oq/zDlAyHIv8f+r0/4GjU1WLjhXRAwPyuavuVpP2vQLkcxQWO+2OD3kmesjLwvZqpSSQqTT/GU1J9nq1ojC/CxOhWRnFONgUcShiso8uVDB0DV427/pq9wJf9ELG7ntXhzx6WcxToWqAX/M6+/iI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(33430700001)(966005)(66476007)(8676002)(52116002)(66556008)(31696002)(166002)(33440700001)(31686004)(16526019)(316002)(33964004)(186003)(66946007)(8936002)(30864003)(2616005)(86362001)(6486002)(6666004)(478600001)(5660300002)(36756003)(2906002)(66574014)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8yXq0QFlLR5vZuNKrGEj44k13mGmo2z0C6IIvdXOgYovf8JeRoLufh02l+SYHPSJ3fafJ9eWrwcPPcv6nZ99BJwmIn5zd/uqM3gLDzBRVSIaCTzNxCsVnqsaB/AvUJIFiWl8Cvmju1275lPsSqXZXHuaQKOzO3EXTDBa3ob2ETrk4qdvbf01q/nkR3mWnw+S+uvTffNG+vomW5QGfYp21WWa9ZFnn5X5ecHw4paQcETgxDrXKTPm2yFLSH6a+5bvJc20+qPw+LncXDWRSXKkJ5QGo/g0D00i5M9x4i0V+axI2XW2uMt48O5mMTEzzaYapZ2W8IN9TdY5E1qtHkB1gd9omBWMezGUmAlrYicF1s1MMqgTVM0S0ArQvoDENUqMXNXRuwbebBnevlXF2eXIIb3BvtSJZL7HCiJ3xG0bEyUbaprjy3cFY0WtRZJxN0iCQezPaBmD/W7FjT8WiiWRwprD6vYUpabpMTpTrpn8VQS3Whh+xxvSsVo3lwKw3EklR/NO+wAIZEWSXdmo7L1dDk4w1BQHfGLurkOQvy/Km//fggAENQUKBNdD6+wJ89baiu0dFbolJWvLVddE5si2QkXAqUfU8CNUTU0G8GMb47IxZEER3l6SaNSSyNGRq6+rPSUQFodKCXYGUHbTLqMKEsipvaLXi+kGIkkB1rm1f9Iynsli2YyXngaIrI+weRPOHzBwA10ID0G/+llBGJFfHaKNKfvZpQsuWh4cNWocC9ld1KXXglwrpOMM2qBnlmBf7edEG7qvtGVHACZgDbgTRmMOGcRX2+Rjihl7ydquyDyST++bKsTU6I3APtMZXfNOOdxHiQWBJ+3CVERl3LNk1760Ldmvnysra9Au6hFY8ig=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da81d3a2-b9ee-448f-e19b-08d7f18d4bbf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 07:15:47.1352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVx9iKHYHlSNVcgEQl07raRA+dBcngpoTNRPFpQmTLmsiKod/80PGsOKTA/rcXFU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
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
Content-Type: multipart/mixed; boundary="===============1541656756=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1541656756==
Content-Type: multipart/alternative;
 boundary="------------16FDAEAF2F272C5B57F4300F"
Content-Language: en-US

--------------16FDAEAF2F272C5B57F4300F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.05.20 um 19:29 schrieb Felix Kuehling:
>>
>> What we could probably do to detect this is adding a BUG_ON() in TTMs 
>> release function and checking if the GEM reference count is really dead.
>
> The problem is, that we have to guess whether there are still any 
> dmabuf references to the GEM BO. There is no way amdgpu can know that. 
> You can't make amdgpu responsible for keeping a reference to the TTM 
> BO while the GEM BO is still referenced by entities completely out of 
> the control of amdgpu.
>

That sounds like you don't understand how this works on the graphics 
side, so here is a brief overview once more.

The last object still around is always the TTM BO, which can even be 
resurrected from the dead (kref_init() called again) if necessary for 
delayed delete.

Then we have the GEM object which holds a reference to the TTM BO. This 
reference gets dropped when the GEM object gets destroyed.

Then we optionally have the DMA-buf object for exported BOs which holds 
a reference to the GEM object and the driver.


This construct guarantees that the GEM object is never destroyed nor the 
driver unloaded before the DMA-buf object referencing it is destroyed.

Additional to that the reference from the GEM object to the TTM BO 
guarantees that the TTM BO is never destroyed before the GEM object is 
destroyed.

> Another weird thing I see is that amdgpu_gem_free_object calls 
> amdgpu_bo_unref. That implies that the GEM object conceptually holds a 
> reference to the amdpu/TTM BO. But that is not really the case. Amdgpu 
> never takes that reference that GEM is supposed to own. If it did, we 
> would leak all our memory because nobody would ever drop that reference. 

See amdgpu_bo_do_create(), the GEM object is initialized with 
drm_gem_private_object_init() with a reference count of 1. Then the TTM 
BO is initialized with ttm_bo_init_reserved() with a reference count of 1.

In general there are two use cases here, the first one is userspace 
allocations with a GEM object handle. In this case the initial reference 
is owned by the GEM object and dropped in amdgpu_gem_free_object().

The other use case are kernel internal allocations like page tables and 
other general buffers. In this case the GEM object is ignored and the 
last TTM BO reference is dropped by calling amdgpu_bo_unref().

>>> I think the correct solution is for amdgpu_bo_ref/unref to delegate 
>>> its reference counting to drm_gem_object_get/put instead of 
>>> ttm_bo_get/put. The amdgpu BO would hold one token reference to the 
>>> TTM BO, which it can drop when the GEM BO refcount drops to 0. 
>>> Finally, the amdgpu BO should only be freed once the TTM BO refcount 
>>> also becomes 0.
>>
>> Just the other way around, but yes the long term plan should probably 
>> be to merge the two.
>
> I need a short term solution. Because I have a bug that causes a 
> kernel oops with applications that are valid and correct, as far as I 
> can tell.
>
> I'm thinking a solution that doesn't require major changes to the way 
> TTM and GEM interact would put amdgpu in charge of coordinating the 
> two. Unfortunately that would mean adding a third reference count in 
> amdgpu_bo, in addition to the ones in TTM and GEM. The amdgpu BO would 
> hold one token reference to each of the GEM and TTM BO. When amdgpu 
> refcount goes to 0 it releases that GEM BO token reference. When the 
> GEM BO refcount goes  to 0, we get a callback amdgpu_gem_object_free. 
> There we can drop the token reference to the TTM BO. Once the TTM BO 
> reference goes to 0 we free the memory.
>
> Does this sound feasible?
>

Well of hand it sounds like it makes the whole thing much more 
complicated without any gain. I probably still haven't understood what 
the core problem here is.

Regards,
Christian.

> Regards,
>   Felix
>
>
>>
>> The difficult is currently we have a mismatch what locks could be 
>> taken when we drop the references.
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 01.05.20 um 16:44 schrieb Felix Kuehling:
>>>>>
>>>>> [dropping my gmail address]
>>>>>
>>>>> We saw this backtrace showing the call chain while investigating a 
>>>>> kernel oops caused by this issue on the DKMS branch with the KFD 
>>>>> IPC API. It happens after a dma-buf file is released with fput:
>>>>>
>>>>> [ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
>>>>> [ 1255.049727] #PF: supervisor read access in kernel mode
>>>>> [ 1255.050092] #PF: error_code(0x0000) - not-present page
>>>>> [ 1255.050416] PGD 0 P4D 0
>>>>> [ 1255.050736] Oops: 0000 [#1] SMP PTI
>>>>> [ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
>>>>> [ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
>>>>> [ 1255.051752] Workqueue: events delayed_fput
>>>>> [ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
>>>>> [ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 <48> 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
>>>>> [ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
>>>>> [ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
>>>>> [ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
>>>>> [ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
>>>>> [ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
>>>>> [ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
>>>>> [ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
>>>>> [ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
>>>>> [ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> [ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> [ 1255.057763] PKRU: 55555554
>>>>> [ 1255.058179] Call Trace:
>>>>> [ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
>>>>> [ 1255.059025]  dma_buf_release+0x56/0x130
>>>>> [ 1255.059443]  __fput+0xc6/0x260
>>>>> [ 1255.059856]  delayed_fput+0x20/0x30
>>>>> [ 1255.060272]  process_one_work+0x1fd/0x3f0
>>>>> [ 1255.060686]  worker_thread+0x34/0x410
>>>>> [ 1255.061099]  kthread+0x121/0x140
>>>>> [ 1255.061510]  ? process_one_work+0x3f0/0x3f0
>>>>> [ 1255.061923]  ? kthread_park+0xb0/0xb0
>>>>> [ 1255.062336]  ret_from_fork+0x35/0x40
>>>>>
>>>>> drm_gem_object_put_unlocked calls drm_gem_object_free when the 
>>>>> obj->refcount reaches 0. From there it calls 
>>>>> dev->driver->gem_free_object_unlocked, which is 
>>>>> amdgpu_gem_object_free in amdgpu.
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>> Am 2020-05-01 um 10:29 a.m. schrieb Christian König:
>>>>>> Am 01.05.20 um 16:21 schrieb Felix Kuehling:
>>>>>>> From: Felix Kuehling <felix.kuehling@gmail.com>
>>>>>>>
>>>>>>> That reference gets dropped when the the dma-buf is freed. Not 
>>>>>>> incrementing
>>>>>>> the refcount can lead to use-after-free errors.
>>>>>>>
>>>>>>> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>>>>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>>> index ffeb20f11c07..a0f9b3ef4aad 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>>>>> @@ -398,8 +398,15 @@ struct dma_buf 
>>>>>>> *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>>>>>>>           return ERR_PTR(-EPERM);
>>>>>>>         buf = drm_gem_prime_export(gobj, flags);
>>>>>>> -    if (!IS_ERR(buf))
>>>>>>> +    if (!IS_ERR(buf)) {
>>>>>>>           buf->ops = &amdgpu_dmabuf_ops;
>>>>>>> +        /* GEM needs a reference to the underlying object
>>>>>>> +         * that gets dropped when the dma-buf is released,
>>>>>>> +         * through the amdgpu_gem_object_free callback
>>>>>>> +         * from drm_gem_object_put_unlocked.
>>>>>>> +         */
>>>>>>> +        amdgpu_bo_ref(bo);
>>>>>>> +    }
>>>>>>
>>>>>> Of hand that doesn't sounds correct to me. Why should the 
>>>>>> exported bo be closed through amdgpu_gem_object_free()?
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>         return buf;
>>>>>>>   }
>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>
>>


--------------16FDAEAF2F272C5B57F4300F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 05.05.20 um 19:29 schrieb Felix
      Kuehling:<br>
    </div>
    <blockquote type="cite" cite="mid:388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com">
      
      <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com"> <br>
        What we could probably do to detect this is adding a BUG_ON() in
        TTMs release function and checking if the GEM reference count is
        really dead.<br>
      </blockquote>
      <p>The problem is, that we have to guess whether there are still
        any dmabuf references to the GEM BO. There is no way amdgpu can
        know that. You can't make amdgpu responsible for keeping a
        reference to the TTM BO while the GEM BO is still referenced by
        entities completely out of the control of amdgpu.</p>
    </blockquote>
    <br>
    That sounds like you don't understand how this works on the graphics
    side, so here is a brief overview once more.<br>
    <br>
    The last object still around is always the TTM BO, which can even be
    resurrected from the dead (kref_init() called again) if necessary
    for delayed delete.<br>
    <br>
    Then we have the GEM object which holds a reference to the TTM BO.
    This reference gets dropped when the GEM object gets destroyed.<br>
    <br>
    Then we optionally have the DMA-buf object for exported BOs which
    holds a reference to the GEM object and the driver.<br>
    <br>
    <br>
    This construct guarantees that the GEM object is never destroyed nor
    the driver unloaded before the DMA-buf object referencing it is
    destroyed.<br>
    <br>
    Additional to that the reference from the GEM object to the TTM BO
    guarantees that the TTM BO is never destroyed before the GEM object
    is destroyed.<br>
    <br>
    <blockquote type="cite" cite="mid:388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com">Another
      weird thing I see is that amdgpu_gem_free_object calls
      amdgpu_bo_unref. That implies that the GEM object conceptually
      holds a reference to the amdpu/TTM BO. But that is not really the
      case. Amdgpu never takes that reference that GEM is supposed to
      own. If it did, we would leak all our memory because nobody would
      ever drop that reference. </blockquote>
    <br>
    See amdgpu_bo_do_create(), the GEM object is initialized with
    drm_gem_private_object_init() with a reference count of 1. Then the
    TTM BO is initialized with ttm_bo_init_reserved() with a reference
    count of 1.<br>
    <br>
    In general there are two use cases here, the first one is userspace
    allocations with a GEM object handle. In this case the initial
    reference is owned by the GEM object and dropped in
    amdgpu_gem_free_object().<br>
    <br>
    The other use case are kernel internal allocations like page tables
    and other general buffers. In this case the GEM object is ignored
    and the last TTM BO reference is dropped by calling
    amdgpu_bo_unref().<br>
    <br>
    <blockquote type="cite" cite="mid:388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com">
      <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com">
        <blockquote type="cite" cite="mid:170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com">I
          think the correct solution is for amdgpu_bo_ref/unref to
          delegate its reference counting to drm_gem_object_get/put
          instead of ttm_bo_get/put. The amdgpu BO would hold one token
          reference to the TTM BO, which it can drop when the GEM BO
          refcount drops to 0. Finally, the amdgpu BO should only be
          freed once the TTM BO refcount also becomes 0.<br>
        </blockquote>
        <br>
        Just the other way around, but yes the long term plan should
        probably be to merge the two.<br>
      </blockquote>
      <p>I need a short term solution. Because I have a bug that causes
        a kernel oops with applications that are valid and correct, as
        far as I can tell.</p>
      <p>I'm thinking a solution that doesn't require major changes to
        the way TTM and GEM interact would put amdgpu in charge of
        coordinating the two. Unfortunately that would mean adding a
        third reference count in amdgpu_bo, in addition to the ones in
        TTM and GEM. The amdgpu BO would hold one token reference to
        each of the GEM and TTM BO. When amdgpu refcount goes to 0 it
        releases that GEM BO token reference. When the GEM BO refcount
        goes&nbsp; to 0, we get a callback amdgpu_gem_object_free. There we
        can drop the token reference to the TTM BO. Once the TTM BO
        reference goes to 0 we free the memory.</p>
      <p>Does this sound feasible?<br>
      </p>
    </blockquote>
    <br>
    Well of hand it sounds like it makes the whole thing much more
    complicated without any gain. I probably still haven't understood
    what the core problem here is.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:388b628f-cfd3-b8e0-d43e-ed4cd280fee7@amd.com">
      <p> </p>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:ca18ec07-a6f4-292c-c800-48dbf9c8854f@amd.com"> <br>
        The difficult is currently we have a mismatch what locks could
        be taken when we drop the references.<br>
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
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
                  index ffeb20f11c07..a0f9b3ef4aad 100644 <br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
                  &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
                  @@ -398,8 &#43;398,15 @@ struct dma_buf
                  *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-EPERM); <br>
                  &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf = drm_gem_prime_export(gobj, flags); <br>
                  -&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) <br>
                  &#43;&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) { <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf-&gt;ops = &amp;amdgpu_dmabuf_ops; <br>
                  &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GEM needs a reference to the underlying
                  object <br>
                  &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that gets dropped when the dma-buf is
                  released, <br>
                  &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * through the amdgpu_gem_object_free
                  callback <br>
                  &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from drm_gem_object_put_unlocked. <br>
                  &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                  &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_ref(bo); <br>
                  &#43;&nbsp;&nbsp;&nbsp; } <br>
                </blockquote>
                <br>
                Of hand that doesn't sounds correct to me. Why should
                the exported bo be closed through
                amdgpu_gem_object_free()? <br>
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
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------16FDAEAF2F272C5B57F4300F--

--===============1541656756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1541656756==--
