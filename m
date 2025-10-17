Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E17CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 22:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0397910E1C4;
	Fri, 17 Oct 2025 22:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0bUCro/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7D610E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbpQ/UmP8H7UjZggoMebMj3gQII7/kAnoW4xIQicZBIAjrqn+eManQZ6g6a+yaMARsft9z3Z7R0AJMp913fQJ8AFobcdCQBoqNXZNRj3Oc2HDjcwWa0ZE2dGBBWm/tWu2mTQMxT1AYTqVdjBoxz/NGHindjVl4AG8bMvsC+jXO3wksq0FyIp9kj1M0EFZ41VwFe+hon2GIo0YCU5q/hDNCsdAIv3Mp9qqzLBnyILItf0eaVMJ+Xocy2wEkxWVSbtz6cKaZwgNDmcD2QR+TCxdVMHMqRzGUzH+w1k9y0nbIUFgLrWofBOBnZaWf2d0GquWhAAZHVZDMXcMqlPKrQ4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mW/QBWLRSzvRcKBuKZKAXeUK3UNKwbx1w+v/ggf1rY=;
 b=rGMO71K50U5al6E1VYenhNR+OHMFkY0EJQp4YApLRdiVsSvorDm4b0YkECbQDZY/pnLtqCXef92P7TRJQExvbkxEyWltiUZyN4HCN5aUMK3U7ogcAwX5PAHTA32x3bUCUsi8CwkOE67JjZGsS7zWZpp5nQ1KM8lMy9wB19mxohd08+pgwWYsxUXkQYWKC+fxIPglzKTWiryBSwDzocCkksljKvtHcz3/LEsvw8XSvl4ZmPQoDzSStL5yVnairMJ0TvyjGSwjr2TXP9TXupHY/E2krvLxtKsnKFokeyGWku3TlvTaYJWGjoWPyhafI6GobmmQJ8KbpzENEoJ3Up841g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mW/QBWLRSzvRcKBuKZKAXeUK3UNKwbx1w+v/ggf1rY=;
 b=U0bUCro/18V9l4r1JWXPmnD12FR2nNEmWh4/1uRcfS3NXt9/pF9DGfIJ4ZaL/8TITkjedGbbx+A7fSaR7U7Hm35d13BI3k0LwoL/gxg892KtATIXbVM5pg0KsQvGw4zh1QjLqlPZqaZ9hXD3cLSDY+JIva/znkkbsJujZ7zUdz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 22:43:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 22:43:11 +0000
