Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29635EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63CB10E519;
	Fri,  7 Jul 2023 07:15:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F07910E520
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3ksB8pbwBtGpi1HEusYGlvq2YpODePj1lsArzLwpAyscVv3mehsImN0rFz3hoPtGWzJYOwvBt+LeUy5707dJO7AcrwezQDagEIwbY7g3tDM1qErxslZ/UZ2q9avUwZM2Su/qm3p8+htwcfogw/vjwc6TBDTpfXgaYEZKWvh/5ABoge+M6bcKx9B/ve51aW3HJ4fJq+O7VksHmAXu/KHgPnrWgxgXb+zZPytJTcUL23PfY5HTHeiQt8VczOMy+g5etK5G9JYjsouHy2BywdyQiMYagMvIQEcmdIAEbF8wfI6v7HKVcvywsyPESwcaDfWmXgFsDA3ts4tjV0DOeYvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqFmL/smzpFrSl1ghAoCW1GnOV9Tv4C/9MrkYUbCfk4=;
 b=F2uT1DZpk6TBYXBZp5Akbb0XDz/5mss/5N+UTXpShG4EY6W/8SLe54+VOhQfNTr1Wd2abgRrWFGLruh6e+Fq1yg3lxDIg5TtSzsIxPn0adSH5CvNYyBbXnk1l9NbFzPAYKdR6OhM/SDStROMVGa4zzTQfZEt6pBCK86N76qCkSf4oB43UAhyFFio0xKv1u4iyeSN5sIVx3H/GV90Qdv8IDnxdoomz9YX2Em33bpEaJ2+PJTvSuSYsEXs6Lw7lDa5MtgP/u2qjm4/7XhE6cMDw2aMViyHyfpnib0RgrHTX68naYPbEGxreeK44jBHHQN0mW51YUgwtY/U6rlTOwTB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqFmL/smzpFrSl1ghAoCW1GnOV9Tv4C/9MrkYUbCfk4=;
 b=N/+tUlVoQEyjRb9frXwUCmMLk7ThSOFuYKuXOxt0FF2wztgVh9PZRYt5+nKREEy7lRlKd0FOOtYKLw9RPsId4Nj8SDohTEGugzLQjnrF4zXC2wQtBHlBN0EGdxxj/Wd10gR4xehI6Gz4iyhV6G0WlWpH7wdjfZLi9cXXaO5BJS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:15:14 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:15:14 +0000
