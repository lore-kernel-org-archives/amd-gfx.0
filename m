Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0FCCD5BD2
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 11:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A9710E624;
	Tue, 26 May 2026 11:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pwRz8tzj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E99610E624
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 11:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Peo29E5hkBPr2DCXd8I5JxgBVYN8WV3jvEhY5Q6jAU3bwmp1mdikfJ1+iX0FjlrE/IxhfI4vj91PTcWKcc/xPDIcBX8j+TIgztMTEfgqcu0jQpUfASWfRYTcwZS5r2ymssE1+ebfs7y1P4QdTcUXgSNQ+BReRv8Bsp272SCh1G4K4BWNoLtzh7TfAoqj5PcY8Wz5KvnhEt6HdS55oKr4RP2clWa+5C9blS8/LC23bEu7Td5mYPJhCINdvDDuDPcIdDiGkCvHrQ6F2/VNYlNLO7PuBQXG+B0RAg6ALM6rFzfgjumaO5W8aGWuG3SokMr1xFiBN1mcn3uQZDBkJgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSE3vetf7OcZ64NyZ5uaDaE6B9VDOPmuIsYXQZKjxr4=;
 b=nPlqHieq9f0wtPB5uYFgWFX01tbxUsiwQHeJZc/1z9FP8X1oOvW8lk7pMzJtsL+IGMV3WUNZAH7vgMFNpnPFUlrTZe2KU1GOlTVWfHiPiBMHHML3/GJbep0hoAzpzEg/P5/qubpNwyMKg9rtvBcymBn42GAT3XECnk/T8Ss9ju187kbkFwPow+8po2R8ltYsgu28AU8AoC0U9QQQvjdaoTvx7aF2t2HRKFKZwrH4H1SbWNv4QqT1uJBn2JQpFHvOuHHvJzCIqNJ95hqXmVsGtt4gxloMaMRnvSr8yLijBdjj362iFg0uswfT5ScP6/RuMG6hFyGvTEQVspSOQBjKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSE3vetf7OcZ64NyZ5uaDaE6B9VDOPmuIsYXQZKjxr4=;
 b=pwRz8tzjzrWL9ucbu2eJzijwWPrRplSqeeSeC8VQaLKJzdlMRLhwk08xOuEsZghqKIkVVBcwimHMIAIHobbLvDZ2ftbx9F/zZxs2eREKdoZGVxdRI3UO2RJ/Szxn0KDjguLg4oYe92PgZe5ovJ++PLyWynbwFmEh3sxo/O/bwPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 11:18:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 11:18:24 +0000
