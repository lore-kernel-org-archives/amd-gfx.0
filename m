Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C137C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB28A10EB00;
	Thu, 22 Aug 2024 14:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j5dIrVmp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4659510EAFF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUO6HNWWByC5AJVn3OgpuQqJtsX4Ei11hgdeDufDAukKo4A4Q7xs21BKG230SJRIZ1rhG50xxh3whYfchRWr4nEkMXFg39KIG0KUGGuz6kpynlYfi46wbiBC6EdSsWISGncw/xlOvDBU7FDm3IYDGmcPYGxYVL5r2SfeEC8jSddLnZAf3ICoHU1awwmoiCDcNC38q2Otuw0GYeRgEO6IMusFrNxdtA6cFluzzsH9cbdM3UTpCc1DuNm7pWPbocC64woKIKy/oe+ArsliyHenC+koce+UL0lGiOPqTNxjB0YedQcMOAKvKuz+Jcw/pw4ZRaK+AC8MMy3L1O9cvFficw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DouMLglRrenZDJZo9NeqBQjf2EPWfZvjfcyARmL7F8=;
 b=ggAEVVIL9MTlMfm2WhE9kM7MIbyYqvN9M5YMbiUVXWjBl9pvRQMBpN5oHtJ2aw/wAq9iUGqLmgAdxpCEBoE49dctJIFqsCmr8poMumBpaWqpjBs7kHrxjClwtWzdQBAzZb/WSC/tyhaxK6MAL0y9ymbFI9jESrBKzWsF1yWZNWgKkpCRgo7ArDTGliL2tcxU5dOwaeIhbjMZ74brrcPCwuBMhViZmCDwKHCx/AY/jGWJvqAvNHEvhHEaO3ruU0L9UQY1ypYtcu+4uIJpNuIdl0BGxkMpSIzOtsfwaFlrfo6VqThFcdJmU/obFlwzSJh4Ewz806WAdcyYZ9Bdb+Dhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DouMLglRrenZDJZo9NeqBQjf2EPWfZvjfcyARmL7F8=;
 b=j5dIrVmpGqixjVL4PlGBaIPJ5aqiauTW15Tf8eVTm2fNF+GDjLsnv2ypt0skik8/+T218ai9Wphdz8Sf9LXm/cAuVwPGIfiM4VbomjCrq5jEzyWndP+BsNaDUwBQLfLCbIOKuW9jxDWQzzVyuM1Uv1WEWOoLlut+ryclisBT3AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 14:46:10 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:46:10 +0000