Message-ID: <2834445d-8da2-e853-50c2-2fececdb86e2@amd.com>
Date: Fri, 7 Jul 2023 09:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 08/10] drm/amdgpu: generate doorbell index for userqueue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-9-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b58b99-39eb-4595-6735-08db7eb9e871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7pPhYtXtQ3Yk/tjXxaERFds3zRfhp71m6bKr3J9pK1ZIjkGWw2r/IWU6//MB6EHV9l3YrYIRgL0Efrk6B1zoNj5B8bBCfJ8GKfnH86EkNonWXZ3sjsysN66KAs6G5TxJ6XhwovMHbDRZHGPTtDkleSPmEYZv3XAApShV27qTdmdSI2kSYUPE9H1qSK9LfKrHRKWffgM5aNrmSHyuXXp/KLf7D3N9a4Be6HaO7hYFMw7o4LZtK1J3YKgFqccRmazBCjMPiKh2Yx4dsrs+r7ggrmxR6ti1p0/8M80tIJiLWogmM48Xaqu/jD4KhPkMdQERS+PXMf5hLrDm7tY0mD/UlxtwdDVMyZjZTOhJp6Fk2ZpfnfN5fOdLelNRrGRJK0qYWKDe9ZCkJ5rc+U7PXtTC4tAqc85YY/DJ1Lm89MESfV7EkKCdNvU17Ur967EbKBW65wmR770TSBYSTCnHikzXIlkXJKjlynjOYVTNKgtgnKlUDj16hSjNmqXyxW62j6A0i6XwBwVD55fzrgOHkaaStYNZdwQ8q9R2siTRhI5/79hvHisY3xpPxgWz8EattnJoT0gB+Fn8mw8F/MDFVtSXL/5BCNJDJ46mW81BBcq0Tp1DgljmHW+h6t/wPy0SWys
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(31686004)(6486002)(6666004)(478600001)(2616005)(83380400001)(86362001)(36756003)(31696002)(2906002)(66946007)(6506007)(186003)(966005)(6512007)(316002)(66556008)(38100700002)(41300700001)(66476007)(8936002)(8676002)(4326008)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5Yb3U4T1hXcnJDN2NzUFgyOUNNdmpQQ0k5Q2dZc2I1cTNXWFpReC9jMzI0?=
 =?utf-8?B?UTBkdk1PMXVlRGZFRmdzS29iRFlBZmpRZlNpRUttRi9iN05ZUHJwOEVINXh1?=
 =?utf-8?B?b21pRjVhNDFGWjFObmhtV2FpMjVNQTBOL3QzazJEV2MwWVo2ZVI1OUtyeWxN?=
 =?utf-8?B?cUVyWllsTk0xUGZXZTc4TG5KRHc3OXVtL2hNWDJKWFVmLzBiR1lHU2JMbEZl?=
 =?utf-8?B?WjAzWFBiU2hVVmczOGFTM2w4U2J0cGV2Y1ZPL2NyaTJjNm11UWVONWkwVzNG?=
 =?utf-8?B?OWJ3VmVUVitvMWFFdFVIZm5tSnZ3MEZOcVF6aStEREgwOFhTcG9nM2piMzJZ?=
 =?utf-8?B?TGM0OE0wN0VRMUgvUXl1ZWZrQVR0dkJxWFdtcFFwTVJXTkVHL2x6ck1GbkRR?=
 =?utf-8?B?R2ZPYkI2V1FDOVBuYkRuWEYzNlprNXhEM3RiTVRDWFZvTS8xZ3ZPbVFDWFli?=
 =?utf-8?B?bjBDZWduT01tUXROZE5udmgyMXJIVXJxMnpISXdYYXRwSW1jY2JTbUlwWkFq?=
 =?utf-8?B?OER6bzZweXF4R29hNkpaRDRic0ROVWlEemJCMjhvbDNOanBraDZFRytzZXh1?=
 =?utf-8?B?cSs3RmV2UThsZHZsVkl2NjRKaWwxaDJld2FDK2NSV1BvbGoraFZ0VnlJM1dl?=
 =?utf-8?B?NVAvU3hXdHRnSUFLUXRoYmZ3emExZFVNanBnbUlsdTVvbTZ3c0IzU0tMSUNa?=
 =?utf-8?B?TENjOGlvdXM1U3dJbk5ZU1d0VC9sRE02aFBrL0htYVRIby9Ma2dZcE1aYnRv?=
 =?utf-8?B?K0g5a1ZqTEMwWmFlUkg0Tm9Xa2ZMUVJna2lZMHh5WXpNZTlZUngySEQxclJJ?=
 =?utf-8?B?cktYajhjYjdHZ2ZhanFZQ0dFS3hDSDh4YkY0YVpCRDZmUjZVMnNTN0YxSVdL?=
 =?utf-8?B?dHEwWXBUMGtBRWxDclBYbllVNEt2dUdmbGliQXhHb3ZSN3pFRHpTb3JNa1FG?=
 =?utf-8?B?anpRV2NTVDlTalh0ZndzeFZFTXB1bDYrbEdTb3hOUk1NRzZDZlVNUDc5ZDNH?=
 =?utf-8?B?aEZsVmV6ejIyTFRaUnZTRkhvSytzNWpvWWIxOXZGNEM0YVZMc1hIMnZMVGhM?=
 =?utf-8?B?THdIL0tpMFN2VVc3dk1GOURhMThPK0FFdTRacXZnb1piTWZoVEx1bW13ZUw3?=
 =?utf-8?B?ZUtQWUQ1aWV0dE1JaUpxbE5iLzliOWN6VmxNbUJ3SlNkY3IzTjdXdjAxVDB4?=
 =?utf-8?B?MStGNThnOUJxZUI1YXhpcEN1bzJPemNYdy91ejdXVlI0NDNFZUtZeW9DSjNo?=
 =?utf-8?B?RU5Ma0JvWFBId0hpRFdseXhOckdOWjF4WVFvR1lMYWl4Y21MV2JOWEF1MmlX?=
 =?utf-8?B?NDVRNldSQTU1WGQ4YWVCZ2xyUzR2dXZOQlZCYjBpalp4cGVVNWdwU0trbzhU?=
 =?utf-8?B?LzBrbDcyNnFLYURvMUhxclVPUUxsR3FaL2JqK2xaVzJVTlpjQVIreUFWRVk4?=
 =?utf-8?B?bU9NdTlYbmVFa2JZQSs2SWRYMUo5eGJNZ01Pb0JVRWFjdm5qT1FwVEc5MFNI?=
 =?utf-8?B?OWRwK3NKT3ZFNW53YTlFbG1CVUtuQm5NVzFoWjNJSWFscFN3WFIrRVRpY0tv?=
 =?utf-8?B?dzg2MVRJZTlZMGNtK2xHcklGbjhOb0pRbFF6eHgvay9CZElSOCt0RThjQmQv?=
 =?utf-8?B?ZUVKQmxqMmFqdHkxTjl4MVg2a2Y1K1NHOXVwSG11ODNRTzBxRldSSmR2cER2?=
 =?utf-8?B?VU05eTNuRW9Hd1pmL2l6cmhuRkN2YUhxbUJ0SHVtMG1GdW9FM3RFaFVjODRp?=
 =?utf-8?B?ZDVFRXdOb04zL2d5aTVadXBWREc4czkxRDlmT3lsRmZZem5qVE1tZzl0TUMz?=
 =?utf-8?B?NVhraElac3EvWG1JVy91RlZtekU1dmdsY1BaK0ZXR0UwMnJXMlhlUzN3LzA1?=
 =?utf-8?B?ZmNLOXN2bmJxVEdXSlgzYk5VVTl5Q1RmNzBwblpxaVBiTGJEWkpDWFRlMGZY?=
 =?utf-8?B?ZHFYbmcyWkt0ZmdqZldYYm5PS2JXUEZDMnZvS0g0ckZGeUZBTDVxUkpNMzZy?=
 =?utf-8?B?b2s2R2FBYzIwM3Q0TERpYTdnTU1wdHVZaVRNL3VDN3cycVNqUHJ5RHJvMnNx?=
 =?utf-8?B?SmpFZ0lKVHRDZDdZcnFSQlRvbkxRbk8wN2dSd3ZYSjVGb3FMelg2YWI3cDlM?=
 =?utf-8?B?Sy9Ub3VrdVVEZlVHK0ZsbXVLVkhzZDVrTE5QYTBUWkthdGlseDVCSGU3MnB3?=
 =?utf-8?Q?sKNUF8IRfm2Mgpaa2rXH9RByx050fp5P+48V5LmyAuKs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b58b99-39eb-4595-6735-08db7eb9e871
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:15:13.9289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAuXMJH1Pkv5LrClDqw1hkISKSkl4dnb3TyqzOHufFzCyQO5wu/jocm5xMqhhXfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.23 um 14:36 schrieb Shashank Sharma:
> The userspace sends us the doorbell object and the relative doobell
> index in the object to be used for the usermode queue, but the FW
> expects the absolute doorbell index on the PCI BAR in the MQD. This
> patch adds a function to convert this relative doorbell index to
> absolute doorbell index.
>
> This patch is dependent on the doorbell manager series:
> Link: https://patchwork.freedesktop.org/series/115802/
>
> V5: Fix the db object reference leak (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 34 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>   2 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index bb774144c372..61064266c4f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -32,6 +32,31 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>   	return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static uint64_t
> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +				     struct amdgpu_usermode_queue *queue,
> +				     struct drm_file *filp,
> +				     uint32_t doorbell_offset)
> +{
> +	struct drm_gem_object *gobj;
> +	struct amdgpu_bo *db_bo;
> +	uint64_t index;
> +
> +	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
> +	if (gobj == NULL) {
> +		DRM_ERROR("Can't find GEM object for doorbell\n");
> +		return -EINVAL;
> +	}
> +
> +	db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
> +	drm_gem_object_put(gobj);
> +
> +	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, doorbell_offset);

This can only be done with the doorbell BO locked and as soon as you 
unlock it the value becomes invalid unless you pin the BO.

Regards,
Christian.

> +	amdgpu_bo_unref(&db_bo);
> +	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
> +	return index;
> +}
> +
>   static int
>   amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   {
> @@ -64,6 +89,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>   	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
> +	uint64_t index;
>   	int qid, r = 0;
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
> @@ -87,6 +113,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	queue->flags = args->in.flags;
>   	queue->vm = &fpriv->vm;
>   
> +	/* Convert relative doorbell offset into absolute doorbell index */
> +	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
> +	if (index == (uint64_t)-EINVAL) {
> +		DRM_ERROR("Failed to get doorbell for queue\n");
> +		goto unlock;
> +	}
> +	queue->doorbell_index = index;
> +
>   	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to create Queue\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index afaeecb9940a..8edb020683a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6719,6 +6719,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   	userq_props.queue_size = mqd_user.queue_size;
>   	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>   	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
> +	userq_props.doorbell_index = queue->doorbell_index;
>   	userq_props.use_doorbell = true;
>   
>   	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);

