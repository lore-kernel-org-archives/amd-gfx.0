Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD914C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494D710EE3A;
	Thu, 30 Mar 2023 13:45:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF9310EE3A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQU6Oqs2nE8e4hJdZAo+HeMMS+O7oKwAhiALRLOmj7Gg0tqf2mZQA098Opn10nOWeUgGFFlIJG7tdlrkJdEag+kxvuRR/6jQb2guTzLUs4EUPkIFLB4xRgEyMeEyiFPLDpt/R6dGSIawSOMMMnIX28cGSb9kOlQwnVCLQpXYLbzlWjs7vpFQ0aXz6c1YILY2yxz7jNRFEsGMD0IIi+108ytBE3mRiuY2WP2sSbMV/2Oe9DJFmDZF34pJws73CvIqywtKGT84b/8ao5DnsBRZNzcJDh2DaQVKQaGkKSj32ZLyl0CtBpHDnx8BrJ4UToBhkKq3HxcDKyhsKJyIETMK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZCZ5NO+rMRqalQqBZYQO4cpvykgS397flMSEJDv0OE=;
 b=KI75aI04zLKdz1dh2taEgRMMUXhPU1W+QMPVOIOy0wlvMoQtJ76xYvByImjgs0/TwnE2i9iS8eRwn5PLGHtqRCa39n6ccUJbi5bPbnjTm3m0t+HTkxD0KC9c6bu2QX/3/ndDLK/zT15uJ4ZyS9g8d9h8s9RrSBVJxG/fvZy13pt4gFVF0/zvSXDAguz8Ns78AfGO4/yLMbRhZgsmf7unsTBG40P10sdm80uz5XgJhWJMecPMub9mS7/WyZYjhXFi7AYWvtPaKX3ZSKAhuUNISPqRwAUPh1trIboJ4V+NFk7Sq1Z96u8qi6XqKBYQ8esYrneilWIxUL/jNmz3BFtHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZCZ5NO+rMRqalQqBZYQO4cpvykgS397flMSEJDv0OE=;
 b=euXEa5gojRcGZDBOxBlGoIjE5yRSti12iQrRrDLGrOF+q3MLaoE6bxpqA6/qr781QCa+wxqcxUi+3jt4bfvbduk7i5p3lOWxNVAzs65mhdhAc5DBzzCdFlD99/KvZXmlE1KZxmv1UpSpwUDrX3X2WAN8nWhYX+8ASIucIaIbw88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:45:33 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:45:32 +0000
