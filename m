Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C0C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 08:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7322910E47F;
	Wed, 19 Feb 2025 08:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbEamLzF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A5710E47F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 08:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxMiizJaHDyF0fanu8i2cA4T10Dme8FT+d9v38R4M50qXeVbhU3SqjcOXJF8il08TlP/cNEHPeK8nVvoWv+3U+E9FAtc7lBlj6KPn9KdqryZ21ozp8Xq2e9cK+Ns2dUzXfRNGjdNyZqLoKgkQV2/ToObU5WK5ppC4w4TF966mycdZg0QckCbaEtTquat/zQv6DWBvx2AkGp1lTdmaL2dVebNenq4NLCd80FLd8p3KaHqo4DngpQTTxYeuUbfbxLIbvvjBvmEtbCXHRmUgEjvprfRWjszhlalUlSvfZPBjt04zkiotFDTPiRi/XNHsUW1Iv+ZcUDN98baHfFMf7kx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Iaml66n8ddfNyygPSRkgDyPpvnHwWwy+2/dfLfijLQ=;
 b=uIcnf0HKjSm4mBmrRrq37hF51yz/25U/CEeCZirU/S3EaKK5/ju3ia5KezaPffnwGtm8IHNnV4MjGtFN1Bnxiyvvlg+rSCFYEytC58SqU0cn8HAEwZwuLGICoPfy9/gfrcjm4wrWSObrAdCbtufQ/hxyTuBDRo+Ix5dZyt2vtxpfTkNNIcuw/xUyARrZ34bc29J527fS4ZH/Bms5A6QXMaquriuLXbPVcHJg+MIFr+eWd52xfbSiiCQeh2Id2HGaqk9+1A0pjIiH7q2xPBIDwz/gwZJ1Xxqo21/aOwEarl3LX4zyv7w0WJXtMLGr+KDK+EM0houlWc8skBSZehh3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Iaml66n8ddfNyygPSRkgDyPpvnHwWwy+2/dfLfijLQ=;
 b=gbEamLzFVOurAsQ1fqlrNq++r37CpnZ4GUTrQIlVCkaArqAAFDij+w3+PtSQzC8bJz+T39wDoXnq99w8o3GuScHJLcs4dlzq2UPEbayoNb71oKWzYaxL2LpbZL9yWazeIJMt75C4J2atjX4BVc4HpzBQKH7BwuMvYshqGeLSi6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 08:28:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 08:28:10 +0000
