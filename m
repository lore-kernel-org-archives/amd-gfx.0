Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33833CCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 09:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C2710E361;
	Mon, 10 Nov 2025 09:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqtYwjg/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC8110E361
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 09:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3UkdysScESsL4Yxe+LKlSn6OH5/v1qokGn6yHwYzjE+QfdzBezR+Puvge46luvqSFcybDHFO7ur82YEQn+hcHTWp36ohcAFspELSifAUUfxFoZiMiAd36MJHuRFu+eztAHUvycoEHFMTiLxH/LRYYa9GUn/GmC6XekSZR4FOn/mU4SZ3XZth4Wv5VEqqBhslyJ2iC9f9uxHZfuQqe6ZkP5PZi5x2eyVZ1VkwX05n3ciD2YNGQJtVLTBmItzfm6oj3AfXGbyyzh0LV/5rVdYAb1wgONcnuSG+0VqoSeAHCaHVDd7L4lnFsmtcgNijaC5dY4nMVNLIhlFwkLGwzm3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fryPz93cShX0oq7AizrFpicmry0DuG2okoL3+hA/D5Q=;
 b=XLqmdlNjE/8AoYuVg6e4oapbUayd0IKrVIz5BA064YRLIyIvhuWxUalxQ7YxhMH3QhteTq9VG9UIqB5rxV7XaTgRCIzswr7yyKNyzLdEF3YX0NbEIyie+xUgscmiUTBcnrwAFInOdRSPS3LsFEGAKnhBCSRyonK7It8ebXkLE3SWe+Sj3t/lDQ4LlOlxaE39phIiyCvdWL5ukfl9F0U+kfShJ2MSnrWlV9aSTjRvWmZUsHj1mp6hgR6gKv+kut4E7uZFwd1PDWbXF3YbLm2dny17BaCoORV7LQglCDs8zvprQyifOGIEh8BnmxSafWIeLZSiUAhIVotCilO1FcKZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fryPz93cShX0oq7AizrFpicmry0DuG2okoL3+hA/D5Q=;
 b=wqtYwjg/bJ+c4P6GMleYeCIcdrC5jCdTFvai6h8lCbPQyPtbeTwHAzUIQihUI6Xjw/0bI60GtWLUfizi25EZG0P0KqJ0R8X/2xfQZsWAv9CdZRGVpvoP5xSUEvIJhh8IvnnELuGPyQ3c50y0PULdtA5dJnfalEWZQHHpNsyMCv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:16:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:16:01 +0000
