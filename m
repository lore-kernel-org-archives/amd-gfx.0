Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1DC33CAF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 03:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6C1206D7
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 03:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rRjFzn1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6C1206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4BD06F381;
	Fri, 17 Jan 2020 03:01:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61C56F381
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 03:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfcMhTXbA/K9MOwNH02eLbT+fH3JcGHki50cKk26WPObCHn6K69uLrEAf2MySbpRVyWYeKznhF2fBzKzrYUblHZvkVJR1tqNWFS0k8rTLfyl6cGlP2TrtauSss0i+rLvfIeegkHA5y8W6BrzawC72yIyHg/dpk83iMEEEsA3OnR+AhE6CQFOLq4mOaNwbcUyXhz9hoDV9/HGi+GmdUxFgAHYN32xdn6H063J5ony+bcLJreuXXktvMWkKxdefMglgcLZEZ1dqfU3fuOH1QdelVMhTTra4tFNfgQxxfwLosVMrR1Ple4xk7UDWd39CVPnOTbgErTcKjVuZDJZvh1DTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvx5kzp8VGSgrCEOn1ZGR9785gpzJqUld2sIODEnynA=;
 b=hLl+p+YYJYboUj0ai8anOsMp6SpjPViBXAvKX5RJXtpzyIw71viW5TDqID9SIPCCRpwziS5TASgdg4scd4C3ZniGZCneV66WcXbSsLir95Cp3WJy+DHvJ4kfTy+pyFkTZufaHoaA19iyHF+2HeXAF23uKzhfuGJWmSMPV/2guaiD+nDF+SiLGScNVfCYM6TgFlhvBD2LqoafIa2ELx0I2/Y6D90oRyVDMjvIeg3g4uf19fVQlgJJvjX0Fae37/V6p5LI+70bCiM3KIcATq28BKEeGq4tZndMJJU2zpegAJ/4IJ1CjPrESIPYCqslQwBy7MwKERff9T9Khp4XaPt06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvx5kzp8VGSgrCEOn1ZGR9785gpzJqUld2sIODEnynA=;
 b=rRjFzn1VnfRTl3mpVKws6Iw2Sa8ScMd1xQJgmtaITA4o2PKQMOk1YaDKmzr5B7WSGcE95823Y2+o1o3bhSIN1IlKJ5TtDRt9T0wQ9/tCoQGcOVB3+tB6IN6ly0UaXyIHspo6GBE0K2ghaMQI7vSXYnpN6zgoXLZHST0ucXIQHwo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3391.namprd12.prod.outlook.com (20.178.240.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 03:01:52 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 03:01:52 +0000
Date: Fri, 17 Jan 2020 11:01:43 +0800
From: Huang Rui <ray.huang@amd.com>
To: chen gong <curry.gong@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: provide a generic function interface for
 reading/writing register by KIQ
Message-ID: <20200117030142.GA5414@jenkins-Celadon-RN>
References: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
Content-Disposition: inline
In-Reply-To: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 03:01:50 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38b5fffe-6388-4feb-7c53-08d79af99a33
X-MS-TrafficTypeDiagnostic: MN2PR12MB3391:|MN2PR12MB3391:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3391D61E82C52104F612C1ECEC310@MN2PR12MB3391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(26005)(186003)(9686003)(16526019)(1076003)(66946007)(66476007)(66556008)(2906002)(5660300002)(30864003)(55016002)(6666004)(33716001)(86362001)(956004)(45080400002)(316002)(6862004)(8676002)(81156014)(4326008)(52116002)(33656002)(966005)(81166006)(478600001)(6496006)(6636002)(8936002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3391;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuaVoEL6LZDWb7kDoKz9YAwaQ10MT2Q/txJY0xtI9XkCipMg1dSfMuRzxBcaXiMoU9z9Q/ixF0so13OUoFponcfSPODRcp4e/+GiUDWJxqNeQLlj7FDN4NEhUn3W38hQgRX/Xjpj59vPZhobwwIrGIbRLWYEMNKoAobgUdxh+j+/N74vWcLhxjrSi2St6SjFz20hd4x5D1D9xnY02MjApIYTUISx/zREC0oPp1kV92J1MGLrUZfnHLoCFUwdhkGdOShLbIex+yLMMvFZxISsYaQUOmqkjLEi+QEVYexrYBfr7PFqYjZyhdHCgGDR1Q17bWqjmQ8Nno6ereEcz3iJJ0weqKV6+ZjYuqFzjtwZVDHt6vU+p4TgfE/lObyvvQeDFG94DlFsiMNa0AAGQluVW3Rdht7545YAUVpdM5gD+U4GjhwSowgkvLqT8VWh5ULAbNj8d4QCZe3aBqszKpF+yAKdFr7vT2t8H9UYBekHE09istpWCt/lge8l2QkFxilUASmKVyfDCEK7zq+Gbt96BQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b5fffe-6388-4feb-7c53-08d79af99a33
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 03:01:52.5561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ashZSzypuxyuLs8JLIhRtHZx1CBLncKEUu/xOw/KYH8LWea3iBYCfgGykjtOEUXLulhCbncqQhyCPbk9odgUMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 16, 2020 at 06:00:54PM +0800, chen gong wrote:
> Move amdgpu_virt_kiq_rreg/amdgpu_virt_kiq_wreg function to amdgpu_gfx.c,
> and rename them to amdgpu_kiq_rreg/amdgpu_kiq_wreg.Make it generic and
> flexible.
> 

Thanks.

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 96 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 92 ----------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  5 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  5 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  5 +-
>  8 files changed, 108 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2c64d2a..963ea46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -218,7 +218,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  	uint32_t ret;
>  
>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_virt_kiq_rreg(adev, reg);
> +		return amdgpu_kiq_rreg(adev, reg);
>  
>  	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
>  		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -296,7 +296,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  	}
>  
>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_virt_kiq_wreg(adev, reg, v);
> +		return amdgpu_kiq_wreg(adev, reg, v);
>  
>  	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
>  		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b88b8b8..0f960b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -296,7 +296,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>  
>  	spin_lock_init(&kiq->ring_lock);
>  
> -	r = amdgpu_device_wb_get(adev, &adev->virt.reg_val_offs);
> +	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
>  	if (r)
>  		return r;
>  
> @@ -321,7 +321,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>  
>  void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
>  {
> -	amdgpu_device_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
> +	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
>  	amdgpu_ring_fini(ring);
>  }
>  
> @@ -658,3 +658,95 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>  	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
>  	return 0;
>  }
> +
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
> +{
> +	signed long r, cnt = 0;
> +	unsigned long flags;
> +	uint32_t seq;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	struct amdgpu_ring *ring = &kiq->ring;
> +
> +	BUG_ON(!ring->funcs->emit_rreg);
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	amdgpu_ring_alloc(ring, 32);
> +	amdgpu_ring_emit_rreg(ring, reg);
> +	amdgpu_fence_emit_polling(ring, &seq);
> +	amdgpu_ring_commit(ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +	/* don't wait anymore for gpu reset case because this way may
> +	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> +	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> +	 * never return if we keep waiting in virt_kiq_rreg, which cause
> +	 * gpu_recover() hang there.
> +	 *
> +	 * also don't wait anymore for IRQ context
> +	 * */
> +	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
> +		goto failed_kiq_read;
> +
> +	might_sleep();
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	}
> +
> +	if (cnt > MAX_KIQ_REG_TRY)
> +		goto failed_kiq_read;
> +
> +	return adev->wb.wb[kiq->reg_val_offs];
> +
> +failed_kiq_read:
> +	pr_err("failed to read reg:%x\n", reg);
> +	return ~0;
> +}
> +
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
> +{
> +	signed long r, cnt = 0;
> +	unsigned long flags;
> +	uint32_t seq;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	struct amdgpu_ring *ring = &kiq->ring;
> +
> +	BUG_ON(!ring->funcs->emit_wreg);
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	amdgpu_ring_alloc(ring, 32);
> +	amdgpu_ring_emit_wreg(ring, reg, v);
> +	amdgpu_fence_emit_polling(ring, &seq);
> +	amdgpu_ring_commit(ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +	/* don't wait anymore for gpu reset case because this way may
> +	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> +	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> +	 * never return if we keep waiting in virt_kiq_rreg, which cause
> +	 * gpu_recover() hang there.
> +	 *
> +	 * also don't wait anymore for IRQ context
> +	 * */
> +	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
> +		goto failed_kiq_write;
> +
> +	might_sleep();
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +
> +		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	}
> +
> +	if (cnt > MAX_KIQ_REG_TRY)
> +		goto failed_kiq_write;
> +
> +	return;
> +
> +failed_kiq_write:
> +	pr_err("failed to write reg:%x\n", reg);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index af4bd27..ca17ffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -94,6 +94,7 @@ struct amdgpu_kiq {
>  	struct amdgpu_ring	ring;
>  	struct amdgpu_irq_src	irq;
>  	const struct kiq_pm4_funcs *pmf;
> +	uint32_t			reg_val_offs;
>  };
>  
>  /*
> @@ -375,4 +376,6 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>  int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>  				  struct amdgpu_irq_src *source,
>  				  struct amdgpu_iv_entry *entry);
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 103033f..adc813c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -45,98 +45,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>  	adev->pg_flags = 0;
>  }
>  
> -uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
> -{
> -	signed long r, cnt = 0;
> -	unsigned long flags;
> -	uint32_t seq;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -	struct amdgpu_ring *ring = &kiq->ring;
> -
> -	BUG_ON(!ring->funcs->emit_rreg);
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -	amdgpu_ring_alloc(ring, 32);
> -	amdgpu_ring_emit_rreg(ring, reg);
> -	amdgpu_fence_emit_polling(ring, &seq);
> -	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -
> -	/* don't wait anymore for gpu reset case because this way may
> -	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> -	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> -	 * never return if we keep waiting in virt_kiq_rreg, which cause
> -	 * gpu_recover() hang there.
> -	 *
> -	 * also don't wait anymore for IRQ context
> -	 * */
> -	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
> -		goto failed_kiq_read;
> -
> -	might_sleep();
> -	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> -		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -	}
> -
> -	if (cnt > MAX_KIQ_REG_TRY)
> -		goto failed_kiq_read;
> -
> -	return adev->wb.wb[adev->virt.reg_val_offs];
> -
> -failed_kiq_read:
> -	pr_err("failed to read reg:%x\n", reg);
> -	return ~0;
> -}
> -
> -void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
> -{
> -	signed long r, cnt = 0;
> -	unsigned long flags;
> -	uint32_t seq;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -	struct amdgpu_ring *ring = &kiq->ring;
> -
> -	BUG_ON(!ring->funcs->emit_wreg);
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -	amdgpu_ring_alloc(ring, 32);
> -	amdgpu_ring_emit_wreg(ring, reg, v);
> -	amdgpu_fence_emit_polling(ring, &seq);
> -	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -
> -	/* don't wait anymore for gpu reset case because this way may
> -	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> -	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> -	 * never return if we keep waiting in virt_kiq_rreg, which cause
> -	 * gpu_recover() hang there.
> -	 *
> -	 * also don't wait anymore for IRQ context
> -	 * */
> -	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
> -		goto failed_kiq_write;
> -
> -	might_sleep();
> -	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> -
> -		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -	}
> -
> -	if (cnt > MAX_KIQ_REG_TRY)
> -		goto failed_kiq_write;
> -
> -	return;
> -
> -failed_kiq_write:
> -	pr_err("failed to write reg:%x\n", reg);
> -}
> -
>  void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>  					uint32_t reg0, uint32_t reg1,
>  					uint32_t ref, uint32_t mask)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 4d1ac76..daaf909 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -287,8 +287,6 @@ static inline bool is_virtual_machine(void)
>  
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
> -uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> -void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
>  void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>  					uint32_t reg0, uint32_t rreg1,
>  					uint32_t ref, uint32_t mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 1cfc508..e74ed06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4747,6 +4747,7 @@ static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
>  static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>  	amdgpu_ring_write(ring, 0 |	/* src: register*/
> @@ -4755,9 +4756,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>  	amdgpu_ring_write(ring, reg);
>  	amdgpu_ring_write(ring, 0);
>  	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				adev->virt.reg_val_offs * 4));
> +				kiq->reg_val_offs * 4));
>  	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				adev->virt.reg_val_offs * 4));
> +				kiq->reg_val_offs * 4));
>  }
>  
>  static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 306ee61..a46ec1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6450,6 +6450,7 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>  static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>  	amdgpu_ring_write(ring, 0 |	/* src: register*/
> @@ -6458,9 +6459,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>  	amdgpu_ring_write(ring, reg);
>  	amdgpu_ring_write(ring, 0);
>  	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				adev->virt.reg_val_offs * 4));
> +				kiq->reg_val_offs * 4));
>  	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				adev->virt.reg_val_offs * 4));
> +				kiq->reg_val_offs * 4));
>  }
>  
>  static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0dfdc86..d9d7ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5221,6 +5221,7 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>  static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>  	amdgpu_ring_write(ring, 0 |	/* src: register*/
> @@ -5229,9 +5230,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>  	amdgpu_ring_write(ring, reg);
>  	amdgpu_ring_write(ring, 0);
>  	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -				adev->virt.reg_val_offs * 4));
> +				kiq->reg_val_offs * 4));
>  	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -				adev->virt.reg_val_offs * 4));
> +				kiq->reg_val_offs * 4));
>  }
>  
>  static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> -- 
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C5af923f51c4f4ef15d7708d79a6b02f5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147656726826661&amp;sdata=IDIyfAQYOOevkv4LTO05%2BuEdtYzowncU%2BraBH4fFFEw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
