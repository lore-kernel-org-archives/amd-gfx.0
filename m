Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BABC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 14:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6DE22EBF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 14:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6DE22EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C703F6E453;
	Tue, 26 Jan 2021 14:51:49 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40746E453
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 14:51:48 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id bl23so2712627ejb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 06:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R5gWCJ8aliV2+fRdbcfreG5KXrLVP9+jCE5/6aDuYBU=;
 b=WbrOzvUDNDveaHoAi6t0lm0rl52NbGLvT4gFSIrMfx7XkCwBAYlFNLCtoK2n5HLmZC
 LRmXCo2LVfvBNiLsgBgZ+TJMtJmj5Zsbyj9xkigO8179xEMACmmPiyBiDhV/9lvqR9Fo
 /XV3Lhlupb5DD/9WggspioKyN823BvoDhP/+Fi/rRoxjw8GQuSzOh07oDlJEo07F8oAf
 7P01lH3vfs+P4AVAmy6OtyHyZOO1yHci2fMp8NCsH9IVW9qQ59nMVdiNdsll4t1dNW9g
 0mt53UZZIT6VK8LbmmDhkjJhO8RyXJGjqqvjTfF4timNJIx4uckuaQQJdYumtLCdD46g
 5qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R5gWCJ8aliV2+fRdbcfreG5KXrLVP9+jCE5/6aDuYBU=;
 b=W29tU3DXtCKiFPDCPCCCTuW0n+h5oJIppYOJQf9IipFTEVjWp0hI+WQV7cNPr82241
 iUfazxo3NZHWbouAJWuu1xEVd3VAr7uFXDRNh5n12Vai1I1T5y+71OZPiXBbv7kJEtk0
 9F5bcjIpFFugLU3A+w3Gto6Bhk56VxYEm4mKr5gfBJLfOJi8RbK3CZR6wL1JgzeDO9Y+
 ZHpNvFqcxclbfK8JU7w+1QMPclbAFp3eOTRyr37aiVjpeGvARpfOW06uaWzIYyqzCe6r
 OM+ivWajnh6mCkrKC/FtJcCaW7QUPAOUQep2laIC6RyTJShFg4YbBHawevOo769D6/6J
 XR5A==
X-Gm-Message-State: AOAM5303B2WTGUqJ5DGko8shpDJOH6jRO29okbJhD9RHDr2+/T+dZ7l3
 GhKZGWnja5X3ZSPqD2EOLP8Dn7E8rjio+Mw3TPMRvmhZ
X-Google-Smtp-Source: ABdhPJyso0A8/yzf+6bmsHHYq5mVWuQl24MdVmdXppQznWiXuHRRwS6wx19xEu12WxkyQM0c4qnIESJIA86b0g9XLI4=
X-Received: by 2002:a17:906:3401:: with SMTP id
 c1mr3808852ejb.156.1611672707645; 
 Tue, 26 Jan 2021 06:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20210126143155.16479-1-ernstp@gmail.com>
 <CADnq5_MzCdBnmZ4e8PckzK7wjA7DdsRaQ35gqi=H=TJ7_OWcmw@mail.gmail.com>
In-Reply-To: <CADnq5_MzCdBnmZ4e8PckzK7wjA7DdsRaQ35gqi=H=TJ7_OWcmw@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Tue, 26 Jan 2021 15:51:36 +0100
Message-ID: <CAD=4a=W-K1Zf64Bqhpzby-nX-iYYnuVZeX55w8JC0=F20x5Mtw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add DC feature flag to disable audio
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0675868915=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0675868915==
Content-Type: multipart/alternative; boundary="0000000000003bc4a805b9cecb63"

--0000000000003bc4a805b9cecb63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No problems with amdgpu, but when my headphone port is glitching I often
end up with some HDMI audio output selected instead.

It also cleans up the clutter in the audio selection list.

//E

Den tis 26 jan. 2021 kl 15:34 skrev Alex Deucher <alexdeucher@gmail.com>:

> On Tue, Jan 26, 2021 at 9:32 AM Ernst Sj=C3=B6strand <ernstp@gmail.com> w=
rote:
> >
> > With the pre-DC path you could set audio=3D0 to disable audio.
> > This adds a similar feature for the DC path with
> > amdgpu.dcfeaturemask=3D0x10.
> >
> > Signed-off-by: Ernst Sj=C3=B6strand <ernstp@gmail.com>
>
> Is there a reason you want this?  I.e., is audio causing problems for you=
?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 ++++---
> >  drivers/gpu/drm/amd/display/dc/dc.h               | 1 +
> >  drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
> >  4 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e490fc2486f7..322d9439b9c2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1013,6 +1013,9 @@ static int amdgpu_dm_init(struct amdgpu_device
> *adev)
> >         if (amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK)
> >                 init_data.flags.disable_fractional_pwm =3D true;
> >
> > +       if (amdgpu_dc_feature_mask & DC_DISABLE_AUDIO)
> > +               init_data.flags.disable_audio =3D true;
> > +
> >         init_data.flags.power_down_display_on_boot =3D true;
> >
> >         init_data.soc_bounding_box =3D adev->dm.soc_bounding_box;
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index 68b65a090d17..4cc0d2308c98 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -2141,9 +2141,10 @@ enum dc_status resource_map_pool_resources(
> >                 true);
> >
> >         /* TODO: Add check if ASIC support and EDID audio */
> > -       if (!stream->converter_disable_audio &&
> > -           dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
> > -           stream->audio_info.mode_count &&
> stream->audio_info.flags.all) {
> > +       if (!dc->config.disable_audio &&
> > +               !stream->converter_disable_audio &&
> > +               dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
> > +               stream->audio_info.mode_count &&
> stream->audio_info.flags.all) {
> >                 pipe_ctx->stream_res.audio =3D find_first_free_audio(
> >                 &context->res_ctx, pool,
> pipe_ctx->stream_res.stream_enc->id, dc_ctx->dce_version);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> b/drivers/gpu/drm/amd/display/dc/dc.h
> > index 71d46ade24e5..2ab6d770c66b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> > @@ -297,6 +297,7 @@ struct dc_config {
> >         bool multi_mon_pp_mclk_switch;
> >         bool disable_dmcu;
> >         bool enable_4to1MPC;
> > +       bool disable_audio;
> >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> >         bool clamp_min_dcfclk;
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> > index 9676016a37ce..7202d816a97e 100644
> > --- a/drivers/gpu/drm/amd/include/amd_shared.h
> > +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> > @@ -220,6 +220,7 @@ enum DC_FEATURE_MASK {
> >         DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D 0x2,
> >         DC_DISABLE_FRACTIONAL_PWM_MASK =3D 0x4,
> >         DC_PSR_MASK =3D 0x8,
> > +       DC_DISABLE_AUDIO =3D 0x10,
> >  };
> >
> >  enum DC_DEBUG_MASK {
> > --
> > 2.27.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000003bc4a805b9cecb63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">No problems with amdgpu, but when my headphone port is =
glitching I often end up with some HDMI audio output selected instead.</div=
><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-ser=
if"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif">It also cleans up the clutter in the audio selection list.=
</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,san=
s-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif">//E<br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">Den tis 26 jan. 2021 kl 15:34 skrev Alex=
 Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com=
</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue=
, Jan 26, 2021 at 9:32 AM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp=
@gmail.com" target=3D"_blank">ernstp@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; With the pre-DC path you could set audio=3D0 to disable audio.<br>
&gt; This adds a similar feature for the DC path with<br>
&gt; amdgpu.dcfeaturemask=3D0x10.<br>
&gt;<br>
&gt; Signed-off-by: Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail=
.com" target=3D"_blank">ernstp@gmail.com</a>&gt;<br>
<br>
Is there a reason you want this?=C2=A0 I.e., is audio causing problems for =
you?<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 ++++---<br=
>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/dc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 drivers/gpu/drm/amd/include/amd_shared.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 4 files changed, 9 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index e490fc2486f7..322d9439b9c2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1013,6 +1013,9 @@ static int amdgpu_dm_init(struct amdgpu_device *=
adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_dc_feature_mask &amp; DC_D=
ISABLE_FRACTIONAL_PWM_MASK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_data=
.flags.disable_fractional_pwm =3D true;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_dc_feature_mask &amp; DC_DISABL=
E_AUDIO)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_data.flag=
s.disable_audio =3D true;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_data.flags.power_down_display_on=
_boot =3D true;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_data.soc_bounding_box =3D adev-&=
gt;dm.soc_bounding_box;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; index 68b65a090d17..4cc0d2308c98 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; @@ -2141,9 +2141,10 @@ enum dc_status resource_map_pool_resources(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true);<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: Add check if ASIC support an=
d EDID audio */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stream-&gt;converter_disable_audio &a=
mp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_is_audio_capable_signal(p=
ipe_ctx-&gt;stream-&gt;signal) &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stream-&gt;audio_info.mode_c=
ount &amp;&amp; stream-&gt;audio_info.flags.all) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dc-&gt;config.disable_audio &amp;&amp=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!stream-&gt;co=
nverter_disable_audio &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_is_audio_ca=
pable_signal(pipe_ctx-&gt;stream-&gt;signal) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stream-&gt;aud=
io_info.mode_count &amp;&amp; stream-&gt;audio_info.flags.all) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_ctx-=
&gt;stream_res.audio =3D find_first_free_audio(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cont=
ext-&gt;res_ctx, pool, pipe_ctx-&gt;stream_res.stream_enc-&gt;id, dc_ctx-&g=
t;dce_version);<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd=
/display/dc/dc.h<br>
&gt; index 71d46ade24e5..2ab6d770c66b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt; @@ -297,6 +297,7 @@ struct dc_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool multi_mon_pp_mclk_switch;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool disable_dmcu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool enable_4to1MPC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool disable_audio;<br>
&gt;=C2=A0 #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool clamp_min_dcfclk;<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/dr=
m/amd/include/amd_shared.h<br>
&gt; index 9676016a37ce..7202d816a97e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt; +++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt; @@ -220,6 +220,7 @@ enum DC_FEATURE_MASK {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D =
0x2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_DISABLE_FRACTIONAL_PWM_MASK =3D 0x=
4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_PSR_MASK =3D 0x8,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DC_DISABLE_AUDIO =3D 0x10,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 enum DC_DEBUG_MASK {<br>
&gt; --<br>
&gt; 2.27.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--0000000000003bc4a805b9cecb63--

--===============0675868915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0675868915==--
