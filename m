Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 11:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E70206C3
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 11:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uRh8TdW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E70206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AB26E14C;
	Thu, 11 Jun 2020 11:56:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFFD6E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 11:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ8VxaYomZjAlLW6LDB5gyBAKAUA/Ezdz/Xe5N9hBtu/BVK+AAcOYapoE8zQ7o4Cbhl1qNvxxmeQS0qbaLfmgz+c0u3cfB454RtLmHU9XV/Qa69bRZuYhGcs52JS7mobTSpl5qvsv5bkMAeJeaangHP9k7bsmGpBeiMnj/vHG253z8FDdtEFQyGg+B5yRAdA+8pyfdsk6NzdAyKdCA1j28MFUmJR0plKgSU1a8c18A4alfRFqx/1qkED6eP5dqT7wQ2AdGNN10vndOChHksb+sQx9x3dZfHhoyL37iB4ke9BGfkP31+dCz5fP2I8a3FjZ5i9BuTRbWTGSwP263rtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6bCaJiQOXEIrbRvD/VZhiNSinA0aj8OAdXib7ctPFo=;
 b=hAaV6n4ycDuB1K9ENKU1iaYpBzFtsj56oFV2Nvgt3WwOW5BsideyGbppUPPOFM14aRGv0blwHIVhHORRQjMjP3tThXhVbNJQMSZdEcZ5lhC35bQ0ded6gz/A2qZy6C1TWku4s/oa4PemTxSt9FAU7ZvRI2VeNkV82yN1KYUfZQ3WyX86xHDEQcHyXOrmHJueb08yexGl9a5Lj6rtktfzqrw7o7KsLwrus6BEWJQpDgq/rp7f3fJ5J93qXxPLetKzbsW4iSgBEpNtqAM72+KmZ+QW+IC64EFBlE7rF2zdMTYWeqlj8YjnN1e2yh8kRltwpWW3w4BArHYpLWFesb3dkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6bCaJiQOXEIrbRvD/VZhiNSinA0aj8OAdXib7ctPFo=;
 b=uRh8TdW53oVvKMQiqjw1DXDybvSgBQqF4lZ9HPTLzbeBjZ/wZq+oJn1n7rSCz8HvW8FhPakNLDuEJGpbhHyCyeIlWLBF2ma2srhhkufzWvohdEtnM3OZl+tXx+M0zrFykYCUqA4Otsa6JTDnkEDMZ5DnyA9zBRGJacZBccZN9Lo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 11 Jun
 2020 11:56:08 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6%4]) with mapi id 15.20.3088.019; Thu, 11 Jun 2020
 11:56:07 +0000
Subject: Re: [PATCH] drm/amdgpu/jpeg: fix race condition issue for jpeg start
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1591806961-11227-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <a447f921-3d6b-ae73-b140-591f3e2e8de1@amd.com>
Date: Thu, 11 Jun 2020 07:56:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1591806961-11227-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:48dd:8568:9c1a:35ff]
 (2607:fea8:a200:445:48dd:8568:9c1a:35ff) by
 YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 11:56:07 +0000
