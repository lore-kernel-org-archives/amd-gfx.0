Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCECFED2F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 09:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7D610E9A1;
	Thu, 12 Mar 2026 09:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TtUvdSov";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DB010E3E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhNahMxxIxm60Rcun92HWhYsnAlgd1CW5YKuZ474UgjzujQzFlx0Sm09Rx4ho3rJj1xywqr+J9OvJKpO7eA9rQNpbjc+02ItjqSdzp7jUglOhF3Aw7FId2vvoDuN4IZk70WcZix1XChbaUCnMSdic1bbvguYS8uPckP04emjnSyJqkovSHxspIYrm1celmzchky2buhsw4Puuhiq2yMuMsAHvy/uPDtBihKpTGf1n2Ue6NiCov3wze1ZkRidGywXwauyvBS8ZBLFuAGVXwsJoyRKjzwfl2sakqfUZya78SoGkYNmTAYEavoqIlM93PVjam/hgLNQY0jzkAWPH9uToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH4y/EAiDfmcS4PBc/zg1IpAiligmEGN7b/2XbMLirI=;
 b=NpWm+EDsCAG/+BtC5ztU1Jt2aUJgKfF22axeT3pI5DShBI6FrP9pCw+R1T2Un4TklHOaza4RJJ01n2RM5UEYISPWTrW8xPD8tDSMYf0MAN8XHAB/hiiRQY05UrtMJaunsJbidA9wykxx/A6FQBRRVWfUtyluD0Mi1LgKFK59J2DZHizeoQ1FkHNnOWfKVlrAXyrQp8965dLPoDHCUqME4PSXPGc43k6dhLPRfTv8tP9ftJ9X4Q8EYFhnAAgERCJPrkzYY5arnao29oQyN0JHMHgI5P274WZGQN+hruLNtZ9JUgtlqPwaWhQ5z5Ht0jibR7esldZJGXaps3SMLYbkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH4y/EAiDfmcS4PBc/zg1IpAiligmEGN7b/2XbMLirI=;
 b=TtUvdSovlUF1rfQB1YbpMi61JuNAIgkbJOB3MzD5jSmxvNPvpiMNmUiem8Fp6fYWe4mcW52t6dweTkkbFwHr6Lz+RMQVk8wyE1AEEmk/ctA6kG/QjrNaU+m0RzdhzF5T8FtkBuJ+yScQmoSaOKPcUCEXBEQhp0sOe1WTHFtZOSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Thu, 12 Mar 2026 09:49:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:49:36 +0000
