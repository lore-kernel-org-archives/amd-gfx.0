Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E881C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 23:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3B8206E5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 23:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3B8206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDCC6F37F;
	Thu, 14 Nov 2019 23:57:17 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94B86F37F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 23:57:15 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id g38so3323001ybe.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 15:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GvwHB7a9fwWaiweIkRg6ThAxSJnVV62xOLu32yjQgXE=;
 b=bgoa7E8zS12Ok+2r1Ovu+lzHeA49+OEYbKDTH0u7yUuxfjMS2LUnvkizgeya1sI8Ci
 rDDfci+2bkKsS82LFdgGLDV+NdS7NdEsJIH+zVWboWv3oNkwYe8dIcBUogemMXVciEPh
 ZsQHaGTDzOrYuwrfyhIGIgXYcUeyKxbuVMKpzG+M/EGbin7SsBnPJhjUHhfoEV1lPVLu
 iuv+34dvdXsCqnEsxK2z4sDJXhNabl+REKYEmtCrwmgu17H4l2C/Xla6lDBx2PZUEIvi
 mbKdW1blW54kybD5Mr17op1Fnk38kvYHhGCoihH52peWdYINFzWNBn6Fe74usYSIWvJJ
 2ypw==
X-Gm-Message-State: APjAAAU50q5Z8/1fwQtuw+faw1g8VlOe1otUqrt3XiRpfCdD8b0KqHmP
 n1mKIQ0lKEl3TV66XI2ghoVYq2/uKKthZO44b5obt+rMFuk=
X-Google-Smtp-Source: APXvYqxfMxkR5Fpj8eByZrapAMn3ZVsRJlclnMP5B6w0vlp8wMsF1tKAfDnXB4qYC5IUwNvJ5DdJI6yqecTeawjuN84=
X-Received: by 2002:a25:7182:: with SMTP id m124mr8874357ybc.487.1573775834962; 
 Thu, 14 Nov 2019 15:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20191001222123.2392-1-jisorce@oblong.com>
 <CAHWPjbWcdhnewEN8OEUgDu5aBpYBW5tUggA_KJ_BUR8JLvCsQw@mail.gmail.com>
 <4610d814-6c54-982e-ecc6-716cc42b5e68@amd.com>
 <CAHWPjbXPL9NsT0yXb8_wkodT18TEBcgf81tY49GP+U=SGZ26YQ@mail.gmail.com>
 <c501ea8d-21d9-61ce-dafb-ef45c1701a1f@amd.com>
In-Reply-To: <c501ea8d-21d9-61ce-dafb-ef45c1701a1f@amd.com>
From: Julien Isorce <julien.isorce@gmail.com>
Date: Thu, 14 Nov 2019 15:57:04 -0800
Message-ID:
 <CAHWPjbXYkpW+HQaCzL6XNtp9HH2Dgq=+=XxRWc0iXLsSPdKw-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use pixel encoding 444 for dongle usb-c
 to hdmi
To: Harry Wentland <hwentlan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=GvwHB7a9fwWaiweIkRg6ThAxSJnVV62xOLu32yjQgXE=;
 b=hCnC95hyCc12H2BgaPxDGiD7lzNPW1MiKu59HT1I7mSHE6QHOo3ymKeKYLHeCAxdDT
 ud6fW96o5QvAH1b1nSrnmWJ8h9fMvLEjgskUvTZnFbk/Cg4iNHw/Ds9Cd+UvNpvHk135
 Ccs9GglFEkqaHBW4cVfV+tAEQuE841J180lGEyyt00RDo9SiI8u2siN8bJ8OdN4bXJDB
 DM7VezFMEPtcIg8h5rGc4KQa6S8FsUaB9I6O/8hLR/tlbJClaBxM635lIRS6Ah+JpPXj
 Y0465eRjQKep28lrr110EQjivpUVth19vMQzk/JTTYI3FguL81uUL7EnZl7khFZWSIcS
 1+Fw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: multipart/mixed; boundary="===============1817925350=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114235704.CyQijGmCB9KBa0BLBX8amqsnbjtmPwasJadk-S8xC1M@z>

--===============1817925350==
Content-Type: multipart/alternative; boundary="000000000000995e460597573dff"

--000000000000995e460597573dff
Content-Type: text/plain; charset="UTF-8"

Hi Harry,

As suggested I created the issue here
https://gitlab.freedesktop.org/drm/amd/issues/2 with a picture of the
problem attached.

Please take a look, thx!
Julien


On Mon, Nov 11, 2019 at 1:11 PM Harry Wentland <hwentlan@amd.com> wrote:

> On 2019-10-08 2:15 p.m., Julien Isorce wrote:
> > Hi Harry,
> >
> > I can reproduce on LG, Samsung and NEC monitors.
> >
> > "Have you checked whether the driver picks RGB or YCBCR420 without your
> > patch?" -> it was selecting RGB .
> >
> > For example on https://commons.wikimedia.org/wiki/File:Gray_scale.jpg ,
> > the second band from the left, will be entirely pinkish.
> > Since the issue also happens without dongle, so with a direct cable from
> > the miniDP from the graphic card to DisplayPort on the screen I think
> > there is more serious issue with RGB output in amdgpu. But it is not
> > easy to reproduce, you should try on above image.
> >
>
> I haven't had time to repro this issue. Can you post a picture of this
> problem somewhere? Ideally with a bug description at
> https://gitlab.freedesktop.org/drm/amd/issues
>
> > In any case, the goal with the patch is just to get the same output when
> > using 2 screens at the same time, one connected to hdmi output of the
> > graphic card and one connected  to usb-c to graphic card (hdmi cable
> > with dongle). So prior this patch, the first one would use YCbCr 444 and
> > the second would use RGB.
> > After this patch, both will use YCbCr 444 (both are hdmi).
>
> I've been hesitant about this patch since it changes driver policy which
> is not something I like to do without very good reason and understanding
> all the implications.
>
> That said, treating an DP-HDMI adapter like a native HDMI connection
> rather than DP is not unreasonable. I'm still curious, though, why this
> is required at all. As mentioned above a picture of the problem (ideally
> showing the monitors side-by-side) would help.
>
> Harry
>
>
> > The patch does not change the case for miniDP to DisplayPort, the driver
> > will still use RGB. Because maybe the RGB issue is also specific to that
> > graphic card which
> > is VEGA"M". So that is why the patch only tries to match hdmi cases
> > together, whether it is direct connection or through usb-c.
> >
> > -
> > Julien
> >
> >
> >
> > On Tue, Oct 8, 2019 at 10:44 AM Harry Wentland <hwentlan@amd.com
> > <mailto:hwentlan@amd.com>> wrote:
> >
> >     Hi Julien,
> >
> >     curious which monitor you're using.
> >
> >     Have you checked whether the driver picks RGB or YCBCR420 without
> your
> >     patch?
> >
> >     I'm not sure I understand how the pinkish color issue looks. Do you
> see
> >     a pinkish color at the transition from grey to another color? Or is
> the
> >     entire grey area pinkish?
> >
> >     Thanks,
> >     Harry
> >
> >     On 2019-10-08 12:06 p.m., Julien Isorce wrote:
> >     > Hi,
> >     >
> >     > Gentle ping ?
> >     >
> >     > Thx
> >     > Julien
> >     >
> >     > On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce
> >     <julien.isorce@gmail.com <mailto:julien.isorce@gmail.com>
> >     > <mailto:julien.isorce@gmail.com <mailto:julien.isorce@gmail.com>>>
> >     wrote:
> >     >
> >     >     Fix pinkish color issue around grey areas. This also happens
> >     >     when not using any dongle so directly with a usb-c to Display
> >     >     Port cable. Meaning there is something wrong when using pixel
> >     >     encoding RGB with amd driver in the general case. In the
> meantime
> >     >     just use the same pixel encoding as when using HDMI without
> >     dongle.
> >     >     This way users will see the same thing on 2 identical screens
> when
> >     >     one is connected with hdmi-to-hdmi and the other is connected
> with
> >     >     usb-c-to-hdmi.
> >     >
> >     >     Signed-off-by: Julien Isorce <jisorce@oblong.com
> >     <mailto:jisorce@oblong.com>
> >     >     <mailto:jisorce@oblong.com <mailto:jisorce@oblong.com>>>
> >     >     ---
> >     >      drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
> >     >      1 file changed, 5 insertions(+)
> >     >
> >     >     diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     >     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     >     index d3f404f097eb..8139dcc0bfba 100644
> >     >     --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     >     +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     >     @@ -3313,6 +3313,7 @@ static void
> >     >     fill_stream_properties_from_drm_display_mode(
> >     >      {
> >     >             struct dc_crtc_timing *timing_out = &stream->timing;
> >     >             const struct drm_display_info *info =
> >     &connector->display_info;
> >     >     +       const struct dc_link *link = stream->sink->link;
> >     >
> >     >             memset(timing_out, 0, sizeof(struct dc_crtc_timing));
> >     >
> >     >     @@ -3327,6 +3328,10 @@ static void
> >     >     fill_stream_properties_from_drm_display_mode(
> >     >             else if ((connector->display_info.color_formats &
> >     >     DRM_COLOR_FORMAT_YCRCB444)
> >     >                             && stream->signal ==
> >     SIGNAL_TYPE_HDMI_TYPE_A)
> >     >                     timing_out->pixel_encoding =
> >     PIXEL_ENCODING_YCBCR444;
> >     >     +       else if ((connector->display_info.color_formats &
> >     >     DRM_COLOR_FORMAT_YCRCB444)
> >     >     +                       && stream->sink->sink_signal ==
> >     >     SIGNAL_TYPE_DISPLAY_PORT
> >     >     +                       && link->dpcd_caps.dongle_type ==
> >     >     DISPLAY_DONGLE_DP_HDMI_CONVERTER)
> >     >     +               timing_out->pixel_encoding =
> >     PIXEL_ENCODING_YCBCR444;
> >     >             else
> >     >                     timing_out->pixel_encoding =
> PIXEL_ENCODING_RGB;
> >     >
> >     >     --
> >     >     2.17.1
> >     >
> >     >
> >     > _______________________________________________
> >     > amd-gfx mailing list
> >     > amd-gfx@lists.freedesktop.org <mailto:
> amd-gfx@lists.freedesktop.org>
> >     > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >     >
> >
>

--000000000000995e460597573dff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Harry,<div><br></div><div>As suggested I created the is=
sue here=C2=A0<a href=3D"https://gitlab.freedesktop.org/drm/amd/issues/2">h=
ttps://gitlab.freedesktop.org/drm/amd/issues/2</a> with a picture of the pr=
oblem attached.</div><div><br></div><div>Please take a look, thx!</div><div=
>Julien</div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Nov 11, 2019 at 1:11 PM Harry Wentlan=
d &lt;<a href=3D"mailto:hwentlan@amd.com">hwentlan@amd.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2019-10-08 2:1=
5 p.m., Julien Isorce wrote:<br>
&gt; Hi Harry,<br>
&gt; <br>
&gt; I can reproduce on LG, Samsung and NEC monitors.<br>
&gt; <br>
&gt; &quot;Have you checked whether the driver picks RGB or YCBCR420 withou=
t your<br>
&gt; patch?&quot; -&gt; it was selecting RGB .<br>
&gt; <br>
&gt; For example on <a href=3D"https://commons.wikimedia.org/wiki/File:Gray=
_scale.jpg" rel=3D"noreferrer" target=3D"_blank">https://commons.wikimedia.=
org/wiki/File:Gray_scale.jpg</a> ,<br>
&gt; the second band from the left, will be entirely pinkish.<br>
&gt; Since the issue also happens without dongle, so with a direct cable fr=
om<br>
&gt; the miniDP from the graphic card to DisplayPort on the screen I think<=
br>
&gt; there is more serious issue with RGB output in amdgpu. But it is not<b=
r>
&gt; easy to reproduce, you should try on above image.<br>
&gt; <br>
<br>
I haven&#39;t had time to repro this issue. Can you post a picture of this<=
br>
problem somewhere? Ideally with a bug description at<br>
<a href=3D"https://gitlab.freedesktop.org/drm/amd/issues" rel=3D"noreferrer=
" target=3D"_blank">https://gitlab.freedesktop.org/drm/amd/issues</a><br>
<br>
&gt; In any case, the goal with the patch is just to get the same output wh=
en<br>
&gt; using 2 screens at the same time, one connected to hdmi output of the<=
br>
&gt; graphic card and one connected=C2=A0 to usb-c to graphic card (hdmi ca=
ble<br>
&gt; with dongle). So prior this patch, the first one would use YCbCr 444 a=
nd<br>
&gt; the second would use RGB.<br>
&gt; After this patch, both will use=C2=A0YCbCr 444 (both are hdmi).<br>
<br>
I&#39;ve been hesitant about this patch since it changes driver policy whic=
h<br>
is not something I like to do without very good reason and understanding<br=
>
all the implications.<br>
<br>
That said, treating an DP-HDMI adapter like a native HDMI connection<br>
rather than DP is not unreasonable. I&#39;m still curious, though, why this=
<br>
is required at all. As mentioned above a picture of the problem (ideally<br=
>
showing the monitors side-by-side) would help.<br>
<br>
Harry<br>
<br>
<br>
&gt; The patch does not change the case for miniDP to DisplayPort, the driv=
er<br>
&gt; will still use RGB. Because maybe the RGB issue is also specific to th=
at<br>
&gt; graphic card which<br>
&gt; is=C2=A0VEGA&quot;M&quot;. So that is why the patch only tries to matc=
h hdmi cases<br>
&gt; together, whether it is direct connection or through usb-c.<br>
&gt; <br>
&gt; -<br>
&gt; Julien<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Tue, Oct 8, 2019 at 10:44 AM Harry Wentland &lt;<a href=3D"mailto:h=
wentlan@amd.com" target=3D"_blank">hwentlan@amd.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:hwentlan@amd.com" target=3D"_blank">hwent=
lan@amd.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Julien,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0curious which monitor you&#39;re using.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Have you checked whether the driver picks RGB or YC=
BCR420 without your<br>
&gt;=C2=A0 =C2=A0 =C2=A0patch?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m not sure I understand how the pinkish color=
 issue looks. Do you see<br>
&gt;=C2=A0 =C2=A0 =C2=A0a pinkish color at the transition from grey to anot=
her color? Or is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0entire grey area pinkish?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Harry<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2019-10-08 12:06 p.m., Julien Isorce wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Gentle ping ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thx<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Julien<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:julien.isorce@gmail.com" targ=
et=3D"_blank">julien.isorce@gmail.com</a> &lt;mailto:<a href=3D"mailto:juli=
en.isorce@gmail.com" target=3D"_blank">julien.isorce@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;mailto:<a href=3D"mailto:julien.isorce@gma=
il.com" target=3D"_blank">julien.isorce@gmail.com</a> &lt;mailto:<a href=3D=
"mailto:julien.isorce@gmail.com" target=3D"_blank">julien.isorce@gmail.com<=
/a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Fix pinkish color issue aro=
und grey areas. This also happens<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0when not using any dongle s=
o directly with a usb-c to Display<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Port cable. Meaning there i=
s something wrong when using pixel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0encoding RGB with amd drive=
r in the general case. In the meantime<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0just use the same pixel enc=
oding as when using HDMI without<br>
&gt;=C2=A0 =C2=A0 =C2=A0dongle.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0This way users will see the=
 same thing on 2 identical screens when<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0one is connected with hdmi-=
to-hdmi and the other is connected with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0usb-c-to-hdmi.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Julien Isorc=
e &lt;<a href=3D"mailto:jisorce@oblong.com" target=3D"_blank">jisorce@oblon=
g.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jisorce@oblong.com" ta=
rget=3D"_blank">jisorce@oblong.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:jisorce@oblong.com" target=3D"_blank">jisorce@oblong.com</a> &lt;mailto:<=
a href=3D"mailto:jisorce@oblong.com" target=3D"_blank">jisorce@oblong.com</=
a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0drivers/gpu/drm/amd/d=
isplay/amdgpu_dm/amdgpu_dm.c | 5 +++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 5 ins=
ertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/gpu/dr=
m/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/amd/displ=
ay/amdgpu_dm/amdgpu_dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0index d3f404f097eb..8139dcc=
0bfba 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/gpu/drm/amd/d=
isplay/amdgpu_dm/amdgpu_dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/gpu/drm/amd/d=
isplay/amdgpu_dm/amdgpu_dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -3313,6 +3313,7 @@ stati=
c void<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0fill_stream_properties_from=
_drm_display_mode(<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 struct dc_crtc_timing *timing_out =3D &amp;stream-&gt;timing;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const struct drm_display_info *info =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;connector-&gt;display_info;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0const struct dc_link *link =3D stream-&gt;sink-&gt;link;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 memset(timing_out, 0, sizeof(struct dc_crtc_timing));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -3327,6 +3328,10 @@ stat=
ic void<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0fill_stream_properties_from=
_drm_display_mode(<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 else if ((connector-&gt;display_info.color_formats &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0DRM_COLOR_FORMAT_YCRCB444)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; stream-=
&gt;signal =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0SIGNAL_TYPE_HDMI_TYPE_A)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timing_out-&gt;pixel_encoding =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0PIXEL_ENCODING_YCBCR444;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0else if ((connector-&gt;display_info.color_formats &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0DRM_COLOR_FORMAT_YCRCB444)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; strea=
m-&gt;sink-&gt;sink_signal =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0SIGNAL_TYPE_DISPLAY_PORT<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; link-=
&gt;dpcd_caps.dongle_type =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0DISPLAY_DONGLE_DP_HDMI_CONV=
ERTER)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timing_out-&gt;pixel_encoding =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0PIXEL_ENCODING_YCBCR444;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timing_out-&gt;pixel_encoding =3D PIXEL_ENCODI=
NG_RGB;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A02.17.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ______________________________________________=
_<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; amd-gfx mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.or=
g" target=3D"_blank">amd-gfx@lists.freedesktop.org</a> &lt;mailto:<a href=
=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.f=
reedesktop.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.fre=
edesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
</blockquote></div>

--000000000000995e460597573dff--

--===============1817925350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1817925350==--
