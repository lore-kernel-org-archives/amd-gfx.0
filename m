Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B5CD342F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 07:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0395410E05A;
	Tue,  5 May 2026 07:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KAaEuG9I";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E88710E05A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 07:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgLkj5Dn/iZlUWh84WdfAXJmoMJKopF1fNU9XLHDU2gPGjAx4SOWsuilLpOPt8S1DfpgqGAtErdga5U5U6sg+jfoYrNG22sOCTWUWAT2p/n5CSkbfpinTk3s1BSTp6EAc9y3jW5gOfOMZDoxNSmqxY2z5ajLMqMWE37h+1T0etHy2asD6eZN2rpi0I0um5qaADPxtGOYOtrLZVoFbjukZZHKbdJWxIEEwk1LhXaGNOR0ucDa9sVUvxvpcvBx9aDUXwkEMNc3/deUfV95/Ckzphcmc5vvDQpHAJpB1fSPtXHLG7EByvAQ7q52IH1VzKFVhmFcu74pL7ba135cPm1LbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UYhHTs2X6jhEzP5X/l8axAcQ7PuQxXDNvL+vWiKvk0=;
 b=MKoabYi1M4We9//Qeey2rb5dF5w2CGK0nVMAILukfE7+bSmVnlFLHzCMT6NC2HQScj9CFk3h3fzftN0onliTkRFYpKR/jSa81WWzmZU86Gwuv+61CKumj5iL9SldhMJk+ubwh74F9LkDsQoJOouXdH4nlMnvSE6rxwgc/hzjXcYwgiu3/YsVcgvJ3iF2O05j3i9mC8ULBov7D/VIjxrK4GdODbCaHNQmDVV1hI3yx8LJbLlujiyN1jc0b/dOZBxzJMrmicTrTjFuX3MT4qQ7MnTYYWJV6Z9Jn9XA/KuggJfe9t4+9VRGNR4oHdwSvzmosagKqOelMO54/ntGvUckCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UYhHTs2X6jhEzP5X/l8axAcQ7PuQxXDNvL+vWiKvk0=;
 b=KAaEuG9IfRuS1MnEahC35HfnabQ5WEG/AR2wHpnwN3o+e8e7gpPLg4cWtgViS2CUV9PZ23ybe4s0HK0MnmZmKhrlo96t97opKThb4U7co2CrFj9t6t5yQJrt8ZmiYtMobCFDpjN22Nbrw0C7FJCXtnDAm2ZamXBQN8JbVAk/dPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:54:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:54:38 +0000
