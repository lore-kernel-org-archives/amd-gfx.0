Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7FAE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 05:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A498910ECE9;
	Thu,  9 Jan 2025 05:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TtFYtwhY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C431B10ECE9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 05:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxDJ+smaqnp5VQM74N/u/IxOT22p3JiWPCEXeBqf63KeIsv4Ctdt+npqnNcTkHdKjB/sWKqQf7S/DMRAgQGm8HcRJxnfrMK5a/zY92YgXy7RMq6YpoOgOw1OybV6BibYLpNHW/dsSKlCVqhRbBIQGe6enFQwbYAz+znH/sAj4niDyvmN8j6apXtQNcPPKY78mHjEUAxdIV76Orii2dG70qBSES2RRDgvZfAs3EEnZ5DRr+YAHRdUbrOgaJ5IwJBi4jeiaM/h4UunnB1VevuGmZorNOlDHUoL3O0lsk94j823Yl0+h75IMYduBi+QwdJX/4YQk/nzziZ2EWLIjqvwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ay36NqJA/gwKCD478PkfEY5ajxyIV1vdPQdBgXcJk4=;
 b=HTDY+Bi1mUMpsNRVT+DsFWyJ3xe3nHhWbVr1Z9tb8Gty5hUNhjG40Lb4qNgDf0hpZwXPhuJxDNmCwVD007/GWBFhEEnJI2VzdY5ihTjGtDIjk9pK75NH9DR2zWz0hHYSTzWx7FoJTUYA2CZGFhHzZVzqsyAlsJj9xNzbGp5bV2uPX1PP22tlSx5ahE4trClPK8uPY1+dXDh98+GukQrqWDY1mi8Fle70inB0yLl5GOlVhXvYtSHfSb8+4a7Q9pqUGhuQbR1eNd6koeSRzpTopT9saLG9MNsFN4rXhi0ztZafF7cr/9fVoTzKuXHl5DMKlYeoh2ors5D9r3Jsr1eU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ay36NqJA/gwKCD478PkfEY5ajxyIV1vdPQdBgXcJk4=;
 b=TtFYtwhY+vsJR9ZdHt5GE7uKvYg3Uqpqxl6ekPTKsFOzZE+7m69zeJ+6ZVp4CJ3umggl3UN8XSxNwGfE+FKwfel4JK6egOVecgR7Xazus75iu/FVuBhWYy4IssGv5Vwbsd4aBrCsdDCO1e7pG+WU2VkZQ4rocD+ocEXhM6cBBLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Thu, 9 Jan 2025 05:58:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 05:58:51 +0000
