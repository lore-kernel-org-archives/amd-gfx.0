Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5628105F79C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 12:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545E010EBBC;
	Fri, 13 Mar 2026 12:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQP2s8N0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C15310EBBC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 12:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFMuXyssfTXLaoLUQGLTx+59ns0vMyXXEZ/ajo93DfU6v7puIShGULpC5BnG9cbCcdjsNgfOfx7ZlTpqTYCXLJ0HCgaiqLK8HY/2AYNrWHyoWqZFUQp9FucOJakqlbCehYAgu0aTxiBRuya22EF0Ms33TZut4nOg/ZQZx+9KB9ahRgalpRplaApmEjbB+oK/XG8g+ThzN0VAHlVkdZKDN9+FWB5ml50b1FxpkWd8tHG603nSnxPARIqsufTNLEeBkbrwiaavMKnBQjGVcWBCamta6kA0Pbt7yEEjwGiEsmiWgMJzw9MgohMQe8RaxiQR2W3O7l2Xu4WmN1pCLkEVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Z/GXtOvkHCL1REGxNcnbW4L1PYIWSo2SxiApKfPAs=;
 b=v24d0gdF+CQm9eMjjuTRruzvQsG8TbwNK8UramjzXEwCFPC5bCnh+M8Bm5pbdGvPQaNHXmW92ybbHwTqEmcaHlW1C/JUvszK3X7W50iiZWdI0mVgdRaa8D37or2PCNIRMVY184gqoTjILHpGyBu9kGUPM7bVDw4oFzC5hgHS/ZTOTqcGbRPdyA3ciGT0dgq1DNzx7EJjPcNsOJAUjbOjsCw8lc9juTfmwQkErt7mGGWJVkV/BfaTZnky3I0mqH4wKUbu5aQbzVi2r/riY0H4wVbKh+DSOVvA28Y9StFC2jScXFLk5UV0HAqX2N2NQhXgSEbp7TWM2D+qNVifgVnasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Z/GXtOvkHCL1REGxNcnbW4L1PYIWSo2SxiApKfPAs=;
 b=jQP2s8N0FTxn4TYpmRMBwFGRpFutaXPYZucLUWGvJmu3fYA038Q5sk74sXkgLfqiFoWrO98R4V2P7wBRuCLSgkyvFHcHWQ1fH+hVfF1kA5LjWdIIVKE6/z7J7pSB+s+pO6xD+tqPDUmg68/jHDBsZ+VxX4drpU98egQHQdHZKp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 12:03:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 12:03:37 +0000
