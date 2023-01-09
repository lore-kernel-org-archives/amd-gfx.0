Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A576C5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 20:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1484610E503;
	Mon,  9 Jan 2023 20:27:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE1E10E503
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 20:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqk6uXx6zbCsjI3WMEh8g0eKACamjCSSTbknKCLo3GZD4sfY1+NZ/86rr1cqtzvmtqKc8zek6Ysyosy/snx3ql53nT8vXKvc9hRW0uqaLcoAW+ceAsGrXIKhT3lA70+diGe+/KPdmqEgQp+Tmsxvbww9/ycucXxetV+0u46KEhGO6l2mcM0frsTWtkDcZlDjqkfsUGR/QDbfiaEvsJ+COkAM7e0zYMllhaKvE8UEPIIxedRtA7vhcnL6Cx1uEz0gsvjMF8jUHU00wZlvY2wJp8VG3W5/otIiRCVFCJjI0d1cZA0JTsV55JXxF6HDMVTteeqkT9JASk69AXvwCA0WCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA0EjkAfDLACDwX/Gia7wVcCFCk1hBKJpgEfJOWj1tg=;
 b=dMHvKUAhm9THf0hqahYNCN18DlxcqQFpous6DdezqSzeOoIOWesYTi89Ly1GSkngUt86VFUEZTwPE6iQ3tnn50UmeZoF4yBcqItU+B4x3HebC08kF5qTw56/pfrqrzdVU3ENtXce4AEeMZnRITxFaaZh6RdEg6BMMFlLxAkORZYFGlCy62YEAZ/w2fjQMOuoX1R6EYSx/hpD+Adh2gNZQ7qS6/ab62CCBmqYko7Ox4s9ZrGm/kEyC/Lavr3GFunPXEzomVa2WKOkyOVrre30JY8X4bgKMb6vjqRAs27JErq9kXTs052Z0coOgjN244vVn6S1JMu33WitSa3e2quexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA0EjkAfDLACDwX/Gia7wVcCFCk1hBKJpgEfJOWj1tg=;
 b=mSUY+s3cikLx2Czrsw3EjjQTxAD0Zcj027cFRfWe48D/uhKcWfNoIq5S0s+yb8cWQsuMkaAOzyigalapjmerMtbadOq1eXEclG+cq6k0tkv/YbiJM4LCY3eLT/2QgJgY2ZdlWE6YqqZBVjfpRGyrIiyq853kSBoKv9TxAF85fYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 20:27:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:27:00 +0000
