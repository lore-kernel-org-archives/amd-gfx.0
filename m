Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44175CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C777E10EA02;
	Thu,  9 Oct 2025 12:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAD3xbTE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1503B10EA02
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 12:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnPxS1/mDX162q4gLX+ROv9wJjrdlj4D6yxr1R84RNR532yGUCnP/XaGk4+jlhqOA9bC4eL5fDN7rxvnN4mfFsRtZYK51uGVMciolC1Tf/7eqvwI6XER8tos8wlXta0vTeww/FTTqSm68Nch9ho2RfipCBcLZjE4AYeg0fYFlvmTGlMDXJiTyzwhX7ZXQlnfRUYgcUYgogMMlcO6QY/oOvcKD2Es84rDieGOFz57yzNttg8LsEdycE0Vjk/HcOc80AO1sMIwzj/HvFvx2LHvLahcBNNorsOQ6U01SdotLQH4lSzUSqFlMgrBKc75DtfYc+lwctls3PZBO3eksE2tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL3/Q2lSm9ZX4S4//q0FYlu59R2OILl/nI3GUpj2AXk=;
 b=h/yVFSa7jbvm+ymqw4TO4psTqJyHW4YhAOiMVC8714QXZEms38Xlno/EhByhE3lDoIlG5mhjt4P7cFJ/LfTGpVHhiRDBWwIJnx5I91j/qYTksl1M9Nck+iCef2Q3WG1TQUGoVa4BbO15Dpv9PxlImFzeEkxN4eTXMFO8dPU3FVi08PaWT0VwUOnnlsChAB9LX57LF8fwRSZfaOc7VxjkcDaaHqDjkIb1d5uVuwRnhpyiMm/iMLOn1rLVARaE920MKXBU9P+2hgVYR65Be3Y5L1TiBlKazNnOiXbPSd6a/nyJR4qsLBXHSTlqWkLcdFnw+Uc53YOb50L4O+mLOFR/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL3/Q2lSm9ZX4S4//q0FYlu59R2OILl/nI3GUpj2AXk=;
 b=QAD3xbTEPCgnHBs8dtvf8VzoMKGOTySCu0S4NBFn+tTCmqXtyXNcVYoIvAFertDmpJkSkRnn3f+Qj0KuE9WMfrpj61q9U9v/cW8Lw9k8r07w1A3UdeYxxOqGiwLp0jKSCOCweNnFSAs2VUJtQD5AKbTPYkRXPpl7jP2Duh79tK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 12:22:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 12:22:48 +0000
