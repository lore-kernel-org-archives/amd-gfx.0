Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D399FCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 16:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D67210E0B9;
	Tue, 12 Aug 2025 16:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGoV54G7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE3A10E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 16:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni900LIcfCFF96yj/sUU1CqhH0KkZKo7ERxdx9YEdc6wHpO5LjcaaPUi2NIjyH2cWJ0CYRTOToVPicXuGnJj+s8Y0PGPfDGkM6aDveFnj8lygZPbvfODC6dF7hhmpusypborGQq/PEGPZgSX8cp+ZkKInqYvHxTwRErh8TlFty4B4zh0AtIVPqKP7wYcr4oHnzm3XQCzfVFZ20kuRbJ+5RrEnce/AVva4HlIKawVSm1xbs7nuaE+M0HSGahPBqDq3GLCdKOY9zPyzNqAVBJFXdidv9lQp1n1Sg/YzHpP/+KABdzc8r4nsVBdCAKSNmjt3TdnbNdOfgc1a4xGWKwMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpobMLN+sRl8NeDD72U/h5gZ2bVXDTfuYet5KkVy8gc=;
 b=LJoCI/ui7H7joT4eZ5Lp8kZLDSoyt/iTBICgqJ3/6y6wOemWy2ZYw9RriQcHjWTt2z5dRkt/SOlg41E4vDTLV6M9BkNDZ9I17dq5sLUHUWewgPp6lZeXBZdnREDFPqvSGFME9ZI4UrhIxGhGVzJGrVMguIHOKrOJryMQmKH1uvXeJWrMHLGzKqpTyTd9kpgNXNdlortbS5HXvIFCn/hs9SQd5uc48x1IAkqf2gu7K2QQ7UUAMjBD8aEZEN9rz26TGA/y3bdlR7l3dgTUEXyC8vJxG6Wg95TIAukz0yNQA3jrSlctNi++RvfTL8Y2qQ1ZhQk21yVw02JzdcO4vmeD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpobMLN+sRl8NeDD72U/h5gZ2bVXDTfuYet5KkVy8gc=;
 b=AGoV54G7h6Rv2fh1Xu3IUdK8ZjrvEaoyXdqBbXe8DWwcmun1kFl2H90MSR6ytiCAP40HA6g39MbtkQ93pvOHB+HwYz3UfQvDmbQYU/9h0cMRvSKn1XKYXp14kJj9rdJqS7jaA0Pt70rcYYwH6340XvALZTCWjwbiTY4ho7qG5JI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 16:51:49 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Tue, 12 Aug 2025
 16:51:48 +0000
Content-Type: multipart/alternative;
 boundary="------------eP1mB1tiitsL6AgmW5O18WGu"
