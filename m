Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65FC352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 09:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0062220733
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzpgm5j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0062220733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3AA6EB9F;
	Mon, 10 Feb 2020 09:21:59 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23C56EB9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 09:21:58 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t3so6627214wru.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=93+Gl0fpvJMYazeTeYTBdyBHqvgUDCeLUHXIiR9WpJQ=;
 b=pzpgm5j3dL21MAeRnMhWjf2KOqY2Dk7jIDeDGpKtYiDYvNAnmT/ayl27nGEaajHR8z
 XMuEXsqhIgGmB2WQ6F2LacSeGFkQEi6WUdKdHHc/sRrwwsEs3mI1hQIIeYJMSvdu/TOn
 L6tjQhnm5bYBrIr46L2cgm2kZjbvCF6iBVRAcRGp7XmQk9auFw5GPs+US8QIENDiialv
 sDO5EdHcB0AmGJC3Hykc4AAfLJKzixgOgOe1OkneSWHieTASuwrKHn1hwU318k2tD6V5
 LvYsdj3AqLKCweABFksm6cGX00mvJodkmIL+qVWEWrh+NuzHdO/g/tfMBuwDCyvrHVTq
 Lvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=93+Gl0fpvJMYazeTeYTBdyBHqvgUDCeLUHXIiR9WpJQ=;
 b=aIAlrlTzFlaNX77FVtSpYpEaIvrjM9O4UrSCSrA7T8yRJ6k4l5O30TIONn/ZVQSvS+
 36EfiGVSn1q9l0gpwq/EUxKsd2vdpRKYpXTrqjz6uy9Sm6bv+tnVCnjfD9LQsVItEcT2
 Ijti61+lyiyy2LwW1wbVg6BH17ISiOCKNeYpxnnV1axldHuRjaN/5xU6KtFMzwqjq3LR
 JEwXM3RLlOKD01VUw4VIgJHNdUamDqFWGXPDiHVM8LGdUulxKHvuftCYlllgRgzLzGnK
 HtZHfS2ol7M72+WtgJiMS6wjWJfsRS9ZVE6opbQmdimsIChHaMEfnGwwcTr7EapSfBIG
 dDxQ==
X-Gm-Message-State: APjAAAVMDCV+VCFtX+2DG5EF0zYO1RXNEfkoN+loegdfwujoN3mNdinO
 cGv/rzeKEH3FovGvdjVB4F/rDj06
X-Google-Smtp-Source: APXvYqxIHB5v8bsjxFzqd6A0d6CRQBx7vJxkEHbodzI/MdkGBX3m9lGGE5jWY1p+evVhei7T5Cq4NQ==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr828455wrm.290.1581326517505; 
 Mon, 10 Feb 2020 01:21:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l131sm14938872wmf.31.2020.02.10.01.21.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Feb 2020 01:21:56 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: limit GDS clearing workaround in cold boot
 sequence
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 James.Zhu@amd.com
References: <20200210083327.12487-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7859a4c7-ca03-2181-2dc8-0995ddc9ae72@gmail.com>
Date: Mon, 10 Feb 2020 10:21:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210083327.12487-1-guchun.chen@amd.com>
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

Am 10.02.20 um 09:33 schrieb Guchun Chen:
> GDS clear workaround will cause gfx failure in suspend/resume case.
>
> [   98.679559] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP block <gfx_v9_0> failed -110
> [   98.679561] PM: dpm_run_callback(): pci_pm_resume+0x0/0xa0 returns -110
> [   98.679562] PM: Device 0000:03:00.0 failed to resume async: error -110
>
> As this workaround is specific to the HW bug of GDS's ECC error
> existing in cold boot up, so bypass this workaround in suspend/
> resume case after booting up.

Mhm, why doesn't this also apply for suspend/resume?

I mean the hardware is usually turned off which is equivalent to a cold 
boot up?

Christian.

>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index de59defa91eb..33f282ff245f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4320,9 +4320,12 @@ static int gfx_v9_0_ecc_late_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int r;
>   
> -	r = gfx_v9_0_do_edc_gds_workarounds(adev);
> -	if (r)
> -		return r;
> +	/* limit gds clearing operation in cold boot sequence */
> +	if (!adev->in_suspend) {
> +		r = gfx_v9_0_do_edc_gds_workarounds(adev);
> +		if (r)
> +			return r;
> +	}
>   
>   	/* requires IBs so do in late init after IB pool is initialized */
>   	r = gfx_v9_0_do_edc_gpr_workarounds(adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
