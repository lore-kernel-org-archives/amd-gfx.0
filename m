Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89049C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273A810E0CF;
	Tue, 25 Apr 2023 12:14:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6177610E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcoQWI4ZUXd7iUHrIIEcR/QxNWBRByKY5xao3e67ooboWUIMBKvNNJpFovxmhx9FNQ7avE8c38FKay7uwqcEq659w1ukpI41DHBGz1QiRgOWEROCXeK9Wa29xfhoxNoOItbEtQ0TzF9G12xnzk0e/wngXxDY0T8MIXdY8Q6j++7xDH8xHJVDysH3u5Ht7Ein5nCVbDkgU4GEJVxD0ZTBETGTY19MVpCDNTryjHQA79IWVd94qwxkMoXUNNy4JBX6oH97RMAgzRoVOOgSaqlPSsF0/UmZtUCwPmBprOLVgG/i3mugSdWpWGJA4Z7cMHcjS1/HvtrjRoUhPIRzTLjfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNpBLLXshaGzeeO+vYBM36MWcowtp7/9H4enCuatsV8=;
 b=J508tmYme1rw9GerF2zJbS3wfMzaiE4I4UL0HaYy1fGx2gmAq8lZnpGQ24cmAc7Nule09ewGPZUnyjIwLfxUpEiylprw42WZBB2i3rwgn+mJZQBLfM9eWTurKgqFNctVzjJYTgDR9gbl7BPhcrJhoyexOEA4a7SY85yoQAkXfoBXflK4ULVTeof4p9gzsWy1ebkJyEXxl1hMsWZD2r9CU/NN09Y54bp9liuMFboIj4lBcnqifzWO6pfrlNMT5R53ZZRSXTl7BKvuD8M5ymhPn0vQAuw7scrRPQlRQk6oydj50++jQC09UQz/SAso3h8cBe9Y1geam7DlWAb+UBMMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNpBLLXshaGzeeO+vYBM36MWcowtp7/9H4enCuatsV8=;
 b=Ll4Vm7EAINoBxIeRUGxqIirlAoOt/xhrQhIcnf+frx82nMQPedML8Lh5QQIspYxuCJfJH1tk8D1YR6BudW67cLFV7YbowICyf/zHMB6pFDJ0M+awcdVHi6spWcLtCAcpdvZhogRPYn+QXliKRWecICOyukz67o3vt/k71fIb+lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:14:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:14:19 +0000
