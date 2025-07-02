Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9409DC83F04
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 16:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3813E10E746;
	Wed,  2 Jul 2025 16:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bcJkhHn0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35B810E744
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 16:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpthh9W8pt4eh2JvXkajlfk86La3rDiOWTATRpa2omVwbyh7c2aH5vWk3JcQ/GJATlyg51dOBidG+ojd7eRV6dJzquR0YjsO1ucILa34m/LMQlcSoGwWaTBBoQzS+9cU21M9XS9s1xM3+orCfj7oXmGo2abPO0AkbUZwgr4s6A0tCVerlxJ+sY8P/XatMNydtAwE19zp+fz66hyqQw2dFclXfO4Vh+t0IRnVmTv7eHTGUjzzOrHRYMNVJ2W8QdAUFb/C8hGl9Av3B8sjjqZR315fGpeH0s+9+rjr4QDiJ0pHa538ZEoXv6ePbn2x0IypmNFuYdoPy3jpTJQQ1ZoK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rQYXeKD3MjnTfAiWCPCMWbNxxH9ZApZfTXCJKpQVo=;
 b=kzd4NaQkDvBvjaOcqZhH6rOEt4zBJfHoLf6FU8wWHutUfhw20hj/L+TuUnw+7J9m8l97Dhi/TUbZVQVsCApUBQdgPIAbWATtm76qX59ZFC+c3pIlBRQX8INjJIi90/Frxn8RA811n3zoGWUFoaUpkpNoiB8WCrdmwtBGtFAsO2tkRhMYpjJY69otPcYI2jITqOm/kb5mV4IQdui1o5JK4AwNUde6NWIRJ8DRsFEkGveNNpiqcyQBDp4ONqWwOThGZLveFyjPmYzlCWrP7ghWo1UV4ylHmZ5Ef+JvDlNuXSKNurHrLphXs22lTpMlZaOjv+Qnhr1i7AQgxgv+5fgWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7rQYXeKD3MjnTfAiWCPCMWbNxxH9ZApZfTXCJKpQVo=;
 b=bcJkhHn0oj/Ip0vuWqlZ1kdFfAIXOt+TDuEtm1oVGsI0/Rlu496MwbVL3V21QO1xLWHmsgpL/UMhYL6W/toM3LNBjcnSHtmb/RRf+eoxCZqgwIH4pHX7GyOV2B8lGwo2Ts1e+Y9wImczbpZPS7PAJx9vg9uHAhluHklt2YCXjMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 2 Jul
 2025 16:21:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 16:21:20 +0000
