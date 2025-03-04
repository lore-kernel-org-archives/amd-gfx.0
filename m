Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9001C282C6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 05:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1C810E50F;
	Tue,  4 Mar 2025 05:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LbknjEgh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ADC10E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 05:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtvadElCJX4cKTNs8sVFPIVKu/B1astL+LGQH9UxmN4BOvZIUWbZ3H+59a8aJnlu8C3CXlqC1mRLRnC6fFUzRp8hm8dBoTqWim1UCHOQVPAnr0LOcV29bOA/U1SrZz7FBI5ZfFIIyhuvp6dsuC4xYNgmOIDWEIzOFU7CtvE+7MtSAhOOWlE42bN/Ec7I/8fN9FXo+sG1aoc2ZhiEDAg58JyQxWqkBk0/Kzfu+ksq2NoESRXuokEiXPXXa2+SqXx38+ZMqt5ZktCeA+Oogx49sq5ADrF85ADSE1Xob05YW5OzYACVI8ekH5SKop9HdTwrnMoE8KavQYDJqiKnMwnL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN9/hmV2RDGP/kgErzfPcEjiDouXfjiw1GE/PiQBMrM=;
 b=X5Xy1W9JZ7+0KNgKHUvYE91iXz1ZfsVAH+m9ZxmSm7gYrKNuRAprLksdgFN718Ay7FSmzYdyZ+jok++dwUhT0x+qTm75rDUA6FJcluRSYi7n8eU8BCgDvcUbgrZAM80yt6gB2dadkltf8gCxLKRsqYhLc+Y3PvyQ+Vmfe4LIRNAMnWCLezYdad9KGDVOjOOBeITfAVrf5yNlEN3l++JIZghSPYFALrQFbPJSw6IS5FbAuLScQo5SWcVk3wkLTrEY8SkMSShQKM+JR7aW9vpM3+iblFXI2m5tpiWifIcmgAMfbSVBstnBpymsluhGN2UupQPzV0xXifB+StFI6PJeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN9/hmV2RDGP/kgErzfPcEjiDouXfjiw1GE/PiQBMrM=;
 b=LbknjEghgg6DD4L3Vv8e9dnB2a8C8kx96pS/FimmNVeqkDF+uinEPprc3bvaEDEiH+rIaiY++O6wfbtWNXZ/OV5WTWkn6P2zPXffrMUEpsxOM1Li+zDvLTOiR7OHHeCDL/l/FdahGJdFZv95GD8MYgfO/h5csdKuKAL5in96LFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 05:21:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:21:46 +0000
