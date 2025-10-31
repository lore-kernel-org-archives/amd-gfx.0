Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C287CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C279610EBBD;
	Fri, 31 Oct 2025 14:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMeL7DKP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2623B10EBBD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6o5TzF4QQJ9fggtL3ZG432jO/Y0IoBADZlusVwoAFwBbLC/ABRinCdpXdfiY5FlcZO9JDOaiSLJIpy/FCzmXpvE6xQZZTRgbCmSm08fYuTPW/GEmHa4jhzrZ0bvUtFEKre/5podyu/6dsyF6vKoM4NiheFfrpifS0fhSNby2HwBLYbC5FNAxOgJzxAgz24Sl61/q+6gBGsaXBk6K6u8kSoh2+TPimmkcDTn0CzfgX6W4V5nrbssh3XM0WOz6rmNr5t/O8FQCaQZPMO2PM5YBFU/EXbcmOWFtTt+C8t3sPYpCCa0HvXKF3ajmdib5Uj1eo3Ohzb8YWJCUinr1sltAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBdeb0pMrjqt/xFgXLReXqDqzjCovtR/rKlCMSyXjFc=;
 b=tsjyaLsfzafM2OyFRjxB1fBZAL1NpSipzCKXY30OzeckjksmjkID3sDbawr5p6F/qgaXpjNqAhSeCLlcR65myAi849JVSj7uJt1U/JZVmk6qO1JHQQIgAplmfNPHa5Ln0QLmVT3JvlCzwn07phU/dh7lfmLx+f0pGQDOAmndJZ1HaYKVaD+COchIjxYOBsmbDRWV+Q5ybIVf+whnbWOSjWbMTnv0Hw1gBRmtV9/esx9JcfASyiB3Q2q99GTpnTQbRNOxetPtZzc8mmfxfvD2g/FtrlGDU8XKzrwsnkBip2HVtDQBVOd5scVm2eHvIPJfqclA3caU/iRP+twTz7d87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBdeb0pMrjqt/xFgXLReXqDqzjCovtR/rKlCMSyXjFc=;
 b=YMeL7DKPDqn6qPJdTqLeyIkfulHVwurPLi5521fQ1A9oyAi4o8gEI3tzTWBd9TY/X/ZCQwandfT+oo59qnw9Ek28/KI063b+pLJGZbhrm1/mkxWZQEhM6mi+XG4meeN95QF/4xYfhnEMeaNRNCBiP//C4y/7qCpRRV3b7YHBPDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:01:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:01:12 +0000
