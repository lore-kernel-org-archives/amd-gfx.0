Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A6CC25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 15:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6162210E22B;
	Fri, 31 May 2024 15:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="weP0p3G5";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A50910E22B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 15:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6LwyuLMWnM9/hou0IwiC9e6tZWWZpC1nM04u0RgSxBDJ/peLylphbq9k0wy/bhau/uUUD9JAjs/DyT3awDMdIVkbugG8WjH0jtg010KcGu3D+j+crUaL59U4S8pDA0+sfC/2DdEVOp04mVjIuYAIOZusqEJK5jTC8qspjlaPl06NXV1nj/y0m+yuFjkOHp4gHTyUSFuOr/+wrb40V+I3K+BwRc+FghJmNIdkFRMv2DwHFAxDnw5yzbec5k9fdxv4nA+d4p0zi59GgUk8JZ1MHbt6ektTKirYRVHHsVGJZZF5ooUmxclZRtbSUWK1vmfWFXHIchVwCsR8ZCHe6Zy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcmKry4S3wFQ5Kgep3q0eNPaJhs+7fFK1Xhw7mVdsFM=;
 b=VAj+R8VAeSu5BFwvbvDPJXchcp0eRh2Nsyyg9L+fLVoUZKDXuPwTWhNbHmxWr1cFAZfG67wJjbZnDGaYOH4BoGcLHhFxVuBAMoGzX3E5Vfculcg5IO29g6Env8ibRz5c5JVg7rQ1koztG5iOBhpvQqkjNpe+/+Hu96D7hy+nrhK/Q/Kp3sZ59oJWKhQpCqidTXZTuPsPKPetazUQchP4iVUZpP1N1Q1vQrZeRTRfgrxLHSFVMSj5QnfMek8Joh8kcl6bgXq6d/RxbZ3rQtfIhMfKYVRSJjF1X07msUjfXpkNgq/Y+JZy0gAcp/Fkc/CUCmqcEOcLx+l7j7wh4btYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcmKry4S3wFQ5Kgep3q0eNPaJhs+7fFK1Xhw7mVdsFM=;
 b=weP0p3G5ovutQTq/JHesCPOOargF8BVROvHgnh1CMKEByMRSULseN5DpKR+n88MkcB+Usw+eHu8omwqW4cQEf49HMXuO9qkvwoMt0slZnewLRHi19qtUhflFmlYHa6SaH0BCU2Fjn1eArUEaoCSpM2j6wKiga38HOIJpErcdVtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 31 May
 2024 15:47:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 15:47:46 +0000