Message-ID: <a69dccf6-f0b6-4b65-ac43-d4354578a9b1@amd.com>
Date: Tue, 26 May 2026 13:18:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: implement per-process MES context
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com
References: <20260525082359.5510-1-lingshan.zhu@amd.com>
 <53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com>
 <591307db-a567-4bac-b995-1eec64a7c42d@amd.com>
 <7f2be916-27ba-47bc-9440-121a9e7d659c@amd.com>
 <3f1b9712-841e-4a2f-984b-a27ccd1d7200@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3f1b9712-841e-4a2f-984b-a27ccd1d7200@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:408:ff::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfb63f5-749b-46ab-ec27-08debb188082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: n3QbLTwYVRf+E8RPRKGTnQnFXkd1FgZLCcUNqGq0eTZtk4gO/2y1qCrVw04PurqEcUAvbmCnpAr2FVB0VRx+FVqk9LbwqGHlp/UU00UMhCamvvQwV+3v9dd7OU/YuQjZPBw0x7+G0SYlOsir/ftBD0Mwtpoe+Y182jxZVj0ujAicu/Ri+BQzw5lbLEUxp7wZMFWzcCAMufH5jZgxmFoA2sF0lzDp45W4hjrHBRv/gOfEcjK3jZjKafpITkwFmRj79WcCaXHKg+bNcEywOrHC/gYfQIoOchJoNMJ+a+MwWqCvF/tGwYd08K9Y3nng0qrqo8dbYruNL9K2lgKpame+PBhGugXrCcpaNnBvtBY1pP5rFh85qBG99eZgukqf/L9dzGapKFog5vqyzxZrrcVh8TzeLKwm46SOfvr04iHnKCMBvuoGI9b9U6QiAhNDDx/Mn+cQqUVDGf9yjgVZSWhI84F8RBWO16kQx0E/GWQwchFJmKjdh1DVQ68dK+H+Ny6xgBOHWSNFGXz7kxbpNg9kztcJeyYk334Nlop5tY2ry0/9PKAnmov0gvNlxXblqeme+sYYQ5eC9FWqd8zaY7MfTId9YJX/cVfGQH7vgx0LkrDnklkSnJdxECz7gzn+7hqfx9knFJs+WWRkcdzWD6zFZgjhox6oJC1inGav6hjPR4jz8Jw+B5DZ0hwVjgPPMSsu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2l0a3Jmb3NRNTlrWkhJS001dHErWHRjTXovSjJyamRZOURYaWxrM2d2ZmUr?=
 =?utf-8?B?NmtaNHh1UGlxMTNvemdndUluVDByY2w1byt5ajhzU0p5OVNpd083S0dYblY5?=
 =?utf-8?B?d3pKS2pNSnJPSjNTZUtJUGg5L29RZnVDZWsvUGNXdjc3OHp3REVpcHJFUHBm?=
 =?utf-8?B?RUx0Mkt6dkwwUmgxRDlJcmZydkVzSlpYTE9BSzY4TXBiTjZUVzV0alQ0SGdB?=
 =?utf-8?B?T0pkVmRFUHlwNjM2V01waGNsWXFqOTFMdlVoL0xrN1JzSDdVTGVkRkVVMDB1?=
 =?utf-8?B?d2tQWGxSMVhGcTJqWGc2U3V0T0V1cmhGdEFkRkZmSmI3bVkvZ082K0pkUytE?=
 =?utf-8?B?dW8zRHRIbU50b3ErRnc1ZS9yRzZEMGphQlNCTEZtYzRqTVVVTHZtaUNlaHg1?=
 =?utf-8?B?ejJFOUhmdjJ3eXpaK3pMSGxRc1dSdDFkNU9DTVl1RVFMNHUwdVh3S25xVXl2?=
 =?utf-8?B?MWFtQkVKdEljQTdodkVpZDRpMktkN2lvc2hkV05scTN0cVlOVmV5YmlxR1hP?=
 =?utf-8?B?dUtoblJkZCtqdXpyRFlvUlh6RG5DQ2xWeGlWTzJNMVRoWjlHa3RlWStmU3hC?=
 =?utf-8?B?c3BsSGV3MVdiZ1gxazFJdUdtK1c2MDdMWHh2eGRCbDlIaVlaaEdEbTczYVNi?=
 =?utf-8?B?VlB5b3BqZTFDVTY4ZnZlemlZenlSU0p0d1NIYSsxaVRoOHpWN1A0YkFaRzdE?=
 =?utf-8?B?RDJDVzRrbTY1R1FOWjZrU0RXZTJ4NHRSWG5BZGdUN0VtWHl3S0dCLzhWNnhY?=
 =?utf-8?B?RFBjTUNVU2E1NGZpNEFleWRNdTZPUlBkODNtaGFPVnlpMWkraTZKOXhvQTNF?=
 =?utf-8?B?NXZqRVlBUkVqWitMY2dyTHlGdlhkR1NDTnhqYmk3SStERTFkUjYyYVpDTTdE?=
 =?utf-8?B?VWZXM1orcjRQSFV0L1A5SDVlUXd3cHFSVEp2OE42MHpPcHUxVWt1WVRMem5M?=
 =?utf-8?B?SzBzYmtKRVUrcnZvOVVKZ1hpZGRqNHEvM3B3T0YrR0FwTWg0N0tHNjVrYnZF?=
 =?utf-8?B?MHFiRGpaazNya3A1dmZxMTJiWU55Z2Q0NENtMFdMRXlBQytQNHphMHJuZ2xX?=
 =?utf-8?B?NDhPZDg3dTVaYTEvamRnUHowdzB6K1B4UXMxOUNTYk50WkZRNEc1Wnpvc2Ns?=
 =?utf-8?B?QktpY3l0cjR5SWUrWkczT1FmTDc5ci9hbnpPUlo4dU5IemZWQk15NWRYenpp?=
 =?utf-8?B?VTFUVVlRajVqOTU4RGN1VFYxdjM3Q1dvcU9kRjVtUUgyZE85SUZvSnpHN3cz?=
 =?utf-8?B?YzZmcFhWaWNTZFEzT1dLNXUrdTBjU0FqTjZCclpkbDZCeGRWd0pLUmhVZXJo?=
 =?utf-8?B?Z1QxNTVkOG1tdUk3QVRXQUJqMVFBL0xwMHozdklUbFRuRWZHeklZSm5GUmEy?=
 =?utf-8?B?QVd1UU0xQ1J6VXlZbkprY0pqQzFyRmhWdU1TREk1OFhiemF1Y3hIZkp5VWl2?=
 =?utf-8?B?aDcydEFaZG02Q2Z3a1UyWm5LenZONFBwTTR1S0p2endtbGlWQ2R0SXgzSG80?=
 =?utf-8?B?dFY1Y0JyWVVQQTVlelFjdm5KTTErdWdFNXNaYkg5Ylc5OStRbkRFMGEzWTdW?=
 =?utf-8?B?UTM0UlpHbFBEb3ZOcGdabkRscmJ3ZVNsSE12OFNwZENCc0lUU1d4bUV4Y0o3?=
 =?utf-8?B?dFEvT3krNnlTaFhWS040UGltc1dMdXZOMWlaRU1kbXBKVng1U3VGeWdQVTF3?=
 =?utf-8?B?eGlkQWpzbkwwR3hkS01JUHNmRVBUUjBtblFJakVWdWFFSHJEOVNVaUVBUTkv?=
 =?utf-8?B?VzF6dDE3dllhZ1lnVU4veUgrWXRmdnk0eHR0S1V1RFZySFFBWWs5ZUtRVVZn?=
 =?utf-8?B?TXk2bkZKVHVGVVVtYmVkRFVoNHZEazdTYmM2OStXMUREUUZMNEdEcnJxS0lU?=
 =?utf-8?B?MjNPRTRzSG50anBnMHU3bWdSdjdrY29iTUlQWHVqSEVkdGNkenJZakViZGJv?=
 =?utf-8?B?cit3Vlp5eHNHV1AvVk1PS1pEN2Y5QTVhaWgyQ3JuR3JUU216V1Q2NGVFc0ds?=
 =?utf-8?B?TzVYNHM3R0JIdlRGbXI4Rjc4YnNMUWVvbjU5SHlTUE5QU0FBSmVHNnlJbmxH?=
 =?utf-8?B?ZUpXTmRNdUpRNTBRT0FxWTFTTHdETDd1SmtwQnNZT3IxVmxxQ0hpZCswL2VT?=
 =?utf-8?B?RkJWOVdwOHlvSkhpSHFNQXg4R0ZVUitQV2I5MzdIN2o1VCtqUFV1cmlUc0tq?=
 =?utf-8?B?eWFKTHpPd1ZxVEtHVWJQQlBEN2Mwa1kwWTR0UEM0NWVtT1RydmxNUlVHT1hh?=
 =?utf-8?B?N2duWUJlY2Naa2pvbVFIcnZRcmxwRU8xalRHZkZ2MGpuUWJBNWV3VXlINk12?=
 =?utf-8?Q?STALVKevtCLFLr9QPw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfb63f5-749b-46ab-ec27-08debb188082
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:18:24.6372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnJwD8iRxfG/3aJtfI6TzftixZfev/ZaaAXW/mLigrlFdwjComhfl8MNmYEU4n2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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