Message-ID: <bafb01ed-562d-45ef-89ff-1b20a11378ae@amd.com>
Date: Wed, 2 Jul 2025 12:21:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: rework how PTE flags are generated
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 david.francis@amd.com
References: <20250606125723.7822-1-christian.koenig@amd.com>
 <20250606125723.7822-2-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250606125723.7822-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0343.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6c14ea-f9a3-457c-7534-08ddb9847ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFpDSWNZZUprQUJTQlhYSDUxSUVQZThVcmRxWVFNQ283eGxpTGJsRHYvR2hE?=
 =?utf-8?B?Qk4vS3B0RElHRHRxeTVMcTZsOUVYeUZmYkJydURBcXJGaSs0c0g2eE1QY2hS?=
 =?utf-8?B?OHZvaDd1bzRLRjdVQnV1MDJYaVdvU2lFQ2FrNG9jbDJWUE1UQnZtdDdJN1ZO?=
 =?utf-8?B?b0FQMGsrT1AwTjhlMGZpSmJVWG1VSHgxdlZBNms2WDhBSytoVStCcTVMcGhp?=
 =?utf-8?B?dWdva0FDaVB6UkZ4OHY5dTdnUmFwcEZ5M2hrM3hLRGxRbnNwRWdibnNDTHpz?=
 =?utf-8?B?OHBVdWJ3a25pS09ISm1GMm83ZkJ4RDU3SzlDbzI3dEtyRjNDRjJTV2ZmaWky?=
 =?utf-8?B?dVErdyszVSswSUFXT1o5amwrV0RxTGIweXJuTUxJY2lTWVRtdEh1UEZ2RHMv?=
 =?utf-8?B?c2EyOWJsRDZ3RnNOM2U2cjBrRmJjYlBYSCsxRFpsUE1VRDlaZmJESGpiT3Bi?=
 =?utf-8?B?NVBOMStLSjFqQXpBK2JkYVp5aTRPMHRIMG0yc0txMkZQT1BxcUwxdWxDa3Ix?=
 =?utf-8?B?aHRFTVgzL1dCekRtMFBCempaaVVLdkFFRVRlUGVyb3YxS3BnMFZCZnNNdkI4?=
 =?utf-8?B?eklPTXdFemRCZkpIZHBkYXVYNWxUbnc5OWszZjBSUlp4M3FiNWpsL1BPYk9T?=
 =?utf-8?B?d08rY21qdUJqVjJiSWNGYms4Wi9pNFQ0Rmk2Mm9PeTlFZ05wcitJTFNEa1pM?=
 =?utf-8?B?d3k3WWZDL2dxczFlNkpUd2RubkttOWorSFFCSFpwNHU5M0dEUkJ6RTdHTUlw?=
 =?utf-8?B?bUtmMVgwa0NkUGd5UjhITVF0Q2lQOWpMVXd0TkQvclJBc1BFUVhpemtBd2Ra?=
 =?utf-8?B?TEY3WEI2SU9hOUpzQzdXb2NKUHFtSGY4cnI4ekt6eDZQN1FlbW1WZFhERlI4?=
 =?utf-8?B?b0RQbDk4eS95dFlrN1pQMUhydjUrWElTWkVQTksxSHR6SFVMckZDMHhCS0Zr?=
 =?utf-8?B?ZDZDam9EcnFPclBmbG91WXlIREh6ZGFOQnNHaDJoTlgyajQ3aEZ1ckJlNXV1?=
 =?utf-8?B?VzF0R0MzYjVTb2plSTQzM05QQjNaU1hmWThhNDYxOFp2TGdCQXV1d3dNdUov?=
 =?utf-8?B?eTk2d0c0Y0VkbnZSdElobThiNjNIYUJTMVQ4aFljeVI1RFM0M2t4OXhHejhL?=
 =?utf-8?B?TFJ0SHN0RGpYN3hJWlY1U29ZUU8vaGJIVVVoR3pNUjRlNFEwelpXUFBBSi9l?=
 =?utf-8?B?aXozZXpOSnRTR0hvN1RxQ3daUnljaDVDNFYwREIvNGpLbEQzNGFZcnpBdm9p?=
 =?utf-8?B?Y0dpaUxGd0xJUDd4eHMreU1qNTJqR1U1d0xNNGZ0M3hGMUJCTkN0bk9zYWhi?=
 =?utf-8?B?alBGUXREbXNRWWxld05kWFJTSDJQZ2ZQSUtGUFgzK3pPNEg0QVBZKzN6R3Mw?=
 =?utf-8?B?ZHhYYzlsWDNXTk1LcjAycXptWndkS3hrSE8zNGFzZGxOaU51Q0tWMVpVS2RG?=
 =?utf-8?B?N1Y2YWdFcnoyNUVyQ053R1VQLzNLZWRPZGxBb3hEWGZGU2MrSGJhS0x2RUkw?=
 =?utf-8?B?c1RmOFI1N3dtZ3JLS0RsOU81ZzBWdE1vc0VZdmZ1N0Ntek1yMjQwWk1DbTRI?=
 =?utf-8?B?RG9YU0JUa0ZzaGY3NDd0c1BvdzQzcU5RTmt1WTM4T1gwY2N4emd0TTcxaUxP?=
 =?utf-8?B?VmNsckhzaFlrcTE3YW5TQlg2UjRYNkU2akpWKzYvVXg1TjdWcjZ3UWQ2TVpB?=
 =?utf-8?B?VEhlbDc3UXJ6Z0ZxMC9XUCtVbG5ZQU1iU1FnT1VybDE1OUs0V3YrV2dGQytw?=
 =?utf-8?B?WHY1Y1o0UXJjdXIwVjdVbUxjby9laXNQTVZVVEc5U1JVS1EyeVlYR2p3UHg3?=
 =?utf-8?B?MlhCbHFPcTd2R3A4WEZUdXFsSG1ybUFyU0duMkFHaGZ5YUpJdllzckVCb0Fy?=
 =?utf-8?B?eFJ4dy9nOHNzeWtQMWFNYnJyVUFDVldYM1ZjTDNQQlVuQVI3K1l4TDREbDZ1?=
 =?utf-8?Q?46fdXR8/E9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NLNGlxM1ozZzN0blF5bjZmNWFRUVhGbVB1MEk1UmRBeDhMZ1l1R2lNNkow?=
 =?utf-8?B?QkNwYmsycmprVFV2WGZuRmZMbDliaTdPZ3ErdzlmdkgvOTZrNFlQUkp1YTZu?=
 =?utf-8?B?Q2xrWnpjWWNaT3pTc1dyenY0ODZFZlJvazVpQUlESGpjRGt6KzRYR1ozdU9l?=
 =?utf-8?B?bmtyRTk2aDdZUTZNTmRtSVhkNGtFYU9QMHE4eTJwS0daZzVXR2tkN2tQSzZN?=
 =?utf-8?B?NTgyTW42MCtQZFJCQW80ODVrUFJzYkFHZWxPN2t3bmV4Q2pqd2NKMmxoaG9a?=
 =?utf-8?B?V29EQ3pwaXhNV0hRQTVBdVdtaHpXNEFNcllmMWZNcFZrbTFxNzlPUzFsd2RB?=
 =?utf-8?B?TWxJTlhJTW5VZnpNcUh1VTkzWnZVR0lDUWZQZTJqazcwZ3JKK0VDTEFvL0RW?=
 =?utf-8?B?eDZEeXBOQnFTMnZzS0ZvTjV1Q2dQWmlPVngvWFRPZy8xOWxwUWNyamdTNldz?=
 =?utf-8?B?VlJFeTh1Z3JmWGhDTVM5WE04UnhpbFZ4UkRGZFBCQTJhTWQzZGxjd3FhdHBu?=
 =?utf-8?B?UWxhSEtUMDhzRTdpMDJNb0NIdUZLOERjMWZkYlZMVzB5Uk9SdlZRVVh1N0VE?=
 =?utf-8?B?ZmdLeFpPSFM4VEdwc3VTNXZlRTkvN2tRd2crbEozS0dGQlhFbjBidm4zL0tV?=
 =?utf-8?B?d0UxK0R1U0NrM21hNW1ZVkRsNUhQRGFZckgvTWZ6OWRINGg4TTZSSkdKNVlz?=
 =?utf-8?B?Um1zemhKamF0MUMzWlVPYXJ0NUg2NG1zbmNqMHJLMTAvU1dUTFhZRGttWjZV?=
 =?utf-8?B?Ti9rTWdJMGorWFV0REttTUNKeHRBWGxPQ1JmMHZRT2lKbjVIWkhGM1NlZXZu?=
 =?utf-8?B?TnlVSUhIOUQyOWRLL1IyUDllZC9icUxyTGRicFdvdmY2K2dLK1hHWVNDNkMy?=
 =?utf-8?B?NU40QjNkcWtUR1hVZnVPSnEzZmVKV1IvZkRqY3VYUFhFSkNmUVVRMjRpcktD?=
 =?utf-8?B?OCtoQmJPeC93d0RQVHRSSHhJcVJ2QytscmFoZzhHcXNBcUxpcXNVUWM0V2c5?=
 =?utf-8?B?MWFQN1NvTU1Ya3REM3F4ZkhxRlhWbGFrd3hKS2FuR044ZENPOW1yZlRrQkxr?=
 =?utf-8?B?OUh5ZndFaEorZjBZREFia0FZQkR6TlhvNmVOdm54c0pmQWk2VkZ4c1BxZ1Zv?=
 =?utf-8?B?SFZUOG9aQUV3bDdnQUVMbDFMMlpvVnZqZkVXMHNlSnlpZnR1ck1IUVdFNWhB?=
 =?utf-8?B?b1UySkZvZjRXUk1hazNWMEcwOVlLN3QwaFJwZXRlbU5wNko1Ykk2ZjIxelpy?=
 =?utf-8?B?LzBvdEVFcHFVZmNWdXF2bmN3RG5yTmYvbDU1UFNYcmRZM3lDZXpqbkwxOU16?=
 =?utf-8?B?V0VnQ2hQU05McmlQRmd4clEycVdTL3pXNk8zTHVLT2VoQ3ozRjVQS0tmMW96?=
 =?utf-8?B?eUZNYVdxUGQvVGFuZjVIK1JRWVNFSGUrTCtDUWUvN2pRV2dkYVMxUHdNaUVt?=
 =?utf-8?B?RW1rSTlWOGdmeEJlQU4xd0VHbWFYVEF1aHp4ZUQxVGp3Q2hqOWcwTHZja25v?=
 =?utf-8?B?VzlMK3V6WXppaEFNUDdFb1ZJaFA4VWQ0Q0IwVG12MUpkL2ZtcStodFRlQ25m?=
 =?utf-8?B?aEp5akhGTEVPemZJWERIQ3hxZWdrUUxCMFBDaVh4a1R1bmk1Ly9jbnV1Zm56?=
 =?utf-8?B?N2RrOWFlNHYzaDJ5bWRzN1IyUlR6ZDNHSG9xOWQxUjh6UFdZVzJWNjBiTjVQ?=
 =?utf-8?B?QUE2QlNWWFVRTVNzS0RneW0xazMxMmwyR0VxWjFqSXFkNGRBYlFIWTdNQW5M?=
 =?utf-8?B?TkdCcFJrRlJ3VXZ3d0N0NTE3eXFWWkR5aVBIcDdyaElFSFMxVVp1MGFVV003?=
 =?utf-8?B?Wi9HRm1kTWVtSHpwUDJiS05kR0x5SVphWTFEMTV6RXZ5MFhhN0E2Z1hmYm5n?=
 =?utf-8?B?ay9YbkxaM3RXNlZ4RFFKdllsbjRBQmxxb2FCYjFiNGJza3YrcDNKd2ZZSUVl?=
 =?utf-8?B?UzNadmVCWW11UG96a1RIa1NWcURjV1FVSTA3ZHd6R2YxNUtoOTYweGlncit0?=
 =?utf-8?B?bjJWazh4bUs1YWdhdkgxS0R5d2wra0dqQ0NFMDNjcmZWUWZ4bCtTOTZ2SU9X?=
 =?utf-8?B?cjhzQThMTjJrWFpUTnZWejRPMWxUalVrcnE0TUszVlpwV1NMSk1uL0I3MVV5?=
 =?utf-8?Q?KUhEGoF+qP9b8ur89kF9wsPgj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6c14ea-f9a3-457c-7534-08ddb9847ac4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:21:20.5170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PlZRdgW+j7IiRk5fr2YFMhzLY7udAEN/pOqGQE7cvrtnlXzVJ/P7BM61Kqxu0o722Y5TpJvl4xz3VryViZ1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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


