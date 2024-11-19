Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE46D44167
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 15:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2795010E66B;
	Tue, 19 Nov 2024 15:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UX5W5vc2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DE510E66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 15:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqgRPzjGvWpYllwsoUHLIIrZxJXOozok1m7u/dJTE8nubDboM5afem78qUZUdB4Xm9IoJpY3ppLbz/QVMmaDc0J1lhTDLVOlWKhwWjnd247xxBrNDJ2brArWi+v8Q2ePeff32B+MjcswjJCNroRNOzmk435nTwWh0QYnxwoD8CLwdb0j6WolX2Acd4xSgu92vKipDLiJbPiZwWWdF2aMcWyQqrDNJY4idkb/U098ef2nviufp12L2yy5qhTRpQhC1hrAWhbWtoPmZ+SfVMEg9UdBp5W2YkQOhQchY1ed2ICXjG8v1s0tl1tt8OGRBAHOQFeeaqLwrFI0Fa52OOJNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzTKxgt7jvbI1MmkwZOaSx9NbMCpy/Bjz5zKMB2CVgA=;
 b=XBlFV0Wfo3dXCy1TUH9EzSAoTlATWT+hVcjbcW/nenJV6EZvsBCD+gSKuyVRZTHurzhjlKd6w+22AIu0raRjEAEpYhF3R6pV4BwahgqXVtm16hYJKc+H7AiRC4GEVkvcpDKu8HVRkvBtMvtvv7bLPwQ+ZtHP9ofvCXvy36fNzwRqA1NOcyvc4oIFjayhiMaIqTt2OPZopEZMa74tBmcbS+U42rGhKj6mnpWYrVBbqAuRrLjd2+TFCq0iU03KAKMZ1qWwL/BMUr6r0lnkCR/8ZFaSzwZkF+IwmNW2gvcS2xFDy1b/pjRSsNt86Q7tO4DpfuL9tUFtBSXa0K8rqypT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzTKxgt7jvbI1MmkwZOaSx9NbMCpy/Bjz5zKMB2CVgA=;
 b=UX5W5vc2/+24ilBRP/t17ku/ZFD4iwNd8a4Adn1nLLptbGePYFMTVe4dPto6JMG3QBG+lTHg33s9rhm1TXn4utQKm/ZJvYyYLfik0RCQPkGRuhcUuIhAu/aR9RRei5Caap69hTjGg9zqbdccgQDujg3/4oq5v4chHHTmjgDbLY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 15:29:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 15:29:58 +0000
Message-ID: <0105de43-f8fe-4eb4-8b2c-81e5306f00e6@amd.com>
Date: Tue, 19 Nov 2024 16:29:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/amdgpu: Add support for isp buffers
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mlimonci@amd.com, benjamin.chan@amd.com,
 king.li@amd.com, bin.du@amd.com
