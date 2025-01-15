Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26889C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 08:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8498610E556;
	Wed, 15 Jan 2025 08:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCxNK4rO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C669F10E561
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 08:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbwEFoUqIVRTMcoK8IFupiUPCs5hhy/VRp+5IvjU6wSh7XYfuyPIqCN7AsV68O7AwEu0TyV5UyI3dmIdN44FP4tCzgoOF60IWKzFO7cy91cTXOJ6u/ny3Y7cOK9PgearnjfAlavLyf4xrt0DXFpGN0RmFSs+7cPrMCVkzl1iFBNOu+onah2i5J6Qkdtgm49Uvyg6R/DCol9rIFYC3S6yZLZTdVBWtp2ngorprGdzcUdzTVu3WpYkKdkfDcnlhU0C12OwmY5hVMLUMJKWut9Ok3hjUDugSBhnuj3Lax7PC6IvTIbz0Uvf5YpFnevZc8FEtWYoARbv1haQY+bY8/rTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSyzbPaACW6CIsGXxGMJ6X9JrVQUdQTd0RugwQLMq38=;
 b=mnUsHlvizm+P78lguVia/XqReoI7ohCSBgYrt7MmL3xEuP6DqvmMXmWX1pT1jsmyc4Jebq9qdJ7DnQt5sORaXbc8IUNat25nQf9V/LHKZxmYAiuniFnDnKeXlBWMr4/9XKVosXZB7r4TYLUO4O2JF5AgYzFdPuONKlUXA1/Y200IQfl+TYp4SyuvM6BykDRij0G/RgOhCblNvyDCbvqiwT82hAcFxmgUwtiHFsWFUirZrj+zSuV/Os7bK6mnZPGt0rDG/lEkaS1dotF7aMx6MQ5MVoKlePC/xO7Z9EdmupmQgYzVbhHpzM6fHHEJQzdQ8FNyylPaaHRUc7vsZOktKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSyzbPaACW6CIsGXxGMJ6X9JrVQUdQTd0RugwQLMq38=;
 b=qCxNK4rOtwDYvrilfGjNagf9p9J49UmgtRTZW8qDoTB7aI74g7k/AJvtIcR0wIMzBWTMmQ0X8te9OvHgYjcpAFhL+UBlG+62k8g/HpQ/33o4DpyWNPeVrOgsRlDCTvFlrJ+jTJ+jw0bi1h/iSDrXLodkR/ezwRiDtl0CWzbZJk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 08:30:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 08:30:00 +0000