On 2025-06-06 08:57, Christian König wrote:
> Previously we tried to keep the HW specific PTE flags in each mapping,
> but for CRIU that isn't sufficient any more since the original value is
> needed for the checkpoint procedure.
>
> So rework the whole handling, nuke the early mapping function, keep the
> UAPI flags in each mapping instead of the HW flags and translate them to
> the HW flags while filling in the PTEs.
>
> Only tested on Navi 23 for now, so probably needs quite a bit of more
> work.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 37 +----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 15 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 17 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 57 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 57 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 56 ++++++++---------
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 10 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 61 +++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 +-
>   16 files changed, 161 insertions(+), 187 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 260165bbe373..9e66d6108a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -494,17 +494,20 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
>   	return amdgpu_sync_fence(sync, vm->last_update, GFP_KERNEL);
>   }
>   
> -static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
> +static uint64_t get_pte_flags(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			      struct kgd_mem *mem)
>   {
>   	uint32_t mapping_flags = AMDGPU_VM_PAGE_READABLE |
>   				 AMDGPU_VM_MTYPE_DEFAULT;
> +	uint64_t pte_flags = 0;
>   
>   	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_WRITEABLE;
>   	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>   
> -	return amdgpu_gem_va_map_flags(adev, mapping_flags);
> +	amdgpu_gmc_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
> +	return pte_flags;
>   }
>   
>   /**
> @@ -961,7 +964,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			goto unwind;
>   		}
>   		attachment[i]->va = va;
> -		attachment[i]->pte_flags = get_pte_flags(adev, mem);
> +		attachment[i]->pte_flags = get_pte_flags(adev, vm, mem);
>   		attachment[i]->adev = adev;
>   		list_add(&attachment[i]->list, &mem->attachments);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0ecc88df7208..1e335ffbf2df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -791,36 +791,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   	return fence;
>   }
>   
> -/**
> - * amdgpu_gem_va_map_flags - map GEM UAPI flags into hardware flags
> - *
> - * @adev: amdgpu_device pointer
> - * @flags: GEM UAPI flags
> - *
> - * Returns the GEM UAPI flags mapped into hardware for the ASIC.
> - */
> -uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	uint64_t pte_flag = 0;
> -
> -	if (flags & AMDGPU_VM_PAGE_EXECUTABLE)
> -		pte_flag |= AMDGPU_PTE_EXECUTABLE;
> -	if (flags & AMDGPU_VM_PAGE_READABLE)
> -		pte_flag |= AMDGPU_PTE_READABLE;
> -	if (flags & AMDGPU_VM_PAGE_WRITEABLE)
> -		pte_flag |= AMDGPU_PTE_WRITEABLE;

