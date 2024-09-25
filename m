Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E588C369AA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 09:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C52910E2D9;
	Wed, 25 Sep 2024 09:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OzohOT1J";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA0010E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 09:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfmH2mX8mZWyArrvFgQJBHeZS07uoOvR3WRLxVYPjS1EF+RnKUcf0SjeBhOEAleOtfHkeeXtnPaLtaQCaPxSj+adf8iOf31r5iZK09gZ+qLS+05okVvrFxtnqkUKCTLs64R2vGwnv7tsI491pfUu0MwE0Vip3h+p8/9nn+DhGRmwYo7q4qUHC4mm5ZM7Dx5WgNlV02SIbRfCXbKwK+ny8Ld4hYPx09JOOKRoDGVjMH4qptkohD/Iykr6gymuTK5K2P+APesKun6bizFPWSDXmH7J6agG+hpq8SUNvT01m4hNk1bV2QRDMk7hBS34zbcl2d49qm02/6PiDqDB2OlERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQewKAlptzlv7DYFCsuGNYBLkrMoxPJYuF8HObM0Z2A=;
 b=BcVi1Ew0aBoTR8xJP2PLMlJapmSGEecdm0yZ3nqwfj4O3XpDzUj7Q0mliwdR1hwFz3vKcg65U44HDocvpu9rzzMeBV0jaPeqTxGHUetPhkx04bBLtwgM4UQUyo87z+3In+yYiYXiAfUmStwc+LLs0H+au7/k1qeFozAe0FzEWE0uDS9dKLdSSgJ6e15onysNn/bnulD6R5jVFXMVh3A/VMEfjOS2jvrkRUZ+4tf0Dtr1/oqwQdaHcuzVy9yfhvHq36HUIvOV+dNOa4s5whzrD6MPUs3yQcid1S00QcSQc4hIeIkZxnE5hWiEVVWLGcxYdxejXpuFygb42kl/2sjjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQewKAlptzlv7DYFCsuGNYBLkrMoxPJYuF8HObM0Z2A=;
 b=OzohOT1JUYZEGHwoGDH4yqAQ+K3BG68tA9ROqEouSAZaxQg/2DI+n+uBh6sD+3HyxXg/nKoh/1EIw6ib9TRWS8kgScUN82jFjXMrIISeIkF0L0Arr18xntAzJXsxMSe7KOTsXPKmoFuCg1K4JP56bjsngxUDGIA5OJ7yQr1b5+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 09:08:43 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.7982.016; Wed, 25 Sep 2024
 09:08:43 +0000