Message-ID: <c5b6ed37-7488-c693-0607-39fa16bcf32a@amd.com>
Date: Tue, 25 Apr 2023 14:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 03/10] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7071a939-e6ce-419d-6f9f-08db45869898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvK59tY0S9BpBOxx+SEq0C/Eo8MgEQFZqb4dmU+1ViNqldxnYsCeB7n7bVuayaAl5K/bQlPeUo1YUPUjS6jozWSTpg1F7MeFKnPdj2+Fz6d0avWiKQsPBe4lnf7xXATnXwP3YvsAcmVrFS/un31sxsWsW/JfzVgBS560mUCWgZUBaVmrmKAD60/FGytpp9ck9o2l+jZISQhEIQjdrtkhcefXjMkd+lns7YxlZRHi0tRLlf0Xb8R09HUIcyT64UR1uAJy5KPp8TCDP/NwJG+o4XgRTEKMOxePaGwW2yBZcpJd+des1v1Tz0ytRR1mWIibSuqZzRtnmQcoF9bYFB7DawlQ8j+/ro82IagOgOWjN61YAyMxFOXX0oTWVNIbHhtkmjdxQ7ZcTSLxQTazmJim4OOvgws02CR5Zlm+KtQ1oTXJU2lV1rt89ycaPfPcapX+WZ6/HO7JK3oAjlBcsMK1uLnEqjhWlGsqJUD02IqPDuvj+7u5XA34s68PUIMKGZXmmUH3M/0tfupBPvvi308PN5rmijBV+x1C5DzNqVMuFLAXPuni208UvT369fhQHu+NoYRz4q54VsOkpm5WUE9WO6UFm2PpxxO6vHOTk9IcQ+1NjyBXc8nNr97iueSzwbtSCl48IbnJjJLAAnbFbAeUkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(6506007)(6512007)(2616005)(36756003)(83380400001)(186003)(38100700002)(66946007)(31696002)(86362001)(478600001)(66556008)(66476007)(31686004)(8676002)(8936002)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjI4c0NoUEEzTzR3TDhaNTcyVmVDNDNtY1A1RHZad09Fakx3OVB5WmRKeVcz?=
 =?utf-8?B?dWI1WENLSjZwd3pxdGUwOVFMT3M5bzhOcVdyYnpMTEdqREpVZVMxOEs0QXFG?=
 =?utf-8?B?Y1l5Ymp3eXM3QnRtcXIxb0xSWDFraXAzOEFsR09KbjR0aWlnbTVlbEkzS2lw?=
 =?utf-8?B?elVKMGg2ZHhLRjR5bHBEVzIzN1VRaFNmTTBqOHVrL2pFVWkxVlowcWNoSXNq?=
 =?utf-8?B?M0s2Qnplc3hDbmVDczZhUE0xVVo0VHJneFJCM1llNFQ1d1lFOTBDU3BPbWJF?=
 =?utf-8?B?SVR1aDNBTDY3eElOTENmemIrQnFmcnBiR2lYWlg4YWFOZjhlb2MzWFVUVXl2?=
 =?utf-8?B?eXJmVlJiUVp1Z2k0UTVGM28yeml6V2hLZE5hZkg0c3hwaENmMng1dmpsa2hq?=
 =?utf-8?B?dGJ5eElxc3MrNDd2eWl6SWJzeDlwQUZFSTdrbFg2MzdUOUlqLzlFRDhPbk9V?=
 =?utf-8?B?ZGNXZFVTbEs5dEhDeDRGVlhFNUJ6QmFNUG4zNU5hdUNCYXJmdlpnSTd3QUQx?=
 =?utf-8?B?MVhWMUQ0UktGOHJpUUJ4ZTc2eWtzOUVxcnFQTFpqOEI1c1EyUUY1dlJmU0hx?=
 =?utf-8?B?d3BaUk9ScVcyN2FqVGdtNEp1ZWowSktJaDJOamFsRXJSWC95eGJ4Q2ozN09E?=
 =?utf-8?B?dG5CcW4vdk9HVE81MzhpNXowb2p0ZU00K3I0ZWhxam5mMVEzTHRUY3B2OXF3?=
 =?utf-8?B?UmNFd0lqMGFzZUNyU1FlakNPQnRuRmFlL21YMnZodXMzMDZaQ2pjMHRVaFVR?=
 =?utf-8?B?b2FtRjNVM3Y3UkZQSlN3cHk0T0JpMzRWZDFsSlpVKzJGdWcrWkhKUUpWcjkz?=
 =?utf-8?B?dm9ZWFFrMzUvQmpxc0xkUVhnMW9XZU5LLzJ1VFJQR1pzNEFPU213ZzNnNlZN?=
 =?utf-8?B?QU02S1lsNlM3U0drQ3V6UHFUWXZRTjVTNVlzUGtvcUN5MDVmZzJ5M0IyQzRE?=
 =?utf-8?B?THFOZlE1cnJjQ2xVaHluM3loaHJtRlQvM0w1eDRCRDl2Mk9nS3JKMDYxRitu?=
 =?utf-8?B?NDlYT3FreVBEbXdnNXRIZ2grTVl4VXArZzJWT1AxTm5NWlN0Z25YcFpBUURB?=
 =?utf-8?B?SVBuN1ZIc1RKTEIwMmZqRnNYeWJnVFMxOVZTeWcvNG90QWZsMDJHaTdhTXI2?=
 =?utf-8?B?KzJPRGNDUjZSVVUyTmFDQWYrcEd1VkZTUU1RYjl3S1VLb1dMQjhiekZkVzJX?=
 =?utf-8?B?VnFpMkQ5TUs4bDRxUXphb01hbjRyMmFRZ0FlSkJ0NFFBR3ppL1VJVDk1cDRx?=
 =?utf-8?B?Z2pNZyt1RlhwVDdvcXN2WlBQUmZMYjh6V0xjQmRYemFPRXBQRDZabXFnWXZn?=
 =?utf-8?B?bzJTanZCZG5WcDdzQWRTN3FudkpPZUFYN0t3N0VvQzNiWEpaMXMzT3FzN2Vk?=
 =?utf-8?B?OC9aNkwrd0tweUlYMFg4TlQ1UHJlaW00aDFxTWZCeTcxRERURTh3clpxLzRX?=
 =?utf-8?B?QVVrb0JZbmcrSEZZN1hxLzVDNytVd2hvRWllVFVld3FtSks4R3FCT3IyWTNm?=
 =?utf-8?B?d3RRaVNOcnFWUzhoTFIwMFNtYXlvVUpWQW9vTUM4YnY3NTJsdWtSeE54emtI?=
 =?utf-8?B?eFpKRWFXeVBWendyTlBHbjJaU2pGeEZCZm0yaVVmU2krM1VvMnFJT0lVdHI1?=
 =?utf-8?B?TUZNMFdyRWtKRkRPVGYrSG42TW5mLy8yaE1NZXZEeXFid3F6a0RtR0FrZEVa?=
 =?utf-8?B?MnlSY2wyOWJ1R3BSVjh2cUdvQTdKVTZXbCt5Tlg2ejNkZWVBaEgwYTF3Tm1t?=
 =?utf-8?B?Mm56djB5Tm8wWG5tdFpTbHZ2RmZhQWVrdW1EN1QvSEdIN2pPb0owOVk3SlY1?=
 =?utf-8?B?ZExUSVpISlFNSzZja0g3Z21FdHBybzhITFBRTVR0cGJIcmdlVFFlOGsrZmdR?=
 =?utf-8?B?c1hoVHpyeTdIQVdoTjZyYkxXcXBicHVONzM5dVZzVDFRMTIrMzJxdW5vWG5v?=
 =?utf-8?B?MTRLd2o1MW9ibDMwWWVFKzQ5elgwM3QyOGhCRmlZYUZLNnJGcWRGT3BLYWlS?=
 =?utf-8?B?R1N4YTBYdE5FZDBJeVRWeUNyekVNZldDZ1d4SC9qVzBMcmlUMkpFS3F1N25s?=
 =?utf-8?B?cDg3RVlITnQ5WHJISnRXUUZQUGtNcHlpNGxJNk1TU1ZuTEQ2UjBDLzZxMEVj?=
 =?utf-8?B?bi93WndmYXowR28wUGhmM1hTd240cGhBWDI0NThJSGY2OFBqMHhpUHRmbllX?=
 =?utf-8?Q?ab/R6qW973KLwERZrgD31mfNBZ4BvQZXUc7QXfu5CxbO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7071a939-e6ce-419d-6f9f-08db45869898
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:14:19.3847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNlLpmensl37/3C5X76b7pxeiNnUsJJHhK0r54fhUEm+HOfSJuqIgAm6gf12o3cQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 126 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>   3 files changed, 129 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2d6bcfd727c8..229976a2d0e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2749,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index effc0c7c02cf..333f31efbe7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -23,6 +23,132 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_userqueue.h"
> +
> +static inline int
> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)

