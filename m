Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D647C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 12:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E3520706
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 12:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Htvy5BjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3520706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4CA89D66;
	Tue, 18 Aug 2020 12:49:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C31E89D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 12:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmQLZzdQcnj5X57BzWGoBZiTcOQho5pbNT4C7T4ZXvH/iWVobFbdaLNo4LtrUoM1WkG5QcO4kWoOZLzKB6oF2i2NtxK2JNSksIewdrSu6YQoD18J8r6aKN9nVzDGCYOJCbmHnNezaeTnR6awR/h1kU3aX8LI+Kr0DTVe95r30iRyCWZ3aQMbTpT/qQz4/Cbg5x00IJPnwerrehl2lEwcTBwZIuxOTTBBFQ24JfV6dbfsw4do16BzLjNR27BsoVrlnBkOY+P/zT6qvnylpkjUg58XWHElPZDe1ekP4feK24DnEp64rr3CYuP74k5vuXiZZE3DtMr0o/u4iXKuNp4vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmwP/etYRJO9wG16CuzhsXL2f4NHAhiW5T6Uua4w2pg=;
 b=Wbtv1sKu0t2pLwHGIrruvdzNIC9STQlz45bXJzr9QdmpMvta0bWt+IWBCYB38r9Lce1c03+1Joido99EjZ2YgDVH5JbZKlG4LF98x7FfoJvkQwZAQ9lvVxJG30Bvz5JbS2lsechZSGhkZM7396JMVCFz/43O8N20OHH66cqDwAZ4yotf8QiOHH122B3Gez5saANSiniluVIGz1bGyeNtiu/pq0s07n6JS7+6uWxzkPFQsjN1KUHzsPYADzoCvKW3lZTE102hcluedZQid1ibXwv2B+s7AmdgCefcPoRJShWAWX8MMPAEqofS34foVAf/0HfFGXr80MhZmzmTDD1Q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmwP/etYRJO9wG16CuzhsXL2f4NHAhiW5T6Uua4w2pg=;
 b=Htvy5BjI8x+1qAcjDk6aTQ2AKRePfK7aQCKXk+9Cvuhj/8/LrHDFpdya4JEPiIFf19M8BfM1QGTj277D3uaFSirjuf7C01oTGPO2yFXIh0hfiVH1Ri7+S0nSrK5KxVzDsAI784aJ9l6FyN19PLhKyJtUQS2QXF4E7s2UZMQPzjs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Tue, 18 Aug
 2020 12:48:55 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 12:48:55 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix repeatly flr issue