Message-ID: <d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com>
Date: Tue, 12 Aug 2025 12:51:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
References: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
X-ClientProxiedBy: YQ1P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::16) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: dee61091-8ee4-4ed1-7448-08ddd9c08758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVdkSUxlV2xFVVhobEdMQkI4MURGb2JjdjFhbEJiZWhsakg5NEVreDFKMVQx?=
 =?utf-8?B?YzNTc0VBMWt3NkQvc0tSMHZyWG5SU1lOTGx6QjdOWTY2c3RDYzFCUEhzNTV1?=
 =?utf-8?B?VjNQT3JpdkQ1YmFQaHc5TW9qNm9ML1RCZmFoeTBUbklKaGFsenc2YThQYm02?=
 =?utf-8?B?NWs4VE84SEVtcGJPV2hSNU0rU0s3cUpPb0ZncUQ0R1EzOE4rOU9GZ2U5Tm5E?=
 =?utf-8?B?UTZMdksvdGRQOENIZDdybC9hejFUdGhLa1VwZ1Q4WHBEZjI4K2QxRWM2NDRH?=
 =?utf-8?B?M2ljbXRaR0tLaVFqWE5rdng3dVJKMU53bk1pcjlSMGhRNll6S096cGdiNkxI?=
 =?utf-8?B?RVJYUlVIWVVaanhZNmJZS2VlSXg4bzNFalBpSEZZR1JxNnVGV20wT0ZLRkRZ?=
 =?utf-8?B?VHpwdXErcyttSmpzajd1b1BFRmZzdXZxQ3A3Z2pTUXFNT1l2NnVqVTZtYUd5?=
 =?utf-8?B?Uk1CeEw5RlNzTlNXbUZ6aWV6QWhLLzB2KzFyRlo0MTZHeUZpUjFwa1EzcGtJ?=
 =?utf-8?B?VXdQQ0QwQUZTNXFoSVlJNGdFTFdySjJMZ0FENS9mZnRPaWd3VEVkWjU4UmIw?=
 =?utf-8?B?MDdJNEQ2THZta2tsckRqSzdvMFRpdGYrV3JXTlhiMHY0aTFrV2FYaVRJa1Fu?=
 =?utf-8?B?SjJra0VtUzBmQnhJZlJuUTQzWkU2VkZXRzhJMlFwWFNBWjN6TFJyTE9zSi9h?=
 =?utf-8?B?ZEVLNmxuVnBYY3FLcHpjQXF1T3ZCcTdwT3dhK2ViOFhPS2poc1lYSHRXQWZi?=
 =?utf-8?B?SkNGYUt1UGwrS1h1amFpajBBVUw0d0lMZEVraDAyVm4zeVFUQVg4Q3FnSFZ1?=
 =?utf-8?B?djlnbC9nOE5FY1dvSmFxMDdOR1JySUNYSFZTUER0MkoxOWVXcmIxRndueVVm?=
 =?utf-8?B?TnNyQ0NuRXg3Q0dNMHFjY21oVE9kKzFQTW03SWpzSThZSGhMMUE5Q01uamxL?=
 =?utf-8?B?MEhnckk5Q0U4TEV3eTZabVdoK3JzQXNaWUFuZ2xrQktPVDk2RGZaUlkyaTQr?=
 =?utf-8?B?Q0FUQ2Z4bDhpazlBcml2NmU3ZjNKVkJVUHBlUDB2aEN2TitxaHhFOGRmWTdq?=
 =?utf-8?B?ZEg0V2hKNTltelJoLzVGL083dU1yQWpWMU5VckNXUGtXRHlPKzVTQTEyeW4z?=
 =?utf-8?B?d1BPNmpmemVVRGdFQkVDK2ZFTnJ4UGFibjMzdTcvVmk4VXNZdVQraDBtZG9K?=
 =?utf-8?B?TmRvc1BrZWlBUG9BdEtOSWRnV3ZEc0tabnZlUWVlZkdYRndhN3VPV2l6bGQ4?=
 =?utf-8?B?dTUyanYvZlhPWWE4VTV5aVpqNW02Mm5telp4WkhZenNZZWhSeXJ4QUZpeXV3?=
 =?utf-8?B?eUFJTW15VUFWUWpwM2hwUHVKR3M0a3VVS3p6eTFyYnl6NE9hSHF1VThja2Iz?=
 =?utf-8?B?akJibTNTOHpOZ3E5YmxLN1k4d0VIWmxPOS8rbHM0N3p6VXErMFRqcEdxYlZE?=
 =?utf-8?B?RCtHT1BhZEFOeHFCeklTakZZWDdWcWc1T2V3NTI5VVQyTjd1bTJ3Zms1L0Jp?=
 =?utf-8?B?dnE0UDFNalBJYnpPdXJaZEFVVFJQRkRmWVJYcWx1Sy9zd0lVTWlxVi9Sa1pO?=
 =?utf-8?B?THdBT1plQm5jaEgxK1FPTnBtL2lORlZwYkRKS0tzWUNvMWN6WXhVSDk2Ujli?=
 =?utf-8?B?OUt2L09TRlM0TU85RVhHR1BQbXRYWmFDWlFucjVSRThHa1Yvdmo2ekk5eXlX?=
 =?utf-8?B?QlhHUGNxZVZqNUFGYWoyY2JBcElvWmtOWE5kTm44bnZZd2lDNWwzc1Q0Y253?=
 =?utf-8?B?R1o3NjZ1RFByS2o1SVVnMjJiQjM1dGtXSktCTWNoSm9tVjZvQkRKS1NpQ2hv?=
 =?utf-8?B?SGM3WFQrK1hMd1pyWGJxRGNYOExoNDJFbmorZXA3eVNOcFhVaTlNQlJNd1A5?=
 =?utf-8?B?TmZnNGxMaktBbmlWa01TM25ONU82Y1pkc2xHSUI4UGh5dVlXRTdoVTUzUTFW?=
 =?utf-8?Q?9l5GIwEEgns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZVckx0R2xETUhLcFJiN2VQUWl2UE5VOGZTb2Z5SURoUTBkL2NEY1dNbUg3?=
 =?utf-8?B?alhrNXJ1emhIMjQ3WDhkdlRTejk2bUsvRmZVb0hTL1pDSHpZM1RuSEFwbytF?=
 =?utf-8?B?WWZ6RE84RnN0RXIyWUtPZnBKUFV4YU93aGNsUWlZczhuSkRZNGhMSlBLNXpw?=
 =?utf-8?B?ZTBBeGdUVkVqdDRHVVZlVEQzQ2xJTTZBbTNINVpyY1VpNGFrZGZMWU00SEtn?=
 =?utf-8?B?SDNNMGxLZ2s4U3RlKzJCVFJ0WWt2ZzA3aWN4RVltNDZJTVpzOXlqdlMwTndk?=
 =?utf-8?B?OVlxY1NNT3oyZ1ppakwxb3lzb3hmSEFBQUxyb1hUS3YwWDBHUjg3cDdxTDh3?=
 =?utf-8?B?enk3SCtGZm5kMDRuazZzN2YyczNON2U0VmQrSlpaYllhOFpuY0hxRGhadllz?=
 =?utf-8?B?VEZaVnY4dWZ6aXlIR3JjdVhTRkFBRzg0RWRXZEsybTdTaVBXRktWK3lvd2hV?=
 =?utf-8?B?ODlWSEVjanhlQ0tRb2ZRV3ZZaEErdzR0SjRqMnV1YlpnT2R0d3hjOGg2M3VT?=
 =?utf-8?B?VXVVRWlwTEd1MDlrZWlNZUhhMUFBTDZFcm95VGNTZ0xmbSs1UFN5djNoVFh2?=
 =?utf-8?B?cU9ZcVVRNW9FUUpUWDFEVE1GR0pKeDIvYVNEeFdyamgxSGI2Wkw5VnFEaHJP?=
 =?utf-8?B?RExpRFNWU1M5MGYyQ3pRU2U2VC9QTFpXTk0waG1KaERBb1RkNERSanNRekY2?=
 =?utf-8?B?MHM1T1ZZWXVaaHFOeGEvSEVvYU40RGJreXpGVVpuSkpGNVVSa0VUWGRmekZL?=
 =?utf-8?B?eERHMk16dEExQk5nTHo4aVZPeVczeW5RMjFzL3ZZSFRWaTFuVGduMlA4MWVx?=
 =?utf-8?B?dHBmSmZQcHNpZHRWSDNjdy9idmU1MXpaTGNyTGk5SFhpRkEzcnRIK1ZLM004?=
 =?utf-8?B?UnJWeVBFc0lxalJHSUVRdHB0bG96OWN2QWMyeDNCbEdTMll5dmtHdjE3U2ds?=
 =?utf-8?B?Sk9NTHhodFl1dys1SUt6cElJcENPekpzNHB2Y0NLdGV2QmVLcWQyTFhPVlFU?=
 =?utf-8?B?blV5b0kvQlJFaHNVbVJxRTVzUllIYVRBSHI5RmRvRHdvLzBhZ2FUck9DaWkw?=
 =?utf-8?B?LzZ3UWNFQ2c2UTlQYzJpUWYyVHVoWm1CSjhWejhPclVRTlBHajNHTjd5aFRC?=
 =?utf-8?B?OFRhMFZPQXRMN2locUJUVUtPU1hEOU5vOW1SdXE1cUwvVVdjb0J3bDRrNnRj?=
 =?utf-8?B?UzkxbmxIenlFU0d2cUo3dWNEUHh2aGkzazhQOGU0TDd2VmV6VnZkbWpER3Zw?=
 =?utf-8?B?LzVkdk9GbEFpYVJVc09tQjUzb1N1Um5qS0I1b2trQkprOFpCUHlxTUg5Qi9y?=
 =?utf-8?B?RXI0UjNYWGNRWWlBWTlBNW5XZTBNUEc1ZHJTQnEybmdjSHI1MEV0YzZkMTBG?=
 =?utf-8?B?aGNzVENDRzlxdTJuV3BydGFLWGJjQUhSZDBuaXgzQ0NKZ0MzZm5rdGZvVHZv?=
 =?utf-8?B?U0tKN294Z3ZEaGRwTkJNYXRZL1lEay9VNThDTXVsZ0dxVTVmamZrSSt4Wm9H?=
 =?utf-8?B?M3FmTEQ2a05sMGJzcjhjVFdSM3c0dnRQcGM3Yi9Xb1o4cEZGVUl1dlBhajdv?=
 =?utf-8?B?L2dZdlZ6V3ZZa0NRaFkrd2FmM0diN3ZhKzAzWjNPVUdWVVhTQUcwTzBYMDNZ?=
 =?utf-8?B?N3M4c2gzbzRLWCttbGROc2pKMjJyZHdlK0JDWG9iNHZySEpPWVJGVzFCekd3?=
 =?utf-8?B?MFM4U3pDVWx4UkdrcTAvdVdwYUNCVUxzR0ZXVHJSUU95RVR5ZFNVaml0bWhY?=
 =?utf-8?B?a0lmMkZhTWU3bndUdW80NTZCMEFOTkRvTzlZV1VBZzF6aTBCNlZOeW93TnZJ?=
 =?utf-8?B?b0VESEF2NS9LR2hOdmltMjMwSEx0Z056QndwK0xzcEYvSUE5eXZ6S0J2eUNm?=
 =?utf-8?B?QkhDbktFTTlPNm51RVZIcDY2V3NKMC9tSVlBb0QzYmltZzI0dm1hUkdMa2xJ?=
 =?utf-8?B?c01BSUVlOTNOMTUzZG8wTE5Fam1UTnJtVGFuQUFtMzYrWGgyNHh0d2RHMEtM?=
 =?utf-8?B?TU1FQXJUbWhXNkVCeFFFdmg1K2pZWXBNVlpWTlJhaU9LdFYzeGhlV2F5QzEy?=
 =?utf-8?B?VStRNmVMSUxaNEtrN0ZiMEpUZXovekJmRkNxSDdwdkZJK3U1KzFjU2tIbmd1?=
 =?utf-8?Q?wfMyeakNGWaTORP1uETr7Y+wf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee61091-8ee4-4ed1-7448-08ddd9c08758
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:51:48.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvHz5cq6X1ikSpwnhcCcBFjZEO7Pa98/DY1vHHnKP0nPKPyKN1ADaFe/P8LEeZaYWOFai2I5i4HCrN8HHwmj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570
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

