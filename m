Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243F3CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 04:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46E110E2E2;
	Fri,  8 May 2026 04:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lOylMGKK";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223FB10E2E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 04:35:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSI6VH+7ZBXtkcWEGjx65Nrd9djP5BeoPaLoKLxBn/+SMeN/7KzSSJrjEeDe3Vlqx4tN1viRJmCzGRkgnD0s+Q+ZZhHBueVYe/Yqo+MBeEzZwz4oC5AEpAm50/xX7ZF+zKyga6mv6Cmu1ovQZPZXEBRGSpO1/bOF1c3G8zklp1kunYI3RphgaEnpSrKZ73vFMWclyMAEJZMW9vP8b/m6HcxZO7/I7Fv3rpVwGtx5PB3GIUHokSmF3dDyZ+owVs+79VsQdPMJzicmFr+p52250pYz2IFDqCUZnv+Kh52JMGKTGcUvAs/28kGQioyj87OiG5e5eyaq/L6wynC9J/agXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlatX5iucJ5K6Pfr5x7vyP/hF59pg9TuWbdjAmUedtM=;
 b=huWSotGjdP/JdTqwwWk+744AZcdG+UAKKgoIC4Xe4hCb6uLThmwln9F6XCx6gEjY1ZLiVSUqWzzfCsTt5A7M9SZF/9q8r8PMR5cQcHdljPVvhzlCBp1hLBhNbUO6MG9AFMh996aZ7IhJX+OeAvkyOvT8msF4oBvdNA/EQ5baLGaAQX1VVWTPIVMldlXOYEtBJXxqVxOt9xErnHD4W3Y0jAwZ31yk0dqQGs6s+5hg6hjZCyEY/X4hLDvJJscI34D/hl1/fICV1kmG7sJ7429iZ1n5HyZni20hvM2L5JApXnFUSGBe72QmDDnR/1iNCmgK0v1JgZNLO0/riMcbPAh7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlatX5iucJ5K6Pfr5x7vyP/hF59pg9TuWbdjAmUedtM=;
 b=lOylMGKKcInOCFzy0IAZeBr13akSSc5AOe/Jurj0XZBb+pfLWOZerOd5X/7i+uMJxVC7Ga3L4aPqn5rmLlogqZzcIo2gLGI9M/DpqgeSTypb+0zgpYccI62jR3ZKD0huxja/5VzwIs3zMZ0t99M/6K+eTGRIIZuAF89ysPDtifQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 04:35:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 04:35:11 +0000
