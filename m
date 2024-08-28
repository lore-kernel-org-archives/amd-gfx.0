Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A076C71143
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 20:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B050210E5E8;
	Wed, 28 Aug 2024 20:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iTdqzjMo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F0810E5E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 20:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn27QJdURwTngaL9JqWS7ILQQpXhDQvCgHECA+4Yjh68BSEFtS3M69MFjtrnruKZdkKmB0dC5H4ixsfipRyxT//UWr/x1ZDb5EBJTEyA3mvn77wtF1QsTodwJkOO438QrF3dg2jryCH61pi38NBpDdAuJQIdAihz0E35Onkyv1RIyYrMuSLbYpIQGZ3UbO7TldPhRMoOsGQGQvZEZwLlJxGCqtou3YJ744QLJO55hYwqohsL3oHTWRX6Y6DY+YmOtxqO6INiyuEg/G7UrRqN8HMKirKYP6i45ksvT+kMfXz6DH9tUoawSIZ1grig496iCGlTN8pZ1ta6GIFstQf0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JiES+DBmfEhiYurEAhr3qkwOfuLvfWZOLEtoCLUioA=;
 b=N9J3rdt1d0in4nAeqKJxJY9sLRg5iz2eLFdVPmZ6WP6UD/pVohKreBn5Nml9r3zs2yG5UmTg7GqvbOQn8npkoy4PAn5zwJq9HBnq/hA4yMbBB/kGPw7I97HoTv6iAKYCkn2kbHeKLEoc7zBWsRQ6ffTEpvRa5SPjsqbPomk7BemyMNWk4YRPaOw26BzqphlMkAtL2mrUg6q2vWgREF5sHGs9nZ9/AylDMqKlVBGS3Nw18kZ70qsqRmyDEuBCaytZz7OCdkiljWrSTOiN1aNEh/8lkqJ+Ris3rpogMprSKkYgKNYIN32/zVS6E0hY38QVzyikS9jHoFfwM1CuCrBErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JiES+DBmfEhiYurEAhr3qkwOfuLvfWZOLEtoCLUioA=;
 b=iTdqzjMoFE22Src7MXfL6N6zjZM2SbMLMzDs5KqNWROSVYTZvRC7DVbp3ypOiRypVcH0qkHtiVZjBPlPc8+ba5GPrxM4hdRIqP+QmPILkK2oY28NqUncvH/MLMX4VonxADLDqDc0iBSMM7+awV3vhnFDlwmUDSnWtLqP2PX8Gtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 20:58:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 20:58:52 +0000
