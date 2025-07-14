Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BFCC83F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 13:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D005D10E496;
	Mon, 14 Jul 2025 13:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fOjpwE3X";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914C210E496
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 13:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMSmznxHeAbL21dLNrJre4/rNBrdxRzcpjGmgXjcw3WXH9OsIU1EDO9GnJHxo33xKbKvWkKQam/qwlk+TS7xIYNhO39JLBM/S0/jNzfBgwcRMt+PSz9bQiIaXaT4wRM6zukJPWoCZ6C/TtTE2/mcx5xhJTzudvnjLCGyfACKTQfDF6KCC6JU/OxgP/GBfUBL9XiIhDHylGwT/7ai03/U5IIWtWD9irIn8PVJo6c6O/h8M5MNxqNLrE2TMZ2RezXX8VXRHMSZknC13hxRhlHRaCBsMoqa8CazUm1W+TJVHZ6kdKtDI3UBbWVjkCf7v+PTh/kPXa3WxExfvIyX64c94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxyplU5/XPb9fJb0D2eEKW5gCSZWMz6nRwcWxdXkyXE=;
 b=gl6zQy3R/P2KrOj8MWh+7a1UhlnjcnSL+jS2gEgX/jWm5V7BSXZvmYgCNc6O0C7vc8eUBzk4AXVbcQpiQ8gYpf28JCqRD0NaUupA7WuYUIkWTe5YoFTu7vmjy6rtXul+AF1w/p4QZTHQOiAIWuGsY31NSxr5yCOkiCPPwqw/oO1prS0H1H5PxMPshlU0p4Y8iKJMR7Kue959CmlltRD8+43PBcWzX1k+ZS59SxyWFgTZF1IPttDfolM88jYMyMe2s72CtMTAuJ6LGx6kEeyzKSLAa2Heg6BhylDzhlpmVybzStvjYkWlhddXhHlAOjERWEyI6eddQ7FCXYh7mlIbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxyplU5/XPb9fJb0D2eEKW5gCSZWMz6nRwcWxdXkyXE=;
 b=fOjpwE3XUiAVa26c5G5ySmy7c35IymFK1UIUyGwU9Xb3GNl1GOY+IMSfqKG/NABGXLd93I++6pgFZEOyJBkP8Ay/lA9UHnJqKEQcj/qA0vse14VAjdh+BkuKM8Z0Ogx5zMRlzo0ZHbpeWdunW9ycIf2k7s3d3xPgMtvFvWaYiW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:27:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 13:27:40 +0000
