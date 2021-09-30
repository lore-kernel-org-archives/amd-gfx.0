Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB39C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A416B6138F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A416B6138F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B356E158;
	Thu, 30 Sep 2021 16:35:07 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D52B6E158
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 16:35:07 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id v25so503561wra.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=i0dy5Zv+fz6bsHKnpLPiTcEtb7IqldfbtrHZyytOvm0=;
 b=Iv6tNZqgWwr4ZAulEUlzL9IJNI7OYOHE3lI8BxLPflisYFTFTaUT4zk9KmZXEyphRL
 DbIoZlDK7YUM8k84NKIV4b6seJ8391emh92XgZpjqStJeL2A6hQWe7SvcyKpRt37Bdfq
 5oCr5Ed9Uj9QIDhS4YdlT1cAa5IdHxqzf4291idS6Bte6Lm62YIN56k1NXtN91H33bR6
 iMARzMXm3SJnGLwk6pwBGbdJpUpvDSe0wswUFVfJy6kM0XgKurF4Bb8IUEc2fP6MPOsB
 naWO0RlM5KY0Pfbkkj/aj/zsyf0uekpHMJjvwqAxkFYdvE2+e7jPt66C9I8A57gOlBB0
 rxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=i0dy5Zv+fz6bsHKnpLPiTcEtb7IqldfbtrHZyytOvm0=;
 b=e5LRvv5+OgqxYKVDrwux0jHiKNZ959PhCYP0suam+NUZ4KjvUvD5eKz9Zswnd0nxPw
 CHm5vM+5aDwy7vuvqs51Gz7jS28chMvwoS7+ebiAmGvx6Jn/Ql4blPPGTQyxybv+HbWU
 3GdPeQHcH6hQ4cZhIId98pJpcy9UQ6kPvJMmVAdE5ojq22wCw5TtBCjrxMMkDnivtNjC
 AkorcnQhHV9QBMJiglDS7LGeN4BE87wbUkG49sEZHduPLL8Mm22Ppq7TmlEVSIceQGB5
 vqhGXakhZN6TpVSdyvpQDrWYSuc4e8WuXsmh2YU9AEmYfuc+wg0Oa401LCFAvhJMOdBZ
 MKfQ==
X-Gm-Message-State: AOAM531J6kfiOucInkqSYrqN8V9+0EZMKLeOXSwNFwY3XbzOJd4pTj+/
 qiN9MBp/IVtUja22bY/+WNyT4NYpjRNc7719I+Y=
X-Google-Smtp-Source: ABdhPJz0irJSJW0hR8exf6wBIyNKgUbmH8iw9Yu0EToUnUsWdJRgR4rEnIecXpyPMT/Ki76vgcUS5w==
X-Received: by 2002:adf:a745:: with SMTP id e5mr7287316wrd.406.1633019705535; 
 Thu, 30 Sep 2021 09:35:05 -0700 (PDT)
Received: from [192.168.0.61]
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id v10sm3648972wrm.71.2021.09.30.09.35.05
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 09:35:05 -0700 (PDT)
Message-ID: <63cbb603-88d4-c1ac-0ead-fd4e0132aa1c@froggi.es>
Date: Thu, 30 Sep 2021 17:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] drm/amd/display: fix DCC settings for DCN3
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
 <CADnq5_Ps0j20jOkEuU3xJi=v6Qbvp66dFdZOdYrCSn6Q6uknSQ@mail.gmail.com>
 <CAAxE2A6mjGL27dGpq1GCGspsa7CffSGO9MhW8LmFmbZ=JzTr_g@mail.gmail.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <CAAxE2A6mjGL27dGpq1GCGspsa7CffSGO9MhW8LmFmbZ=JzTr_g@mail.gmail.com>
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

Can we please add documentation for this enum?

This was not necessarily a typo, but me misunderstanding and stuff it 
working in my testing.

I guess I don't understand why hubp_ind_block_64b_no_128bcl is for 64b 
&& 128b when it specifically says "no_128" in the name.

Is there something about it I am missing or is it just misleading naming?

- Joshie 🐸✨

On 9/30/21 17:14, Marek Olšák wrote:
> I've also amended the version bump that I forgot to do:
> 
> -#define KMS_DRIVER_MINOR       43
> +#define KMS_DRIVER_MINOR       44
> 
> Marek
> 
> On Thu, Sep 30, 2021 at 12:06 PM Alex Deucher <alexdeucher@gmail.com 
> <mailto:alexdeucher@gmail.com>> wrote:
> 
>     Acked-by: Alex Deucher <alexander.deucher@amd.com
>     <mailto:alexander.deucher@amd.com>>
> 
>     On Thu, Sep 30, 2021 at 11:50 AM Marek Olšák <maraeo@gmail.com
>     <mailto:maraeo@gmail.com>> wrote:
>      >
>      > Hi,
>      >
>      > Just discovered this typo. Please review.
>      >
>      > Thanks,
>      > Marek
> 

