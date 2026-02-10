Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C87EA811A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 14:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F8010E58E;
	Tue, 10 Feb 2026 14:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xqbc9s0X";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD4110E58E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 14:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B786nRA11hgLPDiCe1FER6Jvb1h3kL/xVIUoLExu+wuqGa5BgVP+tImFbsiK/RVMwIhct4AUKq21xrbmlzwf2Ddn8JrLWUMKRKSfLHdzDLrl0V2HiyEz4Rp2kn6UCV4PkAhJOX3Ybdo0jaRsMhoZ5nyoatG5lH03kemfhnWGWbPlfSuFRVGgs8UJN18QUztuivYO2FhFRwKTLz/fjQ2CeZlKQcvRdtr2kzHWIIkbWBdz019HEmy+UGw83FFLTmiCYuDxLR4uaTQOGDw2T7MwQ1X8DQgWfW5tIMFKSZSImS8/yiUdoiww1JAslB9JwP0Z1O1yjbGHkVg182EAO0A+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/aalmQaDcSsFSm2ysSJ2DfleUC+/CyhpBx+lFgn6tE=;
 b=uJFafloOdav+lcuBK900S2jGYUw5TAlL+eK7gV7Vhs76HwFPY+XlPBP1QUd9rhd+w0YPWQy1Xb0ZI7Y1+Ct6bc71WAymTH4ZPZA0qh30bhG7gd/SwRjWOGAooZkbMLm0LGAyGD3VBn4knH2Sw3DBErrMsSiLXTDR4CD15VMHj0C51kMJAYbrx8cZZZ9/4O6C7uhiFmeCMmKGaTbACkSgCEFK/mCtYegYtvpyB9vZWNw3tVTQEE1Ncrj4Vg/xtM3EF1WJaw7DNyDiSEs5KW7KNVdrmpkZ8pIk5R/k9/sB3AGRiwCxwjFZNZm9VjWz/SG9G/4Jd1GVYeXiQAPNbDUOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/aalmQaDcSsFSm2ysSJ2DfleUC+/CyhpBx+lFgn6tE=;
 b=Xqbc9s0XkJ/Glzup2E1ORG7csvhHPaN+zlYFduplablNtE9AEYNpIvstQUekwJNyLnUBj7uTD4seCAcbb0Bnv+G2Db1zTzENE8rkprgVRwK9Sez6QjQyN0RgVas47jcZHCxA5TdK1h+X4IjSJoiT61Z4RGZ6ZbTdi209i/eqUsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:00:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:00:27 +0000
Message-ID: <71f6dc98-fed2-48f0-80b5-d455bd3d7d3c@amd.com>
Date: Tue, 10 Feb 2026 15:00:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu: lock both VM and BO in
 amdgpu_gem_object_open
