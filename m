Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94328C3DA5D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 08:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B1E10E0DA;
	Fri, 19 Jul 2024 08:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0AzH18UC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD6510E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 08:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h09tVY/j27ros1Xxv0A+ckhGeAtePnRFHjjaToRoS79FnGeahXiJa9KvNkyzyZjDA09VzxEmwaq0REh9ZRRSckT1AzLt1u/Ci6hNPn4Prg2V1b3t5lrQlKlwgPJ1GAnOGlTiisWpQdKEQsBcIg2OPioM9reVjKmUY49T3ybcWcjQV7ZNX0Uld3eQuPjQxUXT9bUAt/pWFOHIge0V4opQdLZ2Als+BDMucSx+nN2LlXTdo9+hEC1snm3DdXl35v6WXCB6/UDMNTWXBCT16V27XrlGG543iqHbxB3Zr6pM5I9I4Vf2sSQply69VCPw5rv7rXVQor0GpyEVM7cmHtFQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wofTAptVcw1G46PfaW9geQy6p+mb7f7RhiXrakKqOo=;
 b=vyOs2b16s+gilNyjLCGKw1blExhJ6a47LRHeV4CEfxWjB7fAi4n7znBM8DNI9aPbfL4BSo4gNc8V2tNelCNeCCnlRqFHP5gBx1cyeD1WD24sPYCQYLQVWobdK3zDAL+AoI/S0VzQafgY4gj+pfDgCG937L61XrNYvIaX60A8kQQ3Buz1A6m06Zi61oqcFbAiTYNqARpFGmEHTtCnjOKPanxH54iZA50/jn15fpdmayuyVUizIm4MBdoe6v3t7jByPIZ5o//4M0v7TgsNw5ToEjgGeGr71rBujUOtrQs1SNSco84zXvjXIeVFPJ+duHQMuRZDOxAgf8PKCxFrcG/+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wofTAptVcw1G46PfaW9geQy6p+mb7f7RhiXrakKqOo=;
 b=0AzH18UCWdN+c904ySD8UN+RuccKvMQVAt9T3ZOloBu4JFP5S21iVZEFRLiEaLeDuy2I92RjNxkaLL1xjngU1LD1afL5m3bVOXG4ck0XR/ioEKDA8xdmZBO3mnY+hPK5jzgJF95VYoplRUFR5agaSfsrfo6UFVxgiycjyKezZVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 08:45:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 08:45:23 +0000
