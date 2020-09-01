Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E3C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 01:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C027C2064B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 01:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2CZlO89h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C027C2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C0F66E560;
	Tue,  1 Sep 2020 01:40:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410C36E560
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 01:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejYIGjn9kS9HMypY/aYi3D7XNkRhftz7mRebGuCNCL9XDWxK3z+m/sws4dT0H6nKo9/J+rMmZygd4mKoUj6jxPlKkQ+lMWL+2xLM4q0jkEv/N6FQKq2OtzeH3fh8ZPEb3mscOqjO9Hmw1TyeaOhFMvmcdHWXszcXE0snEzOvPuuJ1bB3iYwV0U4lPpnwUpUvjvKjtRb5Ja8a20rmGDjfEVAWxdXqA2E5OH35wt2f8fpHj/8zEGkknUt4nT3LkW8Zevrq/8MGAeb7OXYxLpNbvEIE9z3C7+6KJ91CkFV9HlWnoAVMg21YOri2hWioPA481ipa6nG7yk1g7k8uZTGNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=solz++snNwE6xUOQXmqweVHj7uZl7JfdKGsd/ldSX40=;
 b=aYm0iKza2BA2pzdSqQfMXrjIfir/t+7QByWwgb2Yt4ULxgOY0FmtJvkxoWkLiXjyopYcOHbozn6kC8kANDoC1lDM0xLxnaZuCSNKV4Y0/bViccobMGKlYvXMiTklq3ufQycpf33uZtL1w0zcdXR9DNpytL1CzI0Mh5yrV8HeUHOWcGWjt+t9+hXY6JJGfiXqrGLXLtLTmyzWtkidraCh1q+x2Mt11pXB7dXlX0wVVA/IPm/OheMntrRbJv2nsJty4suF2MAIGctVEr4Xw0IqLUDqa6ym1m8P1q0VSHyOkSb0pLuY+e0aqvoiuc8L5aHk/dPO1EHksNg1N9Qg7tMFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=solz++snNwE6xUOQXmqweVHj7uZl7JfdKGsd/ldSX40=;
 b=2CZlO89hRo1jkezPcIm+ARkJG1nvwBF1g7t7aLzGoUdCLpahLW674Sqg/0tpMWrzpWWz1R0aJ/IU+H64UVEJKdg9Vl35Wa+4mcdM5e/wW29RfMp8HdCcNg31i5/R2onQupmlifj1YWO3gMAo0DFG2mzJ96Ju6bdnm9XxSWcKIGc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 1 Sep 2020 01:40:04 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 01:40:04 +0000
Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com,
 christian.koenig@amd.com
References: <20200901011727.14059-1-Dennis.Li@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <41d0b931-653a-0aba-2ab8-b51c459b2012@amd.com>
Date: Mon, 31 Aug 2020 21:40:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200901011727.14059-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::24) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 01:40:04 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:1802:46a:68a:71ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4baf0e6-2869-43ce-33b6-08d84e17f334
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42675A51CA587B4BF96ECAF8EA2E0@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j936l/MXuXa7CC4Pxw7256qMt/qxgZChf3/Bq2rr9rCyt7f5An87kcWu1k1BbSztxv+OK2f6rZpyF+Q3x2+B89C9SvLgfzCPWp168qRc8j1StnWtAM7/sL7RrxyXgtoXm1bWtUWWWaI/ycBUESBWUwl8eucVmmch9rWR+dMZMw9djHwG/+o85rI1FTkZgcDusH4bKFBx6/ONIbOjklwCKwyyvy1nkVx8VcAFC4VlqE0kvtvDSbibnu/SnOBvl5M6N9baxJSa4GxEUGEBmi9rVx4z/UghQEs2qlnhAi6GHTXFBndDtdSeGUYvVhRm2kSdyzxhambIBfcSUqKk2UtI9NsizZZiaX0HduViL/AafFSXMbKz67Ghmmh9zI2Nqbfg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(956004)(31696002)(2616005)(66946007)(31686004)(316002)(52116002)(66556008)(86362001)(6636002)(53546011)(66476007)(6666004)(16576012)(186003)(8676002)(5660300002)(6486002)(2906002)(83380400001)(36756003)(478600001)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wdBaIwIFAwSIT6hE5xwsDNYIM9qfqEu0d9bdX8x8M2W0M0hMRdGoIweLsQNET7spEpL1eY4G9PSvIivxrp+M4FgkPi4E7PAwrjzsYNMe28QhT9P2jxafXWLSaTLGzxhjWgHwmnogbUxiONICikA6wquOw4ZJF5+XJ47sRlV0AUM6xp9lVS0ITN+k7im2HqRkzjNTTyrGdk2asT+PGL6CX5PBPNOm+jfLHxSWyQKV+xDtt+MOVFiNepr0qvuXgyWIoHYIaRYrvSTplmcIbdRmUMAv7DThkoHpa5GR6BqWW2J7Akuk5BvonDik/nF/qJTcB0uoFndDKGyIYbjrG5K9c45gqMQLwtYHwq6gbxnRkM8Rlt3VRh+rDNPQYrhoZ3onPPtQ+mq6CNJsfSaehagVRt6YWYzri9aRSM9sxD+J125+HWqPtNQudLmxrRU2Rk8rWtVBUjjBrevlnXgFJVx2yObZ8mcyOgJ/Qrke/+VQWiIiNDglpZbHmc4S+5p45THjYntf38YoDEajD7w7Im0jpKbr8QKo7piW/v44nNhKfCnh04EbE+obQvtlBqP7P8gdTlh8MH4aDYl4pF9BZK3p9VKayJX58jqYlOlMTYjmndrNjzP0XSwIsVh7pN75ITBJ0zgCbqbKNLapsFS/wLtpbJT0T2/fWjj4L+UaYCLd3/b36l2ut661pMwg3hYIwRUsqMY+xwO6Y9MEZwh8aEpXBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4baf0e6-2869-43ce-33b6-08d84e17f334
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 01:40:04.7719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf0QQDG5dpMpCK/G45ICzfE4gtgLq+ZgDgt3Jhp1aSXTlkb2MJFG9rVqo3Bej9LnyXc3QeGdXdFAC/NF8quOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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


