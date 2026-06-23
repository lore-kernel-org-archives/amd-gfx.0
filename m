Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F56CD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 12:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DED610EAE5;
	Tue, 23 Jun 2026 12:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MiibIYAT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5C010EAE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 12:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQArsEGfyIHrpism/X5laSFuGgRNPltDk1SX44ve1rboTLg6W3fYzASCP/IderIt7aXPVqKiDGLo2cGYY0ZMBHcnlxZgiiPHo1xRVSw7WKSQ/P+vRxsfCLjW/jzeqd7hqL639fo+OXVSNVwNxFnEj85dxCnBye1umzpeRvk5KsuUoAmGtfCahgrRfJG2br/XkFkgh/NcsjsRLCykFFiAv1yAnGWk9ms1Z5Lph1lxou4RscHgZoan2KvbNY8dd7wkp2yV+IVazzA25+jqI43nP3OyTr5Vo1fDfSmutiA04PIPhaLe6ylyCzQbpSBs+JvxEMEmosvF2PixjVcHZfYb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9OVh1IuD/FrlzR7ZHxk1FCfcvipjAqHN99zM2ToCGk=;
 b=hu2MNccxEpZCfmaNhO5IqdxxEeNlviatzYOoOgfClSCyEnaTV9U/3HsCetrTs5EaDIbEuKAYn7ylq4OWJc+TAPk2iotPTtPpM2aJG/JYotaCHHFVFok2USVs1OgZJJL2XHMs9FTYz7UeuEFT6JdO5ZtHhqQnGMGzOzATFtBFZuzyvYuswYUEkzC62ErcpWXqFgcQbXSR+2dkVIDaVc7Eh1ZZAvtDmH8K8SeSpoV68LwPMKTQXZHsln+JPUWACNA1Cvj3/AuWgsoqCtsJAgS2G3K/y8rYC2mbraV8XdQsJr+UiG/qIQYmDSULF4dTkZ1P/He46EkL04WZRMyMu+Nckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9OVh1IuD/FrlzR7ZHxk1FCfcvipjAqHN99zM2ToCGk=;
 b=MiibIYATfYYuoRBqHQ87b5zGVnlmlPL3o86fikXROQVlo0B1fDwOGZkgsx2NgxKzTKkc3xDCTrbu/JrLsI8UA+AWYfYOXrzVHcRb4cKbn4ee1IjdGPhKKz+aDdXpyyr6xdCA7AZz15/H4pipizq7I4nqtZ1hIqJsDk1MjgS3zjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 12:09:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 12:09:58 +0000
