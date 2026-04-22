Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58CAF9EDDB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E59010EA10;
	Wed, 22 Apr 2026 14:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="othX9CGm";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E26010EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 14:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYXJj/CwMb58ePDkXRbzbfx1kpxf7l6ZnLJyMwjY67l6bpDpo3YjagOlyV2SbHY1G0B+IknQlJd+XNGxk14kcNQuWtqS5KZwfdQCMU2BzWzMZkz+taBnMjwTe4n9ufnTXQh7Pg5ZtIEKakcW5pRM82devxXBfzT9N7hzcqbaK2BMnObrt+H/rnPgLZ+u2Q+JD1euW9whh7YO1D0/A1hjFFu/jxuSqWyb/xCwkbZKkVK6y6O0gcr+bmeMZh4XMSzOuLrprkR0iaxiy+7itL+J2Z1J+pU+gngJabJCsPk7usZdaTn2FQk8uKkJRagQlq6Oyxa3S1gcrFyeNoSHAWW5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42NL2COFDEW1sp40whdZ377c4no/2vh0TEQf/hn1g50=;
 b=uCBAm9whgeN7N2oS37kowsZw6Z7yg361jyM5Z26ng4yvl04hBd2K0m3Yt1r6cJMVqme9HC8QqZsiv43ETkSxlVr1FPd+szgKmbrYnlw6Z0A8UNO5fTsB9XU0/aJ1712DAdtglCOkLmRcj/s7kwBIwOE2PqYACDa320BOSwLwb0i0yI60dUyq5daxUhNEcr6SAsR9pYRYB5PegCviuJJHXQI80vdWEBpPO+PHgEz+Q/4OSDHForCJ/NbcXQuCOfu2DDP2QWK4hpWArcX/U5b+lQ+f/siK6oPlhtdxsDXqQ9Y5l5qOZYUTS3kkU55qjdiioRVVXF0PLIQYzW2Tgdwnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42NL2COFDEW1sp40whdZ377c4no/2vh0TEQf/hn1g50=;
 b=othX9CGmqjkxq1975Y+s8uHBZ5JCJUC/+/NVDs4H9xtbFK/30Wi+5mIhmuXxKqELnuWCYwdiSpAUAuC2LiqmoQdeRM5k7KOAYejZFhn4fR+URj6BATStCu41OWJZN+XYM1n865lWHbinI+sH2qy1txFAF2UWUU6AgeRWj6v2Yzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 14:32:39 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 14:32:38 +0000