Message-ID: <6e7ef802-3634-4c22-b760-a42995b110a4@amd.com>
Date: Wed, 25 Sep 2024 11:08:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/28] drm/amdgpu: add gfx eviction fence helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-17-shashank.sharma@amd.com>
 <7ee872e3-7dea-43c2-84fa-4170b127ff06@gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <7ee872e3-7dea-43c2-84fa-4170b127ff06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: c4beb983-a47d-4eba-a106-08dcdd41a734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUVSaHQ0cFltdnVqbENxc3kzR2VlOXM0QXc0R04wMmtwK1pIbWNRM2FNaXJG?=
 =?utf-8?B?RlUxd2RmZitaWkFHNjBsVmhITFVhV0FyNU5VaW52YUZvWEROb005d1RldHhC?=
 =?utf-8?B?NForWUVDaTF0UnB6RmpVS2xGdjdXQnQzeDJvMkw1dm80TFpkVExveWNEQW1K?=
 =?utf-8?B?Rkh0RVJoTnh5M2x3NlMrMDRuMm9xdmZnNGthL0E1M0dxTXFma1dBeUJOblFV?=
 =?utf-8?B?TnpUOXlkQzV5SzFxbXM2clZwTW1EQ1pxVHNKYkUzUGNsZnYwWEFJYTRscUdV?=
 =?utf-8?B?ajhzU3BpMytnNXlLaW5qZFpPMG1hUWtyNEdsdDBkYU81dUJ3S3VnVTNiZ0N5?=
 =?utf-8?B?a0NqSFo1SmJCRW1QdldLNmxZWVkvaG81TXhCODNLdWJjMEJrVzhyYmlJQUx5?=
 =?utf-8?B?L2N1Rkx2RzZPVnVJTE9pMndJcjVOQUM4blE0Qm1lSGI2RGhtTXNYT0NJWDdv?=
 =?utf-8?B?V0NveThyRDlkSjc2UTl5SGVaNW1jeDEvRE1hWWtXWFdQVVBMbnZsVXN4QnY2?=
 =?utf-8?B?Mmc0QWNuUHpxaXdGVERZMUZtVzRyUFl0ekVsMWJXKzJ1dU91MXVhMU9KVWox?=
 =?utf-8?B?anFMSUR0eUNXaEhOYXBYS2I2alN3ejdmZm5rWmk1N0FvUFRtTUdVbXFMQjkw?=
 =?utf-8?B?cVp2Z2FBUzd0RW16Sld2ekVYdGxyUG4raVRwMDNOeHZRNjlQTU15c3B2d2lX?=
 =?utf-8?B?M1IvdHRNcE9ndkQvTERYVXhyRzNiOEJkRXpEVjhsV1Q5NkQ5bXZYckwzSTJY?=
 =?utf-8?B?dDIxRDBVbFBDSEtTQkhXNGltWlI3elRPQ0xGVWhkMEppck5GYWNlOHRVWjA1?=
 =?utf-8?B?cUJrd2QwUEpRdUFheUllWi9USGhVenVvTFdXQ3dwSEpraklFUG1BUmVoYzhT?=
 =?utf-8?B?aUg4S3F3NEgyL1NPUmFYcU5xK0RUWmtEaVFrQXFKMnk2V2hwNmd3UlJjMEdF?=
 =?utf-8?B?UHVYNEhneEZLWEwwNFpubUdROExNd2luMjQ1SjVMb1lvSjRLYVNmSTVaZzNt?=
 =?utf-8?B?NEt4VDhCWW9KN2haWGtZSDBUUlRLNlBKck82bnhsc0hjUnFXb05kUHo5STZa?=
 =?utf-8?B?MURnVTVjZ3dsclNNOXVLVFp6RXIvUVdFdHR6YUMzMjRIb3QvaEtBYlhVWWJr?=
 =?utf-8?B?UUJscTVOdmpoVE1MVUlrTm9VRmlOcHBMalhFUDQ4akRmbnd6RXhhelRBTmVY?=
 =?utf-8?B?RWZTRS8xeXZiQy8ybTNIWGNZbzd5cEt6dzZtdzk1b25Dai92bTdUK1dqZmw3?=
 =?utf-8?B?bjE4QXo1aFFaK2tzeFBvQXJ5SDFFano3YXdNa3h4cXJQU2xsZis2cnltV3Fs?=
 =?utf-8?B?MWFrWnphRGVSYUh1eFBoRlI3UWdiaHJaMG1yUFUzZ2VXZkFFMlFqS0UvOUpB?=
 =?utf-8?B?Zkh6UXFxUHgrVU9Gd3Z0ZGRTd04xU2JacGRjdGxTUzVNZUF1SG56YzhaRWN3?=
 =?utf-8?B?dWtwT3p4N245WEtuWXdwL3V0UklCUVowSXNGZnJEOGUrbWFZZ3BQMGd3RkMy?=
 =?utf-8?B?U2xwMVB1b3k3ekNGMkF6bHpCd2M5Z2pnZ0xIei9yZm9ILytPLzZQak9FcDZ1?=
 =?utf-8?B?YzJLVGNMY1BGaWpjWnMrbG9zK2E4YzB1bDZnd21KRm9vNTFZaEtycmgrYS9t?=
 =?utf-8?B?dDEyaHdvRVMwN2FsRUNEY0hYQ3AwQUlxT1F2N2o4MFRHalM2Rk1FTDk2YitB?=
 =?utf-8?B?RStER0pTYXluVkkxUWhMS1d6U3hRUDJBQ1E1NzNCdzFWY1hkZUxLZlVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0J1UDRPQmRua1RUSWFqM21NVFVTc2RBV2hzWllsQS9icnNGdFg4WUgzNUE5?=
 =?utf-8?B?U0pTOUY3WmEvMXhjRmJ0Y2RSUEd3LzY2cmVscjFWL2sreTNMbENtMzMvbGFr?=
 =?utf-8?B?a3hWQ2FNS29oUFcwUG0vaG5FdzA4OWtsVDdTa3podm9tSEJDUWVSd1l5blNq?=
 =?utf-8?B?K1Zaa2ZvaTFsWFlJRGZPUlIvaE5BRFNZeEMxTGtLSHUrbjNQdnBwQWp5cHdp?=
 =?utf-8?B?UitjZE9zY0lsaUdyaG43UTZZcnA4OEJ5RzNGM05GR25NY1dhMWxHemVaSjFC?=
 =?utf-8?B?S3FQSDd6ZWgveENhbGx1QXZVWm1ENCt4TG1HSjUyazFtQkJNSFJ2bGJNTTF0?=
 =?utf-8?B?T3RPZ2EvazZGRXNpRVRsM3JQcmFZNlNtVFVtTTIrVHJTZmlYd1pHNFpnUTUz?=
 =?utf-8?B?OHRWeVBac3p4V3BZNzlJOThGNkExeFpKRTI0OWNvL3p1Yk5DSW4xQVlMbHRo?=
 =?utf-8?B?QytoNnAvN3JSY3BJLzJoV2dVaVNNNUd6YStQOFp5WjJmMU9QU25haytKNXJv?=
 =?utf-8?B?elVsOXFmQ1F0cEtvaUJCUXlENlorWEFuMVFvL2N5WjF6WG9CYjJZdE9UenpX?=
 =?utf-8?B?c0ZObG4zV1RtajBYQkR4a3lzVDRMWFdGc1plRmZNT1dNYlVGcmsvbDZ6UDVJ?=
 =?utf-8?B?RXZ1bU9ZTmZQL3BkdUgyYVJvYUNsT2dsRDFNdzk2T0pUdFk2ZjdVanlZRVoy?=
 =?utf-8?B?ZVBVZDhvaGdnTU0rVDdvQ2duMHdqSjhBUFBPZ2dSUTgrNWdWSDN5NzNmWUd3?=
 =?utf-8?B?RTZtODR0RkpnYWNUOW1sQ05GM014SWdWUjBSZm1WL0doR1JTSEVpbXA3WEdp?=
 =?utf-8?B?akU0UXBUazAraEVCamozTVkybCtmMUNrcUx5NjBTbDBkNHdmbmtUcGhuL1FX?=
 =?utf-8?B?RC9YV3diL2ZLOGN2SUszdGtWOXZyU0tkS3VpbHhieTIyN3NyUXBlekt3eWFS?=
 =?utf-8?B?KzJ2QUZZRkttOFdWdzVsS2RsUXIvNmUwUDRKd3BmSDZlQmpyZkNRTnpodVR2?=
 =?utf-8?B?aXJSR2E5SmE3a3N6QmlHNkE0MXlxNnB6di8yRkMyajVZRHBycHdERlNDQkVk?=
 =?utf-8?B?a0tESHNudDFTRkduU25EL2Jqd1Q5UWRiVHRUakd5MUdkbFlQS2dnUjZlQUxE?=
 =?utf-8?B?ckNJdjNoVzJCRjdqM3BZa1h5OU1lenV3MEFtc1p1eTNSeFpGclV2Ui84azBD?=
 =?utf-8?B?VEhTV3RXQnJHUUlhK2djVDNZUk94aUFKL0JGK0thTmJ2c0dTVHBHTkh5L05E?=
 =?utf-8?B?VU1ISUluQ2V5dEN4OS91aXREUGRmL3pZcEJ5a25SWFRDWUNyeUVZVGhQYmpK?=
 =?utf-8?B?WHA1NitoZW9FV1JYVGZiYTRGVDBGMDhlUmdoZEw4WkJKSUt6ck5GSzZ5Nkov?=
 =?utf-8?B?YXFiQ2txdUdlZ2RvL2cyMEZwNVk2RlhhWFNSdGtUOUxrVE9xSHdQSkVQVEZm?=
 =?utf-8?B?R2hlZHVrWW51N2pYK0d6aWIwT3BUSjVlY1dNaWVXR1ZxNjJDckpNdEYvMCtv?=
 =?utf-8?B?QUsxMGpIOVVOMVhiNjJKMHUzZmljNkFQLzJIcFJUdXU1bHpHK3hNeDdRVkUr?=
 =?utf-8?B?Y2xvVlNaUjFzM0xkUjFodUNCV0NWVmV6RXViSW5jV0tTY1VlOVp2S3duRndB?=
 =?utf-8?B?NGZSU3IxbFlHZkI5WGduVlo2amtOUUxuSHJEcGZQK1o5VEpubGNtRkdBMFV3?=
 =?utf-8?B?Wnc1dTJKZnRFNlUxR3lzNXdEQlFoWTc3SkpPcHV3bXRZdEhQWTBOQ0dJd2Q5?=
 =?utf-8?B?a0NLODJ3OVZQdTQ5RlJ3WGJmbk5MSStDUzNhNW54eXpPMU0yNzZ5Z2MyeG95?=
 =?utf-8?B?L3htTG01Snd5dzU4eXc0ZWtrZ2dqOWtwL3ZJVGxueUlUSXFhdUU0cW1RV29M?=
 =?utf-8?B?VGFWRTgrREwzZFpRSExPTXZXWm83bFFKWFZBaWN6Ukh6NUdPc3hCZWY1enJk?=
 =?utf-8?B?SnZRSWdtNW5MNUlOY0RqTzJwRDJKU2I5emM5bjNqUStuazFWbndkMHI0U2xa?=
 =?utf-8?B?eFNMNTJpNG5JUXZWYkg1RGJ0TGRxdUhXaWpOU0p2ejR1NUkyUndRc0xBMGJY?=
 =?utf-8?B?eUJsa2o2ZDFVZk43b1o0bUFMallrU0w4TWRld1pha21hUlNJcmduMEdrb0gv?=
 =?utf-8?Q?hT/SMfoS7TqMpMP/ZFoi8qNey?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4beb983-a47d-4eba-a106-08dcdd41a734
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:08:43.0073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyET8CfQoUlYrLA0VGRRgigjaTUCVrJ7d0Or1amybbesQXDBLiVQ2bpvdrW4xqtx2iXUBAmcxyrGYMRKdDSmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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

