Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6105FED2F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 09:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2824D10E9AF;
	Thu, 12 Mar 2026 09:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SmPft79c";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F1210E9BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm8/Sl9Sil6UwBhND4c5nVW07ctovmzo8N0BLTZmUYTocGnOMUGXx/VsJYe8RutjmvKQEeGg0rYQgv1vdp4hbD+5cVCAV4LLNMj69AE3PRnRA/4OApjfOfPPJo7GeJlDT1WTMU+vODC7G62pIZx2zaZ7Gz9SLf/J8cCugrBDDuyP9GocLIv8J7oY4PgXusHXApUHDxF9zXK9OW7oaC2wqhlETFOp8GJtmzn4V5kHhGXmsSXMUeC5GwpR/g+sXy40MjRYrAb5MgSZA4HarqDwQ4/RnTAJhPeIsACPe+cN07zGceYiuMFJqgQxH59uR0nxvnpkrUnCotEehri7nNG4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e26HyjzBLhr5/pFrsTDzPqOtd0s+VqPcvOVlIix9qDA=;
 b=SF0ixCQ/vKax1uKR7MvSGffDKHApQwVUJm2Pt4gF5zusnDIxJXrWORPrOwJnLhADw9rueSL70UHyZFZvzb5LGXYyc0K/28KxhRXCrmx/HaKMDUN7S6VFn6WT0nm5Vbd2ypavK3uobK6ERTpse6oCu1WC+iVUGHabh53JSxbusDVuKaGz15KdgYLkUvwD6jsSovbqptzlkoVRbb19OGHiuH47fC3HHIGh6/ADFOqKAT99/3kSVKXe9GmnZIKMU/YxP0UzTz2mNVjDk5U315Z9NL6g5W/IuVYyfUHGYlgbUzNCuH0o5ZvTSDopsZmJ82RnwLb+sE7EAD61cfhdSZKcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e26HyjzBLhr5/pFrsTDzPqOtd0s+VqPcvOVlIix9qDA=;
 b=SmPft79cbXIB6K51YRKFifWj3iIgiE4yHzWbIcb8ROQmlJDZqnc4z6pP0lRHRmJvGEI3c7wVWMFRa/AW60PPQiui3zB0lI0dvoKrHHJZRoUEQy/LbzCWHuPF2yCmq6zNrwdlSNvanzyo+C26NXOue8VTCmfkaoIZhTWPMEaieHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 09:31:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:31:11 +0000
