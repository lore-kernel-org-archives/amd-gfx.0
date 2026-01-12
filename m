Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6FAC9EC90
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 13:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B3410E0B9;
	Mon, 12 Jan 2026 13:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvsa+qlz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CAF10E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 13:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgCB9HYpdxd47AzI92Aa2AfZB9/hiTcgv5WHMtCBVDLe2jysW1QlcJudFi+/HDMbylmsFYD+1mUSFEQjGQ6b2j+yBeIOrUPuaH8+AjyVElTKhFnxI7Z4E4EZmvudarWG7T2DnUQqtr5LF9xS0f+fOLqBTeBizChf5bj/MIwI69kvr6TyB4sc9QxOXzDp4QqNMJwYSHiWKN7DPEH3K8b7a8lMFIPti4/mY0qfP4eldj+TE9S/kBiocfOaTfNkJuaaNm7OqIuEy4grNcdxqWPJCmD7vmt7q6k5kG3pAZ7WQRXfeqmmbSRs+gS9sLaNu1Ttl7vqMxkd79XhYNRm+paGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8JfZMkpa/lHdj50nQ6xvr4aJLe60EyDFGLJAPWwtVM=;
 b=N39LX3o+pbYP/O9L1xx57n1XYHAShTwwsiymJJbWMWNBym2QXKFXIdP0gBWIWFTkE4VwQ3XrUhxVLmpxJtJ/Db4i+4PVjkj2E/yQlsWjX+0bw+8u8DDBTr7UA26oN6EwxOfPpUvePY0OXKJjwE23zhCa7BpJBuKfRveK4UXlDOK+3I8FF/xgSpsLrL1LAnXoCM0hlX2pG2ut6ecfM6n6ESBHdfi9JSwAXC0accKvbOFgVdiXGEeCswo8WoRMU6/qXBJb3cUDY50FJHtqtIKyp+JE86fl4ZRNeygJEnca/2jsm59nNkIWc3sCc7xfzmvXY5NewcyTzK3wg7z/HgScqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8JfZMkpa/lHdj50nQ6xvr4aJLe60EyDFGLJAPWwtVM=;
 b=rvsa+qlz+Vb8WwJBLOFSt7B3QbLQUZc8KD68JSPpSMdaceBSjA3Xb+4O+I7XJcQpdOprGDT093s1hcuRpPNXSYlBuckX55en6issompr4Hn/YfDgG2FSGV+Q4mFdJQEwMCttEJ3anfH74kQb6wQ8v/HfrB6Fm6NIOZvfXQ0TjLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Mon, 12 Jan
 2026 13:32:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:32:38 +0000
