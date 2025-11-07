Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79251CCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 05:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7C210E12B;
	Fri,  7 Nov 2025 05:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="spC4jhZa";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038B010E12B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 05:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkKtOMALOYGDq78qU/THvz8h72Ys1x64nkQtMGdADP3Ddxo7ZZ5guPFMNHjzt+c9AGC+a1xcy4l8URIGdBMAMe8ay6n2hvx40fA6iEvLXU+QuElarFxM/uKF9k+gYZeyyvC4hUDNfOb1T6cXIKgQhoEACU1TC/tBndCWJeSGyB4fNw1NVxML3VV5YhcNXtFCutVGQSb0seFSzTWfFZ5e/UpZuSv++MEJ9xeBxHYUE1EbbToG4kYCKNc6vNve/zGHLK02AuBU4h1jJjLMcgiTgKhSyHtkTAUDKuMHxdLNdTWOVy6/FdAlvg1z+Jgo+FAyOs8rCuNV3J2CHHM6LeZDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7OUlJsQKBNiHFoQsvghkwefmQ4+E2mRBQC160rpCUc=;
 b=QXLo9jBL+yUhOezruBeBbWMmi2iWrKzjYP/QjO9f8iYmi7mk/R3JkFzBdSYFqgVQncmtFcyLjY7DxECCKDPF1TqwWaKOGOSL7vOkm7pjQQJucHQfPgysd079VgoZoiF2QFRsQqxd/X/8aXkulOn6QG8SHOxPrkCnMjieVkMHBhlei+hS1ek2FzJt2Um9U8vmHHbn6x8WBWNHDRbsTX851pBJVJXckYKfImWDbwLdXGdbzCHHaiuLMkEL5Rg8Z0JBQuAWa+QMFmdzc96m6YJP0Ph/bQF74UI/IPznsQxl2dE3xCxqJRPPGsCkiYf1lYNWIjR/6KlXCfI8vUb7CJ8BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7OUlJsQKBNiHFoQsvghkwefmQ4+E2mRBQC160rpCUc=;
 b=spC4jhZapFu7DrjESAyKRj40PkZmVBU6Fg2Iwes8MzJZ+HRaCoDedz0kssOfGNfOtIHWtON77AFog7CAlhZYQtZO3DRN8qmOO5h15bPyc+azOa29kSaPmf4LH7tz+1u4Uam0QOtaQiLTi/mJzfTo2DAWWvek7/I8skWJy19EHjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:43:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:43:06 +0000