Message-ID: <6c6fd123-c4f3-4878-a39c-21e6ac74c833@amd.com>
Date: Fri, 17 Oct 2025 18:43:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm
 released
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <20251015201134.2540-2-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251015201134.2540-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::38) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d5a694-dcd2-4579-1567-08de0dce8d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVwQTh1YmxhUUVDVlVIYjQxMnY1WEc4cUo4MGxYdm5hSWRsTmtCSEJLMGZQ?=
 =?utf-8?B?WkI0ZDdHUWlEVVN2dTE0VnJEWG1pVzhyZnVvOWxEcWpFNmZ5RHBhTjVRVjht?=
 =?utf-8?B?aWdMZ3JqbkdBK1JtdXpvcERsbWtOaUhBdDVnNHA5cG9CUW4yUVZpTFlhRlJa?=
 =?utf-8?B?SDhvUmlqWW9KcUxlbk90cDgycTl6SURyWjFHQlR3c3VRcE40eVgrNCtHME9q?=
 =?utf-8?B?NFY2bEdtTS83Q2JSamhwbzVwU1E0cFRlMDVNTHRIZ3pFM1drRVpFSHIzZGc1?=
 =?utf-8?B?eWxISkdCY2dwMm9ZdUpEUTJNcWN3N1Z6WTBWZlJndFBFY3pLeml0eHRTQUZm?=
 =?utf-8?B?a29IZU93U2ZhWTJJOWFEdmJwS3N6YVdkVHJVaHZxM0xUaE9Ja3RBQk1rNU5x?=
 =?utf-8?B?TEhML2oxd2Rlek1DM2xFWUFUdW1RcW5kS3RJcXp1VUM1Szdqa2RyQ08xUSt3?=
 =?utf-8?B?MmV1TzNvbkxyNmJlZkdoMU9SUHpHUEh3ZXhJRmt3bWhqMzBPM2NZWWlkclhF?=
 =?utf-8?B?dXJPam5LQzNDU1BOcGZER1hzZG9sYXZYU0xDTjNLdy9id0R2VHdJL3AzS3pQ?=
 =?utf-8?B?SE5lZ1lQakVjZXBZYjdqRG10Sno3ZVFlcXd5SWZiM003VUE1bW5aSFNIblFn?=
 =?utf-8?B?elJCYk1va01OZVl6WTFiYUREVEdLNmpleENXLzlzSnh0UHU1bWxpYVEzL0lh?=
 =?utf-8?B?N3FTWWpxODNUMG9rWWEvZ01tQmN6U2p5M21LVXdJMGlTTHp6TzhxbktnaWJE?=
 =?utf-8?B?YVhWQnhkQW85VndnUTZER25kMmROcU9peUd4KzhQcFppT2JpMWxBL2ZPckJP?=
 =?utf-8?B?VWhkOVJkVzU4cy9FV1NtWWk1MlFGZms3MHBkRkdneUlsOWd5aXVzRmVCOGto?=
 =?utf-8?B?NXkzcjg4SXNoaFpVS05va2NEOG4weHBWYmo4ck1lQUhCWDNoMXBKWEFvenR5?=
 =?utf-8?B?RDhHb0tjUlZHU21RUEtlazVReElacUFjeXMwd2w5bkc2UjBmbEVIZ3RHaDhl?=
 =?utf-8?B?ZkcwWktBbFpmMWZ4NjNuS2VtblJsUFFKb2VCekVqdW9mUjdIdGN1WUlhRHJE?=
 =?utf-8?B?TlhjZzVvVkxabXFvRGxTa2ZRNis4Q2tVZlFXNDE4enNPZkM0eDB2b3d6c3hp?=
 =?utf-8?B?SDhvLzFxMEJIanBEZThkRndBQS8vL3dvT3VqQUxKZEg1STdwOG44elloemd4?=
 =?utf-8?B?MEFjeGdIZ3E1a01aTXdMMFNLU1VKazVOSk1GL3M5bDByS29MUFlXKytiWXVU?=
 =?utf-8?B?V3hPYlVGdW1Ya1ErTTQ2VWJJUFRZUnNOb3RUV0JNL29lR3dKNlF3VDYyRmNB?=
 =?utf-8?B?NXRHTnROS3NhTTA1Z0NRdzNXMXRuSHhCaUd6cEkzWWx1ZW10MXozZXRDZVFW?=
 =?utf-8?B?K0c4b2FGUzVmSXp6TjIxcm8wRGZ0bHZGY0M4RjVpeWxkSEp6R2VESEtQNjkx?=
 =?utf-8?B?dHFMMTdIT0RHQWVxeDcyQ0RnT2JIMmJtb3QzVU91WjdmbHp0UFZnVTBqYVBH?=
 =?utf-8?B?cVZIZzl0KzUwYnNqOEEvS2Q3czdJYmRYc1VGc3p5S01TYStZbWNHVFkzSjRX?=
 =?utf-8?B?YlJaQVNCamw5c1JyaFZ6MktNdTcyUFR3b0hiTWtzZTZtOEliNjd6WWdtaVN4?=
 =?utf-8?B?Q0V6Mlk1L2owOU1EMXFDM0JEa0VvaEUyU1V1bGJWbVZTZmVobjZXdnN1blNh?=
 =?utf-8?B?ZmxmL3dYWmN4b0tkZnIxWmpkeFdGRlYzQ3FDSkFMM2xlNDJtZEZOQVV3Nk5C?=
 =?utf-8?B?TThRYTJYWHB0VXpMUk9sTkRsS3pqODVTRXhmZW92UkdSQWRMTVNsOTBDcHBN?=
 =?utf-8?B?OHFPM2UxQWswNHBGWW5CeG9obVdMd3FFejd6TFNkQnljazdyMWFGZlZZUlBC?=
 =?utf-8?B?dkNVOTJYM2RpOW1idU5OUXQzcXlGR0gxS29nMmFVM0xyeURkdjFMS1I4QS9p?=
 =?utf-8?Q?SX6eqU4zMeGIpPXr27YPFhBVAZzpMESU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGh0WmN4TUMyaEhyMXcraHBrRjE1T1hSK3pBdU1PelJSQVdRY3BmeVZZK3hn?=
 =?utf-8?B?eDFIMysvTG5nOGRNSUFja3ZTYVB2cUUrR3FsK21MUllKL2JCajJyUGNFNGts?=
 =?utf-8?B?NlJ6cXRFTmdYQWFSNzE1dnpUdEtzc1dYOThYYU11L0JmVkVCbFRZSGhoenQz?=
 =?utf-8?B?WUhPTUJkMWk3L2hqaGJzZm5IdzBoSEd1enZzWXAxdWZ6VUtSQ0dIU0NoSWEv?=
 =?utf-8?B?STVxQjltV3JJWlBWeGkxM0NaQzVpWHBnUjgzcU0wby81WE5WeDZDNTU4TVMz?=
 =?utf-8?B?cU5xUzA1bzFSWlE0ZlR4RGdjNGtpSHd3d0tldFNCKyt6cmY4V2RpdnBhS3No?=
 =?utf-8?B?WW1oWkNSZE1ock5HVVNjMXZGRUdoTUNPZXpFV1lDY08zb0NCR3VzTnRQNlQ3?=
 =?utf-8?B?NEFPR0lzL295eVcxTHVySFh5empPVEpmWUxrVTNLcDNZVlgxemJ0U2xoZDFj?=
 =?utf-8?B?bmJGTStqRzd4N3FqcU9GWVpjMUlGS0Nac0lVenprWVNRVngrTjM4NlJyS3pm?=
 =?utf-8?B?T2NSeDFYKy9rY0I1R0NETjhLcU8rZVV2WnhpNi82dHE0STlGYmdpS29PZTRj?=
 =?utf-8?B?YkNIWk1OSXp1dkVwOG9VVHpjdmsvQ0RzVWdxN2FiSmRnUitwRnJvN0tsb3lW?=
 =?utf-8?B?RFhrYW91QXRFNHcwTmlEQTlRUFRtdzhadkFINlE0MVRaQnZKT1NkMWxuaFlW?=
 =?utf-8?B?MStaUE9ZZXRrQ1FlUGhyMVI3UEdGV1FxSU81ZXdFQ2VWUUg4V2h4SnpadzN6?=
 =?utf-8?B?NnlWVXBiYjUxcDVLTVAvcjAyQUFDY1I4ZWtlaFRPbEw3UFNpWFZNamRiVWMw?=
 =?utf-8?B?UXQ2MzNHaUJFWHlRRUVWcUMvWEs1T2dnazBYakNnVW85ME1yelQ3OXN3RStk?=
 =?utf-8?B?MWJ2UkxwY0NWeDdQNHF3NTRxZjdZOHBTdTREakFaR0JKaHBlZkFFNFpUVWpL?=
 =?utf-8?B?SWFBdXpwWXlvWkdlWHVGT0xuZk1GVU5jQkExRzc1d1Nacno5SUJmNFQ0NW90?=
 =?utf-8?B?ME05eU5yQnZLbkpGK1dGM2VycWpBNDB2NFc3aWUvUE1IYTNDaGdWNU1kc3NE?=
 =?utf-8?B?a21hMlJzWXVsUVFIRG9HR2FGZGM3R0EzZlhXUVk3TWdzbGE4SnA1RFVNcXpB?=
 =?utf-8?B?K1ZXRzhhRExWSEhGS3UrWlpvQi8vQXMxdXVSRUMvUTZ6OS9xMFhrZHI4aUdI?=
 =?utf-8?B?UWVPUm92VUZqdUMyYUQ2ekVRYkZPN2NaS2pBdVovcDNzZEVWemN0VHR1U0dG?=
 =?utf-8?B?UnE0NmkvaFpNMUJDczI5WDlHcVpuM0VvVndOSFlHNU5vY1RvdjBrV09NQkpJ?=
 =?utf-8?B?QmN2L0JFTDd4M3pxVzNJekpiYXFvUHNUWjBUWlZyVndtcXZmdy84cDVMcmVN?=
 =?utf-8?B?RkVqL2daT2x6WERXU0Z6Um4wY2pmSzZsOS9kNURtV2tsSlI5L1FOU09SV0Y2?=
 =?utf-8?B?aHlmb0hMb2MvZk5aWmQ3bjNWOFd6U0taczRUbUNWL1p5ZTFzYXdWYVJGb1A5?=
 =?utf-8?B?Wmlydy9aS0J4eFRFOW1XSkdXZm9qdzM1eXA1VzU0Zy9HYWRGSlRrY2hKODRh?=
 =?utf-8?B?T2dUVUFRU3ZxMnZXVzBWM2U5cEx1R2hCcUtuRXhwL0tMbFhUZHJENFBrSGlh?=
 =?utf-8?B?QTdGaVBleW1rR3A2NGRMaTNPcUhueWFpUGpmL3pyMWpESyt2bXZ1K2d6dzJl?=
 =?utf-8?B?ZjVlcGhLaXkvQW52NVduSzhRbFFSWGVVeHlFQXVhdnhFU0RhV1BXeUtLb3Q5?=
 =?utf-8?B?NTZUKzZsdVU0UjVxR29GTjdqaFhPN20wOGoxbjZXYWZuNzFXR1FackphaTRN?=
 =?utf-8?B?Zmo5SlNrenc2MWQxVHVHdlgyMjg0VW1sblQ5YzZ3NFdQaG5vaDhGRDBybzMz?=
 =?utf-8?B?czJjUE1GcVNZRSt6SE9WSXpzR2ZqcGZWZ0NJQXBkbzQzaEpaNXQzZlJNL1ky?=
 =?utf-8?B?VVlmdDJLSkFVQnJlSGNTL0tiaHpnVUZUdmlQYnk5cldzZnl5dzduUjJ2Ry91?=
 =?utf-8?B?MjBxRElzVjB0UUhVOGp1UTM5N0JyS0xuZk5RbDBwc3hJL2szOEd1TkU0RHc1?=
 =?utf-8?B?T1RQbVdhSmFqYjliVzJzZktKWGpKNjJrZ1U2Z05VajU4TTlwRlZUSHRDenZ2?=
 =?utf-8?Q?SCaV7wcBRq/WSken0zNfvV/k6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d5a694-dcd2-4579-1567-08de0dce8d33
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 22:43:11.8821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6bQRyEUoFDceUBo1c3E1qFlksA8bZfsRthb7fUtbxTv6oR3e7GXDzZ23ty3odQ/OOdflXCX2W3Ak2EEiBO05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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


On 2025-10-15 16:11, Philip Yang wrote:
> In mmu notifier release callback, stop user queues to be safe because
> the SVM memory is going to unmap from CPU.
>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0341f570f3d1..e2a0ae0394b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
>   
>   static void kfd_process_notifier_release_internal(struct kfd_process *p)
>   {
> -	int i;
> +	int i, r;
>   
>   	cancel_delayed_work_sync(&p->eviction_work);
>   	cancel_delayed_work_sync(&p->restore_work);
>   
> +	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> +	r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);

Is there a reason why we can't just call 
kfd_process_dequeue_from_all_devices here, and remove that call from 
kfd_process_wq_release? We don't need to call this an eviction. The 
queues get removed on process termination anyway. We're just doing it a 
bit earlier now.

Regards,
   Felix


> +	if (r)
> +		pr_debug("failed %d to quiesce KFD queues\n", r);
> +
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
