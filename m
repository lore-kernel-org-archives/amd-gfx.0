From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debugfs
Date: Wed, 18 Jan 2017 18:55:25 +0000
Message-ID: <BN6PR12MB1764B0A0DE4BCAB0587A178DF77F0@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <20170118182513.29695-1-tom.stdenis@amd.com>,
 <CADnq5_NxDYM4=jp-y3czqoeVJEygbFaukoit+kRBGZdehjcxRw@mail.gmail.com>
 <BN6PR12MB1764670B2DCBBF1150C02F18F77F0@BN6PR12MB1764.namprd12.prod.outlook.com>,
 <BN6PR12MB16529ECC0DE7C81FFB53C422F77F0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0630363802=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16529ECC0DE7C81FFB53C422F77F0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0630363802==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1764B0A0DE4BCAB0587A178DF77F0BN6PR12MB1764namp_"

--_000_BN6PR12MB1764B0A0DE4BCAB0587A178DF77F0BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Coo, pushed to staging.


Tom


________________________________
From: Deucher, Alexander
Sent: Wednesday, January 18, 2017 13:47
To: StDenis, Tom; Alex Deucher
Cc: amd-gfx list
Subject: RE: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debugfs


Whoops, sorry, I glanced quickly and thought you were grabbing the vendor a=
nd device ids, not the revision.  Carry on :)



From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Wednesday, January 18, 2017 1:45 PM
To: Alex Deucher
Cc: amd-gfx list
Subject: Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debugfs



I am grabbing revision.  Unless there's some other PCI revision value I'm m=
issing :-)



Tom



________________________________

From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Wednesday, January 18, 2017 13:40
To: Tom St Denis
Cc: amd-gfx list; StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debugfs