Message-ID: <4a57e7f6-0722-411f-a37f-24d1f5d6f0e8@amd.com>
Date: Mon, 12 Jan 2026 14:32:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] drm/amdgpu: Consolidate ctx put
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
 <20260112102244.63308-9-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260112102244.63308-9-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: f886069e-1eea-46d0-ded2-08de51df0da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cStTWTFkL2M2QVRVQkNmaGNkZEM3Zmxldm1IR0NaUVZ3WGlzeUw1bm9Vem9x?=
 =?utf-8?B?WmJVeTExaGFtRXVCNFVEVE0xMk5CTmw0SEh5SzdWS0J3VWZEaHM1WmY4TWln?=
 =?utf-8?B?cWt2RUpEeDJQU04xbEdsMXpBUG5tOWlHdjBVdXNYenhOK0MzODhENE9OWGxJ?=
 =?utf-8?B?T01WaE8vTW5CenRvZkkrb0tod01ML2k1NXdFellaeElOOE81M1ZtNHloMTZ2?=
 =?utf-8?B?blFlVWNndlA0V2ZRU012dEg5NHhCbGlOdG0zQXFpNFp0Y0M1NmRuOGkxMGFw?=
 =?utf-8?B?TTlzdWdKMkc5YmJkMW55RnhneklNbkdFR0JxL2lzY2JNQU9SZU92VlI0VkhL?=
 =?utf-8?B?TlZKV2tyZFZUcVQ3NFUyU2kvdEoyRjFFRG5KRTFhb0IzYUVJZlhoTnFXb0ww?=
 =?utf-8?B?cU0vM3VXN1M0NGJLM3lwek91QnVlNVp1dFFnUGxhbEpRMlJCZE5KNm1MT0Nz?=
 =?utf-8?B?YnpNUkdlSGJqV3ZtRzV6V3RwN2JYeWJrWW1sQkRiM1N5ZUJQaEYrUDNUVFRs?=
 =?utf-8?B?NTBIR0o3K1FHblI3cTRpbENFNU9EaGMwRlI3WUw1UXoxRmx3TjN2UHF3YlpC?=
 =?utf-8?B?RWQwd2NzNkRQZyt6eDhBY0lpSytqN3ltVUNXMG1mcm5zZmpjZlJER1JsZHRL?=
 =?utf-8?B?a1VnYitONkpBY1puOGZ2OE8zeTA4b3lIUEJjOEdkWVVVZ29ZYmVneFU2dDh4?=
 =?utf-8?B?d2wwQjlzZU5JZk9KamR4b3FhNGJIYzUvcWdvZGZuVHF2ekFVVFJXVzdrTUsy?=
 =?utf-8?B?eDBaU0pJMHdVTExMclhyUWJBek9qVkMyOEE5YzJDa1l2MTVkS0JWd0pQQzA0?=
 =?utf-8?B?ajQyZWRSQUxBR01JMzZDQk1oZVhEdTJBTmNCYWs5R3M1M1B1NGxMc3hDZW00?=
 =?utf-8?B?MU9KenRsOHlBTXNxYzFVWmZJRmpMMFBMRWorNk1GcEFzU2I1b3FKd1lvVkNy?=
 =?utf-8?B?dEM5a3dySFVHZXl5aW5TaU9EOWVsbzRYRVhWTVYyTnMzZStGK09nUWhkWkxm?=
 =?utf-8?B?a3VIN2FLV2ViQktmbkpDUi9PYzV0TlZqNllqa2tOQUtzVnFpUjNTWTZJcldh?=
 =?utf-8?B?UVo5ckJ3aElDMXR4Ti9lM2pBN1YycVVuZzJ3ZFB4UTZUZ0Q4Rkd2SlV6ZVJW?=
 =?utf-8?B?RzJDMGJsQkUwd3ZCWXZNVEtUSHpYRERGTlRnajVnR01SanV5V2FSSkpSYmlN?=
 =?utf-8?B?RnVTVlROZ1o3Nk1UT1NXMjFNL3VDVUpiMS91YlUzVWwzNTNhUVUzUXh4Zy9i?=
 =?utf-8?B?MUJteU9TbVZOekEwa2RmbUtoQW9hTlRDMGNLQ00wejB5TFlGa0kvV1NXdkF6?=
 =?utf-8?B?STgxQWtNM2J0Sm1HcE01WmF2OHVUaHFpQ2tDLzZERGxvSkxBNnd2cmRuRENR?=
 =?utf-8?B?U2FNcGJPam11STR0aGZzL0VBSUV4OTFFR3AvRHc1UjFJTmlJbTMvc3hFR0hq?=
 =?utf-8?B?S1lvSTU1L1MzZlZlU1ZkM2ZUNFFNNnd3TWlnL1VnY092ZHZSRWJlVkxUcU9z?=
 =?utf-8?B?MGt0NnN3ZjVVV2hTZTdnNEp6dm1PTVF1R3NHV1hPSmorS2RFT0NqL09yRmFL?=
 =?utf-8?B?Q1JId2JUdzFDbXpsRjhxVUtWNnJ5MS8xeVIvMTNFQkNmVnFxMzd2NmUzd1gy?=
 =?utf-8?B?Vk1TVWM0UWJmSVgzSnFZc0Q2bkk0TjMrWlU3QTl0Y1dOMlBlL0tQWXgvYk4z?=
 =?utf-8?B?RjBrSkRuYVVMZW9SbmJtL3lHb0w0SzJJeEJDRTVlNUlBdndxd1VXaG8vMzMx?=
 =?utf-8?B?OTFhYzI4YTY2UitrWUJHZjVHaXBOd1lRK3grODFtTXZ2YnZ5cEJoZVR1V0Ru?=
 =?utf-8?B?MGZYMXlDRjFVN3hoRDZwcVZtd0JnVHJ2TDAvU3lXTHRkY0NubExNSlk1R01C?=
 =?utf-8?B?a3QxV0tSTlpTV3MrL1l6bGg0YUV6U2xDQmphMjhrQkhlb25VUk1nQ3FxOU9W?=
 =?utf-8?Q?n0onLZzw66BordNcrzJoywpeM+EzPlju?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFU0Ni9aSFI0Zkd1R0t3RkxXV1EvRGNzMHNhanpOeHZpcFVqV0hzUXJuYVJt?=
 =?utf-8?B?M0pLNkg5bGxlZGVFVW5QQ3FjQ0ZSQjl6VjNsZ0ViRHo5WElCRlNOQldFQ0tj?=
 =?utf-8?B?MEt0YXZQTWZWQ1FBbTNSek1ydDFiQXNnRTZIN0FtNXJtSVoxS3JUMXo1aVdB?=
 =?utf-8?B?WVN0bFczNVFNWFMxRXE0Qkt1dXNmOTFhbVJTVkNyS2NKazUrUGtEUllHSXBP?=
 =?utf-8?B?WVZRUEtJeDVJTDJZMjdUVmY4QVF0QXA2RElqV2Nwb1hqS0JDNGVqdm9WUmE3?=
 =?utf-8?B?dytJckk3Rk44bzFnTVNkYmVuaFNyYVJLYnZqNk1qL2djekxRK09KTXBrVGZv?=
 =?utf-8?B?Y2NoTTlnZnUwSFB2eFJ2dXNUWkJxMVA5Z0FlRGhCRmxlZkZCOGVZN0VtUkNn?=
 =?utf-8?B?akxRYytqeUNGeDl5S0toMlMxT1RUVXJwaEF1T09wakU5aXUwY3pkTEpBRkZG?=
 =?utf-8?B?dzE5dVpGL0VSa3BIeXdudlJ2eUVBNFFINzhSVGxjL1hTMTBpRTFRQjc4Sy9U?=
 =?utf-8?B?OWtqdHZWblFXVkZSMmFWLzF0Y0FiK1Q1NUZWVlgvUXVmaGJWQzVnV0huRmNl?=
 =?utf-8?B?ZkdwaTZ6S2tpV2JiN2Q5ckRZT1J3RHJwM2xOVmdwb242RDQrQ2FtOW1RWHBv?=
 =?utf-8?B?SWkwODkxTk1IZmJoRDdRa1QrUy9SZnQ5VE9EU2J6enJzVHZuQnI1dVVqYUsz?=
 =?utf-8?B?OCsybThhUnM0T0pSb1k5RVpmcE9wbEFBTTRNd1d4MzBvYUFmN1JvZk9DUmhS?=
 =?utf-8?B?MXlnQWs2S1cwZFN2NVRuSXUwak1KUWdHMUdWdkZUbTFqbGpaWW9nbHRpemxU?=
 =?utf-8?B?MkovRVEwNUVPalRGWVNOVE9oaGl2cWZkdklqR2syWHVnK1VEelUyWVIvSDhL?=
 =?utf-8?B?d2FoVklXSEpoekdPYnVYU01ydTUxMThXMDZLMk92M1RmNmhrRzh2U1UweHo1?=
 =?utf-8?B?bzdoOEZXV3RZc1Zya2pMODZtNUpyRVp1aW8yYnZJYmJ3TkRGeFl4NlBhSm5H?=
 =?utf-8?B?dHFEdVc0UVZCRmZ2NVl5bTArN3kxMXFKTWNWOW1OOWZ2SGRzM0tLV2NYTTc5?=
 =?utf-8?B?aWxpcS9zdjM0ZXA1V2lSR2gxWkpTVWg1b2IzUXZGQkxpcmYzU0tmc3lKZVBy?=
 =?utf-8?B?dmI5MEMyTHJzM2VDMVMyNDh2OGJOUDRpQnlPaktjUCtjSEpQeWV4aW5ZUktq?=
 =?utf-8?B?MENEV1RSb0FnenBZL1lJSHRwOEM3U2pCRzUrcVpYbzRQd2RsS1Zpc0NlVkQ0?=
 =?utf-8?B?RW9XcXBLZjZMNGdqeE45YXBLRzdDSStOSXNReTBqWldaM3pFYmFwVlJFV1lN?=
 =?utf-8?B?REc0R0toWkwzQzliRlNtN2NhSFpoMHF1dHRtcG44bFJwQ2t0SXV3QmpDMzJO?=
 =?utf-8?B?cmxIL1YwN255UmhvclZqR0JoK01RWFUvck9qc0FuK1o0dWZITnhlRUFkejlL?=
 =?utf-8?B?TC9HME5PMWdIQ1hiV2VGdEpvYWtwd3pQVkF0LzFvNlNQcGROSytKZTRMcGFJ?=
 =?utf-8?B?cm0vMThCcHpUUzd6NzRxMzM5NTBEQ2Q1REZtY3JQZW8rMWtuc2syUWlSTUVF?=
 =?utf-8?B?QndmeER5ZHAxcFAvYmE0eTNxSlhMQXppTGNLdDNQU0JINjJyTXNsWkFPUnk3?=
 =?utf-8?B?YUdicXpRN3JZREZ3S3RuKy9CRW1Oa0ptell3azBFc3BJMjZOU2llbjQ4dWpn?=
 =?utf-8?B?czhpcEpvU1ZwcFI0Y05hVFZXWnZRRFJJbXFzWkl1TFFzaEdiMlJocko2eXdo?=
 =?utf-8?B?RnFKWEFpZyt0bC9sZktSd3l0ZCtHdGwxUVhzbU1qcGZkMVNxbmNWN1hsZG9U?=
 =?utf-8?B?Y0JLYkk0SVowUGlNUlFzQ1BGWXBQTk5TSTBySXZ4cnVxb1d5VWs1cDNIY1kv?=
 =?utf-8?B?N3doeG9XWWRwa3FDZWV4Sno1U2JSUkdPSjJ4Ly9QOHJ3SDVOTGdqU3pTVXEz?=
 =?utf-8?B?azlyR2Q5czlYUjNzOG0wZ2YxZTkxQmlkYVE1dlRXbU55NjJ0VnJhVVduSWhN?=
 =?utf-8?B?MzZQOVJZZnNxbTlRTm1EN2dhK0ZVM1NHK0VQdEFCTDJKU2pXWG1RMEVqUmJV?=
 =?utf-8?B?aGJKbzZJMGtCcWFIN0wxZVpCQm1pQ1Fjd3pOdnVnbTlqUnVTdEJDcnV0QVdr?=
 =?utf-8?B?ZFVCeXhzNVA2dWpjV0pid1cxbnJSRXNGSzdxY1ZOczQycXQzNW42RkF3WGwx?=
 =?utf-8?B?TGlGMU54TldCSDZRTGN2d0RkeEFXbkI5dVlFNmpZdlV6UnVLcHI3N1RtTGd6?=
 =?utf-8?B?OXFSbnZjRlptRnBwYTlGRTZGVTFZYUcydHo1Z29QbnAwY2VoMHN0R0pyMVQx?=
 =?utf-8?Q?I9QOKqlnoBdHt4GV1z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f886069e-1eea-46d0-ded2-08de51df0da5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:32:38.3162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv96tUrRc3ru0d5s6QW6I5+qbcPNwxNysXlj81duVwIKx7eZBWeEuE5M1xdERK1k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

