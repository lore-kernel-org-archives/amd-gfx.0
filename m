Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7245BC021A1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 08:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB4110E42A;
	Tue, 11 Feb 2025 08:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4AhDlA+1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E999D10E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 08:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8xY5n6hDZKI1F8Rh3wrSdixad3npD/etf1pEB6MN+lvhd4wZKen3vhH3SnHuAfolS6XG6T24N/aoDO26m+FVTeNH8qUynZKMr8v0jDUyA8pyH39QiLvfK3cniEXn7P8XwGBL1mOswZy0hMsqWHA2LOt9SChzbJ45x6olXWiwhoF/wQ0VUuIZTflr9cztFH+5EWU3R3eOHQg+cBK9rVf8E8ie/K4JZ90o7qRvkWinFtXz6GTuro79jaysxnV1KkdZgXOIW60DjN0XNGN6U4Mqvfq0s75mXGdmsq4BdBapFFf265QcF74RXJELdg9ntBLKho8ATOgH75CUlyp4aHgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZlmOvaNp+/RQgG357Et8Nk/ORuC2dFNz9ZrUi5txRc=;
 b=h9flGH5vne0nv7hb6Q2agQl89QMwNxkxO4+blYNhWhegkq+VtCc5zwAfKYh6qpd/FDnBCUzwIsH18aXwWdVYQPxe2v9rqtvTB8mYGooAvXYEBdu0QoRRFFoohBwUCnUtMLq2EcS4LY31OdUYssueLaI250fwpWivWy/IRUuavHMRM4jLu+jqj2e1LTkRCxPHxYp1qzAr4aizvWwCbMcYFq40T7a97JLWiE2o+7U3aAvDIzBhJenslUL/EjfXly0QjDsDwHi5ygsGdqrWEAnFsdZMVACC9NEjrFIOEiGhs7Jwdo7jBqU6rixfBX8rkTE3cWAHrUi+LfCAJ9sCEX156w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZlmOvaNp+/RQgG357Et8Nk/ORuC2dFNz9ZrUi5txRc=;
 b=4AhDlA+1YmotiAIN9J8FbY/IXab/jFTyMmK+4V9zV/KoSuq5yVfnH4JzAOzH0tLyQv2MOdplledvn2wZA5WJGrFY/+d/c2nikX4IOwf9eMU8FsTlRr48vg+9c6xFdZAXpuLy4NHSp5bwHA01DfOmZcYieKt93qyGSck6lNhl5AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 08:22:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:22:52 +0000
