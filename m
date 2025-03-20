Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A86BC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 14:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1470410E621;
	Thu, 20 Mar 2025 14:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfGWZBBv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E68C10E623
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 14:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjXzmttz3YKd0GcXp2zHRRjn4UuLTO1cg5ZaDfARPiLWZ+cJ6I/uMARLAKxya+BOHLcL0hlaH/Dpd/Kb6/NIe5Y+xQgVnbOJ66TIT8tWFr61w1VI0R+3tVJK4SeKAD9KfxjibG4lNBMCXKEGXZJMKbMUDMnuS3dTHnlcD3FdP1b2fY2M62pHXgUsZYPW90B8BySPyszGVvUy7KvtKLHDdDSXu+Oe9Aw7PF5dio920xgXDlyIeztbMxF6Pf4hoqXNvtWTam6iA/Eo8LiGnIYmbzk+7gTLTzdZahhSGyhnyz5LvFVGvgKMLnlKAFFyQdWI1sYwChS0F/uqgQASIs9bPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR+7AK2UOV7c583r7L1u7i5mgsrtj3Kz/5/vLunDl2M=;
 b=RJYIYL4+fZ6YCYhxys4DzX0SQVPf3qmQHpmrVTOe1u/wF/iyn3u229McYC6/jVgbywTOvb7U9G/peIqKeb6ioKsrhpvU80qYY7U0EKZ6yS6BZIPKkpUQdCeLROsRgZfcnzwtsXZOygb5E9dLhqIKbwqVdNFebQcGAy3W+QXU+6Px1UWJ7VNSlwAwmQ/EMGgrno04hf7jw/aIFzOR0fRV7JFU2p6rZmL47g5tEeKqIni0zvbrE9RYk8cF1RdBSHOpvpo70s0asoFTQIgBWuDMmx7wYaFrMhd7h84pwNe1V7sAwIpzZG0EDBKFLymFZ7FiWL2fZubWhSVe0hxzCLQCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR+7AK2UOV7c583r7L1u7i5mgsrtj3Kz/5/vLunDl2M=;
 b=OfGWZBBvJAsQOtN0uISUY6N27mxgF0SFPABWS3qmxegGX4CA1/xpZJp+oUurk6dxSZRQtGE9G5tspMiXnbze5z/VX0EV/5FIL+A++ykwpURBU3TlFVaUHzqboX03r14E0cMdkKxPtCfUMnoJf4qPctssRIcn+m33N5M53d0wVBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 14:27:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:27:15 +0000