Hey Christian,

On 16/09/2024 16:14, Christian König wrote:
> Am 09.09.24 um 22:06 schrieb Shashank Sharma:
>> This patch adds basic eviction fence framework for the gfx buffers.
>> The idea is to:
>> - One eviction fence is created per gfx process, at kms_open.
>> - This fence is attached to all the gem buffers created
>>    by this process.
>> - This fence is detached to all the gem buffers at postclose_kms.
>>
>> This framework will be further used for usermode queues.
>>
>> V2: Addressed review comments from Christian
>>      - keep fence_ctx and fence_seq directly in fpriv
>>      - evcition_fence should be dynamically allocated
>>      - do not save eviction fence instance in BO, there could be many
>>        such fences attached to one BO
>>      - use dma_resv_replace_fence() in detach
>>
>> V3: Addressed review comments from Christian
>>      - eviction fence create and destroy functions should be called 
>> only once
>>        from fpriv create/destroy
>>      - use dma_fence_put() in eviction_fence_destroy
>>
>> V4: Addressed review comments from Christian:
>>      - create a separate ev_fence_mgr structure
>>      - cleanup fence init part
>>      - do not add a domain for fence owner KGD
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> Change-Id: I7a8d27d7172bafbfe34aa9decf2cd36655948275
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +-
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 148 ++++++++++++++++++
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  65 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   9 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
>>   6 files changed, 231 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index ff5621697c68..0643078d1225 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -66,7 +66,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>> amdgpu_kms.o \
>>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>>       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o 
>> amdgpu_dev_coredump.o \
>> -    amdgpu_userq_fence.o
>> +    amdgpu_userq_fence.o amdgpu_eviction_fence.o
>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 76ada47b1875..0013bfc74024 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -113,6 +113,7 @@
>>   #include "amdgpu_seq64.h"
>>   #include "amdgpu_reg_state.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "amdgpu_eviction_fence.h"
>>   #if defined(CONFIG_DRM_AMD_ISP)
>>   #include "amdgpu_isp.h"
>>   #endif
>> @@ -481,7 +482,6 @@ struct amdgpu_flip_work {
>>       bool                async;
>>   };
>>   -
>>   /*
>>    * file private structure
>>    */
>> @@ -495,6 +495,10 @@ struct amdgpu_fpriv {
>>       struct idr        bo_list_handles;
>>       struct amdgpu_ctx_mgr    ctx_mgr;
>>       struct amdgpu_userq_mgr    userq_mgr;
>> +
>> +    /* Eviction fence infra */
>> +    struct amdgpu_eviction_fence_mgr evf_mgr;
>> +
>>       /** GPU partition selection */
>>       uint32_t        xcp_id;
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> new file mode 100644
>> index 000000000000..2d474cb11cf9
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include <linux/sched.h>
>> +#include "amdgpu.h"
>> +
>> +static const char *
>> +amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>> +{
>> +    return "amdgpu";
>> +}
>> +
>> +static const char *
>> +amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
>> +{
>> +    struct amdgpu_eviction_fence *ef;
>> +
>> +    ef = container_of(f, struct amdgpu_eviction_fence, base);
>> +    return ef->timeline_name;
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>> +    .use_64bit_seqno = true,
>> +    .get_driver_name = amdgpu_eviction_fence_get_driver_name,
>> +    .get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
>> +};
>> +
>> +int amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>> +{
>> +    int ret;
>> +
>> +    spin_lock(&evf_mgr->ev_fence_lock);
>> +    ret = dma_fence_signal(&evf_mgr->ev_fence->base);
>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>> +    return ret;
>> +}
>> +
>> +struct amdgpu_eviction_fence *
>> +amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> +    struct amdgpu_eviction_fence *ev_fence;
>> +
>> +    ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>> +    if (!ev_fence)
>> +        return NULL;
>> +
>> +    get_task_comm(ev_fence->timeline_name, current);
>> +    spin_lock_init(&ev_fence->lock);
>> +    dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
>> +               &ev_fence->lock, evf_mgr->ev_fence_ctx,
>> + atomic_inc_return(&evf_mgr->ev_fence_seq));
>> +    return ev_fence;
>> +}
>> +
>> +void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>> +{
>> +    if (!evf_mgr->ev_fence)
>> +        return;
>> +
>> +    if (!dma_fence_is_signaled(&evf_mgr->ev_fence->base))
>
> You can drop that if, dma_fence_wait() will check that anyway.
Noted
>
>> + dma_fence_wait(&evf_mgr->ev_fence->base, false);
>> +
>> +    /* Last unref of ev_fence */
>> +    spin_lock(&evf_mgr->ev_fence_lock);
>> +    dma_fence_put(&evf_mgr->ev_fence->base);
>> +    evf_mgr->ev_fence = NULL;
>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>> +}
>> +
>> +int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                 struct amdgpu_bo *bo)
>> +{
>> +    struct dma_fence *ef;
>> +    struct amdgpu_eviction_fence *ev_fence = evf_mgr->ev_fence;
>> +    struct dma_resv *resv = bo->tbo.base.resv;
>> +    int ret;
>> +
>> +    if (!ev_fence || !resv)
>> +        return 0;
>> +
>> +    ef = &ev_fence->base;
>> +    ret = dma_resv_reserve_fences(resv, 1);
>> +    if (ret) {
>> +        dma_fence_wait(ef, false);
>> +        return ret;
>> +    }
>> +
>> +    spin_lock(&evf_mgr->ev_fence_lock);
>> +    dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>
> That spinlock is protecting evf_mgr->ev_fence, isn't it?
>
> In that case you probably shouldn't dereference it outside of the 
> spinlock.
Noted
>
>> +    return 0;
>> +}
>> +
>> +void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                  struct amdgpu_bo *bo)
>> +{
>> +    struct dma_fence *stub;
>> +    struct amdgpu_eviction_fence *ev_fence = evf_mgr->ev_fence;
>> +
>> +    if (!ev_fence)
>> +        return;
>> +
>> +    spin_lock(&evf_mgr->ev_fence_lock);
>> +    stub = dma_fence_get_stub();
>> +    dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
>> +                stub, DMA_RESV_USAGE_BOOKKEEP);
>> +    dma_fence_put(stub);
>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>
> This operation doesn't need the spinlock since we are not accessing 
> evf_mgr->ev_fence.

