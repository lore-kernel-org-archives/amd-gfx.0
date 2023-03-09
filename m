Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF71C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 20:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526B610E2A7;
	Thu,  9 Mar 2023 20:24:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC6610E2B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678393438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yka9ogM9j+y0YojMQ9bMUprAq2Q3vHqsfyNZIxtsDLY=;
 b=WWBfDbTEnkHhJRjlV3VGjCRxn9Gp8ygesNdB7uN6XiByDu4bSztsrA192XdIhmSt8Mx3kQ
 RijPjQW+4GJBsZNqFw89ea7EE0nmBgWO6HM67Amacia8dn4YfWgJt7LItxIA9wtkJP0n5P
 fJ0cQ1n93gKnzFWhE/HgQDjrcwbIJoo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-FqxqMwIIPRiseTPxiU4JYQ-1; Thu, 09 Mar 2023 15:23:56 -0500
X-MC-Unique: FqxqMwIIPRiseTPxiU4JYQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 y8-20020a2e3208000000b002934f71de00so973842ljy.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 12:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678393435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yka9ogM9j+y0YojMQ9bMUprAq2Q3vHqsfyNZIxtsDLY=;
 b=0HGlkODBnUDnq/e1j7jPgVuSDE9jqPgWfXlWoP5Y37GzUafHgK5AU6+JunclOpyPJq
 oxkGrDllbWaYO59ZDu0koqkB6FXxqI8mFa8l9psC55t0bX25Pg5SaFAUSYeKzaCsQSW9
 ytuY27yNXm8R+7uTocyJEskHVxWsdgY+HqRfjxLUCcoGknhZKuCai7ewqakodiGCfcv5
 siynoSI7RP2VLh1gr7CUlIv5mksTa0i6wTn9Jeyf9x52HynmOfiJIjujYyiLOfUEqojZ
 rPpDRHMJG+Y9VDe2K5wzonp7QiBLWB3g6er/5g6kKYpsebgeagUT4Oz4gEJKZ1mQqGNd
 Pq1w==
X-Gm-Message-State: AO0yUKUV5A1purxJNDHJCE7ER1Iu7ocJU90ZVnbUF8PhUbHt6dCDjYfW
 gY2AKwRop+t7rvEpGC6kS5kufKu4/NLDelcfNiiuXnKXCalrRsNG2HSDrJaQtnnDmRl2Li0hrJ1
 c4x/HLmpQpeADeNyGBC+SiIJLvrG4hlf6MZ/HoGxDzg==
X-Received: by 2002:a2e:b988:0:b0:295:a699:8cef with SMTP id
 p8-20020a2eb988000000b00295a6998cefmr7097356ljp.1.1678393435358; 
 Thu, 09 Mar 2023 12:23:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8weloI7aqyecmRQvtH4MtYMUWjylrGrxAFXgaTvGQmfF3OtgrdYrPNX6jAmG20we/nB8ZdplCyCbKx/y6ybKo=
X-Received: by 2002:a2e:b988:0:b0:295:a699:8cef with SMTP id
 p8-20020a2eb988000000b00295a6998cefmr7097345ljp.1.1678393435043; Thu, 09 Mar
 2023 12:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20230307151107.49649-1-harry.wentland@amd.com>
 <20230307151107.49649-3-harry.wentland@amd.com>
 <20230308105944.05fb9377@eldfell>
 <CA+hFU4zt4ykkHpB2NyY7Eu2SnMKnMB_b+sUh7NfTTzNyZ3A4mQ@mail.gmail.com>
 <20230309120342.6260cf94@eldfell>
In-Reply-To: <20230309120342.6260cf94@eldfell>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 9 Mar 2023 21:23:43 +0100
Message-ID: <CA+hFU4wT75Lcyi6ZAaU1AeZBmFPD+8Yu86cZ0n2HSPbLxV7Gwg@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] drm/connector: Add enum documentation to
 drm_colorspace
