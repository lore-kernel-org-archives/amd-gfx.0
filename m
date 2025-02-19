Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC36C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 06:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6208A10E467;
	Wed, 19 Feb 2025 06:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+pQSVxe";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148CE10E467
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5VmPRT+r7S19Z/0fBqNKxm4iyRyRkSUMvg74yXc+9oZdDKs/q8zlLIc7gBlcBDpyZeJx/G5bRD8eCtMAjOOdHXzZ6KRin2qOP/lCRwYAuyszY/QhX7nfYe+qsy79rcS3UEnR9Qm+Xmu3FyIoCpbMdo0j22sLMryIjeuRt3XZjI0f8bhHdPp/m44JLhsGep3hgwZK9oY0kHrysIOBff4TgYgijjw3jGlENFZ9WJfvLgR/o0PBPqoYCPhGBEBakkYEhvce89FBT8xpXTxcwSkB7ogAf8/TGjhbLTHaZcmwLM4zanGfvr9m4h7OiRtGOXEawYfnDv3TlthakZ/s+Nqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCuMcvHcvI3P2MUa6t1i074lU5EhUhWRj9QtsHYtNTM=;
 b=p0BM5ds/dqvOP1C9er5ZE5parEJ5XzWSslB5JMKb8dzf6D3/NCZo85fNPPWzlGDtdhAB806SsCc8LJu1ShFwBzq00/A70AZEViBPOVhzoqIommyfQ19It2WzGcETW18b80897z81EMoCgit1mXHtxgZQ/BMmZqyFWpD4BaV9PdfG++VTvYI0HxCm80VMZPL4SFnn9WZkDNvFPix0wKvYKMrxi0WLz6U4lr70EjHD66Zs8DRx8aHj8L4dgxitmeR6/KcOD96Bj6vhc7ihmPtXBUulP145IkgC4Kg6fLu7SEgw2ymMJP/G57bLdj1RMUwlW2jz5oly9Ec7IepXi9thzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCuMcvHcvI3P2MUa6t1i074lU5EhUhWRj9QtsHYtNTM=;
 b=h+pQSVxeL1Py4uOqjds8moNgEjFYmxqhyIDvVhcF/8UqX7hQtqKsJyk3q83UHrLQTE+EZK8jSMhjIX5Vn3b2BhfYEVuiCsKhzjnyDYkx+46f00edebR/SAW5VOkqYNIkeA9JlOACTT0Aiuj8Dp121egYg+aRVeK3flZ7UF6gBbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Wed, 19 Feb 2025 06:51:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:51:59 +0000
