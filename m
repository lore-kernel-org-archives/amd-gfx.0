Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E87EC1E99
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 11:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58F810E85F;
	Thu,  5 Feb 2026 11:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKPb329F";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D7710E851
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 11:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxMJ+hTQ8kTynoh9hUV0FNy5iIKXiGMwQH57mrEvEFts4mEe6IWKkD3sG/H+y/MYu8iBBxQjV7ihv2aUbun8SAwODAJZ3qYiGx0d5P6sre4RPGAGpN/okEvMQ8Cpk/PRQI02O+WAjG5sR3vwRzdnmBuleikBhdm+9HrSL2ZYh6OiSgM8uxLtWabUQGo7VA3V8SrC+BT6+Pxr4txyZX6jutW2e6kFpSkIjMwi9yf2p5HP6L4y3zfB7LM7xjZ6qcMx4y1eu21Ts5Y2MExZKpVc70hauaJMSv38/w8nLgMeZkyxMcUwFDAzzO9vju4x45mOtPwdPNH+IKlIlA0XBEbK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll9H4LKphMwbpJtmRu5UxtYPWAYOyW8QN6Hi832l60k=;
 b=fA6QLXy3xxEHJ8HaFZS2uDyN19gohbyeh96cuXi08JbeHTi31eh47eVJbZjK87AIUyRz+5Yccd51OTSB4+zkcn0ksFN3WeGihldmnUbY/j7SyXebs60J9EJro3+eFbORpSTYMxPL2W6IhzEwz2o4HsJ8E/huMN2q72u/+A/x5dnHKS8SEiAmrA6x6JQsUu+A/0LHMs1rXeoliYpSekTNW7z1V138/ZtbLXQUr1mNU41xJ2gl7fO/HNvMVvzlzkyRmobag2Btv3A3ltXQE39MEYVGgTmVX/9IXOueTYO6Ezq87fko2rlAfXPNM4QBqczWES+eZnQI4VtDFn3IaMDvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll9H4LKphMwbpJtmRu5UxtYPWAYOyW8QN6Hi832l60k=;
 b=hKPb329FXH4nqTWvjQVM6bBpyFwa7tARYpvSounsTrNSPKnwriljz0Mm0d3wuASKaotdo2LTQYEh41uodJi5vwkFzktsCAorMhwAh/Z9SXge2VlGga1oNocbQ4068CIXjGHnQgDTNoRRjeR9zIeqtbX0h/Nj9hURo2ElxdG8UtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 11:10:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 11:10:24 +0000
Message-ID: <4fa4e722-0775-4cee-8106-2834cea92c50@amd.com>
Date: Thu, 5 Feb 2026 12:10:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu: fix eviction fence and userq manager
 shutdown