Message-ID: <dcfc25a2-5aaa-4c62-b684-a70f97f82516@amd.com>
Date: Fri, 8 May 2026 10:05:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260508032019.1617320-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260508032019.1617320-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b13cd3-98cf-4b57-e334-08deacbb3067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: qig3MJ1srn2qogFMZYDc8sLZMGLHOUs3yXATb6ljX13QMj+eYo0loIK1q3T8lqEz9e5hUfe+ZOOKAhnFHuRyAo8JK1VIO/nrb5QXBkaYnW3CltgJITNG8VAHVcBqLfPCwHVg1TLV9/GVzLzGfExvJZATSKVyrGRfU2NYPILZYz9JJKx+0tM7keMV5HDcH27Puls1T1c16Bz87zDUPBneVP3UIrc+6wiZ6cdpD1cqJR1Q9djbre06e/RLqK5Zh5dYiExNewj/rX5d49Hl4/vhLtWectt24uHMyNIDhpPFJW8dsKaJkhdsFSw6s4vC3+sIPPcJli3UB2Fl5gg7UAjuk9qTQKC/r9677JHSOiCOJol6UJnZDdx0l5iA7atcyYKOMZ/QnXH0pCkfBu2dC3G4Ccp4SQ0rlST20jQLULq+AECbyyR1EddQ5f/7Fw5S8y0ANhytJQYgg0QTZP2Ow9JntyH9icYvHTyAr4EPadLGysbYUZU+I1FcI4MoUC77c6Kd9YMp98f4GlsR1n/7VXPXIvZB10Pzk7cK48GkFsEYipJSMxXYXDxtblEFCatGJrralyhCMWsIgjNFAtk4PW9p3F5H2U+DOThAqfDN3+Hf2hT4McMds4uAeTJ46aIbv+zA0iMA144F2/3SjBySHUiMy5kBjhpH79Whs5Ce0q7yl8Z4gQpeUrbGqWzmq0aVgeb0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alovOHJWelZUMWhzSjU3WnJwR1N3YXh1aGdrYllIZ1IwOHFPS21sRklUYWVS?=
 =?utf-8?B?YWdDS0puU3BuWmJUTW51SDJWUlVITHN0WWVpc2RMOU5kNXR5aThZcmJaQ1BH?=
 =?utf-8?B?VDhyNmhIc1A1VW9yWDQ0VGZRb0ZjMHhBQ0Q4SzVSR1JWdGdlT2djWGlsU1Vh?=
 =?utf-8?B?WGN4TVR5eEN3S2xHaTVEQXFMOElDZi9GSGgzbkl3R3dLMmNWWXY3YnBuUCtk?=
 =?utf-8?B?anVzaUZzemJPYm9SYmZsY0QvZXNJWTZYVVBBdEtmRW9HS1N5RXhsajEycE5J?=
 =?utf-8?B?WFU4d241QWZVTTBLZ1BJRzVZLzFHaVhmOXcrUDRxNWZlUk8vSnZwNFRvdWFL?=
 =?utf-8?B?NzYyMW5LQzdud3ppVk1UMlJxZGlxTTVLclFKZ0JTMWpzcmlDSG94OWlveFRW?=
 =?utf-8?B?cmsvSS9xOHBhSTluTURoWkpMY0h4cU9WUFlxVFFFekJrOEM4c29NS2UyT2NC?=
 =?utf-8?B?Y3pDZUVzTHZOeUZCcDFqRGVydzdXU1FqZ3VRYkV1K3IzNHp6WjloKzhSQVd2?=
 =?utf-8?B?NmwwL1BYVVZSTmMrU0ZxSWlmcTVQOUJPMkxiUTVOanpta2k1ZlI4Y3BkNUNw?=
 =?utf-8?B?R0FrN3FxbVFlYVlWVEFEMmlMWFVGQ3VjbG4wZmlxbkQ1bFoyOTRzSDExNkVQ?=
 =?utf-8?B?OWZkWm5qUG9IazNKTU9HZU1RYjhISDhTR3lORDdoRGYrMkk3RXoxSVh2K1JZ?=
 =?utf-8?B?TWsrcEQ3elJvL2FEWXFlVHpFYThqdGRPVDYzSXA2L2dBdnBNL2NqaGRiR28v?=
 =?utf-8?B?VjBDSU5jNUhlbEFnM2U3SHRkbytnWVFZcGNPMlFPN2xzT3MvTGpMSWR2dUkr?=
 =?utf-8?B?cFZzaktYalpGL3JHVEZlWXBCZFZURmFQNVRwNzNLdVVoSXhsdlE1eDAveHFZ?=
 =?utf-8?B?Mi9VTk43SVRCazFHcDdaTUdEOWhCeHRvOUt6VS85RUlzSldnSGJHVXg2TTE1?=
 =?utf-8?B?Ukl2aXBWbHQ1MWhZN0xMWSt2MGZkcFhNTXEvL0R3TUtac0FUWjJRVVJsTUdu?=
 =?utf-8?B?b3Qva1NCcmRENWgrQmRWdVBhSDVjWlYwakx3RUh0Zm91ZlVScGVHL1pHQmxJ?=
 =?utf-8?B?b21vN3k3N0hvN0kxZ0JxSzZ1R2tpNTdGWWJ4L3QwdGh0MmVNNm43MUFYVmFM?=
 =?utf-8?B?R21JcGt0cEV0K0lNeGdPSXBsbEhoWXFSdEpyTHAvUGsySmlNbER6QkpGQnBD?=
 =?utf-8?B?M09aK25pdFBaUjBnUWttVWQwUmYxQm81RTJ3TUhmUlNwT3ZaWVltaXpKZkhx?=
 =?utf-8?B?N0JvSEdXOURGOVlJTWVyeG14YXBjaHFmZmQ0V3I3S2pRZjlKcXNuQzZSb1RT?=
 =?utf-8?B?ZjVtdXFLejdSTTZJVXdFa3VFcm1hb0lKNjB1L3N0RkQyN3pUemkyMndrYmlp?=
 =?utf-8?B?QjRsdWdNejNKR0RlaGsyd2UxMXRnSlBCY1BsOE1JOEEvZTNSZXlRSjU0ajVa?=
 =?utf-8?B?eGRRYkdnZXR1WllCK0I0bzZNVGNZck5kSi80eG43NERuQmlTUWE3U3pFR1J3?=
 =?utf-8?B?WUN5c2lVTytnV3pFcml6em9sZnBtaWF5cjhUUXNjNjRISk1vWS9RSXNGSEZ6?=
 =?utf-8?B?OXZ6ckp0cWJWYUFiQUQrVGZoMWh5YXJ4OHNEbTh5QlNMVVVLRXpvQlNJYlJK?=
 =?utf-8?B?MWMwRGpPcDh4YlNRelArS1RFazExMGdBdTZkeWJVQmYxSFpoWnBZcm5OdVE5?=
 =?utf-8?B?SExFM0FJOGw2Qy9UL0pCdzNwV05CUHkyL05na00rZU52QkhCb3F0emppdnBT?=
 =?utf-8?B?cndXM3pvSUcvVlc5blAwS0RpUWoyVDE5QWZnNTg4S0F4bnMxQmkrUG9GVVlR?=
 =?utf-8?B?bVoxd0xYSVFwRHlNTXRwbnRYTGozeGR3akE3Qmx3NFRUb2FyMWxUY1Bic2Nm?=
 =?utf-8?B?UlN5Yk9wTmNsSVRZMFpMUnAyOGVLLzdESWlRMGJsSlRoZVJ2SU9aeWxFVi84?=
 =?utf-8?B?L2J4UU1RaTRkc3JwekVXaTl3WUQxWU1rTWo3MHBxUEtac2syaFZ2eTZ2QXo5?=
 =?utf-8?B?ckNBMU53YncrYS9sa2dvUmVtOUh2NlhjK1RsOUJ4ZUdvdmdGUFV5OURWN2FO?=
 =?utf-8?B?OCtDSHFVK044ZnZaK1k3cWNvYittMWYrUW5tL0NqNmR0OVVVbXJ6QzlRSk5G?=
 =?utf-8?B?a2FqeUxIL21CNWNWRjVYVGpneXJrSnpGdXplVDIxbG5xdjdldmUxclIvNkM0?=
 =?utf-8?B?QXVuSmhRTEZYbDJmQVZDL0t2bDFaTVo4OG45b1Zxck1MUDVJK3lQcmhHUEYz?=
 =?utf-8?B?VDlvdTUvY0RxZVN6cktWNGpKY2I3VlIydk5tbEM0WU9GWWhxSDdqb05RbmdI?=
 =?utf-8?B?c2UxaWw2aWVJN1N5ZEpoUHJlZVBRc1k2eFNXK3lmK2FXVmpPQnEvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b13cd3-98cf-4b57-e334-08deacbb3067
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 04:35:10.8565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg1aEjAByxCemJAecPjtNDYVAWPDPSLla67coyIUZ6Rc8AqnlZQjDKXxESQ7YI9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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



