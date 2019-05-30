From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/doc: add rough outline of tracepoint documentation
Date: Thu, 30 May 2019 11:57:54 -0400
Message-ID: <CAAzXoRJTE0PpKrV289uNKZvA=LNABA6dviqeoL_0Povmaq7Btg@mail.gmail.com>
References: <20190530145600.12241-1-tom.stdenis@amd.com>
 <MWHPR12MB1422F8CD20776EFC9B4C8288FE180@MWHPR12MB1422.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068302383=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1422F8CD20776EFC9B4C8288FE180-Gy0DoCVfaSXuYgwfTSIEYwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0068302383==
Content-Type: multipart/alternative; boundary="000000000000b84cd0058a1cf6aa"

--000000000000b84cd0058a1cf6aa
Content-Type: text/plain; charset="UTF-8"

Fixed with "is".

Thanks.  I'll wait for more feedback before submitting a v2.

Tom

On Thu, May 30, 2019 at 11:45 AM Abramov, Slava <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
wrote:

> Comments inline (marked with [slava a]).
>
>
> General comment - word capitalisation in the lists is inconsistent
>
>
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, May 30, 2019 10:56 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* StDenis, Tom
> *Subject:* [PATCH] drm/amd/doc: add rough outline of tracepoint
> documentation
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  Documentation/gpu/amdgpu.rst              |  10 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 221 ++++++++++++++++++++++
>  2 files changed, 231 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index 86138798128f..3564765110e5 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -89,6 +89,16 @@ AMDGPU RAS debugfs control interface
>  .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>     :internal:
>
> +AMDGPU Tracing Support
> +======================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +   :doc: AMDGPU Tracing Support
> +
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +   :internal:
> +
>
>  GPU Power/Thermal Controls and Monitoring
>  =========================================
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d3ca2424b5fe..71febb90d3e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -37,6 +37,227 @@
>  #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
>
> job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
>
> +/**
> + * DOC: AMDGPU Tracing Support
> + *
> + * The AMDGPU driver provides numerous trace points that can aid
> + * in debugging.  They are globally enabled by the file:
> + *
> + * /sys/kernel/debug/tracing/events/amdgpu/enable
> + *
> + * or individually by the enable files in the sub-directories
> + * of that directory.
> + *
> + * amdgpu_mm_rreg, amdgpu_mm_wreg
> + * ------------------------------
> + *
> + * These trace points track reads and writes to MMIO registers by
> + * the kernel driver (activity inside ring/indirect buffers are not
> + * traced) which can be used to diagnose IP block activity and
> + * responses.
>
> [slava a] Either 'activities are not traced' or 'activity is not traced'
> [slava a] Double usage of word 'activity' sounds weird.
>
> [snap]
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000b84cd0058a1cf6aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Fixed with &quot;is&quot;.<div><br></div><div>Thanks.=C2=
=A0 I&#39;ll wait for more feedback before submitting a v2.</div><div><br><=
/div><div>Tom</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, May 30, 2019 at 11:45 AM Abramov, Slava &lt;<a h=
ref=3D"mailto:Slava.Abramov-5C7GfCeVMHo@public.gmane.org">Slava.Abramov-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"gmail-m_-894554682780875538divtagdefaultwrapper" style=3D"font-s=
ize:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif,EmojiFon=
t,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&=
quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols" dir=3D"l=
tr">
<p style=3D"margin-top:0px;margin-bottom:0px">Comments inline (marked with =
[slava a]).</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px">General comment - word capita=
lisation in the lists is inconsistent</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_-894554682780875538divRplyFwdMsg" dir=3D"ltr"><font face=
=3D"Calibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From=
:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" =
target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f StDenis, Tom &lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank"=
>Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, May 30, 2019 10:56 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH] drm/amd/doc: add rough outline of tracepoint docume=
ntation</font>
<div>=C2=A0</div>
</div>
<div class=3D"gmail-m_-894554682780875538BodyFragment"><font size=3D"2"><sp=
an style=3D"font-size:11pt">
<div class=3D"gmail-m_-894554682780875538PlainText">Signed-off-by: Tom St D=
enis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">tom.stden=
is-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0Documentation/gpu/amdgpu.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 221 +++++++++++++++++++++=
+<br>
=C2=A02 files changed, 231 insertions(+)<br>
<br>
diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst<br=
>
index 86138798128f..3564765110e5 100644<br>
--- a/Documentation/gpu/amdgpu.rst<br>
+++ b/Documentation/gpu/amdgpu.rst<br>
@@ -89,6 +89,16 @@ AMDGPU RAS debugfs control interface<br>
=C2=A0.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
=C2=A0=C2=A0=C2=A0 :internal:<br>
=C2=A0<br>
+AMDGPU Tracing Support<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
+=C2=A0=C2=A0 :doc: AMDGPU Tracing Support<br>
+<br>
+<br>
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
+=C2=A0=C2=A0 :internal:<br>
+<br>
=C2=A0<br>
=C2=A0GPU Power/Thermal Controls and Monitoring<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h<br>
index d3ca2424b5fe..71febb90d3e3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
@@ -37,6 +37,227 @@<br>
=C2=A0#define AMDGPU_JOB_GET_TIMELINE_NAME(job) \<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job-&gt;base.s_fence=
-&gt;finished.ops-&gt;get_timeline_name(&amp;job-&gt;base.s_fence-&gt;finis=
hed)<br>
=C2=A0<br>
+/**<br>
+ * DOC: AMDGPU Tracing Support<br>
+ *<br>
+ * The AMDGPU driver provides numerous trace points that can aid<br>
+ * in debugging.=C2=A0 They are globally enabled by the file:<br>
+ *<br>
+ * /sys/kernel/debug/tracing/events/amdgpu/enable<br>
+ *<br>
+ * or individually by the enable files in the sub-directories<br>
+ * of that directory.<br>
+ *<br>
+ * amdgpu_mm_rreg, amdgpu_mm_wreg<br>
+ * ------------------------------<br>
+ *<br>
+ * These trace points track reads and writes to MMIO registers by</div>
<div class=3D"gmail-m_-894554682780875538PlainText"><span style=3D"font-siz=
e:11pt">+ * the kernel driver (activity inside ring/indirect buffers are no=
t</span><br>
</div>
<div class=3D"gmail-m_-894554682780875538PlainText"><span style=3D"font-siz=
e:11pt">+ * traced) which can be used to diagnose IP block activity and</sp=
an><br>
</div>
<div class=3D"gmail-m_-894554682780875538PlainText">+ * responses.</div>
<div class=3D"gmail-m_-894554682780875538PlainText">
<div class=3D"gmail-m_-894554682780875538PlainText" style=3D"font-family:Ca=
libri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Se=
goe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android=
 Emoji&quot;,EmojiSymbols;font-size:14.6667px">
<br class=3D"gmail-m_-894554682780875538Apple-interchange-newline">
[slava a] Either &#39;activities are not traced&#39; or &#39;activity is no=
t traced&#39;</div>
<div class=3D"gmail-m_-894554682780875538PlainText" style=3D"font-family:Ca=
libri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Se=
goe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android=
 Emoji&quot;,EmojiSymbols;font-size:14.6667px">
<span style=3D"font-size:11pt">[slava a] Double usage of word &#39;activity=
&#39; sounds weird.=C2=A0=C2=A0</span></div>
</div>
<div class=3D"gmail-m_-894554682780875538PlainText"><br>
</div>
<div class=3D"gmail-m_-894554682780875538PlainText">[snap]</div>
</span></font></div>
</div>
</div>
</div>

_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--000000000000b84cd0058a1cf6aa--

--===============0068302383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0068302383==--