Message-ID: <6b9a46ac-184e-4c70-884e-374053876574@amd.com>
Date: Thu, 20 Mar 2025 19:57:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20250320050943.4161194-1-jesse.zhang@amd.com>
 <20250320050943.4161194-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250320050943.4161194-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2b4e54-6969-4405-2c9b-08dd67bb4f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnppY0tLTzllT1FObHZHb01Lemx1NHR4S2ZYT3ZJSFZ2OWhwdExVTUZaOG1r?=
 =?utf-8?B?djQxU1FsWEdBa05zNThoZFBDbStGL0FGMmtXa0N6dlBtZkhYMktjcmEwMTBw?=
 =?utf-8?B?QStOMExCRzRrZmRVU25vZmFNUlZydWU2aTJVK0dFNjlDNExtV2pxdlZBczlV?=
 =?utf-8?B?VjZWSFQzUnB1U2o5eVMyVmRRNnpTM1BQei93dXIwbUlQZzhOeUw1eGxFdHQ3?=
 =?utf-8?B?SUtGMFR2ekhqUXRXbVpjNDhHM0l4alBoOGRtcDh0WC85NXJyL1JINmFWWDVX?=
 =?utf-8?B?RFo4d1ZuaFYwZzJtYlUwTzltR2YweVhSR2VKVHBueW1kUFZIUXo3V2Yram5I?=
 =?utf-8?B?VUJsZXZSQmZ4OGFDc2JzWnBpYkhudVNjTjFYNk51S0NkZ2NieWRSTlhBb1h5?=
 =?utf-8?B?UGVSS1BLVlR1THZKZ3g2V2xWeUFUL2xaQWwvSFJ5TUVsZ0VDbjB4dXFjM3hL?=
 =?utf-8?B?M3hoaWwwUGdkVXlzeENhWlhremg4VVVPYVh1Y3F6bE1YUkE4aHRVTkV1R0FH?=
 =?utf-8?B?VHdxQnltVnIreHFxMlhUMmFRWk1sWXdwem95bjRQb1RXSDF2WFNndmhYNmUr?=
 =?utf-8?B?ai9HL1BuNzlldDRzVzVpelM1YzZVdUxQS0JLRDR0UjJzNnE2VEJFZHNFYmNL?=
 =?utf-8?B?bHM3RGwrYjBpajI5K0ttZVJzTC9MVk8wbUJDb2MweUVsdE5udjJ3VGdtU1Y3?=
 =?utf-8?B?K1ZNZ1piMG1IMG95ZEpxTndUUkhZbktzT29HbU5CckJORENWTHg1U3VRbVNq?=
 =?utf-8?B?b1ppMFRNOVM5OFU4VEJLMmtxaGlBb3R0OXp5S2RyL283R1c5eTdlNDhkRHlB?=
 =?utf-8?B?dEp5WkNYSk9VaEZJMkVFLzNhaWdTa0ZVNGV6WjJQcm5BSkkybDYvcEYyMFQz?=
 =?utf-8?B?MkY2ZUhPWGFlajNvM3g1V1pSSEpIdFpNMHFPeVBWNU50WUlNbTF1L2FIRERy?=
 =?utf-8?B?RTlpRWhiRktWZVJEb0NSMlJFRnFSVU90T0VxVVQzSnJJMW5UTGMxVURzMzBX?=
 =?utf-8?B?YzFTZzdqY0Nxek9DUFRxSi9sYTVYN3p1L0R5ZGd4RGUzZERNR3ZVcGRPNm1B?=
 =?utf-8?B?cCtKTWRGV1BQNk1KWEJySjgzQ2FWSm9RMy9SaFB5eEhyZDgxNFQya3F5TzBL?=
 =?utf-8?B?MVdrMEk3VFYrVG5HekN6ajJJazhBN1BVM0ZjZzF0RTJWdjlJMG5wbnF4VFVp?=
 =?utf-8?B?ODFKci9wcVJzS0FwMnMxUDRIQzg5RFE4dkpad1JXMThzdE1mbWZSRWlwU1Ry?=
 =?utf-8?B?RkpCRng5amRaOWErbGd5dzV1aXZYMWZiTkdjQXN5YVE0bFBKOXdNemNxUlhp?=
 =?utf-8?B?REdYdnlzN09yTXdMNzJtTkIwYVZnZGdTbkV1dVBYOG9hMDdoUnhKeGpHd1VC?=
 =?utf-8?B?aXZXSDNPaGZ2a1Y2NzhwNUtQREU1TkNuRUhKcWdkOVlTNTVwWkNWejBaSXRp?=
 =?utf-8?B?ZzFSTytvWjRDQ1l2Rmt4cVBta3B0akdBMFJJTFpCZ3U4WEl4ZTJSZnJnY1pm?=
 =?utf-8?B?emVqb2NSRGovZDFBYlovcXpjQ3FMOVZJWnM2cFQrcEJyb3liMGNKZityeksy?=
 =?utf-8?B?dVphV2g4M1lMODFncmtHVkJJOFRUTDBiUmgyNmxPR3ZRcXNTTkxOZ1dRQ0la?=
 =?utf-8?B?OHc3dUN2MUp0TWpiUWN5RW1JeTNqdHBVb2NscmE2c2xNZG91Y09RRVBrdndQ?=
 =?utf-8?B?VDBYV0xwM0x1aWd6T09JYWU1MFlMMXF4S0JLbGZJSFFhNDFMRFJ6V3YvdmNS?=
 =?utf-8?B?K1hGVERBanNLUzlVU1pWQ3dRdmtJQ1hnNXIvT1Izd0ZtaG5wTU5YSGprbWtT?=
 =?utf-8?B?N2dhdWhsMVpqeHdWQmE5V1FtcDBnZEJuSkJ4Z3p3OVZvQWl4VkNaeTkvaFB3?=
 =?utf-8?Q?4cLsYLaAiqKvK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1MyVi9Pa3RhL1NJYXg4UEI2dGx2a0p2Qko0Q3hGUTJZMFZBRUVTNUxMa1cv?=
 =?utf-8?B?ekFQOXhrejltSGRZZUQ1TTJTemRpYW9oUDJlb3VTOEZSQjBOR0VQWnBaVitH?=
 =?utf-8?B?Qnpna3hMZmxXT3BRRjI3VDk2TDNrSXhWQWNSZkJsYVM0T2swSU9RTXFpdHdB?=
 =?utf-8?B?SVY4WENSdTNmVmYxSVhUREZiTERYTjNFSTl2cFF6TzZWWXd2WkJaTjNyN1oz?=
 =?utf-8?B?czF2UVdLMW44UkF2SVNZcUUyZjlmWWpndjlrZDZ0SzZaZHJGZWNQVlFaYWJM?=
 =?utf-8?B?UE5jQ3B1d3puSlZXNUU0b0FjU2VFSVVWejA2VExTQ1pyRWRKSW5hYmNmcHZJ?=
 =?utf-8?B?TFpaVlc5ZUgxUkVCWkJucThYakljT1NsT2ZzMml6eU1XZHFJSzZmb05FNEpL?=
 =?utf-8?B?bnVBZEwrSUFJV1BMenY0VW1MMm1ZajJzeVpBc05MczhvdnlWSUt3R1hCK2Za?=
 =?utf-8?B?Zkd3bUR2c0w4bjFzbTF3STdDbGJKaVl5MUlJZ0Q1MDVNQmlkRGZOcCt4dkFR?=
 =?utf-8?B?VnYzYm9LK2JkbDgycVh5L2JFR0ptb2pOaWZOMElpTjJZSUMyNUIxcVB4ZEhI?=
 =?utf-8?B?TjVqczYrYjdvRXYrUlpyNXJIQjVESTlqbDBLcS9mTzFQY1BHbTVJZTJQd0l1?=
 =?utf-8?B?eUdZMjZOZzJYd3llNTRKWEJwcHY0anBmYXUzcjRMSXRNaHJpRUdtdDY2ZjJP?=
 =?utf-8?B?dlhHSWZ1ank5L3hEbzlPbWhKQm8zeVVHSHZlNnBzdU1jazdkem52YjcvQ3NL?=
 =?utf-8?B?cERxblFkSjJLMmdGMFp6bnNFRzJWU3YyR0ltQmNWelUrcWk3U2NxVTJNSUwz?=
 =?utf-8?B?bVI5S1g4dG9oMnluMW90eEwvdy9DVk4vaFdMY3M5Q0U3Z1JTa2FBUFdjZUNS?=
 =?utf-8?B?NjVDamh5U1VRZkZiSjZxa090anJla1E3d0pzd2RIdHBITTR2YkdFYkpjb3BP?=
 =?utf-8?B?RzVrblNuWWZId1dEQ0dvcWthK1VkbXRsUHhSZHluek4wbnFYOUJHWkN2cWdq?=
 =?utf-8?B?bEN6TFVqMzdmejJtYzZXdEdLVVJ1WFFjZitydzVVQnpIZUMraHhGZE5XRmMv?=
 =?utf-8?B?VEpyQ2ZQUzd0WU9SaUxYUXpuSGlHUDc0UXJiNFJ4TGZrRmh0NFlwTERnYUVs?=
 =?utf-8?B?ZGk2UGhMNVluZHdpTEFDenRxem9oeStodDRQbGV2WlRMdS9UMjgyV2Z1dDhO?=
 =?utf-8?B?dEdrL3loRnB0OWZ4WlFjSVA2TktkcVVhUEQ3VEM0dmlaT0kxS3JTdmFJY1Qx?=
 =?utf-8?B?dTlvRnR0MlJjalVTUlllZjB6aUtEeWM1U1V0YlNEQzkyRGxIcmhXbzQ3YTdX?=
 =?utf-8?B?N3pyWFpZYmNYT3NBcjVVWTFKM1lBTi9mZlhkeUl2UFV1ckhWQ3pkYVpMTjRQ?=
 =?utf-8?B?eEhpd2RWdS9rVWNzRk8xcktVWGZSN0ZKQ2h5MTJxd1J4SExWUU9yUThvakJs?=
 =?utf-8?B?S1dwelRITkVXY3FwN3A4cVpDbzczdGVrcml0YnFTL3ZZMXdJZVJ6SmxhbnJQ?=
 =?utf-8?B?L3ZMSFpzMFM4NWJheFo0R1BzL1p2MzgxQjVMSmNHRHBvWWtISXNkT1Z6M0VQ?=
 =?utf-8?B?VGV0eHhZcm84V3JtQUp6SUluelVXYU83eU9xOTRQMHlIUXZFcG93R2NrbGlS?=
 =?utf-8?B?aFVISFlPTndWT3QxMHljcjkrSk5UTHVvY3BoU0V3bnJ6MStlTDIyd0xESmRY?=
 =?utf-8?B?WmxBNExFTTFGbDlwSFkvUlBoL0JPaVN0S3F6dllRUC9lQ3hIcWl4K0VGMWxF?=
 =?utf-8?B?NFM1Vm5rQzJMdFlJd2c2NGltTGhGYWEyTUZPbHl1dWlnWGVpSEtOd01jR0VD?=
 =?utf-8?B?ci9ienZmbXFHR2lBTjZNYU5vT0ZxOWI3bDBObDVEQ0RCaTJmcFdMcmZDSnFE?=
 =?utf-8?B?bUdYSDdPSm1PSzJJMkV1WTBPOENzTWNoczNDcGtOTEpIVEw1YXlNcHFHNktt?=
 =?utf-8?B?UlRSUmplWEZTZS80K3Z5SmVhc3ByallUYUxuQloyMHNrV3J2Z3ZDWmYrQVhs?=
 =?utf-8?B?YmF6VkY1UkxmTys3UlROckhWV29FZklXaHVDUnFPaXF6K0NRZHQzVGFabXZl?=
 =?utf-8?B?SjR3cDhFNE44bWNXK3Z1VzVYcFo5ZEpjRnVGTGptaFFiTXUra2ZDYU1Wb3po?=
 =?utf-8?Q?GD49F9dqPSgp0wYner7+puCld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2b4e54-6969-4405-2c9b-08dd67bb4f79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:27:15.0780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FrjeaFVOc8U80ADWyGvDaSQd/ifLVz7A5PRtqQSvg+vIjFJDB8uIQWpVlY6leDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
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



