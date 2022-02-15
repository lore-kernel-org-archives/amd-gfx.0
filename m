Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E6AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 12:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1320F10E465;
	Tue, 15 Feb 2022 12:26:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA0C10E464
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 12:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6HQ6UBrJi3EvHgGRrfeEAbIXkcBBJMb6EmeDUgQMO3741jcgC2PNu5DHs7I5g4wuazjBJVGOz6i5DhnVlfvy3ru25kJohmbXXRT7J5kSpgpNuSd/Iqasbwgo9Cb9CmlMspJhKiY49zc34yJJmZbvVZOMqHOwEKUfzsFab+LaIPexty83mbqRcan581eNMIHpRKYn218InsOkvKJHk1JTlyjTtXLE4k1RVIMn+7Ac4hgOY0FrPQVzvhi7MLTE5ZfCDYZyWrdFckAVVMWcYp9MS/3HXQdywBaEMVa9Nq2bSApYOq5s9axHoc5tT2st2ZKFzw7n+sNkmCfoip4GNZnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acrkiDqeSXBBcqs5zhBt3jlNGxmOGEnXVWHmPks22cU=;
 b=dq7AN3Y8/rETBG4J0/IrGS+0lQ+MfwiauPlwathfdLrjXqAWDgJcMHzgEHBF89LolHQmEbYUQ8gQuCb98hL+JmcI7Y82pyQVW4cKRAv6Ye7SEeGk1kgo6wfbfg7elhTW9hlXOVn6stjoLLoiJnoCcN3IKpsMUtPfGYaS1T1zHEUrdtFErsUash37PN4HE5PywIjUdARrYF04MgxTcJgbqwlrZ1x0IlKbDQbcZ9RrN5fEX1OirxMDMzQ1zKhuO0/nSJ/Nfw1sSZsv97tT1Oz5Gd0EWUwmfwDN2fTWinq38DEpTl5eDuoPs1obfzj78x4QgRmlnO55bz9otBHEIkbySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acrkiDqeSXBBcqs5zhBt3jlNGxmOGEnXVWHmPks22cU=;
 b=hZI059d1UGa0Sla6Q9bLI+y29ojSH8lFD90f2J95QrmqIn5HJXGrUsyOuwyhiGramdmHRi5KDtvDQN5XsQ6XWbQ6Itt4QR9eR1P4NtP+8AUaUvXmsOOplj+6kW5HYQ0jzXQNJbYPGu0nrjtzXiwnfDR6QEs/f/r6ShXbf61I5Vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 12:26:40 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 12:26:39 +0000
