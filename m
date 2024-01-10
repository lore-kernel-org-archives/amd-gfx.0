Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC0C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 17:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54EA10E057;
	Wed, 10 Jan 2024 17:22:19 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D4D10E7A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 17:15:42 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5f15a1052b3so39909617b3.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 09:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1704906941; x=1705511741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soA68yzNvfZQWAZpekpt7a4WMrI7QKSPg81VAUrEcdk=;
 b=epcjSLNMygtydxsoYM5ygdz/D7auQ8DPstTgboU8hCUDIGUsp3QieXKCgzFz6uZ05+
 xdjilTi2jmXIEOz81asQ9k+oQXP4oXkWVP52Ci6StfRWJjpfDUcieEDGcTyFJkn6JER/
 XqvktYypLHfcZsWCBTC4SnW8N8AsPqUsd6Y+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704906941; x=1705511741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soA68yzNvfZQWAZpekpt7a4WMrI7QKSPg81VAUrEcdk=;
 b=BK6j7D0/vRyyUAKe82qeQbmBkQ73jdaDzJOZamw5Zp9eZJgJHGhFWq4lo4fJmGunly
 2UKbkss2MbxGMadO1jPs+jkBvEzY/WhUIve+IrmrZDdpLVHD1PJUxMcr0itjD34YByWU
 DkCzzvMAPzkfQ82+b27mR9D7EFB7HFl21E4oiunr5iFSYsLR5sUro/kqz2P9RdekqQaS
 0V/C79KjzodaBkRtjbSc6kO4JNGFEurwqW5ETZ/2iJbow8ZOGzapkPKu/ihTidHF45NR
 sAWQYObJSjJHDENy9OPSEc/2UPf7iHSlt4sPtnUTHMq06KAAcCw7vh5IQSJtbfUvRoLC
 IPig==
X-Gm-Message-State: AOJu0YwiCwzl/FOgt48jUluPEz3RDDiN8TjUpCtwluZU9+zxMuzIWE2v
 8yfBd9k0b7/C6L6WDna7nLzQ8nE+EEs8zh0+PRhtVQTnftfiIA==
X-Google-Smtp-Source: AGHT+IHiky3usvBUSr+P0G2IWOFzW7FhkFV4p161NhBmHRzD0jPC+3YufPeJf4yAtPY54W3fFgqqqnXHnsEneuJfO8U=
X-Received: by 2002:a0d:e28e:0:b0:5d7:1940:7d7a with SMTP id
 l136-20020a0de28e000000b005d719407d7amr1188461ywe.81.1704906941193; Wed, 10
 Jan 2024 09:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-4-andri@yngvason.is>
 <ZZ57Nl3CnRMPcfbj@phenom.ffwll.local>
 <CAFNQBQzo17cK4M-S=Mje8Lxub9Y74xFGj7iEq57vKJr47oiz5Q@mail.gmail.com>
 <CAKMK7uGhMCwbztGdEmG4gFgpyhw6j-JFow-AaprFxcX710=qXA@mail.gmail.com>
 <67808818-ee34-4d04-ad90-cd5c6eb9bb26@tuxedocomputers.com>
In-Reply-To: <67808818-ee34-4d04-ad90-cd5c6eb9bb26@tuxedocomputers.com>
From: Andri Yngvason <andri@yngvason.is>
Date: Wed, 10 Jan 2024 17:15:05 +0000
Message-ID: <CAFNQBQyg+yXSJRtZtyHXMfyBOYrQpU0R0XFUJLcof9rakrBYQA@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Add handling for new "active color
 format" property
To: Werner Sembach <wse@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 10 Jan 2024 17:22:18 +0000
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
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, intel-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Werner,

