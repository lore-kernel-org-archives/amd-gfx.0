Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C6C55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 11:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456A62076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 11:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f3EA5V6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456A62076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DB16E3D0;
	Wed, 22 Apr 2020 11:03:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65176E3D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 11:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNz8GKM8scMREStSUEF3Q3LACLiH3weLJCuCm4fBg0DmGLyQUT/nbqkSOUu2yh/TwU9Pckra/XVymEkJW6fhoRzAHwr+5Vfr36If4CzAewPHLCdmG9ydEzYjTUN7ZlEO5QXM7MzDXAiiso0D1izWHD1Ar/mjRK32HTAAiq4zCqrhFA68V3UodJhtAbLRYpqfd4udNDd+6pUmNoTewFlHL6wQiHwI39mHY5DCdtpqAswAGCP793yUPaBUVOrcgzrqb7Gn7YNObTMfswqupYMm9lnmQ/rC5NF7o0lzlWUQdmthgqgaJX3Oe6ZNJMIEvazZEW2rjiPPk/U8yKsTijWmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GvO5k/HiJrBE7zwgQxLO9MTo2qiAdbCDgpGW26kgAw=;
 b=HRy1MaYlRMb6gX09S6UCyABXdrvz7TwUMlt83OSuSEKp23GwzBur8DEl600m1TiSPysMEInrsvwf0CJ+vf2g7kqBz3Nxqykcf8z3tKAZjF6r7vQy9HV9AlE8LESbjyWwICu2sEHFai5mFf7Zs7IyMPxflPMc9MetRdf+gb6fUM1rqj/mwx1LBhjddYV2ladvhvHzZTQmOEcP9b/uhNFPJXEhpNoyYB/OVWCOQ9EOSkMjSkKLlQE3oARwE+8HqZ2p7EWhk8NHmn2hJ2LvwH1+NckbGa0DTryAxK0Z3WjCdD9IfHudvapIDZWMO1Lfx1ru0DuglSZupZfF6jYGKx/raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GvO5k/HiJrBE7zwgQxLO9MTo2qiAdbCDgpGW26kgAw=;
 b=f3EA5V6PqgUP9TIRLmaNp8zld1T2jN6VaPK6twamPwVZlulJ5sNr9b5nmmlmrvfN7Tb6FanzeWsjqAcQBrejrS21mC5qlA5o37f3MJicD2IZ2hEBmQ+JwDYMrCfP5r8j0KrZe5OfLlBS0eEzv1NQJF3cAfKi8Ru8VaR0tIgNA2k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 11:03:10 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:03:10 +0000