Message-ID: <0a415809-7ffe-4bb1-9789-910b844d9392@amd.com>
Date: Wed, 28 Aug 2024 16:58:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 403bd1a0-692d-4f4f-019a-08dcc7a438f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFV5Ukg1dVRhTkhLN3VrMWIrL0s3L09pYnVEaUVXRGQyTUhzZmwrdUJjR3hq?=
 =?utf-8?B?QW0zNHhoS2RZamlKeXNxT3JGQ0NuOHVQdEtHWWg3dkgvT1RlQ1BVVG5WOHNr?=
 =?utf-8?B?cC9DY1paTTdkMUt0YlVjb01FaEh3dk9kSmhVYkRwVm4rMWhqeTRGOUtGY3Jk?=
 =?utf-8?B?MEJwZEgrckk1a0JBQjJFK256YzRkWFhndUFYbEVUb1ZJNTdUdUpwWHZvRUtw?=
 =?utf-8?B?eUhPak9OQVdFK2ZKb1RxQlpwSUt3VzhpM05iRUgxenlCZ1UwYnJqV1U1QlRt?=
 =?utf-8?B?NmRiNkZ2bXpRZk13dnZuWHFXQ2dOTWcvZis5NEhkckJsQ2JyblE2RHZhdjFT?=
 =?utf-8?B?bFliRldDci9aWlpJTCtEWCtpclRDWTZwTEZvU2xXRTJHVVQ2RlFRK2ZNR3Ji?=
 =?utf-8?B?N2JucjZoelFoR3NnWVBsWTNNTmplZ2dDQ0F3SnFKamZZNVFneitsT1BxbnFt?=
 =?utf-8?B?UldpdHBrSFYyQTV4VHlsMjI1cDlwclFLM09sYlBocWZlT3ZxaUxyWFk2U3NN?=
 =?utf-8?B?ZUxHYXFRai82MzlETTRoc2ZoaDNFMmM5TEZPWUQ5dzZWQVlORjhZVWVwSGFV?=
 =?utf-8?B?ZkF4WE9LWXdBamYzN1NOTXpJQ0VVY0pJSWVBY3lBeTFOR2Q1RjU2M1N1MnVI?=
 =?utf-8?B?TG1Xb05HQmxmcGtuNFA3aHNJN0xZcjVIQTdZNy9LRDAyNkRtMHA3cm5MZldv?=
 =?utf-8?B?d2lqNStnZTFlWVRsL3NYQTJ2TTFoaTk0RHQxT3lLSW13M0dUdnl4YUthdy9p?=
 =?utf-8?B?dzBlTWsvU1liT2k5UHBVRU5wVlh2czhrSVdlQjJ0YzNBY2V0VFlLZk5Mc1Rk?=
 =?utf-8?B?RUU0eDY3QWV1UDhuQjdrUXBZd1JIaFZQZmdxMmpwNkkxcXhPUVRQWTZuRDY1?=
 =?utf-8?B?MTNuMW5tTllBblJyeFFVUzArNVk3RXlOcHpuWTVZUllINTNsTWxpeGZoZnAw?=
 =?utf-8?B?V3lBL2xMYzMyU2pJNmJrTjZ0MzF6NFZrYnNhNXZqSjNBQ3hpWU5oWWljUmhp?=
 =?utf-8?B?VE1Yb2RBNTNvT2h6YjRBMklnSncxdlp4NlgzUlNjcG8vc3NiZ2pkQXpPdmpS?=
 =?utf-8?B?WnE4VXNHWm5YUStVdzZTVHN1YkU5bjZTN0RsazhTWWhYcUNrRjR0ZWo2Q21m?=
 =?utf-8?B?WGpnb0JFVU5iMi9ueGhpdCtNT3dSZS9rbG9UT29VamxoR3Yzc3RveFYwaklC?=
 =?utf-8?B?K0EyTjcrN1Y4K3NnemVTbnRSYVdEaXVadVBqWTA1NWdwdHZOemNDSVlRQ3RD?=
 =?utf-8?B?QmFtakw3Q3BOemE1dExmdi9mWlRyVlpyVk1wWkcrOGdaZGNwSkl2SUwxUUc4?=
 =?utf-8?B?T3VUK1lsM0N5bytMdkp6andRVXlielpEbFl3MkhFaFpKVjB1ajVCcHdkS3Zl?=
 =?utf-8?B?Yy9sY1J0U29vQUxIMnJ6aFdZeWZUSElWbktOcUlTR2JXVlVTRUVSVkdzYTQv?=
 =?utf-8?B?ZEhEbTJBN1lSdFpaTU1hMHZHMnJPSnhvYkQvZktzNkxxKzI1UmFZckdHRmFl?=
 =?utf-8?B?eEtwVWhleUVHaWgvMUU4U2NjdTZjU2pwY2M0SWgrYWZOTFFLV0huTzg0aXNR?=
 =?utf-8?B?R0pKbXVML2pXN2FkMm5LVFNSVncrakRMbEwwdUs3a3RycjFER21pUTZxVVQ4?=
 =?utf-8?B?dENjdlJXbWVUb0F0MmNldjlDSVUrTWFnbFNCUXEzU1A4allMeXliSUdKenlr?=
 =?utf-8?B?N3ZoVWpmTk5LNWJkL2lzWEVEOGNvMnpzWXlRMUVRR29Ca3hRU2VTeTdUVWtN?=
 =?utf-8?B?Vk51SEVmQ3V1U0JHZDlacUhIMGU2Q1pKMHFuRkg2SU14NldRNWwzRllLcXRZ?=
 =?utf-8?B?U1ZuVHJpdys0UHQ0N0pnZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDAvTU5ZRVI1NXFFaWJ5cGUrSzhwclJsS0t1WDJaUVRVQmM3aU54VFQ2SFIw?=
 =?utf-8?B?RUR0REJxZzltR0lNRkZocWFvc2owamJPbEZQWjdvYTREQ29xYnRSK0pHbXRM?=
 =?utf-8?B?c0gyQVF5NG84VlJwMXRmc0M4a1NRY1AyUm1XSzR1KzVVb1cxRDUvMlR0R3hi?=
 =?utf-8?B?MHI4T1M5cnArQ25UUzl3UkR6bENpZHRWd3kxZllVa1J6VVVSVlR6OVFaY2NJ?=
 =?utf-8?B?NFlEMkVCMGRXUDYwYzdhd1VlYVZPTmJ4Ym1uejNURGFRK1UveWpUcVphenA0?=
 =?utf-8?B?TUNQalNXUlVPdG5UcW9qMHdvY2ZPUDVDUDczTzlYaDlNQjZFZ3FDNHZtU2Jy?=
 =?utf-8?B?bWptL01KL05ubURpcDFhbEdSMTRMcU14MktNOHdDdGlXRFMzdnNvSExsZEdT?=
 =?utf-8?B?OTJMbnVWZUxsZDRpcFY3U05Fbk1OUWd5QVRKa1k0akpMbWNZM3JUbEZnNDVN?=
 =?utf-8?B?WEdFOFZrT1hOWnpEcE1LL0hWQ1pieGVTMEtSZXQxeWNCTkR1Zms4NEplMXBw?=
 =?utf-8?B?YXozejQxNzl5ZVdlN3FJenNFNnBCU0Nxa0lVa0pwMFVHVWd2R2ZVODhTa3RY?=
 =?utf-8?B?UzZVNDJLcmpqMmo4eTNnOGZaMnZOQ2oxS0VJa1gxZTByR0tSSTQ0UFdlTG1q?=
 =?utf-8?B?MlA3Ulh0TjhqdVpJa090cllTR0IvTkJZdC9rWTdVeXEvRjcyVEdMY3J2ZVRM?=
 =?utf-8?B?MEJabmJtYmdxT1lvZmFkby9sMnFYZzZoRXFna04vNVdHbWZZU3F5R1hTZTdC?=
 =?utf-8?B?amliS0lZUWl4QnJWdWwwOWFSL3kyZmNBOVIrb24zQnVnZHY5QVV2YWZtR3dx?=
 =?utf-8?B?a1NMajREZDdZWVBrT3l0dzJJRVJFbVlRQW12TWZBM3hOcjhyUnBWcDB3OUlR?=
 =?utf-8?B?RzExcFR1Vnd3M1ZYR1N1dU9vSEdIT0t2dmN1aU1BK1R6b2c2ZGtpZ3dPTnpo?=
 =?utf-8?B?YzZ4djM0SXRhL0lKWXhqSHppaE41V3pZMFl6SWthTFZhVk5DRXdlWnNqYnlO?=
 =?utf-8?B?ZFZDSmhQNUdialYwa0dGNURXWExSdkpYVnJ2TTZ0dVZRNDJZb3hMVi9HRmV3?=
 =?utf-8?B?WWpJNEt3ODFVem1YUU9kcTE3cEJKcEZ0SU53Ni83L1JoWlUzZ1BIbWlxeEV4?=
 =?utf-8?B?eTZLaDZPV2tNRG0rdjIzWUlVc1BZeFpRZkJUOStDa2tEZnIxRG43VFVWSi9I?=
 =?utf-8?B?ZkJWMzluQ0VLbjRlNzRtbXF2SWlZcHlrSHIxTDhqL3F4K0ZDUkNad2hYeGNt?=
 =?utf-8?B?ay93QTBHSldhSnVCMU43QXA5eGZ0MmxoSzBKZXFPd25WMUthdDVVNndsSnEz?=
 =?utf-8?B?NEF6MCs1R0lVeXhpSDJkVFo4Q2RtSXNZRXpiVDhwVEFMV01OUXBFVnYwTTlU?=
 =?utf-8?B?NW5LWUxna25vd0pmYTdtVUNRejJBVU5makszL2w0NG96SDQrN3Y3ek51Zmtv?=
 =?utf-8?B?WDBNQ0RMa2N3cnFFcU0xNXdQaVd4blRvb0lNOE1mR3VnR0hQZlF4U3V5TVdS?=
 =?utf-8?B?eEdUY3lQNE44eDRjZ0FXckhISWJFZ0JuSHNoRndYaXZZamVVcFpBSU5qL204?=
 =?utf-8?B?bHBaMis5N2MxaWdhWHowK0NLVlhQckxUdmhJcE8wd0Q1eEtIVGZuK0Y0aWdw?=
 =?utf-8?B?dHJCc0tRaEFhdy9CNFFXcHp3U1NVVVhERks0ZzNiMjdGdlE5cCtEVVN0eHRS?=
 =?utf-8?B?Q25pQXlabjZ1SFFCV3UxTVVKSXczQnJsNjdVTy9XQ3haT294a1hBWGlpS0ZF?=
 =?utf-8?B?cFM4OERwR0k0ZWZ3MGJxWmR6cnNmZTkxbjZONnNZR2dGdjF3ZnBhTGVGYVhY?=
 =?utf-8?B?MHZHQmlVWnpjUFh4REU3dlQ2a2ZmVzJab0YyYzJmSC9jdUxocDZLOWdlSG5s?=
 =?utf-8?B?NUd4RnJXTFJHUUpzWk54TDRRRXlmQllaZno1ODNQMk91L29QWDljRW5BVUNm?=
 =?utf-8?B?dFhHSkpZM243RWY2K05hQUJ3Z0doamREQTY2V1pSUEl3M09NL2U2ZUNiRjI3?=
 =?utf-8?B?T1lOOUFLenp6bEZkTlJIb2pXUFFoZ2MrQ3ZENS83eDZHRG50TzBKVTFGcVhN?=
 =?utf-8?B?eitpcEJ1RDFjUVJvcGYzQzBVaURYVnRhekVhR2VOc0FUTGdRa3hUbjhlbGcw?=
 =?utf-8?Q?gEe7ni8xBrBmOR94S/ziRMGVz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403bd1a0-692d-4f4f-019a-08dcc7a438f4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:58:52.5240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPEJoOO6wYA0lhAGixA4/Zf8J5Ba//TXdW0V/v7nPjEesQacdzOVu6XG+rBIkt9EvCTzD3h3Wx2TExT8C6oa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487
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