On 08-May-26 8:50 AM, Yang Wang wrote:
> Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arcturus)
> and 9.4.2 (Aldebaran) ASICs:
> 
> - Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update comment
> - Aldebaran (9.4.2): Add dedicated per-clock constraints:
>    * mclk/socclk: Only support voltage control, disable level setting
>    * fclk: Mark as fully unsupported
>    * pcie: Move multi-AID check into 9.4.2 case, disable level setting
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index fd2e63530e8c..9ee3053973cf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>   		       gc_ver == IP_VERSION(11, 0, 2) ||
>   		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
>   			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> -		if (gc_ver == IP_VERSION(9, 4, 2) ||
> -		    amdgpu_is_multi_aid(adev))
> -			*states = ATTR_STATE_UNSUPPORTED;
>   	}
>   
>   	switch (gc_ver) {
>   	case IP_VERSION(9, 4, 1):
> -	case IP_VERSION(9, 4, 2):
> -		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
> +		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
>   		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>   		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>   		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
> @@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>   			dev_attr->store = NULL;
>   		}
>   		break;
> +	case IP_VERSION(9, 4, 2):
> +		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
> +		    DEVICE_ATTR_IS(pp_dpm_socclk)) {
> +			/* Aldebaran mclk/socclk DPM only supports voltage control,
> +			 * not allow to set dpm level directly */
> +			dev_attr->attr.mode &= ~S_IWUGO;
> +			dev_attr->store = NULL;
> +		} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> +			if (amdgpu_is_multi_aid(adev)) {
> +				*states = ATTR_STATE_UNSUPPORTED;
> +			} else {
> +				dev_attr->attr.mode &= ~S_IWUGO;
> +				dev_attr->store = NULL;
> +			}
> +		} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
> +			/* Aldebaran does not support fclk dpm */
> +			*states = ATTR_STATE_UNSUPPORTED;

I see FCLK reporting is supported in aldebaran - 
aldebaran_get_current_clk_freq_by_table.

That may also be kept as read-only then.

Thanks,
Lijo> +		}
> +		break;
>   	default:
>   		break;
>   	}