On 3/20/2025 10:39 AM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
> 
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
> 
>  v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
>  to check if a ring is an SDMA page queue.(Lijo)
> 
>  v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0
>  v4: Fix code style and add more detailed description (Christian)
>  v5: Remove dependency on vm_inv_eng loop order, explicitly lookup shared inv_eng(Christian/Lijo)
>  v6: Added search shared ring function amdgpu_sdma_get_shared_ring (Lijo)
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 20 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
>  3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4eefa17fa39b..464625282872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -573,6 +573,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
>  	unsigned i;
>  	unsigned vmhub, inv_eng;
> +	struct amdgpu_ring *shared_ring;
>  
>  	/* init the vm inv eng for all vmhubs */
>  	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
> @@ -595,6 +596,10 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  		    ring == &adev->cper.ring_buf)
>  			continue;
>  
> +		/* Skip if the ring is a shared ring */
> +		if (amdgpu_sdma_is_shared_inv_eng(adev, ring))
> +			continue;
> +
>  		inv_eng = ffs(vm_inv_engs[vmhub]);
>  		if (!inv_eng) {
>  			dev_err(adev->dev, "no VM inv eng for ring %s\n",
> @@ -607,6 +612,21 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> +		/* SDMA has a special packet which allows it to use the same
> +		 * invalidation engine for all the rings in one instance.
> +		 * Therefore, we do not allocate a separate VM invalidation engine
> +		 * for SDMA page rings. Instead, they share the VM invalidation
> +		 * engine with the SDMA gfx ring. This change ensures efficient
> +		 * resource management and avoids the issue of insufficient VM
> +		 * invalidation engines.
> +		 */
> +		shared_ring = amdgpu_sdma_get_shared_ring(adev, ring);
> +		if (shared_ring) {
> +			shared_ring->vm_inv_eng = ring->vm_inv_eng;
> +			dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
> +					ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
> +			continue;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..45dae38f802b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -504,6 +504,37 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{

Better to keep the (ring->me < adev->sdma.num_instances) check here as well.

Apart from that, series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	if (adev->sdma.has_page_queue && ring == &adev->sdma.instance[ring->me].ring)
> +		return &adev->sdma.instance[ring->me].page;
> +	else
> +		return NULL;
> +}
> +
> +/**
> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
> +* @adev: Pointer to the AMDGPU device structure
> +* @ring: Pointer to the ring structure to check
> +*
> +* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
> +* It returns true if the ring is such an SDMA ring, false otherwise.
> +*/
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	int i = ring->me;
> +
> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
> +		return false;
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +		return (ring == &adev->sdma.instance[i].page);
> +	else
> +		return false;
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> @@ -545,7 +576,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>  {
>  	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
> -	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>  	struct amdgpu_ring *page_ring = &sdma_instance->page;
>  	bool gfx_sched_stopped = false, page_sched_stopped = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 965169320065..77288bfb4e76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
> +struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev,
> +	struct amdgpu_ring *ring);
>  #endif

