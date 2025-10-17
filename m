Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D6FCCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 21:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A381310E1C6;
	Fri, 17 Oct 2025 21:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q30J24aJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF1810E1D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 21:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDS58I5Bl5d6XmS4wG0meZs1u3UrC1wtPshApfd7pV8Lcwb6EjGLY57klAE50JKlqc1u0hLgO0Ndo2V59pALSTqvLS2laxDNe/F52AlGaz0nxrZyb5wSaZ1HaVaox92J7GPIzTEymKF0CL4d4n74WDshszhZKzKpfZuJv5M+y34Vrz6/Jt51ZZSp6ahGqWmEU6aelW1TgjKwGzIwmoQ1rmfYqyMqxZ3j5v4XccZUoc+C+LHAk0myqPJjqpr2x/GES6fpvoBRVkmwQv0PF6nuEhzRTY5XVdv9vfgT+tTHkhr8IQ0PdaZdqXilCriAEJ/b11/eJ32qGihLEz2hI2QNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6lkf4gcXsqxh8ERzDShh7e5kk80idIWzDkEWovHEFk=;
 b=ToP56VDFS6Nql8Pq4NCz8ag86EbGm8L2gPD9FCgXzSuvzrL/E/+yIDcEVIsi4/n57HhlE9A0HHF1tkp603QWjBP1mrclAgKW7N8htnT5KKoeLtmOu8xu7f3b0f1MQkkJV6PhgwynG/Vlg96yOHHUgY22Ni3S0hdqAiVTXUOkR5T6Bu+DW+uuSDgwXuVe5+H8xHPwuB1UNic8EhzErVp1Ak9uToyaMMQ3TNzyHTjz7xZIwAEmOx58t6IMhQR00JQO/oeVEj1n7XVgAdcHo1TErsWD4i3+89BMfpM80IBMGZHdP11KbsJOjwGao04mdHrgVuEfZP51Mq78O6wRMm/65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6lkf4gcXsqxh8ERzDShh7e5kk80idIWzDkEWovHEFk=;
 b=Q30J24aJzPDD5mi3IZQmqqjSTfgk9WM3UeCBpSrMNS5+jqjqioK3edCcBPDuv9vsXo51mplx3DyQS6mMCplRAxg91vUde2EhaWgjSYNC2KUoVg5zm/TF3c5+HMR7gc/ce/aUJ2E5Scw0cASzjbAzNyI3r0uTA3mzgBAThYhP9CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 21:58:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 21:58:20 +0000
