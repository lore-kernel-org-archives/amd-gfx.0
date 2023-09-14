Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A42EEAA41
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 13:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E0310E292;
	Thu, 14 Sep 2023 13:59:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779FC10E293
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiZJIGI6HlwLFIjEryWiY8LsCRh2f5OdZ7qCqTEBJChn+4AXptPfhXAIyeLi3USHrOD7Zi8ab+hi1FAIm3Tlr7IVaDMOke+Vt15+eXP1EnlM6ouga8Kr4l8JikZeow/EW4x4PooKVZTtYAMHTVds8voybLZ5O1wOhAtIH/Ro0TlXDJfr7KX9nkO82K1I28zjRRt4Mph8E+KIZNcDjBUqR0KRai3ezII17MoAXLdFBanWoTYPDuTPGdprXv3KMm/IioDxsdv/QOZoOCMRB3y+SLCJ8iviSkNszWA0PQd+R6BOuuQm4l753cecK1p//2S9fFXcAEvmIhynu5cJZ8ZXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS/o7LJN0l6/df2LIrPcrZ30iYE1vIdlY1LgWvMjMlE=;
 b=dpRG/JU0UryePPHXqBbyqkI9ScOPVjNCh9Se+8UmbA6M1E1ex6b1FgDG1w86OnJ4i76p+EThXsGoTctHQz02SFZFn1aL6ZXDAZnTm4LGCHRERQoLHrXNnqmM0l1hU+rJnGCOYrv7L/deACJIs/ITFkUXxZ/0/hpJuAbW9vjEJdscpsQtzQh3vatv/xoZq1F3jyVkvGwkw9KzDcyYr1LO2bBy5NXT6OWIMrxM8md5wZuMKddcOjj3RlP1bMXUou1+54wguIwTpWkjB4b7DP7uz5kdfuN8LPkhPkl1B0YQ3ngtPemg3d2AAx7blWXXXRxdOn/CJEtmn7B2Hc3dfbJJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS/o7LJN0l6/df2LIrPcrZ30iYE1vIdlY1LgWvMjMlE=;
 b=OGn/CD4pMzPJgdjaqW6wzxKo2isdVew+dktbCzRacw+XSEPFcEepdzcbsetGKEUpKR4rbYla29D9mNIRhkuUyja/6umoLadr6ioUuXZOGaR5SRtOvkcA7lY3S2VZrYwmQimoCqEuHMVM1kEq9/gkMld+ojo+HGdGP7gaREy79mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 14 Sep
 2023 13:59:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 13:59:11 +0000
Content-Type: multipart/alternative;
 boundary="------------jhg5ZSzQK5LGOfu0C0s1e0jD"
