Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4012BC48260
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 20:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FBF10E661;
	Tue, 13 Feb 2024 20:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="int0kfDW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831CA10E661
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 20:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrGuOohRJRJQk58V+k+n3IhCu/STmsKKyP0bvNQSTr3V+ILx02OOzMNmE3tsTkiXCLcLwD02CkWYq5cUbZoU0wQJblNJ3e4FR8qxo0JmrUNQAUYEeX7yhYw5Sxf3TwF5eHK2dNfLMPOFTcU+R8ensU1oGHsjQNAh7KigF4YBcKHXHpNaoAymIM/ktCB5msC3G3tMclWE5fJT9TUGKN/+eaSjMIkU6RY0UbmkiJIj9NgCURhdnkx3jxVZd9BjxE+GO5IcGxboWVXDaLGMYeXCO5J0E5qlAB+iREGHOw50+uz5Z7Rm/TNihyLoD6b9GO3tpZZTwuvMIqMyZg5ceoqlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=086u7uwBUtnNsEQQhaCdJBkwcW3KDS7XqwF603iXCvk=;
 b=ed/uNmo/WMqM8qtlRHPejvNMdPDEC4SD5H0cv6BLnVpZLWYwypmpSMRywuA8tW3U4tQG1S0n67KYRlvSK/woPecmaM0UFCAdj5/M9AH5l0uh05U3ncgg/VMyp5haAur6/dpeqBpt1ziZY9BklUaV5EVznZRBiucAFFU8MraNV+hwSf1cMMPx8D00zoudFwTD4QtvMPfvhAzG5OM8JEaT2yvVD1JLq0osyVUB3dAALIntoATr5utNg6bMbyekwLDlmR8gpljFSUA1UZvd/27KIVntdniXLLC/wlkkgs5fmfGz+vwFYm4tjDr9FdX6dK5LWX/MYFalMA+3CYxMLrv4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=086u7uwBUtnNsEQQhaCdJBkwcW3KDS7XqwF603iXCvk=;
 b=int0kfDWf47sbMA/2cRRClGpvtev0lL6O5YEyq7KqsYcWG6Sks7wRML4ZUk1ocgHvsHb8nb3y/cmh783nDCTfNiZk4xwT7jL36DBQ41EQsyjefIUYJdDC4sikX24Pte1agShtzkndKwOxKUp7B9t3vqp5rvPgxCOdCNClyGVQBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 20:52:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 20:52:04 +0000