Message-ID: <00eda50f-fb2c-419c-9bd3-2fe932cef057@amd.com>
Date: Wed, 15 Jan 2025 13:59:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
 <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
 <CY8PR12MB74358329999D20A4899DA18D851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <fe31a1d4-d137-4d0e-8a63-321a5c365512@amd.com>
 <CY8PR12MB7435DC1509E304F279F6145185182@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435DC1509E304F279F6145185182@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: a180a684-6711-4d29-9c40-08dd353ecd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wkx3YSt6bHNrUkp2VXJqeDZTQmpHQ2lzOVMvMzJZNlZlbGJabDVEaTNtRnAx?=
 =?utf-8?B?bVE1ZWtmYURhd2VGTWhENjhGcldmaVY4R2ZxRWtPVXJVVXMza1RsMzk0bnBX?=
 =?utf-8?B?WDFwZTZ3eUM1QmUzQkZvOUFLcE1PNXhrbW1lc2NvOU5BVVg2a015VUJ2ZEVR?=
 =?utf-8?B?M1pEU2dlRlZubEdzazJFcU1FeG9Uci9JWmFoc1crVHJRQzJvL3U0cUNXcm1U?=
 =?utf-8?B?V0ZVWitjNXpJSW8zQ1NNQTdEMUFFd0EveFRtV3o0S1lQM0dhV3RUZU9NTTVu?=
 =?utf-8?B?d0lBM2xNZnA5RDlSM0F1WjhTUHBsOXhVdFVPUjZMeWtLSWFWU2FHUDI1NnBZ?=
 =?utf-8?B?TWhyK0M1ZWVxclpFNGkzTGY0RjQrM2lZKzhqK1hmRGk2eS90dG5KSlVBUFpD?=
 =?utf-8?B?aXBrWVZYbHVWYXB4c3RNNXNGeDJsZmdRamVaYkpEaEV2UDNNUk51a0VJd2Jk?=
 =?utf-8?B?U2RwVGJNNUVZRlVvUlRjUTNBSktaRVlCdXlQdlp1TGRBS0hLSWFJYzhzRVdm?=
 =?utf-8?B?dms3c09pOTFFd2NSWEg5YjhhRHNUMFVlbTJnWUhBUHlMYkI4Mkd1aWU0cXI4?=
 =?utf-8?B?UVJpUTMzR1A3cHA1NUtod2JLOW9kQkpYTzllVTJNZE5DZ3VmTC91RXRvV2cw?=
 =?utf-8?B?dTVyajU4Vis2MVFWTWMxNDlnM2NhMmI1emltd2N6bXFnUm9rL1ZLTXV1M0JY?=
 =?utf-8?B?ZDE0L203cmtmdWxCbmgxT0w4Y0VlcGFwYkhlcXVFaTF5cTFaUmFpMFFERjhP?=
 =?utf-8?B?a2xvWklWRUtiZ2ZvLzkxU1JmdTNaWU04cU80d0RtWXdNL283Q2pSQWtCQ2ZX?=
 =?utf-8?B?WERCU3FOWGRLdUliSnR6eWNBZFFabFFrREJ4QW40eDRaYWFUbGRIZXd3QkRq?=
 =?utf-8?B?VDJtOXF0bEdVOXdtdDhBNzVFNWl3aUh4ME9yaVNmdjltNUFyV0xZU2s1MnFz?=
 =?utf-8?B?bHd5U1d0YUFVZzB1Q3JaQW8rallVT1V5djhJd1NKaklEakxjWjdzdWR6MFAv?=
 =?utf-8?B?ZUtpVTBqaTRWNWpQckJDOE4vQnYzelNaRVBRTjJxSVNUSjRidlkvTzlBR1FM?=
 =?utf-8?B?TEdra3BCQnVnYm43cE5lTTluTUZzc1B1NUEzeWdWbGptOWMzckNkMUtUbTNp?=
 =?utf-8?B?Tm8xT01jZXVHRElWWmtaeDh6ZTNKbENaR29sd1VJbHJDNzBLZTBWOGJ2Mmd5?=
 =?utf-8?B?NHBSUUQ0NksxTHl2eUQwbm5zWDE2ZWNrUnpLcm5zRUpMeHJzUFlaT1ZHVFJU?=
 =?utf-8?B?emE5RVAxRUsvVHBYOURUTlB6S0tuNFcyK09lZ2pnRUM0L0hROC9pRVNlS3o3?=
 =?utf-8?B?K2wzRkFqd29WcWRhT0FWam5xeWowRkpiL2s5YzIvVmNpRmUzVnV3RWxJQlRP?=
 =?utf-8?B?K3Q1MFc0TDgrN1QyeHdMT1BrUGlWZVc3UmtZdzVzaG5WdTdXek1QN1BVeEkv?=
 =?utf-8?B?Q1NiVlN1VkduYnpTUUJxK2hqbVFKWU1UQVBHeGp1VlNBN1dPeHN1MWNSLzRm?=
 =?utf-8?B?cDRPVWVndmc1S3FRNUM4TmxBazBGQUtFWk1BKzh3QTVBZUkydXBMZm5RQlk0?=
 =?utf-8?B?bmJtUGpxckdsTmRWMXpnb1k1NFJCRHp5ZjRicm03Q1BvRnUzVEFMN00vSXd1?=
 =?utf-8?B?K0pHK0dMRTB4ZVZHNEFQMEJUNk5TdU52MTNNUXl4aVBhUHRYV1pQMnVWaTht?=
 =?utf-8?B?WVcyUVRnaE1xWkI0YUZMOG51WkhXS3Y0WFpOenB0QUNqMCtHZlFnZTlGTXpx?=
 =?utf-8?B?aG1WUll1TWhaTnVzbHFBVXVkRHpQdk9nTk5vRFFJTFRudXRxNXpwNXdGMGdC?=
 =?utf-8?B?TTBUUjNmRXdYUDZ1WDNQdmNQcjhwNTFJODFjY044ZWJ4ZldDTDB1eUorZjVt?=
 =?utf-8?Q?EMtwM1yaE/MiP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21NT0lJM1JFVGtRZkYyYVMvMlg0MzZ5elVScXQ1SDM5WmdvanJJR3pMbTNC?=
 =?utf-8?B?Z0RSUUJ6NHJDSWtXd3BaOHU5blJxSWZkcEpjQWJVcFNyM2J5RGpueHpocTdQ?=
 =?utf-8?B?SFNCMG5BR0w2UFQrVjUzRXJqV0dVVm9iVk1KQldLWmJJRDQrZWQwb0FhRUJS?=
 =?utf-8?B?Y2NwS2FjbGJVMTNTZFN6OFFvM0xqVkp1M1o0ZkNMMGJNWE1uWHVDYVFxWGVR?=
 =?utf-8?B?MXJUOVlZZDV4R0l3L3hRbzlJNzhXbVBpK1pxa0FKZWlHNkF2aXcweDVjZ01E?=
 =?utf-8?B?QnpWak1WNGdwUTNNejNqb3RKR1hPWCszTjVXSGxMYzkxRGhQQ3RNV3ExYXFh?=
 =?utf-8?B?YWdlcGtiaHVNR3pxY2haUHpKTkl5Z1Q4dGJiZDVNcjVid1lsZE5EVXpDK3Iw?=
 =?utf-8?B?VWJxVDhuYzFPOW90MUdrbVRFRVdMQ2RKRUhTNjAzSEpOTzBLbVZFYkxsSFRm?=
 =?utf-8?B?Nk9oK3dEdDBwaTBSeDhkU29zSXZFL1FoSzRyVGhEK0V6K2Y1aW1oazhNaE9u?=
 =?utf-8?B?S0c1ZnlVZElMaDhzWmhqL2VDM0hZUnFIV2w2bWt0N2pJOHZ2bWk0ZjdYNmVT?=
 =?utf-8?B?aXdWcEFvaEFtU2loWlYvcytGVTZGZHdKaXdwbW1GL3dwTVF1elZOcHRSV0lQ?=
 =?utf-8?B?YytXbFc4cHVxRFQvcGszM05DSm12Q0YrOGtiaEZtVHNBVG44VVE2QTJSdHdC?=
 =?utf-8?B?ZENZVU40UnJGVTlWdG5oSnFDOWc5RFhjcVlmMEdqdGcwNjV3SWI5S0tNbVhv?=
 =?utf-8?B?QzRwYmdXRVdadUhaL3FjaUcrTHpKNFBjVzIzRWxsaHRBNjlYYXlmT25OSmxB?=
 =?utf-8?B?VWhZai9nbTUwNVlEZzl4Sm5PTkNrdnY2Y05Uek1ISU9EYnNjay91VmE1SHNE?=
 =?utf-8?B?Y1pyNCtJOTh2akk4dHJtc1YzY2hRQWltOWFOTEhIWDR6bW96WUhWdU9BR1dU?=
 =?utf-8?B?ellpeks2SXoyMGlzZzBSaFhKWmJqMnJON3U5MEtxWTJHUHhFUHk4K2s5M0xV?=
 =?utf-8?B?cUVDMVJ4SXFOMlMzdTVRb3lWT3NFaytYRmkzbUJOc2ZNd0J6WG4zSUJlK2JK?=
 =?utf-8?B?VC9FYXk5NlU3bUo0cURYcVJyT1Z5ZSt4UUVqbHJNNUFiTkY2RnlPUFpKRC9p?=
 =?utf-8?B?dG9ncWdqTllubE9JZUdFYmlXSXE0V3ByOTc1TUJXUXZjKzJabWlWODZiWlpL?=
 =?utf-8?B?WG5nZGFBbEloU05TRzcybzlhd3cyTk9hYk5LOGRYSjVDdXVjWXFYVEd3VzUr?=
 =?utf-8?B?OXZ1NS91ZzFaaVBOV0U1ZldHcDNOYkFJUllZQmhSKyt1MHVhV0dGQXVRU0JT?=
 =?utf-8?B?K3VEeXdZbTF1MDFvVjVhRklTQ2RPeE8vSWNWbS9TNU42K25iblA0NVdrbllX?=
 =?utf-8?B?S0w3THhtdWFmVVNOV2ttZE1obWJDbjN1Q3lVSk0vNmxubGEyMU5iT29Mb0lJ?=
 =?utf-8?B?UnEvbTFyUVg0RzRpY05jdlkyNE05WWJWc1djcFAzajEzOXF4RGM4YVVuZWxS?=
 =?utf-8?B?V1BYT2Y0bHFMSUoxR2plRkRrTURYL3I2R1FsTjZGQ3QwN0ZOQ1NPYnZPQ3JK?=
 =?utf-8?B?YWJQTktOQWRTRGxpSERDZzZ1eE5ZSm1pZitZS3JVd2tscTg5RDdQUkw0RnBN?=
 =?utf-8?B?bDMzZVBTRVlFU3JVMDdIeUVmNmFQVmJoYzZVMG1WKzRXOVRUbTR2M0lZaTZX?=
 =?utf-8?B?UjN3S1IvTXR4YmZaSmtXdFNPSy8vdW50eExHcjliOVlVaGJwS0lJeGYxdzQ5?=
 =?utf-8?B?NTdVM1RTQnJOWlhPamJhd3hQR242V28rVHNxU1ZYTCtGbXBxUTU4TEJjMHE2?=
 =?utf-8?B?YU9rUXNVMHlQRXZqdFlMMExteUx0dk1raUVnMHdKYU9HOEd5eS9RTlJuLzNH?=
 =?utf-8?B?anNFRkNsL1NjbXZ4dHhHRXpQcUQ4RHAzZ092bnFpZFJYVXlGUXhkMDFWN0hF?=
 =?utf-8?B?K0YxbUZIbHZvUEhIZmorelcxLzR1YnR3by91WXp6NTFNQUdObGNjREExdkRi?=
 =?utf-8?B?UzBHTDVJSCtmZXIzZnY1YkhPMjRuS2Q1bTlSc1ZlSHgwbUxaU3hnY3dwMU9R?=
 =?utf-8?B?U0V1dGlNT1VYR0xzeVJXYnpTaWRSMHI5ZGVTZHcyZTZRVUxYS1UvZmNQalRi?=
 =?utf-8?Q?lO/3oXje74l4ma34Gwb95x8qZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a180a684-6711-4d29-9c40-08dd353ecd46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:30:00.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLEbp81NZ2RfWJfbiioQo6pWxCc4Ve070f8n6tzamz0ilYMyoAKcseRP0CEAtVW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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



