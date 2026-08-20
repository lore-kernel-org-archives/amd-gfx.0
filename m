Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8A0C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 18:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741B810E213;
	Thu, 20 Aug 2026 18:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRgVEHC/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18AE10E213
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 18:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTTjYscR4NGUivvnb4JBpu1HOCo533gyaHe1wErsLxs5pmaZIQoz8R02QScFwCOdWHZuX6gcP1H+n+s8xdoDxdicL6jPni80EbH7paK/yG0j+qCQuixuuEuS+by1VLWZjfUrgpCAzmiGiLUCaXUCAxqrJ3rr15MxaAaaMOW/0t2xfXMGW+b4W9lvwSxxkZjCGWtIAsXAbpJzV1CQHCqxs53EUuffbsy7vFeWkg2bVqsXdPvpMWu8Eoi5axkB59yn+yYfHSDrRkvapCvLlG7B6cPw6x1dGKya5fNseV8auGft4kRHH2mtS8zGKGoWbfYt8G1S5mqiP+2M45INu3jtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDUlkzMjCeHVA+2kDP+d+rHu0SEtvj5g7i5AVzbzNuQ=;
 b=aLopR3DANrk1+k26amlFQL2TglBAXIVJu5M/MUIWXkukiQvN3xPhZ1uBz5Fs6syyR6LY4krxSQH/tU2dGazW7gOxYB7Q5zwWtU6A6DkwZ1/gDd8KxcWf/tWY4d2aQcvXG1p1UEs4uJkQndAlcDaj0IIgKXfQXIKtpkW5yGs2dXn6n6Pzqx54WgRVL3j7P0uXAoU6fUXA57ieb77Aqf5NeZBH4ltTUc15C0rF05IqH+DwEwTx/aVwsdxkwykKZ0q/C0bR+GFs/e2FvN4D68cfwDzufqvl1k8E6SmgK8/3l0m12LyRveDp7VQ+VlK7UEdJxcHpvYP6UqQZ8tmmA/V42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDUlkzMjCeHVA+2kDP+d+rHu0SEtvj5g7i5AVzbzNuQ=;
 b=gRgVEHC/E+Tre3YuYMmB7INGV83iJOueVcUtP0Fh783w8c1HauIfoFJIbYLGx/EyEgGUQdMoR5Lp2GP5zJLXiRSr8gYQXYuFc7P0aKbMIfBP5CgNriMuqJmp4G5IlHXb2OXKwIVWhUN8MVAj7nJkwTXE6lwvhQa5gF9LO+WicM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 20 Aug
 2026 18:53:13 +0000
Received: from SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958]) by SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958%4]) with mapi id 15.21.0315.016; Thu, 20 Aug 2026
 18:53:13 +0000
Message-ID: <83137ecf-a9f8-466b-bb25-4d4dc39bc618@amd.com>
Date: Thu, 20 Aug 2026 14:53:11 -0400
User-Agent: Mozilla Thunderbird
From: george.zhang@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Fix wrong bytes-per-pixel value for
 dml2_422_packed_10
