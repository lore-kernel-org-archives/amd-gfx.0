Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4755D2FFEC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 11:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C55B10E062;
	Fri, 18 Oct 2024 11:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DB5096wR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D18F10E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 11:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiwHJeasZqSlUp44eIEwPspUsimAq3qK+jdMmsunmzD+4toeVKm7ElL+WkqADFBk1tBTGWX5m5UwDzzBnm1Jo9IEFwkw6WSO+l4LbU8NAo7X2lb0+kPw8kfy4ffKVkG5lukv8oWAds1q7B+pA65lvrpkc3QI+CxRy8avfKTne1yXM1nkbUBqRB9+oeKX2kLZBTedmeDHKR9aSIWzDGo0YTYCLOcQZcVL0Khj2dvsr1LSc18LGjJjuz71ST4viUVgdwkZ2NAh9SBYp0wKAeUqK4vN/qgzJNDDyRr6/AzbPwzSqTM/3NESvVf5YE8ywYGJJYJobTN/6G2WrCYkjp4CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oga3hEoM7qoa12yt0vR2E/EHnwwTtQGvyAseutxsOk=;
 b=OwwbbdPxLQs9TBjtExbde6f47dNDZ4P2x5CJIsypLHm+K5S0BqUvHt9DxqAsKVZS76CRvXGp0AthTfL+1/BjKHH1pz8+VJBUM6FuO8L3ziXIlSdFfrO8uDHmibbeVyj/jv6IEHl1BeQnWoAx8pqCR/B68+hTbhwv3+UFlBaVC3nGkdDdnclMEz39y72+Cnzx4/yv3oOWV0WLr+uajL54uceXY0WZgMu78ED7LTXQauD+AwvfZvu4aft6gVATcXdDhfex5IQaZNqb/QUW4mLNb9rFOr3ljtLMO/rTCQVweqfm/c9wjknbm4IiYqyZ7Vn/M1pgrchNl7r26ve3gdwfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oga3hEoM7qoa12yt0vR2E/EHnwwTtQGvyAseutxsOk=;
 b=DB5096wRuQGXF2Gid9mY6kBceGF3AD2HTyaId0cm5whAMBtwG8yxKKoTSGs93MyN3+/r3xIigZ/fzcTuseUR1gS2qIrCpSJVF7fCOGbFMwkIsXxpYaZCen9rKPfIiEHNVQSBX4JhEsjyDvqkSqVYrHztYoBS+47UgfGdD8hjoTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 11:10:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 11:10:51 +0000
Content-Type: multipart/alternative;
 boundary="------------8JxE4Oa2mzu0zxJQ9tBdzh1D"