On 2024-08-26 15:34, Ramesh Errabolu wrote:
> Enables users to update the default size of buffer used
> in migration either from Sysmem to VRAM or vice versa.
> The param GOBM refers to granularity of buffer migration,
> and is specified in terms of log(numPages(buffer)). It
> facilitates users of unregistered memory to control GOBM,
> albeit at a coarse level

Can we change the name of this to something more human-readable? I 
suggest something like svm_default_granularity.


>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
>   4 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e8c284aea1f2..73dd816b01f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -237,6 +237,7 @@ extern int sched_policy;
>   extern bool debug_evictions;
>   extern bool no_system_mem_limit;
>   extern int halt_if_hws_hang;
> +extern uint amdgpu_svm_attr_gobm;
>   #else
>   static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* = false */
> @@ -313,6 +314,9 @@ extern int amdgpu_wbrf;
>   /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
>   #define AMDGPU_SWCTF_EXTRA_DELAY		50
>   
> +/* Default size of buffer to use in migrating buffer */
> +#define AMDGPU_SVM_ATTR_GOBM	    9

I change this name, too. AMDGPU_SVM_DEFAULT_GRANULARITY.


> +
>   struct amdgpu_xcp_mgr;
>   struct amdgpu_device;
>   struct amdgpu_irq_src;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b9529948f2b2..09c501753a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
>   bool enforce_isolation;
> +
> +/* Specifies the default size of buffer to use in
> + * migrating buffer from Sysmem to VRAM and vice
> + * versa
> + *
> + * GOBM - Granularity of Buffer Migration

This is really the granularity for page faults as well as migration. 
Hence the suggested name change. Also, GOBM is a new acronym. If you 
only define that in this comment, users won't know what it means. I'd 
remove this comment and instead include enough information in the 
PARM_DESC to let users know what this means. This information is visible 
to them in the output of the "modinfo" command.


> + *
> + * Defined as log2(sizeof(buffer)/PAGE_SIZE)
> + */
> +uint amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
> +
>   /*
>    * OverDrive(bit 14) disabled by default
>    * GFX DCS(bit 19) disabled by default
> @@ -320,6 +331,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>   MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(msi, amdgpu_msi, int, 0444);
>   
> +/**
> + * DOC: svm_attr_gobm (uint)
> + * Size of buffer to use in migrating buffer from Sysmem to VRAM and vice versa
> + */
> +MODULE_PARM_DESC(svm_attr_gobm, "Defined as log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");

