From: Romain Failliot <romain.failliot-QwMNyP4dB9pWk0Htik3J/w@public.gmane.org>
Subject: Re: [Mesa-dev] [AMD] Screen flickering with 4K and RX 480, would be
 glad to help debugging
Date: Sat, 21 Jan 2017 20:16:56 -0500
Message-ID: <CAGpYYjG-O2Lp3NQ3-XSpUxChQMQO4Phnvq_iBGS3ciWoW3=G+Q@mail.gmail.com>
References: <CAGpYYjGSEAR3VCvaWXQux_94+ek2yqpD7-_Rt0HvUKFke_MQ9g@mail.gmail.com>
 <CAAxE2A7bG9LpRHjrmaPSKKaLkhT2qmU+V6pN2+Qwzt2Sr2bQ=w@mail.gmail.com>
 <CAGpYYjFv0fUgn_RRhS3F7o6d3sAQ0T+GyvPiUdMPU5k6AKacWw@mail.gmail.com>
 <CAAxE2A45o4NYC8KZeZexxJDJrpR6-v1HFdDNcMAifKBg5v4Z4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0200890149=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A45o4NYC8KZeZexxJDJrpR6-v1HFdDNcMAifKBg5v4Z4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0200890149==
Content-Type: multipart/alternative; boundary=001a1145e716c8e9370546a4a47a

--001a1145e716c8e9370546a4a47a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

Here's more info about my rig:

It's a Fedora 25 + mystro256 copr repo (https://copr.fedorainfracloud
.org/coprs/mystro256/polaris-gfx/packages/)
This copr repo brings clang and llvm 3.9.0 as well as mesa 13.0.3

This is the display: https://www.amazon.com/gp/prod
uct/B01CH9ZTI4/ref=3Dod_aui_detailpages00?ie=3DUTF8&psc=3D1
This is the graphics card:
http://www.newegg.ca/Product/Product.aspx?Item=3DN82E16814150774&cm_re=3DXF=
X_Radeon_RS_RX_480_DirectX_12_RX-480P836BM-_-14-150-774-_-Product

Strangely, depending on the kernel I use, the problem can completely
disappear.
I have the problem with the latest kernel: kernel-4.9.4-201.fc25, but not
with the kernel-4.8.15-300.fc25
Fedora kernels are here: https://bodhi.fedoraproject.or
g/updates/?packages=3Dkernel

Thank you very much!
<https://bodhi.fedoraproject.org/updates/FEDORA-2017-252ce2f03f>

2017-01-21 16:38 GMT-05:00 Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> [-mesa-dev, +amd-gfx]
>
> This looks suspicious:
>
> [  780.811943] [drm] dc_pre_update_surfaces_to_stream: commit 1
> surfaces to stream 0x1ade3000
>
> Marek
>
>
> ---------- Forwarded message ----------
> From: Romain Failliot <romain.failliot-QwMNyP4dB9pWk0Htik3J/w@public.gmane.org>
> Date: Sat, Jan 21, 2017 at 9:50 PM
> Subject: Re: [Mesa-dev] [AMD] Screen flickering with 4K and RX 480,
> would be glad to help debugging
> To: Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: mesa-dev <mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>
> Hi!
>
> 2017-01-02 15:10 GMT-05:00 Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >
> > Does dmesg or Xorg.0.log show anything?
>
>
> I don't know if it's really relevant, but here are my `dmesg` and
> `journalctl -b _COMM=3Dgdm-x-session` ('xorg' files) before and after a
> session of Dota.
> I got two glitches and quit Dota right away. The main diff I see is
> between the xorg log, but I don't know if it means anything.
>
> Please see the attached tarball.
>
> Thanks!
>



--=20
Romain "Creak" Failliot