Message-ID: <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
Date: Fri, 31 Oct 2025 15:01:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Jesse Zhang <Jesse.Zhang@amd.com>
References: <20251027220255.507105-1-alexander.deucher@amd.com>
 <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
 <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: cb116d44-c984-4d1e-f8f4-08de1885f300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUhMYkEvRmJ2OU95NlBHT1paZ0hLV2Y0UXJTWFdhNUtyRSt5R09CeDV6NGtQ?=
 =?utf-8?B?VGNFU1lleVJIdU4rbGZnbDdGaDhVTWxteUZtd21Ma0hvakZna0sycnR6MFdM?=
 =?utf-8?B?bDBDNmFZd0VxM3Nwb2NpSTJKeGlOUlo2K1gvQmNFMmlaSklRd05VZCs2Mnp2?=
 =?utf-8?B?c3crVXNpOVVaVnFqVmVhMDRxM0x2R1VmUTFnbWhRUkFlZFBEMUtKWmVQR3Y2?=
 =?utf-8?B?c0MybGRINTVXTzlHOGNQU3hyT1YrTlBYSStxb2x0K3dJNUJPZEQ5YUxGOEhT?=
 =?utf-8?B?dVB5NmlDZk1FMjk3TkJEUWwwVjMrNm9OYVFTNXdhM0JmUDNGa1dyZmhXTUlv?=
 =?utf-8?B?aUIzNEw0Ti9PRzExRitaNnJodUF2dUhKUVc2bWNCbmhxT2RNbjBKRzZQeGZz?=
 =?utf-8?B?UnVFdjRjVnpmVWhRMVYzS2hoT0dqTmJrelBUUnYxT05GZ0ZTR2p1YmhkWEpP?=
 =?utf-8?B?YTFFazJNTUtRRGNuVk1VNmdsOWlBOUxGL1MvQWpteGxGcFhGdzRpd3ZvdUVz?=
 =?utf-8?B?b1pCQ3U5a3BDZnVENDNkV09GcFVRb28wVzFBR1ZkbEtFU2U4YVdxMnNyWXBH?=
 =?utf-8?B?Q1R0OU5yWGh6S1BiVTNHVXJCN1IySmduYVg3bTVwNjYrNzg4NUJFcGp5N3RV?=
 =?utf-8?B?Z3FJZFl5QUFMRFRSaHJ4WTR6cHMxSzYrS2llY1RCaUphaVRWUE9oYnc5Nldt?=
 =?utf-8?B?NXdYSG9UeXZ3VTNFREhMemRDRGx6SnlvWlJxRWtTeTlDaXVuY09yeFI2cTRG?=
 =?utf-8?B?T09mcGltTlFrRWVyQkpWQkVOTzcyS1hXbVVzOGRROHJWVWtidlhLdy9mOWRs?=
 =?utf-8?B?VUp6dnUvQ245enF6czBXLytJTytieE14a0ZmTW4wbUpiY00zU1crWmtYN0Jp?=
 =?utf-8?B?S3NvVFMydk5ZaTVQMEM3alF6dVRHcFpkR28yZ1ZtR2RmOTROcmpzcTdZb2wx?=
 =?utf-8?B?SWY4eTJqRVlqR29VV25MMGtXbDZVZUdPN2phYW9wZytsQUNPR1k5TjNLQUZq?=
 =?utf-8?B?Vk54T3NhWG0xdjNkVjh2enRQWWNGSUpNejZ3R2lpeENMVi9XNEk3TEp4UmQ3?=
 =?utf-8?B?d2lyNjZaZkVVMlhRN0lCZGtuRnBZNTlkRS9BQVg4NE9BUzVmb1lUNXBjVW0y?=
 =?utf-8?B?S2ZaMnRNR3F6QjMyRURkVVBnTTZyN2V3OHBRT081YllycjAzUHdwaWZxQzNQ?=
 =?utf-8?B?Z3dCTVlYWlYvWVJBZ0t0Z2g4R3dFV1YrbXNtTTU1M3U1LzlNdllrYlpnK0xv?=
 =?utf-8?B?V0htVG5xOXdJSzZjdjE5NktxM29HYkIweVFYejYxY1BybUcvNnlNMDVhdTA5?=
 =?utf-8?B?dFFrVW9Rcmc1b0x1d3V2YUFiT1gwVjFiWFF1VUtid29pazBMOGhoYUIrbWkz?=
 =?utf-8?B?MUxOUFEvaUFnODh4alg5dWRYUDJWVmtwbTlpMkloZjF2NzRqQ2F4VzZlRExi?=
 =?utf-8?B?NDRILy9aNGtPK1VHVVRZK1FPTDIzdktVT2ZRZkV0SlpCb09mV09maHUvTTBC?=
 =?utf-8?B?NlNYMHlmVXFISDVQMWtWZW1mbnNzQlI1QXNUc2pXcXBpMmRiOTkvRUhYaVFk?=
 =?utf-8?B?Y0xDT3c0VitpaFhVdE1PYlZRMFVpU04zYkg1RVVXK28wL3NmZVRzWVZLc01L?=
 =?utf-8?B?ckNubFJuajRDbmxLV0wvdGhLQXVlOTdDcnRpUzdxYkVkMFlZTnl5a3YyN3FZ?=
 =?utf-8?B?L2dmRWxPRjM1S09oRDBlaCtJODRxUkpmdTlVblZEMUl5VWJ0N2lPY3JkdFpZ?=
 =?utf-8?B?ZVJFOXkxOFdYMEJoNy9pZ1U5OVk1NFo3ejFFci92Y3F5YmdiUm05Y2EyUTBa?=
 =?utf-8?B?V2w0a0FQWXNwUXpFOUNJS0tUbnJxNDdKZ2ZBVTFscTVlVDhEbkNMeWJLd2Z4?=
 =?utf-8?B?OFJ2MklQQ1cvMTdBNW1BQXVqdU9tRmFOTXQ4c01iVTFjcTNoT1NROWVNV0Nh?=
 =?utf-8?Q?1yLb+MGk/K/a0ToTR3bcA6C9jmfSAcaI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajI2Q0xnOThIZitVaFNhVHVLWDBXdDRNRnhyazR3ZlBHWnZvRXNQU3BtRXVD?=
 =?utf-8?B?bW4rWm1lY3FNSWYzYWorTDd2U2lzd2lGRUt0UC9zOENaOXM1MGlNTytqMmpH?=
 =?utf-8?B?RVByaSs3eDZ0M2ZMYk5YendnR2pwRTVaVHAvRHVybUtCYjZKaSt3c0F0MEZn?=
 =?utf-8?B?QUhSRXY0NVUyZytCS0d6VWFXeXdtWldGUXZOdDRwOURmeEdNaXU0dUsyWWFK?=
 =?utf-8?B?SnY3UDBKM1RZZXdOVFFLRnd6WjR5THRKZDNpWnpzdnJvb3p0eXBUcWJRcTFq?=
 =?utf-8?B?MXZXb1dWdEJJemlQZEdWekZGZXZ1N0pZVk9IcEpxQVZIK250OXZWblNzTVUv?=
 =?utf-8?B?MzdDMzRqOXRybmZCMkhUa3dpUWdnQU4yeVNJWDcvNkMwcXdnRDhjbEZXYmJh?=
 =?utf-8?B?NzdTMEtsajhlVEVoOWRGMUxHTURieGdheW1zenBWejNXZCtNL083ZWp3VnI0?=
 =?utf-8?B?YVFCRkV4MU9RSWJYODJ1a2ZLWVVGUWRXZ1YyK0V1WXF0S0JYVEk3NzlZWWRH?=
 =?utf-8?B?RFlOSngrQ2lBbC92SmV0TlZjS3F1ekQ1dFZKdE1pNHZpRDRwVTR0bUlnN2lp?=
 =?utf-8?B?emdzcVJjcm50ZlE5K1ZVL1BCZ3hyTElvRUJhTXpjMVpXUkZSTmc3VkF1MUc1?=
 =?utf-8?B?c2cxbE9CMURtWmFXdHFZQmxncWtlUjB2K1BDNnhySU14Q3pXa0JlK1Z5Nytp?=
 =?utf-8?B?TlRRcjkxQ05zVElPVzhnb3BRT1pCY29xaEhlck0zMkhGbkhzVWFHSHI1UVRS?=
 =?utf-8?B?YmJMcXVzMjAwNGZiY1dDWFdMWkllazlpQmdmWUkwRG1iMkJCblV6ZVlUdllD?=
 =?utf-8?B?UnAvTTA0cDcyb1ZKMjVkNGRlcHVBaXk5K1o5cDBWMkFaZ2Ezdkg3ckxNVGJw?=
 =?utf-8?B?TWhXeHY5N2ZRSFpvampSOGpoZGFCZU1aQVZuRUFGUVhVSk1IUytxY1laR1JF?=
 =?utf-8?B?S2hmTnMxc0RNMFdnUkVZNEgzaGlzemtMNUZ3a2ZURFBHdnN1M04wODZuSFRS?=
 =?utf-8?B?VVh0Nmd2bXpHOEw2L25VRTRKbUc2c1dhdVo1M3dNY0IvbGt0TERnWHZ4RitF?=
 =?utf-8?B?b0NWYkhqbDVrMnpVeGZMUWNEaEIwWUZuY3NEUXlFelkxWENlcmFZV1JTY1pR?=
 =?utf-8?B?UjhDNkl5VTA0elpWU0szbmNBbTloYUN1SlVIWmpOT2pvY3RPOWtWVzFnR2lm?=
 =?utf-8?B?MXFRQUpyc09IQmdYWGp5cmFoR0c5THo0a2Z2M2ZrVDBJcXdScGJvZkRTdmg1?=
 =?utf-8?B?cUlvTU9iSFF5S3hvRWVIcVR2dkw1SUVEV3BJNDJ6b0J1Vk5lOW5qbDdhbmVk?=
 =?utf-8?B?b2xLYzVlVW0rbWMzdXhKbHNKVUdtU09yQ3kvUWI5YWx5WjE3MDZabDJRZlBx?=
 =?utf-8?B?ZFN4ZXZhK1pPUEJ1Y2k0a3VST2hmczhQU05UZ3Qwd1Q3S0t5cGt5Y01hNDRz?=
 =?utf-8?B?TTZ5SS9oVTRuaGtOQTlpZm83OHo4azZzamQ1OGlpaStzcit0aDZPSlhEOTg3?=
 =?utf-8?B?dCs3VVdza2NQakRPNHYydDQ4TzFsYTNlUmpEak9paWNCbEMxUDFzTlRsV1BW?=
 =?utf-8?B?K0J5RWgwRW5xeHhvbTU2a0Nta3d1Z2htOHZHVlNmelEvOHFualRnNUZwUk1O?=
 =?utf-8?B?bnkwQUFaR2V1WEE1eDBCS0Z1UVNGMVUvQnBPanYxSitzcW1vUzNhSFJ2SW02?=
 =?utf-8?B?dkI2WTVzWDVROXVhZ2RBZE9OWHhWbWZMMTB0NlIvWTFYcmR1MHYwSW1la1di?=
 =?utf-8?B?RDU2OXdjMzFLTWx2bGEwNjBOQ3pxOWxKSDBTWkphd3grSk5WMmNrWnFNbnJL?=
 =?utf-8?B?OThSV2FUcFhMNkFQVlBUM1N1WU0ybllhaHI4VVVCRHJUSEFDcTU3UTF6aVF1?=
 =?utf-8?B?U1ErdmtWNm0xMnF0eWw5aTBtSVNQUlp1VW0xSFZXZXFodDhrWXdhVVZTQ0ww?=
 =?utf-8?B?dis0eXczUFplTkNmQ2J3bk1PWnhMdTlYblp1WU5nTjA1RWxVVXdHVFAwMWhG?=
 =?utf-8?B?SE5UWDNvTU5JbDJRRStIRzFlZXRWQ0FzL0tqemo2UEU4M3NycTlkZm9hOHRZ?=
 =?utf-8?B?Q293ekdsemhCaVROMk0yYjFjQUlwakp1SFdHTTE4Mmw0dHkzc01kQ1J5Y0c5?=
 =?utf-8?Q?DnVmMkx05b5UFiG3svrP1lZTa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb116d44-c984-4d1e-f8f4-08de1885f300
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:01:12.2211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q4jSOY5ezgsAqoFywksd1Tl929FoJDFh+JVRRH8+hRDZ2Ja0FP0OT8qiyQ7tPDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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

