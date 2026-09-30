Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8C3CA5FAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 12:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A20B10E789;
	Wed, 30 Sep 2026 12:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dj98tVyn";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7163010E789
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 12:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPEej0Y5xTtKT57bUKdaACLlSEQ/t+1OPYRcgxZvpCbCLWmu9PeeSKAGOivnQ7a0NNmINiyr1yw0S1yxA/0vz/QeDkmhkWdy7WtoDDcWz+VH9JMIdx8E9FDXIl2rcRCL1cPnm2lOHbMoN2gDrv6Me1GNo1wTwmukNg+OzpS6CKQhTGpkklDiRoBYJeYivHpYn4pwbqxBnK8+wpz6pk3VOC5zQ4uZEVvI91/7nGC8S5yYqUGot9LlkT0gidbm3uKCJgxjJz6RmmaYF0MrRHtUosjj8/OiLwSJowIDJEVgn8kNyGAfEXSOSs6qVvOAs3df3xLSs1UgTOVNLsb/hpmhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KFxsN+AC0cec4VcUjnGNWyIxDvsf80ybEQ/rybI6hY=;
 b=k/rKuZnmGl7Snx58tonOR2ohwVxyp4pJK5DiKSkq5NHAE3JKQoXlig+cKVg+64r9sBb6V3234GB7lQCQgGSKQ/zEPqEKN8hJX2bmVAH6gGO34My1Bg779jp5uBdF3OFDM/X0bMuXPsMPmheiWdrmRLQWiz7wxkETAqdirctJ8e4sgFZ6EXFVNWhzqUnEMZOn9nZp06/+5UAIpju4ej80qSq9keYw6CxwyJqUrKSrYgM16VWxNDuOdhQ4Yk4lsuOsPd8xLzxsOacvbO4mC1maDEQRQ/cIPFqauEPoowY5ALHbYgg5LAg43Iml/mC1XLmsq+J1lwJECooKGMpG92410A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KFxsN+AC0cec4VcUjnGNWyIxDvsf80ybEQ/rybI6hY=;
 b=Dj98tVynmQNqKg9XviWBhtIs6TVWgpdzSXSuqe5sYcSUXrPJdv93qnaEKc8r32xAfvyvmLxdUU8Rv+N9VmVP4Xhkb8aQPvXb5iqIylG/sNp5EjhVhDqh90hiUoiqS4TArP8tTkGv2r6aWMxbF/MqQzF3NhcTPBbG1msR01oZXS8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 12:28:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 12:28:35 +0000
