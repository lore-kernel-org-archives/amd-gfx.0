Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA2EECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Oct 2022 20:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C8B10E1EB;
	Fri, 28 Oct 2022 20:18:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320D610E8CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 20:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8Pq6M1YK/ztMytti4TKVTZyFU0yJgJ5peOiBVTZRenM8cXVLROANlNnglZEU8/jHbWZwBhz/DJmjJTyByFxX+hHuux8N//3ZCq7PMkzYmJaxxTgNYP2cMyr6oSFUFNB8RWOdA+5yLargWEkFdv7L3CWwnUlmt4ZjCvIiA62ltaWJir5jVq/49otkYo96Xj1Z/FmvE51deHP1uvZt6EPjztc70z+OXvdU4yMI1AD+Hrkn47euhpzDvRWURcTnngRrGDSX8kzUzpqYQV1zcxpOcZD6xPilBZSSZqnblXIoSU2gRqkQCIJQGlpuEQX/ZIoisJbaXEmzDTp1JPBlMxjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li73hoaxffc6IsC0mp4frwHHMYzzK2m1YoXYOQClyGY=;
 b=YbNcq5eMymh7rDZl58NielZFnMggDQYGCxRU52LWL3CSPUTANOLpz+WTt4n22Y1UFkmcK0+as8uf9gtxR64+hT5ZQJ1dIY8aC9/4yJpz8mdA0O7MVCi5NKAOORy9gdiJOAZO9dXSpIkV+HyePBpI3DJTiDSgFXI3m3KmKImG6uEjLBYE7ei8bWzqzfSfHXESUJz5BPO6439wxy9irse25kZsaJGD0cd5A1+sUrJ0k+XeqHRCyyWbBMO2Vo4gJTGBn99qoOGC2bRCHOEma47lpLJFVs8aqahONjrwHi5HP2Co63MtHU78/beC6Y+DB7NbefFDc0fTpFwxqjlGchPUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li73hoaxffc6IsC0mp4frwHHMYzzK2m1YoXYOQClyGY=;
 b=39n0iNv8dFo+hf9TD3B7AO0CDoR9DcH3ZrZn+muZcqLWm5x38Ou36ieQXxuMwGTqemRigFGm7BO2A0W7KipZxES3CK+Rwf3O8Bg84X60bo93ZDbxKCaae5kka6GGHL8KSkYfiowN1WmAqgWp9qy3ns+wmCaRebhIO9fcuTdHB78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 20:18:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 20:18:31 +0000