Message-ID: <af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com>
Date: Tue, 4 Mar 2025 00:21:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165839.8433-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250131165839.8433-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d9eacd-b5c6-4720-1b1a-08dd5adc7521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkRTNlBhRExrTXJxaFNIYWxEUlQ2RC8xQis3SWFKQXVudVZQaWpMaU4xS1Z3?=
 =?utf-8?B?WUZuRDFxcWlrRjBQUWZWYXkrSk5OOEhCNnRPYlhjeFdCRFhaa1d6MC8wd2gz?=
 =?utf-8?B?UmF5RVlya1F4Z1Y3ZXc2R1FLS1Y5WnMxZjFaSC9WNUFCK09VMzhhMU5iZHF5?=
 =?utf-8?B?WE1OTnpSdG1zQm5wbzI4WnpYRWY2WDlsaDBNY2NlTEQ3UGZrejRsRHhob25q?=
 =?utf-8?B?cVl4R3FXR1hJN05lV3UwSW5rVVVTT1Iyb0xaZ1BBVFFZTHJmM3Jmb1V1MGN4?=
 =?utf-8?B?SS9tTllvN21nektlOC8xVU5OaDNkb2hVTmFDeUNZM2l2TlBwN1d5VVJTUFVp?=
 =?utf-8?B?VXBnTk0xU3ZZbUlQcHQzdlNobEVqODFGVkN1NHgrSHpHZTAwM0c0T2hISlBn?=
 =?utf-8?B?a0NCTGk3YzdoblV0bWVWOVViVGl6VkNkZmkvS3RSazB6Y21UYTNtcWxCcUhp?=
 =?utf-8?B?eTVFRGUwTGhEZ3VXRHFmTUQwczZBSFZDdVdEUm9vNTFhVnJnK1FIcmdrRUZY?=
 =?utf-8?B?L21IbUhVUzVHSUpSd3VWL0ZtTWlSUy84TkoyL0l1UTJZV0Z3UmduNHNCQTNu?=
 =?utf-8?B?d0pmdXlSNDFHMWlVQldGSXV1L3lhYzM3VUJUQmp2WDVpVVBQR25BYkNWc3dX?=
 =?utf-8?B?OE9BNWQ5YitVWVZrL0lteHBNZFIzbzRJVGl5RmFqSUFiOWhEcXU4ODRWdEFs?=
 =?utf-8?B?cDBwTFJMRkRSeE1sMmpPKzU4QW9zNUJocXZkdGVvNWE4cndUSTNHN21HYnJS?=
 =?utf-8?B?MXlOS0VWbDFUNVFhdzdGc3phMC9LMmxjeVBGZUl3QytPQTNQYkZPQ3ZCNVZu?=
 =?utf-8?B?RkZJTUZ5MEl4bTEwOFB1NWZuNGQvejNZaHBxNUlBaUtjMlplZzUyY1NJN2JD?=
 =?utf-8?B?cVhOYnFkMzhlaDM1dXBQc0FsRlEvNGlNUXlJUDdseUsyR0lkSmRHU2hZMXlz?=
 =?utf-8?B?cSt4V3pKR2hjZDlmK0lXQVJhVkM1UzdqSldQVncxcGhJSG9lQnUwSERxVWxF?=
 =?utf-8?B?a1VteXV6ekV1UW1MRmxrSjRjd0lPRms3V1BTc2J5UmJIRVBlQkt6WEhqUUpw?=
 =?utf-8?B?enNvVWJyOW5IWEhiNEVlWU5mT2Q1QWQzMENrQUFCN0xaQjFXOTFYc2pOMnZQ?=
 =?utf-8?B?VGNJT2VLaTdFbW5LVmEzRUtkMFRuVncwOE8rN0pQT3MvY29lOWlpQjdqRzhE?=
 =?utf-8?B?UElpK2g5SDR6MWc2UVBuRWZGT3ZOcnQ4OVd1cFc3aGdLb0pZV0pjamRVQlF2?=
 =?utf-8?B?MS9tVktPREVWWjJyUHVGdG5yR1IwanRpN21ETXQxMDZTUVBpRXpkVWN1eTdZ?=
 =?utf-8?B?TEJ1c2xDOGJnWHFRNDd0am51UEhqbVI4Z1FpSko2M0FWNis1MUFyRldSWFMr?=
 =?utf-8?B?U25PV0d4SENxWlhHSGp0R0szWFRGS0dya2IzbENKaS81TU42d3dySHpyQ3hi?=
 =?utf-8?B?RDhtOWk2TStYNm1kMFlDTG5IZnlQWkpyYnA1U3NvT1IyM3E2NHp6ZE9NeEQv?=
 =?utf-8?B?NDFFa0x4U2I4S0dPZlhmMVN3M3dCaWw5dHR0a1U4WHBYSkhxM3FJSlExbEdi?=
 =?utf-8?B?ZkZxbEN5ekxkTVlHUkVONjlUMUQrbmQrV1lsMVg3ZXdxVkFEQVV5L29hd21v?=
 =?utf-8?B?eHVXeFFuRUp5emNFbjhuS2wvUHJ3d2tPYUtDcGd1cG5sL1BlNG1mVnhkTlBQ?=
 =?utf-8?B?SVF5a2k2Q2RLbHN3a1p3RDJIaTd2QS9XbGg0Y2NaMjBvL215R3Z4dGlONlZn?=
 =?utf-8?B?VjF3THl2SFg4MDZaSEd6SS9ZdVpkaENJY2V4OTJaMEVmUmxFbURucEw0ZzdY?=
 =?utf-8?B?SWt2TmxtMGVQZFUyZDA1S28vdE5hTFF3Uzl2Q3lBVWhlL0dRWHd2VkgwZlNw?=
 =?utf-8?Q?C9UDTw5CHBXzg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllXODR1eElwd3pBNG5IKzRjaWVXdnpIYWRncjVZdnpOZ2F4bEl1YXVhZkhh?=
 =?utf-8?B?NEk3TUtFWVZTMlNRMTc2MitMWVNPNG9KNTJuV05IOWN4MlA0OXFvSW85anJy?=
 =?utf-8?B?TmdZUTRXT0NKODQxYUlTOXJzdkUxL3FIWGxVMDkyelAwTzhQanV2cFZRSXhW?=
 =?utf-8?B?VmcvTk9YNGFwWXg1SjV1aTR4ZUF6cnhjL3RGUVRTUnVpWUkwMkZwbUVJbUlB?=
 =?utf-8?B?K3FJSG5NMGllVWZrNjBqdHE2V3pjVTdKek9aOEtNRlZYMVIwcUhiRWxLcllL?=
 =?utf-8?B?ZlNMd05lZ3paM1NmR3BWRllvRXlxUldhY05EcmNCbEU5WkE5cGYwY0loT1Bz?=
 =?utf-8?B?N2ZVNEpPMTV4eU5hM3lxNjY0czlBZ2UyalA5enRjSFIwRDNMc29KUXFVT1J4?=
 =?utf-8?B?WFRIVGtVcGhwbGhaWVFCZmM5ZysxU0RVU0s5enlCalhBSGhQSVRPTTNtcis0?=
 =?utf-8?B?cnkvTDVsdEVHWmJnR01rc2FWZXp4Tnp2M2tCTXdYbXliSWdLWTcwN25pc25K?=
 =?utf-8?B?WmJ5UlhhUlVUcThlYmk0M2JWSE9hSWR1Z2ZvMkEvSXBQQkZBN21NeUFkOWNw?=
 =?utf-8?B?MllXMTdJcWxrdHorVkZxcXowL0ZCUXR4Vk5QVzRqbkRtdE5OTDB3cXJmTDlY?=
 =?utf-8?B?bENHYXd2YWQrU24vV2tzcUUwbXI1ODFWS1psbG1MUGE5RnVNMno3MFJhRHho?=
 =?utf-8?B?ZXVUbG9sbkV6RDl0OHpiYVNVVGY3UWZrdHRvY1NZYzQ2VFgvOGRlZVlPVUhJ?=
 =?utf-8?B?QURjQ3lVODYxM3NuZEI0WE43d0VJY0tGQUkyVEp0enY5MXpjdjMzY3ZsR0ph?=
 =?utf-8?B?MDUvTkVnSGZGeEdaVUcxUUk5ZVN5TWZmQndKNDhSVUp2T3BORy9rM1p0STkv?=
 =?utf-8?B?ZDltMDcycEFjVXhSbW4xWmZ4RjhJYXZwazdYOXNxOEQ1Q0E3dzhqdWJ4S1Y5?=
 =?utf-8?B?Z2cyYTg4VExZVkp3ZTgvWFdmeVFvWjc1d1p5RDlFOFV1cEtZTDAyQnFxb2M2?=
 =?utf-8?B?eVp1ZElEWXNRdCtwNm5rUStRZFhFU1RYUk12R2V4b0lJWmdKeURHenNvYllT?=
 =?utf-8?B?VkVYb0VYUzIwNzRiZGRrNnVRT1pyUGFhYkZqWkgzVkNTeUc0SmgwQXdZeURo?=
 =?utf-8?B?RnpzV3R2b0pQVEZBQTVUWldBUVR2dzFEOVJDVS81ckdrbllOWk5CWDl6aDgw?=
 =?utf-8?B?ckFDZjRZNXgyU1E5cWZRNy82bk5aZGF2T3VUQ3hMWXlML0FRZnlxdUwwc0dW?=
 =?utf-8?B?RzVHc3BRSWhuWDFSWHlFU1doQlUvS3RXdHZhb24xV01zMmowWjBvZjBHTGds?=
 =?utf-8?B?NmRFMklrR1FNd29ud1dwbWdybUQrbitqdzJYR3V6V2tFMEJZcm81dE8rbkVY?=
 =?utf-8?B?c20yU1E1UU90NEpWMzRDaTMrZjJrVDdIWUtzZis4K3U4YWs4U1NaYWNxUFdh?=
 =?utf-8?B?bTVVcnNHTURrenRzZUdkNlVkVjZ6NWU5WldEcE1PbjNKVldmaWZLdlFlQWx5?=
 =?utf-8?B?eTV0Yllzc01YSnkrRDFUK1V0Ujg2S0dqbFRBTXkyL1dPUTFVeWdKRlNzVGZ2?=
 =?utf-8?B?aEI2RWdpMW14ZWU2TnVWQXlHZWRmYVlpSmpNTmMyS24vajc0dFVGakw0SE1Q?=
 =?utf-8?B?Y09jRHI2a1ZyVkNScS82K0FmeUVnazdadVpIcUFHSkxJVng5ZlV6UXpMRUZS?=
 =?utf-8?B?VThjbFREZTJKZXVWdExVOEp6UHM3OU41SWtjOVdUU2pHQ3ZvTDJGNE5IdHlG?=
 =?utf-8?B?TkNEWndybjdHMklqUkg3SXZwSnJrWmVLU3NmWFdQUC9rY2tONDFzelRZUnpC?=
 =?utf-8?B?RFU5RytTUDYrNEJmaUZVa3FRWlBoRkJSOUgxL1VNcVJhc09JT3VPSUJ5Vnlz?=
 =?utf-8?B?eENDWllic0c3ZTJkenFTZXpTcjRLOThkS0RTdGYvdEZtbkUyVEgzcnYyV2pE?=
 =?utf-8?B?NUpiSzFQbHdDNllVRVpqbnY4RzdmOGMwNmsyQ3RkcHI4Y3JkUk92UnFJL0Jj?=
 =?utf-8?B?VUVpWDQyR1F0elBIVlF1aVFJaGVPR2N0ejBUWlhINXJUN0lJZ0hLNEt4Nk53?=
 =?utf-8?B?bUJhajREN0orUHVOMzJKa0Q0cXhGUTRRL2Ntd1pBcnNLSnRRbHRHVGw4ZVVX?=
 =?utf-8?Q?co+rLP/+wrVznhSTjjiHU7lLO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d9eacd-b5c6-4720-1b1a-08dd5adc7521
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:21:46.2132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzWdFLrLK0gdpHnB66BdtfW7jtp9HvbYUsfdCk4C//WcmGXJPOrTVDJFJALZli1Htp7Js5GNgMCmrbM41rhvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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


