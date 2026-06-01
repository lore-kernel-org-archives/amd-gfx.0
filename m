Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44030CD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 16:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60D7113560;
	Mon,  1 Jun 2026 16:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZFz3yc7b";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E93113560
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 16:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKqtn09n0Gd3VRRAkqy4mdFG+r3+Ka6vzDHiyUhQlVYE6QlUmZPPaaCScoz5IkjVu3Jl1QdDpzlHYzNhax/YVjVAQN3biDz7kZsZO2KH30BP60EuACTtwYQ2pKsdqQr5LSzCt0WPhYsbt/VFhT30mBtFwFkPn+0LbdGwaFu6237v6RMa1xr544J+zgCA9C42vVuQnljrHQqtTt39TlJML1IHAGROR7Gr1yTvoKf5+MX/9ZFqBd9vHNKHujYBA/ev55dpBSM8gpHHe4GNZiiYU8DibbmAKRIpsrTZ6lbVZtHJNxvyWYokHpkc0DbmaxkSjEKHNGCQ4CJfuT24VfMfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2yxAGSR596NXHIgkfsviFZD+8cJY7d0N49xdffZp0M=;
 b=wIr9zHXKDdwux7gPY+E4dGez4O2v/MPz3+OOsskkIpQJgkkTaUz0X2Z0i75GjxxNfOdcZ6SVn6zbZGeW0uPPknOBYUyAmau0K+LbZe4oIHiiaJDDkC12rnPRPFXmYWlwe6rnk22jFXaIFdfNtY1+XGv+eNc1YcTZtSzH0Tj2UmKW4GZGhOtLm0luSZ26BnOFL0QiDM4q1TiD95SlcUm3c+Tq7IELuOsVSzg1Ge+VrL555+lUdt90SbIQYM0zacp58tF15Oj0wD/UDBEMyWmpTVkR45UdBwpNW5IC9m3wZxOoF1uOBY+xaBFk8J7jlDl9lvNsnrf788W/5PkbZ/+EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2yxAGSR596NXHIgkfsviFZD+8cJY7d0N49xdffZp0M=;
 b=ZFz3yc7bONRux+1bYQnXFHP+7ONoziXV+y3vUaRtfDJsgcat1kw2qHcj9zutllSigToB5FYmIWoEnjL8HPhNv12/Secq1BHOctOi5FT2R2ZW0whUGvS1/ohiHXqk3PgyodgFiKUcl2RRvbbm6bTrvlWBrOZrISzD3qBwLCvmd00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 16:11:56 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0071.010; Mon, 1 Jun 2026
 16:11:56 +0000
