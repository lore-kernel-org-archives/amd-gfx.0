Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2A8C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 15:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49F010E1CB;
	Mon, 10 Feb 2025 15:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="trAyBwkH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E87E10E1CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 15:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQskB+i5XUGwYAaoZXxTrqbT8VLzn9qcUkxaBhidzzmBxh9/i8CDS2lEfymCJvjSWfbAlVSi+REvm3NZqpnSAuLIrc156L9avTKVs5awWIxBqmNzC/CSGyTj0t3Ju1JI+ybDhUO7rT+hFXBD5CX9S4OZmk+GVLDcmvOcaNL6AyK7bacg5yYOts4gU45EaPPyHDtP/RBawLjXek8HbVCEBGIDdQDEm9rZef04tBmwPpHC4szwJFIo/35ZISA7nORCFcKwIQylS1IFz3vFMm8g/+XdIgaEaPyrFoFAHZWP14uFN7X4KrvuITjuGko4U537BWtx7OUYDgvbrweZZopmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzO8BCSnKYGL2hdwilggmd2m7JPjDahZjYzsAh+rKiQ=;
 b=xyxSB3Hx/7rokVZ2kLGY/nTVnBJ0DMv7ZYc4w6Fabb6NnfCrMBshEa6T2SjfXWCpuCwu9oD2yS91LQlUUYRHyRHyINeT6JSNtx+kOimzl0LtIoEZB9kSQbLlG+whKqQaUb5ZXJeh5LYaMZCAtdmEhovppmKQBx/5Cuzb0J6PkPB696JbnKxLzUs5rdx3+GgGzkgReaJJW3zR+WUNEDtAPrrPS6mI50FJ5PPX3R1/O1AMRFvQR/FAMsOKNrMQB66KsvzPtGK7opODV/wCe/B82PTVT5BKq2MFQ2Cs6Ot8yCiGWBUv1kXeI4XZzEChlMP9nkfl9xy92G3qqRpZ+OMe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzO8BCSnKYGL2hdwilggmd2m7JPjDahZjYzsAh+rKiQ=;
 b=trAyBwkHBvLdS3RJ2W7EJ3OEWxN6KoFBvFXI51ZdA7a9IPB8okVw2WcJ/hLfhancxHQ06wmzznjud414jKNqDT6pGWpNpXEpWCxIo571QvgZ1gJl315RQpTES2HMsHtZIdRxSutaHId4Q9BCZfT3HvoQreHxUEyBEWuz052XfFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Mon, 10 Feb 2025 15:17:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:17:38 +0000