Message-ID: <2bb6b6df-7332-42a8-9db9-26decd4ee298@amd.com>
Date: Thu, 12 Mar 2026 10:49:32 +0100
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
 <0c94049a-1743-4e93-831a-5bcb5b43aa89@amd.com>
 <BL1PR12MB5144221F15AC59541C403161E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB5144221F15AC59541C403161E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:408:ee::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: e506539a-6584-4390-58ee-08de801cac02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: /kritcWAwlzEfT+QwQnbmwRKb5GM/T8XdRKNZJRui0oN8+TQHZc3wtvedfakP4cRscugEoIIVEJsKzA8cNJFEFCe5DJIgklkOxFpxBF1EbzX0fNS9M8qyaH8ruFprntmHk/lIbNW/t1nH22WmvoscaL4PkGwfK2XDZYEj/waLhLWrleWI8KIlKsxqF1KshCGQyzshoD71wJTXJN4LXtczFDJSNIcXKyyFVd6QSq7MBbUIoZeuytX47cCFIuG4yJaijU4QskDmRk7BtVgc2KhaDrkONgO3GFSv8SR6W7o15yl+sJGzbhQw2PDyid0A0Av97cVdMErxYtjPeXiBx7w6Ccv2069WkxFLqfZzXIiyc3QcP6O9hRR42PuBT0ud1d+bkB8LZIYWdjQlcxWzCAPvNF9f30WopqOUqswmTFyqSMdGEbhD/Hjr2x9/PpONxvoHZ8RnVL820RleN6JXoUnJXZ47g/7mQWO/dCXAp/jm9Li2Hjfv74i+1sN20+84FPsSHLg+b4lIswMvMjTM1sAGi6TEpBy18YoEKzb1mlzpBPOOXF62a1Ol7J178RH5TkQHZ+xB0QbMsLJ2TCjTEh1a9QLvU4VdNPmOstZXuMs5+8LMNCbilpmzyv3Ug0vw4M9UQSQBch8yeA2uWgTmEEaqeVTUuazhWMLawTMChUYrRnY5QJ+cPyubzzW8Z8IuSLm1OHI7+vyZoR6SnT1OSzpFpOTMpD/XYDZtsPB3y0aD0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZpM3gwL1N0dVdCcXpoOWJsdkJ2QWJ4WHErdCt4KzRNSXpNd2JhMDV5aXVk?=
 =?utf-8?B?b1VjdXpYekNNajl2Q0lmV1JzeXhWSkc0c2x2OVZVcFp0ODkrK2ZuTFJrRHRp?=
 =?utf-8?B?b0RhZzJ5Y3dwaG41M0RIUWZ6aHVvV0NUYytKVHQ1L2ZNME5NeHFpd3BjcUs4?=
 =?utf-8?B?MFljVEh2Uk5iYUV0Mm1RM0hONU1QbWcxLzNOZmxUSzNUTHFZZDZmaHMvcFFP?=
 =?utf-8?B?L0VBZ0NzMWlvSmlOS2daNDFuTHRUdW8xTW5qRDg0WnVRZWhxVmVkYmpxaGpR?=
 =?utf-8?B?bnQxMTNtenJsUUVBdkU5V2F1RXBMVXNnWWtaMlh1Sm13RXVHMXJsY3hYQjRv?=
 =?utf-8?B?WFhWUmZ1ZXgyN2V2dUJQdEE0UmxUb0t2d0F6MUk2QlZpc2JLN3JSeDhBd2lO?=
 =?utf-8?B?VUZFdFhsZllRbUpCWVllbHZSOFpvTldXeDMvMXRZbkpGWnNRNWV5V0pwNWV0?=
 =?utf-8?B?L2hVUkZiMGVOd3BManRwRUo5S3JlbEVwSjVhdVZNNm1PZUxkMzE3L216NnZI?=
 =?utf-8?B?cGxWbDI0bXRGdm9sWDNLczN0WnJucEhBQm5qaFpoQ2kzVWpUbWNkUUVlaFpM?=
 =?utf-8?B?WXNpOFY2ZXp3aHZPUXo4WEF1bjZEbHFhMEwwN0ZTYlowZHRMWVg5Vi9HMGZs?=
 =?utf-8?B?Rlpjak9hb2xuZ0VyQzFjeDc0emZSZ3BhNEg1Mi9jeUFJaDI5a2hFT3liaWlN?=
 =?utf-8?B?VGRmSExSa2RNWUMrbTIxRysxM0owQm1iU3pONEZFQ2gvOFV3STJmMFFubDl2?=
 =?utf-8?B?T2FWNnZpeWUwdzZIbStjM2t2K2JaUWRLSTJqcGFMa2NIMCtMN1psKzR3L3Nu?=
 =?utf-8?B?dGRrWlVNSmdta0lISHFUb0dnQ1dITHdJcFVzN1NRY2xqWjFCazFSYmV6ZnRJ?=
 =?utf-8?B?RDE0MDVGRGpRRWYzZXpGcFpLYWNZb3EvU2l4ODltdFNxRlhRTDJHK3QxRHVB?=
 =?utf-8?B?TTdwMXBSd3U2UCt1UjhrWFlYekQycVJaa1RQWFZMbVMxWjE4M2RqVS9oRWJP?=
 =?utf-8?B?aEhkNWtSNkRGWjlra2xRT0oySEg5VTc4VUhDVGl6dy9yNFVTRFgvd3ZRdTRG?=
 =?utf-8?B?d0UycFE5MnNqSFVNZWptVlEwZ0FZMGpGTWVsZS9mU1JOMmpsOVc3eDNZQTJm?=
 =?utf-8?B?Nk91cFlOY05jSnUzNUlEdW55Q1pFSHpKdkNPeXdFc0dIYVlWcmJJYUtzZE1z?=
 =?utf-8?B?NlpLNXNsSG9QMjhkOE0xQVU3dWhXQVZPRVk5S1ZmOEg4WVNVNklMcVJPQy9l?=
 =?utf-8?B?NmtXb0J5Q0JQanllUFVCcU5XQ1hGKy9MK29uT1hKa2dzYS9uWDlGejhtci9E?=
 =?utf-8?B?Z0ZpbEFlT25JOGhES1hRcjZTTE1iNnR2cVlMVytJcW1hQm1NWVFXb2thcjBz?=
 =?utf-8?B?b1krMUN2ZzczWC9kOHlDUm42OEcrU0RYcHE4Myt5ZGJobzBRN054SnN3L0My?=
 =?utf-8?B?cmZGYkFjODdvUC9kUzNYZVp3WHl1b1c0T05pQmZJdlMyKzN3ZXI0ZndoMEF0?=
 =?utf-8?B?ZTBOOTJFOU9YNkFLWVVqQzR0ZHEyNHZTbHcyTDlwZHhYcGRKbHlKS0ZEbTJu?=
 =?utf-8?B?MGUvcFUrTlN6L0E5RW92ZGlSYVhXQ1hua2h1L3l1elEwdlJvSjY1anUzRHdt?=
 =?utf-8?B?YmVCTXlHVm5MMlY1akdhbzRnL1VFLy9yRE9yUDBJKzZPTTRtTWYyQXFZbzcx?=
 =?utf-8?B?azBqMFhQckIyM2J5eXFqeGtwVXJXSHFVTUZQMlJWYXRad3BKa2d0TFU1U0lL?=
 =?utf-8?B?MzFCMXl4QVVraXlESFU3ZXZuVEpIdURVTWh5ajJuTSt4VmQ3MXVCNlRKK2Vu?=
 =?utf-8?B?aGJqWTNDOWdOSnBvaTRZSmIyMDNzUEdZYlFuRW8wazlDSER2d1N2WEdzWnAx?=
 =?utf-8?B?UGdSS1A1SVJvdXhxQzdUOUlramxNR2lPQ2ttVmI3YjBLbDBvbW1CTmIzdVlV?=
 =?utf-8?B?T3ZWNmRqbTZSdEloMU5lbDJ4OFozeExrbVVNM24zbXJwYzdiNGg0RThrdVJt?=
 =?utf-8?B?ekxmeUtVbFhvdDRyUURrQnZVRkpnc2Y1dWtGWXhmTGVhZ081YmNQY2Fad2cy?=
 =?utf-8?B?WU1KOTNsVEFpSFRkZkpTVWhQLzZPSE5rQXZ2U0dwcjg3SEw1OGs2SXRPZHBS?=
 =?utf-8?B?Y050Nkttbjg2bVhha29Qa1BMSGtWNTRFc3BycnhWSTZUeTlHTnFObGt3YXdU?=
 =?utf-8?B?UFdIM0UrZ0RGc1JuNFh4Qm5ZYWI5aVd5Yk5LS29ZOTJHcnR2WGFYTWtDYklD?=
 =?utf-8?B?ZTN0VkQ2L1lZelE0WTRWUE1OcjN0MXdSc3RaMFZVQ1ZRSWZLd0lBd2YrM0ty?=
 =?utf-8?Q?TodT3EMVXbsJSuDESj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e506539a-6584-4390-58ee-08de801cac02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:49:36.7727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zlb64b+QPSILxFAuTrDkOKAnlfSe0m2Gv/gOQ7E4h/iSxDnTgJwwnbk6EUgC6uiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