On 2025-01-31 11:58, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When register a vm range at svm the added vm range may be split into multiple
> subranges and/or existing pranges got spitted. The new pranges need validated
> and mapped. This patch changes error handling for pranges that fail updating:

It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.


>
> 1: free prange resources and remove it from svms if its updating fails as it
> will not be used.
> 2: return -EAGAIN when all pranges at update_list need redo valid/map,
> otherwise return no -EAGAIN error to user space to indicate failure. That
> removes unnecessary retries.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e32e19196f6b..455cb98bf16a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  
>  out_unlock_range:
>  		mutex_unlock(&prange->migrate_mutex);
> -		if (r)
> -			ret = r;
> +		/* this prange cannot be migraed, valid or map */
> +		if (r) {
> +			/* free this prange resources, remove it from svms */
> +			svm_range_unlink(prange);
> +			svm_range_remove_notifier(prange);
> +			svm_range_free(prange, false);

Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.

I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?


> +
> +			/* ret got update when any r != -EAGAIN;
> +			 * return -EAGAIN when all pranges at update_list
> +			 * need redo valid/map */
> +			if (r != -EAGAIN || !ret)
> +				ret = r;

This is a good point. But the explanation is a bit misleading: "all pranges ... need redo" is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.

I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.


> +		}
>  	}
>  
>  	list_for_each_entry(prange, &remap_list, update_list) {
> @@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  		if (r)
>  			pr_debug("failed %d on remap svm range\n", r);
>  		mutex_unlock(&prange->migrate_mutex);
> -		if (r)
> -			ret = r;
> +
> +		if (r) {
> +			/* remove this prange */
> +			svm_range_unlink(prange);
> +			svm_range_remove_notifier(prange);
> +			svm_range_free(prange, false);

Same as above.

Regards,
  Felix


> +
> +			if (r != -EAGAIN || !ret)
> +				ret = r;
> +		}
>  	}
>  
>  	dynamic_svm_range_dump(svms);