Message-ID: <7f99b28d-6fbd-414a-6038-36d358637123@amd.com>
Date: Mon, 9 Jan 2023 15:26:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Add sync after creating vram bo
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230109192743.133767-1-jinhuieric.huang@amd.com>
 <ebef9ae2-6b9d-7bd9-5b30-8935009b3260@amd.com>
 <e8d73f0b-8b99-2f5a-4eca-bf9453da58dc@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <e8d73f0b-8b99-2f5a-4eca-bf9453da58dc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: edea0025-a0a2-4283-a902-08daf27fdca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCJ6z0c3NfP8hJsNWY+WS+0anLzsXoSQ4J7KI2KdNv0EQRbWGhG4gJHDgqPVBQwSfVzfh+KTg4FKI5hsAodmSsdo21Ty0NqeJ/QihaicoCr97IyxHOeHitUw5pEFnfydRkiYK/u+Fj/44+0CV9GD2IhjZJu59OnoH7nJXz518A7AtZpe+Qw9mzDE3p1vUi8tKexllhBdN44eF/q2YPoGAiM43Lp8kuE7ruy66sYMnr5Q94R7CIGtX8Q4kcxPfbFv7kPZ8swISGWwFdko5cpz6BM6VpFhr7v47zvDOdaW3ey8ahOIkTRCWy+RWEBCmfCHt1PfhZZ8n8H90LqkOj2KptDQNgjvCZR5S897Jip1SWTXYHfz3OCnxcZlIf37jcAi7yCcwMrofUI93q5hSSvKz0NOERKlpkHTVbgy/7v9iMIob/FlLCOd3jAYmRgV5qdzOz/PVDhJzLEtq8psbfAuqnCQiKXf9QepvyuxFex7svfvqX1YfYrINm+3TeLFxZq1kXvjPhjdQ9dShy7pRZTHYeE0XtTbBTcXVVKIinBtUeKXGOG7/6VJVyex7z9NxkNuxXNFRYy1Cj2h7BYf1+d6PMqWqx0xHBC4vuAeqNwoiN2mlYTa4rRkhjSp2KcyCpEE/gTEQ8zXkdqpInHFQnwX968PZ3TLHvC5WF8vwnd6x7fEqwBUoScacBdwcdtcr9p/OYeIttcT1AFhwCpgVX3jo4Vg1dy1wl5o51alGUSSebY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(36756003)(41300700001)(38100700002)(44832011)(83380400001)(31696002)(86362001)(6916009)(2906002)(6486002)(66556008)(31686004)(8936002)(66946007)(5660300002)(2616005)(8676002)(478600001)(6666004)(66476007)(186003)(26005)(6506007)(53546011)(6512007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFrZVNKWWxnOWZQMXVtVUxMWXhDVHp3dmdoeW5iY09pWHUxR2todnFkVi90?=
 =?utf-8?B?ZlN6MGdXN3Fub2dEWE5mb0h0ZjFud0lnVGRxYzNWTnhKY1A0emxYWGxxQk43?=
 =?utf-8?B?b1o3Q1JOWnE0dUNLenVyU0NTdEpnTGhQM0R3N2YvY21ndzlWL3hYc2JQcjFS?=
 =?utf-8?B?SFhjTzlrdXB5a0JmZll1cHp2cXhhWWlySVJ6SjhUajNRMWZvTCtUS0tWY251?=
 =?utf-8?B?d1c5Vy9Lam1na0pHekZMNWFUU1Ntc2NHeXZPQnFtZURIdUdUQzdTWmE1MWpM?=
 =?utf-8?B?Zmh1MW4wSFBtNzVDMDBsemhRNEw1UUdSdEQyL20wN2xJbGJ3ZnVjMUQ3SHVm?=
 =?utf-8?B?bTlZajJtMVhaSTJDMlB0a3NMbEU3WlBvaDFDSlpqTmpoVmZvanltZ09iSXlh?=
 =?utf-8?B?anNyUHBpZ2ZBWUNiMTFBOWdmZW1LRmV5cjBmNkpoKzFNdUZWUUthalV4TTZ5?=
 =?utf-8?B?LzZCYTdRYkpMaWVZRW13NkI3c3VtenB5ZTJqUG04SXM2cFoybWtEUjZzSDBM?=
 =?utf-8?B?Q3lDYUsrSjNRWG9rTmVkZzZSR3hrK3BtZ3FHRk5vY01sTFVucEhMbjJQdytK?=
 =?utf-8?B?S2lIQ08vQTNaK05pS0xTb2UzN0RQVVcraHdUZjNuMXNqUWMyR1ljNDZzUzE5?=
 =?utf-8?B?cjR0TTN3RW1aMlZ1bTZZSWtPbkdKRGdOeFA0Y0k2TmRMQWxrSVczSXNLRXk3?=
 =?utf-8?B?SUZEUkEwZEZ1MGI0RzFLdUVJYk0wcStjN3dXYVBIYldYSHYxVHpGSnF6ZG54?=
 =?utf-8?B?cU1QUUNSckhSYlNpMlZQenEwTjlGOFV3YTdGUFJSQzRObXRQc21OVGZzZkZM?=
 =?utf-8?B?MGQwazhWVDJGcllOZEFGc2UzR1NBWSt1ZjZ2YzUrcHA3OGkrTERnd2hlRFFW?=
 =?utf-8?B?TzlJSnBBQnZZMnl5Z2s3VnNQbW9ObkdHYkJmdk1iQm9Ic1o5Q3Vua0xRSGhh?=
 =?utf-8?B?Zm1XWkg1NGNnSnlTNG85aWh3d0hMK0U3SUtVNXNhWldrNW9NdDU0RWxlNkhx?=
 =?utf-8?B?S2NicUpWNFpBc3dScStsSnFyN2Y4WFZYc1BXN2RBV2xXR2RCMHQ3S3E4TUR4?=
 =?utf-8?B?dnhRVmtBakNNRzA1T3BBSUVxeUFhaXVjMERNNmxlVlVua0dPbDZGa1pKTGh4?=
 =?utf-8?B?OVRDL0cwSFY3Ym53TVFSS1V1cG5rSVJuNk41NkN1L0xvRVBPRjBTaFBSdllK?=
 =?utf-8?B?NUw3Um1iM1gwWnh2QVNtNnlwK1JxVGJZY1FHL3dkMm5zOFlLMnJkcWpOS2dp?=
 =?utf-8?B?ZEd3ZEFKd0hQVXhpaE1RaEFUdGlkMzhFUjhac0wxTC9xU3Q3VDRZNGkrZWZH?=
 =?utf-8?B?b1lCYVpTbWE1SWJaNVZNU1poaFhyYzVEMzQ5WFJmUnlhczNUbEtzV2pTeDJ0?=
 =?utf-8?B?TDlMSVJpS2NXcGh0T3pZNEM4RE5MNnEzRkRzUEt2OHhPMUZBMFZBLzhYS3JO?=
 =?utf-8?B?N0JtOHdPMVlnK2J5N3N4NUNFSGFBSWZTT3h3d091MWx3anZGYkRUbU85VC90?=
 =?utf-8?B?OE9hUDJodDhkclYySXhXZzA0TXVKeEpZR0FmRy9paUJrdlByakZZYjlQRkdD?=
 =?utf-8?B?bG4xSWdlRTFSMVdXSm81MTJveXZGbTM1NWxtZ3VaMmFkMUtQN05YaUVMTHdR?=
 =?utf-8?B?WkN3cy9MOGhPUENReG05T0ZRWTQ0Q0ZlR2Q5bTZjWUZiUEhMK2JTeWpHWFJi?=
 =?utf-8?B?RE4xQkIyaU5vK3Jlb1ZqQUsvajFsRzZkMHp0RkwrYTJQK3k4dzA1Vm4yNjBP?=
 =?utf-8?B?WlVydnNiSkZCQS8vdW9ZQk9JcHRUREdMTEt2OE5sLy9PeXAvMCtyZEFWbUYr?=
 =?utf-8?B?b3M2WVlLMHFlNHN3ZERZeDgyL1FwcUpQQTV6Ui8vZnIyeXNteUVNd3FQUXRa?=
 =?utf-8?B?engrQ3lrSm1BWEF2dkNsdXdqRjhVQ1FYQXZ3QWRTN0xZbEIrTTlFMFpSSzIx?=
 =?utf-8?B?N1plaWVOdXovMjNxYkRxWnlic3AyeHRXTXU3M3hFNlRLOHJVOWQzb21zbzgw?=
 =?utf-8?B?WHhmTHZFRXJ4bHFaS3I3YkJnbmZxM2t4SVVKNDJ1eTdwUjM2OXA5YklvN2pT?=
 =?utf-8?B?WHJRUzQxZWlYMy9JUkVhc1ZhaUdlWk9GVERTQkJRTkhoMDlKMmJ3cWllV1h1?=
 =?utf-8?Q?M4EF9CDjbO5wPWFajMQ38mAZp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edea0025-a0a2-4283-a902-08daf27fdca9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:27:00.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NunpyRh1s3EdeqGVmlwzk9Z8wTHG64412Qo6lTpdgL5h+9UEA8q5a1nB6HEuus88XThpi3L9rcUMIa8ZosDecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
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

Am 2023-01-09 um 15:23 schrieb Felix Kuehling:
> Am 2023-01-09 um 15:18 schrieb Philip Yang:
>>
>> On 2023-01-09 14:27, Eric Huang wrote:
>>> There will be data corruption on vram allocated by svm
>>> if initialization is not being done. Adding sync is to
>>> resolve this issue.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index b8c9753a4818..344e20306635 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -574,6 +574,13 @@ svm_range_vram_node_new(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>           goto reserve_bo_failed;
>>>       }
>>
>> Thanks for catching this bug, we could optimize as clear VRAM is only 
>> needed for partial migration, ex pass the clear flag clear = (cpages 
>> != npages) from svm_migrate_vma_to_vram -> svm_migrate_copy_to_vram 
>> -> svm_range_vram_node_new.
>
> I only see one call to svm_range_vram_node_new, and it passes "true" 
> unconditionally. What am I missing?

I think you're suggesting an optimization in svm_migrate_copy_to_vram. I 
think that makes sense. We don't need to initialize VRAM if we know it's 
going to be overwritten immediately with data migrated from system 
memory. But that's outside the scope of this fix.

Regards,
   Felix


>
> That said, if VRAM is not cleared, there will be no fence to wait for, 
> so the amdgpu_bo_sync_wait call is basically a no-op with a little bit 
> of overhead for creating and destroying an empty sync object.
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>>
>> Philip
>>
>>> +    r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
>>> +    if (r) {
>>> +        pr_debug("failed %d to sync bo\n", r);
>>> +        amdgpu_bo_unreserve(bo);
>>> +        goto reserve_bo_failed;
>>> +    }
>>> +
>>>       r = dma_resv_reserve_fences(amdkcl_ttm_resvp(&bo->tbo), 1);
>>>       if (r) {
>>>           pr_debug("failed %d to reserve bo\n", r);