Message-ID: <501c2846-041e-4144-8b51-e796ade6e709@amd.com>
Date: Tue, 23 Jun 2026 14:09:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: Add PASID fpriv lookup manager
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
 <20260623081301.3046023-2-srinivasan.shanmugam@amd.com>
 <5c4c0c82-b2e2-4c42-8515-3de93814b408@amd.com>
 <IA0PR12MB8208E2D6348B44DC32D40EED90EE2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208E2D6348B44DC32D40EED90EE2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: d38701ed-6869-41fd-64f3-08ded1205812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: peU6y3XbPX/4o/PgzVhanFL4gUQ9E2PMD5p8vYU1ATaWWGywakKOBbVdH/6GEHptTcCoBn6W4+5jnopQpqEXLtfdf8ZpGakSVTPn74OmZEJQAZ3z6J3Na9kn4sPC+G6/gDJsGvuk/kUjUYiPqfk1IifXhpTLfLxp4AAEX368c8V51d9z94nycW3+XXrCqBBpFzUj1iV5qIf7rjllv1shsGm+sjfLLi0wcum6KPMZEmANF0qAHpHgsKtrR/khZs5YVynj1ytUMeairItnMVI51fKUpA0nXo3UIsCqHfL1XBBv3T3aEO10s908IkHHJanIRcXx4RKMKd9COrmbbGbdBN0bLql1QaZFCwORKg5OpCnnA2+/V1iBhBXVD/+ZryXzunStlRy5n+z6waQPkN7CLL8ZYmg3xkvt6748l4Thk2YXs+1V2e9omEScf1eNmlAC7qWeuV6mYuf0NYApZWiXFCxkHnyfPWhjUSkWZEq5O/GRFsAq+U6WeUP/POtnsTRuz1HorDPXG515qUcAwXQu5GxPJ7GLurjLtLZnXaS1fdgALZuV6eC5ITyXJ9j5Lq8imBHxoH/To33WceE9mP9HtcZo25jgsvDp7OP+NK50ZgAFRKDDK+mVlyCHepWsJJ0wFwcyhTZgpWLE0X68ol4nJBcz+LjJ1+1OkNrsr0Xbl7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVzVUFqa2VKNFI2YWJWTVBmK1lTbFpVTzc0V2s1dm96cWd3eUE0VmxUSHc1?=
 =?utf-8?B?T3pnN3ZDWVUyeFY5U3E0cG0xRno0Sm15bTRycGx6VWlDTUlDK1F5WTNQQ3R1?=
 =?utf-8?B?aTNXZ3ArWnFicm1mWXVpOCtMMWs3dmNJeS9yNTEzcUNwa1ZUMmhhWFovc05G?=
 =?utf-8?B?QURzRFlMa2NJRnpzSDg2YTU0MG54VDgwMDZVTTJtWXVIdTgzdGluS1ExelhH?=
 =?utf-8?B?UlE4a2dsNTNrd01QMEpXZDA3WDBobmVRQ3RySlp6N3dWZFViQkJqOThYWGVT?=
 =?utf-8?B?cXFER00rUEJmV3JlbmFndGdicUMzSGZkcDVyYk8xdHlaclpPRklmQUo3dWRC?=
 =?utf-8?B?SlJRbThMcHBXaDlnZGl1S2Q0akdSaXZKYlR3YXhBSDAwaUVIL0cxTjlBUVdJ?=
 =?utf-8?B?TmNEU2ZOZnBrb0hvZ1pNYW5zSlhodFk1YUdZc050d2dRdXlOR1NnNFNrMklH?=
 =?utf-8?B?S1l6RUxVMCszQ2pGdExKWmJrb3NzRitjTDlaM3pPelYyMWprQVVLYlFjNEgx?=
 =?utf-8?B?N0JrZlNJK0JvcHZqYkZ6ZEJ3ZEpzNkRMZGZUWFFTRlhLUUZ6UXBSTHJ5WE5W?=
 =?utf-8?B?cHFSUHIwOFlNUmwzUXNPYTFabHBVQVRRUTYvQ2pVMHlCbVBKbFlWWmFKZ2Zj?=
 =?utf-8?B?MGoxREVaWGM5Ykdhb3gvTUNkQnhyV2JVVlpCYzJxSllOWE9LV1VOUGhwNGly?=
 =?utf-8?B?bURIK0M5b0Q5N0pHck40Yi9KQWk0U1ZFUnhrSlNCelF4VXpXdHFUNWVWS09Y?=
 =?utf-8?B?L09QTE9jQkxZTGJRWmxtb0swVHFPdTJUM3pLeCtSVFEvKy9PbHJ1VXVVYjNE?=
 =?utf-8?B?V3ZLMGwvSlVRczhYT0k3SlpNK0dDYWZ5cmtYMnlEVkgyT043bE9BcjFlMEkx?=
 =?utf-8?B?WU83RkpEK1hiTGRBQWRjV1FYa2ljY0NSSUZ5TW1qT0d0eTJKOVZxNzgzeXpE?=
 =?utf-8?B?dE1LWWhqV2g1SDNTUjlaWkF3SWVWL2puTjUrWjNZQ2VJK1M2WjdYVUltQVNh?=
 =?utf-8?B?TjY3Ym9IVk9ZZk1PeHVqUnpIVjRldHVJK09VVUZaUnVKV0Y1bTkzLzlpS09N?=
 =?utf-8?B?dCtqWXo3VDBWcGVVbTlUQlMwZ0FzQlZyV244Q1RqUVZ1V1ZhSHBFWWtjTTlh?=
 =?utf-8?B?MUJsREZjWU1EeTB2VU82eHlnemc3bXBLcnRMNG41Qm1XQmtER2c0OGxob0ha?=
 =?utf-8?B?eDJrcHZXZjFpU3BHNkl3TWtMRFh2cjRrMmFxdi9TRUFPRFBPNXlhL2hpREhN?=
 =?utf-8?B?RjBRRnUxZGt3Q09uNlJrQ1VZYmpRQlBQUWdFT0hMR2ZkeEtTN2lqSFNkSnNs?=
 =?utf-8?B?alJDbDQ4RXo4MGI4MWppK1lTbnhXSlVRajNmU2c3ZmpLU2p3dmpSVS9HQWNQ?=
 =?utf-8?B?OHJzSThuamxzaEtuTEhlS2lMU28zRHhtUExydmY4RElIRTNKbjd5MzNWVG9q?=
 =?utf-8?B?UWtYSDBQZzFpaFNVNHd0Skl3cEFjN1phMUNDMUJjMTJENVlLOFJnN2x0S0NM?=
 =?utf-8?B?Z1A4RXE5eW42SUNoVUo0bmEyRWdHNVpnTitwMmhSWUVpa3MxSy9SaXZNWGIz?=
 =?utf-8?B?VFVGT0ltZ3RWRmRNeGdodU1rSlFJcXhvVi9NcElMUndJdjVIQitWWFhJNDlx?=
 =?utf-8?B?bjIxNzMrQnU0VjZGY25WallCeVR4andPY24yQno4TVRrYUZodlNkTHJwM3lk?=
 =?utf-8?B?Qm5CMlNZOFdvUGsxd3JFY3AzeVd4NE45R3JSbUpIUEcrSkFTY1hwNzhMN3Jj?=
 =?utf-8?B?TWtJNGR5NWZCaW5HZ0JZV3A2N29WR1pXSlBwVlJkNlduWk1TN0xiSWZzVktE?=
 =?utf-8?B?eXRpa2FGbGxxTC91K2NaTGJ4TFpZKzZibkZicVN0SmxpdzZiM2RjNXJUeHFx?=
 =?utf-8?B?UkV2OHlqeGsxZG5xYjlGcmRxSHRFVlNXd28yYXNSWDhZb0FlUU56M3N0QjVo?=
 =?utf-8?B?NkdwbW04UnVSNTRsOWlBZHMrNkEvSEFHYWJJMnFQTmFiOWVZQlY4eGV5dDVj?=
 =?utf-8?B?SFhaRGtXajVaTWlGZ0UyL0tLUmpBYmxod0NLQ2RDS3c3bmNqanpzVW9veFJR?=
 =?utf-8?B?V2pVak9tbG5jb3BzQ3VvNmZXZnFST1NQRTZUYzM1VEIrWmRhL0RlUkJmenl6?=
 =?utf-8?B?MitUWUxieG1BbDJGQzJ4emhrT1JOcHZ2aEh1VWE3UVdUNHIvMUtsL3ZjZ0N6?=
 =?utf-8?B?UkVidWhob1R4T1RGTDVxenphem9oa2NJM3JPWkZLVTQxc1BDQlNJaHQ3TnJK?=
 =?utf-8?B?b1BHeXY4OGQ0UFRQbVZidmxnOVlueGdEMlJoT0gzb3B2a2x5MVRDL0h2SXd3?=
 =?utf-8?Q?IorUMbnuB8jAMbGT2u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38701ed-6869-41fd-64f3-08ded1205812
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:09:58.2005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImqitQhaYfYs9UxjsqivF4EjS3z4+/MDjejtrqbAEIyM+gXC3kwrG4vKwTVf9Zde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

