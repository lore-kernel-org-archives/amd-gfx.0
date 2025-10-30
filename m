Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C74CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 21:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069CB10EA3D;
	Thu, 30 Oct 2025 21:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2sF99xWs";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646AE10EA3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 21:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDgb6H8YbSGnzi5eeMoO/e4ebfqhAKgNomIIdExhC0QYERUekr57KPAtWUYg8+PCFTeY+P3iCutHuG15EpVmjZl9i8rOLX3sX2rvYKc2F17ZF5Mienim5TPOE+sxcWBO/SDIVeDgXAvoqlrwa+o0HOHqubYEhkGnTgh3cWm4OuJb46XrdLmpVRQa3iSsVaPj0xBn2b5QrqNBpsV2aBhGmx+L6/dAvTaA+FL7e3U0ygF0ZfnBDfneFRuWOZxJ9hZb7bDH05idrMy4QMMDgVEj3cKfQeQ66hKR0GoB3/vFirdPlN2byB/OnEdYbZUB+ldBHD28SVselliwinJHWAnD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiiVgUPICGwGiXO+CjEVz0KqwjQSdWNymhzfYKYGXLE=;
 b=V8ki7mjw8nF5h+yzGvhJliLRJzxxRyG30KNurvPQ3yTUBiNv4gIqR2mSp/wLVjQbrcczZ9Eazgl/s+RmsKmzhHy2fJt6VaZNT0/KI1sXnTpkn52wYEh/1tI+jrHpkXrO+3xiElI/SWtz9McuZYwso3wM0X7+rEsvCCgQbr7qtKtAqZo58RrSWrg+Kp894PxPxOEM/3tXVSCxx8SZmDkf3w2+rIoDs0VkBXSbAbfP/tWOz/pYdnr5SoiV0OGOZqHdC5VrzaawRwPFsI2bXJYoflD5vahScq66bNk7jCaUMzQ+GLAvaA7J7jhXnPxnlLSmqYvgt9OugdrSMewhbW01OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiiVgUPICGwGiXO+CjEVz0KqwjQSdWNymhzfYKYGXLE=;
 b=2sF99xWsd8WczzWj6UChu11d/seMjnb59tGUgVKJ5OvSb5xOW8suImnCE3G53MNnTxT7xHYMfAmCMbZPijkCJWD5SuBH6YlIc5IbGX4V7sXfERja+MjpA58jeTrySIWOGizAQFdF6hgQcpaQOUL1wP68aoaEoGKjPgV31jGoXW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 21:28:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:28:16 +0000
