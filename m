Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F06C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 06:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F74110E235;
	Tue, 27 Sep 2022 06:15:49 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5315610E8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 06:15:46 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id lh5so18488308ejb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 23:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=Ltx6YgWGqbIyKShtlgxFNoFKVaCnMWL+xOdk1e0aRDY=;
 b=Hw8cX0+k9YEiHhnP+loVcaKPgyZtL2jYDLFAg91ENQMY1KeMnQp1JD88Q7M+AW4wL5
 JjsSJM9N01SvRm65vPB1E53Y1hGPf9tgueQyMepEmpHY3or9yCMC3IU0LVJ5fXBkXZAe
 mEdmMaCG63lT2M0rUNWUQEUpBkWMI/U+HD3Gzl69U2KYrYkT8df5KruaInUUe8W71yyT
 3/dWf0r7YYzZWoD7BNvTIFgdkg8Exx1U0tdcqG4vewyQv3xeVOqROn1ZyMmpS6kenUsx
 vz6zZ1rPf0P0Ml9b+HsPc6WI+vD3bbVI/wZtsiDdZ7M4LKqrd8gv8CHSxtZEtjc8krlv
 /8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=Ltx6YgWGqbIyKShtlgxFNoFKVaCnMWL+xOdk1e0aRDY=;
 b=yQ3sMgzS5MUbzzTIG9hPK9ZxiGiCVM6HQW0J6sKsNDwt4Iz1FB/DgV7d/HrE+AFGaS
 v/1i+wGEZWaIAHwyviuGtcupx1FHuagk4AIGTiFtpfnlvD5A5mi3sM1iXPYMZkgvTvEK
 kQLVwW3eB+1sMa0TU+BR/MVdZjdoiG8nDld0KMDtl0qHLUdq8zwxn1SDqJP0vlRr6ngf
 I5Pb2i6ZnQ6LzCOrZiKQZwiYYMJYdX7rz4iEY3RyuDUVbVM/KjHztZu/jhYHwOZ5nawe
 3L8QhhsAVURU39yQhYVhdBGXK55gVFTZRhW+vY4skwKvj+jqwIH4RovDM4Ttg2JzEybx
 Zmxg==
X-Gm-Message-State: ACrzQf2Kbqg6Ujx0C6EFcepL8CxjiwAKpRTc+dFRitW9DSus4DnVAVBt
 5YfuyIlzFJfuZAwHaWvp3ZE=
X-Google-Smtp-Source: AMsMyM6Y+RYz5zCBzFMTyPIlG4yihoTBfLubIiKxiRwV9CsTPr+Q1zTRidBk1EgdqJXBAY3uRs9krQ==
X-Received: by 2002:a17:907:a425:b0:783:b550:d99d with SMTP id
 sg37-20020a170907a42500b00783b550d99dmr5465000ejc.17.1664259344749; 
 Mon, 26 Sep 2022 23:15:44 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ebf.dip0.t-ipconnect.de.
 [79.194.14.191]) by smtp.gmail.com with ESMTPSA id
 r17-20020a17090609d100b00781d411a63csm242285eje.151.2022.09.26.23.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Sep 2022 23:15:44 -0700 (PDT)
Message-ID: <88ca9dda-b88b-bd50-7270-04403a91971d@gmail.com>
Date: Tue, 27 Sep 2022 08:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: fix a compiling error in old kernels
Content-Language: en-US
To: Asher Song <Asher.Song@amd.com>, Guchun.Chen@amd.com, flora.cui@amd.com,
 yuliang.shi@amd.com, jun.ma2@amd.com, amd-gfx@lists.freedesktop.org
References: <20220927033743.107390-1-Asher.Song@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220927033743.107390-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 27.09.22 um 05:37 schrieb Asher Song:
> This patch is used to fix following compiling error that occurs in some
> old kernels.
>
> error: ‘for’ loop initial declarations are only allowed in C99 mode
>    for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
>
> Signed-off-by: Asher Song <Asher.Song@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index 772ad200c5da..c91fcde7a16c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -1405,8 +1405,9 @@ void dcn32_update_dsc_pg(struct dc *dc,
>   		bool safe_to_disable)
>   {
>   	struct dce_hwseq *hws = dc->hwseq;
> +	int i;
>   
> -	for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
> +	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
>   		struct display_stream_compressor *dsc = dc->res_pool->dscs[i];
>   		bool is_dsc_ungated = hws->funcs.dsc_pg_status(hws, dsc->inst);
>   