On Wed, Jan 18, 2017 at 1:25 PM, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:=
tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> So we can determine which device the entry is before connecting
> a display.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis@amd.c=
om>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 28681286d57c..8640f9216d93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2967,7 +2967,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struc=
t file *f, char __user *buf,
>                 return -ENOMEM;
>
>         /* version, increment each time something is added */
> -       config[no_regs++] =3D 2;
> +       config[no_regs++] =3D 3;
>         config[no_regs++] =3D adev->gfx.config.max_shader_engines;
>         config[no_regs++] =3D adev->gfx.config.max_tile_pipes;
>         config[no_regs++] =3D adev->gfx.config.max_cu_per_sh;
> @@ -3001,6 +3001,12 @@ static ssize_t amdgpu_debugfs_gca_config_read(stru=
ct file *f, char __user *buf,
>         config[no_regs++] =3D adev->family;
>         config[no_regs++] =3D adev->external_rev_id;
>
> +       /* rev=3D=3D3 */
> +       config[no_regs++] =3D adev->pdev->device;
> +       config[no_regs++] =3D adev->pdev->revision;
> +       config[no_regs++] =3D adev->pdev->subsystem_device;
> +       config[no_regs++] =3D adev->pdev->subsystem_vendor;

For completeness, please add pdev->revision as well.  With that:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

> +
>         while (size && (*pos < no_regs * 4)) {
>                 uint32_t value;
>
> --
> 2.11.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>

lists.freedesktop.org

To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_BN6PR12MB1764B0A0DE4BCAB0587A178DF77F0BN6PR12MB1764namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Coo, pushed to staging.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<br=
>
<b>Sent:</b> Wednesday, January 18, 2017 13:47<br>
<b>To:</b> StDenis, Tom; Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debu=
gfs</font>
<div>&nbsp;</div>
</div>
<div>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">Whoops, sorry, I glanced quickly and thought y=
ou were grabbing the vendor and device ids, not the revision.&nbsp; Carry o=
n
</span><span style=3D"font-size:11.0pt; font-family:Wingdings; color:#1F497=
D">J</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;=
,&quot;sans-serif&quot;; color:#1F497D"></span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<b><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt; font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx [mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Wednesday, January 18, 2017 1:45 PM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debu=
gfs</span></p>
</div>
</div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
&nbsp;</p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">I am grabbing revision. &nbsp;Unless there's some other PCI rev=
ision value I'm missing :-)</span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">&nbsp;</span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">Tom</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
<div>
<div>
<div align=3D"center" style=3D"text-align: center; margin: 0in 0in 0.0001pt=
; font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<b><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;; color:black">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"> A=
lex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" style=3D"color: bl=
ue; text-decoration: underline;">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, January 18, 2017 13:40<br>
<b>To:</b> Tom St Denis<br>
<b>Cc:</b> amd-gfx list; StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debu=
gfs</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&q=
uot;; color:black">
</span></p>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
</div>
</div>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:10.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:black">On Wed, Jan 18, 2017 at 1:25 PM, Tom St Denis &l=
t;<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" style=3D"color: blue; text-decora=
tion: underline;">tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; So we can determine which device the entry is before connecting<br>
&gt; a display.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
 style=3D"color: blue; text-decoration: underline;">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>=
&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;-<br>
&gt;&nbsp; 1 file changed, 7 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 28681286d57c..8640f9216d93 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2967,7 &#43;2967,7 @@ static ssize_t amdgpu_debugfs_gca_config_rea=
d(struct file *f, char __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* version, increment =
each time something is added */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =3D 2;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D 3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#4=
3;] =3D adev-&gt;gfx.config.max_shader_engines;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#4=
3;] =3D adev-&gt;gfx.config.max_tile_pipes;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#4=
3;] =3D adev-&gt;gfx.config.max_cu_per_sh;<br>
&gt; @@ -3001,6 &#43;3001,12 @@ static ssize_t amdgpu_debugfs_gca_config_re=
ad(struct file *f, char __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#4=
3;] =3D adev-&gt;family;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#4=
3;] =3D adev-&gt;external_rev_id;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rev=3D=3D3 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;pdev-&gt;device;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;pdev-&gt;revision;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;pdev-&gt;subsystem_device;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;pdev-&gt;subsystem_vendor;<br>
<br>
For completeness, please add pdev-&gt;revision as well.&nbsp; With that:<br=
>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" =
style=3D"color: blue; text-decoration: underline;">alexander.deucher-urvtwAKJhsc@public.gmane.org=
m</a>&gt;<br>
<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (size &amp;&amp;=
 (*pos &lt; no_regs * 4)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&gt;<br>
&gt; --<br>
&gt; 2.11.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" style=3D"color: blue;=
 text-decoration: underline;">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk654617" style=3D"color: blue; text-decoration: underline;" preview=
removed=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a> </span></p>
<div id=3D"LPBorder_GT_14847650573060.6184570050595048" style=3D"margin-bot=
tom:15.0pt; overflow:auto">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%; background:white; border-top:dot=
ted #C8C8C8 1.0pt; border-left:none; border-bottom:dotted #C8C8C8 1.0pt; bo=
rder-right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none; padding:0in 0in 0in 0in">
<div id=3D"LPTitle_14847650573050.01429245096647258">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:16.0pt; font-family:&quot;Segoe UI Light&quot;,&qu=
ot;sans-serif&quot;; color:#3B5777"><a href=3D"https://lists.freedesktop.or=
g/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"color: blue; text-de=
coration: underline;"><span style=3D"text-decoration:none">amd-gfx
 Info Page - lists.freedesktop.org</span></a></span></p>
</div>
<div id=3D"LPMetadata_14847650573050.012810323802504353" style=3D"margin-to=
p:7.5pt; margin-bottom:12.0pt">
<p style=3D"line-height: 10.5pt; margin: 0in 0in 0.0001pt; font-size: 12pt;=
 font-family: &quot;Times New Roman&quot;, serif;">
<span style=3D"font-size:10.5pt; font-family:&quot;Segoe UI&quot;,&quot;san=
s-serif&quot;; color:#666666">lists.freedesktop.org</span></p>
</div>
<div id=3D"LPDescription_14847650573060.29801268163925165">
<p style=3D"line-height: 15pt; margin: 0in 0in 0.0001pt; font-size: 12pt; f=
ont-family: &quot;Times New Roman&quot;, serif;">
<span style=3D"font-size:10.5pt; font-family:&quot;Segoe UI&quot;,&quot;san=
s-serif&quot;; color:#666666">To see the collection of prior postings to th=
e list, visit the amd-gfx Archives. Using amd-gfx: To post a message to all=
 the list members, send email ...</span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:10.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:black">&nbsp;</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1764B0A0DE4BCAB0587A178DF77F0BN6PR12MB1764namp_--

--===============0630363802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0630363802==--