Message-ID: <8666b57c-ccd2-4b52-abe4-9d26529b7a24@amd.com>
Date: Thu, 30 Oct 2025 17:28:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 18/18] amdkfd: introduce new ioctl
 AMDKFD_IOC_CREATE_PROCESS
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
 <20251022073043.13009-19-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251022073043.13009-19-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fbf4cf-6fc9-40d4-769b-08de17fb3d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2hqVDhGMkRUemVDbVY0YzNMUTcyUHVRVDl2WXV2QVVtWEd2MFZCVGRudmR2?=
 =?utf-8?B?RFNlQWZ0dWJ0T0twa3hZaUFudTZmakZnaG1NMGtMeThMYWk2UGIybDFtLzFX?=
 =?utf-8?B?SXVPWjYrZzNJNzJVUTdjajVyeEcwSUM4ZmxmSjJQaDhFb0ZoZXV4Y0p0cmNP?=
 =?utf-8?B?Y1RvR2xGN1pGK0kwUVFDVFJjd0Z1djM3bldRTFdRQnBNaFZLME1WK0xaQTRD?=
 =?utf-8?B?REhHS29VOVdranZUSENQeWxKS0ZqR3p0c01HVWMvengvOFRaSFBEYVd0T3ly?=
 =?utf-8?B?UytWeFZFb0UvUTFzZEtraEJiaVFsaElxOER1WnZqL0N4OVpxeE1nbnRYTm5D?=
 =?utf-8?B?ME12dHh2NHRkaXMrVnB6ZlZNTzdRMVdWcHl5YUpSZUw4VUR2aEpyQ1pMK3l2?=
 =?utf-8?B?cDQ5QnIxSTFFcGduM3V1NFVGcUp2WTdoM2ZUN0RSaWVjb2dSczJHSGc1YXNU?=
 =?utf-8?B?a0ltejB0WGRDNEhlWTd2RnVpdFlmeDhZdy9DK1pxQjFERjZsWDVxbkRBMVY5?=
 =?utf-8?B?U3pCZkJZUEk2YmNMaTNVaGFTK3pYY3h1QkgyVWovcjRFbURkWitGYjE5bW15?=
 =?utf-8?B?c0ZnZnNCNEszZUNsMG1ITFpreTVYVFdKTWFMVFNLMUZvMm9uQ0w4c0VxdHI1?=
 =?utf-8?B?UjRkSTJXaEs1WWxLU2IwQ21YdU5iL1JCbnZFT1NnOWRSVTlkZkdERGM5S0Ex?=
 =?utf-8?B?MnFRRWhXVW5CY0ZHdHNTM2F4K3gvdjBuQ25NUjRGZUtGcFRXb29LV3B1UzEx?=
 =?utf-8?B?Rmp2T1NUaWExc1dvaUptaURsbkNnN3lTdm0zMDhzaDNFR1Y3OER5am15M3dI?=
 =?utf-8?B?Qjd2clFMMmpRcUdETW43WTVYR0VQOWJNM0ZnL0VobzBhQ1M1VXo0UUE5U1Zt?=
 =?utf-8?B?NStoWm1nd3VRS2VteWlHQmI3Q0tvRk5XejhtN0VlWDRPQzJ1dnAzNmNiRm5u?=
 =?utf-8?B?bFNjNHFqeW1jQnBwVFRNYUJ6bk5TR0pTQ2tFb0lrK2piQ2NIT0tiU2VwQVhY?=
 =?utf-8?B?N3NTanZUcDdlNTUzMW9JR3Nub0hlSmJCQW9nMnJwWWs4NmJEbXdzd01DeThQ?=
 =?utf-8?B?S1N5cnpWbENEeHNoZXFoczhQODN3Yys2NkoybU1Ea0ZUVWNPWURoWDlmTlVh?=
 =?utf-8?B?aVlOeEFneGFMMGhzNmJkK1lTS3pldFoySlZnanp3ZUZ1WWlRRE9LbURSWWNN?=
 =?utf-8?B?ZzRiQXJtTW5PWWo0QU4reHFwTnlmSXlDTkc3RjNuQVNFWFYxamFPd2F3aElV?=
 =?utf-8?B?UER1OUxkdUdGcVN0RU9tdFdsL1ZlQ2RsaS9mMFZUeEhLb3Q1dmJMWGFaWHFJ?=
 =?utf-8?B?SThqZEhraFM1UUNQQXdvSlVDRnpUUXFoZld0eEp3WjR2WDZwcXNqMS9BaCtt?=
 =?utf-8?B?UldkSXcrdm1vV09JVzZuWWRySmpxRi9jZ0R4UU9qMTlEVXluM2c3ZmtFTEFY?=
 =?utf-8?B?eHZJaTlSbHBTamZoQ2JGWkZxYi92ejQ5V2F5d1lRbHErbGlsekdickExcG5Y?=
 =?utf-8?B?UTZ5Rlltd3VZcTVxOWMvMmdhdzRud29SdVZsOEc0VHo3MEhQc2JFVUxKV3Fw?=
 =?utf-8?B?S3dPK2pDdnFORGp4N2czWHoxSmJpNGJQRUdkL3BBM0wwUlNlNjBraFBOTEJW?=
 =?utf-8?B?bGxob3VRTFpJcW1Yd2ZSOFlVaG50dlJWTjVFMjFiTlY3TnBvU3B3SkhhbW5k?=
 =?utf-8?B?OS9DSnhmclRWb2g3THVFQVVQQzd0d1V3b0pRQjU5TWFyQzNLRXRqeGFaQmFS?=
 =?utf-8?B?ZVEwQ3MwZkFZOHJPbDVKbXpqOVl4cVhmMHJFZ3dvWU1oRys3U2xzRCtuRll6?=
 =?utf-8?B?WEg2eVBoZlFOQVNvcmcwWEV3aHM2dFFQWi8ydUtuMlNmZUUrOVZrdlUrZXBZ?=
 =?utf-8?B?dzBqZGY0YmMrMUlhM1JleVU3Z2wwVUNKem96RmpwTUtoQnVJTW1QUTlwSGMy?=
 =?utf-8?Q?yT1f9obSiGTyQ+th98talCu3dzRskR3C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdvcytYNHo5TmZZRi9NbXFTa2gzZFFaOElHVFRIZDZEdXpES0dOYmY2MC9V?=
 =?utf-8?B?dWl6bzRxejIrYmpkYVV3R1hPUS9jc2NmYTkrRlNTejlKZHJpVEZ5MUtQc1do?=
 =?utf-8?B?cWxLZEJnTmc3dFgxcU51RWZTUjNya2xaR3VXT2NmMzZBVW5qUUpqdHJ5eGhS?=
 =?utf-8?B?eFFJb3hBOTRzSGlHOVVaU3pFM3M1SDAxYnVibWd5ak0xNlE4cUlIM1J4UFpv?=
 =?utf-8?B?M3F1cHhKcDRoRnlaSk1XL2FqeGF6cjFzekVML0p4bkNvWEdLWGs3WStUV1Fy?=
 =?utf-8?B?WHpueEZCSGpyWG5wMmpBNDI2RTRlRloxMFNFYkNOYzNXcENOdHI2SUtFZ0la?=
 =?utf-8?B?NzYvVjR4MG5mQmh6MVFKV2NTWjhLN0RvenBxMUlIbG92aXQ3bDJVTzRNcGRo?=
 =?utf-8?B?M2xuMXZGcUpLVE1QRWJ3ajRMRC9PQy9pNm1YZFRSMEJTOHhrN2wwMm80RVhL?=
 =?utf-8?B?SVhEVWE4aVA3b1h1c3l3emh1Q0ZVNUxqSkMzaDZ0elpJOTFlSUxOSWtEM0xG?=
 =?utf-8?B?TTV4R1kxOFBHOG5LbVE2aTdHcy9hK1FmZG9ueWplaUNIWXdMajk2KytxWFJ2?=
 =?utf-8?B?cXl6dlNWUjVHLzlWdHZoWjdtaXV1aXBKSzVJTGxpWG9Kek9qSzBSemJvZSth?=
 =?utf-8?B?QmRXL3BHOCs1YWVhMWZaMnljN09VbzhpNzNBSVdsMHV0ZGIxUk1rR1ljTWo4?=
 =?utf-8?B?WUd3N1drdWUwc2pMZXQ4TTgrVVY2aitqS3JRRjFka1hLMnBnV2xVN09ndDJh?=
 =?utf-8?B?YUw0Q0twbjMyeFlTandaUUN2aTc5U0d3bWhnSVREVGtvSXF0L0NlK1kyUndI?=
 =?utf-8?B?am5WVEdObDloMzZtUUs4dElFa0FlWGpiTnY1V25xekhVVDFYSjFTQVFuckk5?=
 =?utf-8?B?ekJsOG9TejlpS1pNQ1VrNGJYbmdiQVYrMTdqbjErV0RkUnhSa0UzbjVlWDFC?=
 =?utf-8?B?WWF0MnFGSDZqYTkyWThTUXp2YXZvbGxjSk55NlQvR3g3eUNaaVZaVG1yM2xX?=
 =?utf-8?B?NHpZVnM3eWZ1bEIzYnR0OVNTSmttcnlIU2pwQnkwNmpCT0lUNi9Fdm1RWnNp?=
 =?utf-8?B?bEtnUzYzdkRLT0dXcVJlcm5rUnovQ1dUd3V5d29NTHpFdnA3bFhUR1dKekNh?=
 =?utf-8?B?SEVwZ0p1aXZ1ekFQaEtrSUt1KzFpTmJaa2E2R1BpTTRNVWZHMnh4dVN6TFdl?=
 =?utf-8?B?SEhiRXhLM05PSlhienRQdWl6YU8xaGh4VEZCRXdTN0R6RG5iclMvbGtFTExy?=
 =?utf-8?B?UTdtbVRwTngrVm44MWxBR1NLTnpNYjFyalcxdk1MM3dvZXVJcjFMb21nb0dV?=
 =?utf-8?B?UHdvVUdFN1J3blZrZ25VSE5MMXNyYXJKUVhwajhyMW1EWHp5NFk4ZlJsSnBJ?=
 =?utf-8?B?YTlCYnFEQjZ5Z29mUStTZy95L3pkWlBtMUlOZnI0VlA1NEM5SHVxeWNHMXdQ?=
 =?utf-8?B?MkJ3LzlkK1dMS21kTzdWcUpaRW0yby9MN2FJM29DTGFYbWlCeG14YWQrVlJY?=
 =?utf-8?B?NmZyZ3VwWkhIME9hc1J3VWRrR2dSYnFYanJuVlhiTEMya2E2WCsvWXpxdHFu?=
 =?utf-8?B?YTdvelZGeVlzMkI5U0s5U0xOeTE5VnN2MXBzQ0hJaDBNZTNOWE1BbmRVOTl2?=
 =?utf-8?B?U3FZQjNPVjQ5YlhVTjhHMjhjYVRhdGJKbTZvSEZNWDlXM0NaZ3R5RndyRldI?=
 =?utf-8?B?SW01SHFNby9uUzU2M0hBazhadFU2TUNQZ1BrMEdVVlhxN20vWHMyUWUyREh4?=
 =?utf-8?B?cmlqMUFYbTNrQjlDbDZBRS9HQzRmRTIvM2Q1djZ5dGpjUHpoMTFKRkZmM1JK?=
 =?utf-8?B?Y3dvbWVwdVd2dVE5ZHhoZ2Z0c3EvN0dTNVdRc3FnYkRvelpOQi9ES3dTRVhY?=
 =?utf-8?B?MTdRQkFzc0FFemEzdDZHN3JkazJETmkwN25TTTA4Wi93N3JraHlpUFc3Nmd0?=
 =?utf-8?B?V3p6TGM2MjYxNkxTZW1UeGR3OGRUZERIUE5lOVVHalFSQTdGdy9FTVk5ZFNY?=
 =?utf-8?B?dUJtQ0ZVOWNjcXEvYXFRMmQyeW02MUw4TC9wVWJRQlgrR1pyek1peUErT2FS?=
 =?utf-8?B?Q1pjZ0syWFJMMXdXTGZtWlE2MDY1eGo1LytUNld3Q09hWEc2OTFoTjBwMVda?=
 =?utf-8?Q?+bdTg7wuggFdo9rJjm/5s+epQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fbf4cf-6fc9-40d4-769b-08de17fb3d01
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:28:16.2489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIYHjGdGdOBKjr3nAg47MRsKglXRssynHJkzopX7jnzElTTIF+u812mgPVHDWeTZ4snhzm0vlmLHuyhwFIqHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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


