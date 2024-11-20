Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD93AD743F3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 23:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7902010E107;
	Wed, 20 Nov 2024 23:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vac+F/HB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D56310E107
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 23:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq/SZMhglNDfEFcbmcGsAgNGvo0U0EHXs1D6FDCWv1qSv6/SMsdzX74sUnfoswEen1++uOKo9yC0Fn08Z+oQjBw435ySAJVr4JIJJJ8XBVjdTC8N8RR8HviyHXMCX1utqwSqJi8Lf98xTI1tF0YrI/3b8S0NLQHcrzAZkri2vA0DowKEO2ukTdfb79nyfIQs72rG1anZXj+Clbd+HolPZkl5b3ljoej0UdCL5/Cwh8s77X13yzz2wHnkXxUYswcFWJzVvZm22E9IQhGN4SqsS6Oy5PLoETku5ngALvVUISlmKItoTv+sUQFiw7BrnKFp/CNDHLgsHhlEQJGAcRPSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48OVFyrQ5BQ6qljT+pqxGH2paMLLleo2AjnKpyEZ9qQ=;
 b=o/5Bi0ShxmxbwyafUPpuzHDbFFyUqdKDvhWmqNzA+SciLhGvwdwpIhv/b0jjjOK/vXqunRK8qNO/EOOb5dpFRIRKKDm42Oxtgep8WXKbnqosD/amyguepzIy/q3Ef9nsOFbV/pKOLH6VacWh1V/HpzLv8m4my9+SpQT3BT/Je94T44RuWuDJ24kLzCa/tkAX2r4XwBQonBPcPtHAQm6wb6rYOmQm6FlviPSw9ZJ8rsvX0oMPDj9xPYAVqmkj1+ikopjmpvrefIeOPmB9MK1rIBFo9THA7/QFKQ6iEIyjpFlNblJyXN+SQL7uCCgF3TvZY8XWLxBjeyf7EMLHQocfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48OVFyrQ5BQ6qljT+pqxGH2paMLLleo2AjnKpyEZ9qQ=;
 b=vac+F/HB1fsGmwBNeilV9b68WINJ1KDCQg5DNlqgAACO/Apuhr6+LWRYfZr9o62zu9QjCvhJ+kUqgcutzJVxenVn9knk/qeDP3sMJLYYSZiDVEetnM4skK3WPW2lg7jVYO+cbF3Z9u4aCvpm4MgNBcggYPaQoQSD4osnXiy9/mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 23:55:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 23:55:21 +0000
