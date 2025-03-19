Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BF2C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 07:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509E010E2D6;
	Wed, 19 Mar 2025 07:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMYPhIAf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08AF10E2D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 07:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo7/b1SVjgdab56J5Nc9GqN4MNEizUl3HHzDq0HUAYIbgKWY1MbGz93qe3RprQHTJMcJI8sy2YnZoH04aObgb6XNAe9PC0DE4k2Vk4wRY3QlnCtDQ2HQaMHtNx07e3vUjHtnZu4hFb2u47ZMGk1MYdtccVOMeKur5lAHo1QWi9x21r/JId8DgTqoBe105Z7YAIkURamFDimEWHEI/dz81BTrX+AabSGT3C643ktmjyogtWFGPA6/i/L34qF+aBTm9WcZ2vC/dakuMB+uT2NSM0z2WoESs0Qd9t1/C4BY7qpsG2al1gu0cv2SBCJB0kVGEFkjIdpxK4L6xqDbLhSpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDFcTv6LE1M+5jowi4l/MtqC9PgpzDvj2xgPy6C17LY=;
 b=cABzGmf3Jbq5TfG4NbfeiN3IX3wqSg42GAvTLAEJOK3YY1PjdBeKaRcHZziJQAQo6reJyx15GNiqKZdRyozZ8kp4nJqqQvjiFNWTzn8Zm1XUaKvSv41DAe682miIRw1Clz+dbIvO4aQLICmIjbXg+kpQRExXCwEAAw5Q+1gKqa+T3CXAyXC+FXxWuKJsMA7Nyrs2Z6v+CY1RcWGqPDeVcYRBtuwLK0Q9PuSwY5zjKHaqFYawkEwoh1uye2VySl/CLkVo6qKJbb89Zdse2Xe27aZOEk+A5orZT4eOB2XU2jmP/v6hqsKbwkMBYUoidrSa1LUSlQ0EzEjnK3sz3mVK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDFcTv6LE1M+5jowi4l/MtqC9PgpzDvj2xgPy6C17LY=;
 b=hMYPhIAfgP92tlxODoso7kgviZQgjevynjWYVHjub7zaTBKA6uxgcsY87OP0rCQrZspVprK5pxlLRIFR56ntpL9MgznV2cZDVsAoV82B2PMebBvsG/BE+AZk5wrL84vcbFK4L8Y70GXeX9k2/seo8CwYHZnCBQhOJKRTIHaLhU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Wed, 19 Mar 2025 07:13:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 07:13:43 +0000
