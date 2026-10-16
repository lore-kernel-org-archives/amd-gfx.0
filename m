Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03B3CCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 09:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFF51126BE;
	Fri, 16 Oct 2026 09:00:49 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBA81126BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 09:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGsrNypbZrnIxjmJxxLfCAfPDJBf7LEhfNaEInwoEJWxoNUwqNzZCnaexnRBDK9RxuWGz0h8eeuXhwfRNwAqKhPnKt1sngAKyc1f10EMxLkxLTN9dZxfhizBFwcdY4HB9KXuMWT7HuyX1li5/BrlQZZJriFyzPDFrk2+bRLne6yP7CFBRWnzfJFYem/ESxbE20lYhmMxD+N4Kchb2hxpeCR16XqQPHhCDqUiLi4JDoPGC23SZ2vuwYV8CMX7uA+3fxz+ngPXhuuDoDxf6qiZyLBXEL8QcBocDDiWUBs+SnB87Kzkj+UwKRuOFIt7O6/nOxL7rGVEeERjSumZoVZmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxmENF9Q/Iui77JaizxnGvEEZR9TUGYi9c6AzVFCKgk=;
 b=DXbxx7M2yjxfQHAz0QtaUfQX9q7C9kY7sSr6rT8thDDaP+ldgUZiWnG/QNUquFpqfFHvZ0oA5DYM2wHaJY8NX+5ZgAHE8d16tcXvi4CH9eH8Qu1YTfrb6w5lpH+gAZ4C00U1xKdRgZCflClVigCwyGrOfiM9IVdfkbPG+x/5VAsZTIbtNXFqsTn/mKRvm3ElxyrP7jUPIoF16pkKP2lxEOUD8oTDquXBVljxUP9MOHJNFE8ifpVOtf/EVMChay5MQwQxJAXWbkRaS1nblF18pkkiAUO9ID9k5HLWXeCeaqQvNUw8RiH9azaDktW9hvgnmuL9sXVG1f2WggIGAzFJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxmENF9Q/Iui77JaizxnGvEEZR9TUGYi9c6AzVFCKgk=;
 b=bsTjKdyd9N3lZdfFq8fId4dLZpG0MpEnlan/Aoh1VGTX0o8T1POagOqIjuLcL6PkLVWPr6yha3SlbfuJP7z74nk04c+WKRDlvFVcN5jJyMUA8DZ89uAPR6LAYMdTFB5mCyc5knGiFgOAd+S+fNhKUR/yMOK7Tf+DaRMVd6qz0UQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:00:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 09:00:41 +0000
