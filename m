Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3448AC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7A310E0A2;
	Tue, 14 Feb 2023 19:45:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C2410E275
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676403916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sezo+rk7XdltEWsRunMgz/c6NhnfCSCilp6aU9kLSGw=;
 b=J5+IC7CM3WsiDTaLdEoqDB1rCIGFva3bJgJM3iiMLThxlo1cG9J5Fo0CDBEGYmnTlJWOtT
 0alByoOZBJ0tNeGaNK6MXeprDxzoK+8YanGsKN/o1CUZbbxacSFYWXdCV7u++VtaT2d2Q7
 8GxJvGWZxiqpbLKOBkTOXSsILtFNmR8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-9OiefiHUNJe1Hruvmh3ejw-1; Tue, 14 Feb 2023 14:45:14 -0500
X-MC-Unique: 9OiefiHUNJe1Hruvmh3ejw-1
Received: by mail-lj1-f198.google.com with SMTP id
 l1-20020a2e9081000000b0028b97d2c493so4191858ljg.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 11:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sezo+rk7XdltEWsRunMgz/c6NhnfCSCilp6aU9kLSGw=;
 b=WW3hArkuTQ/Jp9belNDNKeLNfHEfNPsp18l8i9ybCJBIRo6YENXUxcrNVIL9tdVTn6
 CV6Ump1JrN3davRmzZbIXcN51YZoylKYqbUBC/w3aOpbqGXXXic3FfsoxoT3yaMqdg3+
 x5zYTtWrVlufvU6IC4sWh1/VCsyj8w+ZjbMuHa/e3e2nMhJwWPcTYQJFYEWz3uRPqOGb
 HrRGVUYkwLqtR9Xe8EM2G4eHM13Oq/tNEAnUgpjlHYXvRd5hu7PUDHErhwjyiETfdFDk
 T1Y8iZbuCQxz4wQZWIHNQgzKu/fcR530/IbSwO24OM+j/CMXwUYQZrS6wK/7waBW66b2
 xt+A==
X-Gm-Message-State: AO0yUKWl1OzCGv1nrA6/FUm0ivzveEh3OiIKwZczrv2lQ4W8/SsWtI4k
 VKlUygAu47Ugj78CvOjqQZhJGGyPfU90wfTQK7gW3QQj+/ScoczBXYEVr1i42Ztts1Yps9IqHw1
 DKO+LGxmYfiCBZJYwHTvBpBsWh+HgjfXuBpVfMOfv7Q==
X-Received: by 2002:a2e:82c7:0:b0:293:34f2:1e47 with SMTP id
 n7-20020a2e82c7000000b0029334f21e47mr551400ljh.1.1676403913238; 
 Tue, 14 Feb 2023 11:45:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8oyCEmZGta3yRuNAf/hmdf/iOjkxmwzucFy1Z1H4cf11WNby761dWM5A1pjKlWDEd7Kd/d+TbDuH0rrmXU+qY=
X-Received: by 2002:a2e:82c7:0:b0:293:34f2:1e47 with SMTP id
 n7-20020a2e82c7000000b0029334f21e47mr551389ljh.1.1676403912794; Tue, 14 Feb
 2023 11:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20230203020744.30745-1-joshua@froggi.es>
 <20230203020744.30745-3-joshua@froggi.es>
 <Y9zkef5FjtZ7guVS@intel.com>
 <CA+hFU4ymiOg06MQeKLcn5MSrR=BZnOLODdZCFvGUdWqt_ha61A@mail.gmail.com>
 <0fc18aec-0703-55f4-f635-d09d345e8dc0@amd.com> <Y90l+DY0rSaMvN1U@intel.com>
 <758e5cf6-53e0-567c-c760-5b773bc7a11c@amd.com> <Y90vrEa3/1RbaGOV@intel.com>
 <CA+hFU4wuM_xHniFyRT+jouQ3k_S3UJsRpAtd1Lgx9UVLtrqZrQ@mail.gmail.com>
 <98d1d22a-1c29-5271-1eaf-89c962eb9678@amd.com>
In-Reply-To: <98d1d22a-1c29-5271-1eaf-89c962eb9678@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Tue, 14 Feb 2023 20:45:00 +0100
Message-ID: <CA+hFU4y=N3bR-vXXeLP0xTe0-HJPgF_GTbKrb3A9St-z2LignQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/connector: Deprecate split for BT.2020 in
 drm_colorspace enum