Message-ID: <e2cab3cd-75b6-6560-7590-e695b4fc10a9@amd.com>
Date: Fri, 28 Oct 2022 16:18:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdkfd: Remove unused variable
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20221027081402.320626-1-Jun.Ma2@amd.com>
 <20221027081402.320626-2-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221027081402.320626-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dee89a0-82f6-4f41-9066-08dab92194e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: junnc+g5SFLEBpzK58f+ZnPzVy+jJamxS0tAJYcrtNtC5g357bTwJx2skYj0wCYeZN1Br0VQzBsCFLqIUE8FJYu7h0PRd6wmRC2TEVl3krEuqktLPZq8JOghrzdUvcKc+N7DRMNEd69fd17+mkwuwgstCf8H+zGKZirS+C7irXb0voUGiBN5rF5I1dSPanrxEdjQsoFtHPSdhMo/qzsXVoeupk985wW4Tzrg3IE+sLFVkWkFZgWnI2KV7ICFxWjIzU6k0CHT66zlAjbV6QRm6d2HfE4tCK8SmpctYFyi2kJk74nK4tvGjG9sjBzhvGjKeiwwHUioyCQzzJwZEUrWnjN9Bv2KX9viAwcWayYRv6uEDV+o+kRTUEcgrJv/eoF7Iz/AFkZbhuRL5xOwVTf25uzT1q3F8uJfj7TnNJ3WTpLKAwxwEmPis16R6GXkS6srLoIqnFje7K1O7TvJmDyEhlsE7re8QXVa5w1Npjw/GEoea2wJwlchs6I30uaHA9UNNcwNVVJOLMmGAEtErurHB0MYNwQQ+tLrlXcqNon/2g4/v2+H5K/fXCR+xfMTwPpZYgcRd+b6G6Of/V5P8DdhBJywzj9ddVgo98XndjjHBtUfFueUwgn7HK/QY6eVBrJKsgd6uO7rY96zLouAUFoeF9ErDQ3N5YqVMPELqaCg4aBhVv4+ZTNqL9Af1QG5BL7QLiszEwNXIaaayOKCRBvvstJJgnmpjwm4E/y8gEKRz10XPSHIFxM2abksflBNYSqFp21SfJf9QijkeCYj7ARJ7C2XesO/WNOJP9ctIbRzMPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(6636002)(6486002)(478600001)(6506007)(83380400001)(8936002)(2616005)(186003)(26005)(41300700001)(31696002)(44832011)(5660300002)(36756003)(86362001)(6512007)(4001150100001)(316002)(2906002)(53546011)(36916002)(38100700002)(31686004)(4326008)(66946007)(8676002)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFjcnFxeFpEZ1FLQlNqc1pDaDB5WUIxd0RZSXhtSVd5MjZQZFlvSjE1VFIw?=
 =?utf-8?B?S2lPd2ZUTEZVdThSU2Jrekc2dHN0RWNmczEyRlBMbDhjSTJ6czkxaVBJUzRa?=
 =?utf-8?B?YU1odUtaVUdnZTZRelNydkJSVjVmbkZVSVF6V1RJU1MwcjhYY3F3Ny9TN2xW?=
 =?utf-8?B?L2w5ZWxSZW8zZktodXFaVnRvZDVXQTZJS3pubHBrYWpEb2JmaHVldVVyTXdM?=
 =?utf-8?B?T1lqLy9WazRXdmhPNFhHQlhoQ1NJZUlJeE1FYXVwSEN5aDl3eVdPNWFqT1la?=
 =?utf-8?B?akkzb0N4SlZscUIvY2hyd3Z6L2hFbC9XTm1yRFdRZ0pKV2Z6dm92bWJieFBX?=
 =?utf-8?B?WDdEL0hkbFprWHVpZlp2ZW5IanY5VnlVRmduOFpENVkxK0drQzBxS1ZzcDhp?=
 =?utf-8?B?S0xtL0FYczNWT0NnRTZCS0tPc3A4cHJXMlZraVRLZTg4ZnZmOTJpUEtmeFFQ?=
 =?utf-8?B?NDNtWWZwSi8zeTdObHNnaEN2bVordmZSb2JSa29uZmZDOTNndHB4cG5vbytU?=
 =?utf-8?B?R3ZCS0I4YkFTNHBmZ0FDUGlYL2RWMlRUT0FJUkZzMHNGQjJnSWpsRDRkclBl?=
 =?utf-8?B?eTdRWUwzK0tCdTBCbHlHclA1YWp1Q1VWcVpROUJzaW5rS3hMSEp4d0ludlp5?=
 =?utf-8?B?N3oyYmhaZjVDT3YzRVZuZGxPTU9yLzlzSzYybTlIS2hscHpHdnV2R2hJd2xI?=
 =?utf-8?B?dE56bVYzei9nQVl0RitkUUZmbWJzWjF6OWtwTy9Jb2wvanZPanQ0eXFkZG4w?=
 =?utf-8?B?Q3NGWFdTY2lGcjhZblBzeEs1WEZIeldEM2dHcUpGcTBQZmZVTUZoN1pNNTRn?=
 =?utf-8?B?VkFsLzdWTXdrT0dGdnhtMVR0YWp1WUUrZzZXUGd6RVh4ZDBYanJwZFFqdERT?=
 =?utf-8?B?RHRSKzRualArUHZ1MHZrSWE2VDZJbmlUcmJpZjArTUFmTGM1elZ0WXdxVjJB?=
 =?utf-8?B?R0xKUk1SbFhteWdMdnpsSGVkOGk3WkF4TXBwMFkweXdZSEhMaFFzQ1NLMy8y?=
 =?utf-8?B?dTZscWp2cVhtU0xXeTArdk9OSENBdGVYLy9qaVk3UmcrbDlibXN6MjJKbFRF?=
 =?utf-8?B?TWRIOUpDSk00Tm9Pbys3amdMZjdRd0owQVF6SUYyU29pTmoxclVCY0hqQ01z?=
 =?utf-8?B?eEpoTTE0aW1WTjZsRFlXM3YrTW9aREFHK085S2srcnBFSHQ3MzRaV2VtRGNi?=
 =?utf-8?B?b0VBdjQ1OGtkVFRULzdkeFNvejBhS2V1djZBTDhOTWNDejRyL1JEanNxSkdF?=
 =?utf-8?B?R2EyWjJqVTVPdXNxQkhaRnBiNHRhWkkxMnhxQ1hxams4Y09pbTZVWS9IVzA0?=
 =?utf-8?B?TTI5azV5SG1jd2hQUWdXMjJhRGppY0l6WWRXLzcyamdocjQySmJDSGxhV0N6?=
 =?utf-8?B?ckQxZHRUMThvbWFZckJrbUkrQW9kMnFBTVo4c09iQ3UzaXVvYTJUUkJOTWtW?=
 =?utf-8?B?bFBTY09pQ0RlMmtNY01pLy9BTitrUjhsMjBZbUlUazl1NW9CUWlXYzhtTUJr?=
 =?utf-8?B?QTFlV3JYVU1QYVVwb2gwcGVVNGhrcFlxRUlNQ1dad2JBeGNEb2k3VXAvdkdi?=
 =?utf-8?B?dmI1aks2cVpFL2hKNHZuL2RuSS9tR3JUUURnT3hvNmg5WkJoMUNta1FwRXBj?=
 =?utf-8?B?cktmS2dpd2JLbGZzaVMyT245ZU91SjhrVi81bDdScTRpR2xsWGp6TFlhbklK?=
 =?utf-8?B?cnJCTGJTWDhRVm5jbmg3M0d1c0EwWE1sbEVSUjRjVFA3TldJQWxqb21SZEpi?=
 =?utf-8?B?VU9pYTRwTTlsK0pCS1ovbE5NQStwb1pxcFRHVVY4c2lCbzl2WXJveDNKTkNL?=
 =?utf-8?B?OUw5UmdVa3BPbVpJSTUvai9xYkFDSWdHK2dHZXdjKzl0TXpqSnhDdExwNVBO?=
 =?utf-8?B?K1lvd3B4cm5tNGVObXQ0aEVJWE14SXpEMmJPYWZuT2xsdlJvK3J6bzB0eTFH?=
 =?utf-8?B?b2daZGVmVnF6NWk3dVY3V056cjF5U3h3MGVueGJTVURLN0ZpcC9Nb1VIeGpX?=
 =?utf-8?B?ODVXcXlTQ0lMRzdxZFJwWWsvSE9UQjZXMHFmb003d2hGNFUyUndpNmZDMlhS?=
 =?utf-8?B?aDJwQWFTZlhibUw3aXp4WnU3bUJmVzlUc2paN2JnNmg0M3FXS2xHazQ0RGFr?=
 =?utf-8?Q?uYmR7I+topg0nUqJiOU5ucZnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dee89a0-82f6-4f41-9066-08dab92194e8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:18:31.0768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miXVpdrUdilVouhJub778eXjyqYc/CpGV0PnbJUx4bKBA/yit6VHQWAZ94Vy2UjFUXJBRl2rQdyeGSEjIjrI+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-10-27 04:14, Ma Jun wrote:
> The kfd_topology_device->cache_count is not used by
> other fucntions, so remove it.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 8b7e34b45740..72fbbd342c10 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1029,7 +1029,6 @@ static int kfd_parse_subtype_cache(struct crat_subtype_cache *cache,
>   			if (cache->flags & CRAT_CACHE_FLAGS_SIMD_CACHE)
>   				props->cache_type |= HSA_CACHE_TYPE_HSACU;
>   
> -			dev->cache_count++;
>   			dev->node_props.caches_count++;
>   			list_add_tail(&props->list, &dev->cache_props);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 3e8ac87f0ac9..912a5e6a24ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -140,7 +140,6 @@ struct kfd_topology_device {
>   	uint32_t			proximity_domain;
>   	struct kfd_node_properties	node_props;
>   	struct list_head		mem_props;
> -	uint32_t			cache_count;
>   	struct list_head		cache_props;
>   	struct list_head		io_link_props;
>   	struct list_head		p2p_link_props;
