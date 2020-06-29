Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A037C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000382336F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKi3FLO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000382336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D4689E35;
	Mon, 29 Jun 2020 08:18:28 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D64389E35
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 08:18:27 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id w16so15661381ejj.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mzsYCpel9v3PBgkdZZ9Vkz5y0nsHd6t2h3UZgEnCMso=;
 b=uKi3FLO8weV88jqln0A04JqUkEe8TQqdRLccTx0BNDRWhEzwFLu3XBVkRa2q21mxp5
 JNssSiC28yFYhJPrWPs9PCe21Jju5jK7Gc529a+9XuCjZBPLx7h7P47UcD8TWBGMOhG7
 D5PneAVVUuBcTrvttab5kArackbgaZMimjJ6SOzqG8Ey18EWeTNjHKL2o6hcJVo5ODLi
 GW6Q6hukC9THdNNLqQjmly+yS2etG4BHg+KI2WrZenmSSjgYe5mQwwV76+0D3PrcvLro
 T/kcnc9PNQZdESNZ4uZKD36p7igsbIxercn2METrraGF74HzLEnGzlr2XFpxMVbKHX0o
 gDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mzsYCpel9v3PBgkdZZ9Vkz5y0nsHd6t2h3UZgEnCMso=;
 b=lEk1wI/g+sJt1YF89pCXn/aQYHKtj6Wd6GPFCIFSaZH8vrAPs+q1tJrDDquRyPTMJN
 /ORsO+aQojNr/902Yyu40jwC8cZIdRvgBVpLoWR7+x+GtWH/Fpakt/qLzxMD394bIGp/
 AWSPZuFRVxQVGDTKm70O9rfjZTzPk3BgWUQwjCb7Q33UUUyPKxJMcPZLnO2t2UU2Qf7P
 Nek5aP53HamDDTRqI+vVdWW8MDuQCKhBTWZx1zHsleaQjZu1aSw/c87Sz3eZG37KwsPw
 WaKrW3LcjQICyBjzJSpjaNSV/sGzB/DynVGeEjKwhPaIv/E2i+qd/T3kTNHCzuJv96wr
 LTeA==
X-Gm-Message-State: AOAM533DOhBtRkayhLB5tKeTU4mAPGDyKhNux4toZQoRuqh65RQLxZ69
 +CUfgzII6N3mOXh+Fw+48b7Et809
X-Google-Smtp-Source: ABdhPJysTY4EWMX9rcS4HtFyOLeMlYF1s2mLREZgqiCkDEthwwfJGo6PFgBNIWlkoFqtQ5V8UvDLOw==
X-Received: by 2002:a17:907:4003:: with SMTP id
 nj3mr11406367ejb.278.1593418705458; 
 Mon, 29 Jun 2020 01:18:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z25sm296759ejd.38.2020.06.29.01.18.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:18:24 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: make IB test synchronize with init for SRIOV
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1593414689-17565-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <87e8a1bc-62b7-5599-4263-dd63546f69f7@gmail.com>
Date: Mon, 29 Jun 2020 10:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1593414689-17565-1-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.06.20 um 09:11 schrieb Monk Liu:
> From: pengzhou <PengJu.Zhou@amd.com>
>
> issue:
> originally we kickoff IB test asynchronously with driver's init, thus
> the IB test may still running when the driver loading done (modprobe amdgpu done).
> if we shutdown VM immediately after amdgpu driver loaded then GPU may
> hang because the IB test is still running
>
> fix:
> make IB test synchronize with driver init thus it won't still running
> when we shutdown the VM.

We explicitly added the asynchronously IB test for SRIOV to make driver 
load faster. Why is that now a problem?

And why would it help when the VM shuts down? We cancel/flush the test 
during driver unload/suspend as well.

>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 457f5d2..4f54660 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3292,8 +3292,16 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* must succeed. */
>   	amdgpu_ras_resume(adev);
>   
> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
> +	if (amdgpu_sriov_vf(adev)) {
> +		r = amdgpu_ib_ring_tests(adev);
> +		if (r) {
> +			DRM_ERROR("ib ring test failed (%d).\n", r);
> +			return r;
> +		}
> +	} else {
> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>   			   msecs_to_jiffies(AMDGPU_RESUME_MS));
> +	}
>   
>   	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
>   	if (r) {
> @@ -3329,7 +3337,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   	int r;
>   
>   	DRM_INFO("amdgpu: finishing device.\n");
> -	flush_delayed_work(&adev->delayed_init_work);
> +	if (!amdgpu_sriov_vf(adev))
> +		flush_delayed_work(&adev->delayed_init_work);

You can drop this change, flushing a work which was never scheduled is 
harmless.

>   	adev->shutdown = true;
>   
>   	/* make sure IB test finished before entering exclusive mode
> @@ -3425,7 +3434,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (fbcon)
>   		amdgpu_fbdev_set_suspend(adev, 1);
>   
> -	cancel_delayed_work_sync(&adev->delayed_init_work);
> +	if (!amdgpu_sriov_vf(adev))
> +		cancel_delayed_work_sync(&adev->delayed_init_work);
>   
>   	if (!amdgpu_device_has_dc_support(adev)) {
>   		/* turn off display hw */
> @@ -3528,8 +3538,16 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	if (r)
>   		return r;
>   
> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
> +	if (amdgpu_sriov_vf(adev)) {
> +		r = amdgpu_ib_ring_tests(adev);
> +		if (r) {
> +			DRM_ERROR("ib ring test failed (%d).\n", r);
> +			return r;
> +		}
> +	} else {
> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>   			   msecs_to_jiffies(AMDGPU_RESUME_MS));
> +	}
>   
>   	if (!amdgpu_device_has_dc_support(adev)) {
>   		/* pin cursors */
> @@ -3554,7 +3572,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   		return r;
>   
>   	/* Make sure IB tests flushed */
> -	flush_delayed_work(&adev->delayed_init_work);
> +	if (!amdgpu_sriov_vf(adev))
> +		flush_delayed_work(&adev->delayed_init_work);
>   
>   	/* blat the mode back in */
>   	if (fbcon) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