To: Harry Wentland <harry.wentland@amd.com>
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
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 amd-gfx@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 14, 2023 at 5:57 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
>
>
> On 2/14/23 10:49, Sebastian Wick wrote:
> > On Fri, Feb 3, 2023 at 5:00 PM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> >>
> >> On Fri, Feb 03, 2023 at 10:24:52AM -0500, Harry Wentland wrote:
> >>>
> >>>
> >>> On 2/3/23 10:19, Ville Syrj=C3=A4l=C3=A4 wrote:
> >>>> On Fri, Feb 03, 2023 at 09:39:42AM -0500, Harry Wentland wrote:
> >>>>>
> >>>>>
> >>>>> On 2/3/23 07:59, Sebastian Wick wrote:
> >>>>>> On Fri, Feb 3, 2023 at 11:40 AM Ville Syrj=C3=A4l=C3=A4
> >>>>>> <ville.syrjala@linux.intel.com> wrote:
> >>>>>>>
> >>>>>>> On Fri, Feb 03, 2023 at 02:07:44AM +0000, Joshua Ashton wrote:
> >>>>>>>> Userspace has no way of controlling or knowing the pixel encodin=
g
> >>>>>>>> currently, so there is no way for it to ever get the right value=
s here.
> >>>>>>>
> >>>>>>> That applies to a lot of the other values as well (they are
> >>>>>>> explicitly RGB or YCC). The idea was that this property sets the
> >>>>>>> infoframe/MSA/SDP value exactly, and other properties should be
> >>>>>>> added to for use userspace to control the pixel encoding/colorspa=
ce
> >>>>>>> conversion(if desired, or userspace just makes sure to
> >>>>>>> directly feed in correct kind of data).
> >>>>>>
> >>>>>> I'm all for getting userspace control over pixel encoding but even
> >>>>>> then the kernel always knows which pixel encoding is selected and
> >>>>>> which InfoFrame has to be sent. Is there a reason why userspace wo=
uld
> >>>>>> want to control the variant explicitly to the wrong value?
> >>>>>>
> >>>>>
> >>>>> I've asked this before but haven't seen an answer: Is there an exis=
ting
> >>>>> upstream userspace project that makes use of this property (other t=
han
> >>>>> what Joshua is working on in gamescope right now)? That would help =
us
> >>>>> understand the intent better.
> >>>>
> >>>> The intent was to control the infoframe colorimetry bits,
> >>>> nothing more. No idea what real userspace there was, if any.
> >>>>
> >>>>>
> >>>>> I don't think giving userspace explicit control over the exact info=
frame
> >>>>> values is the right thing to do.
> >>>>
> >>>> Only userspace knows what kind of data it's stuffing into
> >>>> the pixels (and/or how it configures the csc units/etc.) to
> >>>> generate them.
> >>>>
> >>>
> >>> Yes, but userspace doesn't control or know whether we drive
> >>> RGB or YCbCr on the wire. In fact, in some cases our driver
> >>> needs to fallback to YCbCr420 for bandwidth reasons. There
> >>> is currently no way for userspace to know that and I don't
> >>> think it makes sense.
> >>
> >> People want that control as well for whatever reason. We've
> >> been asked to allow YCbCr 4:4:4 output many times.
> >
> > I don't really think it's a question of if we want it but rather how
> > we get there. Harry is completely right that if we would make the
> > subsampling controllable by user space instead of the kernel handling
> > it magically, user space which does not adapt to the new control won't
> > be able to light up some modes which worked before.
> >
>
> Thanks for continuing this discussion and touching on the model of how
> we get to where we want to go.
>
> > This is obviously a problem and not one we can easily fix. We would
> > need a new cap for user space to signal "I know that I can control
> > bpc, subsampling and compression to lower the bandwidth and light up
> > modes which otherwise fail". That cap would also remove all the
> > properties which require kernel magic to work (that's also what I
> > proposed for my KMS color pipeline API).
> >
> > We all want to expose more of the scanout capability and give user
> > space more control but I don't think an incremental approach works
> > here and we would all do better if we accept that the current API
> > requires kernel magic to work and has a few implicit assumptions baked
> > in.
> >
> > With all that being said, I think the right decision here is to
> >
> > 1. Ignore subsampling for now
> > 2. Let the kernel select YCC or RGB on the cable
> > 3. Let the kernel figure out the conversion between RGB and YCC based
> > on the color space selected
> > 4. Let the kernel send the correct infoframe based on the selected
> > color space and cable encoding
> > 5. Only expose color spaces for which the kernel can do the conversion
> > and send the infoframe
>
> I agree. We don't want to break or change existing behavior (that is
> used by userspace) and this will get us far without breaking things.
>
> > 6. Work on the new API which is hidden behind a cap
> >
>
> I assume you mean something like
> https://gitlab.freedesktop.org/pq/color-and-hdr/-/issues/11

Something like that, yes. The main point being a cap which removes a
lot of properties and sets new expectations between user space and
kernel. The actual API is not that important.

> Above you say that you don't think an incremental approach works
> here. Can you elaborate?

Backwards compatibility is really hard. If we add another property to
control e.g. the color range infoframe which doesn't magically convert
colors, we now have to define how it interacts with the existing
property. We also have to figure out how a user space which doesn't
know about the new property behaves when another client has set that
property. If any property which currently might change the pixel
values is used, we can't expose the entire color pipeline because the
kernel might have to use some element in it to achieve its magic
conversion. So essentially you already have this hard device between
"old" and "new" and you can't use the new stuff incrementally.