--------------eP1mB1tiitsL6AgmW5O18WGu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-08-12 10:56, Sathishkumar S wrote:
> There is a race condition which leads to dpm video power
> profile switch (disable and enable) during active video
> decode on multi-instance VCN hardware.
>
> This patch aims to fix/skip step 3 in the below sequence:
>
>   - inst_1       power_on
>   - inst_0(idle) power_off
>   - inst_0(idle) video_power_profile OFF (step 3)
>   - inst_1       video_power_profile ON during next begin_use
>
> Add flags to track ON/OFF vcn instances and check if all
> instances are off before disabling video power profile.
>
> Protect workload_profile_active also within pg_lock and ON it
> during first use and OFF it when last VCN instance is powered
> OFF. VCN workload_profile_mutex can be removed after similar
> clean up is done for vcn2_5.
>
> Signed-off-by: Sathishkumar S<sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>   2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..da372dd7b761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
> -		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (adev->vcn.workload_profile_active) {
> +		adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
> +		if (adev->vcn.workload_profile_active &&
> +		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   							    false);
>   			if (r)
>   				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
what if there is a context switch here? since the vcn_pg_lock is per 
instance - if another instance starts to
call amdgpu_vcn_ring_begin_use() the amdgpu_dpm_switch_power_profile() 
will not be called due to workload_profile_active is per device.
I think you still have a race condition.

David

>   			adev->vcn.workload_profile_active = false;
>   		}
> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
> +		mutex_unlock(&vcn_inst->vcn_pg_lock);
>   	} else {
>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>   	}
> @@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>   
> -	/* We can safely return early here because we've cancelled the
> -	 * the delayed work so there is no one else to set it to false
> -	 * and we don't care if someone else sets it to true.
> -	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
>   
> -	mutex_lock(&adev->vcn.workload_profile_mutex);
>   	if (!adev->vcn.workload_profile_active) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   						    true);
> @@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>   		adev->vcn.workload_profile_active = true;
>   	}
> -	mutex_unlock(&adev->vcn.workload_profile_mutex);
>   
> -pg_lock:
> -	mutex_lock(&vcn_inst->vcn_pg_lock);
> -	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +	if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))) {
> +		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +		adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
> +	}
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..a876a182ff88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>   	struct mutex            workload_profile_mutex;
>   	u32 reg_count;
>   	const struct amdgpu_hwip_reg_entry *reg_list;
> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
> +	u32 flags;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {
--------------eP1mB1tiitsL6AgmW5O18WGu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-08-12 10:56, Sathishkumar S
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">There is a race condition which leads to dpm video power
profile switch (disable and enable) during active video
decode on multi-instance VCN hardware.

This patch aims to fix/skip step 3 in the below sequence:

 - inst_1       power_on
 - inst_0(idle) power_off
 - inst_0(idle) video_power_profile OFF (step 3)
 - inst_1       video_power_profile ON during next begin_use

Add flags to track ON/OFF vcn instances and check if all
instances are off before disabling video power profile.

Protect workload_profile_active also within pg_lock and ON it
during first use and OFF it when last VCN instance is powered
OFF. VCN workload_profile_mutex can be removed after similar
clean up is done for vcn2_5.

Signed-off-by: Sathishkumar S <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..da372dd7b761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (!fences &amp;&amp; !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt)) {
 		mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
-		mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);
-		if (adev-&gt;vcn.workload_profile_active) {
+		adev-&gt;vcn.flags &amp;= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst-&gt;inst);
+		if (adev-&gt;vcn.workload_profile_active &amp;&amp;
+		    !(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_MASK(adev-&gt;vcn.num_vcn_inst))) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
 				dev_warn(adev-&gt;dev, &quot;(%d) failed to disable video power profile mode\n&quot;, r);</pre>
    </blockquote>
    what if there is a context switch here? since the <span style="white-space: pre-wrap">vcn_pg_lock</span> is per instance -
    if another instance starts to&nbsp;<br>
    call <span style="white-space: pre-wrap">amdgpu_vcn_ring_begin_use() the </span><span style="white-space: pre-wrap">amdgpu_dpm_switch_power_profile() will not be called due to </span><span style="white-space: pre-wrap">workload_profile_active is per device.</span><br>
    <span style="white-space: pre-wrap">I think you still have a race condition.</span>
    <p><span style="white-space: pre-wrap">David
</span></p>
    <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			adev-&gt;vcn.workload_profile_active = false;
 		}
-		mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);
+		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
 	} else {
 		schedule_delayed_work(&amp;vcn_inst-&gt;idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&amp;vcn_inst-&gt;idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev-&gt;vcn.workload_profile_active)
-		goto pg_lock;
+	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 
-	mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);
 	if (!adev-&gt;vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
 		adev-&gt;vcn.workload_profile_active = true;
 	}
-	mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);
 
-pg_lock:
-	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
-	vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+	if (!(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst))) {
+		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+		adev-&gt;vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst);
+	}
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..a876a182ff88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -366,6 +366,10 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
+#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
+#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
+	u32 flags;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
</pre>
    </blockquote>
  </body>
</html>

--------------eP1mB1tiitsL6AgmW5O18WGu--
