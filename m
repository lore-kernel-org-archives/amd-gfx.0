From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Date: Tue, 19 Nov 2019 21:41:24 -0500
Message-ID: <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1592762865=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6cba1e53-1c0d-d408-4d16-cae93ec9e62e-5C7GfCeVMHo@public.gmane.org>
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
To: Luben Tuikov <luben.tuikov-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Huang Rui <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1592762865==
Content-Type: multipart/alternative; boundary="0000000000000929110597be2086"

--0000000000000929110597be2086
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 19, 2019 at 8:52 PM Luben Tuikov <luben.tuikov-5C7GfCeVMHo@public.gmane.org> wrote:

> On 2019-11-14 10:34 p.m., Aaron Liu wrote:
> > From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> >
> > To align the kernel uapi change from Alex:
> >
> > "Add a flag to the GEM_CREATE ioctl to create encrypted buffers. Buffers
> with
> > this flag set will be created with the TMZ bit set in the PTEs or engines
> > accessing them. This is required in order to properly access the data
> from the
> > engines."
> >
> > We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.
> >
> > Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  include/drm/amdgpu_drm.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> > index 5c28aa7..1a95e37 100644
> > --- a/include/drm/amdgpu_drm.h
> > +++ b/include/drm/amdgpu_drm.h
> > @@ -141,6 +141,11 @@ extern "C" {
> >   * releasing the memory
> >   */
> >  #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE       (1 << 9)
> > +/* Flag that BO will be encrypted and that the TMZ bit should be
> > + * set in the PTEs when mapping this buffer via GPUVM or
> > + * accessing it with various hw blocks
> > + */
> > +#define AMDGPU_GEM_CREATE_ENCRYPTED          (1 << 10)
>
> Style!
> TAB char?!
>
> You have a TAB char between ".._ENCRYPTED" and "(1 << 10)"
> Do NOT add/insert TAB chars instead of space to align colunmns!
> If when you press Tab key a tab is inserted, as opposed to the line
> indented, then DO NOT use this editor.
> The Tab key should "indent according to mode" by inserting TAB chars.
> If the line is already indented, as this one is, then it should do nothing.
>

I disagree with this 100%. Tabs or spaces don't matter here from my
perspective. I also disagree with your language. It's overly impolite.

Marek

--0000000000000929110597be2086
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Nov 19, 2019 at 8:52 PM Luben Tuikov &lt;<a href=3D"mailto:l=
uben.tuikov-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">luben.tuikov-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2019-11-14 10=
:34 p.m., Aaron Liu wrote:<br>
&gt; From: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; <br>
&gt; To align the kernel uapi change from Alex:<br>
&gt; <br>
&gt; &quot;Add a flag to the GEM_CREATE ioctl to create encrypted buffers. =
Buffers with<br>
&gt; this flag set will be created with the TMZ bit set in the PTEs or engi=
nes<br>
&gt; accessing them. This is required in order to properly access the data =
from the<br>
&gt; engines.&quot;<br>
&gt; <br>
&gt; We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.<br=
>
&gt; <br>
&gt; Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org" targ=
et=3D"_blank">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.=
com" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/drm/amdgpu_drm.h | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h<br>
&gt; index 5c28aa7..1a95e37 100644<br>
&gt; --- a/include/drm/amdgpu_drm.h<br>
&gt; +++ b/include/drm/amdgpu_drm.h<br>
&gt; @@ -141,6 +141,11 @@ extern &quot;C&quot; {<br>
&gt;=C2=A0 =C2=A0* releasing the memory<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE=C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; 9)<br>
&gt; +/* Flag that BO will be encrypted and that the TMZ bit should be<br>
&gt; + * set in the PTEs when mapping this buffer via GPUVM or<br>
&gt; + * accessing it with various hw blocks<br>
&gt; + */<br>
&gt; +#define AMDGPU_GEM_CREATE_ENCRYPTED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (1 &lt;&lt; 10)<br>
<br>
Style!<br>
TAB char?!<br>
<br>
You have a TAB char between &quot;.._ENCRYPTED&quot; and &quot;(1 &lt;&lt; =
10)&quot;<br>
Do NOT add/insert TAB chars instead of space to align colunmns!<br>
If when you press Tab key a tab is inserted, as opposed to the line<br>
indented, then DO NOT use this editor.<br>
The Tab key should &quot;indent according to mode&quot; by inserting TAB ch=
ars.<br>
If the line is already indented, as this one is, then it should do nothing.=
<br></blockquote><div><br></div><div>I disagree with this 100%. Tabs or spa=
ces don&#39;t matter here from my perspective. I also disagree with your la=
nguage. It&#39;s overly impolite.<br></div><div><br></div><div>Marek</div><=
/div></div>

--0000000000000929110597be2086--

--===============1592762865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1592762865==--
