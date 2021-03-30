Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E597DC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B5B619BD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B5B619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D516E8FB;
	Tue, 30 Mar 2021 13:24:49 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E276E8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 10:43:26 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id ay2so5941914plb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=inEEvxoI2d27PWTByb00t7709zab101mRTK+HEEURs0=;
 b=C9+RPFkWx1dnLku0VJzXhT4WCqoHsMPAfkkwl/4KohDQakhhONCUx+woSyEwYjrpXR
 t1d16MDlzS32+twkwF9bbNrzqgVVnTIfoI0AZogYL4G1S7OgpeJg0emu3T5/HWp5kcJG
 ++epmYQmqILHMzY2hL2QmPVz7uTVYnSW6ybUpM4NE/4ka6AX9/8CrsJwa6V5+njYVIo+
 XgbVwDjQ2vtltDtglB4fNijvaQUZc0s53NH8e1EYls6/XbWYbhbOWqh0zjfmI0VBaOGj
 vhK9ArLDxUL+ZjLu/rXXyDanwAeMXX50oJ08dRer+OEiWgpVZHK0JFYQd9TBlKlb28DY
 jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=inEEvxoI2d27PWTByb00t7709zab101mRTK+HEEURs0=;
 b=qCDRQQuyZizEXUb3/LQTv32WUZQuq1lzywIWYujmIxfjYMIOlRoI/GIlrrB8ezDQ4o
 RFR+95oa8uKyR2f09dOAjboShicjr7xf2Yo3++31eJACaQdN/LJLazQiz8Qa49nI6tJ9
 zLMaieC7hbiDthPPuATcheonRpQeJhMic3UCGamgZ4EKlQ9sAxhIO1C6pa4Rq8d67IY6
 5NxVh310hkvVKBSXnssVFlwYrEPDKuQSi/1x4BthIaVx9nwu7vQyHKaUs7hPPripf562
 tXPUtndJhr5KHtQHqm4Df0YrKE9qBB+2dulBFBkq4qXNRpbn4WRtrB/d6lGfDB/SnElD
 BSaA==
X-Gm-Message-State: AOAM533kuFLtozFsNLxw2kKVh5pY+KZVwVWRFf1kY4Uv6cecPhFFCVCj
 nQQA5X/WdosRArCk/qVXF0MSoyishGa727IOiHSxgw==
X-Google-Smtp-Source: ABdhPJxPMfsifg57CMk+e08YOVt3TzMww6aMvw5ulnMzAx23GI1ES2FVCsm8qjLz2RBA6UgJxREJNfH8cDlZ1xM4T2Y=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr32807495plf.69.1617101006157; Tue, 30
 Mar 2021 03:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210326203807.105754-1-lyude@redhat.com>
 <20210326203807.105754-8-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-8-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Tue, 30 Mar 2021 12:43:15 +0200
Message-ID: <CAG3jFyvK6bk5mF_Jp6w9HpN2rDAPKkdHKbQMRKiW6gGKdR9-Yw@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Tue, 30 Mar 2021 13:24:40 +0000
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

I'm seeing no issues with this patch and the reasoning behind the
patch is sound to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 26 Mar 2021 at 21:39, Lyude Paul <lyude@redhat.com> wrote:
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
> v2:
> * Make sure to use tabs where possible in __DRM_DEFINE_DBG_RATELIMITED()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> ---
>  include/drm/drm_print.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index f32d179e139d..a3c58c941bdc 100644
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
> +#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                                  \
> +({                                                                                             \
> +       static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);\
> +       const struct drm_device *drm_ = (drm);                                                  \
> +                                                                                               \
> +       if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))                        \
> +               drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);       \
>  })
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
> 2.30.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