Message-ID: <013ea777-fb59-45d0-a83d-68919f68785d@amd.com>
Date: Mon, 10 Nov 2025 10:15:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
To: Saleemkhan Jamadar <saleemkhan083@gmail.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20251108190317.13240-1-saleemkhan083@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251108190317.13240-1-saleemkhan083@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebe15fe-9355-4ee1-9ed9-08de2039c471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzJkUEpuaGdmLzNkZ2VFUFJYVHJFVzNoT3pjeFpleENKaURwQUpSVy9scnA5?=
 =?utf-8?B?STVjZGk4VHFvZnNNL2NvSmJrRmc4d041MklrRVQ1RmdjVVorUUpBMmVjTXhx?=
 =?utf-8?B?OHUyMmhuN0VFUUQzNFBPaFF2YjNRY01VOGo2NS9xOWh5TVdSa3RZN2ozZDRB?=
 =?utf-8?B?Y0R4VjZVbUFEakxLQ2laYXZtK3I2ejNOSVd5c2pHbkNFNjVhaitiOTc4QlM4?=
 =?utf-8?B?M3hkSjBXMnY1OXZSSlVLWFZDR0JhQS95dk5DaDNML0NHSTFJZVJrTjA0a1ZW?=
 =?utf-8?B?ZGRMQXVtYy9pVzR3MWlzdjczOUtqR1JDUjE3c1ZaRU5CbEJ6M2lhKzNjdzRu?=
 =?utf-8?B?OUp2VlA5SUd5cnlRRmlLellXejdwTEJwOWlPVnZJU2ZKTWNPWXdqOU8wRVBI?=
 =?utf-8?B?NEFvS05JWVBvaFRBa2tiN1JIbWozNUM4dkhNRjVla3NmM2RiTG1sdnpOYVNS?=
 =?utf-8?B?SXRrdkdGUjJGWHpMcVBCaDRQR2E1WTNlWVRFamRPOXBSbzFTUkVwTGVZMUM1?=
 =?utf-8?B?RlpzRUFyaWxlcWZGaUhkYlNRTUd4aTZsekFzQVFkdDhzYy9SSnluTjFmdkVM?=
 =?utf-8?B?WnUzSTVvWmsyZTczaXNpUTJ5N1pFUGdaSnAwcWdFZzlPYTJ1NGl5ZytDcUM5?=
 =?utf-8?B?c044SmY4cm5qVEkzV2JOTnR0bFpCdDVzUWVZNVJDc2hjSzg1QU9sZm5qdTRD?=
 =?utf-8?B?dGRBWFNqOEtNMUZNc0ZCUEgwVTBEQ1lPWXlRMndva2dLSUNseG9xWmNiV3N4?=
 =?utf-8?B?cUM0a2JPRnFyRDhKMjYwWTZxb1FLK1N6bGVab1krMGx4L053TUk1WndnYk4w?=
 =?utf-8?B?cDYyWDZZV2Z0VTJzRHBJMG9LeXdTSENPTDFDWExMb3FFdW1wRWJjRUhMOCt1?=
 =?utf-8?B?enBoa1lwMHA1TTNlODg3TWVIaUplMHRFMHhnblZxTksyS1RnOHFrWDBXUGxy?=
 =?utf-8?B?QzBSRncrQmRDd0JzWGRIUHlPTDltdVBoUlpMN0JIM3JXTWRaOVJDa3NzMFUv?=
 =?utf-8?B?U3dKbFNNM0VxeHovenV0di9WLzlwb3Ntc1Jhd2xVOElicGhlQTl1QWtQUUxh?=
 =?utf-8?B?Vis0WWlQRGFBaVlNYWs0Z3JhN2ZNWktZQ1o1a2JiaXkzSXpTYXFHSkVVZFl6?=
 =?utf-8?B?R0NPcGltK1BvRUxnbUMvK2tXWE1KTnNCb2c4NkVJQjd5bi9kWW5iMUhYZ21N?=
 =?utf-8?B?bXBvOE1QczBWc3VWZGhXdFgyM0VrYVU3RVFlb3ZiRC9qREpVbjB6Y2lYMnpB?=
 =?utf-8?B?MU8xdDI3NmtxdFkyRWZKK3gxMFhGVmp4Y1BWakYrYS9iQ1BBeEY2akFBQXBq?=
 =?utf-8?B?NE9XRE1seGVyaVk2UjcxSlFYY3d3amUrL1V1aTI2MFRNNmU2dHBHSUVoQzBW?=
 =?utf-8?B?R0ttTHJ1NDhGVDdnSEh2Qldjc1YzcURaeU4zSXllcWdFRXlHTkUrQk5jNDg3?=
 =?utf-8?B?bGZ2U3dzb1dIUXBIY0RPV0Frc25nWldDM211RVRQam5zNjdCZjdFd0x0UWt5?=
 =?utf-8?B?andyeWhpYmVBRm1RbXg0MEsrOENKQ0FLWVdWZmFjdGlFcU1yTzRrRlpsTDNX?=
 =?utf-8?B?blo5UzFRZFg0TG1ZcG5pMC92S0RjSS9ySXcxUFNpNmdRZ2ZKdjFiK2h4VVJO?=
 =?utf-8?B?ejY4MXBrQ1U4em5CaE5WbmN5WjVDb2JEaWxtVzByVVE3VVdBd2FJSDNLV3Zv?=
 =?utf-8?B?Z2xKVzhmd2YrWG5aVWdHT0trQWI2dGhiS0tWUFpFaFZJR3UrUTdFcm1vdmJq?=
 =?utf-8?B?NnpxaDZoZHBHZ1RyVUozNG1PTUZCcEpnYjl0OXFyWHE0eDJsUHpqc1Iwa216?=
 =?utf-8?B?bE5yRE4xMFk0RW1uQVhmQ2VWNStDUlBQc1FBWUpxbHVYK3BwYmsrTXBtVlhs?=
 =?utf-8?B?aHh5V1VhRmZEdmRWS1hCVTRBS0RJaWNRZFlNb2xjeVZYNHZLZHZOMnBERFA4?=
 =?utf-8?Q?FYIr8JrBNMaByyMsN3N1omUKhoDOTA4M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVJdjErRGFHY08rWHRYZFhRTnFzeTE3VEhVTENpQ3FuZ0pNY0FOWjJxMFIv?=
 =?utf-8?B?OVZOWDFWNVV1T3FzT0xkNGdUck9SUlEzeGw4V0tPemFKTnR6bFhjaHlyMGoz?=
 =?utf-8?B?V0lYS2V1WGRNOUdUTGlsTUFaNUUyeU9aVlpDbU9GWGV5Y0NJNURnMjFtQ0Q0?=
 =?utf-8?B?cGxpYU9sTDZ0YU9OdVJJY3BldlJzRFhWcmVyT3VwNXdaMFRac0lwOFlMVlBz?=
 =?utf-8?B?QXduLzFKVHJIRkE0U0xENk5qSnp3Y3VGT001OHlXdXpadEtIK2lRVFFnbWZ3?=
 =?utf-8?B?ekFMb0FOZ3REMzBjUXJhSnBwUDhsSlFDR3lSazlDNTNmd0VKZnZqUm9MQk5D?=
 =?utf-8?B?d2dPcWxBSFV0N1MxSFRJSzZTUXhNTFBzWGlyL1ozOVBEZVpzUjhBR0ZkRTdr?=
 =?utf-8?B?dnh2Y2VwWDJuaUY4NGZtQ014SW80SEtvWTlpMk5jWkl0OUFwVkJzZTcrNHJv?=
 =?utf-8?B?UUtBOWtqSkhIMUlsMVpZOG1DZlVwVDhMdExkZGExSzZEeGNQeGtlcmJTbURi?=
 =?utf-8?B?VFNMcDNvVk1BZi81eTc4RUdmNFM3TFlIbEE1QkJNelZxZWk4M2pIQVRrRVE5?=
 =?utf-8?B?MVEzaWtXL1BHa282U0hGTUdjRFZkU1M3QU93cmRLYlVyQnUwTjUvNkp4S0Jj?=
 =?utf-8?B?L1NBUDIyYmVjOFM2Q2NsU2thREVmSDcrdHB0L1JEL0syOWd4LytuN0hFV01s?=
 =?utf-8?B?QXFQc05LUkZ4akgxcjBpWnh3Lys0eFpzUjk0YVFSYlFEQ2M0UWJybUdhaEVT?=
 =?utf-8?B?NFcxa3FBNjljd2l4eitlYmNWTHlzazh0M1J3RzRRMDZjaEwvTlBWNXREYzRs?=
 =?utf-8?B?cmFUMUhhOC8waFRyWVFkSGpCNEY4YWtRcExsdDFhNDNaamVTYWtHMys2ZzVE?=
 =?utf-8?B?VlZ4U2VMQU8waTJiWWQxV2JlMnNOdyt6ZUpSKzJoaG15YjFpRDZ5Y3cvYU85?=
 =?utf-8?B?YWs1Ynl5UmRldm9vZ1gxaEhydHJjamZBZzZVSUVPN2RpZW1lWU9Qd2JzOE9O?=
 =?utf-8?B?NUdWVzFwam1RRGIzS1l5ZkNEWTEyZzltc05zR2hraXJjcjJaTDloSzVTVWtl?=
 =?utf-8?B?bjZ6YjdhNVdTRGpGWXArclpHY0swQy8rcWdka1o4azBUR0NaUkNrNml3OW9D?=
 =?utf-8?B?TjVRdngyejZZS2FuazZjcVhwcWtqTms5aFdiaUplUTEwOG5ZQmRYakpPdGtk?=
 =?utf-8?B?TE8wYk0vSnZWVm9aYzNxT08yN1pnN3FkTHUwQ1luYVNCM0dLYVZ4TmtvNVJI?=
 =?utf-8?B?U0tKM0oycDF5aHo5WVlYQjNiaHdJS0dCMEhYUGFGNjRyWElwYngwaWtOUWRJ?=
 =?utf-8?B?eWJSOE8zN3J6c2c2MXdmZkxFUzBJREs1emZ5UmlrVFZnck9vRTdtSm0zK0FW?=
 =?utf-8?B?dUtLSHNvQnkrZlVGTkJ4ZHQ3T1I0aG1iS1ErdEFKOCtuZ2IveWZaeTJ2N1dK?=
 =?utf-8?B?bFBraDhXV2NnVnVMcS9pMjB2bStaQWdicTZxWUFvWHg5Mkh0SXNBc1BxTnFV?=
 =?utf-8?B?YXRQNDAxWHNRZnB0bi9DSHFra09XNGE5QVpKSmo3eUxNZVRCVmVpVDdVWGt4?=
 =?utf-8?B?Ly9UTlB0WGJ2bVhGMFgxQ2grTGU1SjAvSHN3czh4OU1KYnRGRE44QlJjcGVu?=
 =?utf-8?B?MGMwWTFvYlhYS2Z2N2pMOWg2QjNvbXpDS3JxQ1c0Nlp0empOczZVMUxCMFlQ?=
 =?utf-8?B?R0tkOFlNY3dJMkozOG81cEVqdE5YYXcyV1VkWDcvTzZsTUgvRmRodGRIbVc3?=
 =?utf-8?B?YnpVUS94WEhmYi9YSnFFZkl5Q2pjUVg5UVIwKzNjVVZzamt3VmEyQU5abkFZ?=
 =?utf-8?B?NGRERDZxckNOcVlPWFhxYWR4L1EvVW55NVRRd1AwVmRQQisxc2x5alhmTWpV?=
 =?utf-8?B?Z1RQTlpLbmovZlpyNnJNNzJkTHMxbkdielN1SmdqbC81WVdDWWRCN0o0a2k0?=
 =?utf-8?B?ODZNZWJoTmJFMU9GbTR5dXdNRCsyUlZKcUtDc1ZXVFlDOW81Ym5aTmp0a0lh?=
 =?utf-8?B?S3E4UDRSdnY3T3V2VXlKSVg4TWp0VzdwM2lPN0p2bHpwamJVY1Q5UXNmb2V0?=
 =?utf-8?B?SEdWQmFNQnhYbFF4NmtITG1ZUzE5N2VkbmVMOXhRWjd3VDBvYzQ4cDB0TjF4?=
 =?utf-8?Q?6PGDk51Vs8ja8LuHWvUyDJpLl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebe15fe-9355-4ee1-9ed9-08de2039c471
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:16:01.5857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAocmOyuc/uv6Hwi7nIebSHW6YW6wWH2Oud3SKRzf1cX9BmudwcwOT9+LYUoMqUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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