Message-ID: <f736b717-f260-4e3f-a1a0-885e3fdecff5@amd.com>
Date: Fri, 16 Oct 2026 11:00:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: map the seq64 memory when restoring
 user queues
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Soltani, Shahyan" <Shahyan.Soltani@amd.com>
References: <20261015072150.3414162-1-Jesse.Zhang@amd.com>
 <262a4948-c17c-4cfb-8235-64c9b3f906de@amd.com>
 <BL1PR12MB51444FC74C3E3FDCC7BD8512E39B2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB51444FC74C3E3FDCC7BD8512E39B2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: b1556b6e-5dc5-488e-1614-08df2b63f46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Fl0d+W0UwN4w04gC8QevU3TdimDcoX41CYeCJBUtosHNH6jzJERIDa8Fw39rhA5K8tHLaY4+7KVqFC40YfKjab+Kv0AUN8cNIupJ9LGY8hW+BPURmQABzqHrCNbsODJu/0KFv6Eg/Axwl/nr+hGJffkMv+UpbyraxT06kh6mgDv60YdJol5W/IjxeQqoUEThw7fXOtgW+kMU4nxM6Aq7bxajLjB/XytVthA8Vl6RVtNa27BpeAdI+A1GWDfTFEkeHouxsOe1/cRTYIL8QYKFkgEBUN54RrRZC7uDqf9uvUVPsHjkRJQ6nCIyVVdEVEa63UdQE9PqV4qWqLo70b7GCCAXYiB21NVPOGweub9GnmAawGdJ8zSGhloKYVyUWKrVWMEItmgWMo9zw2lD2ajVUlCJdt+wUtlMF3cEwR+MmtupKHd1zpwI9reFlrRjA1hzXAottJD0S1WcuvykHCjjPbRAfS1DKxYp8jahZBLNaBssHmrJq1XiZ5MwvFoWbsNfSaZHzV6Z0U5Jc3tSGZFOEtZ1hM1YlhpL1vOLJVvhIWFyTpVKkVMVVSEwNMftY8msLsFsSSvdAwv6rQx1H+iJqoYGfDSpY0GC0oKfAyJMycMr04U8q1nQZn82gA+cQwS+42T4PGFPbUJPlSq5oHmxO/kNW6GNbyb8eAN1AiRHG74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJ0MFgzT0x6ZUlWNWw0U1o0RkwxWURSSjdLbGJMQ1hYK1JacnA1a0RETU91?=
 =?utf-8?B?WitpQTNONm9YQUV0VXI2ZnBORGFlRVMya3NhcWh1VjBYeXo5Ri9iNHIyZ2Uz?=
 =?utf-8?B?dS9FVUt5cFB0YkR2dnRQb2hSU3d4c3BBNDhHQVg4WU51VUpYQ1lJMnh3TFV5?=
 =?utf-8?B?MzdXNlltRmZJb2xJTzNVZDN1cEVsZHpBSEdFeis5c0IzUkhtZXpGUHk4TUVo?=
 =?utf-8?B?UUlXb0d6MG1OOTUyVHlhbGhqYmk1WFVxdlRkcVBWZWxieXNycTBuckJoMEFT?=
 =?utf-8?B?RFE0clhoVUtaZm9xN1orYTU3RlIwenNHUElBN0JYakFVOFlDYStSMzg5aHJ0?=
 =?utf-8?B?bUs3OENYTGlPSHF1VzkzelJLbEtIR21zVkZXNEZESWs2Zzcxa3h2ekdBakZh?=
 =?utf-8?B?SlNOZWc2RDNDNXdJVGNNQjRYZUxOY0d2dVBLdHF2d0t4WWIrc3dERTNtL1ZY?=
 =?utf-8?B?akEyd2g5QWZJNitLMHFhVlYwRG1vajNjYU5kZ3VDN3UrVU9XV3RTMlZLbFhi?=
 =?utf-8?B?alV1YkY3ZVhRcVRwNFdaRHdsMFUrdzRwc3RyN2kvTU5ISXpuaXBRbGNpb1Zh?=
 =?utf-8?B?dkY1Q3RyeEFlWW1wbDN0U0grRkJBV0xMUFhPNnYyN3NTNXZNZU5JQ3pZTzlV?=
 =?utf-8?B?bXpXNUt4KzB1MVBzYU4zOStad09NejlkbkNVY1hocEJrNnVRdXl5WVdvVVlB?=
 =?utf-8?B?dWUxZWJEMkhiM3lNOTZ0OFIwM3pNUXRhbVVieXFKR05QcVpKUDYyd3hZRjhT?=
 =?utf-8?B?a2d5Vzh5bVVveWdzcUJiRGlDOG5hY3FFKy9TV2ptY2tEZmVnUHZEWm5SRXo1?=
 =?utf-8?B?aGdseW9xdUxWWVBuaW1qbng4YUVFM1RIbkpvZy9ZYWptVWM5eVJvM0oyckhF?=
 =?utf-8?B?eUx4bkJJS0pvdG82b0pMeURsTW5BQ1RjYmpqVTU1eEo5QjdNcUVmdklURjZW?=
 =?utf-8?B?QldFOUpZblZVSW43U2d1VXdPVGpydFE2aDBiSWZTc3Jpd055U242elFnVjNo?=
 =?utf-8?B?STVKc0NrU2VQNXREdjN2b2Y1K25FVmpWeDhseHhkRnRHRUNkb0N6cmcrSHJW?=
 =?utf-8?B?VlM1cTdoK2VDZnZnSlFteURIWVorR1J0ci9vTDI5cG1QTU9rK1RVVmZGMW5y?=
 =?utf-8?B?UndhcENsVE5YR0NZY3hxeTVpcDltSEJ1d3ZLMDR2UDAyRXBSN1VhN2c3R1Ro?=
 =?utf-8?B?cVpXb0dnb0x6YXNBY2VuQWhna01OaC9sRGhpVE1UVEFRYnNjYWJveVNmRzFV?=
 =?utf-8?B?bkpoRTAzbDJPS2R6WEp4K0o4Y1UrVmlkU2tQM00vMStGamhoYnlKbTdvV2NL?=
 =?utf-8?B?Y0hXZElUUE0vYUpkQ0N6L1RmeHVyUGo2eC9pVEZ4RnVHZTRQWFFZSjE5K2RE?=
 =?utf-8?B?clBMYUNNZWhuUitDWWNLbGQrN1AyUGRjcEZLRjl0VjcvWnJIK3JOc2hDWmpV?=
 =?utf-8?B?K0NQOERNcG5RYktaaC9lNnZSR2NHWGpUQU5IQk95V1I0VVFJOWxwaUNzUG9P?=
 =?utf-8?B?bnhmelFOZzFIM3VHYlJnYUhkeTNaUjdpT0VKekpTVjFwQmViSjVBTWhITUo0?=
 =?utf-8?B?SUhDcGllMGVVcmdRblVqbnF1TGRoN2xydGM4MEV2L1o0YTZFYTAxeTdmV0hw?=
 =?utf-8?B?ZHBmTTJQUlhMZ0VmWGEvOVFYMFd2R1VITUFVS2hVdThWWXZkbEtLZEhsZGVm?=
 =?utf-8?B?dlpOeWNodWY1aHRhRE1UUEIrNjY1ODFNa25QOVlLS04yTTNyNDRNdlNTR0sx?=
 =?utf-8?B?U1ZvTXNWRGY3TXc1UnpqanYzbmw0VmxtRXVMZFFRaDZHb3dvODN2TlFueDhF?=
 =?utf-8?B?WXR0L0thNWFaQTkxWDQyd25YMjIvQ0NFN0lmWjhkd0M1aUhnSWJuOXFKQm9C?=
 =?utf-8?B?OFJra05ScHgwNmNEK2JVcnVDTWZreXhUdGZtdTZIekVwWmRmVzBzVHRva0p5?=
 =?utf-8?B?SDBiQVJmOUlpTzd0UXpQcXlweDhJQysrQmxST2NRTTRaZC9HWHJyOGNNZ2dj?=
 =?utf-8?B?cG1GYzhBZ3BLTkl5MFNLaHczcVFtYTdlYTlUUXFJeUZEUzhzR2ppUGMwUHFP?=
 =?utf-8?B?NHVPNTZmLzRWM3ducHJvWHA1R1VodkFTRFFyVjJuSFJiUG15Z1c5M21zU2JV?=
 =?utf-8?B?TGw1QWQ1aFRaanZ4Z3ZSUTVkK2ZBREFYbC84SkFWV0ZoQk14NnlRbUc4NzFq?=
 =?utf-8?B?K1JZUE02Vm5uWXJ5bGlsTVpJM2NERVlWbUdwTlZ2em43eHMycU45U2MvaXhI?=
 =?utf-8?B?ekhuUjY5ZUhiYzlaN2p2MTNJS1ZHYVJ2MTQ4WUZKWXVoRWxuOEN3VmpvK01O?=
 =?utf-8?Q?KcarsP8IpfBdQp6xgI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1556b6e-5dc5-488e-1614-08df2b63f46f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:00:41.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzEvjKFIVXhxSa8xPu+r7KCTGdlvSBEOHr3CxXyYGhFScLeK7NRc+8MhVaCqIzx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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