Message-ID: <274d9875-33dd-d9f4-ffd9-8a0b317af4d3@amd.com>
Date: Thu, 30 Mar 2023 09:45:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
 <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
 <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
 <a6b38b89-c537-165c-d017-d1930c2ba2fa@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <a6b38b89-c537-165c-d017-d1930c2ba2fa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c20ee0-470b-4608-07b1-08db3125085a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AuZlcrmGONVdBfyk2mVall9ULxh1t2Gts3ZiM9YSmq/CordGvtArTekA+Pj49H0LWvo1MvnUCOekzyRWDiNp4BVQRG8F65Zb+Cqh3vMWMoY64CjnxNDtV2FQHvwpvczVJTHiL77ntIjs1s0MAVw5y2Ki/eZwRgiWuvrt9/cJCe8rbf0dDvPXpuuZYUBvxA06WwyfDwfUA8S1LoYWcpTtwC7ZCsqS9pSg3Bzu4uZS63gCzIKhAZpfxapnLKM4G0J3VUSFcRiIgywFM3Z+VY6E0TApGydVehACpFdePfLpJhLXjrzTyFnQG+QfFUnFXgJTPTnL97+1mlbmyL5hFPlrqs/iCKV8bZGaFQcKIqpN5aCKMq6jovP8gc5PcAtH0VQtnz7332YuroK/EDo9SoltBZaKRpOJejucIbZnW1g6jHi5XPFoo+gyesJ2YZH3k3i1alFyCdV+cE8Tb/a2op6to2JOEMg/G34zNV8vy/EjzmdFgIkWsenPmMs87a0h2PscNAPDLRbFzhvaEMB9i8U4NxerlMlIQg3WSZtx5M7QqniR4QvDpooeRALPRvo2U81BS70Ki1YV6lR+SC9/hLIAUM8BYXr5wxX5jhHRhid2gSSAWNRPwmqZthZdQZNpSA0M4UeYZr72vMsKGf4K7XpOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(6666004)(6486002)(53546011)(6512007)(6506007)(26005)(31686004)(110136005)(316002)(478600001)(186003)(66574015)(54906003)(83380400001)(8676002)(66946007)(2616005)(66556008)(41300700001)(4326008)(44832011)(5660300002)(38100700002)(2906002)(8936002)(86362001)(66476007)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNzb285N3pxdVpnSG5VdTl0Skd4WERuTS91Vm81MFJmQ25YLzhTZTVZRG9U?=
 =?utf-8?B?YytKKzBtWUR5ZE9KcDNqRGx1cFlMNVVwb3pNc2dZRERBRURMemlaNkJvdjQx?=
 =?utf-8?B?VlEwTEI1NUx2UU1HQWs2R29jWW1ZZmJBbXFSSTRPTmlKOGJtUFExMUJvQzVD?=
 =?utf-8?B?NVR6TXVlMW5TdmlRc0JhVm9NSDByRERGS1dwOElxTm5HcW5VSWFTYzJWNkhw?=
 =?utf-8?B?cWVUZFRVTzMyVjcrSTZiWm1GdzhWMkVhRVl4YkR2VWoyUzRVWGNrUHdNTUFa?=
 =?utf-8?B?amIyejQ1aVRaRUp0UlBGVklCTlJYNnF3dHpEYlBFeU9wbkdpZ3BGNy9yUGRG?=
 =?utf-8?B?cnNqdDVLbE80enNQMlN2amUyUXk2Q08yNFdqaW1QeGZpTkloWjZmV3RCR3NT?=
 =?utf-8?B?bUtJNzMrS1RTM21LZnNPRHpadHBSN3Z5eklNdTVoVmxYd1EyVEhSQ3hoVzhF?=
 =?utf-8?B?dGVKOGo2NlBvcWN3Z2pTTEo1K2Ewdm5iRktpRXYvQ2NkNXAzV3hvWnpaT0Fk?=
 =?utf-8?B?dXpNa0JoQi92RXFMNWFnR3liTjE0VTJOSGhIcGNjTkZrZk4yeFp2UEhiSnJa?=
 =?utf-8?B?RzFrMUZHWlZQbjg4Ym4zYWdsMzRBQTgvZUlla0JBQnF5ckx5blJScTQrN01r?=
 =?utf-8?B?R1JQMXdXYVorNEVaYUhaR0FValREY3M1VXEyODBBMHFUTDRjeVd5Ykcxb0Vl?=
 =?utf-8?B?R0dtYTAvSkp3UllOSE1OOExpS0pBVFZIN0NvZkJpM3lGNWJERnJNb2pjM3I2?=
 =?utf-8?B?ZWRpQTdhRlpkUnBTVHRpdzczY0J1Y2MvdGYrNWhSRk4rTStYMUQ4TTExTFRa?=
 =?utf-8?B?aFRXMW5Zd2R2UWlQTGowRnJraVlJUU5HYUQ3YVB0S2RGc0hZVDdCbVBmTGZI?=
 =?utf-8?B?NjdrTkVRc0VwSlRqeHFEcXB6eElGZWJtdXNGUkQ4bFBhOHd6K0puTFc2LzFF?=
 =?utf-8?B?amxGd0MzSk5vZjdxTGNEWitkaHpUNFU1MGZKUHdLMDlIVHpGeGxiMmEyN0dN?=
 =?utf-8?B?d2duN0kwbXNvRDJMQld3UzBOWDhXRlBXZGlEbGFnWDV6aitjRytKTFhqQmlQ?=
 =?utf-8?B?ZHlhdHN3QmlvNHFCa1pVbFpjSHVZS05MRTRVRTMyK0RaOWdBclJCZXBKRlRk?=
 =?utf-8?B?VUhaWFBtTlh2d0dvQmxYZFVnelJNZ1Q3NFAzb0d3Sm1sTWUzU2V3eXhKdEIy?=
 =?utf-8?B?cytWSzFma2lmQkZkY0pxSjJYc1JqSmNuOG9sajl2NFNFOVI0Z1IwaVBtekpU?=
 =?utf-8?B?Vk1HaVVzNWg1bmRZekhNR1hna3hQclIybFB6dUY5K0pLZExySWppc1lBRkNz?=
 =?utf-8?B?L0NiMzRJMVZnNjd1SFU2aTVFYjhFc0p4ekJVYlRRV1gySkpndU9zZTkyVG5o?=
 =?utf-8?B?d0VwbitKS290Tmkra1pEZURDMlNWbGk5UXY3UW9UNzhoL28vSTVsSS9GcUdT?=
 =?utf-8?B?Qi9wM0wzVThZeXR0bVZKYzFTbmgzd09GTEJkdGxsODZsdThPQXcvb2szUmRh?=
 =?utf-8?B?bFNOdmxtRXBOSFF3ZHVHUC8rcmVZNXpQWjlMQW42bG9JaHJoT3dMQ1EvcUpo?=
 =?utf-8?B?Y3hpMGgzSU5iRlRIZEVqOEFIcndMY2xuM3lFUGM0WGZjcUtSU3JjQS8xQnRz?=
 =?utf-8?B?OWxBS2Z0Nk0wdld6YVFISWdzQjJBUEpGQVl0UUFNc3JrYmtqWWF3ZVdleW5G?=
 =?utf-8?B?dlFyUnZReWNvQlgwRjB5OXg3M3U4cDJaT1dXNUs1dkJOSjdRa2JVSmxqMXhx?=
 =?utf-8?B?YWFqd0ZONDdEcldxQlZUTkM1MDZnVlVDZktnR3JrWk05ZkdVYVZkbGQwMWJG?=
 =?utf-8?B?UzVDSDN4TWhFSzNZU0E2WjU3UUNnTHQxamJCaEdLRjYwNzdmYUxkVXNSbXdk?=
 =?utf-8?B?TWo5N0UzdnBxYkNhODAweThrc292ZWpaUjdrSktEc1M2UjBQUjVmU3RVeVRN?=
 =?utf-8?B?UDMrdXN6ZlFlWXArcGp4MVVvRXFUejJiMkN5OVRldUdFNVUwb0VrSzFvV0l2?=
 =?utf-8?B?WFAyZGRHc0l2MU9YZm51Mlg4UkRvN09QMWZMV1BDc1ZQZHREcTZBRlFnWWdy?=
 =?utf-8?B?UmN3Tzg1cUVQL25DZlB6cTFaanRlQWdZbWEycUVJdzljdEdSS3dUUmFSbk4w?=
 =?utf-8?Q?xYdAfIK+uWmZUjyTvMiJTmLG0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c20ee0-470b-4608-07b1-08db3125085a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:45:32.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDbZ3+ngBqVNY6hdUm8VESLORFFFsq5RxJlsUX/QqFZFDetYP/v/oOvHeQhyu/n5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

