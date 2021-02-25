Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30DDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E85B64EC8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E85B64EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C934E6E0D1;
	Thu, 25 Feb 2021 21:27:07 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006AF89CAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 21:27:06 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id d9so7109756ote.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 13:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XfLgOJEekZp7hKpOQ9RS6avoCsUkzQjf3c0MRL6QqcQ=;
 b=oIpm3EBNnaXk3PghlpyMkevHvLPdm797uB0tHZBpahAjrIURdURiJbqls1Ahihk5iS
 /VSrAu9Q1fPU/7pMOhkAUoweXd5dhdhSRT+pKGYG0snSfdxTSXRAT91B6cc6wZ6rvQB7
 OjdWnJdOERRTnX3X03Nzz60x0OHGBksbdHBel0/OpBfyg2IS7gWVUkzlrW6qKsgeki0V
 zFaeED6LMjbQYMhStPeH4ZXJMsidbOAN8f5Y5lj+L+ycxusiFe1UkVHMTkEPxJ/07LZs
 1ozpQDJJE6qF20pyjmIAozEhgL1MLjbYH4RPTFNyHu2Z3v5nptVa17z/U1gOzwlz+0YP
 +DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XfLgOJEekZp7hKpOQ9RS6avoCsUkzQjf3c0MRL6QqcQ=;
 b=SPICYUcvohSsD+2UyQ3B2Sx3fY7bEphpknIMe8eSLsAcpDcpmPnQC6/vBUD53hO4IS
 mA/fq7JVs8McAsUI7xQ1+PmRp1Vvwg1CsD3MH/439NsKiSSwRrsBTgblHjsu2AAnpzjA
 95bukY39Ucv48L1zzrsl+OA/Mbp1OSlNARixFP5FoWBmO+LpM+mISZ+vcH3gwijsjz/4
 XNmLbPTMsulrmFuCxvOmVYiXDjDdZroBcYv89SUKAZU0g5IrwwWdxV4/c0fO8cFKlJ/v
 dvzEi+V9MUL8XDK1/qryfmtJNfNTG216Uuq4CRyBSJY/UmXsEdGoAl+uE+BUgwpy0WFK
 gTow==
X-Gm-Message-State: AOAM533m5XHAULpADdD9Wuwd355keSj+rLk0yMtjZx6GCACyKF2DHt8f
 ncSNpnK3SHKeWtSNeqTHCaNj5PctCYFiacdN2/Y=
X-Google-Smtp-Source: ABdhPJz/UFodedG4pDI686kqz/arAun/8hsS3czEvkg3uyN8Y7TeD6nqNFsZyh9LLgWq3EmSRAAlpB9+KmLNndX8g9w=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4076828oti.132.1614288426153; 
 Thu, 25 Feb 2021 13:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20210223213408.65847-1-jonathan.kim@amd.com>
In-Reply-To: <20210223213408.65847-1-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Feb 2021 16:26:55 -0500
Message-ID: <CADnq5_NC9+2Egkeo9aGEb+9hdBiaxs=x5WWEVTrF4s=yidkRKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing df counter disable write
To: Jonathan Kim <jonathan.kim@amd.com>
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 23, 2021 at 4:34 PM Jonathan Kim <jonathan.kim@amd.com> wrote:
>
> Request to stop DF performance counters is missing the actual write to the
> controller register.
>
> Reported-by: Chris Freehill <chris.freehill@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 6b4b30a8dce5..44109a6b8f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -568,6 +568,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
>                 if (ret)
>                         return ret;
>
> +               df_v3_6_perfmon_wreg(adev, lo_base_addr, lo_val,
> +                                                       hi_base_addr, hi_val);
>
>                 if (is_remove) {
>                         df_v3_6_reset_perfmon_cntr(adev, config, counter_idx);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