Message-ID: <be2c1df8-3d5a-4369-adde-931184f77c2e@amd.com>
Date: Mon, 14 Jul 2025 15:27:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] drm/amdgpu: clean up sdma reset functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711224024.410506-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 716f1c2e-40d6-4d8e-0e6d-08ddc2da34c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmJwS2hnclF3SklqbmVNOFNrak1tTm1yZ1RHU0VjTTBJZkdmelR3cENsQldW?=
 =?utf-8?B?U3ZsYmVieEs3eUhieGpUYmNZOVFTRXZTeTVLaERvOWpyVnVPRk5nTjZSQWV6?=
 =?utf-8?B?NENrYjdkNk52MkQrNU44WDFNTTAzenhUZjIxT2V1MSsrV3d5bHY3Q1cvQUR1?=
 =?utf-8?B?c0tYV2hvczZGS3E2dEgxNWUzcHBOR0ltSjZqOFlUMWs0VFRma2MrRVYraml2?=
 =?utf-8?B?RW1lWDZucDhnZjUyYmxLdUdXa08xS1M0dlJuWmI1QU92bjEvQTlUcWpOUzhm?=
 =?utf-8?B?UXNpUEFXOXhCTEY5SWJMSmUzOUhJekVJam1TUFNLN3grRXBrK0FDK0M5QW03?=
 =?utf-8?B?bjBWSlBDL1BTZzZNUUx4VG1CTW5LdFRIM1ZXcm1aeWMzR3FGNDM4TTlFOFBU?=
 =?utf-8?B?QkFKSDhwWTIwZlhteFNMdkxKNDNhZExoeEp1WmU3VDh2b3gyN2ZaZllRZEN3?=
 =?utf-8?B?VVRrUzY0ZGtuQzVtV2lmVGhDNmdiaml1OHozQ281eXRnVXA0R3Z5TEJWOWpD?=
 =?utf-8?B?eG40VVpOQ3ZRNWNyUExmYkZqcUg0RXNiUmRsYzJZdmlweVNjRm9uRGhkVHhn?=
 =?utf-8?B?Sk51dU5IZURVbzNoczMzNktkRWF3TUg1eERsVlpwV3FXS21GdlNBejZZMFR1?=
 =?utf-8?B?RjAyL1hjU3NRVEhHTlVzcTVhNFdzZ2tIY0ZqRVpHaGRrMEhLN2xpbUIyTHh6?=
 =?utf-8?B?TXRhcUxoZExHV3JCaUNocGJJd3cweTVCZEs3VXRic0lpQ21NOW9BemZXbFlT?=
 =?utf-8?B?b3FNTUlrbElBMzAxZ3dNT1VvZTBRVElDVWllNy85Nkxxa3E1NzczZ3E1Tjhv?=
 =?utf-8?B?Mm54SGxzc0RyeUtqRm16YmVVdW5QQ28wbHRMMm9BMkFITUF3MTIzZVdMMEow?=
 =?utf-8?B?RFNOU1A3NTh0RHZTaDdvcDJiRDE5cVp1akdSODJhY2NoMlcxNUUyaThnQjBC?=
 =?utf-8?B?a0RvR0hXUjBxWFI2YkZXWXowZEhRcjY0TUQ1Y0JaTDFtUnNBVnRiUTA2Y3Er?=
 =?utf-8?B?dzE0R296Q3QxWVplY00yZ0d1UFJFUWY4ZWRseGJxdkRaOFB3aitQUitWSU03?=
 =?utf-8?B?V1JKMkxZS2pUV05mWmNQUmpEdHBMa2VJQWd1cVV4ZWUwUEJtR1JmTVk0OUFz?=
 =?utf-8?B?eCt2N1hPN1V3V0xDcEwvbDhPU0h1WDVGdE5Ta21TaGtoVUM5dExkU2hTamtN?=
 =?utf-8?B?Tml1N3FOZzRyNkJ6OXBsT1JUVXcyTHYwUGxrR1lWaVJ5RXVJTWsxRWNYYUdC?=
 =?utf-8?B?SG9qK2h0b1I5SFNsaktLcktESE9WaFMybzN0b3hOek5ZN29BclVQeVRGYVRD?=
 =?utf-8?B?S29KMVRreU43OUZ5WlRhV1RpUEFZMWN5OS9JRWlVa3FraWttSmR6YndqQUpF?=
 =?utf-8?B?alFJRmNnY3BjdUl1bktFUkErUDVMK3BTYUc0cy9wZ0lyYVgwKzF2SDRDMFlV?=
 =?utf-8?B?VTNrMnpZMGgrL1lVa1JtZFZuYitzMkRSRW0rcVY1b0kzN2k0U3NLeGdmZEZu?=
 =?utf-8?B?eHpPWXpVSlMrcDRoMldZNFl1Zlc2R3ZUODk0NFB3RWlQZm1wNVFQU0EzWjUy?=
 =?utf-8?B?aG5udFZnUld4QzU0M2NreVlMVEY3MDBMVDExRTdmRkZQUUJVOGVpOG9JWk9L?=
 =?utf-8?B?WWhiYjE1MjRUT245aHBvWXdyUVA4T0ZhTGZNVDBZMHVVanNTL241U2lWSXY5?=
 =?utf-8?B?cmtnalA3cnE0MmJESSt4UUhrTDF3T2VsZm42bEFSSFA5cGhhanBBVS9IV0NX?=
 =?utf-8?B?Yk8zQU9MVTBtQmI3OW1pQ2Jhd2RMaFI2aFRuazVEdW12eUZxUXFqTHg5MVQ2?=
 =?utf-8?B?V0hGTlpWNEVrcENkT3dVTENnTFBrc2RQODdFalFLNS9UUzErWk9kSksyQjFy?=
 =?utf-8?B?NDYreU1KNzZGZjZXa3lPR0IwTU5SWlpyb09RbG80YjhiTHV6aTY3OC9adk4w?=
 =?utf-8?Q?wuynx7CHRfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UERKVGZtRUpFWUdQY3ZTUnBzVStzRlF4YXN0dGZRbXpaMnNvbU1xbnlGc0Ns?=
 =?utf-8?B?dmZsQkUyNDV4Z2MrdUFjZmh2YTNvT1BZWVFUTGdoaUpTN1hzQlFka0s5MTJQ?=
 =?utf-8?B?NkkxQ0dBd0E4TWc2MUdncGU3RGFjVGNDVjlXZFFUZFFteFJlT1l6MzExc2V4?=
 =?utf-8?B?Y1FVZjhVdzVoSUlUeGdVM1hXRjZGQWhqdnFUVEw3N2NxT3N4OW5tcmx4L2dL?=
 =?utf-8?B?Ylc5VDNWa05iaytVZ2RyZ2tPN3dsd1N2KzF3czFsbC85UFhrNnFlTFF2UzJv?=
 =?utf-8?B?aTd5d25Ea0FIR1c5YTZ2RWVFS2twenVZczI4YVJucklBZ0tiRWxabFpaL3Mv?=
 =?utf-8?B?TCtJNGxndDc4WTRCeGljRG1JMkxUQkg5NExETkhiZWk4a1hRRHNYVko4cUZv?=
 =?utf-8?B?d2N3M1NlS0lxMVpzTjczMmZ4Mkk5VXNqSkpBTi9kVVE5UTBvNTIxQU5PMG0r?=
 =?utf-8?B?NDNNRXB3RmFkSjJZOVhzRVFCV1duZ2hwa3B4MnB1MlZITE14RkJscnZZSmo2?=
 =?utf-8?B?S25vc2xnR1dwU3RIaTV5MlZqT20wSURNZGdqTUY4WXcrQkowcEJza01ja3JS?=
 =?utf-8?B?cnlLYWltR21QK1kvYy8xNENBajh5bGpRZjRmdjVMcnp2L2dTK1orMHp4U1JO?=
 =?utf-8?B?c3VDSGJ2T2kzblUyRTJYL1RLbVA5NG11OTZZdHNmS2pkdVRITURaclhwYVh1?=
 =?utf-8?B?cmlEK0FTMXRVaStlUmJlTWllbjMvS3VIQngxV2k4ck4wRVhHdUl6eWRhSFdw?=
 =?utf-8?B?Mzh5NHg4L2YxY2VGQ1kzZ2tIU3hUcjZEaG9Za2E5UzIwUmtXMi8vQkhBYita?=
 =?utf-8?B?c3RjbDJXOTZOV3llZVUwSzZsWXR6Q0h2ekhRbDBZWjJGdkRibXJ5WUtwK2o1?=
 =?utf-8?B?MC9GV1JETGdhRGJvRkJMUSt3NDJmc0tnc0srcVM1N2RXM2p5MTZEU2xWWWxD?=
 =?utf-8?B?RHByVUxBbVNpanpsSm80RnppUmFmM21adkpoWEVvTFJaM0IxUEh0RldBdEZj?=
 =?utf-8?B?UUhKaTRndEt6YXI3THhJdHNQZHhzdDlYQnJrKzlUdTl2ZS95cnVsRGdOM3h3?=
 =?utf-8?B?bmY4TXhXcVk3cTRPVkpJcVlVaTUyOFZ5NWt1YktjMFAwV0RQdjRxY25yVjNy?=
 =?utf-8?B?YlVJZ0VVVUhGZ2UwM3hHaFlFdGF1M0cxdkNKaUVvK1U5cHM5UWhkSHNlbzQv?=
 =?utf-8?B?dzNncnR1dFFRWTl6ZmUrU1VsTHR4RzkwUkQrWUdXbHFZeDFUR3pxeGkyMStr?=
 =?utf-8?B?czZ4LzNnZVFzNUZRMk1SUnAxcDB4bDZFVmNtR0FEajhBTEUzRlFLc29ZcjZp?=
 =?utf-8?B?eFZsb0wzU3VScUZFL0lzM3VXMXdFUDRmbGkyMmE1cHIvdS9rNExOUzl1L1FH?=
 =?utf-8?B?SnlBdWV4dE9udFZhMXNpdVk2MG9ucXQrNlpVZmxhZHN6czMyKyswWmlnd2tN?=
 =?utf-8?B?dEFxOWJjd0pUU1lyNU9DNVZrVFZMcGhmYzIxcWxtSG8yS0lqTzVJN0t1NTNt?=
 =?utf-8?B?NTd4dWxoSndnd05aSFNlbTlXRTRxckNSNXJkT0VGbUFkM1puZW5paGdNbWFF?=
 =?utf-8?B?aktmcFVFenQ2WkptbzkwYVEvUDcrNmdiSmx5MGNrdDZERGF6QStMUDZsZHJa?=
 =?utf-8?B?WU8yV3QrM2JlNnVJUFpVR0N6T29sSHNSU2ZoeVJmNWtCZ3lidXRvN1NBTGlp?=
 =?utf-8?B?N3dEd2ZQOHhyY250S3ZMWnNBNEppaXNXNVlUVGhRYng2OU1iM3ZwMmtrdjFh?=
 =?utf-8?B?Y1V2Y3BCeWhpaFdWM3JGeHdlellSRkEwRkdjWkdrN1Z0aFQ5UnJkS1M3alUw?=
 =?utf-8?B?ZEZnN0w2VUlFcSszRXQ5M1hsM2F0MDdSU01yMXZCYk11dTZoQVhBVWttVHRD?=
 =?utf-8?B?NlRVMElWTE5URStTMnoyU3psc3A4bTV5NitzdU53cGRJRjBoZE1pNkptUW4r?=
 =?utf-8?B?bkhNamVJdnBWajVBY0NVU0s4NVFoc1phOXB5ZTMwbEwwKzlnQ29Ma0xWOC9p?=
 =?utf-8?B?R09FMWMydXNOaXlLSDd2YTBBWS9FZ0JZYWMyREtGSlQ3MlVRbkZZZWtscDkv?=
 =?utf-8?B?d3Vtb1ByT2tIZ0U1eWNMK2RRZERUTk9oQWFYcDlzZUhnR0ZTZFRKU2hocnNY?=
 =?utf-8?Q?r15ojlaAGa7/x1LL+7r4Z8AJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716f1c2e-40d6-4d8e-0e6d-08ddc2da34c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:27:40.4044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWfX9jUxeMzEdmqG99DcHGOHInJz3ipS/oYJG71Jj8OU9DjFgSFWfjjeGjj30tDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