Message-ID: <4758e38d-09af-495c-b10b-d54ed908514f@amd.com>
Date: Fri, 31 May 2024 11:47:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-10-Yunxiang.Li@amd.com>
 <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
 <c848dcc1-0816-4c2b-bc87-8d5918046cd7@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c848dcc1-0816-4c2b-bc87-8d5918046cd7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9b24ab-554a-4d06-c129-08dc81890421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0NUNkcvWnYxRzgvSXBwZjdMd0x0R2NIRTlTWmN6Q1ZOUVBHNWVHMGRCN3Bn?=
 =?utf-8?B?SVIzZC9XZStoUGtZRVVXRGV5YmlwNFpOWU5BeGNBaHBSYUVkMzJCY1lvUUN1?=
 =?utf-8?B?NVpWMTdabmFXTnU2MURZczkyVkhwbkhieEZsb2U1VGhuajF5UzkrV3ZzOStj?=
 =?utf-8?B?MW1ydmlYWUxkVjcvR1BCNTFHcEM4MDNaN05JTGtOMlkrY29YYzdYWWxmUzhV?=
 =?utf-8?B?VkJHZEdpQlYzMFRZT3BzUHNWdk1wcHNRU3V6TEZIWjBOOEI0aHUwbUdyS2VI?=
 =?utf-8?B?ZFlYRDlCdTlEMCtSUWlGb2lTT01CcEpIUFV5U0lFNUZmN3Zzc1k0di91aUhM?=
 =?utf-8?B?OXV2eUFLaUFya21GYS9TNS9xUVpwZGtPVkJyWVlvajNMbUVpWWJVZjYrcG5J?=
 =?utf-8?B?bDhQZ3FEUU5HZjVzano2dEdzdHQram1ZUzZwODg5bFZIQmxqOGtvbGpNTHJE?=
 =?utf-8?B?anZiZ1dsbnc0ZU0zR1VZU2lkRzFVNVdlNXhuTERoMXBKTUo3bUJRamVKWjJq?=
 =?utf-8?B?N1VRWHdTVmhOaGtRWHFVdE5DZy93Y05vRVR1cFhXa3dobENKOGllSmpXQW83?=
 =?utf-8?B?d09qNmx0K1VFcTdwbTJqT09xWkt6R3B3bWlUdkZHRUlLaHMxYkp4VXZMWDN5?=
 =?utf-8?B?ZHhYS3NKMGNqdXN4ck1aQU1FSmhoY3huM05nSHBjd3ZGSE5JdnEzSmtxOWhv?=
 =?utf-8?B?SThRTGFpblM0bi9vd2diS1J0eUlVQWxqT1lYcWswZ2tvd05lY0VEUnR3YlNQ?=
 =?utf-8?B?a2RxcEdjVlhLYmRZM3lNcVZTejN4T2x5Zkc2ZmUvRHBCM2ZGVTVhRE9wUkQx?=
 =?utf-8?B?QjFqTHJhT0NPVTVmYXBzclNuV2x4aStQaHhMZngxUzlMeGRNaTZJY2Iyelp4?=
 =?utf-8?B?V2Rnd09JOVFWeWRWM3gzVWRHUnE0K1FjdXJJQXBYOEpiU2lMMlRPWmY0Y0lz?=
 =?utf-8?B?VTFVY0krbSsxSkdTb28yTDJXbzVjSFl4WldpbFU4OVNMS3Q0RTFHUlhlRFZ0?=
 =?utf-8?B?RzVUajlvQ3d1emMrcVgxM1lnbWluWmZFYW4zYUR6RTgxRVkrRVhYdEN6Tmk4?=
 =?utf-8?B?TlZCcGR4RitldlNleXRpRDZVZ1prdHNaNHFFZ2xiS0p3eGpuS3cwemhqNndo?=
 =?utf-8?B?UFF2bEZTT1llTVJEMXBkSmswbVRZUUFOdmR3S1ZFVDJ1WVhIWHlER2JxNTUv?=
 =?utf-8?B?bmxsM0c1YTdEajRWbWgyRDRNcExRUGVlNHJ2TmZrTUVTT1RZQWFTekowanVV?=
 =?utf-8?B?MHBaWTRzZXlIVVVDUW9CSWx4Z1BZNU1YaTRVRjI0SjdabERGNXN4ekEvbHNU?=
 =?utf-8?B?c1ZwL3VFaHRPZjlJN2NCd1RBTVFLRzJRYWZwei9kNmVFL3VMNml5KzJuZzI2?=
 =?utf-8?B?ZVhJdHpHL0htY3ZxR1hmeGNERWpQb0UwRWxWYmlpdWE2NmdkOEJ5ZXdMU09V?=
 =?utf-8?B?c1dWa0FlRU5mUEl6d1JNcU9IOXJSTkx4YkZhaEZPai9yK0EveC9jK1lCVFFl?=
 =?utf-8?B?US9ZSzlUNWFKMm9ScnNnbnpXaTVmZDYrYmRJZEZiVzBQS0wyMnNpMjc3TFg2?=
 =?utf-8?B?SFBnZmNMM082VHUzMWxidTk0UmE2KzFXUU5WWlJodXVJRUFVbUhEOXE3YUxV?=
 =?utf-8?B?dXBJUS92ZFR5dDFsK09hT3FjTUZUNFJFK3dLa3lsM0lHUEY0U2d1TWJOM2Rq?=
 =?utf-8?B?dlljejEvcDAra3ErRmV6R3RuY0ovSXZxMlhETjRPN0VYTVVKMEwxc3FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkU0aTNhTFBZRUs5RXlkSTd3YnN6eXJFc3phWXFlVS9NZUxNUlhuZVZRUUlv?=
 =?utf-8?B?LzZ5UUF3Mkt5N3AvRkZkYVdiRTJ3RmZQaGN1Uk5RVWRKRElZUExpeTRQcHNT?=
 =?utf-8?B?dW1GTDNBVDMySjhGdE5URDA5ak5wY3paUzRYQk1DaEZhS3U3VUNWWmlEOWhw?=
 =?utf-8?B?VktlOGE2OHdDRXRhZ0NNOVdnNGNQSU5oOU9sdFhTZEwxZE83WXc5UkEyWGpr?=
 =?utf-8?B?Tk8rS3RDYmN6NnlkZGQ0WHVLSDJUcGxFV3d1Q21RZXdESHcwWWtLWFNUZlg2?=
 =?utf-8?B?czY2MjFJUmp6R2R3cUx3SWJZdFUvNm9SQmRTNllNRUVLVEZxeVZGSzlPVk9O?=
 =?utf-8?B?NzJheGRidVFNdFlRSUJFMVpDempJb0pka2VWZUNINGU4Z0pXUndJZGRidG4z?=
 =?utf-8?B?QUlKOHNDWDhVeG16YnBkK3JIeTBoS1RLdXNEK2Roem1vajdZeVJZM0JRMmhj?=
 =?utf-8?B?WWp1ZDlMWDl6KzhpVGplWGVYM3dUcnNsSXI0VUJhbHIwNkc3WFVMUFU2Wm9i?=
 =?utf-8?B?THd5NVZhSzhldE5rZC9DcWtFei8yTnVHNGI1dTU5V2N3V1pGaVE4YXJ0Wnp5?=
 =?utf-8?B?dU5HeGpCcEc1b0h3aUhTcC9Lc0JhT0VwNlE5dHZQSy9qcTRNMkc1MGNkVUU4?=
 =?utf-8?B?ZkNHdnJGYVlUdzM1V1NWTU5LR3lyT2N0RTltZnB0TWVhZ3JUYitoa2YwbG9s?=
 =?utf-8?B?eHVJNE1EVGhrZTVtcVlzcEFqWVFoVmVjTTQ3cVNTMlhpSlRsTXdsMXpsaGlZ?=
 =?utf-8?B?R1NSYm1CbXN1d3dZSjNWTTJKRzBFR1N6bUNmaERkb2dEaHYxOCtYTlJUaEVq?=
 =?utf-8?B?YmRoeHFmdlJ1RTE2eFRpL2RQSHVsMElGR3A0RzNMRVZ1bzdMeGhaL0xWejF6?=
 =?utf-8?B?S1pmeUwvdEpBNW9UaG5uL29GcXhCUHFmRk5YQ3NtQzkyaitKMXFGNVlpdTds?=
 =?utf-8?B?c05zMi9BdW5NK0VnUzNFQk9xa3lqS0lTOStzczFyeDNwVytpaDZuQkVBNkJJ?=
 =?utf-8?B?ZFA0T0ErcXdZTHJiQWJuVWt6RmV5WUlSTDEzUUh3MEZBaUhSYmxvZXJYazhJ?=
 =?utf-8?B?SWdKZ3N0TEhveW1XbjlyeDFVbWhSRVU2TWVnUzRiRmhQd1hMcXhOVDJNek9T?=
 =?utf-8?B?aXRXVVp1eCtXV0duUi9HdlQxZzVJdEhRcCtjVEFxWndTMlBoblJ6ZzlaeGpZ?=
 =?utf-8?B?UVBDWjQvdHlQM29LZW1XSm1VUnpmcTBKSTMydzFKbStPV245M1lRNnJlYVhZ?=
 =?utf-8?B?SjZhRUh5eUVBaVhET3l1anpodTRPMXlzUG1KK0Rzc0tJdVpoRDFPQkczTkNN?=
 =?utf-8?B?WklnbURqWEVrYWQ1Q2dtZDZHV0ZxR0RVeVNJNlVnVHVDd2g5Q1hQRDNUcTNq?=
 =?utf-8?B?YnNXSXdXTVBBMWVXMkdHRFBNTDk1R2pNQkdDWU5rMnB0dk9Vc0YvMjRPK0ty?=
 =?utf-8?B?UytBQ3NpUFE1NitVckN5VTFVWkM5RnQ4NVRXNVJ4bVBQZjFEV1hNT3N4d2I4?=
 =?utf-8?B?b1NqZlczNnlRVjd6TmlGL1VJZWxHUCt5ZFlNeWVIZTNBTUxBZGRRU3hqTGFR?=
 =?utf-8?B?ZFZoWUQ0dmNmTG54V1VLUElpUmZlbWQyTHFmYXBITUUzSmpxMkdPRERNVUxF?=
 =?utf-8?B?M3dmQitUVVZITWJId3BIMWwrcUdlWDJUSlZYd0EyZ3NRME91L3dnamtHM2lZ?=
 =?utf-8?B?SnRxT2JQY3Judko2RzUxRytKWDhsKzVKMU8zWkdEUS94dVFhSDc5K0Q1bHRW?=
 =?utf-8?B?TmMxdDc3cHVhOCtTZlBMRWtmT2RqTjhXOHA0elBBUDEwREtWdXAvd3lwV0pa?=
 =?utf-8?B?dENLL3NOU3Q3aExJckhIUEtRdXVlWXhQOVpVNXdxRHp0alU4eVpFTDhJd3Iy?=
 =?utf-8?B?a3hDQUFvYVBjQzV6YmRLQTF0RFBjZGJCNGtYRDJQMVZUQjlHMTFVdGxpeHJ3?=
 =?utf-8?B?b0xoREVTTFdEWUdOTzNvUUVmb0lMZTU0RXA3c0VnYlZmZmhMeDJkbnFaNVA0?=
 =?utf-8?B?eUcxaytXUXZqSnA3RXo2R1FrTVpsdGwyemF3dHl2K21UK0VoN2hkSXNTV092?=
 =?utf-8?B?aU1rVXNDbWE5eXp5WHFiMlpUQ1Q3ZmVsa3RubGl1eldvVGtqQ2VTVE5idElL?=
 =?utf-8?Q?9X/SxzfJEYPtmxYKcV6f7cz3l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9b24ab-554a-4d06-c129-08dc81890421
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:47:46.5373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O3Kjaf7RNf5O9oN7nPJXR92qFqf26YhgeZ9wibzHs2tRvNRNqLlPG01pZeTqnDt4f7VSSWP4eG4cj68ju+CQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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