To: "Khatri, Sunil" <sukhatri@amd.com>, tursulin@ursulin.net,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <7b1af6c8-bf43-42e9-8ca5-37a12927dc18@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7b1af6c8-bf43-42e9-8ca5-37a12927dc18@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:408:f9::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b132a0-a849-46b0-61f9-08de68acbe33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGxndzBhRjlscWxrWG16MzYxclIwdnVQTUl0WTBsQm1KdWROMlBxRmtzTmxw?=
 =?utf-8?B?cllQb1VxcVNQa1NaUVVGcitIbzhCL1d6ZE5yT0FjTGM2ekNDaUloY3dwNG81?=
 =?utf-8?B?bU1ESGFweXBqajZaMmVYdnpSTGgyVnVHWXh3VEtxazN5YVQzWkgvNUFoM1l6?=
 =?utf-8?B?a01OSFJJeFhzd0RNNG1ETFFzK1E2UGlUemtBUlRQWVhQbGVvR3dBNDAzTWhE?=
 =?utf-8?B?clNrYVY3V0NnZ1pOcVI3bEhjOU9qY3J3SVhxdllSQ3Q3SVZ3YnVvSW1QTDhh?=
 =?utf-8?B?M254QzZ5akVLbnRVZDlqaFBhZ0xZRWNRMytuRnFBRk9IZEtEWStXMGVBenJO?=
 =?utf-8?B?ZnlyUWxySDAyQ1RMN1VyOVdDUld6MXpwRjZWMnNBMjkrRnJKVnZHUkRBTk15?=
 =?utf-8?B?VEdJYWFWQVlzS1RlbWQ0cWE4alBPbEErUWNVNG03YmgyeFNkWkdtbE8xeis1?=
 =?utf-8?B?WnpyZkh5WmtGRWJnZzZsMk05TG5ZV0ZUUTlyQ3ZmNHF2STRHZG8vNHZuOTBn?=
 =?utf-8?B?dlVoa3JRdTU1cUhQenUvL1NuTFpha1psSDlqSEI2YTRmQUdyK2thWEIvSllh?=
 =?utf-8?B?RWFwRXJQd1h4WE5PaWxzNDlaTG56QzJvbUN5aDVVQWVaMDhDU3MyMlpEeUhV?=
 =?utf-8?B?NzhIeXZYckNhZGxSS1RybjlxZXpaNzRMUkJHd1R0WTloUVJ4aDBnNGVwUXZa?=
 =?utf-8?B?YmJZYkNob2tEa0lqMitNSXZYaUFjSWRIZjdYSEV4Vlg2ZlBKek4wRDhFNzRQ?=
 =?utf-8?B?Q3dEQWJaYjlTK2g1ZXoxa2RXVmZsTzAxYjVTb1FmN2hjWFZHYkVFWXNYUXJT?=
 =?utf-8?B?RWlKUVR5Tis1OTdMSnQ5SUxxL0E0d1BUcW9IUGRuVXpQOU9MT053Rmk4dG5S?=
 =?utf-8?B?MjBxejZtNTRLdll0TVVpWi9MMmt3RVBCMHQzU0hSdjUyenIwdkdMeEFTSi9D?=
 =?utf-8?B?YytTcDBHTjl4ZVBxc3ZCZkVJNE5OemN2dWhmYXJpNXBoMm5TNnU0MHJhQk91?=
 =?utf-8?B?MHdxYnZkR1IzMDVhcEFxZllGZlJJS1UvTDRUTnhUamc4c0JHZGZ1dm1mQXk1?=
 =?utf-8?B?aGVEcllpUTc2ck5rQkN0RzRuS2xFSXdHcUowcUxBZHRpUlE5NGViYmNaK2Nn?=
 =?utf-8?B?aWRpclZoMk5EeDN5T3V6MDNZU3BMQ25DTUZHMyt4eTJZMlYwN0V2SCtlWkND?=
 =?utf-8?B?UGhoZnpzazRyRGZuOUw3K3Y0TzdTNUlNaUs1TnRrbVZXRWJ4U1BTMndtOEZC?=
 =?utf-8?B?dGV2NW85MVhwWFNhMmt5amZwclhUc2xDMWlidVQ1RGs1WWJIcTNTKzNDdVdp?=
 =?utf-8?B?OGoyS1N4QjdxeHJ4SFd5dE0xTEtaYzcwSndsQ00vMkxkYTdmK29FVzRiczNZ?=
 =?utf-8?B?MW9rSVdSaTQ0U0JYYm0rVDgxU1JXVFBRZ0E0M1hMOTZQMHZ0MEd6T1ZuMHpv?=
 =?utf-8?B?NFdZcGsxWHFSN3hrcHZuNWxUQzA2VG9CZ1l6aktKOE13QW1DbGx0NDhkOGpY?=
 =?utf-8?B?a0NZYUF0bWJXaHdRQzF2Ykw4eFVNNWpTLzhmbFRabWdJYnlvSExPSzVTd3Fh?=
 =?utf-8?B?aHRnMEtGeC9LMDhOTWtoaFBLc0g4VDBPTndGQVpDaGFLcklBb1ZqdTFvWEY0?=
 =?utf-8?B?aXA0dncxSG1yaSs5UXZiY0pxK0JXMy9GWjBjR0sxUEQ5dW9qa1dOWGRsNjJx?=
 =?utf-8?B?NXRaNGJPcVNzTXlZQUE5UVo5Vlh3cEtTMGdKMCtrb3o2cmFwdkVwOEpKU29J?=
 =?utf-8?B?amt1MnZHS3lEVG1qT0F2T0p4bXZNT2x0dldhNS9aSmlQZk5Pdk5hVW1pV0tY?=
 =?utf-8?B?dSs1citxdHY3SC9TUlNuMVZJOXZacWJaK1hDM25EVm5LQjBiRmhYYkFJZ1JQ?=
 =?utf-8?B?ZGFZcVJnZmRZMDBra010NnhCVGMyNmd4OVY1cXlPTXlMeExsbVhmY043WFhC?=
 =?utf-8?B?Z2Z6ejg2bU5nckFNL1hrZVgzNlRZOWhveW55a0R4STMvTHUweW9BTUtNVEVW?=
 =?utf-8?B?WnZyYy9QMXVVbWxhQXVnTXRWQnd6MWlVOUZGZzZEZkxjMUhmdDNReDhsYXI1?=
 =?utf-8?B?Uk9OMWRkRmtiQ1hiM0lZUTNrT1NhbTNDa2IvbDJGeWdmdEtHQTNqVmVUcm14?=
 =?utf-8?Q?1zcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzI3eVRhM0dLSVIzME45aTRYOUpFcVZhb0pONVFGQUFJRVBVQUh2ZUNZcWh3?=
 =?utf-8?B?RFZGZm13UDMwZHhwcVhQcUFjOHpJT0tTVzE5SXR2Ynljb0VCclpDUFZYdmZa?=
 =?utf-8?B?dXBhTUpvbWJNbEptc09EQ2pTRTI4ZjBjM0xEUFk0M1FvbHV1RWgvU2ppSm9z?=
 =?utf-8?B?bVYySXRaazBGUnFzVnVNKzNqTExtUEorSlI3RkU2aW50NjVrd0xMQ093Y3d5?=
 =?utf-8?B?cFBGOTNid3QxNGFrZERQbTlvNXBpMkxXcS8vZGxHREh5YzdhQWpqZVVzeitO?=
 =?utf-8?B?TFFveVRrWGZwb2N0UEtteXVmVzBsWS8xT2hsbURBTHR6Mk1zdEFYQ2dCb1do?=
 =?utf-8?B?djhtQ2lUQkx3RTFidEIrelA0Q1EvK3YvQjRPcU9qWEhpQmt2Y0pVNFlNSXR2?=
 =?utf-8?B?aGV4cjdJaHROYU1HSnFNV1g1K3lzbUwza1dpTnZlZUlFSzU1Qit1emZ6dC93?=
 =?utf-8?B?RkhsbjNTK0xJaEZwVVJjY0NHZDBDWnBwV3k2eXk1YjNJMjhzVU9QVVp3TmNE?=
 =?utf-8?B?OS82d2pUMGhFQyt3L2g0RTVBS3JNUW5zYUFwSjJzWlFweXRkZEpyQitBTEhK?=
 =?utf-8?B?SDVzbWtEU0VnK21IY1YxOGtUUXZtaG8veE1LZFpPWElhSUdmWUxhN0ttVTdC?=
 =?utf-8?B?cFZUcWR4dUZncTZxVDI4TEM1TzRueXFpblNsakdaU1VUb3RKaGR4UGd3SFR6?=
 =?utf-8?B?WEVJRytvbHVTU1JrcEpGOEFFSFlXemMzVlUxTThHTzJyK0ZoMDRtdXZmNTVo?=
 =?utf-8?B?dUVzMUExS0FMN0NZOGJYTm9HUUpOMkQxNkZVVDFzM29yRkVCdkN4dm1tbWRs?=
 =?utf-8?B?dWgxN3NJMUpGZi8vazBobWE3SXRzRXk2M1lUS3dsNENUWTc1aE9leFIwWHk4?=
 =?utf-8?B?ME9hUXJaM3lSV2xuYnF6Rnd0NXhOVGg1cTVxRW9UY3I4bG8raXdQMFNCb3o0?=
 =?utf-8?B?UmxIVisyM2JSTjgvUHN2Z1pZT09UZnMvVXpDejAwZS9tbEtxbG5MMDdXeTZG?=
 =?utf-8?B?QUtwcWMzOHF3aWlReXhPZURkQkQxRWllY3RZaWkwZjlrbXplTDJLSlhndTRp?=
 =?utf-8?B?OHU4MlI0cXRWTnRRaDFBZ0Z4OEVJRktkeks4YVJsWXhuNjVReHNwR1BiMmVa?=
 =?utf-8?B?RVEwUCtnblBMQlNKNlZoeGg3aFh2L0NpRVdNTngwOVRTT3dNd3JjQnprUy9I?=
 =?utf-8?B?emVOV01aaTh0b3Vmc1VDTGRCQ1k0N1FPMFFrbnlOc1E0NWRzYlB0czRLcDdp?=
 =?utf-8?B?Qm1DeWVVWTZoNXJVamN1aHF2OUFkUVFCRGI0QWhUZktyUUpNSDhIUW4vQ1JE?=
 =?utf-8?B?VHlMSWtsb3dJMDl6TU9TZ0RSY1FRaVM4aURRa2tUWGJJV29pYkF3dlVWamov?=
 =?utf-8?B?OTV1T0s2T3Z0R2VvRTdxSjJZZjY0NC82T1RSMmRhZ1ZyeDlRZDVCQkZobEti?=
 =?utf-8?B?QmlsT0F6aDN2dWg1VnpYM1JLN1I3VWNIWmVNU2t6NzQ3ME53RThuRExqaUZ5?=
 =?utf-8?B?VWlUOW9NeDh2WjZmV3N0bHFuT0F5L05wMEdXOVhoZjNzWU5BOXovd0hNZ0pB?=
 =?utf-8?B?VEJNZ0UxSllNL1BKby90eE9lNU03bXEwTGlsQ0hJM0hKNmhacEwrTlhkWkhn?=
 =?utf-8?B?T24waGJsbWdKTkNmK2J6WHp5WlU5dzRZREcybWhidnlkTjR2L1BXT1ZzZzFE?=
 =?utf-8?B?QXhjT1NoYVlId2VObEVVdEZESFRpMlllMlpaQ0l5eHdyWCs1NUN2ckFPZUxN?=
 =?utf-8?B?ZVNFRzk4L0lta2RlbVN3Y1dHM3ZYbG42T1MzckRjZTQwRy84aDVFbEFjMDVL?=
 =?utf-8?B?MTlpV0VUd05JK1hod05WV3N5b1ZodWJNTU4zOTFEM1ZhZ3VUNE9GdXl4QjNL?=
 =?utf-8?B?Qm1FY25VbnN1dlJtQ2tUYmxNZmgyaUxFZldOQW1DMUxuTER6NXVoZ2hvVXYz?=
 =?utf-8?B?REhzbGdLRTZaOXBJbWwwVTJDNUdnRUQ5bEZ6Z2E2ZDdEckhFeGFsNStFUWpW?=
 =?utf-8?B?eWpsR0pSUzBKK2E2Zmt3YVhqdHZqODFEYldlWUowTjB1Q1F5SWVqTUE1K0pD?=
 =?utf-8?B?ZXhtd0h4cWpodVZ6a1JxTUJERFNvU1M4RDhyNC9hRURZbDgyV0l0WnlFK29M?=
 =?utf-8?B?ZHU4Vzhjdk1qUDJLelpvRFNaR1FoRFZEa3Irbm04NENIVzZsTC9hUHQ2cHBa?=
 =?utf-8?B?V0dqN2lWSlByNGpyVThtNzlDdm8vNXZIMFljSVRsU2kvd3g5NHNPWUdsdWNx?=
 =?utf-8?B?NFJGTWp2dmtHYytodTJ3RXVPMG9vUmJhV0QxajJ6ZkNKTnJOWWRHZnZ1Z2pz?=
 =?utf-8?Q?Ghq5lrZTSmNsKkZ/oR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b132a0-a849-46b0-61f9-08de68acbe33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:00:27.0263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAyaUPXPTfUQ1k8r7zHmL4LLMu8MTRFW9u4gT9NtUHtb/RfZ29uPX6utDP4eJQD7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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

