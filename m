Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F165CA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 15:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4356110E53E;
	Mon,  8 Sep 2025 15:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GpiqekQ0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAF310E53E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 15:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8xlPmGla7+G+kgO/b5/do/VZzmJdbMpYA5ilIcn8Jb7lmZmr8aDZVtv4Uq9Ql+G6PXHF72FlqbVPi9jy95lov9AJAdF0z3UICxdFxG/MATeKqvOd+VGSI6wVOgO8rHlcLwq8ThR7iGfclq6udrPOhjX3arlbroYDHIY3a9lHk06NCwndJIoOLn6yFH5WEfm8mW52q9uWc2MtHCRBpKfb3RNz1gHDVwgY9YqXRlNYz8B47/ty4oNaQU1yh2PkmuQv0frSsTFhCfsTwacOXq3P+GD3NRB4HWBsOpqgTTGSVwKPYhIlsB3RE81zAW04r9CUPekxVP5RFHx8r+i2yOkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V9PVTpHn3i//rQX3XPLTOZT37asFM37hQ4kydjqwx8=;
 b=xYbzf7rEeUU79j6yt/QAGpKEs9tOp7QseVfeHB5culhTDy5TDHjvBDRztDmPQnFJ58MMZVxxp6WY6hg0XVFWMjpvZD4EJ5AooHGsJNBG3OfTlSA2LL7B57EV+g55cqRL5D0N1t5aRFpbopLlQX4PnbRYLcRBzeXXElFwkh+5RsG8zDqzGHR+0eIkspY3Yi5dpttDbOCt4/jhl12q3PqPn8OdamUPyxyGTq5WK7wf+kXWUMJWdqI75bUIDQFAcOtpTBL1lUHUVs8VCpOlAjUVcD0PS/SpiB4IWWc36YQJKPgWftCNW0syZCg3K6Wq1ghegqFKB7RwwG6/IEYfcazsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V9PVTpHn3i//rQX3XPLTOZT37asFM37hQ4kydjqwx8=;
 b=GpiqekQ0dpurqE2r98Bnx/53ege5DznET7AYuCobW+fNLsf4FOARdRjh1vmstIvjA3lfG7zX/ZauB9RbI/X7WXlDp+SvT7W7BoAjxKPvTcwVuGZcjPw+z39RAVWJpRNGEBcg50Qj/qTFvwRgY/XiWMrieow1tzbN9BK5ygcuRL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:41:28 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 15:41:28 +0000
