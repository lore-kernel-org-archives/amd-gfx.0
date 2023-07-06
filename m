Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2BBEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1B710E40D;
	Thu,  6 Jul 2023 13:20:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DEB10E40D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ0sphFVhdYEvOY695J8E8rUU5L3pOU0clDxoiSkmjn+LmI7dBIuARCLAIvABBUJOAo9XxUMO5Yz4MzQn+xu3wEd59fpQRvx6Wcg2eeUB2oj+ie6bupV4KNyPwOe4U9B6ewrqJ929YStNZsjPvTJNHojQ6qsQYtKwBIZY9dSeevWBPicd49JXXkMlcx3QSGOyPueafCwBwSUZ2/CTjRcsTZPqqxoKdl2oRDGX6Muqmg7xHF1wzbn96YTryjpV8ASyeQ/nN2qbjEH1kaddjPlf20OZMNSnOJAKsiL+/DjqLsfzer+OwCukXFvV4f31nPoSxWB9MuUxK+bo/oZhElyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py/yy3bzYz6l117kXcmEbYj+AudwKO12+RBv4wjsGMM=;
 b=eH0hXV6fFdddl3qHnZBsNyKsDgIsSlyqoaOzR3anRfBo64YVx3IwiXAmhtiR2xwWxb4iGyq3X4tuq+/9zRhocSipF5PZ//i1fzMCBE+7PIpIuGAmev0PGwaip+PaXN/eH9elqxiLDuxhfvPhVmk5TEEQDza2VEyrCZGP40vYwqBqYHeZzo4a24RHRdyFQcqKd3g0ITgNQrUo4J2XUE4G89JiGOlNYDVbH5DRBM41lWlF8MlNsBD2UiPFXhLkwkYVKwECh7gcJc2lx/jyJZ3uCEJjtwUkZAeb8cRtUlsffTvd6ZTdLTeNeArtkMJ3qhoH0WolzeUFTi21l0TuNonSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py/yy3bzYz6l117kXcmEbYj+AudwKO12+RBv4wjsGMM=;
 b=LXHm3UaRcfxdAHdf31D4sfb3Wa0rVOsQspbDSouQVylt+Guvcie8jpJZ7EsfS17YnEYuUhUagePNoSCGDvNRyBhXe8Hhd05NqMLBCqrjtYETlmQ1rL2+Sn+7GXp36jxap45u3ZqDP97DCWfI8lQMLqD/YXxK2QeVNffmw4BuE44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 13:20:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:20:23 +0000
