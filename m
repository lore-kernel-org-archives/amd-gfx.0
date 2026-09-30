Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C1ECA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 16:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B3710E278;
	Wed, 30 Sep 2026 16:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RpbkMxlE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206B410E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 16:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7SwqSqzD4+uvXPntDOpvu6brXiRrasjeHoUr+lzCrvMqfVZFeoL006HQbfb7W1bYx00pYtHPGn5Ll0KiKcqnZTpagXge2mhHQFIdVK7xbd7WgQdDNlE53XAp2Xao0yFCeNY4wDtNCOrxXG32VNz6wjO6ZKt4wLgIy3j4bzfbhxVl2NosVHIOsVKyhGZHK8KdgE/zNUkORujo9P8YmOEu64PzpbyZBq95U1RMtrJBif360fV3LpzsboTZrVrdhtK+B4N968XQ2DIig10JHfrD9064SEKXC7Ccv4jU9HPgo/Lk/nOe7YbO2HNxeSONpwL1qDM/tPN4KD9S0QSCt8RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnctWBhdscnw8P1rtKTCEE/4c+59u+hojACo+1X7ZMg=;
 b=uSV1mITlMkrCZKifRPNKrDY0mtxVLP6QvwnnM54gPO2/lZhBow0ZxUw6ZqHsHGpEA+51cK/K57N89GQxABUh9fDRc0l9VZ4UMCD+9JS2yGuNmgqqjann+YnUlLGf68VzGcBNcH5B6Hq6HbaH5moskdpZnwkIuM3QTKmY0iZN2OSYyEfsE5pMYOj31Fx6tWtm1jveyyL3QcM7Joc3Np8JbesRKD81Y8a9Tpp5tGW3/7xET6gKQpux3nl3ffFbgcPDLRI7KkEgbtoHb8wLeASvLrQIHlQ8LYZgn+okT9lC7Et+FqVaCtQTnr4JBU3G2rMfnJdrCnP2JgKRDICG9Exzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnctWBhdscnw8P1rtKTCEE/4c+59u+hojACo+1X7ZMg=;
 b=RpbkMxlE2aQkwqQRGBpsbO9bosUJBsIw5EQ0bL8YTbR1RmXKbkMEDkviVDwJCe9t6PgTAAFq400xwDcMmyhzgTGvuFI8rW6KJzWvK/WpQKzC9sxFsWcl2C7HAOweHWCqb84w6+HDoG/jp0/LwqsjRw1bZgG6rNsx7IxEsE7uWYw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SA1PR12MB9247.namprd12.prod.outlook.com
 (2603:10b6:806:3af::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 16:12:51 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 16:12:49 +0000
Message-ID: <33693b8d-ed0a-4910-af87-eb29e887a1d5@amd.com>
Date: Wed, 30 Sep 2026 12:12:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Philip.Yang@amd.com, cascardo@igalia.com, tvrtko.ursulin@igalia.com,
 "Joshi, Mukul" <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
 <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
 <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
 <9b181f91-4de1-4c0d-8a38-dfd75c8eb98c@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <9b181f91-4de1-4c0d-8a38-dfd75c8eb98c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5d10f5-f7c7-4795-fc32-08df1f0dac4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|921020|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ZfHQVz0zzyz9xH0fyXBbzi2A/Cv5SS6Q4yBjXAB/OK+8b1jW9WX44vABveYfEhV4WUWyHtpzq8555aO97ZKDOyD+E5D1F1LPsU8yG0yuvxgb+GArLBAw34rBVfQsB1oUmcduJdufEVvjPTFq553R9hqfk2WiGe18N6wpa48lS63sKbXS1azjXSiNgy7D5PfcOWjWVWxUOAn6beYux87ElMPTtseu9Qe3tGvGSmE18xGVXoNEfJM4lQZMzKhzMgLnqo7gsOdG7ELY/MYiYBIKuIRkZxKDyFvk+LNLrDA0TbduzXxMxhbbpHHIpkb/9BI74gjrFc2MrqrwLqLWyWpP8DgGlBjeBpRKqTqsLVmG+YJJX0fr4pxbJQTN/iG9SYboPNqotrcVM+d+GFJ+YqltdLXdvWUBJsIMKJqgxgAuO1vxLRtpNntSLSxzVmiregJB87/pyZ6RwNXutJRiXhwTfmO/nnsRycD2uBoUzh8eHCjfquYa+XdMBKVbzZdsjkX+6dWwlsRRmdNOvbzNqZ2c5wrXnkzI7wNaybEvjpKam5xnWfBq1ZJcjQ0R/kGulvUwB493jVWl9EkHyQl5Z5e17Mg1J+66HlfvBaa9eSjlp3ycevkUP3T0BCDIcx2BlE1Gjvc4590QjIhzgLwhgVvNwZgpEN9aeRa+gR0aoRyu375ZLt/JezHaXDkl46BhLbDQ3d+FnbDIAnRI0DZbjlaQOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1UQXVFUUhVNjZVemFEUjZ5bElSZUhGTG40VnArS1pHTW5LbEJvYXNueHV5?=
 =?utf-8?B?TWtvNEYzZFVvbzVhVXRTWm9zeXcvbEtZdGYyUnpOS3dEbTlURFJHRkZQVXdV?=
 =?utf-8?B?S1pucVF3WE91OEFZMWs2SUxwQ1FDY1FHakhlODNnaVc2SC8wUk1uc0pjK3hl?=
 =?utf-8?B?dnRBUEpXMWUxcEJWYXZzMzVaVDBYSStDbjBjQXZ1VlY0NFpFdUpKcVJBby92?=
 =?utf-8?B?Z0pTQ3IzcUp4YjhGZmlyOG9wTm5pRDlEV2lPZVdzbnJJOUFNSy9MTjkyOEpW?=
 =?utf-8?B?UmJ2ZTUxLzB0RWtxN2pJT0MwTFg5emxFSnZwOTh0VldyZjFGd05RNlhGSnB1?=
 =?utf-8?B?cEtacXhMU0ZLSG9COVhkeFJRb1drZGIrdTh1ZjZkNGVIeHFsSVV5OHVCWFFw?=
 =?utf-8?B?Uit0YzJTZEYxMG5vc2taaWphYUR1YXM0S0ZVWnVuYUttZXhtS1N3Y3hGaG9l?=
 =?utf-8?B?M1BJbjh0SEd2MVl1MFgwZ2swL0hoOUZCRlJSSjBOU09YVUZ3bzcza2lFUDBj?=
 =?utf-8?B?U2xJaWdnSjZ6RnhLN2ZqNzRneGNET3FrbVBQdzZEd0hvYVVpMnNQRDhYbFlK?=
 =?utf-8?B?c3pBUm9ROFROWFhrd2lWTWRJenpKc0FoSVVRWmVoU2d6RFM5WE54Zi8yU29j?=
 =?utf-8?B?TnZUa2VnSnRqaEpodGdOV0txd1VRMnRualZYdGpzdXNlZFZaRE5jSnFBRWZ5?=
 =?utf-8?B?STBzb25vWlN6d3FVQWlkbE1tNFF6aTVaN0N5NXNvQ0JzazR5L0xXVTNLaFRJ?=
 =?utf-8?B?cHBuRDg5Z05mallZT1FTSytXeThhdnpCd1VJa1VRSVMyYjltSWwzSFNWakU3?=
 =?utf-8?B?YnVWMmVpeGdUMjZHcDdhNnM1NmZ2MCtDcHF3ZGI2RGRJZVhvcWs5MjRKdm1p?=
 =?utf-8?B?eXI2OGVaSkx6WXg3aTdVUlBScUxQaWJRZjJvVm10eGZEd2FMRllvZmdMVHlt?=
 =?utf-8?B?czI4Zzc4MklxU1dkR01qazlsaWRrM05XQzVoVUIzaHVLWFk4WTgvNk9ydUNL?=
 =?utf-8?B?K2oraXhaZkErMW80YmM2L1BiOHUrNzN4R3JsbHlvYml1TUpsOEkvUkJsYUhM?=
 =?utf-8?B?QWZQeDNLNjVOY29aSTFWdFc0SFZ3NU1Sb2FXSmFwd1ZEN2cxSWRsN0tpUXBS?=
 =?utf-8?B?OTNQWnN1aXNuWTFuWGJQbmxLb1M2VFBYcDhQd0w5S283UGhSYStXNUFpSlpD?=
 =?utf-8?B?K3E0UzhSdk40N1hMd1l6elNXcTFqMm5obVczQWtQaGZsZm9Kc1NSdWJvQmRN?=
 =?utf-8?B?TlNDbFg2dUFkbUxtbjJORDRISTNCL3BOb0x3TnRtSUJ3VklLMU53dmZHSXc3?=
 =?utf-8?B?Z3BBQldDdnBtRWJUaFBWb0tNQzBaeDd2WjduZFZ4djlsNnZlTXNZaWNsV3ZR?=
 =?utf-8?B?b21XVXhSeG5tdmM3LzFiS3E2S1p2cWkvSFB1d3EydXpzZDdvRXZWZ0pwYVNI?=
 =?utf-8?B?Y0tIWTNjbzI3NmFaY0JoSndYMEpOWlVZSTd4YjhJVFV6MzJuR1FUQVVtT1g0?=
 =?utf-8?B?V25PblVkQzY5bDNGRlZmRFBLRGVzcy9Tek5HZUN6ZUJGR1kxdlZ6MzNRM3l4?=
 =?utf-8?B?MjdETVpNSmVWc1dhcDVBb1phL1FZeng4QWJmRUhtME4ya0FFZkt4ay9lQTN2?=
 =?utf-8?B?M0xIbHd2RE5WVFVNVy9lZHF4UjFycUFUbnlKSlFYMXhxUzhqNmlKYytjbStx?=
 =?utf-8?B?ckJnMkFlbENqK2R3eGxmSythaVJUZnIzUXhQQzBxMTRkcDFrZW5PMFE2RWVS?=
 =?utf-8?B?VzIyRk9obTZJRWxCUzZuY08rT01EYUczSlNaOS9aUzQrdW5ubDA3R3d3OXJr?=
 =?utf-8?B?UXViQlU3cUxKYXliVFo3ZzVkOGM1QUpNWm1PZ2ZtMEpkWXluVitJZkdrMnBo?=
 =?utf-8?B?L1p5anlobzNCWDRIYWZnNzB6K1MvL2RyVnhlbVk1d0NSbjllZHl0dXAySkcr?=
 =?utf-8?B?SDNPMmYwbFU4MXVaMFNxUW1OYzZqUEVSakxnTEREZmRVRThlcDliSFFGT0JI?=
 =?utf-8?B?bmZBOStjYjNsUndjYjVFRkpsYUwwQ3RRbThxbGZNMzkrLzlMMDBGL3Z5eWRR?=
 =?utf-8?B?VGV1alMxYTZvcEp2N0xaUHk0VGJ2K2hIMFR5bENzSXZubjNqczh3ME5yS0RS?=
 =?utf-8?B?R2h4V3RkUXBTU1lwdmZ0YWRIaUJTb2Nncmt5bFhmM2R2M2pWVGhKdGJKZ3Vy?=
 =?utf-8?B?MXpvUGdYZEowOW5kNklRazV0R3YzZGJzMkRYOHNWbWlnclgzY3FpSnZSSmdL?=
 =?utf-8?B?emRSajZFMWdURTgyUWJuanluUFE1d1BROHNqUlNaYnkxeXUzV29WR09IVzV0?=
 =?utf-8?Q?rBIzaUXyAY0OKtlckn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d10f5-f7c7-4795-fc32-08df1f0dac4f
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:12:49.7202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML3hkvoEOOe7nYH6NqrGiu1O7VVQ0uXwJI3qzagiWQnl7AJm/FQUZukfGF1cK3YGnm6KUXqtdh2PihysRQ7NZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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

On 2026-09-30 10:59, Christian König wrote:
> On 9/30/26 16:44, Kuehling, Felix wrote:
>> [+Mukul]
>>
>> On 2026-09-30 05:02, Christian König wrote:
>>> @Felix and @Philip any objections to this patch?
>>>
>>> It is actually a bug fix for the NPA support.
>> As I understand it, this fixes the flags used when unmapping memory from the NPA VM. We passed adev->gmc.noretry_flags from amdgpu_ualink_unmap_npa_addr to amdgpu_vm_update_range explicitly in the flags parameter. I guess that's no longer needed with your fix. But I think the end result would be the same, right?
> Not quite, passing adev->gmc.noretry_flags to amdgpu_vm_update_range() is completely broken as well and also need fixing.
>
> The flags parameter to amdgpu_vm_update_range() can't contain the AMDGPU_PTE_TF nor the AMDGPU_PDE_PTE flag because those are overwritten by the PTE callbacks.

I'm pretty sure Mukul tested this and got something that worked as 
expected, at least for a time. I'm not sure if it regressed since, maybe 
during upstreaming. @Mukul, can you comment?


>
> That's why setting the AMDGPU_PTE_IS_PTE for gfx12 through the init_pte_flags is completely broken as well.
>
> We seriously need to stop doing such hacks.

Is there any documentation that tells us what flags can be used where. 
This isn't obvious at all.

Thanks,
   Felix


>
> Regards,
> Christian.
>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Christian.
>>>
>>> On 9/28/26 21:08, Timur Kristóf wrote:
>>>> On 2026. szeptember 28., hétfő 11:10:34 keleti államokbeli nyári idő Christian
>>>> König wrote:
>>>>> That was broken since adding the NPA support.
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
>>>>>    1 file changed, 33 insertions(+), 31 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>>>>> c03327f1242d3..e8f441e018839 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
>>>>> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));
>>>> \
>>>>>             (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev),
>>>> &(cursor)))
>>>>> +/* Return the flags used for cleared PDEs/PTES */
>>>>> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>>>>> +                    struct amdgpu_vm *vm,
>>>>> +                    unsigned int level)
>>>>> +{
>>>>> +    uint64_t flags;
>>>>> +
>>>>> +    if (adev->asic_type < CHIP_VEGA10)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (level != AMDGPU_VM_PTB) {
>>>>> +        uint64_t value = 0;
>>>>> +
>>>>> +        flags = AMDGPU_PDE_PTE_FLAG(adev);
>>>>> +        if (vm->is_npa)
>>>>> +            flags |= adev->gmc.noretry_flags;
>>>>> +        amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
>>>>> +    } else if (vm->is_npa) {
>>>>> +        flags = adev->gmc.noretry_flags;
>>>>> +    } else {
>>>>> +        /* Workaround for fault priority problem on GMC9 */
>>>>> +        flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>>>>> +    }
>>>>> +
>>>>> +    return flags;
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>>>>>     *
>>>>> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>>>> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx = { true, false };
>>>>>        struct amdgpu_vm_update_params params;
>>>>>        struct amdgpu_bo *ancestor = &vmbo->bo;
>>>>> -    unsigned int entries;
>>>>>        struct amdgpu_bo *bo = &vmbo->bo;
>>>>> -    uint64_t value = 0, flags = 0;
>>>>> -    uint64_t addr;
>>>>> +    unsigned int entries;
>>>>> +    uint64_t flags;
>>>>>        int r, idx;
>>>>>
>>>>>        /* Figure out our place in the hierarchy */
>>>>> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>>>> struct amdgpu_vm *vm, if (r)
>>>>>            goto exit;
>>>>>
>>>>> -    addr = 0;
>>>>> -
>>>>> -    if (adev->asic_type >= CHIP_VEGA10) {
>>>>> -        if (level != AMDGPU_VM_PTB) {
>>>>> -            if (vm->is_npa)
>>>>> -                flags = adev->gmc.noretry_flags;
>>>>> -            /* Handle leaf PDEs as PTEs */
>>>>> -            flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>>>> -            amdgpu_gmc_get_vm_pde(adev, level,
>>>>> -                          &value, &flags);
>>>>> -        } else if (vm->is_npa) {
>>>>> -            flags = adev->gmc.noretry_flags;
>>>>> -        } else {
>>>>> -            /* Workaround for fault priority problem on
>>>> GMC9 */
>>>>> -            flags = AMDGPU_PTE_EXECUTABLE | adev-
>>>>> gmc.init_pte_flags;
>>>>> -        }
>>>>> -    }
>>>>> -
>>>>> -    r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>>>>> -                     value, flags);
>>>>> +    flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
>>>>> +    r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0,
>>>> flags);
>>>>>        if (r)
>>>>>            goto exit;
>>>>>
>>>>> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
>>>>> amdgpu_vm_update_params *params, flags |=
>>>>> AMDGPU_PDE_PTE_FLAG(params->adev);
>>>>>            amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>>>>>
>>>>> -    } else if (adev->asic_type >= CHIP_VEGA10 &&
>>>>> -           !(flags & AMDGPU_PTE_VALID) &&
>>>>> +    } else if (!(flags & AMDGPU_PTE_VALID) &&
>>>>>               !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>>>>> -
>>>>> -        /* Workaround for fault priority problem on GMC9 and
>>>> GFX12,
>>>>> -         * EXECUTABLE for GMC9 fault priority and init_pte_flags
>>>>> -         * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
>>>>> -         */
>>>>> -        flags |= AMDGPU_PTE_EXECUTABLE | adev-
>>>>> gmc.init_pte_flags;
>>>>> +        flags |= amdgpu_vm_pt_clear_flags(adev, params->vm,
>>>> level);
>>>>>        }
>>>>>
>>>>>        /*
>>>>
>>>>
