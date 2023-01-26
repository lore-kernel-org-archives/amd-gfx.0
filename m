Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B43C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 01:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F1C10E8D0;
	Thu, 26 Jan 2023 01:38:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C075010E8CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674697105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FktJRh3Oo4iQu4tIjorwONtAD8Srts+yZHN78lIIaLI=;
 b=Yc6hVzW9Ve5IYQO1z9GwEtwLlejr+OOmQYABwFVRhKDOh40T2Z1YcO7jTKByUF7Oxi9GxY
 HEyCB9olL/+pR06cyqTHo+CcbMkrsbgCRUTchHhWZfisYfkTtZlvI3m4mPbxkc3tuipfrx
 3QTPqEQxO+z40REfbixmq6ABF0E9PhI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-uMf1e68cPTOYiyEMmWSfAw-1; Wed, 25 Jan 2023 20:38:21 -0500
X-MC-Unique: uMf1e68cPTOYiyEMmWSfAw-1
Received: by mail-lf1-f72.google.com with SMTP id
 n6-20020a0565120ac600b004d5a68b0f94so270019lfu.14
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 17:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FktJRh3Oo4iQu4tIjorwONtAD8Srts+yZHN78lIIaLI=;
 b=M3Myr06jUdgJSC8AsAawZd3tbFSgZZNCT3gmS4PRAbCm8TEhPfoO8gY3CFyC/wGHIj
 E5AFCGR6Esg7GHTOfx9ePQZgdC+PGzKGttOohzsE2VBMotUEE7MBVwSn+dfcUZvJr9TA
 fmutkULjMZJB93NMdlSWMyC7ZN1qUHkXlzDM1wDGuvg8eql0ijp6FlFdNBIugFF3f5JY
 MlgdsYRwIV1OKNuWtbIxNy7ZGqJxOy0z4MkFffK86PXJvPqQE8/Tf/6kMY++lI1NOADP
 f+ons1R9OXB89/LcrjJG+qKBsQkhBMKaqJp/gbpYlvsxRnQ1BMnmYhjb7mcyK+faE2Ed
 dPhw==
X-Gm-Message-State: AO0yUKUaZf1hShfuY3GgZFU80j/tmY2Fp+RGNTN3I+WMSNG2xik0i/Nv
 Ejqm0GWUKdydgnG5BVH8xz/caV2OmusDWAslltxdFrlX2eyVgwnCR7V321H0ZC7PJ9eqn4O3zwy
 Qd6XPdgeh0kDkvk4LRAxwPSFx1rvrEU5V9W9LIKphdQ==
X-Received: by 2002:a2e:9ac8:0:b0:28e:6a36:f4d with SMTP id
 p8-20020a2e9ac8000000b0028e6a360f4dmr205714ljj.89.1674697099983; 
 Wed, 25 Jan 2023 17:38:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+5BBSf1aysYGjXk5XIIuX0zPNbT7fJinNeGOCOXcqQXwUpH4PtPekzrcKiTxj1aGl7G1ErIUXVbtjOzsUiraQ=
X-Received: by 2002:a2e:9ac8:0:b0:28e:6a36:f4d with SMTP id
 p8-20020a2e9ac8000000b0028e6a360f4dmr205708ljj.89.1674697099707; Wed, 25 Jan
 2023 17:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20230113162428.33874-1-harry.wentland@amd.com>
 <20230113162428.33874-19-harry.wentland@amd.com>
 <CA+hFU4xHKNSWO21Swq_b2VPPxtYGdeo4e3rPEVo44OPmB+opZw@mail.gmail.com>
 <79ca3c26-11e8-0dad-641d-af21ec557d07@froggi.es>
In-Reply-To: <79ca3c26-11e8-0dad-641d-af21ec557d07@froggi.es>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 26 Jan 2023 02:38:08 +0100
Message-ID: <CA+hFU4zNDMpz_khh9RndJbGjZXMwBpC7D0NOyds=8NZiCuGjYg@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] drm/amd/display: Fallback to 2020_YCBCR if the
 pixel encoding is not RGB
To: Joshua Ashton <joshua@froggi.es>
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
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 25, 2023 at 2:00 PM Joshua Ashton <joshua@froggi.es> wrote:
>
>
>
> On 1/23/23 20:30, Sebastian Wick wrote:
> > A new property to control YCC and subsampling would be the more
> > complete path here. If we actually want to fix this in the short-term
> > though, we should handle the YCC and RGB Colorspace values as
> > equivalent, everywhere. Technically we're breaking the user space API
> > here so it should be documented on the KMS property and other drivers
> > must be adjusted accordingly as well.
>
> I am happy with treating 2020_YCC and 2020_RGB as the same.
>
> I think having the YCC/RGB split here in Colorspace is a mistake.
> Pixel encoding should be completely separate from colorspace from a uAPI
> perspective when we want to expose that.
> It's just a design flaw from when it was added as it just mirrors the
> values in the colorimetry packets 1:1. I understand why this happened,
> and I don't think it's a big deal for us to correct ourselves now:
>
> I suggest we deprecate the _YCC variants, treat them the same as the RGB
> enum to avoid any potential uAPI breakage and key the split entirely off
> the pixel_encoding value.

Yeah, I agree. The kernel must know the wire encoding and can thus
always choose the correct variant. If anyone wants to provide a patch
I'll review it.

> That way when we do want to plumb more explicit pixel encoding down the
> line, userspace only has to manage one thing. There's no advantage for
> anything more here.
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> >
> > On Fri, Jan 13, 2023 at 5:26 PM Harry Wentland <harry.wentland@amd.com>=
 wrote:
> >>
> >> From: Joshua Ashton <joshua@froggi.es>
> >>
> >> Userspace might not aware whether we're sending RGB or YCbCr
> >> data to the display. If COLOR_SPACE_2020_RGB_FULLRANGE is
> >> requested but the output encoding is YCbCr we should
> >> send COLOR_SPACE_2020_YCBCR.
> >>
> >> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> >> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> >> Cc: Vitaly.Prosyak@amd.com
> >> Cc: Joshua Ashton <joshua@froggi.es>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: amd-gfx@lists.freedesktop.org
> >> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index f74b125af31f..16940ea61b59 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -5184,7 +5184,10 @@ get_output_color_space(const struct dc_crtc_tim=
ing *dc_crtc_timing,
> >>                  color_space =3D COLOR_SPACE_ADOBERGB;
> >>                  break;
> >>          case DRM_MODE_COLORIMETRY_BT2020_RGB:
> >> -               color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
> >> +               if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODI=
NG_RGB)
> >> +                       color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE=
;
> >> +               else
> >> +                       color_space =3D COLOR_SPACE_2020_YCBCR;
> >>                  break;
> >>          case DRM_MODE_COLORIMETRY_BT2020_YCC:
> >>                  color_space =3D COLOR_SPACE_2020_YCBCR;
> >> --
> >> 2.39.0
> >>
> >
>