Message-ID: <a3e3f082-f2e9-48f7-8e1a-42eff3dbc886@amd.com>
Date: Tue, 13 Feb 2024 15:52:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 69de4d86-6319-4b72-503e-08dc2cd5a296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZKgW1wEP8qZlCrhsyajspZ9J/4lkU7ecGQ0ESeCD+YTB2vfea7ziCfOsGccDARuh62lsQO/VGHIoLPR6PTTMvksnCvxQpDR2Xgoh1fF7II9TWv6Oc/De4JDW6eI3Edq/FYMuDcRNnEdJPzYj5UGRgCk2SzCNMrnp1ktm0ORpSk3TPOWMEDedJ4h+Ag4uu7iWc1lzuZLc/6YS1M5uGKEyVf2nUU5+/JxJsI/HXnDbv2nXybvCo0nGuivkPOvXYGugG+90RxJEjWCUr07wmIers9LVO67sQS7n0dY28jiqKlY8P+ITK3M4X536mw7vDoCBGpTQH2ux098CmKRPI7iAbmx66G/pJJyUIEjeAZL1bj4jYRSji3W4Vrlj4sH18riFeQudrcWcqcQatGu6zW8qv3taViOQc7ph+PHxob0QB42LYv3ixWlcXEajuwwgi+z6x9GNtWh5/3cdTGi6TuJs6YR5mbXVxxWtuurmIjcZyYQh8q/h5QAuRQcsjI2ROj5+2NRdqb8TEq5m/HUt2pSpweyjd3SxXbAdazMMnb/z08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(966005)(6512007)(6486002)(478600001)(31686004)(41300700001)(66899024)(44832011)(4326008)(8676002)(8936002)(2906002)(5660300002)(15650500001)(66556008)(36916002)(316002)(53546011)(6506007)(66476007)(66946007)(83380400001)(86362001)(26005)(36756003)(38100700002)(31696002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndiQlA5bFBHUERDM3V6ZUcvSlRTb2JRaXA2R2x4Vm5UdGpNSjNIcktsdWkr?=
 =?utf-8?B?cFhjM3FONC93K3RwNkdrVVV0d29aYjhzaTFCUlJ0NERXcW5yeE1JbWFjc2xC?=
 =?utf-8?B?SGxnNDRYc01ZUi9KSjVtMWtuckZVMmVDcW9aMFRvS1pzbzlVT2RLMmM2T3NL?=
 =?utf-8?B?RitvYnJ1Z0w0Z2ZiTy9xemtIUnZqdHhyZUpaVm5SUCtCcElOREdwRGROWHgv?=
 =?utf-8?B?c29mUzhwSjRjbXR3M3pHcWJ1WVFTdzVsd25hTElUeVBQeGNwUUV4U2wrV0pi?=
 =?utf-8?B?VlV1WDkwdnJmSG9ZTXVwM3VzQ0JMTUNyaDYxSElqRlV1T1hGbDFDSjd3ZUNE?=
 =?utf-8?B?UkQvVVgvSUVOS21KWnZxemFDQnFzWU5IRmhwblQzWjlOMFVpOTloQ3MwSC9N?=
 =?utf-8?B?aXZvMjQ4bXVSSzF5THpHSXRCK1M5TEFIUS9nRGZYMWZuUUR2QnVSZUlBZFRG?=
 =?utf-8?B?Tmtha2ZuSHR6NmkvMWxEcitvdlhabzc3TDRRQlVvK1RNbTNJMTJSVkM3YXpC?=
 =?utf-8?B?TWp6RWcvS3hBa3JYZkpUdzJ2dWQ3bXJDUWcyNDNOUHBMQVdLdjF2NzA3S2lF?=
 =?utf-8?B?SEFjNjR5MnRaZVFVRldPT01WcGpjYTZiMi8wSzlzVUhCZk5aRXdPcmRyZEZs?=
 =?utf-8?B?V0g3cGozTFkxWGlvRWdRM0F5ZEFvRmxQNjJIRVlUaWVzZ3Z3QktBRHNSTGpX?=
 =?utf-8?B?MWxqZlVlVlFVUGJ6SXdyWnRLODZYLzVORXRuNG1TeFBUZEVlQ3hIOGdqWmd3?=
 =?utf-8?B?bkN5L0dMZms0ZGV6Z1VEY3lYUEZoN3R2VWYyTnRWTmtKSmJvQWtmRXFFUE5p?=
 =?utf-8?B?ajI2cUN0UDFSNDZQOUVpaDZlU3lhb3RGQlVvWEk4MWN5aTdYY1ZyallwV1V1?=
 =?utf-8?B?R2UxTXROTHRjN1VRZnMzdUpSOVlmS0NZWkhoQysxNlVVWldZTGlrbGV1SU1R?=
 =?utf-8?B?d284NDdLVDNldlBoUFJQaSs3c3FRU2dDVGdtOGlDUjcwcHUvV01lbk1ZSE9K?=
 =?utf-8?B?MUFzMTg3Z3FleEppNXJtSWc4aUZFK3lxRnhFSnQralE0TzFPSFAzTmkxZmdw?=
 =?utf-8?B?VkMwdWVkT0NZaWN0amh5emJab293NHFaU0ZURk5XZ3hiTnloRmVrSWc0dHgv?=
 =?utf-8?B?ZWxkaVNEc1BLOEVvTTNoem0rTmE3WGdGV0FtbkFYS3haQVIxQWtwd2hlRHdL?=
 =?utf-8?B?TnV3YkxSSG1rdGxCNGgzVHkxOEJJN2p5cGJLR0plYjdJMnJKWWpJYVhIVFJ5?=
 =?utf-8?B?YkFpTGNldTg3MnB4VFc5T3MrZ25tci9BSlZ5eitXT001L0xONW9wTDRtQ05o?=
 =?utf-8?B?UWwwNVZ2anFuQmlwWE9aNFRUakNtZnpmZ0lJczk0NmFqS3BaL3JOak0yckNm?=
 =?utf-8?B?MW50QytRQXNPZ2FaelFWMCtrcnYrVW8zRnFQUVRTYnFNbzJhNVNhck83Q1pL?=
 =?utf-8?B?a2Rpd1hUWlcxd3hJZzhwVE1HYTU3aG9OL0tFa1JzWXRzVzNCanJ2ekNlU01h?=
 =?utf-8?B?Z0ZWdEVHWGtBQjVoalp3d3ZpWlJ0ZmlrRzRKZTk2T1NlM3RuVU8xSTJhc0xT?=
 =?utf-8?B?VTMxOWo2L29vdUxZOEtKWDFQL3FoNEd1S1RiY2F2ZHQxZE9MUjJ0eEdSdDJy?=
 =?utf-8?B?MUM4UWZkc1BVZ2JWMndDL2RCUFVWc2drQjkwbk5XWmtDNmc2Zms0V2NqeHVt?=
 =?utf-8?B?UFVzY3ZnSVo2ekQ2NHBDQ3VmTjJ2eTlXbFY0UmNhMHRkWVhOWlhJbG9NdEh4?=
 =?utf-8?B?cUg4UTJCMVNmbHcwcS83S3NWRXF4RS9Uc09BNzZYVWp0Ym95WFZ3NjM5ZCt0?=
 =?utf-8?B?a1ZEOHAwT0JYSFo1UWl5MFpOVDNhNFRPL1NUVzJBWkVySnlLa096MVo3SnZy?=
 =?utf-8?B?WDV6dUpVdDRDdklLRjZLN0t0ZWxxemM4WmhlQm1qbFBReWl6SFBLa3dsb0Fo?=
 =?utf-8?B?eWtXK2J5Q09LQUtpNHFSNkpIdnlBN0x0NDZKVFAzT3RTYUZPbCtOR25mNFNS?=
 =?utf-8?B?dVdlc1RVcVkyVitMTUR6OVhqZnpWMFErenR2b1VJM09WQVpZaUc4N0RMSVlB?=
 =?utf-8?B?T3I5WXpUeEh3UWRqYzRqRVcxbFJRZzIzdHZ1RVhmR3VOOVlVK0VpOUQ1enpi?=
 =?utf-8?Q?9eO0OVclh2l5ct0F0niUyaf5m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69de4d86-6319-4b72-503e-08dc2cd5a296
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:52:04.8941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2csd3Otk1P7Q7XJ54d/0p+ywg54CgsfG6VqVJnhzW36lYd4PNaClEd+4vVCrX79Zn/SFnhFiscme56H9i+gFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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


On 2024-02-09 20:49, Rajneesh Bhardwaj wrote:
> In certain cooperative group dispatch scenarios the default SPI resource
> allocation may cause reduced per-CU workgroup occupancy. Set
> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
> scenarions.
>
> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
> * Incorporate review feedback from Felix from
>    https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg102840.html
>    and split one of the suggested gfx11 changes as a seperate patch.
>
>
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 9 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
>   3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 42d881809dc7..697b6d530d12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -303,6 +303,15 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   		update_cu_mask(mm, mqd, minfo, 0);
>   	set_priority(m, q);
>   
> +	if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2)) {
> +		if (minfo->update_flag & UPDATE_FLAG_IS_GWS)
> +			m->compute_resource_limits |=
> +				COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
> +		else
> +			m->compute_resource_limits &=
> +				~COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
> +	}
> +
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 677281c0793e..65b504813576 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -532,6 +532,7 @@ struct queue_properties {
>   enum mqd_update_flag {
>   	UPDATE_FLAG_DBG_WA_ENABLE = 1,
>   	UPDATE_FLAG_DBG_WA_DISABLE = 2,
> +	UPDATE_FLAG_IS_GWS = 3, /* quirk for gfx9 IP */

This flat needs to be a separate bit. So it should be defined as 4. 
Otherwise it looks just like UPDATE_FLAG_DBG_WA_ENABLE | 
UPDATE_FLAG_DBG_WA_DISABLE. I agree that defining bit-masks in an enum 
is not ideal, but I've seen the same in other places.

Regards,
   Felix


>   };
>   
>   struct mqd_update_info {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 43eff221eae5..4858112f9a53 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   			void *gws)
>   {
> +	struct mqd_update_info minfo = {0};
>   	struct kfd_node *dev = NULL;
>   	struct process_queue_node *pqn;
>   	struct kfd_process_device *pdd;
> @@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	}
>   
>   	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
> +	minfo.update_flag = gws ? UPDATE_FLAG_IS_GWS : 0;
>   
>   	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q, NULL);
> +							pqn->q, &minfo);
>   }
>   
>   void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
