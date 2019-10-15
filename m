From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Use pixel encoding 444 for dongle usb-c
 to hdmi
Date: Tue, 15 Oct 2019 15:01:11 -0700
Message-ID: <CAHWPjbVfQO-Kx2wnYSUgdZug_5K3SwjdrU3uT4ziCy1R4+cBRA@mail.gmail.com>
References: <20191001222123.2392-1-jisorce@oblong.com>
 <CAHWPjbWcdhnewEN8OEUgDu5aBpYBW5tUggA_KJ_BUR8JLvCsQw@mail.gmail.com>
 <4610d814-6c54-982e-ecc6-716cc42b5e68@amd.com>
 <CAHWPjbXPL9NsT0yXb8_wkodT18TEBcgf81tY49GP+U=SGZ26YQ@mail.gmail.com>
 <CAHWPjbXH=GYR55+3i1FXF6XcvgGP5ngiSZGOkNuoCt4JPVVp0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0845970898=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHWPjbXH=GYR55+3i1FXF6XcvgGP5ngiSZGOkNuoCt4JPVVp0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>

--===============0845970898==
Content-Type: multipart/alternative; boundary="000000000000f05d520594fa1f85"

--000000000000f05d520594fa1f85
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping ?

Thx
Julien

On Fri, Oct 11, 2019 at 12:31 PM Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi Harry,
>
> Do you need more information ?
>
> Thx
> Julien
>
> On Tue, Oct 8, 2019 at 11:15 AM Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> Hi Harry,
>>
>> I can reproduce on LG, Samsung and NEC monitors.
>>
>> "Have you checked whether the driver picks RGB or YCBCR420 without your
>> patch?" -> it was selecting RGB .
>>
>> For example on https://commons.wikimedia.org/wiki/File:Gray_scale.jpg ,
>> the second band from the left, will be entirely pinkish.
>> Since the issue also happens without dongle, so with a direct cable from
>> the miniDP from the graphic card to DisplayPort on the screen I think there
>> is more serious issue with RGB output in amdgpu. But it is not easy to
>> reproduce, you should try on above image.
>>
>> In any case, the goal with the patch is just to get the same output when
>> using 2 screens at the same time, one connected to hdmi output of the
>> graphic card and one connected  to usb-c to graphic card (hdmi cable with
>> dongle). So prior this patch, the first one would use YCbCr 444 and the
>> second would use RGB.
>> After this patch, both will use YCbCr 444 (both are hdmi).
>> The patch does not change the case for miniDP to DisplayPort, the driver
>> will still use RGB. Because maybe the RGB issue is also specific to that
>> graphic card which
>> is VEGA"M". So that is why the patch only tries to match hdmi cases
>> together, whether it is direct connection or through usb-c.
>>
>> -
>> Julien
>>
>>
>>
>> On Tue, Oct 8, 2019 at 10:44 AM Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org> wrote:
>>
>>> Hi Julien,
>>>
>>> curious which monitor you're using.
>>>
>>> Have you checked whether the driver picks RGB or YCBCR420 without your
>>> patch?
>>>
>>> I'm not sure I understand how the pinkish color issue looks. Do you see
>>> a pinkish color at the transition from grey to another color? Or is the
>>> entire grey area pinkish?
>>>
>>> Thanks,
>>> Harry
>>>
>>> On 2019-10-08 12:06 p.m., Julien Isorce wrote:
>>> > Hi,
>>> >
>>> > Gentle ping ?
>>> >
>>> > Thx
>>> > Julien
>>> >
>>> > On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>> > <mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>> >
>>> >     Fix pinkish color issue around grey areas. This also happens
>>> >     when not using any dongle so directly with a usb-c to Display
>>> >     Port cable. Meaning there is something wrong when using pixel
>>> >     encoding RGB with amd driver in the general case. In the meantime
>>> >     just use the same pixel encoding as when using HDMI without dongle.
>>> >     This way users will see the same thing on 2 identical screens when
>>> >     one is connected with hdmi-to-hdmi and the other is connected with
>>> >     usb-c-to-hdmi.
>>> >
>>> >     Signed-off-by: Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org
>>> >     <mailto:jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>>
>>> >     ---
>>> >      drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>>> >      1 file changed, 5 insertions(+)
>>> >
>>> >     diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> >     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> >     index d3f404f097eb..8139dcc0bfba 100644
>>> >     --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> >     +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> >     @@ -3313,6 +3313,7 @@ static void
>>> >     fill_stream_properties_from_drm_display_mode(
>>> >      {
>>> >             struct dc_crtc_timing *timing_out = &stream->timing;
>>> >             const struct drm_display_info *info =
>>> &connector->display_info;
>>> >     +       const struct dc_link *link = stream->sink->link;
>>> >
>>> >             memset(timing_out, 0, sizeof(struct dc_crtc_timing));
>>> >
>>> >     @@ -3327,6 +3328,10 @@ static void
>>> >     fill_stream_properties_from_drm_display_mode(
>>> >             else if ((connector->display_info.color_formats &
>>> >     DRM_COLOR_FORMAT_YCRCB444)
>>> >                             && stream->signal ==
>>> SIGNAL_TYPE_HDMI_TYPE_A)
>>> >                     timing_out->pixel_encoding =
>>> PIXEL_ENCODING_YCBCR444;
>>> >     +       else if ((connector->display_info.color_formats &
>>> >     DRM_COLOR_FORMAT_YCRCB444)
>>> >     +                       && stream->sink->sink_signal ==
>>> >     SIGNAL_TYPE_DISPLAY_PORT
>>> >     +                       && link->dpcd_caps.dongle_type ==
>>> >     DISPLAY_DONGLE_DP_HDMI_CONVERTER)
>>> >     +               timing_out->pixel_encoding =
>>> PIXEL_ENCODING_YCBCR444;
>>> >             else
>>> >                     timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
>>> >
>>> >     --
>>> >     2.17.1
>>> >
>>> >
>>> > _______________________________________________
>>> > amd-gfx mailing list
>>> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>> >
>>>
>>

--000000000000f05d520594fa1f85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Gentle ping ?</div><div><br></div><=
div>Thx</div><div>Julien</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Oct 11, 2019 at 12:31 PM Julien Isorc=
e &lt;<a href=3D"mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr">Hi Harry,<div><br></div><div>Do you need more information ?</=
div><div><br></div><div>Thx</div><div>Julien</div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 8, 2019 at 11=
:15 AM Julien Isorce &lt;<a href=3D"mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Harry,<div><br></div=
><div>I can reproduce on LG, Samsung and NEC monitors.</div><div><br></div>=
<div>&quot;Have you checked whether the driver picks RGB or YCBCR420 withou=
t your<br>patch?&quot; -&gt; it was selecting RGB .<br></div><div><br></div=
><div>For example on <a href=3D"https://commons.wikimedia.org/wiki/File:Gra=
y_scale.jpg" target=3D"_blank">https://commons.wikimedia.org/wiki/File:Gray=
_scale.jpg</a> , the second band from the left, will be entirely pinkish.<b=
r></div><div>Since the issue also happens without dongle, so with a direct =
cable from the miniDP from the graphic card to DisplayPort on the screen I =
think there is more serious issue with RGB output in amdgpu. But it is not =
easy to reproduce, you should try on above image.</div><div><br></div><div>=
In any case, the goal with the patch is just to get the same output when us=
ing 2 screens at the same time, one connected to hdmi output of the graphic=
 card and one connected=C2=A0 to usb-c to graphic card (hdmi cable with don=
gle). So prior this patch, the first one would use YCbCr 444 and the second=
 would use RGB.</div><div>After this patch, both will use=C2=A0YCbCr 444 (b=
oth are hdmi).</div><div>The patch does not change the case for miniDP to D=
isplayPort, the driver will still use RGB. Because maybe the RGB issue is a=
lso specific to that graphic card which</div><div>is=C2=A0VEGA&quot;M&quot;=
. So that is why the patch only tries to match hdmi cases together, whether=
 it is direct connection or through usb-c.</div><div><br></div><div>-</div>=
<div>Julien</div><div><br></div><div><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 8, 2019 at 10:44=
 AM Harry Wentland &lt;<a href=3D"mailto:hwentlan-5C7GfCeVMHo@public.gmane.org" target=3D"_blank=
">hwentlan-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Julien,<br>
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
ien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank=
">julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<br>
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
jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org" target=3D"_blank">jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org" ta=
rget=3D"_blank">jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org</a>&gt;&gt;<br>
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
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
&gt; <br>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--000000000000f05d520594fa1f85--

--===============0845970898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0845970898==--