Message-ID: <0c94049a-1743-4e93-831a-5bcb5b43aa89@amd.com>
Date: Thu, 12 Mar 2026 10:31:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
 <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
 <DM4PR12MB5152B6F41902A41DAF0364B0E344A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <893e3235-b291-45c7-8644-913e22b432ce@amd.com>
 <BL1PR12MB51440DF0B4763FACFFFE9045E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB51440DF0B4763FACFFFE9045E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:408:fb::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: c87e8459-fe41-4abd-8593-08de801a18db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: pJEt8HJS5CnokevWRTjo0yn2hpm488XIOJ8b5MuxJzAr+DEPiEhtHGyOKwAbwRj9/EZhz4YP7DBu83iT2TIWN8nzkgwoEKR9LTDoUHwu147RbQqi5+RWRX8xJYbcouUqeCpNuiLLHKfmdg209IJJbgKt6yE18yySPNbbcactSvATmhOjdi90PUIDWRgBgNQIN1o45Use4XUwVG3RxM1WYEUlm20wCagipY+pvEEQ2ibRNzdIHualQ+5p94D6ZujJWqWOHLT8xyzcRYnRwytCUZ5lNjU2B4dftF2wXa4D9Z2sczNs12/17o/js+K4Dxg+i4U5h9SjG/GroyMjXr+B2uFJ8d+MDf8rSwyVMbkac7V4u8Rtv354xjkVsZEqyeNmdkcyk9sGPRNnT5n5u/bBWfoZEEOgTCatDcN3fwMG2PS5dDRDSCTPtF7HqwyeEf5LU2MdnJs3ag+15P8aLELWR/VDEGaslj/tVVq5LBpBRI4diPOaM6S15jsOcsgIk6NyuGf67+PdOFlq9rVyUR0ycTnqlxpVCWdecPsUAu+BmCgaAq6O8gWuJ68BkHlhjZ/TjLCGXl+xeqotruvGN7wdP0O0PEye6SUBor896k0Firpi5z79tPTMitlU/OnLFRm3htTMKeKHSnDHrJRqOZj/ydK1xy+QC+pGqEZuS+qC1MxxVPb5i+T+54r1h4R2i6X8M+G3gxy8zj9dhw3vRlfB1b0nifuP0xUVDUG/JmEbqSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWkzYnIvOTJtNk9vM0hyRmtwNEtGclJYRzVJL2toMkZQSlhFelBNdVkzZnVS?=
 =?utf-8?B?YnBwMk4rUS9INzB4Qm9JTEtaVDROa0pXbHVPSFI5UGRET0cvN3pDTjduVUty?=
 =?utf-8?B?UkkxVmVleW5DSGdoVjRmazVuZXNUUWJwQStHakR1cm5zWkZoU3lwSld2SVFr?=
 =?utf-8?B?c082dFJhODdQUm0xUm9zOFVjTExYZFNuRFBFUVlWWXMrM29GZk9zNlJwdll2?=
 =?utf-8?B?S0FJd1BlYk85VEFwaVptRTdoSWw3YklBdnVOWW5DeUFRRjlMci9WZDFxd0wx?=
 =?utf-8?B?UmxOQWYveWZITnQ5NVl2aXY3RS9RUW9Ham5ITjE2dHdNalRQd01LazRFOWZ5?=
 =?utf-8?B?dVVjTGZMTnlVZzhuQ3hITHdvajY1dkVpSXBXTzYrbm16UnhkVWJaUkpDVGdR?=
 =?utf-8?B?U3Ziak85ZlF0dkxpRGJmclhPVmlCS3JaZThHTEU3OWVYVHJ1UzhGb0lSY0l1?=
 =?utf-8?B?LzRwSnora0UvZjJTV0xLcHR5L3JxZUFhaTJDTW94a1ZZR2FNSmFrY1QwQklH?=
 =?utf-8?B?cFczZjhRSnVNalZXVXdEQTc5Mmw2VUo1N2ZoY0grU2RoL3ZiUitTR2ZqQUdn?=
 =?utf-8?B?K2M4SkJyM0VnblFoREZ2V1Q0MHREUE9nMjN5VUh1YVhuRnBKQUZDWDV3ekJM?=
 =?utf-8?B?UUlxcjN5blZOWWtzZmpvelJTalVyVkMxQ0VSTjl5T2xwV3ZUNnE1SCtQbVNs?=
 =?utf-8?B?b1RHdERPeHlrWDF0bStLMktvR01LT0pqcUUxOWlnRlJ0anIxakFmMUpSeTNT?=
 =?utf-8?B?bHg3RHZRYk5qQ013dFRncHhvdXR6WkZlTWlnWlBMNk1VOUpwaVNBMm8zRjJv?=
 =?utf-8?B?Ky83RllhTjZzT2hLTUE2ZmlmOTF1QVBBWXBUT2VXNXdqSGxqOFdQMXlsUFM3?=
 =?utf-8?B?a3AxaFJjMjNDSHFGSEF3UEwyWTcyRlY1NFora3YrS0I2bUpqWElVdmNqdXhE?=
 =?utf-8?B?WWxlekpEWldURXowaTBmdCszU2ZLT0kvYlp4Y0dYeEtjSWgrcnJHbkU0WHRC?=
 =?utf-8?B?QllyMDVkeTY5RnFqUjhNUFZkSHltVXJraW1rcWJKTzcvTDcrbzhOWHNRcEFX?=
 =?utf-8?B?QkgzNTJ4UHlpMXIvbFFydmFuUktQRTAzM1lBaWZlSnJLcWRFWTQ5SmMxL2Rk?=
 =?utf-8?B?cnZSYjVRZFV2OFIrYTdUVDBSS1ptdFF5R0NpbkM3eitjK1VMNHA5VStSWFVO?=
 =?utf-8?B?K0NoNzlyZFNQQ25YdHpQTUt2aTErNEZiL2dXcUhiN1VZTURZOTFVUURwdDc1?=
 =?utf-8?B?Zm82aXVsWGt1QUhSdTh2cDV3ai9pR0dQWjB6NnR5N2hvZ2VQR3dvSktBT2JI?=
 =?utf-8?B?amVvYVVoLytvZHU0MmFSUnNNMDdCUU8vQ0ZYcDVpc29jTG1LcUptMmNQT2hz?=
 =?utf-8?B?dEhic1BUUS9ITWVGSks2ODVXWWRlY3dLUVdjQ09tSGRvTkRmWDdmejJpMzIy?=
 =?utf-8?B?djV5Q1luUm1ONVh3a0xPS0kxZUgxL2IvZlkxSGJDZDhZRXFRWHBhcGFCUUNp?=
 =?utf-8?B?aDZUZEtnNVJjNVljV1hJZ2Q1RG92VGdJK1FHSTJMR0lMTmRsNXRqT1FWV2Rn?=
 =?utf-8?B?NW5LYXNMQW9SczlBalFsY2ZJZHlLU21HY01zK0pCTndDNXhtenRRTlBrQUM0?=
 =?utf-8?B?aFdacGJ4M0kxRW1nVEFoRzN0c0NTaWdWVVV3TkRRM1NKNHZWSlMvRGF1S1Mz?=
 =?utf-8?B?WFVSdkhQLzMyeXBraWlOcFZUR3A2cVI3SzlqQlpKcTFJd1BmNis1dlducmpI?=
 =?utf-8?B?aFR3VnVDRnFVd1UwSUE2dW45OXJ5NEZzN3R2ak9weUtCc1N6andiMkxVV1BI?=
 =?utf-8?B?a01hSzBFL0FrVHM5NDFiQlEvTGZSQjBHa0Ura2ZpQlFXUlIzYkFxZ1BDT1Fm?=
 =?utf-8?B?TnVIRE9Sa0xaNGNZNG5JVzVCOENPTTJHajQ3MWlzKzdVMVdjR2NEUW1BOStZ?=
 =?utf-8?B?aW45NDg3ckY1MDh2NlhUeUpnRndIRzB5VVpaNkkwMmR4a0xxZ1ZKUXRzL0Fa?=
 =?utf-8?B?NnFucHBLU085T1ZmN0tNM0dvaEN4Z2RxUFloOHBOVzc5ZFpqRzNKbURMSlBK?=
 =?utf-8?B?UnM3bHd0bmR0a3oxNjNGT2FpenBMRG5OeE1pcS93N1EzamFvR2RmNlJGWHVh?=
 =?utf-8?B?cmVLaDNXQTZIVWhNUU9DR1F5ZDlIOHdYQ24zV3B4RHN4UXNhdTZFWjB0QWEv?=
 =?utf-8?B?UVBoYmFDUnFpb2J5WERUTGpnNGdZaDB6Q0REL3RXQ0lsRHI4WEtxT3dPNUxJ?=
 =?utf-8?B?WGxxTEhvUTI2aWdSeFJKZlM4cCtXT050T0pLMGhLMitCZDRRZjFjY0I2UjJt?=
 =?utf-8?Q?LVtvoQJbZ0e0hilJDt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87e8459-fe41-4abd-8593-08de801a18db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:31:10.9898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvrI/h+s5uicPXn1j1K3tm3Kgq+7O4TaHc9Eb5+Qwo4YZ0Khhoas2HPDE95aIHnl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

