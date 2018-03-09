From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
Date: Fri, 9 Mar 2018 17:53:03 +0000
Message-ID: <CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180308205409.3203-1-alexander.deucher@amd.com>
 <20180308205409.3203-2-alexander.deucher@amd.com>
 <CY4PR12MB1687F2F0D4288F02D750C755FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <b6999bc4-1fae-c293-42f4-2929b08d1821@gmail.com>,
 <CADnq5_PK5K5OYG4HVxKa1wCk-MxtJNaxH83HF9F7RzxkaXai_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0915318943=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PK5K5OYG4HVxKa1wCk-MxtJNaxH83HF9F7RzxkaXai_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0915318943==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 >I also don't really like the fact that we use the module parameter direct=
ly to determine whether to load the >PSP module or not, we should be using =
adev->firmware.load_type, but that doesn't get set until later.

we can move function amdgpu_ucode_get_load_type to amdgpu_check_arguments(a=
dev);
adev->firmware.load_type will be set.

>The problem with checking the module parameter is that that param is gobal=
 so if you you have multiple >GPUs, you may get messed up.

if user set the load type through module parameters, it is valid for all gp=
u.


Best Regards
Rex


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Saturday, March 10, 2018 1:02 AM
To: Koenig, Christian
Cc: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
Subject: Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module

On Fri, Mar 9, 2018 at 2:45 AM, Christian K=F6nig <ckoenig.leichtzumerken@g=
mail.com<mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
Hi Rex,

I think still initializing the PSP even when you don't need it for firmware=
 upload sounds like a good idea to me.

But take that with a grain of salt since I really on don't know that part o=
f the hardware so well.

Right.  We need PSP for GPU resets among other things.  I also don't really=
 like the fact that we use the module parameter directly to determine wheth=
er to load the PSP module or not, we should be using adev->firmware.load_ty=
pe, but that doesn't get set until later.  We should probably just move tha=
t earlier in the common code rather than having it in the soc files.  The p=
roblem with checking the module parameter is that that param is gobal so if=
 you you have multiple GPUs, you may get messed up.

Alex



Christian.


Am 09.03.2018 um 06:10 schrieb Zhu, Rex:

Hi Alex,


How about keep the firmware type checking in set_ip_blocks.

and remove the same check code in psp module.

also no need to change load type if psp load firmware failed in psp module.


Please review the attached patch.


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><=
mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, March 9, 2018 4:54 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander
Subject: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module

We already handle the firmware loading type checks in the
psp module directly, no need for an additional check.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.de=
ucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 8dc8b72ed49b..ecf58a68cf66 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
                 amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
                 amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
                 amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-               if (amdgpu_fw_load_type =3D=3D 2 || amdgpu_fw_load_type =3D=
=3D -1)
-                       amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block=
);
+               amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
                 if (!amdgpu_sriov_vf(adev))
                         amdgpu_device_ip_block_add(adev, &amdgpu_pp_ip_blo=
ck);
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...


amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org<http://lists.freedesktop.org>
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org<http://freedesktop.org> lists is subject to=
 our Code of ...
www<http://freedesktop.org/>
freedesktop.org
Welcome to freedesktop.org. freedesktop.org is open source / open discussio=
n software projects working on interoperability and shared technology for X=
 Window System ...







_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...





--_000_CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;">&nbsp;&gt;I also don't r=
eally like
 the fact that we use the module parameter directly to determine whether to=
 load the &gt;PSP module or not, we should be using adev-&gt;firmware.load_=
type, but that doesn't get set until later.</span><br>
</p>
<br>
we can move function&nbsp;<span>amdgpu_ucode_get_load_type to&nbsp;<span>am=
dgpu_check_arguments(adev);</span></span>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont,=
 &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,=
 &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font=
-size: 16px;">adev-&gt;firmware.load_type will be set.</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont,=
 &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,=
 &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font=
-size: 16px;"><br>
</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont,=
 &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,=
 &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font=
-size: 16px;">&gt;The problem with checking the module parameter is that th=
at
 param is gobal so if you you have multiple &gt;GPUs, you may get messed up=
.</span><br style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont=
, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji=
, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; fon=
t-size: 16px;">
<br>
</div>
<div>if user set the load type through module parameters, it is valid for a=
ll gpu.</div>
<div><br>
</div>
<div>&nbsp;</div>
<div>Best Regards</div>
<div>Rex</div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont,=
 &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,=
 &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font=