Message-ID: <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
Date: Tue, 11 Feb 2025 09:22:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 192c22b1-b2f5-49b5-aa28-08dd4a75471b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2FlSEVoNVF0Z1ZlQnlITGRBejhoRXM3Vkk3ek9VcXBkMXBRZ2U0RGxzdWg3?=
 =?utf-8?B?cVVNbTZJM1VhYXBrWkpMSy9IUUxkdnNuYzQ5cWdlRW1hUkZZUWxPV1E1MzR5?=
 =?utf-8?B?cWhMdlZCVlc3Q1l4YjhTQU5qTWZzY1RIZ3VrQXBKRTRDcWxJN3V6UnFva1Bj?=
 =?utf-8?B?TnU5ZnZHZEVYOGs1UnhKTFV1THZ2OGFQUEJKQlhzMFo1T1ZVeDhKVm1HOE5m?=
 =?utf-8?B?WWExVEg0bWR0OGhFVWZFY1dwdzFCa2ZEYW82ZVIxcmc4WVVnQjlyVUVEQXo0?=
 =?utf-8?B?S2NvdDJST28ybjFUR3M0bDNFTGJseUhlVzIwR1MvWkpxWHVYUlBzcUROSnpG?=
 =?utf-8?B?aDF6eU5TTlVTdlNRdXFvMnpPTW1RKzltNXFpTncxRk04Wnp4UWJFYUtoRnQ0?=
 =?utf-8?B?bHQ2dUpHUFRiVEUyNVdncGV6cWZlczVnWnV0bkVWNmE4NnBybVZKeVBOdFJL?=
 =?utf-8?B?QlNHRnlDZVM4WDBkRk1vVmg3OHE1RmlvczErZnVUaXdhMjNMU09FV1BxYWhh?=
 =?utf-8?B?TU9KQXI2V1pJak94SkJ6RTM4TXFBbUJCek50TW5hcFFHYUtLeWxvWHVyWUFJ?=
 =?utf-8?B?K003cnJDcTZDdlkxQ29GWDBWcTRyblp0RWtudTQzSmFFSXFGclVpb3JQbnI2?=
 =?utf-8?B?UHNQRksxNVFMaUxjWE5WdnMwUVpJYTlkTmY3WXVNNm9kbzFQZ2QrUndzaUpy?=
 =?utf-8?B?OFhuN0pRN05lQ0RabkJON2w3aE1rdTE1MzZOU0JqOU1OQU5HOUNLL3MxcmpJ?=
 =?utf-8?B?VVZVMjlYQ2tuekl3Q1VuUlBZSm1SU202bXZ2b3ZFN3YxMG1RWlFDSGQxUWp0?=
 =?utf-8?B?Vm5IcHVFUysrSTFGQURzV096TkRjRFVwaG9odXQzVlczSFVFUEFQRHJ6YUht?=
 =?utf-8?B?Z2ZoTmNpNkI0Z09NQmFQTlYwc0VNZXN2c1Q0NFFET2hVblUwZCtDSmlmRjUr?=
 =?utf-8?B?OWUrcjZXN1lndUl2TnpxV2M2c2c5bk5sSVZxTm5ZTVlQOTZDdzNxYUtPZUhW?=
 =?utf-8?B?aWozVjJWS1ArdFJhNnJST1lQV0t6ZjF6UUxwcittRHlPblV3a3E3VWZ1ZmNp?=
 =?utf-8?B?MGc0M0VZRXNtZUh2Z0dJZVdQYTBzSzc1YTdzcHdYS2hrWkNJKytIMk5WMmMv?=
 =?utf-8?B?clJaVDJDM2puT3hoUUJ4cnlSandXWTBSQ1J0U08waVgzQTZsbDhkbXBZRlV6?=
 =?utf-8?B?MkFLL0tnK3RWQndEMXRxNE4xN01OcTVKZy9xQ1FzWWl1bU5wU0RxZ1FQbVJ1?=
 =?utf-8?B?NzlzT1lNTmovOG5WZTFsMXVuTTJERUlrUHlYSmtUM1QxR2JJRkdJY1NVd09P?=
 =?utf-8?B?a1dmdFpNRVdTWTYrelpkNXE4SDdLeEVQdTB0V3dzNGk5VFFQaHVYNjl3c3Jm?=
 =?utf-8?B?cjhLOG1iNlpGaWtvcjRJMWhwaTR1dk1UcFZnd2pLOHlYMHNFUkVDTU9oWUhN?=
 =?utf-8?B?K2NmYy9HZk8rL1UzWmJYNDNxdmFlVDNQUjJFaWlKRFk3SjhNRmtOMk56V3J1?=
 =?utf-8?B?d2pBSGFkemozTWRGbGsxSlk3bkhVME16V3RnaytQVHZRTWJ5K0xKaGhaaXE3?=
 =?utf-8?B?aTlvYnNVVmRnR2JVaG5wcVVTZlRwenZHMEU4aVRSUGIrcVQxcHJkN0wvekd5?=
 =?utf-8?B?eXVwNC85dzkxRWdhR1dWMWZlSWZEMENIUnpwQVA5dDlncWRxeXRpTUVlYmZB?=
 =?utf-8?B?YWl6dkJRbFZDSFpQakE3QlNRR0w0RlhlQmFoNmNDUWJlK2FuWmhQekJOS3Bo?=
 =?utf-8?B?Lzg2dG9sbG16UGxEb2dYeTJBeDhPQldVaU9iQkw0bERBaTBBUEpJYTZkbVRo?=
 =?utf-8?B?QVQ5SEpqSk5HTU5DNmViZzRtTjgyWVdxWnRncnFZZFF3VUFxTU9JWERsWnM3?=
 =?utf-8?Q?qjruric6qAN3i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3p5SEFaR0tGTmlJVHE2WXR6RTB1eGtrUUJVTzNrWlVzNnZYcTdLR2IrbVBK?=
 =?utf-8?B?TUFFL2tMNmROelFnSVFLR1NxUXNxYlNnMW1RczRIL3Y1c0svSzhCRllUcEZW?=
 =?utf-8?B?ekJRRkNZYXhYWE9wM1NNQWp5TXZjZ1RQT0VGekgzR0NZZmdiTFRBM0JhRlVT?=
 =?utf-8?B?NW9CS00vUndCQjZScFVWWDFYV1JDOWVhRmEwZVoybTVadElGUHN0UWcvME9O?=
 =?utf-8?B?WkVQelJXVnJPRytYS2xUN01OUWRpY29SN1A2YU9sZ0xIdmdXbjlqR2puZlA4?=
 =?utf-8?B?VTlPTysvRnVLL3FoNk5jbVA3dDBWMW1RQkFUQlJYSmpSWFN4OXlNRTNKaGpw?=
 =?utf-8?B?bjh0QThXYTB6NG55eTRGOGtnZzBMM0l4UVYzMml2REJaUmM0WnFjM1VHeVdH?=
 =?utf-8?B?ZW93KzQ5cVJVaGMxSFZKZU9PR2R1aHhzNGh1WUc0TndQNmRXZ3NoYzcrVlJB?=
 =?utf-8?B?a1ZjRGxFTEordzJKanh2cWZzamEvTVByNDlKRXh0YmFVbEUzWmtjU2Y1MEJB?=
 =?utf-8?B?OU81c0pjYUpDTkduUzhSdFBNYzVYdFhjNDZjWEZlY0daZ3JtV0NwSmdUejd1?=
 =?utf-8?B?S1dDVm9TOUxUS2lZQklYRTZFYnBzUEtVUmtRMFM5OEVpS2hsRm84cTFVVDd0?=
 =?utf-8?B?Q1NyaEZ0akVSdE85R0pMdXFaWUdmM1BVN0xQekhDQkJYUXJuem9UNG9LOWhj?=
 =?utf-8?B?enAxS0phOTUxbFBQZklDZ2lMaklHR1JNUXpNUVFvaUJuTEtaR2QyRnFwbFJ4?=
 =?utf-8?B?YnJSWmRzTExzOWwyK0Q5eXJVM3IydWhORVNwM0RBYU8zVVMrRUh6UVA1NGdZ?=
 =?utf-8?B?VFBFOHpQbUJrRUw1eCt5c21saU9pQ2N3UEcxVWdBM09iN09MYjN6WHlPTlQx?=
 =?utf-8?B?VEJOZXVzcGNDQ25Ub1ZIeFh1NDhmMCtVNG00ZHpKT1lVYSs2THBnNHphMDFG?=
 =?utf-8?B?ZncwcHQ1d01UOWxJREhic3RFdTlhTUYzdVVFU0luNDZFdlMrVXhzVDBwMUU1?=
 =?utf-8?B?ak40c3R6OUdHRTIrM2xMZENpUE00ZHZTU2REbFRZUFpTd21obmpwYjR1ektw?=
 =?utf-8?B?U25tOGxXUkU0SDVyN243WkVqemJVeWY1WGVIQmxBRzVoSkdMTVBrbU5sdWFm?=
 =?utf-8?B?OXppU05kTnVvVXFWamVnbjk5aTdHc2RTSGRBSlNQMGU1WUczbDk2dGxmblhR?=
 =?utf-8?B?eVJpR0ZTZW1IVHUxdmZ2bFFkd2MvRmNlQ0J3VUo1L2ZnU2JuMVlmUjhnREda?=
 =?utf-8?B?RnpPRmdOc3FWUDkybE1saUU5dVQvTkE5UEpnWEFuOUFyczFNdmljUy84UGh1?=
 =?utf-8?B?aDZXZ2FUczZuTTdFWkx2Qy9IV2hBb2FXR1dRY3VDblJZcWtRN0w3eFMwaWs5?=
 =?utf-8?B?RDRUUGlPRkV0V1A5VFNPUzlCS21qZ3VIdjhESkpSV1hqUlhZSXVwb2hOcFNZ?=
 =?utf-8?B?Nnl3SUREMUNGSDFtbTFhVERwTGczVkZYeUZzNjIvdVNBQ0pCcktWd2hIcm1R?=
 =?utf-8?B?YTNKa204U1l0em1zSWRuUVhVazkwNG5sZEVVYWpCL1ZmZ05yT3V3NXVoTEpl?=
 =?utf-8?B?TjNpSUhBM3FWbmVEREp5Tkdja2VMOGJxVzNNRkZ0QU9lUXVCRUt3YzcwaXNJ?=
 =?utf-8?B?MnJhZlRsMC9ndUw5WnJKQjhoZm9kaHRYZjB1cFByZnFkMDJZYTVuWG1FcVdL?=
 =?utf-8?B?SnNuNWUyQy9Tb3NqTFIwQ214a3A2SXpXQ05aNE1zTUFodlNkejNqd2E1YlBD?=
 =?utf-8?B?dmJ5QU4yQm8vWHFrcUd5OGRLd3JURklrRFRWSXUwNFJlbkJDaytYOVptczN3?=
 =?utf-8?B?aUlXRTRUcEx4SXNWZmxKMXhwaW9KY1Y1NjFmczBOaGszbHJlcTh0bmN3OWpZ?=
 =?utf-8?B?UzZNMnpJbEIyTFRWc3V1dXJwWkxqR2tvOWp4aFVCaWZJQTRuWnVkTGJEV0hY?=
 =?utf-8?B?VG83OXhpekU2U2ttOGsxcldGRjlETzRVdWlIUGF6YnBFM2NZODVnRFVENnAz?=
 =?utf-8?B?dklyMDVoRkNuOTZ4S0NpQUxCYlMvWDFHMDFORVNqWkJPbE55ekQyNFpXOXI4?=
 =?utf-8?B?ZXRpbXNMc3l4M2FVUEJJTTFwUEJSR010MUNFaFdLOEQxUjZ1WFhCc2IwMEpI?=
 =?utf-8?Q?9RAuo1Kg3L26BnFUc519Wp92A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192c22b1-b2f5-49b5-aa28-08dd4a75471b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:22:52.3713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX/VDCnDWkOvz2J+nDnwGU1F6KEYTkYGASOEOZdM1LOZBnJB0l1V9wNmNs2E+0eq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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

Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
> Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a newly
> added __drm_sched_entity_queue_pop.
>
> This allows breaking the hidden dependency that queue_node has to be the
> first element in struct drm_sched_job.
>
> A comment is also added with a reference to the mailing list discussion
> explaining the copied helper will be removed when the whole broken
> amdgpu_job_stop_all_jobs_on_sched is removed.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 100f04475943..22cb48bab24d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   	return fence;
>   }
>   
> -#define to_drm_sched_job(sched_job)		\
> -		container_of((sched_job), struct drm_sched_job, queue_node)
> +/*
> + * This is a duplicate function from DRM scheduler sched_internal.h.
> + * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is removed, due
> + * latter being incorrect and racy.
> + *
> + * See https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
> + */
> +static struct drm_sched_job *
> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
> +{
> +	struct spsc_node *node;
> +
> +	node = spsc_queue_pop(&entity->job_queue);
> +	if (!node)
> +		return NULL;
> +
> +	return container_of(node, struct drm_sched_job, queue_node);
> +}
>   
>   void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>   {
> @@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>   		struct drm_sched_rq *rq = sched->sched_rq[i];
>   		spin_lock(&rq->lock);
>   		list_for_each_entry(s_entity, &rq->entities, list) {
> -			while ((s_job = to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
> +			while ((s_job = __drm_sched_entity_queue_pop(s_entity))) {
>   				struct drm_sched_fence *s_fence = s_job->s_fence;
>   
>   				dma_fence_signal(&s_fence->scheduled);

