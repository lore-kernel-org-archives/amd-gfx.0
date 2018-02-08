From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on Polaris
Date: Thu, 8 Feb 2018 15:14:37 +0000
Message-ID: <CY4PR12MB1687A05815EB945E39F139F1FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1518081259-18120-1-git-send-email-Rex.Zhu@amd.com>
 <1518081259-18120-11-git-send-email-Rex.Zhu@amd.com>,
 <CADnq5_Pme6WORs8Ns1DOhmXMSWWQHBkzkr=kWSF2_XqUakKQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0140444446=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Pme6WORs8Ns1DOhmXMSWWQHBkzkr=kWSF2_XqUakKQyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0140444446==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687A05815EB945E39F139F1FBF30CY4PR12MB1687namp_"

--_000_CY4PR12MB1687A05815EB945E39F139F1FBF30CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

if user select manual dpm mode=1B$B!$=1B(Bwe will disabe autowattman.
When switch to auto, we will restart the auto wattman on Polaris,
Restore to default profile mode on other ASICS.


Best Regards
Rex
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, February 8, 2018 11:02:21 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on Polar=
is

On Thu, Feb 8, 2018 at 4:14 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> Change-Id: I69b24ce65ddb361a89e5ac9b197ae6df9b60a9e5
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Would be good to give a brief description of what autowattman actually
does in the patch description.  Also, we may need to manually select a
profile in some cases (e.g., VR).  Would that be a problem with
autowattman?

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/dr=
m/amd/powerplay/hwmgr/hwmgr.c
> index f50b6cd..549e830 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -1023,6 +1023,10 @@ int polaris_set_asic_special_caps(struct pp_hwmgr =
*hwmgr)
>                 phm_cap_set(hwmgr->platform_descriptor.platformCaps,
>                                                         PHM_PlatformCaps_=
TCPRamping);
>         }
> +
> +       if (hwmgr->feature_mask & PP_AUTOWATTMAN_MASK)
> +               hwmgr->autowattman_enabled =3D true; /* currently only en=
abled on polaris */
> +
>         return 0;
>  }
>
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687A05815EB945E39F139F1FBF30CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
if user select manual dpm mode=1B$B!$=1B(Bwe will disabe autowattman.<br>
When switch to auto, we will restart the auto wattman on Polaris,<br>
Restore to default profile mode on other ASICS.<br>
<br>
<br>
Best Regards<br>
Rex
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, February 8, 2018 11:02:21 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 10/10] drm/amd/pp: Enable auto automan feature o=
n Polaris</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Feb 8, 2018 at 4:14 AM, Rex Zhu &lt;Rex.Zh=
u@amd.com&gt; wrote:<br>
&gt; Change-Id: I69b24ce65ddb361a89e5ac9b197ae6df9b60a9e5<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Would be good to give a brief description of what autowattman actually<br>
does in the patch description.&nbsp; Also, we may need to manually select a=
<br>
profile in some cases (e.g., VR).&nbsp; Would that be a problem with<br>
autowattman?<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 &#43;&#43;&#43;&=
#43;<br>
&gt;&nbsp; 1 file changed, 4 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; index f50b6cd..549e830 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; @@ -1023,6 &#43;1023,10 @@ int polaris_set_asic_special_caps(struct pp=
_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; phm_cap_set(hwmgr-&gt;platform_descriptor.platfor=
mCaps,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps_TCPRamping);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;feature_mask &=
amp; PP_AUTOWATTMAN_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hwmgr-&gt;autowattman_enabled =3D true; /* currently on=
ly enabled on polaris */<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1687A05815EB945E39F139F1FBF30CY4PR12MB1687namp_--

--===============0140444446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0140444446==--
