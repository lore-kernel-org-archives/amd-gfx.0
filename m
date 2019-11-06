Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E1CC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 05:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0AE217D7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 05:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0AE217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9916E170;
	Wed,  6 Nov 2019 05:08:05 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F346E170
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 05:08:04 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id w6so8838700ybj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2019 21:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qy4+GdQ1ZQ7PRRMOuGT2s18/P/YdlCroj7vpMPAi9xE=;
 b=IUzFp5aq01Biw8mOjkKW/EdggLPiDqTn1UVQSZkZL4X/aJgGTNJ8wfT4UkczE3z8fP
 oOVOecP2AvHGnVlqs/AaZeyYbNfuLjvO9cTB8nJRTsPNHzSFjUNvGNOk7jnSGCHkviSJ
 FU9jED280QBNW8NubX3VCA7fHrTUlov/PqgYToKJuvMNcdUClMH9YdDapVm3IuDplHcj
 KnK7eZamGvdRnTc8tpBmVYZihxYErTPBROagTLskPMn/iSYQdE77TZn9j1kd+FhHW3tU
 qY/WQvOPCDFUTyNTHBrFn0at5qGoovFycQdi6q2Mq6e8kc1a0Y/C8ZoRJgTj69iEyD43
 zC1A==
X-Gm-Message-State: APjAAAX8k51O5QMhVQ/8ae7S2LXsVSnr3lHOqABfW27SFZeSdmh4uCq+
 KZumor9hPXACdGJjfXquQh9+riKoM2zM0lYzigkLYRnK
X-Google-Smtp-Source: APXvYqzJ1wlZbiyfBs33NfJPNXkAdAkFqDo3zbTvFtTMmR28pXlvb9FKo+JhF/+yF0AcOD/mjoyupAF+d7vCf3t5ikE=
X-Received: by 2002:a25:14d6:: with SMTP id 205mr608681ybu.230.1573016882958; 
 Tue, 05 Nov 2019 21:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20191001222123.2392-1-jisorce@oblong.com>
 <CAHWPjbWcdhnewEN8OEUgDu5aBpYBW5tUggA_KJ_BUR8JLvCsQw@mail.gmail.com>
 <4610d814-6c54-982e-ecc6-716cc42b5e68@amd.com>
 <CAHWPjbXPL9NsT0yXb8_wkodT18TEBcgf81tY49GP+U=SGZ26YQ@mail.gmail.com>
In-Reply-To: <CAHWPjbXPL9NsT0yXb8_wkodT18TEBcgf81tY49GP+U=SGZ26YQ@mail.gmail.com>
From: Julien Isorce <julien.isorce@gmail.com>
Date: Tue, 5 Nov 2019 21:07:51 -0800
Message-ID:
 <CAHWPjbUOnSeYhAVi0BYZNb6SEq3ud8CpdJAjqB1iQvMNTHiQBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use pixel encoding 444 for dongle usb-c
 to hdmi
To: Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=Qy4+GdQ1ZQ7PRRMOuGT2s18/P/YdlCroj7vpMPAi9xE=;
 b=GJtHWwtgztUbGJ5CHM83ZO0Daf2n5FJbzf0MrsHlJFfg+r9vFSGO5MZmYQ6lGz2MOT
 qxxrVKRrj3Ap+Ieot/d4OtYGv7+/cjTb4BvVQVtjOJ+k8Z8sOXJilkppGT/ul0lz+ZRd
 hbRzEKeh5oiNqkM9h9VVbtrnOULWcXuWCIzWSbQKevsxR3qDx87gdNUuotPfkNy3ZEwc
 Qeik/bKNXtwVLkZCRbWNhOEEncoo+2Ou2fZZieY4ETsxiyYp20j+1LTn0iqHSaVAzmW2
 m4azQLjbkU6HLEjeQWl51ji9Fz7fdGGtN+LqhgbCN7jiaoym+v8M6ndpnpDnYYLQXzfW
 wNOQ==
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1722581037=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106050751.KCKvSlz7k-rsU7riz0ynCwQuJ6ZzwZqQ-ATCLGEdr8E@z>

--===============1722581037==
Content-Type: multipart/alternative; boundary="00000000000088d6270596a688e4"

--00000000000088d6270596a688e4
Content-Type: text/plain; charset="UTF-8"

Hi, gentle ping ? Thx in advance.

On Tue, Oct 8, 2019 at 11:15 AM Julien Isorce <julien.isorce@gmail.com>
wrote:

