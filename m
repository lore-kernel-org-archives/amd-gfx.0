Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53FBCF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5024610E407;
	Mon, 30 Sep 2024 12:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmO/ZT3N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083B610E407
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuA0Uppf8MLXBhuVT6iv9iMfp0HnvlyWuAgVZI67sDZmHZnXqeVX2tYU82ztijl2YcdLe+HQpngUH1+jwSKEKc2fxl0a7UgUIzFGDULJ1UZEP8ajTEPJRK0pm6Nidvn3mUhEqYYJPZKU8FgbuwKQhIAUdLnAn6vx7wNNyteXk889iT5wEPUP3oisR4dav5ViHAR/L/6jR26e0qGxDU5J4lyj1zHHy5k3y9gxHfBeDz8CySWJES7/wQCpl4InLWvX1v/GFrV4TXoA3xyFW2YCdCKlMgUWHYwZliDL4w0PMcqHBjzgEkqA6hNbhAfcQ2s74yqFNpI39ZoIq96FBDIiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6PX9VLweGTd3B917kerIS6KjviRUzF7Vwo5oGPtyMw=;
 b=aXt4awDETMoxlyJWcAZZBVfo03POKS9pFRzwKOVVAYgG1zXzQsUlKVEphzeP7E5uXxoGOIZq5XnEOfzFC/kWUNx9h9utxeVQbdOmLCvniA7Dp3L2hznFXBUyzJHLpDAjMm+CFSbJ4C7CcwhQ9xXfeCXZJAQjBCoMm2OVojZyb66KJci5mYMUaykCDi6N7OrH+3DaBPWNpD9JCzwVqxkD5EKlga6L0ddaYg6XLDMQXiiLyofqGlsLg2TEH/MGn3SPTcjIrkpLqfv+ESoHD70mbDH5HfPNCoBPzqhdtknBknNIM6dXRNpOZoycylQRrZk8PyjebjAWjzvE53shICHRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6PX9VLweGTd3B917kerIS6KjviRUzF7Vwo5oGPtyMw=;
 b=QmO/ZT3NIRLyR8x3QeWKai9kNODjWOIcesHkHgtqUwj/EiwmykuY3MaskxLXuZDvPorqHQXMh0OwvsNf0kErI4L/ZGMnpXeOEBQRW6D3iho5lpF/w8TzSuUNIda5+oKCvLt06Dl4iks/B/FyJdyKxz4nvI3EIngUWU2CaZcqIPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:09:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 12:09:34 +0000
