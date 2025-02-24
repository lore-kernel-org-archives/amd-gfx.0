Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C94C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F6D10E2B4;
	Mon, 24 Feb 2025 13:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kczDo4ai";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EFDF10E2B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 13:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKkJAuUXFUOIHR++aX78G2nOBCAqkDy5UnWEmUOWkS7nKVR0NrphZP3AohvEa7Ro7t5goT+hVAuy9lIKeQQtoynDgYV8wexxt3W8BVycIuD0J/jTsGCrTByvA+Z3jb+hsZlvEtjv4SeIM3XRs8NskQG0iLnr9wLNKs+Oj6xE30tj4qIsRIGNYeNrayi0EbXS181Ms+1uoYJcoYA8rSQvmpk7zYoZtuvFTGihfUvrS3X9BwrAa5uZsUeXRKPwv6EBen8WxvjLKMUrfEO9MiRMOzTfvlVZ5tU+gaMENqSz8G7AAPZxAEL3rbYHV/8ftX1b3NmnMbPz59DjZgTdAi9k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptGHSKKl7OM+MF9F8vI2/5urafudIDEdePv+bqhvtsQ=;
 b=pMkbnf2X+bS364ufJl2I7kZ7TJA7cjnHkZcduyZStDw9V33XYkY8DiG0u410xo7ukShuHurap5WwvbmFDBWP773lqhNoifywCA8R8kJ6YB+F5PYyk/fD5UHJcDUYOkf2gj3IktkZ/1fw1nzomiGBg6qTwtrhm426ig6EMTEckkFL7cTmjOBYlle56SwqfTUsc5OcolfbSDj3YFLp2aq8PjIMMaLewadIhfd8G09fNnHXggsnpuzn1dMeiD73dPlpPHYcC9290v4HGAiVFulRsk0ziQ9DOhwTil6j66Twy5OecEVRXMDi1+Rn4v/n3BpbGWiJR6qnLtLS0sldwhNVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptGHSKKl7OM+MF9F8vI2/5urafudIDEdePv+bqhvtsQ=;
 b=kczDo4aitBAmeq8YxHQlJwzQrcxVT4480pG54TJtxrlHOZJ5/JJWjdwW7H1/WEEb3bacV0GHHf5Zw10FobCEqQ5LWEmIQYm5is3c0Gr83gaAScuY8LHq793pupnKAj1iE/lHsvhSfmrfrZYI8kPZNrkXHRTL5U9Q+pALXfDDxAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 13:24:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:24:17 +0000
