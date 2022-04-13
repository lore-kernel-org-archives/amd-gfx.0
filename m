Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8742C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 14:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEDC10E176;
	Wed, 13 Apr 2022 14:49:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F7B10E176
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 14:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJRk/+DRGCvhz5kJFFUDArzGAp5A4440HJ/Wg3Kqt4NcM1iXqWSw5hz6DVQfKmbqgv0w9eLXpvMVFiRT2FnlF3XvDGWTFeBlb2Dwl6DURRWvvL2mSmLK9w4O0HJSfh+ygzGEe9iM3nGmx/wGFE2czR0iyLA6rGCpUkDwg0muaBRETA3L/jITB2FkbZ3ADv5mKnGfZYPNj+4Kd15ddTIrvwlLCaj6HSdOe/DQBnJSSz5Xr3F9l63WagD93NY4EUeCyVQxhEeCu+R794Dl7nn3G2oqMbJW5/M+KPYZvFc9V73PUoapkOMA4SdmPfdgTod6wmmkRB1Mpy6WXRUi2JQVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYyneiu3TQeIxoMLkrexzVKY5hqZz8FFKml45/GmHZw=;
 b=ezudWg/7lM+MBNOYMv0wEsjly6XI9TVwAJMaPdtTQDJjz2bfeRLayLGgs8BKfPM4xafETwzlxh6DRxO4w70wNx/OiOLBkQsrnvhhC7WWa7WMSznuJbZ45suIjzEoOP3LGYNF8LNqG0oiIukJIZxWIu5Pd3tHGbjycG87euyVKQjzTHOaTvlWNRLndNIyDucKEsnMLpZnSmkiehdaP/xMqXB6YejDIGHQoam4pNXamYEC92cRhnGuwpyUoNTJsu7lKRBDg4MEhOvP/1IoeJsfJbebUVnFw+AM7RpBLcQGKDuscF5UoGHvflFz0YgpI5hK3WIkbm7HOV9fhwoxCWLbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYyneiu3TQeIxoMLkrexzVKY5hqZz8FFKml45/GmHZw=;
 b=bBQNC1P3xM9Bm/i/r+TWAZLCjtazz/SLj5EzhiexyL4vpyrpyv3N25IlaB8aPFBbwCzagTYZe7yBJk2vBsSCyQ5aLL6d3Op4Vyf33e5i+fxdAlZvRs4CW1a5dlvBxBuLYBXOcN3uTCwOZOZghtAA4GhXi3gbUQrvIx32p2pyRr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1465.namprd12.prod.outlook.com (2603:10b6:4:7::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Wed, 13 Apr 2022 14:49:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 14:49:17 +0000
Message-ID: <e2eab99e-d455-a81f-d2a1-6b7e0885b0ae@amd.com>
Date: Wed, 13 Apr 2022 10:49:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: potential NULL dereference in
 kfd_set/reset_event()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20220413073639.GA8812@kili>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220413073639.GA8812@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ee938ae-e7a3-4de0-325b-08da1d5cc92a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1465:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB146556B9E4CB9DCCAA7A7EFA92EC9@DM5PR12MB1465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvJV2yyspA5ZFYHoQ9cQ698wMfCYjA2G9Kpl/hNtYXPIwYaTI4tP8rDxMQnAwSh4Eg01ILbbuAkPpv7Gla4y0dksOPCkDbtFItkz8btem0jtYTd73HJBWYyEOqj52F2DsSwhosizTkojpKU+Wtmom4JATxO8C1WDb8heTuYpsRNmTUu3nE+toTghYXkfJ6rypgO/jqNpMvaB5F4BhGRYO8mIdNw7ekNrMfchxqUpAugogmlS/I2KBk+uOQlvVSyi/EjK2qKubQlH5rkzSmRsgiAy+QZ7qa4Pb5E1Ws+jkXOAHx/UpYBb21697QwyfKgCpvRqTuRT4Bw7ErUDcvpD6pQ4i++mz9VZU5sRSqoEJcJiFZE3BW4wFiq1OnSgQXSjg2SRRDexQmNuAr7ExTy73vOtywrQLhbX7SgsuO3tWO/6YO8xW+nAMCO5DvYSt++2+2q5ls6eNIynTh6cD+y8YV2naEkmdMOmSBiNN0v74JUZ9TKnaxQY9ZlwOTEWT5s5T8q8lYx0SQYx35mdu6XdKk0e/GfCHnBgZE233inw1L0wbI1ByM4SfJu5pPCWcKLSlTHQtcsElS8pkVoIrad3o5LrOAgzmMjJ7dTkdZVwKcHfZvY6nfdyiRpi1IAxNFN3r2GGpnGkD/mNk66Zx8ERrUwp+uJrU8tHSjB45fyMpBVoYVoO0J7F0rR1qO+yXTFudPfo4k2OIleEI1nfUjX+YSq7q2cCcB1pfFFH3vCgHDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(54906003)(6916009)(86362001)(31696002)(6666004)(6506007)(508600001)(6486002)(31686004)(36756003)(2906002)(83380400001)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykp5b2hwdDNBZ1l5VncyMHN5RXZjWnBiZjduL0drbnFFajY1S0tOM0w3Yml2?=
 =?utf-8?B?eFZWQWMyWVF1YlliNzk1UDZjYnBSK045QXdyNmtYZ1FhZ0FxbmFEd0VxS2Vw?=
 =?utf-8?B?c25iejVTWkJFUG5TUkxBM3RLZzJGdVFyYUhUMHhVdXBTL2M4N2tHRUJ4dm02?=
 =?utf-8?B?YUxmbEV6aUVOYWRyeG1Iamg1T2R4T0VpSWowd3NBL0d3VHBmRjU4c2JTNUU0?=
 =?utf-8?B?aWZIeklpNkhSRVM3YXR4eUZqY1B5VDB2MzBsSlJTU0JOSXJNWG5RcUpEQTAv?=
 =?utf-8?B?VDJZUU1oeEc3VHk2ZjFndmx0NVB2OEtESzlaUExUSTRQV29zYlVhMVpKdDVp?=
 =?utf-8?B?WUIyVkE5NCtHa3MyMk82VnBnZ2hqNnY1ZVBCZDRHRG83TFJqTXB4RU1tYnZW?=
 =?utf-8?B?cVFZMG9KMXh5ZkViUnhDcWRZSHo5RDJZb2paQVd6T2VBek9nNmhTS2JqelVt?=
 =?utf-8?B?WmljQzIvZmc1THRPWmN3K0wyVFQ1Vi82Z3J2bWxlOEpVbzZtajB1MHJDMjJI?=
 =?utf-8?B?ZERGcGY2NEN0UVZSZHg4LzFESlhOeEp1QkZ1aklLVmgxVEk0VTQyS1M4UGNQ?=
 =?utf-8?B?SVlQc1U5MmIvdUl1eHhaYWVpQk4vaDIwWlg3aHQyWXE4WW9xa1F4L1gxLzBR?=
 =?utf-8?B?UlQ2eFZaWDFrbXBDZUgvUkV3TkQ4TGpKMmk5MjZBUmVrV0tpanJ5VVQ3U0ly?=
 =?utf-8?B?bFp4Wjh3d3RxT2tjNnhzNFNpbjM1NUVCcnNCaHJoUVpqZG8vZkhnNzBrU0FS?=
 =?utf-8?B?OGxJN0VwMTI5STZXMlB3dSs0eEZ5cVJXczMrQlgyNWNOWjdjSE1zYWlSWXJF?=
 =?utf-8?B?a0tDc0FydER4L0JzOGwwMGpHRVg5RUtKelE1Q29vbmx1VE03RS9qM1JnNFRk?=
 =?utf-8?B?Y3gxWUJNMTYxdjNwWm5ybHM0M09sUStRWkhCblJ0VjBkYWFIUXZRZWh6TCsz?=
 =?utf-8?B?TWZRTCtxWXpPOFJHWEM0OVFQcVQ1ekY1VSt4OGRMaVV3bTRBc0ZUa1BzMWFG?=
 =?utf-8?B?anh0ajluOUNMd0tPa0paRXJySDVBNDZaUGZQWEZTVlNmbCtSUUFIVW9EVGZG?=
 =?utf-8?B?Q25pMGpTUmZEUk9zSHJuTzhGdnJZYlFzeWtxajhDb3l4N0tQdG5KOVhGZlU5?=
 =?utf-8?B?U1N5WXAyWXR1TW9yMys1clkraE53TnFFMkQ3QVZCaFREa0VkQnRkSmV6eE1h?=
 =?utf-8?B?WEV3aWFUR0pXU0FVbXVJTXFPMUtOVjlCZ00vRGMrWjdNM0xkWlhjUHl4dUYw?=
 =?utf-8?B?OXRLTjdOT3F0U01tVlI4bExBenN6RXpZaFNVcEZINjNlOC9jMGVoUHNYQXBy?=
 =?utf-8?B?N3lhY0JvL1B2bmhyRzg3RW9FN0I1aTV3MU5NcTBTbkhoS0xsV2dzZ0x2Nk1T?=
 =?utf-8?B?dHdST2dyc21PZ0tGV1BnVlZPV2ZDYVMzdXE0WjJiQlRLemdhT0hPTEo4TVBJ?=
 =?utf-8?B?QXR0KzBrUGdtQnU0aDVXM05wQ0s2SHJSbUpqT0JTZkZ6SU51TFBQYnpkMkZ3?=
 =?utf-8?B?L1h5MUsyR3ZmQ1M4WFVYVlcwYnZmdE1OMDRnbVZSbzZ5UnNrMktTS0RHbUQz?=
 =?utf-8?B?aDA5STVEcFpreW1CN3RYdG5CVjQ5R1kvUElUSnFRVmhqZ3pLanJGV05qeXhn?=
 =?utf-8?B?TDl0MDFsZzFNWjhDREdDLzJkYTFCY1J1RzFGMThXdUdUWGtoTDEzR2l0bHNV?=
 =?utf-8?B?ZGtSTjFsMkUrSjRUbGovY0krSFVLWHFtVmRPUko1YVJ2QzlwNDh0b2I4Qzc1?=
 =?utf-8?B?OTBrYXBJaDV0SVJ2b043aUtnZ2Rzd1A5NFpIZ0ZnbWZ4bndQK2pNUDNQWW90?=
 =?utf-8?B?K3o2bmdqdHIwYzRoMmZwd3h5dU15Zkp0a0liS0tCNGQ3S3pUSVRnbmRmRTN5?=
 =?utf-8?B?bnhJUVlYMjhENEhFTGZhYUQ3bzZmVmZrbi9BS25BcmluSHpRbjR2VGwwQ1VE?=
 =?utf-8?B?aDYyemJkQkdueUVCTU8vUmptU2NuaWJEancyejFHL3Uzak1qRy9XRlQ1bmVj?=
 =?utf-8?B?NDN6V0dBdWNVeHFTUkV5QVNZZzNmUUdENHFDSXNkRkZVNFBTd2dpbnBzZFNS?=
 =?utf-8?B?Ung1cTkxZGVCU1ZOTVQ2S2FnVm1CRTlmb3N3SnRyUjczVHZWTllheWR2Tnlq?=
 =?utf-8?B?b2kwdlVOdTRoZm1TMlNJUjNucWFZcTJlV3NadmNNNjZIcWcyMVg5NjQxUXdJ?=
 =?utf-8?B?bEdRUENlTG9UZ0hxaktDK2ExUDlZUWt3OThmUEI5aWVmdFhWb0tUbUxJMHc0?=
 =?utf-8?B?MjFrby9JczQzVnVqSzJaeFlqalVja3RaUjk3N1d2ZXJQeW5aQlcwQWNKcE0x?=
 =?utf-8?B?NTRPOXFka0JueXF1VlJRbVUydVp6dkh1OVVVMVA3SURXV21JUllqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee938ae-e7a3-4de0-325b-08da1d5cc92a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:49:17.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZrWZhWQei3UMR+S3K/747rsKjd/rS+fLRiwKDHP8GZctv2u2BMT5daTPWuF8awNnwV7+H5BNbRuw6SficI2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Keely <Sean.Keely@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-04-13 um 03:36 schrieb Dan Carpenter:
> If lookup_event_by_id() returns a NULL "ev" pointer then the
> spin_lock(&ev->lock) will crash.  This was detected by Smatch:
>
>      drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_events.c:644 kfd_set_event()
>      error: we previously assumed 'ev' could be null (see line 639)
>
> Fixes: 5273e82c5f47 ("drm/amdkfd: Improve concurrency of event handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I will apply it to amd-staging-drm-next. Thank you!


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 0fef24b0b915..15570e72a5dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -634,14 +634,19 @@ int kfd_set_event(struct kfd_process *p, uint32_t event_id)
>   	rcu_read_lock();
>   
>   	ev = lookup_event_by_id(p, event_id);
> +	if (!ev) {
> +		ret = -EINVAL;
> +		goto unlock_rcu;
> +	}
>   	spin_lock(&ev->lock);
>   
> -	if (ev && event_can_be_cpu_signaled(ev))
> +	if (event_can_be_cpu_signaled(ev))
>   		set_event(ev);
>   	else
>   		ret = -EINVAL;
>   
>   	spin_unlock(&ev->lock);
> +unlock_rcu:
>   	rcu_read_unlock();
>   	return ret;
>   }
> @@ -660,14 +665,19 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id)
>   	rcu_read_lock();
>   
>   	ev = lookup_event_by_id(p, event_id);
> +	if (!ev) {
> +		ret = -EINVAL;
> +		goto unlock_rcu;
> +	}
>   	spin_lock(&ev->lock);
>   
> -	if (ev && event_can_be_cpu_signaled(ev))
> +	if (event_can_be_cpu_signaled(ev))
>   		reset_event(ev);
>   	else
>   		ret = -EINVAL;
>   
>   	spin_unlock(&ev->lock);
> +unlock_rcu:
>   	rcu_read_unlock();
>   	return ret;
>   