On 2023-03-30 09:43, Shashank Sharma wrote:
> 
> On 30/03/2023 15:33, Luben Tuikov wrote:
>> On 2023-03-30 07:14, Christian König wrote:
>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> This patch adds changes:
>>>> - to accommodate the new GEM domain DOORBELL
>>>> - to accommodate the new TTM PL DOORBELL
>>>>
>>>> in order to manage doorbell pages as GEM object.
>>>>
>>>> V2: Addressed reviwe comments from Christian
>>>>       - drop the doorbell changes for pinning/unpinning
>>>>       - drop the doorbell changes for dma-buf map
>>>>       - drop the doorbell changes for sgt
>>>>       - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>       - add caching type for doorbell
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Generally there are no empty lines in the tag list. Perhaps remove it?
> 
> I would prefer to keep it, to highlight the CC parts.

I've never seen a commit with them separated. Perhaps follow Linux custom?

Regards,
Luben

> 
> - Shashank
> 
>> Regards,
>> Luben
>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>>>>    4 files changed, 28 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 4e684c2afc70..0ec080e240ad 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>>>    		c++;
>>>>    	}
>>>>    
>>>> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>> +		places[c].fpfn = 0;
>>>> +		places[c].lpfn = 0;
>>>> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>> +		places[c].flags = 0;
>>>> +		c++;
>>>> +	}
>>>> +
>>>>    	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>    		places[c].fpfn = 0;
>>>>    		places[c].lpfn = 0;
>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>    		goto fail;
>>>>    	}
>>>>    
>>>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>>>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>>    	return true;
>>>>    
>>>>    fail:
>>>> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>    	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>    		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>    	}
>>>> +
>>> Unrelated newline, probably just a leftover.
>>>
>>> Apart from that the patch is Reviewed-by: Christian König
>>> <christian.koenig@amd.com>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>    }
>>>>    
>>>>    static const char *amdgpu_vram_names[] = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>> index 5c4f93ee0c57..3c988cc406e4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>>>>    		cur->node = block;
>>>>    		break;
>>>>    	case TTM_PL_TT:
>>>> +	case AMDGPU_PL_DOORBELL:
>>>>    		node = to_ttm_range_mgr_node(res)->mm_nodes;
>>>>    		while (start >= node->size << PAGE_SHIFT)
>>>>    			start -= node++->size << PAGE_SHIFT;
>>>> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>>>>    		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>>>>    		break;
>>>>    	case TTM_PL_TT:
>>>> +	case AMDGPU_PL_DOORBELL:
>>>>    		node = cur->node;
>>>>    
>>>>    		cur->node = ++node;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 55e0284b2bdd..6f61491ef3dd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>>>>    	case AMDGPU_PL_GDS:
>>>>    	case AMDGPU_PL_GWS:
>>>>    	case AMDGPU_PL_OA:
>>>> +	case AMDGPU_PL_DOORBELL:
>>>>    		placement->num_placement = 0;
>>>>    		placement->num_busy_placement = 0;
>>>>    		return;
>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>    	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>    	    old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>    	    old_mem->mem_type == AMDGPU_PL_OA ||
>>>> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>    	    new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>    	    new_mem->mem_type == AMDGPU_PL_GWS ||
>>>> -	    new_mem->mem_type == AMDGPU_PL_OA) {
>>>> +	    new_mem->mem_type == AMDGPU_PL_OA ||
>>>> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>    		/* Nothing to save here */
>>>>    		ttm_bo_move_null(bo, new_mem);
>>>>    		goto out;
>>>> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>>>    		mem->bus.offset += adev->gmc.aper_base;
>>>>    		mem->bus.is_iomem = true;
>>>>    		break;
>>>> +	case AMDGPU_PL_DOORBELL:
>>>> +		mem->bus.offset = mem->start << PAGE_SHIFT;
>>>> +		mem->bus.offset += adev->doorbell.base;
>>>> +		mem->bus.is_iomem = true;
>>>> +		mem->bus.caching = ttm_uncached;
>>>> +		break;
>>>>    	default:
>>>>    		return -EINVAL;
>>>>    	}
>>>> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>>>>    
>>>>    	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>>>>    			 &cursor);
>>>> +
>>>> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>>>> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
>>>> +
>>>>    	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>>>>    }
>>>>    
>>>> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>>>>    		flags |= AMDGPU_PTE_VALID;
>>>>    
>>>>    	if (mem && (mem->mem_type == TTM_PL_TT ||
>>>> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>    		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>    		flags |= AMDGPU_PTE_SYSTEM;
>>>>    
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index e2cd5894afc9..761cd6b2b942 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -33,6 +33,7 @@
>>>>    #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>>>>    #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>>>>    #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>>>> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>>>>    
>>>>    #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>>    #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2