On 5/26/26 13:16, Zhu, Lingshan wrote:
> On 5/26/2026 4:46 PM, Christian König wrote:
> 
>> On 5/26/26 09:54, Zhu, Lingshan wrote:
>>> On 5/26/2026 3:02 AM, Christian König wrote:
>>>
>>>> On 5/25/26 10:23, Zhu Lingshan wrote:
>>>>> MES process context is a process-level page
>>>>> where process specific context is saved for
>>>>> MES scheduler.
>>>>>
>>>>> However, current user-queue code path assigns
>>>>> fw_obj of a queue to MES process_context_addr
>>>>> when adding the queue to MES.
>>>>>
>>>>> This means every new queue from the same process
>>>>> would replace the previous process context address
>>>>> with that queue's fw_obj address.
>>>>> What's worse is, when user space frees a queue,
>>>>> its fw_obj will be freed as well, causing MES
>>>>> working on a NULL page pointer.
>>>>>
>>>>> This issue leads to inconsistency and crash
>>>>> in the scheduler.
>>>>>
>>>>> This commit allocates a process-level page for
>>>>> MES process contexts for a process other than queue-level
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
>>>>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
>>>>>  3 files changed, 42 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index 38e310a8694d..0c4d6f80616e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>>  	 */
>>>>>  	cancel_work_sync(&userq_mgr->reset_work);
>>>>>  
>>>>> +	if (userq_mgr->proc_ctx_obj.obj)
>>>> Please drop that check it is unecessary.
>>> sure, I can drop this in V2.
>>>
>>>>> +		amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
>>>>> +				      &userq_mgr->proc_ctx_obj.gpu_addr,
>>>>> +				      &userq_mgr->proc_ctx_obj.cpu_ptr);
>>>>> +
>>>>>  	mutex_destroy(&userq_mgr->userq_mutex);
>>>>>  }
>>>>>  
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> index 28cfc6682333..fe85234e58b3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> @@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
>>>>>  	struct amdgpu_device		*adev;
>>>>>  	struct delayed_work		resume_work;
>>>>>  	struct drm_file			*file;
>>>>> +	struct amdgpu_userq_obj		proc_ctx_obj;
>>>>>  
>>>>>  	/**
>>>>>  	 * @reset_work:
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> index e9189f07c6dc..3022025bc2ec 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>>> @@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>>>>>  	queue_input.gang_quantum = 10000;
>>>>>  	queue_input.paging = false;
>>>>>  
>>>>> -	queue_input.process_context_addr = ctx->gpu_addr;
>>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>>> +	queue_input.process_context_addr = uq_mgr->proc_ctx_obj.gpu_addr;
>>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>>  	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>  	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
>>>>>  
>>>>> @@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>>>>>  
>>>>>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>>>  	queue_input.doorbell_offset = queue->doorbell_index;
>>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>>  
>>>>>  	amdgpu_mes_lock(&adev->mes);
>>>>>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>>> @@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>>>>>  	int r, size;
>>>>>  
>>>>> -	/*
>>>>> -	 * The FW expects at least one page space allocated for
>>>>> -	 * process ctx and gang ctx each. Create an object
>>>>> -	 * for the same.
>>>>> -	 */
>>>>> -	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
>>>>> +	/* The FW expects at least one page space allocated for gang ctx. */
>>>>> +	size = AMDGPU_USERQ_GANG_CTX_SZ;
>>>>>  	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
>>>>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>>>>  				    &ctx->obj, &ctx->gpu_addr,
>>>>> @@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>>>>>  	return r;
>>>>>  }
>>>>>  
>>>>> +static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
>>>>> +{
>>>>> +	int r = 0;
>>>>> +
>>>>> +	mutex_lock(&uq_mgr->userq_mutex);
>>>> Clear NAK. We can't allocate anything while holding that lock.
>>>>
>>>> Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().
>>> I will introduce a different lock in V2.
>>>
>>>>> +	if (!uq_mgr->proc_ctx_obj.obj) {
>>>> Please drop that check, amdgpu_bo_create_kernel() should already take care of that.
>>> I think we still need this check, because although amdgpu_bo_create_kernel() checks (!*bo_ptr), but:
>>> 1) it does not immediately return if bo_ptr is valid. It only skips re-creating the bo,
>>> it still calls amdgpu_bo_reserve(), amdgpu_bo_pin(), amdgpu_ttm_alloc_gart(), and amdgpu_bo_kmap()
>>> on every invocation.
>>>
>>> 2) it calls memset() unconditionally on every invocation.
>>>
>>> So I think this check is still necessary, and another thing, do you think
>>> amdgpu_bo_create_kernel() should immediately return if *bo_ptr is not NULL?
>>> It looks like this deserve a fix.
>> Good point, IIRC we added this handling to make it easier to re-create kernel buffers after suspend/resume.
>>
>> I'm not sure if any code path is actually still using this since we found that for a lot of use cases you need to keep the FW buffers at the same location even after suspend/resume.
>>
>> Anyway just add an if and comment why it is necessary.
>>
>>
>>> Thanks
>>> Lingshan
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +		r = amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PROC_CTX_SZ,
>>>>> +					    0, AMDGPU_GEM_DOMAIN_GTT,
>>>>> +					    &uq_mgr->proc_ctx_obj.obj,
>>>>> +					    &uq_mgr->proc_ctx_obj.gpu_addr,
>>>>> +					    &uq_mgr->proc_ctx_obj.cpu_ptr);
>>>>> +
>>>>> +		if (!r)
>>>>> +			memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);
>> When amdgpu_bo_create_kernel() does that the memset here can probably be dropped.
> 
> oops, I missed this comment.
> 
> amdgpu_bo_create_reserved() sets the struct amdgpu_bo_param all zero by
> memset(&bp, 0, sizeof(bp)), and amdgpu_bo_create() kvzalloc a struct amdgpu_bo.
> However I think we need to set the BO all zero, just like what mes_userq_create_ctx_space() does.

