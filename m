Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6E4C52D6F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 14:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BC910E2A9;
	Mon, 19 Aug 2024 14:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4n/rxip";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DF710E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 14:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDnCQfob/dPgBwffuc/N8wN5pJ7VvrjNzdcdcaEtCGWtbnkq4GM14O1OJf4wp1V7fp1fqCl54rAmCSI+VRFMnTLgH3SzTQKRRoP9atL+uPHnSSLojCa/YXhOC8n/TL/JY3+YE4YukvxZjPExq9sqaMUQlgl3foHL5rb3XM1bOg8LiXENW3qP9euVaIlfyylLXfVaVFly0Dr2y8Ii6TyUuwWv5hD3DKC5w5Qm3WFEsUI3HvWjpAbAY2ahJOC+bAwt5FEdSMe5ESozo1uJQIGBrHKi+TiJxW5DsnScMu6qmumJ5qsW/8lY1hYVouezg595z4jCGs4lOcvp+HuHOEVjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SinQbFpwACO7rWHM4mb1YpTPOiIeOJdgCbm/lnVzzug=;
 b=xcRE3V700oo3qHGNFBpOw4Gvg6XgfUvWv6RXiVj5DtMCXj722MqBLnM9rAMA893NG/wrN4o9ngsbNQPx69Yhd1JKPD6DyR1NTpdrVsyiVjFH5X6H6gxn8X5rChYITp4niAEYvsrpzhpu+69Z9NZy83DTQF7j6tyGCslp4V+po3s+SIvU/mxuQX3LNAXCnw9Vw2EGsMiFo8nj0UnPTcrBuAkW9bOef/hkP4N/4YZJCj7Ii6cuFqtu+Oilawigp3Na8wlgAQPnrKtaR7irO1992sGIrZyo8HebE0RXJCiuU6fGDEKvM4CrNAd1leO24CSH1DQ3ulHIekvNkwhqWcb4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SinQbFpwACO7rWHM4mb1YpTPOiIeOJdgCbm/lnVzzug=;
 b=j4n/rxipeICCSFWSRqC20oqPPPNeiWJYmfWJI1cuo15QKdoPm44/t7mCiYId0MfaHQlZ0T9B1LIILFmWD3mv9Q25oWxmBllp0PGqf5KJ1ccsGsWJPakGadUfjDrhgm0S09PoDBrX0j71ltJujZYi7246Som7rvJBPiMfJCAsZ6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:41:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:41:16 +0000
Message-ID: <d7564130-4f0f-49f4-954e-dbc108de0019@amd.com>
Date: Mon, 19 Aug 2024 10:41:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amd: Introduce additional IPS debug flags
To: sunpeng.li@amd.com, chiahsuan.chung@amd.com
Cc: amd-gfx@lists.freedesktop.org, hamza.mahfooz@amd.com, roman.li@amd.com,
 aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
