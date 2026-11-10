Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D0606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sQzpIIFH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024A710E241;
	Tue, 10 Nov 2026 01:37:52 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0304710E183
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 01:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/tJOJbnNJGTNoPG4Ooo6iff74q/z4SqtsSrPU+DDfla/cq+EIPT3y4XnJUDTQAs3Ten22fd6/Q1C6umXHoevCmPL+L4armhspoN2ElJlozNHbBTMG8LVOEisvgHXvxbTW8b26xK8GtKigx1ujngRLL9R1Uk5tt4gEFj8MYfXGjtLZQz0lXARszr2NkSWtiEY+r4ocl9nrGgcVvjnjejJH0Cjg3kzb6D4Nmrl8CafnFFT1N6ELwQaetSTe8AEe1vqsXLRzQdoJtyZR3rBC0r6m4in/R1gIAqc0RrEgxR1XrByXOmSPzX6hNbDHt+z7iwOitRiPhC48xc6aSctMvGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agA/e1i6H0UORRvUsaqexinxGiKOUC9sCO/tOTAkYMM=;
 b=hSQvJJkD2CSIqjBEae1jkGhq04XwcUMjHGbGN0tWceRzqou7lN5QVN3SrNQa2bo0vvmbUtO6SvK0yiNK/rT/uuphtJrbz3Eoba2o3+VwBKn6Xrk8YqyBomk5cVvPRoch2zShM8Lea548lm/eWcQMGASGWYUgm/6InJCLzujIXQ0DUkEID/mLPdt3oivve4EeMBxOVnHtpyitIk6FpqW6sncbpb8r8NJUihrsZOKRH0muiTaiSwqO56pUw7Ryp9P3+x5TMvU+S+GFNZCMe5Gp9C8rJrZpLU4siEX5cakgF1e5M1gwnT4OAlNeRovyy3BQ0z7+FOPZxQ9XVSYvWOGpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agA/e1i6H0UORRvUsaqexinxGiKOUC9sCO/tOTAkYMM=;
 b=sQzpIIFHqrTGT8i+rt54UHf+/b5lj3MVyjUK+7XffTXKodAba146+3uqWKFtUidzQ8VeIsXehw+H1D33Av+C5vXGp+ty7nTvfimD4Q6C+ZHmwwJRUTQbKpkkiTqiXQcLtGlLTw6PinMeAx2Z2CkZV/HViy0tV0+RTgoDPgRJo6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by CY1PR12MB9698.namprd12.prod.outlook.com
 (2603:10b6:930:107::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 01:37:42 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 01:37:42 +0000
Message-ID: <b077a276-7e05-4383-825d-29e2f73773c8@amd.com>
Date: Tue, 10 Nov 2026 09:37:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 1/3] drm/amd/display: Add the AUX backlight minimum
 once on the custom curve
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com,
 siqueira@igalia.com, harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com