Message-ID: <2bce8ba2-c36f-4c64-b54e-aeb964a47ebc@amd.com>
Date: Fri, 13 Mar 2026 13:03:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260304135425.18729-1-alexander.deucher@amd.com>
 <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
 <MN0PR12MB6004C9B59FDA8BDC2F45AD32FB7DA@MN0PR12MB6004.namprd12.prod.outlook.com>
 <541ae425-cd9b-4088-addf-0a212df9dd8e@amd.com>
 <39534a37-ace9-4623-9bce-dee0f7e7fa06@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <39534a37-ace9-4623-9bce-dee0f7e7fa06@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3759ed-7701-4717-7148-08de80f88ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: pkPVT+CpGTwpIiRTqfDlMs8lYhTGl/djy0TK0nUK3Y5LFQ+PhAEC0zQ7kQAFsaK4K2bZ2EShRshhfV/hPVSiOH8Utzzu5opgVIILlB4+weKcZ5v3Hmoqu6o867r2bA5MKSX7ffPfAPmRtPxMzhzF8h0tJDWRGHoWgz41EJr29s6ySYzwuCNYf7KkrO8APgpNhjJZgH5cluTWXlMOS8c+7MRG1c1R5BG+XRv0ig7OhhTDRCjaVHNEHaEqCv60JmNAD/JH1wGGvYcTL6AWaf0Eh9BzmraLWP2tP/bGY4YS9WXDLSLiQePOI4Edi6ejJXjkKAKLKbjEQ8XLl9BFXpH/vMv2z/uf89aFsBcihpQwVT5+lZYIdAcfyRp+0mK3ufWAOnnSIo8+buV/nVG8jRcxgDaD9VYGg2uK2WW63z4D1iBHGfdVnbrG1TW0F/Huamj6N0P9bCImnaVs0gOaXbUOZgX/tHPf5opoCHGJzDZcozA9rFJiBtFUDooj3MEYPKhN/IRxo3/U1tvsG+dTXSPjztGtFjKQqnuJr/Ugl9sALfpHMFG02HMKk9SQdG5Ny+wSAZ8FTo/NRp5G8NYS6rzMJRlMSqicPfEH5ZQ9B3f/jfKr2SulCUq+iEoHBYwgCP9r8mMNJFzgwJC3bxMul8A8IQWMfwIzejlrFEQUdvsr+c01LsEd8aAjMsiYpC53Y1zc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZsWjYvdGo2UXlMYUxBdEthWTd5anhVc1JLSytFbmN6L1RQT0JjQkNPTzJJ?=
 =?utf-8?B?eE1yZ2NHVWo4SUd4SDVoQk51UXVBUWZ4SkFQZnhRdlBEUTYrMjcrWFlWNTdx?=
 =?utf-8?B?eHZHcFJqWWNHbWc0ZTV4WlduYlFXS3E5ME00RmUxcDJJaG9NV05Ka0diMnpQ?=
 =?utf-8?B?M0ZkTzdPN3ZucjhhVmRneWxTMkdXd3RZeU5ucEV0dS9zRWlRUURMNXhUZ3lD?=
 =?utf-8?B?cWdkVzVTUE1EenNSRW5DMXFXNFcrN05NcmVyMm5BWWdIM0dsNkRMSmtOM25V?=
 =?utf-8?B?TzB0VUpwUGFnNXRaZ3l5ZXY0dlVqRTZEb1huQlBzRytyc1NKRjZvcE8zSElF?=
 =?utf-8?B?OVpzY1FGNmdyWWpQMkI2RTVobGo2eUNxV05WSDJpa24wcFBPL1VNL0p6VHlC?=
 =?utf-8?B?eUVRdkY4ZDJ5ZjBMV0p4SkdERndxcGJqWGpSdFZzbmhqQjB0Qzg2c3pnZWxq?=
 =?utf-8?B?Ti9XajkrckVSNk14Njd6b0tEYmdTZmJjVjdFdFFGYkpzakV6cm9xTm9KRDQv?=
 =?utf-8?B?OWVWanJFYkdobEVwWmJxNnJCZjcwUXcwSDZTcVVrb0JOUlBBK213ajhyU1pV?=
 =?utf-8?B?b3FUZGd5ZE41QVhtUzgwaDVSaGlFVURkbU51WTlpdkNiSFBTbHRrbEx1eENi?=
 =?utf-8?B?TUREYXhDTGE4cFB4bUtucFZ3ak53am15VHhqOFpjTUtjRkZjQ3BVNHo5TEFK?=
 =?utf-8?B?N0tleWJmRDNXZjJmZW0rRWE3RUNjTUhmQ3RISE9CSzlMVnNNR1cwSVpYSHJG?=
 =?utf-8?B?VmhhQmF6bFNzcHdyWUVsSUxUdURnRHpLMWlLZlNkdVFZUzFWaG42dUk4cHdx?=
 =?utf-8?B?WDJnbDNKamFDUmYwaGJUaUZlbUtaajRpZXZTNVcyTzNVOG1zWjZ6aTBWdFRy?=
 =?utf-8?B?YVJDZ3pjYkVSZW9Gbms5ODI4eUs0WWN1eUxlU0FNZDFVVTFhZndEdDBZQnJS?=
 =?utf-8?B?UXZnTGxLWFRIeVN1b0MwSHpPNk4xeTh0VGlORG9vOS9mZUFpRG9VcGNxOVJK?=
 =?utf-8?B?YU1lYzdkWFY5OXBJVzNKR003cG03WW9oRDhzdEdxa0ZoczYxNUlXclUvWnh1?=
 =?utf-8?B?dHNsSzZ4Yit1WDhQQ0NKbjJPZVIwWU5UTHdQVWE0MlprN1VqTjR6YmFxeEh4?=
 =?utf-8?B?R3ROZW53MkhKV2Y5N21HWU5xY1RtSUIxbXMrOEYycHJyaWdkMWRLUWJVNDFQ?=
 =?utf-8?B?VVJiTDloRzVkTUJCbFZZWWJrZm9tRnhiVE1qMTdtRUVPL3dVL0Y2QTJoR25E?=
 =?utf-8?B?bWxoRENlQzFGMEVlVHZ3d3AwWnhSSVNxY0RSZS9Tcmg0dTRzQThrb3M0dyt3?=
 =?utf-8?B?UU4rRk1Uem8vcDhXYUYwekJOUWIrMlJBMFJXNThjVjd3Y0c3VTl5cmwxekwz?=
 =?utf-8?B?ZVlaNGc5V01XVEpvNWFMQ2ZzMmJ3OTJwUSszK2xCM3lOWVZ0ZFE5MTNaUGRM?=
 =?utf-8?B?dDI2UmhYbjVEbUNmc2VFNmFHekE4ME1rUlZDdytxMmZrMTB4cU9WQjhLdVJx?=
 =?utf-8?B?ODY1Zkw2SXFmUE5jaVJ1YzMyMkkxT1FlNkt0UUhtdkRkWHRIUmhHUGVvSkJz?=
 =?utf-8?B?UFVoNWVQRjlweWFNTlpLYTI3S1NaeXZUc1AreEZ1N092OEhoblRjRU5LZ1B4?=
 =?utf-8?B?YVB3WDkxbFdxalhhM2QwOHRIUGJWbUtUSkRvY1NxY3lZeVE1NDVvOWpSdmtv?=
 =?utf-8?B?SkFadXQyekY4cEgreG56aVdPTjZpNGtybXlBSHYrV1F4aThTNzNTbXlUcGNt?=
 =?utf-8?B?MC9XYmRBMW50WWtlQk5LazFxSTNpdHh6U2Y3b0J4YUhjelZNdkJ1T2RrdTFB?=
 =?utf-8?B?Ni9La3RseDJwVHJ3MExuRGFGTG5kVkQyNG9DTnVtaDMwS3FVSTVaVThLYnRW?=
 =?utf-8?B?YzVZNTNmeVNmNXQrd3hOemtNM3F1Vndoejh5UkRwNXNmc3VLTnVBaEdmNi9K?=
 =?utf-8?B?b1RoZGFsTTAwN2VCODI5ekNuN2RBTVpGNEVwUzNFU2NDN2xXLzVHRmhUdDZW?=
 =?utf-8?B?dlkrNDc2SEtDQnkzM0s1a3RqNngrQytqMStaRG9CclBjUmUzQjZ3bHpROGxp?=
 =?utf-8?B?Q215RmZCbDNhcW5Nam9JVGVieEFsN245anZZSm9EWXFwNVVrSitvbDNzWkxo?=
 =?utf-8?B?dHlJZ1doN0I1UnpwVmpiNzhwYVMrQUJYVnNnMlduMlFUUFZXUXRsc1FSL1pw?=
 =?utf-8?B?WEE2U3JlYUtkaXlKS1h5ajB3bWY0bUJ1MTlLS0JsSDdvK1FSc0xOYnFiWnM0?=
 =?utf-8?B?NVVWb05IUStLZ0lXVnZCcllEdUVkcnlNS0I3Uk1IWlZPcFVrTnByUHVWS0w1?=
 =?utf-8?Q?4L/V0TrtbHvJ+QqQ/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3759ed-7701-4717-7148-08de80f88ecd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:03:37.1186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR6VMgPvjIJyYbR7s854Bk8Y1o5HR4KkX7228XvEJvfJYgCyn+FBmCVOcjbJ3YdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
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