Message-ID: <86a65dac-3413-4384-ab6f-6078c813760d@amd.com>
Date: Mon, 10 Feb 2025 20:47:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/sdma: Refactor SDMA reset functionality
 and add callback support
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
 <20250210073145.2681082-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210073145.2681082-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: a6707fc3-fa5f-48ab-b2cf-08dd49e60dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVdZWVcwU291cEt0S3NVVzJvd3AvYVdLd0hsR3V4U0lUQ2U2R2J1UVpEZ1Ar?=
 =?utf-8?B?MWZGaWJwV1ZjNTVTcW0yOGczeHI4dG9wTDIvWW9DR3JLU2daeFA5K0pIYXNi?=
 =?utf-8?B?K0daU2dZSkNWMk1JbDhzWXpmTTdlSU9JUks5OEhiMTNnSFFSbkFvNEsxYjB1?=
 =?utf-8?B?bmxDNll6ZWlEZmdWYlBvYzFsZ1U5VzJ5QUw3MGpoSkVaWjZXTktFU2ZIZlAy?=
 =?utf-8?B?eUJLUUFHV1A5eFBSUFVqMHpZeXdIUmYzMEoxNVkyUng3OVh1bEJFQitHdmdM?=
 =?utf-8?B?Zm5OUkIraVFMK2pjNFhPak9ZaVBZTXg0M3kzVjNYQXdrTUIrY2RBWW95cHpL?=
 =?utf-8?B?WWlDNHVEcS9xZXFPa3N3QTJNR2FHYmxqdHB1OEthVndOOUZyeERnTUFaUTZn?=
 =?utf-8?B?dm9UY21mU25JZHdmSmNyWWdzakVuY2x5S0JRcG9hZy83QVRVSlpNS1drMWJK?=
 =?utf-8?B?QzBkTTh3RkdrV1ZBb1hXbFhUTW1VMkN3WUcvWGljWTlpdmtYTCsvbHQzbXg3?=
 =?utf-8?B?Y25kU3MyQ0ZJakNvZWswN204U00yNE1tV1BYVlUrY3JQK3liVElzMDI2Z3A1?=
 =?utf-8?B?YTAxRlJvR2UxTE9EdklnWU9mMFMvY2h1S2VIZ0xsWmZsbEZHbkEvK05OMDRH?=
 =?utf-8?B?RlpHTFQ5SGY5UTNpc0hEQWt0cXl5bmI5S1JYazhibUpZSjRFOXUxZTVSMUxQ?=
 =?utf-8?B?d09jMjBWVVVIVnI4b2RxMjFjOWNMTmd1OEFBMjJ4VE11bE4rWi9FWlRNTkVy?=
 =?utf-8?B?YngzSWJodk1EcGNVdFQxU2tYdktYdUtySjZ1QytkaXhieXdrd2E1eXM5WTdT?=
 =?utf-8?B?dExuQkoycU9IZXRoTlowb2drQ3IxcHFwM0EzTm50amVEWFRkaEltbENPYjN2?=
 =?utf-8?B?RmpvZ05NZXA5Z2QydWlCbjhnZVcxRnd0UnhYcEFnUTIvblJldGtHdXRRcUN6?=
 =?utf-8?B?aFRWMjZlSWVrcU1jL3g2YVFldTJqdjFPZXIzakxLakY0dmloSDBtSkd4TFAx?=
 =?utf-8?B?TEVXYWxSWkxwd1V5L3ordldmaFdkT1dURzBpcmlESU1IY1hGQTNPV0kzS2w2?=
 =?utf-8?B?ME1CWW5nUHRxSCtjWlZ1aStRWDNZeVZReUdiSVZxMWVwaUIrVkM4bnJuNWYz?=
 =?utf-8?B?Z2RJd1RHVEY0aTV6alVYZUJ5QU9BaVhYUGphZDM1MWc3VnR3TUIwSG0xSlAx?=
 =?utf-8?B?bFB6SGkxNGpwVmdLZ1FqTzBuSzBZOGg0bHRVRnliRlAyRnpqcDhXUTdGRzVi?=
 =?utf-8?B?UVFpbll6UHVjd0I3c3RJV0did2Q2NXUyNDlNYWRMQWhVSzdubGU1emF3Vmh2?=
 =?utf-8?B?M1dyWFpneU5abHhydXlod2lNdTF6VHFUeEZiWjJMVnhKeVhVREt3eGowM1BB?=
 =?utf-8?B?TlFDN2JNdnFDMUlZdFpRQTBTWGlNREo0RkNVbHJNZ1BaY3hDL29xYmJIdzVI?=
 =?utf-8?B?Nm1sS2ZwUEVvRUdFNkpDak0vSUh0SjgvM1hpdG5IdTVzZHdTNkRrNkVjTXlE?=
 =?utf-8?B?aFpsWXUyRE8rOHdBdTVOdW41SGd6UFUvNm1KQUNRM29zeEZhdjEyb2pnbTFL?=
 =?utf-8?B?ZCtDcm5JUEUraW5pTGRoUlVzZnNHQ29IYnNRZi9XOVVUd0RMeWJuTlljcnpk?=
 =?utf-8?B?dW5GVkRWWFJlb0NxYnpqQUVPRTZMWDNiY3BVQm5pYkY5YnhneTk5djZZbmFi?=
 =?utf-8?B?UEZLZllSVHJyUjQ2MkYyUlBPY2srMWluQnZ2YStPSGlMWlJyMXY3ME9uSXM5?=
 =?utf-8?B?RE0yU001YjBKbFFnaE1ZUzV0YXJ3WE9Rd01tczlOWHViekhmL0lFcWI2Zzhk?=
 =?utf-8?B?cTNSWUw3Y2pjZnBDaUk2Y0hFa3hTbm0xL0lDb3RQUjI5K3BRd2NMaUpTby9u?=
 =?utf-8?Q?PZhDqi0JWj7SG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dxeCtoNm0rZXNBclpkQlhpUHBWbkdYWWFpOWtwSEEwTTgvdTl1OE5nL1hT?=
 =?utf-8?B?dWxGOEJuTVkwSzd5S3NMUWlXWGJQS0EzTU4wWTJMbXhMRmpFaE8wQ2QwdmVC?=
 =?utf-8?B?QmhLbC9rZklRN2R6YmdDZUttdU9KeXlQOXg1WmxtSnpqTmE3STIyc0ZNeUhq?=
 =?utf-8?B?OThyV0tETkgxc0lkKzVZQS95bm9YQlRZM2dYWnJFZkxVNnJGcXRuOEJ4UWxO?=
 =?utf-8?B?VjBLOUpXb0g4Wi9mcmVob21DWUk0K1R2d3FhTmtNUFFpUGdVY0M4T2t3eFAx?=
 =?utf-8?B?SjltYlBoYnIzRTVBRWRIZ0NDamlJenlvallocTh0YTdId0FMcnJLVEdpaXJU?=
 =?utf-8?B?bnNnUHRGNDZTSFVRM25ObFd3WTZvQUJXWTBTbE0ycDJoY3lacXRGanVSL2ls?=
 =?utf-8?B?Uk9CVnNaSDFmM01zTzY4ckVjenJMQ05xVWlTcnVwaWNOQVhmWlBidjB2OGt2?=
 =?utf-8?B?ZXl4WUdiZzBGaFh4OE1Pdi8xNUlWLy9GWDVJd3dleEJDR3ZVTkRQTVJMK3lE?=
 =?utf-8?B?M0ZZRXlDcnJDYkJ6NmcwbE12K2w1bFpXTG9UZkdtbTVKUzM5ZkVQUEluS0pL?=
 =?utf-8?B?RCtXdGt6UjlwWUtwSWo5UzlHdktmTTZjT0xQNEpXcEVob0JxdUEzcUhWN3Rj?=
 =?utf-8?B?STFEbXJnV0U3V0M2ZXhiK25helgwbzZ1bGlCSWpUbG96REI2enY3QTlveFcr?=
 =?utf-8?B?ay9NNFNSY0FUNVhmRkxxMDFDNkYxL29HNjZkdTZLYlRJWlIvejltbWVybHRP?=
 =?utf-8?B?dzJHc3lxVk1obm5HR3FPUE5CRjFlL3ZOblNwK0hIRU5jb1VPUnRPMDBTeU84?=
 =?utf-8?B?akcrV1prVk81RDU0QTh0ZndWeC9uOGNrNklSUXhiOFBnTTJVcUpzekFHSHU3?=
 =?utf-8?B?S0IwcE1GQWd2UWYwOHZsUHkvaU9LbmR5SmVjd0RIT2p6WUk0aVJHS2ZpdG1J?=
 =?utf-8?B?UDhEUnBDWG5TU0hNMlVyVTk5eDB6cjdTcGdJQXNwcGErQWpWMEpOdEdORUx6?=
 =?utf-8?B?UGN2Sm82WWNSQzJjMGtnS3dHa1MwRDA5TDlieUxTSmwxVVE1cnN4clRjT2Qz?=
 =?utf-8?B?R2FPUmRHenJGaUZWVmxlSVRDaE1VdDhodys0bkZ3ZEhGZFo4UFFuaW9PSUlz?=
 =?utf-8?B?N2EwbzNqZXdGTzc3enBmRTZRWm0zSVBHOTZtck96bzYzT3dtdzN0c1ZEYU9O?=
 =?utf-8?B?dTBQSmthaUV3NG42YlJNMkZVcXovQ2FDZ09NWklITjN5ZmFlN0JuY3RyS1dN?=
 =?utf-8?B?eWs4NHRHR3UwYS96U3FPYmdsWjRkM0tibzh4ZHIyTkFoQlcxYk5odEtkQTcw?=
 =?utf-8?B?aHFhRjUySW9iL3hIYk5HZG9xc1huOEpjMXJoQXVUVEo5TjJwelRqbmtidWQx?=
 =?utf-8?B?cWRVKzc3dTA0T3REdjRHTHNJVEJ6amRIZWlmMkloTDM4MWpmTTllNHJpanVz?=
 =?utf-8?B?U0d0L25kZHlENVFiWlc0WGVHZnQxYmV0MndiTm16TnczS3YxT0NQKzdaWDgz?=
 =?utf-8?B?Z2hoT2JGdDVtQjNrcy9uRTdyZXp5R09QUzJ1SWtvbk50RlNHaWgraUF0SXZt?=
 =?utf-8?B?Mm1VRmxsQUU4cUJZZVVoc0ZXYWdja0hoSzQzSTlkWGlHbmdBWmRtMkVWajl3?=
 =?utf-8?B?eUZWVjg0MmZEYVdtVzRjU3d0NVE1QldnelBROGpWOHd0aWF1UEhZREVNeUp1?=
 =?utf-8?B?dm12V1RuQ3RaRmVKNUFzWjZabU4xMXNReURJdU50MGU0dDI5UVpwUUNjc3RC?=
 =?utf-8?B?b0JFeFdGK1ZvWWxpYjJoRVZNMS94T0ZCUmpsQ3NaUlhPbDdQZkp0blpHTGtV?=
 =?utf-8?B?MlVMUlZjMmJ3Z3UvNkcxQkNISUdYRkROVVlwVExpNUU5Y0h0NU1VVksySWlr?=
 =?utf-8?B?eGZPMW42ZFdmNndmVCsyb21KUW1uVGNQbjh5Y0pMaDg4cWI5c2NXc0FJVmN0?=
 =?utf-8?B?ZTg1VFVLK3RJNFZvY2tQRXlWa3pmRDhubHpQSzcxZUltMUZiaEhVd2NEVHo2?=
 =?utf-8?B?dGFXaVFOdEptaTgvU2JrczdqTlpRemVVTXlPL1JuWmNhaDB2bDg3ZENDL2NW?=
 =?utf-8?B?WTBSaUp1Z0lvYmU4anRRSmN2WERpK09XOGVYazRHQXZGNWJuOFp0cmdWNVpq?=
 =?utf-8?Q?re070wV9sTV8rKYsiSo6Q7+Ap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6707fc3-fa5f-48ab-b2cf-08dd49e60dc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:17:38.2698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1noUMqc+7GjSIYnlmq0dfSnEHDUfyyNX7mxe4ykfcITO4CiFygha4CwvvdklLJBZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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