On 8/31/20 9:17 PM, Dennis Li wrote:
> When GPU is in reset, its status isn't stable and ring buffer also need
> be reset when resuming. Therefore driver should protect GPU recovery
> thread from ring buffer accessed by other threads. Otherwise GPU will
> randomly hang during recovery.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 172dc47b7f39..8db56a22cd1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,8 +319,13 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   {
>   	uint32_t ret;
>   
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_kiq_rreg(adev, reg);
> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		amdgpu_sriov_runtime(adev) &&
> +		down_read_trylock(&adev->reset_sem)) {
> +		ret = amdgpu_kiq_rreg(adev, reg);
> +		up_read(&adev->reset_sem);
> +		return ret;
> +	}


Isn't adev->reset_sem non-recursive ? How this works when you try to access 
registers
from within GPU reset thread while adev->reset_sem is already write locked from 
amdgpu_device_lock_adev
earlier in the same thread ?

Andrey


>   
>   	if ((reg * 4) < adev->rmmio_size)
>   		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -332,6 +337,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
>   		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   	}
> +
>   	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
>   	return ret;
>   }
> @@ -407,8 +413,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   		    uint32_t acc_flags)
>   {
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_kiq_wreg(adev, reg, v);
> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		amdgpu_sriov_runtime(adev) &&
> +		down_read_trylock(&adev->reset_sem)) {
> +		amdgpu_kiq_wreg(adev, reg, v);
> +		up_read(&adev->reset_sem);
> +		return;
> +	}
>   
>   	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ad9ad622ccce..4ea2a065daa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -287,7 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq.ring.sched.ready &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -	    !amdgpu_in_reset(adev)) {
> +	    down_read_trylock(&adev->reset_sem)) {
>   
>   		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>   		const unsigned eng = 17;
> @@ -297,6 +297,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   				1 << vmid);
> +
> +		up_read(&adev->reset_sem);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e1a0ae327cf5..33b7cf1c79ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -501,12 +501,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq.ring.sched.ready &&
>   			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -			!amdgpu_in_reset(adev)) {
> +			down_read_trylock(&adev->reset_sem)) {
>   		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>   		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   						   1 << vmid);
> +		up_read(&adev->reset_sem);
>   		return;
>   	}
>   
> @@ -599,7 +600,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	if (amdgpu_in_reset(adev))
>   		return -EIO;
>   
> -	if (ring->sched.ready) {
> +	if (ring->sched.ready &&
> +		 down_read_trylock(&adev->reset_sem)) {
>   		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
>   		 * heavy-weight TLB flush (type 2), which flushes
>   		 * both. Due to a race condition with concurrent
> @@ -626,6 +628,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		if (r) {
>   			amdgpu_ring_undo(ring);
>   			spin_unlock(&adev->gfx.kiq.ring_lock);
> +			up_read(&adev->reset_sem);
>   			return -ETIME;
>   		}
>   
> @@ -634,9 +637,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> +			up_read(&adev->reset_sem);
>   			return -ETIME;
>   		}
> -
> +		up_read(&adev->reset_sem);
>   		return 0;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
