Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B654F9D0F6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 21:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1ED10E05C;
	Tue, 14 Apr 2026 21:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WsV7KI99";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80D110E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 21:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+ZJRcxfqsxHr6fOk6C4hCrmIiW/qDidz4eqvXO8+OGebTLxlgVrlNfphshR4c1MnMJrIGXx/QBMSsugZSXRUQ0edWVb7XP/tcstOUTkfryBN9Q4IOspoUOGgo/Lh/F4owssCaHO5eJZuPv+0XfYu9O4LKh36ploG+tjnA71Lssg7q5+Hr3q/FWDxJEy0xYmBycMSwgsP85aVKkDrcP+bYGxy2gE7OXF3zsyaJh6BcoSB9qAn6p0HSVNNwrZFQjxXD5Q6C+5T8oAQJNhHifEVq1DIAArcFqgyRL32/NcsKQ+GgW6r0dLSjOS7aLxXxQ73NkhlfUPm2v3yy8aNRrKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWNR78oZ2F00N0Zuf/X5wzPwQrqQbtvHllrG7VTYqAI=;
 b=ftEb783s8DbYRUxvgRJD8KjDuMo/RathWn9Y0ejaAMMs660KJJikMf64YltILGXPbIH5H/qYdf6BNLvh7KCcKcUYw6Z4O5RiM9NFt5+IoFXsWGNikD3xGeRJEKob7qqo1jIoQ/Jnf/QgAWxwI57VXARMNjpJSTQw2SdDSUMqIg81g3C79+XBuVFTphJhb25dsnvfMJ+PDHtUZkQRMxa9Hw1o/7J8LqkEyLBCelpCbucsHzl2nRpRM2ss8qFoM0Kfs35aWD1kQEE1SXwS9BHVsuiEDph72H/X7c4TVJZFIMM7DFfxf1CfnETSfkYB0ylGk45fTxZUB3KkzaaHJyti7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWNR78oZ2F00N0Zuf/X5wzPwQrqQbtvHllrG7VTYqAI=;
 b=WsV7KI9928LjFqos+1d0XV3g5Y0Wfx4Dna+5tPew15+hECPVomzSRXG4W4Sh4ZR1V5ZVx5zRStZ9DjUq/Y8Y9Pa9yU4qPLrLAE/GLNvaO8i/k2CyhLVKPaUIMwrTNILLQSWrt8QwpRgwbdi6pCT11JYYbPiHo91uzIRu9deLagQ=
