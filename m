Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0A0C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 18:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9909210E1D5;
	Tue,  2 Jan 2024 18:13:22 +0000 (UTC)
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1936B10E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 16:54:02 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 433F133F06C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 16:54:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1704214440; bh=rYJotU0eFIgjvtSo85T7on5RWlF3XVy4G/qHcAn3l7o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=a9Ah6gPklqrl2ITdWgHw1EHIFqxoVAjerXy4MhVWnRzjRFP5BqvICljfwNLVHTpDf
 ZWdD5By4iwr0qdeWwKd5ap39h3BeD2k4FfTUFz1/fEFItjiQ+CBJgFeC4lfqbZ/Wns
 iyFlQmd4fbQTcavGhGow9tKUleteWPUICY0P4nMyfhohxNHkzV28iFM7HcKsGNWYu8
 1goHc9BZWchQyEJMauFWB9z4LhSfS2Mf9bf5V+g1DfY8VzqCf91JHUoMnUT0p7f1Tr
 /s4sM5B7Rle9cvBbEAZfLYeI21czQkj+Gj9V9LHuflIWs/R0mZ9/Cz+C19AydnTxbD
 HrluErrbrZDxw==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-50e9e5c97e1so1111521e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jan 2024 08:54:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxVMbZsrFedo7G+RHZ1+dqh7RsMDp0RiuQviJF93AmBZUnOhA4I
 7vOEwrXkvJ4zn5iocrxlJRs/uJu273nPGPCHwSg=
X-Google-Smtp-Source: AGHT+IG9BqdbGvi9qkT+jtqXKyOlZyqDhaP5CnXUHWo4r+VwWfwEyNODqVS551m1nl2w6PlPCWytdLfKfTRVuQQL6tM=
X-Received: by 2002:a05:6512:3404:b0:50e:9e5b:497 with SMTP id
 i4-20020a056512340400b0050e9e5b0497mr1127479lfr.137.1704214439330; Tue, 02
 Jan 2024 08:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20240101182836.817565-1-joshua@froggi.es>
 <554945c2-bb85-497a-ba88-b486eadd8a3c@froggi.es>
In-Reply-To: <554945c2-bb85-497a-ba88-b486eadd8a3c@froggi.es>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Tue, 2 Jan 2024 17:53:48 +0100
X-Gmail-Original-Message-ID: <CAFZQkGxJ9demMm-85LFimEQGqj2J5-2-RRsOeKRss3Wr=X3j1A@mail.gmail.com>
Message-ID: <CAFZQkGxJ9demMm-85LFimEQGqj2J5-2-RRsOeKRss3Wr=X3j1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
To: Joshua Ashton <joshua@froggi.es>
Content-Type: multipart/alternative; boundary="000000000000470dda060df958f8"
X-Mailman-Approved-At: Tue, 02 Jan 2024 18:13:20 +0000
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
Cc: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000470dda060df958f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested the patch and it fixes the issue for me too. Consider it
Tested-By Xaver Hugl <xaver.hugl@kde.org>

- Xaver

Am Mo., 1. Jan. 2024 um 22:37 Uhr schrieb Joshua Ashton <joshua@froggi.es>:

>  From the issue:
>
> ```
> Thank you for for fixing this!
> I built a custom kernel with this patch on the fedora rawhide kernel
> (6.7.0-0.rc8.61.fc40.x86_64) and now the colors look correct. SDR
> content is now displayed as sRGB and HDR/WCG content can use the full
> capabilities of the display.
> I currently don't have a desktop mail client installed to comment on the
> mailing list directly, so I'll post it here (not sure if it counts or
> matters =F0=9F=98=80 )
>
> Tested-By: Simon Berz <simon@berz.me>
> ```
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> On 1/1/24 18:28, Joshua Ashton wrote:
> > The check for sending the vsc infopacket to the display was gated behin=
d
> > PSR (Panel Self Refresh) being enabled.
> >
> > The vsc infopacket also contains the colorimetry (specifically the
> > container color gamut) information for the stream on modern DP.
> >
> > PSR is typically only supported on mobile phone eDP displays, thus this
> > was not getting sent for typical desktop monitors or TV screens.
> >
> > This functionality is needed for proper HDR10 functionality on DP as it
> > wants BT2020 RGB/YCbCr for the container color space.
> >
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Xaver Hugl <xaver.hugl@gmail.com>
> > Cc: Melissa Wen <mwen@igalia.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
> >   .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++----=
-
> >   2 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 2845c884398e..6dff56408bf4 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector
> *connector,
> >
> >       if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> >               mod_build_hf_vsif_infopacket(stream,
> &stream->vsp_infopacket);
> > -
> > -     if (stream->link->psr_settings.psr_feature_enabled ||
> stream->link->replay_settings.replay_feature_enabled) {
> > +     else if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> > +                      stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_M=
ST ||
> > +                      stream->signal =3D=3D SIGNAL_TYPE_EDP) {
> >               //
> >               // should decide stream support vsc sdp colorimetry
> capability
> >               // before building vsc info packet
> > @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector
> *connector,
> >               if (stream->out_transfer_func->tf =3D=3D
> TRANSFER_FUNCTION_GAMMA22)
> >                       tf =3D TRANSFER_FUNC_GAMMA_22;
> >               mod_build_vsc_infopacket(stream, &stream->vsc_infopacket,
> stream->output_color_space, tf);
> > -             aconnector->psr_skip_count =3D AMDGPU_DM_PSR_ENTRY_DELAY;
> >
> > +             if (stream->link->psr_settings.psr_feature_enabled)
> > +                     aconnector->psr_skip_count =3D
> AMDGPU_DM_PSR_ENTRY_DELAY;
> >       }
> >   finish:
> >       dc_sink_release(sink);
> > diff --git
> a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > index 84f9b412a4f1..738ee763f24a 100644
> > --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct
> dc_stream_state *stream,
> >       }
> >
> >       /* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
> > -     if (stream->link->psr_settings.psr_version =3D=3D DC_PSR_VERSION_=
SU_1)
> > -             vsc_packet_revision =3D vsc_packet_rev4;
> > -     else if (stream->link->replay_settings.config.replay_supported)
> > +     if (stream->link->psr_settings.psr_feature_enabled) {
> > +             if (stream->link->psr_settings.psr_version =3D=3D
> DC_PSR_VERSION_SU_1)
> > +                     vsc_packet_revision =3D vsc_packet_rev4;
> > +             else if (stream->link->psr_settings.psr_version =3D=3D
> DC_PSR_VERSION_1)
> > +                     vsc_packet_revision =3D vsc_packet_rev2;
> > +     }
> > +
> > +     if (stream->link->replay_settings.config.replay_supported)
> >               vsc_packet_revision =3D vsc_packet_rev4;
> > -     else if (stream->link->psr_settings.psr_version =3D=3D
> DC_PSR_VERSION_1)
> > -             vsc_packet_revision =3D vsc_packet_rev2;
> >
> >       /* Update to revision 5 for extended colorimetry support */
> >       if (stream->use_vsc_sdp_for_colorimetry)
>
>