mi=C3=B0., 10. jan. 2024 kl. 13:14 skrifa=C3=B0i Werner Sembach <wse@tuxedo=
computers.com>:
>
> Hi,
>
> Am 10.01.24 um 14:09 schrieb Daniel Vetter:
> > On Wed, 10 Jan 2024 at 13:53, Andri Yngvason <andri@yngvason.is> wrote:
> >> mi=C3=B0., 10. jan. 2024 kl. 11:10 skrifa=C3=B0i Daniel Vetter <daniel=
@ffwll.ch>:
> >>> On Tue, Jan 09, 2024 at 06:11:00PM +0000, Andri Yngvason wrote:
> >>>> +     /* Extract information from crtc to communicate it to userspac=
e as connector properties */
> >>>> +     for_each_new_connector_in_state(state, connector, new_con_stat=
e, i) {
> >>>> +             struct drm_crtc *crtc =3D new_con_state->crtc;
> >>>> +             struct dc_stream_state *stream;
> >>>> +
> >>>> +             if (crtc) {
> >>>> +                     new_crtc_state =3D drm_atomic_get_new_crtc_sta=
te(state, crtc);
> >>>> +                     dm_new_crtc_state =3D to_dm_crtc_state(new_crt=
c_state);
> >>>> +                     stream =3D dm_new_crtc_state->stream;
> >>>> +
> >>>> +                     if (stream) {
> >>>> +                             drm_connector_set_active_color_format_=
property(connector,
> >>>> +                                     convert_dc_pixel_encoding_into=
_drm_color_format(
> >>>> +                                             dm_new_crtc_state->str=
eam->timing.pixel_encoding));
> >>>> +                     }
> >>>> +             } else {
> >>>> +                     drm_connector_set_active_color_format_property=
(connector, 0);
> >>> Just realized an even bigger reason why your current design doesn't w=
ork:
> >>> You don't have locking here.
> >>>
> >>> And you cannot grab the required lock, which is
> >>> drm_dev->mode_config.mutex, because that would result in deadlocks. S=
o
> >>> this really needs to use the atomic state based design I've described=
.
> >>>
> >> Maybe we should just drop "actual color format" and instead fail the
> >> modeset if the "preferred color format" property cannot be satisfied?
> >> It seems like the simplest thing to do here, though it is perhaps less
> >> convenient for userspace. In that case, the "preferred color format"
> >> property should just be called "color format".
> > Yeah that's more in line with how other atomic properties work. This
> > way userspace can figure out what works with a TEST_ONLY commit too.
> > And for this to work you probably want to have an "automatic" setting
> > too.
> > -Sima
>
> The problem with TEST_ONLY probing is that color format settings are
> interdependent: https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_=
966634
>
> So changing any other setting may require every color format to be TEST_O=
NLY
> probed again.
>

If we put a bit map containing the possible color formats into
drm_mode_mode_info (I'm thinking that it could go into flags), we'd be
able to eliminate a bunch of combinations early on. Do you think that
would make things more bearable?

I'm thinking, something like this:
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 128d09138ceb3..59980803cb89e 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -124,6 +124,13 @@ extern "C" {
 #define  DRM_MODE_FLAG_PIC_AR_256_135 \
                        (DRM_MODE_PICTURE_ASPECT_256_135<<19)

+/* Possible color formats (4 bits) */
+#define DRM_MODE_FLAG_COLOR_FORMAT_MASK (0x0f << 22)
+#define DRM_MODE_FLAG_COLOR_FORMAT_RGB (1 << 22)
+#define DRM_MODE_FLAG_COLOR_FORMAT_YCBCR444 (1 << 23)
+#define DRM_MODE_FLAG_COLOR_FORMAT_YCBCR422 (1 << 24)
+#define DRM_MODE_FLAG_COLOR_FORMAT_YCBCR420 (1 << 25)
+
 #define  DRM_MODE_FLAG_ALL     (DRM_MODE_FLAG_PHSYNC |         \
                                 DRM_MODE_FLAG_NHSYNC |         \
                                 DRM_MODE_FLAG_PVSYNC |         \
@@ -136,7 +143,8 @@ extern "C" {
                                 DRM_MODE_FLAG_HSKEW |          \
                                 DRM_MODE_FLAG_DBLCLK |         \
                                 DRM_MODE_FLAG_CLKDIV2 |        \
-                                DRM_MODE_FLAG_3D_MASK)
+                                DRM_MODE_FLAG_3D_MASK |        \
+                                DRM_MODE_FLAG_COLOR_FORMAT_MASK)

 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
