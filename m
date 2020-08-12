Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D99C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7548C207F7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OGoyilBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7548C207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B938889257;
	Wed, 12 Aug 2020 12:14:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A23889257
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 12:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOHJxUfjhL4ErG+RE7zjUSEk3cnE+wLHweHvkdpStJI4L9BfKDI7ln3h1tXIjv0Y7dFDHHEJtMj/1lHIt68LVb2hsLUtqSKASdj2/mjc+hZLdmgVjyJLCh2/dZY6bTZtaKeBWzH2KaGcz9ELmci0xXjE59+GsimK4rOHy472l+WwX6MbXhjWHcljq1MzfAMdf5NCV+rpDELg8uUE9ibWRZl9FzFF1VXfGTam+/6u6912pND79+YMMKvjimkpAnAaLfiI08rxaml/q9Sf2hFVbD3WhsQnkuebxvp58hi6nCXmog+vXKAci39sno1FSPb7cOWgEeyQNc75shGH4EKs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3TTebfH/yfmJZioBBzCUlOzOU7nsIGkN1ieh+g416s=;
 b=JBLjbA0daC6t4ChLHPvDQWwjjqOF4kbQJM2/lvPlS0HilKjkC/GXtLlRXVAHupcMjK/zgIzZEhCRTZKqW1gAHUWh9altqkgkxfAwBkIshqFeU4EMlcZcAEBk3wAmqRuy0kAA3UL2/ji4MpWAl/8HqbEy0umeHmcsY6/dcc8z6pkCT2W2j+X+dG9GtEEDzsi0RafgeuOmWq8RxyeAE2tgErS1gRLXkDjTXKr7k/a/lRKEj8gTWSkE6Qq6wHc9FuOUFnqqYao1niEf2d7Ct+BqTCtNZhdQUEh9AWDmEDvEoDZUoxTBmTkuyNz+mZ+aaVy8igflVmTXr6e9AxggAdM1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3TTebfH/yfmJZioBBzCUlOzOU7nsIGkN1ieh+g416s=;
 b=OGoyilBH5UbBiPV6rZzWf2VFdKpIdcG6OQYlGZ6lCB/IxWfpc7h+soS7BcXDTX1nfmFBJTkGQ0OVpi8DVSOBc25CeL0nRZ6j98rJwYJSb4RZuOJHyWk8QmOJjpvzefLle2Sww04ov2ItvQyTWVBhd5CvZclGyJlG3FbumquKXSU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Wed, 12 Aug
 2020 12:14:49 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 12:14:49 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix repeatly flr issue
To: "Emily.Deng" <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200812091943.438905-1-Emily.Deng@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <71d5893c-453f-7c3e-7a20-e1234920dbba@amd.com>
Date: Wed, 12 Aug 2020 14:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200812091943.438905-1-Emily.Deng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::35) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.126.106) by
 AM0PR10CA0118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 12:14:48 +0000
