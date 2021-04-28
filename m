Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD5C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 20:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8AF6140C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 20:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8AF6140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC996EC35;
	Wed, 28 Apr 2021 20:52:14 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28586EC35
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 20:52:11 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 k26-20020a4adfba0000b02901f992c7ec7bso738503ook.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vi0UohUJSEwK+caKNBeb1MMBnhf/CY7DzAcyBPmY1dA=;
 b=VPwTzSDlrgnffyd7ezdptzH+Ss55Hy5oj1XDY7R73TMhjdS90DM252m9uKpm20I4hI
 B3ofm/SnpXjiMbXTbG7NgJS/44oAz4GK0CJdoNKcUpMD7ndkXBqyXrhWOQlcxDvHw62o
 3146FxXCRXN2oehdHK0+6UqFCwYPFsl78/QoBLwss5Z+U0RmT2OHFX3RoCDOktIeZqcK
 mKiUSj10d7Rvd/gzwf8vQgLLFpzXfv3mWG6BraNXuDxXXbLwXXT6FgMz7Vyo5O4RmkgH
 xoAQOzhCRDd4oomZz2OZSf0AJ6ya43wp6GM4BvjHSPqFpiYlT84a/iZLsSQZENXhBeME
 1muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vi0UohUJSEwK+caKNBeb1MMBnhf/CY7DzAcyBPmY1dA=;
 b=Rlq9yueYO1EXDHC0MPuTrm/NBepw21y23GkvxA0pK50lQxfc7U87/SI6pZ7hRrql3l
 PngQWO5apnzuZBsZv1k2EavBlHmopkjUJX+5rUR0O4R6OKRUzp/CQgjAihxGQwPFjwfe
 xtdH81h9FgSdI6rHJdVslVw77AIwc0+g4iz7bq+3S1PKJLzQwMeF6owG05tZSUUjHiyT
 Cg4+K5n3xHfawOcuyA9EHJQ+89wVeh0MzCwrseM5CHjFam1XNerl6wdJ3Y3IBkXRMbF/
 vr0RbipmJB6O0xJiZ/bhzp8Ah8FEc54ziFo8iqQy7w1vWMaEo5k/4STS261lksLMDol8
 VuZg==
X-Gm-Message-State: AOAM531F6QmWB6jzYOkJM/Ui1Plf7PEKEg45VRl8jaXNvATg1hJE2Oem
 dPAUBpctgQZuc2QPNwYMSQzAg534AiF/nD6rEu8=
X-Google-Smtp-Source: ABdhPJy/1ELvm4A0HgSH0EFygY0aCZiVTeebLYrWQLNi1u+IuxV+h/qPv4n0WdYbqewGdWuVjorHohB4mXWPjbYTO+E=
X-Received: by 2002:a4a:cb0c:: with SMTP id r12mr24250703ooq.90.1619643131041; 
 Wed, 28 Apr 2021 13:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210427045118.87459-1-pavan.ramayanam@amd.com>
 <CADnq5_PUxtPRnh-Mv8803zdvUn_bf5YRG9a-UVn-2b_vVgUvuA@mail.gmail.com>
In-Reply-To: <CADnq5_PUxtPRnh-Mv8803zdvUn_bf5YRG9a-UVn-2b_vVgUvuA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Apr 2021 16:52:00 -0400
Message-ID: <CADnq5_PrVo7sTpB10nLQ9O2F6ztdX8wdsuHimU8JqsCfDp_K3g@mail.gmail.com>
Subject: Re: [PATCH] Handling of amdgpu_device_resume return value for
 graceful teardown
To: pavan.ramayanam@amd.com
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Apr 27, 2021 at 1:46 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 12:51 AM <pavan.ramayanam@amd.com> wrote:
> >
> > From: Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>
> >
> > The runtime resume PM op disregards the return value from
> > amdgpu_device_resume(), masking errors for failed resumes at the PM
> > layer.
> >
> > Signed-off-by: Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>
>
> Subject should be prefixed with drm/amdgpu:, with that fixed,
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Do you need me to commit this for you?
>
> Alex
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 0369d3532bf0..03f3cf194300 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1574,6 +1574,9 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
> >                 amdgpu_device_baco_exit(drm_dev);
> >         }
> >         ret = amdgpu_device_resume(drm_dev, false);
> > +       if (ret)
> > +               return ret;
> > +
> >         if (amdgpu_device_supports_px(drm_dev))
> >                 drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
> >         adev->in_runpm = false;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
