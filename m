Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06E1C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 16:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12232173E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUJnmQHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12232173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1526E0D1;
	Tue, 28 Jan 2020 16:44:12 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AA56E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 16:44:11 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id e7so14994656iof.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jtrMH5RFqFz1TP5tkS8PuoJ81SGX8yUHp61Ylk/7eCo=;
 b=nUJnmQHS5oBgBJGFgLSVUIxndA12pjyUBbBn3COShJ65gzz3+OrX1WM3Bgnd101I2A
 Ejra62yetoNclviJuXHELFpH2UUgWA+1fN3z/ZOzwsZv/sFBNsZlLW7RigrSunw7xfeh
 YQGvkMDuwg8scf1vxhKGIgAHVFKd0RNC56C9j95aMEKtFzykfs08bkGMY0+GB3e+Y8ci
 6Flfmi7GZCJQoR307vTdvaqNrtz2umWsbV2p4y9fXoDdcqFpnlr09/xgwJqMYZ7rmVQi
 ijwxugjWLICo2B2ZaHvL5zlv+nqco5d1IaN500SA9myOgXrpJk4dx2KP6+XJQlGuB/sO
 8omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jtrMH5RFqFz1TP5tkS8PuoJ81SGX8yUHp61Ylk/7eCo=;
 b=lPs9JRgAb/5SC9YWZsS17d/yy9mn0taslJwotq32uHK170h7+YVv4zaS1P+c2tgpdn
 4qBb1rFn4zh85HF4RZA2ENvwtqllhzVkkq7N+KLJl/pjvQt3sfRkRgUxVJgNIbpnTo1E
 JEpXqDpthd0RCDb3o7uuDiJEWmuBLfmEsPxkgv418BtMR5Gubh03VN+Ef7Saix8mc/Yb
 slEWc+Y2WhDfeEBqR0pmtIeb8t0hFTQH6w7/oD9DSbYso71E6Buow5z+aga8eTct4AML
 dQkG4qXHFjiEV1UGavzqB2JJTXqXyoLspRCrz49santD5Qtm4SrILFrnLorhxGNtS9wK
 DWww==
X-Gm-Message-State: APjAAAWDYHMlJY1GhPbWadBMUYT5KXFkKWR9nH6oJFnwu/7B4IwzREu2
 jNgoFWbC/NDaUKKp9rSrY3E=
X-Google-Smtp-Source: APXvYqyQ5A/MD9Ibb2Y5QqsFUenSMov31VUYPyn4eq1hX6o9OGYsT1GF80ImW+lkE+gwPkObq5347w==
X-Received: by 2002:a05:6638:2b7:: with SMTP id
 d23mr18190823jaq.108.1580229850641; 
 Tue, 28 Jan 2020 08:44:10 -0800 (PST)
Received: from ?IPv6:2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b?
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id y11sm4479318iol.23.2020.01.28.08.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 08:44:10 -0800 (PST)
Subject: Re: [PATCH 3/3] drm/amdgpu/navi10: add OD support for restoring
 default table
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200125184845.4233-1-alexander.deucher@amd.com>
 <20200125184845.4233-3-alexander.deucher@amd.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <f51f32b5-9a08-bb30-66e9-52bddb8f469c@gmail.com>
Date: Tue, 28 Jan 2020 09:44:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200125184845.4233-3-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For this, I believe we're updating `table_context->overdrive_table` with
the values set by the user, wouldn't the intended behavior here be to
restore the settings that were there on boot?



If so, I think we'd have to cache the overdrive table that was there on
boot, and use that in the response for `PP_OD_RESTORE_DEFAULT_TABLE`, no?



I'm doing some testing on this patchset, but on initial lookover that's
the only thing I saw. I could be mistaken, but I think this just writes
the overdrive table that we are currently using over again instead of
writing the default one.

On 1/25/20 11:48 AM, Alex Deucher wrote:
> Was missing before.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index d2d45181ae23..f60762f9b143 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2062,6 +2062,14 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>  		if (ret)
>  			return ret;
>  		od_table->UclkFmax = input[1];
> +		break;
> +	case PP_OD_RESTORE_DEFAULT_TABLE:
> +		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
> +		if (ret) {
> +			pr_err("Failed to export over drive table!\n");
> +			return ret;
> +		}
> +
>  		break;
>  	case PP_OD_COMMIT_DPM_TABLE:
>  		navi10_dump_od_table(od_table);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
