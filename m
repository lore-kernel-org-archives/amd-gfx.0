Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D4C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 06:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345F110E598;
	Tue, 12 Aug 2025 06:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hK4t/rko";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6563410E597
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 06:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXbv/RNxeuoiSIXUd30eOyr51fePyPAodIzW1M4Rs548BbrI420STRLM9GAgMa6tY/wiRKM8h1nstwOgoL5Ewj8LEShfayzaFFqdC7I7v3JadKOyCPyJQA7uaZqzqy8kx+vA1LzJss6Bqg2v2bnsMxmNhtAndz2ZECrvTdJV67dq8ycuB6IE5rCQAVHY4HtL1cMej7eb91rVpdrAkt8jpBqHbrr+ETQ1PGW7DwNX5uaRb44l4rqgyWYfyWsKWCW59xdXynlxxOWu35A9Do8LmVRhekdmKc1i1RG9MIr1eMVNuey2RZ7TXc/W78y/u4+PIzF+i/KwiTIRRTixIyYBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnJVoyBZV6NJd/B+ogImSiNHYbZNsDe750GWd38KdJg=;
 b=lUkqAGi1lhuSgpndbtFKe1AapylaQIsHgR+SxtpO5yASS6q+/EK1UU3LS8vsvNLCytXUJ1NUsF8MhXZkmPI9ne0XnCYvRcmA5+82ZF0t8jUJgQTGTiA6Zw3yklTXGzeif+d284fcdVAjbjrJaPCWm0aiRdZGsMV9ZfqxpOttqQyithSJvi9/X/bYwhJmrMyHsYrvlLAiLgAMZKj6I9DA2GmK11eZCApRmzugu29s+M1XoR7hICI9pArpQuifOqDHlW65EjCbp8LfTuQXejZmpXbge7Pds7WU2DXcJgTbVL0Y98hvU+/UAt/EMYGOBt4D5cUsPyv0cWj6BOhHHcrTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnJVoyBZV6NJd/B+ogImSiNHYbZNsDe750GWd38KdJg=;
 b=hK4t/rko1uSc2kY1WdzhcMfotxzG+RhgTTreD2e45U+RNoJfq8n/4iSivrk+dLKJXDNy2jmPYU47u4YSW5p1FiEBMFY4wETMGUFY9ZE1xzmY8PHMWDxRtXm/Y9WWBHbCo1/ZmVvQnpKgb67QRbCqXq6pogQ1cyWpzosU88ON5UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Tue, 12 Aug 2025 06:02:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 06:02:27 +0000
Message-ID: <7215bd69-0c9a-4919-8c6c-3d312440dd13@amd.com>
Date: Tue, 12 Aug 2025 11:32:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/2] drm/amd/pm: Add VCN reset support detection for SMU
 v13.0.6
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Ji, Ruili"
 <Ruili.Ji@amd.com>
