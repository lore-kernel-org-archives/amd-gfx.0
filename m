Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EBDC52D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 06:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC62A10E2AB;
	Tue, 13 Aug 2024 06:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pCYKtfw5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08FC310E2AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 06:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHjf3bbRg4DCXjUnugIAxea+MouAv06fKSJhKxEIhJdQti7y8Jzd7EKe05USZBIpTfEiy5xge4frSPV+oBiqmEv33ENuyLzByd4qartI7aML7EU76AiypXg9AXFptyk787TW6uSFxTUVQ4DfxXtgR/Dim8VI/8d8bz1FF8kAb8IRu/iyX3Qa6NPse5aUaZtxw1IMoHFTHTlqMbaNBN/CdkUhnxb1qQXy0eBjroRVauiTyGhoFdx2jODA1Yd7LprCxGfqrqtbvRec2wqqp5OjhVocu/6OrvrMFYF/t/Hsz3vtNdKtrxgCD+TpAQ1JEkm5y7BJthEpAfNx7d1hUhZEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GYzlrMiBch6g5Z69R6kCMf+9vSQsFnzZZEA4HWrWKc=;
 b=WmQ4NYVagL/YvOo2se9nhySYOclaKMwoIBPxknoP1mTs5VsNjFFvcwdWmQdcQQFJcZYrGG0QJHSYuDLDN3KMjADKlVKSISLrfGR9EA3yNMeus2/cyN/jgUMQcvU6RytqwqPFwkN3gbzh3EEZG45sNrE+EFHsOhFGKA8J9goOrN9zgsVWOrFaaOmbuxXRVf9hJF6V5mfmUVu8KkzQ6BE4KtgereYAQ0rAjXIak6zJGsTtLqJzlwMMcBy9NfK13lUcG0T2OCwxBziYvaKR+xZ1Zc7jCQkGqGfIgxgIoufPcy4iaGBqCxjWg6+zyTcqKyehhJEzEsOn0j3eFkIL5i8EtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GYzlrMiBch6g5Z69R6kCMf+9vSQsFnzZZEA4HWrWKc=;
 b=pCYKtfw52fToBZ2FoY9eG+XAhVTTVvI32KaCrvtosYqP8ccnPbPd3zt8jvypo8c0B9ZpX0WVuiBKeCciViSroBUjO1B/VDwD/puYi6KxTnFT/AjqHPya0sABHbObI4GgnGXkLA2wGyons/BOzXBxmlE7ay6h4z7oJEOtHxtiqLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 06:05:41 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 06:05:41 +0000