-size: 16px;"></span><br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, March 10, 2018 1:02 AM<br>
<b>To:</b> Koenig, Christian<br>
<b>Cc:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP mo=
dule</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">On Fri, Mar 9, 2018 at 2:45 AM, Christian K=F6nig <span di=
r=3D"ltr">&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D=
"_blank" id=3D"LPlnk518351" previewremoved=3D"true">ckoenig.leichtzumerken@=
gmail.com</a>&gt;</span> wrote:<br>
<div class=3D"x_gmail_extra">
<div class=3D"x_gmail_quote">
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"x_gmail-m_-4726930752337344039moz-cite-prefix">Hi Rex,<br>
<br>
I think still initializing the PSP even when you don't need it for firmware=
 upload sounds like a good idea to me.<br>
<br>
But take that with a grain of salt since I really on don't know that part o=
f the hardware so well.<span class=3D"x_gmail-HOEnZb"><font color=3D"#88888=
8"><br>
</font></span></div>
</div>
</blockquote>
<div><br>
</div>
<div>Right.&nbsp; We need PSP for GPU resets among other things.&nbsp; I al=
so don't really like the fact that we use the module parameter directly to =
determine whether to load the PSP module or not, we should be using adev-&g=
t;firmware.load_type, but that doesn't get set
 until later.&nbsp; We should probably just move that earlier in the common=
 code rather than having it in the soc files.&nbsp; The problem with checki=
