Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E71C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785686056B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 785686056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6106E071;
	Tue,  7 Sep 2021 17:03:46 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC02A6E071
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 17:03:44 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 a20-20020a0568300b9400b0051b8ca82dfcso13608608otv.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m9KwqeMdnHHxmOkXIxvjvRaFZzOyXxYoUws6DRtPOiY=;
 b=MjAqhBoIT5i//kX3F4ZP3GON3gIAjHBTU+bcD0a5/cAqmml6qC2jtiuYKwV+keZXry
 nexu+ZVfnusEDWtltx12htRq2DYA3xOFe6MyLE1+Fig9CU8o4FK/C9xCJk9sPHsPov4O
 8SAaAIQCUj+YVVEPvx61Z0m5tF+SSVApGqcPG6d2nAAgPwUN3XGMbmI4gJx8QwgpyvPG
 Jtazb8Q7Yy9MXRzlhhkPknpF60n1gznoB9h12FGyd+NLYXI/xqOHm9nWjZfYtq+5Q1Xz
 GAiJeQ3XTW+JfYt5JuIFVkW6l8cS9vKophAaE204yNo91wcWcFUfloUOUj5CKKtatv8f
 2cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m9KwqeMdnHHxmOkXIxvjvRaFZzOyXxYoUws6DRtPOiY=;
 b=pegaJF2UxIxWmJJhmTLrEitKqe/3YFugOdWVWMuO19k4OoE1SDnsDKZVSv+SySDZCO
 0WR0maMbDjMkY8bL5Jx4VCxrC53nq52/QPdi7WBDaBHRwdGZgUwJKF06GZ0fh1fykQ0b
 gUVtXislImzMiS1Jdurtam6PCPuaaOPHGxa/Jg4jq8MdhWt7S3FPmaHeBOSJGUWpnm/t
 H40xGAHV508p9ZNfyfQm34y4BiE81sUpJqqFr/RkmtsE7U8cxy6DjCkafI+Ox+tKM0sF
 bzEkF9Pl1POxlih66Gbp4mdvCLM0OHsNjklT1W0CxTa9Jw3+lgHumm/asnP/xzGD9PD+
 JOKQ==
X-Gm-Message-State: AOAM533vV6H1nXDg4DuuK3LMTt3qyJFPUt1Dxdv8vhhOXiAmkVEsWite
 wnu8Kn4j90SNRvmEp5kusJMEO+Ad/8Hb1wkNk8+6fN5s
X-Google-Smtp-Source: ABdhPJzeDYLWoBoqF6ER60gY3KmozGqNMf6mbiUdGTJul0PqatjV3Zfj+UKqj+E2eSvrco/n3y4z/HApVKaNgH1iREA=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr16419966otu.357.1631034223949; 
 Tue, 07 Sep 2021 10:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141925.125177-1-contact@emersion.fr>
 <bc35bf95-0eb2-a0d5-0f9d-f2ac5c02426c@amd.com>
In-Reply-To: <bc35bf95-0eb2-a0d5-0f9d-f2ac5c02426c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Sep 2021 13:03:32 -0400
Message-ID: <CADnq5_OTjzPaPLB0qXxpjBSiaNu5+miWSz2CNwbB3LwPpWUchQ@mail.gmail.com>
Subject: Re: [PATCH] amd/display: downgrade validation failure log level
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc: Simon Ser <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Applied.  Thanks!

Alex

On Tue, Sep 7, 2021 at 10:21 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2021-09-07 10:19 a.m., Simon Ser wrote:
> > In amdgpu_dm_atomic_check, dc_validate_global_state is called. On
> > failure this logs a warning to the kernel journal. However warnings
> > shouldn't be used for atomic test-only commit failures: user-space
> > might be perfoming a lot of atomic test-only commits to find the
> > best hardware configuration.
> >
> > Downgrade the log to a regular DRM atomic message. While at it, use
> > the new device-aware logging infrastructure.
> >
> > This fixes error messages in the kernel when running gamescope [1].
> >
> > [1]: https://github.com/Plagman/gamescope/issues/245
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Makes sense since validation can fail. Thanks for the patch!
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Regards,
> Nicholas Kazlauskas
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 986c9d29d686..6f3b6f2a952c 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10467,7 +10467,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
> >                       goto fail;
> >               status = dc_validate_global_state(dc, dm_state->context, false);
> >               if (status != DC_OK) {
> > -                     DC_LOG_WARNING("DC global validation failure: %s (%d)",
> > +                     drm_dbg_atomic(dev,
> > +                                    "DC global validation failure: %s (%d)",
> >                                      dc_status_to_str(status), status);
> >                       ret = -EINVAL;
> >                       goto fail;
> >
>