Message-ID: <991a0813-3cf8-a45a-6a5a-e0262d28ce99@amd.com>
Date: Tue, 15 Feb 2022 13:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/sched: Add device pointer to drm_gpu_scheduler
Content-Language: en-US
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org,
 monk.liu@amd.com, emily.deng@amd.com, horace.chen@amd.com,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20220215112950.13898-1-Jiawei.Gu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220215112950.13898-1-Jiawei.Gu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0201CA0024.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::34) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 270dd1cf-db48-4074-5a31-08d9f07e6ab9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4014EBBFB0A31A03760D4E9283349@MN2PR12MB4014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHREAJkivToBSQbV+5hm68xnebPMe0TiWHHw5uDmhdHS4M15/PUHEehdSLeByrfS+ge0J65zTuDbKgfNJeTzcWfNdiIeZtpcfvqSby447AXB3DHXxGMa8yFi+37v2kXyVKwJKtUJkDAJfYGHjp/XK2LCaeRdeULaCgVi1genyqnf0VX+Zmi8J6re6Azd2kCYzzc5HhLQ9wPwT8Xr41ErWfnQe/ZFqSFWI84pijQ9X/dJZZYANLca536tBnUgTKwfeXQxae9XGRuGK/gI4sB4BfOAJZnZLZfwUYfzhhA4kP8hNW74hM/65NDfRDt13IEnWXbnWnHctrxkrzemPCnB7h9PkgbjcY6IY4GsXDOZ6ieo6Vfk9DphEZbTRQtf3fUSntdKyVTQ4Xyqx5DMio2CCyCg5bg868XgJfny5FzrrO+Ifa0jWwwp2ya3rZ2IwE2+hBzgh/+uCemCvMF0RDxLG/ECLwyZnxVRNPF7VQwONXSy1sZr8erjAiJk4kfkOVMAY/sIcYC9EZjGHLmqDtD8QUdsjKHubmjRySo2bzsnpNU8AZBMNe5ezVigGMt/4ufhM/GUffNBP027xNKB9hezpBlkOosZJpVCqURWlMRw95pudppNHyeNAJt5V2QoJMOmCoyifiwRpSiXtCOjHqhyx4BY0bWZbPaL/7arWgKq7mEeSjTYX54rHdnYivhIv6tonG90ex7jr4exHikZkow9bWIFtpPueFlQgxMaEmbny8tL3obiwTmxEn/VCntI/g+B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(6636002)(110136005)(316002)(8676002)(38100700002)(31696002)(86362001)(8936002)(2906002)(5660300002)(2616005)(6486002)(6512007)(508600001)(186003)(6666004)(6506007)(83380400001)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2tTd3BDYlV0dGc4MnVFcW51cmZNandzR1VxVDNUeXNJOFBWWFdXN2YyVE16?=
 =?utf-8?B?UXk5V29VQXlVdnFwWjZPZVdLeG9KZGZ3NUJjTkp4Ym02UU9CbW5OVGVSeVp3?=
 =?utf-8?B?c0gwdXI0ZVZpWGV3WjZhMTZId3h6Tng3WFBVWFhHY0NhaDU2U2NZUUVXR0Ji?=
 =?utf-8?B?cDFJckpPaDk2dHZnMUF1YUlhaFE1Qk52ZnE0ajA5RDVuY1JJTWtmd25sZTJP?=
 =?utf-8?B?TjBYWlBoRFZycTRTdm1RcmRDYXhFWExGNXFCeGduU2ZpMEJtZVR1bWtlSENO?=
 =?utf-8?B?dzhkNmVXZVZjRSt3K3dmL09wNWlBY251ZWdjU1JZcjcvZkh3dlBvT0QvbUx0?=
 =?utf-8?B?dW9wMUpSaFNaUWJ0WTN6alBnSzhzVVBIWVZPblhlaS8rT2xWalUxM3ZyT1Jh?=
 =?utf-8?B?T1EzcHZ4U2RsOUJOWGlyaEwwN1dIOTM1cGtSeEtoTGRMQXVMZmhEQ1VJYjhJ?=
 =?utf-8?B?RDN1RkgwOUZkN0U5ck85ZXFoZDlzK1A4dXh0V0ljYXAxNDBhMWQvdVBOd3N4?=
 =?utf-8?B?bk9GM2ZMTzZ2MXJnbGYwbDF5bmNiUFVQdEhzellmUGpKMitTTUNTc041TjZZ?=
 =?utf-8?B?NHRkQ3VBSjVkcG9sYlNvUjJWenRXQkQwRlJwMTAxVm4zSFZ3Zm4wRGltTXVN?=
 =?utf-8?B?UStJTGx0b2duMkF0MUZ5T3psNndXOHNPbFpLaWFzKzIvVWtCZHpTU2JMemta?=
 =?utf-8?B?UjkxeS9oV1dwQ0NlYXZ6NVhYeVR4UXJZeWN4R0JtclVVOE9VZTFoNlFrcmVP?=
 =?utf-8?B?OFNsOSs3NXl3NkRwQldVeTQxRDc2VndJZVRpblRtNjBrQmRXNVRham9ZRHAw?=
 =?utf-8?B?ejhtaHZSREptVmVPaVJWUGZ0K0tNbVBDN2c0L3Rwb09wT2Z3TFJwNjBMRUZ0?=
 =?utf-8?B?TC81YmpTTzFROXM3V0RVV0tncEFnYkNJWFMyOHV4OVZZTHhZMXpwa3VqVlZo?=
 =?utf-8?B?K3NkdnV6U2xIdjVlaGZDaGl5dnZnNXcyYlN5WFhMTEtXY25ibWdXOXcyM0Jn?=
 =?utf-8?B?S2xFMFJVWGxmS0k1cTVYSDMvYWRXeGZhTTRLOFhuWW45SnV5RVkzSkptUXFN?=
 =?utf-8?B?Vmw4QlJ0TXovUmVCajRid1UvdEcxcGY1K0ZWRXdJLys5ajY2MVdRYW81eXZH?=
 =?utf-8?B?cnpFTjdpZ3FHV3E3eC9qWnZWUGlDaFoyUnZneFJSY1VpSnB4bHh0VjNKblVt?=
 =?utf-8?B?R3pmQUpublBZWWxyZkVRT1hyKzhDRkxtd3Y3eDF3V3ZXZjh5RWJ1N3FaWThB?=
 =?utf-8?B?RStQYVRYVjUzYTE2ZDZjbk12YW1landadUVzSnlxK3B4eFFaSnRMUnoxajRN?=
 =?utf-8?B?MHpWOU9YUVhYWlpZVWZadnhrMkV1elBSZFZ3Rko2RFRMK3l6b1BiK1A1eDU3?=
 =?utf-8?B?RU5VZmRCZk5lS0NTNXVDQ2Q2dzJyMkNXYzNlbW0ya2tpaFlvOTh6RVRDTkNE?=
 =?utf-8?B?Uys1K05KNG1JaHcwYk5GNGVKS3BsTkhkRHBYYWg4T3NSa1RodDhCNklCalND?=
 =?utf-8?B?T3RvZ3IrOXRuaEkxb21TZDBlT2REWFpZSGFGeEJzbjZDK0JQZXNuZHZMV0d0?=
 =?utf-8?B?TDY2YlkrNDJkWEoydDZUMlBJRmhHY1FVS3dNU3JIem1qUEFHTTBpeWVYYUNm?=
 =?utf-8?B?dUJXYjJKSlJjYS94Nk0zNVlLai8vKzZRbUZmbHlXMW4ra3lzS2VKakptVm1H?=
 =?utf-8?B?SVVlWHdTZnh6YXBFTVNacWx1WGhyeGZ6RnR5V1pqV3M0My9veW9LNVRvMkRS?=
 =?utf-8?B?RzcyZjlIYm5IaGJTeWppTE4vckhiRkJNMGo2QS92QXdqZTRyLzdEc1d1MEJt?=
 =?utf-8?B?NmVvR0QxY2UwTTNiSmJ0RFRSUXpHS0txMGhkZDZxQnNzWEVWUi9kNnZWTVhY?=
 =?utf-8?B?WkdSamtxdjdEdWlzaXV2YjRUSjBkR1lvNVhscnJkcFJQSVNBSklneFJKbFBL?=
 =?utf-8?B?NytmVDFoTWcyc2psdzdmWHp2SnRFbm54TUFzUlVqNEp0VU1zUzUyeXQvMVly?=
 =?utf-8?B?OGdzL2lvTktPR1N2NzZwemVOU3Z2eUZQOWNDT2xZTnlFT1pFVzJjS3hkczVV?=
 =?utf-8?B?cWxFYzR4Y0pObkwwbCt0NjJ5ZDhYWmRIY2Z3K0F1M1JjTE5LNlU5OWtKTE5w?=
 =?utf-8?B?V2lnSS9tS3ZGYTJoRGJKL2NTdU5tU0NCL0F1YTZMTjFGYkVQb2xQUUlRQUlr?=
 =?utf-8?Q?VybMXhi2sqbMyTHFxGfoDK8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270dd1cf-db48-4074-5a31-08d9f07e6ab9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 12:26:39.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgIGgYPoEhjtiOMXklNDNVXcS6CoFhPlIe3OmMim+IcDTLoeBC3TciHxMnih8n+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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