Message-ID: <0a469775-8888-48bb-95fb-d05b81af8be1@amd.com>
Date: Wed, 19 Feb 2025 13:58:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250219080040.3547468-1-jesse.zhang@amd.com>
 <20250219080040.3547468-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250219080040.3547468-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: b82a1b8b-1af2-461f-7a06-08dd50bf5808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?andIajN1dkhWdmowZmZ0L1dnanRoK2xuelZ5L2M4V1dyT0g1b1FIdE1WVXlZ?=
 =?utf-8?B?WXcyQ3BzQ2ZPQXpkazlMODNHMTNSTis4Y21nL0lOd3VsdGdrM3djUlllQkhy?=
 =?utf-8?B?NWRnOTRUSm5BVlROR3d0SWMwV3Rma0ZubktyY2p4OHN1cm9TNjRmMzVkRWhP?=
 =?utf-8?B?dm5zSk9uTWNMcUY2L2F5eHU0RU9KUnBzQVBsamJkQXNVYW41TWFkWEJsUWxU?=
 =?utf-8?B?bzJVcVFWZVBLUTE1dDNrTHVTbkdMY2VUWGlIZ3o2aitUWVIxMFIvZVdnVWpQ?=
 =?utf-8?B?MTJ2OEZiRktDd0swRXNpeHRwT3djK09FYjlrZ0QrOVJlVGxJbXVBU3BQdE0w?=
 =?utf-8?B?LzVUekFUdVdRTFBnZW1xOTBzUkk3c1FxdmM1KzNyWmtoWjBtTVgyWEJUK3A0?=
 =?utf-8?B?a3B6SFYvQjVUY0RSaUUwZGJMajlMZi8zbzMyNWFyekdGdGFiOVhYaldYNEwv?=
 =?utf-8?B?RVBxbFpEZkdOMlJ4VHJISjIvMzdKd1JuMjBqdEFUTHpxOWdZZkFMdnU3ZkZw?=
 =?utf-8?B?SHV5SC9HM1doMmpXaUlIUEJ2WFpZWjNtL3NWY3F2VlhpemlONDJCUVdMSUta?=
 =?utf-8?B?Y1FBLyt4aTZPSHlzR2VaSHY1NmprTFVEajNzNi9EOXV1VEJoUjlnb3ZTankz?=
 =?utf-8?B?bXJBYVJZazRRUHJjZ1lDM2pZR2c4MUZtZDV5V1hUUExtaVVXMlFlNEcrRVQ1?=
 =?utf-8?B?blZKSW4wZkRTTy93cm1JUFNCajJvUUxsazQ3SENjUUc3M2JrejllU01TNS9r?=
 =?utf-8?B?U25SbWVwN0kvbjhkc3I2dHFRZDhXWk1vSnNTWXc2MkZ0TDVXemtzYkVXblJa?=
 =?utf-8?B?MXQxNXlvYVQrVm94SWJVVDFPVy9EK2ZmbkJKTXdNRGR5UkcwQjczOTRGS09X?=
 =?utf-8?B?Tkx3M0x3QjRhUS9ER2VHQitWZTdPSkVWa2N4M2dVWmFyQ0JVNlhZazIraWpw?=
 =?utf-8?B?UXZxY2VVSlJPeEhRRkdQVFpkR0dRUHczazcxaFBiMTU1STlkcmc1QVBVY0Vp?=
 =?utf-8?B?N2pLa2R2MWNHRExNYlltNUU0bHBvZGYvTW1tWWF5S0xEV0tpZ085V1RBUTlj?=
 =?utf-8?B?Y2FGWjhwVERoQkNnSTlteE9Ubng3cG00Yldzb0pxODhhU0Zqc3VCS2VoTE9h?=
 =?utf-8?B?eVlPRzdQM3labmRmWlRZNEhhUmJZWWYza09Oa0VRY1ZROGs1ZzJCTGlIL1JO?=
 =?utf-8?B?V21DTmx2SGw4Ykp4WEY4T1Z1Sm1CelE5a21ldFEyOWFaSytUdS9OdTBKZDVj?=
 =?utf-8?B?SWM1VGRPV2tQdWdjWVkzVjEvZzBTV2tuWHo4d1VsSnlVMVRUUmt0d01yajFq?=
 =?utf-8?B?Vi9GL0ltd0xPbzU5eHQ1UVNPT21IekpJdlJJb0l5MndQYXh4dnlBZytsak9K?=
 =?utf-8?B?WW16S3oxa1BzN0xWQlEvSFhacEwxazhPT1hGaTBQWGRyQjAydlFHTlZNb09T?=
 =?utf-8?B?RU1YUnNNWEY2NFl5YXplMEx1RUJ1VkRJSEtUMFp5VDZ2ZnlreHp2NjRrUHQ3?=
 =?utf-8?B?V3psVGlDeW9mbzdmQ3F4c0lwZTQvd2RqWk81UUxZK01XSzU5V3dWUENMcCs5?=
 =?utf-8?B?TEZSNUlDQ3VySFp3K1liZWttT29uLzcrTmIrKzJvWjVLZEJDcDhuRTZ5S2J3?=
 =?utf-8?B?KzZzNGhZbXVLQkdkZjBKeWdvQWU2b2hpR2pCZWNGSGtnSU1lakdwVVF1bUVP?=
 =?utf-8?B?WW1ZdHYxRXlldnpKaDRrQTJFdGM0RE41UEg2SnJmVDBZbWo5VnRTcjViMGhy?=
 =?utf-8?B?cEdsU3puMGNEMDdPK1FERGduT1c4TmROdDZjejg4ZVZza1h1UWhhcUFIVjNp?=
 =?utf-8?B?aUtzbllPMDdHYlVIUWptRFoxT09lZ1g2UkI0dE1ZRkZ2VUpQYkd0SDF3bkdk?=
 =?utf-8?Q?DXHgiOwuD4Udz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVDSDVsZTE5MHFPVWFwVmJQajdQOWhtNnYyeHYvb2NIdzRpZyt1SXFGNmNR?=
 =?utf-8?B?V1E0VkxUN1RBbkZkTU5uUjh5K3RlejZDTmNCOVE2ZnpPRFRPRFpHbTAvV1Fj?=
 =?utf-8?B?N2d6RG5UcU84dFNkeWR3OFM5WloxWFlobHNzQWd5eDJ2SGtMQUFEOFVvNFpi?=
 =?utf-8?B?S2trQzZnTFRHZ2RFMXR2bDQwYlk0RnU3MGVSVHA2dGVNV1ppc3Z4b3Nyd1Ft?=
 =?utf-8?B?by9ndHAya0Zxckh6Y3VwRXZOTEJsRnI0V0dNbmt4elRXNmxRQ3FtSFZLMnZD?=
 =?utf-8?B?TTZicy85cExwUkthU0RCVDJ6Ymw5M2NmRE12RFB0RnE1YWpMUmsyRVI0NkZY?=
 =?utf-8?B?ZXplbHVNbUtCWEx5bi9NYWI5dW83MDBOYVpCQ2NOZE9VcDYvR0JCSXZyVys0?=
 =?utf-8?B?dTJlOFlxcFJBTlM2OEc5YmN6NVdkWXdWcW43WXdYMzVZdGZLRE4vb3pXaVlm?=
 =?utf-8?B?T3pDR3k3azh4ZkR4TnA5MjZ4Zm9DY1ZmRXZ2aE9NSWNtRWdsSFM0S2xXYTVY?=
 =?utf-8?B?bm5jaC9FZGlQNHJ3ZmRWdEtsT2FzYVM5NW1FUlM4dzJSQUlibGwyRGRWSEEv?=
 =?utf-8?B?aDFSR3hzdXFZZVNwK2VnNmJnTVhpTXVoRTI0U2xBZlJ3Q29ueDFndy9WSHlY?=
 =?utf-8?B?aGNwcEdadEs3L0owQzM4aHlkOTBCSFdtYWJwQ1M0Mk9lc2lHQkRvTkhhRmox?=
 =?utf-8?B?Yk1UY3BYVEZUOERhVklWSEVJcmFMSG1MdlhrQ3hMZllXZm4xYVNsMHpIaFR0?=
 =?utf-8?B?ZnYvWldsb2s1d0djUzdqeFFveHdwMWVMeFpvbGZTZ2d1OCs4bSt0M1ZkVlNM?=
 =?utf-8?B?WVpCbDJIaENTQm5UbXhIQnRTa0Vja3BmcWJUOUw3dkxNbWhuZnIrdDFYUFB1?=
 =?utf-8?B?U2VPZlRsNDB2MDgwMnZiL3JJdU9VRElsR2wrOCthNjkwdlh0NTVraUNKanNi?=
 =?utf-8?B?d2VCM3o5c01xZHhQb2w4NDRVTFRENWFiUGNTSW9tV2dYRWJXR1pSRW5leEwr?=
 =?utf-8?B?WUZMbUovV2YrZmE3eHlpUGNBQjhQM2hCV0ljaExPK3lDVG9WcTMxQVNVNlBj?=
 =?utf-8?B?cHR0NzhMSnJKUmt4ZmhtSXFoZFpSOEdRTzluU3dER2dseVl5cGg0M3dLbGtD?=
 =?utf-8?B?aUxncmN6VDAxU2pFUTk0SjV3ZUgzdjhoemtwRnluSHB2dmdCaUh0WEx4Z2lX?=
 =?utf-8?B?WksrckM3VVpBUlNUMFFNM2FYb0lGZnJiYWt4Qmx0WVVHcDg2NlE0WXZJdzV6?=
 =?utf-8?B?NGFISEZPTzZQRHZ3cFdrUEQ1aWJtdFlZYy9BV2NQUHZzWjVGaFRjaU4rWnVw?=
 =?utf-8?B?cjdtRGJIS1o1N0EvcGZWSnJaaVlJZ3k0dldhU2lheHI5U1pWUTBRQ1dRSkhX?=
 =?utf-8?B?eTlpT0o0eXlZN3dxQWtBN29WM00yREVvdDFWdVBnaG5yTEFCNmNzVVNMSUpq?=
 =?utf-8?B?RTlhelZIYkMwNS9vK1FrWDZJdUdhbmFNUkgxNDE1Q0JXZDlhditJWFYzQmtL?=
 =?utf-8?B?WlA3ZkZJTUFaaWFlc1FueHVUOHlDK2pJaTlGTUJ1VlFYd2h6SnNuRkZBdUdY?=
 =?utf-8?B?OXgxbWVzdHQzMFMxNzRTdWNJcURiYXRneTYyelh2WVJzbUd3L1BER2JnQ0Jy?=
 =?utf-8?B?NUxUS2NXckdCbjhuaWJ2R1dqQlJQSHlVaTR3NDUyNXptOENIc0NRYTdBRk1R?=
 =?utf-8?B?ekI4NEVFK1I2Y3ZZMTIyeHdEYitJbDJjSlE5MjdQL2YvMGZxcnRTZEVFTlVj?=
 =?utf-8?B?c2JqTzZvNVQ1LzkvQU9yK0wrMWJlYUpKTXFuRXhnUXdqM3czcTF0N2F4WXk3?=
 =?utf-8?B?QzYvRmVkcnRQWGxlQWg4VjhZRjRtT1RIdVBSVDdXQmZnbVlNZTl5bjBSTmVY?=
 =?utf-8?B?T0dUTEJTRkVXUDB4Y2Y0ajNZTEFLM090T0IrTmxJbzh5ZDAyd3pWdHFEZWRU?=
 =?utf-8?B?WXU4eUExdWdSc1UvS1VvUmRvUWZvNkRiOU9abSsyTkVjNC9Fc3draWZEYTFL?=
 =?utf-8?B?ajdLcXprdEFxT1RQNGhSMjB2d01qMDB1SmNWQ2pvczNnNEhCM1loY3Nvb0gw?=
 =?utf-8?B?aTlEK1hjMjJwNHN2dDNtQjlYdUtLcnZPTkxLVWxqclZ3NklGWjQvRGJnci83?=
 =?utf-8?Q?eMVx3+vf6yXmktBP2lR63MU/d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82a1b8b-1af2-461f-7a06-08dd50bf5808
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 08:28:10.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV7VfLtzxoHzx/cbg+bmJEvQ5jo/3aq8ErTs0ugFs2to6Z0IjMK3zb6Y1XrU+UDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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



