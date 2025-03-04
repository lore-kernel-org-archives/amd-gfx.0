Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95189C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 07:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393E710E4FF;
	Tue,  4 Mar 2025 07:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FHmBWMo1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6F210E4FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 07:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axgzR7xmlA2kThQcS1wG+J1W9LPCuJI5p3PvMeuGpanoBvMVmLzysAqJhkKq4S91UPKmD1cm0E7JaQGOEXX3554DJgLvuIX9yn4hp/+1G3oP7jyPTDCOhDgQhBnHZODGRg2Zb91U0UQ+rkDd/BuTob2iIXe8llPg1cwAkvH0M98/RFwv3iRtDF2rX+H0qDd2TEygEgCKdcdBbLldT8RJzM4DSQn0W5ly8A+izwU3w6pwJwMj35PCRnVKHqgSqM4wphdwjsZYmnq1i4eKO7wn7/9myQBHHMI656Ct5BhXM5WGvDAPYTi2ujeVKEql5GoUs8HAa/N7QMgeHLt+QQJEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpTYQ1g0jPVPDQrD5aUuCCMSxuN4C679IeYrdRxw8zA=;
 b=ulLb0DXUo6f7rEpLGDAVyz7vgO5Mc14pJfheQcJuAeypVcB8XAnQHLYStqH2OTkXWtME+gI5r0gkuJ5FBUDUK8gS+ps+U6MadN47Vp9Hh0/BFGfwx6EUz1kzZtO+FFUY3p8no0R6RfpiwJgwXdgZy1E37UxvvkiQPE1L6p2g41w9BooK/QT3UQ1BagI/Rc5q3+PokaEKuFSHyn9uxwFxCzQ4kijkiOI3bMOUs0MDRSvhwzcs4r9/69WoMIkwq7Kg8gYRmupBAcNVW1pDNodoF8H1bkphjQze7WbS+UV0M7h6vVJnskyJuIEvzQb9zMsFgYMz0Zoc+Z5ixla0ozn+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpTYQ1g0jPVPDQrD5aUuCCMSxuN4C679IeYrdRxw8zA=;
 b=FHmBWMo1lDNSt4hJYx2OKzQ8EEV1lhgBBKTI17GqXj7f3qO7CXwY51ue/hgivlNU170Ja9IE2POzhibn6/IoY+ZckGCX+2vuqRzKUBoaJ06uZc3O/bKnGjrvR36f4mtoRGPM9nmc/uB8zFmG8GqrO78qj+SkvY8dvnnHge/K6eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 07:01:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 07:01:04 +0000