To: Alex Deucher <alexdeucher@gmail.com>
Cc: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-5-christian.koenig@amd.com>
 <CADnq5_Nb1JwDtZv=3iZX5dgaCovqOjcOL=qDuTBpVyvR15vyfA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Nb1JwDtZv=3iZX5dgaCovqOjcOL=qDuTBpVyvR15vyfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1fb1ed-9095-4f49-2efb-08de64a72928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0o1a3ZGNmc1NjFweUdDckdQWGNjV1V0aWN1L0dsbFFiRXZaRFNSVGZKQkdx?=
 =?utf-8?B?cmVQYWNKTXJkdVdqR3BGN2RRTXk5WTM1S2oycG5xeTFaY2hueWJRNjFZK0N4?=
 =?utf-8?B?SjBWRGF6K3M2WnhHbG96alVzYzVsQ3JDV3NBdTBHbVZ3Q2t0UCtWRnFoTkZQ?=
 =?utf-8?B?ZkUyV0NXZEhsT1A1bitteEtNL3V4Vk5FZnhFSFoyc0M3cjZ5TjlrNENkRE1R?=
 =?utf-8?B?MUFhT3JVcUVlMkZxbGhRMzZTRzZiYjRSczBNb0lvVFNFOGtncCs1UHN2QmE4?=
 =?utf-8?B?am5USnVIb2UyMFJJL1NRZTUwc1ByKzZNZS9VZklEc1kzTEhsbUVOSjM5OTlq?=
 =?utf-8?B?ODc1NTBNbk9CbC8wMjk3Znl1K255ZDlsd1Y3cThCOUZZVjZnQnRCZkdoVEFI?=
 =?utf-8?B?cjZ4cDJaT0hUQnFjSk9ZYkxQSUlhbUxMQ2VkaTkrZ1M5djFvSGNpUEcyYVZq?=
 =?utf-8?B?aCtmM00xemt4K2ZkNXhWYXdNUlZ0ck5WcFFoTHRNQSt6L0JUMGVWSmFwcDJK?=
 =?utf-8?B?RUNXRTlRUXlwOUdaNFlIa1hZSUJXVGVNekJQQlZMTTc1dmVVckFLNzFrWk43?=
 =?utf-8?B?NWFZdGxBTkhiUkVHOXBQQnFLMXNJS0lGZG5wMVp4dis4RDhVb1NsbjhqcTdD?=
 =?utf-8?B?WXRVVUduNjBjS0loQkhSM2cwOFYveGYxbFVHekwwaHUvWFRjVkpacDVrc0p3?=
 =?utf-8?B?Um04QXEwWmN6NzlWVlVES2h5SDVhaHkwL2hrS2pham9mS2dWTXZESUJpRTlN?=
 =?utf-8?B?VTZoWjIyRTYrbjdkWndZQ25wV2tudmprSFFDejNHcjJXeldwYVNFRWpBREQw?=
 =?utf-8?B?dEhlWWNYM3NuUFVLUVRDR2ZMemd1d05aTk1BeE5wdk8yMnlCdDVOaG5ibmdJ?=
 =?utf-8?B?V20zUkNlbmc3bW0yNVAwcTROdmhtNldoVkdkcEV4Q3hyTTVMYW5TZ3MyS0NO?=
 =?utf-8?B?WmZsSEMrL1QyRVk2c3BkODVCQ2NTRnY5TG9mK2hWOGtPa3NlTksxQkVPc2FW?=
 =?utf-8?B?cGxhYWRYTzBMSnVvVjR6dWN6NTh1ck9qY2ZrNGptbTVQN1VUNmJaVngrTzJP?=
 =?utf-8?B?ZzdFTjFITFhSWVZwV3VSZFRkU0hTQkdCMUZZNDVHZUhnQThOcjRQMHdZRkNF?=
 =?utf-8?B?OThIbnhYNE85UmY4S3pSajJOV1gvMlRzS1hBbTF2N292UGtiZW9KM3A5ODA1?=
 =?utf-8?B?L0pMRWxSOTdGWndoSjVKSjdPc0VZaXEyWWcyck9uaVhVOEZTTDFxQkFSWFdW?=
 =?utf-8?B?OVlnOFkrY0s5WlNmUXVsRHJXSjFRdHhMU292N2V1V1VIWXduNCtjZFl6SVZy?=
 =?utf-8?B?Z3NrajRvZk9sWjFXRkQ0QUU5aThNNUNubnFwTTkvR1pMd2pBNldJcnFEc0VR?=
 =?utf-8?B?QkxYZ0s2NGdXdFpLbEprTkEzc3lERXBmL2JvZFRMUHRrTkNPUVhFeU5ZZkpw?=
 =?utf-8?B?UTl4SjVMMzFsOURORSs4QzkxYTBMbDVsNXgrb1QvME1JdUlGMzhFRWlnNXVN?=
 =?utf-8?B?ck9kcU1oSE1neVZOVWs2cGZrVFMwaUpQZmN5VktENm8xbzd3VW1ma0V3cXN5?=
 =?utf-8?B?NEtmWWtIMzltekRQZ1lId2V5NDB5dG1YcEJWSVNpblN2VXVYZTduUGJPOU5o?=
 =?utf-8?B?dFJraTYvSENDdHlNaWlOMkhtYVNhc08valJET2JvYWt3MHppZlBjVjZlY1Ny?=
 =?utf-8?B?TDA1TThJOEd5OWFKT2hSL1RvQ0tNRzYwUlVncldXR3R0Y3YrcnVVaC8vckhF?=
 =?utf-8?B?dE9EcmRINjBCeUd1a002TWkvTjFHK2Y4SEJCKzNqb2pEc1hXWnZUWHU5UEFO?=
 =?utf-8?B?YTBUaldFZW9GbWVlYkRLMUllUzU0ZndXSUh2Z1hUZVpuSXJhektOWE5mcnBE?=
 =?utf-8?B?aE5rbE54WlhHalBXRmxHUXFYZDYyM3U0RmRVYkNaa0Nac21vYnBoWlJQMmcz?=
 =?utf-8?B?RldJWVd0WWdodmoveVhnQUV2NDFpTlkyME5JamlvT2R5cEpScjRTUXF4QmY5?=
 =?utf-8?B?QVNDRTZWSG05dVA5d2FJQjNKbTNEcTlaUDczZmJjZ2N3SlY2eTY2Q1ZUZVhX?=
 =?utf-8?B?UlQxN3lVVC9BaTFpZklnLytLOHNsb2swQ0luckpGUHhMMDJHaFREbWdnMW9j?=
 =?utf-8?Q?lybQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1R6WXJDK0NwWjZNUUU1cDJEK0RTNUo0TU9rZk54WDVRZUI5NTVoSU1pQmZT?=
 =?utf-8?B?R0FGUFZHV1hldW5OSTRRN1BPc0hGbUF2MC9BSi8yRXI4cHJORzVIZWVHZFVn?=
 =?utf-8?B?WElrRXZGM05WZ2o2MU9iRXZ6SjNuVzg3aVg1ZUsvVUhNLzJHK2dtZ3dtTjF3?=
 =?utf-8?B?d0JVeHlGeG5tOEY2NW1VRVd6UEptRTdha1JPYnVTYlpYREt6eTJoN0FoaGE1?=
 =?utf-8?B?Y1VMRkE5aERjblNPR3plbUpnemY1VFRhNlZUUlRpSS82eURpQTVaMmoxMVNK?=
 =?utf-8?B?eFh1TDVTaXVhWXltS2huRFFNZlVwRU5URFM5aXNIa21KY3A1Rml6NmhCbkxK?=
 =?utf-8?B?dmcvYUpRdXV1S3VhTEw1MTdRYkk0aWJrNGkxc25hRDNGb1FBSzd3Y3J6UFRu?=
 =?utf-8?B?UVJvdFZoVTNBQldreWZJelFiczNjKzlRRFVvL1JRSi9yTTd0R1BZdlc0Q0xo?=
 =?utf-8?B?aUJEdWdwbldYQTJLbjFocG9maU14V0VkOUVsRGZHYytJc3ZFOCs1RVFmempa?=
 =?utf-8?B?ZVhHOTZ5ZzN6V1IybGNvbWVVMldoZmtmV1RjVjRuYnFzMGRaVVkycExleW5Q?=
 =?utf-8?B?Q3E0bXhQeUw2M0hnbnlscURhbk1BOHh6WXQyMnQ0VkpnRjA1SFVxdUQzK25j?=
 =?utf-8?B?ZTBDNHJ1WXpZRUhsWDlMNVgzdGJJb0ZXR2MzaFpveC9ucWR6VzN6TW5NUjZH?=
 =?utf-8?B?ZzJWN21VNWJ3SVMwc2c2RW9VU1Bsd3RTNTB1b2dKNERhcjJFSVRQY2xRUEFY?=
 =?utf-8?B?Q1NsVG1lckc3dWJqRzNRb3dqRGlyNWQ2YTNwRkg1Um1Idzg3MFc1MFRFWFpV?=
 =?utf-8?B?MkQydkFJOVZYdXZZVU9ycEZNMmlyeG5DcGpJQVVLUThkSkJDMktYSzdoRzN4?=
 =?utf-8?B?SXdDTm5UdmNKaVV1SC91akdkc0o3b2tueTZtOXdTV3A3MDgwVjBWcU5FRzl4?=
 =?utf-8?B?d000UUlEQStkWmtUQW4zME5ZWm1leVRROTRGUlBNUHRFd2dSbEFudjFVT1Ay?=
 =?utf-8?B?endxRUUzRHlZVFFVM0syWkdzTm84dlU2ZkhTLzNaQ2lNWHA1a1BXaFFDbG5Z?=
 =?utf-8?B?Y3I5S2xpRkNydmg3OWdjU2M4aXAvdmo1TlNYVDVoRG45YXkzWlFoRmgvb0ds?=
 =?utf-8?B?Tnh5MGxHU3lIR3poY1psR2tPRTB6NmlRdWtlUStyZjBKM0hML2ZoN2MwOVJj?=
 =?utf-8?B?S1B6UVFXM3RUTktDczR0RE9qdVFLYy90ZXV5TlNldVpzNlM5MGZ0RWNneUl3?=
 =?utf-8?B?bG02a3NveW01N0J0VXdSSkpheGZxODErZE9uanBTb21xUVI3cDBJZ1pVdGRl?=
 =?utf-8?B?K2kwam1jeUFKNm1WRDBWcm8vb05nTWFIQUpCNUVXUzdMVzQwUjNSNkhvRzJK?=
 =?utf-8?B?ek9XNEh1eWQ3VW40RW44NXVjeTlvQk9yd1BkYi8yZlNHZzZWdEhVWUtteHVt?=
 =?utf-8?B?amRmOW5WdkNJeE9kbXI1bUFqem1CYzA4aDVzVWVNTzRyNUJMTmxTdHRSUkdR?=
 =?utf-8?B?OGRVYVZFeXVTUFNKeHlYR0xoYlFsV0IwNnc2REJHR0NhemRXeGRkbnFaM2Fy?=
 =?utf-8?B?Yncra1lmcXBUUU80Z1lybGVsUmg1NDUzRUZycGthcTFmUkdKcCtVeFZIUVR3?=
 =?utf-8?B?Nko1b0pua1lKblJvUS81RkZZT0J5YnR6WmtyUWRQbFF1RzUwYjBOSGppSHEw?=
 =?utf-8?B?WEpmMWEvcmFFbkg0U2ZIc1RGM1g2d2l4OUh2TlFGRXNhb2ovSzArYmMwOERZ?=
 =?utf-8?B?OXV6QkNNTmNvUkViTnlmVm5Xa3ZzR2dpM0pqbldMYmNxclMvSXc0dDVKZFAx?=
 =?utf-8?B?NjN5VTV3dWVqZ0tVbUd4VDVjS21xSTQxNVRLQnF3NlN3bGNVVFdJb2NqR01l?=
 =?utf-8?B?Rzl0TWhleThjZjVmT2N6ZmlVYlJMb2w1UHlKdzVvZkdHdlFFRk0za013eUkv?=
 =?utf-8?B?QkhwaUdPZGJJcUYxaW45RmtCVVFQQ2dtbi82ZVNhYU5iSVFMKzU2UGsvUXBU?=
 =?utf-8?B?Z3RlMWRHMnIwN0R1WDY4U0lYQXRKM1dYeG1xRUR1dkZsSG5MSHZYVjA1eVJ5?=
 =?utf-8?B?NjRDSDhuZXh5K0pnOUp0NmlhZmZnc3phcjRDOHVIdFo1WFVFWWpwMDJEU2U2?=
 =?utf-8?B?M3FyeGRXSkE0UVZKMU4yZUcxR0ZUdHpCS29mN1B6ZjcwNjZzOU1ZWjNvbzMv?=
 =?utf-8?B?NTVqZGtod1Z4VlVVMWZsMUxKVEhFb2JodDNieFpPS01mMEdrRXlsUENBU2Z1?=
 =?utf-8?B?b3c4VFluWWpibzBrRmFHSzBvb212bTJ2N0xHMjRBQWtFb2x5SEpXYk52SExF?=
 =?utf-8?Q?fiZs5DW4X9vBnVeboy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1fb1ed-9095-4f49-2efb-08de64a72928
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:10:24.8271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eN6RcB/8glAlSicmO9AB/tY79EktZIxCHr7KAB8dXw37YSlGLKqHweJmR3xYt0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