Message-ID: <bc7112bd-93c6-4bb4-bc45-a375522afd35@amd.com>
Date: Tue, 5 May 2026 09:54:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix access to stale wptr mapping
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260504125645.91836-1-sunil.khatri@amd.com>
 <ff00838c-128b-40be-b215-4f21012376cd@amd.com>
 <e9078a36-09fb-4a99-ae56-d513fa787b40@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e9078a36-09fb-4a99-ae56-d513fa787b40@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 997b567a-67b3-412d-b26d-08deaa7b8eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Cn93Ocgxk04pqZm4bRNQPtvAyelUYrla+lTfoDm4gmVd5ungdwrjOwiXc0vX0HlpHVdxtIJkay2Ab+NI54ogznk6dUNxodCXeTZFkMLwS+TNQbVlM+QGpo+Vq0/maSZADxa7hfPeBGojk0uBmpUtXnFFkboAZnQM3rWxUMlE8cb7V51iDJ1HdOwi2JvZMj8pvOJEkyviCrTjOCXoKRucOY17f8OE7L5gwA0JtOy3ScVOpeD1CkQHz6MAiZ2N4DHrADK8CUu+mLiMWN7qlqlHStLnW+dgeMdZmJoIglgWoKEbVYT5eW0PN10+C8OrxJlNX5C+V9m5WpmOyadzrO7uyzesfx9SS6nhn9cvOEC3Nn94MG+MdwsrEBNLFYXIUnySSxFJ1bTlUo/7K43ob2bu5GxblqayMf1cqOV0vzgZTcNyH+hPeWZ3Xq9GMJWEqWdsjqvChmVOf8FXtPbd1zkTnbwLHENz8QXNNrTYVqUY2hugztzyayfFuvXcj/ZOG6puIhZcbqsIhVSPneJF3Tl8kr/0rQoUSlou2D3/AXU9oL8Q9rNPxPTE5dVZvnlfFcGqPHKmKfEo6caXltLC6F4sbC3lQlHdTxS4HkL9KlbR/H8Ek06ObVSjlNRNcMRC1VRKJAcpff6CApGTiuQfOblbQjdqIJnYfz4fpPqkVWhMjjwepHa1VUM7VrwKhPOZRcoQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFXblFabjQ1Q2o2M1VJMXFyK1NIVnc4M1RhcGtwSGVaSG5lMVdKeE80VWRj?=
 =?utf-8?B?RysxWDMvYjV3Q2l4UDFCTXU5OVdyaTVQQWVTZEpzNTYzaGdDbExJMlFLeFE0?=
 =?utf-8?B?blVUWjFwKzRodTNid2grMW9yUWtUbFd4TzVWL0hIdGFKbFNpRGplZnNRbjVu?=
 =?utf-8?B?aEdXVGt5WXNKZG5sTjBTaURSUUx1T3BiakpKRTNJT0Rua2daWHU1ZTAycDZG?=
 =?utf-8?B?bGxqQVIyWUdMN1UxN25STFJvWm80OWYvZkpWV3pEWG5tVktobE9XeEZaMURL?=
 =?utf-8?B?U3l0d1paSnF3Q1FpNDRXc1IrcVpNaU9jTjRFNFFIbmdsOGhMb3NJN1VoMUFu?=
 =?utf-8?B?RUxsTFY3cm8xV2FDcmp0NmJzZnc2clk5eWlkNTd2Z0xicGhFQmI5YlJKWlMy?=
 =?utf-8?B?dmhxOFlGZ1RMUGpMN1g0QjJuQWNYc05vNkRCT2h2Y0FoaVJjOVAwd0xSS2h0?=
 =?utf-8?B?RURwQVdYYm5jenZsenMyUlE5cHVEdmZ1bCt5cU9xcitJMzBXYU5QV3NQdXAz?=
 =?utf-8?B?Q21KWEpDcEpLY0dNTGJQRDNIZzBUTFowR2dWd2VIeGlIem02RDQxRzFMMXRY?=
 =?utf-8?B?MjU2cG4zbmZWTVN4YkQ4NkxiNWh6bWoxNjZSUjBiek5PV2ZPWVVSSTN6NWpt?=
 =?utf-8?B?VEZiMTdDQVR4eFNyRzBFQ09GU0gwLzNiM3pYSVpxTzVFK1RwdTd2UG45V0dR?=
 =?utf-8?B?cE5DRDFHbHRYMjJzV1ByMzFmRis1OUJGeG11dVZ6L2pEZkVmdnZqVGNkK1px?=
 =?utf-8?B?Z0VOd1VibEVmQ213QmRCM2x1ejkyL0ZPTnpidngyVzVkdm9QdWZmeXJ0UmRI?=
 =?utf-8?B?R0hEYUxYZHFJa3Vvb2FrcUM2N1VmNkJGalNJZXoyNnNmaVZ4Q1ZqbTJnQnMw?=
 =?utf-8?B?ZlJuNG04VnJvaGxKMkdYVmRjU3lmVGdGa1p3aUV2MlczSEV2R0ozcFJoTVhY?=
 =?utf-8?B?TFdGK1lJcW0rUmtTTlJrbXJlMjArUzNKVlFZVVFDOTIzVk1RRXg1Vm9QYjZ0?=
 =?utf-8?B?OERGbmxpWWVtNUZVTzhoUDdOQVFvYWVxYVNnTlNRYWlZM0RQN2VnZDlwM2Ju?=
 =?utf-8?B?ZnZ1RDBNdjdJMHlpbG9zL3NWZFRCQjZXNWFySkhaUHF6L0JZbzd6LzZUUG82?=
 =?utf-8?B?VkxBQWNhK2RuWmxxTit1dkUxdHRjUittVThxb0VjZnFjaU5WT2tseEJWWDZu?=
 =?utf-8?B?THVlVjN5bHJISjQ1dEg5dnVoMFJqRlgyMmtyODhDRXZGY1F1em9FUzd0cUNV?=
 =?utf-8?B?ek4rS3BjVytGSGZYWDNhNWsxZWlCbFA1czIrU0hzMEwxMTE5ZjNRQWVRVGNi?=
 =?utf-8?B?Wjk5aDQ1NUZuajRIczluNktPejFtdVNiSkxLTWxGWGtOcGtsNnBidHVBa3ht?=
 =?utf-8?B?MkR2TW03alRWMDRNOU8wUUNaazd4ZHorMWM5UlBkODhhSitmeENSeWQ4Z01i?=
 =?utf-8?B?U1NSZkhjT0tPMFpVT2V6amREZEUrZkRUREkxelpUc3Q4QnF1V0J5MmZ0aVAx?=
 =?utf-8?B?a0srTTVMMmtpTmV0dlpRa1VwaE9TK2NMUmRPMWRRWXhENkNvM2pOVmNVMlRs?=
 =?utf-8?B?bFNmMEU4RzJ0b21USWpyaHdGNmxXN0hpWHhZamUvWHc0OC9NdmVkNHMwUStO?=
 =?utf-8?B?dElMSm14R1R1WUI0T1YvSTRlRjQwdW9YY3prRmNrOTl5dU1YQkFMYmw3M0Q4?=
 =?utf-8?B?eDlxcUtpcGwwOG1rSVQydGNSWTg0QW9sSGVGUlFrNndGTWNhbTEyc0VEeFQ0?=
 =?utf-8?B?cGNqOFlRNlRaS0pzUGtNbXJEdzFXd1BQeHp6MTRwcUt6ZXk3L2dVL0REZUFI?=
 =?utf-8?B?QmhmRWEyQjI1cmlpZENpZ0ZLc1VvNGhYbEZ1TVZEY2NaSmhRMk9panBGdGFM?=
 =?utf-8?B?R25ZSHJ1ZkY0NUppbkZDM3ppaHd1RGUvWVdGOExhQkJScHJoNFRmVzJDcERW?=
 =?utf-8?B?cno3NlV2a1hETFQrMjQ4R2VmVVZQNkMxcmdCTWIyUFJmcjUwd29maW05eW5a?=
 =?utf-8?B?WVFXL3QxUXhTUWxaSk9mcHIrZ0Y1VXFCcTJacGlUcnJrckJXRFZLTzVnbEpu?=
 =?utf-8?B?bnY0cjh4SmkzdVpld2tZT0ZiNU1hZjFqeWpBdTFhQWVzNDJCdlNJT1J2c1Zi?=
 =?utf-8?B?eENqZmpzekdaQTlncWFKNmwwRHgzWmdWUUpQT3RpbmFpNU53Q0QrTmplVFo1?=
 =?utf-8?B?cTFkeU9xQ1JtY3A5cythWHExQ1RyVDhSdjJ4Y05WcC9LZjFhckFCY2R0dHJy?=
 =?utf-8?B?Sjl3UG9VcG04czdqc3lxeGk5TEY5V2JEM1hRWlBOdnA2ZHUvMXBHbjFnR1J0?=
 =?utf-8?Q?zSCyYTE2wLxseiFGd4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997b567a-67b3-412d-b26d-08deaa7b8eab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:54:38.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C4l+fNw5StirGMlWt9J6TzJt6CCdp7YyndjVUEaQd9GmmmdcSZZfR8Ss+SBxLba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
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

