From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix no irq process when evict vram
Date: Wed, 13 Dec 2017 13:00:18 +0000
Message-ID: <CAHbf0-Eb9t=DLzfxy-JBWC2FBmQdUiTGQeXt1rtgV_HZVg21jg@mail.gmail.com>
References: <1513136263-9908-1-git-send-email-yttao@amd.com>
 <CAHbf0-HJr=5UJ0rnNvuURQoT8Ze6JnZkc8-_7ysoopUyBPXzwA@mail.gmail.com>
 <DM3PR1201MB10408E304E474668C12560BBE5350@DM3PR1201MB1040.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1473382082=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM3PR1201MB10408E304E474668C12560BBE5350-BBcFnVpqZhWvVYYlwACKW2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1473382082==
Content-Type: multipart/alternative; boundary="94eb2c0772aa11848d0560385a90"

--94eb2c0772aa11848d0560385a90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm hoping this fixes the slow shutdown time of my laptop, which seems to
switch the card back on right before switching off

It's been an issue since the introduction of KIQ (around the same time)

On Wed, 13 Dec 2017 at 12:07 Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi  Lothian
>
>
>
>
>
> First of all, thanks for your review.
>
>
>
> No, it is the patch which achieve the same function for the issue. But it
> is the root cause of fence timeout.
>
> The patch b9141cd3
> <https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.16-wip&=
id=3Db9141cd3930e390f156739829ca9589fda7926e4> is
> the word-around for the issue. And I think the varible =E2=80=9Cshutdown=
=E2=80=9D
> assignment is better to be located after amdgpu_fini() to ensure no irq
> miss.
>
>
>
> Best Regards
>
> Yintian Tao
>
>
>
>
>
> *From:* Mike Lothian [mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org]
> *Sent:* Wednesday, December 13, 2017 7:23 PM
> *To:* Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amdgpu: Fix no irq process when evict vram
>
>
>
> Is this a follow on to
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.16-wip&i=
d=3Db9141cd3930e390f156739829ca9589fda7926e4
>
>
>
>
> On Wed, 13 Dec 2017 at 07:11 Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org> wrote:
>
> When unload amdgpu driver we use sdma to evict vram but there is no
> irq process after sdma completed work which raises that waiting for the
> fence costs 2s which will trigger VFLR under SRIOV and at last make
> unload driver failed.The reason is that the shutdown varible in adev
> is set to true before evict vram, it cause ISR directly return without
> processing.Therefore, we need set the varible after evict vram.
>
> Change-Id: I7bf75481aa0744b99c41672b49670adc70b478bd
> Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a269bbc..80934ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2458,7 +2458,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         int r;
>
>         DRM_INFO("amdgpu: finishing device.\n");
> -       adev->shutdown =3D true;
>         if (adev->mode_info.mode_config_initialized)
>                 drm_crtc_force_disable_all(adev->ddev);
>
> @@ -2466,6 +2465,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         amdgpu_fence_driver_fini(adev);
>         amdgpu_fbdev_fini(adev);
>         r =3D amdgpu_fini(adev);
> +       adev->shutdown =3D true;
>         if (adev->firmware.gpu_info_fw) {
>                 release_firmware(adev->firmware.gpu_info_fw);
>                 adev->firmware.gpu_info_fw =3D NULL;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--94eb2c0772aa11848d0560385a90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m hoping this fixes the slow shutdown time of my lap=
top, which seems to switch the card back on right before switching off<div>=
<br></div><div>It&#39;s been an issue since the introduction of KIQ (around=
 the same time)</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Wed, 13 Dec 2017 at 12:07 Tao, Yintian &lt;<a href=3D"mailto:Yintian.Tao=
@amd.com">Yintian.Tao-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-3629717190469819022WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Hi=C2=A0 Lothian<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">First of all, thanks for your review.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">No, it is the patch which achieve the=
 same function for the issue. But it is the root cause of fence timeout.<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:.25in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1f497d">The patch
</span><span style=3D"font-size:9.0pt;font-family:&quot;Courier New&quot;;c=
olor:#333333"><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?=
h=3Ddrm-next-4.16-wip&amp;id=3Db9141cd3930e390f156739829ca9589fda7926e4" ta=
rget=3D"_blank"><span style=3D"text-decoration:none">b9141cd3</span></a>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:#1f497d">is the word-around for the issue. And I think the var=
ible =E2=80=9Cshutdown=E2=80=9D assignment is better to be located after am=
dgpu_fini() to ensure no irq miss.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Best Regards<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Yintian Tao<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Mike Lothian [mailto:<a href=
=3D"mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org" target=3D"_blank">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>]
<br>
<b>Sent:</b> Wednesday, December 13, 2017 7:23 PM<br>
<b>To:</b> Tao, Yintian &lt;<a href=3D"mailto:Yintian.Tao-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Yintian.Tao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix no irq process when evict vram<=
u></u><u></u></span></p></div></div><div lang=3D"EN-US" link=3D"blue" vlink=
=3D"purple"><div class=3D"m_-3629717190469819022WordSection1">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Is this a follow on to=C2=A0<a href=3D"https://cgit.=
freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.16-wip&amp;id=3Db9141cd=
3930e390f156739829ca9589fda7926e4" target=3D"_blank">https://cgit.freedeskt=
op.org/~agd5f/linux/commit/?h=3Ddrm-next-4.16-wip&amp;id=3Db9141cd3930e390f=
156739829ca9589fda7926e4</a>=C2=A0<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Wed, 13 Dec 2017 at 07:11 Yintian Tao &lt;<a href=
=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">yttao-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<u>=
</u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<p class=3D"MsoNormal">When unload amdgpu driver we use sdma to evict vram =
but there is no<br>
irq process after sdma completed work which raises that waiting for the<br>
fence costs 2s which will trigger VFLR under SRIOV and at last make<br>
unload driver failed.The reason is that the shutdown varible in adev<br>
is set to true before evict vram, it cause ISR directly return without<br>
processing.Therefore, we need set the varible after evict vram.<br>
<br>
Change-Id: I7bf75481aa0744b99c41672b49670adc70b478bd<br>
Signed-off-by: Yintian Tao &lt;<a href=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org" target=3D"_=
blank">yttao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a269bbc..80934ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2458,7 +2458,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_INFO(&quot;amdgpu: finishing device.\n&quot=
;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;shutdown =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;mode_info.mode_config_initialized)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_crtc_force_disa=
ble_all(adev-&gt;ddev);<br>
<br>
@@ -2466,6 +2465,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_fence_driver_fini(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_fbdev_fini(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_fini(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;shutdown =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;firmware.gpu_info_fw) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_firmware(ad=
ev-&gt;firmware.gpu_info_fw);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;firmware.g=
pu_info_fw =3D NULL;<br>
--<br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><u></=
u><u></u></p>
</blockquote>
</div>
</div></div></blockquote></div>

--94eb2c0772aa11848d0560385a90--

--===============1473382082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1473382082==--