I was trying to see where AMDGPU_PTE_READABLE and AMDGPU_PTE_WRITABLE 
are being set now. I think it depends on amdgpu_ttm_tt_pte_flags. But 
that never gets called for SVM ranges. That's probably why David found 
SVM to be broken.

Regards,
   Felix


> -	if (flags & AMDGPU_VM_PAGE_PRT)
> -		pte_flag |= AMDGPU_PTE_PRT_FLAG(adev);
> -	if (flags & AMDGPU_VM_PAGE_NOALLOC)
> -		pte_flag |= AMDGPU_PTE_NOALLOC;
> -
> -	if (adev->gmc.gmc_funcs->map_mtype)
> -		pte_flag |= amdgpu_gmc_map_mtype(adev,
> -						 flags & AMDGPU_VM_MTYPE_MASK);
> -
> -	return pte_flag;
> -}
> -
>   int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp)
>   {
> @@ -841,7 +811,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	struct dma_fence_chain *timeline_chain = NULL;
>   	struct dma_fence *fence;
>   	struct drm_exec exec;
> -	uint64_t va_flags;
>   	uint64_t vm_size;
>   	int r = 0;
>   
> @@ -945,10 +914,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   
>   	switch (args->operation) {
>   	case AMDGPU_VA_OP_MAP:
> -		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>   		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
>   				     args->offset_in_bo, args->map_size,
> -				     va_flags);
> +				     args->flags);
>   		break;
>   	case AMDGPU_VA_OP_UNMAP:
>   		r = amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
> @@ -960,10 +928,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   						args->map_size);
>   		break;
>   	case AMDGPU_VA_OP_REPLACE:
> -		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>   		r = amdgpu_vm_bo_replace_map(adev, bo_va, args->va_address,
>   					     args->offset_in_bo, args->map_size,
> -					     va_flags);
> +					     args->flags);
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index 3a8f57900a3a..b51e8f95ee86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -63,7 +63,6 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp);
>   int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
>   			      struct drm_file *filp);
> -uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags);
>   int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp);
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 46b2bcbd5025..c69317804071 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -152,15 +152,15 @@ struct amdgpu_gmc_funcs {
>   				   unsigned pasid);
>   	/* enable/disable PRT support */
>   	void (*set_prt)(struct amdgpu_device *adev, bool enable);
> -	/* map mtype to hardware flags */
> -	uint64_t (*map_mtype)(struct amdgpu_device *adev, uint32_t flags);
>   	/* get the pde for a given mc addr */
>   	void (*get_vm_pde)(struct amdgpu_device *adev, int level,
>   			   u64 *dst, u64 *flags);
> -	/* get the pte flags to use for a BO VA mapping */
> +	/* get the pte flags to use for PTEs */
>   	void (*get_vm_pte)(struct amdgpu_device *adev,
> -			   struct amdgpu_bo_va_mapping *mapping,
> -			   uint64_t *flags);
> +			   struct amdgpu_vm *vm,
> +			   struct amdgpu_bo *bo,
> +			   uint32_t vm_flags,
> +			   uint64_t *pte_flags);
>   	/* override per-page pte flags */
>   	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>   				      struct amdgpu_vm *vm,
> @@ -354,9 +354,10 @@ struct amdgpu_gmc {
>   
>   #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
>   #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
> -#define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
>   #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
> -#define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
> +#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
> +	(adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
> +					  (pte_flags))
>   #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
>   	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
>   		((adev), (vm), (addr), (pte_flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index c316920f3450..87523fcd4386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -69,7 +69,7 @@ struct amdgpu_bo_va_mapping {
>   	uint64_t			last;
>   	uint64_t			__subtree_last;
>   	uint64_t			offset;
> -	uint64_t			flags;
> +	uint32_t			flags;
>   };
>   
>   /* User space allocated BO in a VM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index d45ebfb642ca..a0b479d5fff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -67,9 +67,9 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va)
>   {
> -	u64 seq64_addr, va_flags;
>   	struct amdgpu_bo *bo;
>   	struct drm_exec exec;
> +	u64 seq64_addr;
>   	int r;
>   
>   	bo = adev->seq64.sbo;
> @@ -94,9 +94,9 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
>   
> -	va_flags = amdgpu_gem_va_map_flags(adev, AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
> -	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
> -			     va_flags);
> +	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0,
> +			     AMDGPU_VA_RESERVED_SEQ64_SIZE,
> +			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
>   	if (r) {
>   		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
>   		amdgpu_vm_bo_del(adev, *bo_va);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3911c78f8282..10d135e71088 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1328,13 +1328,14 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		/* normally,bo_va->flags only contians READABLE and WIRTEABLE bit go here
>   		 * but in case of something, we filter the flags in first place
>   		 */
> -		if (!(mapping->flags & AMDGPU_PTE_READABLE))
> +		if (!(mapping->flags & AMDGPU_VM_PAGE_READABLE))
>   			update_flags &= ~AMDGPU_PTE_READABLE;
> -		if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
> +		if (!(mapping->flags & AMDGPU_VM_PAGE_WRITEABLE))
>   			update_flags &= ~AMDGPU_PTE_WRITEABLE;
>   
>   		/* Apply ASIC specific mapping flags */
> -		amdgpu_gmc_get_vm_pte(adev, mapping, &update_flags);
> +		amdgpu_gmc_get_vm_pte(adev, vm, bo, mapping->flags,
> +				      &update_flags);
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> @@ -1475,7 +1476,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
>   				   struct amdgpu_bo_va_mapping *mapping,
>   				   struct dma_fence *fence)
>   {
> -	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
> +	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>   		amdgpu_vm_add_prt_cb(adev, fence);
>   	kfree(mapping);
>   }
> @@ -1754,7 +1755,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	list_add(&mapping->list, &bo_va->invalids);
>   	amdgpu_vm_it_insert(mapping, &vm->va);
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
> +	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>   		amdgpu_vm_prt_get(adev);
>   
>   	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
> @@ -1814,7 +1815,7 @@ static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
>   int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_va *bo_va,
>   		     uint64_t saddr, uint64_t offset,
> -		     uint64_t size, uint64_t flags)
> +		     uint64_t size, uint32_t flags)
>   {
>   	struct amdgpu_bo_va_mapping *mapping, *tmp;
>   	struct amdgpu_bo *bo = bo_va->base.bo;
> @@ -1873,7 +1874,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   			     struct amdgpu_bo_va *bo_va,
>   			     uint64_t saddr, uint64_t offset,
> -			     uint64_t size, uint64_t flags)
> +			     uint64_t size, uint32_t flags)
>   {
>   	struct amdgpu_bo_va_mapping *mapping;
>   	struct amdgpu_bo *bo = bo_va->base.bo;
> @@ -2730,7 +2731,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	dma_fence_put(vm->last_tlb_flush);
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
> -		if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev) && prt_fini_needed) {
> +		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
>   			amdgpu_vm_prt_fini(adev, vm);
>   			prt_fini_needed = false;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..f9549f6b3d1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -539,11 +539,11 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_va *bo_va,
>   		     uint64_t addr, uint64_t offset,
> -		     uint64_t size, uint64_t flags);
> +		     uint64_t size, uint32_t flags);
>   int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   			     struct amdgpu_bo_va *bo_va,
>   			     uint64_t addr, uint64_t offset,
> -			     uint64_t size, uint64_t flags);
> +			     uint64_t size, uint32_t flags);
>   int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>   		       struct amdgpu_bo_va *bo_va,
>   		       uint64_t addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a3e2787501f1..846b67d52dfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -469,24 +469,6 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v10_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
> -	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
> @@ -511,21 +493,39 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
> -				 struct amdgpu_bo_va_mapping *mapping,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_bo *bo,
> +				 uint32_t vm_flags,
>   				 uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_WC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> +		break;
> +	case AMDGPU_VM_MTYPE_CC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	*flags &= ~AMDGPU_PTE_NOALLOC;
> -	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
> +	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +		*flags |= AMDGPU_PTE_NOALLOC;
> +	else
> +		*flags &= ~AMDGPU_PTE_NOALLOC;
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT) {
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_PRT;
>   		*flags |= AMDGPU_PTE_SNOOPED;
>   		*flags |= AMDGPU_PTE_LOG;
> @@ -566,7 +566,6 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v10_0_map_mtype,
>   	.get_vm_pde = gmc_v10_0_get_vm_pde,
>   	.get_vm_pte = gmc_v10_0_get_vm_pte,
>   	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 72211409227b..36720d1c07a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -433,24 +433,6 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v11_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
> -	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
> @@ -475,21 +457,39 @@ static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
> -				 struct amdgpu_bo_va_mapping *mapping,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_bo *bo,
> +				 uint32_t vm_flags,
>   				 uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_WC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> +		break;
> +	case AMDGPU_VM_MTYPE_CC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	*flags &= ~AMDGPU_PTE_NOALLOC;
> -	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
> +	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +		*flags |= AMDGPU_PTE_NOALLOC;
> +	else
> +		*flags &= ~AMDGPU_PTE_NOALLOC;
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT) {
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_PRT;
>   		*flags |= AMDGPU_PTE_SNOOPED;
>   		*flags |= AMDGPU_PTE_LOG;
> @@ -530,7 +530,6 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v11_0_map_mtype,
>   	.get_vm_pde = gmc_v11_0_get_vm_pde,
>   	.get_vm_pte = gmc_v11_0_get_vm_pte,
>   	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index b645d3e6a6c8..fb3fb31724a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -456,20 +456,6 @@ static void gmc_v12_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v12_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
> @@ -493,30 +479,45 @@ static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
> -				 struct amdgpu_bo_va_mapping *mapping,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_bo *bo,
> +				 uint32_t vm_flags,
>   				 uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_GFX12_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
> +	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +		*flags |= AMDGPU_PTE_NOALLOC;
> +	else
> +		*flags &= ~AMDGPU_PTE_NOALLOC;
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
> -		*flags |= AMDGPU_PTE_PRT_GFX12;
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_SNOOPED;
>   		*flags |= AMDGPU_PTE_SYSTEM;
>   		*flags |= AMDGPU_PTE_IS_PTE;
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
> -	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> -		*flags |= AMDGPU_PTE_DCC;
> -
> -	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
> -		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
> +	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENT |
> +			       AMDGPU_GEM_CREATE_UNCACHED))
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
>   }
>   
>   static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
> @@ -546,7 +547,6 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v12_0_map_mtype,
>   	.get_vm_pde = gmc_v12_0_get_vm_pde,
>   	.get_vm_pte = gmc_v12_0_get_vm_pte,
>   	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 8030fcd64210..f6ad7911f1e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -382,7 +382,9 @@ static void gmc_v6_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v6_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index a8d5795084fc..93d7ccb7d013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -504,7 +504,9 @@ static void gmc_v7_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v7_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 99ca08e9bdb5..1ea198fcb51f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -716,11 +716,15 @@ static void gmc_v8_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v8_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   	*flags &= ~AMDGPU_PTE_PRT;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cad014c3bbf7..aa2ea1078cb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1084,27 +1084,6 @@ static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int v
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v9_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_WC);
> -	case AMDGPU_VM_MTYPE_RW:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_RW);
> -	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_CC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				uint64_t *addr, uint64_t *flags)
>   {
> @@ -1134,6 +1113,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   					 struct amdgpu_vm *vm,
>   					 struct amdgpu_bo *bo,
> +					 uint32_t vm_flags,
>   					 uint64_t *flags)
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -1247,25 +1227,43 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   }
>   
>   static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
> -	*flags |= mapping->flags & AMDGPU_PTE_MTYPE_VG10_MASK;
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_WC:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
> +		break;
> +	case AMDGPU_VM_MTYPE_RW:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
> +		break;
> +	case AMDGPU_VM_MTYPE_CC:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT) {
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_PRT;
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
>   	if ((*flags & AMDGPU_PTE_VALID) && bo)
> -		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
> -					     flags);
> +		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
>   }
>   
>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
> @@ -1442,7 +1440,6 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v9_0_map_mtype,
>   	.get_vm_pde = gmc_v9_0_get_vm_pde,
>   	.get_vm_pte = gmc_v9_0_get_vm_pte,
>   	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 865dca2547de..4cdd585de0be 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1190,7 +1190,7 @@ svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
>   }
>   
>   static uint64_t
> -svm_range_get_pte_flags(struct kfd_node *node,
> +svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
>   			struct svm_range *prange, int domain)
>   {
>   	struct kfd_node *bo_node;
> @@ -1306,7 +1306,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	if (gc_ip_version >= IP_VERSION(12, 0, 0))
>   		pte_flags |= AMDGPU_PTE_IS_PTE;
>   
> -	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
> +	amdgpu_gmc_get_vm_pte(node->adev, vm, NULL, mapping_flags, &pte_flags);
>   	return pte_flags;
>   }
>   
> @@ -1413,7 +1413,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
>   			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
>   
> -		pte_flags = svm_range_get_pte_flags(pdd->dev, prange, last_domain);
> +		pte_flags = svm_range_get_pte_flags(pdd->dev, vm, prange, last_domain);
>   		if (readonly)
>   			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
>   