On 5/5/26 09:29, Khatri, Sunil wrote:
> 
> On 04-05-2026 06:35 pm, Christian König wrote:
>> On 5/4/26 14:56, Sunil Khatri wrote:
>>> Use drm_exec to take both locks i.e vm root bo and
>>> wptr_obj bo to access the mapping data properly.
>>>
>>> This fixes the security issue of unmap the wptr_obj while
>>> a queue creation is in progress and passing other
>>> bo at same address.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 122 ++++++++++-----------
>>>   1 file changed, 57 insertions(+), 65 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 501e2e10b4a6..3d4f83015488 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -30,34 +30,6 @@
>>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>   -static int
>>> -mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>>> -{
>>> -    int ret;
>>> -
>>> -    ret = amdgpu_bo_reserve(bo, true);
>>> -    if (ret) {
>>> -        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>>> -        goto err_reserve_bo_failed;
>>> -    }
>>> -
>>> -    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>> -    if (ret) {
>>> -        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>>> -        goto err_map_bo_gart_failed;
>>> -    }
>>> -
>>> -    amdgpu_bo_unreserve(bo);
>>> -    bo = amdgpu_bo_ref(bo);
>>> -
>>> -    return 0;
>>> -
>>> -err_map_bo_gart_failed:
>>> -    amdgpu_bo_unreserve(bo);
>>> -err_reserve_bo_failed:
>>> -    return ret;
>>> -}
>>> -
>>>   static int
>>>   mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>>>                     struct amdgpu_userq_mgr *uq_mgr,
>>> @@ -65,55 +37,75 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>>>                     uint64_t wptr)
>>>   {
>>>       struct amdgpu_bo_va_mapping *wptr_mapping;
>>> -    struct amdgpu_vm *wptr_vm;
>>>       struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
>>> +    struct amdgpu_bo *obj;
>>> +    struct amdgpu_vm *vm = queue->vm;
>>> +    struct drm_exec exec;
>>>       int ret;
>>>   -    wptr_vm = queue->vm;
>>> -    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>> -    if (ret)
>>> -        return ret;
>>> -
>>>       wptr &= AMDGPU_GMC_HOLE_MASK;
>>> -    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
>>> -    amdgpu_bo_unreserve(wptr_vm->root.bo);
>>> -    if (!wptr_mapping) {
>>> -        DRM_ERROR("Failed to lookup wptr bo\n");
>>> -        return -EINVAL;
>>> -    }
>>>   -    wptr_obj->obj = wptr_mapping->bo_va->base.bo;
>>> -    if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>>> -        DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
>>> -        return -EINVAL;
>>> -    }
>>> +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>> This should probably be 2 instead of 0.
> Noted
>>
>>> +    drm_exec_until_all_locked(&exec) {
>>> +        ret = amdgpu_vm_lock_pd(vm, &exec, 1);
>>> +        drm_exec_retry_on_contention(&exec);
>>> +        if (unlikely(ret))
>>> +            goto fail_lock;
>>> +
>>> +        wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
>>> +        if (!wptr_mapping) {
>>> +            DRM_ERROR("Failed to lock up wptr bo\n");
>> Please drop that error message. It can spam the logs when userspace intentionally gives incorrect values.
> Noted
>>
>>> +            ret = -EINVAL;
>>> +            goto fail_lock;
>>> +        }
>>>   -    ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
>>> -    if (ret) {
>>> -        DRM_ERROR("Failed to map wptr bo to GART\n");
>>> -        return ret;
>>> -    }
>>> +        obj = wptr_mapping->bo_va->base.bo;
>>> +        ret = drm_exec_prepare_obj(&exec, &obj->tbo.base, 1);
>> Using drm_exec_lock_obj() should be sufficient.
>>
>> We don't need a fence slot for this use case.
> Sure
>>
>>> +        drm_exec_retry_on_contention(&exec);
>>> +        if (unlikely(ret)) {
>>> +            DRM_ERROR("Failed to prepare wptr bo\n");
>> Same here, that this can fail is normal handling. The worst case is OOM and that is already printed in the logs.
> Noted
>>
>>> +            goto fail_lock;
>>> +        }
>> We got all the locks now, so the drm_exec_until_all_locked() loop can be closed here.
> True, Noted
>>
>>>   -    ret = amdgpu_bo_reserve(wptr_obj->obj, true);
>>> -    if (ret) {
>>> -        DRM_ERROR("Failed to reserve wptr bo\n");
>>> -        return ret;
>>> -    }
>>
>>> +        /* mapping now should be stable since both the locks are held */
>>> +        wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
>>> +        if (!wptr_mapping) {
>>> +            DRM_ERROR("Failed to lock up wptr bo\n");
>>> +            ret = -EINVAL;
>>> +            goto fail_lock;
>>> +        }
>> Doing that again is unecessary. We are holding the VM lock above while doing the lockup.
> 
> First time we had mapping at time we did not had wptr object lock. Isnt it possible that either mapping is changed/updated or the bo is freed. At this moment we have both the locks and we
> 
> should be having correct mapping.

The VM lock is sufficient for that. If somebody tries to unmap or free the BO the code will block on the VM lock to remove all the mappings.

So as soon as you grab the VM lock you know that the mapping wouldn't go away.

>>
>>>   -    /* TODO use eviction fence instead of pinning. */
>>> -    ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>>> -    if (ret) {
>>> -        drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
>>> -        goto unresv_bo;
>>> -    }
>>> +        wptr_obj->obj = amdgpu_bo_ref(wptr_mapping->bo_va->base.bo);
>> That is now unecessary as well.
> 
> We are holding the reference in original code and freeing it in destroy. Dont we want to hold any reference now, how do we make sure that its not being freed in between?
> 
> If we dont need a reference then we need to remove from the destroy path too. In amdgpu_userq_destroy we are doing unpin and unref both db_obj and wptr_obj.

Ah! So we keep wptr_obj around and drop that in the destroy path! Yeah then it makes sense to grab the reference.

We can potentially drop that when we stop pinning the wptr BO and use the eviction fence instead.

Thanks for the explanation.

Regards,
Christian.

>>
>>> +
>>> +        if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>>> +            DRM_ERROR("Requested wptr bo size is larger than one page\n");
>> Same, please drop that error message.
> Noted
>>
>>> +            ret = -EINVAL;
>>> +            goto fail_map;
>>> +        }
>>> +
>>> +        ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
>>> +        if (ret) {
>>> +            DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> That error message is useful.
> Got it.
>>
>>> +            goto fail_map;
>>> +        }
>>> +
>>> +        /* TODO use eviction fence instead of pinning. */
>>> +        ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>> Oh! The piun needs to come before the alloc_gart! That's wrong in the existing code as well.
> Got it.
>>
>>> +        if (ret) {
>>> +            DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
>> That error message makes sense.
> regards
> Sunil Khatri
> 
>>
>> Regards,
>> Christian.
>>
>>> +            goto fail_map;
>>> +        }
>>>   -    queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
>>> -    amdgpu_bo_unreserve(wptr_obj->obj);
>>> +        queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
>>> +    }
>>>   +    drm_exec_fini(&exec);
>>>       return 0;
>>>   -unresv_bo:
>>> -    amdgpu_bo_unreserve(wptr_obj->obj);
>>> +fail_map:
>>> +    amdgpu_bo_unref(&wptr_obj->obj);
>>> +fail_lock:
>>> +    drm_exec_fini(&exec);
>>>       return ret;
>>>     }

