Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7FAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 16:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45BF10E4F0;
	Tue, 15 Feb 2022 16:46:56 +0000 (UTC)
X-Greylist: delayed 567 seconds by postgrey-1.36 at gabe;
 Tue, 15 Feb 2022 16:46:55 UTC
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3296A10E513
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 16:46:55 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com
 [188.165.51.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4Jymw60x08z4x6KX
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 16:37:26 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="E9V91jN8"
Date: Tue, 15 Feb 2022 16:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1644943039;
 bh=f1kG4y1Pad9UaeKLlKedqj/sm+OCsoIlrgJXYL6aSeI=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID;
 b=E9V91jN86xK6pzcMltPM69/bOQFFQNJV14lQwmcL2FYT3foga5gLBN44BK4oxAPri
 Vd8zuw1PuCIPGRg2//vtiVX9F2F6j/JTJL3odWwNmjV4QndYJ/cNzlL994kRk5oss4
 t+oB5svlaOh0xBX9GF7yyVj1AjeFwDYEvnfX4LlK0wXUUANzluIiX7MMssmf+EtKXg
 j3TEQWNZHHEFFnC96soVMV8mnPbtAkLt2VhY0qKE/ctXlMHsckdPLAA5vi0D16WsVW
 ELSgf6c8NzeavnNPc22BI1Gvf+qHdGR5FmKWYe1aX8Wak2lhTUG3wpbv4id1Yx/OtQ
 5XOlTjjx0fyLA==
To: Emil Velikov <emil.l.velikov@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation
 property creating and value setting
Message-ID: <GYG6EVT1MqtmfKiPpMhDG9mpuATnmwVDq2PuE_dpDat5oQW_t1tUfm39lSWHj32D5r7mrog27sL4dkgdMYQ5BN830TfVOrgQ4Ts8LcO8Hcs=@emersion.fr>
In-Reply-To: <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com>
References: <20220208084234.1684930-1-hsinyi@chromium.org>
 <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com>
 <KW6DNh6IRRgVJx9DfOFBnEqc4a0x-AnDXEbMxwpfEbk8dOn_KGVzAfo-slJWq-4nWW728Uc-OVpFh2w4fDE4-bxfkDuz1hFILRVvbcuXqaw=@emersion.fr>
 <CACvgo532-pC+7DLFCo=DWTX-OnJEJvSoTmQnt3_qLhiT4cqEMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Maxime Ripard <mripard@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 LAKML <linux-arm-kernel@lists.infradead.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, February 15th, 2022 at 15:38, Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:

> On Tue, 15 Feb 2022 at 13:55, Simon Ser <contact@emersion.fr> wrote:
> >
> > On Tuesday, February 15th, 2022 at 13:04, Emil Velikov <emil.l.velikov@=
gmail.com> wrote:
> >
> > > Greetings everyone,
> > >
> > > Padron for joining in so late o/
> > >
> > > On Tue, 8 Feb 2022 at 08:42, Hsin-Yi Wang <hsinyi@chromium.org> wrote=
:
> > > >
> > > > drm_dev_register() sets connector->registration_state to
> > > > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > > > drm_connector_set_panel_orientation() is first called after
> > > > drm_dev_register(), it will fail several checks and results in foll=
owing
> > > > warning.
> > > >
> > > > Add a function to create panel orientation property and set default=
 value
> > > > to UNKNOWN, so drivers can call this function to init the property =
earlier
> > > > , and let the panel set the real value later.
> > > >
> > >
> > > The warning illustrates a genuine race condition, where userspace wil=
l
> > > read the old/invalid property value/state. So this patch masks away
> > > the WARNING without addressing the actual issue.
> > > Instead can we fix the respective drivers, so that no properties are
> > > created after drm_dev_register()?
> > >
> > > Longer version:
> > > As we look into drm_dev_register() it's in charge of creating the
> > > dev/sysfs nodes (et al). Note that connectors cannot disappear at
> > > runtime.
> > > For panel orientation, we are creating an immutable connector
> > > properly, meaning that as soon as drm_dev_register() is called we mus=
t
> > > ensure that the property is available (if applicable) and set to the
> > > correct value.
> >
> > Unfortunately we can't quite do this. To apply the panel orientation qu=
irks we
> > need to grab the EDID of the eDP connector, and this happened too late =
in my
> > testing.
> >
> > What we can do is create the prop early during module load, and update =
it when
> > we read the EDID (at the place where we create it right now). User-spac=
e will
> > receive a hotplug event after the EDID is read, so will be able to pick=
 up the
> > new value if any.
>
> Didn't quite get that, are you saying that a GETPROPERTY for the EDID,
> the ioctl blocks or that we get an empty EDID?

I'm not referring to GETPROPERTY, I'm referring to the driver getting the E=
DID
from the sink (here, the eDP panel). In my experimentations with amdgpu I
noticed that the driver module load finished before the EDID was available =
to
the driver. Maybe other drivers behave differently and probe connectors whe=
n
loaded, not sure.

> The EDID hotplug even thing is neat - sounds like it also signals on
> panel orientation, correct?
> On such an event, which properties userspace should be re-fetching -
> everything or guess randomly?
>
> Looking through the documentation, I cannot see a clear answer :-\

User-space should re-fetch *all* properties. In practice some user-space ma=
y
only be fetching some properties, but that should get fixed in user-space.

Also the kernel can indicate that only a single connector changed via the
"CONNECTOR" uevent prop, or even a single connector property via "PROPERTY"=
.
See [1] for a user-space implementation. But all of this is purely an optio=
nal
optimization. Re-fetching all properties is a bit slower (especially if som=
e
drmModeGetConnector calls force-probe connectors) but works perfectly fine.

It would be nice to document, if you have the time feel free to send a patc=
h
and CC danvet, pq and me.

[1]: https://gitlab.freedesktop.org/wlroots/wlroots/-/blob/252b2348bd62170d=
97c4e81fb2050f757b56d67e/backend/session/session.c#L144