X-Originating-IP: [2607:fea8:a200:445:48dd:8568:9c1a:35ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0d2caa8-db5d-494f-54ef-08d80dfe6d10
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1916B2C94B9E769AF12D4B32E5800@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3ovnzgMN2YwoSndrWBLueqv3nHmMeN54E6pnXU7wLNk4xmacjIw6sQHLOIewWeRJnKFgogY2g6utKycbqEhlg+uUtGRugYCINwLbB3P5h6n8Xd57W6tHCPrdrbjgO9Q+MOVfQprKZDzAqSc8jlDhhFKU96AVbvW08p+/HwnP67PxS6lAsm4gh/9Yha0WL2+g+fPVpgL7v7+Z0534zDwrEHpC+IztvYaJoFwSIT8Z5TEsvyLalqaCJ1hrhGz9gTi8MoClX/zXCj9kgJj9ATq9orQYlb4as/htnTFmrFyI943LJF1+jqhl1Hw+HuV6cdj3+KtffiasD/9Pb/R7sxmByBZc7eIfPHKDywEsBLYvnMmxUbGmz1piPwKy/RwkuNg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(5660300002)(2906002)(8936002)(8676002)(36756003)(66476007)(2616005)(66556008)(31696002)(86362001)(83380400001)(66946007)(31686004)(478600001)(6486002)(52116002)(44832011)(186003)(16526019)(4326008)(53546011)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +euSmqg4mN/UcvJJcErdr6a1PTads5+PHQQHQ13dUP0JnGyh0S4rtzJtnteqoUKvTLS9/nbch8Rx4YkdgiiaZ9r7O1xD4nIJ6E61eRgeGhAuh0qFzpLmvZGcqBgYCtvXkesYLTkL3FaxSzVcf+v3UUjK8pgXmwXoUz64YJcyLhNer6bOuX1698gFUraY3Ex07by73/sN9obbR1EZJpRq/w0nbUuFJBH06venFDP6VtRkeP02jkEf9t8SAVi3SqwjOScbW/DlPMqp2SLqX8MdkCLMbPCzBYF6rhSy5Umht2YkARYAzL/p5AqY2ZNRSwDQ9iyUkQjWY00CjwqBcivZcICph3i+ZmJsh2V5RIkXa9mZRLp1BPnnHHLp3W+mFGzmlZqvMMQjZ1S0nK4ct902rsmHqRognZgZO79WOHwQ9MzhgLXCfabx2GyBxNPLpH2pcFYxRS7+UnZYgxc7YRipUQ1ReINQEBCdwefdmMEHTDmX1wtUqaVHebJSpktPZmA6xl/v+haCFLLTvnNE4JA4xLMP4CE0gWRqJds3T5KWlkiIQfOEJAbHN9tzc5HPDD5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d2caa8-db5d-494f-54ef-08d80dfe6d10
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 11:56:07.7885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWxAAFSBot3BaaxJyGmN+xlM+YH67GcBlyQDKT+6562tv2bVGb06QMoGob1kHxpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-06-10 12:36 p.m., James Zhu wrote:
> Fix race condition issue when multiple jpeg starts are called.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 16 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 ++
>   2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index d31d65e..8996cb4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -37,6 +37,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
>   {
>   	INIT_DELAYED_WORK(&adev->jpeg.idle_work, amdgpu_jpeg_idle_work_handler);
> +	mutex_init(&adev->jpeg.jpeg_pg_lock);
> +	atomic_set(&adev->jpeg.total_submission_cnt, 0);
>   
>   	return 0;
>   }
> @@ -54,6 +56,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   		amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec);
>   	}
>   
> +	mutex_destroy(&adev->jpeg.jpeg_pg_lock);
> +
>   	return 0;
>   }
>   
> @@ -83,7 +87,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   		fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec);
>   	}
>   
> -	if (fences == 0)
> +	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>   						       AMD_PG_STATE_GATE);
>   	else
> @@ -93,15 +97,19 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
>   
> -	if (set_clocks)
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> +	atomic_inc(&adev->jpeg.total_submission_cnt);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +
> +	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>   						       AMD_PG_STATE_UNGATE);
> +	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>   }
>   
>   void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
>   {
> +	atomic_dec(&ring->adev->jpeg.total_submission_cnt);
>   	schedule_delayed_work(&ring->adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index 5131a0a..55fbff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -46,6 +46,8 @@ struct amdgpu_jpeg {
>   	unsigned harvest_config;
>   	struct delayed_work idle_work;
>   	enum amd_powergating_state cur_state;
> +	struct mutex jpeg_pg_lock;
> +	atomic_t total_submission_cnt;
>   };
>   
>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