On 3/12/26 10:48, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, March 12, 2026 5:31 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array allocation
>>
>> On 3/12/26 10:27, Zhang, Jesse(Jie) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Thursday, March 12, 2026 5:18 PM
>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array
>>>> allocation
>>>>
>>>> On 3/12/26 09:33, Zhang, Jesse(Jie) wrote:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Thursday, March 12, 2026 4:23 PM
>>>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list
>>>>>> array allocation
>>>>>>
>>>>>> On 3/12/26 09:18, Jesse.Zhang wrote:
>>>>>>> When allocating memory for a BO list array, the multiplication
>>>>>>> bo_number * info_size may overflow on 32-bit systems if userspace
>>>>>>> supplies large values. This could lead to allocating a smaller
>>>>>>> buffer than expected, followed by a memset or copy_from_user that
>>>>>>> writes beyond the allocated memory, potentially causing memory
>>>>>>> corruption or information disclosure.
>>>>>>>
>>>>>>> Add an overflow check using check_mul_overflow to detect such cases.
>>>>>>> Also ensure the resulting allocation size does not exceed INT_MAX,
>>>>>>> as the subsequent user copy operations may rely on this limit.
>>>>>>> Return -EINVAL if either condition fails.
>>>>>>
>>>>>> That is completely unnecessary, vmemdup_array_user() already does
>>>>>> that
>>>> check.
>>>>>>
>>>>>>>
>>>>>>> A crash log illustrating the issue:
>>>>>>>
>>>>>>> [ 2943.053706] RIP: 0010:__kvmalloc_node_noprof+0x5be/0x8a0
>>>>>>> ...
>>>>>>> [ 2943.053725] Call Trace:
>>>>>>> [ 2943.053728] amdgpu_bo_create_list_entry_array+0x42/0x130
>>>>>>> [amdgpu] [ 2943.053947] amdgpu_bo_list_ioctl+0x51/0x300 [amdgpu] [
>>>>>>> 2943.054277]
>>>>>>> drm_ioctl+0x2cb/0x5a0 [drm] [ 2943.054379]
>>>>>>> __x64_sys_ioctl+0x9e/0xf0
>>>>>>>
>>>>>>> The overflow occurs in the allocation inside
>>>>>>> amdgpu_bo_create_list_entry_array, leading to a crash in
>>>>>>> vmemdup_user (via __kvmalloc_node_noprof).
>>>>>>
>>>>>> How and on which kernel can you reproduce that?
>>>>> We are developing some fuzz tests for the unified project.
>>>>> The tests involve passing different levels of garbage data and
>>>>> ensuring the kernel
>>>> can handle this data correctly.
>>>>> This issue can be reproduced on the amd-staging-drm-next branch.
>>>>
>>>> Do you have the full backtrace?
>>> Yes,
>>> [ 2943.053649] WARNING: mm/slub.c:7152 at
>>> __kvmalloc_node_noprof+0x5be/0x8a0, CPU#13: amd_fuzzing/2765
>>
>> Ah, yes. That problem came up before.
>>
>> The maximum number of BOs in a BO list should be limited and not the result of the
>> multiplication checked.
>>
>> The problem is that we couldn't give a good number on the maximum BOs we can
>> have in a BO list.
> Thanks Chritian, agreed. v2 switches from pure multiplication-overflow wording to a BO-count limit. We now bound bo_number by INT_MAX / sizeof(drm_amdgpu_bo_list_entry) before allocation/copy. This keeps behavior deterministic for fuzzed input and avoids warning-prone huge allocation paths

Yeah, but I've rejected that before as well. INT_MAX / sizeof(drm_amdgpu_bo_list_entry) is just not a good maximum limit.

This needs to be a fixed constant.

Regards,
Christian.

> 
> Thanks
> Jesse
> 
>>
>> Regards,
>> Christian.