To: Pekka Paalanen <ppaalanen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Uma Shankar <uma.shankar@intel.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Joshua Ashton <joshua@froggi.es>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 9, 2023 at 11:03=E2=80=AFAM Pekka Paalanen <ppaalanen@gmail.com=
> wrote:
>
> On Thu, 9 Mar 2023 01:56:11 +0100
> Sebastian Wick <sebastian.wick@redhat.com> wrote:
>
> > On Wed, Mar 8, 2023 at 9:59=E2=80=AFAM Pekka Paalanen <ppaalanen@gmail.=
com> wrote:
> > >
> > > On Tue, 7 Mar 2023 10:10:52 -0500
> > > Harry Wentland <harry.wentland@amd.com> wrote:
> > >
> > > > From: Joshua Ashton <joshua@froggi.es>
> > > >
> > > > To match the other enums, and add more information about these valu=
es.
> > > >
> > > > v2:
> > > >  - Specify where an enum entry comes from
> > > >  - Clarify DEFAULT and NO_DATA behavior
> > > >  - BT.2020 CYCC is "constant luminance"
> > > >  - correct type for BT.601
> > > >
> > > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > >
> > > Hi,
> > >
> > > this effort is really good, but of course I still find things to
> > > nitpick about. If there is no answer to my questions, then I would
> > > prefer the documentation to spell out the unknowns and ambiguities.
> > >
> > > > Cc: Pekka Paalanen <ppaalanen@gmail.com>
> > > > Cc: Sebastian Wick <sebastian.wick@redhat.com>
> > > > Cc: Vitaly.Prosyak@amd.com
> > > > Cc: Uma Shankar <uma.shankar@intel.com>
> > > > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > > Cc: Joshua Ashton <joshua@froggi.es>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: amd-gfx@lists.freedesktop.org
> > > > ---
> > > >  include/drm/drm_connector.h | 67 +++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 65 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connecto=
r.h
> > > > index 6d6a53a6b010..bb078666dc34 100644
> > > > --- a/include/drm/drm_connector.h
> > > > +++ b/include/drm/drm_connector.h
> > > > @@ -363,13 +363,76 @@ enum drm_privacy_screen_status {
> > > >       PRIVACY_SCREEN_ENABLED_LOCKED,
> > > >  };
> > > >
> > > > -/*
> > > > - * This is a consolidated colorimetry list supported by HDMI and
> > > > +/**
> > > > + * enum drm_colorspace - color space
> > > > + *
> > > > + * This enum is a consolidated colorimetry list supported by HDMI =
and
> > > >   * DP protocol standard. The respective connectors will register
> > > >   * a property with the subset of this list (supported by that
> > > >   * respective protocol). Userspace will set the colorspace through
> > > >   * a colorspace property which will be created and exposed to
> > > >   * userspace.
> > > > + *
> > > > + * DP definitions come from the DP v2.0 spec
> > > > + * HDMI definitions come from the CTA-861-H spec
> > > > + *
> > > > + * @DRM_MODE_COLORIMETRY_DEFAULT:
> > > > + *   Driver specific behavior.
> > > > + *   For DP:
> > > > + *           RGB encoded: sRGB (IEC 61966-2-1)
> > > > + *           YCbCr encoded: ITU-R BT.601 colorimetry format
> > >
> > > Does this mean that HDMI behavior is driver-specific while DP behavio=
r
> > > is as defined?
> > >
> > > Is it intentional that YCbCr encoding also uses different RGB-primari=
es
> > > than RGB-encoded signal? (BT.601 vs. BT.709/sRGB)
> > >
> > > Or do you need to be more explicit on which parts of each spec apply
> > > (ColourPrimaries vs. TransferCharacteristics vs. MatrixCoefficients i=
n
> > > CICP parlance)?
> > >
> > > E.g. BT.709/sRGB ColourPrimaries with BT.601 MatrixCoefficients.
> >
> > Yeah, just adding to this: The Default Colorspace is something well
> > defined. CTA-861 says:
> >
> > "If bits C0 and C1 are zero, the colorimetry shall correspond to the
> > default colorimetry defined in Section 5.1"
> >
> > and in Section 5.1
> >
> > "In all cases described above, the RGB color space used should be the
> > RGB color space the Sink declares in the Basic Display Parameters and
> > Feature Block of its EDID."
> >
> > If I set DRM_MODE_COLORIMETRY_DEFAULT, I expect the Colorimetry the
> > EDID reports to be in effect and not some driver specific nonsense.
>
> Does that also define the MatrixCoefficients for YCbCr signal with
> DRM_MODE_COLORIMETRY_DEFAULT?

Good question. It doesn't seem like it does, which would make
supporting YCC with the default color space impossible.

> Not that userspace would even care, since RGB-to-YCbCr is all
> driver-internal.
>
> It is interesting you point that out. I guess it means that the basic
> colorimetry from EDID is supposed to be really only the default
> colorimetry and might not have anything to do with the actual panel
> primaries.
>
>
> Thanks,
> pq

