Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F11C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 18:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25DC2075A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 18:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yR2bPC8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25DC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5762E6E2DD;
	Wed, 22 Apr 2020 18:42:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7786B6E2DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 18:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3KHvkoRKYzpDNzw2dQM/q+2NPqu9CVDJ23EkypIC/V/m5VuX9a0nDmhDrJXkqKgo5IGUjOZtbMDQ/t/dHR2uov5TdUO1aMb7A6+c273DES1S/BiFvqKmQ2ReXy25ajEgqV4nuM2TcjwvQ0iWkwznz2p0nXtHzyS5TRGZICZXVJvqkUuapCFMk4sSOhNO3kNTZ4ScbI4e9SWn3DigTKjdTq6nTSJK2xzn1gBYBU059sCebKzhmOJ5I6HfE/51k2GHWrScE17fIKY/Ik/Q9Zv/7ELSkqgSdLsFKGaJCi5JoXsM0Gp9sWVqfCZNOX0hEzWJ7uhvNExCTS/aBD0TRHzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7klIDNliFVUbE/yF9kIJuwndjZVHjZfDE1YJlflNHzE=;
 b=nKhwupS7CbXkcj3blBOUPzFcmJgegSQ322lLv8N7QAhsqpdmNBPL/uizMc3h0pIhzY5rRa5NfQUU32h2cMreUL89Ix4+52LzUJIQLJXRUtqzoqAJ0MwNwSkNUlqKY2ySE6sybwSCcS99rTZFF9MlQ5w3bpyGhPEBQbiiCfSocdpxdybD7ip9eW0xGVoJGf3gZpeeE6vTY+y1JEy5siioqswhHSDAKoeRulsadlcNfVGCLCJfKrWjqlBkSuiR58LHK7I62raGWAM2xKOuDFZd17hckGtEMdwezFMVrW9YL3dslnRbFugczmWdn4KiQZX1kTXO8jvq4L0znUgZbx1ZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7klIDNliFVUbE/yF9kIJuwndjZVHjZfDE1YJlflNHzE=;
 b=yR2bPC8VSJ0/ed0KDKldSzDhiM55Hc7POxZsaZFpNI6qyAfxK/z1ilobMt6+UrJdMUGeJxRgkR+NRXL7SRoX2zuMLqqHLcTXtZYrNNpe8kAjtgKGSBG721nFgKlkGK3C6WJsjMITeuV5fwEd7uxWRoptQxXQQidvENBYF03vcYQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 18:42:54 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 18:42:54 +0000