References: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
 <80fc509b-be10-4080-8501-8e210587b774@amd.com>
 <DM4PR12MB51525DB359E7BEE5C3D71516E32BA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB51525DB359E7BEE5C3D71516E32BA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: acc99c47-46f1-4777-c16f-08ddd965d0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFRlVVdkVkhNTU5meElvUTFzQ1cvUHhOV3d2VTdWTXRMSzNMMHR6cm5wbTJS?=
 =?utf-8?B?VVpPTzZxcDVPNFFHdUxrajloWTBROTU1NjVKMHhESXZXNE1EQ3huVlcrT2VW?=
 =?utf-8?B?TnFTcG5YTzU5eTFEYzhPZHk0TjR2SXpnUmRIM3JoRGMvWEJHU3FEOUgyRkM5?=
 =?utf-8?B?UlJTODRYSEtidnBuVGVvZGFwSWxWUis5VC96TmtwMzk0eEJPU0pKV2h6YXNn?=
 =?utf-8?B?SnIwNG1yMDBvdmlxcDR6MFc1SXBBVG5vS0pTZkF1SE5YK1ZRa1JTa1dVcWNS?=
 =?utf-8?B?dElVYXkvb1hndDRQaFhDT3dacUNtbGlFS1pnb25ON2EvMTE4QVc0S0h1RUZN?=
 =?utf-8?B?M09vQXkwYlgyeEZ1RUhrYzM5RjBSdDl4TzlpQlk2WG5aK3F2M1FibE1uR0JO?=
 =?utf-8?B?bHJRQklzblpCQUswTU8yK2F1dFNMNEdTY25oMEJBc0MxenFSNzRsVmpPOTZZ?=
 =?utf-8?B?bVBhTHVvTmRQYVZxeU52eU1FVklVbW9iZWZ3Q1lwT2RVSEJDVGliaWtMaGZ3?=
 =?utf-8?B?YkxpTlZXelpqZHlrSU91U0lsczNhK1V1TTJLN25wcDh1eTk2TnhhVCswWlFR?=
 =?utf-8?B?YnZQamJsRzVpam9LZXRSQjVZb25BTWhBeVJuenVuQ0xRUFNDZldEcE43L2l2?=
 =?utf-8?B?dm8xeGxwcDg3WTIwRFkzUXpwMDM3aTNMY3pPeWU5WEJjQld4SGR3Y3NTMWRq?=
 =?utf-8?B?ak5VSUx3U3IwR0RYVi9LNFBiV3A4TlQxZGZqT3dtUitRRlQvSVhKdGpFTUxl?=
 =?utf-8?B?a1p2Y3RVanIwUCs5bDJzR1o5VjFvM2ZwQkZNRlU0VFdhcXFJemhLNWd4dnAy?=
 =?utf-8?B?UUZIWXlieEt1RGVOUVZTQVJSdkMyVXBqMXhpaHJrbUN2VGxSRnR0WlZ6SURG?=
 =?utf-8?B?SDNQMTEzcDQwYVFSbmpaaW1wUjREREtqQldVQXlwUkhsYnkzdzhyUWRrYjBu?=
 =?utf-8?B?TmljYzFELys4RlZFOVVIN1htei9vWVdXV1FMOVNyZlRSMnNKdUV4Wm0zRStS?=
 =?utf-8?B?VTRDdDdHZHA0T28rSTNjSHhlR2RwTlMxQVRNQytyREVWZmsrU0dLQlpUeHdr?=
 =?utf-8?B?ZzNmeFJ4R3VPcWVXMVRDYmxKSU9sdGRTMWRKR0l4Nm5mbGZPSllVbzd2dDVF?=
 =?utf-8?B?dGRjdm9MVTl1aFYxVTFnV2luTWQ1SEtwZWNSQ3lsYldzU1RKL3F0bUZXOWlM?=
 =?utf-8?B?SHhxZTJMSEJCanE2bHlscTRIUjZNRG5SU0R0TVhUYlV6UVZNNVMxYVJ6SGRt?=
 =?utf-8?B?ZVpXcGN3RERLRUtaTGlYK0VKYjhOZEdOQ1BUTXhZY0xjRzRQdmltZHlVSjA4?=
 =?utf-8?B?b3pUSFBEZjk1a3gvMlJWbFFjemYvUkxHRHZXVVZINDNDNVNQUTZ5a3g1Z3pU?=
 =?utf-8?B?ZFhseURXbGtnWTFkbjZvRnpuQUxDT0VWdXpac0tacGZ0ZFZHNlljR0VJWFM5?=
 =?utf-8?B?dlhNbCs2QkMvTDBWNW5YWW13QzVjbThCREhDMlJOSUZTTWF4L0d3QVpoMndR?=
 =?utf-8?B?ZTFSbWVGUDE3eW5pZElkUlM3ZnQwYi9wakR4MEl3TGNxUUVHMzRibnBTdCt5?=
 =?utf-8?B?QUpGMndMQlhDSWZpVGRlVENpdUN4VkxxazQvSVpvZmhRZ0ZBT0dlVFAyUDhr?=
 =?utf-8?B?bUUvSlZ2WGt3bmEwWk1rMDVOdUVmeWRsdUJ6U3NrVU9EK3FzSjhNT2pSc1RN?=
 =?utf-8?B?d0pEaEpMOERYWUQvVUxvM3N3U0tPV3NncmVXeFJaaUNuLy9oUzNKUlZkWjU5?=
 =?utf-8?B?TlZSNDJWbmZNbjhPZWwxUGJkKzBzYzJjL1Y3enZGT1FCQWhjUDY3ZHY0Q1hJ?=
 =?utf-8?B?Qk1oZTQzOWVRZ1Z3MDVtUTJ4R1NwTGd6NHROeXR2aFBpZXdqekhybDhhc0lr?=
 =?utf-8?B?S1NjTUVTRXlqRHFwNmtZUEhvZjRpUVpNTHNtNTZabVhmV1hWSXhvSjVmcW0y?=
 =?utf-8?Q?E/bV/kFnD+0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S25WSjFxb0Z1VnlEdkZzNUg0Sy94Q2UwcGFrY0dZWnFSZjRYaGN5cTVhNnkx?=
 =?utf-8?B?elJHY2Y4Wkt1N0o0RVY2YkFhWXg1VVUweVZwczJCRGxkTlhGZHRxYVh4MFpM?=
 =?utf-8?B?UHRnRmJFREJLVk96M2I1UTA0eEloVHlHa094ckpuTjR0MTVJanR0QXN0Sng0?=
 =?utf-8?B?eFJVYW1laUJFTTFlOGNWb3c3ZDhFaVgwUldENTB6UEpJYVA4Q1dvZWVRcFha?=
 =?utf-8?B?a2Raa1FlUjcxVExQU0dENzJVVDFmRlJTeTdpZHlmSFU3NjJFNVcvV0tVTUh4?=
 =?utf-8?B?Q3RIZGJDNmdPYk43ZGV2ZEs1QVZ0SUVBbGdwV2ZNR1JrSlluQmw2SHN6WjVS?=
 =?utf-8?B?REVXNVQ1bDlzRUZUc3U1R2tUNVZSOG5VeE03aURLNCtOOUp1alVkczNrUUtG?=
 =?utf-8?B?NFF3RFpnS2ROYlpWa2ptbHdSNjdHSjE4RTN2aXA2NGU5ak10QlFlS3BBclNR?=
 =?utf-8?B?Y0xIeWxtV3pVV294RnArQzRsZVY1S2trV1RkbFRLV3E2MnJER3ZDUWJtK0ZV?=
 =?utf-8?B?UkNNZ0lENG9YOXFUQTBkT1liQzk4VkNpVkoweVVCdGJvWGJtTEdIK2xjdUln?=
 =?utf-8?B?T2JuS2RZSG41WDFJdWRvbzBDTnhVN28xbmRwVzJVTXh3UmZHemJLVG9vbjhM?=
 =?utf-8?B?ZG1HQ0FyRWMzZU9CWXArZWUrVXRvQnVxTUlYbWNxSTZ2eG1td3FPQm1rcEVh?=
 =?utf-8?B?aGg5ZUFGZVp3L2xBam9oSEFNampuZGlVMDNIemo1eXRaNUNqd3E3TWJFd2VX?=
 =?utf-8?B?NndTbjQ3YTRXYkgrSzIwMitFT29VbjN0RjZKUmFVU3Fnc0tBMUtKQ0I2V1FI?=
 =?utf-8?B?NHVCOXhaZWg3elpnMytaUkpNYUVCckdQYWYvLy9NbnlVcS9qK2VtdEVLUXUx?=
 =?utf-8?B?a2xwODZPZ2FLdW1yWmFMaW1Dd25RcTBzVlhzMDAxZjF4Tk9tVitVTXROSDh2?=
 =?utf-8?B?M2Rzd092NzlEeFZ4bzNkMmJoQVZCT3NCSGlFb2lIenpnbDJUZFBFTWdkOFV5?=
 =?utf-8?B?YlFZY255VzNERHc2WEhEVTRtYmFsQkpldit3ZVdpbXR5aGx2NE15VHBjbjRO?=
 =?utf-8?B?eWZUVWsxcnZ2UDZ4dXJsdlE5Q01sdTNVaHR3cnVSSWkwaWJCZ1dmNVNqYU1a?=
 =?utf-8?B?R1kza3loYk9Eblc4N3dQMS9hdndOOG5tUEVvcXArdGprNlY0OFRTTy9QSllw?=
 =?utf-8?B?OXdJU044bHhUVDBFS3dONGYvUStETGk4S0hSN0U1QnduMElITlJ5YTE1Q05L?=
 =?utf-8?B?YWZIbU45QjBTMTUrU3pVY2h3WkVCcmdYTWdBTmVIOHp6YUhweW9IN0QwaHEw?=
 =?utf-8?B?WE1nRTZ4M1FUQk44ZXNEOTlMUW5LVTlWbGY4Zk0yUnhKTHJqQ2I1Nk9FQ1Ey?=
 =?utf-8?B?TWNRV2pzTGdERUh3eFRzL3NZWSswN1RPOUlneWgyWm9ucURwcUN0YlhZM1RE?=
 =?utf-8?B?NTBQVFlTL2JXSU1SMyswKzFMek9DdnBzVFZ3MVNjZnJTcHlMNVE4SC9OZXBz?=
 =?utf-8?B?aTc4cVY0TGF3VUljMHF1Z3JWNDBnTkFwazlrUm9CQThBRHo1SWcyZW9HOXF4?=
 =?utf-8?B?djRXaHZYQmtVYmVJd2piSzhuc29BV1JKUVV3WVUzMXppLy9nZmM2b293NUFj?=
 =?utf-8?B?VjYwNnJwSjN6TUJCdGUxc1ZPMDdxcG1laktTUmYyUndaK1pWVTROMzliLzdU?=
 =?utf-8?B?WkIzN3ZEdU1jd3FVMzB3YWIzd2ZnbklCNnBjbElVSE4rOGhHbGxZT2pQSkpH?=
 =?utf-8?B?dmw5M0pZSXB2Y0NwRU0raFNxdVQ4NWNVTW5hcWhZMW1Qa3VKVXJJblF1ajRB?=
 =?utf-8?B?TC9idWdwM1JOQ01WU2g0eUVMT3dsK1E1YTYyVjNLVlp0MVA4ZktJTEh1UStP?=
 =?utf-8?B?Q0MvSTJTQzRJRUNKR1hkWXE1QUFrSHhiSldvS3FucmxxMHUvU0VJWENrVDZL?=
 =?utf-8?B?QlhvVE9sZmJSRWFXYnM1UmhPbjEyOXdzMFFabk5xeHdCQzE0akZrcTl2K0JS?=
 =?utf-8?B?bmpoSXlXNGJuMEpGcmNxbDRzMFRDYWFVRHVKSFZUUFF5Y3Y4TkNhakk0MkJi?=
 =?utf-8?B?VlMwMHZoNlRSL210Z04vWllpVXNmZGlyL3JFbENBZVM0M0pTZ2MzRXVtSjRW?=
 =?utf-8?Q?QYSX0XtW+cldXTQztXaEluxwl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc99c47-46f1-4777-c16f-08ddd965d0e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:02:27.8055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi1tuH0Kdy4U7P+qcUMHdn2eP9etrsHacvJfrfBVUWn0eOax2Twvd5gV79EMLg1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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