Message-ID: <6a82950b-070d-4fe6-a08a-3a8f795f3460@amd.com>
Date: Thu, 9 Oct 2025 14:22:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Shravankumar.Gande@amd.com
References: <20251009033029.24986-1-yunru.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251009033029.24986-1-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:408:e9::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b64bc71-e7c7-4cba-02e2-08de072e8ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUpXR29hZmJuTmsxOHQ0ZDFibjA5V3FtOUdSN1A3cmsyQzU5Um5XeXVqbGlU?=
 =?utf-8?B?NVY1dC9FZjVod3M4M1ZsM0tlQ2NVRGNvcHJuNHowRFFJZlRnTG9STU9pU2tY?=
 =?utf-8?B?STRZK2Y3L01UK0pISmpQTEJJbHNLa1lQLzVob0pjcW1SUkxJaE5NT3VUQ3VE?=
 =?utf-8?B?RnMrdllWQ0lmYVZuT1FTYTVuUzQyYzJrR1J3QjhmL2E0enFiSy8xSS80NzFz?=
 =?utf-8?B?L1dWZjJWbVQrVDgrbllpRlJSaU9pWWpreGJLSWt3ak12bG9BRGljWVRlMUY3?=
 =?utf-8?B?bTQ0Q3JPdW1rdU5RYWhrOTdvNDRIRUVpU2FwbU1zcVdyQWNKdGc2V01XQzZy?=
 =?utf-8?B?TTdBWVliY0NCbGlnM0JUaWE1N3pITjJMNXRIdzNFZ2FqTStNMHAzMG9saWhk?=
 =?utf-8?B?cjZTR0wrM3BLZUtCcTVrWkhrbGlZcm0vaHBHUk5odnVwWVRhdVM4L1FQcE10?=
 =?utf-8?B?SWJsKzA0bk1qRnZqWXhJTGM2WFl3UjF3Y3NvREQwRkk0cTF0blBpbm9hVWRH?=
 =?utf-8?B?S3dvVWxESnRtNkZPbGpvRU9rZ0dmdy9xS05icWMvN0FtdW9kM29ucm5ySHNG?=
 =?utf-8?B?ZnBZcWFWOFVHcDlaZFdUeHh5Z1ZaaVBvMTZMQ0NaNHpQQWFLMFdBazJFUEQv?=
 =?utf-8?B?RXNxcjdjL0Nncjh3Titta3ZzRzl2MVhYcG1WbEQ0aEh0SmdmNHoxMTEvSjBj?=
 =?utf-8?B?L24zeWRhY2Z3UElIbUNCRWIwVjVRQTZUa3JOVHdhUWdQczZtV1dzYWpHVmcz?=
 =?utf-8?B?WnhiYUYyZGdPcTREdnZBR0RjYVFwWVJpdVlSNjlLanZkL01OaE9SdWRzdnZE?=
 =?utf-8?B?VnNzK2VrelNjdGZHRVdVRGhkbVI0Qmkrd1pUbXphYlV0M3ljWktJanJaSU5V?=
 =?utf-8?B?MU82NGxKelNXcjNCVXp5RExBdFJibHZ6NVh0eWNtOUFtZDNHZ2lDYXVmL1Bl?=
 =?utf-8?B?UlM0ZXh2OURxdTYvZWdEMDVpS0phL0Y3UXpUWGw4d004RGN3NnhCR2pkMWlh?=
 =?utf-8?B?UDFhQ3p5R0V5VEkrOVltZUpYYXViOENaQzVrVkxYY2lIK1VSTU82UFRNdElB?=
 =?utf-8?B?NTY4Q0s4NXA2d2Z5N2l3cFErV2duVzlBOEFoTFBVUFh2dytVZFpsamJFc2VF?=
 =?utf-8?B?L0ZYaHV2eUVWR2VmL21CVGVhZGtjRFllVUVkSGs2NFJJUHpxT1BucjdJSmxj?=
 =?utf-8?B?NHhOWG1heCtqWGFDSEFwbzI2LzRDT1pJT0Z0RStYWDA3S1dxTGJZbG9nTUM5?=
 =?utf-8?B?cC96RG54SGpWZGhSdmdqWnNxNGc5My8wYkdZMnlZTzZ1K0ZXK3dsZE5zZ05n?=
 =?utf-8?B?ZWJvRjNLQ0ZKa2hHQmVwdDUraDFJUEdER1IxN0F0cWg3bkFuOXpSVnZjS2J4?=
 =?utf-8?B?Y3IzckVWeWROeElHZ2tMSFNWQzE2UXNadUZVTmtZVmcxMjZzeXBZbVkvQTNs?=
 =?utf-8?B?bVdWQ2FhT2pIUlhHN2d2RlpXRWdtV2ZRc3NMTXNkbmpTS3lvSFgvOHNBOWFu?=
 =?utf-8?B?NnpQNEs4V3B3MHZ0Q3BLOHdTdFlIUkg3WmlZNlE2M1JrTU0vKzJJcTVTd1pq?=
 =?utf-8?B?dkUzQm1ETHl6U1N2YVBtRW9iZUI5Q3FnUVZjK2lESDB3QmVVUkU4Zm93SHFO?=
 =?utf-8?B?ZGpvV1BQS2l0Z0ZucHF1MkJRUGhIWlU2VGxOVERhK1BwQmxPa1dlVTk2dXJZ?=
 =?utf-8?B?TysvZEMrMkhMOW0rWGZxbkRBc3pmbExla0VqcnZDVklKV2Z2LzM4ckxuQ1lM?=
 =?utf-8?B?Z3czQ2J3M3JsMHc5MU95V0V0WVd5bVoyT2RJVzJGOXpZOUYzU1ZKajdNMlpK?=
 =?utf-8?B?M0N0OGtTd2YxTHEvZ3ZoY1lJSUdQNnBJOVkySXpBTnZpdlJ4TlJFb2pQUTZ1?=
 =?utf-8?B?ckxTY3NMMGNFMytHREp2M0IrQXVhMGdoYWhFUkxORVpWVFhuMkNsaTdYbE1u?=
 =?utf-8?Q?ektTlHN+KK0vXXkt9BlJBD/C9yLMh+WC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUREVGV3OVRYN0xRVjJBUjVzbzZIdmVBM3RLY05mVGszMVZhM0xLZ2xkTVJR?=
 =?utf-8?B?R1hoL0lwS3ZLNm0ycVVocXBlVHhucXFsMWFwM3NnSStyYnU2T0RKbGNWMlBu?=
 =?utf-8?B?VWEvcVUzNmlEcFZEWTBVanhWZkpTWWdybG9hd2VZNFMvVEo5WE5KSmp2Z1Rj?=
 =?utf-8?B?YVlQUDNOa1F6Z29BbHNaZVUvTnNBcXZ5STQ1R0pOb1I5T1VaNGRQQ01vU1ky?=
 =?utf-8?B?NER5aGhyN3p1U1JEZ0F5SC9jQmlweFl5VVVyZ1dBR21DSGgwZlZtZEk2ZExi?=
 =?utf-8?B?UjRvWmRWNWovTjhvVGcxQTFGdlgyZXhiL1RhTmFwdWdWTnE4OXZmUkFwUm1o?=
 =?utf-8?B?MjM0c0pFSkQ3YVpoNmdrdWJHTFR2blpKT1VPeXBpVnZ4YTZWUExvSkFGeGdk?=
 =?utf-8?B?QXZLK2QxeWR1ekROejE5dER0T3UxZmlwTU9oN3B2MDRIdWplVWp2ZWZJV1Fj?=
 =?utf-8?B?VUsyanlpRXJzUzlqVk02SlhlY2psTlh0ZXpQb1JPQ0VEbmEzRFVPNjRna0NP?=
 =?utf-8?B?cEx4a1NWV09xYmVjOGU0ZUNIMjI5eEtpcm9DOGg1YkZ5dG9yVm83clkrbXJ3?=
 =?utf-8?B?VVQvc1FXSnVucXFlZm4xb1hJWnhZL2hqK1V0dlZGU2k5OCtDRXRSMUdycTAy?=
 =?utf-8?B?c3hQd1B4aVVDUnVVTDFVdEdLOWE0S2hjSjdKMEhHaWlxM1EzVkVZSzFUQlM2?=
 =?utf-8?B?bFJpTWFZYVl4bmRhb29MNy9CU2xNYVVvTm9RaXVLMkhoaFEzZ2ZHVFVJNktJ?=
 =?utf-8?B?dExjTVRwdCtZQXp3TUh1S2xZUWFVeUsxSkxyMThiaG85ZE9LQXVYTktyYnRX?=
 =?utf-8?B?djB4UUUxRG5Ub0dhTmJ4a0J0bXpRcXp4S2JhdVpuY1ZUYkVKelh4LzlUZVNY?=
 =?utf-8?B?Q1NQeWpwWWpMZm5xODRMYnFPdTg2QllXOVgvQjQ2aTVEWERORmlaTDRia2Fq?=
 =?utf-8?B?MU5QN1pwWTE1ZkQwbHhzMVdQLzY0aVNNSmQxSnNBUkQzd3RHdFhmWDNHaFQ3?=
 =?utf-8?B?SXJPb2ZOaitYL0JPQ0NOdGo5UmdSVytxRzFGbE1yaTVBRjhyZmRibjNsSTFM?=
 =?utf-8?B?cGd4a1dPdlFwazNycDV5bUlaY2k5c2k3VS8yeFFpQWs1UXJWQThPRk02TkpT?=
 =?utf-8?B?ZjhKU1c3YWozUmU5Qjg1QWx3aVNocElUTGl0ZTA4UEhxVk1iMkpoSENmVGhY?=
 =?utf-8?B?d1VNd050N21QbEFkb05uQTNPMzFJMTdhQTlQRHUrNzZTQms3VE1WeTJrSS9I?=
 =?utf-8?B?QVUxcHVrS0I1b056SGhRa2czNDg3Q1kva2dhVk5HODl5UHBTN3BzZitmZDZG?=
 =?utf-8?B?ZWdvN2l3anU2S0cwY2syQkIrY0NhMjJJSWZlWTJTaGFKcTBEU1gxRFNUYUF6?=
 =?utf-8?B?dDJybVJYRHpwbHdiZFhISk5SM3dUSFBqOElSTjFkK2hNUXRJc24vSEYwa0tO?=
 =?utf-8?B?cUtXaTVwNE0xbW5Bb2dydGE5WnZhQkY1NHlDS3plWWZlZXZJQWU2dlNEOHFQ?=
 =?utf-8?B?OWE1c09uOTZYTXZKcmsrUnZ4U1psLy84WVgwVFVkVjVrNUJ3SmEra1VKczFh?=
 =?utf-8?B?RlBUblB2MHlUOGJiN0d5djdMam9Zc0tLL2xtSysvekpiKzJxbU1vV1p3d3pO?=
 =?utf-8?B?RXNoUDVFdHMrM2k4di8rY2dsRmRBT3lkYVFTSHJOSEVLaDJTeCtFRzlhSVlF?=
 =?utf-8?B?Y1kvVStUbTA3ZGp6OVlJMXV2UitUNGtvSExuU3dKV3JPdWVHVHl4YUJxUmFU?=
 =?utf-8?B?bUpJUjY2U1VmaklZb05rd3BlSzhORUdCVHdXQkZNUExtYkVER01IVzUwYUdo?=
 =?utf-8?B?NG4wZkE3KzFFa3ZETE5IRlFIRVRNRVFtNElWbjZNNGhuUVpTODMzeXFlRTUr?=
 =?utf-8?B?WVNzcjRvSHlKcnlkYTNPR1VFSXBFOXJZdU5xdVBzb0o4eE84cU1rUnk4MEVL?=
 =?utf-8?B?MEt4ZlFuaTI3eDU5Y2NFcUE1b2wrVlhtbGpxWndSdkREdkF4UmxDZXE1NlpI?=
 =?utf-8?B?ZTQvNSswQXJXakFhS052bTBJUXpDTnYrNzVKV3NRWUwzM2NWU3B5cFhwNXpa?=
 =?utf-8?B?MmV6LzlqSDRmdDVleWxrMEZ1Z0drK1FXUjVyNXNzbWlHVUJ0cDJrWE9qNjdH?=
 =?utf-8?Q?xb8AHROmW7RgCwnDZkTNhSERE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b64bc71-e7c7-4cba-02e2-08de072e8ee4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:22:48.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQsUf9en5sdDkUdYdFymYrWh4Lfok0QC+6WU1L28kPcdkY8RllGSuQi/Y0Dww5Hj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

