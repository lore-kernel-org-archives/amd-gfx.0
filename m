Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83D8C636CC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AAB10E2B6;
	Thu, 16 Feb 2023 07:23:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5C010E2B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D48S49dLEKB1/xJnjLs90MzCt9lotAm1T2HAOiJwekzG0Vu2pqyuj919xeJeG0kaA6J1/o98bXn7VrdgPnyWw1U/uo9DTTT4WMdqGWABS/Zao1p4Ov+YFEmT7JqSs2W0vPdiXQ9N0bW16Di9zkuEc6hra4jfJtGn9F9YM/iBrkHIuNC+w9FscGN41fKgjAscoeby8ceN0KkGyCeI0r65df+UflX5mGntIfx6g3aYA1v8ppH8myZAMc9yo2K1p00DC+Ke/cMh7pCjT68Ez+Fm0Wnl/0ci8RQiwV1FoN16+7qbA8T1fwUu4aDomehtc31ET4eF0QDGBydAc4Bicz4k9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqez54G/fSuy2OuMjTVqFdBNHQoLOAJYXDndYuUJY5s=;
 b=WLo8Ka+Asyd+TOC4cELz/o73hpksifgThijXl+VO+00VIj/yDzTZrNRjEoSL4m/wMhU2WiTLmY+DrZXpAAUA9HvKyBAxAo+Oh0C371SHXJcG0AFAAOZCxlnJ6VnfBmvS+FdzWg7Ef+FKjpzv7zCt/UTVxdtQthwDMog499/JDXtDgdSHR6m4alOeyUJrXSrayKbLYIm1xpJ1/m6YJdhqRSPUbGiJpn1OtxoQVXglUXpVL9WhAM5J7fQqmBSsXoQlIHEoWW3YjdBSpztjaBPE+rGb4CARQ5yyRneQmPBKnwUbdHESz2U3nA62wgQLH4M4FCyJaYc4kNeE2yZhZFHMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqez54G/fSuy2OuMjTVqFdBNHQoLOAJYXDndYuUJY5s=;
 b=N8Y+ow8QLmW+kf+sv9VUMQn2QbMKzIwjiS++A/icRaDfCN49oJLLxyV/qWnWsPEcY8vxT5rVB5Ce/GG4EBsY71fYJ0nuvr822wX2kNVkTC0aHGuQjYIZREg0Wyc4F40BjZ16f2Z8UiGajtrkHWVlEqWRR5GYkOodctaE4evMJyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 07:23:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 07:23:30 +0000