Suggested description: "Default SVM page fault granularity in 2^x pages, 
default 9 = 2MiB".


> +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);

All the other writable options use permissions 0600. I'd stay consistent 
with that.


> +
>   /**
>    * DOC: lockup_timeout (string)
>    * Set GPU scheduler timeout value in ms.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9ae9abc6eb43..c2e54b18c167 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -868,6 +868,18 @@ struct svm_range_list {
>   	struct task_struct		*faulting_task;
>   	/* check point ts decides if page fault recovery need be dropped */
>   	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
> +
> +	/* Indicates the default size to use in migrating
> +	 * buffers of a process from Sysmem to VRAM and vice
> +	 * versa. The max legal value cannot be greater than
> +	 * 0x3F
> +	 *
> +	 * @note: A side effect of this symbol being part of
> +	 * struct svm_range_list is that it forces all buffers
> +	 * of the process of unregistered kind to use the same
> +	 * size in buffer migration
> +	 */
> +	uint8_t attr_gobm;

Attr is not a good name for this. Attr are the per-virtual address range 
attributes. This is the default setting for just one of these 
attributes. Instead of a long comment, just use a more descriptive name:

	uint8_t default_granularity;


>   };
>   
>   /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b44dec90969f..78c78baddb1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   }
>   
>   static void
> -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
> -				 uint8_t *granularity, uint32_t *flags)
> +svm_range_set_default_attributes(int32_t *location,
> +			int32_t *prefetch_loc, uint32_t *flags)

