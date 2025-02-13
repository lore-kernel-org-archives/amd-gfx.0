Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06954C021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 10:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F3710E2AE;
	Thu, 13 Feb 2025 10:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="je4tFbEZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09B910E2AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 10:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smqwAoPKkXBGsWSe86NIlJYm5YM12qdvXkmrS+Mm4OnzKPuG8t68/w/o1QWCl4RChiAPi/WO9aYnt5su94Tfme0poXWETAyPWptoVff9JeB+ThIuNIlvkg6d93+telUnX7ZQ7iPymM9kF+LY+OuJra1N8TcY3Z/xwyxAYCLTh9YVAyjcT468KauYhpIn5ezoVKPSBt+tkVC5aqsxXv0TZc+6mSD5s+zwpnPb2k9RQQxtcBAd7RFubqq1gQ6kz8k7axNFkANwP5+gnS4O1RVjWfwXTDH6Xm2l9o5h9cGbho57ClgwmiX63d3Zd8Rpqf77sqwOGq8yv/JrvZsrGkxWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW/Ov5kpjD9QXDSTDTLC9jIklfWvpzx94AkUvb0ukUw=;
 b=zWj0iKbgOlLQKvRcCG0eIlVwXwVNLmMjjd2fO4/B8Bi+OpDhC1tUwBM0rEwNvSgyQBEFgzH0zJ/Mdo3cLjfA+m1BXwm6NS6i2nai2xrkBfrfvSpyRmgct0K+Gg3KXW9hV7uN0GedsLsAYojA49Ggti8LOEaSy3lyMGVIButm4yYa6fR5//KvNy+n7N9HrwiC6wiW2eKZc1lbMafXtk2rBllUcxEz8Iqk4Wx/U345enhywhTW2P6JvIwrnkoYpp01muVvXMrUlH9VRzcPuXNajah990t0JC9ydRNd8k2JFvtUm6KklfUf8qRieo228u5CfNz+7hSrxXqc8RkRDfBu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW/Ov5kpjD9QXDSTDTLC9jIklfWvpzx94AkUvb0ukUw=;
 b=je4tFbEZG/4+nV1oNp52PnWt9oRMaWzl0NMeNyuPNdOV243B4UGztI2Rr2MD8XLf5kJW77z2GC4tZPS0s4o/dk2CFlH5FA9Rs31gNZuKuabB+M8Y5aemFbiVF3UqxX7FhhnP18JppkhCobzbt0a+jwUP/asp2nEgrr++wfFQiMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.20; Thu, 13 Feb 2025 10:16:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 10:16:01 +0000