Received: from PH7P221CA0079.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::14)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 21:53:07 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::c8) by PH7P221CA0079.outlook.office365.com
 (2603:10b6:510:328::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 21:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Tue, 14 Apr 2026 21:53:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 16:53:06 -0500
Received: from [10.254.92.140] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 16:53:05 -0500
Message-ID: <878f4072-dc5f-4fcf-b691-ae823961eb80@amd.com>
Date: Tue, 14 Apr 2026 17:53:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix crash due to NULL dc dereference in
 ISM during teardown
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Ray"
 <Ray.Wu@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Mario Limonciello" <superm1@kernel.org>
References: <20260411043538.2304235-1-srinivasan.shanmugam@amd.com>
 <5276d674-96a1-4650-8224-bb29cd1bd009@amd.com>
 <IA0PR12MB82087F81E20FE6218209087F90252@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <IA0PR12MB82087F81E20FE6218209087F90252@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6bbe5b-de87-488c-aa67-08de9a7035ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: epePRUvYjqac0vkQJ4DVlz1scaUITzZ4JxDa9osK2A9fGWSK3HW+Sr7SCo2w42qjvUWtSiPCWtQRLJ9Leeha9MIO4ixLUC4wENXePI2iRJKs5ubhKZTc0mh5F8L1VPqG0T76U7xoW9WIOtrpzlFcegHXdBuv1kQ5pcnxAPeOdnRx3ZGx19n/zPvjsAXPAY0yk+qlbAmuOScUd+cN6FDqNit1PEyJ2HFnpxb4OWgrkSuZyEz20jMB7I2LOPkzeLHyXVXWAI7u7OG7Cu/oiJxGP5MiCo5F0BS5wGHXGwNa49H+VNkqzQvNU7UPn/eXrDhdhf3ghvS4NWAL8/udeK6aPXUg+Smwt5ZaZ84wQZXJHmGdy+LnPN/1/tuh4rlZsSHehR9+F58112HULvxIvflf5OLfVbHjrtztDUQAIVyTBWq4uIRs9iRyWiwtZ/e63Y6u8Z6mNxlbxTWKRvZfr0E1QhbfdmMd4Ajr5chjMA/9GOouDG9w7B1A83+qZmhvgi9xCJddrPfP1/svzMdF8i0QBzmh02nK83wevirgfbUyc6IIOaUAfhIYTFshSyICSRVeT5crkyOopXe43LjW/7qUjtriadS2sjPDoJ9gAoaUWGl/YOoJzAb/WQJhNd6oTWxGoo3mEgsQ0F9DBFMLo02a0ZFyeqbsCjfLe9tdDWbmIi+1Zb/1fg/Qt9yu8FZ2MINzYK40333iv1L7psdVz+RpBX0TpvdUJUN02PsHxQ2yCE4iOf8ljNe48+I3FYIRgUgLAeSRtNuKZ+Kx2qPG84ISiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aPopo4rUdfwvt8AlKos4B/0j99onvSBZKVtsK6KPvk48b+D3Wzok4GzblMCjyzWnvxs4VzleEpTsNvMDSq6haB/TBZRwmdRi8+Z6GVBASeFOw1lY8IvTMiRbrxjVoB/KcT2no6FIcG/iZiIb2vRWjhLPF+eiUnKw80mkLBZLM5lrIut+UXBtOD8zcNqOywUKBnt/sWj/1OHgXiYHepMkXwuWqQHhka8l7UwL2+/2RhZbwPZ871GyfyBCs0od8qDrl856310n/e4n8Bzlz0xgAsbL1PF/iLGnD3ON9nTjHh+qOqJReos7nInUTMg8OEHSVmiviIixUosnc7yY8nVZyJpcahy7MAq+6ri2SIoYjOWCauCr9QRsH20npWVbh7UtAhi4llOiTtyPTZXG3+KeCxITzs+N1rvl2FpcKXr1z1NkOo+wwOK8Y88vFtKzzdyO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 21:53:06.4100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6bbe5b-de87-488c-aa67-08de9a7035ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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



On 2026-04-14 12:54, SHANMUGAM, SRINIVASAN wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Leo Li <sunpeng.li@amd.com>
>> Sent: Monday, April 13, 2026 8:14 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo
>> <Aurabindo.Pillai@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Wu, Ray <Ray.Wu@amd.com>; Li, Roman
>> <Roman.Li@amd.com>; Chung, ChiaHsuan (Tom)
>> <ChiaHsuan.Chung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
>> Mario Limonciello <superm1@kernel.org>
>> Subject: Re: [PATCH] drm/amd/display: Fix crash due to NULL dc dereference in
>> ISM during teardown
>>
>>
>>
>> On 2026-04-11 00:35, Srinivasan Shanmugam wrote:
>>> The Idle State Manager (ISM) uses delayed work to apply display idle
>>> optimizations later, instead of immediately. This helps avoid rapid
>>> idle transitions that can hurt power or performance.
>>>
>>> A crash was seen during driver teardown. The system boots normally and
>>> the driver loads successfully. Later, when the GPU is being stopped,
>>> the log shows:
>>>
>>>   amdgpu 0000:0e:00.0: finishing device.
>>>   Workqueue: events_unbound dm_ism_sso_delayed_work_func [amdgpu]
>>>
>>> After this, delayed ISM work still runs and reaches:
>>>
>>>   dm_ism_sso_delayed_work_func()
>>>     -> amdgpu_dm_ism_commit_event()
>>>     -> dm_ism_commit_idle_optimization_state()
>>>     -> dc_allow_idle_optimizations_internal()
>>>
>>> The crash report showed:
>>>   KASAN: null-ptr-deref in range [0x690-0x697]
>>>
>>> GDB resolved dc_allow_idle_optimizations_internal+0xa6 to:
>>>   struct dc_state *context = dc->current_state;
>>>
>>> The matching disassembly showed:
>>>   mov %rdi, %r12
>>>   mov 0x690(%r12), %r13
>>>
>>> where r12 holds the dc pointer. A GDB layout dump of struct dc also
>>> showed:
>>>
>>>   /* 1680 | 8 */ struct dc_state *current_state;
>>>
>>> Since 1680 decimal is 0x690, this confirms that current_state is at
>>> offset 0x690. The crash address (~0x690) shows that the access was:
>>>
>>>   dc + 0x690
>>>
>>> This means dc was NULL at the time of the dereference.
>>>
>>> So the issue is:
>>>
>>>   delayed work runs after dm->dc is cleared during teardown
>>>   -> dc becomes NULL
>>>   -> dc->current_state is accessed
>>>   -> crash
>>>
>>> The current ISM code calls into the DC idle optimization path from the
>>> delayed work handlers and from amdgpu_dm_ism_commit_event() without
>>> checking whether dm->dc is still valid. In addition,
>>> dm_ism_commit_idle_optimization_state() calls
>>> dc_allow_idle_optimizations(dm->dc, ...) unconditionally.
>>
>> Hi Sirini, thanks for catching this.
>>
>> Regarding dc==null, I'd prefer the ISM to throw an ASSERT rather than failing
>> silently, since the ISM should never run after dc is destroyed. If it does, it should be
>> fixed as a bug.
>>
>> In addition, we only need to ASSERT(dc) in amdgpu_dm_ism_commit_event(), as
>> the other functions (in regards to the ISM) are static and only reachable from
>> amdgpu_dm_ism_commit_event().
>>
>>>
>>> Also, amdgpu_dm_ism_commit_event() requires dc_lock to be held, but
>>> amdgpu_dm_ism_disable() calls it without taking that lock.
>>
>> We're expecting the caller to hold the dc_lock, so maybe an ASSERT(dc_lock)
>> should also be added in ism_disable() to make that clear. (Only the workqueue
>> workers need to acquire their own dc_lock)
>>
>>>
>>> Fix this by:
>>> - checking dm->dc in delayed work paths
>>> - checking dm->dc in the commit path
>>> - checking dm->dc before entering the idle optimization path
>>> - adding a defensive NULL check in
>>>   dc_allow_idle_optimizations_internal()
>>> - taking dc_lock in amdgpu_dm_ism_disable() before calling commit
>>>
>>> This prevents delayed ISM work from accessing an invalid dc pointer
>>> during or after driver teardown.
>>
>> I was expecting the amdgpu_dm_fini > amdgpu_dm_ism_fini callpath to wait on any
>> remaining work before destroying dc. But perahps there were additional items
>> queued between amdgpu_dm_fini and dc_destroy.
>>
>> Could you give the below diff a try to see if it fixes the npd for you?
>>
>> - Leo
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 09121152b980a..0d10e048b6754 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2237,8 +2237,6 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block
>> *ip_block)  static void amdgpu_dm_fini(struct amdgpu_device *adev)  {
>>       int i;
>> -     struct drm_crtc *crtc;
>> -     struct amdgpu_crtc *acrtc;
>>
>>       if (adev->dm.vblank_control_workqueue) {
>>               destroy_workqueue(adev->dm.vblank_control_workqueue);
>> @@ -2256,11 +2254,8 @@ static void amdgpu_dm_fini(struct amdgpu_device
>> *adev)
>>       }
>>
>>       /* Finalize ISM for each CRTC before dc_destroy() sets dm->dc to NULL */
>> -     drm_for_each_crtc(crtc, adev_to_drm(adev)) {
>> -             acrtc = to_amdgpu_crtc(crtc);
>> -             amdgpu_dm_ism_fini(&acrtc->ism);
>> -
>> -     }
>> +     scoped_guard(mutex, &adev->dm.dc_lock)
>> +             amdgpu_dm_ism_disable(&adev->dm);
>>
>>       amdgpu_dm_destroy_drm_device(&adev->dm);
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> index a3ccb6fdc372e..3baee7aa71a9d 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> @@ -545,6 +545,8 @@ void amdgpu_dm_ism_disable(struct
>> amdgpu_display_manager *dm)
>>       struct amdgpu_crtc *acrtc;
>>       struct amdgpu_dm_ism *ism;
>>
>> +     ASSERT(mutex_is_locked(&dm->dc_lock));
>> +
>>       drm_for_each_crtc(crtc, dm->ddev) {
>>               acrtc = to_amdgpu_crtc(crtc);
>>               ism = &acrtc->ism;
>>
> 
> 
> Hi Leo,
> 
> Thanks for the feedbacks
> 
> I agree that ISM should not run after dc is destroyed, and that this is
> better fixed by ordering/disable logic instead of silently returning on
> NULL.
> 
> This issue is hard to reproduce consistently, but was observed during
> driver unload when the driver was loaded with UI disabled. This suggests
> there may still be a small timing window where delayed work can run after
> dc is cleared.
> 
> I reworked the patch in the direction you suggested:
> 
> call amdgpu_dm_ism_disable() under dc_lock from amdgpu_dm_fini()
> add ASSERT(mutex_is_locked(&dm->dc_lock)) in amdgpu_dm_ism_disable()
> add ASSERT(dm->dc) in amdgpu_dm_ism_commit_event()
> 
> Please let me know if this approach looks good?

It makes sense, feel free to add my r-b when sending it out.

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks,
Leo

> 
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 09121152b980a..0d10e048b6754 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2237,8 +2237,6 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
>  static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  {
>         int i;
> -       struct drm_crtc *crtc;
> -       struct amdgpu_crtc *acrtc;
> 
>         if (adev->dm.vblank_control_workqueue) {
>                 destroy_workqueue(adev->dm.vblank_control_workqueue);
> @@ -2256,11 +2254,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>                 adev->dm.idle_workqueue = NULL;
>         }
> 
> -       /* Finalize ISM for each CRTC before dc_destroy() sets dm->dc to NULL */
> -       drm_for_each_crtc(crtc, adev_to_drm(adev)) {
> -               acrtc = to_amdgpu_crtc(crtc);
> -               amdgpu_dm_ism_fini(&acrtc->ism);
> -
> -       }
> +       /* Disable ISM before dc_destroy() invalidates dm->dc */
> +       scoped_guard(mutex, &adev->dm.dc_lock)
> +               amdgpu_dm_ism_disable(&adev->dm);
> 
>         amdgpu_dm_destroy_drm_device(&adev->dm);
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index a3ccb6fdc372e..3baee7aa71a9d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -472,6 +472,9 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
>         /* ISM transitions must be called with mutex acquired */
>         ASSERT(mutex_is_locked(&dm->dc_lock));
> 
> +       /* ISM should not run after dc is destroyed */
> +       ASSERT(dm->dc);
> +
>         if (!acrtc_state) {
>                 trace_amdgpu_dm_ism_event(acrtc->crtc_id, "NO_STATE",
>                                           "NO_STATE", "N/A");
> @@ -545,6 +548,8 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
>         struct amdgpu_crtc *acrtc;
>         struct amdgpu_dm_ism *ism;
> 
> +       ASSERT(mutex_is_locked(&dm->dc_lock));
> +
>         drm_for_each_crtc(crtc, dm->ddev) {
>                 acrtc = to_amdgpu_crtc(crtc);
>                 ism = &acrtc->ism;
> 
> Thanks,
> Srini