You broke the indentation here.


>   {
>   	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>   	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
> -	*granularity = 9;

I think I'd prefer to keep this here. Instead of removing this, add a 
struct svm_range_list *svms parameter so you can initialize this here.


>   	*flags =
>   		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
>   }
> @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
>   
> +	prange->granularity = svms->attr_gobm;
>   	svm_range_set_default_attributes(&prange->preferred_loc,
> -					 &prange->prefetch_loc,
> -					 &prange->granularity, &prange->flags);
> +				&prange->prefetch_loc, &prange->flags);

Broken indentation.


>   
>   	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>   
> @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>   
>   	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
>   
> +	/* Determine the starting and ending page of prange */
>   	start_limit = max(vma->vm_start >> PAGE_SHIFT,
> -		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
> +		      (unsigned long)ALIGN_DOWN(addr, 1 << p->svms.attr_gobm));
>   	end_limit = min(vma->vm_end >> PAGE_SHIFT,
> -		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
> +		    (unsigned long)ALIGN(addr + 1, 1 << p->svms.attr_gobm));
> +
>   	/* First range that starts after the fault address */
>   	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
>   	if (node) {
> @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
>   		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>   			bitmap_set(svms->bitmap_supported, i, 1);
>   
> +	/* Bind granularity of buffer migration, either
> +	 * the default size or one specified by the user
> +	 */
> +	svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);

0x3F is a little high as a limit. That's 63 decimal. 2^63 pages is more 
than the supported virtual address space in the HW. With 47 virtual 
address bits, 12 bits for the address within the page, the highest 
possible limit would be 35 decimal. A more useful limit would be maybe 
27 (512GB), which is the largest page size supported with 4-level paging.

Regards,
   Felix


> +	pr_debug("Granularity Of Buffer Migration: %d\n", svms->attr_gobm);
> +
>   	return 0;
>   }
>   
> @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
>   	node = interval_tree_iter_first(&svms->objects, start, last);
>   	if (!node) {
>   		pr_debug("range attrs not found return default values\n");
> -		svm_range_set_default_attributes(&location, &prefetch_loc,
> -						 &granularity, &flags_and);
> +		granularity = svms->attr_gobm;
> +		svm_range_set_default_attributes(&location,
> +					&prefetch_loc, &flags_and);
>   		flags_or = flags_and;
>   		if (p->xnack_enabled)
>   			bitmap_copy(bitmap_access, svms->bitmap_supported,