Message-ID: <dce6f4ec-80f1-43cd-a45f-2a1655e56200@amd.com>
Date: Fri, 18 Oct 2024 13:10:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] drm/amdgpu: add helper function
 amdgpu_ip_block_suspend
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017162531.1551442-1-sunil.khatri@amd.com>
 <20241017162531.1551442-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241017162531.1551442-3-sunil.khatri@amd.com>
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: fce74a86-e163-41ec-146b-08dcef6586e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjNVbDFiQjJaa3VpM21OU3I2ck5hMGZQME1rd2I0YUFsTjloOXdOcGdWZnJM?=
 =?utf-8?B?dlFuMzBZLzU1akFnVXN3SkF5U0t0MzF0bzRBRGVwZjVwOUdDY1h4ZE9xbEsx?=
 =?utf-8?B?azhXSG4weFp1aXJZYWJKdVBjdkI2Y3JKVHQ2aTRrMWttZVhma2E1OXBSVXVp?=
 =?utf-8?B?d0ZndVBURjQ2ZW5OWVJDd3dpM1FvcXM0anQ5dU9lMGJ3c1dMd1ZGbmNwbWth?=
 =?utf-8?B?cXdiY2FyZXNPcm9GN2Jjc1FsK2lMUVdxZS9lSnRod2NGTzV0YTM4NGNjTDFH?=
 =?utf-8?B?OThSV0czcmY0ZC80V1hxeFFEdGVzRExPSjU1cDU1MlFuazdibitlRWpZdWtQ?=
 =?utf-8?B?NHFuWGNrVCtaYlhDWTY2Q1lrQmdZQWFZSkJWVFo2dnVwdDdLbUpJMWFQNlBB?=
 =?utf-8?B?WW0vQkFkU2JUbnVIRm5lOGJqYmloOTZCY1d1UWtCUGd0RGQweFRmU29WM28w?=
 =?utf-8?B?NmcrL1VDa0gzWmhHWngxTWVqQXlDdWd4dE5TU2NpTitYVWllQ3NJakV6SEhN?=
 =?utf-8?B?MUkzT08xL1hHc3o0dVRINlUvdXpsamhpd1ZwR0FiT0xaL0xwYVNjOG1mWnEw?=
 =?utf-8?B?OWtWMXNSb1lOQmg2WTNnbkRxY2M0bEZrWmJqQU5EVU5LMXQrUUhFbGNMQlIx?=
 =?utf-8?B?OUo0U243NGxob3J4aTZHNE5ISTJJZkJvQU5QZlA2WThWVm9aNWJ5dTc0VktE?=
 =?utf-8?B?bjNOaVJIV1lpTmNQcndRdWVZdXp1R2p1US9leDJURkJ6VGJEd2phOE5uVDRv?=
 =?utf-8?B?dFNiNGNFVDVvR01NcjhlWWpRV1pZQllMN0MyOWpwS1p0WFVraTJrUFRXYXJS?=
 =?utf-8?B?dkpWOGgwVkVWVjljTE9aamtUZ2R0QlVNMXlTVGhiZHJQbk43Q0g1Y3RxQjRP?=
 =?utf-8?B?WUF5V0M4R3QrQ2IrQkdiWCtKVkZYcTNJNG9UaWExbDZFOTRPOUZINmJYSDR5?=
 =?utf-8?B?c1FaSVlrTXF5QW83R0lPOERCQkpwNXE1Qm02NXVmZk9HTXlkcldsNE1XeWZH?=
 =?utf-8?B?N1BBdEhpb09yZ2tNeEFOZVhjUFR6eURVSTg3a3Y5RFpXWCt5T1d1L1NEaXhI?=
 =?utf-8?B?dllHeUswa2EzSW9STW53RE03WW1vR1Y2bWpJL015cEJZL0IwSWxlbU5tbit1?=
 =?utf-8?B?WE1saFNkdm12YTUyR09VbjJRSW45T1c3Ri82S3dOeGlPV1V5WXJESzU4YXF2?=
 =?utf-8?B?dFE5Rkx1aTZwWkliZzFWWEpRTzBqSm9YbGJpbjc3V0pmZlFVYkhaTDFybitJ?=
 =?utf-8?B?amxWWlEvRFdhejhsSml3TkpSQmlaa2hpb1RaSkFnZTByZVZMbWNCOGlmcXJv?=
 =?utf-8?B?ZHkwYTNwTk9kUk1jMGQ4T3BiR1JKUnJZSDdGc1FMdHpBYWdtcjVXUmhvVjFO?=
 =?utf-8?B?SHN0SFJnOVJTWGEzWVRYUTQ1bnI5dWw2TDByZEZIMjJSQTg2WXZUMVpWMm5h?=
 =?utf-8?B?U3ZETi9hdnA4enlRUWVwMjdKa1AzZ2Z6dFIvb3ZVMXFiQ04yN1JJR0FkUnJY?=
 =?utf-8?B?cVZ0WStKZU9SWkZwem9ZTFduaEhpL2tjNDRHV2EveEExYXVqUktBdUpnQS95?=
 =?utf-8?B?Q2xSeEVVV21sMlhlUVpsdkpNQ2JWZnpISzF3OGt6TWljeXhiN3JMaEVQN3FK?=
 =?utf-8?B?UjkxL3MrVkorWlpHWmJIeURRZVFGd3ZvRGIxZElGYUJrNXY0MDZWUmREMi9o?=
 =?utf-8?B?ZmNaenZEZDZtRExhM0xmSElydCtJQmRkNDFMazJPRzcwem5xcWdRTENvS0RJ?=
 =?utf-8?Q?Ej9tWx+t28nGwlib+CooDj0amq4ZcMi3qTJAzHs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHQ2eVZEalRNQkVtd2FwWkFrbnNFMFRyWk5TZ2F6T1pzQzZsTUdIVEZ5TVla?=
 =?utf-8?B?S2NtRktBYTE1SGRtWFFSYlVkcVYyM0VxdlQxeDM5NnpNMUVJVXBFc0t2SWMx?=
 =?utf-8?B?bm5Vc3BFVlhEQjQrc2tEWWg2clBwTEtYMFZFc2tRTWJsRFBvT1l0c29ZejFz?=
 =?utf-8?B?amFPak5JUFduQzlYOU9yK2ljMjVGTVJhRUZqWXZYT2lrNEJZOGFuRVVueW1J?=
 =?utf-8?B?a1FNRVlPRFhjbFhPUmRsUGxGeGpRWFpaaUJabEdTOFBkYlNJZ01iT1dDc0lR?=
 =?utf-8?B?RFVRRTI5cUhyUU15SnllNE1hS0RrUmV0azJoMko1U2hYZzBWSi90emdWdmsv?=
 =?utf-8?B?bkx3eHdjZHVGa3pkYzdENGwxdUxsWW03dE9qdHo1eW9aZjk5dnVhd2QzcEdz?=
 =?utf-8?B?bUNNcW5sQnhuOXRwUjd6aWlnalQvd3NCT1NiTnRvUWFSUkUzSmdrRWdEaWFj?=
 =?utf-8?B?bC9McTJPTllPd0FPenR4bVRxY3E5dHVIdEQ5eXA5TDBTZ3puc3hoWU5Ma1I4?=
 =?utf-8?B?ZzNLSE5vbWR3aC9sWjJSZWdHcE9vOENObHhSeGFVV3RWalZZK0Q5OUxTZUwy?=
 =?utf-8?B?V2cxMEhNR0EyOEgxcyt3YUdnalg1TGtsUWVPZlZOV0pMS1RjblBDSXNLRHdt?=
 =?utf-8?B?OXJodUlpYmNZdW1HSXdwYnY1VHJkc09aRVQ2bFBDNTVtaDhqVWJ3My90UHBY?=
 =?utf-8?B?c1BTTkMwNkxHWUxxTzNiY3FpQlhEUVRYbFdTMURqWkx0WWlBNHo2YlNsZm5V?=
 =?utf-8?B?QXd3elI5OCtaQUVnYVBjb3dMKyt4MVpRUW4zdXFleWVkMVozbzM3dmRiTGh2?=
 =?utf-8?B?K1Y1dVF5b0VlTVB2T1NQZitIUEl5YitVbUZHVXE5YzYyMlJOVTJZTDhOb2xP?=
 =?utf-8?B?T29KNFRZTTBHWjhkTjlGNnpSNm1xZXVMY2pGWWRxeVJDbGxCWGxxVTd5Nngz?=
 =?utf-8?B?dFIzRCtzT2RkV1pDeHVkdTdZT0J4MXNTVXpVclNrb2c1aTVaSXhGWkhrUGlY?=
 =?utf-8?B?TnJhOXZTbTR3Tnd5ZWY0UFhWdlEvWndHWXlLbVVGOFprZEplcjBwM1ZOTENM?=
 =?utf-8?B?d2JoTjdSQjhvZDdkWGlnRzNMc21SMC9Kei9TWDBWNmF0ZWNvQi9NZjZ6UXMy?=
 =?utf-8?B?djFuQWhrYWdEMEZXVmdVVzAwb0pFRXJGVGZqTjVNMUZiUHJqOTVlTVZPRG9s?=
 =?utf-8?B?Z1dkWi9jdjJXRWFVL2NydU1XM09MOWo0R1hJOEZBVDdhelVEVDM4OW0vV29t?=
 =?utf-8?B?blk0c0c0S3lSMnp3VmVmTnJKdjF1dTZDU2RXMkplaDFsaWlSVkFUYjdhdXM3?=
 =?utf-8?B?bE9ybGtQY3dHSklSUFpWQ1lLeGJYQUc0d0xIK2EwWXBmSThpRkExMWpjeEtQ?=
 =?utf-8?B?VXNMMmlrMi9PME1MU0hDSFE0d1FPWVQrMVhqRTFKU2ZEWFJrdEtQYmtFbHpv?=
 =?utf-8?B?SEExdWc5dVg4cERnSDBUcXhDQlNVdFdMUGVRdjZ2TWNpcXVCekdOeWI5YTFj?=
 =?utf-8?B?TFdHei9SQ2JyUFZ5d3REQ2pGMDllWHVXeU43dkttQVdQOXhPQUNGa1A3d01M?=
 =?utf-8?B?Z2JkOUdEaTZQUmZiUUh6MjlxcjVtNHZrWVRnNjNUdHZUMHRjVjY5eDh3TVdr?=
 =?utf-8?B?Nzk4Y3BLVmw1ekhFbVZDVEhqS3dxdHVJZGpPSW1wV2lFL0lOVk5mbzZxakpa?=
 =?utf-8?B?T01lajMrSDBPUThySitCQjNhb3pDeHZ2QVU2dE9mZzFkVDM2ZUk5VHMzK3Rp?=
 =?utf-8?B?OW1ieFp4OG1xYnJBZEszVFJMekNLYkU1ejIvYU5reXZBVGd0WG5VMnVKeGFp?=
 =?utf-8?B?VHpDeDNqS0tJZWRybzBycGJjWlZ2SWlVTndBUHpWYVRUYW9jUTNuOXhWNklE?=
 =?utf-8?B?L0dBWEZNRnl3N2x0SmtEOGIyRlYzUndEZ0Z2UWloRzRIeGRiS1E2UWlXY2hB?=
 =?utf-8?B?THhuYVF1bHFBSTRKaWNValNlVXpNM1gxMEVqTXdENU0yaEdhLzZOV0RGRWlG?=
 =?utf-8?B?blhJNVB3NGNRNTJEdVV5WVpsQlFiR1Awc0hnQ1hWNDhicUdMVlZ4YlkzckRv?=
 =?utf-8?B?MmhJeFI5UmljSm5GNGxwamZyM00xUHpLQW9FYzlSRmY5bllRVGFNcGtqMjJr?=
 =?utf-8?Q?WZE8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce74a86-e163-41ec-146b-08dcef6586e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:10:51.4784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW7fOuppRXugTOJPx0dd4gyL+w6DVAeaykvgEa7LT+98PGhcjt+CAA3KVlEk2oOx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