Message-ID: <09ee94b6-d4d9-444b-96de-53d64ff377d2@amd.com>
Date: Mon, 1 Jun 2026 10:11:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add missing kdoc for ALLM parameters
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20260601141215.2647457-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260601141215.2647457-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: c87e99ff-c497-45d5-4eb9-08debff880b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799007|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: blDi4qZ03mKx3vwpjcfqe1bqo8J3vmwY0WTrtRGNbbXp3rIt00UvSrTfjZVEshgNkFQ8GHyNv03RPyjZXgimygeryTWtc3eKM6934NDurqIxjsbHkNRKGDWCPDoRGjafwjLzJLa/FT6/1GHmyuYEttsGrUsp0JmfBVMO9q8UkYZc2fZUfa55W05cCpdwe2wy9RsLa4ApbtwnCmbUfSaB3x5CzXrqYzllL51m/6qz4EVc4v0f+YdSNVO1bwAfUJjLWDtc92OVSniwm5cj306JIJkjDmYzB0HKUxOgxrKjjf2R9xrgGMXIr8h8Q2XMBMoLt4dFFq4nJzAHhCcuC7JRf+5M//RZykapvToNLyeGPwWU+/k4hkfkNlocNVwwqm6p3g4kPUdo0ylKrOqFOiOCL1C7ZwzDgS3IovqonAPwOgFRSQgoNbbnqP5vSWaESpn0zlj9h3S5uaRlOpi4DsIuMRInIBo4vk7VWV7uICURmjfVf7P2qiGl/YyeQuvQjzMsU02VDKdnH2/esjaQbg0U9yxLklnxQTB3WWig2KucW1TG+ySxDKiR6UgPZ0iD2sk/bMyadGSocb5K2wC5JDHIt6orfYY6GL60/a5tweD31V3waxDgqCzoQM39DvlvAgI/Zzob2HAtgeSScsGoDwlnU+iRTdzmQuQ7B2lotvU8NDRiR7EF8v5mLCWMM0E/o5Uw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799007)(22082099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGhxTzlubFFBSlRQdTZuUitzbXJ5Y3JKMktSVUdlV0dXVEljU0kxeFg5NWMx?=
 =?utf-8?B?UDFDVGZDV1NaUTNrRVRubzAyN2hwT2h1YVlDZWpTeWlMdy8ySEU0SkFPZVUw?=
 =?utf-8?B?ZUZ6UlN1Qm55bkF1ekVIb3hyckc5QWVGVUgzZkhuT3kxa2xGT2hXeTRvdTJk?=
 =?utf-8?B?RnVxVkIwZ3BSWGRHUDk4dWRQR3F1WnNLZkVRWUlYNlVIWm95VHV3OUF6cW9y?=
 =?utf-8?B?OE5TRHlwdG8xL25PZ2V2bnB1alFEK3hhWXQ3VDI2WnhBcmhIeSswMTB3YUpy?=
 =?utf-8?B?YVI2T1JQTlQ2SGdYWXozaFhhL1Y4U3BoMHpNdVQzVjRMOWdQeC9QZEtCVXhH?=
 =?utf-8?B?b2h2S004TGp3aDg0REt3Tk0yOFJCZE5qWDlTdzI5ejlVNmJsemVjbmRyTmRQ?=
 =?utf-8?B?OG5lT3Q3bGxWMXRFTVR2ZVh3Q1IwRGUvaTdsNk1Ob3MxKzArazk4am5TN3l5?=
 =?utf-8?B?OWp2dTJJQmVoNFc4SzdBMFNvbm5zdkdVcEdxUVZ0cGlkalVWWit4ME53TWk1?=
 =?utf-8?B?dUt6OUZuQ3gzQ1AvMk9tNVFBLzlKNFAwaU5QMno0NXNJZU8ybkZadEsrVGlG?=
 =?utf-8?B?RUF6VWVXZG8relNFOVhtY1poTStUVWsvaWN1bk00MGoxTGVoaWFUOFUwcWxo?=
 =?utf-8?B?NXlQb0hSRUJLTWtzVWl2amxBdFordkEzbnV5RFQxbFpkVXhxOWFiRDJCSm9P?=
 =?utf-8?B?c3hSRHZTUmFjS0kyelJNUVgzVzZiNi9GdllGZ0lkdDdTVERyTjRFRFRJRW1G?=
 =?utf-8?B?WmZqODJFdWZ3bHhwTFB6OU1BQkxyWVVMMjB6UW5NVHBsc2JQMXNOOE1PQ3g0?=
 =?utf-8?B?UmgwQ1FxN3NQVXhzaVEzOVZnZkkxRm1tOVVnTVNKcU9BSnBKMGlHR2gwbTZT?=
 =?utf-8?B?UTZEWGRKNWNrUkZOb1h2VjBWZ0RSQ0swdGJvQ0lVM0wzS0kzWE9HNjFCZnha?=
 =?utf-8?B?a2IxdjJZRkhtVU1TSG1KcTlJY3N2RTdoZkRwYWZHRFJZTzA4SzBGUGpvbnRr?=
 =?utf-8?B?cEEyVXhDanB3eTNjM3pEN3hxa0tPaUExSStWcDhCYk11eXRYWGJSQTRXQVVn?=
 =?utf-8?B?cHJReVd4ZnNUdEhiaWFjbnlEOHdoRThseEY5UGxVUWNKenNBZW82QnRrMFF5?=
 =?utf-8?B?dHBJOFNscUFocHVzRGlsdldSaEpOYUhwUDV3Mm9lblE2ZDRSREp2a3F1L0hv?=
 =?utf-8?B?Qi92dE5xaTYwZ1NKQ29JRWlwYnpXUWZlS1k0aE8rY0MxZVZuSi80R09PbTlQ?=
 =?utf-8?B?cmVaeTdZbld3TzYvY2s0SnFhN2wxN1lSOU5qL2hmM1R2TWxzRFg0TXovelFE?=
 =?utf-8?B?dmZpK1JNOGxrL2dhM1JFYkNYKzBFcVlmTnpXcjlRdWJqVHhOQnp5R3Y4ZHli?=
 =?utf-8?B?WW90YVdURXREenZMYmhBRldpK25DQStyNk84Yi90M0FDRzVLdVh4TVVDRkZJ?=
 =?utf-8?B?M2FMYzFYMURra2NYd3BPdkZML3FNa1ZOVHFudURiVWowbU5BeTVpMGcxdmN5?=
 =?utf-8?B?Ky9xRmZGOVZFUlZoMnErSEdZQit0aDJONWZoR2t5SDhZeXRCSmVDekhMNmR6?=
 =?utf-8?B?M3p4WDFMUGZzVXgrOHNUeXdzTDNxUlBHU1FLYTNXKzNSd1NUQm4wMXpPUUJT?=
 =?utf-8?B?c0VwMVF2MmdtMDZYdVJWbTBBUW5pQmxhSWtod0pQbnN0QThSb2pqUDFRRlJH?=
 =?utf-8?B?QzFuQ1ZBbVhYRFJiNWp2SUNzTktNeUk1c0lKOW93S01WTVgvSEx0aUY2akJL?=
 =?utf-8?B?bXk5NkhXd1RUZEx2Z0NXVTY0OFhsNlF0UGFtcDJvREd0eVk4RGZrRGZyMUov?=
 =?utf-8?B?TDMyZlFQbkxYd3pKS0ZHbHJrbU80SjhuYmozR3dvMWs2WjRjSE9yNEJnL2w4?=
 =?utf-8?B?Mys4L2FDbHZRcUlRbGtRb1N6T2FBdUxmanNrSUxWMk1qY200V05NZHQ5bGFa?=
 =?utf-8?B?dWdzWHBGU1RvWTE4ZXdBR21jcmptaGdZV2ZSQWFCdUpWbHNmODIyYWY4SWxC?=
 =?utf-8?B?bm11Z1l2b21RWVdxOFlWTWcrTG5sNWFxVDhtSTNjcDM1QURKaXRpWnl6N290?=
 =?utf-8?B?KzRuU1E1c2t3QU1hdTE1UzVseHZBcHl6dHpYb1VqQnR0VjdwTVR1N0tYUmNt?=
 =?utf-8?B?dERzWG1TdE1UMG1ncXRTUE5uMHZnVVVBZ09jd24va3A4dG1LK29ZajdiQVBB?=
 =?utf-8?B?VWFqT3pNTWk3TUFRWGVzMDZzMWdYV1hMNXZ6RjBwR1JqVjcrd2RuaUpZZFQ0?=
 =?utf-8?B?dHp0MTJTbmFwbnNqM0JSb0NwVWUvWlh4YUNYbHVDcmgrSnhoeEIrM3M0RXVq?=
 =?utf-8?Q?nWwZHs6WuV/LGG3LKZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87e99ff-c497-45d5-4eb9-08debff880b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:11:56.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krvRDKGB14BMiU5dtwJvJ2iJTuAVD/8Nu5XCctwYhmcjJRs5xqhZ+0S8Cb8Bu4MRa1I2WQrjMpPv4UBQ8ByAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 6/1/26 08:12, Srinivasan Shanmugam wrote:
> Add descriptions for the missing parameters for ALLMEnabled and
> ALLMValue  to keep the function documentation synchronized with the
> function prototype mod_build_hf_vsif_infopacket().
> 
> Fixes the below with gcc W=1:
> ../display/modules/info_packet/info_packet.c:507 function parameter 'ALLMEnabled' not described in 'mod_build_hf_vsif_infopacket'
> ../display/modules/info_packet/info_packet.c:507 function parameter 'ALLMValue' not described in 'mod_build_hf_vsif_infopacket'
> 
> Fixes: 3c2381b92cba ("drm/amd/display: add support for VSIP info packet")
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index fa05547c615a..f5ac4bf32a78 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -502,6 +502,8 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
>    *
>    *  @stream:      contains data we may need to construct VSIF (i.e. timing_3d_format, etc.)
>    *  @info_packet: output structure where to store VSIF
> + *  @ALLMEnabled: indicates whether ALLM HF-VSIF should be generated
> + *  @ALLMValue:   ALLM bit value to advertise in HF-VSIF
>    */
>   void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
>   		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue)

