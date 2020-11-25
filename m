Return-Path: <SRS0=wFA9=E4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_48_96,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB15C56202
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2020 14:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3848E20732
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2020 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmOtCSOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3848E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE41689CE2;
	Sun, 22 Nov 2020 14:42:35 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF9789CDE;
 Sun, 22 Nov 2020 14:42:34 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id w24so14894971wmi.0;
 Sun, 22 Nov 2020 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ZfRvHwqmgeHf8eNDpQN/iHraaYBg+HoCHYTXRagkUtA=;
 b=EmOtCSOjopPQis+QXKljMrjRsZqbefxSBLplY3tRVHE0egqqwAHAu++xQvnTf5OtDb
 wg8axNzXB9h+41gQ0fDW0aWlHvDphI84qke3Enevv0Vnoef5E7EWCiNMLw44hIxZbrwB
 e0ANrA4RQo8fjo977yRqKdVL8Hx2aJO08S9KFwUhR4IF9kTl4ZVDTWxgSt8wQO0zvw5C
 7SbtdGycSRngRgCkqPjD96EardAElCmf+FWS8NpwpzcuF6Wpr0f9uZy5litTwMBR7RB9
 c4nCmJrXXdgMYaE25Qg8RbGvo6AwIK09r9Cnfx2nh1FVauo9hoSWWK3aoVcr70vGEqvW
 /pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ZfRvHwqmgeHf8eNDpQN/iHraaYBg+HoCHYTXRagkUtA=;
 b=avx3pgHNd7j2gBukXD6tqiUvZ3uWlCfUPKpSchl4Y+xHWtQFBl478LLM9YPdPmjo5T
 S8Is5gFSz1xzSzzXSmjehlHM7KRR7iA8LIXQTpPEfP/qPIsWlsl0BxcLlAMx4A4XFxG9
 y4HIIcsQ8w8hfpbjmON9TtmaB9g73xUZ55j9NGVNDNA6UU8dKecsV8Yz17DjqTGK7KLO
 /Zax2IWyZ50AfOcZrwHgh+Vcw5koY/jWcX5umYQNEdxg8rqTX4bbXgJ+snHhQSvjrTob
 KDJ2M+nSRNMwecLcdwRYt8UWq3prm8GpRdpuHjtq5uqLcGvikWxS1YVVZRcGCGrv0FQZ
 H5xw==
X-Gm-Message-State: AOAM533lbT10XLG09KVYwyF/dOCIHbWviYL5NQ6O+VsOjf3KzNKf197z
 38IZEVjlKZkEa7jxp3KKLOzem/4iaP8=
X-Google-Smtp-Source: ABdhPJzkLtchXIs6QtxL+hmYzacYHA+rk3uma5wqQi69XKUZQcf3aozLlh92ERPGLlnGBZzO3ntyYQ==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr18925059wmj.26.1606056153040; 
 Sun, 22 Nov 2020 06:42:33 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f16sm13333686wrp.66.2020.11.22.06.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2020 06:42:32 -0800 (PST)
Subject: Re: [PATCH v3 05/12] drm/ttm: Expose ttm_tt_unpopulate for driver use
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, robh@kernel.org, l.stach@pengutronix.de,
 yuq825@gmail.com, eric@anholt.net
References: <1605936082-3099-1-git-send-email-andrey.grodzovsky@amd.com>
 <1605936082-3099-6-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <28332cf0-612c-10bd-c64e-fff6e1f18653@gmail.com>
Date: Wed, 25 Nov 2020 11:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605936082-3099-6-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 Harry.Wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.11.20 um 06:21 schrieb Andrey Grodzovsky:
> It's needed to drop iommu backed pages on device unplug
> before device's IOMMU group is released.

It would be cleaner if we could do the whole handling in TTM. I also 
need to double check what you are doing with this function.

Christian.

>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_tt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 1ccf1ef..29248a5 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -495,3 +495,4 @@ void ttm_tt_unpopulate(struct ttm_tt *ttm)
>   	else
>   		ttm_pool_unpopulate(ttm);
>   }
> +EXPORT_SYMBOL(ttm_tt_unpopulate);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
