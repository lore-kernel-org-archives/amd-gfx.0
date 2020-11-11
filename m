Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_48_96,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A171C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 09:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD9020719
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 09:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv+z6rUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD9020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E129189826;
	Mon,  9 Nov 2020 09:06:44 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B4789826
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 09:06:43 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id o21so11133478ejb.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=n/ZkDPrxYQnBPGruplLBCZYDs70O/RHL1QZXd1r0x1s=;
 b=kv+z6rUbAZatEAKZHssiolIEICTIYyAjD8fQZ2oyAvyPMQxnbgiVPAGHX9twnqhzJX
 LY/JWe+xHE4pT0UjgKKEmLFmnK8knPS4QLMOcbxgoGMEJZNQg/aiVY6JvUPg4WDlIkrj
 MpuEXg/xpD4E/UKwER3OdLK1YtKTUIK8zSBxXUJUamjAehB+UgVBJV7clAfTKXNwbtJ/
 J8oKQPsmH2bgoyAfpKTfunLKVhIuY6stCX4kRwIyvRt0mKudEUqqHrPDWGey+xYPjQpN
 u1pQZ48FcoBUjvVBiQduDTBtNM/MkYDq6oCmVpHY35BAXCfaLFzGimkKa0zhnZjYdj8V
 avsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=n/ZkDPrxYQnBPGruplLBCZYDs70O/RHL1QZXd1r0x1s=;
 b=uVyo4+IOsE79N4hKFZIDwLkMcDmrFUTIZ+IEELg+YA7RFq3nZ+oJyiSUK+++5Yff57
 Ym218x9sEk32s+BytaGrvdm0LHPrCQ9LDM8rMvurADWeSbEsCjqfpKzDBEyVy+zwAyyl
 RN0LH7fHGoEToBiCfu0eTM/U1xVxRUUs899dhSNY48UwF7i0NJg58mqOtZPLKKya2tuN
 4EPhtQPaxi1EszUxSa6J+d//YZXviGg23nB7mLeHEsZCctoYavNEyOrVgqsCnX6TGJFB
 UfYl30rkpaYlEVUjyX3NVkNHDUlUupnsYCdir56O+YY0SdnQ0uAxh/Fcqz6Y0bFbXbjf
 V+5A==
X-Gm-Message-State: AOAM530MCs9vrJ+UCwFFvSP37E9BGBGhFPpBKKzHJVIPf9f+Om63mCu/
 RsOkemsJ2cEaRGGovXeLdSTvIQiAyiA=
X-Google-Smtp-Source: ABdhPJzx3kMrK9OPsC3TYW4hTevTHmIknGw5y2Ig/T1yw6HNR07Z7xaREn4SFckFfX9pTFSVwn021w==
X-Received: by 2002:a17:906:3a8d:: with SMTP id
 y13mr14488979ejd.460.1604912801950; 
 Mon, 09 Nov 2020 01:06:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k2sm8316485ejp.6.2020.11.09.01.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 01:06:41 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix SI UVD firmware validate resume fail
To: Sonny Jiang <sonny.jiang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201108150953.12042-1-sonny.jiang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d0bdc224-6a4c-1e49-3cfc-1d4988b8516b@gmail.com>
Date: Wed, 11 Nov 2020 18:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201108150953.12042-1-sonny.jiang@amd.com>
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

Am 08.11.20 um 16:09 schrieb Sonny Jiang:
> The SI UVD firmware validate key is stored at the end of firmware,
> which is changed during resume while playing video. So only to get
> the key at device initialization and save it for later using.
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 7cf4b11a65c5..aab7415c1a32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -279,13 +279,16 @@ static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
>   {
>   	void *ptr;
>   	uint32_t ucode_len, i;
> -	uint32_t keysel;
> -
> -	ptr = adev->uvd.inst[0].cpu_addr;
> -	ptr += 192 + 16;
> -	memcpy(&ucode_len, ptr, 4);
> -	ptr += ucode_len;
> -	memcpy(&keysel, ptr, 4);
> +	static uint32_t keysel = 0;

Well, that is a really big NAK.

You can't just make a variable static and hope that we don't have 
multiple instances of the device driver loaded.

If you need to keep the value around put it into adev somehow.

Christian.

> +
> +	/* Only get the validate key at device initialization*/
> +	if (!keysel) {
> +		ptr = adev->uvd.inst[0].cpu_addr;
> +		ptr += 192 + 16;
> +		memcpy(&ucode_len, ptr, 4);
> +		ptr += ucode_len;
> +		memcpy(&keysel, ptr, 4);
> +	}
>   
>   	WREG32(mmUVD_FW_START, keysel);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