Message-ID: <e72d2d7e-5854-4977-a94e-e5782b1d2cd3@amd.com>
Date: Wed, 19 Feb 2025 12:21:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250219062046.3530422-1-jesse.zhang@amd.com>
 <20250219062046.3530422-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250219062046.3530422-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c31607-05f9-41ac-1b79-08dd50b1e82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXFqQTYxUFJyK1U4SUxqemdmbWNJU1dSQUdOSHAvY0RUUjNRVGZaZXFGTDV1?=
 =?utf-8?B?SnB2TS9PMUhmaWNkS2NrcFYwNm42M3kyRlhIcDdXcGRZTXpXNE8xSzNpM1J5?=
 =?utf-8?B?TE1xdis1emNmTFZQMjkvRVc4WWJ0ZHpPYW82a09oSUZuMGxRdkUyN1Q0Q1Uy?=
 =?utf-8?B?UkVwa1NzK3N0emthYm0wcFVmM05Jd1N4eWExWDQ3NUhmQWZLRmk1ZERuUGs2?=
 =?utf-8?B?cDgyclZRTHJuMTRGUjVaRlpXZWVqUUM4Rmp4b1R4aTZwZnNwMjRWUXN1U0Jo?=
 =?utf-8?B?bXVHaWIybXhhWlk3bzZjU3pxNHVzVFlGMEVTY3VjYkVObW9RZWFjSjZ6VFZz?=
 =?utf-8?B?azh2TU9xOXA2Z0lPdU1OTmczWnhjN1pjd3ZRTUxpN0RJMTZDbmxlK2FiZmxE?=
 =?utf-8?B?ejZUZTVybitFSXh6NnlVU0c1cUNFN0ZkTmp3SElIelZPZThhYXhUUWR4U0VP?=
 =?utf-8?B?MVRXQnRURFhDeXN6ZzF4dDRsZXc2S0ZtNFozUVl3SVcxUHFEU200eFdMcHQ1?=
 =?utf-8?B?b3JlYzdnOE1iM2k0WW9tS2hXMFNTbDJlQXpMSEhqMkJzUDJsamQvelJidjhK?=
 =?utf-8?B?dWtQWGFzc3BBT0tHZ1N1UjB4VTk3cVQ5YVUyVlRRaXZVRzJSUlJTYXVTUFZN?=
 =?utf-8?B?eXhiMWNzMUVLN09nQ1M1NXlaVzV3VzJTRnpOZEpyZVpicVFGMjdTNWxXUjFs?=
 =?utf-8?B?Yy9rQjhNM2tSSTBFamNaMGhlKy82Vk5hUFl6d2VlSkJMaysxaUcwdkpOWk95?=
 =?utf-8?B?WmFDU3BlZ1huMkx4T2tPdm9XQ1cvOEJ1eUEwMWJWMTU1WERrVFprVWFDVnZB?=
 =?utf-8?B?bmJZTkVCNWNlb0l3emdjdzVldU5ZUkdkSW9lQVFmZFhWNHdYVEdVbmtlYmIv?=
 =?utf-8?B?WWVDSGl2UTdTSGlObWhkMEIvekRGbGdVZ1hoSzc5TythQ0xlcFBPM2hrSWJR?=
 =?utf-8?B?bmtuWEZ6bzBpblVlVnpwSlVBNjNFRmhNYXpFVVYzRG9QN3dMV2p6Yngzbm1G?=
 =?utf-8?B?eEtDS3llUm9LZE82dEtoU2dYT3prd1llMGxFSGM2cjZwZTVqL296UUNQTFN2?=
 =?utf-8?B?MExubTFhakRWYStFTE9Dcjk1bWdZYlVkRnArTEI0UTgwTmJrUkthN0pIbEFY?=
 =?utf-8?B?b1RKTjlKa0lUQm5MeXBuZi9CRGRkWjd2THBydm9lMzhxZFZNRTFmTVFkd20w?=
 =?utf-8?B?QTNrNWlLYXh3SHllM1RWK2x3RUptL3dvcjdTek0wS0tVVlFPRFpUcXFqblMy?=
 =?utf-8?B?S3ovY3hxNXk4amFqUTdVQVl2d3QvTXF0dEpCSmg0NzdacVh3akdVNFRqYmww?=
 =?utf-8?B?LzVOWDVESjk0dStabXB0L2hvWjdvNnJLeGtMRWE2QkpHL2NoTUxlbU4xNXhu?=
 =?utf-8?B?Tm5nKzJsWTRKMmplQkRzZzk3VkFsUjZMYzUrbG8vcW1QSlZINndhL0tVbThi?=
 =?utf-8?B?T1V2eE10VzE1eERBbVFSaU9mcEpDbUFrUDRRQWhOQ3FselVBV2RJbzJFZ2Yv?=
 =?utf-8?B?c2hoTTVObTRiVlkxNW5OWjl5L21KNjdpUXEvOVczQnMrZkxvSG5JTFlGOXVO?=
 =?utf-8?B?RG5YeXE1Rkw1ck1peHREWEVPUS9xMEVLVzlWM1lPSWhvNU1wVnJWaUxKb0dn?=
 =?utf-8?B?Q1BxcEpXYTNGNyt5UnVnc0FPM3BRMERQSEF3aXM3OTU4NDVyZ3RkRHpVd1ZT?=
 =?utf-8?B?S1dPa2F0WGdFTFN4Sy9tYnZhVDFBWk5GRnRtbEk1Z3hVTEFsVTVJemZINGV5?=
 =?utf-8?B?MHhVTW5HYmFxT0tXZUhCSkViZmRqY0QzaHRTb1I3U0VNc1kwTUIwbGtFdlNs?=
 =?utf-8?B?UXZkbW5EY0l6RmxDWDFBK0RDc0JsdXpMejVqaUppWVhlanpMTVVld0Q0OWJB?=
 =?utf-8?Q?FebC2SpXRkJOJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZ5am1oY0tFMDlkbnJLajZwQnJSTXI2NjhndldZK1pEUGRsYXRrZUVyNi9C?=
 =?utf-8?B?UkhTY1pOUnJLR3hhQitBbWtidlV3UkZmNHk2Y2RUR0NpYm1Fa2F6cktXUnJo?=
 =?utf-8?B?V0RzL1IrYXlqVyttcUdhMUpmTFRsNjBQNW5tWU1nL0FadDJTelNWK2ROMGFp?=
 =?utf-8?B?dFVGVzhUOGl3TlQ1UVRhQjN0R1NlOUozNzFtTm1xbVgwRFZnTU1oOFB0NFlz?=
 =?utf-8?B?alJXVTBTS3dqU2l0SnFUaHZ5Vk5ZVE9jQnozSFUyZlR4aGlERmdwdElCalZm?=
 =?utf-8?B?RXdFcHVDbDdWNWpob0J1U1NsUUlZL2Q0TlJwMUFnY3Y0a1dNQjVwV3daWEV5?=
 =?utf-8?B?SG9LY3BDQTl0WGZjamN3cHNSdXlXaVlPbHZuNUtURmY5YUM1U3l5TnlrSnFL?=
 =?utf-8?B?LzM4TFR1R09qU3NIeHJ0dUU4MDdTdElaTGVuQmFwSnprQzRDRXhKaWRDU0ty?=
 =?utf-8?B?ZzJmM2RRSkFaeVIrU1c5Qm1UTHZvOUlUNER6LzdyQTQwMmZQUVdZb1ZyeUdH?=
 =?utf-8?B?TkNnRDE4WTFJZGtQWkw1eGNMOFhNQUNIYnM5UFJZeVZyWEZHN0UxU2l3VUV4?=
 =?utf-8?B?Y0diVWJQQ0UyTGlyajlDQ2tFbktuamkreHBCSWhubEd1RVNyR1l0R0Vsd2s5?=
 =?utf-8?B?aTQrNnZrUm1aNWJNMFFYU3paRnpoWlNOY041T01qNUM2YzdKdTZWd1FydU4x?=
 =?utf-8?B?Zldwbmx3S0VtelNhTStZdldIOWFLallQdzB3YzNFSkxrOVVDVlQ3Qmw5WjJI?=
 =?utf-8?B?U1dOeTVJV2JFMCtCNFRkMHdBUzVlZHJGT3h0ZjhNZDRoNkpITTliYXZ3ZlFC?=
 =?utf-8?B?REdmdW54QVJpTTExclIzckU4Q3VZYkF5dldjME03WnhqSEJ4eXNLc1NMOWV0?=
 =?utf-8?B?Q2NyRlpSeVVvOWJwcG9abENIOHJOcVZPZWprNktId3NmdWhIQlhMcDRXaXhw?=
 =?utf-8?B?M3VQWTJKWHR0NlEvVm9iS2V1M1E3a3F5cWFLRDF5eWx3WGx4aW03bkFTaitw?=
 =?utf-8?B?bWNsM3dOUnM2Mml4enBBMTlmQk5GWFRKYzNGa04vcW8wcitiYm1pQTFtYzZH?=
 =?utf-8?B?a3YyaS9kUjBrcUZSRkMzYnhmeWNuSThxYys5emFGQzlyZjZnYTI2STNqcWpx?=
 =?utf-8?B?WVhBWUFMNU9qay9KY3BSR2ZpakpieW5sSWl5SGF3aGRzUndzUHhRNWZ3TERl?=
 =?utf-8?B?dnhlUml3c00xVkc3aFpYVEhNc0xsWC9TM2RkTzhkR1d5Vzk5VUtNMUlvc1or?=
 =?utf-8?B?Qm9BN2tDYUVsVnhBeGdUK2Z0Zk5rSjZmRGVQekpINGhVbHJxclBPK0RyRmJ1?=
 =?utf-8?B?T2JRWmljdVBZM2QyR1ZXQnl4NTJ3STh3QXpUeHBGTXNZbkVwUUk1OFF6L0x5?=
 =?utf-8?B?M3lmdTdTRWExa2NjUWh3ZDErMGxCRUFSbWI3S29kYzVyaFJWMk03Y3JOTS9M?=
 =?utf-8?B?Tm5YWndzajBUWXQ1VzNNM3J0aTFTdE1iU2w2bWc4UVJ4akQxSlZxckFEUmV3?=
 =?utf-8?B?MnBLNlplaHpxM3orYzRacG9qaXF0OTFzU1RLbEdPMlFMNHM1VXgra1ZDOTVT?=
 =?utf-8?B?TU9wb2JIcDluSE81dWJFNUJ4S0MvZXlabmJCMFFXNHlIZ1VJRFJKazVtV04z?=
 =?utf-8?B?THAreU5IWDBoRFJxV3NHakVIdE5DNHlaaVFVTVpjeUVDQnJZUU5oUlc2Ym8v?=
 =?utf-8?B?OGlwZFptSlpvTlRiZTF0cEkzeXVKcDJuUHhKNTd4QU9IbUZhWGp5MFVqKzhX?=
 =?utf-8?B?WUgyVlpkUllrVEpsQmY3QVdJV0htSXBkakRWdUQ1aTJHQ2tpTGpoT2M3NHpC?=
 =?utf-8?B?RjNVemNzV2dNV1V6THphcW8yYXF2dXdDOVFBeXZRTk9mRDRmUGZOa3p0b0xP?=
 =?utf-8?B?UTk0RXB0eHA2YXFKZ1lBc3dhdjdrRUZ1SjQvRHBBWXpzSWwxUXdkMkxWeTZT?=
 =?utf-8?B?cmgzeHJabTNLZ2l6cGVqQTNSb1dOVTRmeGZiUkdhckVFdnN6WVRQK3RaYmt4?=
 =?utf-8?B?d1QveDVqeXMzR3BHaUZXajZIeUFFclpORCswdmwyaS9STXFQV2o5NnhzV2JD?=
 =?utf-8?B?anBHMjFpOEhxSWxMZTZQSWJBb3YyZm5wMS81bWpyWGlMQUMvWHJFbERvZzUy?=
 =?utf-8?Q?vnxBizU6W3NTMSIuyPC90SVSh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c31607-05f9-41ac-1b79-08dd50b1e82b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:51:59.4602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkFeUICNOT/l8qnRKE2Yhg3QC3GbyYiN936mo23gPiU1m6QBJqwfbKZMvx1FSGJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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



On 2/19/2025 11:50 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
> 
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
> 
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cb914ce82eb5..013d31f2794b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -601,8 +601,17 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_SDMA &&

I think better would be to combine ring type with something like this

bool amdgpu_sdma_is_page_queue(struct amdgpu_device *adev, struct
amdgpu_ring* ring)
{
        int i = ring->me;

        if (!adev->sdma.has_page_queue || i > adev->sdma.num_instances)
                return false;

        return (ring == &adev->sdma.instance[i].page);
}

Thanks,
Lijo

> +	    adev->sdma.has_page_queue &&
> +	    (strncmp(ring->name, "sdma", 4) == 0)) {
> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
> +		 * Shared VM invalid engine with sdma gfx ring.
> +		 */
> +		ring->vm_inv_eng = inv_eng - 1;
> +	} else {
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +	}
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2aa87fdf715f..2599da8677da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	 * to WA the Issue
>  	 */
>  
> +	spin_lock(&adev->gmc.invalidate_lock);
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>  	if (use_semaphore)
>  		/* a read return value of 1 means semaphore acuqire */
> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
>  				      hub->eng_distance * eng, 0);
>  
> +	spin_unlock(&adev->gmc.invalidate_lock);
>  	return pd_addr;
>  }
>  