On 09.10.25 05:30, Ellen Pan wrote:
>     1. Introduced amdgpu_virt_init_critical_region during VF init.
>      - VFs use init_data_header_offset and init_data_header_size_kb
>             transmitted via PF2VF mailbox to fetch the offset of
>             critical regions' offsets/sizes in VRAM and save to
>             adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 103 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   7 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
>  4 files changed, 147 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 929936c8d87c..2a33b950d511 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2754,6 +2754,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +
> +		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
> +			r = amdgpu_virt_init_critical_region(adev);
> +			if (r)
> +				return r;
> +		}

Alex has the final word on this, but that looks a bit misplaced.

Why can't that be done in some early_init callback or any of the amdgpu_virt_init* functions in amdgpu_virt.c?

>  	}
>  
>  	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3a6b0e1084d7..46c19e96086a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -843,6 +843,109 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
>  	adev->virt.ras.cper_rptr = 0;
>  }
>  
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
> +{
> +	uint32_t sum = 0;
> +
> +	if (buf_start >= buf_end)
> +		return 0;
> +
> +	for (; buf_start < buf_end; buf_start++)
> +		sum += buf_start[0];
> +
> +	return 0xffffffff - sum;
> +}
> +
> +#define mmRCC_CONFIG_MEMSIZE	0xde3