On 2/6/26 11:21, Khatri, Sunil wrote:
> 
> On 02-02-2026 06:21 pm, Christian König wrote:
>> The VM was not locked in the past since we initially only cleared the
>> linked list element and not added it to any VM state.
>>
>> But this has changed quite some time ago, we just never realized this
>> problem because the VM state lock was masking it.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 22 ++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 ++
>>   4 files changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 768998c82b43..ec5130497743 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -878,6 +878,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>>       struct amdgpu_bo *bo[2] = {NULL, NULL};
>>       struct amdgpu_bo_va *bo_va;
>>       bool same_hive = false;
>> +    struct drm_exec exec;
>>       int i, ret;
>>         if (!va) {
>> @@ -958,19 +959,25 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>>               goto unwind;
>>           }
>>   -        /* Add BO to VM internal data structures */
>> -        ret = amdgpu_bo_reserve(bo[i], false);
>> -        if (ret) {
>> -            pr_debug("Unable to reserve BO during memory attach");
>> -            goto unwind;
>> +        drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +        drm_exec_until_all_locked(&exec) {
>> +            ret = amdgpu_vm_lock_pd(vm, &exec, 0);
>> +            drm_exec_retry_on_contention(&exec);
>> +            if (unlikely(ret))
>> +                goto unwind;
>> +            ret = drm_exec_lock_obj(&exec, &bo[i]->tbo.base);
>> +            drm_exec_retry_on_contention(&exec);
>> +            if (unlikely(ret))
>> +                goto unwind;
>>           }
>> +
>>           bo_va = amdgpu_vm_bo_find(vm, bo[i]);
>>           if (!bo_va)
>>               bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
>>           else
>>               ++bo_va->ref_count;
>>           attachment[i]->bo_va = bo_va;
>> -        amdgpu_bo_unreserve(bo[i]);
>> +        drm_exec_fini(&exec);
>>           if (unlikely(!attachment[i]->bo_va)) {
>>               ret = -ENOMEM;
>>               pr_err("Failed to add BO object to VM. ret == %d\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 5f9fa2140f09..5c90de58cc28 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -232,6 +232,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>       struct amdgpu_vm *vm = &fpriv->vm;
>>       struct amdgpu_bo_va *bo_va;
>>       struct mm_struct *mm;
>> +    struct drm_exec exec;
>>       int r;
>>         mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
>> @@ -242,9 +243,18 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>           !amdgpu_vm_is_bo_always_valid(vm, abo))
>>           return -EPERM;
>>   -    r = amdgpu_bo_reserve(abo, false);
>> -    if (r)
>> -        return r;
>> +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        r = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(r))
>> +            goto out_unlock;
>> +
>> +        r = amdgpu_vm_lock_pd(vm, &exec, 0);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(r))
>> +            goto out_unlock;
>> +    }
>>         amdgpu_vm_bo_update_shared(abo);
>>       bo_va = amdgpu_vm_bo_find(vm, abo);
>> @@ -260,8 +270,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>           amdgpu_bo_unreserve(abo);
>>           return r;
>>       }
>> -
>> -    amdgpu_bo_unreserve(abo);
>> +    drm_exec_fini(&exec);
>>         /* Validate and add eviction fence to DMABuf imports with dynamic
>>        * attachment in compute VMs. Re-validation will be done by
>> @@ -294,7 +303,10 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>           }
>>       }
>>       mutex_unlock(&vm->process_info->lock);
>> +    return r;
>>   +out_unlock:
>> +    drm_exec_fini(&exec);
>>       return r;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 1878e0faa722..f69332eed051 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1445,6 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>   {
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>       struct amdgpu_fpriv *fpriv;
>> +    struct drm_exec exec;
>>       int r, pasid;
>>         /* Ensure IB tests are run on ring */
>> @@ -1484,7 +1485,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>       if (r)
>>           goto error_pasid;
>>   +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> Do we really need to do this here? We are in the process of creating a new VM and new PD so at this time, no one would be able to use the VM and PD till it returns from the function.
> 
> Looking at it with that understanding it feels we should be fine without locking the pd here

The PD is already on TTM BO eviction list at that point and might be locked concurrently.

So yes, we absolutely need that.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(r))
>> +            goto error_vm;
>> +    }
>> +
>>       fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
>> +    drm_exec_fini(&exec);
>>       if (!fpriv->prt_va) {
>>           r = -ENOMEM;
>>           goto error_vm;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 6a2ea200d90c..b4bf1b7c214f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1735,6 +1735,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>>   {
>>       struct amdgpu_bo_va *bo_va;
>>   +    amdgpu_vm_assert_locked(vm);
>> +
>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>       if (bo_va == NULL) {
>>           return NULL;

