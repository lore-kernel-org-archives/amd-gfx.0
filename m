From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Userptr broken with the latest amdgpu driver
Date: Mon, 8 Apr 2019 20:41:22 -0400
Message-ID: <CAAxE2A5J4GJZBV=R7nFNVEoPpW9Sg-K5wGrXk-NEczSpxo+CYA@mail.gmail.com>
References: <CAAxE2A7LC1btT5j0y214V8KqHN+HMm8KW-ciVyXYTdYcqe5VAA@mail.gmail.com>
 <295abb92-59b2-875c-82cb-cbe2be9ea6e0@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1913847579=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <295abb92-59b2-875c-82cb-cbe2be9ea6e0-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1913847579==
Content-Type: multipart/alternative; boundary="0000000000007f408605860e381a"

--0000000000007f408605860e381a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Indeed, you're right.

Marek

On Mon, Apr 8, 2019 at 4:59 PM Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Marek,
>
> I guess you are using old kernel config with 5.x kernel, and the kernel
> config option CONFIG_HMM is missing because the dependency option
> CONFIG_ZONE_DEVICE is missing in old config file. Please update your
> kernel config file to enable option CONFIG_ZONE_DEVICE.
>
> You should have this message in dmesg log:
>
> "HMM_MIRROR kernel config option is not enabled, "
> "add CONFIG_ZONE_DEVICE=3Dy in config file to fix
>
> Philip
>
>
> On 2019-04-08 4:46 p.m., Marek Ol=C5=A1=C3=A1k wrote:
> > Hi,
> >
> > amdgpu_mn_register fails with -ENODEV in amdgpu_gem_userptr_ioctl.
> >
> > The regression happened within the last 1-2 months.
> >
> > Marek
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>

--0000000000007f408605860e381a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Indeed, you&#39;re right.</div><div><br></div><div>Ma=
rek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Apr 8, 2019 at 4:59 PM Yang, Philip &lt;<a href=3D"mai=
lto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Marek,<br>
<br>
I guess you are using old kernel config with 5.x kernel, and the kernel <br=
>
config option CONFIG_HMM is missing because the dependency option <br>
CONFIG_ZONE_DEVICE is missing in old config file. Please update your <br>
kernel config file to enable option CONFIG_ZONE_DEVICE.<br>
<br>
You should have this message in dmesg log:<br>
<br>
&quot;HMM_MIRROR kernel config option is not enabled, &quot;<br>
&quot;add CONFIG_ZONE_DEVICE=3Dy in config file to fix<br>
<br>
Philip<br>
<br>
<br>
On 2019-04-08 4:46 p.m., Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; amdgpu_mn_register fails with -ENODEV in amdgpu_gem_userptr_ioctl.<br>
&gt; <br>
&gt; The regression happened within the last 1-2 months.<br>
&gt; <br>
&gt; Marek<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
&gt; <br>
</blockquote></div>

--0000000000007f408605860e381a--

--===============1913847579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1913847579==--