Message-ID: <2dbe7e0b-86c4-46c3-9b0f-4cb5a12668c7@amd.com>
Date: Mon, 24 Feb 2025 14:24:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing parameter for
 amdgpu_sdma_register_on_reset_callbacks
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250224114550.2289805-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250224114550.2289805-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b5eca8-62e1-4e15-fb8f-08dd54d68a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJiSVM3M2h0YmpwTlRLbHM3dSsxQTdGK1lVaGJLV2RiSjh5RVg2dktZM0Jx?=
 =?utf-8?B?c0FKRm1SdDRZUHdWVzdERlVMMU52TFk5cjdUVHE0a1RiUWNxd1pPN2tkTGtp?=
 =?utf-8?B?UW5aK1RqVlhmQ3JYYXVxV3hKVnkybSt5VVdvaFVKYUhVWWdRZFRLMnZrZjU4?=
 =?utf-8?B?Z0hYeWNDdFh0RXYvOVcvbG9nVFZuY1d4SkZobC9nbnJuaVVjeEVWRHVMU2pV?=
 =?utf-8?B?U1pHY2RZUVZFTmY5YUppdzVLeVZRcUJvTWplWDdqNzNmbU0wdXpBSHY5bDFQ?=
 =?utf-8?B?eURjQkNmRlJmdGZnRHNjQzcycnNtcjFzdDVNanR0ajhFam1ya0hpV2V4d0ZJ?=
 =?utf-8?B?V2wwVWZiVEJYNEpTVVdISmdQSmwxSS96Rk9oK0xxbmdtazFxazZ6THQwckds?=
 =?utf-8?B?NW1UdDN1TEExSVQrMjY4Z3Z2UXJVci9pYmE4a2pTc2V0bWk0b0NnY3VkTmcy?=
 =?utf-8?B?Y01vWktuYWZmUFp4MDBHcmVxcVhGYkIxMURNL1pMempOcld1cy9HZnBnMXZ3?=
 =?utf-8?B?Y1BZZ3V5bFMzdTVSY3Vncnk3ZlhuMmI0b3ZrRTFMQStKMTBYMlg5SUxhQm5U?=
 =?utf-8?B?K3FxSWNYUWMyRTg3MEZnMGVGK0pWMzdON2Z4YXROcEQxaE44T3ZKZVZCWVda?=
 =?utf-8?B?bVFsKzJGODd0QkpyQnFUZWVHelhTOUxvaHNFd21GMmpRVFZISDBhQlBwZnRG?=
 =?utf-8?B?SGp0TGljSWM1c1pMcjNKaXhiRy9zL3ZJbXNRNjNkcC84YWpLZ3duMVFHZEdS?=
 =?utf-8?B?RUsveGN1dDV2SGNVV3dTbnZCT0d6WGR1TG0rZVdwcFNSa3JUekdCTVVTQmty?=
 =?utf-8?B?S3V3VXpGQXJpRTJjdlRqalJqLzd4WS9zOE9XVnZidDFlQmVtZU4ySFJSeTJ6?=
 =?utf-8?B?eUhiUnp4a3ZxY3ZxVFUzOFNadW1oaFNDYVhuWGNsdWZsM2QwUDFWc2lsTkxX?=
 =?utf-8?B?bGtXd0xqZ21lUTl3TFgyRVc3SnA3eWwwVzYveVZKZ25jQzVHV09tdzNyNkly?=
 =?utf-8?B?OVZCemNDNUdOZnUxc0o2cjFhS2xKM0FIdm0zUHNjdWt1ZVRLSVc5dzh1NFZo?=
 =?utf-8?B?Q0s4bkpSaEw1bnVBUlVGWmJlQklhendHcFlWdjJNTEpRWGZhMmZ3Q1dZWUVP?=
 =?utf-8?B?WDRiQnhqOHE5cnpncXpRWnhwMG5tUmQrNHNuNXcydXRHdzkvM1AzMkU3T013?=
 =?utf-8?B?QW1OcmRkMmV2aXgwbzQ5dlY2bU5iT291N1pDaHhHVHBHdkNBMktPVkFmWHVG?=
 =?utf-8?B?TXNBeCthbi9YODhNOHNXQ0tIZUl3bW05ZmtUZ0JoZDU4dlFIN25BT01ubTZQ?=
 =?utf-8?B?dU84TDNUc0NXMndkK3R4NXAvcldjV0xpS1JjeHcyQURGOTRuVVhYTTBmTng1?=
 =?utf-8?B?Z0dpWDBlcDFMc2g1MDZpcXcydFdSWXhUYTJ0OVNaLzBpQVAwckNvL2Z6ZmE2?=
 =?utf-8?B?Y00zcUhJOEt2S3JvL2Rmdzd1akF5WkUyOXZObW9zWmM5dkVRaUJMUXBzUU5K?=
 =?utf-8?B?bGg5SFZOOU5tWWhBMWVMSlJPSEl4N21YTEtFNVJGaG4xejBoUGVCRDYydzlL?=
 =?utf-8?B?L0ZzUFhRdDNFNlNtWVl2c25aNE8wUG85M2Rua21iYmNRaVFkN2t5Vzk2YW5E?=
 =?utf-8?B?NVBpUDZhNUoyejJDQWJONzZCZHR1Y0djNStCS0t4bHVwOE5qV29jQWJ0dVdl?=
 =?utf-8?B?VEhlUFoveEVhYnlyQU1VZDJQVlNjblV5U1V1OXdscU5Pekp2akErSWVpWG5O?=
 =?utf-8?B?MWc2QnNSVE1qUFg2NTJxeGUrU3ZoOWlRczhNOEFWSTFyRWl1VEV2UHBWU0pW?=
 =?utf-8?B?eFk0ci82NVhPYWZwN2hKZDdDQ1U3TEVUTlhMajRXTTE2REJuYmI0Z3RDQVZy?=
 =?utf-8?Q?DWrpdVt+RLX4w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZlUWNqd25FRlI1ZUlqYm9rQ0R4a29iZkpOMWJDNGtzdGpTdm1mdmR4V3Bw?=
 =?utf-8?B?YmJvVkswZ2xwZTcvUjMzMmduMXBTZGlUcWI0eVlySEpwWTQ5REtjeVpub2xP?=
 =?utf-8?B?cFcveHpYNGVSblV0a1E5YnUxMXV5a1Z1OGhXUURRcVJEcTQwa1dPd0tZOFIx?=
 =?utf-8?B?VVFMNEZySWRqbWw1TVRMTVZJVE03M1IzY2JZWUtQcWZvVFFDVkg1ZDBWQytt?=
 =?utf-8?B?MTJqZDJZeXhLY3ZGUmc5NTV6YjNTSDdpN0xjTHhLSTdLUTFiVzNtQi9POWtD?=
 =?utf-8?B?cWRpa0MwcGFhZmxaZDh4SUtyN0FvT0Y3MjdLdk5FTXByZ0h3Nys5VGNlY2NX?=
 =?utf-8?B?cHcwVTRZS0swbzNrN0xGTHNHdE9Odm1LaTJ2VitlYklJblozUzY1U0NJUTN0?=
 =?utf-8?B?eEVPYURZYTZrYk1DdC9LTXBEZFIyMitpcFVFVzZhbnhKeVJNY2Y0Vjk1MGUr?=
 =?utf-8?B?Qit0SjZtY05KdWd4K2ZaaGNJUXFSVWpadDlYck9iV3AxM1hvcHlDbmhqSTdO?=
 =?utf-8?B?RUdBa3dRQUJwWUpxbmt4SFlwS2xiVUNOK0k2N1R6RHdqc25sT25ZdUkyR2dX?=
 =?utf-8?B?a1dNK21odmY4YkJOUkxOYVhNZVNXUC9PTWpPSXZ0UUxUUm4weXlMSlZOYk44?=
 =?utf-8?B?bVVhUTlmUjEzQjArYng2Vkt0UjRubldMZFBEN0ZyK01kdmdqT3pzYnBzYU9R?=
 =?utf-8?B?RlJsUmFFSEpRQ3RtZU1TUlN4cFJKenE2MTZkMnJRSEJuNjhQQUNlcklWdU0x?=
 =?utf-8?B?dHAzMUxCU1ZoT0d0TnNrczN5Szd5cHVWa214QTB1VEJNY1Q4VUJaOFM4TWNQ?=
 =?utf-8?B?NkJJbURtcHBRVkRRY0FUaUZpbVR0Yi82bUtYRFVMd1V1dk40MjJJR0ZYTFhq?=
 =?utf-8?B?UU5iV3IxU28xTm9GVXNVRzBkaThHc3Jmc29YeTFWYzlXVkZRdWtlcWZrbEt5?=
 =?utf-8?B?Nk41R25TVExCY0EySStBOGZsNVp4RzNoZUlXU2c5cUpvdGhwQTdiRXhoTHd6?=
 =?utf-8?B?bThvSUo5dzNGSDRmUnNKZFpoQkd0OTU1RU5yU01VV3k0RnNXQ2JyT01ZdlVR?=
 =?utf-8?B?Ui9rdzE5MU5PREdIYXU4RVBXWW5TWHlhYTJXa1FJK204and4Mlc4NHFVT1Ey?=
 =?utf-8?B?QUJ3OHFwMkxsNjI2SHplenJtbXIwVTh3RHdYTGFBK3RxeDFvWHFTV3BQV00y?=
 =?utf-8?B?SmhRcFlTYmZXMmlKc2Rvc2w3MDZiR0dOU1JpZTJwR0lteHNaLzBBYmlDMlpx?=
 =?utf-8?B?anE1WUR6STJOc0dqdTl4bkxJR0pSNkRuVzhsMmh4SDFKRDNvVjNkZ0xkZDhi?=
 =?utf-8?B?TWdLVnpZY2UrWHM5VzdJMjJTN2YvbEN3b1RJZG5CRjJUV1JpNzFvekloQlFw?=
 =?utf-8?B?bm1xTHZTRjlXNThuaXpaeE10azdEU0VCNmZ1M3d4VlFILzV3dWJ2S01Qcmlu?=
 =?utf-8?B?NFV2YkQxZEV5aGlMWUIxVUxUNk1mMlIyWnN3WWlCcFNIeUZqUzBTbmgyNHlB?=
 =?utf-8?B?OXBTdmVPbngyckRGVVkrNFpPNW5YQXhFT3FlZ3IvcUhXRGZPSWt3ZTRIQWVG?=
 =?utf-8?B?UHR5RGc3US8xeE8wbW9SbVc0M0VLaEhsQ1VGVm90cXVGU1NiNjNkSkY5dkd2?=
 =?utf-8?B?Y1QyRWJKY2NaQUxNNFZoOXU1RUNiWGJiWGxCb3BUZnk2YXQvY0ozcmdEUjM0?=
 =?utf-8?B?cU8yM3hSd09BSWxMS3ZRMUl5MnhnZE9RS0hWMVloTVNxRDY5VWl6TWhoRkR2?=
 =?utf-8?B?V0tOK21pV3VWTjI5R3RrSXJvcWJva2NmbmVQc2tKbXBkRjZGd2Q2cXV3R3Iw?=
 =?utf-8?B?cXpTTFZNcWd6c3RwV1JWclhtWmNhTGdWL242SGsxSi9tTlI5eU1zb0MwTmJW?=
 =?utf-8?B?WHcrNDZZc1VjSThJazhuN1RsU1BVdkc1QUllSmRVTFFIVkRDeDlSSkJCT01H?=
 =?utf-8?B?ZXJ4QmtEcSt5L1ArYXk4N2wwdVBsbUtGL3NDdFUySVZOM3liSklteTZCVytl?=
 =?utf-8?B?VThLejA2aHMvYmxSai91NFJLb2ZYZ2x0YzlGQnJpUXo2MEQ4LzNNWXlUZW8x?=
 =?utf-8?B?MktReThKdUt3NVk0SExuQlRocWlVUVNjT1NYTjc1N1pnQWxSVy93eFN4bWU2?=
 =?utf-8?Q?tFOM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b5eca8-62e1-4e15-fb8f-08dd54d68a2a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:24:17.6718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng/lnQs2Jfg88a9036kWkk72nRWWCLoFQLfO+hoZbez3uC0fP+YTivJA21rHW4wu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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

Am 24.02.25 um 12:45 schrieb Srinivasan Shanmugam:
> This commit updates the documentation for the function
> amdgpu_sdma_register_on_reset_callbacks to include a description
> for the 'adev' parameter.
>
> The 'adev' parameter is a pointer to the amdgpu_device structure,
> which is necessary for registering SDMA reset callbacks.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:474: warning: Function parameter or struct member 'adev' not described in 'amdgpu_sdma_register_on_reset_callbacks'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 42a7b86e41c3..82856592039b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -464,6 +464,7 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks

Why do we have a function to dynamically register callbacks in the first place?

That doesn't seem to make much sense.

Regards,
Christian.

> + * @adev: Pointer to the amdgpu_device structure
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
>   *
>   * This function allows KFD and AMDGPU to register their own callbacks for handling