On 6/23/26 13:32, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, June 23, 2026 2:51 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [RFC PATCH 1/3] drm/amdgpu: Add PASID fpriv lookup manager
>>
>> On 6/23/26 10:12, Srinivasan Shanmugam wrote:
>>> Current VM fault handling resolves PASIDs through VM state:
>>>
>>>     PASID -> VM
>>>
>>> That is sufficient for VM fault handling, but process-scoped event
>>> delivery paths need a different semantic mapping:
>>>
>>>     PASID -> amdgpu_fpriv
>>>
>>> Although both mappings are indexed by PASID, they serve different
>>> purposes:
>>>
>>>     vm_manager.pasids
>>>             PASID -> VM fault handling
>>>
>>>     vm_manager.pasid_fprivs
>>>             PASID -> process-scoped DRM file-private owner
>>>
>>> Add a PASID fpriv xarray beside the existing PASID to VM xarray.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 13 +++++++++++++
>>>  2 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 450bd9dc6bc0..3141ae1383b0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2869,6 +2869,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device
>>> *adev)  #endif
>>>
>>>     xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>>> +   xa_init_flags(&adev->vm_manager.pasid_fprivs,
>>> +                 XA_FLAGS_LOCK_IRQ);
>>
>> I think we should completely remove &adev->vm_manager.pasids.
>>
>> Take a look at amdgpu_pasid_alloc(), we already store the PASIDs in the global
>> amdgpu_pasid_xa xarray.
>>
>> But instead of a real value we just give xa_mk_value(0) as dummy for the entry.
>>
>> I think we can re-use that array to store pasid->fpriv mapping. It just needs proper
>> locking and interface to retrive the fpriv for a pasid (while holding the XA lock
>> irqsave).
>>
>> Let me know when you have more questions.
> 
> Thanks!.
> 
> Just to be sure, few clarifications please:
> 
> 1. Should amdgpu_pasid_xa become the single PASID ownership table,
>    replacing adev->vm_manager.pasids?

Yes, exactly that was my thinking.

> 
> 2. For DRM PASIDs, should amdgpu_pasid_alloc() continue inserting the
>    dummy xa_mk_value(0), and should amdgpu_driver_open_kms() replace that
>    entry with fpriv after fpriv setup?

What do you mean? amdgpu_pasid_alloc() is called from amdgpu_driver_open_kms().

> 
> 3. For existing VM fault users, should the lookup path become:
> 
>         PASID -> fpriv -> vm
> 
>    using &fpriv->vm while holding the amdgpu_pasid_xa lock irqsave?

Yes, exactly that. It is a bit tricky since we need to dance with the VM root BO refcount and unlocking/relocking etc..

But I think that should be doable.

> 
> I will rework the RFC to use amdgpu_pasid_xa and remove the new vm_manager.pasid_fprivs xarray.

Thanks,
Christian.

> 
> Best regards,
> Srini
> 
>>
>> Regards,
>> Christian.
>>

