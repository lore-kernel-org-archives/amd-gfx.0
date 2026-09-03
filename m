Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F687C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 04:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7DD10E013;
	Thu,  3 Sep 2026 04:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIsKuHAt";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252FF10E037
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 04:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBr9uaN8JvlzyQunwZ1JfPJyjPSke378t0pHY4Gfb+Uz5Z2bEQiDSOzjObq+TJ75a4U0DL/nDaQ+8FSVNLAIAq4xwEIiWfXcyauhHLgpRuc6Wk46NwbxTNvDhWgTgCiducF9+qcf282DuCxznVMVec4JGSJRCtskXcz0miJxvkQbaDw+ze3oEpL9bftbHn8JaeK1egz2uUSMMo1qDS2j1TOOpC+Ar9N2SzfusNAieBHFLGgPS5dU5j4FgBtZ2z48SRsmaeZ0UU8nFn+7+Arpv5mTAc6abTynYXyJV3Itu9kjvptuz2BCLv2qexdlwDMj2LjAAaKbYSxuHGq9SeEqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK/A+zQEAAhb0lFJTQIWlYz4KnMPcXYZRW2apaPcr0g=;
 b=vEQpPtgIznj98oAGCYiTX2U0/SsLyl/pFZ/0B2g5bcpAkMRi2SHuI7RAdtzhLLxzR1Suj3elIwKp23gMwPSOLL02sGJttanxqwYqDSYF82iVyPuULDZCJ/nsLZhkMKIJziJcQGEZv9uTp5Xvdj64e9wenB1LgUeH1ZqnWEK40ageTlCmFFEbhnajLYJc1tDpEjstmNKlQ144NR6Tk3Qbt3XuQaWtVIU/Skdj1cC5dFNS2UXvq44AAeP0S2JrlyVgegGiUFzW0/nOkj3BdLBd5M1yo+wTwpoAlG6Zq9u89UmRP31ZXYjCraUswM2F9pFuO3GYeFkUrEKC976rscu4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK/A+zQEAAhb0lFJTQIWlYz4KnMPcXYZRW2apaPcr0g=;
 b=GIsKuHAtGPEOD+5Lwln7+EiwpPHJvHGqDRpMpmSy4JsfUwbT+Gr6XjLJeCNQvIvTiTYOKerPbw3V6QzvIdSK6W8EUEm2a9M/vs48ItgKxQjjQi4jiENo60QZ9GmoeiSXYLt0s/es5/qHEG09UQ2suKlRRX6hHWGNRILBnnNsWy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 04:02:25 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 04:02:25 +0000
