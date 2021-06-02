Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CAFC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 01:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C9A613CD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 01:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C9A613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B32C6EB43;
	Wed,  2 Jun 2021 01:43:48 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52AD6EB43
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 01:43:47 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 x41-20020a05683040a9b02903b37841177eso1083641ott.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Og4pF8mSsbwYgGrfaVYZiLsepJ+hZpXJUZuF9qBJr80=;
 b=nQoMeiksRjieVxod+xgdNf6YGxRQPxad4gNKFZPY7A3Z4qeQ5u7emkfPCnZFKbVjnc
 otx6hT5qVDoDOhI6VRRZyI1BSYxpxGzKM8HOYxboLqg/S8leUvqmzZR5RPg8QH/v1uYz
 E1s7KCQZd38KZeN3wnre89owro+r91Jt8Qbmb0N2eTBKvQtn17+dPHq+GamXkk1NwFVL
 pt2CHSznGA1yG2HaK2yjkouavbE6FiZljzHOgZmTNiMKjUbxOr3/P9t8uN2aIYK5I4a3
 OrNDYemN2RrXcrVtx2gWKWdGph516WheoHGKhHy2MKd/OiW7Mr+SNFr7bay8SJ/Tx5cA
 YjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Og4pF8mSsbwYgGrfaVYZiLsepJ+hZpXJUZuF9qBJr80=;
 b=rCFlM1WlgIPXE/QyHMEioirTIxFZSafRD0RGKNWvy34Yl46m60uHBBjwiU4mWgDvdk
 nZhZyTA2rsub4UqbXfN+Vgebk8AxnApM3gRyRF52V17j0t0DE/S/ECvqKZQIVlZWtSNb
 2MSvKhbP31TEh4e4TZpqM4pMEULovCtWehkKBh2l4aKJVg0H12WZdGcOMvstI2LntDkS
 VjCRZ0wZ90tIl814uWNKGaKSmxkTAMrf307WR7opreWYA6HK2g2MA061B+yDSh34Rimf
 sczL4VJvDiAd+eKTBAGaI9m0RaBc0df8/d2rePR73/ija7d/2UKeiq0RfWt7nwrPF6H8
 Uzyg==
X-Gm-Message-State: AOAM532RJTjDVrJDva3j2pxjuHbr846mYqnN0866Z4Gu31QmdRESz0j5
 AIzanJ7p7w6cu+Iy+5u7b2WjvKowcFO33r0jdqo=
X-Google-Smtp-Source: ABdhPJzGWfqAKNJpLChHNgYhHdh2//9h9ZmjmGYIygtEjsaJhnC1XN4ugjx9YhCTXmKdBfQYngV8J91keLHo5kAiq2k=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr24043234otl.311.1622598227022; 
 Tue, 01 Jun 2021 18:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <RbK0wXzzSSK3M7hx467tnbnCEW1BmHW8lY9PBwcqs4@cp7-web-045.plabs.ch>
 <CAP+8YyGU71kt_OcV-EjboCQFNE7EDwDb2M2mvRx4t9K_Wgg_0g@mail.gmail.com>
In-Reply-To: <CAP+8YyGU71kt_OcV-EjboCQFNE7EDwDb2M2mvRx4t9K_Wgg_0g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 21:43:36 -0400
Message-ID: <CADnq5_MSS3dVaw7YDSpqx1Knr0rMXB282Z6TRbQScqu+zwvoVw@mail.gmail.com>
Subject: Re: [PATCH RESEND] amd/display: convert DRM_DEBUG_ATOMIC to
 drm_dbg_atomic
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, May 26, 2021 at 10:00 AM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>
> I think there are plenty more occurrences too or did I miss the
> cleanup of those?
>
> On Wed, May 26, 2021 at 3:56 PM Simon Ser <contact@emersion.fr> wrote:
> >
> > This allows to tie the log message to a specific DRM device.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 2c9d099adfc2..4dd811816cba 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10089,7 +10089,7 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
> >
> >         if (cursor_scale_w != primary_scale_w ||
> >             cursor_scale_h != primary_scale_h) {
> > -               DRM_DEBUG_ATOMIC("Cursor plane scaling doesn't match primary plane\n");
> > +               drm_dbg_atomic(crtc->dev, "Cursor plane scaling doesn't match primary plane\n");
> >                 return -EINVAL;
> >         }
> >
> > --
> > 2.31.1
> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