Message-ID: <c0348974-ea24-4e99-b177-aa4038514afb@amd.com>
Date: Wed, 19 Mar 2025 12:43:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 V8] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20250319050727.4099266-1-jesse.zhang@amd.com>
 <20250319050727.4099266-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250319050727.4099266-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: ae32e4b2-7a3b-4f65-1d20-08dd66b594b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnB3NFBnWVU1MmRVVzZEY2JKUGh2Wjd0V0dMczNGQ1dmdlVoUWFRUGUwNXJR?=
 =?utf-8?B?RTRicnFGZG1FcWkwcHNCcHArVGlMYXBoUFlDRm51aXhycjJOdFlsU2x4dzBL?=
 =?utf-8?B?TlQwVHlFdk1WejJ5elFLOU5uL01SdXpPZk1WVlVpV2pmUm1QZUR4SDNzNGNB?=
 =?utf-8?B?SkN0aTh0cjhXaUY4RUZaemVSczkrbi9WV2xlODMyUEJRWENEYTFHYU5iVGJ2?=
 =?utf-8?B?Y3MrZEpIZ0I2OXdNL0xOUS9xNVVWbWJyVnRiSnhGdDl0L1EvRGh3SmNQa2oz?=
 =?utf-8?B?ZERrSVFLUVllNkR2S2wzWGlwMXd0TmdHYlNyTmY5cjVDWFMwTU85ZmIydW5K?=
 =?utf-8?B?SkNmVUxFOWIxSXl2NkxnWnBwcG1RdWkxOThINjBRTzVCTGl6NlNDNTZqS2ZS?=
 =?utf-8?B?b3B5S1RsQWtCSHVMenU0MkFiaThlQnNlUm9QdlZDYnVXNWtuQS9hUCt4VDg0?=
 =?utf-8?B?SWVFc2Ryek81N2FWcVhybXVTRUF0ZktMMEhKdmhLYXdtaFFyVFhHYzRJUFI4?=
 =?utf-8?B?eFp1MStQZnFyWDJxbDBqak00NnpiWURaeFFFdDN6NmFldms5bExVUWt6S2dB?=
 =?utf-8?B?MXJEMzlKcDlpcVMxNlI2ZXVENXdNQnErTVQ4RHBuaStwNnd5ZWtxakJjTHlE?=
 =?utf-8?B?eVVlT3liUDlDVUJObnMrYjY5OXZ5aStDWWR3UkNPQmhRdGo4Y3RvZm9USWRC?=
 =?utf-8?B?QWhBRnJoRkpudXhuSmxEYlNKM1gyMmpndHIvOWhOaEhCZWYvNWZFZWxRMVJq?=
 =?utf-8?B?UVRtWGU0YlV6S3ZFU2dHeEVWWGUvQlh1SnAvL2hjL0s2bS8zTFBvM3ZIWm90?=
 =?utf-8?B?Z1QzMW10ZXI3elgxay9TOUx5V2w3aWxROW9uaE81SHdiTFhMM09NUi83QWdK?=
 =?utf-8?B?QjR4TU5GSjJlTmhSZ0JzNTBiNDNJQldoOVdYL04wem5QT2svT1pqYVlTVEty?=
 =?utf-8?B?R3pQV0pLTFdNb0QvTk1iS3NNbkxsYjNKQlY1cnRFVnl5dzF0cGJmU0huS0o1?=
 =?utf-8?B?b0Vld2wyUFlzUjl6YjJQOU5IMjBielNCQ3kvekNwVDhlamRWa2xvM3RyUWZO?=
 =?utf-8?B?amU5K1Z0c1pYQzlSQXpub0hnSFJSVzFrYXJTVWxPT3F0OElzcjR0NTdleS9E?=
 =?utf-8?B?MVZvOEZ4eE1JbUxTZlgyMUtMbTI4TXV3a1h3K1dJK0dsKzVoT2lkWTJTeEZR?=
 =?utf-8?B?RldoLzNtbW5uYWtRY1lHcnNMcVk5WmJ5WWU4Qm1iUnBLUmZKK1NUdmdqSk5M?=
 =?utf-8?B?Q3VrTDlrVjdTaVNxRXBaLzhEcklYOEdCbFErMUtLWjBTMm9mUkFlbTF3bkx3?=
 =?utf-8?B?S2JQMUNmVlpLcWNsSGFyaU9ybnhKVHN0V1dla0lIZWFtcGZIcDRhWGk5aysx?=
 =?utf-8?B?dWt3SzRTVU9PVzFKbFZjak1LQXJZSWFpWFYyamkrdnBTVElwcHl1T3F4alVH?=
 =?utf-8?B?aXVKTXlkWmlJdDc1NnJoUlc5NlNjcDZGWDBZUnNJMHJOaGZKdU0wNjhVTlBM?=
 =?utf-8?B?QTJ1ZnQ3elZ5L1dFN2VSRXhaZzdFTkRrSjU3OEs0TDlHK0hoM0VvNkRkTEV1?=
 =?utf-8?B?T2gwTExlbndEUkV4VlFONmg4eUtINFNVUm44M2p0aktKczh2djBvTDR5MUZ4?=
 =?utf-8?B?bjF5cW4veXd5NUVoNzNjTkd5cjlpaXhlbm40bk5TM215SnZGTG1jWWJ5dS9P?=
 =?utf-8?B?SklYcXRCTWxmWmFzRDh0enJqVE9wYlQ3YWxlRHRCSEdWcGVqWCtMTXZBOS9F?=
 =?utf-8?B?eEdPV1k0VkprZi9zRlVmbi9SOFVMU3V3Wk04a0xPOUxHMklTL0d3UU42am9F?=
 =?utf-8?B?MzlyQzJlREdvOXJqVmtuT09lNEs5cTJUL2xRU2o1Y0tqUWtEeFFKaUxQOVY0?=
 =?utf-8?Q?MlF1aMLQT9ee8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVVdjl1YjdjY3lqbEpicUlYNnFOMUwwTE14NS9tSWFHdXNXbG5hSzNRR3hN?=
 =?utf-8?B?NFVzYkl5a3FEYTJaUyttMHRRVDRIOWhLSzlvVkpiTkJSR2N5TGgxZWhMRlFJ?=
 =?utf-8?B?VkczY1RWZG11SnpScDUwajZXV0dOeTFOdElGSmpHQk9jdGIxbytxSXh4b25j?=
 =?utf-8?B?My9xK1NyYkdJOERMcWVZNG1hT2F4TWozZU9pZEJaODJoamtyREZpcjhGQ3RF?=
 =?utf-8?B?dkxzZERtemt0dk5rVkJvMnFtRmpqZENzOU8xVlA0NGd4UEN4WjcvL21qbFpt?=
 =?utf-8?B?U055ejJlQ09CZ09EY1JiMU9PRjJBZTB0WlN2NkJtbytMNU9kVkF6b3huTVhi?=
 =?utf-8?B?bEI1TlhjNTJvUnNWRjU1OGhobUpneFdZYkx2N09xNENuU3JUdXhBeUh6Skkz?=
 =?utf-8?B?TnJndjQwVTRXM3lvQlpNaG1wV1JtSEdmbDVsck04c0JnWnU2WWpQWFROZk1C?=
 =?utf-8?B?bWZISnYySjNRNW10ejdGZjIyajVWZ2c3OHZqQVN3czdPVFloMXhUc01tQi9l?=
 =?utf-8?B?V0R6U3BlTkd5dGR5YkpwTmRBcE5NaWh3ZEt6SVlxRDlaRTI4WWh2bU92aVVk?=
 =?utf-8?B?c28zVU9qbFhTb1NOY1FqTUpvTlNrTFp2cXVrejF5ODRBZ2pYcWtoZk91QnNx?=
 =?utf-8?B?ZmZKS0pyQnZRTmFQQkNNQ3VzSmdGc1ZmM1IxNCszclU1aTdVTVpPRXJGNWFn?=
 =?utf-8?B?V0NldDdGcXptOWNHRWowL2Q4YVpBckY5bnlldjJQL09SM3ZWQUk0dWZOUTM2?=
 =?utf-8?B?cVQ0YzdsblRpTVVJS08wZE5kQWprb2U2eWI5ZjV5N0x2L1hKR0JxZWRMNVlx?=
 =?utf-8?B?RHhFQ29yV0Y5Zis3Z0lvSnBna1ZpUy8yUVZreU84VGpHYzArVWNmUFk4eERE?=
 =?utf-8?B?TmRDMm5zLy9rRnFySUxUT2Z2YmQ5TXdoSldYS3pVaUUrQ1BzNWZMQUFpSFdH?=
 =?utf-8?B?dW1qVWNIckZKaDZpbXp4eGpmYzRiVmdXaFJOeVora2dyMVJzMTZTRWZEcFky?=
 =?utf-8?B?SlNEZ3pvRTRhemRFRUxWZDhrd1NyVk41RUpwcVk4ZmR2cThzbHlPd0JzTnZX?=
 =?utf-8?B?WVZZZm5HeEQxN3MrUmR6b0hNZzMwaUc4cUZuL3IyOXRkZStpVUtIVFhjYnlH?=
 =?utf-8?B?alVRMDZPN2Y3SGxicHdtY3cxMXFLZWEySXMwMDFRdVl3M2Y4SGFoaHNlOWFs?=
 =?utf-8?B?OU5KZHF6c1J3VTlEWGpwQ05BZjRhb2pSMjZIOTdsTGg1QkhMTWJHQWxkMlZj?=
 =?utf-8?B?YUpEbVV2S1FhNmc3YjRjLzU1NUtaVlFFazJEakVsM1ZMSkdyS0NEWXZ0ZHRN?=
 =?utf-8?B?RmJCTkorQVh4NWFYSjFUclllZ1U3dFdSRDFwUExzcVlyUk8rQ21UNzNhdlE3?=
 =?utf-8?B?UCsxYjVUR0NqYmxlSXhZMnpON0dSWHl3dkNCMHFrejdmdnpBTHE1dkh3d2pk?=
 =?utf-8?B?VXJxQlFlQ0d6MGwyeU1aWmtDYlpBRDRvc2VodURWeGxzYU1HUmVERitBdmZW?=
 =?utf-8?B?SVBDMU13OU5hajBQT3doclAxTFNBWUdRUEExdFZQc0daTENHU0JaVmE3VHJQ?=
 =?utf-8?B?SEdjalRwVnNndXJOaW0yeUR3ekxjNTVKK1JJL1Q4RzFMazVmSlM2Z3Q5RnR2?=
 =?utf-8?B?MXZ1TE0xdERkOU9ZV1ZMVTJKNEJtSTZZdDhPYmpJRmRQem9Kc0F0bDJzcmhD?=
 =?utf-8?B?Umxzcm1mT1E1ZkpVeXFwZTluWUkvTWZlQndzL0R0NUJqMGdTZ1BNS3pCb3VV?=
 =?utf-8?B?em9ZUDBXU29mZTJCMm5xTTRrZ3hTbnFDV2lvQnBQMjF5b2FibGdDTkxIYVNB?=
 =?utf-8?B?RHFyZ2JXd1ZWemhBK1Z4YTZodzV2SldyWTkzamJwOEtVTGxlMUNwVFBVUFBk?=
 =?utf-8?B?aHBpTDl1Y2xuNUVFYnBLbUdNNjVGVlJuRmtZckgzR3RycnFmVThUNXZiRW9W?=
 =?utf-8?B?dGZQZnVwOWttaDVma2VNNDgvODE2SEFoWFloYytEemdyVGFTVnNaNjZCM0JS?=
 =?utf-8?B?NzgwT2YzOXorekhJZmtXelBxU3RLQUZJYjJRdUJmWHRicXFsZHVWM1NUUzhQ?=
 =?utf-8?B?enVVNFpBYTRHeVpkVmdjYjV3c2NTMmR2U0dET1Y2R0JjRXcwNXdBeHgyODNS?=
 =?utf-8?Q?WwsZfEyiyFUnRU1Jm2mPZuY5s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae32e4b2-7a3b-4f65-1d20-08dd66b594b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 07:13:42.9887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0lF1IDRc9373jj66qHyUNBsABvwVSKV7UbKgmVZwK2SoIJUpAE4s2dAbqLeWVS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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



