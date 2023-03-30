Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE17C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BF610EE3C;
	Thu, 30 Mar 2023 13:43:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5264D10EE4A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrUZfZPA8feIjaRAwSrag4lpugjOoo6j2Iz12GxLSiwOAffCpYwTJyrk+qBqdJq1KlxAoVrHbebT3N9B3FQPkjTetMw0lXEgQUBxYPxKtjQRMmFPKzqlt5teWE124zEl1qE71QpNeL52/atEdqRGKCmtTv0ZFqUDBKkEVo9nISMZ0JO21ypK1oKzIGwG3SRXeZbYbIdsasPXX5Jlrk62iIcib6lS1zilVep9S8sCmoSyFkTqYXf7QkVbbHJXRyPiLv2oV5gmZ1FVRpnrdcm9MkNty9iJXBuue7gFlYDQYTAt/DI3O7LIX6lTlcoNsV5mvn3C8xwtP3TaNURV6O4eRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF5HlzNZopr0fHbnQYFleSGtO/xixGFnF091A0Ow2C0=;
 b=RZKyTC8n9lbe7eZZRb4WOhUDevQifHytAP+0+ZKzqajMyUlAVMZPX7+OrldIxeyNKonMB5ZsqtB/Dsan3hti27rvHv6Iv8Tg4+ML6Lv7w3A9GZLjISGpblCjkDY83KLjXFzjPbM2y8SYiv2NkXE7UOKXOv9dSAa+9ZnackbGzIm55wGHZiS1je1kCIEn6ZHQN4bW7Ss4NbHDdOdv4DhBou296LXMPkbOpDQ/+vI0KKgrKaQbI6hX25hJ5OEaj+p0GdeEVeBVsF7LCQPXN9s1UnolaFiAjsu14RNeuH6CNefstggQOsHn+zLUv8T3HooNXcgIEDwTcgCBV4jlO9stMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF5HlzNZopr0fHbnQYFleSGtO/xixGFnF091A0Ow2C0=;
 b=XE4i1embYeH0mvukKAZN0hErz6I35gNcfGRB/8k7ia6aTFDoPfA2U5hQ2h0V62mZBjkobSzdX3zlMD+op8kCxzx+lHV/sEU2s/zSw80djNiWVI6nwTSuyt/wNelmNXtV9eahJRIi6bjbG6TCYGv9q8NKUFCcECDHo+JQfXYv0vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 13:43:34 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 13:43:34 +0000