Message-ID: <b70d0fb7-f405-51c6-58fa-a28b59a6fc26@amd.com>
Date: Thu, 6 Jul 2023 15:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 03/10] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6602fc36-916d-402d-03f8-08db7e23c148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/iVBYd5Ks0o8YdWImpv9dKkA3mBDDAyNNSCDV5b1+7TBtVkul6ZxZnRB8g09e2Wf4Iwd+MbAVzU0V/bxMGOFEtYRjgabVTtGX9JhV+nl3GitSANqCV5A6wSu5owx2LoPa0nKo/reff/KlOGfP6N48Noxvp4bAkTt+/FHUez45VDpnM2JJou+XZlrZoHoaa92ZaeNMPUidlhSbwMHc6O/fI5qjBva6jdg8J+Z1uHRz5jT37AX897LlaFcyvTbkDMiUi1xSLZ/JgeyXU9cUJgT0Fl2giUshvme/d9i5NuOcn4jwW2lBJEn268Xgf60qUvbvMWRI/Btemd7hU2jSQqStBbvmmzISyelPBLzA1oecQA7ITGopkJ4FNjwugyrs4Ad/kMPJLTWlast4Ay2FOaDVqbqFwQ2xX4LWxFMYdm2SL5AaDn7zR4l7FX4HAQlZZOrSlUHUzjwxfkZL1gsQrjwpbDyI/f+s2gU6Ie7yVyEWLs9z6U1Azvt38jxRaF5QSfgMJC6pMemqog7aCRpevlb4WQKslLp8tXVchJCwAkMi1SHHgV48JKzG8K9pvKIKF9X0WbHiYn3fbNf9K/GMtbM1O7djs2ASMHXRNRy+bzYFPEGb3GmWalCjqoX/X97tEwJn6jNXoU5B5haDRrLcDfXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(83380400001)(31696002)(36756003)(86362001)(38100700002)(6512007)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(478600001)(316002)(2906002)(4326008)(66556008)(66476007)(66946007)(31686004)(186003)(2616005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2pEdVBWSTJUYkcwRHBYMnZOMnV0SjROa25FSFdXVVh0OU9IdXN1M2FTVUFS?=
 =?utf-8?B?OC92YXdGSG1TY1JoMm1pNUVJOWhuSEMyR0NoUUpsamI0cE9GZGFkQnZYbU5a?=
 =?utf-8?B?V3RRbm5jNEIxNVlXRTJ5Y3RiSEFxMUdsRzlKZWo0aDI0VFA0Y0hzS3VhWDBS?=
 =?utf-8?B?RmVPdW1ab01KOFRrWkpqTDkwWGdDMjYzTEh2SXFGaHNJcSt3WlFra3BZRmhC?=
 =?utf-8?B?TDRBTDdCZkE5dDZXYloySTJtbkViazFVdG9QOVFiRkFVUXB0VFZKRDFPRFQv?=
 =?utf-8?B?VTVhUFdoM2VTaGxjRlhxdjJRU0J5M1B0dFhLeWNXUm5neEx3Y09TcVhaRitK?=
 =?utf-8?B?YzZjR2tFa3JEVU05aTdUNW8ybC9SSjh5ZGlmUnVBRGpUMmlsRVNISzVWRHQz?=
 =?utf-8?B?ZS8rNmJCZkMyRGVlY3BkbGxyZ0hBVjFJazFMVXdUdTZDV050eUpZTkFiTHBq?=
 =?utf-8?B?UVdUb1ZZcjFGS2I4ZDNISlppRTVVMXBBU0lQOUV5MUpFSUN4RG85ZlZpNUM2?=
 =?utf-8?B?MXRlV2RGTHVGbWpwVEtjSnBvRExRL3owWWQwTDVNcnVDTmdEMW4rSVNvNERH?=
 =?utf-8?B?Nmt0THlkbC9hU1oyREdGb2RiN1BZbnE4dXI1ZjVQYU0weFI5VzNTZ1FhOTNj?=
 =?utf-8?B?d0ozSnRHRHNMVnNUc1o4dlFUZjg0RFRiWmU3blBLT3ljWURscUF3VUpkUkJU?=
 =?utf-8?B?bkttWURvaFd2cmRDejVrdWhRdXVLcUJ0RDdkWklPa25wbTA2dmFNY1VMVmpV?=
 =?utf-8?B?d1FwMEY3K2lPTnBvZ1I5eXBMWHpVV1hSMFZac1gyVElYRlg3aVUwRnZQekFN?=
 =?utf-8?B?SWhObVNyVEJXR0tEY29zeUNrQTJHRDJxN0hmMDZxUjlMS3pLSzdlME9DTWZK?=
 =?utf-8?B?akZic0tuREJEbkthdXVqWjkxcXB6L0hlT2ZMWmFmbU5DRmQrVXZyQzY5M053?=
 =?utf-8?B?a1V2U1lBMDdOQmNlOW1PNkFTZFY4dVlKRjlFU3A0QWxTam1yWittMzN5L2hX?=
 =?utf-8?B?UXpzSzZXdFBuSG55WlNia1hvVllOL1ZpcDVWTmdBSzZuQzZmQTh3OGFSUmhp?=
 =?utf-8?B?dWF6SWJ2UlNSVDN1UXAza0NKQnY3T1Z2ekY2N3RWblRIUXlGaGM0RHFFL2NG?=
 =?utf-8?B?TzhUZXRVNEhvNEY1emVmdjY3OTVJdDYwNWh4QlN2L1dYS1ZzQlFHNTVtTFgv?=
 =?utf-8?B?ZVArdUVhaTJiU3p1Q0hubEJBQ2VQNDcvek1EMnhFc0VDZ1dOYXFWZnZKZk9i?=
 =?utf-8?B?YnRxRkdubXQ5S2JLdWcvUlVsR0RXTmhzUWJob0hWZ2h2QjNVTFA4dGU0eTlD?=
 =?utf-8?B?MEMyQUlreU9uSlR1SHRxRmdBbExvNDhuL0ZPSDI0bXA1aTJXdzlIeVRQR2h0?=
 =?utf-8?B?bXg3YzA1eDRxUGxSSHJxQ1kreHdUTXhrMHFxMlR0YnFpTzlFUUtBQXBpWHRw?=
 =?utf-8?B?SFFneFN3bnRYZVlGUXZNVW1NeXRqOW4wM1M0ZGxTTzYzVDNRem1mc3pnT0Jv?=
 =?utf-8?B?MXFFZnRuMXgycnorWWoxaXJmOWljQTIybDA3dkxNZmlXZEN5Nlc2cW1BUTdB?=
 =?utf-8?B?c2hKWUZTL0phekJCd1Z5a2pRUHlnMSt0RWo5RmRMZ1VLZUZKaGtxZW16VEhH?=
 =?utf-8?B?K1pTY280OFExTmlKTk1tTmM1ZUhzdXE5T2VGNUliMWhaSW9rUHFJSHRDdXVm?=
 =?utf-8?B?eVJmWVBkbG9ldUFGRXZVOExOb0xNdlBrZ2V4VXVxVHM1Z0l6VFYrYjkwMjVV?=
 =?utf-8?B?SVA3UkdkMU4zQW1zak5FcVE0ZnFzUjhFYTZvT2EvVCtmZkdmVGJBNEt2T2ZW?=
 =?utf-8?B?R0V4OUppOUNEUmRLSkJOYlFsSzd4Nk5FS0tUalp4U0wxKzVjcTJxUWlsOVlP?=
 =?utf-8?B?d2lDUlBHc05lQlVRNytNdnU3bjNMd2FGaHdWNnBSSDF3WmVYalZ3L0ZOb0cr?=
 =?utf-8?B?eFJnV0hobmRtVVlXMzc1VXJNbUk0aXNLcXFLcEM0bUQxU2E5NlRUYnR6OC81?=
 =?utf-8?B?ZUh6YVdybGZuVGtCMGc4QzVCeVdVZnhUYUNQQkpzQk1XbjJoaHZLdDk1dUY0?=
 =?utf-8?B?OGpYZ0NlWEFYMmVoRzV0YlB6a0VIei8rK2Myejc4R0Rlcjk1T29wNEdQeFZI?=
 =?utf-8?B?bmlreFQyblh4S0E4dE5sTnA4NUJMZkRHYmpJYVdkU1lPZWJkb05iNW5rVXZH?=
 =?utf-8?Q?3M5DggMwyR/qo4rnApGulhzevkyq7zXuSdjqKieT/cyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6602fc36-916d-402d-03f8-08db7e23c148
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:20:23.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3OQgm5PwJXxjkcXUr1HiSwMjfEyUKPS5KhSXIERXxpPla/dwtIZOZc/Nc3D82Vv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

Am 06.07.23 um 14:35 schrieb Shashank Sharma:
> This patch adds:
> - A new IOCTL function to create and destroy
> - A new structure to keep all the user queue data in one place.
> - A function to generate unique index for the queue.
>
> V1: Worked on review comments from RFC patch series:
>    - Alex: Keep a list of queues, instead of single queue per process.
>    - Christian: Use the queue manager instead of global ptrs,
>             Don't keep the queue structure in amdgpu_ctx
>
> V2: Worked on review comments:
>   - Christian:
>     - Formatting of text
>     - There is no need for queuing of userqueues, with idr in place
>   - Alex:
>     - Remove use_doorbell, its unnecessary
>     - Reuse amdgpu_mqd_props for saving mqd fields
>
>   - Code formatting and re-arrangement
>
> V3:
>   - Integration with doorbell manager
>
> V4:
>   - Accommodate MQD union related changes in UAPI (Alex)
>   - Do not set the queue size twice (Bas)
>
> V5:
> - Remove wrapper functions for queue indexing (Christian)
> - Do not save the queue id/idr in queue itself (Christian)
> - Move the idr allocation in the IP independent generic space
>    (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 110 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>   3 files changed, 113 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4c5e44d41652..43cb37f097af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2786,6 +2786,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index effc0c7c02cf..e37b5da5a0d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -23,6 +23,116 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_userqueue.h"
> +
> +static struct amdgpu_usermode_queue *
> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +	return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int
> +amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	const struct amdgpu_userq_funcs *uq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
> +	if (!queue) {
> +		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
> +	uq_funcs->mqd_destroy(uq_mgr, queue);
> +	idr_remove(&uq_mgr->userq_idr, queue_id);
> +	kfree(queue);
> +
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return 0;
> +}
> +
> +static int
> +amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	const struct amdgpu_userq_funcs *uq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	int qid, r = 0;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	uq_funcs = uq_mgr->userq_funcs[args->in.ip_type];

I think you need to validate the ip_type here or otherwise userspace 
could send you invalid values.

> +	if (!uq_funcs) {
> +		DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", args->in.ip_type);
> +		r = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +	if (!queue) {
> +		DRM_ERROR("Failed to allocate memory for queue\n");
> +		r = -ENOMEM;
> +		goto unlock;
> +	}
> +	queue->doorbell_handle = args->in.doorbell_handle;

That doorbell_handle should probably translated into a doorbell object 
(BO?).

Or otherwise userspace could potentially do quite a bunch of nonsense 
with that.

Regards,
Christian.

> +	queue->doorbell_index = args->in.doorbell_offset;
> +	queue->queue_type = args->in.ip_type;
> +	queue->flags = args->in.flags;
> +	queue->vm = &fpriv->vm;
> +
> +	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
> +	if (r) {
> +		DRM_ERROR("Failed to create Queue\n");
> +		goto unlock;
> +	}
> +
> +	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> +	if (qid < 0) {
> +		DRM_ERROR("Failed to allocate a queue id\n");
> +		uq_funcs->mqd_destroy(uq_mgr, queue);
> +		r = -ENOMEM;
> +		goto unlock;
> +	}
> +	args->out.queue_id = qid;
> +
> +unlock:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return r;
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +		       struct drm_file *filp)
> +{
> +	union drm_amdgpu_userq *args = data;
> +	int r = 0;
> +
> +	switch (args->in.op) {
> +	case AMDGPU_USERQ_OP_CREATE:
> +		r = amdgpu_userqueue_create(filp->driver_priv, args);
> +		if (r)
> +			DRM_ERROR("Failed to create usermode queue\n");
> +		break;
> +
> +	case AMDGPU_USERQ_OP_FREE:
> +		r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +		if (r)
> +			DRM_ERROR("Failed to destroy usermode queue\n");
> +		break;
> +
> +	default:
> +		DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
> +		return -EINVAL;
> +	}
> +
> +	return r;
> +}
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 79ffa131a514..55ed6512a565 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -55,6 +55,8 @@ struct amdgpu_userq_mgr {
>   	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>   };
>   
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>   
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);