On 2025-10-22 03:30, Zhu Lingshan wrote:
> This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
> that creates a new secondary kfd_progress on the FD.
>
> To keep backward compatibility, userspace programs need to invoke
> this ioctl explicitly on a FD to create a secondary
> kfd_process which replacing its primary kfd_process.
>
> This commit bumps ioctl minor version.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 46 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
>   include/uapi/linux/kfd_ioctl.h           |  8 +++--
>   4 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ad5ca3fd847c..04862fa820f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3146,6 +3146,49 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	return r;
>   }
>   
> +/* userspace programs need to invoke this ioctl explicitly on a FD to
> + * create a secondary kfd_process which replacing its primary kfd_process
> + */
> +static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	struct kfd_process *process;
> +	int ret;
> +
> +	if (!filep->private_data || !p)
> +		return -EINVAL;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	if (p != filep->private_data) {
> +		mutex_unlock(&kfd_processes_mutex);
> +		return -EINVAL;
> +	}
> +
> +	/* Each FD owns only one kfd_process */
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {

This check can be done before taking the lock because we never change 
the context_id of a process after creating it.


> +		mutex_unlock(&kfd_processes_mutex);
> +		return -EINVAL;
> +	}
> +
> +	process = create_process(current, false);
> +	if (IS_ERR(process)) {
> +		mutex_unlock(&kfd_processes_mutex);
> +		return PTR_ERR(process);
> +	}
> +
> +	filep->private_data = process;
> +	ret = kfd_create_process_sysfs(process);