Message-ID: <6c06878a-fe02-4fc0-a47a-de2f3179bcf5@amd.com>
Date: Thu, 13 Feb 2025 15:45:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
 <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
 <a7f7fcda-ae6a-4506-a7a2-4e3eea5316e4@amd.com>
 <4c2483df-ae3a-4380-a01a-de11edb36e09@amd.com>
 <f1856ade-76e8-4bf2-9dd0-0a98bce21859@amd.com>
 <64a793d5-1694-4449-bdb6-0bbfa7815598@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <64a793d5-1694-4449-bdb6-0bbfa7815598@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 83da3f98-7bf0-46ef-eb7a-08dd4c176a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFRtTFJjWURQMzhpbTZyb3NubTQydlBDUlo0SFYyVUF0aStpTVR6dGozQlJV?=
 =?utf-8?B?NjhGYnNPSDJWTU1YMzVuU1c4WmRCLzl0emVSWWJTWWV0MVB4MUFjVVZuRFNL?=
 =?utf-8?B?VGZhbEp0RE8vZWR3VSt5NE9wbzROWXFEOVdZUjNpSGNpMnNHdTRxVFlIci9X?=
 =?utf-8?B?RnM5MXd2VWNjU2tYOHI1b1F1RmQrbHVjVytLNGJRYnZYUHFtQ1ZmemlPNFhz?=
 =?utf-8?B?SzBSVVowclhLQ3VicUFWaWQ4cFZ0ei9ETHZjck5ScmRFNTdWa3pmdC9BelZ4?=
 =?utf-8?B?NXFFb1U4SllRbWZRNFNzSTZ2akR5LzF0OHlmby83WnVDZncxc2J5WitaaGVx?=
 =?utf-8?B?Mk1jaWlyRUNqcXZ1Vkt2elFhMW45dm5BeDlzTnFFeFhyT25TM2R3cDJ4dW5u?=
 =?utf-8?B?bVhlS1dNT0dpNWV1dTZaZGdUOGxXZDJMam4rMDlsRXB5TUlsT25wcGdJR2F5?=
 =?utf-8?B?M0s1aDFFN29pRHkwZnpBenZIUVZiay9SL25VOGlTS01aUlZNU29JMm9IR2Jh?=
 =?utf-8?B?cXV6ZEhBTTg3a3J2WWxkSFJPT2hXb3hjOTJhSmtGNnRWWC83ZHdxeUFZZjI1?=
 =?utf-8?B?MW5EWHg0T2dEcjRDdVJkbS9zY002YUlseHlBbVcvN2tGNUVwUGV4Qzl1OFo2?=
 =?utf-8?B?TzdUSS9KU0d4azR0UVphWll5enJudGZSVEpqZGticXFoZUxGN29PUTZVLzJn?=
 =?utf-8?B?SXlabnFVMFpIRjdhK1IzMUZJbXNwWDV0MjBqY2p3aFYrMTVOZzkzRmRLMVlH?=
 =?utf-8?B?TVh4ZnVRRG5MRDFVamxIWlljNnlRQ0E5bUNrOEQxdWZxSU1UK003SFpjelJi?=
 =?utf-8?B?aVZtUy9OM2VkYWtBUEhEcFcwYkYwSEovY01GSVhSSld0azV1TTJhbGVpSEFC?=
 =?utf-8?B?Z3ZOaGpzVExORFJjOEVHaVJEcTRGbjJ3UjFncTFJODZDNTFkcmkwQ2tzS00w?=
 =?utf-8?B?b1B4UFlIdjRoMWtNeHA1Nm84U3lMbU5xcUYzL0pwbFhZdDRVTEJvMDR2U2lD?=
 =?utf-8?B?bmtZaDVVZUNaSjBWL2NWM1BYQzEyWFhjYkZqbDJYdDErTW9pc3dpVFlLU0RT?=
 =?utf-8?B?WHhEd3ozaFBabXg4MThCQzkyL1p1MEJ0MUpqUkdFdVduY2JiY3gzNExOQkpr?=
 =?utf-8?B?b0pCOHhGMm0yUEJyQzI3S3M4N0gyQ29KdkRPSGtZSnRZYU02cmViS1d1YWts?=
 =?utf-8?B?KytyWERLblp1RGcwWmVCUUV1OWdVTGZ3SDhWRGdSc0U3REdLNGV6SG9PR09h?=
 =?utf-8?B?OVVHQng2MDZFQ2d1dmtjcXlIOE1SSzNUZUZlODBJa1hBK3NrUG03ZkJJL0dD?=
 =?utf-8?B?SkVqZGF4MmRJc1lzSWdmaUw1NmRIWWtJa0t0QTl6UU0rYzhOUVBsZ2ZJM05n?=
 =?utf-8?B?L0g0c0RPdm55NmhrMytYL0hZVHBHQ1IxMUNzL3IwREhGeFRRKzk3ejdOSGJV?=
 =?utf-8?B?Y3NZR0xQeC9XZzZKRVppOXBxcVNic3lQK2Jrdmx2TVc0NVpZTXFnZnYwODRo?=
 =?utf-8?B?enMzNmZ1UnpZMUtOOTgrRUZqYzBFZXVQTzcwckttSEZ2Tlc2S04wYVBFMzFR?=
 =?utf-8?B?U0xqVlc5eVJkUW9IS2RqNkdoU01VUWpRNnllYkJGREhiNHliTTZsU2t1Vmhk?=
 =?utf-8?B?emgvZ1VkbHdhaDFFbzBvSUVKbEU5ZnJJeklYZzFPVDZBRkxtWXpMTVlZakNt?=
 =?utf-8?B?ZFFXdzNsU0dhcng5VlNSZ0tacGVrdGpLY2t3ZnRKanMxZ1Q1OXQzNXRRWDd6?=
 =?utf-8?B?OU1JbmJ2ZDFMQmJUdDEzWjVpaVJmMGtuZjdQVDhVbkxGU29wbm93eEJLdGw3?=
 =?utf-8?B?V3g0K1dKMlRvL1VKWHZXQTJEU2NQQ0FvOE5xOFpyS0QrWFVjcU00eXFGakNY?=
 =?utf-8?Q?s3uUOLoFRsTXx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdoN0I3aVpLUDVrS08vQWJxa0dPN3hGMUpEVzNEMFdEdDh2UmhDamYvdjdC?=
 =?utf-8?B?aE9vd0d1V0NqaURJZFgxMS90cmo0Wk1mSGxUK3Q2MTI0ZXRMdW55Uk4vdmFH?=
 =?utf-8?B?aVZvOHdaeU1TUFFmWTVsWmQvOFg3WVhGTGFSUi8xeTEzT2hrQmNxaUxvRmF1?=
 =?utf-8?B?V2VOTy9tQXhHQjVlUzN6ZGdYYWlkVGlTQUNHN0hJcXpwVnU2RHBzSEhKWjZC?=
 =?utf-8?B?ZUx0WkwwVHVrL3NjMUhzODVwanRQdUpHR3BhRndqOUt6OC9LTkxUUSthV1J1?=
 =?utf-8?B?cytBOFR0dWExSjhxTXlKWndDN0VsM3FKMVBGVHhGNUIxakh1ZDY1ZVdDNk1M?=
 =?utf-8?B?Uno4VTd1eWhnYzJUNG9VQkNLNitGRlhKQnVuN0hMVmF3MzhCS2R6MXRYNXVK?=
 =?utf-8?B?dGJFdmVIUWFWTWhlSWQ5OUE1MmJta1Y2OTI1NzNMREVOTlllb25ZNURKdDIw?=
 =?utf-8?B?L1FxYVUvSVorck52QjlMbmZiRlpzeG1jU0QxT1pnRll6L01oZmdwak9Pd083?=
 =?utf-8?B?Y2s1VENlaDRmeGhGM29GTkhWS0dFSi9xbkFkQnJpTnYrYkhDOERlNEFKeFNF?=
 =?utf-8?B?NlhnMUcxTWtTY2pBYUNsd20wWEdaMDR1Z0c4OHN0QkVWbjVqY1FjQ3JVdE5p?=
 =?utf-8?B?MUNSbUIwV2lJSDh6ODVTblRHMHRxRjZqMjUvOGJURmpzZ0VzbklGQlZ2REFS?=
 =?utf-8?B?NFBhcU1jYUl4M3B4d3k1MjRzVUlBS09nVmV6ajkwd2UvbGtPVFNpc0pFbFZQ?=
 =?utf-8?B?dmZlVmN6R29Bd29BMXNrSTIzT2txSkIrMk1SeittV2l6OXpqVkpKck51TGJp?=
 =?utf-8?B?UW1yY2ZNeWRHa0ZnUDh2TERYTlY3cnNTYW9peE8wOUR3Kys1M0FINUpURlhU?=
 =?utf-8?B?TkxmK3JhZTArZ1VnWUF2NG5XZlU3Tnl0anBuRHJ3Yk1YcnV3eDN6MGZ4QzNa?=
 =?utf-8?B?bkpYVC9aRFlNK1Q4amFwblo1NDVubDhRcEZRVWdGRUdaMmZWLzhIZTNhU2x0?=
 =?utf-8?B?TEtBOW55ZjlkTk1PY09pMW1STHkxVk84M3Mwb1FBSWR6S05lS1BWemxEQXkw?=
 =?utf-8?B?Y1pBU0NkL2J3bWVlYlNGcHliakNJOGJ0eDVvVlNPNmhpWG1UWk1PTTN3Wjdu?=
 =?utf-8?B?Ujl0ZEpBeDdZTW5GTThmeXVvTm0xQUZ5UzRpOXNWYTEzRUMrTXpYVHNTalNC?=
 =?utf-8?B?ZnhCUk1JdGJMQlJ3VEFYMElrQkd6NHlHUFpCOHpIbFBmcTF6ZkRwaFY0YW1u?=
 =?utf-8?B?QlFCOFBMRVVTVFJza0EvZmplais3MkgzT3I1dlJKdUJUU2NuSTNlNE90Vlp6?=
 =?utf-8?B?ZDREQ3dTY3pjRDlpWjQ4TmhqaXFQK0JwYjFKbzAyaWI3bjh5anBMZ21OWjFK?=
 =?utf-8?B?UU9Bd3hWM1AvNytVcG5maGhoejMrRVc0SStMdVByV0ZTWEVOak1HUGM5UEdq?=
 =?utf-8?B?YkxRbld6R3hqRjlRMVFXWHI5aEFvNGVkL1lBTjZjZWM1cWMxMUhZTCtLaTJ6?=
 =?utf-8?B?SGNUQStlc1ZCYzFPR3loT1lMbXhkWEZpR2RMQVVLVnU1djdqcGRyUDRVMjRW?=
 =?utf-8?B?VXVJeTEramxsOHZiK09hOWl3ekNKWjRvN1hFbFJTVXJXNnRqUkhGQ3NQaG1C?=
 =?utf-8?B?YzlvTEVwalBqcU9ENkZRVloySEtJMUxtbFYzOVNaSmgxcytveFdZUEpPektK?=
 =?utf-8?B?WXZqZ1BRc21ScUF1YjF1S3kzNVpTTzYxREtIdFllWjVGcnA5TmdJa3cyaWQw?=
 =?utf-8?B?NHJqR1hEN2IwZlVXSnNaaHgwbzV6WDFSOHBJZ0RmcnpxbWxoR1RDTC9rT2FH?=
 =?utf-8?B?WXRWQzNJRFJCa0M5SU9RQVVtNHVYanJ4SEcvLzFhbEUxZW84N0piQ2xqeGJr?=
 =?utf-8?B?NWNjVlZvekVrcExSdXUxOXdURURJOFhKUVphK1E0dGN4OWZ5T003d1JGZEgv?=
 =?utf-8?B?SzhPTlNUcnk3MnR5VDB6czhIRmovbzQ1eVFwN2RUUXdzMzVIN29PV3BmbllF?=
 =?utf-8?B?RFVEbFc3b3I3TjI0YTJzRzVUS2gyeitJNkNxaFNTQXk1a2NoVEtUQ2pOdzNt?=
 =?utf-8?B?OVRmdC9Dem5Kblp0ZjhOdERjYlluWEx0M3ZERUVQL09PcUJDSSsvbjVpYzVX?=
 =?utf-8?Q?FWbofYEnOY5dx0yi4+Awva6qW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da3f98-7bf0-46ef-eb7a-08dd4c176a03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:16:00.6754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKOw53w8VhdVlmoM6uvsPzTcFZAjYeAJy6BhhF8Rbn/BAInrRrqTwPld1nbEN5bw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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