--000000000000470dda060df958f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I tested the patch and i=
t fixes the issue for me too. Consider it</div><div>Tested-By Xaver Hugl &l=
t;<a href=3D"mailto:xaver.hugl@kde.org">xaver.hugl@kde.org</a>&gt;</div><di=
v><br></div><div>- Xaver<br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">Am Mo., 1. Jan. 2024 um 22:37=C2=A0Uhr sc=
hrieb Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es">joshua@froggi.e=
s</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=
=A0From the issue:<br>
<br>
```<br>
Thank you for for fixing this!<br>
I built a custom kernel with this patch on the fedora rawhide kernel <br>
(6.7.0-0.rc8.61.fc40.x86_64) and now the colors look correct. SDR <br>
content is now displayed as sRGB and HDR/WCG content can use the full <br>
capabilities of the display.<br>
I currently don&#39;t have a desktop mail client installed to comment on th=
e <br>
mailing list directly, so I&#39;ll post it here (not sure if it counts or <=
br>
matters =F0=9F=98=80 )<br>
<br>
Tested-By: Simon Berz &lt;<a href=3D"mailto:simon@berz.me" target=3D"_blank=
">simon@berz.me</a>&gt;<br>
```<br>
<br>
- Joshie =F0=9F=90=B8=E2=9C=A8<br>
<br>
On 1/1/24 18:28, Joshua Ashton wrote:<br>
&gt; The check for sending the vsc infopacket to the display was gated behi=
nd<br>
&gt; PSR (Panel Self Refresh) being enabled.<br>
&gt; <br>
&gt; The vsc infopacket also contains the colorimetry (specifically the<br>
&gt; container color gamut) information for the stream on modern DP.<br>
&gt; <br>
&gt; PSR is typically only supported on mobile phone eDP displays, thus thi=
s<br>
&gt; was not getting sent for typical desktop monitors or TV screens.<br>
&gt; <br>
&gt; This functionality is needed for proper HDR10 functionality on DP as i=
t<br>
&gt; wants BT2020 RGB/YCbCr for the container color space.<br>
&gt; <br>
&gt; Signed-off-by: Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es" t=
arget=3D"_blank">joshua@froggi.es</a>&gt;<br>
&gt; <br>
&gt; Cc: Harry Wentland &lt;<a href=3D"mailto:harry.wentland@amd.com" targe=
t=3D"_blank">harry.wentland@amd.com</a>&gt;<br>
&gt; Cc: Xaver Hugl &lt;<a href=3D"mailto:xaver.hugl@gmail.com" target=3D"_=
blank">xaver.hugl@gmail.com</a>&gt;<br>
&gt; Cc: Melissa Wen &lt;<a href=3D"mailto:mwen@igalia.com" target=3D"_blan=
k">mwen@igalia.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=C2=A0 =
=C2=A0|=C2=A0 8 +++++---<br>
&gt;=C2=A0 =C2=A0.../amd/display/modules/info_packet/info_packet.c=C2=A0 =
=C2=A0| 13 ++++++++-----<br>
&gt;=C2=A0 =C2=A02 files changed, 13 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 2845c884398e..6dff56408bf4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector *con=
nector,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (stream-&gt;signal =3D=3D SIGNAL_TYPE_HDM=
I_TYPE_A)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_build_hf_vsi=
f_infopacket(stream, &amp;stream-&gt;vsp_infopacket);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (stream-&gt;link-&gt;psr_settings.psr_feature_=
enabled || stream-&gt;link-&gt;replay_settings.replay_feature_enabled) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0else if (stream-&gt;signal =3D=3D SIGNAL_TYPE_DIS=
PLAY_PORT ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 stream-&gt;signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 stream-&gt;signal =3D=3D SIGNAL_TYPE_EDP) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// should decide=
 stream support vsc sdp colorimetry capability<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// before buildi=
ng vsc info packet<br>
&gt; @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector *con=
nector,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stream-&gt;o=
ut_transfer_func-&gt;tf =3D=3D TRANSFER_FUNCTION_GAMMA22)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tf =3D TRANSFER_FUNC_GAMMA_22;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_build_vsc_in=
fopacket(stream, &amp;stream-&gt;vsc_infopacket, stream-&gt;output_color_sp=
ace, tf);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aconnector-&gt;psr_sk=
ip_count =3D AMDGPU_DM_PSR_ENTRY_DELAY;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stream-&gt;link-&=
gt;psr_settings.psr_feature_enabled)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0aconnector-&gt;psr_skip_count =3D AMDGPU_DM_PSR_ENTRY_DELAY;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0finish:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dc_sink_release(sink);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_pack=
et.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c<br>
&gt; index 84f9b412a4f1..738ee763f24a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c<br=
>
&gt; +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c<br=
>
&gt; @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_st=
ream_state *stream,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* VSC packet set to 4 for PSR-SU, or 2 for =
PSR1 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (stream-&gt;link-&gt;psr_settings.psr_version =
=3D=3D DC_PSR_VERSION_SU_1)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsc_packet_revision =
=3D vsc_packet_rev4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else if (stream-&gt;link-&gt;replay_settings.conf=
ig.replay_supported)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (stream-&gt;link-&gt;psr_settings.psr_feature_=
enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stream-&gt;link-&=
gt;psr_settings.psr_version =3D=3D DC_PSR_VERSION_SU_1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsc_packet_revision =3D vsc_packet_rev4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (stream-&gt;l=
ink-&gt;psr_settings.psr_version =3D=3D DC_PSR_VERSION_1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsc_packet_revision =3D vsc_packet_rev2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (stream-&gt;link-&gt;replay_settings.config.re=
play_supported)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsc_packet_revis=
ion =3D vsc_packet_rev4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else if (stream-&gt;link-&gt;psr_settings.psr_ver=
sion =3D=3D DC_PSR_VERSION_1)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsc_packet_revision =
=3D vsc_packet_rev2;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update to revision 5 for extended colorim=
etry support */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (stream-&gt;use_vsc_sdp_for_colorimetry)<=
br>
<br>
</blockquote></div>

--000000000000470dda060df958f8--