Message-ID: <39a18510-d818-444d-8d00-40e8887ea568@amd.com>
Date: Tue, 4 Mar 2025 12:30:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/3] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250228102711.832036-1-jesse.zhang@amd.com>
 <20250228102711.832036-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250228102711.832036-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: ae973b75-8bac-4b4b-eddd-08dd5aea542e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1ZueFVIUlYxeXlJSy8zYlVPTDZ6OFdzQ05KaDVnMWNxSDJQMVJ4YzVlTGp5?=
 =?utf-8?B?R0pCaEZnNlNuaVcwQ010ZldTR2V6UHRRRFFqblN0Q2trRzZWcjNYMnh0dVov?=
 =?utf-8?B?ZS9nRDgzaFN5dHRSTkx2blVPRy81S2RydWdsdTJLcGFQUFRLVVJ5ZUFMZWFw?=
 =?utf-8?B?YmxqOUNScmpaTVFsSjRCQlB1ME9ZWXhsMEllcWRwRzZSem5Bb2NUeEtIN1Rq?=
 =?utf-8?B?U0hCNzNCVk5jNTcvT0Iza0JvSnlHMmFEcWVHTUQ0WHNnaHZxT2NyVlQxcnFF?=
 =?utf-8?B?VEJZbkNZUlBnUEsxakhjR3EvRm1JWTZWOEpndEdpVWloNVU3d2FKNWM5b2pS?=
 =?utf-8?B?WlA1dlFvVm0vcG5sUXRvZzZUclBUZTQzeU1BQUd3bE1TOGR5bkVSRVRJMXBy?=
 =?utf-8?B?ZWNDcXFGbVlQdVprUG9zeEtuQkFpc2dRU3YrdzZkNktyQVFZZG1sMVhtZ1J2?=
 =?utf-8?B?N3RTMG9hcVdkSlY4OVFRU2QxOEdoTUNkdytLZnEvR1FnZjdKOHl5SzVRK3Qw?=
 =?utf-8?B?UXBzR1dvWkp0QjhSczlZTEM0b25jZlN0VmMreEUyZEp5ZWJ1YXJIa21hMGxx?=
 =?utf-8?B?Wk9Ya2VDMnY3eTBIa3pndDFsd2RqOUlXYXczZFhsWUZTTUtwNVo5NUV0TTVK?=
 =?utf-8?B?b3RtOXlnenpkT1Rlc2VMMkhhQS9BNTJRbllpTzdjYkdlMkIwL3B1WGtWT2FE?=
 =?utf-8?B?Zi80QVpXQk1hMVlXaWN5dTF1K2RGdGljbTY3QmVFOHpWNDJjaXNwa0ZZVXk5?=
 =?utf-8?B?dnY5ai93a0UwUTRHTldGQUp2UXRXQU9uVFNVNzdxWXBvb0NTM29laVhtclZt?=
 =?utf-8?B?bSsySUhabzVTdnZJNUQxUlNsM040SGhCSzFYV1VyUWR4cGo3eHo2KzVRQW50?=
 =?utf-8?B?VWg0YmQ4MjVVaUlYRzR4YWUxT0c4UTE2YmxBZ0Y0MElSOWRsOWdFN0doS1Z6?=
 =?utf-8?B?Q0JmZFVCWXhZamlpK3dpVmp6cDJKWUdUVGhQbU5xVE10RE9WQXRBcXBWN3FG?=
 =?utf-8?B?NGxMMFltOVlyNUxnQ1J6dWl2Qjhlc2l3R1pGUDdKdWtsY1BYcHMrSzBsdnVq?=
 =?utf-8?B?eHRkdklUWFhtWVJYRUJQUkVCY1c5SEF2SC91b2pWYUN0NEdPRTJHN3g2b1U5?=
 =?utf-8?B?cnZDMkVQa3hYeE5qV1pybU41N0o0b2Q3WkpzL3Q3S3ozYlZibEdXcWZZVUR3?=
 =?utf-8?B?MnBlOGdEZ2ZWa0pjbWxWdXlOWm5kNEJEMFhvZkxHZWFpbjRIaFJ2d3lmRFhn?=
 =?utf-8?B?WW53cjRCYm93UjdpcC9JT2ZxQ3hmM1ZEenYwQ0ZPRENuOFZGd1BwZmdydzVt?=
 =?utf-8?B?dHdpU3JLT0doZG1oUnN4aHdvZnlkNkRCRVZGc0xManpseGVUQnhGOEtsbG5I?=
 =?utf-8?B?d0JPYTh0QWNVaGEzUFZVYlVzVEt5c0hBcWdpRTdXTDVhTUtBbjJWREt6aWJn?=
 =?utf-8?B?dFlPVmIyTmxTbjBEUXlGV2lkdkNlSTd4UEZsUHo1Nk5zeHByN21jN0hxZDdH?=
 =?utf-8?B?Q0dWa2RMRnlyQzlOUGpzR21KTEtkSGxjV3BxeGhxVTY2d0dUWTlxMnNCSXZD?=
 =?utf-8?B?QjBlS05FanhDNWlWVmdXc2p4YTk4elI0dUlrWkl3N0Qwc2xRdUI0ZEVFTXdC?=
 =?utf-8?B?S0tVTExlM2hUUXlHNlgrdDF4L0xHMWpVWWNUL003b1ppaHpBNDVSdVpJUFc5?=
 =?utf-8?B?cFB2aU9PdExXRjdKSlhzTTJxOGVqc3RHQ3hjRW1IWEpHUXd3NzFPVS82L0dB?=
 =?utf-8?B?ZFJpQjBkVzZWbG9zUWtoTEo2L2tMTy9kbHNpVXd3TGlwYnFuckIxbDZSUFZE?=
 =?utf-8?B?R1ZnK2paM1ZKUWI4WHJoemtlcDcxbitLSitnSUVPUldLbjBLZkQ0MHovQm0w?=
 =?utf-8?Q?Mcq0SKwjA9tvM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RvSjdSOTRVV0YyeHliSnlQS01NZ2ZFbm9FcS9FeHo0R0JWU1o3bmI2MHEr?=
 =?utf-8?B?bW41R1lYMklVTXRoSElJOE5MTjJLUXdIRzByeDlwQ09tMkIyK2VPNHdOYjVm?=
 =?utf-8?B?K2V1bWtzL3RqNkN3VjZ1T3RyTWFKQUsvK0JqNUZYbGxmM2hiYUgzdStKL01D?=
 =?utf-8?B?YXU1K1dscVZZd0dtRjI2czNKb2VnU1NkaFRhTmpyMnl3OGZaR0FuSGJRa1Jw?=
 =?utf-8?B?ZFp1RWJhOVBEUzd2RDZ5bkVSaXZEUmxaNW95K0t4T1VKNm5Fd1BXbnEra2ow?=
 =?utf-8?B?TlE1ZE1TU04rcFBscmpleFczc3gwSHVKbDhKYlBOZHFEeFI4dm83Vk1VN0t6?=
 =?utf-8?B?NFRTL3NwbmVHb2x0RXNYVjNaNUgrb0Q0bTh0aXNXYThHWVJkSGNrRFl0alJ4?=
 =?utf-8?B?RldFMWMrQW9MU1p0ODN4R0NaaTlRM3pBWk53OUV3T1pyVVF0TjZic2lDeGVa?=
 =?utf-8?B?R1Q3THpIWGF3UVNRSzBEVUNZamk0Wk9jQ2I4Q2NtSWM3TGRGeENCUVBUaTZH?=
 =?utf-8?B?MFgzT2JGSUZtMGFWOG5lbDhTRDNqUnE1bzhNdkluTzZnamtxMEUvVmRkWVhr?=
 =?utf-8?B?WGxFU0lUR014SFM0eWFKUWp3Nlpjdi9BMTE4cEFtUjVrcnhQdERzU0F4TnIw?=
 =?utf-8?B?bGJ1bWhERjRJZHdFajF3V3VySUxCUXN4UC9OSWJXTVpkYk1SZmtYa3BkT25a?=
 =?utf-8?B?czhPVGxoVEs0ZEVpcVdLUFJZanMrSDk2bzI4dDAvNHc3WTNtTlNEb1JIQ0sr?=
 =?utf-8?B?Wjk5RGtyR0J5VjhOQ3lqZGsyTjNHSlhZdWxRS2VzakdlRVJ0T00wcTBjZVhZ?=
 =?utf-8?B?N3VnSU5HN2VncUlsU1JYYVRUSUF6QkpXRFpnWXBrNHBhcUNXNUE4cUloNzUw?=
 =?utf-8?B?TXp0RVNXc2NYb2pDNHE5UWxnTUNtR3B1T04wQXRpVml1dEFrRCtPNWQzSWdq?=
 =?utf-8?B?THE0UjFkck8rb1ZoTzhTajd5b1M5ZDhsaXVBK1FnSjJ1SE1YTFpHdmlOdjV5?=
 =?utf-8?B?d1BYTGE3Z0VJNUpKMDJPeWJxRE8xN2JEV2thM3BraW5VQUlTSGxjeEFWelRE?=
 =?utf-8?B?bW9GbVNyamZVeGNZWWVUSTVpWmNrcFdiK290dnNUWHFGKy9HaVUrcGYveklH?=
 =?utf-8?B?RFBiWjVQKzIzL2lidVdMZ3E2dzJmS0RRM2UzeHdYNTg5K2F6YVc2ekVVTTlv?=
 =?utf-8?B?UWpJa2x1VFdKWTVQdkt4Sytkb1dVUDduZVZUcCtaVDM2L3VQRGtLZU5mTGth?=
 =?utf-8?B?UXZYT2hKMDhMYWc0TWx1Y2JqZlNXRmFaS1cxb3Y2MmhMVWpCWGpvRW5TRjlY?=
 =?utf-8?B?c00rMTdqSWFJbmJVeFFsaFh3TWtLcmFZdTdHN1V5cVlFbjRUY1FST0E1SDFI?=
 =?utf-8?B?R04zWlpjZk5vTjJ1WUNYZWJleVNZYWJ6NXVyWHluc24rVUNVS08weEpvbzZv?=
 =?utf-8?B?amU5VTVJUFU1a096T1graXNBb2FzemcwSXcxa1VwcE0yVGJjWUtUbzg0UTQ5?=
 =?utf-8?B?bE05R1ZEUmRTTFhvMUN1YitFMzZvZVZNeGxZZXlJT3dlQUk3OW55a1RJUG5I?=
 =?utf-8?B?Q2VoQkpzbWFhY25VMGdlbzRhTGNyMlJSa2FDb1Z4bFlRcDZzL1RibGdDVWxr?=
 =?utf-8?B?dVBUdHV5MVlzUWZ2TjJVV2E3VWxKVUtSaDZzZXpkY041K3c1THJ5Y2xoTHh5?=
 =?utf-8?B?OGJnR0M0QkJkbVNwemVqalZrVENCQUE0RzN1bVNZUzVwSFI3d2lHOFFnbHFa?=
 =?utf-8?B?QTk3QjlLN21sWDVaeTZWQzFDSkZCSVNKUmUyRUQ4blBwWEtUS1JNV2JFeGk4?=
 =?utf-8?B?QXZxOVdPRElveUE0U0VkMGw2NEU0dGtPclhWN1pYY25aWG1tcERydlIzRHBo?=
 =?utf-8?B?OGIxY0RJT0JjN01JSnFUSXBlZHhDVlV5a1hpWlA2M2cvcllUY2s4YUdQcUpu?=
 =?utf-8?B?K1JMVXZjajA4V3NSV2t3L215TXBjcERBTnJMS1hYTHVQTlhpam5EdzNWOHlo?=
 =?utf-8?B?aCtxeDZFbTloODBrWlpQQldWSHZVT2ZsYzdvbjNaM3F1WDFmVFdYTjlmUGQ0?=
 =?utf-8?B?ODZYaTYxbnloVE9SRzk5MXpnWlg2SElmeWszSEV6cVJ0Y1JOeWZaR1ZLRkhY?=
 =?utf-8?Q?/46k3CefLTDYYF7sQPRJMjED2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae973b75-8bac-4b4b-eddd-08dd5aea542e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:01:04.1409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUt2rzZxqUELYJWwPrnQGVgZCVlB4HDO34D25zyeZv40FdcGuUkGiRn82ac96AWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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