Message-ID: <728d9e8a-d655-0966-517e-fcec09f9433e@amd.com>
Date: Thu, 14 Sep 2023 15:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
 <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
 <59d9927d-5216-e2fa-22cd-205e4a35ebaa@amd.com>
 <DM4PR12MB516507AC620DD2812610C11287F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com>
 <c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com>
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 49223089-8c55-4307-dd37-08dbb52ac5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJPJQZOhLtVuGMWtd7B+glAKFBO9IKwnkAZdkeJtaN2n6PXaFgVR3VYZhsC8zswTOhsWUnDaGIES+qUda7uiD4Ign5t/iyLnaJSFzNw+Zb+NMGoC4SoNNVYTYvnv0Q92Lp1JHfoc/n6oHP/rYmaZYdFLloPMh8PT/AccVlzN5WwQEJtoDd25zl5JsBAQ5ClGc6pX79PuAhdZLplwQSBEZFQUKT08EreCb6+JxIsVs7WOaBnHif3lK/0vlmFcK9NDPX2RddwXPiKt1taAD+LUwYiGnkVpR2pqjRP3oL+GwsqZZCI8DKGx8fNkNa6GxD4yrOmL5thp+RByS9vkhLLW2Jcu28mUQ6Tt3J7OkjtVFV9g/SHFPDq5GAPt6LkJXaOgbl/X/CnKWqRaNg4dpuOM2fwznRTb7ruwcCMOjnYLQ7iTmFuFJ8k68758S9eawcZ4X/A+RqwbUakxzxuiP9/8FbXv7+oj+THQ1JXa/q63U48WzHv2ZJrg3lnwIh0QL0sd2BGWMpWfbpL1ZxASobTVO1oA6y7Kbxjr2L5eUZ1QK3eE9xXMhwwURRZCdoakmgCKo4b2xSNU9iHTSzoZF6hRxu3EZN9D2ytag+oW8HGM9SAHzNasZcpqi183Itl8/2Ms3Ob75DjfBusjovgltfWALw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(186009)(1800799009)(451199024)(224303003)(15650500001)(30864003)(2906002)(66574015)(36756003)(38100700002)(86362001)(31696002)(6512007)(2616005)(6506007)(110136005)(41300700001)(33964004)(53546011)(6486002)(4326008)(66946007)(8936002)(66476007)(66556008)(478600001)(31686004)(316002)(6666004)(83380400001)(54906003)(26005)(5660300002)(45980500001)(43740500002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklmRzBwTTB5NVRYaWRWWFQ3UmE1KzIxVkVwY3NDeG9jZk9HYVo1KzE5aU55?=
 =?utf-8?B?WkRFTkFRbUxqSlcrZXFJNWtjZnRvYUhRQzdQa1Vpb0RTbnBxMk1PZWRMZ1VQ?=
 =?utf-8?B?Vm5selBMQk96SWJqRDlYVSt0TWF2SEQ3N0hraHErblk2dHUzOEJvdm8zbHZq?=
 =?utf-8?B?ZXhremk5bDVFbnYxMm9TemMvN2pZSXgyZ0tiaXNCdml2VW9NQWFqaEhKSHF6?=
 =?utf-8?B?RVlZRGFZYnpDT0IzRXJCRE45T2NDUTM0a1hjays5Y3VxREFPc2VHWE1Kc1h4?=
 =?utf-8?B?R3FEeitQeFUzWENPdnJxY2xpN3p2bnBMd1orclNGT3F5SFBUbGxKdXljbzRx?=
 =?utf-8?B?dnZJMExhbzJqZ2RwRGxqcVppdEhzYnFidEVGNUQxWkVDcFZSOFptSzl2eE9t?=
 =?utf-8?B?K1dsaVZLeFgwQW4rb2MvTUFBZ1BERmFLT2xoLzJUN1AzbzNxeWMvYkdsazRQ?=
 =?utf-8?B?cmxpOWR4cmszUUtINVdwSlVrNUtVMHRkckQvREpqbzNHUTRRbW1lOVF3czJu?=
 =?utf-8?B?elZ6cTN4Y1NBdEwwd3l5cjE0TmN5ZC9mSVl5MGRDN1BRaW51QVd0d1IyOUlu?=
 =?utf-8?B?dGp4aWlKWVNlRVhhK3UzbHZOMU5DaWI3REtlQ3ovWm4rK2NsbFl3cGJJQTZ0?=
 =?utf-8?B?cjd3MUtVZXVCTHF5emhocTN1bDB2U2RjVklCRlU0VXZXMmdmSmxKbzlYdWRU?=
 =?utf-8?B?VFpPVXk2cXk1UEhuVHlUbHFwdUxZUGErSENWYjlCbm1KZkZMZDJZQmg4eVl4?=
 =?utf-8?B?VlQzWGtobXhQeklubVpaVGdGQ25aRXF4NDl6aVB2VzB3Z0NVZS83YThzNVJJ?=
 =?utf-8?B?U0Z6SUR1bHJ4Tlo2bzBtbWsycDl1YS9FZks2U1Z0Y01DQ1hIcDF5dGtoMXdw?=
 =?utf-8?B?OTFoMi9LcnZvTm9aYkxlbUFwSEhmRENNLzNXY0R0S3JRd0dZNE9pZ0U1TjV5?=
 =?utf-8?B?cmgrL0lIUVdSdUZSTmw0RVluMDRCRDdLR0R4WncxdFB4S3ZTK1NVSzBkUmhY?=
 =?utf-8?B?ZERmdm5zU1lIb3RtTDJxY2VDUUtnTUpsMUs2Q3BaMTIrQXFIL3JNSzFpaFh2?=
 =?utf-8?B?MGQyb1I4S2xOcERPNktJMFNySGZkSDF2Sjh4TFhGOUNlZ3h6S2VFYzAwem85?=
 =?utf-8?B?VGJiQWhNeHFGMU56Vy92aGR3bE9xZDFLOUhXVHpaeU5RZW9CZGJsd05VR0Jp?=
 =?utf-8?B?SHNCc0pDWTAzaXVxemhQZjNxM2FpV0dxUjlVWVBXMWV5RFBxaHRHTzg1UE1v?=
 =?utf-8?B?cEkrQ3MyQVpSMU5vcmx6ZkNYSW1hdEtkTS9Ea2Z1anYvWEhSTGtSbjZjcm5r?=
 =?utf-8?B?Qm5wWjhld1NnUzBVckRDYVJTRTk5QTVxR0E3OEJmV1dBNkpTTlFoWGtQTUla?=
 =?utf-8?B?WngyUjBRc2NkQjhUanB4MktxNUV0Zmg4dFFBeHVqYWVjQzVpRVlZQmFuK0lG?=
 =?utf-8?B?ejdHM2lEQWZ2Rm56ZXRjdVVMR2lUNElUL2xoMmpQSXVvcy82dUNrUU55N1hq?=
 =?utf-8?B?bDZiQ0pIYWV5b0NTY09RVVNGN1p0QWlyTU81dHZYZEh0ZUF0eGtPRTZoM3kz?=
 =?utf-8?B?NVRsZzVob2x3MXRWbkpNTGp5bi94aVVVc25Xa2IyQkdTR2dWc3VFOSs3MFYv?=
 =?utf-8?B?c0ZaZUVOc1h0Sy9HYmdsdW5QSVFVY0ZkVk0rWFhjTjVFODM1d245czN3U3pp?=
 =?utf-8?B?Z3JIS2Mwb28rRFNLZUh5a0tyamY2LzlrN0taa2xGaDFMQWRxQ2k1OHJya1NW?=
 =?utf-8?B?L3V2ek1xdW01M3ZBWkVtTTUzVDVxZFFqNDRkSkxpNjR3Rkd0TE4rcU80ZWRa?=
 =?utf-8?B?N0w3cXE1VkpFTDVzcVpLVmZkditaZ2RxbkRGWEROaDBubWFSZXZWZ0Njd2xJ?=
 =?utf-8?B?UXBETjk3Tkt6QW9ERXJ5ZnJYSDBaWC9nTWcreEZ0UElZYXhVZFNoeG5GTjhF?=
 =?utf-8?B?VGZzWndpb3ljQzBUM1R5UEVDa0dVMkdVVEVEcG1SQkx2NjJqMDc3UkpVeWti?=
 =?utf-8?B?VmdCK1R4Y1ZZMzNSa0RNOC92U0d3SU5NUXU3ZnFhT1MyNmlrMHZqZlc4L1Jz?=
 =?utf-8?B?TDFqK1orQWllSGFpZWtTVndpSUJYRFBFRnJRWk1tK0puQ0xKUFcxNy9VNENm?=
 =?utf-8?Q?jFxcEMhX8e42mqDHMFZo1eSua?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49223089-8c55-4307-dd37-08dbb52ac5d0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:59:11.8006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CImuGUnqM+bkm2YN/lMWP0dmt3A/k9EgwqUPxgWB6/51HgEHV7Cqu/YF7rfK0MbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Fan,
 Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------jhg5ZSzQK5LGOfu0C0s1e0jD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.09.23 um 15:37 schrieb Felix Kuehling:
>
> Userptr and SVM restore work is scheduled to the system WQ with 
> schedule_delayed_work. See amdgpu_amdkfd_evict_userptr and 
> svm_range_evict. This would need to use queue_delayed_work with the 
> system_freezable_wq.
>
> BO restoration is scheduled with queue_delayed_work on our own 
> kfd_restore_wq that was allocated with alloc_ordered_workqueue. This 
> would need to add the WQ_FREEZABLE flag when we create the wq in 
> kfd_process_create_wq.
>
> There is also evict_process_worker scheduled with 
> schedule_delayed_work, which handles stopping of user mode queues, 
> signaling of eviction fences and scheduling of restore work when BOs 
> are evicted. I think that should not be freezable because it's needed 
> to signal the eviction fences to allow suspend to evict BOs.
>
> To make sure I'm not misunderstanding, I assume that freezing a 
> freezable workqueue flushes work items in progress and prevents 
> execution of more work until it is unfrozen. I assume work items are 
> not frozen in the middle of execution, because that would not solve 
> the problem.
>

I was wondering the exact same thing and to be honest I don't know that 
detail either and of hand can't find any documentation about it.

My suspicion is that a work item can freeze when it calls schedule(), 
e.g. when taking a look or similar.

That would then indeed not work at all and we would need to make sure 
that the work is completed manually somehow.

Regards,
Christian.

> Regards,
>   Felix
>
>
> On 2023-09-14 2:23, Christian König wrote:
>> [putting Harry on BCC, sorry for the noise]
>>
>> Yeah, that is clearly a bug in the KFD.
>>
>> During the second eviction the hw should already be disabled, so we 
>> don't have any SDMA or similar to evict BOs any more and can only 
>> copy them with the CPU.
>>
>> @Felix what workqueue do you guys use for the restore work? I've just 
>> double checked and on the system workqueues you explicitly need to 
>> specify that stuff is freezable. E.g. use system_freezable_wq instead 
>> of system_wq.
>>
>> Alternatively as Xinhui mentioned it might be necessary to flush all 
>> restore work before the first eviction phase or we have the chance 
>> that BOs are moved back into VRAM again.
>>
>> Regards,
>> Christian.
>>
>> Am 14.09.23 um 03:54 schrieb Pan, Xinhui:
>>>
>>> [AMD Official Use Only - General]
>>>
>>>
>>> I just make one debug patch to show busy BO’s alloc-trace when the 
>>> eviction fails in suspend.
>>>
>>> And dmesg log attached.
>>>
>>> Looks like they are just kfd user Bos and locked by evict/restore work.
>>>
>>> So in kfd suspend callback, it really need to flush the 
>>> evict/restore work before HW fini as it do now.
>>>
>>> That is why the first very early eviction fails and the second 
>>> eviction succeed.
>>>
>>> Thanks
>>>
>>> xinhui
>>>
>>> *From:* Pan, Xinhui
>>> *Sent:* Thursday, September 14, 2023 8:02 AM
>>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix 
>>> <Felix.Kuehling@amd.com>; Christian König 
>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; 
>>> Wentland, Harry <Harry.Wentland@amd.com>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
>>> <Shikang.Fan@amd.com>
>>> *Subject:* RE: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
>>> during suspend
>>>
>>> Chris,
>>>
>>> I can dump these busy BOs with their alloc/free stack later today.
>>>
>>> BTW, the two evictions and the kfd suspend are all called before 
>>> hw_fini. IOW, between phase 1 and phase 2. SDMA is turned only in 
>>> phase2. So current code works fine maybe.
>>>
>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>> *Sent:* Wednesday, September 13, 2023 10:29 PM
>>> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Christian König 
>>> <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhui 
>>> <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org; Wentland, Harry 
>>> <Harry.Wentland@amd.com>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
>>> <Shikang.Fan@amd.com>
>>> *Subject:* Re: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
>>> during suspend
>>>
>>> [+Harry]
>>>
>>> Am 13.09.23 um 15:54 schrieb Felix Kuehling:
>>>
>>>     On 2023-09-13 4:07, Christian König wrote:
>>>
>>>         [+Fleix]
>>>
>>>         Well that looks like quite a serious bug.
>>>
>>>         If I'm not completely mistaken the KFD work item tries to
>>>         restore the process by moving BOs into memory even after the
>>>         suspend freeze. Normally work items are frozen together with
>>>         the user space processes unless explicitly marked as not
>>>         freezable.
>>>
>>>         That this causes problem during the first eviction phase is
>>>         just the tip of the iceberg here. If a BO is moved into
>>>         invisible memory during this we wouldn't be able to get it
>>>         out of that in the second phase because SDMA and hw is
>>>         already turned off.
>>>
>>>         @Felix any idea how that can happen? Have you guys marked a
>>>         work item / work queue as not freezable?
>>>
>>>     We don't set anything to non-freezable in KFD.
>>>
>>>     Regards,
>>>       Felix
>>>
>>>         Or maybe the display guys?
>>>
>>>
>>> Do you guys in the display do any delayed update in a work item 
>>> which is marked as not-freezable?
>>>
>>> Otherwise I have absolutely no idea what's going on here.
>>>
>>> Thanks,
>>> Christian.
>>>
>>>
>>>         @Xinhui please investigate what work item that is and where
>>>         that is coming from. Something like "if (adev->in_suspend)
>>>         dump_stack();" in the right place should probably do it.
>>>
>>>         Thanks,
>>>         Christian.
>>>
>>>         Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>>>
>>>             [AMD Official Use Only - General]
>>>
>>>             I notice that only user space process are frozen on my
>>>             side.  kthread and workqueue keeps running. Maybe some
>>>             kernel configs are not enabled.
>>>
>>>             I made one module which just prints something like i++
>>>             with mutex lock both in workqueue and kthread. I paste
>>>             some logs below.
>>>
>>>             [438619.696196] XH: 14 from workqueue
>>>
>>>             [438619.700193] XH: 15 from kthread
>>>
>>>             [438620.394335] PM: suspend entry (deep)
>>>
>>>             [438620.399619] Filesystems sync: 0.001 seconds
>>>
>>>             [438620.403887] PM: Preparing system for sleep (deep)
>>>
>>>             [438620.409299] Freezing user space processes
>>>
>>>             [438620.414862] Freezing user space processes completed
>>>             (elapsed 0.001 seconds)
>>>
>>>             [438620.421881] OOM killer disabled.
>>>
>>>             [438620.425197] Freezing remaining freezable tasks
>>>
>>>             [438620.430890] Freezing remaining freezable tasks
>>>             completed (elapsed 0.001 seconds)
>>>
>>>             [438620.438348] PM: Suspending system (deep)
>>>
>>>             .....
>>>
>>>             [438623.746038] PM: suspend of devices complete after
>>>             3303.137 msecs
>>>
>>>             [438623.752125] PM: start suspend of devices complete
>>>             after 3309.713 msecs
>>>
>>>             [438623.758722] PM: suspend debug: Waiting for 5 second(s).
>>>
>>>             [438623.792166] XH: 22 from kthread
>>>
>>>             [438623.824140] XH: 23 from workqueue
>>>
>>>             So BOs definitely can be in use during suspend.
>>>
>>>             Even if kthread or workqueue can be stopped with one
>>>             special kernel config. I think suspend can only stop the
>>>             workqueue with its callback finish.
>>>
>>>             otherwise something like below makes things crazy.
>>>
>>>             LOCK BO
>>>
>>>             do something
>>>
>>>             -> schedule or wait, anycode might sleep.  Stopped by
>>>             suspend now? no, i think.
>>>
>>>             UNLOCK BO
>>>
>>>             I do tests  with  cmds below.
>>>
>>>             echo devices  > /sys/power/pm_test
>>>
>>>             echo 0  > /sys/power/pm_async
>>>
>>>             echo 1  > /sys/power/pm_print_times
>>>
>>>             echo 1 > /sys/power/pm_debug_messages
>>>
>>>             echo 1 > /sys/module/amdgpu/parameters/debug_evictions
>>>
>>>             ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
>>>
>>>             pm-suspend
>>>
>>>             thanks
>>>
>>>             xinhui
>>>
>>>             ------------------------------------------------------------------------
>>>
>>>             *发件人:*Christian König <ckoenig.leichtzumerken@gmail.com>
>>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>>             *发送时间:*2023年9月12日17:01
>>>             *收件人:*Pan, Xinhui <Xinhui.Pan@amd.com>
>>>             <mailto:Xinhui.Pan@amd.com>;
>>>             amd-gfx@lists.freedesktop.org
>>>             <amd-gfx@lists.freedesktop.org>
>>>             <mailto:amd-gfx@lists.freedesktop.org>
>>>             *抄送:*Deucher, Alexander <Alexander.Deucher@amd.com>
>>>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>>>             <Christian.Koenig@amd.com>
>>>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>>>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>>>             *主题:*Re: [PATCH] drm/amdgpu: Ignore first evction
>>>             failure during suspend
>>>
>>>             When amdgpu_device_suspend() is called processes should
>>>             be frozen
>>>             already. In other words KFD queues etc... should already
>>>             be idle.
>>>
>>>             So when the eviction fails here we missed something
>>>             previously and that
>>>             in turn can cause tons amount of problems.
>>>
>>>             So ignoring those errors is most likely not a good idea
>>>             at all.
>>>
>>>             Regards,
>>>             Christian.
>>>
>>>             Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
>>>             > [AMD Official Use Only - General]
>>>             >
>>>             > Oh yep, Pinned BO is moved to other LRU list, So
>>>             eviction fails because of other reason.
>>>             > I will change the comments in the patch.
>>>             > The problem is eviction fails as many reasons, say, BO
>>>             is locked.
>>>             > ASAIK, kfd will stop the queues and flush some
>>>             evict/restore work in its suspend callback. SO the first
>>>             eviction before kfd callback likely fails.
>>>             >
>>>             > -----Original Message-----
>>>             > From: Christian König
>>>             <ckoenig.leichtzumerken@gmail.com>
>>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>>             > Sent: Friday, September 8, 2023 2:49 PM
>>>             > To: Pan, Xinhui <Xinhui.Pan@amd.com>
>>>             <mailto:Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>>>             > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>>>             <Christian.Koenig@amd.com>
>>>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>>>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>>>             > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction
>>>             failure during suspend
>>>             >
>>>             > Am 08.09.23 um 05:39 schrieb xinhui pan:
>>>             >> Some BOs might be pinned. So the first eviction's
>>>             failure will abort
>>>             >> the suspend sequence. These pinned BOs will be
>>>             unpined afterwards
>>>             >> during suspend.
>>>             > That doesn't make much sense since pinned BOs don't
>>>             cause eviction failure here.
>>>             >
>>>             > What exactly is the error code you see?
>>>             >
>>>             > Christian.
>>>             >
>>>             >> Actaully it has evicted most BOs, so that should stil
>>>             work fine in
>>>             >> sriov full access mode.
>>>             >>
>>>             >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra
>>>             evict_resource call
>>>             >> during device_suspend.")
>>>             >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>             <mailto:xinhui.pan@amd.com>
>>>             >> ---
>>>             >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>>>             >>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>             >>
>>>             >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>             >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>             >> index 5c0e2b766026..39af526cdbbe 100644
>>>             >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>             >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>             >> @@ -4148,10 +4148,11 @@ int
>>>             amdgpu_device_suspend(struct drm_device
>>>             >> *dev, bool fbcon)
>>>             >>
>>>             >>        adev->in_suspend = true;
>>>             >>
>>>             >> -     /* Evict the majority of BOs before grabbing
>>>             the full access */
>>>             >> -     r = amdgpu_device_evict_resources(adev);
>>>             >> -     if (r)
>>>             >> -             return r;
>>>             >> +     /* Try to evict the majority of BOs before
>>>             grabbing the full access
>>>             >> +      * Ignore the ret val at first place as we will
>>>             unpin some BOs if any
>>>             >> +      * afterwards.
>>>             >> +      */
>>>             >> + (void)amdgpu_device_evict_resources(adev);
>>>             >>
>>>             >>        if (amdgpu_sriov_vf(adev)) {
>>>             >> amdgpu_virt_fini_data_exchange(adev);
>>>
>>

--------------jhg5ZSzQK5LGOfu0C0s1e0jD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 14.09.23 um 15:37 schrieb Felix Kuehling:<br>
    <blockquote type="cite" cite="mid:c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com">
      
      <p>Userptr and SVM restore work is scheduled to the system WQ with
        schedule_delayed_work. See amdgpu_amdkfd_evict_userptr and
        svm_range_evict. This would need to use queue_delayed_work with
        the system_freezable_wq.<br>
      </p>
      <p>BO restoration is scheduled with queue_delayed_work on our own
        kfd_restore_wq that was allocated with alloc_ordered_workqueue.
        This would need to add the WQ_FREEZABLE flag when we create the
        wq in kfd_process_create_wq.<br>
      </p>
      <p>There is also evict_process_worker scheduled with
        schedule_delayed_work, which handles stopping of user mode
        queues, signaling of eviction fences and scheduling of restore
        work when BOs are evicted. I think that should not be freezable
        because it's needed to signal the eviction fences to allow
        suspend to evict BOs.<br>
      </p>
      <p>To make sure I'm not misunderstanding, I assume that freezing a
        freezable workqueue flushes work items in progress and prevents
        execution of more work until it is unfrozen. I assume work items
        are not frozen in the middle of execution, because that would
        not solve the problem.<br>
      </p>
    </blockquote>
    <br>
    I was wondering the exact same thing and to be honest I don't know
    that detail either and of hand can't find any documentation about
    it.<br>
    <br>
    My suspicion is that a work item can freeze when it calls
    schedule(), e.g. when taking a look or similar.<br>
    <br>
    That would then indeed not work at all and we would need to make
    sure that the work is completed manually somehow.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com">
      <p> </p>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2023-09-14 2:23, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com">
        [putting Harry on BCC, sorry for the noise]<br>
        <br>
        Yeah, that is clearly a bug in the KFD.<br>
        <br>
        During the second eviction the hw should already be disabled, so
        we don't have any SDMA or similar to evict BOs any more and can
        only copy them with the CPU.<br>
        <br>
        @Felix what workqueue do you guys use for the restore work? I've
        just double checked and on the system workqueues you explicitly
        need to specify that stuff is freezable. E.g. use
        system_freezable_wq instead of system_wq.<br>
        <br>
        Alternatively as Xinhui mentioned it might be necessary to flush
        all restore work before the first eviction phase or we have the
        chance that BOs are moved back into VRAM again.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        <div class="moz-cite-prefix">Am 14.09.23 um 03:54 schrieb Pan,
          Xinhui:<br>
        </div>
        <blockquote type="cite" cite="mid:DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com">
          <meta name="Generator" content="Microsoft Word 15 (filtered
            medium)">
          <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
          <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}@font-face
	{font-family:"\@Microsoft YaHei";}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
          <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - General]<br>
          </p>
          <br>
          <div>
            <div class="WordSection1">
              <p class="MsoNormal">I just make one debug patch to show
                busy BO’s alloc-trace when the eviction fails in
                suspend.<o:p></o:p></p>
              <p class="MsoNormal">And dmesg log attached.<o:p></o:p></p>
              <p class="MsoNormal">Looks like they are just kfd user Bos
                and locked by evict/restore work.<o:p></o:p></p>
              <p class="MsoNormal">So in kfd suspend callback, it really
                need to flush the evict/restore work before HW fini as
                it do now.<o:p></o:p></p>
              <p class="MsoNormal">That is why the first very early
                eviction fails and the second eviction succeed.<o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">Thanks<o:p></o:p></p>
              <p class="MsoNormal">xinhui<o:p></o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> Pan, Xinhui <br>
                    <b>Sent:</b> Thursday, September 14, 2023 8:02 AM<br>
                    <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                    Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated
                      moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                    Wentland, Harry <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com" moz-do-not-send="true">&lt;Harry.Wentland@amd.com&gt;</a><br>
                    <b>Cc:</b> Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                    Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                    <b>Subject:</b> RE: <span style="font-family:&quot;Microsoft
                      YaHei&quot;,sans-serif" lang="ZH-CN"> 回复</span>:
                    [PATCH] drm/amdgpu: Ignore first evction failure
                    during suspend<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">Chris,<o:p></o:p></p>
              <p class="MsoNormal">I can dump these busy BOs with their
                alloc/free stack later today.<o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">BTW, the two evictions and the kfd
                suspend are all called before hw_fini. IOW, between
                phase 1 and phase 2. SDMA is turned only in phase2. So
                current code works fine maybe.<o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> Koenig, Christian
                    &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;
                    <br>
                    <b>Sent:</b> Wednesday, September 13, 2023 10:29 PM<br>
                    <b>To:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Felix.Kuehling@amd.com</a>&gt;;
                    Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;;
                    Pan, Xinhui &lt;<a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xinhui.Pan@amd.com</a>&gt;;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                    Wentland, Harry &lt;<a href="mailto:Harry.Wentland@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Harry.Wentland@amd.com</a>&gt;<br>
                    <b>Cc:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
                    Fan, Shikang &lt;<a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Shikang.Fan@amd.com</a>&gt;<br>
                    <b>Subject:</b> Re: <span style="font-family:&quot;Microsoft
                      YaHei&quot;,sans-serif" lang="ZH-CN"> 回复</span>:
                    [PATCH] drm/amdgpu: Ignore first evction failure
                    during suspend<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal" style="margin-bottom:12.0pt">[+Harry]<o:p></o:p></p>
              <div>
                <p class="MsoNormal">Am 13.09.23 um 15:54 schrieb Felix
                  Kuehling:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <div>
                  <p class="MsoNormal">On 2023-09-13 4:07, Christian
                    König wrote:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal">[+Fleix]<br>
                    <br>
                    Well that looks like quite a serious bug.<br>
                    <br>
                    If I'm not completely mistaken the KFD work item
                    tries to restore the process by moving BOs into
                    memory even after the suspend freeze. Normally work
                    items are frozen together with the user space
                    processes unless explicitly marked as not freezable.<br>
                    <br>
                    That this causes problem during the first eviction
                    phase is just the tip of the iceberg here. If a BO
                    is moved into invisible memory during this we
                    wouldn't be able to get it out of that in the second
                    phase because SDMA and hw is already turned off.<br>
                    <br>
                    @Felix any idea how that can happen? Have you guys
                    marked a work item / work queue as not freezable?<o:p></o:p></p>
                </blockquote>
                <p>We don't set anything to non-freezable in KFD.<o:p></o:p></p>
                <p><o:p>&nbsp;</o:p></p>
                <p>Regards,<br>
                  &nbsp; Felix<o:p></o:p></p>
                <p><o:p>&nbsp;</o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal">Or maybe the display guys?<o:p></o:p></p>
                </blockquote>
              </blockquote>
              <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                Do you guys in the display do any delayed update in a
                work item which is marked as not-freezable?<br>
                <br>
                Otherwise I have absolutely no idea what's going on
                here.<br>
                <br>
                Thanks,<br>
                Christian.<br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                    @Xinhui please investigate what work item that is
                    and where that is coming from. Something like &quot;if
                    (adev-&gt;in_suspend) dump_stack();&quot; in the right
                    place should probably do it.<br>
                    <br>
                    Thanks,<br>
                    Christian.<o:p></o:p></p>
                  <div>
                    <p class="MsoNormal">Am 13.09.23 um 07:13 schrieb
                      Pan, Xinhui:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                        Official Use Only - General]<o:p></o:p></span></p>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                    <div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                            notice that only user space process are
                            frozen on my side.&nbsp; kthread and workqueue&nbsp;
                            keeps running. Maybe some kernel configs are
                            not enabled.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                            made one module which just prints something
                            like i++ with mutex lock both in workqueue
                            and kthread. I paste some logs below.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.696196]
                            XH: 14 from workqueue <o:p></o:p></span></p>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.700193]
                              XH: 15 from kthread<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.394335]
                              PM: suspend entry (deep)<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.399619]
                              Filesystems sync: 0.001 seconds<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.403887]
                              PM: Preparing system for sleep (deep)<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.409299]
                              Freezing user space processes<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.414862]
                              Freezing user space processes completed
                              (elapsed 0.001 seconds)<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.421881]
                              OOM killer disabled.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.425197]
                              Freezing remaining freezable tasks<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.430890]
                              Freezing remaining freezable tasks
                              completed (elapsed 0.001 seconds)<o:p></o:p></span></p>
                        </div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.438348]
                            PM: Suspending system (deep)<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">.....<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.746038]
                            PM: suspend of devices complete after
                            3303.137 msecs <o:p></o:p></span></p>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.752125]
                              PM: start suspend of devices complete
                              after 3309.713 msecs<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.758722]
                              PM: suspend debug: Waiting for 5
                              second(s).<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.792166]
                              XH: 22 from kthread<o:p></o:p></span></p>
                        </div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.824140]
                            XH: 23 from workqueue<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">So
                            BOs definitely can be in use during suspend.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">Even
                            if kthread or workqueue can be stopped with
                            one special kernel config. I think suspend
                            can only stop the workqueue with its
                            callback finish. <o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">otherwise
                            something like below makes things crazy.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">LOCK
                            BO<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">do
                            something<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;
                            -&gt; schedule or wait, anycode might
                            sleep.&nbsp; Stopped by suspend now? no, i think.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">UNLOCK
                            BO<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                            do tests&nbsp; with&nbsp; cmds below.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                            devices &nbsp;&gt; /sys/power/pm_test <o:p></o:p></span></p>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                              0 &nbsp;&gt; /sys/power/pm_async<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                              1 &nbsp;&gt; /sys/power/pm_print_times<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                              1 &gt; /sys/power/pm_debug_messages<o:p></o:p></span></p>
                        </div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                            1 &gt;
                            /sys/module/amdgpu/parameters/debug_evictions<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">./kfd.sh
                            --gtest_filter=KFDEvictTest.BasicTest<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">pm-suspend<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">thanks<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">xinhui<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div class="MsoNormal" style="text-align:center" align="center">
                        <hr width="98%" size="1" align="center"> </div>
                      <div id="divRplyFwdMsg">
                        <p class="MsoNormal"><b><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">发件人</span><span style="color:black">:</span></b><span style="color:black"> Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                          </span><b><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">发送时间</span><span style="color:black">:</span></b><span style="color:black"> 2023</span><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">年</span><span style="color:black">9</span><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">月</span><span style="color:black">12</span><span style="font-family:&quot;Microsoft
                            YaHei&quot;,sans-serif;color:black" lang="ZH-CN">日</span><span style="color:black"> 17:01<br>
                          </span><b><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">收件人</span><span style="color:black">:</span></b><span style="color:black"> Pan, Xinhui <a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                              amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                              &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                          </span><b><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">抄送</span><span style="color:black">:</span></b><span style="color:black"> Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                            Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                            Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                          </span><b><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">主题</span><span style="color:black">:</span></b><span style="color:black"> Re: [PATCH] drm/amdgpu:
                            Ignore first evction failure during suspend</span>
                          <o:p></o:p></p>
                        <div>
                          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                        </div>
                      </div>
                      <div>
                        <div>
                          <p class="MsoNormal" style="margin-bottom:12.0pt">When
                            amdgpu_device_suspend() is called processes
                            should be frozen <br>
                            already. In other words KFD queues etc...
                            should already be idle.<br>
                            <br>
                            So when the eviction fails here we missed
                            something previously and that <br>
                            in turn can cause tons amount of problems.<br>
                            <br>
                            So ignoring those errors is most likely not
                            a good idea at all.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            Am 12.09.23 um 02:21 schrieb Pan, Xinhui:<br>
                            &gt; [AMD Official Use Only - General]<br>
                            &gt;<br>
                            &gt; Oh yep, Pinned BO is moved to other LRU
                            list, So eviction fails because of other
                            reason.<br>
                            &gt; I will change the comments in the
                            patch.<br>
                            &gt; The problem is eviction fails as many
                            reasons, say, BO is locked.<br>
                            &gt; ASAIK, kfd will stop the queues and
                            flush some evict/restore work in its suspend
                            callback. SO the first eviction before kfd
                            callback likely fails.<br>
                            &gt;<br>
                            &gt; -----Original Message-----<br>
                            &gt; From: Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                            &gt; Sent: Friday, September 8, 2023 2:49 PM<br>
                            &gt; To: Pan, Xinhui <a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                              amd-gfx@lists.freedesktop.org</a><br>
                            &gt; Cc: Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                            Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                            Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                            &gt; Subject: Re: [PATCH] drm/amdgpu: Ignore
                            first evction failure during suspend<br>
                            &gt;<br>
                            &gt; Am 08.09.23 um 05:39 schrieb xinhui
                            pan:<br>
                            &gt;&gt; Some BOs might be pinned. So the
                            first eviction's failure will abort<br>
                            &gt;&gt; the suspend sequence. These pinned
                            BOs will be unpined afterwards<br>
                            &gt;&gt; during suspend.<br>
                            &gt; That doesn't make much sense since
                            pinned BOs don't cause eviction failure
                            here.<br>
                            &gt;<br>
                            &gt; What exactly is the error code you see?<br>
                            &gt;<br>
                            &gt; Christian.<br>
                            &gt;<br>
                            &gt;&gt; Actaully it has evicted most BOs,
                            so that should stil work fine in<br>
                            &gt;&gt; sriov full access mode.<br>
                            &gt;&gt;<br>
                            &gt;&gt; Fixes: 47ea20762bb7 (&quot;drm/amdgpu:
                            Add an extra evict_resource call<br>
                            &gt;&gt; during device_suspend.&quot;)<br>
                            &gt;&gt; Signed-off-by: xinhui pan <a href="mailto:xinhui.pan@amd.com" moz-do-not-send="true">&lt;xinhui.pan@amd.com&gt;</a><br>
                            &gt;&gt; ---<br>
                            &gt;&gt;&nbsp;&nbsp;&nbsp;
                            drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |
                            9 +++++----<br>
                            &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 5 insertions(+),
                            4 deletions(-)<br>
                            &gt;&gt;<br>
                            &gt;&gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                            &gt;&gt;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                            &gt;&gt; index 5c0e2b766026..39af526cdbbe
                            100644<br>
                            &gt;&gt; ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                            &gt;&gt; +++
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                            &gt;&gt; @@ -4148,10 +4148,11 @@ int
                            amdgpu_device_suspend(struct drm_device<br>
                            &gt;&gt; *dev, bool fbcon)<br>
                            &gt;&gt;<br>
                            &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_suspend = true;<br>
                            &gt;&gt;<br>
                            &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Evict the majority of BOs
                            before grabbing the full access */<br>
                            &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =
                            amdgpu_device_evict_resources(adev);<br>
                            &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                            &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                            &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Try to evict the majority
                            of BOs before grabbing the full access<br>
                            &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Ignore the ret val at
                            first place as we will unpin some BOs if any<br>
                            &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * afterwards.<br>
                            &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                            &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                            (void)amdgpu_device_evict_resources(adev);<br>
                            &gt;&gt;<br>
                            &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
                            &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            amdgpu_virt_fini_data_exchange(adev);<o:p></o:p></p>
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                </blockquote>
              </blockquote>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
          </div>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------jhg5ZSzQK5LGOfu0C0s1e0jD--