Message-ID: <dced9ae7-78b7-452c-a1c1-4b546977a31c@amd.com>
Date: Mon, 8 Sep 2025 11:41:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use udelay rather than fsleep
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Wen Chen <Wen.Chen3@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20250903164402.4002993-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250903164402.4002993-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 955f0ccf-b024-41c1-29e2-08ddeeee2d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHlVcVdrS2phYWpFdHJ3Ni9LcEJjUlU2ZjRTNU5FdEpZTis5V09LMzIzcG9V?=
 =?utf-8?B?SE9OVmZObnJoWFFVRFZIbS80OHNhSWlPREpVaUMvZTVma2F4UEJLNGM0U0V5?=
 =?utf-8?B?SVVUdHIxbUpsQVlJcmFXbDJlRHdocFZQd1Y4ak1peUM3QXp3Q0pHTEdrVjNH?=
 =?utf-8?B?dHBHZHFvd1FicjkyTWk3SnlWOENWcXZmRlp5MEl1dzBFQ1VhbnllS1EvazdR?=
 =?utf-8?B?WjdWa0dzNEhuQkRkK2xudlBxZWxidnJ3NWdueUlyeUxRRU1vTFUrek5JSjd3?=
 =?utf-8?B?aWRKN1AzQ214bjNtOUtYbWZWNDdhbkR4UDhBYkRDNnJGSm1HMDMwNXYyeHc2?=
 =?utf-8?B?MXFGUmh5b1E5MXdZaytLK0xSVEkzYnVpWHNVOHc3ZWgwZTRtV2tIVkRFRTBZ?=
 =?utf-8?B?M1p3bkNlM3c1OFY2TGJ3OU5ISTJlbVlLRnhwYjA3YjZpVUxEWms3Sml4Q0g0?=
 =?utf-8?B?d0drN2o4MCt2ZFluSGkyd2U1TTZDdHlvTHluNDVkbVM4Nys3ZHUrVGtmYTBK?=
 =?utf-8?B?bW9wQ1hUaWRScTJGdFRrTm1zQUErbmZuZ2ZrUVg5VWJmY0dWbjk4OE1xanVS?=
 =?utf-8?B?WHA2NHJVYzI0QXNHK2ozZEJDTHhBV2NlTlJkNml0QWQ2SFV0R1FTcnFCa2U2?=
 =?utf-8?B?NDl6YlhsL0NEd2lJSTJ2U0tHU3hnU3pQODdNckZRejhZbnVvK3ExSmp2L0sx?=
 =?utf-8?B?Ykpkb1pCSzNFdnB6STRRNkl1NEcwc2pwdVFETEU3N2RHWFQ1UlNJQ0g4dis3?=
 =?utf-8?B?Y0lnQnFKcW1GekNVbDlETCsweGs5M2wxekQyVEFrdGVPc2diU1FNSWd4NW1Q?=
 =?utf-8?B?NFJhVURxZmtMZlNDRzJvNm8xZFRBWGM1WjllTlpPdjlFWWdBejdJbmh3R2hB?=
 =?utf-8?B?QkJaVVhJNzJ1LzNzOHluSnl4ditqa2lJSVpxdWYweUUyWENpaVJoU2VVZUlw?=
 =?utf-8?B?OVM5Nlh5bFBpT2dmZzVkanZEbVRSZ2dPQlllMERvNUVNWlpkcUtGSHNwUFN3?=
 =?utf-8?B?dW1ZTWNqak9HMWk3QnBsdjJkOEhxZ04rUmo2ckpuRmI4OWM0V1VWZmx5RUUz?=
 =?utf-8?B?bjZCZlRoVG1qaUg5bWRuY29yK2ZGUDBpTU0xc3RrdE1YSlhMR0s5aUZ4eHdV?=
 =?utf-8?B?Tk5TckUwdWFVUmhXUTNIeGVEWjRYcDlkc3hQOVFvb3p5QmhLUnkvMU1Ja0Q4?=
 =?utf-8?B?ckhoRzhTbDY1aW5odG83SFRDRnFNNjJBSWtlNXhpOE50cjBQcHc4UmVvbHdY?=
 =?utf-8?B?MUFDN0xrcFBPUXo1QWFablhpZndaVGRhNmZ2VHQyRW4ybUpHTXZ0V0d3NHgr?=
 =?utf-8?B?TDVMQjRwb3hlbXNIaUdsMUd6Z1FJL3J0cTZ6QWxJTVZXRFRsb3o5ZlNDV0pW?=
 =?utf-8?B?NUNmdXZIRTA1cXlqdHdkSFJtOVh2ZDBReDhOdUZkcjdycXJlVVBOMWJYV2Ev?=
 =?utf-8?B?ZVordFMreEUvQ014NjRlYTd4eHhUd3VQNnZRZkFITG1IUDFGeEpRWmExd2kz?=
 =?utf-8?B?ckZPbXRQVWwvN2REalp1TkxFR1dYSitRUU1oQ0k1WnNMSzU0SGtrZndTb1E2?=
 =?utf-8?B?YTRjWHc5eFo3TXJxbkYxSVZuR1ZqVWprQ1NiRGhxeXI1L0pNc2l3eEtQOHdz?=
 =?utf-8?B?VkNibHc0MFpBbW90SlBkZStJUTRzRnM3V0xldEVGeXJ4Vk9vNFU0QTZLSHkr?=
 =?utf-8?B?WlhDcW96VFdCUDRuQlovc3JVZ1dqcmEzaDdoSENhalVEa3ZkV0wydHgwYkVv?=
 =?utf-8?B?VHFaYUhtVm9JaWVya2poMnFjRGI2VGJweS9Hckp2TDlJVlpHeklyRHdDdVQ2?=
 =?utf-8?Q?fM88WbkzS2JQcuaYXFU+1sR3eNV36CHAog9TI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhENVBzcEFPMjRLNU5oNmwxdVA1dnoxQVhxUFpldWo1MGVKUEtFY1lqYWFx?=
 =?utf-8?B?cWtNcVJJQWR4dmhoMDl2YlJScGliWGpjTVpGMVVOcXZTWnZSNjNZcFpBNHhk?=
 =?utf-8?B?eGE2OGtjMVJ5aURKZExOZ2ZpT3dBZC90aTVpYmh4VFZUdU1oenhoVk13R3c4?=
 =?utf-8?B?MXgzSHBrNDdjU1o1dWF4cnA2K2kxMkkvQzRqc2pJcjc5b3FnOUdjUGpLT0tD?=
 =?utf-8?B?VjNlMEJjY2cxTnY5VmFwcGFCUXBTMkphb1V1U3JJVkpmdXllM09GSjVuWEhB?=
 =?utf-8?B?Q3pHYnVScEhaN0hpNnNOUFNhd3pIOGR3OE42OTExVE55RlB6WXJnZGVPKzhl?=
 =?utf-8?B?eEkzYkpETE1SQXd2Vlk1UVE2cFltR0RKdThmZEZCSVhjUVkrYWZEbG5aWG1m?=
 =?utf-8?B?enNDWkE0empHR2lIY0FaNGw0QWNGWDVlS0dnaGUzZWlPcjFLclpmUTk1UUpO?=
 =?utf-8?B?cUJVVWN6ODB1V016UnVqVjFBd3Y3Rm5NT21iMmEwUDN2MGRoVFE4aGJGY0hs?=
 =?utf-8?B?OG82RVRhQTR4WFJSWTk1Rk9PZG02OTJETVhpMVI4S1ZkZWF2N2l6TTZOUk9s?=
 =?utf-8?B?bFZsNDgyNHo5OHF3eHdrdy8yaXoyNGhJNHpqOWhWcXNZbWI0QlBWYk5DU3Uz?=
 =?utf-8?B?NDZnZWpkZ0lwazZYRnc5MGM5L3JVQ3JHSm9RQzFhODlGU3BlWlF0SUlvcWxL?=
 =?utf-8?B?bktGYmR4NVgzNXhXbkF2U2hHK0kzSDRmbnFXMTlQbGd4Y2dhdmVLSHl3aktC?=
 =?utf-8?B?RjVMaGxQUTIrcy8wN0VlaHJWUVJGU1lZTnZNVlk1QXQ4OTY2T1ZlM3lDSTJv?=
 =?utf-8?B?a1piejlEdHF0REwrUWZBWGRwc2NkWnpmSFZnWTNiZStpNDhtcUtNSVVvTFd2?=
 =?utf-8?B?UEFqNjNVOG1UWE9FRXlrMzN5bWF6NWVqVEZCODF0MWh0RERtNzMwOXhNZzRi?=
 =?utf-8?B?OVNicWIwYXIwMStCNmE5SFJEL1Jta1J6aXJiaUdFY3J2ak0rYXgybVlOK05y?=
 =?utf-8?B?NjZ2c0hMVmcrZWpYdXdOUjJrN3hicmJMSTAvbytwQjYvNXJRaHljLy96aDQx?=
 =?utf-8?B?d3NPenFnOUxRZk5yZENkd0NmUVBXbUpSNWNNa1EvQ3Bjci9PazNLZlo5Sm51?=
 =?utf-8?B?Ylc2eEFuUTQ3ejNVNHovZ0NkQ2hqNVkrQzg4cHJpTXkyWCtYV0srUWg0QlpE?=
 =?utf-8?B?bVk1ckxiSHkvU0VtS2xZZis0NjNlakRIemw3TG1MQ1BIeTcweVl4NjZDblpn?=
 =?utf-8?B?cUR1MXM3Tk1xTFRaeWQrb2F2TU5nQ2ZVZis3TXlUcWFheHFLMi9qQlZXRGhy?=
 =?utf-8?B?b3IxYk04V09aTmtXUEgyMXU1a2pTeU5NS01pblR5a1pPZVdOYkwzVkN1bjEr?=
 =?utf-8?B?Qjkralp0MlZaekhmemxiZUEySEFEbklheHNSeTkzSG5yMVRSYnQweVZKQUww?=
 =?utf-8?B?RnVadHlqSDBpa3Z1d0VUS3FrWTVTN1FQb1Vqa1oyTEFoVDBFak9xMmVRcFhT?=
 =?utf-8?B?K2FMMndSVGpWUWJIRGRyUXN5aG8xVDBLbnpJTjdEV3RxY252TElBVWd1QVRV?=
 =?utf-8?B?ZEUvRWRsQ1Zyb3lHQlNLKzlhWTAzV3JVSVhNZGdxVDNFbjJVMndaU3ZkaFpm?=
 =?utf-8?B?VC8wTzN6U2MwZ0FyRWRoUHMvY2hicGpnbjloMzhoeFlqS0g3SEFrVnZBZTdK?=
 =?utf-8?B?SjhKZXZzL3NVNHhBL29lM3kxcU5RNDI2MFM5MFN0UDZxdThza21IenNDMlJU?=
 =?utf-8?B?SFpqRUlOcmF1c2R5OWhFZFkvcFRzWXA1N2swaU56Z0RNT1JxNS9uSzlxQkI1?=
 =?utf-8?B?MWhRam4wSzd1NS9Od1drbFpmekhRWWFUamVKYUtyK3VGWlM4d0NFSm5kUWlB?=
 =?utf-8?B?anFndnFtZUozWUhVK1VqNXIvZ21WanREMXgyZzBwUFZmbnN1QVU0TTIxdzdy?=
 =?utf-8?B?REN6QnVoMkwwKzFwc3lhK0JkQmZMdnpoMDRPUVR5bnF0NzlRM0JrbVpmdHpB?=
 =?utf-8?B?NE5mVWdqV1JyUUhEYnhDYlppUFN0UDJ5RFJoYlA0ei9tVkEyczhzQXpxbDE4?=
 =?utf-8?B?VWpEMjlxUmVqOU5veG9lQSthalJpMy95eGh6c3N4MUc4UjlSc3grQTNSaVgw?=
 =?utf-8?Q?aDMV6jSWL+xW8B43OIqkKgp84?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955f0ccf-b024-41c1-29e2-08ddeeee2d47
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:28.8401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT/aBPeW3IL89KFPYAy+G6iDeyZFW6SGP3L+V25nlgbBUznASVtbGGdHR7K86NpKoUEo0E2szpYJOvLXOARm2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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



On 2025-09-03 12:44, Alex Deucher wrote:
> This function can be called from an atomic context so we can't use
> fsleep().
> 
> Fixes: 01f60348d8fb ("drm/amd/display: Fix 'failed to blank crtc!'")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4549
> Cc: Wen Chen <Wen.Chen3@amd.com>
> Cc: Fangzhi Zuo <jerry.zuo@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 7d24fa1517bf1..cc377fcda6ff9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -955,7 +955,7 @@ enum dc_status dcn20_enable_stream_timing(
>  		return DC_ERROR_UNEXPECTED;
>  	}
>  
> -	fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
> +	udelay(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
>  
>  	params.vertical_total_min = stream->adjust.v_total_min;
>  	params.vertical_total_max = stream->adjust.v_total_max;