Subject: Re: [PATCH] drm/amdgpu: protect kiq overrun
To: Yintian Tao <yttao@amd.com>, monk.liu@amd.com, Felix.Kuehling@amd.com
References: <20200422145027.2209-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <51a7086f-d0d5-50bd-f3b6-6809f793428e@amd.com>
Date: Wed, 22 Apr 2020 20:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200422145027.2209-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0112.eurprd05.prod.outlook.com
 (2603:10a6:207:2::14) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0112.eurprd05.prod.outlook.com (2603:10a6:207:2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17 via Frontend Transport; Wed, 22 Apr 2020 18:42:52 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 448b9290-c053-4d2b-9d0e-08d7e6ecf7b1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3850:|DM6PR12MB3850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB385005326A1D33274104E88583D20@DM6PR12MB3850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(81156014)(66476007)(52116002)(186003)(8676002)(478600001)(6486002)(6636002)(6666004)(86362001)(31696002)(2906002)(31686004)(2616005)(4326008)(316002)(66946007)(36756003)(16526019)(66556008)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIDRyNavSnv4lKclI8urezu9/++LNAJIuHyZ0lhFuH3QOwJbVp49Y3mQlzO690Hl33J8asBPMqCKSq8TYn52vAxX+3cY5bARNx4Tktd33F3duoVVWrLsaC2w5Kbg8lPWIMF3eahwyKEKQLcgAaL9ybAFdVX9YLUFcoOw8ujHjIM/dGQLgWKtd9UD+QhwRB4zRzizxOh6sQdWDFcGeTlmk+HGDOJDQLM7K/o4ZpGQkj0FALzwlBgTO4FD+md+IVgdG+3eWY/VZgo+2Qg32bXm4J0cG5FQwaqZt5XI6ghmvYJgP/LtXkr8e58t4NACIWzQ3HZMPOEjf80Qm//qoAvnSnkqJOAQ0/v+0Jj5IrnT3tB+xFIUP4mcvIiM85mk+58pcykMMmejNiBG9Ss0cafgPIR812IjcWX5GRt0XfEwmBUP6Cf+klMCLnkUraUMFMJ5
X-MS-Exchange-AntiSpam-MessageData: NVbJ2gANwosTruboowfJj5axcXTEbjzjxo0vNcB+eRZEnrc6PeyLJ6/QaEDDE+jRMW1h+ZKxZPUbKNA1zROHPaxMGUmTuq/mTojcPupIro3pPIF/pPevf3+DlTF3igZ6ncjqQbepMAP2Pumgw27HIMqh9YLRylFBtWei4WtBBYWf6XxLyu3/AuJfGmIZibPlsDu0FjybcAZzNWCcvMwkPowhR5E8dkLbmG7/Nr8PVamVXT7mPbSfyJTqDzUaGDvuBM4l28V0cZHVq5MrThD9gWxN5RU+5bAwQ97HuGLAMAFlTLZ+/KKVfIUsGMX80rSL1Sj9Hnft9HOMQi1Xhq4w6US7McA+7tA4guul7ovWf1xWH5RuHY8JxDYYJRmo+l2T2OiTPfVQr6ex9fGIAilKYcuwxLjOz6yKtheAdARS2z3dgd7KNzmNTEaSIXcTCWjQG54UaUru/8BjafHH+RcMqnfQ/Z7ItCH0zy5tptzq5cw90WUv2Okbh12/essVeM/Ru/GXeqKlDUW3FkEYE6MpTWCZgtJXB0Z8ZJl4NuDwO+oHBj2G9A3jgoW2BRQ1LxIhM6ZwuCINQvqOHK7d6Y/e7HkXK3E+9bbOZXz9KQirf4w6pscQ0bNoI/HJNHqQbo3adG5mg7vCnFrTuH8g8Sg50uX29nR11V1Cpy59+BIvSwwLpIOqXPmTi5djwaF2bgQb5sT6zydzkFtreplDhLlNhH97Ggj+HX0P2sFlStiOA2eGw5WkIr+eE4jsL7qkbkZcPolrfYUMzwF0pD9AnE3UDKPcoj/k3IhND9QpCkgX7pAG632SA0AqnENZ0qkoqiFpkpAN8A2NLAeaJf9lTq6p3BkdJHWYBK7K9/7EEVHlymY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448b9290-c053-4d2b-9d0e-08d7e6ecf7b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 18:42:54.1364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ObiL6h/gxwAgzk671NsfA2lryKBEEBd4CmeZa8HxnpF7q8XBYVrLmzyYvCDCuZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
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

Am 22.04.20 um 16:50 schrieb Yintian Tao:
> Wait for the oldest sequence on the kiq ring
> to be signaled in order to make sure there
> will be no kiq overrun.
>
> v2: remove unused the variable and correct
>      kiq max_sub_num value

First of all this should probably be added to the fence handling code 
and not the kiq code.

Then you are kind of duplicating some of the functionality we have in 
the ring handling here. Probably better to avoid this, see 
amdgpu_fence_driver_init_ring() as well. That's also why I suggested to 
use the num_fences_mask value.

Regards,
Christian.

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
>   		pr_err("Failed to alloc KIQ (%d).\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
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
>   		pr_err("Failed to alloc KIQ (%d).\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
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
> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq)
> +{
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
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   {
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
>   		pr_err("critical bug! too many kiq readers\n");
> @@ -728,6 +752,12 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
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
>   	amdgpu_fence_emit_polling(ring, &seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
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
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
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
>   		pr_err("critical bug! too many kiq readers\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
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

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