On 2024-05-31 2:52, Christian König wrote:
> Am 31.05.24 um 00:02 schrieb Felix Kuehling:
>> On 2024-05-28 13:23, Yunxiang Li wrote:
>>> These functions are missing the lock for reset domain.
>>>
>>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 4 +++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                | 8 ++++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
>>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> index eb172388d99e..ddc5e9972da8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> @@ -34,6 +34,7 @@
>>>   #include <asm/set_memory.h>
>>>   #endif
>>>   #include "amdgpu.h"
>>> +#include "amdgpu_reset.h"
>>>   #include <drm/drm_drv.h>
>>>   #include <drm/ttm/ttm_tt.h>
>>>   @@ -401,13 +402,14 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>>>   {
>>>       int i;
>>>   -    if (!adev->gart.ptr)
>>> +    if (!adev->gart.ptr || !down_read_trylock(&adev->reset_domain->sem))
>>>           return;
>>>         mb();
>>>       amdgpu_device_flush_hdp(adev, NULL);
>>>       for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
>>>           amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>> +    up_read(&adev->reset_domain->sem);
>>>   }
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index e4742b65032d..52a3170d15b7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -307,8 +307,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>>>           dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
>>>               ring->name);
>>>       } else {
>>> -        r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
>>> -                       &fence);
>>> +        r = -ETIME;
>>> +        if (down_read_trylock(&adev->reset_domain->sem)) {
>>> +            r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
>>> +                           job, &fence);
>>> +            up_read(&adev->reset_domain->sem);
>>> +        }
>>>           if (r)
>>>               dev_err(adev->dev,
>>>                   "Error scheduling IBs (%d) in ring(%s)", r,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 86ea610b16f3..21f5a1fb3bf8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -28,6 +28,7 @@
>>>   #include "kfd_priv.h"
>>>   #include "kfd_kernel_queue.h"
>>>   #include "amdgpu_amdkfd.h"
>>> +#include "amdgpu_reset.h"
>>>     static inline struct process_queue_node *get_queue_by_qid(
>>>               struct process_queue_manager *pqm, unsigned int qid)
>>> @@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>>>           return;
>>>         dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
>>> -    if (dev->kfd->shared_resources.enable_mes)
>>> -        amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
>>> +    if (dev->kfd->shared_resources.enable_mes &&
>>> + down_read_trylock(&dev->adev->reset_domain->sem)) {
>>> +        amdgpu_mes_flush_shader_debugger(dev->adev,
>>> +                         pdd->proc_ctx_gpu_addr);
>>> +
>>
>> It's not clear to me what's the requirement for reset domain locking around MES calls. We have a lot more of them in kfd_device_queue_manager.c (mostly calling adev->mes.funcs->... directly). Do they all need to be wrapped individually?
> 
> Whenever you call a MES function (or any other function directly interacting with the rings or the HW registers) you need to make sure that at least the read side of the reset lock is held.

Having to do that for each caller of amdgpu_mes functions seems error prone.

Would it make sense to wrap that inside amdgpu_mes_lock/unlock? Maybe turn it into amdgpu_mes_trylock/unlock and make sure that all the amdgpu_mes functions that take that lock can fail and return an error code. Add an attribute so the compiler can flag callers that ignore the return values. This would make it easier to let the compiler spot places that don't handle errors due to reset lock failures.

Regards,
  Felix

> 
> Regards,
> Christian.
> 
>>
>> Regards,
>>   Felix
>>
>>
>>> up_read(&dev->adev->reset_domain->sem);
>>> +    }
>>>       pdd->already_dequeued = true;
>>>   }
> 