On 3/19/2025 10:37 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This commit updates the VM flush implementation for the SDMA engine.
> 
> - Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM_INVALIDATE_ENG0_REQ
>   register value for the specified VMID and flush type. This function ensures that all relevant
>   page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.
> 
> - Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sdma_v4_4_2_get_invalidate_req`
>   function. The updated function emits the necessary register writes and waits to perform a VM flush
>   for the specified VMID. It updates the PTB address registers and issues a VM invalidation request
>   using the specified VM invalidation engine.
> 
> - Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide access to the required register
>   definitions.
> 
> v2: vm flush by the vm inalidation packet (Lijo)
> v3: code stle and define thh macro for the vm invalidation packet (Christian)
> v4: Format definition sdma vm invalidate packet (Lijo)
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 +++++++++++++++----
>  .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 54 +++++++++++++
>  2 files changed, 117 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..06ce0c98ef5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
> +#include "gc/gc_9_0_sh_mask.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1292,21 +1293,71 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  			       seq, 0xffffffff, 4);
>  }
>  
> -
> -/**
> - * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
> +/*
> + * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
> + * @vmid: The VMID to invalidate
> + * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
>   *
> - * @ring: amdgpu_ring pointer
> - * @vmid: vmid number to use
> - * @pd_addr: address
> + * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
> + * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
> + * L2 PDEs) are invalidated.
> + */
> +static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
> +					uint32_t flush_type)
> +{
> +	u32 req = 0;
> +
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
> +
> +	return req;
> +}
> +
> +/*
> + * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
> + * @ring: The SDMA ring
> + * @vmid: The VMID to flush
> + * @pd_addr: The page directory address
>   *
> - * Update the page table base and flush the VM TLB
> - * using sDMA.
> + * This function emits the necessary register writes and waits to perform a VM flush for the
> + * specified VMID. It updates the PTB address registers and issues a VM invalidation request
> + * using the specified VM invalidation engine.
>   */
>  static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -					 unsigned vmid, uint64_t pd_addr)
> +					    unsigned int vmid, uint64_t pd_addr)
>  {
> -	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
> +	unsigned int eng = ring->vm_inv_eng;
> +	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
> +
> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> +                              (hub->ctx_addr_distance * vmid),
> +                              lower_32_bits(pd_addr));
> +
> +        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> +                              (hub->ctx_addr_distance * vmid),
> +                              upper_32_bits(pd_addr));
> +	/*
> +	 * Construct and emit the VM invalidation packet
> +	 */
> +	amdgpu_ring_write(ring,
> +		SDMA_PKT_VM_INVALIDATE_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(0x1f) |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(0x1f |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(eng)));
> +	amdgpu_ring_write(ring, VM_INVALIDATE_REQ_INVALIDATE(req));
> +	amdgpu_ring_write(ring, 0);
> +	amdgpu_ring_write(ring, VM_INVALIDATE_ADDR_RANGE_INVALIDATE_ACK(BIT(vmid)));
>  }
>  
>  static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
> @@ -2115,8 +2166,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
> +		4 + 2 * 3 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> @@ -2148,8 +2198,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
> +		4 + 2 * 3 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> index 8de4ccce5e38..2da2e2443c87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> @@ -64,6 +64,9 @@
>  #define HEADER_BARRIER  5
>  #define SDMA_OP_AQL_COPY  0
>  #define SDMA_OP_AQL_BARRIER_OR  0
> +/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
> +#define SDMA_OP_VM_INVALIDATE 8
> +#define SDMA_SUBOP_VM_INVALIDATE 4
>  
>  /*define for op field*/
>  #define SDMA_PKT_HEADER_op_offset 0
> @@ -3331,5 +3334,56 @@
>  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
>  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
>  
> +/*
> +** Definitions for SDMA_VM_INVALIDATION packet
> +*/
>  
> +/* Define for HEADER word (DW0) */
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_op_offset 0
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_op_mask 0x000000FF
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_op_shift 0
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_op_shift)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_offset 8

By consistent format, I meant -

_offset = DWORD offset
_mask = Mask of the field
_shift = shift required for the field within that DWORD

Besides, all defines start with

SDMA_PKT_<packet name>_<dword name>_<field name>_offset
SDMA_PKT_<packet name>_<dword name>_<field name>_mask
SDMA_PKT_<packet name>_<dword name>_<field name>_shift

Or, better approach design/verif team to generate the header and copy
directly.

Thanks,
Lijo

> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_mask 0x000000FF
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_shift 8
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_shift)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_offset 16
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_mask 0x0000001F
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_shift 16
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_shift)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_offset 21
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_mask 0x0000003E
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_shift 21
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_shift)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_offset 26
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_mask 0x0000007C
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_shift 26
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_shift)
> +
> +/* Define for INVALIDATEREQ word (DW1) */
> +#define VM_INVALIDATE_req_invalidate_offset 0
> +#define VM_INVALIDATE_req_invalidate_mask 0xFFFFFFFF
> +#define VM_INVALIDATE_req_invalidate_shift 0
> +#define VM_INVALIDATE_REQ_INVALIDATE(x) (((x) & VM_INVALIDATE_req_invalidate_mask) << VM_INVALIDATE_req_invalidate_shift)
> +
> +/* Define for ADDRESSRANGELO word (DW2) */
> +#define VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_offset 0
> +#define VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_mask 0xFFFFFFFF
> +#define VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_shift 0
> +#define VM_INVALIDATE_ADDR_RANGE_LO_ADDR_31_0(x) (((x) & VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_mask) << VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_shift)
> +
> +#define VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_offset 16
> +#define VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_mask 0x0000001F
> +#define VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_shift 16
> +#define VM_INVALIDATE_ADDR_RANGE_HI_ADDR_64_32(x) (((x) & VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_mask) << VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_shift)
> +
> +/* Define for ADDRESSRANGEHI and INVALIDATEACK word (DW3) */
> +#define VM_INVALIDATE_ADDR_RANGE_invalidate_ack_offset 0
> +#define VM_INVALIDATE_ADDR_RANGE_invalidate_ack_mask 0x0000FFFF
> +#define VM_INVALIDATE_ADDR_RANGE_invalidate_ack_shift 0
> +#define VM_INVALIDATE_ADDR_RANGE_INVALIDATE_ACK(x) (((x) & VM_INVALIDATE_ADDR_RANGE_invalidate_ack_mask) << VM_INVALIDATE_ADDR_RANGE_invalidate_ack_shift)
>  #endif /* __SDMA_PKT_OPEN_H_ */