Message-ID: <9776c960-4c8c-4aea-86f6-6d70f19d8476@amd.com>
Date: Wed, 20 Nov 2024 17:55:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Differentiate logging message for driver
 oversubscription
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20241112182549.88964-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241112182549.88964-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:806:28::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: f61b145b-0b29-4f9f-b182-08dd09becb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3VrMjFUZFdWRnErM1NKc1pZRjRadmlyVE1nb3VEbU5GN1dPdVRFUGhmZ3RJ?=
 =?utf-8?B?ZTU5d3pCMVFxS1labEJzWGlHR2tGRWVJeWZDbzhuQ1NTWHlMMGhEeWhEQVhN?=
 =?utf-8?B?UWFnUkJZWFpyblp0dU4rclFoN0IvcSs1SVo0aXM5WS9PNENWNjg1b2plck5w?=
 =?utf-8?B?bTNmQWtoYzBoUUNsd1ZnUzdoTVRGWEhhSHBqYnFibXhmTVRGQkVUQTl5WjZF?=
 =?utf-8?B?d3ArZFB3UUZaelliUjJQWVlJL2h0REdrQno1VHV2TjFOa3JEMHJ0NWxrSS9G?=
 =?utf-8?B?V1UxRVREYUMwcCtUTm9UNkN5VE1lRDEwbzNpNkwwQUpTTVBDRmpJNFhNSUlF?=
 =?utf-8?B?UXR3WGFSZEdlY0lHcE5XZVpHZTRyVlVCa083bU4xQlJmVlhwY0NMS0pVNXA2?=
 =?utf-8?B?R01oaGdPU1lUSnZZUjVVa0gvUkFvbnJBbVE3UDZIWWo5VnNsNU1uRGIxRnFG?=
 =?utf-8?B?N1k0eUJlV3hHamJrUW42YTZSMEkrQlpoRlFGaWRBd1B6eHVRRFR2SHFFVkRB?=
 =?utf-8?B?bnA2UlY0WVNBWlFrMCtpNmNrUTZEY0NxTGlPQjJMNDB6SUEyaVd2LzYyY0Fp?=
 =?utf-8?B?bWFuT2lubUN0WDcvbUpaeWhGZDdLN1Q4ZS84dDhvWWZzWW02ZktQamNYWWlD?=
 =?utf-8?B?VlpFVkZteHlwbjJadUduLzQzdkVLb211S2RZbmpRODJLVDFVejZRVkFKKzUx?=
 =?utf-8?B?OHJWVCszbjJWbjYvZ3hHSE8xUFhjTVI3dHRGWDBxMjZxOEduZmt6Lzc2YUsr?=
 =?utf-8?B?NVBJaHAycUJ3bDN2SzVBQW9pSSt2dVRLWjJHNVJidXUyMEhYMStiQ25kVnhO?=
 =?utf-8?B?MDBmQUJjdHRqNW82UGc1cDgzWC9ZM3ZleU8yUjdscEFVQTNzWVdqdCtMRnRY?=
 =?utf-8?B?SHpvYWRnN2hOY1dSdU4rV1JUK2hSbXhjYTdWaGtJUkNaT2M2Q3hZRjRFclRt?=
 =?utf-8?B?cEpSTUU1MnR6UFBDeVBGVCtLV2NJcmNYTSs1TFZUS2pqR1paUmlEb3hFQVp4?=
 =?utf-8?B?NTFUQWxrMVIrcWpkeGNNL3pzZ3h3Qkl2Z0dHSmNwckxDSjR3WlNQQWR4UFR6?=
 =?utf-8?B?Nkt5ODM4ckNDYmZaeWJ1WjcxNFk3V1FhUkF0YUxtbnFqQU1zSWxHSXQzOE50?=
 =?utf-8?B?S3FHakM3eVhEODFQSm1uRmVXWWlvZmFVQTcrUFdOOEVEUkVxZ2llZGo3QkY0?=
 =?utf-8?B?WDhTT0JoRXYzMXFUd3dRQ0h3TUdjVXhoM0RJUzNBU2JNRlJIV2JjcTU0bk9x?=
 =?utf-8?B?NjdmYm5yZXhwNlJEU1piVVBwSVVRSVNCM29VY2hBOTVyV0F0dHUvSHlUbmts?=
 =?utf-8?B?TVRWOThjclMzcWhkQzg5NlFBenhqY25yeFhGTnZkRitremFhaWo1dVFxWDBI?=
 =?utf-8?B?WnExU3dsQXkvdmczMk9iV2lWRlhHdWtQdjl2TWsvZWZoVzM1MXRTRUFEUVJB?=
 =?utf-8?B?azcvako3UUNvU3BQbkQ3TGhJYmtVd00xZGdLMUF2K1ZWNCtsUUNPQkFRU3FO?=
 =?utf-8?B?eGxXQ01HMkwycDE1T0lMZ2NMbW5iUUVWVlE5M29rQmV1M3gvZTJwVTh2ZDJn?=
 =?utf-8?B?NHgrYnpzRm84SHpQaW9CWnUxaEVQVTVWNFBFQWxmY2NKY0Y2b0xkUlpsTU5F?=
 =?utf-8?B?emsxeG9paER4NzkwOElpUGt6bE1XbG1JSWY0THRtU0FJWXRFWEwvZjZBRXZI?=
 =?utf-8?B?V3hnSG40M0k5TUltNnZuU0NNVjVOZ2U5TC9BRVlGUkRXTkRVY3N3RWJST2NR?=
 =?utf-8?Q?D1XimvhfyaoOgfUoec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTd6S0RiRFZwZzFXTjZiVDM0TFF3Y3VXN2VhTUhPbkVjTkhGbzNhRXgrcnJi?=
 =?utf-8?B?NkFOTnQxMWxKUy9QYUdoTmQxR0JFQ2JrOThRTWZHWnE5NGhLa3RlVmZ2K2Qx?=
 =?utf-8?B?aWUxMjRBTit1NUVrTm1HWmpEdE00QjNuN2NGdmVJVkNxbSs4RmZVcHVsajhi?=
 =?utf-8?B?dDhxQmo0RVNCN2F2WmJnWXZ5WFU3QWd3TjAvcE1TMGhOVG9kRHVxUmtMSDRn?=
 =?utf-8?B?bThtVVNsZkdVYWxJMHA2ZUQzdEYrMWlmNEFhZll3bHNUbkpoc282VG4zbXlp?=
 =?utf-8?B?cnpuMEdXWncyMjhlQkt0dEpLby90RDBGWU5Ha3hGVGtTVDJtQU0yYUw5Y1VW?=
 =?utf-8?B?cktPMjVCYkVVcFpxWTFMeDFCRkUyMUlLd01KTFpaaU1rVzhyTVpma2VmSVJr?=
 =?utf-8?B?Wmd0UnhJK3l0U0I1TEZZbnZzdmtnS0c0SkthdlBMZ0JMNGgwY2FWeStlTzRa?=
 =?utf-8?B?Tkdtc1J4a0piaWxxTWpXODBFdWhrWVlWUTAyVUJCUllUQnhYMXZwRTRBa2Uz?=
 =?utf-8?B?TXZESVhxKzB5QlM3dEpRWkszZnh4WmVBbDk3My9ncUFGdGtIQ2VGQ010Q0t2?=
 =?utf-8?B?NlJoTkRWdDVlRm5jK2x0cUIvMkV0bVRWb0xZT3FCNkZXSEJ5MlAwSU9haVJK?=
 =?utf-8?B?ZktoWSt1TGNDTEJvRmhsK2hIVHFuVWRFcHBpNWhacHNEM1BqQUVUdHJNOXRD?=
 =?utf-8?B?WEVOTTlsVHplRlFkYzE0UUNlYjB4ajFvQ2lnNmZWVmlPZXYxQzJJSmV5R1hn?=
 =?utf-8?B?Wm9NU0poNVZiem55VVhLcGpyNGkybndwakIrZTRHYlh6ZXUvU0N0akc5YjM0?=
 =?utf-8?B?cStjOUtFR2JMc3J6NzdVWDY0VnlMTHdtNlJHVk9BMzFFSkRCSVJ4NjhhSytw?=
 =?utf-8?B?anZsMW5qQnZUN2ZWZjFTRkcwdTdqRnhyNUxsSUtmOVY3MjBUNzZTVnp4ZnZn?=
 =?utf-8?B?TWFmZTFaRllJSWIzZ1ZEdGhsUjd5MHdQQWNlaXZrMEdSbHo0UUNnOHJickhu?=
 =?utf-8?B?Wm1RUHluL3cycFkrMjFUdklHZG5iWUl3RDNaaEpRcWdXdXhvaEpIWjM3dUpG?=
 =?utf-8?B?SlpNRUJldlg3UFBrVFJrMnFvRUlpNDF3RCthdjRSNXdtemUvcDZXNGdCb3A0?=
 =?utf-8?B?Y1k1eHBENXJlZUIvVHFaQ2RkWGFwY0VUWUN2bGswaEZ0dVpVTlVPM0I5bjRJ?=
 =?utf-8?B?Y095V2E3NnJuQ2JpYUk2djAzUTg3Z1VyREhibVdiby9xMHc0WFloc1QwYWJJ?=
 =?utf-8?B?a2lFMnZOTk9ORmVCcG1PSUhMQVVyQjNWWWdxd3NMVjNKdGRIL0Y5QkRSYzVa?=
 =?utf-8?B?YlFtdnpKK2l6cjk5R3k4NTNaNXFubEF4SHh1Z2VVU1lsd3k2RlhGVXhMZWpz?=
 =?utf-8?B?SWwrVlJQWEtVQnloQjh0SWJ0Wmx2ZWI0RExVOXNra3grQWNIK3Q1NW1zVmV2?=
 =?utf-8?B?RC8rYXBmdWhhQXlIMWUzYVJGTk9kcm1uZmJGNWdyVWRCSllKRHAwSlVaejJN?=
 =?utf-8?B?ZFQ1Z0xMZEJOeXViT3pWNlR4RGJVdnI3R2FzbFp1WURialJSRXZmdy9ISTA5?=
 =?utf-8?B?Z3B1NzFrY2VTSjJKWFBjazB4UkZ3M2VvZGg1NGt1dGpXc1ZUaXhyR2RUWkRH?=
 =?utf-8?B?VFVDbDFYUEE2czRzRnNMUmZVUmxadE9mdGowUVhnLzJ0OXNUL3pHL1JWcHpX?=
 =?utf-8?B?cmxRYmVZV2s5SlVTNFlRd3dPWVFDWlVoNENMaUxjbFBrakUybXFTUzdmcmlo?=
 =?utf-8?B?dFRseG9wNVk4aXBITEV4dWNybTVmUnZaMmpoWW1QdE1WcDNnNlZvN1FqNkxn?=
 =?utf-8?B?OGZlbXlyQktncndTSGhnKzJNQnFtdjZRamhyWnR0bjQ3T0pwcVIvMDZaSlBX?=
 =?utf-8?B?Y1dYTk5HbzFoLzhIY2J6ZU82N0FCRHd1L092TVd2VlhBTFFacjF2QTF6aU5l?=
 =?utf-8?B?SStmNWFiTjZMbjgzNVIycjVlRU1Sa1d4Y05paHhVZDNXMXczZ29NRExTdU9P?=
 =?utf-8?B?Um10K2hEdExkdGVUdXN0MWdhZjQrRXBadmdtRll6Z1FhTHBsbyszYUpmU2pC?=
 =?utf-8?B?QWZTQkF2bVRHZndqR2hPRG5CRGRQZ1I3SzNZWHRNcitYNVYvVGFENUEzMENJ?=
 =?utf-8?Q?vIADr7KTKEfkVj50/r6hzQogM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61b145b-0b29-4f9f-b182-08dd09becb07
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 23:55:21.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1x4Nqv4sr6waUnf47BobgR+WJOfYO7/A9KcTCoftr4X4u1kQCCsYp+sq/fphDwDMKNdCocLoI9kUmZvCgoy9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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



