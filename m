Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FC7C6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 18:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4385610E135;
	Wed,  8 Mar 2023 18:21:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECFC10E135
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 18:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXwqoccWLdjogcjESFNMSyFikZfIjv6vW8N07PQMbr9L1A7rjagwiLOhcmboednKVojVqMOJnS1oLkeD1klodaKmqE0dNIJVOGDwlNiviFwfwIRVfttRGg8tGWXkvhSRoNABEYOeolWJAnFAY+X7W3P08Nte5qjSHxsjml+gHTxT5N+65UIi5jhz4ma/l1YPokT9CnYJ786NwyBkZQP5YC7eFnz8zHObWezj7VEb62REplv+SJnuAU9jDKmYawPQ8hFzChMeAlJP48PYLVQZqe/lWjkAWFAybDXErA2VK/L+W6ChTpDpB3lfwIE1Adt9+jjV1X/gTxoqm7wfddqqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s2UOoQaaWZNywxC0aIoeUZkA2WRrpw4h7J+wYoXYxE=;
 b=WMKLgbjTXJA3pdinyqCTGRjinJhJ76Sbs2UKqJdCrGYbkUEurruzPtlrKqbKfbN6hrZiJw2pKQoskXUGrMQzqHsV8iZzWM0mMf6m+zXGf29XM9Xbt9Px30wahH/gaNwaMA3ZM/U9JfftPW2fCfZJ8+GekMv8nQIGMrLH5xYMZlZIo0f664ZIQZrwJzhN/iViuIpmmZYjw9WMhAfT458ZO7bJb/ZX/ystgl9Fai9RxBn67hDgKqzhLcRw4Hug4NV2dYDmkUwtibwGjnix65DBGQJLcn/VJhIgJJHEm7hz0CyHKeUKgbABaQl//0WxqUCjqo7VFVh5gMTAjTybnHeqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2UOoQaaWZNywxC0aIoeUZkA2WRrpw4h7J+wYoXYxE=;
 b=pjKm1tS8Zd1eWmR2533Htd6GYwqoF5GvR9X19GdG2jhjbnrzDzUZVCsMYy45zPOEdc+RSOH6hn6OWcuMTlmDYy+l9HTnPX1QW6cm7raWmQRownYdmDyMReiDF7k5fKd+T6f7TozTk5fZacNFvXSw6XtW4mAnICmUQ6xB67t6Ahs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Wed, 8 Mar 2023 18:21:23 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6156.023; Wed, 8 Mar 2023
 18:21:23 +0000