Message-ID: <f2755b35-ef95-4067-b5bd-0a37ee1df457@amd.com>
Date: Thu, 3 Sep 2026 09:32:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
 <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
 <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
 <IA0PR12MB8208E904460F474C4975950690B72@IA0PR12MB8208.namprd12.prod.outlook.com>
 <SA0PR12MB70916914036CA157754EAAC497B72@SA0PR12MB7091.namprd12.prod.outlook.com>
 <BN9PR12MB514657D40AC8B41594720A93F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB514657D40AC8B41594720A93F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ef6d22-aad3-4dfb-9760-08df09702994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SfMoq7W7x3GFS25TbvpCs50l2M3GIRMHey3qNBB0Fx0jeZGgvUVTTbbBYviTPejc4ZbDnwPjOfBoHwIHpq6i5vrCA9a76qbvWdp++ZTdX/VXht2SIIU11LHiErfzoLvbQRkBMzK6XarvbOcUH8ZhkXERaxIcZhTeu1xWGNEdL8MO5Djcbc3s1n7ID2gWtAV6vtKGsdDS23i87RPqOJ988sGVfWXTJmcWS/TqLAPROPeW5HlXkMp7lSxfsFgwUPIxtYU8nBfVemuS8IVIcGStitbN29+vD4M+vOzWdAsPvBnTPe4YbN+RaqYlNtGWGmxGRR4z9YOWAmVG7/NCSkgN8bgJpwK/oCT49PYWUBLKSli4JbyQaF5uYOBgwsReisFrxhDXYJ0ygobCEFBZk/NQ8pRXAhlkL/HCyZaJMnohuJzRDe47JUONBKqCJKKKcTq0ZVYj1SG3eOwWVMwpU2aS2fxMbDU3UM4sNLogEoXmgSYe2oo2iGOKinYDLARftC1m0ZhatomuVUqrXp/SoHaTPlIjm2ajBzIWuUlcwPXyFwlGZMzohgNksdWNMUwJ5mxeuZbKq6neKuOo9VjOazi/0Tb1Qj/ph+gMbZblKmHWgOMWszdUyVez9+ijzER1IpE/53ErU/axHlfh7XA09v798WnJ4vtQKdE8I10Li3M9Q9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFxNnNuNEhyaEMwb0lmZWtlRkFOQ08xVmlDTzJDM0hGYWlGU2FoZTVGaGxX?=
 =?utf-8?B?MmF2UXp2VHBCWW5FQTJaMFpYZjVPc3NtUCt4NGdlcjlETSt4Q21zLzdZdE1C?=
 =?utf-8?B?cjhXbXJsYkRHdlRvcEdmZEpmQ2dqVko0MGUxbDFSbTF5ZUpHOGsxWVViTW42?=
 =?utf-8?B?STBseXdXbm5EbDFlNE9zb0xKMVpRcEYvd1M3WHlPc2dIbDExL3g2S2Zlcisw?=
 =?utf-8?B?TmwxcDBENUR0V3BveTAxa0dUWlIzeXYyS1Z3UU1aaHdKVTJGU3J4NlcybHcv?=
 =?utf-8?B?WVo1SWJwSXl3dWttZGgwd05jUjgySmtXcjFzT0d0QjZOU2hXN2pXdVRyeTg0?=
 =?utf-8?B?dm9nU0hYTFl3ajJlUUFIS3Y3YUNFQkJtcTMvMXgvaUh0M2h6amZqZWtOWDNQ?=
 =?utf-8?B?WVNMb2YvNUx0SktENml6MytBY0x3cjJTUVlrNVp4QzJDbituREowaHB5MW00?=
 =?utf-8?B?NjV3UEJNSlczemJpdXRMQjFGNE9lYTZNVEh6cmEwQWwyV1V2TXBQNHVOTEZj?=
 =?utf-8?B?MEY4UFZ4NzE4M1Vsa3FkQjV6QnNaOURieHRlNWVtY3dvb0tWWGYvUzZDckZz?=
 =?utf-8?B?MmdBQVdZOGx3VGcwek9veHRBVFN0RlRyYWN0R0RiczVUSzF4ZFdkbWNNc0Np?=
 =?utf-8?B?Z2tIdWpZdjdBK0h6OEJJWncxbXdYZm1SZGdibTUxbnJoZDFNb3FtS1QxRFRt?=
 =?utf-8?B?N3F2SFZrbmlrOFVNQ0NyWEdlamhZZkliYXRjWjA3YVpzUitFM0x4a1ZCVlBo?=
 =?utf-8?B?anJXNm9kM2w4QjRNWWYwbHU0UHhJU21LMEg0aXRLa1pIb0ZKeTIyWG00MXZx?=
 =?utf-8?B?aUNpK3VGZ1VMUzRlV1FVS3E1QUx6WDF1S1JJTmN3WEZmZ25JaWhuRFI2NzY5?=
 =?utf-8?B?ODlCaDgyb3VoVUNCb1JObjBRSnRyU0dCcFJ0b3ZEbkVreTVpL1dGcDcydnU1?=
 =?utf-8?B?MmVFWUF0WFRScEJ0Nk0xUzlOYWtqYTUwRG1DSm9hZW1kSkk0WGxLZTRjUFFO?=
 =?utf-8?B?Mld6OGM2UURhQXY3V2wxR1J5eVR2VFVabnRFRm9oKzlDSWdkZ1F4THc5UlM0?=
 =?utf-8?B?TDBhM0JKdEIybXM2djNwb2VSKy9Bd3R5bkZVVFdFSXlVZEhRVUZKUmZQYnFq?=
 =?utf-8?B?YXFkWEhLS2VtZmdieXo4dEQzY0c1WS8vR21pemRnRXRBd2ZxbHRPMUw2Vnpn?=
 =?utf-8?B?YUplUFVMTFlZaVpqV3A5VmZrN2FKREZ4U1lNb0pnS2NyOXczandXbjFSVVJL?=
 =?utf-8?B?Wlp1aXNoWUFlM3FZVmwydVdOcUQyNGNEL1kzR21ub3JmS3k1TjQvMFpLTWRr?=
 =?utf-8?B?RVhQLzBGbTRlaXRySm9LYzA5VVlkc2tRcWdVQkpnTVNDeHJkM0s0SFN4YWRV?=
 =?utf-8?B?eEdqclloY3FEZHord1RBWDR0TnFSeWZNK1Y5UVlaOUxWUHZrZXFUbWhCTERE?=
 =?utf-8?B?Rzk0cWhjYis1K3kyZlVxK0tNa3Z1Uy93TDJjOEZmaVdYOVJKOXoycldiMUc4?=
 =?utf-8?B?Ny9pZmNxLzliK3Zhc2UrNGZCRzNvc25HL0Jjc2p5Qm5qRnhVQ29xYnV4cnh3?=
 =?utf-8?B?cjRWamVZbS9hRkF2QzhkSjFleEdJYXB2MkhxYnpWVUtZNkNXYW1zemhRWExI?=
 =?utf-8?B?WGFSeDlkcXUxVGVkbWEzM1A4UmVNSVNYSXV6elNRZGJ1ZFlHQkNlTlpGY2Nt?=
 =?utf-8?B?WWpBbXhxQkhYZGxta2I5eWhnNUJXSi9DZGhLMCt4MG91R21jRzlXNkV5TitO?=
 =?utf-8?B?R28wc1oreEJzekFCd0FVQXMxc0lTVlVjZVorTlJWN0tKNUhBOU4ySkFRSU4z?=
 =?utf-8?B?Vm16a1hxOXNwWnhCSGZSMHRVTmNyWDdISUQyVnM3dkJxK3laeVVKdVBzdVh3?=
 =?utf-8?B?cGZlL1F5OWkzY3FUbThXQjNkN3R2R2xiNkdnRExoYkE5VXVYd2V4bUYzaFFz?=
 =?utf-8?B?OHdXd1VBS1Y5K3RuRDN5T1RyZldVcWpyUnBydVVWT2lyYmEvN1VGb2FtelNJ?=
 =?utf-8?B?Z1YybU0vZUM2V2JCTE9UakRpR3J0VE04a3VYV3VaTEl4eUFVbVQ4dmtCMnNp?=
 =?utf-8?B?eGdhWUF3bmFLZ1BrbkJTSm9hMmVPWDlaam80N05tLzc0MjhJMXR6OUNMY1h5?=
 =?utf-8?B?SUdHYzdQb1dkcTZtcDVqYngyN0oxTXdxUjdwamhqUmQ1cGdCSjFqbWlRTGZX?=
 =?utf-8?B?dnNRcG9xNDRVaHhHTTFkU0lrd1Npb3RYSW54NlFEYWFSWWRHTTFRenJRc3Mr?=
 =?utf-8?B?YmJqRkpWaExQMnVDa3FpanNDRHErT2dpMHVwbnpOTDdDVEhFeVlhWmRlK2Q5?=
 =?utf-8?Q?Qs4sknWYzSZi10k0LE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef6d22-aad3-4dfb-9760-08df09702994
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 04:02:24.9874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/swcXV+zSiV9bJRjKw7E/bifP4OoAUEp4clDq659gtzTOtOwiB13u1yUujE/PqA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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