On 2/13/2025 2:45 PM, Sundararaju, Sathishkumar wrote:
> 
> 
> On 2/13/2025 1:35 PM, Lazar, Lijo wrote:
>>
>> On 2/13/2025 1:07 PM, Sundararaju, Sathishkumar wrote:
>>> On 2/13/2025 12:16 PM, Lazar, Lijo wrote:
>>>> On 2/13/2025 8:24 AM, Sathishkumar S wrote:
>>>>> Add helper functions to handle per-instance and per-core
>>>>> initialization and deinitialization in JPEG4_0_3.
>>>>>
>>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>>> Acked-by: Christian König <christian.koenig@amd.com>
>>>>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 +++++++++++
>>>>> +-----------
>>>>>    1 file changed, 98 insertions(+), 92 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> index 2a97302a22d3..e355febd9b82 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> @@ -525,6 +525,75 @@ static void
>>>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>>>>>    }
>>>>>    +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int
>>>>> inst)
>>>>> +{
>>>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>>>> +
>>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>>> +             1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>>> +    SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
>>>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>>> +
>>>>> +    /* disable anti hang mechanism */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>>> regUVD_JPEG_POWER_STATUS),
>>>>> +         0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>>> +
>>>>> +    /* JPEG disable CGC */
>>>>> +    jpeg_v4_0_3_disable_clock_gating(adev, inst);
>>>>> +
>>>>> +    /* MJPEG global tiling registers */
>>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>>>> +             adev->gfx.config.gb_addr_config);
>>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>>>> +             adev->gfx.config.gb_addr_config);
>>>>> +
>>>>> +    /* enable JMI channel */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>>>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>>> +}
>>>>> +
>>>>> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>> +    int jpeg_inst = GET_INST(JPEG, ring->me);
>>>>> +    int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
>>>>> +
>>>>> +    /* enable System Interrupt for JRBC */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
>>>>> +         JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
>>>>> +         ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
>>>>> +
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>>>> +                reg_offset, 0);
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>>> +                reg_offset,
>>>>> +                (0x00000001L | 0x00000002L));
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>>>> +                reg_offset, lower_32_bits(ring->gpu_addr));
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>>>> +                reg_offset, upper_32_bits(ring->gpu_addr));
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>>>> +                reg_offset, 0);
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>>> +                reg_offset, 0);
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>>> +                reg_offset, 0x00000002L);
>>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> +                regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>>>> +                reg_offset, ring->ring_size / 4);
>>>>> +    ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>>> +                     reg_offset);
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * jpeg_v4_0_3_start - start JPEG block
>>>>>     *
>>>>> @@ -535,84 +604,42 @@ static void
>>>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>>>    static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>>>>    {
>>>>>        struct amdgpu_ring *ring;
>>>>> -    int i, j, jpeg_inst;
>>>>> +    int i, j;
>>>>>          for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>>> -        jpeg_inst = GET_INST(JPEG, i);
>>>>> -
>>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>>> -                 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>>> -        SOC15_WAIT_ON_RREG(
>>>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_ON
>>>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>>> -
>>>>> -        /* disable anti hang mechanism */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>>> -                      regUVD_JPEG_POWER_STATUS),
>>>>> -             0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>>> -
>>>>> -        /* JPEG disable CGC */
>>>>> -        jpeg_v4_0_3_disable_clock_gating(adev, i);
>>>>> -
>>>>> -        /* MJPEG global tiling registers */
>>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>>>> -                 adev->gfx.config.gb_addr_config);
>>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>>>> -                 adev->gfx.config.gb_addr_config);
>>>>> -
>>>>> -        /* enable JMI channel */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>>> regUVD_JMI_CNTL), 0,
>>>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>>> -
>>>>> +        jpeg_v4_0_3_start_inst(adev, i);
>>>>>            for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>> It's better to move this inside the instance function. Instance takes
>>>> care of all cores within the instance.
>>> The separation in the helper functions was done to decouple core
>>> specific configs away from instance
>>> specific configs to have the degree of freedom to control them
>>> independently without meddling with
>>> each other, so having them done separately kind of helps to align better
>>> with that choice.
>>>
>> Functionally, is an instance considered started even if its cores are
>> not initialized?
> 
> was that a question ? _start() does it.
> 
> The current design aligns better for the initialization and also future
> work planned, like per core reset
> and full instance recovery, and this separation is a must for that, I do
> not want them together as it
> hinders an axis of freedom in configuration and recovery process with
> validation at every step.
> 