X-Originating-IP: [217.86.126.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76da8972-dc75-42eb-9c21-08d83eb94f0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3708408C9149936FBC4545178B420@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqpqEcHkgj+dKelmFnbQ7a/uAciSIv1aZhvQ+VXtTLInG5aYAFqfkDulFspfIn+yx3hWri+sdzuL+n4uGoVzNXrUYeDP8Ag/pHDcKX/U85YnwquJQAw5Q0w5CNxu+Z6k5xtuAPtb/O7EjaX7pm9rLckoQtFh79Syvr/kgG1jGrG58Dwx1kVsUhIKC/nSOkgQyjFagC4nkRDAxLiK0S3CvZzDPh1kxUUs1xBHy1DpnmXfo1Hmk/hDYbFzQspj1S8JZnWhZnfNWROjq2L02VglwI8Vp0cY3U+X6RYuDZLWse0005fRwicu5KC5c0LoQzs4Z+lr1BrjUHjhMr04yBWuwX8xV/uAtqHcfC6Dmug8K5fvc3ttIRpJhdLFuJOGlmsK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39850400004)(346002)(136003)(396003)(8936002)(8676002)(31696002)(2906002)(478600001)(83380400001)(956004)(36756003)(186003)(52116002)(66476007)(66946007)(26005)(66556008)(2616005)(6486002)(5660300002)(16576012)(316002)(53546011)(6666004)(16526019)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AFLyEAHjB/YYCtsJLibyL7MoqI4D3wHyZkctFmCq46vSXDo5g81ml2M5h04Y9Q7nfutz5FAqBqVAwxDA3G1l5zQaWmOwLV1GPiD0mqwOLEHBtt1dFEroZq7nzSyFch/2YWbzqY5broULyE2hp0GsEawEKgfmLbdtInIrfRMIGWzb1k2nN8uXHAWVx68APMWVIxVlt3D5U+Mnp1wOHy4XTjWCGl7x6DBCqhKuJH8xPEGgv+tncc4MG6vuJ+NSXvuZlw6JsImdeMF5h10q7HATcy68HOObm6mAPMXfabUE+10LcLe2IAgVTJpXmYxTPtPNT1xFAxoZZPQlHbEz/a8LVW94cy2MhxNsSm+vwnYAYQaQ/3MteC/wlkY0dNBV1Wu2rMJ0NmygA3WpefNZbnBI9aLL4YWiOECKezm5QAiwcdESV5jRn1BWAwWIEQ8xi4eF8Dg5GXoBjeoah7OI8BCuRZ4tFplbawfO8vWdbf/igSLgAUcElCQJ0tS7vHh30CdjVkNbBLR2aeLMrpmjHO55gxf80IxnwnNOF5951T4nyLyWW+pF0/ssWq9x70+2mqVkJ6MkACORXM3sAc09DArtidnpYFoloWCu189ZhsZEcTWKWuiXv+h/Td1KEprvQozzmyWGm9sT6HF1lx4bxcvGQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76da8972-dc75-42eb-9c21-08d83eb94f0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 12:14:49.1410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks3QMygxPfErdU2DBW+OTNKMxZw2ZXf4eFiHpHpQO2VQWMuW6ofTwbN/nIf5DHqGbAXLqP0oFqTCfNetk2TUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/12/20 11:19 AM, Emily.Deng wrote:
> From: jqdeng <Emily.Deng@amd.com>
>
> Only for no job running test case need to do recover in
> flr notification.
> For having job in mirror list, then let guest driver to
> hit job timeout, and then do recover.
>
> Signed-off-by: jqdeng <Emily.Deng@amd.com>
> Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
> ---
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 20 +++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 22 ++++++++++++++++++++--
>   2 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index fe31cbeccfe9..12fe5164aaf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -238,6 +238,9 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
> +	int i;
> +	bool need_do_recover = true;


We should find a better name for "need_do_recover", may be 
"need_to_recover" ?


> +	struct drm_sched_job *job;
>   
>   	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>   	 * otherwise the mailbox msg will be ruined/reseted by
> @@ -258,10 +261,25 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   
>   flr_done:
>   	up_read(&adev->reset_sem);
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +		spin_lock(&ring->sched.job_list_lock);
> +		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
> +		struct drm_sched_job, node);
> +		spin_unlock(&ring->sched.job_list_lock);
> +		if (job) {
> +			need_do_recover = false;
> +			break;
> +		}
> +	}


This 1st job retrieval logic can move to a function as there are two 
instance of it.


>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> -		&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
> +		&& (need_do_recover || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
>   		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 6f55172e8337..fc92c494df0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -259,6 +259,9 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
> +	int i;
> +	bool need_do_recover = true;
> +	struct drm_sched_job *job;
>   
>   	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>   	 * otherwise the mailbox msg will be ruined/reseted by
> @@ -279,10 +282,25 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   
>   flr_done:
>   	up_read(&adev->reset_sem);
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +		spin_lock(&ring->sched.job_list_lock);
> +		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
> +					struct drm_sched_job, node);
> +		spin_unlock(&ring->sched.job_list_lock);
> +		if (job) {
> +			need_do_recover = false;
> +			break;
> +		}
> +	}
>   
>   	/* Trigger recovery for world switch failure if no TDR */
> -	if (amdgpu_device_should_recover_gpu(adev)
> -		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> +	if (amdgpu_device_should_recover_gpu(adev) && (need_do_recover ||
> +		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