References: <20260820095943.3942404-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260820095943.3942404-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::16) To SA1PR12MB6970.namprd12.prod.outlook.com
 (2603:10b6:806:24d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: fade34c6-7cb2-41bb-2210-08defeec498d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 74sk5UIEy2ThdRx4kCzxxZNGrSXMlkF1ndbEiFBA1Z6vbz/P6x82xcbhT3gr6pi5RTmutaxlyonOxUGvIGha3K2fi7tOT42Xrr3AZANwAWeCHpzzyc3hUB6f+y/fbW3iaO0vev/96c8elwjRea2MMCdDJC8mA74TsodRSNYF/cEaIIo8KmF8pGm1B782veC/2HP2lHeQUQMgPqvSQ/r4dmEmnY4FG81VD8ALEr/ijkk8+GoSwigvehfWPDpXyfCl+1Od2uMfrIyTFJYLu9w5foP5SoilsT3Gs0Nxo45iRTDn7qumRdB2oI8fgjhKAxh5wSQQFp00/MGGKhfbfg+YscQXpG03weEKxyb6ZOBn3Yv4onzk12gvwLv8GHkL3scFpU4aXml9txA9ROLXjdJ+AoPoAzjjosGCu2QnrbEINw4JqUR11PZSyPtHXRzaH6Nb2ehUpgue0/9wPjSs/rNwTgP4nICclgWVqy+clk4zVCCzhD52nFBGC7RyYLWbgnmoqohaCX7g5c5p/BQ1/4KDeatwx8DGYmzJhJyEa1XcX4EVO5RKfx5GAq3wMPv20+LhdCzR9ZEv/91pjd2xfCLgZIrVLHskmtH6bih7qoVl3O5zqgD+x0ttsLI3hf5kVaAmPAdkvHrNoR/21GSHH3466fcu5Nb308phm/TU30qN7J4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6970.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG13aHpXeURub1VaZ3N1NXIzNXhEVzFYUEhHSGs1TjZCaFQ3QkhMYVBINDUr?=
 =?utf-8?B?WXQ3cFFsNjlsNk1UYzhEK0NqdEJVZ2hIV2xPL2ZXVTg2KzN1VlZZR0tEZXBi?=
 =?utf-8?B?L1JwbEtzK0k4ajBvWEZmRkJRM1dTV1ZiZUZqOUM3Zko4UHJZSndUWmpXUmQ1?=
 =?utf-8?B?cXkyR0dUb3RyV0xOUTJYYk10RzdnRjVKY1VKc1gvaWhDY09kVU51RVozSjF4?=
 =?utf-8?B?V0ZEaDQ5NTRJdjhjaWhBUGtnQTlCdkZic1JzZXFzVUVGdlJWa1JaRCtTKy94?=
 =?utf-8?B?V01yaXN0MXUwTVA0NkxSWkI5WTFpbHB1NXBadk9ObXdjNGIyTVJuMXhoL04x?=
 =?utf-8?B?TjRKa25PTGx5cWdqeXowS25CeTVsOFZadDg0SW5jaithZWFDdnpxTWZ5bXVL?=
 =?utf-8?B?bVNzbTI5QVJ4Ymd0VjhONkczOVNvUjlUZGhJUXRKMjhYZVBnVG5DV3JHZnQ4?=
 =?utf-8?B?VVFzOFZ4Y1lIQm1FSGxMditEVHpoZk9MV2NNRUwzSWFnYjRRN3FVZk5nVUVq?=
 =?utf-8?B?VW1Zek4rdDl0aU5QM0F6UjlocWxJR1Ztb0M1WVlhdGhIQmlYdm5XZUxEdTlI?=
 =?utf-8?B?VHlsYWFjT3d4THNwcFVSK2ZRcjEyZjdxdXZIckp0cW9weE5tZ3RqMW1xVk9G?=
 =?utf-8?B?TmFVYmJNZVl3NFNIWVNSWWZldWs4OUFDckh0M1NhQk42eWtjU3V0Sy9BMG8v?=
 =?utf-8?B?L2Vra09rVzBMcXcwZzV6c3lPaVJoeUZuWUVIMEtQZUlFRXpoMG14Zmg3VStT?=
 =?utf-8?B?ckU2djlJdHVkSW1FTGo5V3FmNmM4RVpPaE1CNTJMd2RWS3JRd3RXSFpQM2xJ?=
 =?utf-8?B?TlcxMVVMVTl0ZFNNc3BnZVVBUlJFOUdjdmtkWnFiNDAyK25NNWwvTzFIVEk0?=
 =?utf-8?B?S0JKTmZCcGVMRE5YbjFWaU5wd3N4NFJaaHZYSnVnNzVyZWZnSkE5aTU1M3Ny?=
 =?utf-8?B?V0FyWWxraHAvWHNDV285bVFmK1UzUVNtOGVVK2Y1enJLamV1dy9OQ2ZYTjR5?=
 =?utf-8?B?UXFnVm5COFhzNk94a29lWTZvZDBLL1djTzd5VjRSci85cDU5VjJkS2RxWUtm?=
 =?utf-8?B?SituN2RzclNHaHNSS0hFYTZJc2MwbE55ZS94TzZYeHdrSUNQUmJ5VGFuSmRP?=
 =?utf-8?B?eEJ0aUpvSldLOGlvMmludDh6ZEFya3RydUZpRHUwZHFoWllFQUVLUWtKNjh2?=
 =?utf-8?B?ZTlreDc4NXRDNGI5SWtjUGRZK1NFTnVpTnJVeEE1NXZaR0ZqbCtESk56Nk9U?=
 =?utf-8?B?eDl1UVJ5SWJBS2FQclUyNlVTc1REanFpMUdCUTV1b1VDVVpLS1loeVdBSDJS?=
 =?utf-8?B?dFp1aHVhM3dlenNsdldoT09jdUZCdnlzc1p4NWlONHRPcitnUDhXUVh6am9O?=
 =?utf-8?B?Z0Rta0lYcEpkNXNsR3UyaitNNHIvbTEvWnpFY3ViTDRobDlORlhWWG4rRFJ1?=
 =?utf-8?B?c0p0SnRrWktVRW9GTWFObUxsQW1uczduYndtREN1OEhBaFNNNEFMbVM0SlFM?=
 =?utf-8?B?akM2a3lyS3lVUjMvYWJRNkFTMUtPdit1TmpiaFU5dkxrbnY5UTVsc0cyQllN?=
 =?utf-8?B?dDNVdVBsK0JKT2luMlptdmdHVHo0UWsreUNEMHlnRVdkWW1MNmk4OEcrTUo2?=
 =?utf-8?B?cVJRS3gzRzdoNlVac3Z0YXNKMEY2RFhlcTJDVEJ3MU53b3k4Q2ZjRllBYXNO?=
 =?utf-8?B?VW9GeUYzTVRFNXkvaUY1dTFXcDE0bnU5d3dTN2xlbThWK0toZHc1c0FqRVlB?=
 =?utf-8?B?WmdiOXcxaERwMkZmbmxXWHJMTlR5WnpPcDFxZkNST1lTSmZrR3hhOXh4cEFF?=
 =?utf-8?B?aTZ4VEVHOGQwUGE0NE9ZbW5wSGF4bnM5ZnRWamwrWU90NWpWWW9iSzQvV0tx?=
 =?utf-8?B?WEUxL3pNL2ljTWdmUTBJbCtkQnVycU9PcDZCNVdZTXlyTWVBaTN1cmZrSGkx?=
 =?utf-8?B?WkRXbFJsbXJSeFBwNGNtU3BUR2t2Z2MzRFpzSSt1WUQvclVNajVKRFErSzNE?=
 =?utf-8?B?RGNsVERqSFR0OWNYV0xpTXNJSnZSOGxsdXlJNDFwZC90ZkNkeDV0UzZVZk13?=
 =?utf-8?B?d25DQ0g3MXJnYytSRWh5WTNnTTZyNkhwdk5qNk9kcEp0MzlvY1hYU2hRb0NS?=
 =?utf-8?B?WkVKS2Y1T3F2SWZDR2NaUnBuTU1jZUQzTnFYQzhYaXcyOTNIbFpkMmxBaEJu?=
 =?utf-8?B?RURwL2pLMUlSYUtzUElUbUxxRGNpeEVTcGxQS2Y2WTIydmVQQ1g0RjYrT05F?=
 =?utf-8?B?WFp4OTZiM0JqQVB5VUd6b2w2enF5aDM3akJDUFlqYWY5NkNWTmxZSlZwRjZI?=
 =?utf-8?B?STVjZGhJSkRYYkplN3FEK2hVQ2I0VXF6K21wOURYVFZqdnV2ekx3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fade34c6-7cb2-41bb-2210-08defeec498d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6970.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:53:13.4414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX6wIARv7qyTpJCExZILAsRMp6NLmrv3fpHYNX2dkA6ADJdsqtMnuxpyHaLI2qAlM1RT2Wm3E0YRk//NHib3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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



On 8/20/26 5:59 AM, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com> wrote:
> The pixel format dml2_422_packed_10 needs BytePerPixelDETY set to
> 8.0/3. But it was accidentally placed in the wrong group that sets it to
>    4, so the correct value was never used.
> 
> This caused wrong DET buffer size and bandwidth calculations whenever
> this format was used.
> 
> Fix it by moving dml2_422_packed_10 out of the wrong group so it gets
> the correct value of 8.0/3.
> 
> Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: George Zhang <george.zhang@amd.com>

> ---
>   .../dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c   | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
> index 321a29d289b6..bd2494c976ac 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
> @@ -74,7 +74,9 @@ void dcn5_calculate_byte_per_pixel_and_block_sizes(
>   		*BytePerPixelDETC = 0;
>   		*BytePerPixelY = 8;
>   		*BytePerPixelC = 0;
> -	} else if (SourcePixelFormat == dml2_444_32 || SourcePixelFormat == dml2_rgbe || SourcePixelFormat == dml2_422_packed_10 || SourcePixelFormat == dml2_422_packed_12) {
> +	} else if (SourcePixelFormat == dml2_444_32 ||
> +		   SourcePixelFormat == dml2_rgbe ||
> +		   SourcePixelFormat == dml2_422_packed_12) {
>   		*BytePerPixelDETY = 4;
>   		*BytePerPixelDETC = 0;
>   		*BytePerPixelY = 4;
> 