Message-ID: <e4d4b06d-b51f-b78b-612c-870f9ec1f937@amd.com>
Date: Thu, 16 Feb 2023 08:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/9] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230215184356.2205-1-shashank.sharma@amd.com>
 <20230215184356.2205-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230215184356.2205-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebae810-54e8-4ed4-b18e-08db0feeb436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ouwe9/Y0E+9ApShdERYC3O1eLAaLkbNnSMv3qAM6iVobZ0SwQF2pDat4GtuWoRV4qEapiZ2x+QmDnS14/n9L82XE8RdTimSVRpja1ahAXTiq0UV0OiKKN75Wb3eZ94lAFYcnvJpVt0B2BF8CjoAAFPeRfNyWrOSZ8+FZT3l8TESFlC/KXXU35dIySzb3xTvAYwqT6VMaStZWF7Vwfv2UEHtAbxkSZiqcOlzNPoMw5X7Gwt9taH852ngoGmDl8U0yg09NnxNqccYVAbLNB72tkERhmDsnxTV2MkbrWTz8KLC3qRFBiZXRnRXt8z6CIMDGVIdO6ScXCa/yJ3ob5HeYjcDw38+L1C5honqmCDMJ+5CQ4xM45jOEe7r4KwKQPRWXUJ0rpRuyD67zZgPXSGRnAGRjtrCbyhyTyrm6kpUvtsFJhppUASbaSLIjWr2qqDV7dZa4K1qmdvHbhfZ2Esr5OlwiRD5T7E8Xxt4P0COf9SF1zet/rn8E/f7eJ9oisL9TiJ5ekXVnP1IbEaMRlSUJbTmm3jvTQf4+VsUn+r915eIpm7CAm4fQYjR53EXBr73Kk3Ikf3rRj+6xIzHw8qHJidP1iS7Ok6A5d6cpaeMey8vulNiSi1cI0wsGBEy2yIFQ6qJKdazPyYY7D6e4xWdY0o1dIT8kb3Cokox8wL5NJl1thjjPUdUqQj1FXSrM4C8Y8ZA9fyMq16D7LUqwMeuMWlzc7d53iltLeOYsJlEZHHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199018)(66476007)(83380400001)(31686004)(66556008)(8676002)(4326008)(41300700001)(38100700002)(8936002)(316002)(66946007)(54906003)(6486002)(5660300002)(2616005)(36756003)(86362001)(6666004)(31696002)(2906002)(6512007)(186003)(26005)(478600001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1GRnBOYkFMb2JzaC84dTNnL2lCUG5FOGJaTW1aK0RRVjJQNDlEZ2xVN04z?=
 =?utf-8?B?OFQveldybTZXRGtqdDh3YnBUT2g0S0JHM3lSM2JxaTBsWElTZllQZSsreXlr?=
 =?utf-8?B?NVB3Q0p6Q2VKczY5TVVKVGp0N3RCMU1uZ09YN1dUNW9CTFRWbkV4NVdZYWNw?=
 =?utf-8?B?MFlaV0c3UXJBaC9GTFRlRGN3LzdXcnNZTU11ZmNlK3VVWXpEMWNIdTM1ejZX?=
 =?utf-8?B?UEl1VXJiOU9WSXJ5RmNqSGlXNm5tZXZpMkZMNDNQeGlTTmFkbXd2VmdVS1lu?=
 =?utf-8?B?V1pPZFg4RkJXMEN1WUZUQndXY1ZZemNOQ01NZVJYSUFxSGZzYlVXWXNNZnJh?=
 =?utf-8?B?NzJ1R2xXWENMWUFYTnhtK1NVY2VtNUFDQ3ZiZXNuYjBXVmRXbTFwbjdBOGk1?=
 =?utf-8?B?cUF2SGxrbnc0VncwcEtDNVYreVJhZllDdHAvdys3eW1lLzlCU0FBRG5yY2lZ?=
 =?utf-8?B?a1cwZ1k1ZWFUbjBSTCtGZW5YeHdnREdPV2NrOUc0N1FlZ2kyQXBTa3VZb1pN?=
 =?utf-8?B?cVMydFJJUWZPL0xDcGIvbnp4N3VwdXdpSzcvU096bldHc00reTJ3OGhyaUlD?=
 =?utf-8?B?S0dqemhLdXM2TjBteitZMGoxVmJUdktPWk0wVG9meVdmRitGMXRERlduSlh0?=
 =?utf-8?B?d2ZTaEtrS1FXckV5UHJKajRzVk9xbnhwVWJtUVVucXZuMDNocGhZbFFQR3hD?=
 =?utf-8?B?K2VVZXFZQ05YVmdNd1dLem5tSkdQMXpWYUs1bGhBY2ZvTjVlZk1RR25Bc1Jx?=
 =?utf-8?B?aTQ5RWlmZUY4OGZGWmFEMTFxTXZCajFvTG1wTm5jdUt2LzJBNDRTYlZhYzNM?=
 =?utf-8?B?YXcvMkQxSzlYLzBwOUR4Vy96R2wwWlM4YWplQ1dnZ093dTNzTW5aUHl4U3lq?=
 =?utf-8?B?MzlBQk9uYnNIOTczZkpMNVR0ZUFoZGZBMVZiU0cwVFZET0pUQnkrNHRTNkwv?=
 =?utf-8?B?N0JsdE1sWjFiZU9XS1g2Ujk4cHBhNlg2d2lNdldYekp2a2NTWXgzZUlBQnY2?=
 =?utf-8?B?TlptVmwvVWh6UHg4TlFFMk5NaUNwTjVVQUlkeHRhZnlnZXYwUmVLQk5GWGFy?=
 =?utf-8?B?YTFmWkhUaVVhY05FQVFmczREYW4xWFBPNndLZ1ZpSFRZT0xSUVQ1cXpSRjNN?=
 =?utf-8?B?clJhOTJWN1duaUQybWEwTktpWVNFOCtSVnNKL1JlU0RSdWViRDRIVWY0Z3RU?=
 =?utf-8?B?RmtmZHdaVEg3MmVEbVVaak93Wk5KVmdBeW1RZG1DYWxtVG16UTJKRlVtNVZr?=
 =?utf-8?B?TE1hY1dMYWhFUUdtcnY4YUI0WEhFZHhmWTh1Y0h6TEE1TDVFTmszaVJYVmxQ?=
 =?utf-8?B?UWp5Zk5VcXV2RzlOT04vcXRCYlp6dWRQMEhoNlJvUFF2NVByclFTSk5GR1lm?=
 =?utf-8?B?TkRjMStTTVpLRHJvRXJXRFk1ZGl5T0hqYUY4dkloR0VXZ2NjYzcrS0NGVm5X?=
 =?utf-8?B?ek9pTDZvM0xpKzVERVgwNVJqMUtqSXNycEo4TkovNnYyMGh4Vk40dUJpWFNH?=
 =?utf-8?B?Z0dmeG1CTHk3dkVsNkVyaFlZMm1zNmNkVlNiR0VJQ21FTjI0YlhTQzhCKy9z?=
 =?utf-8?B?WmJsVzIrYklVbkc2RllEVkV5S0ZRZUliMkdPSWJ4RDFlZ0JSTmpCaU9CdlBH?=
 =?utf-8?B?VDJ2azRJL3NKMEJhd1lFZ2g2RlA1Ylp5bGNPQzZNVmxwZU1ja2RmZko3b2gw?=
 =?utf-8?B?c1ZOd253WTAzemphMzFZNGVSYzJDTUw5U3d0SkRhVHFQMTVIeHFCWWpmVzNQ?=
 =?utf-8?B?N2JDSmV0SkQ0N1FvWDdFZXArVGFTVVNOTzVWK1JZVnN1am5wUG1PWmF6WU5k?=
 =?utf-8?B?S2JRSU4vbWgrU200SGxGdGFYYkdLNGhvSzhveS9mV2Y4dGNCanBOVk1QZFlX?=
 =?utf-8?B?anZlcyt0bGl3WFFPM1Z4bWpqTU1UOE5SenlxU1lCcFZEY0VTZDlpYnUydmFp?=
 =?utf-8?B?Z3FmMklUbElma1JyZG96MzZWYTFqQkw2c1R5Zm04WVN4SkxWVVErc0VxODRT?=
 =?utf-8?B?bDB4eXVpMnNvSkMwVnhxVGNPaXFNaDI3eDVoL1M4NnJDR3VhVUNicXhmTWw4?=
 =?utf-8?B?S21XOHJSUGtucDVUbEdUdnpxQ1JiSm00MWRGY0J4OUZSaUpHYXhqRmUyNGRB?=
 =?utf-8?Q?oNQ+kwBfhOkNPJF+8EdkxyLH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebae810-54e8-4ed4-b18e-08db0feeb436
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:23:30.5829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L4EshZTDm0+wF+2AedjbaY2cAV6s/Gvaehto3n7bOmbEhgTRjj2Wrm3tfvNfxbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.02.23 um 19:43 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 114 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>   3 files changed, 117 insertions(+)
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
> index 13e1eebc1cb6..ecf31d86f3de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -22,6 +22,120 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_userqueue.h"
> +
> +static inline int
> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
> +}
> +
> +static inline void
> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
> +{
> +    idr_remove(&uq_mgr->userq_idr, queue_id);
> +}
> +
> +static struct amdgpu_usermode_queue *
> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +    return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +    struct amdgpu_usermode_queue *queue;
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
> +    int r;
> +
> +    /* Do we have support userqueues for this IP ? */
> +    if (!uq_mgr->userq_funcs[mqd_in->ip_type]) {
> +        DRM_ERROR("GFX User queues not supported for this IP: %d\n", mqd_in->ip_type);
> +        return -EINVAL;
> +    }
> +
> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +    if (!queue) {
> +        DRM_ERROR("Failed to allocate memory for queue\n");
> +        return -ENOMEM;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +    queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
> +    queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
> +    queue->userq_prop.queue_size = mqd_in->queue_size;
> +    queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
> +    queue->userq_prop.queue_size = mqd_in->queue_size;
> +
> +    queue->doorbell_handle = mqd_in->doorbell_handle;
> +    queue->queue_type = mqd_in->ip_type;
> +    queue->flags = mqd_in->flags;
> +    queue->vm = &fpriv->vm;
> +    queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;

> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
> +    if (queue->queue_id < 0) {
> +        DRM_ERROR("Failed to allocate a queue id\n");
> +        r = queue->queue_id;
> +        goto free_queue;
> +    }

Don't keep the assigned id inside the queue structure. This is only used 
as handle between userspace and kernel and not useful inside the kernel 
otherwise.

This prevents people from using it in hw communication.

Apart from that this looks good to me,
Christian.

> +
> +    args->out.queue_id = queue->queue_id;
> +    args->out.flags = 0;
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    return 0;
> +
> +free_queue:
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +    return r;
> +}
> +
> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +    struct amdgpu_usermode_queue *queue;
> +
> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
> +    if (!queue) {
> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +        return;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +		       struct drm_file *filp)
> +{
> +    union drm_amdgpu_userq *args = data;
> +    int r = 0;
> +
> +    switch (args->in.op) {
> +    case AMDGPU_USERQ_OP_CREATE:
> +        r = amdgpu_userqueue_create(filp, args);
> +        if (r)
> +            DRM_ERROR("Failed to create usermode queue\n");
> +        break;
> +
> +    case AMDGPU_USERQ_OP_FREE:
> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +        break;
> +
> +    default:
> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
> +        return -EINVAL;
> +    }
> +
> +    return r;
> +}
> +
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 7eeb8c9e6575..7625a862b1fc 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -42,6 +42,8 @@ struct amdgpu_userq_funcs {
>   	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>   };
>   
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>   
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);