References: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
 <20261103-amdgpu-aux-curve-min-v1-1-62119efdcc6d@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261103-amdgpu-aux-curve-min-v1-1-62119efdcc6d@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0e81c9-6a18-46cc-99d4-08df3ecb367b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|3023799007|10067099003|11063799006|4143699003|261026121527099003|261026140227099003|261102130727099003|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: N5jkhccRXTMYt7UBa8iA4wNHMpuaqM2TSLFvkNaEy6j7pCUuc6RJidLsp21IlNVNF6/sTqZDQTvuMI1Vu+HmfYID7JsZZoCJ9healkzDbdz9sL1jgzrw42pYR5Hq/c32tsJhmcPxUsBN0u7CjgsFUohV52Fe6V8yq48jz1M6V6oxwf6ikT8PRwRLszR1NlqPzKdWQomQmEsaDzqe+TeSGnmg49I50IT11z9xKF0c8ZfWTuZk4yR1QM0vciuPxGL4ZAgs+x3nzxVR3g48fdx9wbRmqZKy8TnsvVuHaOPYGASFOWbwiLt3K4U2fLovyycCwDl55fBchG+Fj+sHBynhtJed6ETDuPe29oRv7qBdvTLbFoTGStEKFEtzrGvkU9vWfipI80mU9q97GEJ4xFgm+tC3v1HUJcbJiPY45sPq0LHx1ADPGpBpmU0s84Qz4VWI8qN1fehMyuIjmTpR7jcdo9yJCzgn0MZztSIXteCLbWHptKaNBa96HOv8H6laOjuSGQpNXsKqAzbeKihTjMdJcf+ZCrHGf8wdaflfmqe4TG31pp9DgrP/Jv0nDywmijHX1uwD7LHnKqWR85i9p+Jz5QGldEVpBJIL7dIixz916/lWj1TwREIVhy15NI+uq0m/7+B9fE4Pxp1nyo2JTnY24L4WiU3sAY/R6uO1IQ+8OF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261102130727099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVQRlZuVk9zRTJ3NlNnS0tEbTRWcWZmbkpXRE5kVzlrQ2cycHBlQUxFKzBH?=
 =?utf-8?B?c1czNTkvNlJ3eThzUUVVVC9BSHJnWEQ4OWpubVdsL2RtVXkyTW05ZHU4UFlz?=
 =?utf-8?B?OXlpR0pPemFnVE9qZXEyYmtOakdaWHkwRkp1aC81WGduSmNxN3NWRWFqYjNa?=
 =?utf-8?B?UWNqdWFzS1ZuQzMwSlRDWGRYMUUyd1ZqVDIxV0JjMUZGcVBuRkhtVTJtRURH?=
 =?utf-8?B?bGpIY0doNW0wV1JUUGs5UGc4aTd4ZVZXd21hTFhhdGRuZnUxQW1pdFFsb2d1?=
 =?utf-8?B?WlFjY09VMXlwSFRVQlljNUJMcVVzUUdkSmNWMXBZNUl4M2ZmK3pNT25BaExY?=
 =?utf-8?B?VS9NVURVUzFiZlFiS2pSNUhBZzI4d3djSC9RdmM2NGxmM2RSZDV1dHhRN2xt?=
 =?utf-8?B?ak1iazd6akhVZW9ZY0xocVJLdnRucFRlZExIL0s5Q2ZkNkdFVld0M1Y4QjZS?=
 =?utf-8?B?VmFMU3V5Nm9LaE15aEdEK3VuOFlybENFSitXZ1pqd29nMStaODJsemZVdGpN?=
 =?utf-8?B?alQrM2NiT0FqVW9hNnNNaUhDNWdBNVZsdnF1RW5FeHZ2bGJMQW43Q09zV3RT?=
 =?utf-8?B?NzhSQWkwME5NTzVNckV2dVlMUEEySDJmMlpEeWZLTHV5VGtxM0lLaHBIMi9z?=
 =?utf-8?B?RVZETEFFYVI4bVdBZlVHU2E1elk2bU9pMHNUTnVRT2c5MGR6RGdlMzJIcU9q?=
 =?utf-8?B?VG1VVkFySldLQ2NMTU9JeWl0cXN2Y3RNK05UTXdENFpWaWIwU2VDUWQwMERn?=
 =?utf-8?B?NjF3b2hHTEw5OERPT2pWT3pzYVdCOGdlbGtoQnlldDltUjdpT2JxRlp4TEYy?=
 =?utf-8?B?SUwxVVFJOG9MbEhYQkdWSjVDcEJiSkJRelpOTWxhMUFzMWYvcGZBZ3BpVFIz?=
 =?utf-8?B?bXpiY0dhb0ZYS0NRYVVuZDdpaFZMZUc0dHNYZ09FSFBwakJXTnowVlczRFpS?=
 =?utf-8?B?QWtNNXhNcVpFdFB4MWxqYjM5a0Z0akpqSmxRMFRzOTRUMzg4Z3FIQlR1aHVG?=
 =?utf-8?B?WHFLSDU2K1dlRHNDdytsL2hsVnRIN0dpbWgxWGlpTnIzNjFqdFZmdGsrTm1Y?=
 =?utf-8?B?WVVvdWpUV0Y2MU45VVh2RGxkb0FZNS9KbGo2VUJ0YnJxV0VxQ0tjaFlMT3Yr?=
 =?utf-8?B?Y3VMTzRtNjFTK2JZelowc0F1R3FxWGpTVHEzNE8zbVN6RXQxQ1F2dS9QTjFo?=
 =?utf-8?B?eUxDa1AwWkppaGF6akV5QS9Ccy9Vc3dsa29LUy9BK2xsQmxIZi8rUzhkMkhX?=
 =?utf-8?B?d3NmQzBmV1V4amFRN2hoTWdmd3BGeXhmQjl2cWZQNnpvMldMU0hiYWV1ZHlW?=
 =?utf-8?B?Vzl0c0dVaEVkN0lzWGNwclpCcFFVU0VyQVBRbm9Pc0U3Rm8vanZlVTJYNVdX?=
 =?utf-8?B?ZjN3NG5vQkRjd0RMeTRmckdXcDkwNUZMd28xdU1LVHVSUzNDclJGVUpldmow?=
 =?utf-8?B?Y25JdEZhTWJlb2FhQ1JuaURKRWppdFQrS1FZK21JN0x4QzNQZnRMZ0VNbDk5?=
 =?utf-8?B?TzZ2aG54a2RxTnlUWE4xU3U2U0IzcG14SlZNbnZYN1BLYW9oTVI1UG5zWTNY?=
 =?utf-8?B?bXJFZmxPUTBXcGszck9YZGt3WVRiWURtRFZLZ2hEVDdUYTIyanQ5d1dZYS9k?=
 =?utf-8?B?UU1VU1I0K2ZtLy9QVkxDQUpwUkRuQWVWNFZ5RGowUXZ0bnd3MGY4a0RualNa?=
 =?utf-8?B?ekhUUUZCNnRGUytKRUFuZW0rUktTNHU5OEtmaUw4Y0k3RnJFN0V6Z1B6WlVE?=
 =?utf-8?B?MXBPcUVkaUFMZEpQSzlqazVrdVhTbzBqUTllRWoxQTRxWi9wbXN1SUhOM0xO?=
 =?utf-8?B?dG51OTZsTjczcDA2ZzdaOTg0U3cxazhWTjN1WGRRRXRPbTFJSm02MUtVaVVH?=
 =?utf-8?B?QzRzOU8vZ1lqeXRjcnVDcEpIZ0JVWFFXbFgxMFdTMHhkZjNleFJwanU0cW4w?=
 =?utf-8?B?VjJIS2RsR01YMDlNZkFFZTlMVVF1L0NEWnA0YVBjYmdOOENhQk1aNUQxUnJO?=
 =?utf-8?B?dG9lL1NZZDd6cElEZXBkUGErY2ZyOHdoVFZhWm94Q0VqVnNuTWt0TFJHdVcw?=
 =?utf-8?B?Tkpjb1BBZnR2RUsrcHVPZnlFVzlOTHZGV3Y4SFFaOERJbWRpbWN6MkVEZE9n?=
 =?utf-8?B?K3hMazhxd0k5a1F1cmVQcGJTa3g1cEVqeWhwVk5VaHZJSFdoL3ZSMkxOY1VT?=
 =?utf-8?B?d2hxbmhCQ3V0eG01Q0t1TWZVSkF5ZndpU0tvcG1qT3JpMUVTRGJpTkZKL3RO?=
 =?utf-8?B?UjIvSEk1Szc3N2FyVXR6M25INXk0bUlTNDZBOGRUY0xKVUdLRFJVQWxwVkda?=
 =?utf-8?B?U3NDeEVNUXdKa084RXFPUG84aHZPbko5R0Fvb25YK0N5WXppby85dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0e81c9-6a18-46cc-99d4-08df3ecb367b
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:37:42.5891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYlG/0TxAh1D/zAcfjn09u5kZwBv1uiPKynZIHk5Cq656CHARYZoxxCczQQYx3n3F8jLogcDjHogeVDZB6co8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/2026 9:15 PM, Hugo Sales wrote:
> On an AUX backlight, convert_brightness_from_user() maps the user level
> through the ATIF custom brightness curve with
> convert_custom_brightness(), which rescales the result to
> user_min..user_max. convert_brightness_from_user() then rescales it
> again, from 0..user_max to user_min..user_max, so the minimum goes in
> twice. On the 1..512 nits AUX fallback range, a request for 0 gives
> 1998 millinits instead of 1000
>
> Rescale the curve's output to 0..user_max and leave the offset to the
> caller
>
> Fixes: 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to userspace")
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> I saw this on my laptop, an ASUS ROG Flow X13 GV301QH, with 7.2.9, when
> PWM still went through this code: the amdgpu_dm_brightness trace showed
> requested=0 converted=6023, where 3084 is the minimum. Commit
> d422a66847a9 ("drm/amd/display: map PWM brightness through custom
> backlight curve"), in 7.2.10, moved PWM off this path, but on current
> kernels it still hits an AUX panel with an ATIF curve. On older stable
> kernels this fixes PWM too
>
> With amdgpu.backlight=1, which forces AUX, the GV301QH uses the 1..512
> nits fallback range. There the floor goes from 1998 to 1000 millinits,
> the midpoint from 159999 to 159310 and the top from 496000 to 495968.
> The rounding of the level to 8 bits and of the luminance to a whole
> percent stays as it is
>
> No existing test changes: they all run with a minimum of 0, where adding
> it twice makes no difference. Patch 3 adds one with a non-zero minimum
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  9 ++++-----
>   .../amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c | 14 +++++++-------
>   2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 27546febf90d3..8b49cbcde91cd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -122,10 +122,10 @@ static inline u32 scale_input_to_fw(int max, u64 input)
>   	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
>   }
>   
> -/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> -static inline u32 scale_fw_to_input(int min, int max, u64 input)
> +/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [0..max] */
> +static inline u32 scale_fw_to_input(int max, u64 input)
>   {
> -	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
> +	return DIV_ROUND_CLOSEST_ULL(input * max, AMDGPU_MAX_BL_LEVEL);
>   }
>   
>   static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *caps,
> @@ -251,8 +251,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
>   						    (brightness - lower_signal),
>   						    upper_signal - lower_signal);
>   scale:
> -	*user_brightness = scale_fw_to_input(min, max,
> -					     DIV_ROUND_CLOSEST(lum * brightness, 101));
> +	*user_brightness = scale_fw_to_input(max, DIV_ROUND_CLOSEST(lum * brightness, 101));
>   }
>   
>   EXPORT_IF_KUNIT(convert_custom_brightness);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index c6d15fb8ad989..2d7a07d9ad874 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -1125,10 +1125,10 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
>   
>   	/*
>   	 * Exact match: lum=50, brightness_scaled=128
> -	 * result = scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(50*128, 101))
> -	 *        = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(6400, 101))
> -	 *        = scale_fw_to_input(0, 65535, 63)
> -	 *        = 0 + DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
> +	 * result = scale_fw_to_input(max, DIV_ROUND_CLOSEST(50*128, 101))
> +	 *        = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(6400, 101))
> +	 *        = scale_fw_to_input(65535, 63)
> +	 *        = DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
>   	 */
>   	KUNIT_EXPECT_TRUE(test, brightness != 32896);
>   	KUNIT_EXPECT_TRUE(test, brightness < 32896);
> @@ -1171,9 +1171,9 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
>   
>   	/*
>   	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
> -	 * Then: scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(20 * 50, 101))
> -	 *      = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(1000, 101))
> -	 *      = scale_fw_to_input(0, 65535, 10)
> +	 * Then: scale_fw_to_input(65535, DIV_ROUND_CLOSEST(20 * 50, 101))
> +	 *      = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(1000, 101))
> +	 *      = scale_fw_to_input(65535, 10)
>   	 * The output should be significantly less than input.
>   	 */
>   	KUNIT_EXPECT_TRUE(test, brightness < 12850);
Reviewed-by: Ray Wu <ray.wu@amd.com>