Actually the intent of this lock was to serialize the update inside 
evf_mgr across various queues inside a process, so I want to use it for 
any updates into evf_mgr. Do you think that's unnecessary ?

>
>> +}
>> +
>> +void amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>> +{
>> +
>> +    /* This needs to be done one time per open */
>> +    atomic_set(&evf_mgr->ev_fence_seq, 0);
>> +    evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
>> +    spin_lock_init(&evf_mgr->ev_fence_lock);
>> +
>> +    spin_lock(&evf_mgr->ev_fence_lock);
>> +    evf_mgr->ev_fence = amdgpu_eviction_fence_create(evf_mgr);
>
> amdgpu_eviction_fence_create() will call kmalloc, doing that while 
> holding the spinlock is a bad idea.
>
> You need to do something like:
>
> tmp = amdgpu_eviction_fence_create(....);
> spin_lock(...);
> evf_mgr->ev_fence = tmp;
> ...
Noted
>
>> +    if (!evf_mgr->ev_fence) {
>> +        DRM_ERROR("Failed to craete eviction fence\n");
>> +        goto unlock;
>> +    }
>> +
>> +unlock:
>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> new file mode 100644
>> index 000000000000..b47ab1307ec5
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_EV_FENCE_H_
>> +#define AMDGPU_EV_FENCE_H_
>> +
>> +struct amdgpu_eviction_fence {
>> +    struct dma_fence base;
>> +    spinlock_t     lock;
>> +    char         timeline_name[TASK_COMM_LEN];
>> +    struct amdgpu_userq_mgr *uq_mgr;
>> +};
>> +
>> +struct amdgpu_eviction_fence_mgr {
>> +    u64            ev_fence_ctx;
>> +    atomic_t        ev_fence_seq;
>> +    spinlock_t         ev_fence_lock;
>> +    struct amdgpu_eviction_fence *ev_fence;
>> +};
>> +
>> +/* Eviction fence helper functions */
>> +struct amdgpu_eviction_fence *
>> +amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>> +
>> +void
>> +amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>> +
>> +int
>> +amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                 struct amdgpu_bo *bo);
>> +
>> +void
>> +amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                 struct amdgpu_bo *bo);
>> +
>> +void
>> +amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +
>> +int
>> +amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>> +
>> +int
>> +amdgpu_eviction_fence_replace_fence(struct amdgpu_fpriv *fpriv);
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index f4529f2fad97..c9b4a6ce3f14 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -186,6 +186,13 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>           bo_va = amdgpu_vm_bo_add(adev, vm, abo);
>>       else
>>           ++bo_va->ref_count;
>> +
>> +    if (!vm->is_compute_context || !vm->process_info) {
>
> I said it before, we should really drop this line since the user 
> queues are completely independent of that.
I can see that compute code is trying to segregate the KFD UQs, so I 
thought we should also do the same.
>
>> +        /* attach gfx eviction fence */
>> +        if (amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo))
>> +            DRM_DEBUG_DRIVER("Failed to attach eviction fence to 
>> BO\n");
>> +    }
>> +
>>       amdgpu_bo_unreserve(abo);
>>         /* Validate and add eviction fence to DMABuf imports with 
>> dynamic
>> @@ -236,6 +243,8 @@ static void amdgpu_gem_object_close(struct 
>> drm_gem_object *obj,
>>       struct drm_exec exec;
>>       long r;
>>   +    amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>> +
>
> We should probably skip that call for per VM BOs, or otherwise we will 
> also detach the page tables accidentally.

Agreed, but we have not added the fence to VM root yet, due to the 
dependency as discussed. There will be separate patch for it, following 
this.

- Shashank

>
> BTW: Were do we attach the eviction fence to the page tables?
>
> Regards,
> Christian.
>
>>       drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>>       drm_exec_until_all_locked(&exec) {
>>           r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 019a377620ce..e7fb13e20197 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1391,6 +1391,8 @@ int amdgpu_driver_open_kms(struct drm_device 
>> *dev, struct drm_file *file_priv)
>>       mutex_init(&fpriv->bo_list_lock);
>>       idr_init_base(&fpriv->bo_list_handles, 1);
>>   +    amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>> +
>>       amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>         r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>> @@ -1464,6 +1466,7 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>           amdgpu_bo_unreserve(pd);
>>       }
>>   +    amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>       amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>       amdgpu_vm_fini(adev, &fpriv->vm);
>>       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>