References: <20240715144203.14563-1-pratap.nirujogi@amd.com>
 <20240715144203.14563-2-pratap.nirujogi@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240715144203.14563-2-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a41b91b-db6c-499f-ad02-08dd08af065c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFdxaGpHcWJaczZpcUVkZzM1RGdKeEpmcnlHRERVcHpnVXRxam55aFJ2TXg4?=
 =?utf-8?B?Ri83OGRSS0kyR1FZTkt6RWlxNEo4ZWNuQ0o4SkhUVUhicVNBSTYyWThMa2hn?=
 =?utf-8?B?VjFyMXlnS0FFMDUwbGFuQm9SM3ZvZGUxa0EydVBVRk9JV2NBNEZwSDNZYmhu?=
 =?utf-8?B?UDVNUWlKOThRTW9UdlRTeXZZbUZyMENYVnRUYXgxNHZ6L1Z5TDFueHRKUXZZ?=
 =?utf-8?B?ZHFRM2dZdHZFM25kdXBYMktJc1lxWTBGTkEzT3dkTERFWG5RTGxDcll1dllZ?=
 =?utf-8?B?SmxUdlJ2dm1oZzB1TTFjeG1BY1M0M2owMWUreUZlSi9zNk5DTk1uSXNtUnBY?=
 =?utf-8?B?aHB2eU1ML1g5V3QzVWNweWFEL3dPWVZReUNCOWFqVjg2OWRNaGNoRHNQNGZD?=
 =?utf-8?B?bjBFajZ2MmtDVTdkd2RGRmZBSXQyVDFuMmIyTnFtWVJrdkdoUDgvckFtVUo3?=
 =?utf-8?B?SXZTZHdwS0JkcnVxYmlMZ21xTDF2bkx5S3RXS0h4QkVqc2ZiNzBQdmJ0QTlU?=
 =?utf-8?B?R0ZkZkROWFErM2lRYU1zUnpmQUwxaldEclZVWllKZ2RNN2QybnJic00vTHYz?=
 =?utf-8?B?M0o2RlBtcVFjOFBIelI3RmZpS2dvRGI5ZWVYdTVjNm0xT2dIeDJGbkFTcjdM?=
 =?utf-8?B?b2d0S3RkSTMxb2xKWHZBZDBsbzNMR25Ec2JhY2RmLzltU3lIaVJBVENqSDhQ?=
 =?utf-8?B?aTlScFk0QWhFMU1SY3NCd0ZlNDV1K3oxRGpoWkJva0NkeS9oZ2toUnlwQ1VL?=
 =?utf-8?B?aXczOVlSNDlEOGQ3azAwZ0VqWEdBNWwyN2JwdW9mYWJZSHRObFl6eFYzL2hS?=
 =?utf-8?B?ZnNKRWp6NGRPWUNTSVdXMHRPZ1FTditwTWVLNTlDSVFINXdoalNYTDlFVENI?=
 =?utf-8?B?QVNnZFdJdWVxRkFSQUNqYnBDcDkxM3RscUNGL3EzSzZVNldtc3l6NXRSaldl?=
 =?utf-8?B?VFVNUm5vNkNwSFErUm9oeHpweXJTVjlKVkVJUi9NQUp4WHJvVExObVVWNmkr?=
 =?utf-8?B?N3pqSHpmYlcyTmwyWHJmQ0d6NDBTZnU1QjFEVnl2Y3VGUG9qN2o5V3Vzc09x?=
 =?utf-8?B?dUlkanlnNFlGelloK0t2VHlqdXdLYW1aY2Zya3FpS25jTGo4cnY1cVJYcjho?=
 =?utf-8?B?eDBoVktMeU5Ya2RVdkNSUG5tSHRGakplbWliUmpQVzJQaTdMeTA1QUxYYWM5?=
 =?utf-8?B?cEdZU2dMOUx4dmxZYXc0Y2xPL1B4czFjYXAzQVB2TStteHptRFc0ODhIZkI0?=
 =?utf-8?B?SjBkakM0bjdCUnUrVXE5aG9jenJyS0pSVnZuRjdiZkVsT0tSVUxTUnVmUEQ3?=
 =?utf-8?B?SHJSazNpR1JFTlFWbnduYmUrS3Y1ZEluMW5tM2wyaVdoK1FpTmRLQ25iTkIx?=
 =?utf-8?B?WStackFQRS81K1Z5WVVrZUNEZkR5eEswNnRlWnlzTkJSdmNXWFJuY1UyblVl?=
 =?utf-8?B?cDkrMWZKVi96L2FvQXJVRCtZakR0QVZCTFlTcklXUFdKR1BGMnQ1cldxbENU?=
 =?utf-8?B?RWx4RXNpV3RDejBWTEhjaGt1Ums0Y2R1S05NZHNKMnVNRWJUVlpWNXdrSkNC?=
 =?utf-8?B?ekJBOHl6czIzdHFHOFVWSFFhTzd4S3M4WkREdWNwUmc2OXU0SWlnWjRSMjlF?=
 =?utf-8?B?WThxU1U2Q0dtL2FFcWhIU2NJREZDSG1PTVVQSVZXSGVkNks5QVhZTWxsNXFl?=
 =?utf-8?B?UkJkM00xQUI0UkFyNzk1cWdUeVVuWlFtM3Y5RSt3QXVnemgwMS9UeUliSGFN?=
 =?utf-8?Q?5NKxhko6WC7NpIEHo0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhuYklCVldxZlpGazVnUVVkeVpHV0wzam5GaTVMMS82OWpwdjdzWitOdTgz?=
 =?utf-8?B?KzJ2NDloL2h6MU4vWmtneEd5V0JMMGZWdXN6QytnYWNadXRKbThyTGJGQmhx?=
 =?utf-8?B?cVdlV3psaWdlVnROc01YYk1iZkZ4aHNKT0ZuNy9HcVNPUkJzQWZKODRIQ3BT?=
 =?utf-8?B?SUFWOWxJa0lpeHlWY25YOG5HamR1bVJ1ZFhUeDhwZUl0bnBmaU1VRVoyUmpY?=
 =?utf-8?B?V2JxZnlGTExZalRlWlRqZzhaVzZsbHpHcFZDdDBXb2FsSTVEejNGSHJVdkg3?=
 =?utf-8?B?bTFyVDJyV1o1eENpV0tBeE5BTVpDUjJZbW54QXFKREw4Ykx4NW1PcWYxaDRz?=
 =?utf-8?B?ZUh4b1BoNUV4L1ROYkNTNHM1YlNqcC9kamVPWEsvdVdDdmNpZHIyano4TXNO?=
 =?utf-8?B?U1dEL3BqQ2VFTWNTVEV4djQrR0VUNGFDTXlaRFdZdU4zdkVObmJ1enBJUzRy?=
 =?utf-8?B?NnhSekNKaUVJOU1uWGFHQit1dTVwRzZyQ3JXTStaTDNKeUw0dlZsYS9PMzhX?=
 =?utf-8?B?QnBJNVBQcDY5OVRuMGtBeDE0aTQzR3FiSmJZbHdCMGhUV3lQNk02QUFOM2FT?=
 =?utf-8?B?RndQNHUzOFNrdmcvOG9TcUw1WFpIeWVCR0NXU0UybFY5dzM1ZS9sdzR2RlVr?=
 =?utf-8?B?ZjZWZGJOeDJHZEtTRGRHQ3d5SGtYaTE0TjdSeG9NejJhem04OUlzRmJlb1ZO?=
 =?utf-8?B?ZldnNzd1SUN6OFR3cUdFYmlPZi9VMzFoNGF3T3NlQ1dmdDNFZVhsdTU0RzRY?=
 =?utf-8?B?UEhjTm01TUtDZnc3K3ZsSlFVTzNjY3NabThuaFNlQWhYbVFhdXRpU0xvM1B3?=
 =?utf-8?B?RDJPbVg3VXRjRHNHNTZHcjdXTjZIOFVGR1dZWXlPYVlRRU54VlR1NzE0YXQv?=
 =?utf-8?B?dys5QW9jMktBUVJ5V1ZhZ2NGZmJKckZjeDhsT2g1azVnUEFrRjBIN21HRlFN?=
 =?utf-8?B?NUwyY3RDZVZUY05VZVVMazBGNWRYL2JzNStFMUIvTlFjTE9lcW85MnNwYkJP?=
 =?utf-8?B?VHQ2dXlvdDQveVBtaHJ3QmxNTlcyQmdCMU5JZk1ISWoxcUhjMzVKUDFMbU9W?=
 =?utf-8?B?dzZqQnFNdStkcWk1cTJOTU5LY3Y1QUpEbmh6aTUra241RXcxL0xZcXM0NUpQ?=
 =?utf-8?B?MGVKVExaQitQdDJSWnluZW5pU3pZajhYTlhUdjc5aUtsdFNVLzlVOGFvdXA2?=
 =?utf-8?B?TmhodGI5N3BRdU91Z3ZDOUlrRVFSMWhrY3V1YlFOSmI4U1poeVBwV2EvSFhm?=
 =?utf-8?B?bTNLMDBqNXBndm1weTUzaUtLblhrYStaaFUyL1pOMWZFWWlVcGswRGM3ZjdR?=
 =?utf-8?B?VVB5aVJ4SC96czNpeDF2ZktHeUhjRlJScE1pQjM5VkRYWW1PeWNXMW9USTNw?=
 =?utf-8?B?OFRnOGpZRWpLeHROcm01K0VpanFxcXMzRlJBeUxSNXZyU3I4b29qZjBvUWtM?=
 =?utf-8?B?dE96YVNZa3hxRnZ0Z0lrcDc2RnpBQkhKa2ZqWCs4SGxFM1lIeDgrdUo0OWUx?=
 =?utf-8?B?SVU3S0w5ZXhybGhrSWdnUkRxZlZ0dkU0a0dBM213Q1NyR0tlVmtiVURFSXIx?=
 =?utf-8?B?UDRjRXFLS25NL0c3eDB5YTVyQUlycDh4QTZDOWtaTmtLOFh2aEpLL3ZRdnZX?=
 =?utf-8?B?RHpNL2tiYjlhSHY1UU1CRVBieEtTSlNxKzF6QmQvM2NMUWkxTGFXYjlaUXhQ?=
 =?utf-8?B?c1RFRHFnR0NsUUZzQ29jQUFuVzFhdkQ2eE9xRlFqejdhdXJ3UTNMTzBTT0Fo?=
 =?utf-8?B?V3JncTV6VzdBKzl1V3ppaVlZKzRhYzJPcGZUVURFYUNTMDJwOVF5dlcxUXg4?=
 =?utf-8?B?Z015NG96cEQrNkNCd0taL3hRZS92YmE1ZjRlYlUzNjRnbUovQ2RUUmxPUmVm?=
 =?utf-8?B?S1oxWkZnVjNBWGlaRlJWY0FLdmRRcDhvelRRWWN6SHNLdm9UVE9Qb2RGRzho?=
 =?utf-8?B?MThjYm16czZ4T1RnM2VYOUhKOU4xdHozL2ZPdExNREgxcERSbmMreTUrOEJO?=
 =?utf-8?B?ZXlSVXAvRXMxQ2Z1N0xrYmFITTYxckM0WmNvNzJBaUlMbGdCL3FtbjcxUFkz?=
 =?utf-8?B?dG5XTm1PbEpSN0FMK1FFcWJ6eXUvamVlMWp1MHpRYlFQSmwwUWlQeGhjMkVp?=
 =?utf-8?Q?ULKdfJtaty+sJ03MnPm9gPHtB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a41b91b-db6c-499f-ad02-08dd08af065c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:29:57.8988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Dt3r2VkneYUsnNLPUeE4ay1HBZgdFIemJY9eFL+4wkgEkqB8RPj2wfxncWrXS8J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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