Message-ID: <6a7fc43b-a0da-4b8c-926b-41084257aff2@amd.com>
Date: Fri, 19 Jul 2024 10:45:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] KFD user queue validation
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240718210558.26340-1-Philip.Yang@amd.com>
 <24b881b8-6bb4-4438-b329-6aa2b7938918@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <24b881b8-6bb4-4438-b329-6aa2b7938918@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4a14b0-c689-455b-4338-08dca7cf2117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFp1c2RTMHhTNWUyNUR0Vy9oNkVqdVVRbW00NDR3bUVXalpOVjlKdXR3RnRI?=
 =?utf-8?B?a3JZWC8yNm9FMzNyMFFsZ0JmdndBZjY3M2tBbkI3c1l0N1RicFliMFFQQTNM?=
 =?utf-8?B?VlhITEJpdlR4ek5MSFV1K1dRU2RiT3VLcGY4TjVBSDBQYnlMdTFTSGZmbEgy?=
 =?utf-8?B?dXFyZHhsUHJCUlU3L3BZM0QwMStuR0paalNzWUtPYlVTdWJtVy8ySU9leXBn?=
 =?utf-8?B?eGZOTnV2MlJVMXNGeFJlTW1rMUFDOW1YZkRlcXpDUjFLSm80Y1dSZXNFd0du?=
 =?utf-8?B?R0FITFVUdnNGaWQrWkk3OURWMFc3OWxnZk1hb3M5aURCcURGTzZJcFFFTGFY?=
 =?utf-8?B?RS9BWGZUQjYrQkZYQkxNY1NLdS9xMzc0bjZCNlpucG5LMTVub25Sb1J3ZW0r?=
 =?utf-8?B?MmVOWGVLVXlrRjlUaWhUUVI4NUFadittRHcxUW1WT2k5TUVNaTVyNnAreVFL?=
 =?utf-8?B?bmcvQXJGUERNRWs1YmpzdWNKSS81TG9qeW5lQWRTS3E2M0VqcGJFcm04QThT?=
 =?utf-8?B?anpGbGtIRUxjMTh6UUlhN1UyeVZjb3JEVHdicU8rUzRnQXpmU2hMaktOckdl?=
 =?utf-8?B?QXM0V0hJTFcwSWVQZEp1TmpsWFpPQmprOTdXUE5hT1gzS0RJWHNlblI0NVUx?=
 =?utf-8?B?OUN3dU1kVDhYTlB3ZEVxdWpjL2svMVZmWUdaR0txa0dTdWY3c3ZIa24zTVho?=
 =?utf-8?B?Q3J0UEVWME8zWDg5d0ZDWlBtQ1JJZ2l0SjR5UVNUYXFWdlhxYWJHRGV5L3Nq?=
 =?utf-8?B?YzVMUmhTRFlCNEI5eitqWExGdWYwaVgrajVjSDdlbGV6U0VEbXJZZGoxMjBn?=
 =?utf-8?B?VC9FL28vaER1QkNhU2NOYVoyVnNFL3BaZHdiaVpzMHRoWExtU2o4UXJQdlFk?=
 =?utf-8?B?VFJSNXhWbnROUFYremRFZXhSdzFtbXEvaWpzajZROTNuclhhQmtsWklzbGNB?=
 =?utf-8?B?QmRyTTF6R1hEZjZvUXF5YzlpUEZPbmMrZHFUeUhSOXV3ampDVW5WbEZUZ2hH?=
 =?utf-8?B?VlJ1WjNNR2crUE9zM21MaW9NcXZRbkpvYTQvYVpQb3VEdjhVSWdOWEZ3azBx?=
 =?utf-8?B?UVQzK0tpZzRwQjdsQzVhQnpTcVhyUFFMRW1ab0h2TTZvYlk3ZXdwWUM3Nis4?=
 =?utf-8?B?VE5mRVdRSkVWRWsvK09TUWZ6MEh4bFFNWkdMTkNwQzFnMkpEcEpVcitFdVY0?=
 =?utf-8?B?VTJOWnl2Z3k4ZEFyN2dOZ3RIcWU5bGQ1TTRQSmQybDJJY213VnZhT3FER01C?=
 =?utf-8?B?YStERkliVDFSVGZreXpha2NRV2FXVDh4eDlzanpCc0p1NVNLd0lxRzQrcWtx?=
 =?utf-8?B?VXJVYkx0bEIrMjNRaFYvZlpvSVdTOHc4YzBqRDA4WUZNVEw0eEU0dUduQVly?=
 =?utf-8?B?Q3h5eVJYM1RZTklJRWFVa2JIcFovNXpsdzJGVzNTM2w3VnZwWHIydmQzbG52?=
 =?utf-8?B?TWd6K1gzRGptamFyQUpqMjFrZlVOcHFHemFCa1p2bTg2RXdXWnh2Q2JMRnRt?=
 =?utf-8?B?Qk9xc052VG1XRU01a2ZtZDdBVXFCL3U0d0FSSks5TTI3TnErM25ES0o0QTV6?=
 =?utf-8?B?M2hhMWFUSmErMWFzYVd2TmhSamZMU1BpbXFacExnS0ZTNE9KUzF2MFJwSmUx?=
 =?utf-8?B?dVozcStnaGltQ2VyaUlZUC9JZytZOVB6UGFMQlkwOE01ZkxrL1YrSzFBQVA1?=
 =?utf-8?B?U09ROWZ2UmFoZWJGYVNSWFdrVmx3bUYvY0tJbVNzNmN1UmdKaldmcCtMQ1NZ?=
 =?utf-8?B?bVorRCtZR3ZYZm42Zkp1cWYyczY3Rm9hL0tmNytIL3lOdWREZmlHd01IRnRJ?=
 =?utf-8?B?eEJkM080dkJ4NGpRa0hNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVnWEJGbmhpN2ZxVzMvSlhhbHZ0WDErRXFhRW00V1BRbmt3dytHWVJWYzJp?=
 =?utf-8?B?Q1VQYjU3YmY4aDNLUDJSckc0Y1d6NU1BZnlXdHBxNmkyUG5QejZGc2h0TDJG?=
 =?utf-8?B?QWxzUjN0cG1GaHlkMHZYaVMzdG8wRlg5UFM4dWFqSkRvNXhUL0F3dFpKdXM2?=
 =?utf-8?B?TDdNK3BXVi9PYkU5L3VkaVhqYU5GbkJCWGlkU1NKaG13cXRybXVBcGsrSEpm?=
 =?utf-8?B?WXo3QlA4QnkrdUp6VDBLRWJRNkljeG5QLytVTXJJNWwzWDREd1hUWVM4bXJz?=
 =?utf-8?B?MEZRa1BScnRlVmlja0dHZFdBVm8vdkdjbWhXbEtxN0V4K0w0OVd0VVhQeE80?=
 =?utf-8?B?ekwzYkxjWjJqU3htbGlDT1l3dUFhU1VRUkI4VEtqL3g3TVVXbmtpdWErcEZz?=
 =?utf-8?B?ZDh1RHRvYW5UdXNIK25wYTRESVRDMTltOERzWlFoYW04eVl0QXRpVXU1Rll0?=
 =?utf-8?B?c0R4MjJaT3dtYWI0ZS9jL3BhakZmdXpORUlpYnlQUTJCdHkvK05CL2dqaXV0?=
 =?utf-8?B?K3lPRmVpM3E5cHFoZ2w3WnFEb1A1MG84V3AzQVZOS0cyNHZnYURYV3R5QkV4?=
 =?utf-8?B?MXlKK1JJbzBTTWxCUUhRWEJzRE4vQ0RsODZQOFFQNjBKK0prSGwyTFp0eFhQ?=
 =?utf-8?B?UFBXbHpOUDdZeEYyVld6cUtCc1VSRE5EOEF1UUQxMzI4RmNCcEI4SXRHajNp?=
 =?utf-8?B?Sk5FU2Vzb1o0eDJHZWVLWGRsR3hMTUJIRU9va0x6MHBWN0M1YWtPbFZNWEhJ?=
 =?utf-8?B?K3JEMmJyTDJPL1ZGUUJ3V2h6QTJIYnlqK0FEMlJMOUY5VGpYdkVCRTIwZkZ0?=
 =?utf-8?B?c1c2cVV2aElxckVFZ0FHQmdkdG92U1QrVTlQL0ZydVB1bkgxYzIrKzhHcmEy?=
 =?utf-8?B?SEh1bGpoTEFSdVFwcUM5dHcvbHhYVk9lVzBLQTVpcEpCK1pjdnhRZlBiSUJx?=
 =?utf-8?B?WXREYmRWQUlZVzhCRmg2ejhqYkI2T2RvZnVBamVZUGFRSjJjSWtZUlVuOHNq?=
 =?utf-8?B?L1ZtVU44K21sOUhVY2NkMTFWcXFMMEJMSTliQTk2L3cyN01YLy9xY2IwME1O?=
 =?utf-8?B?Q1o2cGNvYkZTRkg3S2cxbHBsM0tvaGdBTFV2Y0tDTWdvWERGMFlzNzJKT0hy?=
 =?utf-8?B?R290a0prdnVrQ01JTjVqUmU3R0pYMkV1THBxQ2puZFNIdE1GaXN1VUIxQ1RB?=
 =?utf-8?B?L1diQ05wd04xUGZWVHZBcVN4N3A2WmNoS09mL2ZtTU5FQjNMRUFudHhKSjdh?=
 =?utf-8?B?UkNadDRXcCtSYmxZaDJuQXlNbkdRQWRuUTdFYVZJNjV4aEZxdVoyQWtjWm1E?=
 =?utf-8?B?TWRWYS91N2VUNm10dy8zY1dITkc5OGdTZXhqTFBEc1dEQ3VjRVBhL0k1ejN4?=
 =?utf-8?B?SXZQWDU4RWJxYUhZWTNZUzRWcElGbkRrYzFjNExTa1VZVzM4RVg3R1BpcW9R?=
 =?utf-8?B?T1FaUENEZWpKUGZ0TE1wcVBheTJpRXIvMWUvWGo3U2ZLZU1RSGVhbzNYVDNj?=
 =?utf-8?B?dXVjRzZwcVVlMEZwcTg2UDVDbkx6bDE5ODI1Ukk5b2FaVE1OUVhIclArT2dY?=
 =?utf-8?B?Sk40WnZ1ZUYrdGFueTRoTEhIbDIyTDVCZ1JZLzJPZVB4RlhIRktMRERhTTRU?=
 =?utf-8?B?c1JmVmVNVGg4cWlzOGxXWUh2am9EVGhoekZsNGdoOXFsSkFyMFh6dFl2SUlG?=
 =?utf-8?B?UnNPbVMwcGRyU1VKU3lieHBpY1E2NXpIenI1aG9UQi9xb3BTdDVlSUVoM2My?=
 =?utf-8?B?MnFiWWVzYVp0OHhiT2ZXTlAyWjVSQ0ZSMG1mQ1VhbldtWEVDYm02TVZ0RURr?=
 =?utf-8?B?bnpvVDlhOXZqb1N3RlVObFhMcjVkU0sxT1Fhb0UrVEZ1dkhza3dPbHhBUDd2?=
 =?utf-8?B?SHlWU2RKQnhQYjFGWnAzSExUMWlQM0tDUzJ0L3dQM3lxT29BaFNNK0MzSkts?=
 =?utf-8?B?TFA5V0M4Skh0VmxxdDZBcGlQN1hzSFA0eGlKT1k0R0t5RnkxOEh6MDlISFBS?=
 =?utf-8?B?b1NBdUhtaWFCZk1uV0NKbC8vdWIzV3BEWjlHUGNjWHI1TkN2VjNiOHFYTC9X?=
 =?utf-8?B?V0k3Y3RyN0o2d2hQTVBLVUhCMnA3QjJ4MjBBVGJsTDlHbUxrN2dWZXRHSFRz?=
 =?utf-8?Q?gJ/w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4a14b0-c689-455b-4338-08dca7cf2117
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:45:23.5995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6YYKgkfyddWAbBvj/dRttI+vLDNVEV6pjLz/3wbVPCBY5j3vdsXEHz+WllDwZbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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

