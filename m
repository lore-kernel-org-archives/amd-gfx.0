Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCFFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 06:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF696142A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 06:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FF696142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00826E2EF;
	Thu, 30 Sep 2021 06:27:16 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5E56E2EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 06:27:15 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 l18-20020a05600c4f1200b002f8cf606262so7380011wmq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=JEEZCaJjJIHKuempylm6YiEW3Xfj2CywVOCoQCrFYok=;
 b=LvxwRHpC+PM7aGR1qa1vC2u6hu81pD/+xK/K0/YwMNipnS1zNe1wy7NWaTCHuh5wwu
 JRSCxFDxXGbADvi02E45TyLCfiWZ2HznlZkf/LQ1JKlAzyX2104C6633lqVcIRr4mt98
 nxQd+T501CWWAxOTuunLssL2QDBVGaPCYW688YaewZQekdy475zzz1OqKklc+Mj/xaMv
 llymj2CFuRiOki112phqonljvbx1M7aw9VeS9hwF1McWne5jdGcvis1pOljK2GARHQVx
 Cu8k5uK+FhhLyDHa4ZyCGhUMP000IDG+bWFLMzoHBulvF3bcquv/TCPk+xRrmlen9b9n
 BXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JEEZCaJjJIHKuempylm6YiEW3Xfj2CywVOCoQCrFYok=;
 b=VfRUaVMhl2/Lq+o9y04pG3qnlZ2BJIcu92zL1vP8MR4HPXdoc6cVnTSrNC1xvbWkb2
 qMIt+qseAYj6dA0w0fdaNw3/XKU88CWM1C5NAUYKt0CC5yWDzBQlFZO2I4YpFqvybwM8
 6g2fzPTs/p+du5sauwiknRtROvs1UDAUmj/DxwYuxxE2DYAyWhUm7DICAdMjVmefoJXP
 OsziufluVyELd4F5NBH7J4FALH4I8NSchBAijACirvJQAv0DqiROg56kNCbKhTKuilZU
 CxfF+lRs6CogTvwuBcuotiDeWKLyZlBFCXtxihk5aRJMmMZE59Pcj9gsREAJazTGGKB1
 /9Sw==
X-Gm-Message-State: AOAM533H0Ak6JC9YNB9hHO9q+g45ch/56acRPG0PFAba5f9UXIDw2MHl
 CGH9hQ2lfia/fQZzawlp60QkvF/lyOg=
X-Google-Smtp-Source: ABdhPJyQDRwd1SsI+m7bp2lTBmDH9ebPOAnAuRt7tJ/4LNFVBLRSl+OoBnVZKi87LRFpEzPcbF2anA==
X-Received: by 2002:a05:600c:28e:: with SMTP id
 14mr14574530wmk.88.1632983234102; 
 Wed, 29 Sep 2021 23:27:14 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id n26sm3708497wmi.43.2021.09.29.23.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 23:27:13 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: consolidate case statements
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210929174509.1640343-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e1ed8f5b-fac5-b578-cda6-6f16c2689990@gmail.com>
Date: Thu, 30 Sep 2021 08:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929174509.1640343-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.09.21 um 19:45 schrieb Alex Deucher:
> IP_VERSION(11, 0, 13) does the exact same thing as
> IP_VERSION(11, 0, 12) so squash them together.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 382cebfc2069..aaf200ec982b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -216,13 +216,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>   	case IP_VERSION(11, 0, 7):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 0, 12):
> -		err = psp_init_sos_microcode(psp, chip_name);
> -		if (err)
> -			return err;
> -		err = psp_init_ta_microcode(psp, chip_name);
> -		if (err)
> -			return err;
> -		break;
>   	case IP_VERSION(11, 0, 13):
>   		err = psp_init_sos_microcode(psp, chip_name);
>   		if (err)