Message-ID: <a3edcdbc-f4a0-491b-b66b-04a1a7e6cc4a@amd.com>
Date: Wed, 30 Sep 2026 14:28:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to
 vm_manager
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930111601.3721001-1-sunil.khatri@amd.com>
 <2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com>
 <8939b352-899f-4327-a8ed-26e12e3b6c39@amd.com>
 <0e990a33-7251-4c96-b52d-e87f924eee99@amd.com>
 <36532d93-3880-470b-9b64-38d3b24d0060@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <36532d93-3880-470b-9b64-38d3b24d0060@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 145bfe50-79e1-48af-07cb-08df1eee591a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: DlqwPigYH4Lo2QRDZ+p3j2TsRYg8EtWnYOOahoBixTdgQqWpYoElYpe1vJAbQ49OUEdIVea2IT7Fzg8QSyAUC5XcB6sKU9jrG73SYf+RGzBIQy4BLecJk1qvRV84ryn7vrayMXexsgMFkvLHgf1N6mjps8SIoczUtYsGES+Az9NQOq34ZRaSU8i2T2PCiI1hfpwy+BCEHMMSxZZ2CQrafjQARGA6fhYvrJv70kYIpyAdAYA8127afSXS+3Jbk5ff+EHMbIgbqLHiyIX0EaJtjwhLPGgwKyfERBbauJmcsp3KxHE9BROd4vUy3L9moQ0dYd5qMMfgff6DExYbH7jeYVepYQxYY06ziHrCvHRXi9l2caw1B9d8QYicrio0lfASzg+vfWhIK9lZ4XwUpOdl2MajJFbmi6mxL3EObBjv66In4a5rBAmr5AenyCdVeSak8tHFt8LVxOJERSYt0kMw3sW8OCYDGx+LrEC1mZJj0qnRs3fgjfo1JhKaV2WCUW6V3ofEOnZ8Vp61m+sAbjIQA2uPvVYDCNWxSQ4lE5gjUGXjow2bnsYL1Sy9oy5N0NcuJ+khH4iv3d0qW8ET1mpjFiS3IvPI8eJeUDrWu9Rr84avGkU6FXPj77GZIhzSCzWwboTVc+CyM8UcOAWgfp2JsmENW/7WD16DUn65AxDbU6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkN6eVF1bXJHZTBLQ3dDNENYTjQrNGFremNaajd0QjFjbzBTMzBmQ1p4ZUZY?=
 =?utf-8?B?S05ScGQ4VXlncmVnK0s1WkNjRHFPM056TWYzUkFuSHo3MUJBbWdNWUlaWi9K?=
 =?utf-8?B?dE9aTWIzOFpFeGhHWTN1SXd1Rk1SN0tld3JyQ1JERXJWeGM3d1RBdlNYanRt?=
 =?utf-8?B?ODcva3d6VnJRUmVCdmJCc09QVVZJc0hHaGdtQmROZlRrbmtBQURHTFBVYnBF?=
 =?utf-8?B?V0U4ODNqN0tLRzZ2RUhuZjk0LysrYS9NUzRZUDltVmRSMjlaU2tiTmxiMGdB?=
 =?utf-8?B?WlY5ekNBNldrNTkwVHFTczJvWGtVVUhSRUdsLzdnazVKcmdmaytOZk0wamd1?=
 =?utf-8?B?Zm53TFVuYy94aFFwMG5INkE0eVRyOXZJclNCcHJiMDBwb1RrM0F5WDF4OUJO?=
 =?utf-8?B?dFJ5QmJuOWViM09lcnc0d0ZlWmRyanVqSDFQLzVFdjE0UzFnczhpZXdETmM1?=
 =?utf-8?B?clB5V3ZtUUwvMkVQSXRVRWJ2VWtMczhjd2ZSY3E0citPSWJ1NXl3U2t2Z0da?=
 =?utf-8?B?bXZ6UXVhOSt6cHlESjVsek82MGE3cHNoWkVMTFpobmdSaFlmNHZ2WC9Sd1dy?=
 =?utf-8?B?WGRrTk81NHo1Q0kyQWMrNVYyOFdWOEhoOFp5TFNRcUplbldQVGpBYXVNT3Nw?=
 =?utf-8?B?ZHNnbmNDSmhmRVRuaFdySUh2NnBVMUM4VTErMmk3SUtGcmgxUGdxL0xpa0gv?=
 =?utf-8?B?RmJVZ3ZZZjRBVHRVaHc2ZVdkU1F0MHQxQjRrY0drVDg2aFhLdnA5QlhrVS9K?=
 =?utf-8?B?bHZoa3JabHowQmQzUUVDV29adTVaNERkbTNQZUZFaFBvSVJjaWwzaTNPc0dl?=
 =?utf-8?B?SDZsblJFY2p3OHFURnFLcFlTTEJvMEpyVmdzWENtZGZtTit6ZFdiVjJlZklQ?=
 =?utf-8?B?U0NwL25uekxOcVdFcVFhUUc1S3Z5M1ZUMUpnUUFaSjN1VUlyZGpYckZhVkhG?=
 =?utf-8?B?Z05aeE5uV05IME10bzZrYnNBbU94ZWxnNVBPTHloV0FLMEhvU3I5U29raDF5?=
 =?utf-8?B?bWZjaFB2eE5TcklZOEROeVo0KzdMTys5TVROSC9IMnV1ekxFbHl1Nkg4TGdj?=
 =?utf-8?B?RHlUMDF0b0hXZ0UvaE9RS0t0UVdEVDh5L1VUVCtOeUkxQVlDdkxETUlmNDdB?=
 =?utf-8?B?bHIyUS80RW84NXFQYXV0Y29BakdvZzI4SkYxczkxYVFTQTFhQSthZnJ2OCs1?=
 =?utf-8?B?eHFrc04wR0Z6NHN3OVJtTi82ZDk4T2NROWpWNUhVL05HU3VhSEUwWDZHckFp?=
 =?utf-8?B?OVc5ME5QdTFva011YVFyOWhKSW9nTUJrb3Bra0xXbXRIT3c5RlZNQVJ0VHZI?=
 =?utf-8?B?dDZuTE5kdjNhTG5kdm9sb0M0TE5OQUJyM1E4UFBUQnpuVFFtL1lFR1hoQXY5?=
 =?utf-8?B?RHl0QTJCZVpmZFo0eDExanI4TG1maVJzdmZZTC9GT0xyZFptamNXVEZ5RUdy?=
 =?utf-8?B?NVZ2TytueTQ0NFBEMEV2Nmt6VlVDN3JqRWpFdVpTalFKcUE2U2l2NzR1dmNM?=
 =?utf-8?B?YUF6SHRpL2JWU0VvRFpvRmJWTjRPN3hMVkxsSXdMdFNhWjRqQXlTSDJ5bnFs?=
 =?utf-8?B?a2pNYzNCeVRSTnY5NC9KejlURDFHdjB1UU9QeXloNXI2a3ZnUEEzMEx1b2hF?=
 =?utf-8?B?L0Z5OGxweHUzTWJUWm5CUmNWbDNpVGxKbmdNTzRIK3N5eGxGblhIQW5oTG9w?=
 =?utf-8?B?WFVrTkt6QmVXc3pueDhHZ1pzV3BXU3NuT24wazJJVDVBcGEwYmdjY2RRSHlq?=
 =?utf-8?B?ZXdUdHFKVkFmU3VjUFhpRWlyU0Z5TkhjemdkVHA1c2Z3QktiSjdrYnJjMG9U?=
 =?utf-8?B?bXk4SlA3TmQxMnNEMnZnNU84SXh0VzB4RDl1YksxZ25mVGgwOFlJKzQzZHg0?=
 =?utf-8?B?dkVFeEE2eW9Ya1hHSXNueWxVZi9DMHlWeStmNE1kajFIdTVZL3V6RlAzM1dD?=
 =?utf-8?B?YmdRSFR4b1ZzcnViYnY4ZWtrMnRUOTZPekcwanIvMDlDejlhaXczQ2hvbHVK?=
 =?utf-8?B?alkyUUlSQXU4c053NlZjMER3Rlk2N20xbGZrZngzKzFPUWNYTU9kTlZ1RjRp?=
 =?utf-8?B?emlMc2hQR0tRdGhqSmdveWE1Q0NFNTFlVzB1RmZiSU9tS25sQ05ieFJuRjA3?=
 =?utf-8?B?ZUdHR0tvREdZRjZRVktPNEs0cmpHSldNTDMrZ2ZxUHNIZDVYTmRGdjJUcmFy?=
 =?utf-8?B?WFlNUVdTUEhQTkxydjR2MlRUbFdxclI4aTBXRFd1Y3NCYm44bG1oU09rdU0w?=
 =?utf-8?B?cUkwa01CVnFuSmZ3eFBzSSs4WThZaklPUU82VWQrM2dWQTZDbGFGTURyamRx?=
 =?utf-8?Q?TZUxnYiq00zBMQ60sc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145bfe50-79e1-48af-07cb-08df1eee591a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:28:35.7698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfrmVttx3MTYz9EAkSB0/RZkYhbbpbEwQFgxfZC/AIsj3m/QakrYVb+K9rKIeZFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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



