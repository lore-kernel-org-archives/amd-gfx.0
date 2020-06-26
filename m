Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2443C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 17:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6E206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4qa4EkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E2D6E14F;
	Fri, 26 Jun 2020 17:04:24 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0226E14F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 17:04:23 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id h5so10174905wrc.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ibB27vs/PEK089BSrPcul0RY1rW1kODUa7BzpUTWiU0=;
 b=R4qa4EkZUleIfdLMEyb2CKO31kYSQZBBxVssQJYIpFzsiAZhqIBIzGmWlNjpgeLSqB
 BLZ2x5eNPzt0oZ8SPDYFZD0IKv3ePa86deGi0xHaKoxQA1fH+oOkZ+T/RXtFjfJNEtw2
 y9ocl5MclkGSBHyWhzWipcW51/geKmHo225sUIRGZ8MnFtTJsVo64o74TonLffjXGqZB
 Z/mvWPOBN+2eTH/yktXBluwddEJBLuHd5XWsn4xsRrHD8ZwOeElfhjL5iD45dvDKezxA
 EtfxQp4tH4nl9sPD3ekW1/MJrLoa3kuPx9JZRSGPU2viIPzD+ayS03z/ddEbNP0qtVto
 Mwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ibB27vs/PEK089BSrPcul0RY1rW1kODUa7BzpUTWiU0=;
 b=TLh/IzfYeOT8aOLiTV4cEdINhY9G/Qg1g5GzUL/OuJKIT3zLK8ympMe+SWtw5dmhtw
 px/mOEFxJJ9GFBjcZYbt1+Ufti5tgaASHgQ4Hon35pCskYZzLVaPcQQT/awI82H0V9Hp
 GCuLOMviFMSSKNJ1qWkoz9yp51dZvKfokNGNYbW38vcw/Syn4h0I2B4SK4r/laSHr13b
 DDg5KvcxP6vzGb8Eq4tNIBe28tJlcCeGsoJQS56X5EJG2cwuo7pXBQ93DYGMZncszmAZ
 u9JCcTr70ALDkN/tG3ymW93sscjuvuzFykp8ZF4/fBDe58LEmRsaJHjHyS9giGDpe9oA
 amZw==
X-Gm-Message-State: AOAM530LbTWGldtDHG/QksB6/5oenbed7bEhcuk7xVRuC8PTEQddG1Wy
 2PJuSQnulv+kMyxYifj2axk=
X-Google-Smtp-Source: ABdhPJx31vmcKZC4cx8P1lLeqXY1efDkePNu0KB+DFhIDyTXz9xRgw6z+2Dj7zMiqWp1Cmcr9lB43w==
X-Received: by 2002:adf:9062:: with SMTP id h89mr4421425wrh.285.1593191061767; 
 Fri, 26 Jun 2020 10:04:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f16sm18415737wmh.27.2020.06.26.10.04.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jun 2020 10:04:21 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Adding wait time before reading upll control
 register
To: Alex Jivin <alex.jivin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200626161239.19762-1-alex.jivin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a3c7780c-d891-4cf6-f49b-e72692803615@gmail.com>
Date: Fri, 26 Jun 2020 19:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200626161239.19762-1-alex.jivin@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.06.20 um 18:12 schrieb Alex Jivin:
> Adding a delay between writing to UVD control register and reading from it.
> This is to allow the HW to process the write command.
>
> Signed-off-by: Alex Jivin <alex.jivin@amd.com>
> Suggested-By: Luben Tukov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/si.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 9d7b4ccd17b8..42cdc14fb79d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1435,6 +1435,12 @@ static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
>   	/* Assert UPLL_CTLREQ */
>   	WREG32_P(cg_upll_func_cntl, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
>   
> +	/* Waiting for HW to process the previous write.
> +	 * This is to give a chance to HW to act before
> +	 * the first read is done.
> +	 */
> +	mdelay(1);
> +

Mhm, that is most likely not a good idea.

We need to issue a read after the write to make sure that the stuff is 
send out to the hardware.

Adding a delay here is probably just postponing that. Do we have some 
note in the documentation that this is necessary?

Christian.

>   	/* Wait for CTLACK and CTLACK2 to get asserted */
>   	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
>   		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
