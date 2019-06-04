From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add smu message mutex
Date: Tue, 4 Jun 2019 07:09:32 +0000
Message-ID: <MN2PR12MB329644D6EEFE57167D2D622DA2150@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1559545315-25728-1-git-send-email-Jack.Xiao@amd.com>,
 <MN2PR12MB3309583D02AAF94151906292EC150@MN2PR12MB3309.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0533131502=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3309583D02AAF94151906292EC150-rweVpJHSKTpWdvXm18W95QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============0533131502==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329644D6EEFE57167D2D622DA2150MN2PR12MB3296namp_"

--_000_MN2PR12MB329644D6EEFE57167D2D622DA2150MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Huang, Ray
Sent: Tuesday, June 4, 2019 1:37 PM
To: Xiao, Jack; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Zhang, H=
awking
Cc: Xiao, Jack; Wang, Kevin(Yang); Quan, Evan; Gui, Jack; Gao, Likun
Subject: RE: [PATCH] drm/amd/powerplay: add smu message mutex

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Xiao,
> Jack
> Sent: Monday, June 03, 2019 3:02 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking
> <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: add smu message mutex
>
> Add smu message mutex preventing against race condition issue.
>
> Signed-off-by: Jack Xiao <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 1 +
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 7 ++++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 3026c7e..db2bbec 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -350,6 +350,7 @@ static int smu_early_init(void *handle)
>        smu->adev =3D adev;
>        smu->pm_enabled =3D !!amdgpu_dpm;
>        mutex_init(&smu->mutex);
> +     mutex_init(&smu->msg_mutex);

As talked with you, we need use smu->mutex to protect the context in the th=
read instead of introducing the specific mutex of messages. Because msg_mut=
ex cannot protect the case of multi-message pairing. And yes, this is the k=
ey issue of swSMU so far.

+ Linux power folks,
Kevin, could you please use the smu->mutex to protect below callbacks which=
 will be called from gpu_info ioctl.

amdgpu_dpm_get_sclk
amdgpu_dpm_get_mclk

And we need smu->mutex to protect the smu_dpm_set_uvd_enable/ smu_dpm_set_v=
ce_enable as well, because they will be called during VCN command submissio=
ns. We should look over all ioctl/sysfs interface in the driver, they all n=
eed the mutex.

Thanks,
Ray

[Kevin]

Hi Ray,

i think we should add msg_mutex lock to protect smu message function and re=
gsiter change.
more elaborate locks should be used to protect this critical resource and r=
educe the probability of mutual exclusion.

Hi Jack,

The patch is
Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Thanks,
Kevin

>
>        return smu_set_funcs(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 3eb1de9..735233e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -374,6 +374,7 @@ struct smu_context
>        const struct smu_funcs          *funcs;
>        const struct pptable_funcs      *ppt_funcs;
>        struct mutex                    mutex;
> +     struct mutex                    msg_mutex;
>        uint64_t pool_size;
>
>        struct smu_table_context        smu_table;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index d2eeb62..de737a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -104,6 +104,8 @@ static int smu_v11_0_send_msg(struct smu_context
> *smu, uint16_t msg)
>        if (index < 0)
>                return index;
>
> +     mutex_lock(&smu->msg_mutex);
> +
>        smu_v11_0_wait_for_response(smu);
>
>        WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0); @@ -
> 111,11 +113,11 @@ static int smu_v11_0_send_msg(struct smu_context
> *smu, uint16_t msg)
>        smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
>
>        ret =3D smu_v11_0_wait_for_response(smu);
> -
>        if (ret)
>                pr_err("Failed to send message 0x%x, response 0x%x\n",
> index,
>                       ret);
>
> +     mutex_unlock(&smu->msg_mutex);
>        return ret;
>
>  }
> @@ -132,6 +134,8 @@ static int smu_v11_0_send_msg(struct smu_context
> *smu, uint16_t msg)
>        if (index < 0)
>                return index;
>
> +     mutex_lock(&smu->msg_mutex);
> +
>        ret =3D smu_v11_0_wait_for_response(smu);
>        if (ret)
>                pr_err("Failed to send message 0x%x, response 0x%x, param
> 0x%x\n", @@ -148,6 +152,7 @@ static int smu_v11_0_send_msg(struct
> smu_context *smu, uint16_t msg)
>                pr_err("Failed to send message 0x%x, response 0x%x param
> 0x%x\n",
>                       index, ret, param);
>
> +     mutex_unlock(&smu->msg_mutex);
>        return ret;
>  }
>
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB329644D6EEFE57167D2D622DA2150MN2PR12MB3296namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI=
 Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang, Ray<br>
