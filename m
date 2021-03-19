Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190BC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188B164F65
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188B164F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07CC6EA22;
	Fri, 19 Mar 2021 14:23:30 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A356E9EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:30:30 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id y200so5676397pfb.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mBRi75+4ZXFYImT5TGU9kGKxGRhGqVxM6M+tAV+mb/E=;
 b=UazQNSNh6OqCQMM7wl92C43GmrPxGV3RZTO1y89v5bBE501r/9WKGlixY+7tAGZMeL
 v1rihy7KJQrRr70kCLg1utX4ZLw15BnWYkmDtcze4PGsl5h7zGOhqRfvfnX7iZri2IeK
 m/E/gTkDMa8E8Jsmtqf12BlJY9luyi+9POcFQErCOwISZg9gXbdzRWg7CGnS6s0afTFs
 WUKpqnWVcxnm86q8NVsJV6ijswLLKfpq6/o5BLRXQ00OZJLwvJ3rYSR5fYBo/vmkhNxx
 ns5vkqPFqwJyGnanDCUOVTbGsq9M6ylYB7FQINiZPwOtBnWlRFqlE2Adv0FI5b9jdTDc
 ejeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mBRi75+4ZXFYImT5TGU9kGKxGRhGqVxM6M+tAV+mb/E=;
 b=phXpPZl6npQCz3j135Ds7hVxTZVc3MMyzOUseoMd2hya/Yb5gTlALzLIN3gNFlD2J3
 aw0YE2GDGZciZ+v3xlDZFwogR3SFium2+n4y5eI//IcwCTzxJVqA8d4cXdbBdsmi9HjJ
 359C9XESmIz0DKSK2J1QjDBXtyc6QHY/fU+nnVoLB/Gior2ErVeH9dbvozOYZujxBGDV
 WeOuQRHVSk6HlIjorv/4KAw4OSKl0+xnk2EpNCfE8YCtEQmGI1cTPISkmhWaOB0aIxTq
 gDYOAaFxnew5s1bjuNHAOl+yCbWqSyZqYVokxIzj2outA+fcn4XnImBgoz6Qb7ylx3YA
 ISWQ==
X-Gm-Message-State: AOAM531+CvlJxldwlGboaNl4gFWpjk3B1zYbTt/uaIIwc0gNHcSgoqIP
 2M3dGyIx1tO6+zzBvTmbKowr5verY2acY02uG+Ayfw==
X-Google-Smtp-Source: ABdhPJyueJqbCvxvjsAE48+4+uzNTfZK3apwOOTQ5ZGtvQfah7LFUXUY4ry2appxkZ5SC84t3BxNou620Ggqog2+hro=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr8786871pfo.12.1616153430352; Fri, 19
 Mar 2021 04:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-19-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-19-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 12:30:19 +0100
Message-ID: <CAG3jFyv2F7ri4wQcwipoLT6nr-K_SWpLcAFi_B0Lo_O+KaWo2w@mail.gmail.com>
Subject: Re: [PATCH 18/30] drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Fri, 19 Mar 2021 14:23:23 +0000
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
Cc: Maxime Ripard <mripard@kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

Thanks for the patch,

On Fri, 19 Feb 2021 at 22:59, Lyude Paul <lyude@redhat.com> wrote:
>
> Since we're about to move drm_dp_helper.c over to drm_dbg_*(), we'll want
> to make sure that we can also add ratelimited versions of these macros in
> order to retain some of the previous debugging output behavior we had.
>
> However, as I was preparing to do this I noticed that the current
> rate limited macros we have are kind of bogus. It looks like when I wrote
> these, I didn't notice that we'd always be calling __ratelimit() even if
> the debugging message we'd be printing would normally be filtered out due
> to the relevant DRM debugging category being disabled.
>
> So, let's fix this by making sure to check drm_debug_enabled() in our
> ratelimited macros before calling __ratelimit(), and start using
> drm_dev_printk() in order to print debugging messages since that will save
> us from doing a redundant drm_debug_enabled() check. And while we're at it,
> let's move the code for this into another macro that we can reuse for
> defining new ratelimited DRM debug macros more easily.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/drm/drm_print.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index f32d179e139d..3a0c3fe4d292 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -524,16 +524,20 @@ void __drm_err(const char *format, ...);
>  #define DRM_DEBUG_DP(fmt, ...)                                         \
>         __drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
>
> -
> -#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...)                            \
> -({                                                                     \
> -       static DEFINE_RATELIMIT_STATE(_rs,                              \
> -                                     DEFAULT_RATELIMIT_INTERVAL,       \
> -                                     DEFAULT_RATELIMIT_BURST);         \
> -       if (__ratelimit(&_rs))                                          \
> -               drm_dev_dbg(NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__);      \
> +#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                                    \
> +({                                                                                               \
> +       static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST); \
> +       const struct drm_device *drm_ = (drm);                                                   \
> +                                                                                                 \
> +       if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))                         \
> +               drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);        \
>  })

checkpatch --strict is unhappy about the tabs/spaces in this patch


ERROR: code indent should use tabs where possible
#48: FILE: include/drm/drm_print.h:531:
+
                           \$

WARNING: please, no spaces at the start of a line
#48: FILE: include/drm/drm_print.h:531:
+
                           \$


>
> +#define drm_dbg_kms_ratelimited(drm, fmt, ...) \
> +       __DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
> +
> +#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
> +
>  /*
>   * struct drm_device based WARNs
>   *
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