In general looks good to me, but Andrey is the maintainer for the GPU 
scheduler now.

Am 15.02.22 um 12:29 schrieb Jiawei Gu:
> Add device pointer so scheduler's printing can use
> DRM_DEV_ERROR() instead, which makes life easier under multiple GPU
> scenario.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 9 +++++----
>   include/drm/gpu_scheduler.h            | 3 ++-
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 3e0bbc797eaa..4404af323321 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -489,7 +489,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>   			if (r == -ENOENT)
>   				drm_sched_job_done(s_job);
>   			else if (r)
> -				DRM_ERROR("fence add callback failed (%d)\n",
> +				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   		} else
>   			drm_sched_job_done(s_job);
> @@ -815,7 +815,7 @@ static int drm_sched_main(void *param)
>   			if (r == -ENOENT)
>   				drm_sched_job_done(sched_job);
>   			else if (r)
> -				DRM_ERROR("fence add callback failed (%d)\n",
> +				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   			dma_fence_put(fence);
>   		} else {
> @@ -846,7 +846,7 @@ static int drm_sched_main(void *param)
>   int drm_sched_init(struct drm_gpu_scheduler *sched,
>   		   const struct drm_sched_backend_ops *ops,
>   		   unsigned hw_submission, unsigned hang_limit, long timeout,
> -		   atomic_t *score, const char *name)
> +		   atomic_t *score, const char *name, struct device *dev)
>   {
>   	int i, ret;
>   	sched->ops = ops;
> @@ -855,6 +855,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	sched->timeout = timeout;
>   	sched->hang_limit = hang_limit;
>   	sched->score = score ? score : &sched->_score;
> +	sched->dev = dev;
>   	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
>   		drm_sched_rq_init(sched, &sched->sched_rq[i]);
>   
> @@ -872,7 +873,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	if (IS_ERR(sched->thread)) {
>   		ret = PTR_ERR(sched->thread);
>   		sched->thread = NULL;
> -		DRM_ERROR("Failed to create scheduler for %s.\n", name);
> +		DRM_DEV_ERROR(sched->dev, "Failed to create scheduler for %s.\n", name);
>   		return ret;
>   	}
>   
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index d18af49fd009..38a479879fdb 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -302,12 +302,13 @@ struct drm_gpu_scheduler {
>   	atomic_t                        _score;
>   	bool				ready;
>   	bool				free_guilty;
> +	struct device			*dev;
>   };
>   
>   int drm_sched_init(struct drm_gpu_scheduler *sched,
>   		   const struct drm_sched_backend_ops *ops,
>   		   uint32_t hw_submission, unsigned hang_limit, long timeout,
> -		   atomic_t *score, const char *name);
> +		   atomic_t *score, const char *name, struct device *dev);
>   
>   void drm_sched_fini(struct drm_gpu_scheduler *sched);
>   int drm_sched_job_init(struct drm_sched_job *job,

