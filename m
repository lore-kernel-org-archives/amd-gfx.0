Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B79C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 00:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB5710E165;
	Thu,  9 Mar 2023 00:56:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B8A10E165
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678323387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HSIZf0rL2FrIp71hrGXHS2YYOx5CMkrhQZJjncHWNY=;
 b=CyFhyhnei6bKTjscEbJqYpKgyO3sT9UFq4B1RSGspHfSQFyMGu3OJNxsQNi2GlqcY3PDqw
 IMwzdUPXdC3HG7UDUb3A78/7SSncM7UTFBopOCmltHJrg0KItMGSFp+rfpbhGBWFRjNinc
 NW3IbHcpwb2CLBRCgZ7SAjk8AjCEZ14=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-kuE4WjHUOjmXjoV7JQGYfA-1; Wed, 08 Mar 2023 19:56:24 -0500
X-MC-Unique: kuE4WjHUOjmXjoV7JQGYfA-1
Received: by mail-lf1-f71.google.com with SMTP id
 a11-20020a195f4b000000b004b53d7241f6so69997lfj.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 16:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678323382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HSIZf0rL2FrIp71hrGXHS2YYOx5CMkrhQZJjncHWNY=;
 b=ERkoCvCtYkubaQq7TRfumTkbEHdDJrGUSIA9AAbszey4sWEM3f3y64bKH45/JJ3Ym4
 lKnBGRlHrGIklc8vLvlva38s/q4XO+RigY44Rkd4RGikBdWpU7tWuI8utk/17slVQImP
 IvnrBl8/5RHmr10mBOECPxE9yQNbzgjJJqvYfbO16GbcEz712y533mJlYOUuihkmdQNj
 RE5v1wX1SsC/q406aYi0pP/BYexETSwViyEJZvvFQX5YEq10RKyvTnZ9I3jpAG76OkhF
 yv/ZA5jSt9j3YOws3c71NORVlcA20i40Fv+k39IN14TjVxYAYgJAkBA6KqyRKEnxNPR/
 r0ug==
X-Gm-Message-State: AO0yUKX2Fvj0yxA1rZZbJtG1n3HYBqOfgR9qEL1+2CWKxvijL/iZDUda
 Zngr/a8iU+SG7RbFuzPjTUXRD4dGvyoN2LZvZDZMDYq1tb6G9wdfJ5qyucDhsxawbGry9QfQJqq
 BB37nh1IRqfRMsr9bpTAbf19ivodN8BKS0mGp2WsbxQ==
X-Received: by 2002:ac2:546c:0:b0:4d5:ca42:aee7 with SMTP id
 e12-20020ac2546c000000b004d5ca42aee7mr6202846lfn.7.1678323382720; 
 Wed, 08 Mar 2023 16:56:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/eYh4mgBl+FbkUzVKxOv/XTs9Qe8FSrB8sTOuRLzObZ8rlabp/cKRFIq0xJaq/JEpA1yN+k0v/9x5qbf0K40Y=
X-Received: by 2002:ac2:546c:0:b0:4d5:ca42:aee7 with SMTP id
 e12-20020ac2546c000000b004d5ca42aee7mr6202840lfn.7.1678323382400; Wed, 08 Mar
 2023 16:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20230307151107.49649-1-harry.wentland@amd.com>
 <20230307151107.49649-3-harry.wentland@amd.com>
 <20230308105944.05fb9377@eldfell>
In-Reply-To: <20230308105944.05fb9377@eldfell>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Thu, 9 Mar 2023 01:56:11 +0100
Message-ID: <CA+hFU4zt4ykkHpB2NyY7Eu2SnMKnMB_b+sUh7NfTTzNyZ3A4mQ@mail.gmail.com>
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

On Wed, Mar 8, 2023 at 9:59=E2=80=AFAM Pekka Paalanen <ppaalanen@gmail.com>=
 wrote:
>
> On Tue, 7 Mar 2023 10:10:52 -0500
> Harry Wentland <harry.wentland@amd.com> wrote:
>
> > From: Joshua Ashton <joshua@froggi.es>
> >
> > To match the other enums, and add more information about these values.
> >
> > v2:
> >  - Specify where an enum entry comes from
> >  - Clarify DEFAULT and NO_DATA behavior
> >  - BT.2020 CYCC is "constant luminance"
> >  - correct type for BT.601
> >
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Hi,
>
> this effort is really good, but of course I still find things to
> nitpick about. If there is no answer to my questions, then I would
> prefer the documentation to spell out the unknowns and ambiguities.
>
> > Cc: Pekka Paalanen <ppaalanen@gmail.com>
> > Cc: Sebastian Wick <sebastian.wick@redhat.com>
> > Cc: Vitaly.Prosyak@amd.com
> > Cc: Uma Shankar <uma.shankar@intel.com>
> > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Cc: Joshua Ashton <joshua@froggi.es>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: amd-gfx@lists.freedesktop.org
> > ---
> >  include/drm/drm_connector.h | 67 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 6d6a53a6b010..bb078666dc34 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -363,13 +363,76 @@ enum drm_privacy_screen_status {
> >       PRIVACY_SCREEN_ENABLED_LOCKED,
> >  };
> >
> > -/*
> > - * This is a consolidated colorimetry list supported by HDMI and
> > +/**
> > + * enum drm_colorspace - color space
> > + *
> > + * This enum is a consolidated colorimetry list supported by HDMI and
> >   * DP protocol standard. The respective connectors will register
> >   * a property with the subset of this list (supported by that
> >   * respective protocol). Userspace will set the colorspace through
> >   * a colorspace property which will be created and exposed to
> >   * userspace.
> > + *
> > + * DP definitions come from the DP v2.0 spec
> > + * HDMI definitions come from the CTA-861-H spec
> > + *
> > + * @DRM_MODE_COLORIMETRY_DEFAULT:
> > + *   Driver specific behavior.
> > + *   For DP:
> > + *           RGB encoded: sRGB (IEC 61966-2-1)
> > + *           YCbCr encoded: ITU-R BT.601 colorimetry format
>
> Does this mean that HDMI behavior is driver-specific while DP behavior
> is as defined?
>
> Is it intentional that YCbCr encoding also uses different RGB-primaries
> than RGB-encoded signal? (BT.601 vs. BT.709/sRGB)
>
> Or do you need to be more explicit on which parts of each spec apply
> (ColourPrimaries vs. TransferCharacteristics vs. MatrixCoefficients in
> CICP parlance)?
>
> E.g. BT.709/sRGB ColourPrimaries with BT.601 MatrixCoefficients.

Yeah, just adding to this: The Default Colorspace is something well
defined. CTA-861 says:

"If bits C0 and C1 are zero, the colorimetry shall correspond to the
default colorimetry defined in Section 5.1"

and in Section 5.1

"In all cases described above, the RGB color space used should be the
RGB color space the Sink declares in the Basic Display Parameters and
Feature Block of its EDID."

If I set DRM_MODE_COLORIMETRY_DEFAULT, I expect the Colorimetry the
EDID reports to be in effect and not some driver specific nonsense.

> > + * @DRM_MODE_COLORIMETRY_NO_DATA:
> > + *   Driver specific behavior.
> > + *   For HDMI:
> > + *   Sets "No Data" in infoframe
>
> Does DEFAULT mean that something else than "No Data" may be set in the
> HDMI infoframe?
>
> If so, since these two have the same value, where is the difference? Is
> DEFAULT purely an UAPI token, and NO_DATA used internally? Or NO_DATA
> used only when crafting actual infoframe packets?
>
> Should NO_DATA be documented to be a strictly driver-internal value,
> and not documented with UAPI?
>
> I am unclear if userspace is using these enum values directly, or do
> they use the string names only.
>
> > + * @DRM_MODE_COLORIMETRY_SMPTE_170M_YCC:
> > + *   (HDMI)
> > + *   SMPTE ST 170M colorimetry format
>
> Does "colorimetry format" mean that the spec is used in full, for all
> of ColourPrimaries, TransferCharacteristics and MatrixCoefficients?
>
> If yes, good. If not, the wording misleads me.
>
> > + * @DRM_MODE_COLORIMETRY_BT709_YCC:
> > + *   (HDMI, DP)
> > + *   ITU-R BT.709 colorimetry format
> > + * @DRM_MODE_COLORIMETRY_XVYCC_601:
> > + *   (HDMI, DP)
> > + *   xvYCC601 colorimetry format
> > + * @DRM_MODE_COLORIMETRY_XVYCC_709:
> > + *   (HDMI, DP)
> > + *   xvYCC709 colorimetry format
>
> Btw. xvYCC are funny because they require limited quantization range
> encoding, but use the foot- and headroom to encode out-of-nominal-range
> values in order to expand the color gamut with negative and greater
> than unity values.
>
> Just for curiosity, is it in any way possible today to make use of that
> extended color gamut through KMS? Has it ever been possible?
>
> I mean, the KMS color pipeline assumes full-range RGB, so I don't see
> any way to make use of xvYCC.
>
> > + * @DRM_MODE_COLORIMETRY_SYCC_601:
> > + *   (HDMI, DP)
> > + *   sYCC601 colorimetry format
> > + * @DRM_MODE_COLORIMETRY_OPYCC_601:
> > + *   (HDMI, DP)
> > + *   opYCC601 colorimetry format
> > + * @DRM_MODE_COLORIMETRY_OPRGB:
> > + *   (HDMI, DP)
> > + *   opRGB colorimetry format
> > + * @DRM_MODE_COLORIMETRY_BT2020_CYCC:
> > + *   (HDMI, DP)
> > + *   ITU-R BT.2020 Y'c C'bc C'rc (constant luminance) colorimetry form=
at
> > + * @DRM_MODE_COLORIMETRY_BT2020_RGB:
> > + *   (HDMI, DP)
> > + *   ITU-R BT.2020 R' G' B' colorimetry format
> > + * @DRM_MODE_COLORIMETRY_BT2020_YCC:
> > + *   (HDMI, DP)
> > + *   ITU-R BT.2020 Y' C'b C'r colorimetry format
> > + * @DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
> > + *   (HDMI)
> > + *   SMPTE ST 2113 P3D65 colorimetry format
> > + * @DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
> > + *   (HDMI)
> > + *   SMPTE ST 2113 P3DCI colorimetry format
> > + * @DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
> > + *   (DP)
> > + *   RGB wide gamut fixed point colorimetry format
> > + * @DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
> > + *   (DP)
> > + *   RGB wide gamut floating point
> > + *   (scRGB (IEC 61966-2-2)) colorimetry format
>
> Again, there is no way to actually make use of WIDE since the KMS color
> pipeline is limited to the unit range color values, right? Or is it
> possible by setting all color pipeline KMS properties to pass-through
> and using a floating-point FB?
>
> I suppose the FIXED vs. FLOAT has the exact same problems as BT2020_YCC
> vs. BT2020_RGB, but I would be surprised if anyone cared.
>
> > + * @DRM_MODE_COLORIMETRY_BT601_YCC:
> > + *   (DP)
> > + *   ITU-R BT.601 colorimetry format
> > + *   The DP spec does not say whether this is the 525 or the 625
> > + *   line version.
>
> Good to note that ambiguity here. :-)
>
> Or maybe the DP spec writer was thinking about BT.709 ColourPrimaries
> and BT.601 MatrixCoefficients...
>
> >   */
> >  enum drm_colorspace {
> >       /* For Default case, driver will set the colorspace */
>
>
> Thanks,
> pq