ng the module parameter is that that param is gobal so if you you have mult=
iple GPUs, you may get messed up.<br>
<br>
</div>
<div>Alex<br>
</div>
<div><br>
&nbsp;</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"x_gmail-m_-4726930752337344039moz-cite-prefix"><span class=3D=
"x_gmail-HOEnZb"><font color=3D"#888888"><br>
Christian.</font></span>
<div>
<div class=3D"x_gmail-h5"><br>
<br>
Am 09.03.2018 um 06:10 schrieb Zhu, Rex:<br>
</div>
</div>
</div>
<div>
<div class=3D"x_gmail-h5">
<blockquote type=3D"cite">
<div id=3D"x_gmail-m_-4726930752337344039divtagdefaultwrapper" dir=3D"ltr" =
style=3D"font-size:12pt; color:rgb(0,0,0); font-family:Calibri,Helvetica,sa=
ns-serif">
<p style=3D"margin-top:0px; margin-bottom:0px">Hi Alex,</p>
<p style=3D"margin-top:0px; margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px; margin-bottom:0px">How about keep the firmware =
type checking in
<font size=3D"2"><span style=3D"font-size:11pt">set_ip_blocks</span></font>=
.</p>
<p style=3D"margin-top:0px; margin-bottom:0px">and remove the same check co=
de in psp module.</p>
<p style=3D"margin-top:0px; margin-bottom:0px">also no need to change load =
type if psp load firmware failed in psp module.</p>
<p style=3D"margin-top:0px; margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px; margin-bottom:0px">Please review the attached p=
atch.</p>
<p style=3D"margin-top:0px; margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px; margin-bottom:0px">Best Regards</p>
<p style=3D"margin-top:0px; margin-bottom:0px">Rex<br>
</p>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_gmail-m_-4726930752337344039divRplyFwdMsg" dir=3D"ltr"><font f=
ace=3D"Calibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>F=
rom:</b> amd-gfx
<a class=3D"x_gmail-m_-4726930752337344039moz-txt-link-rfc2396E" href=3D"ma=
ilto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"LPlnk86=
6746" previewremoved=3D"true">
&lt;amd-gfx-bounces@lists.<wbr>freedesktop.org&gt;</a> on behalf of Alex De=
ucher <a class=3D"x_gmail-m_-4726930752337344039moz-txt-link-rfc2396E" href=
=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" id=3D"LPlnk978603" prev=
iewremoved=3D"true">
&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
<b>Sent:</b> Friday, March 9, 2018 4:54 AM<br>
<b>To:</b> <a class=3D"x_gmail-m_-4726930752337344039moz-txt-link-abbreviat=
ed" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"L=
Plnk848814" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_gmail-m_-4726930752337344039BodyFragment"><font size=3D"2">=
<span style=3D"font-size:11pt">
<div class=3D"x_gmail-m_-4726930752337344039PlainText">We already handle th=
e firmware loading type checks in the<br>
psp module directly, no need for an additional check.<br>
<br>
Signed-off-by: Alex Deucher <a class=3D"x_gmail-m_-4726930752337344039moz-t=
xt-link-rfc2396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blan=
k" id=3D"LPlnk972109" previewremoved=3D"true">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c | 3 &#43;--<br>
&nbsp;1 file changed, 1 insertion(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c b/drivers/gpu/drm/amd/=
amdgpu/<wbr>soc15.c<br>
index 8dc8b72ed49b..ecf58a68cf66 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
@@ -531,8 &#43;531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(<wbr>adev, &amp;vega10_com=
mon_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(<wbr>adev, &amp;gmc_v9_0_i=
p_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(<wbr>adev, &amp;vega10_ih_=
ip_block);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_fw_load_type =3D=3D 2 || amdgpu_fw_load_type =3D=3D -=
1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(<wbr>adev, &amp;psp_v3_1_ip_block);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_device_ip_block_add(<wbr>adev, &amp;psp_v3_1_ip_block=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(<wbr>adev, &amp;amdgpu_pp_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sriov_v=
f(adev))<br>
-- <br>
2.13.6<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a class=3D"x_gmail-m_-4726930752337344039moz-txt-link-abbreviated" href=3D=
"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"LPlnk972475"=
 previewremoved=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a id=3D"LPlnk828600" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" target=3D"_blank" previewremoved=3D"true">https://lists.freedesk=
top.org/<wbr>mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15206168590980.853081255131565" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15206168590890.9899217792441102" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15206168590930.19447896014313382" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15206168590930.012224533044336905"></di=
v>
<div id=3D"LPTitle_15206168590930.6676613286273705" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15206168590950.5455473805207254" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15206168590950.8065594362643194" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15206168590970.6098635693868852" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<div id=3D"x_gmail-m_-4726930752337344039LPBorder_GT_15205709349260.1063847=
4698232214" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-in=
dent:0px">
<table id=3D"x_gmail-m_-4726930752337344039LPContainer_15205709349240.28082=
90117558123" cellspacing=3D"0" style=3D"width:90%; background-color:rgb(255=
,255,255); overflow:auto; padding-top:20px; padding-bottom:20px; margin-top=
:20px; border-top:1px dotted rgb(200,200,200); border-bottom:1px dotted rgb=
(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td colspan=3D"2" id=3D"x_gmail-m_-4726930752337344039TextCell_152057093492=
40.5375816182761378" style=3D"vertical-align:top; padding:0px; display:tabl=
e-cell">
<div id=3D"x_gmail-m_-4726930752337344039LPTitle_15205709349250.74404129282=
7629"><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk536103" target=3D"_blank" style=3D"text-decoration:none" previewre=
moved=3D"true">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"x_gmail-m_-4726930752337344039LPMetadata_15205709349250.43526037=
89039715">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank" id=3D"LPlnk63900=
8" previewremoved=3D"true">lists.freedesktop.org</a></div>
<div id=3D"x_gmail-m_-4726930752337344039LPDescription_15205709349260.44569=
05619796764">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all
<a href=3D"http://freedesktop.org" target=3D"_blank" id=3D"LPlnk830011" pre=
viewremoved=3D"true">
freedesktop.org</a> lists is subject to our Code of ...</div>
<div id=3D"LPBorder_GT_15206168899720.8833749745803448" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15206168899640.6943990955761994" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15206168899670.5783242277363418" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15206168899670.7334405047222263"></div>
<div id=3D"LPTitle_15206168899670.763851449544301" style=3D"top: 0px; color=
: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_s=
egoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quo=
t;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-hei=
ght: 21px;">
<a id=3D"LPUrlAnchor_15206168899690.45324843322065345" href=3D"http://freed=
esktop.org/" target=3D"_blank" style=3D"text-decoration: none;">www</a></di=
v>
<div id=3D"LPMetadata_15206168899690.3043585253425025" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
freedesktop.org</div>
<div id=3D"LPDescription_15206168899710.8181653055355163" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Welcome to freedesktop.org. freedesktop.org is open source / open discussio=
n software projects working on interoperability and shared technology for X=
 Window System ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
<br>
<fieldset class=3D"x_gmail-m_-4726930752337344039mimeAttachmentHeader"></fi=
eldset> <br>
<pre>______________________________<wbr>_________________=0A=
amd-gfx mailing list=0A=
<a class=3D"x_gmail-m_-4726930752337344039moz-txt-link-abbreviated" href=3D=
"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"LPlnk362977"=
 previewremoved=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>=0A=
<a class=3D"x_gmail-m_-4726930752337344039moz-txt-link-freetext" href=3D"ht=
tps://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" id=
=3D"LPlnk454668" previewremoved=3D"true">https://lists.freedesktop.org/<wbr=
>mailman/listinfo/amd-gfx</a>=0A=
</pre>
<div id=3D"LPBorder_GT_15206169213320.2568680993662593" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15206169213230.11439653090999924" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15206169213260.72102435629418" colspan=3D"2" style=3D"ve=
rtical-align: top; position: relative; padding: 0px; display: table-cell;">
<div id=3D"LPRemovePreviewContainer_15206169213260.3666898892948929"></div>
<div id=3D"LPTitle_15206169213270.5090766411535075" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15206169213280.020882264522205762" href=3D"https://lis=
ts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"tex=
t-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15206169213290.6035465984423496" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15206169213300.07041936860112408" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
 hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</blockquote>
<br>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0CY4PR12MB1687namp_--

--===============0915318943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0915318943==--