Message-ID: <1503c782-a3d4-4259-81fb-d4d2ed683ef7@amd.com>
Date: Thu, 22 Aug 2024 10:45:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdkfd: SMI report dropped event count
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240730201547.13590-1-Philip.Yang@amd.com>
 <20240730201547.13590-5-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240730201547.13590-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: be1b1b46-361b-4063-177b-08dcc2b92971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0UxalBrQkZTK3dNalh5a2NsOExQZEUwWTlVWDlteEMxcWVMTzhaZmVhaEJ3?=
 =?utf-8?B?QjlwY0x5YVByYUZlN3lOT2g1WTRiZlJRT1lDQ1pDc1psaUk4cGdtRW90M0lo?=
 =?utf-8?B?NCtYVlhMQkNQSzZYbmJmM09HUzhKTkNjWXowNXBEdUIrM1cvZEdRaWp6T21w?=
 =?utf-8?B?aWpydDI0MDh3c28zb3dKNW1iMS9iNXY5QkhxMFFUdWs5aE5oelhRM25EZE16?=
 =?utf-8?B?ZDY3ZDdpaGpKWXBFWmQwZ0xEMnkwQTlxNEpqQ3h1N1hlWU5meUp0WWRjZHhG?=
 =?utf-8?B?bWJva0V2TG1kZWM5OXNPQXdJOTc3NU1ySkNwWWNmL0lOclRGdVB1UGgvUTZu?=
 =?utf-8?B?RXlXaGtybENyUWpxTlZGTXRuRXRpVTJVSkVNUmlJZzVPeFlaOGYwTFRDNEFE?=
 =?utf-8?B?SHA1LzVxSHhZK0toTFRvaDlxK0tWN2FtdjAzWjZTTVVxbjZ5T1JPRTJ5TTVu?=
 =?utf-8?B?WlFuK003aGxrRTR5bWJBc1JWUHNSUjFsRUcyRUY0N1VsT2tySDIwbDZiNTVs?=
 =?utf-8?B?WTkyUTZGYUNKK2lFVXgrNy9kZURQR1hDUXA4bFJhWWxTWVd3WUZJRG5qdjZE?=
 =?utf-8?B?djVGaFFhckl3K1JVdWpFbWpLaUpsKzFQRXMvRFQrTndBWUJvUUd2OUtvR0Rr?=
 =?utf-8?B?SmVtM0F6U29jSC9TN2NzdCtmUW1FT1luWmpqclIyYlloMk9LajhVY0IvZnBK?=
 =?utf-8?B?Z2ZrVEhrY2tHKzR3Mml3UVRWMzZHZjY3VDZyWHZFamZRQ1RaUWsvNGtGakNa?=
 =?utf-8?B?eURYRGs1NnJLODd0SXZvdUVnUDFPMFF0Q1krNWVzYjBTbVllN1JuT1ZkZTlF?=
 =?utf-8?B?TGI3blcxV0w2aFhOVGNHellXYU1IbXpOVldPN2xHMVFtNjNZWTV3V2Y2aVhv?=
 =?utf-8?B?Z3NLTlZUaFkyZ3ltbDJwdGY1amE2enFSQk5GS1R1Z2JkcDNpUVFWdklrSzd5?=
 =?utf-8?B?Q3hTbWJJSWlNTWVEeHh6dlg5NzVLMVh1Wmwxc0FuTmV3Q0xFZ2tEUC9jdUsr?=
 =?utf-8?B?TnhMUys2NXp4cDRNVTJtOFBOY1FsK0d1d1ZQREFxNXd1a2FNcy9LZzlRZDhk?=
 =?utf-8?B?TllubmYvYVhzclFjdGFXWFJlOGVYTnk4KzMvUjZxWFMvQld1SGgrcjhoWDRj?=
 =?utf-8?B?K3F5WWh3K0x3V0Fhc2NLN1lFcDhYc1VPazhLRllkTFRpaTJIUkpzZG1qS2N2?=
 =?utf-8?B?djFCWjRRN082N1lBaGZuRGJwcCtpa2hWZmZ5bzNhZDd3ajdhYmxubTd3SFhq?=
 =?utf-8?B?S0Noa3RaYzBOYlNpOXBwbElFOXlqWTVKZWVTb2JNUXhnOTJUV2E4QmdKREhL?=
 =?utf-8?B?T29JRkpxRGFkdE1od1lxRXFTdmJNZm0yUlgrR1hmSkZvMzR2V0J4SHlTNy9J?=
 =?utf-8?B?SkkrQXY0R0lyNlU4NVJaUi9LZjRTeUNtUmVYckplMGovMnJ3ZXBNU2pwNFZx?=
 =?utf-8?B?MmM4WjlZeW02Si9HeGE4RnJibC9WOTUyVDQ4Z2tQRnF3bWNzdmxpclliOGQx?=
 =?utf-8?B?c3lWdWFEaytkbEdqWS8wYjZWQXc5QWR1YXZYNEJraWxzbEVsLzdoZWdFaDNM?=
 =?utf-8?B?bTlZdUV1Z0dLK1FiS1pVb3VTKy9oUHZITFdxVEZiUWV0a01kbWNBVG1LK21E?=
 =?utf-8?B?bzFuelRPblBJL1FPblREZmhYb0ZvT0lHL1JMRDUzMWVjbmRDRmRrKzVmQ3hp?=
 =?utf-8?B?Q3E2YjJGMlRjVDhKS1YwdDZGUnpMQ082VVFjU01pTVF1Wkd0MFhDcEs3aUYv?=
 =?utf-8?B?Z25FdWYvTmFKQ28xajUxZmxRdGJTbjFiSSs0cWJCVG9ybVNGVU9aTzVhM29r?=
 =?utf-8?B?ZWNMaXVPcFhoelBYWUJaZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2xHQUJPRlJmRWp4TVNEa0V0WENjSVhqZjJ2aWIraTZIZW53VFlnODd1REw2?=
 =?utf-8?B?V3FDZ3l6bFlwUW1HQUF1YitWem9WVzNkOFFYTkNQYzN5M0loSzRPTzUwY0F4?=
 =?utf-8?B?N3ByelZYZERIcHJGckxVTS9SZ1c4Y2ZSQnkya0FnU0hLNzMzbURXaHdXWkpm?=
 =?utf-8?B?eURlNU9xelMvdjNmMjRWVkJkSDRaUU9xa0VGVDc1SGt2T3ZXb2JaN08wcGtJ?=
 =?utf-8?B?Q0M5VWdPaUFySW1CVDNTUm13L0krYTJkUkRZcG54WmFMTjBMcjQ2ejFCcGRX?=
 =?utf-8?B?bUhXS1pTaEtFNWQzOWdZZmJyZ0V0bklPWGdNallIMXRpRHZjWllZb2thOFM3?=
 =?utf-8?B?Z1h0N3Zoai9VOGdOZjZUMGRRVnJpQU9FeWs2S2Ftdk04aVY0bVVIbFFQOURj?=
 =?utf-8?B?RlN1ZkdYSUlyUFdKZEswY1JkSVhteWx3UG9tS3dVZHN3QjQrWEM4bU5LQThX?=
 =?utf-8?B?YTRxZ3RqRFdBWjEvbjdRUEUrNUhUMGNyeEd5a0pHbFFOREFidEJ4bk1vOXJi?=
 =?utf-8?B?clFZaXI1VlREMmllMTV0N2Z6VENRdUphSmRXdERLbWZyVmZDcEVGOWxZT1ov?=
 =?utf-8?B?ckgrK29WMDlxRUt6eHVZb0l1TnB5ZnRyQTZlNmJMZUx0NDE0NzAyMS82MHp4?=
 =?utf-8?B?OUNXQTBYOStzMTdyN1dNdllFUjhqTmJRM2tHOFVDMFRjempFeDJpR1pBTUFz?=
 =?utf-8?B?Z1ZIWWFmU29xeFB5Wm9nWTczU1V1bEMwRmF4czRKWnVDTTlsUXpDZnJUTWVh?=
 =?utf-8?B?SFJNcFBNd1pMQkNQaFRCanlmSnhadklpQUYwZ05ZYTJ0Q3RsbnJybnhSTGVV?=
 =?utf-8?B?aVVLekhOZ1kwOGhWNTgyY1o5dkR3RSttWDB4aHlvRDY0MElhOXpXUDhRVWt5?=
 =?utf-8?B?bmwvYjFQRjZrNk50NHpleFZObmRuV0lHRmlrOE1LeDJWbHpHSnI3aWowcGhO?=
 =?utf-8?B?bjk1WVRpZXZOUUF2KzE2OGVKM0FmNjlxaGNIUzc2UUxIN1REMjFqd2c5ZE1S?=
 =?utf-8?B?U0dndnZ0eDFiYTFqdllKa0x2TmNHTHhXdThEUlZkWVYzRnkyNFpPY2VsL2to?=
 =?utf-8?B?YkJVMWo0WWFTZGx3VllaZzVMWHYwZ2d2VldxaFpQcFVIYmVFY21Sazkya3dG?=
 =?utf-8?B?YllEWWhuY0kyWDdyYXY2WXhZU3djbGdUUURwb1JRa3FsYVpsV3plbzRKS1Bo?=
 =?utf-8?B?QlV5MTdrUlA3WDJMSDZ5azBBYlR1OFZOZC9oSk15ZmlQVGsrS0VZdm9xNDZ6?=
 =?utf-8?B?RklUQmhSUkg4UkZvYjN4WjVBbnVUWHlDeGl3UXdNL0Y5Sk0rWTZvV2t1UWZ2?=
 =?utf-8?B?VHZHZ0RjMThsbStqaVY4eEtnVDU1YTV2ZDdac2NUTzZPRFNNTGNDZmtUL0Zq?=
 =?utf-8?B?U3JteWlJaTFnVXV5dXpESW5QSnhDNzJ1Mm1reVRVb1NZbFhka2ZwNWhGZHpV?=
 =?utf-8?B?bm4yQU10d1lRYjhyRllST3cxRkwyL2llQjlTc3BCOTlSSVkrSlJYWG52RmVU?=
 =?utf-8?B?YUZrMDNTUndlMDIzSjRuZUdCbDVHdmpPZnpDbVNHUTdCSWtuQkVPelhseDdY?=
 =?utf-8?B?M2NCVGhUMlkyaGVwc0YwMGhmM0dUd0VFWmJWMHJPb2o4RnFsWWVtdmpYbkps?=
 =?utf-8?B?UlRkL2c1QnYyb0VKYS9CeTlwZ2FpUVpsYWxOWldJR25WTkJCd1cxamtGYnh3?=
 =?utf-8?B?cUpqR2I0SFNJbDNVbWljdUFFZ0oycmxMbmdzNWlVbUtOMEhMbVZOeHdQZDVC?=
 =?utf-8?B?T1VnRy9vUEhMbFVxL3Fpbzh6NXpsbFBJRndVRFNZRXdsWXhHOTRNSm1NcGVw?=
 =?utf-8?B?UHR3Y3ZiWCtscXAvbmhpTzJTOEgyUHVLL3Z0aFFpS2dHZ3VJbGF4TzA5NW05?=
 =?utf-8?B?OWJhbVRteVNRYVZ6eUlRbTNuSDR5Y0VOK3FqelZnZzZjYlBsdUJmbGlmNE1n?=
 =?utf-8?B?N3BiWGJ6RmtDMTBJb1VlMDdRUUxKTWdLVXBrRk42enF6aWE2TG1iTWRFR3lP?=
 =?utf-8?B?eld5cCtuZWdYV1pKK0ZIa0tQTUZidVpZbUVDcHEyREVoZ1Z5OTFUakoreHJB?=
 =?utf-8?B?TlRPVitnRzNzL3hzcTh0NGJ2S01VUXIwU09VWE02a254NTlvT29HSllTcnZY?=
 =?utf-8?Q?0A2Qo9q4iMfbcEs9otTlYJt5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1b1b46-361b-4063-177b-08dcc2b92971
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:46:10.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6rFcziDhC/p8WmT2jnoSw/Xpo780fJaGGq7F/hF+0n2iMmFT9KBWvSIq4GMCwri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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


