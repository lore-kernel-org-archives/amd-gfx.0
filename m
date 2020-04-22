Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA1C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 14:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275A92076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vq+BoMqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275A92076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92B66EA0D;
	Wed, 22 Apr 2020 14:56:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93D96EA18
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 14:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1dPPomYwx2cNo7EUDKWkGXzXOqb+JKF6MC2zaqHUVgb24ZmL5j9MZOZapBRoaHF9cwtWyNaOGr4F6acADfn8t4qnnkeZkovS05pMULHaDd+StZSSkuOGTivuzUXHhuFIerd/4ANwtq1YHSBo2fhMaK9WtVH6JINMZttuR+SLnOVEfK8gV/3XpOaf58MKXwwYJjKeor1dIycS6WtjwY+SiQLrOqpR8llcoCMQA3F3PcQbOUiwjSxQPXve+y2knl8Kf4874XgW90v5VobztXijKxwwv1EdNf0uOHRDj+HMTGlx9DSf5Re/GW7MWU7Co4hedHgFBEPyB1Cx+KDTLW4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4xHD9G0fgQ0FV0qegz3X4TQMUqR+omn9TDZ9dMhbVs=;
 b=JOLbbZ8ndKHolHkaoautPOp93gb0Rz8LIBmFGGwIOuU2KasUcQWs4s6MZfeVwkE5bHh1JhE5Mt1jPe4Pmn+F3PNpPhutniHqJOPfHSRAiqfZ64HZn5MKc12aKagoXn6F7xUW9GGGfc8FKQXvlEhULFGqKsBAGlvyiK2bmnf+efesXKof6wRfCrgpr5D7mPkX/abs7kfqa14JfG6OHajfurU7uPRQ0RxLBSplhMrXlF9IRS3oVFcVgPzSNB7UZFPHBjKMxMLKxbreyE5Up4TdIhcM+FliJZDuUcBCsa3X4TmvRAsNOaQDFOyrt6CYVMFQwCuA4pJX12EYM7BnuDpQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4xHD9G0fgQ0FV0qegz3X4TQMUqR+omn9TDZ9dMhbVs=;
 b=vq+BoMqbDUdFGwD6J8AWblKGe7ZAzFS1gJWieCJEZijjFk60fwVzt8V7NkFZBPzqBgfEeUSL4GfIOisRWJnLip5AAxwD3xfP1VkrnsePPFvf3lxwf7vGW6LgYYb3hmiYqPB6out0kd6tu3ElnuBLhkGAaL5TtYApgtcKkW2SSe8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 14:56:43 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 14:56:43 +0000
Subject: Re: [PATCH] drm/amdgpu: protect kiq overrun
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20200422145027.2209-1-yttao@amd.com>
 <BYAPR12MB324027891F92EFEE9CCF5E85F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2506b93e-b3d5-25a8-1487-14fcf08c14dd@amd.com>