On 3/12/26 10:27, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, March 12, 2026 5:18 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array allocation
>>
>> On 3/12/26 09:33, Zhang, Jesse(Jie) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Thursday, March 12, 2026 4:23 PM
>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array
>>>> allocation
>>>>
>>>> On 3/12/26 09:18, Jesse.Zhang wrote:
>>>>> When allocating memory for a BO list array, the multiplication
>>>>> bo_number * info_size may overflow on 32-bit systems if userspace
>>>>> supplies large values. This could lead to allocating a smaller
>>>>> buffer than expected, followed by a memset or copy_from_user that
>>>>> writes beyond the allocated memory, potentially causing memory
>>>>> corruption or information disclosure.
>>>>>
>>>>> Add an overflow check using check_mul_overflow to detect such cases.
>>>>> Also ensure the resulting allocation size does not exceed INT_MAX,
>>>>> as the subsequent user copy operations may rely on this limit.
>>>>> Return -EINVAL if either condition fails.
>>>>
>>>> That is completely unnecessary, vmemdup_array_user() already does that
>> check.
>>>>
>>>>>
>>>>> A crash log illustrating the issue:
>>>>>
>>>>> [ 2943.053706] RIP: 0010:__kvmalloc_node_noprof+0x5be/0x8a0
>>>>> ...
>>>>> [ 2943.053725] Call Trace:
>>>>> [ 2943.053728] amdgpu_bo_create_list_entry_array+0x42/0x130 [amdgpu]
>>>>> [ 2943.053947] amdgpu_bo_list_ioctl+0x51/0x300 [amdgpu] [
>>>>> 2943.054277]
>>>>> drm_ioctl+0x2cb/0x5a0 [drm] [ 2943.054379] __x64_sys_ioctl+0x9e/0xf0
>>>>>
>>>>> The overflow occurs in the allocation inside
>>>>> amdgpu_bo_create_list_entry_array, leading to a crash in
>>>>> vmemdup_user (via __kvmalloc_node_noprof).
>>>>
>>>> How and on which kernel can you reproduce that?
>>> We are developing some fuzz tests for the unified project.
>>> The tests involve passing different levels of garbage data and ensuring the kernel
>> can handle this data correctly.
>>> This issue can be reproduced on the amd-staging-drm-next branch.
>>
>> Do you have the full backtrace?
> Yes,
> [ 2943.053649] WARNING: mm/slub.c:7152 at __kvmalloc_node_noprof+0x5be/0x8a0, CPU#13: amd_fuzzing/2765

Ah, yes. That problem came up before.

The maximum number of BOs in a BO list should be limited and not the result of the multiplication checked.

The problem is that we couldn't give a good number on the maximum BOs we can have in a BO list.

Regards,
Christian.
