Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440EFCD98F8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 07:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC26110F483;
	Fri, 19 Jun 2026 07:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rpibAPBK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F2110F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 07:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqzecZJvhcVdc0B+12Mlb8dHbyP8zBnlM0MjHFxtNYkycq/d6TVnFeJOUcuILEZKzGhkaB7sTyllu07cVf+fe/iC23jVyT4fjj50FqbYC8A2Ov07oS8A8zIUUqFKFlyVNCrkIyfyRPfIKT268CHLmwuCGFkgx78jmbKlVH5Y/eGR2MJ6PMMsyVUEiueNioaz/Qx0LYnaMa54E+0CGTTOht99jYiJ8+nws2Wqy5v7rhbFZFrpykQSEoPOFY8z4l4yr8xCKAqHds3TYdq12WwwQEtQ8oobn1ct7VV45lDdN11V8Tk6GEjyzNooLpGLRmRXL1a8Mf9m5uvl8MZIgNT3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0qvdpZVHM0pTM9m3Q32RaDy0X2KXljAZYA0NVRD7WE=;
 b=dYROtUXtlCgHl/fNMLVrheJv505JpCZ9eRVOMfrr83QC3NTv2Hd7X9xQsjT0NYHlh/Hk6JDcqzmCKnpYmySXSG5SSgCyli4BGnc5voDg9DTWwGY0QdszvS0nsW+CnFKNosfF/PcU1eGQV0TDlKqxdghDzUIcB2QZ7IG9YchKnm3IbRBVtxgpSr+pPLhQJmStHvgLFlMYqVjiNJAQMxaHyeYkUXP4XB+fUIaZ96hcNhNw9o6ObGrqRsG3HH4CjiUqwcq6ySzoQ15q9LkCCOcbH+h0FjpPJvDzQ7U3FYmagCGr4RqBrzxP32zXdwjCKe/p2EvGqlsIAxyfRKY024MDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0qvdpZVHM0pTM9m3Q32RaDy0X2KXljAZYA0NVRD7WE=;
 b=rpibAPBKsVmIGen7RmFSCtUDLk3z6nP70k8hIJtKKHdjyyBgpKFu4Df2HfGn9bLpBLZ+hBiDdVLBwC3Udq77RvqNW057NcCQkuHeqTjc5byzafflmF6kUijakx4VCIfG8WI+U4Laorwe/bI5lLxA8VN2ZfOg/JB65dixTjpRJpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Fri, 19 Jun 2026 07:33:40 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 07:33:39 +0000