> From what I've seen recently I am inclined to favor an incremental
> approach more. The reason is that any API, or portion thereof, is
> useless unless it's enabled full stack. When it isn't it becomes
> dead code quickly, or never really works because we overlooked
> one thing. The colorspace debacle shows how even something as
> simple as extra enum values in KMS APIs shouldn't be added unless
> someone in a canonical upstream project actually uses them. I
> would argue that such a canonical upstream project actually has
> to be a production environment and not something like Weston.

I agree that it's very easy to design something that doesn't work in
the real world but weston is a real production environment. Even a new
project can be a real production environment imo. The goals here are
not entirely undefined: we have color transformations and we want to
offload them.

> I could see us getting to a fully new color pipeline API but
> the only way to do that is with a development model that supports
> it. While upstream needs to be our ultimate goal, a good way
> to bring in new APIs and ensure a full-stack implementation is
> to develop them in a downstream production kernel, alongside
> userspace that makes use of it. Once the implementation is
> proven in the downstream repos it can then go upstream. This
> brings new challenges, though, as things don't get wide
> testing and get out of sync with upstream quickly. The
> alternative is the incremental approach.

I also agree pretty much with everything here. My current idea is that
we would add support for the new API in a downstream kernel for at
least VKMS (one real driver probably makes sense as well) while in
parallel developing a user space library for color conversions. That
library might be a rewrite of libplacebo, which in its current form
does all the color conversions we want to do but wasn't designed to
allow for offloading. One of the developers expressed interest in
rewriting the library in rust which would be a good opportunity to
also take offloading into account.

No doubt all of that will take a significant amount of effort and time
but we can still get HDR working in the old model without offloading
and just sRGB and PQ/Rec2020 code paths.

> We should look at this from a use-case angle, similar to what
> the gamescope guys are doing. Small steps, like:
> 1) Add HDR10 output (PQ, BT.2020) to the display
> 2) Add ability to do sRGB linear blending
> 3) Add ability to do sRGB and PQ linear blending
> 4) Post-blending 3D LUT
> 5) Pre-blending 3D LUT

Sure, having a target in sight is a good idea.

> At each stage the whole stack needs to work together in production.
>
> If we go to a new color pipeline programming model it might
> make sense to enable this as an "experimental" API that is
> under development. I don't know if we've ever done that in
> DRM/KMS. One way to do this might be with a new CONFIG option
> that only exposes the new color pipeline API when enabled and
> defaults to off, alongside a client cap for clients that
> are advertising a desire to use the (experimental) API.

Yeah, that's a bit tricky. I also don't know how upstream would like
this approach. Not even sure who to talk to.

> If we have that we could then look at porting all existing
> use-cases over and verifying them (including IGT tests) before
> moving on to HDR and wide-gamut use-cases. It's a large
> undertaking and while I'm not opposed to it I don't know
> if there are enough people willing to invest a large amount
> of effort to make this happen.
>
> Harry
>
> >> The automagic 4:2:0 fallback I think is rather fundementally
> >> incompatible with fancy color management. How would we even
> >> know whether to use eg. BT.2020 vs. BT.709 matrix? In i915
> >> that stuff is just always BT.709 limited range, no questions
> >> asked.
> >>
> >> So I think if userspace wants real color management it's
> >> going to have to set up the whole pipeline. And for that
> >> we need at least one new property to control the RGB->YCbCr
> >> conversion (or to explicitly avoid it).
> >>
> >> And given that the proposed patch just swept all the
> >> non-BT.2020 issues under the rug makes me think no
> >> one has actually come up with any kind of consistent
> >> plan for anything else really.
> >>
> >>>
> >>> Userspace needs full control of framebuffer pixel formats,
> >>> as well as control over DEGAMMA, GAMMA, CTM color operations.
> >>> It also needs to be able to select whether to drive the panel
> >>> as sRGB or BT.2020/PQ but it doesn't make sense for it to
> >>> control the pixel encoding on the wire (RGB vs YCbCr).
> >>>
> >>>> I really don't want a repeat of the disaster of the
> >>>> 'Broadcast RGB' which has coupled together the infoframe
> >>>> and automagic conversion stuff. And I think this one would
> >>>> be about 100x worse given this property has something
> >>>> to do with actual colorspaces as well.
> >>>>
> >>>
> >>> I'm unaware of this disaster. Could you elaborate?
> >>
> >> The property now controls both the infoframe stuff (and
> >> whatever super vague stuff DP has for it in MSA) and
> >> full->limited range compression in the display pipeline.
> >> And as a result  there is no way to eg. allow already
> >> limited range input, which is what some people wanted.
> >>
> >> And naturally it's all made a lot more terrible by all
> >> the displays that fail to implement the spec correctly,
> >> but that's another topic.
> >>
> >> --
> >> Ville Syrj=C3=A4l=C3=A4
> >> Intel
> >>
> >
>

