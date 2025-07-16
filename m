Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B5C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 13:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0A10E6ED;
	Wed, 16 Jul 2025 13:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIiAjoOO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4139110E6DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 13:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXr++R4qlgR0rjXg3/1WDESD5aWrTTvzepC6+yrEW0hIzZOPRa0S74S61SUuEC8fUiMZ2L4kJEJMPhO9rKBG6fV+Q3WNtcbqQNwrmOBVjAjVNX62JXiwHZfz417X+0CifnVq0n8ZyCgbjGr30R3Wn19+nII8qb5tuei45kucu4nfdzVrAvFsw182av7x5ccpPZlf8ixN39FGGbBhUe5wgBkwnZM9nSaD3NTU7B6hkfd6ENjq1mPQcqiA8BkYa3AX5Xa9Uoz2Bnfhk16yrbWwhxeeCsE9HZKNOZJpmSjRmi5XykkPWeePPLMGkZXiRHx3seRkHCtJFK7+SgbBxIzY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IPvFWXzy6Q9x7rAJ8hGVX3RD2hV+wcajYKAJjxgzmc=;
 b=onRDMmoYrLn010+jaBk9lNl8VrUVO1y1+xEA0oRqpTen3+XFZTdiARRh9QK9Zzm8M8kZcifmJbz+927I6Sew9IFfn8dAYr87uyT72VDgnsAm+EFu1B67iHxl4otTmYQ4Vtr9eALJSx5fH+zkzHKP1fPu2XU7zyKHsKBRqWSB7+Tq/dQzmJfveQmwiwElq5pgmo4EcE+6msWHE56XizW/tLmxIO6ZsFSxE9cmK26E7KGOAM8CZMBmHnLWYDIcAseL4A2QXCZscnIOcm4fc6ZsNKx6zT160YHjGQZM1TiFzJ9/0AzszGLIbkoiDRMJ50ICo9J7vKSKPVSTZoqWdKxBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IPvFWXzy6Q9x7rAJ8hGVX3RD2hV+wcajYKAJjxgzmc=;
 b=GIiAjoOOB6WGbWkGVg7x+0w62Dvntwet4f1BfLWeshMGEDa1lbdvCwfw4K1Yx0XWHuNsnnXIdA0JS/X+pzPxONgAixckLF7NtFQJ0FHYCOp8cE8zN5Hp0JQj5EE4ncv+IxbgZiIOetL8VeDbQ343229q1LAjJuSQPAxBTqyN8go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 16 Jul
 2025 13:00:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 13:00:43 +0000