On 10/16/26 05:03, Zhang, Jesse(Jie) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, October 15, 2026 6:38 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
>> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Soltani,
>> Shahyan <Shahyan.Soltani@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu/userq: map the seq64 memory when
>> restoring user queues
>>
>> On 10/15/26 09:19, Jesse Zhang wrote:
>>> Since the seq64 mapping of a VM only gets its page tables updated by
>>> the CS ioctl, a process which only uses user queues never has its
>>> seq64 memory mapped. USERQ_WAIT hands out the seq64 address of user
>>> queue fences for the GPU to wait on, so a queue waiting for an earlier
>>> job faults on it and hangs.
>>>
>>> A GFX user queue waiting with FENCE_WAIT_MULTI for the already
>>> signaled fence of its previous job (va 0xffffffffffc00000 from
>>> USERQ_WAIT) never gets past the wait:
>>>
>>>   amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:8
>> pasid:13)
>>>   amdgpu 0000:03:00.0:       Faulty UTCL2 client ID: CPG (0x6)
>>>
>>> Update the seq64 mapping where the user queues get their VM restored,
>>> which also happens before the first queue of a file is mapped, once
>>> the page tables are validated again, and wait for it like for the
>>> other page table updates. Only do it when the PTEs aren't there yet or
>>> were cleared, so that restoring after every eviction doesn't write them again.
>>>
>>> Fixes: ae05e3f3d02b ("drm/amdgpu: move amdgpu_vm_bo_update() call
>> into
>>> correct location")
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>
>> The seq64 mapping should just be a normal individual BO mapping, so the
>> extra handling here should be superflous.
>>
>> My educated guess is that this is already fixed fix the patch
>> "drm/amdgpu/userq: actually validate userq BOs" from Benjamin Cheng from
>> a few days ago.
>>
>> Please make sure that you have this patch and re-test if that issue still happens
>> or if we are missing something else.
> Hi Christian,
> Benjamin’s patch, ea9be90a5558 (“drm/amdgpu/userq: actually validate userq BOs”), is already included in the source base for this patch.
> 
> The gap I see is that the seq64 BO is pinned in GTT and its bo_va remains on individual.idle.
> amdgpu_seq64_map() adds the mapping to bo_va->invalids, but amdgpu_vm_bo_insert_map() only moves always-valid BOs to needs_update.

Oh, that is completely broken!

With user queues amdgpu_vm_bo_insert_map() needs to do this for all BOs, not just for the always-valid ones.

That probably also explains issues we have seen after VRAM eviction and/or suspend/resume.

Good catch we need to fix that instead.

Regards,
Christian.


> Benjamin’s patch only looks at the individual evicted list. so it does not pick up this case.
> 
> Thanks
> Jesse
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19
>> +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 4dca1ab48410..94b9e6890f91 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1070,6 +1070,12 @@
>> amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr
>> *uq_mgr)
>>>             if (unlikely(ret))
>>>                     goto unlock_all;
>>>
>>> +           /* The pinned seq64 BO only needs a slot for the rearm */
>>> +           ret = drm_exec_prepare_obj(&exec, &adev->seq64.sbo-
>>> tbo.base, 1);
>>> +           drm_exec_retry_on_contention(&exec);
>>> +           if (unlikely(ret))
>>> +                   goto unlock_all;
>>> +
>>>             /* This validates PDs, PTs and per VM BOs */
>>>             ret = amdgpu_vm_validate(adev, vm, NULL,
>>>                                      amdgpu_userq_validate_vm,
>>> @@ -1140,6 +1146,18 @@
>> amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr
>> *uq_mgr)
>>>     if (ret)
>>>             goto unlock_all;
>>>
>>> +   /*
>>> +    * The seq64 mapping is kept up to date by the CS path only, but the
>>> +    * queues wait for user queue fences through their seq64 address. Its
>>> +    * PTEs only need writing when they aren't there yet or were cleared,
>>> +    * e.g. by amdgpu_vm_handle_moved() after a VRAM loss.
>>> +    */
>>> +   if (!list_empty(&fpriv->seq64_va->invalids) || fpriv->seq64_va-
>>> cleared) {
>>> +           ret = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
>>> +           if (ret)
>>> +                   goto unlock_all;
>>> +   }
>>> +
>>>     key = 0;
>>>     /* Validate User Ptr BOs */
>>>     list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
>>> @@ -1203,6 +1221,7 @@
>> amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr
>> *uq_mgr)
>>>      * it explicitly (as the CS path syncs it) before restarting queues.
>>>      */
>>>     dma_fence_wait(fpriv->prt_va->last_pt_update, false);
>>> +   dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
>>>     dma_fence_wait(vm->last_update, false);
>>>
>>>     xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
> 