Am 18.07.24 um 23:12 schrieb Felix Kuehling:
> On 2024-07-18 17:05, Philip Yang wrote:
>> This patch series do additional queue buffers validation in the queue
>> creation IOCTLS, fail the queue creation if buffers not mapped on the GPU
>> with the expected size.
>>
>> Ensure queue buffers residency by tracking the GPUVM virtual addresses
>> for queue buffers to return error if the user tries to free and unmap them
>> when the qeueu is active, or evict the queue if SVM memory is unmapped and
>> freed from CPU.
>>
>> Patch 1-2 is prepration work and general fix.
>>
>> v2:
>>   - patch 3/9, keep wptr_bo_gart in struct queue
> The series is
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I only skimmed over it and will probably find something to complain on 
later.

But we need to get this out of the door, so feel free to add Acked-by: 
Christian König <christian.koenig@amd.com> to the series for now.

Thanks,
Christian.

>
>> Philip Yang (9):
>>    drm/amdkfd: kfd_bo_mapped_dev support partition
>>    drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
>>    drm/amdkfd: Refactor queue wptr_bo GART mapping
>>    drm/amdkfd: Validate user queue buffers
>>    drm/amdkfd: Ensure user queue buffers residency
>>    drm/amdkfd: Validate user queue svm memory residency
>>    drm/amdkfd: Validate user queue update
>>    drm/amdkfd: Store queue cwsr area size to node properties
>>    drm/amdkfd: Validate queue cwsr area and eop buffer size
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   6 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  24 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   6 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  61 +---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  19 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
>>   .../amd/amdkfd/kfd_process_queue_manager.c    |  79 +++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 336 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  12 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   2 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   4 +
>>   16 files changed, 489 insertions(+), 91 deletions(-)
>>

