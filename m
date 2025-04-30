Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E83C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 05:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFCA10E06C;
	Wed, 30 Apr 2025 05:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jHGvM79q";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74EBF10E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 05:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dijoJucKz4rOsJUnRpdxqnWdw0gOlGnwnvdasKxbjSyxPCcmLc/VR0NXcYzZAzsjX9lyeg3vL/q1uXaNG/Eg3XJGHmJAf93BN0Yv/6yqjGKDiGBlfaUba5QJRNzz5SXT3994wYytbdiHSsgPXOYNmVnhEp469nFQmRFEFrmEVGyPljcinL7PM0oO0u/zCfguGmWMy09uzdeADyMdjwRB9qEM3zsCOQSNzwwALUSeexC0JFmKFnqnTttrm2o2luTpfVqhUXr271lpbM7k1wWrIkzYjrpV2/W1yGhsor/kGRp2kyhlSKytG/6ucczXxJtkwxYEcTFr1Byz5RFrWNYuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZQ/gcQP+gJXgf8TmcXCgXXJiGuBek2EMDTLoX1CEGI=;
 b=Tz4Lm+IhxpIKdSIaCDltIR8ltN3r36cfiNlC13gcfXKuivFWVTdKylVZpe3w09ZEOwTp//wTdQhz29NEYsvlxJX8y9JVXpouAp1i7KigdEI9oGTCRX1lg37oNFRFJxUF4/YPR6K49Lu6yawkMxJpfaoTLf1sWQtQ1ajS7G5TkbVaJ0kO8xFZiDsMtAplaS+atrBdRWZsNgI6bQ30+q7TILMq0GI33rv1jezfHERpPF5ojjoZIQruAVOn4QzOnM6ZEnMC3Q2XACEhYmBWbNwdSRQzxDK/Tu/Ak2ACPki/B32oEQv+q1ivg2WWJoPfCZTFwEcEvsVPo9dbELrHvBw20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZQ/gcQP+gJXgf8TmcXCgXXJiGuBek2EMDTLoX1CEGI=;
 b=jHGvM79qh1Vf+foWX4PWWtl6bz5aoPUxzPCrPfpBdF+fnzrGCEsBdrNTLuYsA5WWvb1/yJSJb6Xlx4/wh2RWI6wpC70+qw4J7zgpPWPrOGUqMSmVVJlVSfUI3tor4X/R8tP7fRCxpBAZJq99kh24eNEE6WV/paYV4veJYfZUfSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 05:04:37 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 05:04:37 +0000
Subject: Re: [PATCH] drm/amdgpu: properly handle GC vs MM in
 amdgpu_vmid_mgr_init()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <Arvind.Yadav@amd.com>