On 2/28/2025 3:57 PM, Jesse.zhang@amd.com wrote:
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
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4eefa17fa39b..aad3c5ea8557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -602,8 +602,20 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +	if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
> +		/* SDMA has a special packet which allows it to use the same
> +		 * invalidation engine for all the rings in one instance.
> +		 * Therefore, we do not allocate a separate VM invalidation engine
> +		 * for SDMA page rings. Instead, they share the VM invalidation
> +		 * engine with the SDMA gfx ring. This change ensures efficient
> +		 * resource management and avoids the issue of insufficient VM
> +		 * invalidation engines.
> +		 */
> +		ring->vm_inv_eng = inv_eng - 1;

As mentioned in a previous comment also, strongly discourage to assume
vm_inv_eng based just on loop order. If two rings of the same instance
need to share the inv_eng, call them out explicitly and assign.
Shouldn't have any implicit assumption that the previous/next ring in
the loop order will be part of the same engine.

Thanks,
Lijo

> +	} else {
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +	}
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 42a7b86e41c3..9b958d6202bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -462,6 +462,29 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
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
> +		return (ring == &adev->sdma.instance[i].ring);
> +	else
> +		return false;
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> @@ -503,7 +526,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>  {
>  	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
> -	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>  	struct amdgpu_ring *page_ring = &sdma_instance->page;
>  	bool gfx_sched_stopped = false, page_sched_stopped = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 965169320065..1fa2049da6c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>  #endif