Message-ID: <6aa57b50-52e0-4a53-bd68-c6fb8d484dce@amd.com>
Date: Wed, 22 Apr 2026 20:02:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu: nuke amdgpu_userq_fence_free
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-3-christian.koenig@amd.com>
 <4a0892be-46b9-4720-9b7e-398aa0a74c87@amd.com>
 <b53997ef-f55c-4813-bca6-2308475db357@amd.com>
 <e3320914-cd30-4ed2-8c92-783a67a5dad3@amd.com>
 <ffed97ca-b8f4-414c-964c-3153df1d87e7@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <ffed97ca-b8f4-414c-964c-3153df1d87e7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1281b685-077c-4b45-7710-08dea07c00ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: sBeGNEz7bdnMHtogeb9g6Sz2eyRHdpQ578Tf0XPa5IF/2E/vOyMVHwpXc89hILxIn7WfzWrL3d2JjXdAO4v5dSyJacK3Rpi6jlhu2V0X865+nmz0Wp0tyg4QdkUz6WDW/p0D3Gl7ejDv/tFYi0OWyomEUdMwEd6lweyPkIjnp27pEIhLdlSuP73jvkWANCozT9U6w0+nNrqKEOVFrsGb5VhcTwhV15AI7CKJR9eLLpBraSXkxIImKdsf7VHfy1gHgUcVhb1sMHwU8y6ayuM8c+GSKb2yWqhIdmv7OBTUdxErDlZZJKxq9nHIv16iySwnD5eMxxhl6LLLO1YDy95U7osRRLBIPv4DPARHh5MFxW7dPg8qaNyXpdSVHPNGhH889couliPQoRPWGiLE5V0qpJC+nDzrNb3+NyTfcN0QPcH83GmSJ67mN6CgZbIV/0AJNmq/AzfGN2eW7iAutHWfn0eYfG/c9SXUu4z72Y4Ga9CAC6Y1wQN5PDFduX85jPV5B+UGL2qiPhZnaC6iXfwveIQyGpLpG1/AQl4N8IQQ5h48THbcTccUtR1Q+kwJhAD/OxJrHUe9pxCULWAb50G269ugzeWc7V7eblSNRQ5l7/PJhDqPW7QnL0R7dosDw5Ym5SDiR8eWv+GfWkMNka1fiDwucDQ5NrhqBm+igSxoq2ss3DDIddwfz4kf2bpmGN8GDBJwGWVvNylGT22E9a6qnNxD0O+Ytjo+CV33zz0wCW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFyUWRNRXlmYUpCd2p5ZGJPK2crcG5UY1lITzZ0MjhkV2U0NWdIdk50bzh3?=
 =?utf-8?B?SEdaYnN0cUVad0RhWi9KaHZYS08wRzRnZ3JaNHpibUg1bFVFNHJWYUtqdUhu?=
 =?utf-8?B?bmRVY2dEV0ZyYjNzaUhiYmJaN1grOGp3NDlWcUc1TFppOFBHaTRCQ3hVMkds?=
 =?utf-8?B?Wm9EN0tlU0NaY2VHbFEwaFRiQ1FXWGtGSTdKck1MKy9IR3Q0WWpUR1JWbUtN?=
 =?utf-8?B?Z3R0dGw4L3VCckNHS2Qrd251QVY5TndWQnIvMXN5ZlJqUGk4d0pEaVpaV21w?=
 =?utf-8?B?K1hzRXJEc1dFM1VMVzFUd1prN2xOWDZzb3kvS3dnRlZsc1pTZE5XK3BaU2ta?=
 =?utf-8?B?aEorc1BsOXU4bkdWRHBtcGhpd0ZOYnp5c3hMWXRpQXNBNkdleVB6YVhKT09C?=
 =?utf-8?B?dFo1NWg1UVlEN1JJdHdtYmFLcjFYcm5XZ2sxUHFoRUFxNGxMZ1Y1aFdvMjhu?=
 =?utf-8?B?TkRMYytBb09PTGNqZGhTb1poVlI2eld4elpmdkh3NDZRNDZmWWY0anByQkcx?=
 =?utf-8?B?V1laOFc0UkhudlJaQzRKRjRxV0cvT25PamNwNVkxcEFzM0g1YUV3SUhIUzFr?=
 =?utf-8?B?aVlHcWJTejlPbWMwM3FGNWV3NXFuWDRNSlJEdmNFMmtLTFhPRjQxc0JsZWRv?=
 =?utf-8?B?L0pXakF0MlNYNkFUVHVaMFNWQm1nSFlWZWFFcVVmS3kwSm5Zcm55MkN3V3dw?=
 =?utf-8?B?dHR3c3FvTm1rY0MwLzA5SFpvMVQ1REd2SGc2eVpVN04wbGFRbTN5VllVRGd0?=
 =?utf-8?B?QVpia3ZmMTFGME5qcllhQ3NCd0JCTXVIQVdNMWlwUGZ5c1VNMUN6NDhSMmlp?=
 =?utf-8?B?RVhTOEJhTmdKdmZLU1A1ZWJKYnJQV3V1eC9PZDgvb1o2MEVNeTdJUnZwS0c5?=
 =?utf-8?B?NlBhdTdTTnFpdWlOVktuVHgvQzJzM3VTeFBCNFRXa0hiMDVUeWltVjcraE12?=
 =?utf-8?B?dFhpOUVqRG9FK0R0UjAyYng0RzRSQ3EyckxCN1l3a0xkSXVmQWdWb1hKMFJP?=
 =?utf-8?B?endzS3VPSGZUNFZZdnBFN1Fic092VVlhMFppdTlFUnlwV0Fob1NNaXZFQm52?=
 =?utf-8?B?MjF5ZjR2d2twc1hYMDZkN2loWHZ3UnNpVktodTFsNmx4QzQrVTJuODUwa2hv?=
 =?utf-8?B?V2lqcXdjYVRnQ1l2cnpZajFTNDV0ZllYbC9kb1Z6czNQcjF3K3EydkVsbGRS?=
 =?utf-8?B?Q2tzczUvY04zejNVcTVYL1orbHJPZllqM1puOW44R0FxZmVsWnBPQXNYUEVY?=
 =?utf-8?B?OTEzWnBMNDFTSWY3Mi9JekRYL1BISWtqSUxZRVJMdm5jOHJ3N3dYcGJwSjBW?=
 =?utf-8?B?SFpBdHk3L3k5ckpYTUxFdkk5T3dnZURTNGYvMWtpYit5NUR0NU1KeFhPQ1Zi?=
 =?utf-8?B?cENQSURDSTdOZ0sxa0d1V0F5Y2NtKzFwM0dSSWpOTzJiWlZUNVhBaUdKU1hT?=
 =?utf-8?B?VGtJQVNNRFU3Njdndm5LRTJFVFhhTXVPdXJxZFVDMjlwb0poVXVZNk03RUFj?=
 =?utf-8?B?cHNBblhSRS8rRDJsMHluY3pXN0RDdHNTWVZwNjU1Vk03LzcrTTcxNysrRFQv?=
 =?utf-8?B?ZUFPSGIxMVZuenJUaVNBdmZYWEVwWXhNWEJpSlVTdmVPK1JpTmRSck9zYWZ5?=
 =?utf-8?B?V2VjYnhLUXQ4dTFpWlJDT3B5dUUrWFBlSlI4cCtRVk5mR0dTakRjOTFpUUt4?=
 =?utf-8?B?WGRwOHhRVG9HMDVjMGF5V3lSNHFON2dheWtIanlLSENLcWFUUG9pb29EeEQ3?=
 =?utf-8?B?V3ZtdnNWRGxGTG83N3FrOXQvbFlReTBYdXpCYXdXdVY2Q25qeFNLTEppek1l?=
 =?utf-8?B?RmdkWm03R3B3bi9pQ1NFSzdObGhSUkJFMGpzZE1JT093cEw2R3pYZUhqWGxP?=
 =?utf-8?B?MTJYSFVtcHB3WTZvdGJEVXJrbkdOLy9PWjUxY0FOb29RTlVLeTUzTlpxN0JG?=
 =?utf-8?B?c3JMa2duSG93SUtZMm9QOGhHU3NJU256Y1VvWHZxQnV1aUxFcEhQYmxvOHNU?=
 =?utf-8?B?Zm9xaHU5SzVVeTNBaFAyRGtlajlabWNZZEJPR0lZdkdMTGVJUVNGcEs3dWFw?=
 =?utf-8?B?NDR3WHNWNlZZdmROZ0JsNFV3Z01ZRmFnREdEOEJhWlYzTy82VGJra0YrYjZS?=
 =?utf-8?B?anQvSU45MDNLUWVoQzMzRklGNHZRakEvZk1ZLzBIbGNPYjVwNVZQT1l5SFls?=
 =?utf-8?B?Y0x3OW96YVg3OXpYM09DM0RqdStNRmIySVc1WndoSzhjSitNUzlEQWdzWnNn?=
 =?utf-8?B?Q2tMQnNXc2Y0cHg2MDhnd2dzWVJxQkpGYmRuSHNndlpWSTczLytjU0lOQW4y?=
 =?utf-8?B?dm9xYVZzY0VXTEhZS0w0Y0thZTlkb3pUVVdwNlR4b3d2bitud21BQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1281b685-077c-4b45-7710-08dea07c00ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:32:38.7743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icvDRhwZNUmBgG4xYgMNhF3XGgZVRo/CgGg9gdgy6qPA7OQUF3quBlzfbCVG8n5gHW2ilnRHGKXGlMzAruNqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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