<b>Sent:</b> Tuesday, June 4, 2019 1:37 PM<br>
<b>To:</b> Xiao, Jack; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Z=
hang, Hawking<br>
<b>Cc:</b> Xiao, Jack; Wang, Kevin(Yang); Quan, Evan; Gui, Jack; Gao, Likun=
<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: add smu message mutex</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of Xiao,<br>
&gt; Jack<br>
&gt; Sent: Monday, June 03, 2019 3:02 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking<br>
&gt; &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: add smu message mutex<br>
&gt; <br>
&gt; Add smu message mutex preventing against race condition issue.<br>
&gt; <br>
&gt; Signed-off-by: Jack Xiao &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbs=
p; | 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 7 &#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; 3 files changed, 8 insertions(&#43;), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index 3026c7e..db2bbec 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -350,6 &#43;350,7 @@ static int smu_early_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev =3D adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pm_enabled =3D !!amd=
gpu_dpm;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;mute=
x);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;msg_mutex);<br>
<br>
As talked with you, we need use smu-&gt;mutex to protect the context in the=
 thread instead of introducing the specific mutex of messages. Because msg_=
mutex cannot protect the case of multi-message pairing. And yes, this is th=
e key issue of swSMU so far.<br>
<br>
&#43; Linux power folks, <br>
Kevin, could you please use the smu-&gt;mutex to protect below callbacks wh=
ich will be called from gpu_info ioctl.
<br>
<br>
amdgpu_dpm_get_sclk<br>
amdgpu_dpm_get_mclk<br>
<br>
And we need smu-&gt;mutex to protect the smu_dpm_set_uvd_enable/ smu_dpm_se=
t_vce_enable as well, because they will be called during VCN command submis=
sions. We should look over all ioctl/sysfs interface in the driver, they al=
l need the mutex.<br>
<br>
Thanks,<br>
Ray</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[Kevin]</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Hi Ray,</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">i think we should add msg_mutex lock to protect sm=
u message function and regsiter change.</div>
<div class=3D"PlainText"></div>
<div>more elaborate locks should be used to protect this critical resource =
and reduce the probability of mutual exclusion.</div>
<div><br>
</div>
<div>Hi Jack,</div>
<div><br>
</div>
<div>The patch is</div>
<div>Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Kevin</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_set_funcs(adev);<=
br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; index 3eb1de9..735233e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; @@ -374,6 &#43;374,7 @@ struct smu_context<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smu_funcs&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pptable_funcs&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *ppt_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; msg_mutex;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pool_size;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; index d2eeb62..de737a0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; @@ -104,6 &#43;104,8 @@ static int smu_v11_0_send_msg(struct smu_conte=
xt<br>
&gt; *smu, uint16_t msg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return index;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;msg_mutex);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_wait_for_response(=
smu);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_S=
MN_C2PMSG_90, 0); @@ -<br>
&gt; 111,11 &#43;113,11 @@ static int smu_v11_0_send_msg(struct smu_context=
<br>
&gt; *smu, uint16_t msg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_send_msg_without_w=
aiting(smu, (uint16_t)index);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_wait_for_r=
esponse(smu);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to send message 0x%x, response 0x%x=
\n&quot;,<br>
&gt; index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;msg_mutex);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; <br>
&gt;&nbsp; }<br>
&gt; @@ -132,6 &#43;134,8 @@ static int smu_v11_0_send_msg(struct smu_conte=
xt<br>
&gt; *smu, uint16_t msg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return index;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;msg_mutex);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_wait_for_r=
esponse(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to send message 0x%x, response 0x%x=
, param<br>
&gt; 0x%x\n&quot;, @@ -148,6 &#43;152,7 @@ static int smu_v11_0_send_msg(st=
ruct<br>
&gt; smu_context *smu, uint16_t msg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to send message 0x%x, response 0x%x=
 param<br>
&gt; 0x%x\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index, ret, p=
aram);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;msg_mutex);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; --<br>
&gt; 1.9.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk554601" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB329644D6EEFE57167D2D622DA2150MN2PR12MB3296namp_--

--===============0533131502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0533131502==--