Message-ID: <17496fc0-30f5-448f-bec6-8ca14010865c@amd.com>
Date: Fri, 7 Nov 2025 11:13:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Fixing the clang format
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20251105145047.167807-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251105145047.167807-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0100.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: fc403f66-bf7a-4bc7-a3e2-08de1dc08650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkVJczNnU2hiSTVLVWJNdmlKTVhtR2s1MHpUMzRrZHUyTzlVb1BEZWVvUFRE?=
 =?utf-8?B?VlFFaytaNjY1TllzYVorUlcrKzJrclVOcWplakphcWFtYzVjQ3lvNVRPZ1VV?=
 =?utf-8?B?V1hTY0NtTHROeno3eEkzd0h3WWo4RitYV1lacWlQYnhWOC9PbURmbGN4bTFO?=
 =?utf-8?B?UGJOMitqWG9yR2VSOEQrTGRXRDhrTzlTUXlXWWhoUExOREdSSWdJeERDNFlW?=
 =?utf-8?B?dnlzVElScGNDQUxpTEsyQWlyZDBOSHN0MllwejBsWVJkSCs4alIvQWM4L29n?=
 =?utf-8?B?NzQ3WkEvQThJTnNVYzdKVXErRzNEdGVVR1R6czl0UEg0b0hTZmZBZjlVaTlS?=
 =?utf-8?B?YmRiWEZFMjR3VzBYYTRUTUhqYVRHUTh3VE12bUZzU0hRZnM3VUQ4Lzl6TnJG?=
 =?utf-8?B?aGhJZ1VaVnlrTTBrVHRLQWpiWXJYQm8ybU9Ba0dkamhUcWZTRzVTcDZtN2dX?=
 =?utf-8?B?ZGhQdFo4S1R4b1JKbXEzK01FM1R4VGVJRVlSRXZZVHRLTGErODVhYUs5aW5i?=
 =?utf-8?B?WU9UWE0rdmZ5Y0lyMkh5TjQ4TTNtSFRQUXRUQS82akFyRTR5akhDUElYL0VQ?=
 =?utf-8?B?bXEzZk9RU2FMT3VlZnlCY2k4VzF4YzRQMjdEbFFPaHJaNnYxYU1vZUtUQk04?=
 =?utf-8?B?MlNFdnRlUnM5VGtTZnJTeGdwb2lvWFZzS2Rsa25DR3Exb2VoaFFFZDB1bWdw?=
 =?utf-8?B?LzFQR0pqNWV1WGUyOEtUa1NYZWMvd3dsWEY3Vnk0NndPa1QyNjh0RkdsU3VS?=
 =?utf-8?B?WWVVMFZYOVZhdUFrRGRMblNsSDZGUjFqSGJsVloybHJHNG1oalBaTEZ0T3F2?=
 =?utf-8?B?SFBmR01sZGw3MFJLQXJjWlJ3NCtlcE9DTW0yaWhGejVnbXhqQ1IvSnhuNkpO?=
 =?utf-8?B?cUR6MndSSzVBSTIwN3dNcTgvbHBvMHdncWs5eFdyeDhyV05qSytKVEVUeDND?=
 =?utf-8?B?c25TdjFKeDVhSWpReERNdUkya1k5ZzhkcnZLWE95aDVjRFV5eDA3THhJbHJ3?=
 =?utf-8?B?THBsbzJ3N0UrWkljUGFPSXhlL0FWajJPdlhYZEQ2MFVQSEtMTjRjT1RJQm45?=
 =?utf-8?B?dSt2OUtMQ1RmNU9xRGJmbHBpMXplTnA5NU83VkkwRGZYU3VBeE5USTlHRENx?=
 =?utf-8?B?R05pN1NZWE5OeXFPazQ3dVltRVNKdmo2cVZRRHdCaUdWZVZnRUpVQmxxMmlP?=
 =?utf-8?B?WXdsMk4yanBwTkN1T213UW5KaFdRR3IrQVV2OU9nekJHS0tXOHdCUEpsSXYz?=
 =?utf-8?B?TkdpQmtnYk5RZThLcVhyRWxod1lTQVIzTmhwaEQ5WVRQRXc3Ym5YUHZOSTR5?=
 =?utf-8?B?a2s0TDc2YjNxaDAzVG12L0xYbTEvWnBzVE16QkdVNWJVeGR2R1ZIdEIvUVZi?=
 =?utf-8?B?VTE3Y0ExUjV2ZU1Ib1g5bm8vdnlDci9kQ1YrOTFpeS9BcmZ0ZStra1p1cDJ5?=
 =?utf-8?B?eUFCYm9yMk1lSFdEZVF1ZkhxYTdyU3Azakg1WW9VelBTU2wya2hRM3VnSWh3?=
 =?utf-8?B?M2VUdjVRMjF4UHhhRkFIZ3RXMk5JdEVaU2lwYTNjMloxVGR5TTRxdGRPQ3JM?=
 =?utf-8?B?NkhHRUxDb2pwQ3F0aUtqaXV3WjB6NGVVZGYzQ2t6bTNHb3J2OExRT1Zlcllu?=
 =?utf-8?B?UU9hYUxMeTEyUWZ2YXRXc0lUM1ZBUEpIQlJ4d05PRWxtTHE2U1JoZ3JlWk1r?=
 =?utf-8?B?ZUtQREtXSzZmaEQwUW1QeEkxbUZYczJWNTB0V3k1N0tIY3JyYm5LRXN4YzdR?=
 =?utf-8?B?YjV1VVVDUEhFUndYQlhxN3RyTHNQN0tYd0IzZWpwT25kc1VGY0daTStFVm9E?=
 =?utf-8?B?VEhLSEV3Ny8yMnl4dWxFaHNLR2J1czl4NXBIbEZwQSsrWm04ZEc2MWRGbWRt?=
 =?utf-8?B?WXdsN2tWdDlmNDBJaGQ2OFdaKzJORTVHK0ZXTFV1YzlmeG1Xa3NJZVpFbGMr?=
 =?utf-8?Q?0ny1ushbZ20xKwUbxTxCG59aFuojs1KL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVd1WkRhSUJ4SnozMFNiM01rOHRoaGoyM3pwd2oxQno3b1VKN3E1NytRdmFn?=
 =?utf-8?B?TVBDUXh0ejBvRFIrM0syNi9hbzR0dnY0a2g3bW1yRFc3OTN6NHZxRkVVM3Vo?=
 =?utf-8?B?YUI5NDdrYUtGbGxzWGE0WlZkUzhBOVJ4RkZMRmtwMnJLRFlvZWgxYll1RjZW?=
 =?utf-8?B?RGFmSFhNazkwMWY3a2JyeXVmc1FLZllIeHNnRDhreHJYT2dSYWxnY3hMcUNU?=
 =?utf-8?B?OHNoQVFRYUV2cW5jN0M2cU5VTzFLVVpuL0srMGFBRXkrdU9Ba0hWQzZ3Rklv?=
 =?utf-8?B?Z1lOM1VpUUd3QkE0SjYzRWlLWE0vVmRhSXRjWFNpSCtTL0plWmJCc204cnFL?=
 =?utf-8?B?WW9xbEc4M2FSTWZRSXkyeEZLTGNxY3A2bWcwTDY4eUk0Q3JKYUQvWEsxSnZK?=
 =?utf-8?B?WmpEcHRWTVZDOXMrbWh4L2J3Q3AvNnF3NlhXMnphWjl5bkZtZG5XbVExTlA3?=
 =?utf-8?B?NlZYWVBQSERFdlpEdFg4elVrQ2NPcG5DZUZqbHlvbGxPbERMa1VlOHpHdG5z?=
 =?utf-8?B?MmxydStzUi9OWmRobDV4djNJb3RLVGJTN203Z2hXTVVpKzQxOWtlV2paTS9U?=
 =?utf-8?B?VUxwcjk4L2tKMjRaY0xweEQ5bnZKMW83VFNpNjQ1VDQvem1GUjR4SFF2WE8w?=
 =?utf-8?B?UjQrWkwyTjVub3ZvWW1sZDBrNHpvN0dhUTF4UHFyKy9zTXczTFhPLzQ0elp1?=
 =?utf-8?B?a0dqakFhcXJnY2pvZHFOa1ZxaHA2bU1KcEhxSFU1RWsraCtlWGxtZGlNK2JV?=
 =?utf-8?B?akVhZ2JwSlZMcHFWK2FDcWZORkdtcm1HL0FsR3UyU1FpWHRlK0NQMnowYUFr?=
 =?utf-8?B?Rno4RnZyR25xWTRLWm1QcWIzVmVNdmRCemdlTUMyRzJCN2VOQ1BWaE5WYzRX?=
 =?utf-8?B?QTZraEtTTkNFMEJWNHBqdU1zYXhpWk50eCtsL3VrcTF6RDRWZW1uem81SGJL?=
 =?utf-8?B?S0txbDlqQWV4QlpidExEV2dzN0FDb0o5N2xWUUlranRrdWJwMWl0WG1aTDcz?=
 =?utf-8?B?czN0RmZZOE1EK2ZvS2xVY1dURnVyemxTSXR2QVo4SWZDS3FQR0R4RndLTG5h?=
 =?utf-8?B?UEZWT0pvZy80em1BZ2FLMDZOcXowcHQ0T1Vqa1hZZlNjamZJOUt4WmZneE1r?=
 =?utf-8?B?VC9KZ09obTRDbjMxZW0rVXZCYXphZzJzYkZCVWszU3JyZjc0d0VpdGUwWjJN?=
 =?utf-8?B?enBRWjhMOW9POG9BMllmYzBDaUtySUt3WTBDWW5Mc3hHd3o5UVhXM251Y2Fx?=
 =?utf-8?B?WUthQ20wODJsRFZNKzRtQXhGYzAwUm1GL05lQTlRZ3lsczN4TjhJTzZ5dzcr?=
 =?utf-8?B?Q3plZzdqY1E1MkJvdERMNnZKWHpxTzV5Vml0WnhmczdTSlI4RGxkWTh4S3Zk?=
 =?utf-8?B?TjFoN2c4NHVTWjBKenE5OGgvVzVQTldXTE5DTG01RTlYTC9hNzBmNExoRHJS?=
 =?utf-8?B?S2lKQjZHRHZReGxzbGdUM0tJWnFpdmNvVnFsSzlKRmRsL21xQ3VUU2RYNll1?=
 =?utf-8?B?UWN5ckF1am1YU0xsbzJjb2V2RDY3aGhPUEdZOWlGa2picnpZZG5MZEREdWJF?=
 =?utf-8?B?a3hpaVhGU21xN1J3WjFrUGUxOE83R0JId05ta0ZxYkQ3WVdtTUI4L2xYSE5Q?=
 =?utf-8?B?VldCTXdnc0Vnbk92dENhRGM5MG9IWnhhZ1M4VjlVNmN5Z0Y4aGF3TFhQcFhy?=
 =?utf-8?B?QXFvY3hOYTFxZzZGeFIrRlR5UnVzSXdVYS9CYjlOU3NUa2thWnYrNHF3SWQw?=
 =?utf-8?B?WGRTajNYMy8wcE9CTis3VGx5TkhTM25OenViMzJtRE5ibEw2Z04xeTBxYS9o?=
 =?utf-8?B?QlhpZzFtalg2WTMxN1pNYjRuWVAwdmJoUkZkUWNiQmtFM0pCSCtGL2g3eXdV?=
 =?utf-8?B?aDdNM1FMc1A0TU93TmhNQVpRWmhMdVREamlCZmNHcWEzQW10d2VlOVBwWVRG?=
 =?utf-8?B?RDB1QllFajRHSnQ2WGNyU3JaUEx6RmoyS1dWMUlXa0RFYUhjTEkrVkFXQmox?=
 =?utf-8?B?RUEreWVoQTE4OXpVQVlUZkthVEV0aFkzeGFNekk3UDlqWWVmdFZ1T3ZhR01u?=
 =?utf-8?B?ZkdWczZCUXJGWHlOTDNSb2M2d3MvWTY2QU90aUJIV0FzczlrRm1RcDlUMitQ?=
 =?utf-8?Q?PPtgn2I8DwhYkFKV4zPA+UvFc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc403f66-bf7a-4bc7-a3e2-08de1dc08650
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:43:06.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzYAeeURgzdEAxfUuG+0OQUw38UqKosJKGD8aoM45uh5EYbyoRig0m5KWG369CQz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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



On 11/5/2025 8:20 PM, Ahmad Rehman wrote:
> This patch fixes the formatting in the patch
> "amdkfd: Do nto wait for queue op response during reset"
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0904c36192c7..d7a2e7178ea9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2095,7 +2095,7 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
>   	while (*fence_addr != fence_value) {
>   		/* Fatal err detected, this response won't come */
>   		if (amdgpu_amdkfd_is_fed(dqm->dev->adev) ||
> -				amdgpu_in_reset(dqm->dev->adev))
> +		    amdgpu_in_reset(dqm->dev->adev))
>   			return -EIO;
>   
>   		if (time_after(jiffies, end_jiffies)) {