Yeah those are just the housekeeping structures. If you need the BO content to be zeroed out then you indeed need to do that manually.

Regards,
Christian.

> 
> Thanks
> Lingshan  
> 
>> Regards,
>> Christian.
>>
>>>>> +	}
>>>>> +
>>>>> +	mutex_unlock(&uq_mgr->userq_mutex);
>>>>> +
>>>>> +	return r;
>>>>> +}
>>>>> +
>>>>>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>>>>  				struct drm_amdgpu_userq_in *args_in)
>>>>>  {
>>>>> @@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>>>>  		goto free_mqd;
>>>>>  	}
>>>>>  
>>>>> -	/* Create BO for FW operations */
>>>>> +	/* Create per-process MES process context BO */
>>>>> +	r = mes_userq_create_proc_ctx_space(uq_mgr);
>>>>> +	if (r) {
>>>>> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
>>>>> +		goto free_mqd;
>>>>> +	}
>>>>> +
>>>>> +	/* Create BO of a gang for FW operations */
>>>>>  	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
>>>>>  	if (r) {
>>>>>  		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>> @@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
>>>>>  	*fence_ptr = 0;
>>>>>  
>>>>>  	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
>>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>>  	queue_input.suspend_fence_addr = fence_gpu_addr;
>>>>>  	queue_input.suspend_fence_value = 1;
>>>>>  	amdgpu_mes_lock(&adev->mes);
>>>>> @@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>>>>>  		return 0;
>>>>>  
>>>>>  	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
>>>>> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>>>>> +	queue_input.gang_context_addr = ctx->gpu_addr;
>>>>>  
>>>>>  	amdgpu_mes_lock(&adev->mes);
>>>>>  	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);

