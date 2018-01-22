From: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushing irq
Date: Mon, 22 Jan 2018 14:38:57 +0000
Message-ID: <BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0@BN6PR1201MB0100.namprd12.prod.outlook.com>
References: <20180118210353.18842-1-harry.wentland@amd.com>
 <20180118210353.18842-16-harry.wentland@amd.com>,
 <2996fec0-814d-ec58-788b-883df20d2651@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0353755780=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2996fec0-814d-ec58-788b-883df20d2651-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0353755780==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0BN6PR1201MB0100_"

--_000_BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0BN6PR1201MB0100_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,


I've checked to revert this change and use Alex's change on switching irq d=
estruction sequence and it worked no problem.
You can reject this change if Alex's change is pulled in.


Thanks,

Nick

________________________________
From: Grodzovsky, Andrey
Sent: Friday, January 19, 2018 1:33:51 PM
To: Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Lipski, Mikita
Subject: Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushing irq

What this spin lock is protecting here ? Seems to me it's just a read of
an array element which is always there.

Regarding subsequent remove_timer_handler and timer queue destruction it
seems to me to be obsolete code, I don't think DAL is still using the
timer queue,

so seems to me everything related to it should be removed.

Thanks,

Andrey


On 01/18/2018 04:03 PM, Harry Wentland wrote:
> From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
>
> Lock irq table when reading a work in queue,
> unlock to flush the work, lock again till all tasks
> are cleared
>
> Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 1874b6cee6af..fb60c91a1bfe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -400,14 +400,15 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
>   {
>        int src;
>        struct irq_list_head *lh;
> +     unsigned long irq_table_flags;
>        DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
> -
>        for (src =3D 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
> -
> +             DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
>                /* The handler was removed from the table,
>                 * it means it is safe to flush all the 'work'
>                 * (because no code can schedule a new one). */
>                lh =3D &adev->dm.irq_handler_list_low_tab[src];
> +             DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>                flush_work(&lh->work);
>        }
>


--_000_BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0BN6PR1201MB0100_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>
<p style=3D"margin-top:0;margin-bottom:0">Hi Andrey,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
I've checked to revert this change and use Alex's change on switching irq d=
estruction sequence and it worked no problem.&nbsp;
</div>
You can reject this change if Alex's change is pulled in.
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0">Nick<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Grodzovsky, Andrey<b=
r>
<b>Sent:</b> Friday, January 19, 2018 1:33:51 PM<br>
<b>To:</b> Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Lipski, Mikita<br>
<b>Subject:</b> Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushi=
ng irq</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">What this spin lock is protecting here ? Seems to =
me it's just a read of
<br>
an array element which is always there.<br>
<br>
Regarding subsequent remove_timer_handler and timer queue destruction it <b=
r>
seems to me to be obsolete code, I don't think DAL is still using the <br>
timer queue,<br>
<br>
so seems to me everything related to it should be removed.<br>
<br>
Thanks,<br>
<br>
Andrey<br>
<br>
<br>
On 01/18/2018 04:03 PM, Harry Wentland wrote:<br>
&gt; From: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Lock irq table when reading a work in queue,<br>
&gt; unlock to flush the work, lock again till all tasks<br>
&gt; are cleared<br>
&gt;<br>
&gt; Signed-off-by: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Harry Wentland &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 =
&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c<br>
&gt; index 1874b6cee6af..fb60c91a1bfe 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.=
c<br>
&gt; @@ -400,14 &#43;400,15 @@ void amdgpu_dm_irq_fini(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int src;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_list_head *lh;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long irq_table_flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;DM_IRQ: =
releasing resources.\n&quot;);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (src =3D 0; src &lt; DAL=
_IRQ_SOURCES_NUMBER; src&#43;&#43;) {<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DM_IRQ_TABLE_LOCK(adev, irq_table_flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* The handler was removed from the table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * it means it is safe to flush all the 'work'<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * (because no code can schedule a new one). */<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lh =3D &amp;adev-&gt;dm.irq_handler_list_low_tab[src];<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; flush_work(&amp;lh-&gt;work);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0BN6PR1201MB0100_--

--===============0353755780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0353755780==--