Message-ID: <83463d64-b0dc-43e7-b098-b978c44756da@amd.com>
Date: Wed, 16 Jul 2025 15:00:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
 <CADnq5_NYhPa+6gUqeJsvXkqtkwwkWmv=F70Wv96L+CEA-AGE1w@mail.gmail.com>
 <6d19ad87-6091-477c-a1ee-ddb224a63fe1@igalia.com>
 <CADnq5_PFKKdDOnX7np+31jDfmf17=PNSFoFtmHk+XSPqRjnf4Q@mail.gmail.com>
 <a07c4db8-a775-4036-a30e-8266c02283df@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a07c4db8-a775-4036-a30e-8266c02283df@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: d641a60c-805c-4bef-6065-08ddc468c5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVllTzZBVEVGTVZCTVd3U2FpUE52VEkrbDIreHE3L3Y1WWJyaWgzUHRaYVJM?=
 =?utf-8?B?OE5rdHZ0S0VQeW9LUCtNTE9lNmt1K2hLNnhuaFIxSDFwbStSMWJMU3dUWG02?=
 =?utf-8?B?YjlqSk90bFZDS0V0bWR0KzJRYnd1SDNmcVh3N3ZEaUxGUWlGVm41bFJvazdN?=
 =?utf-8?B?Q0tWTGV0RnhwZEpMQ1QxSktNUEc2YXIvaDhNZnhFWFk1NVkveDlVM3FrUzZx?=
 =?utf-8?B?Z0pKRVRsZzFZd2Y5QXo3Q0hXSUhVb24xa01zVkx6QkJoV3p1cFZDR0JNTjB1?=
 =?utf-8?B?N2xlQ2ZsN3BSdFY1YlU4RWp1a2tGbkN3Rmp2cEgydFVsK0p3OE9tK3hQQnZG?=
 =?utf-8?B?QkoybFN0WkoyeVJQMnViUkg2VzJRUG45WE9TOVNFaTRod1VLTVBXVnFaVlBH?=
 =?utf-8?B?Q2hSWXBLTmJJaVcvcHQ0NUJuVDErSnBiOERlTm54K0ljWnBSRXVjY25uNGc0?=
 =?utf-8?B?NEVZMWRiTERUU0YzVXlsSko0M2lrOTlsbFBPbjkzUEVua1ZYb0RGZ1QyeUY2?=
 =?utf-8?B?QnBjbHJ5QlUrNk9SWng5MTV0RUJ0MWhLYTl1eHFrTWltUHpQVFlIOWJ6R04y?=
 =?utf-8?B?d3JYZHpFTStrbHRVZ1kvakZvTmt3UUM5U1JvMzZvTHA1TXVnREV1cjJiaXN1?=
 =?utf-8?B?R2xxU2prdVR5cWlScFJEMWh6WWI0bDhudG9pZGJhQWVrU1pKMHBNYjZJVVFJ?=
 =?utf-8?B?VTJZM1RvODUyMC9mZzNYSmV6eUNOSmMzK25jRUN6RHc3WUNRaGVIUm5OQTlS?=
 =?utf-8?B?Z3FrV1J4dVV0bTF1MHR2WWpkRkxXczZuNjJGMDVyRE5MRTNvUnY5N2k5bHRh?=
 =?utf-8?B?djlBRU1VZHpCVUVjcEdjUi81NHRWMFZBamp6akF3L2RqdmZNQnowclRwbzBa?=
 =?utf-8?B?Q09tWFQzb0Y4Q1pjbmVubWpEaTVsNWhFOERtVXpoV0g1Z0M0VGpuTGs3a3hU?=
 =?utf-8?B?dEtsZ0oxWVZuTldteHBwQVg1NWk3bFExbmtES1FhVkQ2ZEk1UmJ1ejNxOExO?=
 =?utf-8?B?Ymowd0NPU3p1T1JmaGJQZkNpSTBLSXAxNmFRYjdqYk5Za24zUlZpaTZ5L0lj?=
 =?utf-8?B?bTIzODNZZWdHT01kS3VJTFBqbjZMWGJvZjV2TEZPdHRnQUE4cTVmazZwWDFJ?=
 =?utf-8?B?ZVVBZ29pQnE0b2tUUGdPZ2JtU3ZEd2t6NzRDYkNiend5S1ZBeDU4THltM3R1?=
 =?utf-8?B?SFhORDg4dkxlWWU0dXU1aE84aDVqeHAxY1c0VUU5NWJhY1d5NEpXRlB5eTNN?=
 =?utf-8?B?QVBYSTNicG5ObnJGdU15NkF5UzN6WUZQejJhaGI3Q1o1ZlozZW9YRW9pcGs2?=
 =?utf-8?B?amp1WkZDMUVNaS9FUE9wdkJudVd6ek5kdG5EeGNDV1lYMVRjS1dWLzgwbnUr?=
 =?utf-8?B?UlFwWWhhL0dURXFlMlJybk5XR2V6QW5tZmhKNm96WHY1WFJWM0FhVHMrV3JD?=
 =?utf-8?B?eHA0TWJjNUdSMTJNOEhNUHlpQllwR0tKcDhIK2Y0TGlJRlJ5SEZ5UytOUjlt?=
 =?utf-8?B?SmlDUy8xdjIyazk0V2E2UktnRVR0cEo3cE5RSWpIMVExRTBKb0FGZkFVa01O?=
 =?utf-8?B?N1NZcWRiUmlJaDRBeTN1WDA5Y1ZvY1gxbW5mM1daWjFGMGloSFIwUjNaSnZq?=
 =?utf-8?B?cFNYSU1qZWZXU1p5Nm1DQ2pmQkYvNUdlTXUwYnYrbDhCZkdVNUgzWE1ZaXRK?=
 =?utf-8?B?M3NBSGRkMDk3STZGTVpYMSsweHQvbkQ0KzNQM25TeDJUODBVOW5QS3c4Ui8z?=
 =?utf-8?B?QjhZNUZITDRLV1ZXd2UzU3VHbjRmc2F2bTBKVFNGeFJZUjFtREczbzZSa3ZY?=
 =?utf-8?B?SHZWSXNmWXRQeGIweURpRXV1dlVDRUxldllNek1IRk45WnpFQjZaaDcyQXRm?=
 =?utf-8?B?L3B4WHF6Y1h3WERER2F3c09MR0dlcjV1Tm9PU3d1SVBQanVOemNOMjQ0ZnhC?=
 =?utf-8?Q?otnD6TYx+X8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVI3ejZ4aHA4WE0vaDlZalZ0YkFjTnYxUGxSSkF3VXdGZGVVWjU3VlhIK1FL?=
 =?utf-8?B?NEh4cHdkRk54Qy9CRkU5QXhtYWN2RzJXQ1dSRmM4YlMvMVQyMUVRRUFUZE1E?=
 =?utf-8?B?T043eDRCUm5jbEFoN1REWFNyVVYyaXFUOFJBUnVFZmVvSWtoTE1sR1lEWlRw?=
 =?utf-8?B?Y3hUNG9QMHFEL1cweGgwYzl1VEtNNUtTN2Q1bS9Oc3JMUzZlc0pVN0NReHN3?=
 =?utf-8?B?QnVwZmhOSFY1TzJoT3k4Qk9sOGcvR1VUelU3L1VGQjdlblh2aFF1SDRZVG5m?=
 =?utf-8?B?RHNucERuVWdRcmxlOVltajNqdEJmd1lIekY4OFhlOFlRU0JidDNZWnpTRTdl?=
 =?utf-8?B?b0lZb2ZGVHdiVXBTV0o1NGdnYW9xaG45VjdLcjhBVmF0OGlydUk0Y3Y2OCtn?=
 =?utf-8?B?THdwdFB2Ui9KY1hRTk1PSUNTN1ZBdWVha3habmxzUGdRaHNENXhpTEQ5MEdT?=
 =?utf-8?B?Z0N2WitkRGRLVFhna08ydGhCK3J4RWpkOWMya3NHUmx5ZXd5S3YxUXBMK3pM?=
 =?utf-8?B?c21wdkVyNGM3Z2VZUk5HZGcrTzhnUzYvbzVYYklkVGxobUIyRDYxdWhTUjJ0?=
 =?utf-8?B?YUNuMmIxdkVQL2xwd2hCNHVQNXU1KzJWRFJyZW5paitzTnVGTm5ReGUzclMy?=
 =?utf-8?B?b1ZoNjduaGFIdjJDVGRMQ0dIakRlL3NsenFGYmhrcUpMbDZsK3p3UFZGT2pV?=
 =?utf-8?B?L1ZZYkt5RGVjSTVWVGIvUU1tWUhUbjk1UUlWQy9QcnkzTjNJWGNRekJrZXFl?=
 =?utf-8?B?OXBuU1hWYWxDQlg0Mmk3bFNkWG5pSGZmU012RHRQMHpTZFVudUFuM3N1OWRm?=
 =?utf-8?B?SEhXa1I0Nlg4WTRQUzREUi93aG9PZHhPUDNmOTRrdUtTMFkvSjZvWUNad2Mx?=
 =?utf-8?B?M0FNWlc5TUhIYUtTTTFjQThibEFZeTF6QURNTFpMbGIyYUhzb1pDcEx4Nk9H?=
 =?utf-8?B?bTVML0FRdEJjVzVrMm01UmRWbmpNZlVMQVR3M0E1WnhOZWNVVWErcGFHdXYw?=
 =?utf-8?B?OWhtS25vMk5BK2VNOXlNbE1sb1NnRUhTUGdWTGc3cGNCdkNUMXlhWkZhRmJL?=
 =?utf-8?B?ZE54d05BS0prQnVlZ3p4NVlWV1FDdndTVkNUdFcva093MnR0SDBuNWRpc0NJ?=
 =?utf-8?B?WXlMQXBXVWhUYzc2aU5QS1NrQmNSaUsraHdFcDc1bytoM1psZUpSc2tyY043?=
 =?utf-8?B?UWFkdHdVRTAxblpBWmlHZWl4UERTNFFIS2l6SGN5bU1EUVNWVzhmQTRyTDBI?=
 =?utf-8?B?MXU0T0xzd3dsdDI2U2s2UTdEODF5dDFXSjd2cmwyczFvQmF0NVNnWW1ZSXRz?=
 =?utf-8?B?V0NDU09BdUtkbStNSTQ2VHFFSDdlZmo4RHdldXN1TnlsZ0o1UE4rQWlLNERR?=
 =?utf-8?B?ajI3NEoyMFJnTUxzMVQ1V3VkeW41Mzc1bmV1VVlZMUl4MUlzV0JyV2lURmdV?=
 =?utf-8?B?bmYyci9MOCtXRlAvN1RJcFJIWUJYMVJFYS96TmRReE9NaDROeGJYa3dnOEhS?=
 =?utf-8?B?U0RVYzg1Y3JyOU5oUzZaMHJNTkNJaXVTUmpPc1lUWFk0WEJCMU9QUXFTeXVI?=
 =?utf-8?B?QmxSLzc5dWVvbkxCS0p6Y2ltZ0lJa0NBdWNOTmIvK0RnTkZCKzdwWFJ4YW92?=
 =?utf-8?B?dWtST3A3Y0Mzbm9oN0NvZ1laR0U2dm5ja24xVk8yQmJGQTEvMzVZTWZ0UWJS?=
 =?utf-8?B?M0MxQnU0ZDZrR3RqZC9TYUh1bzNRL3BSN1RXS1BhR3JSQWZXNldZVklwYU5Q?=
 =?utf-8?B?ZGVML0tPRExnNFpIdDBoNC9hMzdZQ1oydExLZjhWVE1JbGtKWjQ2dVhWWUhL?=
 =?utf-8?B?SXhYUkliVGFTZmFORjVSOUZjZWx5TDZ4UkhJWUFYalhUWTdBSitjVmhaZE5x?=
 =?utf-8?B?QzRkM3o1dWR6NkpFcFhKNjh6bHBvWmxPSzlEd3Rhc2hTY1Zwelh6UUJZTkpT?=
 =?utf-8?B?Z2w1SFdnWnU2bkxaRTBUVGRDeVJJR0VwYngvaWdMZDhGbVJvbmkyYk1tSG9s?=
 =?utf-8?B?a2w1Ti9kS20xNnIySjR1N2NZdTVYNmlYUDNIQ1hxaUprbDFnNUo0byszR2d3?=
 =?utf-8?B?VXRpZmZoRHBvM3JYdHFvNThkb0hRUzFaM3pZSWExS2x0OGdYQlFHcFNXK2R0?=
 =?utf-8?Q?vLYRDWg+BpuwVccx1da/FRRZY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d641a60c-805c-4bef-6065-08ddc468c5ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 13:00:42.9890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VA7dRbBomZDacRLLOB0yqfKX90jFYpOlWEcG70cZHp1d1UZXE6ovMcPbRc97Y+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