On 2024-11-12 12:25, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> To have user better understand the causes triggering runlist oversubscription.
> No function change.
> 
> Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
> ---
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 44 +++++++++++++------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 37930629edc5..1848578dd5a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -28,6 +28,10 @@
>  #include "kfd_kernel_queue.h"
>  #include "kfd_priv.h"
>  
> +#define OVER_SUBSCRIPTION_PROCESS_COUNT (1 << 0)
> +#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT (1 << 1)
> +#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT (1 << 2)
> +
>  static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>  				unsigned int buffer_size_bytes)
>  {
> @@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>  
>  static void pm_calc_rlib_size(struct packet_manager *pm,
>  				unsigned int *rlib_size,
> -				bool *over_subscription)
> +				int *over_subscription)
>  {
>  	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
>  	unsigned int map_queue_size;
> @@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
>  	 * hws_max_conc_proc has been done in
>  	 * kgd2kfd_device_init().
>  	 */
> -	*over_subscription = false;
> +	*over_subscription = 0;
>  
>  	if (node->max_proc_per_quantum > 1)
>  		max_proc_per_quantum = node->max_proc_per_quantum;
>  
> -	if ((process_count > max_proc_per_quantum) ||
> -	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
> -	    gws_queue_count > 1) {
> -		*over_subscription = true;
> +	if (process_count > max_proc_per_quantum)
> +		*over_subscription |= OVER_SUBSCRIPTION_PROCESS_COUNT;
> +	if (compute_queue_count > get_cp_queues_num(pm->dqm))
> +		*over_subscription |= OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
> +	if (gws_queue_count > 1)
> +		*over_subscription |= OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
> +
> +	if (*over_subscription)
>  		dev_dbg(dev, "Over subscribed runlist\n");
> -	}
>  
>  	map_queue_size = pm->pmf->map_queues_size;
>  	/* calculate run list ib allocation size */
> @@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
>  				unsigned int **rl_buffer,
>  				uint64_t *rl_gpu_buffer,
>  				unsigned int *rl_buffer_size,
> -				bool *is_over_subscription)
> +				int *is_over_subscription)
>  {
>  	struct kfd_node *node = pm->dqm->dev;
>  	struct device *dev = node->adev->dev;
> @@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  	struct qcm_process_device *qpd;
>  	struct queue *q;
>  	struct kernel_queue *kq;
> -	bool is_over_subscription;
> +	int is_over_subscription;
>  
>  	rl_wptr = retval = processes_mapped = 0;
>  
> @@ -212,16 +219,25 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  	dev_dbg(dev, "Finished map process and queues to runlist\n");
>  
>  	if (is_over_subscription) {
> -		if (!pm->is_over_subscription)
> -			dev_warn(
> -				dev,
> -				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
> +		if (!pm->is_over_subscription) {

Braces are unnecessary here.

> +
> +			dev_warn(dev, "Runlist is getting oversubscribed due to%s%s%s."
> +				" Expect reduced ROCm performance.\n",
> +				is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ?
> +				" number of processes more than maximum number of processes"
> +				" that HWS can schedule concurrently." : "",

I'd prefer not to break string literals over multiple lines. It makes it impossible to grep the source code for error messages. I've also seen that result checkpatch errors. I'd rather take long lines. checkpatch is OK with that for long string literals. Maybe you can also make the messages more concise. Suggestions:

* " too many processes."
* " too many queues."
* " multiple processes using cooperative launch."

> +				is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ?
> +				" number of queues is more than assigned compute queues." : "",
> +				is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ?
> +				" cooperative launch is more than allowed." : "");
> +
> +		}
>  		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>  					*rl_gpu_addr,
>  					alloc_size_bytes / sizeof(uint32_t),
>  					true);
>  	}
> -	pm->is_over_subscription = is_over_subscription;
> +	pm->is_over_subscription = is_over_subscription ? true : false;

The ?-operator is unnecessary here. It's the same as the implicit conversion to bool. If you want to make it explicit, you can use

	pm->is_over_subscription = !!is_over_subscription;

With these nit-picks fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

>  
>  	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
>  		pr_debug("0x%2X ", rl_buffer[i]);