On 02-Sep-26 10:25 PM, Deucher, Alexander wrote:
> Public
> 
> 
> For kernel queues each IB executes with a kernel provided vmid assigned 
> dynamically by the kernel driver.
> 

In this case, it's a device level TMA 'kq_tma_bo' for first level. That 
address is programmed in SQ registers. When a job is submitted, the 
second level handler is picked from what is programmed in kq_tma_bo. Do 
you mean to say that driver will change that value dynamically based on 
what is provided by user?

Thanks,
Lijo

  > Alex
> 
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Wednesday, September 2, 2026 12:12 PM
> *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org
> *Subject:* Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler 
> infrastructure
> 
> Public
> 
> I'm not sure how this works, I thought the TMA mapping is per VMID and 
> kernel queues have static VMIDs.
> 
> Thanks,
> 
> Lijo
> 
> ------------------------------------------------------------------------
> 
> *From:*SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com 
> <mailto:SRINIVASAN.SHANMUGAM@amd.com>>
> *Sent:* Wednesday, 02 September 2026 21:29:38
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; 
> Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> *Cc:* amd-gfx@lists.freedesktop.org <mailto:amd- 
> gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org <mailto:amd- 
> gfx@lists.freedesktop.org>>
> *Subject:* RE: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler 
> infrastructure
> 
> Public
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> Sent: Wednesday, September 2, 2026 8:59 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com <mailto:SRINIVASAN.SHANMUGAM@amd.com>>;
>> Koenig, Christian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; Deucher, 
> Alexander
>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
>> infrastructure
>>
>>
>>
>> On 02-Sep-26 8:36 PM, Srinivasan Shanmugam wrote:
>> > MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>> > SQ_SHADER_TBA/TMA registers for them. Add infrastructure to let the
>> > driver program the first-level CWSR trap handler for these VMIDs
>> > directly via SRBM select.
>> >
>> > Add kq_tma_bo — a pinned GTT BO used as device-level TMA scratch for
>> > kernel queue VMIDs. Unlike per-process TMA (created in
>> > amdgpu_trap_alloc), this is device-level and lives for the lifetime of
>> > the device. It is zero-initialized by the OS: the second-level handler
>> > address is 0 until userspace calls SET_L2_TRAP.
>> >
>> > Add amdgpu_trap_program_kernel_vmids() which dispatches to a per-HW
>> > vmhub callback, and a new program_kernel_trap_vmids hook in
>> > amdgpu_vmhub_funcs for per-GFX-generation register writes.
>> >
>> > Required for:
>> >    - RADV graphics debugging on Vega/Navi/Steam Deck (Valve request)
>> >    - Consistent trap handler behavior when switching between kernel
>> >      queues and user queues
>> >
>> > Suggested-by: Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>> > Cc: Alexander Deucher <alexander.deucher@amd.com <mailto:alexander.deucher@amd.com>>
>> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com <mailto:srinivasan.shanmugam@amd.com>>
>> > Change-Id: I0709e788835b69d3d492864de8d5c2d36d0f08c8
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 37
>> ++++++++++++++++++++++++
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 ++
>> >   3 files changed, 40 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > index 3ca187f5ade8..5624a5ab5c62 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> > @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>> >     void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>> >                                              uint32_t status);
>> >     uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t
>> > flush_type);
>> > +   void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>> >   };
>> >
>> >   struct amdgpu_vmhub {
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> > index 31f653ec3fb1..0e0aeea0aa2d 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> > @@ -256,8 +256,23 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>> >
>> >     memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>> >
>> > +   /*
>> > +    * Device-level TMA for kernel queue VMIDs. Pinned GTT — not subject
>> > +    * to eviction. Zero-initialized by OS: second-level handler address
>> > +    * is 0 until userspace calls SET_L2_TRAP.
>>
>> How is the exclusivity maintained as a user app doesn't 'own' kernel queue? How is
>> the conflict of different user apps trying to install their own second level handler on a
>> kernel queue handled?
> 
> As pointed out by Alex:
> 
>    - Each process gets its own per-VM TMA buffer for kernel queues
>    - It is allocated and mapped at a fixed VA in the process's GPUVM
>      when the device is opened, similar to amdgpu_map_static_csa()
>    - Before each job is dispatched to a kernel queue VMID, the driver
>      programs SQ_SHADER_TMA to that process's own TMA VA
> 
> This way:
>    - App A submits job → TMA = App A's TMA → job runs
>    - App B submits job → TMA = App B's TMA → job runs
>    - No conflict — each process has its own TMA buffer
> 
> Note: SET_L2_TRAP for kernel queue VMIDs is not part of this series.
> This series only installs the first-level trap handler.
> 
> For second-level handler support on kernel queues, I think since:
> 
>    - Each process has its own per-VM TMA buffer (allocated at device
>      open, mapped at a fixed VA in the process's GPUVM)
>    - User calls SET_L2_TRAP → writes second-level handler address
>      into that process's own TMA buffer
>    - When shader crashes → first-level handler reads from that
>      process's TMA → jumps to that process's second-level handler
>    - No conflict — each process has its own TMA with its own
>      second-level handler address
> 
> The per-VM TMA design is the foundation for this future series.
> The device-level kq_tma_bo will be removed in v2.
> 
> For long term — kernel queues are replaced by user queues entirely
> , where MES already handles this correctly via ADD_QUEUE.
> 
> Thanks,
> Srini
> 