On 2/19/2025 1:30 PM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
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
>  replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
>  to check if a ring is an SDMA page queue.(Lijo)
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 ++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cb914ce82eb5..da719ec6c6c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -601,8 +601,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +	if(amdgpu_sdma_is_page_queue(adev, ring)) {

Sorry, didn't mean to exclude the ring type check.

BTW, there is another problem. If the previous ring is regular sdma ring,

vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);

This step would have modified the bitmap and invalidation engine in the
next loop is not the same.

What you may want to do is -

After allocating sdma ring invalidation engine, assign the same inv
engine to page ring corresponding to the sdma instance.

	ring->vm_inv_eng = inv_eng - 1;
	if (ring->type == sdma) {
		page_ring = amdgpu_sdma_get_page_ring(adev, ring->me); => returns
&adev->sdma.instance[i].page
		if (page_ring)
			page_ring->vm_inv_eng = inv_eng - 1;
	}	
	vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);

Then skip any page rings in the generic loop.
	if (ring->type==sdma && amdgpu_sdma_is_page_queue(adev, ring)) continue;  -

Thanks,
Lijo

> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
> +		 * Shared VM invalid engine with sdma gfx ring.
> +		 */
> +		ring->vm_inv_eng = inv_eng - 1;
> +	} else {
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +	}
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8de214a8ba6d..96df544feb67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -503,6 +503,24 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +/**
> +* amdgpu_sdma_is_page_queue - Check if a ring is an SDMA page queue
> +* @adev: Pointer to the AMDGPU device structure
> +* @ring: Pointer to the ring structure to check
> +*
> +* This function checks if the given ring is an SDMA page queue.
> +* It returns true if the ring is an SDMA page queue, false otherwise.
> +*/
> +bool amdgpu_sdma_is_page_queue(struct amdgpu_device *adev, struct amdgpu_ring* ring)
> +{
> +	int i = ring->me;
> +
> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
> +		return false;
> +
> +	return (ring == &adev->sdma.instance[i].page);
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 7effc2673466..c2df9c3ab882 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_page_queue(struct amdgpu_device *adev, struct amdgpu_ring* ring);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2aa87fdf715f..2599da8677da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	 * to WA the Issue
>  	 */
>  
> +	spin_lock(&adev->gmc.invalidate_lock);
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>  	if (use_semaphore)
>  		/* a read return value of 1 means semaphore acuqire */
> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
>  				      hub->eng_distance * eng, 0);
>  
> +	spin_unlock(&adev->gmc.invalidate_lock);
>  	return pd_addr;
>  }
>  

