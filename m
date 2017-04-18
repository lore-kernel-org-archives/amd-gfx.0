From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
Date: Tue, 18 Apr 2017 15:17:17 +0000
Message-ID: <MWHPR1201MB00452889FF2C7FDC55630B4BF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <1492119298-8526-1-git-send-email-AlexBin.Xie@amd.com>,
 <58F0495D.60607@amd.com>
 <MWHPR1201MB0045DE55E81D0FF5CE76671FF2060@MWHPR1201MB0045.namprd12.prod.outlook.com>,
 <58F57C14.20403@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0543324516=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58F57C14.20403-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0543324516==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB00452889FF2C7FDC55630B4BF2190MWHPR1201MB0045_"

--_000_MWHPR1201MB00452889FF2C7FDC55630B4BF2190MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi David,


When amdgpu_bo_reserve return errors, we cannot release the BO. This is not=
 a memory leak. General speaking, memory leak is unnoticed and unintentiona=
l.


The caller of function amdgpu_vram_scratch_fini ignores the return error va=
lue...


The "memory leak" is not caused by my patch. It is caused because reserving=
 BO fails.


This patch only aim to make function amdgpu_vram_scratch_fini behave correc=
tly.


To follow up, we can add a warning message when amdgpu_bo_reserve error hap=
pens in a different patch.


If function call amdgpu_bo_reserve is changed to uninterruptible, this chan=
ges driver behaviour. Without a substantial issue, I would be cautious for =
such a change.


Thanks,

Alex Bin Xie

________________________________
From: Zhou, David(ChunMing)
Sent: Monday, April 17, 2017 10:38 PM
To: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO



On 2017=1B$BG/=1B(B04=1B$B7n=1B(B17=1B$BF|=1B(B 22:54, Xie, AlexBin wrote:

Hi David,


Thanks for the comments. However, please have look at amdgpu_bo_reserve def=
inition.

static inline int amdgpu_bo_reserve(struct amdgpu_bo *bo, bool no_intr)

Ah, this is a wired wrapper for ttm_bo_reserve.



When we call this function like the following:

         r =3D amdgpu_bo_reserve(adev->vram_scratch.robj, false);
The false means interruptible.


On the other hand,  when amdgpu_bo_reserve function return error, why do we=
 unref BO without kunmap and unpin the BO? This is wrong implementation whe=
n amdgpu_bo_reserve return any error.

Yeah, I see your mean, it's in driver un-loading, How about changing to no =
interruptible? Your patch will make a memleak if bo_reserve fails, but it s=
eems not matter. I have no strong preference.

Regards,
David Zhou


Thanks,
Alex Bin Xie

________________________________
From: Zhou, David(ChunMing)
Sent: Friday, April 14, 2017 12:00 AM
To: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO



On 2017=1B$BG/=1B(B04=1B$B7n=1B(B14=1B$BF|=1B(B 05:34, Alex Xie wrote:
> According to comment of amdgpu_bo_reserve, amdgpu_bo_reserve
> can return with -ERESTARTSYS. When this function was interrupted
> by a signal, BO should not be unref. Otherwise the BO might be
> released while is kmapped and pinned, or BO MIGHT be deref
> multiple times, etc.
         r =3D amdgpu_bo_reserve(adev->vram_scratch.robj, false);
we have specified interruptible to false, so -ERESTARTSYS isn't possible
here.

Thanks,
David Zhou
>
> Change-Id: If76071a768950a0d3ad9d5da7fcae04881807621
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org><mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 53996e3..1dcc2d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -355,8 +355,8 @@ static void amdgpu_vram_scratch_fini(struct amdgpu_de=
vice *adev)
>                amdgpu_bo_kunmap(adev->vram_scratch.robj);
>                amdgpu_bo_unpin(adev->vram_scratch.robj);
>                amdgpu_bo_unreserve(adev->vram_scratch.robj);
> +             amdgpu_bo_unref(&adev->vram_scratch.robj);
>        }
> -     amdgpu_bo_unref(&adev->vram_scratch.robj);
>   }
>
>   /**



--_000_MWHPR1201MB00452889FF2C7FDC55630B4BF2190MWHPR1201MB0045_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi David,</p>
<p><br>
</p>
<p>When&nbsp;<span style=3D"font-size: 12pt; font-family: Calibri, Arial, H=
elvetica, sans-serif;">amdgpu_bo_reserve return errors, we cannot release t=
he BO. This is not a memory leak. General speaking, memory leak is&nbsp;unn=
oticed and unintentional.</span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><br>
</span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;">The caller of function&nbsp;<span>amdgpu_vram_scratch_fini ign=
ores the return error value...</span></span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><span><br>
</span></span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><span>The &quot;memory leak&quot; is not caused by my patch. I=
t is caused because reserving BO fails.</span></span></p>
<p><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-=
size: 12pt;"><br>
</span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><span></span></span><span style=3D"font-family: Calibri, Arial=
, Helvetica, sans-serif; font-size: 12pt;">This&nbsp;patch only aim to make=
 function&nbsp;</span><span style=3D"font-family: Calibri, Arial, Helvetica=
, sans-serif; font-size: 12pt;">amdgpu_vram_scratch_fini
 behave correctly.</span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><span><br>
</span></span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><span>To follow up, we can add a warning message when
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 16px;">
amdgpu_bo_reserve</span> error happens in a different patch.</span></span><=
/p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><span><br>
</span></span></p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;">If function call&nbsp;</span><span style=3D"font-family: Calib=
ri, Arial, Helvetica, sans-serif; font-size: 12pt;">amdgpu_bo_reserve is ch=
anged to uninterruptible, this changes&nbsp;driver&nbsp;behaviour.
 Without a substantial issue, I would be cautious for such a change.</span>=
</p>
<p><span style=3D"font-size: 12pt; font-family: Calibri, Arial, Helvetica, =
sans-serif;"><br>
</span></p>
<p>Thanks,</p>
<p>Alex Bin Xie</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhou, David(ChunMing)=
<br>
<b>Sent:</b> Monday, April 17, 2017 10:38 PM<br>
<b>To:</b> Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO</font>
<div>&nbsp;</div>
</div>
<div><br>
<br>
<div class=3D"moz-cite-prefix">On 2017=1B$BG/=1B(B04=1B$B7n=1B(B17=1B$BF|=
=1B(B 22:54, Xie, AlexBin wrote:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi David,</p>
<p><br>
</p>
<p>Thanks for the comments. However, please have look at <span style=3D"">a=
mdgpu_bo_reserve</span> definition.</p>
<p><span>static inline int amdgpu_bo_reserve(struct amdgpu_bo *bo, bool no_=
intr)</span><br>
</p>
</div>
</blockquote>
Ah, this is a wired wrapper for ttm_bo_reserve.<br>
<br>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p></p>
<p><span><br>
</span></p>
<p><span>When we call this function like the following:</span></p>
<p><span><span style=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r =3D amdgpu_bo=
_reserve(adev-&gt;vram_scratch.robj, false);</span><br style=3D"">
</span><span style=3D"font-size:12pt">The false means <span>interruptible</=
span>.</span><span><br>
</span></p>
<p><span style=3D"font-size:12pt"><br>
</span></p>
<p><span style=3D"font-size:12pt">On the other hand, &nbsp;when&nbsp;<span =
style=3D"">amdgpu_bo_reserve function return error, why do we unref BO with=
out kunmap and unpin the BO? This is wrong implementation&nbsp;when&nbsp;<s=
pan style=3D"">amdgpu_bo_reserve return any error.</span></span></span></p>
</div>
</blockquote>
Yeah, I see your mean, it's in driver un-loading, How about changing to no =
interruptible? Your patch will make a memleak if bo_reserve fails, but it s=
eems not matter. I have no strong preference.<br>
<br>
Regards,<br>
David Zhou<br>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><br>
</p>
Thanks,
<div>Alex Bin Xie<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhou, David(ChunMin=
g)<br>
<b>Sent:</b> Friday, April 14, 2017 12:00 AM<br>
<b>To:</b> Xie, AlexBin; <a class=3D"moz-txt-link-abbreviated" href=3D"mail=
to:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText"><br>
<br>
On 2017=1B$BG/=1B(B04=1B$B7n=1B(B14=1B$BF|=1B(B 05:34, Alex Xie wrote:<br>
&gt; According to comment of amdgpu_bo_reserve, amdgpu_bo_reserve<br>
&gt; can return with -ERESTARTSYS. When this function was interrupted<br>
&gt; by a signal, BO should not be unref. Otherwise the BO might be<br>
&gt; released while is kmapped and pinned, or BO MIGHT be deref<br>
&gt; multiple times, etc.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(ad=
ev-&gt;vram_scratch.robj, false);<br>
we have specified interruptible to false, so -ERESTARTSYS isn't possible <b=
r>
here.<br>
<br>
Thanks,<br>
David Zhou<br>
&gt;<br>
&gt; Change-Id: If76071a768950a0d3ad9d5da7fcae04881807621<br>
&gt; Signed-off-by: Alex Xie <a class=3D"moz-txt-link-rfc2396E" href=3D"mai=
lto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">
&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 53996e3..1dcc2d1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -355,8 &#43;355,8 @@ static void amdgpu_vram_scratch_fini(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;vram_scratch.robj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;vram_scratch.robj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&gt;vram_scratch.robj);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.robj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.r=
obj);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
<br>
</div>
</span></font></div>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR1201MB00452889FF2C7FDC55630B4BF2190MWHPR1201MB0045_--

--===============0543324516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0543324516==--