Message-ID: <a7fc627a-f904-42d4-8ada-e6f0da3343c5@amd.com>
Date: Fri, 19 Jun 2026 13:03:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: amdgpu_userq_restore_all return errors on failed
 bo reservation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260618105158.93562-1-lingshan.zhu@amd.com>
 <d2a07581-dae9-45ff-909f-a87795e0b472@amd.com>
 <151c36e3-ead9-42c4-8bc8-1585a7871f38@amd.com>
 <5b36b3f7-f2e2-400f-8ef3-f3d953bb328c@amd.com>
 <73f27315-0b3a-4042-b16e-e49bc005d305@amd.com>
 <bc27cab4-18de-47a0-86bc-4b7fe3ce1de3@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <bc27cab4-18de-47a0-86bc-4b7fe3ce1de3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b94455b-ff70-4d54-8eda-08decdd5144a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: xslIp4/cYMfI4BMlW/m4VCmBN+IP8sccZ9NDdsqyJg4ZBRvU5XWqBz2LleJ4QVHHpQHuwlOH58MyGlUKGUZFyVIocQG4x4IyCJdTnwBbaSBI8YDolA8bw9YZ1ZwPTW7hn3jaqi6aNxoQkChPFOUI4H4UWjiQwxaWfcqaJz9NXHc4ST1PI7xGl5zaRBQD7O6k5mG9Y5EbiDc66nzI503DjRBDfdo6a0AMoFERkhfuDKR4aBh7fL5kDjqv9beZBsNoYoH9COhDnRWfNU9lgGdutD9CywPuhbzusIJA+8OwgbyjDHzL/rge+ysWTE2wcio8MloVE+M+d4v7BfG/38C778gxWscx2OVro3R3JS9TFwqQPZ4YqZYUpGONiYMDV51xLNg7699TAEzzEY++oNR62OD9ODx2huyJjSrDwW8iIpeQ2oeQKmq76D9bylnIm3/d71X2L+NZkY8vqY4bpasia8U+/Hwt+wO3PSNU9CIhjJU1aRDIPzNNro8My5vVFY5zt9uYPiUws/zzBWiase3txuhvxZ+DSfKzQBstcglmZy/wCDVA6iGY43PsYZBYCxgU7o8yQCU8fYinxLzlX1Xi7w398b4az/QDAYntCVa8fv51ekp7ljjki71IzyiwRLSyn8sVUHA1Tp1N+r7vUjjdfePl5Yd+nQK9HTosFO9sWOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEF5eDdIS0NQbDkrQmcyYXdIbEc5RW1HTWpydWltamVURE9RTURIeWY0YjFq?=
 =?utf-8?B?dlpYZCtXckN3bzI4c1lFZjZ0WGdFbTJVU3Bwb29ub3ByakM3YWtwVXJrVlBk?=
 =?utf-8?B?dnNjeGRORXIvanRUVjV5YjRwSEZCeCtLM1lmYWVOdDE2VkhOekJSQWkxamxQ?=
 =?utf-8?B?M3JaSFFXajhXdU03REowcXl3Wk9iTkR4aUJ4cVFaODhqZTBnTDFJVlNRZGJJ?=
 =?utf-8?B?VGl6QUY3cjRpV1F4NUNVRmdJYm02UHg2dTJCQ0hpWU43eDJYQ25SUmJtQlJj?=
 =?utf-8?B?WGdseWsvYzg3Z0pWSVhGdDh1ZFFKakZlVFlzMW1WR2t2bEVmRWg2b2p6OU8y?=
 =?utf-8?B?WS9xalZ5TmJoaXpGdGNFQ09kckFKeXJZS2xmWmxaM0R2VE0yTlB6WXEyaTVP?=
 =?utf-8?B?NUl0ME5QNzlGQ2FEU0FUTnNtWDlncFhUUTdCcVdJZkdsclJlMzltc2Vra3Bk?=
 =?utf-8?B?Mk5YK2Z0Q2tndENJZGxWTCt2SU95TStNSDFwZExWUyswZnlLQ1VVa0pFMUlk?=
 =?utf-8?B?cks5c2VRZGhkQWROM3ZYTWFvS1ZZdW0rWm1vVlk4bFhUcnN0ell6Qno2TUFW?=
 =?utf-8?B?bWpKaksrcjgyN3BQYzBDUTlocTJJSGcwS3lnNnA4bm96VHUxbzJhV2lvMVEx?=
 =?utf-8?B?L2hKTTcwOS9udVJjTk1qcklQY1Z6dHZPdnJoK2Y4Rm9BdmdFRGRwNWpzN3pF?=
 =?utf-8?B?bnZvWmNpMk80T0c1UnYyV3lpRHhZS1ZJQjhjNmx1aXlsUGxrd004YWNpUE80?=
 =?utf-8?B?QnYyYXo0Z2FFQ1BFTWhabWMzN0VDVUd1aE5oQVJNRFI1ZkpXaTcyNXNwWElq?=
 =?utf-8?B?UTgySzgzZ3pYSE0zSklXckl5dzdudEoxWWlCUGZEUkozdmFURFlXWWNGbDdp?=
 =?utf-8?B?YTdaeGRldmMwSENIeFk4WDJkSFozekd3WjBZT3pGbmRzT00xSC9rMTB4QW9z?=
 =?utf-8?B?c3Y0dzNYSGNiZDF1eUFCTFZIL2hiTzJKNXZKaW1NZFFOeVJvdkxPbXRVdGpi?=
 =?utf-8?B?ZXhhOFI5MFg3aDdBcXBTN2s4c1JEWVZEcy9GZG1VTUlTMVdVb2N1U0FaWm9X?=
 =?utf-8?B?dTl4WExsSm8xV0lrc2hRa3BuTFUvNVVYWU1TcjZNbE83WnphMXMwN2NKNjJu?=
 =?utf-8?B?aUJ2MVFPRWVueGhJMTFhdE5xNGpFZ05jWHRLcjNLakJQYy9mdU1KcFc2aDRX?=
 =?utf-8?B?WmpNbmFaZHl0bnllZ0cvcXJHQnpFbHVENUh4Ky8yMEE3T0xseVVqdU1vOFh6?=
 =?utf-8?B?SXU4a3JTc1kwU25OVnorMWpaZXg1cWNkZDYyMGZDNnUyMkVmM3hwQW9LVWZD?=
 =?utf-8?B?Z09PSWVlZkJmVzE0aElEdy9jWDlodmJTblVKUWZwUmV6Z2xZbEtBenRuNFJa?=
 =?utf-8?B?MnZ1ZFlKV2p0bVphR0dzYXRXSy85SDNKTW5xektHUkVrSjlmWlNWbVNNSytF?=
 =?utf-8?B?S25mdmxOTWQ2a1Z1Qk9WNTB2T3Qwb0lwYmtHbCtMRDRJbnUrODJpME5EL1hZ?=
 =?utf-8?B?Ym9TWlkzUEhaYlIxeFpOQzVleXJGdENwWHNvZW5kRHR1VWZnblRPUWVKaTJU?=
 =?utf-8?B?Y2hVODF6cGRya2FHU2RhR3JOZXYyakxpRHRTMVY1WjlCVkV5ZFcrci9YZTAv?=
 =?utf-8?B?bTJ4b216V0pEb2RnWkhVLzhGeC9KKzNiS1JSbTgreUc4WWRGbk43b1VQdUYz?=
 =?utf-8?B?RHRoYThLU2dMU0IvcDF0bXNNTFhXeXFhMWRvWTZjbFNJemtxQ2V6Y0dTanB3?=
 =?utf-8?B?eFNFc2JVdFNWb1ZydGI3RDJOYjFqRkpBT1NPTTZZMUFKTDFrSmg3UEdTVDB2?=
 =?utf-8?B?dTZjK3dQdVNETjF1OGdxMXBTQ1p3QUhJZE5rVmFZYSttWk1vSStMSXYyL2RJ?=
 =?utf-8?B?cVB4MDcxYlE1c2Q2bnBrT1kvbUZrYzNIbkZ5VWVKSzRKRVhVK3dRbkt0QzhX?=
 =?utf-8?B?WGhmc2lWU0FMamF4b1liN3FmR3A0WUdpWk42V0JnbmxxK3BjODhlQWk4R3JZ?=
 =?utf-8?B?cUdxRWRnbXhhanB4NjJhRFNPQ2hMdERHdm5TZ3Z3UGl2dGY3Y1RJaExHTk1p?=
 =?utf-8?B?Szc3eGxzbTcyalFzTE1HLzl5OW00ZVU5RWZhbndwblZIR3MvalQ4eDg1WnJJ?=
 =?utf-8?B?TjU5SUtONzV6Q3BiQjdML0pHOUhoaEdsY29Ba1RwWm1jOHdRL1c3QjZqNHE2?=
 =?utf-8?B?eWc3VlFkMVJIZEg1MVdPZ3VZSS8xVmEyM1gxa05wRHFFK0pIVy85ZXhYajBn?=
 =?utf-8?B?aVlvNzloVDY0cHQweHpzNHQwVHkyUFhnTmxDY2ZKdWpOZ2lmWDhMYlIrNGF5?=
 =?utf-8?B?TllZakFSU1Irb3dqMENRV2NqZHNpaXhPSTNtZEkzRUtPK0J5WXBTUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b94455b-ff70-4d54-8eda-08decdd5144a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 07:33:39.7507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DriXNeC/omJ8rEjcqd3/eDyHTANR2OSUnBYsfor+Kl/piDzrCLlzNbWgP0tzuGMbPD+SpkdDdusiEjyLvJ0IJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
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