The kfd_create_process_sysfs call can be outside the lock. With these to 
changes, the patch is good to go.

Still no Reviewed-by for the uAPI change because we don't have the user 
mode changes in a publicly visible place.

Regards,
   Felix


> +	if (ret)
> +		pr_warn("Failed to create sysfs entry for the kfd_process");
> +	mutex_unlock(&kfd_processes_mutex);
> +
> +	/* Each open() increases kref of the primary kfd_process,
> +	 * so we need to reduce it here when we create a new secondary process replacing it
> +	 */
> +	kfd_unref_process(p);
> +
> +	return 0;
> +}
> +
>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>   	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>   			    .cmd_drv = 0, .name = #ioctl}
> @@ -3264,6 +3307,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
>   			kfd_ioctl_set_debug_trap, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
> +			kfd_ioctl_create_process, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 44ecdaf02657..02def4f830b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1054,6 +1054,7 @@ struct amdkfd_ioctl_desc {
>   };
>   bool kfd_dev_is_large_bar(struct kfd_node *dev);
>   
> +struct kfd_process *create_process(const struct task_struct *thread, bool primary);
>   int kfd_process_create_wq(void);
>   void kfd_process_destroy_wq(void);
>   void kfd_cleanup_processes(void);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4350552e9648..236015993902 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -68,7 +68,6 @@ static struct workqueue_struct *kfd_restore_wq;
>   static struct kfd_process *find_process(const struct task_struct *thread,
>   					bool ref);
>   static void kfd_process_ref_release(struct kref *ref);
> -static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
>   
>   static void evict_process_worker(struct work_struct *work);
>   static void restore_process_worker(struct work_struct *work);
> @@ -1578,7 +1577,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>    * On return the kfd_process is fully operational and will be freed when the
>    * mm is released
>    */
> -static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
> +struct kfd_process *create_process(const struct task_struct *thread, bool primary)
>   {
>   	struct kfd_process *process;
>   	struct mmu_notifier *mn;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 5d1727a6d040..84aa24c02715 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -44,9 +44,10 @@
>    * - 1.16 - Add contiguous VRAM allocation flag
>    * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>    * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
> + * - 1.19 - Add a new ioctl to craete secondary kfd processes
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 18
> +#define KFD_IOCTL_MINOR_VERSION 19
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
>   #define AMDKFD_IOC_DBG_TRAP			\
>   		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>   
> +#define AMDKFD_IOC_CREATE_PROCESS		\
> +		AMDKFD_IO(0x27)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x27
> +#define AMDKFD_COMMAND_END		0x28
>   
>   #endif