On 2/10/2025 1:01 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This patch refactors the SDMA reset functionality in the `sdma_v4_4_2` driver
> to improve modularity and support shared usage between AMDGPU and KFD. The
> changes include:
> 
> 1. **Refactored SDMA Reset Logic**:
>    - Split the `sdma_v4_4_2_reset_queue` function into two separate functions:
>      - `sdma_v4_4_2_stop_queue`: Stops the SDMA queue before reset.
>      - `sdma_v4_4_2_restore_queue`: Restores the SDMA queue after reset.
>    - These functions are now used as callbacks for the shared reset mechanism.
> 
> 2. **Added Callback Support**:
>    - Introduced a new structure `sdma_v4_4_2_reset_funcs` to hold the stop and
>      restore callbacks.
>    - Added `sdma_v4_4_2_set_reset_funcs` to register these callbacks with the
>      shared reset mechanism using `amdgpu_set_on_reset_callbacks`.
> 
> 3. **Fixed Reset Queue Function**:
>    - Modified `sdma_v4_4_2_reset_queue` to use the shared `amdgpu_sdma_reset_queue`
>      function, ensuring consistency across the driver.
> 
> This patch ensures that SDMA reset functionality is more modular, reusable, and
> aligned with the shared reset mechanism between AMDGPU and KFD.
> 
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 +++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 64c163dd708f..3e60456b0db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -105,6 +105,7 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
> +static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev);
>  
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>  		u32 instance, u32 offset)
> @@ -1330,6 +1331,7 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
>  	sdma_v4_4_2_set_vm_pte_funcs(adev);
>  	sdma_v4_4_2_set_irq_funcs(adev);
>  	sdma_v4_4_2_set_ras_funcs(adev);
> +	sdma_v4_4_2_set_reset_funcs(adev);
>  
>  	return 0;
>  }
> @@ -1605,8 +1607,14 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> +	u32 id = GET_INST(SDMA0, ring->me);
> +	return amdgpu_sdma_reset_instance(adev, id);

Looks like it may be better to pass the amdgpu_ring pointer as the
argument here as well as for pre/post reset calls.

> +}
> +
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +{
>  	u32 inst_mask;
> +	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
> @@ -1617,10 +1625,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (adev->sdma.has_page_queue)
>  		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
>  
> -	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
> -	if (r)
> -		return r;
> +	return 0;
> +}
>  
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +{
> +	int i;
> +	u32 inst_mask;
> +	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
> +
> +	inst_mask = 1 << ring->me;
>  	udelay(50);
>  
>  	for (i = 0; i < adev->usec_timeout; i++) {
> @@ -1638,6 +1652,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
>  }
>  
> +static struct sdma_on_reset_funcs sdma_v4_4_2_reset_funcs = {
> +	.pre_reset = sdma_v4_4_2_stop_queue,

It's better to call these as prereset/postreset. That makes it a bit
easier to know when the function is used.

Thanks,
Lijo

> +	.post_reset = sdma_v4_4_2_restore_queue,
> +};
> +
> +static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev)
> +{
> +	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_reset_funcs);
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,

