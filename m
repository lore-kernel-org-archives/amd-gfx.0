Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8F3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 12:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2160C2070E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 12:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2160C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8659F6E101;
	Wed, 27 Jan 2021 12:24:04 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6990A6E101
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 12:24:02 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so2391975ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qHqzKSNQkDNwsC/In7mU6bqyNetCTqIGFqnl2R3GPKw=;
 b=cM2Aw3VFb1X1ajYsPsR58diS8L2FKEo6rONwBuyVYbes4NxJRZ7iqJQNKp/bVzl+CG
 JRc5RIG/miM9w1A+/CbJ3us0Ejgeq4c6TsrHQgesS3psS76Ean+Reeh33SuxmRa6WRJz
 iTrSKdVz7BLb04Szqz/PAdqlHCIeD2o6bjNoSipoBcB4HGehnKhVELHFDIcl/wmG0V7+
 B/VtXSiFLbaGtyq7Nej2pcxT9jXjA/DKn8z0r9Zu9lcg4P0N+L20Lv1+cx1p74ocETA2
 6jZqimqnTBCsygjFtHf9VAoaPJFXGZJwBZ/D73d/hvXkr13Zsd/IHP/RHvU1/NEDM2p1
 twSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qHqzKSNQkDNwsC/In7mU6bqyNetCTqIGFqnl2R3GPKw=;
 b=Lnttp6lLfgKDZlQydJ6400JFfxzj051yHmMAgG65OEIfzdOP3bUTKdGe6DV9j3hNBr
 elAB13lzkzzHzi4RuRyAIokr0acXs3FetpkifpO+jZMQCSRzeJynsZsB4kiW2+VokkCb
 nuLj3fc2lJ8kk+fKA+A5dW3cDkH/9ZoO3Ixm+FSds6CvTI9XG3dDhXYFkUSJiAFiOfTS
 3B7JVkW/clZydcrAdTiQVOrFnx1ITPsXuM1ZUT7VYjpORRRJ58F+Dvdw23p7Dj8+XJkl
 Qxz9LbzfGjixxn8RYdAOwJn/eEo5dcochEIriXLN+LL46t6NgcX0ezUth6MP5WDcWYD9
 cStA==
X-Gm-Message-State: AOAM532XR59fWoBSseEMZPL4nnAyrqftbuU0IDoBRAirERjK9DlNAqph
 Z0JkfcHlN+juBSnL/JYkW4346nn/fhMF7dAZAIg=
X-Google-Smtp-Source: ABdhPJwTzRmeE5ozz3G7a1Dpu/zEHD4yzBQThr0ws6TQYaMrRDDrYbsC6o2qOZqOzbZbDmFzJNBAXUHW+IL2DqgN82U=
X-Received: by 2002:a17:906:3685:: with SMTP id
 a5mr6385417ejc.544.1611750241003; 
 Wed, 27 Jan 2021 04:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20210126143155.16479-1-ernstp@gmail.com>
 <CADnq5_MzCdBnmZ4e8PckzK7wjA7DdsRaQ35gqi=H=TJ7_OWcmw@mail.gmail.com>
 <CAD=4a=W-K1Zf64Bqhpzby-nX-iYYnuVZeX55w8JC0=F20x5Mtw@mail.gmail.com>
 <0115f891-d4a8-930c-7095-cbb45ec1df01@amd.com>
 <c9c2a670-4f82-adb5-8ecf-fd80652203c7@gmail.com>
In-Reply-To: <c9c2a670-4f82-adb5-8ecf-fd80652203c7@gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Wed, 27 Jan 2021 13:23:49 +0100
Message-ID: <CAD=4a=WiL5m0jJOgEDe9xrM3bsX1Xt+YTtV_WY5_j+sAOEGe=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add DC feature flag to disable audio
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: multipart/mixed; boundary="===============1480801833=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1480801833==
Content-Type: multipart/alternative; boundary="00000000000094eb2a05b9e0d853"

--00000000000094eb2a05b9e0d853
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just some additional thoughts...

The amdgpu driver already supports this as I mentioned, however only for
the non-DC codepath.
"Set HDMI/DPAudio. Only affects non-DC display handling. The default is -1
(Enabled), set 0 to disabled it."

Linux doesn't have a good infrastructure to disable sound cards afaik. If
someone has 6 displays, do they really need 6 extra sound cards? Minor
thing, I know.

It was very easy to do, and didn't feel intrusive.
//E

Den ons 27 jan. 2021 kl 12:11 skrev Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com>:

> Am 26.01.21 um 17:15 schrieb Harry Wentland:
> > On 2021-01-26 9:51 a.m., Ernst Sj=C3=B6strand wrote:
> >> No problems with amdgpu, but when my headphone port is glitching I
> >> often end up with some HDMI audio output selected instead.
> >>
> >
> > Wouldn't this be better fixed in the audio management service, like
> > PulseAudio? It sounds like it's not remembering your preferences
> > correctly.
>
> Yeah agree. A feature like this in a specific hardware driver is
> justified if it prevents hangs or something similar.
>
> But this just sounds like a problem in a higher level of the stack which
> should be fixed hardware driver independently.
>
> Christian.
>
> >
> > Harry
> >
> >> It also cleans up the clutter in the audio selection list.
> >>
> >> //E
> >>
> >> Den tis 26 jan. 2021 kl 15:34 skrev Alex Deucher
> >> <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>:
> >>
> >>     On Tue, Jan 26, 2021 at 9:32 AM Ernst Sj=C3=B6strand <ernstp@gmail=
.com
> >>     <mailto:ernstp@gmail.com>> wrote:
> >>      >
> >>      > With the pre-DC path you could set audio=3D0 to disable audio.
> >>      > This adds a similar feature for the DC path with
> >>      > amdgpu.dcfeaturemask=3D0x10.
> >>      >
> >>      > Signed-off-by: Ernst Sj=C3=B6strand <ernstp@gmail.com
> >>     <mailto:ernstp@gmail.com>>
> >>
> >>     Is there a reason you want this?  I.e., is audio causing problems
> >>     for you?
> >>
> >>     Alex
> >>
> >>      > ---
> >>      >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> >>      >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 ++++---
> >>      >  drivers/gpu/drm/amd/display/dc/dc.h               | 1 +
> >>      >  drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
> >>      >  4 files changed, 9 insertions(+), 3 deletions(-)
> >>      >
> >>      > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>      > index e490fc2486f7..322d9439b9c2 100644
> >>      > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>      > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>      > @@ -1013,6 +1013,9 @@ static int amdgpu_dm_init(struct
> >>     amdgpu_device *adev)
> >>      >         if (amdgpu_dc_feature_mask &
> >> DC_DISABLE_FRACTIONAL_PWM_MASK)
> >>      >                 init_data.flags.disable_fractional_pwm =3D true=
;
> >>      >
> >>      > +       if (amdgpu_dc_feature_mask & DC_DISABLE_AUDIO)
> >>      > +               init_data.flags.disable_audio =3D true;
> >>      > +
> >>      >         init_data.flags.power_down_display_on_boot =3D true;
> >>      >
> >>      >         init_data.soc_bounding_box =3D adev->dm.soc_bounding_bo=
x;
> >>      > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>     b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>      > index 68b65a090d17..4cc0d2308c98 100644
> >>      > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>      > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>      > @@ -2141,9 +2141,10 @@ enum dc_status
> >> resource_map_pool_resources(
> >>      >                 true);
> >>      >
> >>      >         /* TODO: Add check if ASIC support and EDID audio */
> >>      > -       if (!stream->converter_disable_audio &&
> >>      > -  dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
> >>      > -           stream->audio_info.mode_count &&
> >>     stream->audio_info.flags.all) {
> >>      > +       if (!dc->config.disable_audio &&
> >>      > +               !stream->converter_disable_audio &&
> >>      > +  dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
> >>      > +               stream->audio_info.mode_count &&
> >>     stream->audio_info.flags.all) {
> >>      >                 pipe_ctx->stream_res.audio =3D
> >> find_first_free_audio(
> >>      >                 &context->res_ctx, pool,
> >>     pipe_ctx->stream_res.stream_enc->id, dc_ctx->dce_version);
> >>      >
> >>      > diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> >>     b/drivers/gpu/drm/amd/display/dc/dc.h
> >>      > index 71d46ade24e5..2ab6d770c66b 100644
> >>      > --- a/drivers/gpu/drm/amd/display/dc/dc.h
> >>      > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> >>      > @@ -297,6 +297,7 @@ struct dc_config {
> >>      >         bool multi_mon_pp_mclk_switch;
> >>      >         bool disable_dmcu;
> >>      >         bool enable_4to1MPC;
> >>      > +       bool disable_audio;
> >>      >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> >>      >         bool clamp_min_dcfclk;
> >>      >  #endif
> >>      > diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> >>     b/drivers/gpu/drm/amd/include/amd_shared.h
> >>      > index 9676016a37ce..7202d816a97e 100644
> >>      > --- a/drivers/gpu/drm/amd/include/amd_shared.h
> >>      > +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> >>      > @@ -220,6 +220,7 @@ enum DC_FEATURE_MASK {
> >>      >         DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D 0x2,
> >>      >         DC_DISABLE_FRACTIONAL_PWM_MASK =3D 0x4,
> >>      >         DC_PSR_MASK =3D 0x8,
> >>      > +       DC_DISABLE_AUDIO =3D 0x10,
> >>      >  };
> >>      >
> >>      >  enum DC_DEBUG_MASK {
> >>      > --
> >>      > 2.27.0
> >>      >
> >>      > _______________________________________________
> >>      > amd-gfx mailing list
> >>      > amd-gfx@lists.freedesktop.org
> >> <mailto:amd-gfx@lists.freedesktop.org>
> >>      > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >> <
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CHARRY.WENT=
LAND%40amd.com%7C736532bfba5d4b96e9ac08d8c209e99d%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637472695123517788%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3D1MWOf=
MfaIhdV%2BcnH%2BeAC0aRqb9BMVrdvReZBKG2ZJSc%3D&reserved=3D0
> >
> >>
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--00000000000094eb2a05b9e0d853
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:arial,helvetica,sans-serif"=
 class=3D"gmail_default">Just some additional thoughts...</div><br></div><d=
iv>The amdgpu driver already supports this as I mentioned, however only for=
 the non-DC codepath.</div><div><span class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif">&quot;</span>Set HDMI/DPAudio. Only aff=
ects non-DC display handling. The default is -1 (Enabled), set 0 to disable=
d it.<span class=3D"gmail_default" style=3D"font-family:arial,helvetica,san=
s-serif">&quot;</span></div><div><span class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif"><br></span></div><div><span class=3D"g=
mail_default" style=3D"font-family:arial,helvetica,sans-serif">Linux doesn&=
#39;t have a good infrastructure to disable sound cards afaik. If someone h=
as 6 displays, do they really need 6 extra sound cards? Minor thing, I know=
.</span></div><div><span class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif"><br></span></div><div><span class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif">It was very easy to do, an=
d didn&#39;t feel intrusive.<br></span></div><div><span class=3D"gmail_defa=
ult" style=3D"font-family:arial,helvetica,sans-serif"></span></div><div><sp=
an class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"=
>//E<br></span></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Den ons 27 jan. 2021 kl 12:11 skrev Christian K=C3=B6n=
ig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzu=
merken@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Am 26.01.21 um 17:15 schrieb Harry Wentland:<br>
&gt; On 2021-01-26 9:51 a.m., Ernst Sj=C3=B6strand wrote:<br>
&gt;&gt; No problems with amdgpu, but when my headphone port is glitching I=
 <br>
&gt;&gt; often end up with some HDMI audio output selected instead.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Wouldn&#39;t this be better fixed in the audio management service, lik=
e <br>
&gt; PulseAudio? It sounds like it&#39;s not remembering your preferences <=
br>
&gt; correctly.<br>
<br>
Yeah agree. A feature like this in a specific hardware driver is <br>
justified if it prevents hangs or something similar.<br>
<br>
But this just sounds like a problem in a higher level of the stack which <b=
r>
should be fixed hardware driver independently.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Harry<br>
&gt;<br>
&gt;&gt; It also cleans up the clutter in the audio selection list.<br>
&gt;&gt;<br>
&gt;&gt; //E<br>
&gt;&gt;<br>
&gt;&gt; Den tis 26 jan. 2021 kl 15:34 skrev Alex Deucher <br>
&gt;&gt; &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">ale=
xdeucher@gmail.com</a> &lt;mailto:<a href=3D"mailto:alexdeucher@gmail.com" =
target=3D"_blank">alexdeucher@gmail.com</a>&gt;&gt;:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 On Tue, Jan 26, 2021 at 9:32 AM Ernst Sj=C3=B6s=
trand &lt;<a href=3D"mailto:ernstp@gmail.com" target=3D"_blank">ernstp@gmai=
l.com</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"mailto:ernstp@gmail.com" =
target=3D"_blank">ernstp@gmail.com</a>&gt;&gt; wrote:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; With the pre-DC path you could set a=
udio=3D0 to disable audio.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; This adds a similar feature for the =
DC path with<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; amdgpu.dcfeaturemask=3D0x10.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Signed-off-by: Ernst Sj=C3=B6strand =
&lt;<a href=3D"mailto:ernstp@gmail.com" target=3D"_blank">ernstp@gmail.com<=
/a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"mailto:ernstp@gmail.com" =
target=3D"_blank">ernstp@gmail.com</a>&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Is there a reason you want this?=C2=A0 I.e., is=
 audio causing problems<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 for you?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Alex<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ---<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 drivers/gpu/drm/amd/display/am=
dgpu_dm/amdgpu_dm.c | 3 +++<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 drivers/gpu/drm/amd/display/dc=
/core/dc_resource.c | 7 ++++---<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 drivers/gpu/drm/amd/display/dc=
/dc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 drivers/gpu/drm/amd/include/am=
d_shared.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 4 files changed, 9 insertions(=
+), 3 deletions(-)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/drivers/gpu/drm/amd/dis=
play/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; index e490fc2486f7..322d9439b9c2 100=
644<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/drivers/gpu/drm/amd/display/am=
dgpu_dm/amdgpu_dm.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/drivers/gpu/drm/amd/display/am=
dgpu_dm/amdgpu_dm.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -1013,6 +1013,9 @@ static int amd=
gpu_dm_init(struct<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 amdgpu_device *adev)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(amdgpu_dc_feature_mask &amp; <br>
&gt;&gt; DC_DISABLE_FRACTIONAL_PWM_MASK)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0init_data.flags.disable_fractional_pwm =3D true;=
<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdg=
pu_dc_feature_mask &amp; DC_DISABLE_AUDIO)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0init_data.flags.disable_audio =3D true;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ini=
t_data.flags.power_down_display_on_boot =3D true;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ini=
t_data.soc_bounding_box =3D adev-&gt;dm.soc_bounding_box;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/drivers/gpu/drm/amd/dis=
play/dc/core/dc_resource.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 b/drivers/gpu/drm/amd/display/dc/core/dc_resour=
ce.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; index 68b65a090d17..4cc0d2308c98 100=
644<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/drivers/gpu/drm/amd/display/dc=
/core/dc_resource.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/drivers/gpu/drm/amd/display/dc=
/core/dc_resource.c<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -2141,9 +2141,10 @@ enum dc_statu=
s <br>
&gt;&gt; resource_map_pool_resources(<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0true);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
TODO: Add check if ASIC support and EDID audio */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!str=
eam-&gt;converter_disable_audio &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; - =C2=A0dc_is_audio_capable_signal(p=
ipe_ctx-&gt;stream-&gt;signal) &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0stream-&gt;audio_info.mode_count &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 stream-&gt;audio_info.flags.all) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dc-=
&gt;config.disable_audio &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0!stream-&gt;converter_disable_audio &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; + =C2=A0dc_is_audio_capable_signal(p=
ipe_ctx-&gt;stream-&gt;signal) &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0stream-&gt;audio_info.mode_count &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 stream-&gt;audio_info.flags.all) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_ctx-&gt;stream_res.audio =3D <br>
&gt;&gt; find_first_free_audio(<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;context-&gt;res_ctx, pool,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 pipe_ctx-&gt;stream_res.stream_enc-&gt;id, dc_c=
tx-&gt;dce_version);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/drivers/gpu/drm/amd/dis=
play/dc/dc.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 b/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; index 71d46ade24e5..2ab6d770c66b 100=
644<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/drivers/gpu/drm/amd/display/dc=
/dc.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/drivers/gpu/drm/amd/display/dc=
/dc.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -297,6 +297,7 @@ struct dc_config=
 {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boo=
l multi_mon_pp_mclk_switch;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boo=
l disable_dmcu;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boo=
l enable_4to1MPC;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool dis=
able_audio;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 #if defined(CONFIG_DRM_AMD_DC_=
DCN)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boo=
l clamp_min_dcfclk;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 #endif<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/drivers/gpu/drm/amd/inc=
lude/amd_shared.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; index 9676016a37ce..7202d816a97e 100=
644<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/drivers/gpu/drm/amd/include/am=
d_shared.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/drivers/gpu/drm/amd/include/am=
d_shared.h<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -220,6 +220,7 @@ enum DC_FEATURE_=
MASK {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_=
MULTI_MON_PP_MCLK_SWITCH_MASK =3D 0x2,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_=
DISABLE_FRACTIONAL_PWM_MASK =3D 0x4,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_=
PSR_MASK =3D 0x8,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DC_DISAB=
LE_AUDIO =3D 0x10,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 };<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 enum DC_DEBUG_MASK {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; --<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; 2.27.0<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ____________________________________=
___________<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; amd-gfx mailing list<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"mailto:amd-gfx@lists.free=
desktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a> <br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=
=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"https://lists.freedesktop=
.org/mailman/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt; &lt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;d=
ata=3D04%7C01%7CHARRY.WENTLAND%40amd.com%7C736532bfba5d4b96e9ac08d8c209e99d=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637472695123517788%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;sdata=3D1MWOfMfaIhdV%2BcnH%2BeAC0aRqb9BMVrdvReZBKG2ZJSc%3D=
&amp;reserved=3D0" rel=3D"noreferrer" target=3D"_blank">https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fma=
ilman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CHARRY.WENTLAND%40amd.com%7C=
736532bfba5d4b96e9ac08d8c209e99d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637472695123517788%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1MWOfMfaIhdV%2BcnH=
%2BeAC0aRqb9BMVrdvReZBKG2ZJSc%3D&amp;reserved=3D0</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank"=
>amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman=
/listinfo/amd-gfx</a><br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
<br>
</blockquote></div>

--00000000000094eb2a05b9e0d853--

--===============1480801833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1480801833==--