On 10/31/25 14:53, Alex Deucher wrote:
> On Fri, Oct 31, 2025 at 4:40 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 10/27/25 23:02, Alex Deucher wrote:
>>> If we don't end up initializing the fences, free them when
>>> we free the job.
>>>
>>> v2: take a reference to the fences if we emit them
>>>
>>> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
>>> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
>>>  3 files changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 39229ece83f83..0596114377600 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>               return r;
>>>       }
>>>       *f = &af->base;
>>> +     /* get a ref for the job */
>>> +     dma_fence_get(*f);
>>
>> I think it would be better to set the fence inside the job to NULL as soon as it is consumed/initialized.
> 
> We need the pointer for the job timed out handling.

I don't think that is true. During a timeout we should have job->s_fence->parent for the HW fence.

But even when we go down that route here, you only grab a reference to the hw_fence but not the hw_vm_fence.

That looks broken to me.

Christian.

> 
> Alex
> 
>>
>>>
>>>       if (ring->funcs->insert_end)
>>>               ring->funcs->insert_end(ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 55c7e104d5ca0..dc970f5fe601b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>
>>>       amdgpu_sync_free(&job->explicit_sync);
>>>
>>> +     if (job->hw_fence->base.ops)
>>> +             dma_fence_put(&job->hw_fence->base);
>>> +     else
>>> +             kfree(job->hw_fence);
>>> +     if (job->hw_vm_fence->base.ops)
>>> +             dma_fence_put(&job->hw_vm_fence->base);
>>> +     else
>>> +             kfree(job->hw_vm_fence);
>>> +
>>
>> This way that here can just be a kfree(..).
>>
>> Regards,
>> Christian.
>>
>>>       kfree(job);
>>>  }
>>>
>>> @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>       if (job->gang_submit != &job->base.s_fence->scheduled)
>>>               dma_fence_put(job->gang_submit);
>>>
>>> +     if (job->hw_fence->base.ops)
>>> +             dma_fence_put(&job->hw_fence->base);
>>> +     else
>>> +             kfree(job->hw_fence);
>>> +     if (job->hw_vm_fence->base.ops)
>>> +             dma_fence_put(&job->hw_vm_fence->base);
>>> +     else
>>> +             kfree(job->hw_vm_fence);
>>> +
>>>       kfree(job);
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index db66b4232de02..f8c67840f446f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>               if (r)
>>>                       return r;
>>>               fence = &job->hw_vm_fence->base;
>>> +             /* get a ref for the job */
>>> +             dma_fence_get(fence);
>>>       }
>>>
>>>       if (vm_flush_needed) {
>>

