Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC3C9830D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 22:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C9310E256;
	Wed, 23 Sep 2026 22:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RREjtVq9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9952E10E256
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 22:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXRc4zrwR0JCDwbdRmgalc0dxE4ew0uNyxsG89nfDzlUBE/9ChpKwzLAFLNFF+4EtQyGuw+aUDzSidTE3/FMiYhexrZ018txl9WLDZ6BCQaRG4uQj4mwHljLmd1nQnN6qcYqTOGKAKAfZkuAzcvdSVBavSJr1PjeSRzzFR/BNWFz7BT1g3kTqbCRiG+jHiGfSkdUZCXDJkBtP6KRMoBbOYNtCg7dSFdg7VUVLqWl/cwGt7xkwIMZcDaifnehqSGTOro/gxcrEjj/TGpJUoPZC3/Yrq5i4j0viWX6B0O2oBfba0eEd8QM2CNIS6RnIA2tmVBB80KQFnOiFiZOkv95rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h48kYPfGF2rsHwvSn8olqiy9srRZAxmlCh2E8d131gE=;
 b=tekDlXS0CDktFhKBxVP6IYaO/i68dmAW8a7sNA5k7Wnp6LCOoSVL2jtynjgew4I6HDSe1p8eB5lzPEZ8v2jMK+Ee5wXj9qWxOtPsguQsuhYFjuMIIARWidLQU9KT4YxsdZoooHzlvDT0UGT3U3wfeabL65bSXYnHV80dc52lE3DX219BKxp6Ut80RlcK5EPkgiM56CpeElH5Rg/PJ5tL45GrVR3ZwrQP7OoeTSgnvLSPGFq+AcLr+kPZ4BPPr4M5dg77dNS1sHL9aDCXHXRWRQRuwUK7pkIRx13cPzYMbHmMSKFXQSbk78hVeYzmqpm5isEfYT0RBU/sNmX5m5fGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h48kYPfGF2rsHwvSn8olqiy9srRZAxmlCh2E8d131gE=;
 b=RREjtVq9SDQjMKidOGncOiGu1Rz0qRWecKczGQStfyOF0X0zoAXYbqDbjBbKSbkihLCg+obxsHTDa/2o/4bFv3nhSb81ApcEs9wPLtL/G3OGmf4MGFOp2lHNJjO/D7rusgz+bz/At9/j+lWnJvd1fZJHetLeWK/i4qs+p/rRt8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by DM4PR12MB6086.namprd12.prod.outlook.com
 (2603:10b6:8:b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 22:24:43 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:24:42 +0000
Content-Type: multipart/alternative;
 boundary="------------APddK5JYfX2IwqmYwrAbxS0O"
Message-ID: <56e4648e-e1ba-4fbc-8854-5f030968d7c6@amd.com>
Date: Wed, 23 Sep 2026 18:24:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix bo_va leak / WARN_ON in
 gem_object_open error path
To: "Kuehling, Felix" <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com,
 Christian.Koenig@amd.com
References: <20260923212838.1421843-1-mukul.joshi@amd.com>
 <20260923212838.1421843-2-mukul.joshi@amd.com>
 <2a0655e8-9284-4ba9-b3bd-ce2eb2ae036a@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <2a0655e8-9284-4ba9-b3bd-ce2eb2ae036a@amd.com>
X-ClientProxiedBy: YT4PR01CA0484.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::7) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b30bc6-f56d-4581-76cd-08df19c176c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|8096899003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: XO9PsRvXzN7ySJVeB8KFo76uC84maEtdyDG8uylEL2I7OlEHp4EosG3WDO3mHFWFZcSMi71MkA50N2yg4YKDNGrzRsnl7mP/iSbAAAmW1TzGkPXTffodoykMG6e2Uj2hF2KC1irlHryvUKn/DjaqZOMhoXRy0RqtQ4bXVKWI4gd67/fOG51UX2sETl2xLWWrwLZQPqVfckMTNl5VIh0mFx1wJXMc8+wvyN7eEXjFq+RHBlYZosfs5ANxjoOlY+e8hoqBhrjLgbxVsk84YHVf6YBI27rgcPQSJMseUpgJOd1+uKhuC3UJ90IlrpxdRdEH2j7uxB92QLJfTks7Os9DWLbzXqYnvbgdVtOUjlRTO/K3bbpSfg2FqH85Cgg3YE2H1iloRV7R7pvBXi0nxq5cH1qL39LPteR0pS0SOE5HgNlPBGzlvNX6iNj2YRx5VgOAvlh3IcDVWOs8Lr3WvB4RlJgo61gniD8uekSIKnKivyWuYVH0r6MkHiKim8qjyFNH5Yn9adQi1/dfUk2h6Pf/1EvmoFjzySqoWT21mUmHOQvr8R/zlTX2EXV3tmyIwR6GKxkyufw4nfpYa3jWdDSoPS3zmXQm3DX+SG+MoNmjzdu77EMFqH4tHyzowkcELb4/fAXrn8x0d/2z6hbLGy9K9rQPxdc73/zIvMty9hur204=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(8096899003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlSQnkxUTVWSXA1L0s1QnprQ1BMeWlpZU53ZGpHZnRmcDZzRC8rclgrY0pF?=
 =?utf-8?B?bXZuaHBvTHV0UDJhN2ZZaGdyODU1bkZtV0ZwQTZmUldMSkpGQXJ4RStOVjh6?=
 =?utf-8?B?WXhXQTNlMmVhWmJFa0ZmeE1zUjd3SnpIdDBHZFZpN2ZSK1hmQ0N4QlhnNGpX?=
 =?utf-8?B?Q0Z4a0VrckErN2FjOTZ5d0FUZ0RaWUVMZUI1ZlBGVGlOazVlVmFHZFIrbDls?=
 =?utf-8?B?MW5tSEdjb3d1SWI4K2lNejgvTTh5dUxTREdTZzVsZmpoYlBrTHg2R1oyUzlE?=
 =?utf-8?B?S3kyand3Zm0xdU81Z0xzREZuR0tjUy9JMUVYZXhVc1hUeGlacmJTQXlPZG9s?=
 =?utf-8?B?QzhmMGxmcCtIZGtuQVJhblR0eFY5S3JxeExDVmg2ODdHVXk2N3pvczAzV2lj?=
 =?utf-8?B?Q0xGdjBxRloxbU9XeE8zS0V1dlNwcTUrNEYrM3pNenFrWDJnMlB0cXhGa1dU?=
 =?utf-8?B?b1VEM3RKZUFQeFJkTWVqSlNjR2s5eGo3QzFwSFJMUFNndE4yWlhneTd2SlBC?=
 =?utf-8?B?eU01NzFmMUJsdjRMQ3ZxVDFWSmdwUk5NZG41ZmxaYzVpdFlaT3hsck9CM2ls?=
 =?utf-8?B?cVdYLzBxczFqWGVIdEZKSWNieVFFQ3NlaFVRbDNMcUZMb1hadXdRV2tOSUd3?=
 =?utf-8?B?Z1hGNVlseUdDTDg1dExSd3hFZDE1dHdhQ2ROLzUvZmJrL3VDMytha2FBQUVq?=
 =?utf-8?B?enh0Q2crY1FQME1nbDhML3NiSlNuM1JwUk1veldNSFhyMXl6Vm9JSlpNc2FV?=
 =?utf-8?B?UWpxRWdZcXZGMlVWZ2tYdXlpdTd4VWJkaDQyVFMxTVZqeHFKa2xZa0NMNjdp?=
 =?utf-8?B?VDRPNG5Ddy8zeVRhQXMvaDJNY3hNVEVIRnJaNFNQVy9YdUNUZmhYbUN6OHRt?=
 =?utf-8?B?bVRiV2c3dVBuQ0VIcFJaQXovMFZoNmtleG9yTjZBcEprT2EySC83NVFuQ0ts?=
 =?utf-8?B?bXdwVlYwRDROT1NVVkVhdU1aWUFWQ2syM1BMWEJaUXdLdm1UYlJseUdwbFhl?=
 =?utf-8?B?Y3N3MVd2b0ZpVnAxZ3kwdE1sWU13WDdWNXhzT2JCKzVWVVdlRjVUMURxV200?=
 =?utf-8?B?bnFaV3N0cmhsL1hjRzVPdnZFSkVOZHRFRXZWZlZzVFEvSzJzTzVxWi9jem1i?=
 =?utf-8?B?M0lzK3IxdTBaWnoyUFJYNjZEaFVSN01FaUJwZm5ESkhHdjZheVRIclo3MzNO?=
 =?utf-8?B?YW5NQWhxUGROQzhpSldEY0tBd1lOaUl3UnE2cDBLZ1ljVHFCSGVDZnNuMjBY?=
 =?utf-8?B?SDNrbzEvVWVPSWxSTURpNzJqOEcrOHNTeGc5Z3lIZ2tuSEs4L0JWY1pvYjFq?=
 =?utf-8?B?NWd2a0FlZUkxZnNOMEdndEV4K3Q1RDBKSGpkN1djeXhZQVRoWklIb2QxZmY0?=
 =?utf-8?B?RFVIc0lkcGNvUWJ4a0ZqL1V2a2JoSzgvOHlTdUZLVkduQVhjVnZMc2ZFUm5N?=
 =?utf-8?B?bGY1UTB3a0ZJSFBNaWtZeGYrZzZOYWlOYkZFRHJFN0Fka3M3T01MbEhKdkEv?=
 =?utf-8?B?cER4UGoza3NLZWFYT2FoM3VqaDNuUUhWeTcvTGJ0T2k3UGdXMWdqdXZNUFJQ?=
 =?utf-8?B?Y1JBQ0RUREJvdllSM0dJTmxCMURXMDVIODF6UXZzang5WVpvQlhyaXVvSE1n?=
 =?utf-8?B?L0ZhdnpWRkZKbGZwZGFlL1dqQTFEOWIwZ2FXQno5VHNuYjFpaXR6NHh1WFZB?=
 =?utf-8?B?QkpQZENJM0ZCMGcvOSthb05MZDBFSDJWN2xBczYyZ0xrc2c3b0tKTmFyY0s4?=
 =?utf-8?B?T1VoT3A0Wkl2V2J0NmNBU3NjZng0MjE3UzZ2SFZMc2FiUUE0amc0SkFDMjdJ?=
 =?utf-8?B?MEdEazhxdU1TMVVxODl3VVpKN0d4YzVrSkdsVzVmRC85V3pSczR6bkJxTGly?=
 =?utf-8?B?cE9rVXUxNUV3N0g4elgrQ3lKQzYyZ21DczBZa2V5UjQ5WTczUG9PZDlHZENX?=
 =?utf-8?B?QVE4UUlNYkV6RnF5bXM1UExER2UyL1NJZW5kZEJRQmg0RDRzNkZJc0FrZHU2?=
 =?utf-8?B?NEp5SVNDOHdaZ3MyQkQ3Q0pvVEN1a1hud2F6T2UzdEh0NmlFY0luQ0RjVTl3?=
 =?utf-8?B?MXFoclJkNUZVTjFoOHJjOWFYbWdtWVVEdmxldnBvczMwUE5BZTVONlgxWlZh?=
 =?utf-8?B?L1JFQXhNZUU0WW55NkxqNHVraXZoZHZUN3pUMFVCTjVoWHdCKy9wNVA4OUk1?=
 =?utf-8?B?NlMxREo2bnk2TVVyYmx0Wk5IUjN1cElWNDJFSVFHZDVmN3dpY01LSXE4THJh?=
 =?utf-8?B?MzNQbGc2MkdjOE5SRXBXVmFiZjR6ZkpkL0s2SEducFlFWWpJT1ZSTVJmU09k?=
 =?utf-8?B?dUFaRkJQbk5MVXZhS05OWCtINTFDbjg2RW1lVFRLL0hRRHNZTkh1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b30bc6-f56d-4581-76cd-08df19c176c0
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 22:24:42.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMsfMKdTGjp8sZyXJ2EaskkC79P9HSoe4VRMVQ30gJ7apGnQn1D0Ki4Lfzgry/BpzqPpXzE9G7KZGf/L7AOpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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

--------------APddK5JYfX2IwqmYwrAbxS0O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/23/2026 5:57 PM, Kuehling, Felix wrote:
> On 2026-09-23 17:28, Mukul Joshi wrote:
>> amdgpu_gem_object_open() maps the BO into the caller's VM early
>> (amdgpu_vm_bo_add(), which sets abo->vm_bo) and only later validates and
>> attaches an eviction fence for dynamic dma-buf imports in compute VMs 
>> via
>> amdgpu_amdkfd_bo_validate_and_fence().
>>
>> When that validate/fence step fails, the function returned the error
>> without undoing the VM mapping. Since .open() failed,
>> drm_gem_handle_create_tail() aborts the import and drops the last
>> reference, freeing the BO while it still has a bo_va attached. This 
>> trips
>> WARN_ON(abo->vm_bo) in amdgpu_bo_release_notify() and leaks the bo_va:
>>
>>    amdgpu 0004:04:00.0: validate_and_fence failed: -12
>>    WARNING: CPU: 96 PID: 2868883 at amd/amdgpu/amdgpu_object.c:1343
>>             amdgpu_bo_release_notify+0x15d/0x180 [amdgpu]
>>     ttm_bo_put+0x149/0x350 [amdttm]
>>     drm_gem_prime_fd_to_handle+0x132/0x1c0 [drm]
>>     drm_ioctl+0x251/0x3d0 [drm]
>>
>> Roll back the VM mapping on the error path: re-reserve the BO and PD, 
>> then
>> either delete the freshly added bo_va (also detaching the eviction 
>> fence)
>> or drop the extra ref_count taken for a pre-existing bo_va. Also 
>> clean up
>> the bo_va in the out_unlock path when the eviction fence attach itself
>> fails right after amdgpu_vm_bo_add(), which had the same leak.
>
> That looks like a lot of complexity for a rollback. Would it be easier 
> to move validate_and_fence before mapping the BO? That way, if 
> validate_and_fence fails, there is less to roll back.
>
Sure. That makes sense. I think that approach is being attempted by 
another engineer.

I will ask him to send the patch out for review.

I will drop this approach for now.


Regards,

Mukul

> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 53 +++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 0d579517c03c..d52bbdc42b31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -237,6 +237,7 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>       struct amdgpu_bo_va *bo_va;
>>       struct mm_struct *mm;
>>       struct drm_exec exec;
>> +    bool bo_va_added = false;
>>       int r;
>>         mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
>> @@ -264,6 +265,7 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>       bo_va = amdgpu_vm_bo_find(vm, abo);
>>       if (!bo_va) {
>>           bo_va = amdgpu_vm_bo_add(adev, vm, abo);
>> +        bo_va_added = true;
>>           r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>>           if (r)
>>               goto out_unlock;
>> @@ -304,9 +306,60 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>           }
>>       }
>>       mutex_unlock(&vm->process_info->lock);
>> +    if (r)
>> +        goto out_vm_bo_rollback;
>> +    return 0;
>> +
>> +out_vm_bo_rollback:
>> +    /*
>> +     * The open failed after we already mapped the BO into this VM. 
>> Undo
>> +     * that mapping, otherwise drm_gem_handle_create_tail() aborts the
>> +     * import and frees the BO while it still has a bo_va attached
>> +     * (abo->vm_bo != NULL), tripping WARN_ON(abo->vm_bo) in
>> +     * amdgpu_bo_release_notify() and leaking the bo_va.
>> +     */
>> +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        int r2 = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
>> +
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(r2))
>> +            goto out_rollback_unlock;
>> +
>> +        r2 = amdgpu_vm_lock_pd(vm, &exec, 0);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(r2))
>> +            goto out_rollback_unlock;
>> +    }
>> +
>> +    bo_va = amdgpu_vm_bo_find(vm, abo);
>> +    if (bo_va) {
>> +        if (bo_va_added) {
>> +            if (!amdgpu_vm_is_bo_always_valid(vm, abo))
>> + amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, abo);
>> +            amdgpu_vm_bo_del(adev, bo_va);
>> +            amdgpu_vm_bo_update_shared(abo);
>> +        } else {
>> +            --bo_va->ref_count;
>> +        }
>> +    }
>> +
>> +out_rollback_unlock:
>> +    drm_exec_fini(&exec);
>>       return r;
>>     out_unlock:
>> +    /*
>> +     * If we already added a bo_va (e.g. the eviction fence attach 
>> below
>> +     * failed), remove it while still holding the reservations so 
>> the BO is
>> +     * not freed with a dangling abo->vm_bo.
>> +     */
>> +    if (bo_va_added) {
>> +        bo_va = amdgpu_vm_bo_find(vm, abo);
>> +        if (bo_va)
>> +            amdgpu_vm_bo_del(adev, bo_va);
>> +        amdgpu_vm_bo_update_shared(abo);
>> +    }
>>       drm_exec_fini(&exec);
>>       return r;
>>   }
--------------APddK5JYfX2IwqmYwrAbxS0O
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/23/2026 5:57 PM, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2a0655e8-9284-4ba9-b3bd-ce2eb2ae036a@amd.com">On
      2026-09-23 17:28, Mukul Joshi wrote:
      <br>
      <blockquote type="cite">amdgpu_gem_object_open() maps the BO into
        the caller's VM early
        <br>
        (amdgpu_vm_bo_add(), which sets abo-&gt;vm_bo) and only later
        validates and
        <br>
        attaches an eviction fence for dynamic dma-buf imports in
        compute VMs via
        <br>
        amdgpu_amdkfd_bo_validate_and_fence().
        <br>
        <br>
        When that validate/fence step fails, the function returned the
        error
        <br>
        without undoing the VM mapping. Since .open() failed,
        <br>
        drm_gem_handle_create_tail() aborts the import and drops the
        last
        <br>
        reference, freeing the BO while it still has a bo_va attached.
        This trips
        <br>
        WARN_ON(abo-&gt;vm_bo) in amdgpu_bo_release_notify() and leaks
        the bo_va:
        <br>
        <br>
        &nbsp;&nbsp; amdgpu 0004:04:00.0: validate_and_fence failed: -12
        <br>
        &nbsp;&nbsp; WARNING: CPU: 96 PID: 2868883 at
        amd/amdgpu/amdgpu_object.c:1343
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_release_notify+0x15d/0x180 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; ttm_bo_put+0x149/0x350 [amdttm]
        <br>
        &nbsp;&nbsp;&nbsp; drm_gem_prime_fd_to_handle+0x132/0x1c0 [drm]
        <br>
        &nbsp;&nbsp;&nbsp; drm_ioctl+0x251/0x3d0 [drm]
        <br>
        <br>
        Roll back the VM mapping on the error path: re-reserve the BO
        and PD, then
        <br>
        either delete the freshly added bo_va (also detaching the
        eviction fence)
        <br>
        or drop the extra ref_count taken for a pre-existing bo_va. Also
        clean up
        <br>
        the bo_va in the out_unlock path when the eviction fence attach
        itself
        <br>
        fails right after amdgpu_vm_bo_add(), which had the same leak.
        <br>
      </blockquote>
      <br>
      That looks like a lot of complexity for a rollback. Would it be
      easier to move validate_and_fence before mapping the BO? That way,
      if validate_and_fence fails, there is less to roll back.
      <br>
      <br>
    </blockquote>
    <p>Sure. That makes sense. I think that approach is being attempted
      by another engineer.</p>
    <p>I will ask him to send the patch out for review.</p>
    <p>I will drop this approach for now.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Mukul</p>
    <blockquote type="cite" cite="mid:2a0655e8-9284-4ba9-b3bd-ce2eb2ae036a@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 53
        +++++++++++++++++++++++++
        <br>
        &nbsp; 1 file changed, 53 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
        <br>
        index 0d579517c03c..d52bbdc42b31 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
        <br>
        @@ -237,6 +237,7 @@ static int amdgpu_gem_object_open(struct
        drm_gem_object *obj,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_exec exec;
        <br>
        +&nbsp;&nbsp;&nbsp; bool bo_va_added = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = amdgpu_ttm_tt_get_usermm(abo-&gt;tbo.ttm);
        <br>
        @@ -264,6 +265,7 @@ static int amdgpu_gem_object_open(struct
        drm_gem_object *obj,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va = amdgpu_vm_bo_find(vm, abo);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo_va) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va = amdgpu_vm_bo_add(adev, vm, abo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va_added = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
        amdgpu_evf_mgr_attach_fence(&amp;fpriv-&gt;evf_mgr, abo);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;
        <br>
        @@ -304,9 +306,60 @@ static int amdgpu_gem_object_open(struct
        drm_gem_object *obj,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;vm-&gt;process_info-&gt;lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_vm_bo_rollback;
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +out_vm_bo_rollback:
        <br>
        +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * The open failed after we already mapped the BO into this
        VM. Undo
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * that mapping, otherwise drm_gem_handle_create_tail()
        aborts the
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * import and frees the BO while it still has a bo_va
        attached
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * (abo-&gt;vm_bo != NULL), tripping WARN_ON(abo-&gt;vm_bo)
        in
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_bo_release_notify() and leaking the bo_va.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; drm_exec_init(&amp;exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
        <br>
        +&nbsp;&nbsp;&nbsp; drm_exec_until_all_locked(&amp;exec) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r2 = drm_exec_prepare_obj(&amp;exec,
        &amp;abo-&gt;tbo.base, 1);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_exec_retry_on_contention(&amp;exec);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r2))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_rollback_unlock;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r2 = amdgpu_vm_lock_pd(vm, &amp;exec, 0);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_exec_retry_on_contention(&amp;exec);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r2))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_rollback_unlock;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; bo_va = amdgpu_vm_bo_find(vm, abo);
        <br>
        +&nbsp;&nbsp;&nbsp; if (bo_va) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_va_added) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_vm_is_bo_always_valid(vm, abo))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_evf_mgr_detach_fence(&amp;fpriv-&gt;evf_mgr, abo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_del(adev, bo_va);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_update_shared(abo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --bo_va-&gt;ref_count;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +out_rollback_unlock:
        <br>
        +&nbsp;&nbsp;&nbsp; drm_exec_fini(&amp;exec);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; &nbsp; out_unlock:
        <br>
        +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * If we already added a bo_va (e.g. the eviction fence
        attach below
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * failed), remove it while still holding the reservations
        so the BO is
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * not freed with a dangling abo-&gt;vm_bo.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (bo_va_added) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va = amdgpu_vm_bo_find(vm, abo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_va)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_del(adev, bo_va);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_update_shared(abo);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_exec_fini(&amp;exec);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------APddK5JYfX2IwqmYwrAbxS0O--