On 9/30/26 13:58, Khatri, Sunil wrote:
> 
> On 30-09-2026 05:11 pm, Christian König wrote:
>> On 9/30/26 13:35, Khatri, Sunil wrote:
>>> On 30-09-2026 05:01 pm, Christian König wrote:
>>>> On 9/30/26 13:16, Sunil Khatri wrote:
>>>>> vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
>>>>> vm_manager than the mes ip struct.
>>>> That's the VMID mask for the user queues, so I would name it vmid_mask_uq_gfxhub/vmid_mask_uq_mmhub.
>>>>
>>>> Apart from that looks good to me.
>>> Noted. Another point here if that is the case then should i change that in MES HW layer too..
>>> unionMESAPI_SET_HW_RESOURCES{
>>>          struct{
>>>                  unionMES_API_HEADER   header;
>>>                  uint32_t               vmid_mask_mmhub;
>>>                  uint32_t               vmid_mask_gfxhub;
>>>
>>> Should i update here too or this is fine ??
>> No, that is fine. The MES handles only user queues here so that is unambious.
>>
>> But thinking more about it, we should also do a bunch of more cleanups.
>>
>> The structure amdgpu_vmid_mgr is really the per VMHUB structure for example.
>>
>> And the vmid_mask in the that structure is really the mask of VMIDs used by kernel queues.
>>
>> We should probably name that structure and the field more appropriate.
>>
>> Regards,
>> Christian.
> 
> That's true.
> But since it is used by both GFXHUB as well as MMHUB so something generic seems ok to me. But we can change vmid_mask -> kernel_vmid_mask. Suggest if you still think to change the amdgpu_vmid_mgr to something else like amdgpu_vmhub_vmid_mgr or amdgpu_kernel_vmid_mgr... but these names seems pretty big.

Just name that amdgpu_vmhub instead.

And using kq and uq as accronyms for kernel and user queues seem pretty staright forward to me.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>>
>>> Regards
>>> Sunil Khatri
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++----
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 4 ++++
>>>>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 ++--
>>>>>   6 files changed, 14 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> index 5285c1d1fd4cb..9c36ccf5d5659 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> @@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>>>       total_vmid_mask = (u32)((1UL << 16) - 1);
>>>>>       reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>>>>>   -    adev->mes.vmid_mask_mmhub = 0xFF00;
>>>>> -    adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>>>> +    adev->vm_manager.vmid_mask_mmhub = 0xFF00;
>>>>> +    adev->vm_manager.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>>>>         num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>>>>>       if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>>>>> @@ -184,8 +184,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>>>         dev_info(adev->dev,
>>>>>                "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
>>>>> -             adev->mes.vmid_mask_mmhub,
>>>>> -             adev->mes.vmid_mask_gfxhub);
>>>>> +             adev->vm_manager.vmid_mask_mmhub,
>>>>> +             adev->vm_manager.vmid_mask_gfxhub);
>>>>>         dev_info(adev->dev,
>>>>>                "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> index 594fb817e0a38..2b13a5b375393 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> @@ -122,8 +122,6 @@ struct amdgpu_mes {
>>>>>       void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
>>>>>       struct amdgpu_irq_src            irq[AMDGPU_MAX_MES_INST_PIPES];
>>>>>   -    uint32_t                        vmid_mask_gfxhub;
>>>>> -    uint32_t                        vmid_mask_mmhub;
>>>>>       uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>>>>>       uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>>>>>       uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 98cdd7e3475fb..5f22c146e2339 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
>>>>>       /* Global registration of recent page fault information */
>>>>>       struct amdgpu_vm_fault_info    fault_info;
>>>>>       unsigned int                npa_vmid;
>>>>> +
>>>>> +    /* VMID masks for GFXHUB and MMHUB */
>>>>> +    uint32_t                        vmid_mask_gfxhub;
>>>>> +    uint32_t                        vmid_mask_mmhub;
>>>>>   };
>>>>>     struct amdgpu_bo_va_mapping;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> index d1cd665ab301c..178ef8dfe6d61 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> @@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>>>>       mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
>>>>>       mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>>>   -    mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>>>> -    mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>>>> +    mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>>>> +    mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>>>       mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>>>       mes_set_hw_res_pkt.paging_vmid = 0;
>>>>>       mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>>> index c0719d8fa63e9..f2dd4323ffd3e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>>> @@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>>>>       mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>>>         if (pipe == AMDGPU_MES_SCHED_PIPE) {
>>>>> -        mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>>>> -        mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>>>> +        mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>>>> +        mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>>>           mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>>>           mes_set_hw_res_pkt.paging_vmid = 0;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>>>> index 20159fb9d6ea3..c3e1f9a746ce0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>>>> @@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>>>>>       mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>>>         if (pipe == AMDGPU_MES_SCHED_PIPE) {
>>>>> -        mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>>>> -        mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>>>> +        mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>>>> +        mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>>>           mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>>>           mes_set_hw_res_pkt.paging_vmid = 0;
>>>>>   