On 22-04-2026 03:42 pm, Christian König wrote:
> On 4/22/26 11:40, Khatri, Sunil wrote:
>> On 22-04-2026 02:56 pm, Christian König wrote:
>>> On 4/22/26 10:29, Khatri, Sunil wrote:
>>>> On 21-04-2026 06:25 pm, Christian König wrote:
>>>>> As preparation for independent fences remove the function and do all of
>>>>> it's cleanup directly after signaling.
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
>>>>>    3 files changed, 31 insertions(+), 64 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index c6546a858597..1b15b51dc3f4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
>>>>>          r = amdgpu_sync_init();
>>>>>        if (r)
>>>>> -        goto error_sync;
>>>>> -
>>>>> -    r = amdgpu_userq_fence_slab_init();
>>>>> -    if (r)
>>>>> -        goto error_fence;
>>>>> +        return r;
>>>>>          amdgpu_register_atpx_handler();
>>>>>        amdgpu_acpi_detect();
>>>>> @@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
>>>>>          /* let modprobe override vga console setting */
>>>>>        return pci_register_driver(&amdgpu_kms_pci_driver);
>>>>> -
>>>>> -error_fence:
>>>>> -    amdgpu_sync_fini();
>>>>> -
>>>>> -error_sync:
>>>>> -    return r;
>>>>>    }
>>>>>      static void __exit amdgpu_exit(void)
>>>>> @@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
>>>>>        amdgpu_unregister_atpx_handler();
>>>>>        amdgpu_acpi_release();
>>>>>        amdgpu_sync_fini();
>>>>> -    amdgpu_userq_fence_slab_fini();
>>>>>        mmu_notifier_synchronize();
>>>>>        amdgpu_xcp_drv_release();
>>>>>    }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index a58342c2ac44..909bdccc2a92 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -32,29 +32,9 @@
>>>>>    #include "amdgpu.h"
>>>>>    #include "amdgpu_userq_fence.h"
>>>>>    -static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>>>> -static struct kmem_cache *amdgpu_userq_fence_slab;
>>>>> -
>>>>>    #define AMDGPU_USERQ_MAX_HANDLES    (1U << 16)
>>>>>    -int amdgpu_userq_fence_slab_init(void)
>>>>> -{
>>>>> -    amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>>>>> -                            sizeof(struct amdgpu_userq_fence),
>>>>> -                            0,
>>>>> -                            SLAB_HWCACHE_ALIGN,
>>>>> -                            NULL);
>>>> Are we not having benefit enough to continue create a cache here ? If that is fine that LGTM,
>>> Using all those kmem_cache instances was a bad idea to begin with.
>>>
>>> See the idea of a kmem_cache is to reduce the number of CPU cache lines and memory you need for certain number of objects when the object size is not a power of two.
>>>
>>> So for exampe two objects with 96 bytes only take 3 cache lines and 192 bytes instead of 256 bytes and 4 cache lines.
>>>
>>> But that difference is so marginally for most use cases that you absolutely don't need it.
>> Thanks for the explanation. Also if i am not wrong in cases where last no of such objects are often created and deleted kmem_cache helps in reuse and helps with internal fragmentation too.
> Nope that's not correct. See kmalloc() and co also uses kmem_cache underneath, they just round up the size of the allocated object to the next power of two.
>
> As long as you don't give special flags kmem_cache object storages are also shared among users, e.g. when one driver creates a kmem_cache for an 96 byte sized object and another driver does the same they will actually share their allocations which each other.
>
> Regards,
> Christian.
>
>> Regards
>>
>> Sunil Khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>
>>>> Regards
>>>> Sunil
>>>>
>>>>
>>>>
>>>>> -    if (!amdgpu_userq_fence_slab)
>>>>> -        return -ENOMEM;
>>>>> -
>>>>> -    return 0;
>>>>> -}
>>>>> -
>>>>> -void amdgpu_userq_fence_slab_fini(void)
>>>>> -{
>>>>> -    rcu_barrier();
>>>>> -    kmem_cache_destroy(amdgpu_userq_fence_slab);
>>>>> -}
>>>>> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>>>>      static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
>>>>>    {
>>>>> @@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>>>>>    }
>>>>>      static void
>>>>> -amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
>>>>> +amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
>>>>>    {
>>>>>        unsigned long i;
>>>>> +
>>>>>        for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>>>>            amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>>>>        userq_fence->fence_drv_array_count = 0;
>>>>> +    kfree(userq_fence->fence_drv_array);
>>>>> +    userq_fence->fence_drv_array = NULL;
>>>>> +
>>>>> +    amdgpu_userq_fence_driver_put(userq_fence->fence_drv);
>>>>> +    userq_fence->fence_drv = NULL;

Setting this to NULL is hitting a NULL dereference in, so either we add 
a NULL check in the amdgpu_userq_fence_driver_process or lets not set 
the NULL.

Regards
Sunil Khatri

>>>>>    }
>>>>>      void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>>>>> @@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>>>>>            fence = &userq_fence->base;
>>>>>            list_del_init(&userq_fence->link);
>>>>>            dma_fence_signal(fence);
>>>>> -        /* Drop fence_drv_array outside fence_list_lock
>>>>> +        /*
>>>>> +         * Drop fence_drv_array outside fence_list_lock
>>>>>             * to avoid the recursion lock.
>>>>>             */
>>>>> -        amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>>>> +        amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>>>>            dma_fence_put(fence);
>>>>>        }
>>>>>    @@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>>>>      static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>>>>>    {
>>>>> -    *userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
>>>>> +    *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>>>>>        return *userq_fence ? 0 : -ENOMEM;
>>>>>    }
>>>>>    @@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>>>>        spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>>>>          if (signaled)
>>>>> -        amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>>>> +        amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>>>>>          *f = fence;
>>>>>    @@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>>>>>        return false;
>>>>>    }
>>>>>    -static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>>>>> -{
>>>>> -    struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
>>>>> -    struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
>>>>> -    struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
>>>>> -
>>>>> -    /* Release the fence driver reference */
>>>>> -    amdgpu_userq_fence_driver_put(fence_drv);
>>>>> -
>>>>> -    kvfree(userq_fence->fence_drv_array);
>>>>> -    kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>>> -}
>>>>> -
>>>>> -static void amdgpu_userq_fence_release(struct dma_fence *f)
>>>>> -{
>>>>> -    call_rcu(&f->rcu, amdgpu_userq_fence_free);
>>>>> -}
>>>>> -
>>>>>    static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>>>>        .get_driver_name = amdgpu_userq_fence_get_driver_name,
>>>>>        .get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>>>>>        .signaled = amdgpu_userq_fence_signaled,
>>>>> -    .release = amdgpu_userq_fence_release,
>>>>>    };
>>>>>      /**
>>>>> @@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>>        r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>>>>        if (r) {
>>>>>            mutex_unlock(&userq_mgr->userq_mutex);
>>>>> -        kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>>> +        kfree(userq_fence);
>>>>>            goto put_gobj_write;
>>>>>        }
>>>>>    @@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>        for (i = 0, cnt = 0; i < num_fences; i++) {
>>>>>            struct amdgpu_userq_fence_driver *fence_drv;
>>>>>            struct amdgpu_userq_fence *userq_fence;
>>>>> +        unsigned long flags;
>>>>>            u32 index;
>>>>>              userq_fence = to_amdgpu_userq_fence(fences[i]);
>>>>> @@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>                continue;
>>>>>            }
>>>>>    +        spin_lock_irqsave(userq_fence->base.lock, flags);
>>>>> +        if (dma_fence_is_signaled_locked(&userq_fence->base)) {
>>>>> +            /*
>>>>> +             * It is possible that fence is already signaled and the
>>>>> +             * fence_drv now NULL, just skip over such fences.
>>>>> +            */
>>>>> +            spin_unlock_irqrestore(userq_fence->base.lock, flags);
>>>>> +            continue;
>>>>> +        }
>>>>>            fence_drv = userq_fence->fence_drv;
>>>>> +        amdgpu_userq_fence_driver_get(fence_drv);
>>>>> +        spin_unlock_irqrestore(userq_fence->base.lock, flags);
>>>>> +
>>>>>            /*
>>>>>             * We need to make sure the user queue release their reference
>>>>>             * to the fence drivers at some point before queue destruction.
>>>>> @@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>             */
>>>>>            r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>>>>                     xa_limit_32b, GFP_KERNEL);
>>>>> -        if (r)
>>>>> +        if (r) {
>>>>> +            amdgpu_userq_fence_driver_put(fence_drv);
>>>>>                goto put_waitq;
>>>>> -
>>>>> -        amdgpu_userq_fence_driver_get(fence_drv);
>>>>> +        }
>>>>>              /* Store drm syncobj's gpu va address and value */
>>>>>            fence_info[cnt].va = fence_drv->va;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>>> index d56246ad8c26..d355a0eecc07 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>>> @@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
>>>>>        char timeline_name[TASK_COMM_LEN];
>>>>>    };
>>>>>    -int amdgpu_userq_fence_slab_init(void);
>>>>> -void amdgpu_userq_fence_slab_fini(void);
>>>>> -
>>>>>    void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>>>>>    void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>>>>>    int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