Maybe call that handle instead of index. And I don't think you actually 
need those wrapper functions, see below.

> +{
> +	return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
> +}
> +
> +static inline void
> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
> +{
> +	idr_remove(&uq_mgr->userq_idr, queue_id);
> +}
> +
> +static struct amdgpu_usermode_queue *
> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +	return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_mqd_gfx *mqd_in = &args->in.mqd.gfx;
> +	int r;
> +
> +	/* Do we support usermode queues on this GFX IP ? */
> +	if (!uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX]) {
> +		DRM_ERROR("Usermode queue is not supported for this GFX IP\n");
> +		return -EINVAL;
> +	}
> +
> +	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +	if (!queue) {
> +		DRM_ERROR("Failed to allocate memory for queue\n");
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
> +	queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
> +	queue->userq_prop.queue_size = mqd_in->queue_size;
> +	queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
> +
> +	queue->doorbell_handle = mqd_in->doorbell_handle;
> +	queue->queue_type = AMDGPU_HW_IP_GFX;
> +	queue->flags = mqd_in->flags;
> +	queue->vm = &fpriv->vm;
> +	queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);

It is usually good practice to *not* store those handles inside the 
object they refer to, background is that this always creates a circle 
reference (handle->object, object->handle).

Additional to that I would move registering the userspace handle out of 
this function.

> +	if (queue->queue_id < 0) {
> +		DRM_ERROR("Failed to allocate a queue id\n");
> +		r = queue->queue_id;
> +		goto free_queue;
> +	}
> +
> +	args->out.queue_id = queue->queue_id;
> +	args->out.flags = 0;
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return 0;
> +
> +free_queue:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	kfree(queue);
> +	return r;
> +}
> +
> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	u32 ip_type = args->in.ip_type;
> +
> +	switch (ip_type) {
> +	case AMDGPU_HW_IP_GFX:
> +		return amdgpu_userqueue_create_gfx(filp, args);
> +	default:
> +		DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", ip_type);
> +	}

Instead insert the idr_alloc() or more generally handle alloc here.

Christian.

> +
> +	return -EINVAL;
> +}
> +
> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_usermode_queue *queue;
> +
> +	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
> +	if (!queue) {
> +		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +		return;
> +	}
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	kfree(queue);
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
> +		r = amdgpu_userqueue_create(filp, args);
> +		if (r)
> +			DRM_ERROR("Failed to create usermode queue\n");
> +		break;
> +
> +	case AMDGPU_USERQ_OP_FREE:
> +		amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +		break;
> +
> +	default:
> +		DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
> +		return -EINVAL;
> +	}
> +
> +	return r;
> +}
> +
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 6fe5d8d73f37..8d8f6b3bcda5 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -43,6 +43,8 @@ struct amdgpu_userq_funcs {
>   	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *uq);
>   };
>   
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>   
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);