Date: Wed, 22 Apr 2020 16:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BYAPR12MB324027891F92EFEE9CCF5E85F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0145.eurprd04.prod.outlook.com (2603:10a6:207::29)
 To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR04CA0145.eurprd04.prod.outlook.com (2603:10a6:207::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Wed, 22 Apr 2020 14:56:42 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c207d599-1013-4ba0-6b28-08d7e6cd5ef8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4171:|DM6PR12MB4171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4171CE1DE08DA0541E96576E83D20@DM6PR12MB4171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(5660300002)(45080400002)(86362001)(478600001)(966005)(66476007)(110136005)(8676002)(8936002)(6486002)(66556008)(81156014)(36756003)(316002)(31686004)(6636002)(52116002)(4326008)(16526019)(6666004)(53546011)(66946007)(186003)(2906002)(31696002)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrzMrAvVmWKfWIPCj/pAwE9uimHhreRg54ffRn4m3OSZW+SfUx9U4ya/kUFmPYqt5Xv8IavZ/GDeyed6IBIOIid1Nxvg5+l9Mx66gQwki6sZXubXELX0Mm7JvYs/nExQKCwn7zKIgawLc9DJaFRplU4XkXUQFU17hrzrueuSDAEcNyo7TBqlcKRWVZsbyN93Zh5qskNMDT4r8nyBrJxew3pGg2ffTI9dgv9IVVO9KySGTiK0VIjf86Xkn6YOF/rLCgri3TeO56OAbY21kqdxa+ifkQjeljn2iH/hVByyROSvyRO79/QS3/VL33PPpF+27PQ85p8e2us7DeANwb/Qh/7xbrjIp2c+wrBOAap0eajkOnB0ZO7YuU0Io9/Gz25YtyG0p8Rq7FuCL/IQxo40v9kSpcN5f3lVzlvxsWR2WfKvB96tq5aqv/6gChp80Wko06jVxlsIwN3RA0LVXMhMlimTFB/de6pl9r9lLamiFR8=
X-MS-Exchange-AntiSpam-MessageData: zGhbsUgrwAeWpTp38Bxh4SK+eiObaRZrXpaFSUDviZLdB958OpoZdIvAyQIDzg8FQ57pQFuZD5qRe8JGDx4hbPmTpkeRh2U12fgNev7lO4/HfWPwwy4IxYjr06+jbeehzAadr8jC1HLVmzpzFiGo8GWTZMN7yScjPhDHOsE2j93UCWBCmFNZjBkkYrdRhkoEwzCSZGQM/pIiv9AgK3W4wQn6RYCkcpWQJ6hrdmIXCHUvY6fmsXx0OIxoED5Bnw1yAPWHXf4j7sM0Z7O+iJW0E4qZL2DR8UsLqWdemzEipeY3yhd6Ixas0fKDfT1jpYG4Hf/OTymbGWDOVrCCKopUV61MBQ9+DJvnxgk5fiNs7NfLZRMeWPCcFq0Se8+5Qj+k8Or1+zSYFxk4IxXEemcWokn8b2majwjs9GMlynx2wLJYYe/3l0pmhkjRXL+QmB296u1KYH+u98vsGJ4dhXi40+4QzjyuHgYMxaYB8TrCCWXguYiR9hW+BnnhSgiZOq2kLP+v+QT4PoFTv2llQqJ6SmZ9f9fdA5QOHm/SiNMbZ8KqztgP1NnjtdWgChwJ0+gnelp0j/qjg+xySPACRPIZ/1jeum+CkxwGmtiKSK8KcQGSLaOgSYDT4TWgqTLfz4lVoc7fpQ2dWsAiJY3/lSuMu4GSMR2skTR9oTXiakR6xP28J7eLNGubMl+LYsua/7ETkPS+gol528H+rAv/RSoe6TLJIztTPdHrMrL4JLGrJKU/cIPrwzEtyzUFmovprFZhCbsGJcbhciZ/5pU/SQleL7+M0M/WLriJP1Nm98StkS54YYQ6e5jugVZyD2+K4GgFpVD2tdDMyyOPmKCKwLPRk6Iiv7MectcLGgfaBpfiedI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c207d599-1013-4ba0-6b28-08d7e6cd5ef8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 14:56:43.5134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GDoHZnARHeWDP4gF29atyUfL7UuxP1AQXCxwJHVOzKxDrIOJm90w5DDsLZOXUu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_ring_alloc() function checks if the requested number of DW 
don't exceed the maximum submission size.

It does NOT check if there is enough room on the ring. That would 
require MMIO access and that is what we want to avoid.

Regards,
Christian.

Am 22.04.20 um 16:54 schrieb Liu, Shaoyun:
> [AMD Official Use Only - Internal Distribution Only]
>
> I think each  kiq operation will call ring_alloc  for the package space  , why  not just check whether this allocation is succeed or not ?
>
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yintian Tao
> Sent: Wednesday, April 22, 2020 10:50 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
> Subject: [PATCH] drm/amdgpu: protect kiq overrun
>
> Wait for the oldest sequence on the kiq ring to be signaled in order to make sure there will be no kiq overrun.
>
> v2: remove unused the variable and correct
>      kiq max_sub_num value
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  6 ++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 30 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 +++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 +++++
>   8 files changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 691c89705bcd..fac8b9713dfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -325,6 +325,12 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   		 mec, pipe, queue_id);
>   
>   	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		pr_err("critical bug! too many kiq submission\n");
> +		goto out_unlock;
> +	}
> +
>   	r = amdgpu_ring_alloc(kiq_ring, 7);
>   	if (r) {
>   		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index df841c2ac5e7..fd42c126510f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -323,6 +323,12 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   		 mec, pipe, queue_id);
>   
>   	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		pr_err("critical bug! too many kiq submissions\n");
> +		goto out_unlock;
> +	}
> +
>   	r = amdgpu_ring_alloc(kiq_ring, 7);
>   	if (r) {
>   		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a721b0e0ff69..84e66c45df37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -321,6 +321,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> +	else
> +		kiq->max_sub_num = (ring->ring_size / 4) /
> +				(ring->funcs->align_mask + 1);
>   
>   	return r;
>   }
> @@ -663,6 +666,21 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq) {
> +	uint32_t seq = 0;
> +	signed long r = 0;
> +
> +	seq = abs(kiq->ring.fence_drv.sync_seq - kiq->max_sub_num);
> +	if (seq > kiq->max_sub_num) {
> +		r = amdgpu_fence_wait_polling(&kiq->ring, seq,
> +					      MAX_KIQ_REG_WAIT);
> +		return r < 1 ? -ETIME : 0;
> +	}
> +
> +	return 0;
> +}
> +
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)  {
>   	signed long r, cnt = 0;
> @@ -674,6 +692,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq_read;
> +	}
> +
>   	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
>   		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   		pr_err("critical bug! too many kiq readers\n"); @@ -728,6 +752,12 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>   	BUG_ON(!ring->funcs->emit_wreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq_write;
> +	}
> +
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_wreg(ring, reg, v);
>   	amdgpu_fence_emit_polling(ring, &seq); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ee698f0246d8..1ee59a927bd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -103,6 +103,7 @@ struct amdgpu_kiq {
>   	struct amdgpu_ring	ring;
>   	struct amdgpu_irq_src	irq;
>   	const struct kiq_pm4_funcs *pmf;
> +	uint32_t		max_sub_num;
>   };
>   
>   /*
> @@ -387,4 +388,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_iv_entry *entry);
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +
> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 8c10084f44ef..4b027006d072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -57,6 +57,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>   	uint32_t seq;
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq;
> +	}
> +
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>   					    ref, mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5b1549f167b0..a136e2229f7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4051,6 +4051,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq_read;
> +	}
> +
>   	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
>   		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   		pr_err("critical bug! too many kiq readers\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 30b75d79efdb..77d8bc9c0111 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -423,6 +423,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   
>   	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>   		spin_lock(&adev->gfx.kiq.ring_lock);
> +		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +		if (r) {
> +			spin_unlock(&kiq->ring_lock);
> +			DRM_ERROR("too many kiq submissions\n");
> +			return -ETIME;
> +		}
> +
>   		/* 2 dwords flush + 8 dwords fence */
>   		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
>   		kiq->pmf->kiq_invalidate_tlbs(ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index fecdbc471983..c429a2a5fe3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -614,6 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   			ndw += kiq->pmf->invalidate_tlbs_size;
>   
>   		spin_lock(&adev->gfx.kiq.ring_lock);
> +		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +		if (r) {
> +			spin_unlock(&kiq->ring_lock);
> +			DRM_ERROR("critical bug! too many kiq submissions\n");
> +			return -ETIME;
> +		}
> +
>   		/* 2 dwords flush + 8 dwords fence */
>   		amdgpu_ring_alloc(ring, ndw);
>   		if (vega20_xgmi_wa)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7C0cd26307c0a149ebe0bd08d7e6cc84b1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637231638419034830&amp;sdata=rxkhyMutFwbe5Nw%2BeBGiESW9wTdflDUo%2F4xEvbCbR6U%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