On 8/12/2025 11:26 AM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, August 12, 2025 1:38 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
> Subject: Re: [v3 1/2] drm/amd/pm: Add VCN reset support detection for SMU v13.0.6
> 
> 
> 
> On 8/12/2025 6:33 AM, Jesse.Zhang wrote:
>> This commit introduces support for detecting VCN reset capability
>> through the SMU interface. Key changes include:
>>
>> 1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN
>> reset support 2. Implemented SMU backend functions for VCN reset
>> capability detection 3. Added SMU_CAP(VCN_RESET) capability flag for
>> SMU v13.0.6 4. Updated PPSMC message definitions to accommodate VCN
>> reset functionality 5. Added version checks for VCN reset support
>> (fw_ver >= 0x04557100)
>>
>> The changes maintain backward compatibility while enabling proper
>> detection of VCN reset capabilities when supported by the firmware.
>>
>> v2: clean up debug info and adjust this message to be more meaningful
>> (Alex)
>>
>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c             | 15 +++++++++++++++
>>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h         |  1 +
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 10 ++++++++++
>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   |  5 +++++
>>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h    |  4 ++--
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 17 +++++++++++++++++
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h    |  1 +
>>  7 files changed, 51 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index 6e0d711820ea..518d07afc7df 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
>>       return ret;
>>  }
>>
>> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev) {
>> +     struct smu_context *smu = adev->powerplay.pp_handle;
>> +     bool ret;
>> +
>> +     if (!is_support_sw_smu(adev))
>> +             return false;
>> +
>> +     mutex_lock(&adev->pm.mutex);
>> +     ret = smu_reset_vcn_is_supported(smu);
>> +     mutex_unlock(&adev->pm.mutex);
>> +
>> +     return ret;
>> +}
>> +
>>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>>                                 enum pp_clock_type type,
>>                                 uint32_t *min,
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index 09962db988d6..9748744133d9 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct
>> amdgpu_device *adev,  int amdgpu_dpm_reset_sdma(struct amdgpu_device
>> *adev, uint32_t inst_mask);  bool
>> amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);  int
>> amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
>> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
>>  bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
>>                                         enum smu_temp_metric_type type);
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index dc48a1dd8be4..f9a350a82764 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -4106,6 +4106,16 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>>       return ret;
>>  }
>>
>> +bool smu_reset_vcn_is_supported(struct smu_context *smu) {
>> +     bool ret = false;
>> +
>> +     if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
>> +             ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
>> +
>> +     return ret;
>> +}
>> +
>>  int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)  {
>>       if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn) diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index 611b381b9147..7990771151be 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -1426,6 +1426,10 @@ struct pptable_funcs {
>>        * @reset_vcn: message SMU to soft reset vcn instance.
>>        */
>>       int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
>> +     /**
>> +      * @reset_vcn_is_supported: Check if support resets vcn.
>> +      */
>> +     bool (*reset_vcn_is_supported)(struct smu_context *smu);
>>
>>       /**
>>        * @get_ecc_table:  message SMU to get ECC INFO table.
>> @@ -1702,6 +1706,7 @@ int smu_send_rma_reason(struct smu_context
>> *smu);  int smu_reset_sdma(struct smu_context *smu, uint32_t
>> inst_mask);  bool smu_reset_sdma_is_supported(struct smu_context
>> *smu);  int smu_reset_vcn(struct smu_context *smu, uint32_t
>> inst_mask);
>> +bool smu_reset_vcn_is_supported(struct smu_context *smu);
>>  int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
>>                     int level);
>>  ssize_t smu_get_pm_policy_info(struct smu_context *smu,
> 
> It's better to split smu v13.0.6 changes to a separate patch.
> 
>> diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
>> index 41f268313613..63a088ef7169 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
>> @@ -94,9 +94,9 @@
>>  #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
>>  #define PPSMC_MSG_SetThrottlingPolicy               0x44
>>  #define PPSMC_MSG_ResetSDMA                         0x4D
>> -#define PPSMC_MSG_ResetVCN                          0x4E
>>  #define PPSMC_MSG_GetStaticMetricsTable             0x59
>> -#define PPSMC_Message_Count                         0x5A
>> +#define PPSMC_MSG_ResetVCN                          0x5B
>> +#define PPSMC_Message_Count                         0x5C
>>
>>  //PPSMC Reset Types for driver msg argument
>>  #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 90e66c8f2f82..60aaf0e2ce8f 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -434,6 +434,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>>           ((pgm == 0) && (fw_ver >= 0x00557900)) ||
>>           ((pgm == 4) && (fw_ver >= 0x4557000)))
>>               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>> +
>> +     if ((pgm == 4) && (fw_ver >= 0x04557100))
>> +             smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>>  }
>>
>>  static void smu_v13_0_x_init_caps(struct smu_context *smu) @@ -3171,6
>> +3174,19 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>>       return ret;
>>  }
>>
>> +static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context
>> +*smu) {
>> +     bool ret = true;
>> +
>> +     if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
>> +             dev_info(smu->adev->dev,
>> +                     "SMU VCN reset not supported.  Please update SMU firmware.\n");
> 
> This will come for every reset attempt for programs other than 4. Better restrict this to once, or not to keep it as it requires IFWI update.
> 
> Hi Lijo, Once we got their confirm from PMFW, we will add more programs for review.
> Some programs are still under testing.
> 

That is fine, but any user on an older IFWI will be affected by these
messages. Since IFWI upgrade is a major change, I don't know whether we
should keep this or at minimum restrict the messaging to only once.

Thanks,
Lijo

> Thanks
> Jesse
> 
> Thanks,
> Lijo
> 
>> +             ret = false;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>  static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t
>> inst_mask)  {
>>       int ret = 0;
>> @@ -3859,6 +3875,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>>       .reset_sdma = smu_v13_0_6_reset_sdma,
>>       .reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
>>       .dpm_reset_vcn = smu_v13_0_6_reset_vcn,
>> +     .reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
>>  };
>>
>>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu) diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> index ece04ad724fb..7c98f77c429d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> @@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
>>       SMU_CAP(RMA_MSG),
>>       SMU_CAP(ACA_SYND),
>>       SMU_CAP(SDMA_RESET),
>> +     SMU_CAP(VCN_RESET),
>>       SMU_CAP(STATIC_METRICS),
>>       SMU_CAP(HST_LIMIT_METRICS),
>>       SMU_CAP(BOARD_VOLTAGE),
> 