--001a1145e716c8e9370546a4a47a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi!<br><br>Here&#39;s more info about =
my rig:<br><br>It&#39;s a Fedora 25 + mystro256 copr repo (<a href=3D"https=
://copr.fedorainfracloud.org/coprs/mystro256/polaris-gfx/packages/" target=
=3D"_blank">https://copr.fedorainfracloud<wbr>.org/coprs/mystro256/polaris-=
<wbr>gfx/packages/</a>)<br>This copr repo brings clang and llvm 3.9.0 as we=
ll as mesa 13.0.3<br><br>This is the display: <a href=3D"https://www.amazon=
.com/gp/product/B01CH9ZTI4/ref=3Dod_aui_detailpages00?ie=3DUTF8&amp;psc=3D1=
" target=3D"_blank">https://www.amazon.com/gp/prod<wbr>uct/B01CH9ZTI4/ref=
=3Dod_aui_deta<wbr>ilpages00?ie=3DUTF8&amp;psc=3D1</a><br></div>This is the=
 graphics card: <a href=3D"http://www.newegg.ca/Product/Product.aspx?Item=
=3DN82E16814150774&amp;cm_re=3DXFX_Radeon_RS_RX_480_DirectX_12_RX-480P836BM=
-_-14-150-774-_-Product">http://www.newegg.ca/Product/Product.aspx?Item=3DN=
82E16814150774&amp;cm_re=3DXFX_Radeon_RS_RX_480_DirectX_12_RX-480P836BM-_-1=
4-150-774-_-Product</a><br><br></div>Strangely, depending on the kernel I u=
se, the problem can completely disappear.<br></div>I have the problem with =
the latest kernel: kernel-4.9.4-201.fc25, but not with the kernel-4.8.15-30=
0.fc25</div><div>Fedora kernels are here: <a href=3D"https://bodhi.fedorapr=
oject.org/updates/?packages=3Dkernel" target=3D"_blank">https://bodhi.fedor=
aproject.or<wbr>g/updates/?packages=3Dkernel</a><br><br></div><div>Thank yo=
u very much!<br></div><div><a href=3D"https://bodhi.fedoraproject.org/updat=
es/FEDORA-2017-252ce2f03f" target=3D"_blank"></a></div></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">2017-01-21 16:38 GMT-05:00 Mare=
k Ol=C5=A1=C3=A1k <span dir=3D"ltr">&lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">[-mesa-dev, +amd-gfx]<br>
<br>
This looks suspicious:<br>
<br>
[=C2=A0 780.811943] [drm] dc_pre_update_surfaces_to_<wbr>stream: commit 1<b=
r>
surfaces to stream 0x1ade3000<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marek<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
---------- Forwarded message ----------<br>
From: Romain Failliot &lt;<a href=3D"mailto:romain.failliot-QwMNyP4dB9pWk0Htik3J/w@public.gmane.org">r=
omain.failliot-QwMNyP4dB9pWk0Htik3J/w@public.gmane.org</a>&gt;<br>
Date: Sat, Jan 21, 2017 at 9:50 PM<br>
Subject: Re: [Mesa-dev] [AMD] Screen flickering with 4K and RX 480,<br>
would be glad to help debugging<br>
To: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo@gm=
ail.com</a>&gt;<br>
Cc: mesa-dev &lt;<a href=3D"mailto:mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mesa-dev=
@lists.freedesktop.<wbr>org</a>&gt;<br>
<br>
<br>
Hi!<br>
<br>
2017-01-02 15:10 GMT-05:00 Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:mara=
eo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt;<br>
&gt; Does dmesg or Xorg.0.log show anything?<br>
<br>
<br>
I don&#39;t know if it&#39;s really relevant, but here are my `dmesg` and<b=
r>
`journalctl -b _COMM=3Dgdm-x-session` (&#39;xorg&#39; files) before and aft=
er a<br>
session of Dota.<br>
I got two glitches and quit Dota right away. The main diff I see is<br>
between the xorg log, but I don&#39;t know if it means anything.<br>
<br>
Please see the attached tarball.<br>
<br>
Thanks!<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Ro=
main &quot;Creak&quot; Failliot<br></div></div>
</div>

--001a1145e716c8e9370546a4a47a--

--===============0200890149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0200890149==--
