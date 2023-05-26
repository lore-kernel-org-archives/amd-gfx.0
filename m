Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1FC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 16:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE5710E821;
	Fri, 26 May 2023 16:25:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBC910E1D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685118298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BqWSicT0Iat4feyKZNUBhFtLfjsTE7YKO4vPRaAmQ8=;
 b=QzYKw4FNipSYvVSOpX1hL6V/kpox/dlQlLOpwugq0FuHP/ubzpOHBBrjANGfigtbsl4i7m
 Q/Bdqu2NeKyzVzQZVseDhbngZ/5AHomr3uLUdXZQCjaRtYu4O4TMj/FuYn2qoEHPM8556d
 BLbT0VekFsp0cf8YJRHQz1vuCfNLx6Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-amIjvduyMP-Qoob0qqGS_g-1; Fri, 26 May 2023 12:24:54 -0400
X-MC-Unique: amIjvduyMP-Qoob0qqGS_g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af222cc3a1so4578221fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 09:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685118293; x=1687710293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BqWSicT0Iat4feyKZNUBhFtLfjsTE7YKO4vPRaAmQ8=;
 b=P2ZGBnZ1VN8mClCEP7GhPsayxdq+N9inBRhh8g1bgmqpk+mxJj4TdCBc+Vbgyh4iy+
 whcHIm881neSQ7U87cz3rAgRfvtR7y5atSUBBjykQBeQJ3/kWcvypbHdPlHzuZ7ApLRk
 p5Mx0MeM0PsIk7Gj3haNeC/8ec6JZFIJcdj9AwhJXJWMynpFHUzVamrWLNCr5/oPhP64
 nt8mO7M5CNUAb7quBDnZ5sOl+g/MzNqT7QcgQkrGQITgFvqQcuMkOFriZo3jg9c0uA2J
 d8qLuXr0Ai+OE0kjrE2apfLsH4+3ygzhYVW3HPsbEbjPubULpWYWL+utcEWRWjDal9Hj
 tXbA==
X-Gm-Message-State: AC+VfDy5rWs67lmu/2dewzciZTPG5eDSCMFdV4MBowKEoycjwuXHa6/h
 f9ORGfm8OeNMWzZsg/HWUKjUaV8FvvGXIV0kLRJCIOTDpKtsNdK5lzpNIwri5piJaSfjIv+RpvR
 LvtQzHnjPTQ+s6HmHkezZCqLIRJHmLn3q+36ypHpP9g==
X-Received: by 2002:a2e:8959:0:b0:2ab:6e23:ef71 with SMTP id
 b25-20020a2e8959000000b002ab6e23ef71mr828118ljk.37.1685118293365; 
 Fri, 26 May 2023 09:24:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6j+rnFbtlIb1gdyHMEYio2NUJXLv4pKXLXlO3dfVrC9QdjbkT5dHXQbSEmJhOP1PcupukuE0A7ZFsi7zuwIdg=
X-Received: by 2002:a2e:8959:0:b0:2ab:6e23:ef71 with SMTP id
 b25-20020a2e8959000000b002ab6e23ef71mr828104ljk.37.1685118293028; Fri, 26 May
 2023 09:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525191809.3524-1-harry.wentland@amd.com>
 <20230526161648.5865ce1a@eldfell>
In-Reply-To: <20230526161648.5865ce1a@eldfell>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 26 May 2023 18:24:41 +0200
Message-ID: <CA+hFU4wv+4Qkyj-2ajv3o=2OX6N1+Pz=PVq0Z6YPnZaMJFPx7A@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Enable Colorspace connector property in amdgpu
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>, Uma Shankar <uma.shankar@intel.com>,
 dri-devel@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 26, 2023 at 3:16=E2=80=AFPM Pekka Paalanen <ppaalanen@gmail.com=
> wrote:
>
> On Thu, 25 May 2023 15:17:56 -0400
> Harry Wentland <harry.wentland@amd.com> wrote:
>
> > This patchset is based on Joshua's previous patchset [1], as well
> > as my previous patchset [2].
> >
> > It is
> > - enabling support for the colorspace property in amdgpu, as well as
> > - allowing drivers to specify the supported set of colorspaces, and
> >
> > Colorspace, Infoframes, and YCbCr matrix
> > ---------------------------------------
> >
> > Even though the initial intent of the colorspace property was to set th=
e
> > colorspace field in the respective HDMI AVI and DP SDP infoframes that
> > is not sufficient in all scenarios. For DP the colorspace information
> > also affects the MSA (main stream attribute) packet. For YUV output the
> > colorspace affects the RGB-to-YCbCr conversion matrix. The colorspace
> > field of the infopackets also depends on the encoding used, which is
> > something that is decided by the driver and not known to userspace.
>
> Hi Harry,
>
> the "deprecation" of BT2020 RGB vs. YCC is now dropped completely.
> Should there still be a patch that adds some UAPI documentation only,
> saying that drivers are free to swap e.g. between BT2020 RGB and YCC
> based which encoding they actually chose?

Yes please!

> Even if just BT2020 variant specifically.
>
> I have nothing against with this series now.
>
>
> Thanks,
> pq
>
> >
> > For these reasons a driver will need to be able to select the supported
> > colorspaces at property creation.
> >
> > Note: There seems to be an understanding that the colorspace property
> > should ONLY modify the infoframe. While this is current behavior and
> > sufficient in some cases it is nowhere specified that this should be th=
e
> > only use of this property. As outlined above this limitation is not
> > going to work in all cases.
> >
> > This patchset does not affect current behavior for the drivers that
> > implement this property: i915 and vc4.
> >
> > In the future we might want to give userspace control over the encoding
> > format on the wire, in particular to avoid use of YUV420 when image
> > fidelity is important. This work would likely go hand in hand with a
> > min_bpc property and wouldn't conflict with the work done in this
> > patchset. I would expect this future work to tag along with a drm_crtc
> > or drm_connector's Color Pipeline, similar to the one propsed for
> > drm_plane [3].
> >
> > Colorspace on crtc or connector?
> > --------------------------------
> >
> > There have been suggestions of programming 'colorspace' on the drm_crtc
> > but I don't think the crtc is the right place for this property. The
> > drm_plane and drm_crtc will be used to offload color processing that
> > would normally be done via the GFX or other pipelines. The drm_connecto=
r
> > controls the signalling with the display and ensures the wire format is
> > appropriate for the encoding by programming the RGB-to-YCbCr matrix.
> >
> > [1] https://patchwork.freedesktop.org/series/113632/
> > [2] https://patchwork.freedesktop.org/series/111865/
> > [3] https://lists.freedesktop.org/archives/dri-devel/2023-May/403173.ht=
ml