Message-ID: <a731fb0f-99d2-4c9e-9a57-c527cbc692ec@amd.com>
Date: Tue, 13 Aug 2024 14:05:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Align hwss_wait_for_all_blank_complete
 descriptor with implementation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240812104023.3744443-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240812104023.3744443-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:4::16) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 67917345-3482-4edc-bf73-08dcbb5df5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkMzU01DcTRjM0RVSDdiZ3A1ek00bDVmbEhkaVRlV1lvcXNlME82T1JjMFdn?=
 =?utf-8?B?VkZVUHFsOUpSL0JVd0Z5eHdyQnJXdFV3MjhrMy9FVEpsMFRoUFl1RW5OMVVh?=
 =?utf-8?B?UVlLOVcveWM0Y29HREVybmlGUGh1eE9aWG1Ha3M5a2JvaFg0NmtXeUlDUE9k?=
 =?utf-8?B?ZUhXVVA4QVhIbnF4OE1XY1RqMTJENHFuaExXejk4Kzdqa3dsS1NuZ0JrTHhy?=
 =?utf-8?B?YkMzMTJTY002Q0lhc25zdTVPRGVLZzJreWpWM1ZVdXY4Qi9LS3FMOG1yRXRS?=
 =?utf-8?B?M214bk0rdUpGcnBLY2ttVEZtcFptVXFZRHBiUk5GSVZLQVIweGw4Tm9LWEJa?=
 =?utf-8?B?a29jOUZCaVNxSlYrU3ZYYldkVWh1K1hxMkc0blE2NnUwcVBremZiTW1mblR1?=
 =?utf-8?B?OEtUN1N2alZ6d0VXS3Q0NVdxNFNuYnpZdmxXdUE3cXJNUjUrVWFEZ005SmMw?=
 =?utf-8?B?RVdZandWV3RnNjNNdTdydElibzExVnpWWHFqR3F5M3ppK0xBTFJnWExqemtB?=
 =?utf-8?B?WmpidWhzL0NDVWoxZTJvRTJJV0EreXZ3cVFGeEF6Nm45azk3Ny9WVEY1Q3FY?=
 =?utf-8?B?RWh0TnhHS0RONHFKcU0xdVZQVTNmajJVMmRhclcrRzZldTFyb2NuczF4TFJJ?=
 =?utf-8?B?b0JmeGx0NkcwdHZoMnpNL3JycUpETTVYYWJYSjQzQWYyK1c3VTdRaFNuTHM0?=
 =?utf-8?B?YXFOdjVJSEVibUJuUnY1MU9VZ3BYSUpxdkhoSm84S1BzU1JoU2xsR0toV1N1?=
 =?utf-8?B?dDJXaUs4U3JmT3FOTzlvRzMwaS93dDJON3pBRGtsdGYyZElYdDQvQzY4dElD?=
 =?utf-8?B?WTdpSzdzVWlxMlRhWnVPRjFVSUkyRlFPWHRDU3BMZVpmUitvcDFoWFhjZjRv?=
 =?utf-8?B?NlZTbVNWSjg2VTdsc1hTbE9xR3hvU28xRUc3V2hkK3NuUlIxSEh3ZUVpNkR3?=
 =?utf-8?B?MmU5d2Vpc3FPUTJQVGVXWFpCVjVGSmZyQWlQdmFSWm9XUmVnOTdDenlJUnBF?=
 =?utf-8?B?Wm9MVG93MWJVOTExKzJuNC9Sa3JhcXRvWXRDTWNhVXhZZXlYMlhRWS96RTV1?=
 =?utf-8?B?NmtqVHJ5ejVxMFBqUnRtSmZnVGhwTXBHd2VzRGNiQUJxR1N5c284K3dJeUtj?=
 =?utf-8?B?VGRMN2drT0JZSEp0YTZVQURQbXBHU1dDNHJwenhMc0w4YmhRcHpsc0U5UFZ1?=
 =?utf-8?B?QjhmWUh2MSszOURSSlYyUWFyYmV4Mzc5SURyclFpNTJveVVlWVljS1ZRWitw?=
 =?utf-8?B?N3ZnZXZ2bjQrSmZOcWhBLzJCT0ExYVNub0VIS1Y4UmFIMmdYK253bFIzRmlz?=
 =?utf-8?B?TTBnaFlDYU14K0V4KzMzNjNaZ1BvdWJGbGRkN01DSkpQRGpETmRGV05ENXBr?=
 =?utf-8?B?VDRqV20vcnMyeEFYVWtlb2dTTytoNGVoYU5XeElmK3RRN2QvMjZPUmF2OTFl?=
 =?utf-8?B?M0dFSm5HTUFVSHNNTWlwR2ZUT3JSQklOMGlKQ3VvZFdCM2JIa2ZIWU9NMERU?=
 =?utf-8?B?N0dVYUgyT1oyNXNqSlB4QmozMG02Q2NXWjlQcTBpQ2RwTkhxYzNXRzZvYWIv?=
 =?utf-8?B?M0ppYWJyOXhWY0ZzUUlMQU0vODRiVnRVcm5aNHhLUUVYMkJKeTZIbTRpcTF1?=
 =?utf-8?B?eTUxcUpCN2pHb0U0R0JkT1NkdDEyRmdpRVN6K2VVM3ZRdUwwQVJMMHhzZmFx?=
 =?utf-8?B?QmZNKzVDU0hJbWJ2c1BzMURLSVlxSGZxbElhZVpzR000NEtuU2k0c0FuWng2?=
 =?utf-8?B?MFQ3cmtvZGxNRmhpemkzdWRHTm84ZVJUWkcwQ2UzdTZtcVkveC9QQ3FCVjlF?=
 =?utf-8?B?UWQ0U2RPVHFJOHg2K2h2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0MvRy9XVWNIdzF1SEM3RzQxTStkTEJqTzVzdk1ZY2RMbWxqRzI2YXhmNWRR?=
 =?utf-8?B?Kyt3M25zL1ZSa1NjY0tvRGNab29JWkJHN2Y0T3lueGZsY2NobVFoZ3Rzc0RY?=
 =?utf-8?B?cUhZMUQwMHVOc0tOYmV2TFdWeDRkbWdBYys5cjNoaklRaFVlVFBuSlJvSjc1?=
 =?utf-8?B?UUxaSXJKdXpuWWNyR2VpZ2tpd0hsSGplN3ZnQks4eVZwWXZXVmduRXFGMDVp?=
 =?utf-8?B?aEpNdE5jZWN6K0FodTk0MEQxODdmWGJ6aFVPYnpPWllGMitWZlY3T1dCaWNY?=
 =?utf-8?B?Si9od3c3djBPbFVXS0ZHWUszVEQzSWdPaWxERktGQzJyK0NMQmR4czVPbEs5?=
 =?utf-8?B?KzB1RVpITGVxOUQ0ZitWM0JKZDhLT09sTmhFRFA1cUpvWWJsUWU4MTZuUFE3?=
 =?utf-8?B?ejJ0WjZpUzJhNXZkQUlTblhFMnRISTZFazhGRFR3QXdiY2dXeUg1YWtqcEpM?=
 =?utf-8?B?ZHprbUxRWkszaW8xVG9zSk5YWVVGQ1EyUkhlYmZOMEcvMXZTcFJpVW5TcmpT?=
 =?utf-8?B?NmpxUUY0clpnRHMrK1hQNFh6TUQwejRRMlk2MzNrQ3IzQTVkcW13K2pLRlcy?=
 =?utf-8?B?MmwwTkxWejg0VENNd3FYNHBHTDlxRDlocEJWZlFYc1Fua3lJMW12bTFwK0Qy?=
 =?utf-8?B?SlNOVmlaVm4xblpkMlZEVDB0YTVDT0JKUDhZYWMzMjhWZXQ1UDlrSWZ4bHU1?=
 =?utf-8?B?ZGxtNDd1M2grSG53bTRXRFd1Q0NqR2dxb2MwdEdZTEE0VnRGWlRpRnV5LzFO?=
 =?utf-8?B?bEpWc3p2THdHckl1MnlIV053czhXVEhSNHJnVkJoNFZnQ0RSTTBIaHdSZ3NY?=
 =?utf-8?B?U082K1B3cFJWOFMwaG5DV2RHVHgwRmlwMzQ1UFZBTnczazRUT1IxMHczY2lj?=
 =?utf-8?B?RTBURVEvM3RmOXUrVm1kb3pVTXZDenNtTlJVN3haVTRJTEhHc3hta2drR1ZV?=
 =?utf-8?B?MEpsNE9FRk0xRVZUNjc3aFIreElPOXBVdW91Y0kvZXFqNUlmb1Z1eHZhSzR4?=
 =?utf-8?B?R1RUMm5BTG1OUnlwYW5MWHEyN0NSNzRYbFVVcUxsRlUyRUVlQWVLNGRQNVpP?=
 =?utf-8?B?UmFVbm9rb0lIcGdGTVY3ZUZMUG5lakRwdnU0NXk1SVJmcHFGZTRuM3R3bzll?=
 =?utf-8?B?VURHT1NzS0dFcWZ3TE9rbW81YW9jK2JxZ1hZNE9ZOVBPYXJPbXR2bFZCQ0tJ?=
 =?utf-8?B?MGErNjYxaUNaajQrV0YxNkZhVjZqSUltMUdGbU1GazNXdWdnSHZwWm9BcjJx?=
 =?utf-8?B?ZW03Zm9tZE9kUnR6Z2lZZVJ0eGdoRUY3SjVycFBEQ0lrbkc4RFhrcEcvRWpu?=
 =?utf-8?B?ejlkYVovZWtnMHdTRXYxMzQwdkRHRWpZZmdHRUZ6UGpRK3FRVUZaamhtbmhU?=
 =?utf-8?B?YzkraFprdUU3RGJqZittTmR2YlZ0SG8wbkxpejVDRDEzeU8yRjRRZE9UV0xp?=
 =?utf-8?B?dFpSUUpUR0hYNExPYVRmZDNQVU9XRmx2c3N4Rk1KVDUvMWNWN01EL2FKL0Fz?=
 =?utf-8?B?RURKNDBNVkw5bTlkTjhLSE9SSnByK0VQaTR3eVowOXkxVUhoTHhraFNGVVRk?=
 =?utf-8?B?Z2RJKzBteDhFSXFQQlJmdUxTQ3ZJQUxPc3lRUFR4bk53cHdBWUQzdUNsYS9V?=
 =?utf-8?B?V2lKVC9KYkF5RGNGMDRTUks1MFVNSjFYZVNLWDdXRWIrNTJjZjRvQXVkMm1T?=
 =?utf-8?B?Q2YvQ3czOTJkaUdFRm02V0JWeHowdHpjdDB3amk1Z0pQYWlsWHhjZXBrMS9P?=
 =?utf-8?B?VjRDcUFvbWlEaGxvd1RvS1hNckcvK1ljMS9kN1k4dHQ4Q2xsQ1BjcC90MHla?=
 =?utf-8?B?YnMyeWlCdzBaa21mTWgrOE5zNTlBS2l6cmt4aHRJWUVLdzlkbDdERmFTSW1I?=
 =?utf-8?B?dXExbjFLNmtJN1llc2pmRm1KQ0Nvd3o4VVAxK1BWdTRVbnVLTUh5Y0xhZHZW?=
 =?utf-8?B?YUZPNmw0L1ZBQVpvTGJ4VmdLTHJSTmF5VkFuV3M3ajlleDVXamhKVitqOGRM?=
 =?utf-8?B?YUF2OG1DbFQ3S3ZpZkZHUVBPaVMvUEp0WExaVTBVMlBIYkE2STBrN2RVeFZn?=
 =?utf-8?B?OHZQMkRXUDZ4VDVtWXlLZVAycUJsNHFvUGFXTFA4aEl5RXN6S1dobWNBeWQ4?=
 =?utf-8?Q?r54gl+oQbu58dja35Ib4i8BT5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67917345-3482-4edc-bf73-08dcbb5df5e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 06:05:41.4017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZoscyEzPEuBSJ1ZeuepbReH3gP8EDFi0Jce1MrarzZP3I8lEA4M8nq/FBjE9LpOY1r6hKh0M+i8aCX7I0Ajdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 8/12/2024 6:40 PM, Srinivasan Shanmugam wrote:
> The descriptor for `hwss_wait_for_all_blank_complete` was previously
> misaligned with the actual implementation. This commit refines the
> descriptor to reflect the implementation of
> `hwss_wait_for_all_blank_complete`
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_hw_sequencer.c:991: warning: expecting prototype for hwss_wait_for_blank_complete(). Prototype was for hwss_wait_for_all_blank_complete() instead
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 9a569aac3c00..7ee2be8f82c4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -980,7 +980,7 @@ void get_surface_tile_visual_confirm_color(
>   }
>   
>   /**
> - * hwss_wait_for_blank_complete - wait for all active OPPs to finish pending blank
> + * hwss_wait_for_all_blank_complete - wait for all active OPPs to finish pending blank
>    * pattern updates
>    *
>    * @dc: [in] dc reference