> Hi Harry,
>
> I can reproduce on LG, Samsung and NEC monitors.
>
> "Have you checked whether the driver picks RGB or YCBCR420 without your
> patch?" -> it was selecting RGB .
>
> For example on https://commons.wikimedia.org/wiki/File:Gray_scale.jpg ,
> the second band from the left, will be entirely pinkish.
> Since the issue also happens without dongle, so with a direct cable from
> the miniDP from the graphic card to DisplayPort on the screen I think there
> is more serious issue with RGB output in amdgpu. But it is not easy to
> reproduce, you should try on above image.
>
> In any case, the goal with the patch is just to get the same output when
> using 2 screens at the same time, one connected to hdmi output of the
> graphic card and one connected  to usb-c to graphic card (hdmi cable with
> dongle). So prior this patch, the first one would use YCbCr 444 and the
> second would use RGB.
> After this patch, both will use YCbCr 444 (both are hdmi).
> The patch does not change the case for miniDP to DisplayPort, the driver
> will still use RGB. Because maybe the RGB issue is also specific to that
> graphic card which
> is VEGA"M". So that is why the patch only tries to match hdmi cases
> together, whether it is direct connection or through usb-c.
>
> -
> Julien
>
>
>
> On Tue, Oct 8, 2019 at 10:44 AM Harry Wentland <hwentlan@amd.com> wrote:
>
>> Hi Julien,
>>
>> curious which monitor you're using.
>>
>> Have you checked whether the driver picks RGB or YCBCR420 without your
>> patch?
>>
>> I'm not sure I understand how the pinkish color issue looks. Do you see
>> a pinkish color at the transition from grey to another color? Or is the
>> entire grey area pinkish?
>>
>> Thanks,
>> Harry
>>
>> On 2019-10-08 12:06 p.m., Julien Isorce wrote:
>> > Hi,
>> >
>> > Gentle ping ?
>> >
>> > Thx
>> > Julien
>> >
>> > On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce <julien.isorce@gmail.com
>> > <mailto:julien.isorce@gmail.com>> wrote:
>> >
>> >     Fix pinkish color issue around grey areas. This also happens
>> >     when not using any dongle so directly with a usb-c to Display
>> >     Port cable. Meaning there is something wrong when using pixel
>> >     encoding RGB with amd driver in the general case. In the meantime
>> >     just use the same pixel encoding as when using HDMI without dongle.
>> >     This way users will see the same thing on 2 identical screens when
>> >     one is connected with hdmi-to-hdmi and the other is connected with
>> >     usb-c-to-hdmi.
>> >
>> >     Signed-off-by: Julien Isorce <jisorce@oblong.com
>> >     <mailto:jisorce@oblong.com>>
>> >     ---
>> >      drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>> >      1 file changed, 5 insertions(+)
>> >
>> >     diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> >     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> >     index d3f404f097eb..8139dcc0bfba 100644
>> >     --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> >     +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> >     @@ -3313,6 +3313,7 @@ static void
>> >     fill_stream_properties_from_drm_display_mode(
>> >      {
>> >             struct dc_crtc_timing *timing_out = &stream->timing;
>> >             const struct drm_display_info *info =
>> &connector->display_info;
>> >     +       const struct dc_link *link = stream->sink->link;
>> >
>> >             memset(timing_out, 0, sizeof(struct dc_crtc_timing));
>> >
>> >     @@ -3327,6 +3328,10 @@ static void
>> >     fill_stream_properties_from_drm_display_mode(
>> >             else if ((connector->display_info.color_formats &
>> >     DRM_COLOR_FORMAT_YCRCB444)
>> >                             && stream->signal ==
>> SIGNAL_TYPE_HDMI_TYPE_A)
>> >                     timing_out->pixel_encoding =
>> PIXEL_ENCODING_YCBCR444;
>> >     +       else if ((connector->display_info.color_formats &
>> >     DRM_COLOR_FORMAT_YCRCB444)
>> >     +                       && stream->sink->sink_signal ==
>> >     SIGNAL_TYPE_DISPLAY_PORT
>> >     +                       && link->dpcd_caps.dongle_type ==
>> >     DISPLAY_DONGLE_DP_HDMI_CONVERTER)
>> >     +               timing_out->pixel_encoding =
>> PIXEL_ENCODING_YCBCR444;
>> >             else
>> >                     timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
>> >
>> >     --
>> >     2.17.1
>> >
>> >
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> >
>>
>

--00000000000088d6270596a688e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, gentle ping ? Thx in advance.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 8, 2019 =
at 11:15 AM Julien Isorce &lt;<a href=3D"mailto:julien.isorce@gmail.com">ju=
lien.isorce@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">Hi Harry,<div><br></div><div>I can re=
produce on LG, Samsung and NEC monitors.</div><div><br></div><div>&quot;Hav=
e you checked whether the driver picks RGB or YCBCR420 without your<br>patc=
h?&quot; -&gt; it was selecting RGB .<br></div><div><br></div><div>For exam=
ple on <a href=3D"https://commons.wikimedia.org/wiki/File:Gray_scale.jpg" t=
arget=3D"_blank">https://commons.wikimedia.org/wiki/File:Gray_scale.jpg</a>=
 , the second band from the left, will be entirely pinkish.<br></div><div>S=
ince the issue also happens without dongle, so with a direct cable from the=
 miniDP from the graphic card to DisplayPort on the screen I think there is=
 more serious issue with RGB output in amdgpu. But it is not easy to reprod=
uce, you should try on above image.</div><div><br></div><div>In any case, t=
he goal with the patch is just to get the same output when using 2 screens =
at the same time, one connected to hdmi output of the graphic card and one =
connected=C2=A0 to usb-c to graphic card (hdmi cable with dongle). So prior=
 this patch, the first one would use YCbCr 444 and the second would use RGB=
.</div><div>After this patch, both will use=C2=A0YCbCr 444 (both are hdmi).=
</div><div>The patch does not change the case for miniDP to DisplayPort, th=
e driver will still use RGB. Because maybe the RGB issue is also specific t=
o that graphic card which</div><div>is=C2=A0VEGA&quot;M&quot;. So that is w=
hy the patch only tries to match hdmi cases together, whether it is direct =
connection or through usb-c.</div><div><br></div><div>-</div><div>Julien</d=
iv><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 8, 2019 at 10:44 AM Harry Went=
land &lt;<a href=3D"mailto:hwentlan@amd.com" target=3D"_blank">hwentlan@amd=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi Julien,<br>
<br>
curious which monitor you&#39;re using.<br>
<br>
Have you checked whether the driver picks RGB or YCBCR420 without your<br>
patch?<br>
<br>
I&#39;m not sure I understand how the pinkish color issue looks. Do you see=
<br>
a pinkish color at the transition from grey to another color? Or is the<br>
entire grey area pinkish?<br>
<br>
Thanks,<br>
Harry<br>
<br>
On 2019-10-08 12:06 p.m., Julien Isorce wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Gentle ping ?<br>
&gt; <br>
&gt; Thx<br>
&gt; Julien<br>
&gt; <br>
&gt; On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce &lt;<a href=3D"mailto:jul=
ien.isorce@gmail.com" target=3D"_blank">julien.isorce@gmail.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:julien.isorce@gmail.com" target=3D"_blank=
">julien.isorce@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Fix pinkish color issue around grey areas. This als=
o happens<br>
&gt;=C2=A0 =C2=A0 =C2=A0when not using any dongle so directly with a usb-c =
to Display<br>
&gt;=C2=A0 =C2=A0 =C2=A0Port cable. Meaning there is something wrong when u=
sing pixel<br>
&gt;=C2=A0 =C2=A0 =C2=A0encoding RGB with amd driver in the general case. I=
n the meantime<br>
&gt;=C2=A0 =C2=A0 =C2=A0just use the same pixel encoding as when using HDMI=
 without dongle.<br>
&gt;=C2=A0 =C2=A0 =C2=A0This way users will see the same thing on 2 identic=
al screens when<br>
&gt;=C2=A0 =C2=A0 =C2=A0one is connected with hdmi-to-hdmi and the other is=
 connected with<br>
&gt;=C2=A0 =C2=A0 =C2=A0usb-c-to-hdmi.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Julien Isorce &lt;<a href=3D"mailto:=
jisorce@oblong.com" target=3D"_blank">jisorce@oblong.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jisorce@oblong.com" ta=
rget=3D"_blank">jisorce@oblong.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c | 5 +++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 5 insertions(+)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0index d3f404f097eb..8139dcc0bfba 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -3313,6 +3313,7 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0fill_stream_properties_from_drm_display_mode(<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc_crtc_timing *=
timing_out =3D &amp;stream-&gt;timing;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct drm_displa=
y_info *info =3D &amp;connector-&gt;display_info;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct dc_link *l=
ink =3D stream-&gt;sink-&gt;link;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(timing_out, 0, s=
izeof(struct dc_crtc_timing));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -3327,6 +3328,10 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0fill_stream_properties_from_drm_display_mode(<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((connector-&gt=
;display_info.color_formats &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRM_COLOR_FORMAT_YCRCB444)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; stream-&gt;signal =3D=3D SIGN=
AL_TYPE_HDMI_TYPE_A)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 timing_out-&gt;pixel_encoding =3D PIXEL_ENCODING_YCBCR444;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0else if ((connector-&gt=
;display_info.color_formats &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRM_COLOR_FORMAT_YCRCB444)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; stream-&gt;sink-&gt;sink_signa=
l =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0SIGNAL_TYPE_DISPLAY_PORT<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; link-&gt;dpcd_caps.dongle_type=
 =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0DISPLAY_DONGLE_DP_HDMI_CONVERTER)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0timing_out-&gt;pixel_encoding =3D PIXEL_ENCODING_YCBCR444;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 timing_out-&gt;pixel_encoding =3D PIXEL_ENCODING_RGB;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.17.1<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
&gt; <br>
</blockquote></div>
</blockquote></div></div>

--00000000000088d6270596a688e4--

--===============1722581037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1722581037==--