Message-ID: <0b18ca6d-caa9-4386-b9c2-01052b4167a7@amd.com>
Date: Mon, 30 Sep 2024 14:09:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/09] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 28409306-ee63-454a-ae3f-08dce148bf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djNHWFE3cXROd3lwcCt3cTJ1ekFJK3BzZmhsOTEvZ3ExN1o2YlN0dVJUa1A4?=
 =?utf-8?B?dUN3Y1hRdkpUQjhWZ1U1TWJFTHprS2NNeGZCTWYwQklzUGN2ck53VTJ1ZHlt?=
 =?utf-8?B?OVlBdHNaQmZpWDFrQ24wUmppRDVUK2NWTGQ4akw0aVRLTzdldm8rb0w2L2Vj?=
 =?utf-8?B?RlZ4QklOZVVDTHRaY1RhMTc5VU9CSlk5eEZHYlFJcDlFV1ovdDhxUTZxRWZh?=
 =?utf-8?B?NjJiYTBMTUEzQzBtRjdVYVdqMVBYTHVTV1NsSWkzU1BJVXR4YUMyc0RlaUk0?=
 =?utf-8?B?MHhYVlFMREFZL2RpK3RBZFF0Y01WL0dqREUwVmdKZDVWMGJLY3RHbkhSeTFi?=
 =?utf-8?B?YndUWHF5OTNoUm5obTdJN0xUZG9Mbm1ZNENUbTRNL3hiRS9Ha0VJdjdUQUVq?=
 =?utf-8?B?M2piUXE4Tmk0ZUpMTm9wekV3YTlTRlAydU14L3BRbmd2RmZMbnU1Z2hWREcw?=
 =?utf-8?B?cUxHMVh6YzN2aUlXbHZkczZnVVcxZTJaaXkwdEs2SVRTeHI0WFpvaTdjbW1V?=
 =?utf-8?B?VmpoR1UrZmRzSm9Tdk9lSVFxQmk0TDdjcFBaaGRRRnVkV3N3bUx3TXVGSnZQ?=
 =?utf-8?B?SjlMV3hVeTFzNFdmUmRyNkhEaFVwaW1BdDJqbXFHMml0V2YvWEsvdTZqb24v?=
 =?utf-8?B?SUU4NU1hN2p6ck50SnlkcVdMQ2o1TlhoTHF1K0ZzUmJtSmdwOHZPQnNiY01y?=
 =?utf-8?B?blFQWGdLVXZrOUNyUnYrNEdCUzJ5LzM1WWw4SUEzVmQ2OTdKU3RUSm1CanVr?=
 =?utf-8?B?QmRYdndMSFZZY21KTVorUFI5STdDaHVibWgzdzdaWldINkpCZXFQRWg4V0lE?=
 =?utf-8?B?Qk5UeGdzVHhEUnIwN2tYcVhpTjYvdXBHeUJ3YTE2bHE4dHBSR3gxem9OdGdR?=
 =?utf-8?B?V1k5eHdYWUFzaHZTU2xJLzl2T3UxaSt2MC9SdUxoSHFMNEkvTXF2TVhGcTdX?=
 =?utf-8?B?UWJ6dFQwT2kxK3ZLWGhzOTV1UUI5WXpYNnc4eXZPOXF3YUtRaTAxejJGR29i?=
 =?utf-8?B?SGh3cGRGUUlFSzM3SWtxeExvSVhxZEo0QmxlWEp6K2Q1L3pzb0R0RERRV25B?=
 =?utf-8?B?N0huNllKMmxJV1JqdGRoU0R0LzkzNEVQZEZBcWFLM1NsbzFTUHdwYjNZdEZC?=
 =?utf-8?B?S0d4NFlhM0wvQU5GNTNtRjdlcU5BaVBHWHdEVjc1anZJL0FLQ2s5Y25uckdE?=
 =?utf-8?B?RUdMS3VXeGVlbDliSEtnSWVTTmt5NkxwemJmY1VweUlNaHdOaU1OYlNXV0t1?=
 =?utf-8?B?K2x6c3F1cSthcWUrZU5FSzlpU250RURNNTByaGowdlZyd1dRbUVkdHd1OEY0?=
 =?utf-8?B?QUd6eUVLNEJLTEtzRTNGbWF3bmVGT21FM1dXRGt2SmxIS1R6SG1uTVNmZ0Jz?=
 =?utf-8?B?cC9Gd3JvOG5NaVlRTTNVWksyb0poVlhTQ3QvbkhQc1A0THk3QTBzQzcyWXNo?=
 =?utf-8?B?NHdSV1hDS0c2RU81SE1iSnMrVTBlWFEzcDduT0pwTFhaMnNHQmx4Smd2dVVS?=
 =?utf-8?B?b1ljbEJCV29FRmtHTGdiT2llZWpMV0w0RUVVbEprcUVITnp0RDB3TW5Ob0FS?=
 =?utf-8?B?ZU5oQnZmbWl3KzhsR1c4OW1BZ05YajNGR2c4MzdrRWQwWmpid3ZwN296azBT?=
 =?utf-8?B?WmlLV2FVRDdNUlc1RmhRdWJqZThvQy9HMFljdFdIVUlSMTVWZ0NzR0E5U2R1?=
 =?utf-8?B?ZjdCYWRhWkF4ZVloYWFHamRlYjFaTDVBcXdXN2JmMmJPNWc0NGc0NmVPS1JI?=
 =?utf-8?B?T0lOS3VWclhMUVM1Ukg4OTNWOE1ZWEFhZWFwNkxlbEVqSTBTcXVDWm9TVU5w?=
 =?utf-8?B?alcxUU9oQ2tPcCtENElCQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVUxNjdVaVIzTVJad3B1NzdwRUhvbmp4SDFCcUJZL0FsQ1o3d0dlbllOWi9C?=
 =?utf-8?B?SzJDei9tTVR4MVRDaHdIeUI2bklzZFR1cDd5U0d6ek5sT0dNVVFCWUtNVml1?=
 =?utf-8?B?OWF3OEc4Qm81aUJsdDIyVWxSV3MyWUlyR2czaUQyWWQxZG5IU1YzRTdNbzJ0?=
 =?utf-8?B?RkQ4M1dTMlc0elJCcDUxaStFL1pGZU9Ia2d4RXZMNGtrcEhzOFo2QUJKSUla?=
 =?utf-8?B?TTJleitvb2U1S1ZJbHFTdzhaZGhMaGFISlFPSFUrMENWWmczcGh0cVV5cldB?=
 =?utf-8?B?YW5yTWcwVFZ3bk54K0lmdENLek1LRnUrMzNZWnZXVldPcjJiOU4vbUN5QUtE?=
 =?utf-8?B?RWR5TVB6VjVsWmVrVUdwZkNPQTNxdnltSXJXTlEwcHg1NUpIQjc1bjJQQXc4?=
 =?utf-8?B?bElqakV3eTN0TUQyRlZrTFdvSnVaZzZNYitiY2FBWTZBZzl4SDVITHI0alMv?=
 =?utf-8?B?WEl6dmdkSkRQTnl5L05rRVpmbzR4N2lnZnZsYVovTm1GQ3NUZUszeFpnL0Fm?=
 =?utf-8?B?SDEwU3lpM3RJSkxPV3FNbXRmalZEdjlDb3ZsU24xTGVEZGV6U0Izd1ExUkRr?=
 =?utf-8?B?YVBUNzFKYXVYbXY4UVA2V2ZTWVZsN0c5K1JFU0JQT01ULzVUZlhGRnJWbVRI?=
 =?utf-8?B?ZnpjVjR4eHRhb2QwQUZJcW9KTkROQ1RwMC9tdjRndkNwZ0gzTHRhMlJ4NnBs?=
 =?utf-8?B?eFJ3TS9uZXRtRmhMNHRCRlBxeFdMc3oranZ5SlNCNi9lM2xMUHcwazdtREFR?=
 =?utf-8?B?eStzVmVoNFlnT3dtai9GZ21pdFBBOVd6UzU2ckg2NFcvakxUWW9tTWlnY3Nh?=
 =?utf-8?B?TzUvbHhIMlVEcHVoQVZGbnEvREYxM3BXVzkwTkhLMjArRXVjQ1ZiTGZ4Z0dz?=
 =?utf-8?B?TERTSGpJU1o1MDJ0R3Z6eFpZUjZBQ2M1THQzMWVTSU4vVlc3aEhGQ1FUN3Rp?=
 =?utf-8?B?Q0o0UUZoWDduWEZJREwwZ3RuZjZmT05CeDRUL2V1VFRKN2tubGJFd0tCb3I2?=
 =?utf-8?B?SjZ2YU9kc0U4MFc4cWtoN09Eczl3dEpEMW8vTGg1b0lNVlNCUFlNZzdBQUlx?=
 =?utf-8?B?c3lMU2VFd2poY014bU1WaHo4NHFmTm9uOGJLbkhEMEtZVnN1cjNtVWdIMGJj?=
 =?utf-8?B?SDZPVlJaVWNVc2VqTGR5dTlqS2E1NE5ZSDhCNSt2WXFZeGlsbjFGVmN2ODR2?=
 =?utf-8?B?Yks2MFErbXpiMHRocHJzM2FLMFhKNyt2OHMwL1FGTVhpMkVueXpwTmo5OUJY?=
 =?utf-8?B?VHQrVk5nMnZ1NElmd0RxNFAxZUZUM2hYQ3FyUzZicnpnUlljai9Zd3pRODNi?=
 =?utf-8?B?SkFYYnRJQXZjNjE0SDRTZU41NzZQT3ZiZll6V2lTdkNIajFXaS9ZbGNkZFcr?=
 =?utf-8?B?azd4aVkyQVdjRHp4R3VMcmdsME44OWk1WXN5M0ZaaVU2aWtKYU9jcUtKMWxo?=
 =?utf-8?B?Q1A3aGFyNVljVThISWVJY1pBZlVDYUczdkU3VE1ZdkxCa2xENVlJZk9pUjkv?=
 =?utf-8?B?RktZVi94VFpnbDVOUXk5T1BQYkx2VGt5cGlXRWkxb3ZNY2M1UldCZS90U0o3?=
 =?utf-8?B?YzVoVzdEMjVmS3QzRzJzMlNKci8wSEFra3JEY0FPbGV5L1ZaSFlSVFZSVlVt?=
 =?utf-8?B?QzlINDF0cDJ1dTVKWjJpUDlJbEx1OXZyN0hMNGE3aEdjbjhRWjhQYnN6UUZp?=
 =?utf-8?B?blZNSENYZmhtN21sWGZUQytrcW9QM3cwaENObzlJTGdhbWxEejI0b2EyRjcv?=
 =?utf-8?B?ZG82VjM4anVVZmFiRFdrWThhUVh2U1h1d0dWL1hNVFptdVJsVDFTVHlISnJ6?=
 =?utf-8?B?b3BDbTZrellLS21lQzFMZGQ1YkVCTHFWZnphUkwxUUV2amlFNXhKMGZzeHRy?=
 =?utf-8?B?blc3d2dYSXZHVmhPbS9HZkR5cXp0R2FZVnJseXV3SzMya2Y0ellqQlR5cXVx?=
 =?utf-8?B?RWNxS0c4dVVFSjJvL3RNREMwVHpvSlhub2tTRjRVbkdUMWY2amUralB4TDc4?=
 =?utf-8?B?N2U0QlY4Ky9lMjJpamJWRVF2Qm9Sa1luZktyTkIrRlFJWThlL01pNHgyOUNX?=
 =?utf-8?B?UURVZkt0NCtoS2JQVVlyRk5rb21XdXVvV3A5aGQ2ZnJ6QUJybzdCTU0zMHNj?=
 =?utf-8?Q?V6kw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28409306-ee63-454a-ae3f-08dce148bf30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:09:34.4113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlMkVgi83SVw7uYGBNB1d63KFJWIpfcgsbHEOMffrytjk6hmNiuT3txfj4HjCaQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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