On 11/8/25 20:02, Saleemkhan Jamadar wrote:
> This should not be used indiviually, use amdgpu_bo_gpu_offset
> with bo reserved.
> 
> v2 - pin bo so that offset returned won't change after unresv/unlock (Christian)

Each pin must have a matching unpin or otherwise you run into warnings on destruction.

Regards,
Christian.

> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 21 ++++++++++++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 3040437d99c2..bc7858567321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
>  {
>  	int db_bo_offset;
>  
> -	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
> +	db_bo_offset = amdgpu_bo_gpu_offset(db_bo);
>  
>  	/* doorbell index is 32 bit but doorbell's size can be 32 bit
>  	 * or 64 bit, so *db_size(in byte)/4 for alignment.
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b1ee9473d628..f0ad3edbdef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -93,8 +93,27 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>  		return ret;
>  	}
>  
> -	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
> +	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
> +	if (ret) {
> +		DRM_ERROR("Failed to reserve wptr bo\n");
> +		return ret;
> +	}
> +
> +	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
> +		goto unresv_bo;
> +	}
> +
> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> +	amdgpu_bo_unreserve(wptr_obj->obj);
> +
>  	return 0;
> +
> +unresv_bo:
> +	amdgpu_bo_unreserve(wptr_obj->obj);
> +	return ret;
> +
>  }
>  
>  static int convert_to_mes_priority(int priority)