Am 15.07.24 um 16:42 schrieb Pratap Nirujogi:
> Add support to create user BOs with MC address for isp using the dma-buf
> handle exported for the buffers allocated from system memory in isp driver.
>
> Export amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel() as well for
> isp to allocate GTT internal buffers required for fw to run.
>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 103 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |   4 +
>   2 files changed, 107 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6faeb9e4a572..517c9567a332 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -39,6 +39,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_dma_buf.h"
>   
>   /**
>    * DOC: amdgpu_object
> @@ -334,6 +335,9 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>    *
>    * Allocates and pins a BO for kernel internal use.
>    *
> + * This function is exported to allow the V4L2 isp device
> + * external to drm device to create and access the kernel BO.
> + *
>    * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
>    *
>    * Returns:
> @@ -357,6 +361,77 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL(amdgpu_bo_create_kernel);
> +
> +/**
> + * amdgpu_bo_create_isp_user - create user BO for isp
> + *
> + * @adev: amdgpu device object
> + * @dma_buf: DMABUF handle for isp buffer
> + * @domain: where to place it
> + * @bo:  used to initialize BOs in structures
> + * @gpu_addr: GPU addr of the pinned BO
> + *
> + * Imports isp DMABUF to allocate and pin a user BO for isp internal use. It does
> + * GART alloc to generate gpu_addr for BO to make it accessible through the
> + * GART aperture for ISP HW.

Where exactly is this DMA-buf coming from? E.g. can you guarantee that 
this will ever be an amdgpu buffer object or could that also be 
something else?

Apart from that the patch looks good to me.

Regards,
Christian.

> + *
> + * This function is exported to allow the V4L2 isp device external to drm device
> + * to create and access the isp user BO.
> + *
> + * Returns:
> + * 0 on success, negative error code otherwise.
> + */
> +int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
> +			   struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
> +			   u64 *gpu_addr)
> +
> +{
> +	struct drm_gem_object *gem_obj;
> +	int r;
> +
> +	gem_obj = amdgpu_gem_prime_import(&adev->ddev, dbuf);
> +	*bo = gem_to_amdgpu_bo(gem_obj);
> +	if (!(*bo)) {
> +		dev_err(adev->dev, "failed to get valid isp user bo\n");
> +		return -EINVAL;
> +	}
> +
> +	r = amdgpu_bo_reserve(*bo, false);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to reserve isp user bo\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_pin(*bo, domain);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) isp user bo pin failed\n", r);
> +		goto error_unreserve;
> +	}
> +
> +	r = amdgpu_ttm_alloc_gart(&(*bo)->tbo);
> +	if (r) {
> +		dev_err(adev->dev, "%p bind failed\n", *bo);
> +		goto error_unpin;
> +	}
> +
> +	if (!WARN_ON(!gpu_addr))
> +		*gpu_addr = amdgpu_bo_gpu_offset(*bo);
> +
> +	amdgpu_bo_unreserve(*bo);
> +
> +	return 0;
> +
> +error_unpin:
> +	amdgpu_bo_unpin(*bo);
> +error_unreserve:
> +	amdgpu_bo_unreserve(*bo);
> +	amdgpu_bo_unref(bo);
> +
> +	return r;
> +}
> +EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
> +
>   
>   /**
>    * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
> @@ -433,6 +508,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>    * @cpu_addr: pointer to where the BO's CPU memory space address was stored
>    *
>    * unmaps and unpin a BO for kernel internal use.
> + *
> + * This function is exported to allow the V4L2 isp device
> + * external to drm device to free the kernel BO.
>    */
>   void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   			   void **cpu_addr)
> @@ -457,6 +535,31 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   	if (cpu_addr)
>   		*cpu_addr = NULL;
>   }
> +EXPORT_SYMBOL(amdgpu_bo_free_kernel);
> +
> +
> +/**
> + * amdgpu_bo_free_isp_user - free BO for isp use
> + *
> + * @bo: amdgpu isp user BO to free
> + *
> + * unpin and unref BO for isp internal use.
> + *
> + * This function is exported to allow the V4L2 isp device
> + * external to drm device to free the isp user BO.
> + */
> +void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
> +{
> +	if (bo == NULL)
> +		return;
> +
> +	if (amdgpu_bo_reserve(bo, true) == 0) {
> +		amdgpu_bo_unpin(bo);
> +		amdgpu_bo_unreserve(bo);
> +	}
> +	amdgpu_bo_unref(&bo);
> +}
> +EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>   
>   /* Validate bo size is bit bigger than the request domain */
>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index bc42ccbde659..17aa99b8311d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -299,6 +299,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   			    unsigned long size, int align,
>   			    u32 domain, struct amdgpu_bo **bo_ptr,
>   			    u64 *gpu_addr, void **cpu_addr);
> +int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
> +			   struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
> +			   u64 *gpu_addr);
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       uint64_t offset, uint64_t size,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
> @@ -310,6 +313,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>   			struct amdgpu_bo_vm **ubo_ptr);
>   void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   			   void **cpu_addr);
> +void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo);
>   int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
>   void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
>   void amdgpu_bo_kunmap(struct amdgpu_bo *bo);