Message-ID: <bb743d26-edd3-d60e-96a7-95b70dcb72f2@amd.com>
Date: Wed, 8 Mar 2023 13:22:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] amd/display/debugfs: add sysfs entry to read PSR
 residency from firmware
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230308071035.98892-1-shirish.s@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230308071035.98892-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec8dc09-a379-4ada-009a-08db2001ec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqBvMIa9loaVaBGHzvjWofVQVjlNH6PD+GF2k3LyZeM+xByemmuaFdRJE8CBPCeg40FjHsl8xwvUDg+qzeka/K/Z8Sa1qIxeWFzRMU0jj56yhHhFgYwGd9JUFtbMaFo9NKFi/XwikClKsJ238mPZ/Hbxl7hgzZruQzVYWwh6sJISPXkG/WbEr14rw4fZzInzixGGClynuceXFip52B4/3IivvG3Pg2NSIZ+kvGjt+wx4NDuwW8B1gjpbJWDie6fs48+O84ler4E2P7ZLnBKoArHWsQboj6IZldoz+8VYLaTwPhbSdCGpsnogS3G42ivB3BmOgnCHpgD7oiGZAlfkf8cPshHUssiiCeToUIS/2cJBLAq/aIldBX1O8TOjM3UiPm5CNDnScA3BETNvdyq53iab6CZGZQZFk8WPO7zw2RlzcRdV8/UXCqr+ezRYnIyL3fI2RCeQud39OfN3qwYyJuGkQUP1O/muN8rm7hzQmEwZY+DAO+MqJRElNaCCG+PGw4ghWEx1g2SZ05KTJ737y4qaVnyE5OJUdaGgoUfsQQzA9/ZSLmvIdCJnrFfE4PFuCqEywjlB2THY6Ay3Rn/kpnL089248VliNtPTaTJRlBqUTDt7m9tUNToIq41ZJ70FmMuC1sr8zmDrY5/l47Ht1BxoLToZYZRQ2fSn5/NYJJLpsZEshuWAjnGl3rCLHuHYYCJ4N8PUzc47HZSF1r6Rq4Ino1TIQlV4wRKyDm3FF8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(44832011)(31686004)(2906002)(8936002)(5660300002)(41300700001)(4326008)(66556008)(66476007)(83380400001)(66946007)(6636002)(6666004)(6506007)(86362001)(316002)(110136005)(478600001)(6486002)(8676002)(6512007)(53546011)(26005)(31696002)(186003)(2616005)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NzN0lKcE1iSnhhQVRYenNOemlqUVpFdXNLMDB6L3NhWDNZOG9rczI2a00y?=
 =?utf-8?B?STRDeTdqY0Q1djNZeGQ3MHNnMUdNTUprTTNuRldPVk9MU0habTNnallpcnkw?=
 =?utf-8?B?bjJQSXNGN2F3alFkcFRTeUVCNmJ5Z2VVVHhSa1A2QkE4UzdJeDZmRE5mNDFr?=
 =?utf-8?B?ei9CUnFWekp1UWpEWngxSzgvR3ZWQk9TZUpKMmFLQmtsL2JkUEVJN1dHTmp5?=
 =?utf-8?B?b2FnRUI2N1RFblRQL2hxbVJSZ3Z3SmN5QkRSRFZkN2N3Q0Z3MkM2b0xaOFRM?=
 =?utf-8?B?OGZKTzZJRXp1VDNJcHNvWFBCaXhaNFpFdFhDb2NNSHAwQk0wcWFUSitMTjdC?=
 =?utf-8?B?YWZXMlRyTnBuQUgrbnQvUkEvNlM4cFJxWXBCbWJ5MGoybTB2RktvQWJQdEx3?=
 =?utf-8?B?NUlsTUhaNXVhVXpZZ3BUVm1IVm5KNmFOYUh4YVhGcVUxRUhudTVnVlFvY211?=
 =?utf-8?B?MXVNdGd2MkFMcGd2S0xyRllZK1ZLcTBCYkVFdVVqbjlRSnI5S3ROZERuWmdW?=
 =?utf-8?B?MkhyV2JQYmlVZDUrOWhMMWpJcjFndmRUSnFoRDYzdEZPVXYwN0svTFdBU21z?=
 =?utf-8?B?Zmk1bXBzUWI4VTlnTXhTWXFPSVdVbDJ6dURTMjFrYm5IRk5rb2FyZlNwaktH?=
 =?utf-8?B?UjVnWEtmT0RSbGRESkRqNzNTbWJWSjJ3cUttcU1XUnlTbVBrRjlROGNoQlR1?=
 =?utf-8?B?RnJwQ05rQTdGYzdMZTJPR1FaeGVWK3VNQlIxMUtLcUwyTFZ5MEp3cGVwQmp4?=
 =?utf-8?B?allOZDYrc1pwQUlRRHNOcEVUa285cHhrU25Ga0JqRE9qaXlFTWVjSVRINTc1?=
 =?utf-8?B?ZGhaWXVKYTBTcmZ5dkdKL0lLeEQ0MTNidTcrb2dEc2RoUUVyNmtDckNGT2hS?=
 =?utf-8?B?aFdGYjNHOENER252OXpYRUxkdTVZVm0rSytXUGpSVFRTcVBnQlVQbzFVUFhy?=
 =?utf-8?B?WDZ4VlovKzhNTjhNNFFsdmFrbTRkbEI0Wkk4R0FjSjJSZVZKMUNFZmQrM2Vv?=
 =?utf-8?B?YXZNRndCVHQ1WE41Wk5ZUG0wQUdwZ0FUZGJvV1RnbnZLQ2swdUZZRmxlWXNT?=
 =?utf-8?B?UG5qS3Jyd2FHWW9vNWdEeEJXazJTVkVGMXIrN3g1ais4dTZWTjNTZ3UxSHo3?=
 =?utf-8?B?cXVWeUp1d056SnFoSEV6aVdUMFBGZ2xNSjRaTTY5bXFxWTNYWk1BR0dTY3ht?=
 =?utf-8?B?NW1xVGlGV3pUbGFmSjNCVHY1SWVGSEsxNW9naFErdEtYNjdROWtPWjRXUkJ1?=
 =?utf-8?B?VTk5MURHQjZCTXRPeHpPdm1acnRtSkxmMnVMeDZtZ2o5bFdJV2VJcEZCWFRP?=
 =?utf-8?B?amZlQU1PK1FFbCtLOUZsNTNSdXRONS9oYUJ4VGI2bzU2YVZmVGthejY3T3VI?=
 =?utf-8?B?SVpSL0pwRS9NU0dmc1lpdjNpT2lNdW5yUTZ1WVFvK1dUQWROR0g3aTFMbnA5?=
 =?utf-8?B?N2M3SGM4SkRIZEpLM0ROSUlqbmhWOU11Z0RQQUI3c1J6cUpROXZ3NDM4Ky82?=
 =?utf-8?B?MmxINkcycGFLWWJHVGN3L0QweGlwaUcrdmRXcDlkY09RQVBxZE9tN3I5a3o3?=
 =?utf-8?B?dmwybnBaSDhPR1FZWnN5RFdudnk3MElUT01aUVc5N3lhRFdzNnNrcFNrNUJz?=
 =?utf-8?B?WlZQZkJMVkVvRjJwQ2ozUmdPN3VHaUh5cjBIS3dIdHNzSStua2JMaFMzUGF5?=
 =?utf-8?B?OW9yVElCRGUyQjBIM0RNWUllbWxPYlZzcjBnSlVPVFU3RVExSTg5a2graElS?=
 =?utf-8?B?UGUxbFJnQk50cEgrNzE2MS9iNEJaYlZsaHhrbXBhY05TVlFFUTJzNTlNVzFo?=
 =?utf-8?B?QTZhVjRjQ1ptSmNYL0lEeFVjZFNUNU9YeWVXS09Pd245ZExPQ0VMLy94dmdY?=
 =?utf-8?B?UVFZVWJrZFJHRGJ1UktlYWVLbmhDRTljbERoMGVxRExoTzdYS2lBRFZ0VDU3?=
 =?utf-8?B?bDRBYlUzcEVKMVFnTmdwSDlqd0V4LzR4M3Z4RmpLSDZyd1p4Qkw3ZTRMTDFE?=
 =?utf-8?B?ME5lK0xDUlhOVzlZSjcvallvaGJYMGlVckJIMGNUcEpZc0xaTzgzdjBEWE5x?=
 =?utf-8?B?MlpOUmk2aExSOU5OaDlVR3ErVzJlZ3Y2a0dNUG1uckpodFRDYkZTbHluU1Vm?=
 =?utf-8?Q?nJ1pBosvfWncx1UKTrtviVDLP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec8dc09-a379-4ada-009a-08db2001ec5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:21:23.7328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eF76d3mkczDUlnzkkOZh9tZJKirnMZgoFGtLDIN/wtYbvx86rQKSetIwzSN3eEVibaU5ZnYTOnM3q/LffxWNWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/8/23 02:10, Shirish S wrote:
> [Why]
> Currently there aren't any methods to determine PSR state residency.
> 
> [How]
> create a sysfs entry for reading residency and internally hook it up
> to existing functionality of reading PSR residency from firmware.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index abf7895d1608..8ff2802db5b5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -27,6 +27,7 @@
>   #include <linux/uaccess.h>
>   
>   #include "dc.h"
> +#include "dc_link.h"

Please drop this include, the relevant function should already be
accessible from dc.h.

>   #include "amdgpu.h"
>   #include "amdgpu_dm.h"
>   #include "amdgpu_dm_debugfs.h"
> @@ -2793,6 +2794,22 @@ static int psr_get(void *data, u64 *val)
>   	return 0;
>   }
>   
> +/*
> + *  Read PSR state residency
> + */
> +static int psr_read_residency(void *data, u64 *val)
> +{
> +	struct amdgpu_dm_connector *connector = data;
> +	struct dc_link *link = connector->dc_link;
> +	u32 residency;
> +
> +	dc_link_get_psr_residency(link, &residency);

Did you mean to use link_get_psr_residency() here?

> +
> +	*val = (u64)residency;
> +
> +	return 0;
> +}
> +
>   /*
>    * Set dmcub trace event IRQ enable or disable.
>    * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
> @@ -2828,6 +2845,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
>   			 dmcub_trace_event_state_set, "%llu\n");
>   
>   DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL, "%llu\n");
>   
>   DEFINE_SHOW_ATTRIBUTE(current_backlight);
>   DEFINE_SHOW_ATTRIBUTE(target_backlight);
> @@ -2991,6 +3009,7 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>   	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
>   		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
>   		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
> +		debugfs_create_file_unsafe("psr_residency", 0444, dir, connector, &psr_residency_fops);
>   		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
>   				    &current_backlight_fops);
>   		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,

-- 
Hamza