On 19-06-2026 12:59 pm, Christian König wrote:
> On 6/19/26 07:51, Khatri, Sunil wrote:
>> On 18-06-2026 06:59 pm, Christian König wrote:
>>> On 6/18/26 15:18, Khatri, Sunil wrote:
>>>> On 18-06-2026 06:12 pm, Christian König wrote:
>>>>> On 6/18/26 12:51, Zhu Lingshan wrote:
>>>>>> In amdgpu_userq_restore_all(), when failed to reserve
>>>>>> a bo, it should return a meaningful error code other than
>>>>>> "false" that means SUCCESS, which is wrong.
>>>>>>
>>>>>> The caller should not ignore the return code of
>>>>>> amdgpu_userq_restore_all as well
>>>>>>
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>>>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> index 95b680fc88c5..8b14870afbf5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>> @@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>   	unsigned long queue_id;
>>>>>>   	int ret = 0, r;
>>>>>>   
>>>>>> -
>>>>>> -	if (amdgpu_bo_reserve(vm->root.bo, false))
>>>>>> -		return false;
>>>>>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>>>>>> +	if (r)
>>>>>> +		return r;
>>>>> Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.
>>>> I think i probably missed that. There is no return value check for amdgpu_userq_restore_all and this cant fail. We should wait uninterruptible here i.e change false->true and drop the if condition.
>>> No, dropping and re-acquiring the lock is a broken approach to begin with.
>>>
>>>>> The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.
>>>>>
>>>>> Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.
>>>> we need to maintain order of locking First reserve root bo and then take mutex else we had mutex deadlocks.... this is why we have added root bo locking first before taking mutex in next line.
>>> As long as we do that in amdgpu_userq_vm_validate() that should be unproblematic. The VM root BO and all other BOs are still locked and acquiring the userq_mutex shouldn't be much of a problem.
>> Are you suggesting to move amdgpu_userq_restore_all inside the amdgpu_userq_vm_validate? Current order is we amdgpu_userq_vm_validate and then amdgpu_userq_restore_all. So if i get it correct, while we have the exec locks just before exec_fini, after amdgpu_evf_mgr_rearm, take mutex and call amdgpu_userq_restore_all?
> Yes, exactly that.

Let me work on that and push another patch set on this.

Regards

Sunil Khatri


>
> Christian.
>
>> Regards
>> Sunil Khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards
>>>>
>>>> Sunil Khatri
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>   
>>>>>>   	mutex_lock(&uq_mgr->userq_mutex);
>>>>>>   	/* Resume all the queues for this process */
>>>>>> @@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>>>>   		goto put_fence;
>>>>>>   	}
>>>>>>   
>>>>>> -	amdgpu_userq_restore_all(uq_mgr);
>>>>>> +	ret = amdgpu_userq_restore_all(uq_mgr);
>>>>>> +	if (ret)
>>>>>> +		drm_file_err(uq_mgr->file, "Failed to restore user queues, ret=%d\n", ret);
>>>>>>   
>>>>>>   put_fence:
>>>>>>   	dma_fence_put(ev_fence);
