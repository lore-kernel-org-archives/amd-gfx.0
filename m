From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: revert "fix deadlock of reservation between
 cs and gpu reset v2"
Date: Wed, 6 Sep 2017 08:04:49 +0000
Message-ID: <BLUPR12MB044977C621578CDB0427B52584970@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1504617263-7210-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1690430580=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504617263-7210-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--===============1690430580==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044977C621578CDB0427B52584970BLUPR12MB0449namp_"

--_000_BLUPR12MB044977C621578CDB0427B52584970BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>The patch doesn't work at all:
1. The CS can still be blocked because of amdgpu_ctx_add_fence().
2. The order of submission isn't correct any more.
3. We could end up using freed up memory because we now drop the
   ctx reference to early.


I suddenly found that the parser->job is really a wild pointer:

    amdgpu_cs_parser_fini(p, 0, true);

    trace_amdgpu_cs_ioctl(job);
    amd_sched_entity_push_job(&job->base);

so "cs_parser_fini" cannot be called before "entity_push_job", that part is=
 correct


but how to understand 1)

what do you mean "The CS can still be blocked because of amdgpu_ctx_add_fen=
ce()."


for 2)The order of submission isn't correct any more.

I think since the pointer "job" is already a dirty pointer, meaningless tha=
t  we talking about it if the order is correct ...


BR Monk



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, September 5, 2017 9:14:23 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhou, David(ChunMing)
Subject: [PATCH] drm/amdgpu: revert "fix deadlock of reservation between cs=
 and gpu reset v2"

From: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This reverts commit 10e709cb296c98424c03408d23e3addeddcd4088.

The patch doesn't work at all:
1. The CS can still be blocked because of amdgpu_ctx_add_fence().
2. The order of submission isn't correct any more.
3. We could end up using freed up memory because we now drop the
   ctx reference to early.

This needs to be fixed cleanly by doing the context handling after the BO
handling, but this is a larger task just avoid the obvious crashes for now.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index b96776c..2db4010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1061,7 +1061,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *=
p,
         cs->out.handle =3D amdgpu_ctx_add_fence(p->ctx, ring, p->fence);
         job->uf_sequence =3D cs->out.handle;
         amdgpu_job_free_resources(job);
-       amdgpu_cs_parser_fini(p, 0, true);

         trace_amdgpu_cs_ioctl(job);
         amd_sched_entity_push_job(&job->base);
@@ -1120,10 +1119,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *filp)
                 goto out;

         r =3D amdgpu_cs_submit(&parser, cs);
-       if (r)
-               goto out;

-       return 0;
 out:
         amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
         return r;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB044977C621578CDB0427B52584970BLUPR12MB0449namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>&gt;<font size=3D"2"><span style=3D"font-size:10pt">The patch doesn't wo=
rk at all:<br>
1. The CS can still be blocked because of amdgpu_ctx_add_fence().<br>
2. The order of submission isn't correct any more.<br>
3. We could end up using freed up memory because we now drop the<br>
&nbsp;&nbsp; ctx reference to early.</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">I suddenly found that th=
e parser-&gt;job is really a wild pointer:</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"></span></font></p>
<div style=3D"color:#d4d4d4; background-color:#1e1e1e; font-family:'Droid S=
ans Mono','Courier New',monospace,'Droid Sans Fallback'; font-weight:normal=
; font-size:14px; line-height:19px; white-space:pre">
<div><span style=3D"color:#d4d4d4">&nbsp;&nbsp;&nbsp;&nbsp;</span><span sty=
le=3D"color:#dcdcaa">amdgpu_cs_parser_fini</span><span style=3D"color:#d4d4=
d4">(p,
</span><span style=3D"color:#b5cea8">0</span><span style=3D"color:#d4d4d4">=
, </span><span style=3D"color:#569cd6">true</span><span style=3D"color:#d4d=
4d4">);</span></div>
<br>
<div><span style=3D"color:#d4d4d4">&nbsp;&nbsp;&nbsp;&nbsp;</span><span sty=
le=3D"color:#dcdcaa">trace_amdgpu_cs_ioctl</span><span style=3D"color:#d4d4=
d4">(job);</span></div>
<div><span style=3D"color:#d4d4d4">&nbsp;&nbsp;&nbsp;&nbsp;</span><span sty=
le=3D"color:#dcdcaa">amd_sched_entity_push_job</span><span style=3D"color:#=
d4d4d4">(</span><span style=3D"color:#d4d4d4">&amp;</span><span style=3D"co=
lor:#d4d4d4">job-&gt;</span><span style=3D"color:#9cdcfe">base</span><span =
style=3D"color:#d4d4d4">);</span></div>
</div>
<p></p>
<p>so &quot;cs_parser_fini&quot; cannot be called before &quot;entity_push_=
job&quot;, that part is correct</p>
<p><br>
</p>
<p>but how to understand 1)<br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt">what do you mean &quot;T=
he CS can still be blocked because of amdgpu_ctx_add_fence().</span></font>=
&quot;</p>
<p><br>
</p>
<p>for 2)<font size=3D"2"><span style=3D"font-size:10pt">The order of submi=
ssion isn't correct any more.</span></font></p>
<p>I think since the pointer &quot;job&quot; is already a dirty pointer, me=
aningless that&nbsp; we talking about it if the order is correct ...
<br>
</p>
<p><br>
</p>
<p>BR Monk<br>
</p>
<p><br>
</p>
<p><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;death=
simple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, September 5, 2017 9:14:23 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhou, David(ChunMing)<br>
<b>Subject:</b> [PATCH] drm/amdgpu: revert &quot;fix deadlock of reservatio=
n between cs and gpu reset v2&quot;</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">From: Christian K=F6nig &lt;christian.koenig@amd.c=
om&gt;<br>
<br>
This reverts commit 10e709cb296c98424c03408d23e3addeddcd4088.<br>
<br>
The patch doesn't work at all:<br>
1. The CS can still be blocked because of amdgpu_ctx_add_fence().<br>
2. The order of submission isn't correct any more.<br>
3. We could end up using freed up memory because we now drop the<br>
&nbsp;&nbsp; ctx reference to early.<br>
<br>
This needs to be fixed cleanly by doing the context handling after the BO<b=
r>
handling, but this is a larger task just avoid the obvious crashes for now.=
<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ----<br>
&nbsp;1 file changed, 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index b96776c..2db4010 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -1061,7 &#43;1061,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cs-&gt;out.handle =3D amdg=
pu_ctx_add_fence(p-&gt;ctx, ring, p-&gt;fence);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;uf_sequence =3D cs=
-&gt;out.handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_job_free_resources(=
job);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cs_parser_fini(p, 0, true);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_cs_ioctl(job)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd_sched_entity_push_job(=
&amp;job-&gt;base);<br>
@@ -1120,10 &#43;1119,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cs_submit(&am=
p;parser, cs);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cs_parser_fini(&amp=
;parser, r, reserved_buffers);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_BLUPR12MB044977C621578CDB0427B52584970BLUPR12MB0449namp_--

--===============1690430580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1690430580==--