On 1/14/2025 10:51 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, January 10, 2025 10:37 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>
>>
>>
>> On 1/11/2025 2:53 AM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, January 10, 2025 11:29 AM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>>>
>>>>
>>>>
>>>> On 1/10/2025 9:43 PM, Kim, Jonathan wrote:
>>>>> [Public]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Thursday, January 9, 2025 10:39 PM
>>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue
>> reset
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/9/2025 8:27 PM, Kim, Jonathan wrote:
>>>>>>> [Public]
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>> Sent: Thursday, January 9, 2025 1:14 AM
>>>>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue
>>>> reset
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/9/2025 1:31 AM, Jonathan Kim wrote:
>>>>>>>>> Per queue reset should be bypassed when gpu recovery is disabled
>>>>>>>>> with module parameter.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>>>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>> index cc66ebb7bae1..441568163e20 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>>>> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>>     uint32_t low, high;
>>>>>>>>>     uint64_t queue_addr = 0;
>>>>>>>>>
>>>>>>>>> +   if (!amdgpu_gpu_recovery)
>>>>>>>>> +           return 0;
>>>>>>>>> +
>>>>>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>>>>>
>>>>>>>>> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
>>>>>> amdgpu_device
>>>>>>>> *adev,
>>>>>>>>>     uint32_t low, high, pipe_reset_data = 0;
>>>>>>>>>     uint64_t queue_addr = 0;
>>>>>>>>>
>>>>>>>>> +   if (!amdgpu_gpu_recovery)
>>>>>>>>> +           return 0;
>>>>>>>>> +
>>>>>>>>
>>>>>>>> I think the right place for this check is not inside callback, should be
>>>>>>>> from the place where the callback gets called.
>>>>>>>
>>>>>>> I don't think it really matters.  We're going to have different reset types in the
>>>> future
>>>>>> that my come from different callers.
>>>>>>> It's probably easier to remember to put the bypass where the reset is actually
>>>>>> happening.
>>>>>>>
>>>>>>
>>>>>> If I want to define something like amdgpu_gpu_recovery=2 (don't do queue
>>>>>> reset but perform other resets), then it matters.
>>>>>
>>>>> I don't get why that matters.
>>>>> This callback alone, for example, calls 2 types of resets within itself (queue then
>>>> pipe).
>>>>> If you wanted partial resets between queue and pipe in this case, you'd have to
>>>> branch test within the callback itself.
>>>>> GPU reset bypass checks are invisible to the KFD section of the code as well.
>>>>>
>>>>>>
>>>>>> Since this is a callback, keeping it at the wrapper place may be more
>>>>>> maintainable rather than keeping the check for gfx10/11/12 etc.
>>>>>
>>>>> Maybe not.  MES is preemption checks are not like MEC preemption checks at
>> all.
>>>>> And we probably don't want to jam other future IP resets into a single caller.
>>>>> If you look at the kfd2kgd callbacks, most are pretty much copy and paste from
>> one
>>>> generation to another.
>>>>> I don't see how putting the test in the callback makes it less maintainable.
>>>>>
>>>>
>>>> My thought process was this could be put in - reset_queues_on_hws_hang
>>>> and anything similar handles MES based queue resets. What you are saying
>>>> there won't be anything like reset_queue_by_mes() for MES based resets.
>>>> Is that correct?
>>>
>>> No the opposite.  But now we'd have to remember to put it in 2 places where
>> there's still no visible test for gpu reset bypass in the same file.
>>> SDMA resets are also being implemented and will probably have to be called in
>> different places in the KFD as well.
>>> We can look at consolidating this later as more devices and IPs get done if it
>> makes sense to abstract this stuff.
>>> My point is, the callback does the reset and returns a reset status.
>>> Bypassing by fail return seems easier to remember and leverage.
>>
>> Ok, we have SDMA queue reset called from job timeouts. If it's getting
>> called from KFD too, will look at consolidating that one.
>>
>> BTW, if this is returning a fake success, won't it result in a print
>> like queue reset succeeded which gives the false impression that queue
>> reset happened? Or, should it return a different error code like
>> 'ECANCELED' since operation is intentionally skipped through module param
> 
> Well ... the call is supposed to return an address of which queue got reset where a null return indicates "no queue got reset".

We should also somehow indicate to the user that the queue indeed ran
into a reset situation. Not sure if that is taken care if address is
returned as NULL.

> I'm thinking to make this simpler, maybe we change reset_queues_on_hws into a wrapper that takes in a queue type input (compute, sdma etc) and branches to the right reset call based on input type.
> That way we only need 1 place to do the gpu_recovery enablement check in the KFD, and the KFD has the flexibility to call this wrapper where ever it wants to without having to worry about the module parameter status in the future.

Yes, this was the intention of original comment - to add at caller place
rather than inside callback. It provides a one-place (or fewer places)
control of the usage.

While at it, suggest to use amdgpu_device_should_recover_gpu(). This
will give an info message if recovery is disabled, and we could control
different meanings of this param (Ex: gpu_recovery = 2, avoid sdma queue
reset alone) through the same function.

Thanks,
Lijo

> 
> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>> That being said, putting the test in hqd_get_pq_addr was probably overkill, but I
>> don't think anyone really cares to use it with gpu recovery off on its own at the
>> moment.
>>>
>>> Jon
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Jon
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Jon
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>>>>>
>>>>>>>
>>>>>
>>>
> 