Ok, that is fine if this provides more flexibility for future
functionalities.

Asked in particular based on the approach (that is to be) followed in
vcn. If that was the case, then this would be something like -

int jpeg_inst_start(amdgpu_jpeg_inst* inst)
{
	power_up_inst();

	for_each_core_in_inst(core, inst)
		jpeg_core_start(core);
}

Thanks,
Lijo
> Regards,
> Sathish
> 
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Sathish
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> -            int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>>>>> -
>>>>>                ring = &adev->jpeg.inst[i].ring_dec[j];
>>>>> -
>>>>> -            /* enable System Interrupt for JRBC */
>>>>> -            WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>>> -                          regJPEG_SYS_INT_EN),
>>>>> -                 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
>>>>> -                 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
>>>>> -
>>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> -                        regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>>>> -                        reg_offset, 0);
>>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>>> -                        reg_offset,
>>>>> -                        (0x00000001L | 0x00000002L));
>>>>> -            WREG32_SOC15_OFFSET(
>>>>> -                JPEG, jpeg_inst,
>>>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>>>> -                reg_offset, lower_32_bits(ring->gpu_addr));
>>>>> -            WREG32_SOC15_OFFSET(
>>>>> -                JPEG, jpeg_inst,
>>>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>>>> -                reg_offset, upper_32_bits(ring->gpu_addr));
>>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>>>> -                        reg_offset, 0);
>>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>>> -                        reg_offset, 0);
>>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>>> -                        reg_offset, 0x00000002L);
>>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>>>> -                        reg_offset, ring->ring_size / 4);
>>>>> -            ring->wptr = RREG32_SOC15_OFFSET(
>>>>> -                JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>>> -                reg_offset);
>>>>> +            jpeg_v4_0_3_start_jrbc(ring);
>>>>>            }
>>>>>        }
>>>>>          return 0;
>>>>>    }
>>>>>    +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int
>>>>> inst)
>>>>> +{
>>>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>>>> +    /* reset JMI */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>>>> +         UVD_JMI_CNTL__SOFT_RESET_MASK,
>>>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>>> +
>>>>> +    jpeg_v4_0_3_enable_clock_gating(adev, inst);
>>>>> +
>>>>> +    /* enable anti hang mechanism */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>>> regUVD_JPEG_POWER_STATUS),
>>>>> +         UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>>>> +         ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>>> +
>>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>>> +             2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>>> +    SOC15_WAIT_ON_RREG
>>>>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
>>>>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * jpeg_v4_0_3_stop - stop JPEG block
>>>>>     *
>>>>> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct
>>>>> amdgpu_device *adev)
>>>>>     */
>>>>>    static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>>>>>    {
>>>>> -    int i, jpeg_inst;
>>>>> +    int i;
>>>>>    -    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>>> -        jpeg_inst = GET_INST(JPEG, i);
>>>>> -        /* reset JMI */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>>>> -             UVD_JMI_CNTL__SOFT_RESET_MASK,
>>>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>>> -
>>>>> -        jpeg_v4_0_3_enable_clock_gating(adev, i);
>>>>> -
>>>>> -        /* enable anti hang mechanism */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>>> -                      regUVD_JPEG_POWER_STATUS),
>>>>> -             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>>>> -             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>>> -
>>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>>> -                 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>>> -        SOC15_WAIT_ON_RREG(
>>>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_OFF
>>>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>>> -    }
>>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
>>>>> +        jpeg_v4_0_3_stop_inst(adev, i);
>>>>>          return 0;
>>>>>    }
> 