On 2024-07-30 16:15, Philip Yang wrote:
> Add new SMI event to report the dropped event count when the event kfifo
> is full.
>
> When the kfifo has space for two events, generate a dropped event record
> to report how many events were dropped, together with the next event to
> add to kfifo.
>
> After reading event out from kfifo, if there were events dropped,
> generate a dropped event record and add to kfifo.

[JZ] I am wondering if it is better to use the below method.

can calculate dropped event count during adding event.
Generate/Send dropped event only in event read.
when there are dropped events, If there is space left for dropped 
event,then

send out dropped event with this event read. otherwise, send out
dropped event  with next event read.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 41 ++++++++++++++++++---
>   include/uapi/linux/kfd_ioctl.h              |  6 +++
>   2 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 9b8169761ec5..9b47657d5160 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -42,6 +42,7 @@ struct kfd_smi_client {
>   	struct rcu_head rcu;
>   	pid_t pid;
>   	bool suser;
> +	u32 drop_count;
>   };
>   
>   #define KFD_MAX_KFIFO_SIZE	8192
> @@ -103,12 +104,26 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>   	}
>   	to_copy = min(size, to_copy);
>   	ret = kfifo_out(&client->fifo, buf, to_copy);
> -	spin_unlock(&client->lock);
>   	if (ret <= 0) {
> +		spin_unlock(&client->lock);
>   		ret = -EAGAIN;
>   		goto ret_err;
>   	}
>   
> +	if (client->drop_count) {
> +		char msg[KFD_SMI_EVENT_MSG_SIZE];
> +		int len;
> +
> +		len = snprintf(msg, sizeof(msg), "%x ", KFD_SMI_EVENT_DROPPED_EVENT);
> +		len += snprintf(msg + len, sizeof(msg) - len,
> +				KFD_EVENT_FMT_DROPPED_EVENT(ktime_get_boottime_ns(),
> +				client->pid, client->drop_count));
> +		kfifo_in(&client->fifo, msg, len);
> +		client->drop_count = 0;
> +	}
> +
> +	spin_unlock(&client->lock);
> +
>   	ret = copy_to_user(user, buf, to_copy);
>   	if (ret) {
>   		ret = -EFAULT;
> @@ -173,22 +188,36 @@ static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
>   }
>   
>   static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
> -			       unsigned int smi_event, char *event_msg, int len)
> +			       unsigned int smi_event, char *event_msg, int event_len)
>   {
>   	struct kfd_smi_client *client;
> +	char msg[KFD_SMI_EVENT_MSG_SIZE];
> +	int len = 0;
>   
>   	rcu_read_lock();
>   
>   	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
>   		if (!kfd_smi_ev_enabled(pid, client, smi_event))
>   			continue;
> +
>   		spin_lock(&client->lock);
> -		if (kfifo_avail(&client->fifo) >= len) {
> -			kfifo_in(&client->fifo, event_msg, len);
> +		if (client->drop_count) {
> +			len = snprintf(msg, sizeof(msg), "%x ", KFD_SMI_EVENT_DROPPED_EVENT);
> +			len += snprintf(msg + len, sizeof(msg) - len,
> +					KFD_EVENT_FMT_DROPPED_EVENT(ktime_get_boottime_ns(), pid,
> +					client->drop_count));
> +		}
> +
> +		if (kfifo_avail(&client->fifo) >= event_len + len) {
> +			if (len)
> +				kfifo_in(&client->fifo, msg, len);
> +			kfifo_in(&client->fifo, event_msg, event_len);
>   			wake_up_all(&client->wait_queue);
> +			client->drop_count = 0;
>   		} else {
> -			pr_debug("smi_event(EventID: %u): no space left\n",
> -					smi_event);
> +			client->drop_count++;
> +			pr_debug("smi_event(EventID: %u): no space left drop_count %d\n",
> +				 smi_event, client->drop_count);
>   		}
>   		spin_unlock(&client->lock);
>   	}
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index e4ed8fec3294..915d1e7c67fe 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -530,6 +530,7 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
>   	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
>   	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +	KFD_SMI_EVENT_DROPPED_EVENT = 12,
>   
>   	/*
>   	 * max event number, as a flag bit to get events from all processes,
> @@ -610,6 +611,7 @@ struct kfd_ioctl_smi_events_args {
>    *    rw: 'W' for write page fault, 'R' for read page fault
>    *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
>    *    error_code: migrate failure error code, 0 if no error
> + *    drop_count: how many events dropped when fifo is full
>    */
>   #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
>   		"%x %s\n", (reset_seq_num), (reset_cause)
> @@ -645,6 +647,10 @@ struct kfd_ioctl_smi_events_args {
>   		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
>   		(node), (unmap_trigger)
>   
> +#define KFD_EVENT_FMT_DROPPED_EVENT(ns, pid, drop_count)\
> +		"%lld -%d %d\n", (ns), (pid), (drop_count)
> +
> +
>   /**************************************************************************************************
>    * CRIU IOCTLs (Checkpoint Restore In Userspace)
>    *