Subject: Re: [PATCH] drm/amdgpu: refine kiq access register
To: Yintian Tao <yttao@amd.com>, monk.liu@amd.com, Felix.Kuehling@amd.com
References: <20200422092908.27434-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <27ab6479-5cee-60e2-aeea-cb2a156b508b@amd.com>
Date: Wed, 22 Apr 2020 13:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200422092908.27434-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0006.eurprd07.prod.outlook.com
 (2603:10a6:200:42::16) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0006.eurprd07.prod.outlook.com (2603:10a6:200:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.9 via Frontend
 Transport; Wed, 22 Apr 2020 11:03:08 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b8ff386-59be-4f90-cdca-08d7e6acbe2c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:|DM6PR12MB2602:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26025B962819752FD8C42D4483D20@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(66556008)(8936002)(31696002)(316002)(81156014)(6636002)(30864003)(66476007)(52116002)(186003)(16526019)(2906002)(5660300002)(8676002)(2616005)(4326008)(66946007)(478600001)(86362001)(6666004)(6486002)(31686004)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj4jI0Wtks/Mt1T10CBwn+CbSJ2Egtan68JD1zkY8Vp33LoiiCNu6YiCLUzi5ACy1TcMc8ew5CEcO5rebAu0RxaEoVU268l5kaWd/l9dad6kCUjwu6Wyp2u7iJP+BiPJINM/zk0SDwwHnCFPE8pVKnrU05xZj5kyKTPcBwpvZMPCclCB6b5TEcFQMXjqZSf484SCAmVqeedY4CsGSwiIkrPSNCBIXY7nMfu7ZLfBhS4RJeMtbVzHbljUBQbslWceJbZ3KbUugVK/Mfq5Zjj4MWief+z+OaedRHXi4IP9WonuSGoPPjGjjzIfTU88fmRamtJxuGFhVOtlyc9OJCqS3wc84+lcHx7tftGVYCrUFgYKKTndJRQs7RXQXvzh6UltmnCkdusCWgvUzboiMFK+aMJo3TUqKePn6b97aWL7JGxrDtrySlYfu8AMPIsaMKaF
X-MS-Exchange-AntiSpam-MessageData: A3zB7N1lEP/TsoTlZw5reNzyigy0ZyHRkZKv5o/NPZm7P+FCCuXeg0AJ2J/t/FXhNmUgj+N3fu7RRkCfMQoEdGpEl6nP500sMpdTomAWrjY6KoWT0/ACWEB58u1KLyAWLWnSGAZ863q1XDV7jqRxPpyKWVIcBfK+A7q+SMTZqFZpCb26EdUXzsdV3S914QM/hVpbU7mKJIDg3QllYQ70rt0+SCUX/xkk0yZJzlsfsIRmN+VZcevndrW1eixvTAzobtQRqZAYMu1vrJ+sVYacBSgIqMU7C0LYrats89huVphGekJESt1gcFE+OPlYX6l/e/6EYApPNBnXncalwty0FLtbAZ1hDj+LMOnJPYQaTmAVLGKFUWgDFBLi/yJ7DnWPSIi7xEkJ3t7zMg0g3XaHRqArVk2hmSPL6yLZoIRED98B4Rr+LWnnUht4KJJj5qTLxoqNQM9IrzN78PO23tuTrRrogx9FX9kU26uG93881sACpUWC/7sVKuVqbrYp4AcsL0la+XSDdfYqW1shmhDG0PqbiMeoVVSl97Afam3xiy4B1qE6EBGanxkp1uT7p9iDjLGqxnJovjggmDaSTcpJWcYFuLHKA/T5mQ/JrdVsQbsonLSINnrS5SmaZs/sHYXE2fMAJ/4etlobifIWcX7M67d9T20VDJnB5cJ2goREZbBbfC2w/O2Mz59CflZrQmvzSumLk0zvh7bfztOsx5k8Ii5zbB9a9mLy573v2uB9KZqA0ZxiQxUGcz+Kt2DgxBltpFAdMt3IJGsnALK4VYERbxOhZFpFZh4OJ+MOl1S2vPF04WvuaRpbmb0wJON0pwj/xoXLWGdnK1kfqYALM07rznScjtp6bB96IoWYuFfr0kM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ff386-59be-4f90-cdca-08d7e6acbe2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:03:09.9010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/rq4GHQhq1oI8Ry7cSzFxFvKhD48aCWj66/lc5iKuXCOYvDsNXOOd6wkVmdMRmA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.04.20 um 11:29 schrieb Yintian Tao:
> According to the current kiq access register method,
> there will be race condition when using KIQ to read
> register if multiple clients want to read at same time
> just like the expample below:
> 1. client-A start to read REG-0 throguh KIQ
> 2. client-A poll the seqno-0
> 3. client-B start to read REG-1 through KIQ
> 4. client-B poll the seqno-1
> 5. the kiq complete these two read operation
> 6. client-A to read the register at the wb buffer and
>     get REG-1 value
>
> And if there are multiple clients to frequently write
> registers through KIQ which may raise the KIQ ring buffer
> overwritten problem.
>
> Therefore, allocate fixed number wb slot for rreg use
> and limit the submit number which depends on the kiq
> ring_size in order to prevent the overwritten problem.
>
> v2: directly use amdgpu_device_wb_get() for each read instead
>      of to reserve fixde number slot.
>      if there is no enough kiq ring buffer or rreg slot then
>      directly print error log and return instead of busy waiting

I would split that into three patches. One for each problem we have here:

1. Fix kgd_hiq_mqd_load() and maybe other occasions to use 
spin_lock_irqsave().

2. Prevent the overrung of the KIQ. Please drop the approach with the 
atomic here. Instead just add a amdgpu_fence_wait_polling() into 
amdgpu_fence_emit_polling() as I discussed with Monk.

3. Use amdgpu_device_wb_get() each time we need to submit a read.

Regards,
Christian.

>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 +-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 13 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 13 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 83 +++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 13 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  8 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  8 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 35 +++++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 13 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 13 ++-
>   12 files changed, 167 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4e1d4cfe7a9f..1157c1a0b888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -526,7 +526,7 @@ static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
>   /*
>    * Writeback
>    */
> -#define AMDGPU_MAX_WB 128	/* Reserve at most 128 WB slots for amdgpu-owned rings. */
> +#define AMDGPU_MAX_WB 256	/* Reserve at most 256 WB slots for amdgpu-owned rings. */
>   
>   struct amdgpu_wb {
>   	struct amdgpu_bo	*wb_obj;
> @@ -1028,6 +1028,12 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>   
>   int emu_soc_asic_init(struct amdgpu_device *adev);
>   
> +int amdgpu_gfx_kiq_lock(struct amdgpu_kiq *kiq, bool read,
> +			unsigned long *flags);
> +void amdgpu_gfx_kiq_unlock(struct amdgpu_kiq *kiq, unsigned long *flags);
> +
> +void amdgpu_gfx_kiq_consume(struct amdgpu_kiq *kiq, uint32_t *offs);
> +void amdgpu_gfx_kiq_restore(struct amdgpu_kiq *kiq, uint32_t *offs);
>   /*
>    * Registers read & write functions.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 691c89705bcd..a65d6a1abc04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -309,9 +309,11 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   			    uint32_t doorbell_off)
>   {
>   	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
>   	struct v10_compute_mqd *m;
>   	uint32_t mec, pipe;
> +	unsigned long flags = 0;
>   	int r;
>   
>   	m = get_mqd(mqd);
> @@ -324,13 +326,19 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
>   		 mec, pipe, queue_id);
>   
> -	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
> +	if (r) {
> +		pr_err("failed to lock kiq\n");
> +		goto out_unlock;
> +	}
> +
>   	r = amdgpu_ring_alloc(kiq_ring, 7);
>   	if (r) {
>   		pr_err("Failed to alloc KIQ (%d).\n", r);
>   		goto out_unlock;
>   	}
>   
> +	amdgpu_gfx_kiq_consume(kiq, NULL);
>   	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
>   	amdgpu_ring_write(kiq_ring,
>   			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
> @@ -350,8 +358,9 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
>   	amdgpu_ring_commit(kiq_ring);
>   
> +	amdgpu_gfx_kiq_restore(kiq, NULL);
>   out_unlock:
> -	spin_unlock(&adev->gfx.kiq.ring_lock);
> +	amdgpu_gfx_kiq_unlock(&adev->gfx.kiq, &flags);
>   	release_queue(kgd);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index df841c2ac5e7..4435bd716edd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -307,9 +307,11 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   			    uint32_t doorbell_off)
>   {
>   	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
>   	struct v9_mqd *m;
>   	uint32_t mec, pipe;
> +	unsigned long flags = 0;
>   	int r;
>   
>   	m = get_mqd(mqd);
> @@ -322,13 +324,19 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
>   		 mec, pipe, queue_id);
>   
> -	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
> +	if (r) {
> +		pr_err("failed to lock kiq\n");
> +		goto out_unlock;
> +	}
> +
>   	r = amdgpu_ring_alloc(kiq_ring, 7);
>   	if (r) {
>   		pr_err("Failed to alloc KIQ (%d).\n", r);
>   		goto out_unlock;
>   	}
>   
> +	amdgpu_gfx_kiq_consume(kiq, NULL);
>   	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
>   	amdgpu_ring_write(kiq_ring,
>   			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
> @@ -348,8 +356,9 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
>   	amdgpu_ring_commit(kiq_ring);
>   
> +	amdgpu_gfx_kiq_restore(kiq, NULL);
>   out_unlock:
> -	spin_unlock(&adev->gfx.kiq.ring_lock);
> +	amdgpu_gfx_kiq_unlock(&adev->gfx.kiq, &flags);
>   	release_queue(kgd);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index ea576b4260a4..c0dc7f1849c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -295,6 +295,43 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
>   	return -EINVAL;
>   }
>   
> +int amdgpu_gfx_kiq_lock(struct amdgpu_kiq *kiq, bool read,
> +			unsigned long *flags)
> +{
> +	struct amdgpu_wb *wb = &(kiq->ring.adev)->wb;
> +
> +	spin_lock_irqsave(&kiq->ring_lock, *flags);
> +	if ((atomic64_read(&kiq->submit_avail) > 0) &&
> +	    (read ? find_first_zero_bit(wb->used, wb->num_wb) <
> +	     wb->num_wb : 1)) {
> +		return 0;
> +	} else {
> +		spin_unlock_irqrestore(&kiq->ring_lock, *flags);
> +		pr_err("critical! too more kiq accessers\n");
> +		return -EDEADLK;
> +	}
> +}
> +
> +void amdgpu_gfx_kiq_unlock(struct amdgpu_kiq *kiq, unsigned long *flags)
> +{
> +	spin_unlock_irqrestore(&kiq->ring_lock, *flags);
> +}
> +
> +void amdgpu_gfx_kiq_consume(struct amdgpu_kiq *kiq, uint32_t *offs)
> +{
> +	atomic64_dec(&kiq->submit_avail);
> +	if (offs)
> +		amdgpu_device_wb_get(kiq->ring.adev, offs);
> +
> +}
> +
> +void amdgpu_gfx_kiq_restore(struct amdgpu_kiq *kiq, uint32_t *offs)
> +{
> +	atomic64_inc(&kiq->submit_avail);
> +	if (offs)
> +		amdgpu_device_wb_free(kiq->ring.adev, *offs);
> +}
> +
>   int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   			     struct amdgpu_ring *ring,
>   			     struct amdgpu_irq_src *irq)
> @@ -304,10 +341,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   
>   	spin_lock_init(&kiq->ring_lock);
>   
> -	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
> -	if (r)
> -		return r;
> -
>   	ring->adev = NULL;
>   	ring->ring_obj = NULL;
>   	ring->use_doorbell = true;
> @@ -325,13 +358,15 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> +	else
> +		atomic64_set(&kiq->submit_avail, ring->ring_size / 4 /
> +			     (ring->funcs->align_mask + 1));
>   
>   	return r;
>   }
>   
>   void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
>   {
> -	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
>   	amdgpu_ring_fini(ring);
>   }
>   
> @@ -671,19 +706,25 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   {
>   	signed long r, cnt = 0;
> -	unsigned long flags;
> -	uint32_t seq;
> +	unsigned long flags = 0;
> +	uint32_t seq, reg_val_offs = 0, value = 0;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_lock(kiq, true, &flags);
> +	if (r) {
> +		pr_err("failed to lock kiq\n");
> +		goto kiq_read_exit;
> +	}
> +
> +	amdgpu_gfx_kiq_consume(kiq, &reg_val_offs);
>   	amdgpu_ring_alloc(ring, 32);
> -	amdgpu_ring_emit_rreg(ring, reg);
> +	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
>   	amdgpu_fence_emit_polling(ring, &seq);
>   	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	amdgpu_gfx_kiq_unlock(kiq, &flags);
>   
>   	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>   
> @@ -707,9 +748,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	if (cnt > MAX_KIQ_REG_TRY)
>   		goto failed_kiq_read;
>   
> -	return adev->wb.wb[kiq->reg_val_offs];
> +	mb();
> +	value = adev->wb.wb[reg_val_offs];
> +	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
> +	return value;
>   
>   failed_kiq_read:
> +	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
> +kiq_read_exit:
>   	pr_err("failed to read reg:%x\n", reg);
>   	return ~0;
>   }
> @@ -717,19 +763,25 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>   {
>   	signed long r, cnt = 0;
> -	unsigned long flags;
> +	unsigned long flags = 0;
>   	uint32_t seq;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	BUG_ON(!ring->funcs->emit_wreg);
>   
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
> +	if (r) {
> +		pr_err("failed to lock kiq\n");
> +		goto kiq_write_exit;
> +	}
> +
> +	amdgpu_gfx_kiq_consume(kiq, NULL);
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_wreg(ring, reg, v);
>   	amdgpu_fence_emit_polling(ring, &seq);
>   	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	amdgpu_gfx_kiq_unlock(kiq, &flags);
>   
>   	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>   
> @@ -754,8 +806,11 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>   	if (cnt > MAX_KIQ_REG_TRY)
>   		goto failed_kiq_write;
>   
> +	amdgpu_gfx_kiq_restore(kiq, NULL);
>   	return;
>   
>   failed_kiq_write:
> +	amdgpu_gfx_kiq_restore(kiq, NULL);
> +kiq_write_exit:
>   	pr_err("failed to write reg:%x\n", reg);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 634746829024..ff7597ca6cad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -96,6 +96,7 @@ struct kiq_pm4_funcs {
>   	int invalidate_tlbs_size;
>   };
>   
> +#define MAX_KIQ_RREG_NUM 64
>   struct amdgpu_kiq {
>   	u64			eop_gpu_addr;
>   	struct amdgpu_bo	*eop_obj;
> @@ -103,7 +104,7 @@ struct amdgpu_kiq {
>   	struct amdgpu_ring	ring;
>   	struct amdgpu_irq_src	irq;
>   	const struct kiq_pm4_funcs *pmf;
> -	uint32_t			reg_val_offs;
> +	atomic64_t		submit_avail;
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index f61664ee4940..137d3d2b46e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -181,7 +181,8 @@ struct amdgpu_ring_funcs {
>   	void (*end_use)(struct amdgpu_ring *ring);
>   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>   	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> -	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
> +	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
> +			  uint32_t reg_val_offs);
>   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>   	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
>   			      uint32_t val, uint32_t mask);
> @@ -265,7 +266,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
> -#define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
> +#define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>   #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 8c10084f44ef..a4c3f284691c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -56,13 +56,19 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>   	unsigned long flags;
>   	uint32_t seq;
>   
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
> +	if (r) {
> +		pr_err("failed to lock kiq\n");
> +		goto failed_exit;
> +	}
> +
> +	amdgpu_gfx_kiq_consume(kiq, NULL);
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>   					    ref, mask);
>   	amdgpu_fence_emit_polling(ring, &seq);
>   	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	amdgpu_gfx_kiq_unlock(kiq, &flags);
>   
>   	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>   
> @@ -80,9 +86,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>   	if (cnt > MAX_KIQ_REG_TRY)
>   		goto failed_kiq;
>   
> +	amdgpu_gfx_kiq_restore(kiq, NULL);
>   	return;
>   
>   failed_kiq:
> +	amdgpu_gfx_kiq_restore(kiq, NULL);
> +failed_exit:
>   	pr_err("failed to write reg %x wait reg %x\n", reg0, reg1);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 0a03e2ad5d95..7853dbc3c8bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7594,10 +7594,10 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
>   	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>   }
>   
> -static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> +static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
> +				     uint32_t reg_val_offs)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
> @@ -7606,9 +7606,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>   	amdgpu_ring_write(ring, reg);
>   	amdgpu_ring_write(ring, 0);
>   	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   }
>   
>   static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fc6c2f2bc76c..bdbd92d4fe45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6383,10 +6383,10 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;
>   }
>   
> -static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> +static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
> +				    uint32_t reg_val_offs)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
> @@ -6395,9 +6395,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>   	amdgpu_ring_write(ring, reg);
>   	amdgpu_ring_write(ring, 0);
>   	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   }
>   
>   static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 84fcf842316d..293219452c0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4042,14 +4042,21 @@ static int gfx_v9_0_soft_reset(void *handle)
>   static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   {
>   	signed long r, cnt = 0;
> -	unsigned long flags;
> -	uint32_t seq;
> +	unsigned long flags = 0;
> +	uint32_t seq, reg_val_offs;
> +	uint64_t value = 0;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_lock(kiq, true, &flags);
> +	if (r) {
> +		pr_err("failed to lock kiq\n");
> +		goto failed_kiq_exit;
> +	}
> +
> +	amdgpu_gfx_kiq_consume(kiq, &reg_val_offs);
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 9 |	/* src: register*/
> @@ -4059,12 +4066,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   	amdgpu_ring_write(ring, 0);
>   	amdgpu_ring_write(ring, 0);
>   	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   	amdgpu_fence_emit_polling(ring, &seq);
>   	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	amdgpu_gfx_kiq_unlock(kiq, &flags);
>   
>   	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>   
> @@ -4088,10 +4095,14 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   	if (cnt > MAX_KIQ_REG_TRY)
>   		goto failed_kiq_read;
>   
> -	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
> -		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
> +	value = (uint64_t)adev->wb.wb[reg_val_offs] |
> +		(uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
>   
> +	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
> +	return value;
>   failed_kiq_read:
> +	amdgpu_gfx_kiq_restore(kiq, &reg_val_offs);
> +failed_kiq_exit:
>   	pr_err("failed to read gpu clock\n");
>   	return ~0;
>   }
> @@ -5482,10 +5493,10 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;
>   }
>   
> -static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> +static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
> +				    uint32_t reg_val_offs)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
> @@ -5494,9 +5505,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>   	amdgpu_ring_write(ring, reg);
>   	amdgpu_ring_write(ring, 0);
>   	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				kiq->reg_val_offs * 4));
> +				reg_val_offs * 4));
>   }
>   
>   static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 30b75d79efdb..ab960b052c0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -415,6 +415,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   {
>   	int vmid, i;
>   	signed long r;
> +	unsigned long flags = 0;
>   	uint32_t seq;
>   	uint16_t queried_pasid;
>   	bool ret;
> @@ -422,20 +423,28 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
>   	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
> -		spin_lock(&adev->gfx.kiq.ring_lock);
> +		r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
> +		if (r) {
> +			pr_err("failed to lock kiq\n");
> +			return -ETIME;
> +		}
> +
>   		/* 2 dwords flush + 8 dwords fence */
>   		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
> +		amdgpu_gfx_kiq_consume(kiq, NULL);
>   		kiq->pmf->kiq_invalidate_tlbs(ring,
>   					pasid, flush_type, all_hub);
>   		amdgpu_fence_emit_polling(ring, &seq);
>   		amdgpu_ring_commit(ring);
> -		spin_unlock(&adev->gfx.kiq.ring_lock);
> +		amdgpu_gfx_kiq_unlock(kiq, &flags);
>   		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> +			amdgpu_gfx_kiq_restore(kiq, false);
>   			return -ETIME;
>   		}
>   
> +		amdgpu_gfx_kiq_restore(kiq, NULL);
>   		return 0;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index fecdbc471983..d14fd56a959e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -589,6 +589,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   {
>   	int vmid, i;
>   	signed long r;
> +	unsigned long flags = 0;
>   	uint32_t seq;
>   	uint16_t queried_pasid;
>   	bool ret;
> @@ -613,7 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		if (vega20_xgmi_wa)
>   			ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -		spin_lock(&adev->gfx.kiq.ring_lock);
> +		r = amdgpu_gfx_kiq_lock(kiq, false, &flags);
> +		if (r) {
> +			pr_err("failed to lock kiq\n");
> +			return -ETIME;
> +		}
> +
> +		amdgpu_gfx_kiq_consume(kiq, NULL);
>   		/* 2 dwords flush + 8 dwords fence */
>   		amdgpu_ring_alloc(ring, ndw);
>   		if (vega20_xgmi_wa)
> @@ -623,13 +630,15 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   					pasid, flush_type, all_hub);
>   		amdgpu_fence_emit_polling(ring, &seq);
>   		amdgpu_ring_commit(ring);
> -		spin_unlock(&adev->gfx.kiq.ring_lock);
> +		amdgpu_gfx_kiq_unlock(kiq, &flags);
>   		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> +			amdgpu_gfx_kiq_restore(kiq, NULL);
>   			return -ETIME;
>   		}
>   
> +		amdgpu_gfx_kiq_restore(kiq, NULL);
>   		return 0;
>   	}
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
