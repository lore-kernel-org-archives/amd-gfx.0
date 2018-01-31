From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 7/9] drm/amdkfd: Add dGPU support to kernel_queue_init
Date: Wed, 31 Jan 2018 15:23:13 +0000
Message-ID: <BN6PR12MB16520A78D8FFA5E0AF393BD2F7FB0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-8-git-send-email-Felix.Kuehling@amd.com>,
 <CAFCwf11nyKTuxF4R+GfWt_Zg5pRjYezbp9TEW_-OWqRhhR-rVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494121179=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf11nyKTuxF4R+GfWt_Zg5pRjYezbp9TEW_-OWqRhhR-rVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0494121179==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16520A78D8FFA5E0AF393BD2F7FB0BN6PR12MB1652namp_"

--_000_BN6PR12MB16520A78D8FFA5E0AF393BD2F7FB0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Oded Gab=
bay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, January 31, 2018 10:17 AM
To: Kuehling, Felix
Cc: amd-gfx list
Subject: Re: [PATCH 7/9] drm/amdkfd: Add dGPU support to kernel_queue_init

On Fri, Jan 5, 2018 at 12:17 AM, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wr=
ote:
> Recognize dGPU ASIC families.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_kernel_queue.c
> index 5dc6567..69f4964 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -297,10 +297,15 @@ struct kernel_queue *kernel_queue_init(struct kfd_d=
ev *dev,
>
>         switch (dev->device_info->asic_family) {
>         case CHIP_CARRIZO:
> +       case CHIP_TONGA:
> +       case CHIP_FIJI:
> +       case CHIP_POLARIS10:
> +       case CHIP_POLARIS11:
I believe POLARIS is from arcatic islands, no ?
Maybe rename kernel_queue_init_vi to kernel_queue_init_vi_ai ?
or create a new function kernel_queue_init_ai() and assign same
functions as vi ?
Either way, I think you need to address that.

They are all gfx8.  adding ai just confuses things.

Alex


>                 kernel_queue_init_vi(&kq->ops_asic_specific);
>                 break;
>
>         case CHIP_KAVERI:
> +       case CHIP_HAWAII:
>                 kernel_queue_init_cik(&kq->ops_asic_specific);
>                 break;
>         default:
> --
> 2.7.4
>

Other then that, This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16520A78D8FFA5E0AF393BD2F7FB0BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Oded Gabbay &lt;oded.gabbay=
@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 31, 2018 10:17 AM<br>
<b>To:</b> Kuehling, Felix<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 7/9] drm/amdkfd: Add dGPU support to kernel_queu=
e_init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Jan 5, 2018 at 12:17 AM, Felix Kuehling &l=
t;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; Recognize dGPU ASIC families.<br>
&gt;<br>
&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 5 &#43;&#43;&#43=
;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&gt; index 5dc6567..69f4964 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&gt; @@ -297,10 &#43;297,15 @@ struct kernel_queue *kernel_queue_init(struc=
t kfd_dev *dev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (dev-&gt;device=
_info-&gt;asic_family) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TONGA:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_FIJI:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS10:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS11:<br>
I believe POLARIS is from arcatic islands, no ?<br>
Maybe rename kernel_queue_init_vi to kernel_queue_init_vi_ai ?<br>
or create a new function kernel_queue_init_ai() and assign same<br>
functions as vi ?<br>
Either way, I think you need to address that.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">They are all gfx8.&nbsp; adding ai just confuses t=
hings. &nbsp;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Alex<br>
</div>
<div class=3D"PlainText"><br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; kernel_queue_init_vi(&amp;kq-&gt;ops_asic_specifi=
c);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_KAVERI:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_HAWAII:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; kernel_queue_init_cik(&amp;kq-&gt;ops_asic_specif=
ic);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
<br>
Other then that, This patch is:<br>
Reviewed-by: Oded Gabbay &lt;oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk943420" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16520A78D8FFA5E0AF393BD2F7FB0BN6PR12MB1652namp_--

--===============0494121179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0494121179==--