Message-ID: <2c67aadd-cbf0-42c8-ba3f-325c239d0060@amd.com>
Date: Fri, 17 Oct 2025 17:58:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Adding delay after sending the Exception
 event to runtime
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, philip.yang@amd.com
References: <20251017183354.116538-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251017183354.116538-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c25a97c-683b-4921-81da-08de0dc84922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1mQ1BpbGVLTDFGRy9ST2p1Qk14UGhWeTdzMHFUU2thMEhlcXRWNjBYVnF0?=
 =?utf-8?B?NFB3NWhhd21IRVVoM25zNSsyM2lDVzIvRHB2a1BxcFRhNkFFei9zVlFRay9k?=
 =?utf-8?B?SFErSTBPNFFDU1RkcDhydGVGSEFvZXA4OVBjaFJORnpNdkM3QkRxTTVHcFZN?=
 =?utf-8?B?aXVObGYrS3dGZTdQSkV6QWRwMlhVeUthRjRja2xrQlNHT3V4aUxCbDZ0RENV?=
 =?utf-8?B?dFpFa1d3Z3FqNi9Bb0dEam5MYnRZWjZvVk91aFRxZkFhL0drOW8zcDcwTVUv?=
 =?utf-8?B?R0xpQ0R4bkNMbTZmb2ZlNTVVWWFOK21aODJrMXdtY2kwazRvSlh0N24wTXpK?=
 =?utf-8?B?amFyempVL0Rhdm9UMDlqbytXZVJZNlJsdW5pRW4yajUrZUN2cFhOc0o1b2xp?=
 =?utf-8?B?MkNlMFczWGMxMlI1WWRWcTk0QkYyUXBJTmc3NHVsN2d2UFpjM0pvTkR5bDZw?=
 =?utf-8?B?bGJjWHk0U3pTOSt1Y21EcWViTVRSRWdQVGdKOE1MTmg2MitCaXJueDVCSU9B?=
 =?utf-8?B?QWppb2pzdjNvSDE3SStzK0pTS01rR1l0QWJaaGJFUWZiMjhyY3A4MVFyRjV4?=
 =?utf-8?B?WTlrMWU4R2dTR01Md1ExYTRlai90cjdWM05pNHdCRWE2N0xnVVBVcGg1elhv?=
 =?utf-8?B?ekVaejdUK0J3ZGtmYlBXOVd2ZVMrQnRaOUlkZ01nbnA5ajRxZnpJWmRtenZU?=
 =?utf-8?B?blV3S2dZc3N0UlI3M2R6eng4UUIxNVBHNG5aQlNsMHViU2FWSXAxckdYamox?=
 =?utf-8?B?RVpqWXNEMFAyU0liazkxTDdTYmZMTlVMZUZjcUF3NHFjZjEyTVhXdTBFRjZ0?=
 =?utf-8?B?Qk80TjhURVhtc29tSDY4QURrVUlsdldZYktiTGNnVkVKcGtzaktXYVpaSUZq?=
 =?utf-8?B?NUhIOStCYW45V25hZXRNUHRFYkdRVVhicHZ5RVpLS3ZNeWU5ejBocmRpREZp?=
 =?utf-8?B?L1h0c0NTV21sOGFya0MzQ2lQNTYxUGJ1SmsvVVlsbXRqTjVjYk8valJnb2g0?=
 =?utf-8?B?MEFhd0ZnOFBqbzcvMTBZdzB2NnZVV3o3MENTUEUyTEt2Q0NwL2NFaVZnRTdU?=
 =?utf-8?B?RTVncG5NekQ1T0NoWEFMdk81TUl4V29hZUVXSDJ3ZlJ3aHVnVGxQcHN6SEFR?=
 =?utf-8?B?YjlQVmZ4enJxRWxKcnUyd3E4T1cxVXIyRzMxbzBGcWlGSkpTcWYzUXhaTzQ0?=
 =?utf-8?B?NitPR2hIWEtOb3hjbENuVXJSVnJpWkl0VW5vV1VnNFJMWThsc0JVREUyNHJs?=
 =?utf-8?B?d1FsaUZVbExtb3lIWFpyR0Y0cUpRb3ZuZ2hBRzNhODl0UjJ5dXZGRGJIRk10?=
 =?utf-8?B?dnZoTkVjdVJHTkFqQmpMV3loRnR5eXNpd2hVTjFFSEdTMFE0azFVM2hhaTA5?=
 =?utf-8?B?RndkYW1wL3BlWTIyK0U4L3dTTkpWZ2pQVDNUTXVWeHo2WmV6Ri9jSHAzcVUy?=
 =?utf-8?B?UGlrY21QU1dYaGFGS1lyR2IveUpnblFMVTRzUm1FV3hPU3JPY1JVMnZsbmp2?=
 =?utf-8?B?Q2ZvM0VKWjg3NUpMK3FhYnZFTWN4SHhXMDdlRmcwUEpNWk5hMGtJN0hlbnUv?=
 =?utf-8?B?S091emZLc3RkOTJzbEVvN0luM3pTYlV5U3JVN0EzSlVLRCs5bUZFWU5RSnor?=
 =?utf-8?B?c3NLSHEvY0kvY3Q2YkJkTXAzVWRIcUh4U3A5Y2IyeTEwMERHa2xjYVRGN0lU?=
 =?utf-8?B?R0NteUtwaEhnRWo2RENWcVdOdFZlbmZGVFBOUWF1WW40cmhTaWQ5YTV3ekNt?=
 =?utf-8?B?dkYvQmdubWhiMW5zVGd1dDdDeEIzTzRoT1lrclpiUTFNMjBRUkdlNXZlbzFM?=
 =?utf-8?B?VVFSc1Y4MC81Rnl0ZkVuQWNvUnEyS1I3cGlxWklQMDMwcGt2TEIvNFQ4SDdE?=
 =?utf-8?B?WWVLaDRKYkh0ZFg4WHE4QTgyMklpbTNHNS9GWk54TW51TngxSFJZOTRwN1RU?=
 =?utf-8?Q?akG4C/ryGGkTKKBepraiz6IALynxt6RW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlaeGx0NWdZK3pSeXcwSmdXaytZNlN3STJWZ1hYY3RFS0xEaERFS0xtT2VS?=
 =?utf-8?B?MU9xaVNZN2lpVVRpRnFzOVRVbkhtMUQyYjRKajFVcURPbWtIZjlQaUwyNVpY?=
 =?utf-8?B?UHp3b2I1eE9saXBVTFZwemtmRDdPRHlBdithVHIzU0cyc2lVU0tDbEM2R2pm?=
 =?utf-8?B?dDgwdUxpdjNBOGM0ZzE4WUpGV2tWNlZpUEcxckxnWkJRSmtDdnVmYURSTTRL?=
 =?utf-8?B?ZEZsQURRWSttNzZJWmE3aXFPQmh3VXdPMGdORlVKTHZQMmZ0Z0dzRmRiTXhk?=
 =?utf-8?B?ckd3RTErdS9HQWxlbXBpV0dNemlzNmFta2g3ZnVFMmlGV1RDcUFJWmc0Y0dI?=
 =?utf-8?B?SlBTQ1gyaFVSL05tUTVScU9jeDJtdkFIbnZlSVNIR2RTczBXS1hxMm8zdTMx?=
 =?utf-8?B?MEpBMkF3b3haS0RIRDlUK2tpWnl4UEk3anBnd3BMMEtPcXNmQkxyeXBscmhx?=
 =?utf-8?B?S2d4TFYrUTRJbkRzUk5XenlwS2diZDd3ZGRhL3BBMFE2cDRCN1RiL29SczFh?=
 =?utf-8?B?YkJrUURLRFR0L1ppSFVhUzBYRGdieVpNODBRMU5Ib3U0WVFGeUJsQ05mL3Ro?=
 =?utf-8?B?aU1lbVM1Sm9KLzkxbzZycVpqN285WEphOWtRTFYrc0dhcytUNkwxUE03NkxX?=
 =?utf-8?B?K2hiT1lRSmh2eTBhdStkd3FhcGlTQWVvZG45ZjZCaXVqOEhwZzdIQlNTdFRQ?=
 =?utf-8?B?aWIzcWhwR0FvSVFEQ1hhRExsZVFzTXlnYkZMUVBwcGlRVUJPekRKYjZaVkxX?=
 =?utf-8?B?MWlHcTV0UGVDOVRQY2txakx4TllSem1BdEQzWERzbklNeXFpclVScGhoM1lq?=
 =?utf-8?B?QkdCbTFNYmZucGwwUy9oVXN0OGZ0dE1NZTRSNlV5eTNZanVpdjdRUHNyMFU3?=
 =?utf-8?B?bUVNTGhITXBqenFRRDZ1VTc5aURIZVZZSkhnVE5GN1Ywb1U3djRURVB1WHpV?=
 =?utf-8?B?YkZ3UmhQRUFPS0V2Tm1XcUl3N2FiT3Z6dm5kZXFRSVNQa2wvZEl5NCtFMUxr?=
 =?utf-8?B?Y1FWRHJ6bzZvY3VaYSs0NE1OSWxzSnlGTGdzaWRiNlU1dHJJVVJKTmhxUDFz?=
 =?utf-8?B?c09jZi84bTNtNVVhYms3MlZlZUV4ZXdNVzBrT2J4am5JeFd0dk1XVVJFYkph?=
 =?utf-8?B?aTJwY3ZEZjg0YzB6QUlBT2ZwVUMraFdZYUhaMzJnRHR3OTQ1bCtmUVRIREI5?=
 =?utf-8?B?bWxqc0VSNXZRUW1yeHJJeU9PTjJWVUxDblhXVkN5dW9ZV21sYUZ1c251dnd2?=
 =?utf-8?B?MGsxYjVtdExQZ2RYNlNtd1Yrc2orMjU4TnhLNm1HNENwVFJoTEdyVG43amtD?=
 =?utf-8?B?SDk4Vm1iMFAwR1JheEZHZ3MwZllhVXFWWUx6dGwzTk4wbXZQU2hMUnVDNFlX?=
 =?utf-8?B?RDdKSnVaSFRSdGZ3OStPS1oxMW1tSFN6WjVqV051Y0NPemx6RFAyT0QvbFRF?=
 =?utf-8?B?c2NSUTZqMnByRkgxR0FDQ0Rkd2I0bGltTEpMVjRnSGxJQmhwMTN6Qm9TYU0v?=
 =?utf-8?B?dDg1M0lnaHYwZWtHUlFpUE5SdWsyc0ZMak5sbFZCTFlRR1J2OWZHWURHdDZE?=
 =?utf-8?B?QnAvbHpnbzJWMVdFcktmU090V0p0cXJjaWsrY0I0cUFjL1hPTzJ1dW1RUGNv?=
 =?utf-8?B?aDZqMkZLbGFEQ2JCT0Y2dEFRRDBsWklBVnByTVphTGNhMEVWTk5aT2lhdHZJ?=
 =?utf-8?B?MFRnbjRyM3Nib0JQa0V4YnFXTk8rQ3pwZ096eHBsc1hLZExyZE9EUmlXSTNm?=
 =?utf-8?B?OFNqTWF0cHhEWEhxQWZBOXJuZ0lZR2ZNM0hnYXFXWmtDUkI2YkxNd3BSeS9w?=
 =?utf-8?B?KzYwVUVHbytOTjBDL2R0cTdwQ296UmVqdFVLeVltUTNaQWY1UlYweXNyOWhx?=
 =?utf-8?B?bTRxQmgvMWFMZVM0akNjRit5blZ4TzBzaWxPbTk3cGt2U3FibTYxNXNXQXBF?=
 =?utf-8?B?SDROWTNQREJsMnBtK2RLVEpxeFJqcmg3dmJKdDlPSjB5SXE3QWQxYXljMCta?=
 =?utf-8?B?c21zelBzR0UzSGNTbU1LWWdoWjJQSTRxL01yTjZXanhTRVBxUVQ2Y1V3Tk4w?=
 =?utf-8?B?U004Ry82RUtoSW1nWUZQVzVDcTFLQ0RmVFp5N090ckVwZ1NvR21PdVBsWkgz?=
 =?utf-8?Q?RaBHXklltC2jzhBWrFjnXOcb1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c25a97c-683b-4921-81da-08de0dc84922
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 21:58:20.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMuaLZz9Y6xw20PxnNIx7bSA5qNdkmseAak3Lzvi4IhGhUTg5wrXK6W0cSSUHGbfUm/LjJFeJdL30ZxvlyTvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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

On 2025-10-17 14:33, Ahmad Rehman wrote:
> The patch adds the sleep to yield for the runtime to act on
> the EXCEPTION event. This allows the runtime/app to execute
> actions on signal reception before driver gets a chance to
> move ahead with the sequence.
>
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 82905f3e54dd..8dfb796fd506 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1329,6 +1329,13 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   		}
>   
>   		rcu_read_unlock();
> +
> +		/*
> +		 * Since the set_event is asynchronous, putting a delay
> +		 * to give runtime sometime to act on the EXCEPTION before
> +		 * driver moves ahead.
> +		 */
> +		ssleep(2);

This adds a 2s sleep inside a loop that iterates over all processes 
using KFD. If you have multiple KFD processes running, that could add up 
to a significant delay.

I also don't like waiting before the srcu_read_unlock, because that 
would block other threads synchronizing with the kfd_processes_srcu 
(mostly kfd_process_notifier_release).

What exactly is it that you want to prevent "moving on" to here?

Regards,
   Felix


>   	}
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   }