Am 30.09.24 um 13:58 schrieb Arunpravin Paneer Selvam:
> This patch introduces new IOCTL for userqueue secure semaphore.
>
> The signal IOCTL called from userspace application creates a drm
> syncobj and array of bo GEM handles and passed in as parameter to
> the driver to install the fence into it.
>
> The wait IOCTL gets an array of drm syncobjs, finds the fences
> attached to the drm syncobjs and obtain the array of
> memory_address/fence_value combintion which are returned to
> userspace.
>
> v2: (Christian)
>      - Install fence into GEM BO object.
>      - Lock all BO's using the dma resv subsystem
>      - Reorder the sequence in signal IOCTL function.
>      - Get write pointer from the shadow wptr
>      - use userq_fence to fetch the va/value in wait IOCTL.
>
> v3: (Christian)
>      - Use drm_exec helper for the proper BO drm reserve and avoid BO
>        lock/unlock issues.
>      - fence/fence driver reference count logic for signal/wait IOCTLs.
>
> v4: (Christian)
>      - Fixed the drm_exec calling sequence
>      - use dma_resv_for_each_fence_unlock if BO's are not locked
>      - Modified the fence_info array storing logic.
>
> v5: (Christian)
>      - Keep fence_drv until wait queue execution.
>      - Add dma_fence_wait for other fences.
>      - Lock BO's using drm_exec as the number of fences in them could
>        change.
>      - Install signaled fences as well into BO/Syncobj.
>      - Move Syncobj fence installation code after the drm_exec_prepare_array.
>      - Directly add dma_resv_usage_rw(args->bo_flags....
>      - remove unnecessary dma_fence_put.
>
> v6: (Christian)
>      - Add xarray stuff to store the fence_drv
>      - Implement a function to iterate over the xarray and drop
>        the fence_drv references.
>      - Add drm_exec_until_all_locked() wrapper
>      - Add a check that if we haven't exceeded the user allocated num_fences
>        before adding dma_fence to the fences array.
>
> v7: (Christian)
>      - Use memdup_user() for kmalloc_array + copy_from_user
>      - Move the fence_drv references from the xarray into the newly created fence
>        and drop the fence_drv references when we signal this fence.
>      - Move this locking of BOs before the "if (!wait_info->num_fences)",
>        this way you need this code block only once.
>      - Merge the error handling code and the cleanup + return 0 code.
>      - Initializing the xa should probably be done in the userq code.
>      - Remove the userq back pointer stored in fence_drv.
>      - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()
>
> v8: (Christian)
>      - Move fence_drv references must come before adding the fence to the list.
>      - Use xa_lock_irqsave_nested for nested spinlock operations.
>      - userq_mgr should be per fpriv and not one per device.
>      - Restructure the interrupt process code for the early exit of the loop.
>      - The reference acquired in the syncobj fence replace code needs to be
>        kept around.
>      - Modify the dma_fence acquire placement in wait IOCTL.
>      - Move USERQ_BO_WRITE flag to UAPI header file.
>      - drop the fence drv reference after telling the hw to stop accessing it.
>      - Add multi sync object support to userq signal IOCTL.
>
> V9: (Christian)
>      - Store all the fence_drv ref to other drivers and not ourself.
>      - Remove the userq fence xa implementation and replace with
>        kvmalloc_array.
>
> v10: (Christian)
>       - Add a comment for the userq_xa xarray
>       - drop the if check of userq_fence->fence_drv_array
>       - use the i variable to initialize userq_fence->fence_drv_array_count
>       - drop the fence reference before you free the array in the error handling,
>         otherwise it could be that some references leaked.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 446 +++++++++++++++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   7 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>   6 files changed, 483 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a31f6c92a755..6178a1cda223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1043,6 +1043,12 @@ struct amdgpu_device {
>   	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>   	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>   
> +	/* xarray used to retrieve the user queue fence driver reference
> +	 * in the EOP interrupt handler to signal the particular user
> +	 * queue fence.
> +	 */
> +	struct xarray			userq_xa;
> +
>   	/* df */
>   	struct amdgpu_df                df;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6e51b27b833d..70cb3b794a8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2878,6 +2878,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f7baea2c67ab..95f232ad4a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -25,6 +25,7 @@
>   #include <linux/kref.h>
>   #include <linux/slab.h>
>   
> +#include <drm/drm_exec.h>
>   #include <drm/drm_syncobj.h>
>   
>   #include "amdgpu.h"
> @@ -92,6 +93,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	spin_lock_init(&fence_drv->fence_list_lock);
>   
>   	fence_drv->adev = adev;
> +	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> @@ -105,6 +107,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   	struct amdgpu_userq_fence *userq_fence, *tmp;
>   	struct dma_fence *fence;
>   	u64 rptr;
> +	int i;
>   
>   	if (!fence_drv)
>   		return;
> @@ -115,14 +118,16 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
>   		fence = &userq_fence->base;
>   
> -		if (rptr >= fence->seqno) {
> -			dma_fence_signal(fence);
> -			list_del(&userq_fence->link);
> -
> -			dma_fence_put(fence);
> -		} else {
> +		if (rptr < fence->seqno)
>   			break;
> -		}
> +
> +		dma_fence_signal(fence);
> +
> +		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> +			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +
> +		list_del(&userq_fence->link);
> +		dma_fence_put(fence);
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   }
> @@ -132,8 +137,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>   					 struct amdgpu_userq_fence_driver,
>   					 refcount);
> +	struct amdgpu_userq_fence_driver *xa_fence_drv;
>   	struct amdgpu_device *adev = fence_drv->adev;
>   	struct amdgpu_userq_fence *fence, *tmp;
> +	struct xarray *xa = &adev->userq_xa;
> +	unsigned long index;
>   	struct dma_fence *f;
>   
>   	spin_lock(&fence_drv->fence_list_lock);
> @@ -150,6 +158,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   
> +	xa_lock(xa);
> +	xa_for_each(xa, index, xa_fence_drv)
> +		if (xa_fence_drv == fence_drv)
> +			__xa_erase(xa, index);
> +	xa_unlock(xa);
> +
>   	/* Free seq64 memory */
>   	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>   	kfree(fence_drv);
> @@ -191,6 +205,33 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	amdgpu_userq_fence_driver_get(fence_drv);
>   	dma_fence_get(fence);
>   
> +	if (!xa_empty(&userq->uq_fence_drv_xa)) {
> +		struct amdgpu_userq_fence_driver *stored_fence_drv;
> +		unsigned long index, count = 0;
> +		int i = 0;
> +
> +		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
> +			count++;
> +
> +		userq_fence->fence_drv_array =
> +			kvmalloc_array(count,
> +				       sizeof(struct amdgpu_userq_fence_driver *),
> +				       GFP_KERNEL);
> +
> +		if (userq_fence->fence_drv_array) {
> +			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
> +				userq_fence->fence_drv_array[i] = stored_fence_drv;
> +				xa_erase(&userq->uq_fence_drv_xa, index);
> +				i++;
> +			}
> +		}
> +
> +		userq_fence->fence_drv_array_count = i;
> +	} else {
> +		userq_fence->fence_drv_array = NULL;
> +		userq_fence->fence_drv_array_count = 0;
> +	}
> +
>   	spin_lock(&fence_drv->fence_list_lock);
>   	/* Check if hardware has already processed the job */
>   	if (!dma_fence_is_signaled(fence))
> @@ -240,6 +281,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>   
>   	/* Release the fence driver reference */
>   	amdgpu_userq_fence_driver_put(fence_drv);
> +
> +	kvfree(userq_fence->fence_drv_array);
>   	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>   }
>   
> @@ -255,3 +298,392 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.signaled = amdgpu_userq_fence_signaled,
>   	.release = amdgpu_userq_fence_release,
>   };
> +
> +/**
> + * amdgpu_userq_fence_read_wptr - Read the userq wptr value
> + *
> + * @filp: drm file private data structure
> + * @queue: user mode queue structure pointer
> + * @wptr: write pointer value
> + *
> + * Read the wptr value from userq's MQD. The userq signal IOCTL
> + * creates a dma_fence for the shared buffers that expects the
> + * RPTR value written to seq64 memory >= WPTR.
> + *
> + * Returns wptr value on success, error on failure.
> + */
> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> +					struct amdgpu_usermode_queue *queue,
> +					u64 *wptr)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo *bo;
> +	u64 addr, *ptr;
> +	int r;
> +
> +	addr = queue->userq_prop->wptr_gpu_addr;
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
> +	if (!mapping)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	r = amdgpu_bo_reserve(bo, true);
> +	if (r) {
> +		DRM_ERROR("Failed to reserve userqueue wptr bo");
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (r) {
> +		DRM_ERROR("Failed mapping the userqueue wptr bo");
> +		goto map_error;
> +	}
> +
> +	*wptr = le64_to_cpu(*ptr);
> +
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return 0;
> +
> +map_error:
> +	amdgpu_bo_unreserve(bo);
> +	return r;
> +}
> +
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_signal *args = data;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_gem_object **gobj = NULL;
> +	struct drm_syncobj **syncobj = NULL;
> +	u32 *syncobj_handles, num_syncobj_handles;
> +	u32 *bo_handles, num_bo_handles;
> +	int r, i, entry, boentry;
> +	struct dma_fence *fence;
> +	struct drm_exec exec;
> +	u64 wptr;
> +
> +	/* Array of syncobj handles */
> +	num_syncobj_handles = args->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj_handles);
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
> +
> +	/* Array of pointers to the looked up syncobjs */
> +	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
> +	if (!syncobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_syncobj_handles; entry++) {
> +		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry]) {
> +			r = -ENOENT;
> +			goto free_syncobj;
> +		}
> +	}
> +
> +	/* Array of bo handles */
> +	num_bo_handles = args->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		goto free_syncobj;
> +
> +	/* Array of pointers to the GEM objects */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_bo_handles;
> +	}
> +
> +	for (boentry = 0; boentry < num_bo_handles; boentry++) {
> +		gobj[boentry] = drm_gem_object_lookup(filp, bo_handles[boentry]);
> +		if (!gobj[boentry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +	}
> +
> +	/*Retrieve the user queue */
> +	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	if (!queue) {
> +		r = -ENOENT;
> +		goto exec_fini;
> +	}
> +
> +	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	if (r)
> +		goto exec_fini;
> +
> +	/* Create a new fence */
> +	r = amdgpu_userq_fence_create(queue, wptr, &fence);
> +	if (r)
> +		goto exec_fini;
> +
> +	for (i = 0; i < num_bo_handles; i++)
> +		dma_resv_add_fence(gobj[i]->resv, fence,
> +				   dma_resv_usage_rw(args->bo_flags &
> +				   AMDGPU_USERQ_BO_WRITE));
> +
> +	/* Add the created fence to syncobj/BO's */
> +	for (i = 0; i < num_syncobj_handles; i++)
> +		drm_syncobj_replace_fence(syncobj[i], fence);
> +
> +	/* drop the reference acquired in fence creation function */
> +	dma_fence_put(fence);
> +
> +exec_fini:
> +	drm_exec_fini(&exec);
> +put_gobj:
> +	while (boentry-- > 0)
> +		drm_gem_object_put(gobj[boentry]);
> +	kfree(gobj);
> +free_bo_handles:
> +	kfree(bo_handles);
> +free_syncobj:
> +	while (entry-- > 0)
> +		if (syncobj[entry])
> +			drm_syncobj_put(syncobj[entry]);
> +	kfree(syncobj);
> +free_syncobj_handles:
> +	kfree(syncobj_handles);
> +
> +	return r;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	u32 *syncobj_handles, *bo_handles;
> +	struct dma_fence **fences = NULL;
> +	u32 num_syncobj, num_bo_handles;
> +	struct drm_gem_object **gobj;
> +	struct drm_exec exec;
> +	int r, i, entry, cnt;
> +	u64 num_fences = 0;
> +
> +	num_bo_handles = wait_info->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		return PTR_ERR(bo_handles);
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj);
> +	if (IS_ERR(syncobj_handles)) {
> +		r = PTR_ERR(syncobj_handles);
> +		goto free_bo_handles;
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_bo_handles; entry++) {
> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> +		if (!gobj[entry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r) {
> +			drm_exec_fini(&exec);
> +			goto put_gobj;
> +		}
> +	}
> +
> +	if (!wait_info->num_fences) {
> +		/* Count syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			if (r)
> +				goto exec_fini;
> +
> +			num_fences++;
> +			dma_fence_put(fence);
> +		}
> +
> +		/* Count GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence)
> +				num_fences++;
> +		}
> +
> +		/*
> +		 * Passing num_fences = 0 means that userspace doesn't want to
> +		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +		 * userq_fence_info and return the actual number of fences on
> +		 * args->num_fences.
> +		 */
> +		wait_info->num_fences = num_fences;
> +	} else {
> +		/* Array of fence info */
> +		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> +		if (!fence_info) {
> +			r = -ENOMEM;
> +			goto exec_fini;
> +		}
> +
> +		/* Array of fences */
> +		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> +		if (!fences) {
> +			r = -ENOMEM;
> +			goto free_fence_info;
> +		}
> +
> +		/* Retrieve GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence) {
> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					r = -EINVAL;
> +					goto free_fences;
> +				}
> +
> +				fences[num_fences++] = fence;
> +				dma_fence_get(fence);
> +			}
> +		}
> +
> +		/* Retrieve syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			if (r)
> +				goto free_fences;
> +
> +			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +				r = -EINVAL;
> +				goto free_fences;
> +			}
> +
> +			fences[num_fences++] = fence;
> +		}
> +
> +		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
> +			struct amdgpu_userq_fence_driver *fence_drv;
> +			struct amdgpu_userq_fence *userq_fence;
> +			u32 index;
> +
> +			userq_fence = to_amdgpu_userq_fence(fences[i]);
> +			if (!userq_fence) {
> +				/*
> +				 * Just waiting on other driver fences should
> +				 * be good for now
> +				 */
> +				dma_fence_wait(fences[i], false);
> +				dma_fence_put(fences[i]);
> +
> +				continue;
> +			}
> +
> +			fence_drv = userq_fence->fence_drv;
> +			/*
> +			 * We need to make sure the user queue release their reference
> +			 * to the fence drivers at some point before queue destruction.
> +			 * Otherwise, we would gather those references until we don't
> +			 * have any more space left and crash.
> +			 */
> +			if (fence_drv->uq_fence_drv_xa_ref) {
> +				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
> +					     xa_limit_32b, GFP_KERNEL);
> +				if (r)
> +					goto free_fences;
> +
> +				amdgpu_userq_fence_driver_get(fence_drv);
> +			}
> +
> +			/* Store drm syncobj's gpu va address and value */
> +			fence_info[cnt].va = fence_drv->gpu_addr;
> +			fence_info[cnt].value = fences[i]->seqno;
> +
> +			dma_fence_put(fences[i]);
> +			/* Increment the actual userq fence count */
> +			cnt++;
> +		}
> +
> +		wait_info->num_fences = cnt;
> +		/* Copy userq fence info to user space */
> +		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
> +				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> +			r = -EFAULT;
> +			goto free_fences;
> +		}
> +
> +		kfree(fences);
> +		kfree(fence_info);
> +	}
> +
> +	drm_exec_fini(&exec);
> +	for (i = 0; i < num_bo_handles; i++)
> +		drm_gem_object_put(gobj[i]);
> +	kfree(gobj);
> +
> +	kfree(syncobj_handles);
> +	kfree(bo_handles);
> +
> +	return 0;
> +
> +free_fences:
> +	while (num_fences-- > 0)
> +		dma_fence_put(fences[num_fences]);
> +	kfree(fences);
> +free_fence_info:
> +	kfree(fence_info);
> +exec_fini:
> +	drm_exec_fini(&exec);
> +put_gobj:
> +	while (entry-- > 0)
> +		drm_gem_object_put(gobj[entry]);
> +	kfree(gobj);
> +free_syncobj_handles:
> +	kfree(syncobj_handles);
> +free_bo_handles:
> +	kfree(bo_handles);
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index c3e04cdbb9e7..f72424248cc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -37,7 +37,9 @@ struct amdgpu_userq_fence {
>   	 */
>   	spinlock_t lock;
>   	struct list_head link;
> +	unsigned long fence_drv_array_count;
>   	struct amdgpu_userq_fence_driver *fence_drv;
> +	struct amdgpu_userq_fence_driver **fence_drv_array;
>   };
>   
>   struct amdgpu_userq_fence_driver {
> @@ -52,6 +54,7 @@ struct amdgpu_userq_fence_driver {
>   	spinlock_t fence_list_lock;
>   	struct list_head fences;
>   	struct amdgpu_device *adev;
> +	struct xarray *uq_fence_drv_xa_ref;
>   	char timeline_name[TASK_COMM_LEN];
>   };
>   
> @@ -65,5 +68,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 7f6495466975..ba986d55ceeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -27,6 +27,32 @@
>   #include "amdgpu_userqueue.h"
>   #include "amdgpu_userq_fence.h"
>   
> +static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long index;
> +
> +	if (xa_empty(xa))
> +		return;
> +
> +	xa_lock(xa);
> +	xa_for_each(xa, index, fence_drv) {
> +		__xa_erase(xa, index);
> +		amdgpu_userq_fence_driver_put(fence_drv);
> +	}
> +
> +	xa_unlock(xa);
> +}
> +
> +static void
> +amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
> +{
> +	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
> +	xa_destroy(&userq->uq_fence_drv_xa);
> +	/* Drop the fence_drv reference held by user queue */
> +	amdgpu_userq_fence_driver_put(userq->fence_drv);
> +}
> +
>   static void
>   amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   			 struct amdgpu_usermode_queue *queue,
> @@ -36,7 +62,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>   
>   	uq_funcs->mqd_destroy(uq_mgr, queue);
> -	amdgpu_userq_fence_driver_put(queue->fence_drv);
> +	amdgpu_userq_fence_driver_free(queue);
>   	idr_remove(&uq_mgr->userq_idr, queue_id);
>   	kfree(queue);
>   }
> @@ -320,6 +346,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   	queue->doorbell_index = index;
>   
> +	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to alloc fence driver\n");
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 5fbffde48999..77a33f9e37f8 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -47,6 +47,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_obj	db_obj;
>   	struct amdgpu_userq_obj fw_obj;
>   	struct amdgpu_userq_obj wptr_obj;
> +	struct xarray		uq_fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   