Message-ID: <a6b38b89-c537-165c-d017-d1930c2ba2fa@amd.com>
Date: Thu, 30 Mar 2023 15:43:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
 <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
 <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: ba06ae87-3748-4571-378c-08db3124c1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yl6teJ5//LXW5EPklY7yIp86eVX0y/ZVZYTgIFzPngw7IR7qFfW6jlg+liItLxB4TvOsxO4wUCTH7kK5rJEh50GiARV0XSEDKJS/jb19FuSf2F9sEq1rmCZ+J8bbvLft3Pn4jCDrb1jjGLR7SVRvLa2qMRsKayKXOllsyGebp4Ird3zuld0Q/uc5UBdwqPVraEX1z89KdZnfO3RPoH7b9dTuxYI90KYKs5n+E2KYzDMUvTiXsAx4RaOqcVWB+Z23TyPHoeTzerh4y61s/z3rVU8KtUk8q6M4Mm6VyW1RYeEEX3tfy7K20JTNQYuAAD/MLtI0PpWxdTse8UvDvtRsH7IFNw9BKTim4a1N52RgdURk1Xp2sRqRfUCthn81ei/01wFZJQdPKA00g0jvzgzwtEVW/2pAYbLxYggGaZ3ibOCLnT9w8UmgoYFUifFxQYHs5tq2kV3ActJ4VVMu8LJCSxQF6HJu03+zEsmbmup184vWR/PdDribOy7WTDrovRzT8idG0zUcuvSDSZrISw3jGgbWo0FJmyoczNLk7EJ8n3OWRZBRbh+zMVYQkCwV29oxFfIxVZvEg7S90WfWNtPQIL0lti5uUnZYgfRDW6FScpQ7vIziG1DQKNq2qPFzigg31ZrQHIaIRN0w3balsGqPLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(31686004)(44832011)(2906002)(41300700001)(36756003)(8936002)(316002)(4326008)(54906003)(110136005)(86362001)(478600001)(8676002)(6486002)(66476007)(66556008)(5660300002)(31696002)(66946007)(38100700002)(6666004)(83380400001)(53546011)(66574015)(6512007)(26005)(2616005)(186003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzB5YUFQL3RUbWJuTVlIWU11VkxFNXhGVE5nUSs4NzhtMThKdWFJQzVoZmlQ?=
 =?utf-8?B?WkszVzNIR1pGWkdoaGNlZDJzV1lTWThON0YwcXBna3N2SVNlT0oxdnhlTkwx?=
 =?utf-8?B?WEdSY1ZmUUpRZ2dUVXlUTll4dWxJTkpLQzZGbWNWWTVHSDlZZUNySTZnbEpn?=
 =?utf-8?B?Z0ZhTzR3c1I1dHdMTStKQWUzdjVadGpZSlU0WUtUeDFFOHova0hYUEYzbHhi?=
 =?utf-8?B?bjM2OTNsbnAxejdoMTV1VFplZHduWm1yUldTYTdLZGNzeURnUzkwUDgxUGpD?=
 =?utf-8?B?dndJMmU4SWFDZTdCcGRoYjEwRXppOGoyVFl5VUl3R2ZmbGNMTXJCSkVuTTRJ?=
 =?utf-8?B?cWF2dVl3cmxWTUhHYkVXZHViZHlQOHlpdnUzSko5bTV4anFDdDVJdVVvdHow?=
 =?utf-8?B?Q0dxQ3dhd0FvQnZwdzJMMDJMQ3VWaERqMkpZc0RQaExKVEVzTElWQUkzZGZT?=
 =?utf-8?B?RlZWcmFjMW9vd1doVEg1aEJ4SVJNOUxzSSs5Vk5UK3NkUU5zY0E2V0lQcm9E?=
 =?utf-8?B?TjQ2UWprRno2YUtrYW5UYTNlS3N6WUxmZWhIUFJYQ0l5WXJ5dEZhK1BkczVq?=
 =?utf-8?B?anliTVU0OGJkOUJ2aHBvL2ZQS2wzSDBydmthYStGQk1YYm1jWFlIMEw3aDJN?=
 =?utf-8?B?M1VuSEUwRjZhb1JaSWdsdFVCQXZHWkdaWG9IaUYxUW1BdXcxVWZrY3VUOUJG?=
 =?utf-8?B?OUl5SU5mZ1Fhb1I4Q1NIZE5UTGpESHliTjVOeXdEQTRKWis1RHU4VXRXcG5x?=
 =?utf-8?B?aEF3dzhibG43OHV2bkJ4TlV2K2RpeWJnRUpLeDY5Z0Y5K2Qzd0RERFd0Qmlx?=
 =?utf-8?B?ZjBpdWtOMEd1VXlwZXZ6TTBCbVV0ZnJ1QmhEaHd0dHAySnRSSW9WL3lXSjRw?=
 =?utf-8?B?SGlrU215dGNXeU1zT3JDMDNmU21IbW1UdG12MUVCOVhTNlphYmZZZmRTWnBE?=
 =?utf-8?B?cHBZM1JkRWZVTGJQejFWVkFwUHl2alZDL2t5S2pVbEFCT0dYSWRVN0xvOWJP?=
 =?utf-8?B?dXN2TE5PMTVvVFJTYWU1R2JjZ3htQitiM0FHNnNaSWNvc1dCa055M3VHUWV3?=
 =?utf-8?B?RDdEdGVrQmlkUVVpTGhVK2FNVDFsVzVjQWxzQkxsdW0vNGpZM2paTHRnRFlr?=
 =?utf-8?B?NUJIQ0Zza01GR1ErMDZzdDZTblEyN1pKUzZRNXJPV25qRnBPYTFqTC9YcDly?=
 =?utf-8?B?YkNaT2FFUHNYcDJoTkZvYUE3c1l4bWtxY3YrZk9WNXV5SFJQdzBlMEdITnlU?=
 =?utf-8?B?TUlnQVBzbkV0bnhlUGc2bEdNamxLOFlRYW1udjU3WDcxTFpEamtvMFM2UGRY?=
 =?utf-8?B?eFpVNGprMS9UQXAzdTc4Q2tkaEJ5T1QyMjRHbXp5bmJhemtFUytnK0RXbGRJ?=
 =?utf-8?B?Mkt1SURXUlhOOTVwK3BDNkkyL2VBZ2xMbUZ5d2sxeDBIeDBQNlBra1hFcTYx?=
 =?utf-8?B?YU1zUUVPbHdFZWU1eWRBQ0RpdE00djZ5M0ZRd3Bac2xvTE8xZlBmenRVbWtB?=
 =?utf-8?B?MDlkZ0VZN2orVHNWWVF1L0d3enFkcVk4enFGMkY5SWVFSEpGajVDUWk1Nnh4?=
 =?utf-8?B?MzZmeWgySEt3TFA2QXFVdXYwMm1CS0xXMzIwQkJuV2pBZnhRVVJQYStVSG40?=
 =?utf-8?B?R3k4cW5yTG5aQ09rWlhJbWNIQnFjeVdmRjhCMFhSZGxjYjN1bzJGNy8weC9z?=
 =?utf-8?B?OTNCeTNuVGdCWGtjQ0lRSkJsekJtY2Z1VFBHMHovcVFYU2R1YkF2enZBQy8x?=
 =?utf-8?B?eVlieCs0VmdIOW5UZURNcW9vUU02WGlwMzRKMWpJTUdEM3QxRlR5ajk5aytS?=
 =?utf-8?B?ZXlQeWY5YUZEdGhKcXR4YWFtK1N2SDg5SWNQZ01td1dIcVpqdXBOekdGWExD?=
 =?utf-8?B?UmFBYm5USjNqMFpwMExHNHRVTzNzaVEwTTdGNXhZSmFvMG9Uam0xMEsydTlx?=
 =?utf-8?B?bFQ1QmJseVM3TVU2MlNBdi92WSthMU9zeWc5WTdkQ0ZSR0NlaG8zN095bnJv?=
 =?utf-8?B?dmNGOTM0SzIwZHIxSlU2alAzVVNwb0xxdmNFL0hLak1XWjd0S2NsUXpNSCtj?=
 =?utf-8?B?cVR4dWdQQ0RyY3dSV2xDbmZwcnVnMERMWjJPa2F5U2lRSXA5clJBSno2ZWhm?=
 =?utf-8?Q?6N7QSOwNTsnqDAXV5K9fIFpHC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba06ae87-3748-4571-378c-08db3124c1c2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:43:34.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTcDmlY2NOrkZW94q1A9RcTfOgSKWe8v/AD4ock0CNWo7Mj3syPzSUj7VK9R8duoabLmyd/vDJ2gbVmN7xCmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 15:33, Luben Tuikov wrote:
> On 2023-03-30 07:14, Christian König wrote:
>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> This patch adds changes:
>>> - to accommodate the new GEM domain DOORBELL
>>> - to accommodate the new TTM PL DOORBELL
>>>
>>> in order to manage doorbell pages as GEM object.
>>>
>>> V2: Addressed reviwe comments from Christian
>>>       - drop the doorbell changes for pinning/unpinning
>>>       - drop the doorbell changes for dma-buf map
>>>       - drop the doorbell changes for sgt
>>>       - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>       - add caching type for doorbell
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Generally there are no empty lines in the tag list. Perhaps remove it?

I would prefer to keep it, to highlight the CC parts.

- Shashank

> Regards,
> Luben
>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>>>    4 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 4e684c2afc70..0ec080e240ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>>    		c++;
>>>    	}
>>>    
>>> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>> +		places[c].fpfn = 0;
>>> +		places[c].lpfn = 0;
>>> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
>>> +		places[c].flags = 0;
>>> +		c++;
>>> +	}
>>> +
>>>    	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>    		places[c].fpfn = 0;
>>>    		places[c].lpfn = 0;
>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>    		goto fail;
>>>    	}
>>>    
>>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>    	return true;
>>>    
>>>    fail:
>>> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>    	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>    		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>    	}
>>> +
>> Unrelated newline, probably just a leftover.
>>
>> Apart from that the patch is Reviewed-by: Christian König
>> <christian.koenig@amd.com>
>>
>> Regards,
>> Christian.
>>
>>>    }
>>>    
>>>    static const char *amdgpu_vram_names[] = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>> index 5c4f93ee0c57..3c988cc406e4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>>>    		cur->node = block;
>>>    		break;
>>>    	case TTM_PL_TT:
>>> +	case AMDGPU_PL_DOORBELL:
>>>    		node = to_ttm_range_mgr_node(res)->mm_nodes;
>>>    		while (start >= node->size << PAGE_SHIFT)
>>>    			start -= node++->size << PAGE_SHIFT;
>>> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>>>    		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>>>    		break;
>>>    	case TTM_PL_TT:
>>> +	case AMDGPU_PL_DOORBELL:
>>>    		node = cur->node;
>>>    
>>>    		cur->node = ++node;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 55e0284b2bdd..6f61491ef3dd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>>>    	case AMDGPU_PL_GDS:
>>>    	case AMDGPU_PL_GWS:
>>>    	case AMDGPU_PL_OA:
>>> +	case AMDGPU_PL_DOORBELL:
>>>    		placement->num_placement = 0;
>>>    		placement->num_busy_placement = 0;
>>>    		return;
>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>    	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>    	    old_mem->mem_type == AMDGPU_PL_GWS ||
>>>    	    old_mem->mem_type == AMDGPU_PL_OA ||
>>> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>    	    new_mem->mem_type == AMDGPU_PL_GDS ||
>>>    	    new_mem->mem_type == AMDGPU_PL_GWS ||
>>> -	    new_mem->mem_type == AMDGPU_PL_OA) {
>>> +	    new_mem->mem_type == AMDGPU_PL_OA ||
>>> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>    		/* Nothing to save here */
>>>    		ttm_bo_move_null(bo, new_mem);
>>>    		goto out;
>>> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>>    		mem->bus.offset += adev->gmc.aper_base;
>>>    		mem->bus.is_iomem = true;
>>>    		break;
>>> +	case AMDGPU_PL_DOORBELL:
>>> +		mem->bus.offset = mem->start << PAGE_SHIFT;
>>> +		mem->bus.offset += adev->doorbell.base;
>>> +		mem->bus.is_iomem = true;
>>> +		mem->bus.caching = ttm_uncached;
>>> +		break;
>>>    	default:
>>>    		return -EINVAL;
>>>    	}
>>> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>>>    
>>>    	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>>>    			 &cursor);
>>> +
>>> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>>> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
>>> +
>>>    	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>>>    }
>>>    
>>> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>>>    		flags |= AMDGPU_PTE_VALID;
>>>    
>>>    	if (mem && (mem->mem_type == TTM_PL_TT ||
>>> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>    		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>    		flags |= AMDGPU_PTE_SYSTEM;
>>>    
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index e2cd5894afc9..761cd6b2b942 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -33,6 +33,7 @@
>>>    #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>>>    #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>>>    #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>>> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>>>    
>>>    #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>    #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