On 1/12/26 11:22, Tvrtko Ursulin wrote:
> Currently there are two flavours of the context reference count
> destructor:
> 
>  - amdgpu_ctx_do_release(), used from kref_put from places where the code
>    thinks context may have been used, or is in active use, and;
>  - amdgpu_ctx_fini(), used when code is sure context entities have already
>    been idled.
> 
> Since amdgpu_ctx_do_release() calls amdgpu_ctx_fini() after having idled
> and destroyed the scheduler entities, we can consolidate the two into a
> single function.
> 
> Functional difference is that now drm_sched_entity_destroy() is called on
> context manager shutdown (file close), where previously it was
> drm_sched_entity_fini(). But the former is a superset of the latter, and
> during file close the flush method is also called, which calls
> drm_sched_entity_flush(), which is also called by
> drm_sched_entity_destroy(). And as it is safe to attempt to flush a never
> used entity, or flush it twice, there is actually no functional change.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Looks like this was the last patch to review. I will pick up the set and try to push it to amd-staging-drm-next.

Regards,
Christian.

> ---
> v2:
>  * Use separate variable for drm_dev_enter for readability.
> 
> v3:
>  * Keep amdgpu_ctx_fini_entity as a separate function.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 54 ++++---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  9 ++++-
>  2 files changed, 15 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 325833ed2571..cc69ad0f03d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -284,6 +284,8 @@ static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
>  	if (!entity)
>  		return res;
>  
> +	drm_sched_entity_destroy(&entity->entity);
> +
>  	for (i = 0; i < amdgpu_sched_jobs; ++i) {
>  		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
>  		dma_fence_put(entity->fences[i]);
> @@ -409,7 +411,7 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>  	return r;
>  }
>  
> -static void amdgpu_ctx_fini(struct kref *ref)
> +void amdgpu_ctx_fini(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
>  	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
> @@ -508,24 +510,6 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> -static void amdgpu_ctx_do_release(struct kref *ref)
> -{
> -	struct amdgpu_ctx *ctx;
> -	u32 i, j;
> -
> -	ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			if (!ctx->entities[i][j])
> -				continue;
> -
> -			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
> -		}
> -	}
> -
> -	amdgpu_ctx_fini(ref);
> -}
> -
>  static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  {
>  	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> @@ -533,8 +517,7 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  
>  	mutex_lock(&mgr->lock);
>  	ctx = idr_remove(&mgr->ctx_handles, id);
> -	if (ctx)
> -		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> +	amdgpu_ctx_put(ctx);
>  	mutex_unlock(&mgr->lock);
>  	return ctx ? 0 : -EINVAL;
>  }
> @@ -750,15 +733,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>  	return ctx;
>  }
>  
> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
> -{
> -	if (ctx == NULL)
> -		return -EINVAL;
> -
> -	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> -	return 0;
> -}
> -
>  uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>  			      struct drm_sched_entity *entity,
>  			      struct dma_fence *fence)
> @@ -927,29 +901,15 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id, i, j;
> +	uint32_t id;
>  
> -	idp = &mgr->ctx_handles;
> -
> -	idr_for_each_entry(idp, ctx, id) {
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>  		if (kref_read(&ctx->refcount) != 1) {
>  			DRM_ERROR("ctx %p is still alive\n", ctx);
>  			continue;
>  		}
>  
> -		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -				struct drm_sched_entity *entity;
> -
> -				if (!ctx->entities[i][j])
> -					continue;
> -
> -				entity = &ctx->entities[i][j]->entity;
> -				drm_sched_entity_fini(entity);
> -			}
> -		}
> -		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +		amdgpu_ctx_put(ctx);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index cf8d700a22fe..b1fa7fe74569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -70,7 +70,14 @@ struct amdgpu_ctx_mgr {
>  extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
>  
>  struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id);
> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
> +
> +void amdgpu_ctx_fini(struct kref *kref);
> +
> +static inline void amdgpu_ctx_put(struct amdgpu_ctx *ctx)
> +{
> +	if (ctx)
> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +}
>  
>  int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>  			  u32 ring, struct drm_sched_entity **entity);