Yeah, but that is still not the root cause.

Attaching the TLB fence all the time just makes more use of the MES, it doesn't cause any additional problems which wouldn't have been there before.

Regards,
Christian.

On 3/12/26 22:08, Mario Limonciello wrote:
> There is actually a contingent of two people who claim that this patch is the cause for MES resets here:
> 
> https://gitlab.freedesktop.org/drm/amd/-/issues/4749
> 
> 
> On 3/5/2026 3:43 AM, Christian König wrote:
>> The original reporter already mentioned on the ticket that this patch is not the actual cause of the issues.
>>
>> It basically just changes timing to create and eventually wait for the TLB fence to signal.
>>
>> Let's see what the reporter finds with his extended bisect.
>>
>> Regards,
>> Christian.
>>
>> On 3/5/26 07:48, Liang, Prike wrote:
>>> [Public]
>>>
>>> It’s possible that we failed to save and invalidate some active pages during suspend, which then prevents those pages from being restored correctly on resume.
>>>
>>> For now, we still rely on this patch to keep the userq page tables updated and synchronized. Until the full solution is ready, how about we fall back to the initial approach and restrict this TLB flush to only the userq path?
>>>
>>> Regards,
>>>        Prike
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, March 4, 2026 9:57 PM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>>> Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
>>>>
>>>> On 3/4/26 14:54, Alex Deucher wrote:
>>>>> This reverts commit f3854e04b708d73276c4488231a8bd66d30b4671.
>>>>>
>>>>> This causes framebuffer corruption after suspend.
>>>>
>>>> But prevents massive memory corruption with userqueues.
>>>>
>>>> I have strong doubts that this is related to the FB corruption in any way, it will just
>>>> change the timing.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Prike Liang <Prike.Liang@amd.com>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 01fef0e4f4085..25b1d679ba262 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -1073,7 +1073,7 @@ amdgpu_vm_tlb_flush(struct
>>>> amdgpu_vm_update_params *params,
>>>>>      }
>>>>>
>>>>>      /* Prepare a TLB flush fence to be attached to PTs */
>>>>> -   if (!params->unlocked) {
>>>>> +   if (!params->unlocked && vm->is_compute_context) {
>>>>>              amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>>>>
>>>>>              /* Makes sure no PD/PT is freed before the flush */
>>>
>>
>>
> 