Message-ID: <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
Date: Thu, 9 Jan 2025 11:28:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: aurabindo.pillai@amd.com, kenneth.feng@amd.com
References: <20250108225627.14063-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250108225627.14063-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef218db-90b6-4806-f822-08dd3072b0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzltQVpWbFVVU3lhenNJT3M5QWdHejVvL2crVFpUM1VNU2tOYlRVL3lObWpp?=
 =?utf-8?B?d3NEekdrc0VmOERVL2NCeFFZdXdEVWdsaG9rclluaGdSb1IxeHA4TlZSWXgv?=
 =?utf-8?B?ejBRTE1FUGFydDFIL2VrcTd4WHNmOWtybGY1akdMb0Y1QlVCME1ETU84alk5?=
 =?utf-8?B?SzJoaUtYZHpqbkdrY2hqZ1Q5QkR1REh2MllKWjhYTlFkelZlMzJGUERxL0dp?=
 =?utf-8?B?bmQ3Q2hwVEw2MllTWW44Z2l5OVJlZTlWczJNdlRsQ2VmYU0xL0JZeFJGcFJT?=
 =?utf-8?B?bXkycUZmNkozckxtajFrYVEyOVZyVm5VbGVUUUNCWmRSMW5aOXd2N3VqRmdr?=
 =?utf-8?B?cnplazk3MFVUM3htTXI2QSttdzZQYUNDS1gzZkF5UGtkU3ZCMGdtcXBwcWJU?=
 =?utf-8?B?L2l1MFFDTS9QY3l0WXNEbHZ5Qm54ZkpmdVBXcUo0eE94WWhTcVNDZStRVGEx?=
 =?utf-8?B?eEt6bk96QkdVajR0S0lJczhhZ3F1QmhDenlQeVRqOVEwQzUyQW9Dd0pYbGFG?=
 =?utf-8?B?bE5HVHZzMUoyUjFyeml3VHA3SGNvVEg0M015OHkzZHdYTkZrLzR0U0hMN2F4?=
 =?utf-8?B?NzgyME8yQkxkeVdMS0ZEbkpQZXVnaGYvZy9Udit5WmtYczVVSmpjSjZYcVQv?=
 =?utf-8?B?WHdHblhSaS9HQjE2UncxbWRrU2xEbm5xYWpiZGJ3OExRK3BQUGN3MFllWVRy?=
 =?utf-8?B?aDNtbmM5MGJSQ0NScDJIS3B5UW9aejdwNm5kczhNR2xnMExFc051OXFac090?=
 =?utf-8?B?RU1OY2NDS1Z1ckFHR3h4NXhYSHdVa3Q3ekZhRWZhcS9WRko4bzZ0ZVc3NDFq?=
 =?utf-8?B?Z1VicnlUN2ZWS1ZISFJxZ3RRUU5WMi9hbTdnbkQ4aldLLzNPMkJJU2lxc0U5?=
 =?utf-8?B?SWp6R0Q2VUlXeDc1M3loTkVJdXorTEduVHBpVnhXSTM3Q05oaTVKY1krRW9L?=
 =?utf-8?B?SlRJOWFvRW1WTnptWlh1c3FGS05aZUtIZHJGRzFvTFk4NmJIN0xIY3VlYkNw?=
 =?utf-8?B?VWZNZzVadXZOT3hkblVhWmx4allMQi9NcUNFdWNleDRGZW1VNU9yUlBuQmtz?=
 =?utf-8?B?TWJqdWZnY3E5cXVHZmdJTTRvejV5Qlp1b2RJcVhpMGRVZUhSSU9ORC94MXVz?=
 =?utf-8?B?L3FyYnVQVjV2SFFZNXdsdUFhaFBubkp4MHpmcUdQbjJLYktwemhTZmFhdmZ3?=
 =?utf-8?B?cThkWndJd2hhTXFzUkRIYlA1UitFbkRsYzRLZ2RyYUZnL0FSaGNwNEpKeTYr?=
 =?utf-8?B?aE9LVEU0dUE0bU84UEdJM2srTWNZVHR4bGIvMTYvbmFxRWNITmw5cW16UDNo?=
 =?utf-8?B?Q1RCclFOaDNKZzgvU3Zhd0ZZdFZDQ0FQQTMwWkRGUktMc2trdDQwdEdPRyt2?=
 =?utf-8?B?Q3VBOWFIKzNoZllNSTlyY21sTisrdjFlK2VmVkx2RXJuU3dCcGFWRjIxMHNk?=
 =?utf-8?B?cUFIeWUwcWE3Q21YY21Ua3hSRUxRNytyWkdiVTZaWDZuU0txekpLMWZPSG1v?=
 =?utf-8?B?MXRITXJOcmVXeXp0RzBuNXNMYUpMaTAxNndBbTNoSnY1aGdIbmZWcStjY0th?=
 =?utf-8?B?RXNOVWVWOGtScS9Dd3gweWZEKzJVak12WTBpeTZQN09XWDFvMVF2R2h6c291?=
 =?utf-8?B?TmsxU2czR0hWZ1Q4UkdmY2RESHZNRGwwVURlY01ITFd6UTRMbEhMQWFESjVV?=
 =?utf-8?B?SW44aUd0ang2OXM4QlVaUTFWbVNtamVFZGx6dll2cWQ3UnZ3V2pkbkF3NElp?=
 =?utf-8?B?Znl0Mld2VXBrZDB1UlR6ZFhpampvYmRGcVJYWHZnR25LTkx3NGw3T0Q2UUtY?=
 =?utf-8?B?VDhUVjFvUE5QeCs0alVJb1V6Nk9WVTV3Nit2MlF5c1YxZjl3QTVVZ3FZR29G?=
 =?utf-8?Q?wDgI8OKh9zV40?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdvakxDc3psMm9HWVJEeE13N1FjVWtJTTRVT2hybVE5TXgvMks4UXFBMXpi?=
 =?utf-8?B?eDRGaFNYVlp2c21aY21kWlowYkNQSE1pRkhvWTJDOFdYVjVjM3BvS2pwaUlV?=
 =?utf-8?B?RENyK0wzVk8xUzR4NWtCd2QvMkpIQmlFOFBsVVVxWUZZbHlQNGh3b2ZmTzl0?=
 =?utf-8?B?ZlYvemZHRmlycm1IeEJmV280MHVqNEZyd2h4STBidFRYZzluSGxOWXJDc2Uz?=
 =?utf-8?B?SHBST0FCNC9QUnRuMHYyNXd2cHk3QWtpcXVXa3pIZFh2Z1hHMno5Wk1zakVl?=
 =?utf-8?B?akFSNVlGMlF6WVZXVFdkOGVMazZrMjZMY3lzUXU2VDJpamUvSEVTY2l1UTVp?=
 =?utf-8?B?bUs0WW4wWTh6cjA1QTh6K1dVUGFPb3BUdUpla0pwWVowUUxiSjgvL1JqeWpn?=
 =?utf-8?B?M1VQd2o2ZDBsMllLWXhzZDlIblEyMEJleUZMUGZrUUxQcWN2bkZMb0JVK3gw?=
 =?utf-8?B?d25NWXphN2RBMU5VKzNxSjFVOE5MellhRmJ5RlJNNlNCYnVUVkZvUE4wS2Mv?=
 =?utf-8?B?cGI4aXRrYkNVeG4wZXJQTzBzNW5Mdk5VQnFkN3dMQmc2TFVXWHFFdFduKytF?=
 =?utf-8?B?SmJ0VThPYWwxcmFncHdtcW5JS0RCWThYWUdSR2pydlpHSHgrVG84ZGJVOFpW?=
 =?utf-8?B?YzV4d2pTb2x6V0Y1Mk5LeGdQRTNMQUdDVlRvL0VoTXNCREFSNytjQSttWEwv?=
 =?utf-8?B?bGRIUjN2Sm5mL3dvNDFyWXNNaHlUTEYzN3hyK1Q3ZzAxMy9EZzBZZ1dLMXBH?=
 =?utf-8?B?YnFoUWpwQmZKRjIwU2krWTRwNXFJYUpkK3NLM0duNkxPeUFkS085eFcySVV6?=
 =?utf-8?B?SkZaQWdtUUxrS3dxWHh6aFY4OE5OZHBXT1UyZHNMTGgrd25zWWlqOVBUUisv?=
 =?utf-8?B?NitBL0FCNTFIMEZmY1VGejZ0TGtuUTYzRU1nQWxMR05CRDQvWHJnTmxiSExH?=
 =?utf-8?B?V2gwOFhRTWxwOEIyeU81bjRsRkYvR09nbXVRVHViZ2tWWUxiSlNnd0MzNlJT?=
 =?utf-8?B?a0Z5cEwxb2JWdVd0U0doY1NBam9jM1Q4L1o0azdpbWlRZ2ZYU2tUakNXMEkw?=
 =?utf-8?B?MGR6bVJjeVppNEdFSWQyYTJ1OWtJcFhZbmJLeHA5THMyWldwVEFWZmpoaEE1?=
 =?utf-8?B?ZW81SWUycEFnTE9WSjJmNFVZVDYxQndXeVRla1Bpa20zdUVyMjdQalBxTFA5?=
 =?utf-8?B?RFgyQmozczJxZlVKaTlZbElIWWFUZnVJdHoyVnplUU50cEFocE1mUGNjbWRX?=
 =?utf-8?B?eS8zcFZJQ3NXYiszR29XNWhnUSsyNXRqaDNqUzlFRGpyN0p0UkxBZldMYmk5?=
 =?utf-8?B?a1VYUGQydm55RmtKdE8xaG5tSkFUZkdmb01xN0tLY0FmbDNJMmwvVHpNNWh5?=
 =?utf-8?B?TkxDeGhZVkVqVG9NSGRCQ3A0aTFuMy93aUJYejRLTDRUNllqdXl2Y3ZGRldr?=
 =?utf-8?B?cTJEdStFTUUvVHJLemxuYXFEN285dkpHajJJb2tCcWpKenhvOHJSYVZJbGNt?=
 =?utf-8?B?RlpUMlRHRlhJbFUrOWlacWwwS3MrNklZL0tYUmNxM1VSZ1ZEd3lBVTIwNjRC?=
 =?utf-8?B?dXNseGdURjYrZ0EzdDdmVGJzdkZxdmJCbHhtVkJjUi8zeGdXVndsVnBaRHlN?=
 =?utf-8?B?eGNFVm96aTF0emd5MTlYUjF3TUtVQlJ3R0YrUmhPemdPcGxRakR5VXYxQjJi?=
 =?utf-8?B?ZDNMTU12ZWVLcmF4cndXbW5iM2pERlFLRHVvUkJRQk1IM0pvbDVicXduSXUv?=
 =?utf-8?B?eURPejd6aFBzc2pubDY1WmlRTW1CZU9Tbll3VjNjck5adnA2ZjRKTnhENjFX?=
 =?utf-8?B?Snp3UWdlZWFlRnNBL21kTXg1ZUR4RVBQekgvRlFzQ3lFT1VhYVhqOW9ReWNa?=
 =?utf-8?B?K2haaG9FT0FzRy9FaVlCV0IrQ0VzckFxeWkrOE1nUS91T0c4ZUdtbXVUWlJI?=
 =?utf-8?B?V3AvZXpjU3hpOXByem1saW5Odm1BZXMrOGhzckxrTHp1TzhYd0xBcU1QcjZ0?=
 =?utf-8?B?YmZqa24yQis3NWFJMytueWVZREJ6Y08xMVhRSmFYeTRTWmdKaVJzdUljVlFr?=
 =?utf-8?B?QUNleUpRa29Zem9taDlpb3BhNm4yOC9YaHlpUytDUkxrRkUycWtueU5ONVpI?=
 =?utf-8?Q?PXoahTkNGDe+pu3CTGdJWVBB7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef218db-90b6-4806-f822-08dd3072b0ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 05:58:51.1005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgDJLzE6YOf4kbj6nivcyA9+U0KIeD6VtXUvKIt2PhYWsFNtrO4GXPmr+Kr8aAl+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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