Why is that not in a header?

> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
> +	uint32_t init_hdr_offset = adev->virt.init_data_header_offset;
> +	uint32_t init_hdr_size = adev->virt.init_data_header_size_kb << 10;
> +	uint64_t pos = 0;
> +	uint64_t vram_size;
> +	int r = 0;
> +	uint8_t checksum = 0;
> +
> +	if (init_hdr_offset < 0) {
> +		DRM_ERROR("Invalid init header offset\n");

The DRM_* type of functions are usually used with everything related to the DRM interfaces, e.g. display controller, render interfaces etc...

But that here is HW or at least VF->PF interface and here using the dev_err, dev_warn... class of functions is usually more adequate.

> +		return -EINVAL;
> +	}
> +
> +	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +	if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +		DRM_ERROR("init_data_header exceeds VRAM size, exiting\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate for init_data_hdr */
> +	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
> +	if (!init_data_hdr)
> +		return -ENOMEM;
> +
> +	pos = (uint64_t)init_hdr_offset;
> +	amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
> +					sizeof(struct amd_sriov_msg_init_data_header), false);
> +
> +	switch (init_data_hdr->version) {
> +	case GPU_CRIT_REGION_V2:
> +		if (strncmp(init_data_hdr->signature, "INDA", 4) != 0) {
> +			DRM_ERROR("Invalid init data signature: %.4s\n", init_data_hdr->signature);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		checksum =
> +			amdgpu_virt_crit_region_calc_checksum((uint8_t *)&init_data_hdr->initdata_offset,
> +				(uint8_t *)init_data_hdr + sizeof(struct amd_sriov_msg_init_data_header));

Please make sure that checkpatch.pl doesn't complain about the coding style here.

Regards,
Christian.

> +		if (checksum != init_data_hdr->checksum) {
> +			DRM_ERROR("Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
> +						checksum, init_data_hdr->checksum);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		/* Initialize critical region offsets */
> +		adev->virt.crit_region_base_offset = init_data_hdr->initdata_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID] =
> +			init_data_hdr->ip_discovery_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
> +			init_data_hdr->vbios_img_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
> +			init_data_hdr->ras_tele_info_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
> +			init_data_hdr->dataexchange_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
> +			init_data_hdr->bad_page_info_offset;
> +
> +		/* Initialize critical region sizes */
> +		adev->virt.crit_region_size_in_kb = init_data_hdr->initdata_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] =
> +			init_data_hdr->ip_discovery_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
> +			init_data_hdr->vbios_img_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
> +			init_data_hdr->ras_tele_info_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
> +			init_data_hdr->dataexchange_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
> +			init_data_hdr->bad_page_size_in_kb;
> +
> +		adev->virt.init_data_done = true;
> +		break;
> +	default:
> +		DRM_ERROR("Invalid init header version: %u\n", init_data_hdr->version);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	kfree(init_data_hdr);
> +	init_data_hdr = NULL;
> +
> +	return r;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>  	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 2a0627596bd2..5f6014b2f349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -292,6 +292,11 @@ struct amdgpu_virt {
>  	/* critical regions v2 */
>  	uint32_t init_data_header_offset;
>  	uint32_t init_data_header_size_kb;
> +	uint32_t crit_region_base_offset;
> +	uint32_t crit_region_size_in_kb;
> +	uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	bool init_data_done;
>  
>  	/* vf2pf message */
>  	struct delayed_work vf2pf_work;
> @@ -428,6 +433,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
>  void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_virt_init(struct amdgpu_device *adev);
>  
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index b53caab5b706..d15c256f9abd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
>  	GPU_CRIT_REGION_V2 = 2,
>  };
>  
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
> +	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +	AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +	char     signature[4];  /* "INDA"  */
> +	uint32_t version;
> +	uint32_t checksum;
> +	uint32_t initdata_offset; /* 0 */
> +	uint32_t initdata_size_in_kb; /* 5MB */
> +	uint32_t valid_tables;
> +	uint32_t vbios_img_offset;
> +	uint32_t vbios_img_size_in_kb;
> +	uint32_t dataexchange_offset;
> +	uint32_t dataexchange_size_in_kb;
> +	uint32_t ras_tele_info_offset;
> +	uint32_t ras_tele_info_size_in_kb;
> +	uint32_t ip_discovery_offset;
> +	uint32_t ip_discovery_size_in_kb;
> +	uint32_t bad_page_info_offset;
> +	uint32_t bad_page_size_in_kb;
> +	uint32_t reserved[8];
> +};
> +
>  /*
>   * PF2VF history log:
>   * v1 defined in amdgim

