From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix sdma doorbell range setting
Date: Tue, 21 Aug 2018 20:15:06 +0000
Message-ID: <DM5PR12MB18209CC22537183C0FCEDF79F7310@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20180821082102.19653-1-evan.quan@amd.com>,
 <f1975140-a462-c11f-d84e-179ff3d506f4@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1375838991=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f1975140-a462-c11f-d84e-179ff3d506f4-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1375838991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18209CC22537183C0FCEDF79F7310DM5PR12MB1820namp_"

--_000_DM5PR12MB18209CC22537183C0FCEDF79F7310DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, this is for amd-staging-drm-next and ultimately upstream.


Alex

________________________________
From: Kuehling, Felix
Sent: Tuesday, August 21, 2018 4:10:07 PM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Russell, Kent
Cc: Deucher, Alexander; Zhang, Hawking
Subject: Re: [PATCH] drm/amdgpu: fix sdma doorbell range setting

[+Kent]

Which branch is this for?

amd-staging-drm-next doesn't have Shaoyun's other changes for changing
the doorbell layout, so this change looks reasonable for
amd-staging-drm-next.

Kent, we should not merge this change into amd-kfd-staging, because it
would break KFD's 8 SDMA queues per engine. I'm preparing upstreaming
Vega20 changes KFD. That will include reverting this commit.

Regards,
  Felix

On 2018-08-21 04:21 AM, Evan Quan wrote:
> Use the old doorbell range setting until the driver is
> able to support more sdma queues.
>
> Change-Id: I80fc067fc64878d3c7dc3d38bbe1c6c94bec397f
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v7_4.c
> index 89ea92075b6b..2e65447637c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -76,7 +76,7 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdgpu=
_device *adev, int instan
>
>        if (use_doorbell) {
>                doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, OFFSET, doorbell_index);
> -             doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, 8);
> +             doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, 2);
>        } else
>                doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, SIZE, 0);
>


--_000_DM5PR12MB18209CC22537183C0FCEDF79F7310DM5PR12MB1820namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Yes, this is for amd-staging-drm-=
next and ultimately upstream.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Tuesday, August 21, 2018 4:10:07 PM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Russell, Kent<br>
<b>Cc:</b> Deucher, Alexander; Zhang, Hawking<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix sdma doorbell range setting</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[&#43;Kent]<br>
<br>
Which branch is this for?<br>
<br>
amd-staging-drm-next doesn't have Shaoyun's other changes for changing<br>
the doorbell layout, so this change looks reasonable for<br>
amd-staging-drm-next.<br>
<br>
Kent, we should not merge this change into amd-kfd-staging, because it<br>
would break KFD's 8 SDMA queues per engine. I'm preparing upstreaming<br>
Vega20 changes KFD. That will include reverting this commit.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
On 2018-08-21 04:21 AM, Evan Quan wrote:<br>
&gt; Use the old doorbell range setting until the driver is<br>
&gt; able to support more sdma queues.<br>
&gt;<br>
&gt; Change-Id: I80fc067fc64878d3c7dc3d38bbe1c6c94bec397f<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/=
amd/amdgpu/nbio_v7_4.c<br>
&gt; index 89ea92075b6b..2e65447637c6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&gt; @@ -76,7 &#43;76,7 @@ static void nbio_v7_4_sdma_doorbell_range(struct=
 amdgpu_device *adev, int instan<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SD=
MA0_DOORBELL_RANGE, OFFSET, doorbell_index);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORBELL_RAN=
GE, SIZE, 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORBELL=
_RANGE, SIZE, 2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SD=
MA0_DOORBELL_RANGE, SIZE, 0);<br>
&gt;&nbsp; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB18209CC22537183C0FCEDF79F7310DM5PR12MB1820namp_--

--===============1375838991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1375838991==--