On 2/2/26 23:37, Alex Deucher wrote:
> On Mon, Feb 2, 2026 at 7:51 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> That is a really complicated dance and wasn't implemented fully correct.
> 
> I'd suggest elaborating on what was wrong with the previous flow.
> It's not entirely clear from the patch.
> 
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 7 +++++--
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
>>  5 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 02abe85624a6..9cd44be45861 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2976,6 +2976,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>
>>         if (fpriv && drm_dev_enter(dev, &idx)) {
>>                 amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>> +               amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
>> +               amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
>>                 amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>                 amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>>                 drm_dev_exit(idx);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 8fe9f91f9551..ef4da6f2e2a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -146,13 +146,19 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>>  void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
>>  {
>>         evf_mgr->shutdown = true;
>> +       /* Make sure that the shutdown is visible to the suspend work */
>>         flush_work(&evf_mgr->suspend_work);
>>  }
>>
>> -void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
>>  {
>>         dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
>>                        false);
>> +       /* Make sure that we are done with the last suspend work */
>>         flush_work(&evf_mgr->suspend_work);
> 
> Is it intended to flush the work here and in amdgpu_evf_mgr_shutdown()?

Yes, we need both. That's why I added the comments to explain why we have each.

Going to improve the commit message.

Christian.

> 
> Alex
> 
>> +}
>> +
>> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>>         dma_fence_put(evf_mgr->ev_fence);
>>  }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> index 527de3a23583..132a13a5dc1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> @@ -66,6 +66,7 @@ void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>>                                  struct amdgpu_bo *bo);
>>  void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>  void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>  void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index e007f10a6c1c..60e8a993557a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1350,13 +1350,16 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>         return 0;
>>  }
>>
>> +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
>> +{
>> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
>> +}
>> +
>>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>  {
>>         struct amdgpu_usermode_queue *queue;
>>         unsigned long queue_id;
>>
>> -       cancel_delayed_work_sync(&userq_mgr->resume_work);
>> -
>>         mutex_lock(&userq_mgr->userq_mutex);
>>         amdgpu_userq_detect_and_reset_queues(userq_mgr);
>>         xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 095c09f3d96c..13f4e356728b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -117,6 +117,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>>                           struct amdgpu_device *adev);
>>
>> +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>>
>>  int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>> --
>> 2.43.0
>>

