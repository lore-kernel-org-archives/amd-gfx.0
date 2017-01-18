From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debugfs
Date: Wed, 18 Jan 2017 18:44:42 +0000
Message-ID: <BN6PR12MB1764670B2DCBBF1150C02F18F77F0@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <20170118182513.29695-1-tom.stdenis@amd.com>,
 <CADnq5_NxDYM4=jp-y3czqoeVJEygbFaukoit+kRBGZdehjcxRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0937879209=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NxDYM4=jp-y3czqoeVJEygbFaukoit+kRBGZdehjcxRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0937879209==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1764670B2DCBBF1150C02F18F77F0BN6PR12MB1764namp_"

--_000_BN6PR12MB1764670B2DCBBF1150C02F18F77F0BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am grabbing revision.  Unless there's some other PCI revision value I'm m=
issing :-)


Tom


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, January 18, 2017 13:40
To: Tom St Denis
Cc: amd-gfx list; StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debugfs

On Wed, Jan 18, 2017 at 1:25 PM, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> So we can determine which device the entry is before connecting
> a display.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

> +
>         while (size && (*pos < no_regs * 4)) {
>                 uint32_t value;
>
> --
> 2.11.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_BN6PR12MB1764670B2DCBBF1150C02F18F77F0BN6PR12MB1764namp_
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
<p>I am grabbing revision. &nbsp;Unless there's some other PCI revision val=
ue I'm missing :-)</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 18, 2017 13:40<br>
<b>To:</b> Tom St Denis<br>
<b>Cc:</b> amd-gfx list; StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add PCI info to gca_config debu=
gfs</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Wed, Jan 18, 2017 at 1:25 PM, Tom St Denis &lt;=
tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt; So we can determine which device the entry is before connecting<br>
&gt; a display.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk654617" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14847650573060.6184570050595048" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14847650573040.2543156100021653" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14847650573050.6209665506878967" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14847650573050.4249670139356132"></div>
<div id=3D"LPTitle_14847650573050.01429245096647258" style=3D"top: 0px; col=
or: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_14847650573050.26124938264084885" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14847650573050.012810323802504353" style=3D"margin: 1=
0px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: =
wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Ari=
al, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14847650573060.29801268163925165" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
 hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1764670B2DCBBF1150C02F18F77F0BN6PR12MB1764namp_--

--===============0937879209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0937879209==--
