From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amdkfd: Improve KFD IOCTL printing
Date: Mon, 30 Sep 2019 18:05:33 +0000
Message-ID: <DM6PR12MB27786C334D48B9EC6329B68CF0820@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20190928034132.28340-1-Yong.Zhao@amd.com>
 <20190928034132.28340-6-Yong.Zhao@amd.com>,
 <30b9f4d8-0365-27fb-b6b4-ba2d20b9cb81@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821909814=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <30b9f4d8-0365-27fb-b6b4-ba2d20b9cb81-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1821909814==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB27786C334D48B9EC6329B68CF0820DM6PR12MB2778namp_"

--_000_DM6PR12MB27786C334D48B9EC6329B68CF0820DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Okay, I will change dev_err back to dev_dbg. The hex printing is still very=
 useful.

Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 30, 2019 11:47 AM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 6/6] drm/amdkfd: Improve KFD IOCTL printing

On 2019-09-27 11:41 p.m., Zhao, Yong wrote:
> The code use hex define, so should the printing. Also, printf a message
> if there is a failure.
>
> Change-Id: Ia7cc7690553bb043915b3d8c0157216c64421a60
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index c28ba0c1d7ac..d1ab09c0f522 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1840,7 +1840,7 @@ static long kfd_ioctl(struct file *filep, unsigned =
int cmd, unsigned long arg)
>        } else
>                goto err_i1;
>
> -     dev_dbg(kfd_device, "ioctl cmd 0x%x (#%d), arg 0x%lx\n", cmd, nr, a=
rg);
> +     dev_dbg(kfd_device, "ioctl cmd 0x%x (#0x%x), arg 0x%lx\n", cmd, nr,=
 arg);
>
>        process =3D kfd_get_process(current);
>        if (IS_ERR(process)) {
> @@ -1895,7 +1895,8 @@ static long kfd_ioctl(struct file *filep, unsigned =
int cmd, unsigned long arg)
>                kfree(kdata);
>
>        if (retcode)
> -             dev_dbg(kfd_device, "ret =3D %d\n", retcode);
> +             dev_err(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret =3D =
%d\n",
> +                             nr, arg, retcode);

NAK. We don't want to spam the kernel log with cryptic error messages
every time ioctl functions fail. Please leave this as a dev_dbg message.
Failing ioctl functions could be perfectly normal for a number of
reasons (system call interrupted by signal, running out of event slots,
timeouts on event waiting, etc). But every bug report will incorrectly
blame any unrelated problem on those messages if they happen to appear
in the kernel log.

Regards,
   Felix


>
>        return retcode;
>   }

--_000_DM6PR12MB27786C334D48B9EC6329B68CF0820DM6PR12MB2778namp_
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
Okay, I will change&nbsp;<span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fon=
t-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !i=
mportant">dev_err
 back to dev_dbg. The hex printing is still very useful.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div style=3D"color: rgb(0, 0, 0);"><span style=3D"font-size: 14.6667px;">Y=
ong</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, September 30, 2019 11:47 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 6/6] drm/amdkfd: Improve KFD IOCTL printing</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-09-27 11:41 p.m., Zhao, Yong wrote:<br>
&gt; The code use hex define, so should the printing. Also, printf a messag=
e<br>
&gt; if there is a failure.<br>
&gt;<br>
&gt; Change-Id: Ia7cc7690553bb043915b3d8c0157216c64421a60<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 &#43;&#43;&#4=
3;--<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_chardev.c<br>
&gt; index c28ba0c1d7ac..d1ab09c0f522 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -1840,7 &#43;1840,7 @@ static long kfd_ioctl(struct file *filep, un=
signed int cmd, unsigned long arg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_i1;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(kfd_device, &quot;ioctl cmd 0x%x (#%=
d), arg 0x%lx\n&quot;, cmd, nr, arg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(kfd_device, &quot;ioctl cmd 0x%x=
 (#0x%x), arg 0x%lx\n&quot;, cmd, nr, arg);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process =3D kfd_get_process(=
current);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(process)) {<br>
&gt; @@ -1895,7 &#43;1895,8 @@ static long kfd_ioctl(struct file *filep, un=
signed int cmd, unsigned long arg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfree(kdata);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retcode)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_dbg(kfd_device, &quot;ret =3D %d\n&quot;, retcode);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dev_err(kfd_device, &quot;ioctl cmd (#0x%x), arg 0x%lx, ret =3D %d\=
n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; nr, arg, retcode);<br>
<br>
NAK. We don't want to spam the kernel log with cryptic error messages <br>
every time ioctl functions fail. Please leave this as a dev_dbg message. <b=
r>
Failing ioctl functions could be perfectly normal for a number of <br>
reasons (system call interrupted by signal, running out of event slots, <br=
>
timeouts on event waiting, etc). But every bug report will incorrectly <br>
blame any unrelated problem on those messages if they happen to appear <br>
in the kernel log.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retcode;<br>
&gt;&nbsp;&nbsp; }<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB27786C334D48B9EC6329B68CF0820DM6PR12MB2778namp_--

--===============1821909814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1821909814==--