To: amd-gfx@lists.freedesktop.org
References: <20200818094144.378857-1-Emily.Deng@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3378dc9f-e88d-f5bd-c1cc-c5984b6f916f@amd.com>
Date: Tue, 18 Aug 2020 14:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200818094144.378857-1-Emily.Deng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::40) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
 (2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69) by
 AM0PR07CA0027.eurprd07.prod.outlook.com (2603:10a6:208:ac::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.15 via Frontend Transport; Tue, 18 Aug 2020 12:48:54 +0000
X-Originating-IP: [2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e997a463-9ed1-419f-33d9-08d843751102
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-Microsoft-Antispam-PRVS: <DM6PR12MB370810E65B55EE90E3EBB5138B5C0@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNkzdNHnxslkdGrNI6Snk0ucBkntXJ7lbDefFl0c5wmd4bmn8XPxJKsf+0TRe9FZlykPM1w7yFaqIAeE2u1Ord33DFCk6up6jXCsu2NzkAvYA7WEed86NMyGh1ufPUC6I5acfVw7K3MDiZB/vFzeaz8/vLxck62lbxlY18f+Iwb/LJPDPA39ejNmjGL5VAqKafhrKKP23MEBYSF3rfZbOXDvVH+vOq1aOabjarMjUOSEaqLtYKkzNRt2HHtUR2bXITw0Gg4u4kg89wnuJbg7CzZXilinS6w9SFHu8kdGgpDG1MRmZDZd2OgG4XhognpH6vcAO4AAfb4147TugpgLjuHjAFi9JhLkNkGRYE9Q8svuw3xwobosI8g8HDMfPkpJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(186003)(6916009)(52116002)(36756003)(31696002)(83380400001)(31686004)(6486002)(8676002)(478600001)(5660300002)(66556008)(16526019)(53546011)(66946007)(8936002)(6666004)(316002)(2616005)(66476007)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JvUCCIqIiyIkm98Z6zxM2irUoiBY2VW5MzAfjPyVBlDnQHD8aoenTcxp0GO935gYgV2zWH40NUU96KgQh1Ol1q7CZn+8gCLX2LEgEpaZ3QhbPv/vQiby9sOhvLl0NewOB8V3cwg1SVdnD2GW9TsUglL8g/IC4ExG2pgoGxrrUu5ZmDdWvbKdTYslA7CKeBoF1Ae7RCjmBQ7gBVAStCI3uhmnz3QYJO8ydlmQkdvqHtDYBKj8vSxmZsXXizLxJ9oOaqyQVuUpgaERMmb6CRQTBidePu08JdzkAy+VXvk/EFyzfJQ5Zz3Uk/o4ncD/nK2aZ5H1LoNVuzfmDa3jV52IQ1IACJ0PoJqbdwzitAc5whwR71efLX3DvvyP34YuHOoyZ+vmumGdd0Vj040rJUeyWv8I2mKWehJzdyqd6ghkOLJUvSPFnYjl7UaU6aVUj8GAm+srp+Jd7Fm+qvP63pGYkGOAloXEOaIATmzBz1RLcFWKBPJUDJO7sqxm0DxuWab1kf3GBFTTqM71oEn9Ipl/l0IsG0CrOSaDDKvCVPCHyp7V7aV5onopgY2i5qkxGUbEBxI7IXMyPuIzxkuVyZxLzJVn3Pa/T8VUJwkiRU3GvgnLb0cXFQYd8sJrod24w74pJPXgCs1MQSVcV4XbGPxH/UPDkfTop5uki1u9BU75Ig9NYA91yTEgGy4ukalb+uCqcNlyOmrgapD458BnJz52Zg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e997a463-9ed1-419f-33d9-08d843751102
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 12:48:54.9606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+6isBfWINTaiD8b4FDqdcoKr5jtlohx6oUVefJwKTgkWkcvbs7Eve2j3Y3LNrxR1s+p5r8297f1Zlcd1jOvWA==
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

With below minor comments fixed, the series is Acked-by: Nirmoy Das 
<nirmoy.das@amd.com>

On 8/18/20 11:41 AM, Emily.Deng wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  4 +--
>   4 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f9d97f61aa5..69115781be05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1136,6 +1136,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
>   
>   /* Common functions */
> +bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
>   bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
>   int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			      struct amdgpu_job* job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fe8878761c29..e17f632efd07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3925,6 +3925,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_device_has_job_running - check if whether has job in ring mirror list


"check if whether has job in ring mirror list" --> "check if there is any job in mirror list"


> + *
> + * @adev: amdgpu device pointer
> + *
> + * Check whether has job in ring mirror list
> + */
> +bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
> +{
> +	int i;
> +	struct drm_sched_job *job;
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +		spin_lock(&ring->sched.job_list_lock);
> +		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
> +				struct drm_sched_job, node);
> +		spin_unlock(&ring->sched.job_list_lock);
> +		if (job) {


No need to have braces for single if statement.


Nirmoy


> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>   /**
>    * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index fe31cbeccfe9..bd4e7c2d0dd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -261,7 +261,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> -		&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
> +		&& (amdgpu_device_has_job_running(adev) || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
>   		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 6f55172e8337..d5c14745a9d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -281,8 +281,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	up_read(&adev->reset_sem);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
> -	if (amdgpu_device_should_recover_gpu(adev)
> -		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> +	if (amdgpu_device_should_recover_gpu(adev) && (amdgpu_device_has_job_running(adev) ||
> +		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