On 12.07.25 00:39, Alex Deucher wrote:
> Make them consistent and drop unneeded extra variables.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 14 +++++++++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 +++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 20 ++++++++------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 20 ++++++++------------
>  4 files changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 5a1098bdd8256..999705e7b2641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1428,7 +1428,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(5, 0, 0):
>  	case IP_VERSION(5, 0, 2):
>  	case IP_VERSION(5, 0, 5):
> -		if (adev->sdma.instance[0].fw_version >= 35)
> +		if ((adev->sdma.instance[0].fw_version >= 35) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	default:
> @@ -1544,11 +1545,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
>  	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 6843c2c3d71f5..e542195972dd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1347,11 +1347,13 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(5, 2, 2):
>  	case IP_VERSION(5, 2, 3):
>  	case IP_VERSION(5, 2, 4):
> -		if (adev->sdma.instance[0].fw_version >= 76)
> +		if ((adev->sdma.instance[0].fw_version >= 76) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	case IP_VERSION(5, 2, 5):
> -		if (adev->sdma.instance[0].fw_version >= 34)
> +		if ((adev->sdma.instance[0].fw_version >= 34) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	default:
> @@ -1457,11 +1459,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
>  	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index d2effa5318176..c08e9a6cf6827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1355,7 +1355,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(6, 0, 0):
>  	case IP_VERSION(6, 0, 2):
>  	case IP_VERSION(6, 0, 3):
> -		if (adev->sdma.instance[0].fw_version >= 21)
> +		if ((adev->sdma.instance[0].fw_version >= 21) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	default:
> @@ -1575,18 +1576,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> +	int r;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (ring == &adev->sdma.instance[i].ring)
> -			break;
> -	}
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
>  
> -	if (i == adev->sdma.num_instances) {
> -		DRM_ERROR("sdma instance not found\n");
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1596,7 +1592,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 99a080bad2a3d..ba1f3e3b6eb61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> +	int r;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (ring == &adev->sdma.instance[i].ring)
> -			break;
> -	}
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
>  
> -	if (i == adev->sdma.num_instances) {
> -		DRM_ERROR("sdma instance not found\n");
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
>  	}
>  
> @@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> @@ -1346,7 +1341,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	adev->sdma.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> -	adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  
>  	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>  	if (r)