References: <20240816225754.156098-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240816225754.156098-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0202.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3833fe02-3edf-4b70-469c-08dcc05cfb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk5DTmEvbXRTUm1vK2x6OXlYWlFlSjVnYWZTeUdIajU1NHRKdXNBOWM5dU9M?=
 =?utf-8?B?TWhRZEQ3di9VdTZmTHpzS1o0dUw2ZVF5NjhvUGZrUlI1VDBTTXJ6UlZzL1NJ?=
 =?utf-8?B?TDd0dUZMSVVvWDYvNlYyaTdUeTF2MUtSVUdPVnBVSkxoaEdMb2ZhUENlTW5q?=
 =?utf-8?B?QytOaVpCenQwSzhaQjZBdmlMUE4zVFgwWjBuWHBVTU8wSStWU21KZEZWdU1o?=
 =?utf-8?B?QWE0MC9zMjhyQUt4RXBha2xQUGFxQVdybzRXQ0RxbVQwdGxOTFI4elRoU2Jv?=
 =?utf-8?B?QXVQSkZlQlhtZnBwdVJwZWgrbGhLSDlPTUY3TDFpa3NMQXN0NVVqcFJIbHdI?=
 =?utf-8?B?dEtjaEg1N01ROXg3cXJOdzltc3ZObEExTUVBU3FhWEt4ZzlCUDFkck5qVXd4?=
 =?utf-8?B?bUEreDVyTVI1aEp3SHRyQWY1Q3dSb3ZnUEtlaDR1SlUzTWFneXVFZmlKUXIw?=
 =?utf-8?B?WUhCb2MrREd0eXA3QnZtK0lNcnFhR0xJdjdPaGhlRmNzWTU4c2ZHVXREelNl?=
 =?utf-8?B?NEplOFBYMVV5YkZjai9aRnlQNGtaSTlEV1Nra0VPa0kxMms2eVFXNHhTcllr?=
 =?utf-8?B?VG5PUVk4amJxY2hFVXlyODBBeEt3UURqZHNtY0dxQWtsVURPOVh1S0V5U3d1?=
 =?utf-8?B?WUxWb29kUlB3MDhMTHltekt4a0N5QTY5Mk1oQXlRTHJaQ2V4QWZtejZEb2Jy?=
 =?utf-8?B?Ulo5NC9UbDcyU3JFbGZjcVVCeVg3SW9nV05MM2c4VkFyR093NnVybCtZRE9s?=
 =?utf-8?B?clQ3bWRGdFQwRUVvblB0SjMzV1dLWGZNcHJYL21yQUQ2cndldnlPNzVsYm85?=
 =?utf-8?B?ZEo0Y04zODZQRi95SEdQZ3BveFpHV085MzRzaWt0K0wzMEJYb3lKSzA2SFVO?=
 =?utf-8?B?MmFOUm1Da2xZWmVDRC9jVUhwR01ra0t6LzVyb3lsREJaMDlDUWtWcEJyeitE?=
 =?utf-8?B?dkpWQSttb0FqakRrUHIyTDh3bHdUajROMllZQ3VPaHFwY2VNOGdUd3N6LzRV?=
 =?utf-8?B?NUw0dnpHUEV5eVU1cUF6bFl4NjNnLzYvdUJBRndjeHAyZ3RNMzlZU3daNmdC?=
 =?utf-8?B?dENUOWpXcFBValVvR1N1ejVOTDl5R3lnYXlnYnh3NU9jL0U2bTArKzQ5VWxl?=
 =?utf-8?B?Q08yZ1hybWl5R2NHTGR4aFN1QkZoUG1yQm1XRlVUdWU0RXdXV0ZEQ0lzZkJX?=
 =?utf-8?B?VkVpWGpoZ2RKN29HN1NJQ3JjZ2Eva0g1cFk2dzJtMzMyV0lpYzFOZ1dPQzU3?=
 =?utf-8?B?N2w1aC9McGJuNXNWUmJPYzBSaGhxY3p1SnhTQ0lHK1JsUk1ISXh2a2FKZ2hC?=
 =?utf-8?B?Rndhd3dhVm9FRXV3OCs0bU5RS01KL3MxM0dWWUdYRTcvWTQ0RjFMb1FjalNX?=
 =?utf-8?B?cC9qc1hFelA2MnF4eXNpWnAveWd1SEs5SEY1d2hUakNTbUpYd1FGVUxZQm53?=
 =?utf-8?B?SUVTTzFmRlMwZXUzZ0N3RDh1RHBIdFoyMkEzNTlPY2xWVmpVNkNKLzBDbUdN?=
 =?utf-8?B?ZGpUWEJqWmd0OEZwbXRiUXI2TmtTMXM1OTBWb2tJZGQ1KzFRL0prWk5oYi9k?=
 =?utf-8?B?QTI1emlPT3BkUGlkWkZWZnlmdnB0TzgzK3E2QUJnaGFtdDIvZjZaVkZZK2pH?=
 =?utf-8?B?RzgzREg3MnRjTWg0STh1eWF4SnN6ZDhoZ0d1QjQwb1gwMEtrQmJKbEFoMG54?=
 =?utf-8?B?TmlOMG9TeVNpeGtZbHRPRTlzWWFHMnc0SEhEdlZXazJUazgwNFhnanM2LytV?=
 =?utf-8?B?b3h0M2NTS2lIM2hyMEwxNHpIR0lzUHlzUzJ4Y1IyY25uVTJYWUhYZkxrWHRZ?=
 =?utf-8?B?UlVocm5EaWdZeWtOemxudz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG9HRG9YSWtmN0NPSnlmV3VHODAwRDhBeTlONEZBR2d0NEVxNHlKR0VpNmx1?=
 =?utf-8?B?VUZCenBYZWlLTExuM09NcTFSVkwxM1lHdDJuQ0NQM01UMitiTWhCb1FFMGRL?=
 =?utf-8?B?N0NaVEdna2tEY3FZRDlianQ2ekxlUGFMVzR6MjFkWkFiekRYM3locnNrN2tZ?=
 =?utf-8?B?Um41T0hrcU1raFFqM3Q5V2lUeWFRbzVIR3JDdllOdFJZM0ZsS1IvWFpadXFI?=
 =?utf-8?B?QXBZWXphOWpFMmRQbWFLL0Vxd1MwdUZJdVFLUS8yS0FTRnliL2F1T3dMYnlZ?=
 =?utf-8?B?OHZuMUlPTnlxYWQrWVJ5RTFqYjNURmk2ejhDUzVRR1ZOQWtrbXl5RndQZkFC?=
 =?utf-8?B?RVg1bkIxaUt6d2l3UWZ2YjBlSURoUXRTT1VXaUR2T3VxMDgvRUZpaS9PRjcz?=
 =?utf-8?B?WFpEZGNtNUlQNzYyUVAvUTFTK0gwLzFvQ3NSMCszcnZsSUlmNHJuNXFRYUk1?=
 =?utf-8?B?VTlxQkE1dE1DUkllSXNXcDArSXZhNmYyZjcvZXpHTjU2QVVVSU1zemljZTFL?=
 =?utf-8?B?bXpPTVpmUE90RkZqQVh3OFN2T1RtWTg5T0hHdXhMRityOUZLdWMrc3N0V2Qy?=
 =?utf-8?B?dWxKNFNKeHQxMnhUTXloTjdIOWIyRFluNzJoZlZBTkF2NzB4SG1MelhVNGFD?=
 =?utf-8?B?ZXpQMGthU2hOZU83TSs0TndsV0s4bDVJLzJYUm5iaUM2eWZNdHp0LzVnWXp0?=
 =?utf-8?B?TW80NXE3UjVOemlMcGpNT3JXS3ArbjRyOXNHTUZtQVhBTEVCUmRsdTd3c3Bw?=
 =?utf-8?B?bmxTZjJuTkZha2JXWVFpNzVQdTZ0bFY3bjZ2VTZFMlFuWFZaODh0cGxqTVFT?=
 =?utf-8?B?NERiTFJnUUxUb05LbFhQblRsUmJ6dFNqVm5qMlFvRlhBYURIYytMajJ0WlZV?=
 =?utf-8?B?Z3AzYmhId1pMdzRHNzRCZXJPOUt3bGtaQThIdmJEb3YycTFpRUtoZ0dBV2Nz?=
 =?utf-8?B?dkgrL1NHcEtFOGw4MmpHOVUrQUxLd1pGcC9PSC9FaEYxdE5iVlJ6UVVNdXh4?=
 =?utf-8?B?cDNkSlVSSEdhQ3dObUZQVm1WbHdpRk4rZ1pvclB5NFN5SXUxVlV2Mjk5elhW?=
 =?utf-8?B?OWdBODlBWDZPaWFOM3p1NnUxQjJaTEY0dnV1QWVsSVRIRXo1dlJpd0dFNU1n?=
 =?utf-8?B?c3QrQVUzVHViTG1JdW1PZ3BIRVYzcnE3QVhtZ1JtQWMvN01GbkNpRnlnNVN5?=
 =?utf-8?B?dExZaXFvL2tjY2dUTlcxRGJTWDM1SXBPWTMrbVVrRXZkczAwWmVRa0Exd21H?=
 =?utf-8?B?ZnJxdkhGa0gyRFR5OFlHTitNRldUV0dRRVBHOVcyNW1JMHdyejlKYXUyK2RL?=
 =?utf-8?B?YVNqVTF6QndLYmhURTcxZ285N1J0T2pwakpSQVhleGsrL2M4N0UrbENaWlZV?=
 =?utf-8?B?QXVOZ3luWjhjZ1JDV3NlUWZCVVlGUHFMdms2RTFvN1QyUERNY0tSQW5KWCtx?=
 =?utf-8?B?MVRIYXFCdnFVeURMT09sTjVjY2lkajljWmdUM0F1ZlNBbXdJT3AyY1lvbmRs?=
 =?utf-8?B?REJ0cVMvSTZnRFlsdERaMURNNldzZEhNLzEvMHlibG52OHJyM1FnRDlBM2N0?=
 =?utf-8?B?QUZMcTZlWVRoRUNKOHE5STZ6UEZCeEZQZkpPZlVkU3VzRTNQeEJCckwyUld1?=
 =?utf-8?B?ZGdsVkNZOTNXT3owQ3ZqdkZiSVlobEJBTm5KU1ZsWE1ZZ2c5cFFDOFpTOW9s?=
 =?utf-8?B?UStJRFNIRlNyd3hwanFQaU9YYVUycnYvTmtxMXdoSWN5WGxvb05rdkgyUUtq?=
 =?utf-8?B?alRjbXNKczE1ampUWjJjK0c4VjBzVm80czZvY3JzT21QRW40R0NLZnNRbHpS?=
 =?utf-8?B?aTFvM0JrK0hhUCtFZDk5MlFFQjUvWjdVZWVMOVJlQnliRmlvMWN1SDFLY2kw?=
 =?utf-8?B?dXlDcGZCUGVWNm5kQzdwaHd6ekFDZ2ExdGp0Tk1oS1Fwckp6VVNLaGhIejYx?=
 =?utf-8?B?c0R3Sis3UlE2YmZJa3NPNHVIb1pFM3dRZkYyM2NIUkQza1lFdEtPRE13Wm1m?=
 =?utf-8?B?Y2pzdjVDVUlNejgyTGRLSEFqbXc0aVBrZHZ2OVBWalIwWksrWHZhUTIyVTdX?=
 =?utf-8?B?TXlEWTFYRlVrdnFRZDh5UWVDdy9Cb0xFTXdtaXZ6WEsrcmNoUjNqNjJzanBP?=
 =?utf-8?Q?CxJvsg7YVIagIfHlqFs39Ln5z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3833fe02-3edf-4b70-469c-08dcc05cfb35
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:41:16.5213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0WcaX8oW+ft3ISx5KcexyoMWgvSQY7WIOyNf8jkJKm0mx/YclWgAaOGk+C7/asqI1jANkr8ycfXJlIF2hTlmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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