On 16.07.25 14:51, Tvrtko Ursulin wrote:
>>>>>> be disabled once GFX/SDMA is no longer active.  In this particular
>>>>>> case there was a race condition somewhere in the internal handshaking
>>>>>> with SDMA which led to SDMA missing doorbells sometimes and not
>>>>>> executing the job even if there was work in the ring.
>>>>>
>>>>> Thank you, more or less than what I assumed.
>>>>>
>>>>> But in this case there should be no harm in holding GFXOFF disabled
>>>>> until the job completes (like this patch)? Only a win to avoid the SMU
>>>>> communication latencies while unit is powered on anyway.
>>>>
>>>> The extra latency is only on the CPU side, once the
>>>> amdgpu_ring_commit() is called the SDMA engine is already working.
>>>
>>> It is on the CPU side but can create bubbles in the pipeline, no? Is
>>> there no scope with AMD to have GFX and SDMA jobs depend on each other?
>>> Because, as said, I've seen some high latencies from the GFXOFF disable
>>> calls.
>>
>> The SDMA job is already executing at that point.  The allow gfxoff
>> message to the firmware shouldn't come until later because it's
>> handled by a delayed work thread from end_use().  If you have multiple
>> submissions to SDMA within the delay window, the begin_use() and
>> end_use() will just be ref count handling and won't actually talk to
>> the firmware.
> 
> I followed up with testing a bunch more games, and is it turns out, Cyberpunk 2077 is the only one which has this submission patterns where default GFX_OFF_DELAY_ENABLE is regularly defeated.
> 
> There, around 1.2 times per second the SDMA submissions miss that 100ms hysteresis and cause a CPU latency over 100us (I only measured when >100us and ignored the rest). Average latency is ~400us and max is ~2ms. So IMHO quite bad.

What exactly does Cyberpunk do to hit that? Are those SDMA page table updates, clears or userspace submissions?

> 
> And the vast majority of those latencies come from the SMU request. Only very rarely someone hits the mutex contention path.
> 
> So that was the motivation for the RFC. I suppose I could have also proposed to increase the hysteresis, but holding the GFXOFF disabled for the duration of the job sounded preferable for power consmuption.
> 
> Anyway, given I only found Cyberpunk 2077 suffers from this I guess it maybe isn't to interesting to upstream for you guys. Then again it is limited to specific old SKU so maybe it should not be that controversial either? Only that Christian NAKed tying it to job lifetime. So I don't know, AMDs call.

Well what you could do is to take a look if we couldn't simplify the SMU and/or adjust the GFX_OFF_DELAY_ENABLED.

On the other hand why does it help to keep GFXOFF disabled while running the SDMA job?

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