On 1/9/2025 4:26 AM, Alex Deucher wrote:
> Add helpers to switch the workload profile dynamically when
> commands are submitted.  This allows us to switch to
> the FULLSCREEN3D or COMPUTE profile when work is submitted.
> Add a delayed work handler to delay switching out of the
> selected profile if additional work comes in.  This works
> the same as the VIDEO profile for VCN.  This lets dynamically
> enable workload profiles on the fly and then move back
> to the default when there is no work.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 6d5d81f0dc4e7..c542617121393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>  	mutex_unlock(&adev->enforce_isolation_mutex);
>  }
>  
> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device, gfx.idle_work.work);
> +	enum PP_SMC_POWER_PROFILE profile;
> +	u32 i, fences = 0;
> +	int r;
> +
> +	if (adev->gfx.num_gfx_rings)
> +		profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	else
> +		profile = PP_SMC_POWER_PROFILE_COMPUTE;

Since profile selection is in generic code, it makes sense to first
check if the profile is supported for the family. Otherwise, this needs
to be passed by the respective GFX family.

Thanks,
Lijo

> +
> +	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> +		fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
> +	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
> +		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
> +	if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> +		r = amdgpu_dpm_switch_power_profile(adev, profile, false);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> +				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> +				 "fullscreen 3D" : "compute");
> +	} else {
> +		schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
> +	}
> +}
> +
> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	enum PP_SMC_POWER_PROFILE profile;
> +	int r;
> +
> +	if (adev->gfx.num_gfx_rings)
> +		profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	else
> +		profile = PP_SMC_POWER_PROFILE_COMPUTE;
> +
> +	atomic_inc(&adev->gfx.total_submission_cnt);
> +
> +	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> +		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
> +				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> +				 "fullscreen 3D" : "compute");
> +	}
> +}
> +
> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
> +{
> +	atomic_dec(&ring->adev->gfx.total_submission_cnt);
> +
> +	schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
> +}
> +
>  /*
>   * debugfs for to enable/disable gfx job submission to specific core.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 7f9e261f47f11..6c84598caec21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>  
> +/* 1 second timeout */
> +#define GFX_PROFILE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
> +
>  enum amdgpu_gfx_partition {
>  	AMDGPU_SPX_PARTITION_MODE = 0,
>  	AMDGPU_DPX_PARTITION_MODE = 1,
> @@ -477,6 +480,9 @@ struct amdgpu_gfx {
>  	bool				kfd_sch_inactive[MAX_XCP];
>  	unsigned long			enforce_isolation_jiffies[MAX_XCP];
>  	unsigned long			enforce_isolation_time[MAX_XCP];
> +
> +	atomic_t			total_submission_cnt;
> +	struct delayed_work		idle_work;
>  };
>  
>  struct amdgpu_gfx_ras_reg_entry {
> @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +
> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
> +
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>  