--------------8JxE4Oa2mzu0zxJQ9tBdzh1D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 17.10.24 um 18:25 schrieb Sunil Khatri:
> Use the helper function amdgpu_ip_block_suspend where
> same checks and calls are repeated.

I strongly suggest to squash this patch and the next one together.

>
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..df57efa019ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -364,6 +364,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
>   				   enum amd_ip_block_type block_type);
>   bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
>   			      enum amd_ip_block_type block_type);
> +int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
>   
>   #define AMDGPU_MAX_IP_NUM 16
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b7277bef7463..f69aba68e7b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -272,6 +272,23 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
>   	sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
>   }
>   
> +int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +	int r;
> +
> +	if (ip_block->version->funcs->suspend) {
> +		r = ip_block->version->funcs->suspend(ip_block);
> +		if (r) {
> +			dev_err(ip_block->adev->dev,
> +				"suspend of IP block <%s> failed %d\n",
> +				ip_block->version->funcs->name, r);
> +			return r;
> +		}
> +	}

Please add "ip_blocks->status.hw = false;" and remove that from the 
callers as well. Apart from that looks good to me, Christian.
> +
> +	return 0;
> +}
> +
>   /**
>    * DOC: board_info
>    *

--------------8JxE4Oa2mzu0zxJQ9tBdzh1D
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 17.10.24 um 18:25 schrieb Sunil Khatri:<br>
    <blockquote type="cite" cite="mid:20241017162531.1551442-3-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">Use the helper function amdgpu_ip_block_suspend where
same checks and calls are repeated.</pre>
    </blockquote>
    <br>
    I strongly suggest to squash this patch and the next one together.<br>
    <br>
    <blockquote type="cite" cite="mid:20241017162531.1551442-3-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..df57efa019ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -364,6 +364,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 
 #define AMDGPU_MAX_IP_NUM 16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b7277bef7463..f69aba68e7b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -272,6 +272,23 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
 	sysfs_remove_bin_file(&amp;adev-&gt;dev-&gt;kobj, &amp;bin_attr_reg_state);
 }
 
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	if (ip_block-&gt;version-&gt;funcs-&gt;suspend) {
+		r = ip_block-&gt;version-&gt;funcs-&gt;suspend(ip_block);
+		if (r) {
+			dev_err(ip_block-&gt;adev-&gt;dev,
+				&quot;suspend of IP block &lt;%s&gt; failed %d\n&quot;,
+				ip_block-&gt;version-&gt;funcs-&gt;name, r);
+			return r;
+		}
+	}</pre>
    </blockquote>
    <br>
    Please add &quot;i<span style="white-space: pre-wrap">p_blocks-&gt;status.hw = false;&quot; and remove that from the callers as well.

Apart from that looks good to me,
Christian.
</span><br>
    <blockquote type="cite" cite="mid:20241017162531.1551442-3-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	return 0;
+}
+
 /**
  * DOC: board_info
  *
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------8JxE4Oa2mzu0zxJQ9tBdzh1D--