On 2024-08-16 18:57, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Idle power states (IPS) describe levels of power-gating within DCN. DM
> and DC is responsible for ensuring that we are out of IPS before any DCN
> programming happens. Any DCN programming while we're in IPS leads to
> undefined behavior (mostly hangs).
> 
> Because IPS intersects with all display features, the ability to disable
> IPS by default while ironing out the known issues is desired. However,
> disabing it completely will cause important features such as s0ix entry
> to fail.
> 
> Therefore, more granular IPS debug flags are desired.
> 
> [How]
> 
> Extend the dc debug mask bits to include the available list of IPS
> debug flags.
> 
> All the flags should work as documented, with the exception of
> IPS_DISABLE_DYNAMIC. It requires dm changes which will be done in
> later changes.
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++
>  drivers/gpu/drm/amd/include/amd_shared.h      | 59 ++++++++++++++++++-
>  2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dd8353283bda3..a18ecf8607232 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1864,6 +1864,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
>  		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
> +	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS_DYNAMIC)
> +		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
> +	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
> +		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
> +	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
> +		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>  	else
>  		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>  
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f5b725f10a7ce..6c12ca954a53e 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -61,7 +61,7 @@ enum amd_apu_flags {
>  * acquires the list of IP blocks for the GPU in use on initialization.
>  * It can then operate on this list to perform standard driver operations
>  * such as: init, fini, suspend, resume, etc.
> -* 
> +*
>  *
>  * IP block implementations are named using the following convention:
>  * <functionality>_v<version> (E.g.: gfx_v6_0).
> @@ -251,19 +251,76 @@ enum DC_FEATURE_MASK {
>  	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
>  };
>  
> +/**
> + * enum DC_DEBUG_MASK - Bits that are useful for debugging the display driver.
> + */
>  enum DC_DEBUG_MASK {
> +	/* @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting */

This function has a kernel doc but these enum docs are not
using /**. Would be nice to fix that. Not sure if we're generating
kernel docs for this enum.

Harry

>  	DC_DISABLE_PIPE_SPLIT = 0x1,
> +
> +	/* @DC_DISABLE_STUTTER: If set, disable memory stutter mode */
>  	DC_DISABLE_STUTTER = 0x2,
> +
> +	/* @DC_DISABLE_DSC: If set, disable display stream compression */
>  	DC_DISABLE_DSC = 0x4,
> +
> +	/*
> +	 * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimizations
> +	 */
>  	DC_DISABLE_CLOCK_GATING = 0x8,
> +
> +	/* @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR-SU */
>  	DC_DISABLE_PSR = 0x10,
> +
> +	/*
> +	 * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subvp, even
> +	 * if mclk switch in vblank is possible
> +	 */
>  	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
> +
> +	/* @DC_DISABLE_MPO: If set, disable multi-plane offloading */
>  	DC_DISABLE_MPO = 0x40,
> +
> +	/* @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA */
>  	DC_ENABLE_DPIA_TRACE = 0x80,
> +
> +	/*
> +	 * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN version
> +	 * does not default to it.
> +	 */
>  	DC_ENABLE_DML2 = 0x100,
> +
> +	/* @DC_DISABLE_PSR_SU: If set, disable PSR SU */
>  	DC_DISABLE_PSR_SU = 0x200,
> +
> +	/* @DC_DISABLE_REPLAY: If set, disable Panel Replay */
>  	DC_DISABLE_REPLAY = 0x400,
> +
> +	/*
> +	 * @DC_DISABLE_IPS: If set, disable all Idle Power States, all the time.
> +	 * If more than one IPS debug bit is set, the lowest bit takes
> +	 * precedence. For example, if DC_FORCE_IPS_ENABLE and
> +	 * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC takes
> +	 * precedence.
> +	 */
>  	DC_DISABLE_IPS = 0x800,
> +
> +	/*
> +	 * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time,
> +	 * *except* when driver goes into suspend.
> +	 */
> +	DC_DISABLE_IPS_DYNAMIC = 0x1000,
> +
> +	/*
> +	 * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) if
> +	 * there is an enabled display. Otherwise, enable all IPS.
> +	 */
> +	DC_DISABLE_IPS2_DYNAMIC = 0x2000,
> +
> +	/*
> +	 * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the time.
> +	 */
> +	DC_FORCE_IPS_ENABLE = 0x4000,
>  };
>  
>  enum amd_dpm_forced_level;