References: <20250429175022.1636538-1-alexander.deucher@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <9379f31c-392e-4ad2-d19b-f2c1a6917208@amd.com>
Date: Wed, 30 Apr 2025 10:34:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250429175022.1636538-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: d83cd750-8460-42a4-1b96-08dd87a4817c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXNqVW5QMHdFK1E3Yk1XSG1GK3VrbWJ4aFQ3dnNUc3JrMkZXRWsrbTl3VmVU?=
 =?utf-8?B?R29LSDlRUCtJaFQwSVNoS1FJVXZuK2RpN0RIMG9maDROaFRvNzk0ZkJZb1dZ?=
 =?utf-8?B?MUZqeUVIRnRvV08zdzk5TEROVGVkRUlydUY3WWIrSzRYa0s4NGw0NDlvUVdQ?=
 =?utf-8?B?OUxIZUdEeW1WZlZoME9ndmxJcDB3MEpqT3crNXlScks2OVZteGVhVEZYaS9w?=
 =?utf-8?B?ZGw0aXhsclNnYXFTeVQyR0RMLys5aGdleWZIRlF5R2tQUVNDUVhBZWtuSGR1?=
 =?utf-8?B?TnBYdlVHa2NIK1FoNkdVSDRRZHExZDFabE9YcmZxcUM5SFpHY3pPUEJiYjBx?=
 =?utf-8?B?K0RuSEw4SWxnakFVbUQzaktPaEk1L0xCMUNYVS9KVG45OW5wMjFLSFVyZnBH?=
 =?utf-8?B?U3c1SGRSYllvem5scUZTVUlkQ01MTnBvNXF6b3YySE90eVYxdjhTa2VyeUNy?=
 =?utf-8?B?ODhGdGh0WmNxZkowM0tPY3Rya1l2Yktsd2xuWjhibW1zM2VxRnkyUnRYWnlo?=
 =?utf-8?B?SFNQa0F0V2c2bTQ4dm1ia3pwdngveTU4bzk4QllpWDQxSnZITzZEMjlZWEdy?=
 =?utf-8?B?aWxkRmFQdjNzZm5OakUwc2p5bUhFR3FqYWVjcElQY29pL21IYW1reklYd1RG?=
 =?utf-8?B?dnpLZkM1ekNRamdMOFhRQW5MSzRjRUtGTXNHMVJ0dk93UnFoZnFvSkh2UFpK?=
 =?utf-8?B?R3FVZ1Y5djd4c3FDandzUndUYUkyQVZRZnYxVG4ySTNFUEtqeFgxSXpzT2Fl?=
 =?utf-8?B?dlU4bWVOTVk3NndPZ0JGU1dSbWRranNVeUlBN2doajA2dzA5dTFpRnI3QnVs?=
 =?utf-8?B?ekxKYkd1SExFQmp5by96N2pYUWNQdjlRYjJLYnpMV0tjaG5tTkxjTXFyWXdv?=
 =?utf-8?B?bVdpTk9aQmdlbEJhdk1NdnU3UWZtMCtVa0d0ZWJFTmFiTGx0L1cxRysrU1h1?=
 =?utf-8?B?eDZJOEpJOFRVUWhnVnF4QlBBYnFuN0gwRzhlUHYyZDdIbGZNSFZmdE5qcUE3?=
 =?utf-8?B?enhqbDhTalUrcEs5K0Y0KytaNUFXZmEwcm9QNmZpZThZOXZQMHpvK3B4cHNn?=
 =?utf-8?B?czQ5RzdMc3FiaFM3ckV3MmtGa3ZFNnhYL3AweWlOcDZ3OFEyeDF6bGVVUTJs?=
 =?utf-8?B?c0xTc3RiVk5udExNZmVvcDJmaysyN1VGQ0NEV3ZzaVRvVWQvMk9FK2VQM3ZT?=
 =?utf-8?B?R1Byb2U0N01iZm8vUnliQmYwTjZJR2x3Z0YrTmJXZzdGMzgvcXEwdTZOMDZi?=
 =?utf-8?B?MWRJZlZSQjE1aDBiZmUyY0FzUTJTRitSSzcyQWZGSStObnFteGdCYVVFb0hz?=
 =?utf-8?B?NEYwbUZIcmtieWRidWZvQ3FiOEZHeUUxQmRtS0N0VFlYNG1yWEkrZVB5SUMz?=
 =?utf-8?B?Y2ZhaXdyOVpjdHh0a3piaW80VnIzdkZ3bTMrbURYSXJWRG9RZXhrSGZzNm51?=
 =?utf-8?B?ZnRoQWpUU1hmZ2VWeDRuaU9qd2YwSzJTNHV2MktrNjBlOGxxeTBXYUNEUE9t?=
 =?utf-8?B?U2RWK2dGY1FDa0RYQ2IrNDJPTVVBdHExSEdRQ3VRdmtyb1ZDTmxDZXRXdDJJ?=
 =?utf-8?B?c00rVnEwcjcwcGRDTWc4OFJXeXJtN0xlY2VlNG1xM05ad1I2VzdBU3BTRDE4?=
 =?utf-8?B?ZWdZRWtvTWpXMURLYnk2cGdXa0J1MEE2TUEwMEhwczFSM1hBYUZ0d1lXVmpr?=
 =?utf-8?B?dmptalJUbm1RaCthbThwRzFObTBOWUVnRUF4S01aMHhzYlNaRFZoNjd6UVlo?=
 =?utf-8?B?ZENsdzlyWllZbGxOMDRmdllDalFEVjlPYUR2QmlXTXllbGpKRWoyUWJiT0pr?=
 =?utf-8?B?RXE2NzZBOVo5aXdRSU1UNFdlQlIzRzY5QzZUSmpZbU1uazk4dklST0dOc0tQ?=
 =?utf-8?B?N0pKYjhPelhRa1Q1V3kzVlorck9rdWhvUXpaaCt3YmpaN3BjU2lvTThxVmtY?=
 =?utf-8?Q?dBBD79+zRUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFFCcVdBcE1pN2k0azZSMGdxSk1aSDlUaEl3Z1owblBUSytXYXJxL2c4VHBq?=
 =?utf-8?B?UnpNWG1lUUszV1lnRXN4bjhLUVdTbG1JWmFxVW9Dd2pydmVUak8yRGZkVnhK?=
 =?utf-8?B?MWxiNVVKNHAzUjc3VjhlNkE0Q2VuUGViYy9ORGtnV2dYNTdQclo2aUUrbjQ3?=
 =?utf-8?B?aFJsTHJxcjVEZzgydm9zTHNPV3hjVDFVeDhLV0YrMXNudVArVXcvc2FQdmdR?=
 =?utf-8?B?bzhCd2xoMEUrTE1lMUJ2YVRCL2pJcmczOGQ3VHd3ak1ZNzVQYXIxdHB1dlFC?=
 =?utf-8?B?SmRaZFRRUnQvUzVzeVpvSEVOdTd2K05xZTJsbVFnWi92c2t1VEFRQ3NUNXpS?=
 =?utf-8?B?UmVjYUllL2JZU1hRMHg4WGtmRzA1bjNPYVhsaHl3OEtZU2kwTnRZN2VkanBa?=
 =?utf-8?B?aTFvdnNBZFo2RFQvY25FWENEYksrc096UVRybURqK2hWbEozUTVwYURjd1l2?=
 =?utf-8?B?RlArRkZNa3h5SWpQS2EwUmtRYkhaUWZVNEp1VzVaSUkrckdQMXBpUWIwajBj?=
 =?utf-8?B?OWdvZjQvNzBuVXMwV3I0K2FlbWltZWhjSzRzSWdmaWJYdmkvU3NPL0VCTXV3?=
 =?utf-8?B?WkZBcm12eVI3cjA4akFUbEpQSVNNYWR3VlNrZXBkb0pVSVYyR1lMNCtiOCs3?=
 =?utf-8?B?RVZsSkJkZm1WTU5vb0ZNaE5QdmI5Mnlzdy9CVUlEWjZJN21wWDIrNDJ2WGxC?=
 =?utf-8?B?cVFlSnNnZCt2QzhSSWIweHpTOUVPK0t4US9yUzFOcTlVc2pQMzdIdlJaRGxr?=
 =?utf-8?B?V095dmtxa1hFdkVDRE16WEprT1RNdThHcTkvWW0wVWY3YUswYmFvNHpMSGly?=
 =?utf-8?B?Rk9nSHdya3loSHZjc0hLU3ZrWDJzbG54TU81Q3VWWGs4VG1DRkNYelhYR0VO?=
 =?utf-8?B?V2sxWFFGQS80ZW42enpwNUtmZUswWkN3Sjl2RmJzcjZpZzd3SndOK0RMVkpF?=
 =?utf-8?B?U09nakpGalQzVm5qVEhDQ1cyRDFPeG0zRGJHOTBlZTFYNkR0SURGUmJLYXZM?=
 =?utf-8?B?cG43T0IrMHlFbFpjeGFtRmg3SXJPRWRrQ1Y0bFZKSlJzTUVRZFhsNTZWNFlO?=
 =?utf-8?B?Tll4SXRYemdQQkQ4RHRIcnM3aE9oUUJ3aTNBNHZRR2ZoT1Z5ZW5XTWZSbW5a?=
 =?utf-8?B?R0EzcDlBYlppdDlhVDBGazVBQjNZcWJOZ2FVc2dUWGVCYm1CTFNzZ0RpNzBB?=
 =?utf-8?B?dFFNMWxzZktxMlByQTdtSTVHY3NBNTZ6NkxjNjJybis5VGZibDA0SXFQSzRX?=
 =?utf-8?B?L21RWXcvWGVSN1p0R2YzdTdxUDJwVzFmbXU3bjAyVVZqeEhTSDM0cnJJdTBE?=
 =?utf-8?B?aWY0aEJoeE56UHFpNDcxNmR2QlB0cGRQOW0xNiswTmZPZURvS25uWm5BQW5N?=
 =?utf-8?B?eUh2VzF2V1FpU29WVjZtZmRuRW95K2hCd1lWTkVwaXRBWjdSZ2QvRm9PZllD?=
 =?utf-8?B?N2ZHK0V0MXR4SklvSXM3b1VxMzN3RnFycEZTNG8wckVXZmcvUkUrS1l0VGJh?=
 =?utf-8?B?MExDd2gvaFJDZi9Xd0dPaGFjdlhaS21aYzFqS0xaREJmU3lwcUYrODl3ZXJy?=
 =?utf-8?B?MmduVlNTTUFLRmpIcVpTeUh6YzUyNjRHeG1FQzRQZWt2ZWNlczNGYmJ4enZq?=
 =?utf-8?B?cGluMEZtc1FnOWIxVm40cDEzbDlCa2tQZkQwRFljWEZjQ2NwWlZvMDZxZ0dG?=
 =?utf-8?B?Z0E3eGhGZnRsRlowdGs4VFJ0c1Jyc1ExSVd2cy9LSW9ncHQ3d2JlWlJKSWhm?=
 =?utf-8?B?WUpoRXlPaDBOTFRRRURNV0p0ckJkSnZQS3pzNlZBOUtIbWd1czM2NVIzU29J?=
 =?utf-8?B?VmhuaW01ZDAxRjdHdm9IMmc3RmorL3JhdkdZVGpjMmdZMXpJTzhKOEd6YU9P?=
 =?utf-8?B?cDRtS3U4OGxub2gxNjU1bTFtS0JVVjNWYVJnd1dWZ0cxbVBXOEp0Rm1IRjNs?=
 =?utf-8?B?eFFPaXNaM2tWOGRnLzRVTVpYRDNRRjBmckhoczEyZS9Gdkxid0tDd25nbUNo?=
 =?utf-8?B?MVVOall1dHo0cE82MkMyUUVzVnZHcEgyd1UwRER1bzFTemNoMnNSTHFCRzZP?=
 =?utf-8?B?eGlYWE5sRFd3bzlPbm1WMWNQQXZzbzZQMnR2Z2wrbitpemtaZldmRDIzWGJi?=
 =?utf-8?Q?48LwmuVfk64qTwVQleqhely/v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83cd750-8460-42a4-1b96-08dd87a4817c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 05:04:37.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBwiygpY6DYjpAFWddw8V65sJf09aCl7OhOfHksPsATdOInqsogMHc4hSMDDlEiIFtgMC1skY8oIqhLNub+5Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 4/29/2025 11:20 PM, Alex Deucher wrote:
> When kernel queues are disabled, all GC vmids are available
> for the scheduler.  MM vmids are still managed by the driver
> so make all 16 available.
>
> Also fix gmc 10 vs 11 mix up in
> commit 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")
>
> Fixes: 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")
> Cc: Arvind Yadav <Arvind.Yadav@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 2 +-
>   3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 359c19de9a5b9..c7a6d40ded5c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -576,8 +576,12 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   		INIT_LIST_HEAD(&id_mgr->ids_lru);
>   		id_mgr->reserved_use_count = 0;
>   
> -		/* manage only VMIDs not used by KFD */
> -		id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
> +		if (AMDGPU_IS_MMHUB0(i) ||
> +		    AMDGPU_IS_MMHUB1(i))
> +			id_mgr->num_ids = 16;
> +		else
> +			/* manage only VMIDs not used by KFD */
> +			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
>   
>   		/* skip over VMID 0, since it is the system VM */
>   		for (j = 1; j < id_mgr->num_ids; ++j) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 7648e977b44bc..a3e2787501f18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -896,7 +896,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * amdgpu graphics/compute will use VMIDs 1-7
>   	 * amdkfd will use VMIDs 8-15
>   	 */
> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
> +	adev->vm_manager.first_kfd_vmid = 8;
>   
>   	amdgpu_vm_manager_init(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7f5ca170f141a..917d894a1316a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -828,7 +828,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * amdgpu graphics/compute will use VMIDs 1-7
>   	 * amdkfd will use VMIDs 8-15
>   	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>   
>   	amdgpu_vm_manager_init(adev);
>   
