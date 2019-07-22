From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in
 switch statement
Date: Mon, 22 Jul 2019 15:58:00 +0000
Message-ID: <BN6PR12MB18098741A081711936563597F7C40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190721225920.GA18099@embeddedor>,
 <c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1749919304=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c735a1cc-a545-50fb-44e7-c0ad93ee8ee7-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, "Cox, Philip" <Philip.Cox-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1749919304==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18098741A081711936563597F7C40BN6PR12MB1809namp_"

--_000_BN6PR12MB18098741A081711936563597F7C40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We need to add a /*fall through */ comment then.

Alex
________________________________
From: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, July 22, 2019 11:14 AM
To: Gustavo A. R. Silva <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>; Cox, Philip <Philip.Cox@a=
md.com>; Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Deucher, Alexander <Alexander=
.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Zhou, Davi=
d(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; David Airlie <airlied-cv59FeDIM0c@public.gmane.org>; Daniel =
Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; dri-deve=
l@lists.freedesktop.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; linux-kernel@vge=
r.kernel.org <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in s=
witch statement

This one properly in purpose , The mqd init for CP and  COMPUTE will
have the same  routine .

Regard

sshaoyun.liu

On 2019-07-21 6:59 p.m., Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to case KFD_MQD_TYPE_COMPUTE.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Gustavo A. R. Silva <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 4f8a6ffc5775..1d8b13ad46f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -430,6 +430,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD=
_TYPE type,
>        switch (type) {
>        case KFD_MQD_TYPE_CP:
>                pr_debug("%s@%i\n", __func__, __LINE__);
> +             break;
>        case KFD_MQD_TYPE_COMPUTE:
>                pr_debug("%s@%i\n", __func__, __LINE__);
>                mqd->allocate_mqd =3D allocate_mqd;

--_000_BN6PR12MB18098741A081711936563597F7C40BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We need to add a /*fall through */ comment then.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, July 22, 2019 11:14 AM<br>
<b>To:</b> Gustavo A. R. Silva &lt;gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org&gt;; Cox, Philip =
&lt;Philip.Cox-5C7GfCeVMHo@public.gmane.org&gt;; Oded Gabbay &lt;oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Deuc=
her, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Chr=
istian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Zhou, David(ChunMing) &lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt=
;;
 David Airlie &lt;airlied-cv59FeDIM0c@public.gmane.org&gt;; Daniel Vetter &lt;daniel-/w4YWyX8dFk@public.gmane.org&g=
t;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt=
;; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org &lt;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing bre=
ak in switch statement</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This one properly in purpose , The mqd init for CP=
 and&nbsp; COMPUTE will
<br>
have the same&nbsp; routine .<br>
<br>
Regard<br>
<br>
sshaoyun.liu<br>
<br>
On 2019-07-21 6:59 p.m., Gustavo A. R. Silva wrote:<br>
&gt; Add missing break statement in order to prevent the code from falling<=
br>
&gt; through to case KFD_MQD_TYPE_COMPUTE.<br>
&gt;<br>
&gt; This bug was found thanks to the ongoing efforts to enable<br>
&gt; -Wimplicit-fallthrough.<br>
&gt;<br>
&gt; Fixes: 14328aa58ce5 (&quot;drm/amdkfd: Add navi10 support to amdkfd. (=
v3)&quot;)<br>
&gt; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
&gt; Signed-off-by: Gustavo A. R. Silva &lt;gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 &#43;=
<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c<br>
&gt; index 4f8a6ffc5775..1d8b13ad46f9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c<br>
&gt; @@ -430,6 &#43;430,7 @@ struct mqd_manager *mqd_manager_init_v10(enum =
KFD_MQD_TYPE type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MQD_TYPE_CP:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_debug(&quot;%s@%i\n&quot;, __func__, __LINE__);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MQD_TYPE_COMPUTE:<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_debug(&quot;%s@%i\n&quot;, __func__, __LINE__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd-&gt;allocate_mqd =3D allocate_mqd;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18098741A081711936563597F7C40BN6PR12MB1809namp_--

--===============1749919304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1749919304==--
